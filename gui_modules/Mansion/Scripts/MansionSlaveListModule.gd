extends Panel

var active_person
onready var SlaveModule = get_parent().SlaveModule
onready var SlaveContainer = $ScrollContainer/VBoxContainer
onready var LocationsList = $TravelsContainerPanel/TravelsContainer/HBoxContainer
onready var LocationsPanel = $TravelsContainerPanel
onready var header = $HBoxContainer
onready var modes = $modes
onready var CharacterContextMenu = $CharacterContextMenu

var populatedlocations = []
var default_locations = ["show_all", "mansion"]
var selected_location = "aliron"
var prev_selected_location = "show_all"
var visible_persons = []

const BUTTON_HEIGHT = 64

const TEX_ROW_NORMAL = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars.png")
const TEX_ROW_HOVER = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_hover.png")
const TEX_ROW_HOVER2 = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_hover2.png")
const TEX_ROW_PRESSED = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_pressed.png")
const TEX_ROW_DISABLED = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_disabled.png")
const TEX_ROW_AVAIL = preload("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_avail.png")
const TEX_TRAVEL_SMALL = preload("res://assets/Textures_v2/MANSION/icon_travel_small.png")
const TEX_NO = preload("res://assets/Textures_v2/MANSION/no.png")
const TEX_YES = preload("res://assets/Textures_v2/MANSION/yes.png")
const TEX_FOOD_STARVING = preload("res://assets/images/iconsitems/food_old.png")

var mode = 'default'
#var mode = 'food'


const JOB_COLOR_DEFAULT = "k_gray"
const JOB_COLOR_REST = "yellow"
const JOB_COLOR_TRAVEL = "factor5"
const JOB_COLOR_SERVICE = "green"
const JOB_COLOR_GATHER = "factor2"
const JOB_COLOR_CRAFT = "aqua"

const JOB_SERVICE_MODS = ['mod_pros', 'mod_service']
const JOB_GATHER_MODS = ['mod_collect', 'mod_hunt', 'mod_fish', 'mod_farm']
const JOB_CRAFT_MODS = ['mod_build', 'mod_cook', 'mod_tailor', 'mod_smith', 'mod_alchemy']

var mass_rule_list = []
var mass_service_list = []
var mass_select_press_effect = false

#sorting is a view-only reorder: character_order keeps the manual (drag) order, so dropping the
#sort - or coming back to the mansion screen - puts every row back where the player left it.
#name and sex sit in every mode, the rest only exist while the default columns are on screen
const SORT_COLUMNS = {
	sex = {node = 'sex_sort', icon = false},
	name = {node = 'name_sort', icon = false},
	occupation = {node = 'job', icon = false},
	exp = {node = 'explabel', icon = false},
	date = {node = 'icon2', icon = true},
	sexact = {node = 'icon3', icon = true},
	train = {node = 'icon4', icon = true},
	type = {node = 'state2', icon = false},
}
const SORT_SEX_ORDER = ['male', 'female', 'futa']
const SORT_CLASS_ORDER = ['master', 'spouse', 'heir', 'servant', 'servant_notax', 'slave_trained', 'slave']
const SORT_COLOR_IDLE = Color(0.878431, 0.878431, 0.878431)
const SORT_COLOR_HOVER = Color(1, 1, 1)

var sort_key = ''
var sort_desc = false
var sort_hovered = ''

func _apply_task_color(job_label, mod_value):
	if typeof(mod_value) != TYPE_STRING or mod_value == "":
		return
	if JOB_SERVICE_MODS.has(mod_value):
		_set_job_label_color_from_key(job_label, JOB_COLOR_SERVICE)
	elif JOB_GATHER_MODS.has(mod_value):
		_set_job_label_color_from_key(job_label, JOB_COLOR_GATHER)
	elif JOB_CRAFT_MODS.has(mod_value):
		_set_job_label_color_from_key(job_label, JOB_COLOR_CRAFT)


func _set_job_label_color_from_key(job_label, color_key):
	if variables.hexcolordict.has(color_key):
		job_label.set("custom_colors/font_color", Color(variables.hexcolordict[color_key]))
	elif variables.hexcolordict.has(JOB_COLOR_DEFAULT):
		job_label.set("custom_colors/font_color", Color(variables.hexcolordict[JOB_COLOR_DEFAULT]))


func _ready():
	input_handler.slave_list_node = self
	globals.connect("slave_added", self, "queue_rebuild")
	globals.connect("task_removed", self, "queue_rebuild")
	globals.connect("hour_tick", self, "update_dislocations")
	globals.connecttexttooltip($BedroomIcon, tr("BEDROOMTOOLTIP"))
	globals.connecttexttooltip($DateIcon, tr("DATETOOLTIP"))
	globals.connecttexttooltip($SexIcon, tr("SEXTOOLTIP"))
	for nd in modes.get_children():
		nd.connect('pressed', self, 'set_mode', [nd.name])
#	for rl in ['lock', 'ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'nudity', 'personality_lock', 'relationship', 'masturbation']:
#		globals.connecttexttooltip(header.get_node('rule_' + rl), tr('WORKRULE%sDESCRIPT' % rl.to_upper()))
#	for rl in ['waitress', 'hostess', 'dancer', 'stripper', 'males', 'females', 'futa', 'petting', 'oral', 'anal', 'pussy', 'group', 'sextoy']:
#		globals.connecttexttooltip(header.get_node('brothel_' + rl), tr('BROTHEL%sDESCRIPT' % rl.to_upper()))
	for rl in ['meat', 'fish', 'grain', 'vegetables', 'bread', 'meatsoup', 'curry', 'friedfish', 'fishcakes']:
		globals.connecttexttooltip(header.get_node('food_' + rl),
			tr('MATERIAL%sDESCRIPT' % rl.to_upper()) + globals.get_food_info_text(Items.materiallist[rl]))
#	globals.connecttexttooltip(header.get_node('food_state'),
#		"[center]" + tr("FOODSTATEHEADER") + "[/center]\n" + tr("FOODSTATEHEADERDESCRIPT"))
	input_handler.connect("mass_select_in_act", self, "off_mass_select_effect")
	input_handler.register_btn_source("slave_2_line", self, "tut_get_slave_line", self, 'tut_get_slave_line_rect')
	input_handler.register_btn_source("daisy_line", self, "tut_get_daisy_line", self, 'tut_get_daisy_line_rect')
	input_handler.register_btn_source("ff_meat", self, "tut_get_ff_meat")
#	input_handler.register_btn_source("ff_vegetables", self, "tut_get_ff_vegetables")#delete with time(29.01.26)
	input_handler.register_btn_source("daisy_waitress", self, "tut_get_daisy_waitress")
	input_handler.register_btn_source("default_mode", self, "tut_get_default_mode")
	input_handler.register_btn_source("service_mode", self, "tut_get_service_mode")
	build_sort_headers()
	get_parent().connect("visibility_changed", self, "on_mansion_shown")


#the mansion screen coming back (from a character panel, the city, a scene) is a fresh start
#for the list, so it always reappears in the order the player arranged themselves
func on_mansion_shown():
	if get_parent().visible:
		reset_sorting()

func tut_get_slave_line():
	for line in SlaveContainer.get_children():
		if line.get_meta('slave').get_stat('slave_class') == 'servant':
			return line
func tut_get_slave_line_rect():
	var check_rect
	for line in SlaveContainer.get_children():
		if line.get_meta('slave').get_stat('slave_class') == 'servant':
			check_rect = line.get_global_rect()
			break
	check_rect.size.x = 300
	return check_rect
func tut_get_daisy_line():
	for line in SlaveContainer.get_children():
		if line.get_meta('slave').get_stat('unique') == 'daisy':
			return line
func tut_get_daisy_line_rect():
	var check_rect
	for line in SlaveContainer.get_children():
		if line.get_meta('slave').get_stat('unique') == 'daisy':
			check_rect = line.get_global_rect()
			break
	check_rect.size.x = 300
	return check_rect

func tut_get_ff_meat():
	return SlaveContainer.get_children()[0].get_node("ff_meat")
#func tut_get_ff_vegetables():
#	return SlaveContainer.get_children()[0].get_node("ff_vegetables")
func tut_get_daisy_waitress():
	var line = tut_get_daisy_line()
	return line.get_node("rule_waitress")

func tut_get_default_mode():
	return modes.get_node("default")
func tut_get_service_mode():
	return modes.get_node("brothel")

func off_mass_select_effect():
	mass_select_press_effect = null

func OpenJobModule(person = null):
	input_handler.ActivateTutorial('TUTORIALLIST4')
	if person != null:
		get_parent().get_node("MansionJobModule2").selected_location = person.get_location()
		get_parent().active_person = person
	get_parent().remove_hovered_person()
	get_parent().mansion_state_set("occupation")
	get_parent().get_node("MansionJobModule2").focus_on_person_task(person)


func OpenInventory(person = null):
	get_parent().remove_hovered_person()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	#gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.inventory
	gui_controller.inventory.set_active_hero(person)
	gui_controller.emit_signal("screen_changed")


func OpenSpells(person = null):
	get_parent().remove_hovered_person()
	gui_controller.spells = input_handler.get_spec_node(input_handler.NODE_SPELLS)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.spells, 0.3)
	gui_controller.spells.show()
	gui_controller.previous_screen = gui_controller.current_screen
	gui_controller.current_screen = gui_controller.spells
	gui_controller.spells.open(person)
	gui_controller.emit_signal("screen_changed")

func update_buttons():
	for i in SlaveContainer.get_children():
		if i.has_meta("slave"):
			i.pressed = (get_parent().active_person == i.get_meta('slave'))

func rebuild():
	#update_button reads this for the luxury rule, and rebuild can run before the first
	#update()/refresh_after_turn() - on a fresh game the queued rebuild is the very first call
	luxury_rooms_taken = globals.calculate_lux_rooms()
	update_dislocations()
#	build_locations_list()
	#LocationsPanel.visible = (get_parent().mansion_state != "sex")
#	$population.visible = LocationsPanel.is_visible()
#	$food_consumption.visible = LocationsPanel.is_visible()
#	$BedroomLimit.visible = !LocationsPanel.is_visible()
#	$BedroomIcon.visible = !LocationsPanel.is_visible()
#	$SexLimit.visible = !LocationsPanel.is_visible()
#	$SexIcon.visible = !LocationsPanel.is_visible()
#	$DateLimit.visible = !LocationsPanel.is_visible()
#	$DateIcon.visible = !LocationsPanel.is_visible()
	$population.text = str(ResourceScripts.game_party.characters.size()) +"/" + str(ResourceScripts.game_res.get_pop_cap())

	$food_consumption.text = str(ResourceScripts.game_party.get_food_consumption()) + "/" + tr("MSLMDAY")
	input_handler.ClearContainer(SlaveContainer)
	mass_rule_list.clear()
	mass_service_list.clear()
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var newbutton = input_handler.DuplicateContainerTemplate(SlaveContainer)
		
		newbutton.get_node("rhand").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("rhand").set_disabled(false)
		newbutton.get_node("lhand").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("lhand").set_disabled(false)
		newbutton.get_node("chest").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("chest").set_disabled(false)
		newbutton.get_node("legs").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("legs").set_disabled(false)
		newbutton.get_node("SpellIcon").connect("pressed", self, 'OpenSpells', [person])
		
		for rl in ['lock', 'ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'nudity', 'personality_lock', 'relationship', 'masturbation']:
			var true_btn = newbutton.get_node('rule_' + rl)
			true_btn.connect('pressed', self, 'toggle_rules', [newbutton, rl])
			if rl != 'luxury':
				globals.connecttexttooltip(newbutton.get_node('rule_' + rl), "[center]"+tr("WORKRULE"+rl.to_upper()) + "[/center]\n" + person.translate(tr('WORKRULE%sDESCRIPT' % rl.to_upper())))
			mass_rule_list.append({
				btn_node = true_btn,
				act_func = 'toggle_rules_mass',
				act_args = [weakref(newbutton), rl]
			})
		for rl in  ['waitress', 'hostess', 'dancer', 'stripper', 'males', 'females', 'futa', 'petting', 'oral', 'anal', 'pussy', 'group', 'sextoy']:
			var true_btn = newbutton.get_node('rule_' + rl)
			true_btn.connect('pressed', self, 'toggle_service', [newbutton, rl])
			globals.connecttexttooltip(newbutton.get_node('rule_' + rl), "[center]" + tr("BROTHEL"+rl.to_upper()) + "[/center]\n" + person.translate(tr('BROTHEL%sDESCRIPT' % rl.to_upper())))
			mass_service_list.append({
				btn_node = true_btn,
				act_func = 'toggle_service_mass',
				act_args = [weakref(newbutton), rl]
			})
		for f_id in ['meat', 'fish', 'grain', 'vegetables', 'bread', 'meatsoup', 'curry', 'friedfish', 'fishcakes']:
			newbutton.get_node('ff_' + f_id).connect('pressed', self, 'press_food', [newbutton, f_id])
		
#		var list = person.get_social_skills()
#		newbutton.get_node("SpellIcon").visible = !list.empty()
		newbutton.get_node("SpellIcon").visible = false
		
		update_row_availability(newbutton, person)

		newbutton.pressed = (get_parent().active_person == person)
		newbutton.set_meta('slave', person)

		# globals.connectslavetooltip(newbutton, person)
		
		newbutton.target_node = self
		newbutton.target_function = 'rebuild'
		newbutton.arraydata = i
		newbutton.parentnodearray = ResourceScripts.game_party.character_order

		newbutton.connect('pressed', get_parent(), 'set_active_person', [person])
		newbutton.connect('gui_input', self, 'double_clicked', [newbutton])
		newbutton.connect('mouse_entered', get_parent(), 'set_hovered_person', [newbutton, person])
		newbutton.connect('mouse_exited_custom', get_parent(), 'remove_hovered_person')
		
		newbutton.get_node("job").connect("pressed", self, 'OpenJobModule', [person])
#		newbutton.get_node("job").set_disabled(false)
#		newbutton.get_node("job").disabled = person.travel.location == "travel" || person.is_on_quest()
		
		match get_parent().mansion_state:
			"skill":
				build_for_skills(person, newbutton)
				newbutton.get_node("job").set_disabled(true)
				newbutton.get_node("job").set_mouse_filter(MOUSE_FILTER_IGNORE)
			"default":
				pass
			"sex":
				build_for_sex(person, newbutton)
		var pos = self.rect_size
		$TravelsContainerPanel.rect_position.y = pos.y - 50
		update_button(newbutton)
	apply_sorting()
	rows_signature = build_rows_signature()
	show_location_characters()
	update_description()
	update_header()


func update_row_availability(newbutton, person):
	if person.is_on_quest():
		newbutton.disabled = true
		newbutton.get_node("rhand").set_disabled(true)
		newbutton.get_node("lhand").set_disabled(true)
		newbutton.get_node("chest").set_disabled(true)
		newbutton.get_node("legs").set_disabled(true)
	else:
		newbutton.disabled = false
		newbutton.texture_normal = TEX_ROW_NORMAL
		newbutton.texture_hover = TEX_ROW_HOVER
		newbutton.get_node("rhand").set_disabled(false)
		newbutton.get_node("lhand").set_disabled(false)
		newbutton.get_node("chest").set_disabled(false)
		newbutton.get_node("legs").set_disabled(false)


var rows_signature = ""
var rebuild_queued = false


#task_removed is emitted once per deleted task, and ending a turn from the job panel
#deletes every unstaffed temporal job in one go - a dozen signals, a dozen full rebuilds,
#all inside the same frame. Fold a burst into a single rebuild.
#call_deferred is the engine's own batching primitive for this: the message queue is
#flushed once at the end of the frame, so the guard collapses N signals into one rebuild
#that still lands before anything is drawn, and there is no per-frame cost while idle.
#Direct rebuild() callers are untouched and stay synchronous.
func queue_rebuild():
	if rebuild_queued:
		return
	rebuild_queued = true
	call_deferred("flush_queued_rebuild")


func flush_queued_rebuild():
	rebuild_queued = false
	rebuild()


#covers everything that changes how a row is built: the roster, the mansion state, and
#the list mode - which mansion_state does not always imply, since set_mode changes it alone
func build_rows_signature():
	var res = str(get_parent().mansion_state) + "/" + str(mode)
	for id in ResourceScripts.game_party.character_order:
		res += "|" + str(id)
	return res


#post-turn refresh: a full rebuild recreates ~40 nodes and dozens of tooltips per character,
#which is the bulk of the finish turn cost. Rows only need recreating when the roster
#(or the panel mode that changes how a row is built) actually changed
func refresh_after_turn(spread = false):
	if spread: #always a coroutine when asked for, so callers can yield on 'completed'
		yield(get_tree(), 'idle_frame')
	#the signature already encodes mansion_state and mode, so testing it alone is strictly
	#stronger than the old "not in default mode -> always rebuild" clause, which forced a
	#full unsliced rebuild every single turn ended from the job or craft panel
	if build_rows_signature() != rows_signature:
		rebuild()
		return
	luxury_rooms_taken = globals.calculate_lux_rooms()
	update_dislocations()
	if spread:
		yield(get_tree(), 'idle_frame')
	var slice = OS.get_ticks_msec()
	for i in SlaveContainer.get_children():
		#a rebuild landing between chunks frees these nodes out from under us
		if !is_instance_valid(i) or i.is_queued_for_deletion() or !i.has_meta('slave'):
			continue
		update_row_availability(i, i.get_meta('slave'))
		update_button(i)
		if spread and OS.get_ticks_msec() - slice >= variables.turn_frame_budget_msec:
			yield(get_tree(), 'idle_frame')
			slice = OS.get_ticks_msec()
	if spread:
		yield(get_tree(), 'idle_frame')
	apply_sorting() #occupations and exp moved on, so the sorted view has to follow
	show_location_characters()
	update_description()
	update_header()


func double_clicked(event, button):
	if !(event is InputEventMouseButton):
		return
	if event.button_index == BUTTON_RIGHT and event.pressed and !event.doubleclick:
		if button.disabled:
			return
#		event.accept_event()
		_show_character_context_menu(button)
		return
	if event.button_index == BUTTON_LEFT and event.doubleclick:
		if button.disabled:
			return
		get_parent().set_active_person(button.get_meta("slave"))
		get_parent().mansion_state = "char_info"


func _show_character_context_menu(button):
	if CharacterContextMenu == null:
		return
	var person = button.get_meta("slave")
	if person == null:
		return
	var actions = [
		{
			"label": tr("MSLMCONTEXT_OPEN"),
			"callback": funcref(self, "_context_open_person"),
			"args": [person]
		},
		{
			"label": tr("MSLMCONTEXT_INVENTORY"),
			"callback": funcref(self, "_context_open_with_inventory"),
			"args": [person]
		}
	]
	CharacterContextMenu.open_with_actions(person.get_short_name(), actions, get_viewport().get_mouse_position())


func _context_open_person(person):
	if get_parent() == null or !is_instance_valid(get_parent()):
		return
	get_parent().set_active_person(person)
	get_parent().mansion_state = "char_info"


func _context_open_with_inventory(person):
	get_parent().set_active_person(person)
	OpenInventory(person)


var locations_signature = ""

#runs on every hour_tick. The button list only has to be rebuilt when the set of populated
#locations actually changed, which is rare - otherwise just resync the pressed state
func update_dislocations():
	var temparray = []
	var has_training = false
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in ['mansion','travel'] && !temparray.has(person.travel.location):
			temparray.append(person.travel.location)
		if !has_training and person.get_work() == 'learning':
			has_training = true
	temparray.sort()
	populatedlocations = temparray
	var new_signature = str(has_training)
	for loca in temparray:
		new_signature += "|" + str(loca)
	if new_signature == locations_signature and LocationsList.get_child_count() > 1:
		update_location_buttons()
		return
	locations_signature = new_signature
	build_locations_list(has_training)


func build_locations_list(has_training = null):
	input_handler.ClearContainer(LocationsList)
	var newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
	newbutton.set_meta("location", "show_all")
	newbutton.text = tr("MSLMSHOWALL")
	newbutton.connect("pressed", self, "show_location_characters", [newbutton])
	var newseparator = $TravelsContainerPanel/VSeparator.duplicate()
	LocationsList.add_child(newseparator)
	newseparator.visible = true
	newseparator.rect_position.y = 100
	var sorted_locations = sort_locations()
	for loca in sorted_locations:
		if loca == null:
			continue
		newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
		if loca == 'aliron':
			newbutton.text = tr("MSLMMANSION")
		else:
			newbutton.text = ResourceScripts.world_gen.get_location_from_code(loca).name
		newbutton.set_meta("location", loca)
		newbutton.connect("pressed", self, "show_location_characters", [newbutton])
		newseparator = $TravelsContainerPanel/VSeparator.duplicate()
		LocationsList.add_child(newseparator)
		newseparator.visible = true
		newseparator.rect_position.y = 100
	
	var f = has_training
	if f == null: #called directly - work it out ourselves
		f = false
		for i in ResourceScripts.game_party.character_order:
			var person = ResourceScripts.game_party.characters[i]
			if person.get_work() == 'learning':
				f = true
				break

	if f:
		newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
		newbutton.text = "Training"
		newbutton.set_meta("location", 'training')
		newbutton.connect("pressed", self, "show_location_characters", [newbutton])
	else:
		LocationsList.get_children().back().queue_free()
	
	update_location_buttons()


func sort_locations():
	var capitals = []
	var settlements = []
	var dungeons = []
	var quest_locations = []
	var locations_array = populatedlocations
	for loca in locations_array:
		if loca == null:
			locations_array.erase(null)
			continue
		if loca in ["mansion", "travel", "show_all"]: continue
		match ResourceScripts.world_gen.get_location_from_code(loca).type:
			"capital":
				capitals.append(loca)
			"settlement":
				settlements.append(loca)
			"dungeon","encounter":
				dungeons.append(loca)
			"quest_location":
				quest_locations.append(loca)
	return capitals + settlements + dungeons + quest_locations


func build_for_sex(person, newbutton):
	var limit = calculate_sex_limits()
	var sex_participants = get_parent().sex_participants
	
	newbutton.texture_disabled = TEX_ROW_DISABLED
	
	if sex_participants.has(person):
		newbutton.pressed = true
	else:
		newbutton.pressed = false
		if sex_participants.size() >= limit:
			newbutton.disabled = true


func update_description():
	var sex_participants = get_parent().sex_participants
	$BedroomLimit.text = str(sex_participants.size()) +  '/' + str(calculate_sex_limits())
	$DateLimit.text = str(ResourceScripts.game_globals.weekly_dates_left) + "/" + str(ResourceScripts.game_globals.weekly_dates_max)
	$SexLimit.text = str(ResourceScripts.game_globals.weekly_sex_left) + "/" + str(ResourceScripts.game_globals.weekly_sex_max)


func calculate_sex_limits():
	if get_parent() != null && get_parent().get("in_test_mode") == true:
		return ResourceScripts.game_party.character_order.size()
	var slavelimit = 2
	if ResourceScripts.game_res.upgrades.has('master_bedroom'):
		slavelimit += ResourceScripts.game_res.upgrades.master_bedroom
	return slavelimit


func show_location_characters(button = null):
	if button != null:
		prev_selected_location = selected_location
		selected_location = button.get_meta("location")
#	update_location_buttons()
	visible_persons.clear()
	for person in SlaveContainer.get_children():
		if !person.has_meta('slave'):
			continue
		var person_reference = person.get_meta("slave")
		if person_reference == null:
			continue
		if selected_location == 'training':
			if person_reference.get_work() == 'learning':
				person.visible = true
			else:
				person.visible = false
		else:
			if person_reference.get_work() == 'learning':
				person.visible = false
				continue
#			if get_parent().mansion_state != 'sex': 
#				build_for_default(person_reference, person)
			var person_location = person_reference.travel.location
			if selected_location == "show_all":
				person.visible = true
			elif selected_location == "mansion" || selected_location == "aliron":
				if person_location == "mansion": person_location = "aliron"
				person.visible = person_location == "aliron"
			else:
				person.visible = (person_location == selected_location)
		if person.is_visible():
			visible_persons.append(person)
			if prev_selected_location != selected_location:
				for visible_person in visible_persons:
					visible_person.pressed = false
				get_parent().active_person = null
				if get_parent().mansion_state in ["default", "skills"]:
					get_parent().set_active_person(visible_persons[0].get_meta("slave"))
		if get_parent().mansion_state == "sex":
			person.visible = person_reference.travel.location == ResourceScripts.game_world.mansion_location
	
	if visible_persons.size() < 1 and selected_location != "show_all":
		selected_location = "show_all"
		show_location_characters()
	update_location_buttons()


func update_location_buttons():
	for i in LocationsList.get_children():
		if i == LocationsList.get_child(LocationsList.get_children().size()-1) || !i.has_meta('location'):
			continue
		i.pressed = selected_location == i.get_meta("location")


func build_for_skills(person, newbutton):
	if person == get_parent().skill_source:
		newbutton.texture_disabled = TEX_ROW_PRESSED
		newbutton.disabled = true
	if !person in get_parent().chars_for_skill:
		newbutton.texture_disabled = TEX_ROW_DISABLED
		newbutton.disabled = true
	else:
		newbutton.texture_normal = TEX_ROW_AVAIL
		newbutton.texture_hover = TEX_ROW_HOVER2
	newbutton.get_node("job").disabled = true


var training_types = {
	nothing = 'No Training',
	slave_training = "Slave Training",
	slave_training_workforce = "Slave Training",
	slave_training_warrior = "Slave Training",
	slave_training_service = "Slave Training",
	academy = 'Academy',
	heir = 'Heir Education',
}


func remove_from_travel(person):
	get_parent().persons_for_travel.erase(person)
	rebuild()

var luxury_rooms_taken = 0
func update():
	luxury_rooms_taken = globals.calculate_lux_rooms()
	update_dislocations()
#	get_parent().NavModule.build_accessible_locations()
	for i in $ScrollContainer/VBoxContainer.get_children():
		update_button(i)
	apply_sorting()
	update_description()
	update_header()
	match_mode()
	if mode == 'rules':
		input_handler.start_mass_select(self, mass_rule_list)
	elif mode == 'brothel':
		input_handler.start_mass_select(self, mass_service_list)
	else:
		input_handler.stop_mass_select()


func update_button(newbutton, t_mode = mode):
	var person_location
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')
	if person.get_work() == 'learning':
		t_mode = 'training'
		newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
		newbutton.get_node('progress').max_value = variables.tutduration
	newbutton.get_node("icon").texture = person.get_icon_small()
	newbutton.get_node("name").text = person.get_short_name()
	if person.is_master() or person.is_unique():
		newbutton.get_node("name").set("custom_colors/font_color", variables.hexcolordict.unique)
	newbutton.get_node("sex").texture = images.get_icon(person.get_stat('sex'))
	var job_label = newbutton.get_node("job/Label")
	_set_job_label_color_from_key(job_label, JOB_COLOR_DEFAULT)
	var work_code = person.get_work()
	var is_traveling = person.travel.location == "travel" || person.check_location('travel') || work_code == 'travel'
	
	newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
	newbutton.get_node("stats/hp").value = person.hp
	newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
	newbutton.get_node("stats/mp").value = person.mp
	newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
	newbutton.get_node("explabel").text = str(floor(person.get_stat('base_exp')))
	if is_traveling:
		job_label.text = tr("TASKTRAVEL")
		_set_job_label_color_from_key(job_label, JOB_COLOR_TRAVEL)
	elif work_code == '' or !person.is_avaliable():
		if person.is_on_quest():
			var time_left = int(person.get_quest_time_remains())
			if time_left > 0:
				var time_left_string = ''
				if time_left == 1:
					time_left = 4 - ResourceScripts.game_globals.hour
					time_left_string = str(time_left) + " turns"
				else:
					time_left_string = str(time_left) + " d."
				job_label.text = "On Quest: " + time_left_string
			else:
				job_label.text = person.get_unaval_string()
		else:
			job_label.text = tr("TASKREST")
			_set_job_label_color_from_key(job_label, JOB_COLOR_REST)
	elif work_code == 'learning':
		newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
#	elif work_code == 'special':
#		var task = person.find_worktask()
#		job_label.text = tr("TASKMISSION")
	else:
		var task = person.find_worktask()
		if work_code == 'crafting':
			var predict_task_id = person.predict_active_task()
			if predict_task_id == null:
				job_label.text = tr('TASKREST')
			else:
				var predict_task = ResourceScripts.game_res.tasks_progresses[predict_task_id]
				var predict_task_cat = predict_task.job
				if predict_task_cat != 'building':
					predict_task_cat = predict_task_cat.trim_suffix('_item')
					predict_task_cat = predict_task_cat.trim_suffix('_material')
				var predict_job = tasks.tasklist[predict_task_cat]
				job_label.text = tr(predict_job.name)
				if predict_job.has('mod'):
					_apply_task_color(job_label, predict_job.mod)
		else:
			job_label.text = tr(task.name)
			if task.has('mod'):
				_apply_task_color(job_label, task.mod)
	
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(1,1,1))
	# if !person.check_location('Aliron'):
	#location
	if !person.is_avaliable():
		newbutton.get_node('LocIcon').texture = null
		person_location = null
	elif person.check_location('travel'):
		newbutton.get_node('LocIcon').texture = TEX_TRAVEL_SMALL
		newbutton.get_node('LocIcon').hint_tooltip = tr("MSLMRELOC") + ": " + tr("MSLMRE") + " " + str(ceil(person.travel.travel_time / person.travel_per_tick())) + tr("MSLMTURN") + ". "
		person_location = null
		
	elif person.check_location('aliron') || person.get_location() == "mansion": # Temporary
		person_location = "aliron"
	else:
		### Temporary
		if person.get_location() == "mansion":
			person_location = "aliron"
		else:
			person_location = person.get_location()

	if person_location != null:
		var ploc = ResourceScripts.world_gen.get_location_from_code(person_location)
		if ploc != null: 
			match ploc.type:
				'settlement':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_village')
				'dungeon':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_dungeon')
				'capital':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_city')
				'quest_location', 'encounter':
					newbutton.get_node('LocIcon').texture = images.get_icon('travel_event')
			newbutton.get_node('LocIcon').hint_tooltip = tr(ploc.name)
			#newbutton.get_node('Location').text = tr(ploc.name)
	#job
	var job_button = newbutton.get_node("job")
	job_button.disabled = false
	if !person.is_worker(): #for conditions for work and combat are the same
		job_button.disabled = true
		_set_job_label_color_from_key(job_label, 'red')
		if person.get_stat('slave_class') == 'slave':
			globals.connecttexttooltip(job_button, person.translate(tr('TRAINNOTRAINER')))
		else:
			globals.connecttexttooltip(job_button, person.translate(tr('TRAINNOWORKTRAIT')))
	elif person.travel.location == "travel" || person.is_on_quest():
		job_button.disabled = true
	#class
	newbutton.get_node("state").texture = person.get_class_icon()
	#gear
	for slot in ['rhand', 'lhand', 'chest', 'legs']:
		var titem = person.equipment.gear[slot]
		if titem == null:
			newbutton.get_node(slot + "/icon").texture = null
			newbutton.get_node(slot + "/quality_color").hide()
		else:
			var item = ResourceScripts.game_res.items[titem]
			item.set_icon(newbutton.get_node(slot + "/icon"))
			if item.quality != "":
				newbutton.get_node(slot + "/quality_color").show()
				newbutton.get_node(slot + "/quality_color").texture = variables.quality_colors[item.quality]
			else:
				newbutton.get_node(slot + "/quality_color").hide()
			globals.connectitemtooltip_v2(newbutton.get_node(slot), item)
	
	#checks
	if ResourceScripts.game_globals.weekly_dates_left <= 0:
		newbutton.get_node("DateIcon").texture = TEX_NO
	elif !person.has_status('relation'):
		newbutton.get_node("DateIcon").texture = TEX_NO
	elif person.tags.has("no_date_day"):
		newbutton.get_node("DateIcon").texture = TEX_NO
	else:
		newbutton.get_node("DateIcon").texture = TEX_YES
	if ResourceScripts.game_globals.weekly_sex_left <= 0:
		newbutton.get_node("SexIcon").texture = TEX_NO
	elif person.has_status('no_sex'):
		newbutton.get_node("SexIcon").texture = TEX_NO
	else:
		newbutton.get_node("SexIcon").texture = TEX_YES
	if !person.can_be_trained():
		newbutton.get_node("TrainIcon").texture = TEX_NO
	else:
		newbutton.get_node("TrainIcon").texture = TEX_YES
	
	#rules
	for rl in ['lock', 'ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'nudity', 'personality_lock', 'relationship', 'masturbation']:
		newbutton.get_node('rule_' + rl).pressed = person.check_work_rule(rl)
#	newbutton.get_node('rule_luxury').visible = !person.is_master()
	newbutton.get_node('rule_luxury').disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) and !person.check_work_rule("luxury") or person.is_master()
	var text = "[center]"+tr("WORKRULELUXURY") + "[/center]\n" + person.translate(tr('WORKRULELUXURYDESCRIPT'))
	text += "\n"
	text += "Rooms used %d/%d" % [luxury_rooms_taken, ResourceScripts.game_res.upgrades.luxury_rooms + 1]
	globals.connecttexttooltip(newbutton.get_node('rule_luxury'), text)
	newbutton.get_node('rule_relationship').disabled = person.is_master()
	newbutton.get_node('rule_nudity').disabled = !person.has_status('sexservice')
	newbutton.get_node('rule_contraceptive').disabled = person.check_trait('undead')
	newbutton.get_node('rule_ration').disabled = person.check_trait('undead')
	#services
	for rl in ['petting', 'oral', 'anal', 'pussy', 'group', 'sextoy']:
		newbutton.get_node('rule_' + rl).pressed = person.check_brothel_rule(rl)
		if person.is_master() == false:
			if !person.has_status(tasks.gold_tasks_data[rl].req_training):
				if person.get_stat('slave_class') == 'slave':
					newbutton.get_node('rule_' + rl).disabled = true
	for rl in ['waitress', 'hostess', 'dancer', 'stripper', 'males', 'females', 'futa']:
		newbutton.get_node('rule_' + rl).pressed = person.check_brothel_rule(rl)
	#food. the per-character tooltips need a fresh demand, which is expensive, so they are
	#only built while the food column is actually on screen
	if t_mode == 'food':
		person.get_food_demand()
	for f_id in ['meat', 'fish', 'grain', 'vegetables', 'bread', 'meatsoup', 'curry', 'friedfish', 'fishcakes']:
		var allowed = person.get_filter_for_food(f_id)
		var label = newbutton.get_node('ff_%s/Label' % f_id)
		label.text = tr("FOODFILTERALLOWED" if allowed else "FOODFILTERFORBIDDEN")
		label.set("custom_colors/font_color", Color(variables.hexcolordict['green' if allowed else 'gray']))
		if t_mode == 'food':
			globals.connectmaterialtooltip(newbutton.get_node('ff_' + f_id), Items.materiallist[f_id],
				globals.get_food_char_text(Items.materiallist[f_id], person))
	#filter columns
	for nd in newbutton.get_children():
		nd.visible = nd.is_in_group(t_mode)
	
	#postprocess
	if person.is_master():
		newbutton.get_node('DateIcon').visible = false
		newbutton.get_node('rule_luxury').visible = false
		newbutton.get_node('rule_relationship').visible = false
		newbutton.get_node('rule_constrain').visible = false
	if person.check_trait('undead'):
		newbutton.get_node('rule_contraceptive').visible = false
		newbutton.get_node('rule_ration').visible = false
	update_food_icon(newbutton, person)


#the food column shows what the character is running on right now - the item they last ate,
#tinted red when it was below their demand, or the starvation icon when they went without.
#the cell frame always keeps its place in the row; states with no meal leave it empty
func update_food_icon(newbutton, person):
	var node = newbutton.get_node('FoodIcon')
	if !node.visible:
		return
	var icon = node.get_node('icon')
	var state = person.food.get_state()
	icon.visible = true
	icon.modulate = Color(1, 1, 1)
	match state.state:
		'undead', 'none':
			icon.visible = false
		'starving':
			icon.texture = TEX_FOOD_STARVING
		'poor':
			icon.texture = Items.materiallist[state.meal].icon
			icon.modulate = Color(1, 0.5, 0.5)
		_:
			icon.texture = Items.materiallist[state.meal].icon
	globals.connecttexttooltip(node, globals.get_food_state_tooltip(person))


func set_mode(newmode):
	mode = newmode
	update()


func update_header ():
	for nd in header.get_children():
		nd.visible = nd.is_in_group(mode)


### Sorting ###

func build_sort_headers():
	for key in SORT_COLUMNS:
		var nd = header.get_node(SORT_COLUMNS[key].node)
		nd.mouse_filter = MOUSE_FILTER_STOP
		nd.mouse_default_cursor_shape = CURSOR_POINTING_HAND
		nd.connect('gui_input', self, 'sort_header_input', [key])
		nd.connect('mouse_entered', self, 'sort_header_hover', [key, true])
		nd.connect('mouse_exited', self, 'sort_header_hover', [key, false])
		if SORT_COLUMNS[key].icon: #those already carry a tooltip explaining the column
			nd.hint_tooltip = tr(nd.hint_tooltip) + "\n" + tr("MSLMSORTHINT")
		else:
			globals.connecttexttooltip(nd, tr("MSLMSORTHINT"))
	update_sort_headers()


#a column cycles through ascending, descending and back to the order the player set by hand
func sort_header_input(event, key):
	if !(event is InputEventMouseButton) or event.button_index != BUTTON_LEFT or !event.pressed:
		return
	if sort_key != key:
		sort_key = key
		sort_desc = false
	elif !sort_desc:
		sort_desc = true
	else:
		sort_key = ''
		sort_desc = false
	apply_sorting()
	update_sort_headers()


func sort_header_hover(key, hovered):
	if hovered:
		sort_hovered = key
	elif sort_hovered == key:
		sort_hovered = ''
	update_sort_header(key)


func update_sort_headers():
	if header == null:
		return
	for key in SORT_COLUMNS:
		update_sort_header(key)


func update_sort_header(key):
	var nd = header.get_node(SORT_COLUMNS[key].node)
	var color = SORT_COLOR_IDLE
	if sort_key == key:
		color = Color(variables.hexcolordict['factor2' if sort_desc else 'k_yellow'])
	elif sort_hovered == key:
		color = SORT_COLOR_HOVER
	if SORT_COLUMNS[key].icon:
		nd.modulate = color
	else:
		nd.set("custom_colors/font_color", color)


#rows are only moved around, never the array behind them. dragging a row would write the visual
#position back into character_order, so it stays off while a column is sorted
func apply_sorting():
	if SlaveContainer == null:
		return
	var entries = []
	for nd in SlaveContainer.get_children():
		if !nd.has_meta('slave'):
			continue
		nd.drag_enabled = sort_key == ''
		entries.append({row = nd, base = get_row_base_index(nd), value = null})
	if sort_key == '':
		entries.sort_custom(self, 'compare_base_rows')
	else:
		for e in entries:
			e.value = get_sort_value(e.row, sort_key)
		entries.sort_custom(self, 'compare_sort_rows')
	for i in entries.size():
		SlaveContainer.move_child(entries[i].row, i)


func reset_sorting():
	sort_key = ''
	sort_desc = false
	sort_hovered = ''
	apply_sorting()
	update_sort_headers()


func get_row_base_index(row):
	var idx = ResourceScripts.game_party.character_order.find(row.arraydata)
	return idx if idx >= 0 else ResourceScripts.game_party.character_order.size()


func compare_base_rows(a, b):
	return a.base < b.base


#ties keep the manual order, so rows with the same value never shuffle between sorts
func compare_sort_rows(a, b):
	if a.value != b.value:
		if sort_desc:
			return a.value > b.value
		return a.value < b.value
	return a.base < b.base


#occupation and the availability marks are read back from the row: they are the strings and
#icons update_button just worked out, and recomputing them here would only duplicate that logic
func get_sort_value(row, key):
	var person = row.get_meta('slave')
	match key:
		'sex':
			return get_sort_rank(SORT_SEX_ORDER, person.get_stat('sex'))
		'name':
			return person.get_short_name().to_lower()
		'occupation':
			return row.get_node("job/Label").text.to_lower()
		'exp':
			return floor(person.get_stat('base_exp'))
		'date':
			return 0 if row.get_node("DateIcon").texture == TEX_YES else 1
		'sexact':
			return 0 if row.get_node("SexIcon").texture == TEX_YES else 1
		'train':
			return 0 if row.get_node("TrainIcon").texture == TEX_YES else 1
		'type':
			return get_sort_rank(SORT_CLASS_ORDER, person.get_stat('slave_class'))
	return 0


func get_sort_rank(order, value):
	var idx = order.find(value)
	return idx if idx >= 0 else order.size()


func toggle_rules(newbutton, code):
	var person = newbutton.get_meta('slave')
	var cvalue = person.check_work_rule(code)
	var nvalue = !cvalue
	person.set_work_rule(code, nvalue)
	update()
#	update_button(newbutton)

func toggle_rules_mass(newbutton_ref, code):
	var newbutton = newbutton_ref.get_ref()
	var true_btn = newbutton.get_node('rule_' + code)
	if (true_btn.disabled
			or (mass_select_press_effect != null and true_btn.pressed == mass_select_press_effect)
		):
		return
	toggle_rules(newbutton, code)
	if mass_select_press_effect == null:
		mass_select_press_effect = true_btn.pressed


func toggle_service(newbutton, code):
	var person = newbutton.get_meta('slave')
	var cvalue = person.check_brothel_rule(code)
	var nvalue = !cvalue
	person.set_brothel_rule(code, nvalue)
	update_button(newbutton)

func toggle_service_mass(newbutton_ref, code):
	var newbutton = newbutton_ref.get_ref()
	var true_btn = newbutton.get_node('rule_' + code)
	if (true_btn.disabled
			or (mass_select_press_effect != null and true_btn.pressed == mass_select_press_effect)
		):
		return
	toggle_service(newbutton, code)
	if mass_select_press_effect == null:
		mass_select_press_effect = true_btn.pressed


func press_food(newbutton, code):
	var person = newbutton.get_meta('slave')
	person.toggle_food(code)
	update_button(newbutton)


func match_mode():
	for nd in modes.get_children():
		nd.pressed = (mode == nd.name)
