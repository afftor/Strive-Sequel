extends Panel

var active_person
onready var SlaveModule = get_parent().SlaveModule
onready var SlaveContainer = $ScrollContainer/VBoxContainer
onready var LocationsList = $TravelsContainerPanel/TravelsContainer/HBoxContainer
onready var LocationsPanel = $TravelsContainerPanel

var populatedlocations = []
var default_locations = ["show_all", "mansion"]
var selected_location = "mansion"
var prev_selected_location = "show_all"
var visible_persons = []

const BUTTON_HEIGHT = 64



const JOB_COLOR_DEFAULT = "k_gray"
const JOB_COLOR_REST = "yellow"
const JOB_COLOR_TRAVEL = "factor5"
const JOB_COLOR_SERVICE = "green"
const JOB_COLOR_GATHER = "factor2"
const JOB_COLOR_CRAFT = "aqua"

const JOB_SERVICE_MODS = ['mod_pros', 'mod_service']
const JOB_GATHER_MODS = ['mod_collect', 'mod_hunt', 'mod_fish', 'mod_farm']
const JOB_CRAFT_MODS = ['mod_build', 'mod_cook', 'mod_tailor', 'mod_smith', 'mod_alchemy']

func _apply_task_color(job_label, task_data):
	if typeof(task_data) != TYPE_DICTIONARY:
		return
	if !task_data.has("mod"):
		return
	var mod_value = task_data.mod
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
	globals.connect("slave_added", self, "rebuild")
	globals.connect("task_removed", self, "rebuild")
	globals.connect("hour_tick", self, "update_dislocations")
	globals.connecttexttooltip($BedroomIcon, tr("BEDROOMTOOLTIP"))
	globals.connecttexttooltip($DateIcon, tr("DATETOOLTIP"))
	globals.connecttexttooltip($SexIcon, tr("SEXTOOLTIP"))

func OpenJobModule(person = null):
	input_handler.ActivateTutorial('TUTORIALLIST4')
	if person != null:
		get_parent().get_node("MansionJobModule2").selected_location = person.get_location()
	get_parent().remove_hovered_person()
	get_parent().mansion_state_set("occupation")
#	get_parent().get_node("MansionJobModule2").show()
#	get_parent().get_node("MansionJobModule2").rebuild()
#	ResourceScripts.core_animations.UnfadeAnimation(get_parent().get_node("MansionJobModule2"), 0.3)
#	gui_controller.clock.hide()
#	ResourceScripts.core_animations.FadeAnimation(gui_controller.clock, 0.3)
	#yield(get_tree().create_timer(0.3), 'timeout')


func OpenInventory(person = null):
	get_parent().remove_hovered_person()
	gui_controller.inventory = input_handler.get_spec_node(input_handler.NODE_INVENTORY_NEW)
	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.inventory, 0.3)
	gui_controller.inventory.show()
	gui_controller.inventory.get_node("GridContainer/GearButton").set_pressed(true)
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


func rebuild():
	update_dislocations()
#	build_locations_list()
	LocationsPanel.visible = (get_parent().mansion_state != "sex")
	$population.visible = LocationsPanel.is_visible()
	$food_consumption.visible = LocationsPanel.is_visible()
	$BedroomLimit.visible = !LocationsPanel.is_visible()
	$BedroomIcon.visible = !LocationsPanel.is_visible()
	$SexLimit.visible = !LocationsPanel.is_visible()
	$SexIcon.visible = !LocationsPanel.is_visible()
	$DateLimit.visible = !LocationsPanel.is_visible()
	$DateIcon.visible = !LocationsPanel.is_visible()
	$population.text = str(ResourceScripts.game_party.characters.size()) +"/" + str(ResourceScripts.game_res.get_pop_cap())

	$food_consumption.text = str(ResourceScripts.game_party.get_food_consumption()) + "/" + tr("MSLMDAY")
	input_handler.ClearContainer(SlaveContainer)
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var newbutton = input_handler.DuplicateContainerTemplate(SlaveContainer)
		
		newbutton.get_node("rhand").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("rhand").set_disabled(false)
		newbutton.get_node("tool").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("tool").set_disabled(false)
		newbutton.get_node("chest").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("chest").set_disabled(false)
		newbutton.get_node("legs").connect("pressed", self, 'OpenInventory', [person])
		newbutton.get_node("legs").set_disabled(false)
		newbutton.get_node("SpellIcon").connect("pressed", self, 'OpenSpells', [person])
		var list = person.get_social_skills()
#		newbutton.get_node("SpellIcon").visible = !list.empty()
		newbutton.get_node("SpellIcon").visible = false
		
		if person.is_on_quest():
			newbutton.disabled = true
			newbutton.get_node("rhand").set_disabled(true)
			newbutton.get_node("tool").set_disabled(true)
			newbutton.get_node("chest").set_disabled(true)
			newbutton.get_node("legs").set_disabled(true)
		else:
			newbutton.disabled = false
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_hover.png")

		newbutton.pressed = (get_parent().active_person == person)
		newbutton.set_meta('slave', person)

		# globals.connectslavetooltip(newbutton, person)
		update_button(newbutton)
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
				build_for_default(person, newbutton)
			"sex":
				build_sex_selection(person, newbutton)
		var pos = self.rect_size
		$TravelsContainerPanel.rect_position.y = pos.y - 50
	show_location_characters()
	update_description()


func double_clicked(event, button):
	if event is InputEventMouseButton and event.doubleclick:
		# if get_parent().active_person == null:
		if button.disabled:
			return
		get_parent().set_active_person(button.get_meta("slave"))
		get_parent().mansion_state = "char_info"

#obsolete
func build_for_ocupation(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	if person.travel.location == "travel":
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true


func build_for_default(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('loctext').visible = false
	
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('rhand').visible = true
	newbutton.get_node('tool').visible = true
	newbutton.get_node('chest').visible = true
	newbutton.get_node('legs').visible = true
	newbutton.get_node('DateIcon').visible = !person.is_master()
	newbutton.get_node('SexIcon').visible = true
	newbutton.get_node('TrainIcon').visible = person.training.enable
	newbutton.get_node('LocIcon').visible = true
	newbutton.get_node('state').visible = true


func update_dislocations():
	var temparray = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in ['mansion','travel'] && !temparray.has(person.travel.location):
			temparray.append(person.travel.location)
	temparray.sort()
	populatedlocations = temparray
	build_locations_list()


func build_locations_list():
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
	
	var f = false
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


func build_sex_selection(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('loctext').visible = false
	
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('rhand').visible = true
	newbutton.get_node('tool').visible = true
	newbutton.get_node('chest').visible = true
	newbutton.get_node('legs').visible = true
	newbutton.get_node('DateIcon').visible = !person.is_master()
	newbutton.get_node('SexIcon').visible = true
	newbutton.get_node('TrainIcon').visible = person.training.enable
	newbutton.get_node('LocIcon').visible = true
	newbutton.get_node('state').visible = true

	var limit = calculate_sex_limits()
	var sex_participants = get_parent().sex_participants
	
	newbutton.texture_disabled = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_disabled.png")
	
	if sex_participants.has(person):
		newbutton.pressed = true
	else:
		newbutton.pressed = false
		if sex_participants.size() >= limit:
			newbutton.disabled = true
#	for button in SlaveContainer.get_children():
#		if button == SlaveContainer.get_child(SlaveContainer.get_children().size()-1):
#			continue
#		var ch = button.get_meta("slave")
#		button.pressed = sex_participants.has(ch)
#		button.disabled = (sex_participants.size() >= limit && !button.is_pressed())
#		if ch.has_status('no_sex'):
#			button.get_node("SexIcon").self_modulate = Color(variables.hexcolordict.red)
#		elif ResourceScripts.game_globals.weekly_sex_left < 1:
#			button.get_node("SexIcon").self_modulate = Color(variables.hexcolordict.yellow)
#		else:
#			button.get_node("SexIcon").self_modulate = Color(variables.hexcolordict.green)
#		if !person.has_status("relation"):
#			button.get_node("DateIcon").self_modulate = Color(variables.hexcolordict.red)
#		elif person.tags.has("no_date_day") || ResourceScripts.game_globals.weekly_dates_left < 1:
#			button.get_node("DateIcon").self_modulate = Color(variables.hexcolordict.yellow)
#		else:
#			button.get_node("DateIcon").self_modulate = Color(variables.hexcolordict.green)

#	update_description()




func update_description():
	var sex_participants = get_parent().sex_participants
	$BedroomLimit.text = str(sex_participants.size()) +  '/' + str(calculate_sex_limits())
	$DateLimit.text = str(ResourceScripts.game_globals.weekly_dates_left) + "/" + str(ResourceScripts.game_globals.weekly_dates_max)
	$SexLimit.text = str(ResourceScripts.game_globals.weekly_sex_left) + "/" + str(ResourceScripts.game_globals.weekly_sex_max)


func calculate_sex_limits():
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
		if person == SlaveContainer.get_child(SlaveContainer.get_children().size()-1):
			continue
		var person_reference = person.get_meta("slave")
		if person_reference == null:
			continue
		if selected_location == 'training':
			if person_reference.get_work() == 'learning':
				build_for_tutelage(person_reference, person)
				person.visible = true
			else:
				build_for_default(person_reference, person)
				person.visible = false
		else:
			if person_reference.get_work() == 'learning':
				person.visible = false
				continue
			if get_parent().mansion_state != 'sex': build_for_default(person_reference, person)
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


func update_location_buttons():
	for i in LocationsList.get_children():
		if i == LocationsList.get_child(LocationsList.get_children().size()-1) || !i.has_meta('location'):
			continue
		i.pressed = selected_location == i.get_meta("location")


func build_for_skills(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('loctext').visible = false
	
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('rhand').visible = true
	newbutton.get_node('tool').visible = true
	newbutton.get_node('chest').visible = true
	newbutton.get_node('legs').visible = true
	newbutton.get_node('DateIcon').visible = !person.is_master()
	newbutton.get_node('SexIcon').visible = true
	newbutton.get_node('TrainIcon').visible = person.training.enable
	newbutton.get_node('LocIcon').visible = true
	newbutton.get_node('state').visible = true
	if person == get_parent().skill_source:
		newbutton.texture_disabled = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_pressed.png")
		newbutton.disabled = true
	if !person in get_parent().chars_for_skill:
		newbutton.texture_disabled = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_disabled.png")
		newbutton.disabled = true
	else:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_avail.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/button_job_chars_hover2.png")
	newbutton.get_node("job").disabled = true


var training_types = {
	nothing = 'No Training',
	slave_training = "Slave Training",
	academy = 'Academy',
	heir = 'Heir Education',
}


func build_for_tutelage(person, newbutton):
	newbutton.get_node('progress').visible = true
	newbutton.get_node('explabel').visible = false
	newbutton.get_node('stats').visible = true
	newbutton.get_node('loctext').visible = true
	newbutton.get_node('job').visible = false
	newbutton.get_node('rhand').visible = false
	newbutton.get_node('tool').visible = false
	newbutton.get_node('chest').visible = false
	newbutton.get_node('legs').visible = false
	newbutton.get_node('DateIcon').visible = false
	newbutton.get_node('SexIcon').visible = false
	newbutton.get_node('TrainIcon').visible = false
	newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
	newbutton.get_node('progress').max_value = variables.tutduration
	newbutton.get_node('loctext').text = training_types[person.get_tutelage_type()]
	


func remove_from_travel(person):
	get_parent().persons_for_travel.erase(person)
	rebuild()


func update():
	update_dislocations()
#	get_parent().NavModule.build_accessible_locations()
	for i in $ScrollContainer/VBoxContainer.get_children():
		update_button(i)
	update_description()


func update_button(newbutton):
	var person_location
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')
	
	newbutton.get_node("icon").texture = person.get_icon_small()
	newbutton.get_node("name").text = person.get_short_name()
	if person.is_master() or person.is_unique():
		newbutton.get_node("name").set("custom_colors/font_color", variables.hexcolordict.unique)
	newbutton.get_node("sex").texture = images.get_icon(person.get_stat('sex'))
	var job_label = newbutton.get_node("job/Label")
	_set_job_label_color_from_key(job_label, JOB_COLOR_DEFAULT)
	var work_code = person.get_work()
	var gatherable = Items.materiallist.has(work_code)
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
	elif work_code == 'special':
		var task = person.find_worktask()
		job_label.text = tr("TASKMISSION")
	else:
		if !gatherable:
			if tasks.tasklist.has(work_code):
				job_label.text = tasks.tasklist[work_code].name
				_apply_task_color(job_label, tasks.tasklist[work_code])
			else:
				job_label.text = work_code.capitalize()
		else:
			job_label.text = Items.materiallist[work_code].name
			_set_job_label_color_from_key(job_label, JOB_COLOR_GATHER)
	
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(1,1,1))
	# if !person.check_location('Aliron'):
	#location
	if !person.is_avaliable():
		newbutton.get_node('loctext').text = tr("CHAR_UNAVALIABLE")
		newbutton.get_node('LocIcon').texture = null
		person_location = null
	elif person.check_location('travel'):
		newbutton.get_node('loctext').text = tr("MSLMRELOC") + ": " + tr("MSLMRE") + " " + str(ceil(person.travel.travel_time / person.travel_per_tick())) + tr("MSLMTURN") + ". "
		newbutton.get_node('LocIcon').texture = load("res://assets/Textures_v2/MANSION/icon_travel_small.png")
		newbutton.get_node('LocIcon').hint_tooltip = tr("MSLMRELOC") + ": " + tr("MSLMRE") + " " + str(ceil(person.travel.travel_time / person.travel_per_tick())) + tr("MSLMTURN") + ". "
		person_location = null
		
	elif person.check_location('aliron') || person.get_location() == "mansion": # Temporary
		newbutton.get_node('loctext').text = tr("MSLMMANSION")#ResourceScripts.world_gen.get_location_from_code(person.get_location()).name
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
			newbutton.get_node('loctext').text = ploc.name
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
	for slot in ['rhand', 'tool', 'chest', 'legs']:
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
	if !person.has_status('relation'):
		newbutton.get_node("DateIcon").texture = load("res://assets/Textures_v2/MANSION/no.png")
	elif person.tags.has("no_date_day"):
		newbutton.get_node("DateIcon").texture = load("res://assets/Textures_v2/MANSION/no.png")
	else:
		newbutton.get_node("DateIcon").texture = load("res://assets/Textures_v2/MANSION/yes.png")
	if person.has_status('no_sex'):
		newbutton.get_node("SexIcon").texture = load("res://assets/Textures_v2/MANSION/no.png")
	else:
		newbutton.get_node("SexIcon").texture = load("res://assets/Textures_v2/MANSION/yes.png")
	if !person.can_be_trained():
		newbutton.get_node("TrainIcon").texture = load("res://assets/Textures_v2/MANSION/no.png")
	else:
		newbutton.get_node("TrainIcon").texture = load("res://assets/Textures_v2/MANSION/yes.png")
	


var stateicons = {
	work = load('res://assets/images/gui/gui icons/workicon.png'),
	rest = load('res://assets/images/gui/gui icons/sleepicon.png'),
	joy = load('res://assets/images/gui/gui icons/joyicon.png'),
}

func get_state_texture(tempchar):
	return
	var rval = tempchar.last_tick_assignement

	rval = stateicons[rval]
	return rval
