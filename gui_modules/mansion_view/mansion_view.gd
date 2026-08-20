extends Control
#This script owns every autoload lookup for the feature. mansion_layout.gd and the two
#data registries stay free of singletons because game_res.gd preloads them and preload

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const RoomUpgrades = preload("res://assets/data/mansion_room_upgrades.gd")
const FloorPlans = preload("res://assets/data/mansion_floor_plans.gd")
const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

signal place_changed(code)

export var embedded = false

var mode = 'work' setget set_mode
var picked_slot = null
var picked_floor = 0
var picked_char = null
var picked_char_from = null
var picked_char_kind = 'work'
var drag_end_frame = -1
var grounds_card_return = -1
var zoom = 1.0
var pan = Vector2.ZERO
var panning = false
var pending_expel = null
var pending_cancel = null
var place = LocationTasks.MANSION_CODE
var local_tasks = false

onready var grid = $GridViewport/FloorGrid
onready var card = $Overlay/RoomCard
onready var rest_panel = $RestPanel
onready var location_panel = $LocationPanel
onready var service_panel = $Overlay/ServicePanel


const EMBEDDED_MARGIN = 16
const EMBEDDED_BAR_HEIGHT = 44
const EMBEDDED_RAIL_WIDTH = 220
const EMBEDDED_OPEN_LEFT = 100.0
const EMBEDDED_OPEN_RIGHT = 1590.0
const EMBEDDED_OPEN_BOTTOM = 1063.0
#The HUD hangs off the bottom edge of the folded slave list and reads as the rest of that same
const EMBEDDED_HUD_LEFT = 320.0
const EMBEDDED_HUD_RIGHT = 1586.0
const EMBEDDED_HUD_TOP = 197.0
var hud_visible = true
var hud_bottom = EMBEDDED_HUD_TOP + 170

func _ready():
	ResourceScripts.game_res.ensure_mansion_layout()
	$TopBar/ModeWork.connect("pressed", self, "set_mode", ['work'])
	$TopBar/ModeSleep.connect("pressed", self, "set_mode", ['sleep'])
	$FloorSelector/Up.connect("pressed", self, "change_floor", [1])
	$FloorSelector/Down.connect("pressed", self, "change_floor", [-1])
	$ZoomControls/In.connect("pressed", self, "zoom_by", [grid.ZOOM_STEP])
	$ZoomControls/Out.connect("pressed", self, "zoom_by", [-grid.ZOOM_STEP])
	$Overlay/CardCatcher.connect("gui_input", self, "catcher_input")
	grid.setup(self)
	card.setup(self)
	rest_panel.setup(self)
	location_panel.visible = false
	service_panel.setup(self)
	$ExpelZone.setup(self)
	connect("resized", self, "layout_view")
	connect("visibility_changed", self, "on_visibility_changed")
	layout_view()
	if embedded:
		globals.connect("slave_added", self, "queue_refresh")
		globals.connect("task_removed", self, "queue_refresh")
	refresh()
	center_view()


func on_visibility_changed():
	if is_visible_in_tree():
		return
	close_card()
	clear_char_pick()


func layout_view():
	if !embedded:
		return
	$Background.visible = false
	place_child($GridViewport, Rect2(Vector2.ZERO, rect_size))
	$PlaceBar.visible = false
	$ExpelZone.visible = false
	lay_out_hud()
	if grid.view != null:
		fit_zoom()
		center_view()


func lay_out_hud():
	if !embedded:
		return
	var width = EMBEDDED_HUD_RIGHT - EMBEDDED_HUD_LEFT
	var strip_height = rest_panel.apply_layout(width)
	place_child($RestPanel, Rect2(EMBEDDED_HUD_LEFT, EMBEDDED_HUD_TOP, width, strip_height))
	lay_out_strip($RestPanel)
	var bar_top = EMBEDDED_HUD_TOP + strip_height + 6
	place_child($TopBar, Rect2(EMBEDDED_HUD_LEFT, bar_top, width, EMBEDDED_BAR_HEIGHT))
	$FloorSelector.visible = false
	$ZoomControls.visible = false
	move_anchored($TopBar/ModeWork, -380, -200)
	move_anchored($TopBar/ModeSleep, -190, -10)
	move_anchored($TopBar/RearrangeHint, -380, -10)
	$TopBar/Counters.visible = false
	hud_bottom = bar_top + EMBEDDED_BAR_HEIGHT
	lay_out_location_panel(open_rect())
	if grid.view != null:
		fit_zoom()
		center_view()


func set_hud_visible(shown):
	if hud_visible == shown:
		return
	hud_visible = shown
	if !embedded:
		return
	$TopBar.visible = shown
	rest_panel.rebuild()


func open_rect():
	if !embedded:
		return Rect2(Vector2.ZERO, $GridViewport.rect_size)
	var top = hud_bottom + 8
	return Rect2(EMBEDDED_OPEN_LEFT, top,
		EMBEDDED_OPEN_RIGHT - EMBEDDED_OPEN_LEFT, EMBEDDED_OPEN_BOTTOM - top)


#sideways rather than growing, so a full household cannot push the plan off the panel.
const LOCATION_CARD_WIDTH = 226


func rebuild_location_panel(location_code):
	var panel = location_panel
	panel.get_node("Background").texture = null if local_tasks 		else LocationTasks.location_background(location_code)
	panel.get_node("LocalShade").visible = local_tasks
	panel.get_node("LocalFrame").visible = local_tasks
	panel.get_node("Title").text = tr("MANSIONVIEW_LOCALTASKS") if local_tasks 		else LocationTasks.location_name(location_code)
	var entries = LocationTasks.tasks_for(location_code)
	var rooms = panel.get_node("Rooms")
	input_handler.ClearContainer(rooms)
	for entry in entries:
		input_handler.DuplicateContainerTemplate(rooms).setup(self, entry)
	if local_tasks:
		for slot in grounds_slots():
			input_handler.DuplicateContainerTemplate(rooms).setup_plot(self, slot)
	panel.get_node("Empty").text = tr("MANSIONVIEW_NOTHINGHERE")
	panel.get_node("Empty").visible = entries.empty() and !local_tasks


func refresh_location_places():
	for node in location_panel.get_node("Rooms").get_children():
		if node.is_queued_for_deletion():
			continue
		if node.has_meta('task') or node.has_meta('plot'):
			node.refresh()


func lay_out_location_panel(room):
	var panel_room = room
	if embedded and local_tasks:
		panel_room = Rect2(room.position + Vector2(EMBEDDED_RAIL_WIDTH, 0),
			room.size - Vector2(EMBEDDED_RAIL_WIDTH, 0))
	place_child($LocationPanel, panel_room)
	var inner = panel_room.size.x - 48
	$LocationPanel/Rooms.columns = int(max(1, floor(inner / LOCATION_CARD_WIDTH)))
	place_child($LocationPanel/Rooms, Rect2(24, 64, inner, max(10, room.size.y - 88)))
	place_child($LocationPanel/Title, Rect2(24, 12, min(800, inner), 40))
	place_child($LocationPanel/Empty, Rect2(24, 64, min(900, inner), 36))


func lay_out_strip(panel):
	var width = panel.rect_size.x
	place_child(panel.get_node('Title'), Rect2(10, 4, 220, 24))
	place_child(panel.get_node('Warning'), Rect2(238, 4, max(10, width - 248), 24))
	place_child(panel.get_node('Scroll'), Rect2(10, panel.TITLE_HEIGHT,
		max(10, width - 20), max(10, panel.rect_size.y - panel.TITLE_HEIGHT - 6)))
	panel.get_node('Scroll').mouse_filter = Control.MOUSE_FILTER_PASS
	panel.get_node('Scroll/List').mouse_filter = Control.MOUSE_FILTER_PASS


func fit_zoom():
	var space = open_rect().size - Vector2(16, 16)
	if space.x <= 0 or space.y <= 0 or grid.rect_size.x <= 0 or grid.rect_size.y <= 0:
		return
	zoom = clamp(min(space.x / grid.rect_size.x, space.y / grid.rect_size.y),
		grid.ZOOM_MIN, grid.ZOOM_MAX)


func place_child(node, rect):
	node.rect_position = rect.position
	node.rect_size = rect.size


func lay_out_rail(holder, back, label, forward):
	var step = (EMBEDDED_RAIL_WIDTH - 12) / 4.0
	place_child(holder.get_node(back), Rect2(0, 0, step, 44))
	place_child(holder.get_node(label), Rect2(step + 6, 0, step * 2, 44))
	place_child(holder.get_node(forward), Rect2(step * 3 + 12, 0, step, 44))


func move_anchored(node, left, right):
	node.margin_left = left
	node.margin_right = right
	node.margin_top = 0
	node.margin_bottom = EMBEDDED_BAR_HEIGHT


func layout():
	return ResourceScripts.game_res.mansion_layout


func tasks():
	return ResourceScripts.game_res.tasks_progresses


func party():
	return ResourceScripts.game_party.characters


func floor_index():
	return int(layout().current_floor)


func current_floor():
	return MansionLayout.get_current_floor(layout())


func floor_plan():
	return MansionLayout.get_floor_plan(layout(), floor_index())


func slot_codes():
	var plan = floor_plan()
	if plan == null:
		return []
	var res = []
	for slot_plan in plan.slots:
		res.append(slot_plan.code)
	return res


func get_room(slot_code):
	return MansionLayout.get_room(current_floor(), slot_code)


func get_character(char_id):
	if party().has(char_id):
		return party()[char_id]
	return null


func is_present(person):
	if person == null:
		return false
	return person.check_location('mansion', true)


func person_is_here(person):
	if person == null:
		return false
	if in_mansion():
		return is_present(person)
	return person.check_location(place, true)


func room_workers(room):
	return MansionLayout.get_room_workers(room, tasks())


func in_mansion():
	return place == LocationTasks.MANSION_CODE


func showing_plan():
	return in_mansion() and !local_tasks


func set_local_tasks(value):
	if local_tasks == value:
		return
	close_card()
	clear_pick()
	clear_char_pick()
	local_tasks = value
	if local_tasks:
		mode = 'work'
		set_place(LocationTasks.MANSION_CODE)
	refresh()


func set_place(code):
	if place == code:
		return
	close_card()
	clear_pick()
	clear_char_pick()
	place = code
	if !in_mansion():
		mode = 'work'
		local_tasks = false
	emit_signal("place_changed", place)
	refresh()


func rebuild_place_bar():
	input_handler.ClearContainer($PlaceBar/List)
	for code in LocationTasks.accessible_locations():
		var button = input_handler.DuplicateContainerTemplate($PlaceBar/List)
		button.text = tr("MANSIONVIEW_MANSION") if code == LocationTasks.MANSION_CODE \
			else LocationTasks.location_name(code)
		button.pressed = code == place
		button.connect("pressed", self, "set_place", [code])


func resting_characters():
	var res = []
	match mode:
		'work':
			for char_id in LocationTasks.characters_at(place):
				var person = get_character(char_id)
				if person == null or person.is_on_quest() or person.is_unavaliable():
					continue
				if person.get_work() in ['', null]:
					res.append(char_id)
		'sleep':
			for char_id in MansionLayout.unhoused_characters(layout(), party()):
				res.append(char_id)
	return res


func unhoused_count():
	return MansionLayout.unhoused_characters(layout(), party()).size()


func assign_worker(slot_code, char_id):
	var room = get_room(slot_code)
	if room == null or room.task_id == null:
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_VOID"))
		return false
	var person = get_character(char_id)
	if person == null:
		return false
	if !is_present(person):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_AWAY"))
		return false
	if !person.is_worker():
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_NOTWORKER"))
		return false
	ResourceScripts.game_res.sync_room_tasks()
	var task = tasks()[room.task_id]
	if task.workers.size() >= task.max_workers:
		var absent = first_absent_worker(room)
		if absent == null:
			input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
			return false
		get_character(absent).remove_from_task()
	person.assign_to_task(room.task_id)
	refresh_people()
	return true


func first_absent_worker(room):
	for char_id in room_workers(room):
		var person = get_character(char_id)
		if person != null and !is_present(person):
			return char_id
	return null


func assign_location_worker(task_id, char_id):
	var person = get_character(char_id)
	if person == null or !tasks().has(task_id):
		return false
	if !person.check_location(place, true) and !(place == LocationTasks.MANSION_CODE and is_present(person)):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_AWAY"))
		return false
	if !person.is_worker():
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_NOTWORKER"))
		return false
	var task = tasks()[task_id]
	if task.type != 'gather_limited' and task.has('max_workers') \
			and task.workers.size() >= int(task.max_workers):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return false
	person.assign_to_task(task_id)
	refresh_people()
	return true


func unassign_worker(char_id):
	var person = get_character(char_id)
	if person == null:
		return
	person.remove_from_task()
	refresh_people()


func assign_resident(slot_code, char_id):
	var person = get_character(char_id)
	if person == null:
		return false
	var check = MansionLayout.assign_character(layout(), floor_index(), slot_code, char_id,
		person.is_master(), master_id(), ResourceScripts.game_res.shares_master_bed(person))
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return false
	ResourceScripts.game_res.rooms_changed()
	refresh_people()
	return true


func master_id():
	var master = ResourceScripts.game_party.get_master()
	return master.id if master != null else null


func unassign_resident(char_id):
	if is_pinned(char_id):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_MASTERPINNED"))
		return
	MansionLayout.unassign_character(layout(), char_id)
	ResourceScripts.game_res.rooms_changed()
	refresh_people()


func is_pinned(char_id):
	var person = get_character(char_id)
	if person == null:
		return false
	return MansionLayout.is_pinned(layout(), char_id, person.is_master())


#through here, so the two ways of moving somebody cannot drift apart.
func place_character(kind, holder, char_id, resident_id, holder_floor = -1):
	if kind == null:
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return false
	if resident_id != null and resident_id != char_id:
		return swap_people(kind, holder, char_id, resident_id)
	match kind:
		'sleep':
			return assign_resident(holder, char_id)
		'build':
			return assign_builder(holder, char_id, holder_floor)
		'task':
			return assign_location_worker(holder, char_id)
	return assign_worker(holder, char_id)


func release_character(char_id, from_kind):
	if from_kind == 'sleep':
		unassign_resident(char_id)
	else:
		unassign_worker(char_id)


func swap_people(kind, slot_code, incoming_id, resident_id):
	if kind == 'sleep' and (is_pinned(resident_id) or is_pinned(incoming_id)):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_MASTERPINNED"))
		return false
	if kind == 'sleep':
		var here = MansionLayout.get_slot_of_character(layout(), incoming_id)
		MansionLayout.unassign_character(layout(), resident_id)
		if !assign_resident(slot_code, incoming_id):
			put_back(floor_index(), slot_code, resident_id)
			return false
		if here != null:
			put_back(here.floor, here.slot, resident_id)
		refresh_people()
		return true
	return swap_workers(kind, slot_code, incoming_id, resident_id)


func put_back(floor_id, slot_code, char_id):
	var person = get_character(char_id)
	if person == null:
		return false
	var seated = MansionLayout.assign_character(layout(), floor_id, slot_code, char_id,
		person.is_master(), master_id(),
		ResourceScripts.game_res.shares_master_bed(person)).ok
	if seated:
		ResourceScripts.game_res.rooms_changed()
	return seated


func swap_workers(kind, holder, incoming_id, resident_id):
	var target = task_id_for(kind, holder)
	var resident = get_character(resident_id)
	if target == null or resident == null:
		return false
	var incoming_from = task_of_worker(incoming_id)
	resident.remove_from_task()
	var placed = false
	match kind:
		'task':
			placed = assign_location_worker(holder, incoming_id)
		'build':
			placed = assign_builder(holder, incoming_id)
		_:
			placed = assign_worker(holder, incoming_id)
	if !placed:
		resident.assign_to_task(target)
		refresh_people()
		return false
	if incoming_from != null and incoming_from != target:
		resident.assign_to_task(incoming_from)
	refresh_people()
	return true


func task_id_for(kind, holder):
	match kind:
		'task':
			return holder if tasks().has(holder) else null
		'build':
			var slot = MansionLayout.get_slot(current_floor(), holder)
			return slot.build.task_id if slot != null and slot.build != null else null
	var room = get_room(holder)
	return room.task_id if room != null else null


func task_of_worker(char_id):
	for task_id in tasks():
		var task = tasks()[task_id]
		if task.get('workers', []).has(char_id):
			return task_id
	return null


#cannot come apart - which they had, twice, before this was one path.

func begin_carry_drag(source):
	var data = source.carry_data()
	if data == null or source.carry_refusal() != '':
		return null
	abandon_pick()
	source.set_drag_preview(make_drag_preview(source.carry_texture()))
	return data


func begin_carry_click(source):
	var data = source.carry_data()
	if data == null:
		return false
	if picked_char == data.char_id:
		clear_char_pick()
		return false
	var refusal = source.carry_refusal()
	if refusal != '':
		input_handler.SystemMessage(tr(refusal))
		return false
	return pick_character(data.char_id, data.from_slot, data.from_kind)


func drop_carried_on(target):
	var data = pick_data()
	if target == null or data == null:
		return false
	var refusal = target.refusal_for(data)
	if refusal != '':
		input_handler.SystemMessage(tr(refusal))
		return false
	clear_char_pick()
	return target.take_carried(data)


func pick_character(char_id, from_slot, from_kind):
	if drag_just_ended() or get_character(char_id) == null:
		return false
	picked_char = char_id
	picked_char_from = from_slot
	picked_char_kind = from_kind
	show_pick_preview(char_id)
	refresh_people()
	return true


func clear_char_pick():
	if picked_char == null:
		return
	picked_char = null
	picked_char_from = null
	$Overlay/PickPreview.visible = false
	refresh_people()


func abandon_pick():
	picked_char = null
	picked_char_from = null
	$Overlay/PickPreview.visible = false


const PREVIEW_SIZE = Vector2(64, 64)


func make_drag_preview(texture):
	var preview = TextureRect.new()
	preview.texture = texture
	preview.expand = true
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview.rect_size = PREVIEW_SIZE
	var frame = Panel.new()
	frame.show_behind_parent = true
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	frame.rect_position = Vector2(-5, -5)
	frame.rect_size = PREVIEW_SIZE + Vector2(10, 10)
	frame.add_stylebox_override('panel', load('res://assets/Themes_v2/UNIVERSAL/Panel_Square.tres'))
	preview.add_child(frame)
	return preview


func show_pick_preview(char_id):
	var person = get_character(char_id)
	var texture = null
	if person != null:
		texture = person.get_icon()
		if texture == null:
			texture = person.get_class_icon()
	$Overlay/PickPreview.texture = texture
	$Overlay/PickPreview.expand = true
	$Overlay/PickPreview.rect_size = PREVIEW_SIZE
	$Overlay/PickPreview.visible = true
	move_pick_preview(get_global_mouse_position())


func move_pick_preview(position):
	$Overlay/PickPreview.rect_global_position = position


func pick_data():
	if picked_char == null:
		return null
	return {kind = 'mansion_char', char_id = picked_char, from_slot = picked_char_from,
		from_kind = picked_char_kind}


func carried_data():
	if picked_char != null:
		return pick_data()
	var dragged = get_viewport().gui_get_drag_data()
	if dragged is Dictionary and dragged.get('kind', '') == 'mansion_char':
		return dragged
	return null


func drag_just_ended():
	return drag_end_frame == Engine.get_frames_drawn()


func _notification(what):
	#began: get_drag_data() cannot repaint, since that would free the very node the drag is
	if what == NOTIFICATION_DRAG_BEGIN:
		call_deferred("refresh_marks")
	if what == NOTIFICATION_DRAG_END:
		drag_end_frame = Engine.get_frames_drawn()
		call_deferred("refresh_people")


func grounds_floor():
	return MansionLayout.get_floor(layout(), MansionLayout.grounds_floor(layout()))


func grounds_slots():
	var plan = MansionLayout.get_floor_plan(layout(), MansionLayout.grounds_floor(layout()))
	if plan == null:
		return []
	var res = []
	for slot_plan in plan.slots:
		res.append(slot_plan.code)
	return res


func open_grounds_card(slot_code):
	var was = floor_index()
	layout().current_floor = MansionLayout.grounds_floor(layout())
	grounds_card_return = was
	card.open(slot_code, $Overlay/CardCatcher.get_global_rect())
	$Overlay/CardCatcher.visible = true


func open_task_screen(entry):
	service_panel.open(entry)


func open_service_screen():
	for entry in LocationTasks.tasks_for(place):
		if entry.own_screen:
			open_task_screen(entry)
			return


func refresh_marks():
	if showing_plan():
		grid.refresh_marks()


var built_signature = ""
var refresh_queued = false


func update():
	if !is_visible_in_tree():
		return
	queue_refresh()


func queue_refresh():
	if refresh_queued:
		return
	refresh_queued = true
	call_deferred("flush_queued_refresh")


func flush_queued_refresh():
	refresh_queued = false
	if !is_visible_in_tree():
		return
	if layout_signature() == built_signature:
		refresh_people()
		return
	refresh()


func layout_signature():
	var floor_data = current_floor()
	if floor_data == null:
		return ""
	var res = str(floor_index())
	for code in slot_codes():
		var room = MansionLayout.get_room(floor_data, code)
		res += "|%s:%s:%s" % [code, MansionLayout.slot_status(floor_data, code),
			room.type if room != null else "-"]
	return res


func refresh():
	ResourceScripts.game_res.sync_room_tasks()
	if !embedded:
		rebuild_place_bar()
	$GridViewport.visible = showing_plan()
	$FloorSelector.visible = showing_plan() and !embedded
	$ZoomControls.visible = showing_plan() and !embedded
	location_panel.visible = !showing_plan()
	if showing_plan():
		grid.rebuild()
		apply_view()
		update_floor_selector()
	else:
		if embedded:
			lay_out_location_panel(open_rect())
		rebuild_location_panel(place)
	built_signature = layout_signature()
	refresh_people()
	update_mode_buttons()


func refresh_people():
	if showing_plan():
		grid.update_all()
	else:
		refresh_location_places()
	rest_panel.rebuild()
	$ExpelZone.refresh()
	update_counters()
	if card.visible:
		card.rebuild()


func update_counters():
	var data = MansionLayout.summary(layout(), floor_index(), tasks())
	$TopBar/Counters.visible = in_mansion() and !embedded
	$TopBar/Counters/Rooms.text = "%s %d/%d" % [tr("MANSIONVIEW_ROOMSBUILT"), data.built, data.built + data.empty]
	$TopBar/Counters/Beds.text = "%s %d/%d" % [tr("MANSIONVIEW_BEDS"), data.residents, data.beds]
	$TopBar/Counters/Workplaces.text = "%s %d/%d" % [tr("MANSIONVIEW_WORKPLACES"), data.workers, data.workplaces]
	$TopBar/Counters/Upkeep.text = "%s %d" % [tr("MANSIONVIEW_UPKEEP"), data.upkeep]
	var cap = ResourceScripts.game_res.get_pop_cap()
	var population = ResourceScripts.game_party.character_order.size()
	$TopBar/Counters/Population.text = "%s %d/%d" % [tr("MANSIONVIEW_POPULATION"), population, cap]
	$TopBar/Counters/Population.set("custom_colors/font_color",
		Color(1, 0.37, 0.37) if population >= cap else Color(1, 1, 1))
	var unhoused = unhoused_count()
	$TopBar/Counters/Unhoused.text = "%s %d" % [tr("MANSIONVIEW_UNHOUSED"), unhoused]
	$TopBar/Counters/Unhoused.visible = unhoused > 0


func update_floor_selector():
	var floor_data = current_floor()
	$FloorSelector/Label.text = floor_data.code if floor_data != null else "-"
	$FloorSelector/Up.disabled = floor_index() >= layout().floors.size() - 1
	$FloorSelector/Down.disabled = floor_index() <= 0


func update_mode_buttons():
	$TopBar/ModeWork.pressed = mode == 'work'
	$TopBar/ModeSleep.pressed = mode == 'sleep'
	var moving_room = mode == 'rearrange'
	$TopBar/ModeWork.visible = !moving_room
	$TopBar/ModeSleep.visible = showing_plan() and !moving_room
	$TopBar/RearrangeHint.visible = moving_room
	$TopBar/RearrangeHint.text = tr("MANSIONVIEW_MOVEHINT")
	$ExpelZone.visible = mode == 'sleep' and showing_plan() and !embedded


func change_floor(step):
	go_to_floor(floor_index() + step)


func stairs_target(step):
	var walk = MansionLayout.house_floors(layout())
	var at = walk.find(floor_index())
	if at < 0:
		return null
	var to = at + step
	if to < 0 or to >= walk.size():
		return null
	return walk[to]


func go_to_floor(target):
	if target < 0 or target >= layout().floors.size() or target == floor_index():
		return
	close_card()
	layout().current_floor = target
	refresh()
	center_view()


const PAN_MARGIN = 80.0


func zoom_by(step):
	set_zoom(zoom + step)


func set_zoom(value):
	var clamped = clamp(value, grid.ZOOM_MIN, grid.ZOOM_MAX)
	if is_equal_approx(clamped, zoom):
		return
	var centre = $GridViewport.rect_size / 2
	pan = centre - (centre - pan) * (clamped / zoom)
	zoom = clamped
	close_card()
	apply_view()


func pan_by(delta):
	pan += delta
	close_card()
	apply_view()


func center_view():
	var room = open_rect()
	pan = room.position + (room.size - grid.rect_size * zoom) / 2
	pan.x = max(pan.x, room.position.x)
	pan.y = max(pan.y, room.position.y)
	apply_view()


#Called on every refresh too, so it must not close the card by itself.
func apply_view():
	clamp_pan()
	grid.apply_transform(zoom, pan)
	$ZoomControls/In.disabled = zoom >= grid.ZOOM_MAX
	$ZoomControls/Out.disabled = zoom <= grid.ZOOM_MIN
	$ZoomControls/Label.text = "%d%%" % round(zoom * 100)


func clamp_pan():
	var room = open_rect()
	var slack = room.size - grid.rect_size * zoom
	pan.x = clamp(pan.x, room.position.x + min(0.0, slack.x) - PAN_MARGIN,
		room.position.x + max(0.0, slack.x) + PAN_MARGIN)
	pan.y = clamp(pan.y, room.position.y + min(0.0, slack.y) - PAN_MARGIN,
		room.position.y + max(0.0, slack.y) + PAN_MARGIN)


func set_mode(value):
	if !showing_plan() and value != 'work':
		update_mode_buttons()
		return
	if mode == value:
		update_mode_buttons()
		return
	mode = value
	clear_pick()
	clear_char_pick()
	close_card()
	update_mode_buttons()
	grid.update_all()
	rest_panel.rebuild()
	$ExpelZone.refresh()


func start_move(slot_code):
	if !has_any_swap_target(slot_code):
		input_handler.SystemMessage(tr(pick_refusal(slot_code)))
		return false
	close_card()
	self.mode = 'rearrange'
	set_pick(slot_code)
	return true


func set_pick(slot_code):
	picked_slot = slot_code
	picked_floor = floor_index()
	grid.update_all()


func clear_pick():
	if picked_slot == null:
		return
	picked_slot = null
	grid.update_all()


func end_move():
	clear_pick()
	if mode == 'rearrange':
		self.mode = 'work'


func has_any_swap_target(slot_code):
	for index in range(layout().floors.size()):
		for other in floor_slot_codes(index):
			if index == floor_index() and other == slot_code:
				continue
			if MansionLayout.can_swap(layout(), floor_index(), slot_code, index, other).ok:
				return true
	return false


func floor_slot_codes(index):
	var plan = MansionLayout.get_floor_plan(layout(), index)
	if plan == null:
		return []
	var res = []
	for slot_plan in plan.slots:
		res.append(slot_plan.code)
	return res


#whose mouse_filter is STOP, and a STOP control ends gui_input propagation in Godot 3
func _input(event):
	if !is_visible_in_tree():
		return
	#_input runs before the GUI and before the autoloads' own handlers, so anything swallowed
	if input_handler.hard_tutorial_active:
		return
	if !gui_controller.windows_opened.empty():
		return
	if !mansion_is_the_screen():
		return
	if event is InputEventMouseMotion and picked_char != null:
		move_pick_preview(event.global_position)
	if event.is_action_pressed("ESC") or event.is_action_pressed("RMB"):
		if picked_char != null:
			clear_char_pick()
			get_tree().set_input_as_handled()
		elif picked_slot != null or mode == 'rearrange':
			end_move()
			get_tree().set_input_as_handled()
		return
	handle_view_input(event)


func pointer_over_plan(position):
	if !$GridViewport.get_global_rect().has_point(position):
		return false
	#Anything of this screen's own drawn over the plan owns the wheel where it sits: the room
	#card, the service screen, the idle strip, the bars. They are this node's children rather
	#than its siblings, so the scan further down never saw them and the plan went on zooming
	#underneath the very list the player was trying to scroll.
	if covered_by_own_panels(position):
		return false
	if !embedded:
		return true
	#they do not hide the mansion behind them and they are not windows either - so neither
	if !mansion_is_the_screen():
		return false
	var above = false
	for node in get_parent().get_children():
		if node == self:
			above = true
			continue
		if !above or !(node is CanvasItem) or !node.is_visible_in_tree():
			continue
		if !(node is Control):
			return false
		if control_covers(node, position):
			return false
	return true


#Tooltips follow the cursor and answer to nobody; they are not something to scroll.
const WHEEL_TRANSPARENT = ['TextTooltip', 'ItemTooltip']


func covered_by_own_panels(position):
	var above = false
	for node in get_children():
		if node.name == 'GridViewport':
			above = true
			continue
		if !above:
			continue
		if node is Control:
			#a CanvasLayer has no visibility of its own - only its children do
			if node.is_visible_in_tree() and control_covers(node, position):
				return true
		elif node is CanvasLayer:
			#the card, the screens over it and the catcher behind them live on a layer of
			#their own, which is how they get above every panel here
			for child in node.get_children():
				if !(child is Control) or !child.is_visible_in_tree():
					continue
				if WHEEL_TRANSPARENT.has(child.name):
					continue
				if control_covers(child, position):
					return true
	return false


func mansion_is_the_screen():
	var screen = gui_controller.current_screen
	if screen == null or !(screen is Node) or !is_instance_valid(screen):
		return true
	if screen == self or screen.is_a_parent_of(self):
		return true
	return !screen.is_visible_in_tree()


func control_covers(node, position):
	if !(node is Control) or !node.visible:
		return false
	if node.mouse_filter != Control.MOUSE_FILTER_IGNORE \
			and node.get_global_rect().has_point(position):
		return true
	for child in node.get_children():
		if control_covers(child, position):
			return true
	return false


func handle_view_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE and !event.pressed:
			panning = false
			return
		if !pointer_over_plan(event.global_position):
			return
		match event.button_index:
			BUTTON_WHEEL_UP:
				zoom_by(grid.ZOOM_STEP)
			BUTTON_WHEEL_DOWN:
				zoom_by(-grid.ZOOM_STEP)
			BUTTON_MIDDLE:
				panning = true
			_:
				return
		get_tree().set_input_as_handled()
	elif event is InputEventMouseMotion and panning:
		pan_by(event.relative)
		get_tree().set_input_as_handled()


func find_slot_of_type(type_code):
	for code in slot_codes():
		var room = get_room(code)
		if room != null and room.type == type_code:
			return code
	return null


func stairs_ways():
	var slot = find_slot_of_type('stairs')
	if slot == null:
		return null
	var node = grid.get_slot_node(slot)
	if node == null or !node.has_node("Stairs") or !node.get_node("Stairs").visible:
		return null
	return {Up = node.get_node("Stairs/Up"), Down = node.get_node("Stairs/Down")}


func special_worker(room):
	if room == null or MansionLayout.special_work_slots(room) <= 0:
		return null
	var trainer = ResourceScripts.game_res.practice_trainer(room)
	return trainer.id if trainer != null else null


func place_kinds(slot_code):
	var res = []
	var node = grid.get_slot_node(slot_code)
	if node == null:
		return res
	for cell in node.get_node("People").get_children():
		if cell.visible:
			res.append(cell.kind)
	return res


func place_holder_of(slot_code, kind):
	var node = grid.get_slot_node(slot_code)
	if node == null:
		return null
	for cell in node.get_node("People").get_children():
		if cell.visible and cell.kind == kind:
			return cell.char_id
	return null


func slot_pressed(slot_code):
	var room = get_room(slot_code)
	if room != null and RoomTypes.has_tag(room.type, 'stairs') and mode != 'rearrange':
		return
	if mode != 'rearrange':
		if picked_char != null:
			drop_carried_on(grid.get_slot_node(slot_code))
			return
		open_card(slot_code)
		return
	if picked_slot == null:
		if !has_any_swap_target(slot_code):
			input_handler.SystemMessage(tr(pick_refusal(slot_code)))
			return
		set_pick(slot_code)
		return
	if slot_code == picked_slot and picked_floor == floor_index():
		end_move()
		return
	try_swap(picked_floor, picked_slot, floor_index(), slot_code)
	end_move()


func pick_refusal(slot_code):
	if MansionLayout.slot_status(current_floor(), slot_code) == 'broken':
		return 'MANSIONVIEW_ERR_BROKEN'
	return 'MANSIONVIEW_ERR_NOTHINGTOSWAP'


func try_swap(floor_a, code_a, floor_b, code_b):
	var check = MansionLayout.can_swap(layout(), floor_a, code_a, floor_b, code_b)
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return false
	MansionLayout.swap_slots(layout(), floor_a, code_a, floor_b, code_b)
	refresh()
	return true


func start_construct(slot_code, type_code):
	var check = MansionLayout.can_start_construct(layout(), floor_index(), slot_code, type_code)
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return
	var data = RoomTypes.get_type(type_code)
	if !can_afford(data.build_cost):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_CANTAFFORD"))
		return
	pay(data.build_cost)
	MansionLayout.start_build(layout(), floor_index(), slot_code, 'construct', type_code,
		data.build_progress, data.build_cost)
	close_card()
	refresh()


func start_repair(slot_code):
	var check = MansionLayout.can_start_repair(layout(), floor_index(), slot_code)
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return
	MansionLayout.start_build(layout(), floor_index(), slot_code, 'repair', null,
		MansionLayout.REPAIR_PROGRESS, {})
	close_card()
	refresh()


func start_upgrade(slot_code, upgrade_code):
	var check = MansionLayout.can_start_upgrade(layout(), floor_index(), slot_code, upgrade_code)
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return
	var room = get_room(slot_code)
	var level = MansionLayout.next_upgrade_level(room, upgrade_code)
	var level_data = RoomUpgrades.get_level_data(upgrade_code, level)
	if !can_afford(level_data.cost):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_CANTAFFORD"))
		return
	pay(level_data.cost)
	MansionLayout.start_build(layout(), floor_index(), slot_code, 'upgrade', upgrade_code,
		level_data.progress, level_data.cost)
	refresh()
	if card.visible:
		card.rebuild()


#The card steps aside here for the same reason it does for demolition: the sheet that
#catches clicks beside the card would take the click meant for the answer.
func request_cancel_build(slot_code):
	pending_cancel = slot_code
	set_card_aside(true)
	var question = input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
		[self, 'cancel_build_confirmed', tr("MANSIONVIEW_CANCELCONFIRM")])
	if !question.is_connected("popup_hide", self, "on_question_closed"):
		question.connect("popup_hide", self, "on_question_closed")


#Whichever way the question goes away, the card comes back.  It hides itself before it
#calls an answer back, so this must not clear what the answer still needs.
func on_question_closed():
	set_card_aside(false)


func cancel_build_confirmed():
	var slot_code = pending_cancel
	pending_cancel = null
	if slot_code == null:
		return
	var result = MansionLayout.cancel_build(layout(), floor_index(), slot_code)
	if result == null:
		return
	refund(result.refund)
	if tasks().has(result.task_id):
		ResourceScripts.game_res.clean_task(result.task_id)
	close_card()
	refresh()


func refund(cost):
	for res in cost:
		if res == 'gold':
			ResourceScripts.game_res.money += int(cost[res])
		else:
			ResourceScripts.game_res.materials[res] += int(cost[res])


func assign_builder(slot_code, char_id, floor_id = -1):
	var floor_data = current_floor() if floor_id < 0 \
		else MansionLayout.get_floor(layout(), floor_id)
	var build = MansionLayout.get_build(floor_data, slot_code)
	if build == null:
		return false
	var person = get_character(char_id)
	if person == null:
		return false
	if !is_present(person):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_AWAY"))
		return false
	if !person.is_worker():
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_NOTWORKER"))
		return false
	ResourceScripts.game_res.sync_room_tasks()
	var task = tasks()[build.task_id]
	if task.workers.size() >= task.max_workers:
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return false
	person.assign_to_task(build.task_id)
	refresh_people()
	return true


func build_workers(build):
	return MansionLayout.get_build_workers(build, tasks())


func build_days_left(build):
	if build == null:
		return null
	var per_tick = 0.0
	for char_id in build_workers(build):
		var person = get_character(char_id)
		if person != null and is_present(person):
			per_tick += person.get_job_value('building')
	if per_tick <= 0:
		return null
	var ticks = ceil((build.limit - build.progress) / per_tick)
	return int(max(1, ceil(ticks / float(variables.HoursPerDay))))


func build_label(build):
	if build == null:
		return ""
	match build.kind:
		'construct':
			return "%s %s" % [tr("MANSIONVIEW_BUILDING"), tr(RoomTypes.get_name_key(build.target))]
		'repair':
			return tr("MANSIONVIEW_CLEARINGOUT")
	return "%s %s %d" % [tr("MANSIONVIEW_UPGRADING"),
		tr(RoomUpgrades.get_name_key(build.target)), int(build.level)]


func build_eta_text(build):
	var days = build_days_left(build)
	if days == null:
		return tr("MANSIONVIEW_NOBUILDER")
	return tr("MANSIONVIEW_DAYSLEFT") % days


func demolish(slot_code):
	var check = MansionLayout.can_demolish(layout(), floor_index(), slot_code)
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return
	var task_id = MansionLayout.demolish_room(layout(), floor_index(), slot_code)
	#the model cannot reach the task system, so releasing the workers is done here
	if task_id != null and tasks().has(task_id):
		ResourceScripts.game_res.clean_task(task_id)
	ResourceScripts.game_res.rooms_changed()
	close_card()
	refresh()


func can_afford(cost):
	if cost == null:
		return false
	for res in cost:
		if res == 'gold':
			if ResourceScripts.game_res.money < cost[res]:
				return false
		elif ResourceScripts.game_res.materials.get(res, 0) < cost[res]:
			return false
	return true


func pay(cost):
	for res in cost:
		if res == 'gold':
			ResourceScripts.game_res.money -= int(cost[res])
		else:
			ResourceScripts.game_res.materials[res] -= int(cost[res])


func can_expel(char_id):
	var person = get_character(char_id)
	return person != null and !person.is_master()


func request_expel(char_id):
	if !can_expel(char_id):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_MASTEREXPEL"))
		return
	pending_expel = char_id
	var person = get_character(char_id)
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
		[self, 'expel_confirmed', tr("MANSIONVIEW_EXPELCONFIRM") % person.get_short_name()])


func expel_confirmed():
	var char_id = pending_expel
	pending_expel = null
	var person = get_character(char_id)
	if person == null:
		return
	MansionLayout.unassign_character(layout(), char_id)
	if gui_controller.mansion == null:
		input_handler.SystemMessage("Standalone run: expel skipped")
		refresh_people()
		return
	ResourceScripts.game_party.add_fate(char_id, tr("SIBLINGMODULEFATEREMOVED"))
	ResourceScripts.game_party.remove_slave(person, true)
	refresh()


func open_card(slot_code):
	var node = grid.get_slot_node(slot_code)
	if node == null:
		return
	card.open(slot_code, node.get_global_rect())
	$Overlay/CardCatcher.visible = true


func close_card():
	if card == null:
		return
	if grounds_card_return >= 0:
		layout().current_floor = grounds_card_return
		grounds_card_return = -1
	card.visible = false
	$Overlay/CardCatcher.visible = false


#The card and the sheet that catches clicks beside it both live on the overlay layer, which
#draws above - and takes mouse input before - anything added to the tree root, a yes/no
#question included.  A CanvasLayer wins that contest even at layer zero; only a negative
#layer loses it, and that would bury the card under the whole screen.  So rather than fight
#the order, the card steps aside while it has a question of its own open.  The catcher is
#the half that actually broke it: it would swallow the click meant for Yes and close the
#card instead of answering.
func set_card_aside(aside):
	if card == null:
		return
	card.visible = !aside
	$Overlay/CardCatcher.visible = !aside


func catcher_input(event):
	if event is InputEventMouseButton and event.pressed:
		close_card()


