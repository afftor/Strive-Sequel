extends Control
#This script owns every autoload lookup for the feature. mansion_layout.gd and the two
#data registries stay free of singletons because game_res.gd preloads them and preload

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const FloorPlans = preload("res://assets/data/mansion_floor_plans.gd")
const LocationTasks = preload("res://gui_modules/mansion_view/mansion_location_tasks.gd")

#### the hard tutorial's handles on this screen ####
#The tutorial teaches the mansion by pointing at real rooms, so it needs to name particular
#ones. The slot nodes are rebuilt on every grid.rebuild() and the local-task cards on every
#refresh, so nothing can be registered as a node - every one of these is resolved again each
#frame by input_handler's button registry (hard_tutorial.validate_btn).
#A slot that starts as rubble on the ground floor - see assets/data/mansion_floor_plans.gd.
#The whole chapter happens on this one slot: it is cleared out, then a kitchen is raised on
#it, then that kitchen is worked.
const TUTORIAL_SLOT = 'c2'
#The plot the tutorial's kitchen garden stands on, put there by hard_tutorial.prepare_general_tut.
const TUTORIAL_PLOT = 'g1'

signal place_changed(code)
#What the plan is arranging - work or beds. Embedded, the buttons for it live in the mansion's
#left-hand column rather than on the plan itself, so they have to hear about it.
signal mode_changed(value)

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
#Whether the panel beside the card was up when the card stepped aside.  A room with nothing
#to say never had one, so it must not be conjured up on the way back - see set_card_aside().
var details_were_shown = false
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
	$TopBar/ModeWork.text = tr("MANSIONVIEW_MODEWORK")
	$TopBar/ModeSleep.text = tr("MANSIONVIEW_MODEBEDS")
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
	#The house can change without this screen touching it: the choice at the start of a game
	#hands over a room, a story effect can raise or take one, achievements grant them. Whoever
	#changes the house says so through this signal - without it the plan went on drawing the
	#house as it was when it was last looked at.
	globals.connect("rooms_changed", self, "on_rooms_changed")
	layout_view()
	if embedded:
		globals.connect("slave_added", self, "queue_refresh")
		globals.connect("task_removed", self, "queue_refresh")
	refresh()
	center_view()
	register_tutorial_buttons()


#### the hard tutorial ####

#Nothing on this screen keeps a stable node to hand out, so each of these is a search rather
#than a reference. A search that comes up empty answers null, which the tutorial reads as
#"not built yet" and retries on the next frame - that is how a step can point at a builder's
#place that only appears once the scaffolding is paid for.
func register_tutorial_buttons():
	input_handler.register_btn_source('mansion_tut_slot', self, 'tut_get_slot')
	input_handler.register_btn_source('mansion_build_place', self, 'tut_get_build_place')
	input_handler.register_btn_source('mansion_work_place', self, 'tut_get_work_place')
	input_handler.register_btn_source('mansion_rest_daisy', self, 'tut_get_rest_daisy')
	input_handler.register_btn_source('mansion_rest_master', self, 'tut_get_rest_master')
	input_handler.register_btn_source('mansion_rest_servant', self, 'tut_get_rest_servant')
	input_handler.register_btn_source('mansion_garden_place', self, 'tut_get_garden_place')
	input_handler.register_btn_source('mansion_store_slot', self, 'tut_get_store_slot')
	input_handler.register_btn_source('mansion_bed_place', self, 'tut_get_bed_place')


func tut_get_slot():
	if !showing_plan():
		return null
	return grid.get_slot_node(TUTORIAL_SLOT)


#The first place of this kind standing empty inside the tutorial's own slot. Builders and
#workers are the same cell in two colours (mansion_char_slot.gd), so one search serves both.
#The estate's chest is opened from the store room's own card now, so the tutorial has to walk
#the player to that room first. Found by what stands in it rather than by where it stands.
func tut_get_store_slot():
	if !showing_plan():
		return null
	for entry in MansionLayout.each_room(layout()):
		if entry.floor == floor_index() and entry.room.type == 'store_room':
			return grid.get_slot_node(entry.slot)
	return null


#The first bed standing empty anywhere on the floor being drawn. Which room it is in is not the
#lesson - that somebody is carried into one is - so this looks across the whole floor rather
#than at one slot the way the work chapter's places do. The master's own bed is passed over: it
#is his and every drop onto it is refused (mansion_char_slot.refusal_for), so framing it would
#be pointing at a wall.
func tut_get_bed_place():
	if !showing_plan() or mode != 'sleep':
		return null
	for entry in MansionLayout.each_room(layout()):
		if entry.floor != floor_index():
			continue
		var node = grid.get_slot_node(entry.slot)
		if node == null or !node.has_node("People"):
			continue
		for cell in node.get_node("People").get_children():
			if cell.is_queued_for_deletion() or !cell.visible:
				continue
			if cell.get('kind') != 'sleep' or cell.get('master_bed'):
				continue
			if cell.get('char_id') == null:
				return cell
	return null


func tut_get_empty_place(kind):
	var node = tut_get_slot()
	if node == null or !node.has_node("People"):
		return null
	for cell in node.get_node("People").get_children():
		if cell.is_queued_for_deletion() or !cell.visible:
			continue
		if cell.get('kind') == kind and cell.get('char_id') == null:
			return cell
	return null


func tut_get_build_place():
	return tut_get_empty_place('build')


func tut_get_work_place():
	return tut_get_empty_place('work')


#A portrait in the idle strip, found by who it is rather than by where it sits: the strip is
#rebuilt from scratch whenever anybody is put to work, and the order changes with it.
func tut_get_rest_cell(unique_code):
	if !rest_panel.visible or !rest_panel.has_node("Scroll/List"):
		return null
	for cell in rest_panel.get_node("Scroll/List").get_children():
		if cell.is_queued_for_deletion() or !cell.visible:
			continue
		var person = get_character(cell.get('char_id'))
		if person != null and person.get_stat('unique') == unique_code:
			return cell
	return null


func tut_get_rest_daisy():
	return tut_get_rest_cell('daisy')


#The master's own portrait in the strip. Used by the lesson about the right click menu, which
#is taught here rather than on a row of the household list: the rooms chapter has the list
#folded away by then, and the menu the strip offers is the whole of it
#(mansion_view.open_char_menu) rather than the two entries a row has.
func tut_get_rest_master():
	return tut_get_rest_cell('tutorial_master')


func tut_get_rest_servant():
	return tut_get_rest_cell('tutorial_servant')


#The empty place on the kitchen garden's card. The card is only in the tree while the local
#tasks screen is up, and it carries its plot as metadata (mansion_task_room.setup_plot).
func tut_get_garden_place():
	if !local_tasks or !location_panel.visible:
		return null
	for card_node in location_panel.get_node("Rooms").get_children():
		if card_node.is_queued_for_deletion() or !card_node.visible:
			continue
		if card_node.get_meta('plot', '') != TUTORIAL_PLOT:
			continue
		if !card_node.has_node("PeopleScroll/People"):
			return null
		for cell in card_node.get_node("PeopleScroll/People").get_children():
			if cell.is_queued_for_deletion() or !cell.visible:
				continue
			if cell.get('kind') == 'task' and cell.get('char_id') == null:
				return cell
		return null
	return null


func on_visibility_changed():
	#The card, the hover panel and the character menu live on a CanvasLayer so they draw above
	#the room plan - but a CanvasLayer does not inherit its parent's visibility, so hiding the
	#mansion leaves whatever stands on it drawing over whatever screen came next. Closing the
	#card is not enough on its own: the layer itself is put away with the plan.
	$Overlay.visible = is_visible_in_tree()
	if is_visible_in_tree():
		#a room granted while this screen was away leaves it drawing the old house
		if layout_signature() != built_signature:
			queue_refresh()
		return
	close_card()
	clear_char_pick()


#The hover panel for a portrait: the line the cell wants at the top, then the character's own
#numbers, tools and buffs. One panel serves every portrait on the screen - it is on the overlay
#so it draws above the room card, like the other two tooltips beside it.
#The cell's own binding is dropped first: refresh() runs often, and a second binding would open
#the panel twice from one hover.
func connect_char_tooltip(node, person, text, hint = ""):
	var panel = $Overlay/CharTooltip
	if node.is_connected("mouse_entered", panel, "showup"):
		node.disconnect("mouse_entered", panel, "showup")
	globals.disconnect_text_tooltip(node)
	if person == null:
		return
	node.connect("mouse_entered", panel, "showup", [node, person, text, hint])



#### the character menu ####

#a line's worth of picture, no more
const MENU_ICON_SIZE = 32
#the social panel the expanded card draws: six slots, and the menu offers what is in them
const SOCIAL_PANEL_SLOTS = 6
var menu_icons = {}

#The household list has offered this menu on a right click for a while; the work strip carries
#the same people, so it offers the same menu. Everything on it is done by the list module, which
#owns those screens - this only decides what is worth offering for this character.
func open_char_menu(person, at = null):
	var menu = $Overlay/CharMenu
	if person == null or menu == null:
		return
	#Unfold first: it is the one that keeps the player where they are, on the mansion, and the
	#others send them off to a screen of their own.
	var actions = []
	menu_action(actions, tr("MANSIONVIEW_MENU_UNFOLD"), "menu_unfold", person, [true, ""])
	menu_action(actions, tr("MANSIONVIEW_MENU_LEVELING"), "menu_open_leveling", person,
		leveling_allowed(person))
	menu_action(actions, tr("TRAINING_LABEL"), "menu_open_training", person,
		training_allowed(person))
	menu_action(actions, tr("MSLMCONTEXT_INVENTORY"), "menu_open_inventory", person,
		inventory_allowed(person))
	menu_action(actions, tr("MSLMCONTEXT_OPEN"), "menu_open_info", person, [true, ""])
	#Nobody takes themselves out. The card hides its date button on the master rather than
	#greying it, and this menu does the same.
	if !person.is_master():
		menu_action(actions, date_label(), "menu_start_date", person, date_allowed(person))
	for entry in social_skill_actions(person):
		actions.append(entry)
	menu.open_with_actions(person.get_short_name(), actions,
		at if at != null else get_viewport().get_mouse_position())


#What they can do to somebody today. A skill they cannot pay for, have no charges left of or do
#not meet the conditions for is still listed - saying so is the point - but it is greyed out and
#cannot be pressed, the same as its slot on the expanded card.
#Only what the character has to hand: the six slots of their social panel, in the order the
#expanded card draws them (MansionSlaveListModule.build_expanded_social_skills). Everything they
#merely know but have not put in a slot belongs to the panel where slots are arranged, not to a
#menu meant for using one now.
func social_skill_actions(person):
	var res = []
	person.rebuild_skills()
	var panel = person.skills.social_skill_panel
	var skills = []
	for position in range(1, SOCIAL_PANEL_SLOTS + 1):
		if panel.has(position):
			skills.append(panel[position])
	if skills.empty():
		return res
	res.append({separator = tr("MANSIONVIEW_MENU_SOCIAL")})
	for code in skills:
		var data = Skilldata.get_template(code, person)
		if data == null:
			continue
		var usable = social_skill_usable(person, code, data)
		#a skill they cannot use today keeps its own picture and goes grey, so the line still
		#says which skill it is; the reason it is out of reach is on the tooltip
		res.append({
			label = tr(data.name),
			icon = skill_icon(data),
			disabled = !usable,
			tooltip = "" if usable else tr("MANSIONVIEW_MENU_SKILLREFUSED") % tr(data.name),
			callback = funcref(self, "menu_use_social"),
			args = [person, code],
		})
	return res


func skill_icon(data):
	if data.icon is String:
		return menu_sized(load(data.icon)) if data.icon != '' else null
	return menu_sized(data.icon)


#A skill's own picture is drawn at whatever size it was painted - 256 across for most of them -
#and a PopupMenu in Godot 3.5 draws an icon at its natural size, which turned each line into a
#poster. One copy is made at the height of a line and kept for as long as the screen lives.
func menu_sized(texture):
	if texture == null:
		return null
	if menu_icons.has(texture):
		return menu_icons[texture]
	var image = texture.get_data()
	if image == null:
		return texture
	image = image.duplicate()
	image.resize(MENU_ICON_SIZE, MENU_ICON_SIZE, Image.INTERPOLATE_BILINEAR)
	var small = ImageTexture.new()
	small.create_from_image(image)
	menu_icons[texture] = small
	return small


func social_skill_usable(person, code, data):
	if !person.check_cost(data.cost):
		return false
	if !person.checkreqs(data.reqs):
		return false
	var used = person.skills.social_skills_charges.get(code, 0)
	return Skilldata.get_charges(data, person) - used > 0


#### what the menu does ####

func menu_open_info(person):
	get_parent().set_active_person(person)
	get_parent().mansion_state = "char_info"


func menu_open_inventory(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list):
		return
	get_parent().set_active_person(person)
	list.OpenInventory(person)


#Unfolding is the household list's business: it opens itself and puts this character's card up,
#which is the same as unfolding it by hand and pressing them.
func menu_unfold(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list) or !list.has_method('unfold_to_person'):
		return
	list.unfold_to_person(person)


#Training is its own popup over the mansion, the same one the card's own button opens - the list
#module knows which tab of it this character wants.
func menu_open_training(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list):
		return
	list.OpenTraining(person)



#Every line the menu offers, with the same answer the card's own button would give. What is
#refused is still listed, greyed out and unpressable - the same treatment the card gives its own
#buttons - and the reason it gives is carried on the line's tooltip.
func menu_action(actions, label, method, person, allowed):
	var reason = allowed[1]
	actions.append({
		label = label,
		disabled = !allowed[0],
		tooltip = "" if allowed[0] else (reason if reason != "" else tr("MANSIONVIEW_MENU_REFUSED")),
		callback = funcref(self, "menu_do"),
		args = [method, person, allowed],
	})


#The menu greys a refused line, so this should never be reached with a refusal; it stays as the
#backstop that keeps a rule from being walked around if a line is ever left pressable.
func menu_do(method, person, allowed):
	if !allowed[0]:
		var reason = allowed[1]
		input_handler.SystemMessage(reason if reason != "" else tr("MANSIONVIEW_MENU_REFUSED"))
		return
	call(method, person)


#The rules are the card's, asked of the list module that owns them rather than written again -
#see MansionSlaveListModule._update_card_action_states, which gates the same five buttons.
func leveling_allowed(person):
	if person.is_avaliable():
		return [true, ""]
	return [false, person.get_unaval_string()]


func training_allowed(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list) or !list.has_method('training_availability'):
		return [true, ""]
	return list.training_availability(person)


func inventory_allowed(person):
	if !person.is_on_quest():
		return [true, ""]
	return [false, person.translate(tr("ONQUESTLABEL"))]


#The date's refusal comes back as a key, the way the card receives it, so it is translated and
#given the character's own words here.
func date_allowed(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list) or !list.has_method('date_availability'):
		return [true, ""]
	var answer = list.date_availability(person)
	if answer[0]:
		return [true, ""]
	return [false, person.translate(tr(answer[1]))]

#How many dates are left this week, said on the line itself - the card's own date button says it
#the same way (MansionSlaveListModule:1785), and a player about to spend the last one should not
#have to hover something else to find that out.
func date_label():
	return tr("BTNDATE") + " (%d/%d)" % [ResourceScripts.game_globals.weekly_dates_left,
		ResourceScripts.game_globals.weekly_dates_max]


#The date is asked for before it is started - the list module puts the question and takes the
#answer, the same way its own card button does.
func menu_start_date(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list):
		return
	list.OpenDate(person)


func menu_open_leveling(person):
	var list = input_handler.slave_list_node
	if list == null or !is_instance_valid(list):
		return
	list.OpenProgression(person)


#A skill with nobody to aim at is used on the character themselves; the rest go through the
#targeting screen, the way the character's own skill list does it (SUpgradesList.select_spell).
func menu_use_social(person, code):
	var data = Skilldata.get_template(code, person)
	if data == null or !social_skill_usable(person, code, data):
		input_handler.SystemMessage(tr("MANSIONVIEW_MENU_SKILLREFUSED") % tr(data.name))
		return
	if data.tags.has('no_target'):
		person.use_social_skill(code, person)
		input_handler.emit_signal("SpellUsed")
		return
	gui_controller.spells = input_handler.get_spec_node(input_handler.NODE_SPELLS)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.spells, 0.3)
	gui_controller.spells.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.spells
	#locked to this caster and this skill: the menu was opened on one person, so the screen is
	#only there to ask who it lands on
	gui_controller.spells.open(person, code, true)
	gui_controller.emit_signal("screen_changed")


#What is drawn was built for a house that has just changed, so it cannot be trusted however
#much of it still matches - the signature goes with it.
func on_rooms_changed():
	built_signature = ""
	update()


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


#Four short columns keep local work in the lower-left corner instead of laying a wall across
#the rooms. Width includes the grid's six-pixel gap, so the column calculation stays exact.
const LOCATION_CARD_WIDTH = 186
const LOCATION_CARD_HEIGHT = 164
const LOCATION_GRID_MAX_COLUMNS = 4
#below the location's name, which sits at 12..52
const LOCATION_GRID_TOP = 64


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
	if embedded:
		lay_out_location_panel(open_rect())


func refresh_location_places():
	for node in location_panel.get_node("Rooms").get_children():
		if node.is_queued_for_deletion():
			continue
		if node.has_meta('task') or node.has_meta('plot'):
			node.refresh()


func lay_out_location_panel(room):
	var panel_room = room
	#the estate's own column - clock, plan buttons, what has been gathered, the journal - stands
	#down the left of the screen, and the picture used to run under it, so those panels sat on
	#the location like litter. It begins where they end instead
	if embedded:
		panel_room = Rect2(room.position + Vector2(EMBEDDED_RAIL_WIDTH, 0),
			room.size - Vector2(EMBEDDED_RAIL_WIDTH, 0))
	place_child($LocationPanel, panel_room)
	var inner = panel_room.size.x - 48
	var rooms = $LocationPanel/Rooms
	var columns = int(min(LOCATION_GRID_MAX_COLUMNS,
		max(1, floor(inner / LOCATION_CARD_WIDTH))))
	rooms.columns = columns
	var card_count = 0
	for child in rooms.get_children():
		if child.visible and !child.is_queued_for_deletion():
			card_count += 1
	var rows = int(max(1, ceil(card_count / float(columns))))
	var across = int(min(columns, max(1, card_count)))
	var grid_width = min(inner, across * LOCATION_CARD_WIDTH - 6)
	var grid_height = rows * LOCATION_CARD_HEIGHT + (rows - 1) * 10
	#what is gathered at the location stands across the top of its picture, in the middle: the
	#place is the subject of this screen, and what the estate has dug out of it is reported
	#elsewhere, at the bottom of the screen
	var grid_left = max(24, round((panel_room.size.x - grid_width) / 2.0))
	place_child(rooms, Rect2(grid_left, LOCATION_GRID_TOP, grid_width,
		min(grid_height, panel_room.size.y - LOCATION_GRID_TOP - 24)))
	place_child($LocationPanel/Title, Rect2(24, 12, min(800, inner), 40))
	place_child($LocationPanel/Empty, Rect2(24, 64, min(900, inner), 36))


#Where the strips sit is the panel's own business - it has two of them and knows how tall each
#turned out. All that is left here is letting a drop fall through the scrollers onto the panel.
func lay_out_strip(panel):
	for path in ['Scroll', 'Scroll/List', 'BusyScroll', 'BusyScroll/BusyList']:
		panel.get_node(path).mouse_filter = Control.MOUSE_FILTER_PASS


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
	#The estate's own tasks and another place's are the same question about different ground, so
	#swapping between them says the same thing as walking to another place: what this screen is
	#showing has changed. Said out loud because the screen above decides from it which view is up -
	#the navigation strip reaches this directly, without going through the buttons.
	emit_signal("place_changed", place)
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


#The other half of the strip: everyone at this place who IS at work and could be moved to
#different work. Whoever cannot be moved is left out rather than shown greyed - the point of
#the row is that it can be dragged from, and a portrait that refuses every drop is noise.
func working_characters():
	var res = []
	if mode != 'work':
		return res
	for char_id in LocationTasks.characters_at(place):
		var person = get_character(char_id)
		if person == null or person.is_on_quest() or person.is_unavaliable():
			continue
		if person.get_work() in ['', null]:
			continue
		if !person.is_worker() or !person_is_here(person):
			continue
		res.append(char_id)
	return res


#What somebody is busy with, as a picture and a line of text. Read off the task they hold
#rather than off the room they stand in: a builder, a farm hand and a clerk are all "in" a
#room, and it is the work that tells them apart.
func assignment_of(char_id):
	var person = get_character(char_id)
	if person == null:
		return null
	var task_id = person.get_work()
	if task_id in ['', null] or !tasks().has(task_id):
		return null
	var task = tasks()[task_id]
	var icon = task.get('icon', null)
	return {
		icon = load(icon) if (icon is String and icon != '') else icon,
		text = tr(task.name) if task.has('name') else '',
	}


#Beds standing empty. The strip's "bed them down" button is only worth offering while there
#are some - what the estate can sleep, less those already tucked in.
func free_beds():
	var housed = 0
	for entry in MansionLayout.each_room(layout()):
		housed += entry.room.occupants.size()
	return max(0, MansionLayout.total_sleep_capacity(layout()) - housed)


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
		input_handler.SystemMessage(person.translate(tr("MANSIONVIEW_ERR_AWAY")))
		return false
	if !person.is_worker():
		input_handler.SystemMessage(person.translate(tr("MANSIONVIEW_ERR_NOTWORKER")))
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
		input_handler.SystemMessage(person.translate(tr("MANSIONVIEW_ERR_AWAY")))
		return false
	if !person.is_worker():
		input_handler.SystemMessage(person.translate(tr("MANSIONVIEW_ERR_NOTWORKER")))
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
	#The tutor is named on the room rather than held by a place, so walking out of the room has
	#to take the title with them - otherwise the room would go on claiming a teacher who is not
	#in it. Done here rather than on the card: this is the door every way out goes through.
	clear_tutor(char_id)
	person.remove_from_task()
	refresh_people()


func clear_tutor(char_id):
	for entry in MansionLayout.each_room(layout()):
		if entry.room.practice.trainer == char_id:
			entry.room.practice.trainer = null


#Somebody put in the tutor's place. They take an ordinary workplace in the room like anyone
#else - what makes them the tutor is the room naming them, which is what practice_trainer()
#reads before it will let a habit be worked out of anybody.
func assign_tutor(slot_code, char_id):
	var room = get_room(slot_code)
	if room == null:
		return false
	if !assign_worker(slot_code, char_id):
		return false
	room.practice.trainer = char_id
	refresh_people()
	return true


func assign_resident(slot_code, char_id):
	var person = get_character(char_id)
	if person == null:
		return false
	var check = MansionLayout.assign_character(layout(), floor_index(), slot_code, char_id,
		person.is_master(), master_id(), ResourceScripts.game_res.shares_master_bed(person))
	if !check.ok:
		input_handler.SystemMessage(person.translate(tr(check.reason)))
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
#### what a turn is worth ####

#What one character puts into the place they are standing in, per turn. This is the turn's own
#arithmetic asked one person at a time: game_res.process_rooms() multiplies the room's job by the
#room's own modifier, and process_gathering() asks the task list - both are asked from here, so
#the number under a portrait and the number the turn delivers cannot drift apart.
#
#The crit roll the tick makes (get_job_value's second argument) is left out on purpose: this says
#what the work is worth, not what a die said.
func person_yield_at(character, place_kind, place_holder, place_floor = -1):
	if character == null:
		return 0.0
	if place_kind == 'build':
		return builder_yield(character, place_holder, place_floor)
	if place_kind == 'task':
		var made = LocationTasks.production_of(place_holder, character)
		#A quest produces nothing to count, so production_of has nothing to answer with - but a
		#hand on one is still worth a point of progress a turn, which is the figure its card
		#carries. The portrait standing on the card says the same thing the card does.
		return made if made > 0 else LocationTasks.quest_share(place_holder)
	#A bed makes nothing, and the tutor's place in a practice room teaches rather than makes -
	#neither is counted in what the estate gains.
	if !(place_kind in ['work', 'work_upgrade']):
		return 0.0
	var room = get_room(place_holder)
	#And a workshop with nothing on its bench pays nobody however good they are: _spend_room_work
	#finds no recipe to put the work into and the turn sends them to rest instead
	#(game_res.process_rooms). What they would be worth is still worth saying while choosing whom
	#to put here - that is the room card's candidate list, which asks person_yield_in_room
	#directly - but somebody already standing in an idle room adds nothing, and the tooltip on
	#their face is a statement about this turn.
	if idle_workshop(room):
		return 0.0
	return person_yield_in_room(character, room, place_holder)


#Has this room a recipe to work on? Asked in the same order the work itself takes - the room's
#own queue when Ledgers has given it one, the estate's otherwise - because game_res.room_current_craft
#is the same question _spend_room_work asks first. Rooms that are not workshops at all have no
#queue to be empty and answer no.
func idle_workshop(room):
	if room == null:
		return false
	var job = RoomTypes.get_work_job(room.type)
	if job == null or job == '':
		return false
	if !ResourceScripts.game_res.crafting_lists.has(job + '_item'):
		return false
	return ResourceScripts.game_res.room_current_craft(room) == null


#Scaffolding makes nothing, but what a builder puts in is still work worth naming: it is what
#decides when the room opens, and it is counted in the same points the bar across the card
#measures. A repair the estate does for itself is the exception - it advances a flat point a
#turn however many hands are on it (the fixed branch in game_res), so no hand has a share of
#its own to name.
func builder_yield(character, slot_code, floor_index):
	var build = MansionLayout.get_build(floor_data_at(floor_index), slot_code)
	if build == null or build.get('fixed', false):
		return 0.0
	return character.get_job_value('building', false)


#The floor a place sits on. -1 is "the one on screen", which is what the plan's own cells mean;
#the estate grounds are drawn by the local tasks screen while the plan behind it is still on a
#floor of the house, so those cells name their floor.
func floor_data_at(floor_index):
	if floor_index < 0 or floor_index >= layout().floors.size():
		return current_floor()
	return layout().floors[floor_index]


#The room's own work. Three kinds of room are counted somewhere other than by this arithmetic and
#so answer nothing rather than a number nobody will be paid: a practice room trains, a farm is
#worked for what bodies give, and a store room's clerk is paid at the moment a delivery arrives -
#see the three branches game_res.process_rooms() takes before it reaches the multiplication.
func person_yield_in_room(character, room, slot_code):
	if character == null or room == null:
		return 0.0
	for tag in ['practice', 'farm', 'storage']:
		if RoomTypes.has_tag(room.type, tag):
			return 0.0
	#a gathering building works its job through the task list, so it is asked the way the task
	#panel asks it rather than as the room's own craft
	var gather = LocationTasks.gather_entry_for_room(room.type, slot_code)
	if gather != null:
		return LocationTasks.production_of(gather.id, character)
	var job = RoomTypes.get_work_job(room.type)
	if job == null or job == '':
		return 0.0
	return character.get_job_value(job, false) * MansionLayout.craft_modifier(room)


#What that comes to on a tooltip, or "" when this place pays nobody. Written the way the cards
#write it - "Per turn +0.7", one decimal - so the line under a portrait and the line on the card
#it stands in read as the same measurement.
func person_yield_text(character, place_kind, place_holder, place_floor = -1):
	var made = person_yield_at(character, place_kind, place_holder, place_floor)
	if made <= 0:
		return ""
	return "%s +%s" % [tr("MANSIONVIEW_PERTURN"), str(stepify(made, 0.1))]


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

#A refusal about a person says which person - the message keys carry [name] and the pronouns
#that go with it, and only the character can fill those in.
func refusal_text(refusal, char_id):
	var person = get_character(char_id)
	return tr(refusal) if person == null else person.translate(tr(refusal))


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
		input_handler.SystemMessage(refusal_text(refusal, data.char_id))
		return false
	return pick_character(data.char_id, data.from_slot, data.from_kind)


func drop_carried_on(target):
	var data = pick_data()
	if target == null or data == null:
		return false
	var refusal = target.refusal_for(data)
	if refusal != '':
		input_handler.SystemMessage(refusal_text(refusal, data.char_id))
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
		#an empty idle strip is folded away, and a drag is exactly when it is wanted back
		rest_panel.call_deferred("set_carry_open", true)
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
	var climbable = stairs_repaired()
	$FloorSelector/Up.disabled = floor_index() >= layout().floors.size() - 1 or !climbable
	$FloorSelector/Down.disabled = floor_index() <= 0 or !climbable


func update_mode_buttons():
	$TopBar/ModeWork.pressed = mode == 'work'
	$TopBar/ModeSleep.pressed = mode == 'sleep'
	var moving_room = mode == 'rearrange'
	#standalone the plan is the whole screen and carries its own pair; embedded they would be
	#a second set of the buttons already standing in the column on the left
	$TopBar/ModeWork.visible = !moving_room and !embedded
	$TopBar/ModeSleep.visible = showing_plan() and !moving_room and !embedded
	emit_signal("mode_changed", mode)
	$TopBar/RearrangeHint.visible = moving_room
	$TopBar/RearrangeHint.text = tr("MANSIONVIEW_MOVEHINT")
	$ExpelZone.visible = mode == 'sleep' and showing_plan() and !embedded


func change_floor(step):
	go_to_floor(floor_index() + step)


func stairs_repaired():
	return MansionLayout.stairs_repaired(layout())


func stairs_target(step):
	#rotted through until they are repaired, so there is nowhere they lead
	if !stairs_repaired():
		return null
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
	#The grounds are walked out to rather than climbed to, so only a storey is refused.
	var between_storeys = !MansionLayout.is_grounds(layout(), target)
	if between_storeys and MansionLayout.is_grounds(layout(), floor_index()):
		between_storeys = false
	if between_storeys and !stairs_repaired():
		input_handler.SystemMessage(tr("MANSIONVIEW_STAIRSBROKEN"))
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
	#pan is where the field's corner goes, so the content's own offset inside the field comes
	#off it - otherwise the empty margin above the first row is what gets centred.
	var content = grid.content_rect()
	pan = room.position + (room.size - content.size * zoom) / 2 - content.position * zoom
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
	#The limits are about where the rooms end up rather than where the field does, so the
	#content's offset is taken off both ends - see mansion_floor_grid.content_rect().
	var content = grid.content_rect()
	var origin = room.position - content.position * zoom
	var slack = room.size - content.size * zoom
	pan.x = clamp(pan.x, origin.x + min(0.0, slack.x) - PAN_MARGIN,
		origin.x + max(0.0, slack.x) + PAN_MARGIN)
	pan.y = clamp(pan.y, origin.y + min(0.0, slack.y) - PAN_MARGIN,
		origin.y + max(0.0, slack.y) + PAN_MARGIN)


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
	#A sound staircase says everything it has to say on its own face - the up and down buttons
	#are drawn there. A rotted one has to be repaired first, and its card is where that is
	#bought, so it opens until the work is done.
	var sound_stairs = room != null and RoomTypes.has_tag(room.type, 'stairs') and stairs_repaired()
	if sound_stairs and mode != 'rearrange':
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
	#Two turns downstairs, three above - a set piece of work, and its own job either way.
	MansionLayout.start_build(layout(), floor_index(), slot_code, 'repair', null,
		MansionLayout.repair_turns(floor_index()), {}, true,
		MansionLayout.repair_task_name(floor_index()))
	close_card()
	refresh()


func start_upgrade(slot_code, upgrade_code):
	#the card greys the row, but the same rule has to hold wherever the order comes from
	if ResourceScripts.game_res.upgrade_locked(upgrade_code):
		input_handler.SystemMessage(tr("MANSIONVIEW_UPGRADELOCKED"))
		return false
	var check = MansionLayout.can_start_upgrade(layout(), floor_index(), slot_code, upgrade_code)
	if !check.ok:
		input_handler.SystemMessage(tr(check.reason))
		return
	var room = get_room(slot_code)
	var level = MansionLayout.next_upgrade_level(room, upgrade_code)
	var level_data = RoomTypes.get_level_data(upgrade_code, level, room.type)
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
		input_handler.SystemMessage(person.translate(tr("MANSIONVIEW_ERR_AWAY")))
		return false
	if !person.is_worker():
		input_handler.SystemMessage(person.translate(tr("MANSIONVIEW_ERR_NOTWORKER")))
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


#Turns rather than days for a job of a set length: its whole point is that it takes two turns
#or three, and rounding that into days would hide the very number that was chosen.
func build_turns_left(build):
	if build == null or !build.get('fixed', false):
		return null
	for char_id in build_workers(build):
		var person = get_character(char_id)
		#the same question the tick asks - somebody here and willing, not somebody strong
		if person != null and is_present(person) 					and ResourceScripts.game_res.can_work_fixed(person):
			return int(max(1, ceil(build.limit - build.progress)))
	return null


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
		tr(RoomTypes.get_upgrade_name_key(build.target)), int(build.level)]


func build_eta_text(build):
	if build != null and build.get('fixed', false):
		var turns = build_turns_left(build)
		if turns == null:
			return tr("MANSIONVIEW_NOBUILDER")
		return tr("MANSIONVIEW_TURNSLEFT") % turns
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
	#a building gone is places gone, and a job the estate shares has to hear about it
	ResourceScripts.game_res.sync_room_tasks()
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
	$Overlay/RoomDetails.visible = false
	$Overlay/CardCatcher.visible = false
	details_were_shown = false


#The card and the sheet that catches clicks beside it both live on the overlay layer, which
#draws above - and takes mouse input before - anything added to the tree root, a yes/no
#question included.  A CanvasLayer wins that contest even at layer zero; only a negative
#layer loses it, and that would bury the card under the whole screen.  So rather than fight
#the order, the card steps aside while it has a question of its own open.  The catcher is
#the half that actually broke it: it would swallow the click meant for Yes and close the
#card instead of answering.
#
#The panel beside the card is on that same layer and is the wider half of the pair, so it has
#to step aside as well - left up, it stood over the right-hand side of the question and took
#the No button with it, which is how demolition ended up looking like a question with one
#answer.  Whether it was up at all is remembered rather than assumed: a room with nothing to
#say has no panel, and a second call while the card is already aside must not forget the
#first answer.
func set_card_aside(aside):
	if card == null:
		return
	var details = $Overlay/RoomDetails
	if aside and card.visible:
		details_were_shown = details.visible
	card.visible = !aside
	details.visible = details_were_shown and !aside
	$Overlay/CardCatcher.visible = !aside


func catcher_input(event):
	if event is InputEventMouseButton and event.pressed:
		close_card()


