extends Control
#Standalone mansion floorplan screen. Not wired into the game yet - run it with F6 on
#mansion_view.tscn in the editor, or add --mansion-selftest to run its checks and exit.
#It deliberately does not register itself in ResourceScripts.node_data and never touches
#gui_controller.current_screen, so nothing in the running game can reach it yet.
#
#Three modes, one grid:
#	work      - rooms show their workplaces, the top panel holds everyone idle and present
#	sleep     - rooms show their beds, the top panel holds everyone without one
#	rearrange - rooms trade places, people are not touched
#
#This script owns every autoload lookup for the feature. mansion_layout.gd and the two
#data registries stay free of singletons because game_res.gd preloads them and preload
#resolves at compile time - see the note at the top of mansion_room_types.gd.

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const RoomUpgrades = preload("res://assets/data/mansion_room_upgrades.gd")
const FloorPlans = preload("res://assets/data/mansion_floor_plans.gd")
const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

export var test_mode = false

var mode = 'work' setget set_mode
var picked_slot = null
#a pick carries its floor, so a room can be carried upstairs before being put down
var picked_floor = 0
#Somebody lifted by a plain click, waiting for the click that puts them down. This is the
#alternative to dragging - the same moves, one click at each end instead of one gesture.
var picked_char = null
#where they were lifted from: a slot code, a task id, or null when it was the top panel
var picked_char_from = null
var picked_char_kind = 'work'
#Godot cancels a button's press when a drag begins, so a finished drag does not normally
#also fire pressed. This makes that independent of the engine: a click landing in the same
#frame a drag ended is that drag's tail, not a new click.
var drag_end_frame = -1
#what the screen showed the moment it opened, kept so the self test can ask about it
var boot_unhoused = -1
var zoom = 1.0
var pan = Vector2.ZERO
var panning = false
var in_test_mode = false
var pending_expel = null
var pending_cancel = null
#which place the screen is showing. LocationTasks.MANSION_CODE is the mansion itself, and
#is the only one with a floorplan, beds or anything to build.
var place = LocationTasks.MANSION_CODE

onready var grid = $GridViewport/FloorGrid
onready var card = $RoomCard
onready var rest_panel = $RestPanel
onready var location_panel = $LocationPanel


func _ready():
	#the layout comes first: creating a character rebuilds their effects, and the
	#private-room bonus asks the layout where they sleep
	ResourceScripts.game_res.ensure_mansion_layout()
	if test_mode and OS.has_feature('editor'):
		modding_core.handle_test_mode()
		in_test_mode = true
		spawn_test_characters()

	$TopBar/ModeWork.connect("pressed", self, "set_mode", ['work'])
	$TopBar/ModeSleep.connect("pressed", self, "set_mode", ['sleep'])
	$TopBar/ModeRearrange.connect("pressed", self, "set_mode", ['rearrange'])
	$FloorSelector/Up.connect("pressed", self, "change_floor", [1])
	$FloorSelector/Down.connect("pressed", self, "change_floor", [-1])
	$ZoomControls/In.connect("pressed", self, "zoom_by", [grid.ZOOM_STEP])
	$ZoomControls/Out.connect("pressed", self, "zoom_by", [-grid.ZOOM_STEP])
	$TestButton.connect("pressed", self, "run_self_test")
	$SkipTurnButton.connect("pressed", self, "skip_turn")
	$CardCatcher.connect("gui_input", self, "catcher_input")
	grid.setup(self)
	card.setup(self)
	rest_panel.setup(self)
	location_panel.setup(self)
	$ExpelZone.setup(self)
	handle_test()
	refresh()
	center_view()
	boot_unhoused = unhoused_count()
	if in_test_mode and OS.get_cmdline_args().has("--mansion-selftest"):
		call_deferred("run_selftest_and_quit")


func run_selftest_and_quit():
	run_self_test()
	get_tree().quit()


func handle_test():
	for node in get_tree().get_nodes_in_group('test'):
		if is_a_parent_of(node):
			node.visible = in_test_mode


#### state access ####

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


#The canonical "present in the mansion" test, matching what the rest of the game uses.
func is_present(person):
	if person == null:
		return false
	return person.check_location('mansion', true)


func room_workers(room):
	return MansionLayout.get_room_workers(room, tasks())


#### where the screen is looking ####

func in_mansion():
	return place == LocationTasks.MANSION_CODE


func set_place(code):
	if place == code:
		return
	close_card()
	clear_pick()
	clear_char_pick()
	place = code
	if !in_mansion():
		#nothing out there can be arranged or slept in
		mode = 'work'
	refresh()


func rebuild_place_bar():
	input_handler.ClearContainer($PlaceBar/List)
	for code in LocationTasks.accessible_locations():
		var button = input_handler.DuplicateContainerTemplate($PlaceBar/List)
		button.text = tr("MANSIONVIEW_MANSION") if code == LocationTasks.MANSION_CODE \
			else LocationTasks.location_name(code)
		button.pressed = code == place
		button.connect("pressed", self, "set_place", [code])


#### people ####

#Who the top panel offers. In work mode that is everyone idle and here; in sleep mode
#everyone without a bed, wherever in the world they are.
func resting_characters():
	var res = []
	match mode:
		'work':
			#only the people actually standing where the screen is looking
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


#### assignment ####

#Puts someone into a workplace. The room owns a real task, so this is the ordinary
#assign_to_task() the whole game uses - the room only decides which task that is.
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
		#the only way past a full room is to take an absent worker's place
		var absent = first_absent_worker(room)
		if absent == null:
			input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
			return false
		get_character(absent).remove_from_task()
	person.assign_to_task(room.task_id)
	refresh_people()
	return true


#Someone assigned here but currently elsewhere in the world. They keep the place until a
#character who is actually here takes it, and return to it on their own otherwise.
func first_absent_worker(room):
	for char_id in room_workers(room):
		var person = get_character(char_id)
		if person != null and !is_present(person):
			return char_id
	return null


#Work at another location. The task already exists - LocationTasks created it through the
#same helpers the old job screen uses - so this is once again plain assign_to_task().
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
	#a dungeon seam has no cap at all, which is why gather_limited carries no max_workers
	if task.type != 'gather_limited' and task.workers.size() >= int(task.max_workers):
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
		person.is_master(), master_id())
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return false
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
	refresh_people()


#The master stays in his own room; nothing may move him out of it.
func is_pinned(char_id):
	var person = get_character(char_id)
	if person == null:
		return false
	return MansionLayout.is_pinned(layout(), char_id, person.is_master())


#One person put into one place, however they got there. Dragging and clicking both come
#through here, so the two ways of moving somebody cannot drift apart.
func place_character(kind, holder, char_id, resident_id):
	if kind == null:
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return false
	if resident_id != null and resident_id != char_id:
		return swap_people(kind, holder, char_id, resident_id)
	match kind:
		'sleep':
			return assign_resident(holder, char_id)
		'build':
			return assign_builder(holder, char_id)
		'task':
			return assign_location_worker(holder, char_id)
	return assign_worker(holder, char_id)


#Taking somebody out of wherever they are, which is what both a drop on the top panel and
#a click on it mean.
func release_character(char_id, from_kind):
	if from_kind == 'sleep':
		unassign_resident(char_id)
	else:
		#builders and workers both sit on ordinary tasks, so one call covers them
		unassign_worker(char_id)


#A drop onto an occupied place. Swapping keeps both people housed instead of silently
#evicting one of them.
func swap_people(kind, slot_code, incoming_id, resident_id):
	if kind == 'sleep' and (is_pinned(resident_id) or is_pinned(incoming_id)):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_MASTERPINNED"))
		return false
	if kind == 'sleep':
		var here = MansionLayout.get_slot_of_character(layout(), incoming_id)
		MansionLayout.unassign_character(layout(), resident_id)
		if !assign_resident(slot_code, incoming_id):
			MansionLayout.assign_character(layout(), floor_index(), slot_code, resident_id,
				get_character(resident_id).is_master())
			return false
		if here != null:
			MansionLayout.assign_character(layout(), here.floor, here.slot, resident_id,
				get_character(resident_id).is_master())
		refresh_people()
		return true
	#work places only give way when the person holding them is not even here
	var person = get_character(resident_id)
	if person != null and is_present(person):
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return false
	return assign_worker(slot_code, incoming_id)


#### picking people up ####

#Lifting somebody costs nothing and changes nothing - everything happens on the click that
#puts them down, so a pick can always be abandoned without consequence.
func pick_character(char_id, from_slot, from_kind):
	if drag_just_ended() or get_character(char_id) == null:
		return false
	picked_char = char_id
	picked_char_from = from_slot
	picked_char_kind = from_kind
	refresh_people()
	return true


func clear_char_pick():
	if picked_char == null:
		return
	picked_char = null
	picked_char_from = null
	refresh_people()


#What a drag of the person in hand would be carrying. Places answer a click with the very
#same can_drop_data they answer a drag with, so neither way in can start allowing something
#the other refuses.
func pick_data():
	if picked_char == null:
		return null
	return {kind = 'mansion_char', char_id = picked_char, from_slot = picked_char_from,
		from_kind = picked_char_kind}


#Puts down whoever is in hand. The pick is let go first: the move either happens or is
#refused with a message, and carrying them on either way would only confuse the next click.
func place_picked(kind, holder, resident_id):
	var char_id = picked_char
	if char_id == null:
		return false
	clear_char_pick()
	return place_character(kind, holder, char_id, resident_id)


#A click on the body of a room rather than on one of its places - the click twin of
#dropping somebody onto the room itself, which lands them in its first free place.
func place_picked_in_room(slot_code):
	var node = grid.get_slot_node(slot_code)
	var kind = node.first_free_kind() if node != null else null
	if kind == null:
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_FULL"))
		return false
	return place_picked(kind, slot_code, null)


func drag_just_ended():
	return drag_end_frame == Engine.get_frames_drawn()


func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		drag_end_frame = Engine.get_frames_drawn()


#### refresh ####

func refresh():
	ResourceScripts.game_res.sync_room_tasks()
	rebuild_place_bar()
	$GridViewport.visible = in_mansion()
	$FloorSelector.visible = in_mansion()
	$ZoomControls.visible = in_mansion()
	location_panel.visible = !in_mansion()
	if in_mansion():
		grid.rebuild()
		apply_view()
		update_floor_selector()
	else:
		location_panel.rebuild(place)
	refresh_people()
	update_mode_buttons()


#Everything that changes when people move but rooms do not.
func refresh_people():
	if in_mansion():
		grid.update_all()
	else:
		location_panel.refresh_places()
	rest_panel.rebuild()
	$ExpelZone.refresh()
	update_counters()
	if card.visible:
		card.rebuild()


func update_counters():
	var data = MansionLayout.summary(layout(), floor_index(), tasks())
	$TopBar/Counters.visible = in_mansion()
	$TopBar/Counters/Rooms.text = "%s %d/%d" % [tr("MANSIONVIEW_ROOMSBUILT"), data.built, data.built + data.empty]
	$TopBar/Counters/Beds.text = "%s %d/%d" % [tr("MANSIONVIEW_BEDS"), data.residents, data.beds]
	$TopBar/Counters/Workplaces.text = "%s %d/%d" % [tr("MANSIONVIEW_WORKPLACES"), data.workers, data.workplaces]
	$TopBar/Counters/Upkeep.text = "%s %d" % [tr("MANSIONVIEW_UPKEEP"), data.upkeep]
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
	$TopBar/ModeRearrange.pressed = mode == 'rearrange'
	#beds and rearranging are mansion business; out on a location there is only work
	$TopBar/ModeSleep.disabled = !in_mansion()
	$TopBar/ModeRearrange.disabled = !in_mansion()
	$ExpelZone.visible = mode == 'sleep' and in_mansion()


func change_floor(step):
	var target = floor_index() + step
	if target < 0 or target >= layout().floors.size():
		return
	close_card()
	#the pick survives the trip: that is what carrying a room to another floor means
	layout().current_floor = target
	refresh()
	center_view()


#### zoom and panning ####

#How far past the edge the plan may be dragged. Without a margin the mansion sticks to
#the viewport border; with an unbounded pan it can be flung out of sight entirely.
const PAN_MARGIN = 80.0


func zoom_by(step):
	set_zoom(zoom + step)


func set_zoom(value):
	var clamped = clamp(value, grid.ZOOM_MIN, grid.ZOOM_MAX)
	if is_equal_approx(clamped, zoom):
		return
	#keep whatever sits in the middle of the viewport where it is, so zooming reads as
	#moving towards the plan rather than towards its top left corner
	var centre = $GridViewport.rect_size / 2
	pan = centre - (centre - pan) * (clamped / zoom)
	zoom = clamped
	#the card is anchored to a slot's screen rect, which the new scale invalidates
	close_card()
	apply_view()


func pan_by(delta):
	pan += delta
	close_card()
	apply_view()


func center_view():
	pan = ($GridViewport.rect_size - grid.rect_size * zoom) / 2
	apply_view()


#Called on every refresh too, so it must not close the card by itself.
func apply_view():
	clamp_pan()
	grid.apply_transform(zoom, pan)
	$ZoomControls/In.disabled = zoom >= grid.ZOOM_MAX
	$ZoomControls/Out.disabled = zoom <= grid.ZOOM_MIN
	$ZoomControls/Label.text = "%d%%" % round(zoom * 100)


#The plan may be dragged anywhere between "its far edge just reached the near edge of the
#viewport" and the mirror of that, plus a margin. This holds whether the plan is larger
#than the viewport or smaller than it, because the two bounds swap over on their own.
func clamp_pan():
	var slack = $GridViewport.rect_size - grid.rect_size * zoom
	pan.x = clamp(pan.x, min(0.0, slack.x) - PAN_MARGIN, max(0.0, slack.x) + PAN_MARGIN)
	pan.y = clamp(pan.y, min(0.0, slack.y) - PAN_MARGIN, max(0.0, slack.y) + PAN_MARGIN)


#### modes ####

func set_mode(value):
	if !in_mansion() and value != 'work':
		update_mode_buttons()
		return
	if mode == value:
		update_mode_buttons()
		return
	mode = value
	clear_pick()
	#whoever was in hand belonged to the old mode's places and has nowhere to go in this one
	clear_char_pick()
	close_card()
	update_mode_buttons()
	grid.update_all()
	rest_panel.rebuild()
	$ExpelZone.refresh()


func set_pick(slot_code):
	picked_slot = slot_code
	picked_floor = floor_index()
	grid.update_all()


func clear_pick():
	if picked_slot == null:
		return
	picked_slot = null
	grid.update_all()


#Anywhere in the whole mansion, not just this floor - a room may be carried upstairs.
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


#Zoom and panning live here rather than on the grid's _gui_input. Slot nodes are Buttons,
#whose mouse_filter is STOP, and a STOP control ends gui_input propagation in Godot 3
#whether or not it consumed the event - so the wheel only ever reached the grid through
#the gaps between slots. _input() runs before the GUI sees anything, so nothing can
#swallow it.
func _input(event):
	if !visible:
		return
	if event.is_action_pressed("ESC") or event.is_action_pressed("RMB"):
		if picked_char != null:
			clear_char_pick()
			get_tree().set_input_as_handled()
		elif picked_slot != null:
			clear_pick()
			get_tree().set_input_as_handled()
		elif mode == 'rearrange':
			self.mode = 'work'
			get_tree().set_input_as_handled()
		return
	handle_view_input(event)


func handle_view_input(event):
	if event is InputEventMouseButton:
		#releasing the middle button has to land even if the cursor left the plan first,
		#otherwise the drag would stick on
		if event.button_index == BUTTON_MIDDLE and !event.pressed:
			panning = false
			return
		if !$GridViewport.get_global_rect().has_point(event.global_position):
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
		#_input reports motion in screen pixels, so unlike gui_input on the scaled grid
		#this needs no correction for the zoom
		pan_by(event.relative)
		get_tree().set_input_as_handled()


#### slots ####

func slot_pressed(slot_code):
	if mode != 'rearrange':
		#somebody in hand goes into the room's first free place, the same as dropping them
		#on its body; with empty hands the click is a request to see the room
		if picked_char != null:
			place_picked_in_room(slot_code)
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
		clear_pick()
		return
	try_swap(picked_floor, picked_slot, floor_index(), slot_code)
	clear_pick()


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
	#one swap per visit to the mode: it keeps an accidental second drag from undoing the
	#move the player just made
	self.mode = 'work'
	refresh()
	return true


#### construction, repair and upgrades ####

#Nothing is instant any more: paying starts scaffolding, and somebody has to stand in it.
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


#Clearing out a derelict slot costs nothing but still takes builders and time.
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


func request_cancel_build(slot_code):
	pending_cancel = slot_code
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
		[self, 'cancel_build_confirmed', tr("MANSIONVIEW_CANCELCONFIRM")])


#Unlike the old upgrade queue, which kept both the progress and the materials, cancelling
#here hands back exactly what was paid.
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


func assign_builder(slot_code, char_id):
	var build = MansionLayout.get_build(current_floor(), slot_code)
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


#How long the scaffolding still needs, in whole days, from what its builders actually
#contribute. Null when nobody is on it, because then the answer is "never".
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


#### expelling ####

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
	#remove_slave reaches into gui_controller.mansion, which does not exist when this
	#scene is run on its own
	if gui_controller.mansion == null:
		input_handler.SystemMessage("Standalone run: expel skipped")
		refresh_people()
		return
	ResourceScripts.game_party.add_fate(char_id, tr("SIBLINGMODULEFATEREMOVED"))
	ResourceScripts.game_party.remove_slave(person, true)
	refresh()


#### card ####

func open_card(slot_code):
	var node = grid.get_slot_node(slot_code)
	if node == null:
		return
	card.open(slot_code, node.get_global_rect())
	$CardCatcher.visible = true


func close_card():
	if card == null:
		return
	card.visible = false
	$CardCatcher.visible = false


func catcher_input(event):
	if event is InputEventMouseButton and event.pressed:
		close_card()


#### test mode ####

func spawn_test_characters():
	ResourceScripts.game_world.make_world()
	var ids = []
	for i in range(8):
		var character = ResourceScripts.scriptdict.class_slave.new("mansion_view_test_%d" % i)
		character.create('Human', 'female' if i % 2 == 0 else 'male', 'random')
		character.fill_boosters()
		#a fresh character is a slave with no trainer, and is_worker() refuses those, so
		#work mode would have nobody to place at all
		character.set_stat('slave_class', 'servant')
		if !character.tags.has('worker'):
			character.tags.append('worker')
		#professions is a dictionary keyed by class; unlock_class is the way in, and it is
		#what MansionMainModule.test_mode() uses to make its own master
		if i == 0:
			character.unlock_class('master')
		characters_pool.move_to_state(character.id)
		ids.append(character.id)
	ResourceScripts.game_res.money = 100000
	for material in ResourceScripts.game_res.materials:
		ResourceScripts.game_res.materials[material] = 5000
	#characters_pool.move_to_state drops people straight into the party, so the one call
	#add_slave() makes on the way in never happens here. Without it the test household wakes
	#up on the floor and beds mode opens with every bed empty.
	ResourceScripts.game_res.autohouse_household()
	#the master keeps the house; the two after him go out into the world
	spawn_test_locations(ids.slice(1, 2))


#The place bar lists wherever the household is standing, so in a fresh world it only ever
#offers the mansion and the location screen cannot be opened at all. Posting somebody to a
#settlement and somebody to a dungeon puts both shapes of it on the bar: capped gathering
#and recruiting work on one, uncapped seams on the other.
func spawn_test_locations(char_ids):
	var codes = []
	for type_code in ['settlement', 'dungeon']:
		var code = find_world_location(type_code)
		if code != null:
			codes.append(code)
	for i in range(min(codes.size(), char_ids.size())):
		var location = ResourceScripts.world_gen.get_location_from_code(codes[i])
		#a dungeon offers nothing until a subroom has been cleared out
		if location.type == 'dungeon':
			stock_dungeon_seams(codes[i], 2)
		get_character(char_ids[i]).instant_travel(codes[i])
	return codes


func find_world_location(type_code):
	for code in ResourceScripts.game_world.location_links:
		var location = ResourceScripts.world_gen.get_location_from_code(code)
		if location == null or location.get('type', '') != type_code:
			continue
		if location.get('locked', false):
			continue
		return code
	return null


#Rolls seams out of the dungeon's own biome, which is what clearing a subroom does
#(ExplorationDungeon.add_subroom_res). The gather mod is registered alongside for the same
#reason world_gen.finalize_subrooms does it: get_gather_mod_from_loc() indexes gather_mods
#with no fallback. In practice generation has already filled that in for every material in
#the biome, so this line does nothing here - it is only insurance against a material the
#roll produces that generation never happened to see.
static func stock_dungeon_seams(code, count = 1):
	var location = ResourceScripts.world_gen.get_location_from_code(code)
	if location == null or !location.has('gatherable_resources'):
		return []
	var loot_processor = Items.get_loot()
	var stocked = []
	for _i in range(count):
		var materials = loot_processor.get_reward(location.gatherable_resources).materials
		for material in materials:
			input_handler.AddOrIncrementDict(location.gather_limit_resources,
				{material: materials[material]})
			if !location.gather_mods.has(material):
				location.gather_mods[material] = loot_processor.get_gather_mod(
					location.gather_settings, material)
			if !stocked.has(material):
				stocked.append(material)
	return stocked


#Runs a whole in-game day so the screen can be watched doing its job. The real Finish
#turn button lives on the clock, which does not exist when this scene runs on its own.
func skip_turn():
	var unhoused = ResourceScripts.game_res.unhoused_characters()
	if !unhoused.empty():
		input_handler.SystemMessage(tr("MANSIONVIEW_ERR_UNHOUSED") % unhoused.size())
		return
	for _i in range(variables.HoursPerDay):
		ResourceScripts.game_res.tick()
	ResourceScripts.game_globals.hour += variables.HoursPerDay
	refresh()
	input_handler.SystemMessage(tr("MANSIONVIEW_TURNPASSED"))


#Exercises the model and the screen end to end so a regression shows up without clicking.
func run_self_test():
	var report = []
	ResourceScripts.game_res.ensure_mansion_layout(true)
	run_model_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_work_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_sleep_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_ui_checks(report)
	run_input_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_click_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_placement_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_turn_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_build_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	set_place(LocationTasks.MANSION_CODE)
	refresh()
	#before run_location_checks, which stocks a dungeon of its own and would otherwise be
	#the reason the test-mode one has seams
	run_test_location_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	set_place(LocationTasks.MANSION_CODE)
	refresh()
	run_location_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	set_place(LocationTasks.MANSION_CODE)
	refresh()
	run_effect_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()
	run_floor_checks(report)
	ResourceScripts.game_res.ensure_mansion_layout(true)
	refresh()

	var failed = 0
	for line in report:
		if !line[1]:
			failed += 1
		print("[mansion_view self test] %s ... %s" % [line[0], "OK" if line[1] else "FAILED"])
	print("[mansion_view self test] %d checks, %d failed" % [report.size(), failed])
	input_handler.SystemMessage("Self test: %d checks, %d failed" % [report.size(), failed])


#Empty slots on floor 1, in order.
func free_slots(wanted):
	var res = []
	for code in slot_codes():
		if res.size() >= wanted:
			break
		if MansionLayout.slot_status(current_floor(), code) == 'empty':
			res.append(code)
	return res


func find_slot_of_type(type_code):
	for code in slot_codes():
		var room = get_room(code)
		if room != null and room.type == type_code:
			return code
	return null


func run_model_checks(report):
	var free = free_slots(3)
	report.append(["the level map provides empty slots", free.size() >= 3])
	if free.size() < 3:
		return
	var a = free[0]
	var b = free[1]

	report.append(["build a work room", MansionLayout.build_room(layout(), 0, a, 'forge')])
	var room = get_room(a)
	report.append(["a new room gets an id for its task", room.task_id != null])
	report.append(["a work room declares its discipline", RoomTypes.get_work_job('forge') == 'smith'])
	report.append(["a bedroom declares none", RoomTypes.get_work_job('bedrooms') == null])
	report.append(["base capacities come from the type",
		MansionLayout.work_capacity(room) == 1 and MansionLayout.sleep_capacity(room) == 0])

	room.upgrades['craft_expansion'] = 2
	report.append(["an upgrade widens the room", MansionLayout.work_capacity(room) == 3])
	room.upgrades['craft_tools'] = 1
	report.append(["and better tools modify only this room",
		is_equal_approx(MansionLayout.craft_modifier(room), 1.25)])
	room.upgrades.clear()

	report.append(["a unique room refuses a second copy",
		MansionLayout.build_room(layout(), 0, b, 'bathhouse')
			and MansionLayout.can_build(layout(), 0, free[2], 'bathhouse').reason == 'MANSIONVIEW_ERR_UNIQUE'])

	#the save round trip: JSON has no ints, and validate() has to put them back
	var restored = parse_json(to_json(layout()))
	MansionLayout.validate(restored, party())
	report.append(["layout survives to_json/parse_json", restored is Dictionary])
	report.append(["room ids survive the round trip",
		MansionLayout.get_room(MansionLayout.get_floor(restored, 0), a).task_id == room.task_id])
	report.append(["the id counter clears every id in use",
		int(restored.next_room_id) > int(str(room.task_id).split("_")[2])])


func run_work_checks(report):
	var free = free_slots(2)
	if free.size() < 2 or party().empty():
		report.append(["work: there is a slot and a character to test with", false])
		return
	var slot = free[0]
	MansionLayout.build_room(layout(), 0, slot, 'forge')
	refresh()
	var room = get_room(slot)

	report.append(["work: the room owns a task", tasks().has(room.task_id)])
	report.append(["work: the task carries the room's discipline", tasks()[room.task_id].job == 'smith'])
	report.append(["work: the task caps at the room's workplaces",
		tasks()[room.task_id].max_workers == MansionLayout.work_capacity(room)])

	var ids = party().keys()
	var first = ids[0]
	self.mode = 'work'
	report.append(["work: assign somebody", assign_worker(slot, first)])
	report.append(["work: the game agrees they work here", get_character(first).get_work() == room.task_id])
	report.append(["work: the room lists them", room_workers(room).has(first)])
	report.append(["work: they leave the rest panel", !resting_characters().has(first)])

	if ids.size() > 1:
		report.append(["work: a full room refuses the next one", !assign_worker(slot, ids[1])])

	#the room moves with its people, which is the whole reason the task id lives on it
	var target = free[1]
	MansionLayout.swap_slots(layout(), 0, slot, 0, target)
	refresh()
	report.append(["work: a swap carries the room's workers along",
		get_room(target).task_id == room.task_id and get_character(first).get_work() == room.task_id])

	demolish(target)
	report.append(["work: demolishing frees the workers", get_character(first).get_work() in ['', null]])


func run_sleep_checks(report):
	self.mode = 'sleep'
	refresh()
	var ids = party().keys()
	if ids.empty():
		report.append(["sleep: there is a household to test with", false])
		return

	#the level map ships enough beds, and joining the household seats you in one
	report.append(["sleep: everybody is seated without being asked", unhoused_count() == 0])
	report.append(["sleep: so nothing sits in the rest panel", resting_characters().empty()])
	#every check above runs after ensure_mansion_layout(), which sweeps the household on the
	#way through - so on its own it would pass even if the screen opened with empty beds.
	#This is the state the player actually saw, recorded in _ready() and never rebuilt.
	report.append(["sleep: and the screen opened that way, before anything was clicked",
		boot_unhoused == 0])

	var master = null
	var non_master = null
	for char_id in ids:
		if get_character(char_id).is_master():
			master = char_id
		elif non_master == null:
			non_master = char_id
	var master_slot = find_slot_of_type('master_bedroom')
	report.append(["sleep: the level map ships a master bedroom", master_slot != null])
	if master != null and master_slot != null:
		report.append(["sleep: the master was seated in his own room",
			MansionLayout.get_slot_of_character(layout(), master).slot == master_slot])
		report.append(["sleep: and nothing takes him out of it",
			MansionLayout.is_pinned(layout(), master, true)])
		unassign_resident(master)
		report.append(["sleep: even asking outright leaves him there",
			MansionLayout.get_slot_of_character(layout(), master) != null])
		report.append(["sleep: and his room cannot be torn down",
			MansionLayout.can_demolish(layout(), 0, master_slot).reason == 'MANSIONVIEW_ERR_MASTERROOM'])
	if non_master != null and master_slot != null:
		#one bed there is his and stays his, however wide the room has been made
		report.append(["sleep: a single bed room has no room for anyone else",
			MansionLayout.assign_character(layout(), 0, master_slot, non_master, false, master).reason == 'MANSIONVIEW_ERR_MASTERBED'])
		get_room(master_slot).upgrades['bed_size'] = 2
		report.append(["sleep: bed size lets others in beside him",
			MansionLayout.assign_character(layout(), 0, master_slot, non_master, false, master).ok])
		MansionLayout.unassign_character(layout(), non_master)
		#and his own bed is still held even then
		get_room(master_slot).occupants.clear()
		#three distinct non-masters against three beds: the third is refused, because one
		#of them is his. ids order is a dictionary's, so they have to be picked by hand.
		var others = []
		for char_id in ids:
			if char_id != master and others.size() < 3:
				others.append(char_id)
		report.append(["sleep: but one bed is still kept for him",
			others.size() == 3
				and MansionLayout.assign_character(layout(), 0, master_slot, others[0], false, master).ok
				and MansionLayout.assign_character(layout(), 0, master_slot, others[1], false, master).ok
				and MansionLayout.assign_character(layout(), 0, master_slot, others[2], false, master).reason == 'MANSIONVIEW_ERR_MASTERBED'])
		get_room(master_slot).occupants.clear()
		get_room(master_slot).upgrades.clear()
		ResourceScripts.game_res.autohouse_household()

	if non_master != null:
		var where = MansionLayout.get_slot_of_character(layout(), non_master)
		unassign_resident(non_master)
		report.append(["sleep: anyone else can be turned out", unhoused_count() == 1])
		report.append(["sleep: and then shows in the rest panel", resting_characters().has(non_master)])
		report.append(["sleep: putting them back seats them again",
			assign_resident(where.slot, non_master) and unhoused_count() == 0])

	report.append(["sleep: a luxury bedroom is tagged for the private-room bonus",
		RoomTypes.has_tag('luxury_bedrooms', 'luxury')])

	#beds mode is about beds: scaffolding places have no business in it
	var free = free_slots(1)
	if !free.empty():
		start_construct(free[0], 'forge')
		refresh()
		var node = grid.get_slot_node(free[0])
		var sleeping_places = count_place_kind(node, 'build')
		self.mode = 'work'
		refresh()
		var working_places = count_place_kind(grid.get_slot_node(free[0]), 'build')
		report.append(["sleep: no builder places while beds are being arranged", sleeping_places == 0])
		report.append(["sleep: but they are there in work mode", working_places > 0])
		pending_cancel = free[0]
		cancel_build_confirmed()
	self.mode = 'work'


func count_place_kind(node, kind):
	if node == null:
		return 0
	var res = 0
	for cell in node.get_node("People").get_children():
		if cell.visible and cell.get("kind") == kind:
			res += 1
	return res


func run_ui_checks(report):
	self.mode = 'work'
	report.append(["grid builds one node per slot", grid.slot_nodes().size() == slot_codes().size()])

	var free = free_slots(1)
	if !free.empty():
		open_card(free[0])
		report.append(["card opens on an empty slot with the build list",
			card.visible and card.get_node("BuildList").visible])
		report.append(["build list offers something affordable",
			card.get_node("BuildList").get_child_count() > 1])
		close_card()
		report.append(["card closes", !card.visible])

	layout().current_floor = 1
	refresh()
	var broken_code = null
	for code in slot_codes():
		if MansionLayout.slot_status(current_floor(), code) == 'broken':
			broken_code = code
			break
	report.append(["the level map has damaged slots", broken_code != null])
	if broken_code != null:
		open_card(broken_code)
		report.append(["card offers to clear out a damaged slot",
			card.visible and card.get_node("RepairButton").visible])
		close_card()
	layout().current_floor = 0
	refresh()

	self.mode = 'sleep'
	report.append(["the expel zone only exists in sleep mode", $ExpelZone.visible])
	self.mode = 'work'
	report.append(["and is gone again in work mode", !$ExpelZone.visible])

	set_zoom(99.0)
	report.append(["zoom stops at the maximum", is_equal_approx(zoom, grid.ZOOM_MAX)])
	set_zoom(-99.0)
	report.append(["zoom stops at the minimum", is_equal_approx(zoom, grid.ZOOM_MIN)])
	set_zoom(1.0)

	var slack = $GridViewport.rect_size - grid.rect_size * zoom
	center_view()
	pan_by(Vector2(100000, 100000))
	report.append(["dragging right and down stops at the margin",
		pan.x <= max(0.0, slack.x) + PAN_MARGIN + 0.01])
	pan_by(Vector2(-100000, -100000))
	report.append(["dragging left and up stops at the margin",
		pan.x >= min(0.0, slack.x) - PAN_MARGIN - 0.01])
	center_view()

	self.mode = 'rearrange'
	report.append(["rearrange mode engages and shuts the card", mode == 'rearrange' and !card.visible])
	self.mode = 'work'
	report.append(["work mode returns", mode == 'work' and picked_slot == null])


#Fires synthetic events straight at _input(), aimed at the middle of a slot node. That is
#exactly where the wheel used to be swallowed: slot nodes are Buttons, and a STOP control
#ends gui_input propagation in Godot 3 even when it ignores the event.
func run_input_checks(report):
	set_zoom(1.0)
	center_view()
	var nodes = grid.slot_nodes()
	if nodes.empty():
		report.append(["input: there is a slot to aim at", false])
		return
	var slot_rect = nodes[0].get_global_rect()
	var over_slot = slot_rect.position + slot_rect.size / 2
	report.append(["input: the probe point sits on a slot inside the plan",
		$GridViewport.get_global_rect().has_point(over_slot)])
	#this is the mechanical reason the handling cannot live on the grid's gui_input
	report.append(["input: slot nodes really do stop gui events",
		nodes[0].mouse_filter == Control.MOUSE_FILTER_STOP])

	var before = zoom
	_input(mouse_button(BUTTON_WHEEL_UP, over_slot, true))
	report.append(["input: the wheel zooms in over a slot", zoom > before])
	before = zoom
	_input(mouse_button(BUTTON_WHEEL_DOWN, over_slot, true))
	report.append(["input: and back out again", zoom < before])
	before = zoom
	_input(mouse_button(BUTTON_WHEEL_UP, $GridViewport.get_global_rect().position - Vector2(40, 40), true))
	report.append(["input: the wheel outside the plan is ignored", is_equal_approx(zoom, before)])

	set_zoom(1.0)
	center_view()
	var start = pan
	_input(mouse_button(BUTTON_MIDDLE, over_slot, true))
	report.append(["input: the middle button starts a drag", panning])
	_input(mouse_motion(Vector2(25, 15)))
	report.append(["input: motion drags the plan", !is_equal_approx(pan.x, start.x)])
	_input(mouse_button(BUTTON_MIDDLE, over_slot, false))
	report.append(["input: releasing ends the drag", !panning])
	var held = pan
	_input(mouse_motion(Vector2(40, 40)))
	report.append(["input: motion after the release does nothing", is_equal_approx(pan.x, held.x)])
	set_zoom(1.0)
	center_view()


func mouse_button(index, position, pressed):
	var event = InputEventMouseButton.new()
	event.button_index = index
	event.position = position
	event.global_position = position
	event.pressed = pressed
	return event


func mouse_motion(relative):
	var event = InputEventMouseMotion.new()
	event.relative = relative
	return event


#### clicking people around ####

func rest_cell(char_id):
	for cell in rest_panel.get_node("List").get_children():
		#ClearContainer hides and queue_frees, so within the frame the old cells are still
		#children - and the invisible one is the template every cell is copied from
		if cell.visible and cell.get("char_id") == char_id:
			return cell
	return null


func place_cell(slot_code, kind, char_id):
	var node = grid.get_slot_node(slot_code)
	if node == null:
		return null
	for cell in node.get_node("People").get_children():
		if cell.visible and cell.get("kind") == kind and cell.get("char_id") == char_id:
			return cell
	return null


func present_workers(wanted):
	var res = []
	for char_id in party():
		if res.size() >= wanted:
			break
		var person = get_character(char_id)
		#the master is pinned to his own bed, so he cannot stand in for the sleep half
		if person != null and !person.is_master() and person.is_worker() and is_present(person):
			res.append(char_id)
	return res


#Clicking is the second way to move somebody: one click lifts them, the next puts them
#down. These drive the real cells rather than the view's methods, because what is being
#checked is precisely what a click on a cell does - and that it agrees with a drag.
func run_click_checks(report):
	drag_end_frame = -1
	self.mode = 'work'
	var free = free_slots(1)
	var workers = present_workers(2)
	if free.empty() or workers.empty():
		report.append(["click: there is a room and somebody to move", false])
		return
	var slot = free[0]
	MansionLayout.build_room(layout(), 0, slot, 'forge')
	var worker = workers[0]
	unassign_worker(worker)
	refresh()

	var cell = rest_cell(worker)
	report.append(["click: an idle person is offered in the top panel", cell != null])
	if cell == null:
		return
	cell.on_pressed()
	report.append(["click: clicking them picks them up", picked_char == worker])
	report.append(["click: which by itself changes nothing",
		get_character(worker).get_work() in ['', null]])

	var target = place_cell(slot, 'work', null)
	report.append(["click: the room shows a free workplace", target != null])
	if target == null:
		return
	target.on_pressed()
	var room = get_room(slot)
	report.append(["click: clicking it puts them to work there",
		get_character(worker).get_work() == room.task_id])
	report.append(["click: and hands are empty again", picked_char == null])

	#a click on somebody already in a place lifts them rather than turning them out - that
	#is what makes one click enough to begin a move
	var filled = place_cell(slot, 'work', worker)
	report.append(["click: their workplace shows them", filled != null])
	if filled != null:
		filled.on_pressed()
		report.append(["click: clicking them lifts them out of it", picked_char == worker])
		report.append(["click: without taking the job away yet",
			get_character(worker).get_work() == room.task_id])
		var again = place_cell(slot, 'work', worker)
		if again != null:
			again.on_pressed()
		report.append(["click: clicking them again sets them back down",
			picked_char == null and get_character(worker).get_work() == room.task_id])

	#the top panel is where somebody is put down to be taken off the job
	filled = place_cell(slot, 'work', worker)
	if filled != null:
		filled.on_pressed()
	report.append(["click: the top panel offers itself to somebody in hand", rest_panel.accepts_pick()])
	rest_panel._gui_input(mouse_button(BUTTON_LEFT, Vector2.ZERO, true))
	report.append(["click: clicking it takes them off the job",
		get_character(worker).get_work() in ['', null] and picked_char == null])

	#the room body is a target too, exactly as it is for a drag
	cell = rest_cell(worker)
	if cell != null:
		cell.on_pressed()
	close_card()
	slot_pressed(slot)
	report.append(["click: the room itself takes them into its first free place",
		get_character(worker).get_work() == room.task_id])
	report.append(["click: instead of opening its card", !card.visible and picked_char == null])

	#a full room refuses a click for the same reason it refuses a drop
	if workers.size() > 1:
		var second = workers[1]
		unassign_worker(second)
		refresh()
		cell = rest_cell(second)
		if cell != null:
			cell.on_pressed()
		var occupied = place_cell(slot, 'work', worker)
		report.append(["click: a taken workplace refuses a drag",
			occupied != null and !occupied.can_drop_data(Vector2.ZERO, pick_data())])
		if occupied != null:
			occupied.on_pressed()
		report.append(["click: and refuses the click the same way",
			get_character(second).get_work() in ['', null]
				and get_character(worker).get_work() == room.task_id])
		clear_char_pick()

	#beds are the mode this was asked for, and they work the same
	self.mode = 'sleep'
	refresh()
	var housed = MansionLayout.get_slot_of_character(layout(), worker)
	report.append(["click: they have a bed to be moved out of", housed != null])
	if housed != null:
		unassign_resident(worker)
		refresh()
		cell = rest_cell(worker)
		report.append(["click: somebody without a bed shows in the panel", cell != null])
		if cell != null:
			cell.on_pressed()
			var bed = place_cell(housed.slot, 'sleep', null)
			report.append(["click: their old room shows a free bed", bed != null])
			if bed != null:
				bed.on_pressed()
			report.append(["click: clicking it puts them back to bed", unhoused_count() == 0])

	#a finished drag must not read as a click as well, or the cell it was dragged from would
	#end up holding somebody the player has already put down
	self.mode = 'work'
	unassign_worker(worker)
	refresh()
	cell = rest_cell(worker)
	_notification(NOTIFICATION_DRAG_END)
	if cell != null:
		cell.on_pressed()
	report.append(["click: the tail of a drag is not a new click", picked_char == null])
	drag_end_frame = -1

	unassign_worker(worker)
	demolish(slot)
	self.mode = 'work'


#The one check that needs a whole turn: process_rooms() is a pass nothing else in the
#game would run, so if it were missing or mis-wired a character standing in a kitchen
#would simply idle. This puts one there, queues a real recipe and advances a tick.
func run_turn_checks(report):
	var free = free_slots(1)
	if free.empty() or party().empty():
		report.append(["turn: there is a slot and a character to test with", false])
		return
	var slot = free[0]
	MansionLayout.build_room(layout(), 0, slot, 'kitchen')
	refresh()

	var worker = null
	for char_id in party():
		if get_character(char_id).is_worker() and is_present(get_character(char_id)):
			worker = char_id
			break
	report.append(["turn: somebody can be put to work", worker != null])
	if worker == null:
		return
	report.append(["turn: put them in the kitchen", assign_worker(slot, worker)])

	#bread is the simplest recipe in the game: 2 grain in, 2 bread out, 1 work unit. One
	#worker contributes well under a work unit per tick, so a single tick moves the
	#recipe's progress without finishing it - both are worth asserting separately.
	ResourceScripts.game_res.materials.grain = 500
	ResourceScripts.game_res.materials.bread = 0
	var recipe_id = ResourceScripts.game_res.add_recipe_task('bread', {}, {fixed = 20})
	ResourceScripts.game_res.tick()
	var recipe = ResourceScripts.game_res.tasks_progresses.get(recipe_id, null)
	report.append(["turn: a tick moves the recipe the room worker is on",
		recipe != null and recipe.progress > 0])

	#a full in-game day is four ticks, which is comfortably past one work unit
	for _i in range(variables.HoursPerDay):
		ResourceScripts.game_res.tick()
	report.append(["turn: a day of that actually yields the goods",
		ResourceScripts.game_res.materials.bread > 0])

	#and the same character does nothing at all once taken off the place
	unassign_worker(worker)
	var idle_before = ResourceScripts.game_res.materials.bread
	for _i in range(variables.HoursPerDay):
		ResourceScripts.game_res.tick()
	report.append(["turn: and stops when taken off it",
		ResourceScripts.game_res.materials.bread == idle_before])

	#everyone is seated on arrival now, so the blocker has to be given something to catch
	report.append(["turn: a full household does not block the turn",
		ResourceScripts.game_res.unhoused_characters().empty()])
	MansionLayout.unassign_character(layout(), worker)
	report.append(["turn: but one person without a bed does",
		!ResourceScripts.game_res.unhoused_characters().empty()])
	ResourceScripts.game_res.autohouse_household()

	#the private-room bonus is now a question about where somebody sleeps
	var lux = free_slots(1)
	if !lux.empty():
		MansionLayout.build_room(layout(), 0, lux[0], 'luxury_bedrooms')
		refresh()
		report.append(["turn: nobody has the private-room bonus yet",
			!ResourceScripts.game_res.character_room_has_tag(worker, 'luxury')])
		MansionLayout.assign_character(layout(), 0, lux[0], worker, false)
		report.append(["turn: sleeping in a luxury bedroom grants it",
			ResourceScripts.game_res.character_room_has_tag(worker, 'luxury')])
	report.append(["turn: the luxury work rule is gone",
		!variables.work_rules.has('luxury')])


#Nothing is instant any more, so the whole lifecycle needs covering: paying starts
#scaffolding, somebody has to stand in it, the tick moves it, and cancelling hands the
#materials back - which the old global upgrade queue never did.
func run_build_checks(report):
	self.mode = 'work'
	var free = free_slots(3)
	if free.size() < 3 or party().empty():
		report.append(["build: there are slots and a character to test with", false])
		return
	var slot = free[0]
	var cost = RoomTypes.get_type('forge').build_cost
	var wood_before = ResourceScripts.game_res.materials.wood

	start_construct(slot, 'forge')
	report.append(["build: paying starts scaffolding rather than a room",
		MansionLayout.slot_status(current_floor(), slot) == 'building' and get_room(slot) == null])
	report.append(["build: and the materials are gone",
		ResourceScripts.game_res.materials.wood < wood_before or !cost.has('wood')])
	report.append(["build: a second thing cannot be started on the same slot",
		MansionLayout.can_build(layout(), floor_index(), slot, 'kitchen').reason == 'MANSIONVIEW_ERR_BUILDING'])
	report.append(["build: nothing can be moved while it is going up",
		MansionLayout.can_swap(layout(), floor_index(), slot, floor_index(), free[1]).reason == 'MANSIONVIEW_ERR_BUILDING'])

	var build = MansionLayout.get_build(current_floor(), slot)
	report.append(["build: scaffolding owns a task", tasks().has(build.task_id)])
	report.append(["build: with one builder's place", tasks()[build.task_id].max_workers == 1])
	report.append(["build: no builder means no estimate", build_days_left(build) == null])

	var worker = null
	for char_id in party():
		if get_character(char_id).is_worker() and is_present(get_character(char_id)):
			worker = char_id
			break
	report.append(["build: put a builder in it", assign_builder(slot, worker)])
	report.append(["build: now there is an estimate", build_days_left(build) != null])
	ResourceScripts.game_res.tick()
	report.append(["build: a tick moves it along", build.progress > 0])

	#cancelling hands back exactly what was paid, which the old upgrade queue never did
	var wood_mid = ResourceScripts.game_res.materials.wood
	pending_cancel = slot
	cancel_build_confirmed()
	report.append(["build: cancelling clears the scaffolding",
		MansionLayout.get_build(current_floor(), slot) == null])
	report.append(["build: and refunds the materials",
		ResourceScripts.game_res.materials.wood > wood_mid or !cost.has('wood')])
	report.append(["build: the builder is released", get_character(worker).get_work() in ['', null]])

	#finishing it turns the scaffolding into the room it was
	start_construct(slot, 'forge')
	build = MansionLayout.get_build(current_floor(), slot)
	MansionLayout.advance_build(build, build.limit)
	assign_builder(slot, worker)
	ResourceScripts.game_res.tick()
	report.append(["build: finishing raises the room",
		MansionLayout.slot_status(current_floor(), slot) == 'built' and get_room(slot).type == 'forge'])
	report.append(["build: which owns a work task straight away",
		tasks().has(get_room(slot).task_id)])

	#upgrades run through the same scaffolding, one at a time, without stopping the room
	var room = get_room(slot)
	report.append(["upgrade: the room offers its own upgrades",
		MansionLayout.can_start_upgrade(layout(), floor_index(), slot, 'craft_tools').ok])
	start_upgrade(slot, 'craft_tools')
	report.append(["upgrade: the room keeps working while it goes on",
		MansionLayout.slot_status(current_floor(), slot) == 'built'])
	report.append(["upgrade: only one at a time",
		MansionLayout.can_start_upgrade(layout(), floor_index(), slot, 'craft_expansion').reason == 'MANSIONVIEW_ERR_BUILDING'])
	var upgrade_build = MansionLayout.get_build(current_floor(), slot)
	report.append(["upgrade: builders' places follow the room's own scaffolding upgrade",
		tasks()[upgrade_build.task_id].max_workers == MansionLayout.build_capacity(room)])
	MansionLayout.advance_build(upgrade_build, upgrade_build.limit)
	assign_builder(slot, worker)
	ResourceScripts.game_res.tick()
	report.append(["upgrade: finishing applies it",
		MansionLayout.upgrade_level(get_room(slot), 'craft_tools') == 1])
	report.append(["upgrade: and it really changes the room",
		is_equal_approx(MansionLayout.craft_modifier(get_room(slot)), 1.25)])
	report.append(["upgrade: the next level is still open",
		MansionLayout.can_start_upgrade(layout(), floor_index(), slot, 'craft_tools').ok])
	get_room(slot).upgrades['craft_tools'] = RoomUpgrades.max_level('craft_tools')
	report.append(["upgrade: but the top one is refused",
		MansionLayout.can_start_upgrade(layout(), floor_index(), slot, 'craft_tools').reason == 'MANSIONVIEW_ERR_MAXLEVEL'])

	#clearing out a derelict slot uses the same scaffolding, free of charge
	layout().current_floor = 1
	refresh()
	var broken = null
	for code in slot_codes():
		if MansionLayout.slot_status(current_floor(), code) == 'broken':
			broken = code
			break
	report.append(["repair: the level map ships a derelict slot", broken != null])
	if broken != null:
		start_repair(broken)
		var repair = MansionLayout.get_build(current_floor(), broken)
		report.append(["repair: it costs nothing", repair.refund.empty()])
		report.append(["repair: and reads as building", MansionLayout.slot_status(current_floor(), broken) == 'building'])
		MansionLayout.advance_build(repair, repair.limit)
		assign_builder(broken, worker)
		ResourceScripts.game_res.tick()
		report.append(["repair: finishing leaves an empty slot",
			MansionLayout.slot_status(current_floor(), broken) == 'empty'])
	layout().current_floor = 0
	refresh()


#Work away from home. None of these tasks are new - they come from the same idempotent
#creators the old job screen calls - so what is worth checking is that the screen reads
#them correctly and that assigning through it really puts somebody to work.
func run_location_checks(report):
	report.append(["location: the mansion is always on the bar",
		LocationTasks.accessible_locations().has(LocationTasks.MANSION_CODE)])

	var entries = LocationTasks.tasks_for(LocationTasks.MANSION_CODE)
	report.append(["location: home offers work of its own", !entries.empty()])
	if entries.empty() or party().empty():
		return
	var capped = null
	for entry in entries:
		if !entry.unlimited and entry.max_workers > 0:
			capped = entry
			break
	report.append(["location: that work has places on it", capped != null])
	if capped == null:
		return

	var worker = null
	for char_id in party():
		if get_character(char_id).is_worker() and is_present(get_character(char_id)):
			worker = char_id
			break
	if worker == null:
		report.append(["location: somebody can be sent to it", false])
		return
	unassign_worker(worker)
	report.append(["location: send somebody to it", assign_location_worker(capped.id, worker)])
	report.append(["location: the game agrees they work there",
		get_character(worker).get_work() == capped.id])
	report.append(["location: the task reports what it now yields",
		LocationTasks.production_per_turn(capped.id) > 0])
	report.append(["location: an idle task yields nothing",
		LocationTasks.production_per_turn(entries[0].id) >= 0])
	unassign_worker(worker)
	report.append(["location: taking them off empties it again",
		!LocationTasks.workers_of(capped.id).has(worker)])

	#a dungeon seam takes as many hands as you send, which is why gather_limited carries
	#no max_workers at all
	var dungeon = find_dungeon_code()
	report.append(["location: the world has a dungeon to check", dungeon != null])
	if dungeon != null:
		#seams only appear once a subroom with a resource has been cleared
		#(Exploration/Scripts/ExplorationDungeon.gd:1225), so a freshly generated world has
		#none - stock one the same way rather than let the check pass on an empty list
		stock_dungeon_seams(dungeon)
		var dungeon_entries = LocationTasks.tasks_for(dungeon)
		report.append(["location: a stocked dungeon offers work", !dungeon_entries.empty()])
		var seam = null
		for entry in dungeon_entries:
			if entry.unlimited:
				seam = entry
				break
		report.append(["location: dungeon work is uncapped", seam != null])
		if seam != null:
			report.append(["location: and shows what is left rather than places",
				seam.remaining != null and seam.remaining > 0])
			report.append(["location: with no worker cap on the task itself",
				int(tasks()[seam.id].get('max_workers', 0)) == 0])

	#switching away from home hides everything that only the mansion has
	set_place(LocationTasks.MANSION_CODE)
	report.append(["location: home shows the floorplan", $GridViewport.visible and !location_panel.visible])
	var away = dungeon if dungeon != null else LocationTasks.MANSION_CODE
	if away != LocationTasks.MANSION_CODE:
		set_place(away)
		report.append(["location: elsewhere shows the location panel instead",
			location_panel.visible and !$GridViewport.visible])
		report.append(["location: with no beds and no rearranging out there",
			$TopBar/ModeSleep.disabled and $TopBar/ModeRearrange.disabled])
		self.mode = 'sleep'
		report.append(["location: and the modes refuse to switch", mode == 'work'])
		set_place(LocationTasks.MANSION_CODE)
		report.append(["location: coming home brings them back",
			!$TopBar/ModeSleep.disabled and $GridViewport.visible])


#Test mode posts two of the household out into the world so both shapes of the location
#screen can be opened by hand rather than only from this file. These check that the bar
#really offers them, and that the work on them can be handed out and reports a yield.
func run_test_location_checks(report):
	#the screen's idea of home is a constant, the world's is generated; if they ever part
	#company the mansion simply stops being on its own bar
	report.append(["test places: home is the code the world actually generated",
		LocationTasks.MANSION_CODE == ResourceScripts.game_world.mansion_location])

	var bar = LocationTasks.accessible_locations()
	report.append(["test places: the bar offers somewhere besides the mansion", bar.size() > 2])
	var town = null
	var dungeon = null
	for code in bar:
		if code == LocationTasks.MANSION_CODE:
			continue
		match ResourceScripts.world_gen.get_location_from_code(code).type:
			'settlement':
				town = code if town == null else town
			'dungeon':
				dungeon = code if dungeon == null else dungeon

	report.append(["test places: one of them is a settlement", town != null])
	if town != null:
		var town_work = LocationTasks.tasks_for(town)
		report.append(["test places: with work of its own to hand out", !town_work.empty()])
		var capped = null
		for entry in town_work:
			if !entry.unlimited and entry.max_workers > 0:
				capped = entry
				break
		report.append(["test places: some of it with places to stand in", capped != null])
		var locals = LocationTasks.characters_at(town)
		report.append(["test places: and somebody standing there to do it", !locals.empty()])
		if capped != null and !locals.empty():
			set_place(town)
			report.append(["test places: who can be put on it",
				assign_location_worker(capped.id, locals[0])])
			unassign_worker(locals[0])
			set_place(LocationTasks.MANSION_CODE)

	report.append(["test places: and one of them a dungeon", dungeon != null])
	if dungeon == null:
		return
	var seam = null
	for entry in LocationTasks.tasks_for(dungeon):
		if entry.unlimited:
			seam = entry
			break
	report.append(["test places: whose seams are stocked before anything is clicked", seam != null])
	var diggers = LocationTasks.characters_at(dungeon)
	report.append(["test places: with somebody standing there to dig", !diggers.empty()])
	if seam == null or diggers.empty():
		return
	set_place(dungeon)
	report.append(["test places: who can be put on a seam",
		assign_location_worker(seam.id, diggers[0])])
	#digging asks the location for its gather mod, which is the one thing about a seam that
	#is not visible in the entry itself
	report.append(["test places: and the seam reports what they dig out",
		LocationTasks.production_per_turn(seam.id) > 0])
	unassign_worker(diggers[0])
	set_place(LocationTasks.MANSION_CODE)


func find_dungeon_code():
	for code in ResourceScripts.game_world.location_links:
		var location = ResourceScripts.world_gen.get_location_from_code(code)
		if location != null and location.has('type') and location.type == 'dungeon':
			return code
	return null


#Room upgrades are only worth having if the game outside this screen actually reads them.
#These check the seams where a room's own upgrade replaces a global one.
func run_effect_checks(report):
	var master_slot = find_slot_of_type('master_bedroom')
	report.append(["effects: the level map ships a master bedroom", master_slot != null])
	if master_slot != null:
		var room = get_room(master_slot)
		room.upgrades.clear()
		var base = ResourceScripts.game_res.get_sex_limit()
		room.upgrades['furnishing'] = 2
		report.append(["effects: furnishing widens who fits in a scene",
			ResourceScripts.game_res.get_sex_limit() == base + 2])
		#the formula used to be copied into both screens that ask; if anybody inlines it
		#again the room's furnishing silently stops counting on one of them
		report.append(["effects: both screens delegate instead of copying the formula",
			delegates_sex_limit("res://src/scenes/SexSelectMenu.gd")
				and delegates_sex_limit("res://gui_modules/Mansion/Scripts/MansionSlaveListModule.gd")])
		room.upgrades.clear()
		report.append(["effects: and narrows again without it",
			ResourceScripts.game_res.get_sex_limit() == base])

		#bed size is beds, and those already run through sleep_capacity
		var beds = MansionLayout.sleep_capacity(room)
		room.upgrades['bed_size'] = 3
		report.append(["effects: bed size adds beds beside the master's",
			MansionLayout.sleep_capacity(room) == beds + 3])
		room.upgrades.clear()

	#a bathhouse answers the same question the old Bath upgrade did
	ResourceScripts.game_res.upgrades.resting = 0
	report.append(["effects: no bathhouse and no upgrade means no bath",
		!ResourceScripts.game_res.has_bath()])
	var free = free_slots(1)
	if !free.empty():
		MansionLayout.build_room(layout(), floor_index(), free[0], 'bathhouse')
		report.append(["effects: simply having a bathhouse grants it",
			ResourceScripts.game_res.has_bath()])
		MansionLayout.demolish_room(layout(), floor_index(), free[0])
	ResourceScripts.game_res.upgrades.resting = 1
	report.append(["effects: and the old upgrade still grants it on its own",
		ResourceScripts.game_res.has_bath()])
	ResourceScripts.game_res.upgrades.resting = 0


func delegates_sex_limit(path):
	var file = File.new()
	if file.open(path, File.READ) != OK:
		return false
	var text = file.get_as_text()
	file.close()
	return text.find("get_sex_limit()") != -1 and text.find("upgrades.master_bedroom") == -1


#A room may be carried to another floor: the pick survives the trip, and everything the
#room owns travels with it because the whole dictionary moves.
func run_floor_checks(report):
	report.append(["floors: the mansion has more than one", layout().floors.size() > 1])
	if layout().floors.size() < 2:
		return
	var ground = free_slots(1)
	if ground.empty():
		report.append(["floors: there is somewhere to build downstairs", false])
		return
	var here = ground[0]
	MansionLayout.build_room(layout(), 0, here, 'forge')
	refresh()
	var task_id = get_room(here).task_id

	layout().current_floor = 1
	refresh()
	var upstairs = free_slots(1)
	report.append(["floors: and somewhere free upstairs", !upstairs.empty()])
	if upstairs.empty():
		return
	var there = upstairs[0]

	report.append(["floors: a room on another floor is a valid target",
		MansionLayout.can_swap(layout(), 0, here, 1, there).ok])
	report.append(["floors: carry it upstairs", MansionLayout.swap_slots(layout(), 0, here, 1, there)])
	report.append(["floors: it arrived", MansionLayout.slot_status(MansionLayout.get_floor(layout(), 1), there) == 'built'])
	report.append(["floors: and left the floor below",
		MansionLayout.slot_status(MansionLayout.get_floor(layout(), 0), here) == 'empty'])
	report.append(["floors: keeping everything it owned",
		MansionLayout.get_room(MansionLayout.get_floor(layout(), 1), there).task_id == task_id])
	report.append(["floors: a slot still cannot trade with itself",
		!MansionLayout.can_swap(layout(), 1, there, 1, there).ok])

	#picking something up and walking to another floor is the interaction that needs it
	self.mode = 'rearrange'
	layout().current_floor = 1
	refresh()
	set_pick(there)
	report.append(["floors: the pick remembers its floor", picked_floor == 1])
	change_floor(-1)
	report.append(["floors: and survives the trip downstairs",
		picked_slot == there and picked_floor == 1 and floor_index() == 0])
	try_swap(picked_floor, picked_slot, 0, here)
	report.append(["floors: putting it down completes the move",
		MansionLayout.slot_status(current_floor(), here) == 'built'])
	clear_pick()
	self.mode = 'work'


#The free placement rules kept for laying furniture out inside a room. Nothing on the
#floor uses them any more, so they are only honest if they stay covered.
func run_placement_checks(report):
	var Placement = load("res://src/core/mansion_placement.gd")
	var area = Placement.make_area(20, 20, [[0, 0, 4, 4]])
	var items = Placement.make_items()

	var first = Placement.place(area, items, [6, 6, 4, 4])
	report.append(["placement: put an item down", first != null])
	report.append(["placement: overlapping is refused",
		Placement.can_place(area, items, [8, 8, 4, 4]).reason == 'MANSIONVIEW_ERR_OCCUPIED'])
	report.append(["placement: hanging over the edge is refused",
		Placement.can_place(area, items, [18, 18, 4, 4]).reason == 'MANSIONVIEW_ERR_NOSPACE'])
	report.append(["placement: blocked ground is refused",
		Placement.can_place(area, items, [1, 1, 4, 4]).reason == 'MANSIONVIEW_ERR_LOCKED'])
	report.append(["placement: an item may move onto its own ground",
		Placement.move(area, items, first, 7, 6)])
	report.append(["placement: lookup by point", Placement.item_at(items, 8, 7).id == first])
	report.append(["placement: remove", Placement.remove(items, first) and items.empty()])
