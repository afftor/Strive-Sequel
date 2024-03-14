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
var limit

const BUTTON_HEIGHT = 64


func _ready():
	input_handler.slave_list_node = self
	globals.connect("slave_added", self, "rebuild")
	globals.connect("task_removed", self, "rebuild")
	globals.connect("hour_tick", self, "update_dislocations")
	globals.connecttexttooltip($BedroomIcon, tr("BEDROOMTOOLTIP"))
	globals.connecttexttooltip($DateIcon, tr("DATETOOLTIP"))
	globals.connecttexttooltip($SexIcon, tr("SEXTOOLTIP"))

func OpenJobModule(person = null):
	input_handler.ActivateTutorial('job')
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

func rebuild():
	build_locations_list()
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
		
		newbutton.disabled = person.is_on_quest()
		if !person.is_on_quest():
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char.png")

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
		globals.connecttexttooltip(newbutton.get_node("obed"), tr("STATOBEDIENCEDESCRIPT"))
		
		
		newbutton.get_node("job").connect("pressed", self, 'OpenJobModule', [person])
		newbutton.get_node("job").set_disabled(false)
		newbutton.get_node("job").disabled = person.travel.location == "travel" || person.is_on_quest()
		match get_parent().mansion_state:
			"travels":
				build_for_travel(person, newbutton)
				newbutton.get_node("job").set_disabled(true)
				newbutton.get_node("job").set_mouse_filter(MOUSE_FILTER_IGNORE)
			"skill":
				build_for_skills(person, newbutton)
				newbutton.get_node("job").set_disabled(true)
				newbutton.get_node("job").set_mouse_filter(MOUSE_FILTER_IGNORE)
			"upgrades":
				build_for_upgrades(person, newbutton)
			"default":
				build_for_default(person, newbutton)
			"occupation":
				build_for_ocupation(person, newbutton)
			"craft":
				build_for_craft(person, newbutton)
			"sex":
				build_sex_selection(person, newbutton)
		var pos = self.rect_size
		$TravelsContainerPanel.rect_position.y = pos.y - 50
		show_location_characters()


func double_clicked(event, button):
	if event is InputEventMouseButton and event.doubleclick:
		# if get_parent().active_person == null:
		if button.disabled:
			return
		get_parent().set_active_person(button.get_meta("slave"))
		get_parent().mansion_state = "char_info"


func build_for_ocupation(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()
	if person.travel.location == "travel":
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true

func build_for_default(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()

func build_for_travel(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()
	var selected_travel_characters = get_parent().selected_travel_characters
	if person.travel.location == get_parent().selected_destination || get_parent().selected_destination == null || person.travel.location == "travel":
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true
	elif (person.predict_obed_time() <= 0) && !person.is_controllable():
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true
	else:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")
	for button in SlaveContainer.get_children():
		if newbutton.get_meta("slave") in selected_travel_characters:
			newbutton.texture_pressed = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")


func build_for_craft(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()
	newbutton.pressed = false
	if person.travel.location != ResourceScripts.game_world.mansion_location:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true
	# if person in get_parent().persons_for_craft:
	# 	newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/panel_char_available.png")
	# else:
	# 	newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/panel_char.png")
	for button in SlaveContainer.get_children():
		if newbutton.get_meta("slave") in get_parent().persons_for_craft:
			newbutton.texture_pressed = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")



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
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()
	calculate_sex_limits()
	var sex_participants = get_parent().sex_participants
	for button in SlaveContainer.get_children():
		if button == SlaveContainer.get_child(SlaveContainer.get_children().size()-1):
			continue
		var ch = button.get_meta("slave")
		button.pressed = sex_participants.has(ch)
		button.disabled = (sex_participants.size() >= limit && !button.is_pressed())
		if ch.has_status("no_sex") or !ch.has_status("sex_basic") or (sex_participants.size() > 1 and !ch.has_status("sex_group")):
			button.hint_tooltip = "Sex Requirements aren't met"
			button.get_node("name").set("custom_colors/font_color", Color(variables.hexcolordict.red))

	update_description()




func update_description():
	var sex_participants = get_parent().sex_participants
	$BedroomLimit.text = str(sex_participants.size()) +  '/' + str(calculate_sex_limits())
	$DateLimit.text = str(ResourceScripts.game_globals.weekly_dates_left) + "/" + str(ResourceScripts.game_globals.weekly_dates_max)
	$SexLimit.text = str(ResourceScripts.game_globals.weekly_sex_left) + "/" + str(ResourceScripts.game_globals.weekly_sex_max)


func calculate_sex_limits():
	var slavelimit = 2
	if ResourceScripts.game_res.upgrades.has('master_bedroom'):
		slavelimit += ResourceScripts.game_res.upgrades.master_bedroom
	limit = slavelimit
	return limit


func show_location_characters(button = null):
	if button != null:
		prev_selected_location = selected_location
		selected_location = button.get_meta("location")
	update_location_buttons()
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
			build_for_default(person_reference, person)
			var person_location = person_reference.travel.location
			if selected_location == "show_all":
				person.visible = true
			elif selected_location == "mansion" || selected_location == "Aliron":
				if person_location == "mansion": person_location = "Aliron"
				person.visible = person_location == "Aliron"
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
	
	if visible_persons.size() < 1:
		selected_location = "show_all"
		show_location_characters()



func update_location_buttons():
	for i in LocationsList.get_children():
		if i == LocationsList.get_child(LocationsList.get_children().size()-1) || !i.has_meta('location'):
			continue
		i.pressed = selected_location == i.get_meta("location")


func build_for_upgrades(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()
	if get_parent().select_chars_mode:
		if person.get_work() == "building" || !person.check_location('aliron'):
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
			newbutton.disabled = true
		else:
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")
			newbutton.texture_pressed = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")
		for button in SlaveContainer.get_children():
			if button == SlaveContainer.get_child(SlaveContainer.get_children().size()-1):
				continue
			button.pressed = get_parent().chars_for_upgrades.has(button.get_meta("slave"))
	else:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char.png")
		newbutton.texture_pressed = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_pressed.png")
		# for i in $ScrollContainer/VBoxContainer.get_children():
		# 	i.pressed = i.get_meta("slave") == get_parent().active_person
	newbutton.get_node("job").disabled = person.is_on_quest()



func build_for_skills(person, newbutton):
	newbutton.get_node('progress').visible = false
	newbutton.get_node('explabel').visible = true
	newbutton.get_node('stats').visible = true
	newbutton.get_node('job').visible = true
	newbutton.get_node('obed').visible = !person.is_master()
	if person == get_parent().skill_source:
		newbutton.texture_disabled = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_chosen.png")
		newbutton.disabled = true
	if !person in get_parent().chars_for_skill:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true
	else:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")
	newbutton.get_node("job").disabled = person.is_on_quest()

var training_types = {
	nothing = 'No Training',
	slave_training = "Slave Training",
	academy = 'Academy',
	heir = 'Heir Education',
}


func build_for_tutelage(person, newbutton):
	newbutton.get_node('progress').visible = true
	newbutton.get_node('explabel').visible = false
	newbutton.get_node('stats').visible = false
	newbutton.get_node('job').visible = false
	newbutton.get_node('obed').visible = false
	newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
	newbutton.get_node('progress').max_value = variables.tutduration
	newbutton.get_node('Location').text = training_types[person.get_tutelage_type()]
	


func remove_from_travel(person):
	get_parent().persons_for_travel.erase(person)
	rebuild()


func update():
	update_dislocations()
#	get_parent().NavModule.build_accessible_locations()
	for i in $ScrollContainer/VBoxContainer.get_children():
		update_button(i)


func update_button(newbutton):
	var person_location
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')

	newbutton.get_node("icon").texture = person.get_icon_small()
	newbutton.get_node("name").text = person.get_short_name()
	if person.is_master() or person.is_unique():
		newbutton.get_node("name").set("custom_colors/font_color", variables.hexcolordict.unique)
	newbutton.get_node("sex").texture = images.icons[person.get_stat('sex')]

	newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
	newbutton.get_node("stats/hp").value = person.hp
	newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
	newbutton.get_node("stats/mp").value = person.mp
	newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
	#newbutton.get_node("HBoxContainer/stats/hplabel").text = str(round(person.hp)) + "/" + str(round(person.hpmax))
	#newbutton.get_node("HBoxContainer/stats/mplabel").text = str(round(person.mp)) + "/" + str(round(person.mpmax))
	newbutton.get_node("explabel").text = str(floor(person.get_stat('base_exp')))
	var gatherable = Items.materiallist.has(person.get_work())
	if person.get_work() == '' or person.get_work() == "Assignment" or person.get_work() == "disabled":
		if person.is_on_quest():
			var time_left = int(person.get_quest_time_remains())
			if time_left > 0:
				var time_left_string = ''
				if time_left == 1:
					time_left = 4 - ResourceScripts.game_globals.hour
					time_left_string = str(time_left) + " turns"
				else:
					time_left_string = str(time_left) + " d."
				newbutton.get_node("job/Label").text = "On Quest: " + time_left_string
			else:
				newbutton.get_node("job/Label").text = tr("CHAR_UNAVALIABLE")
		else:
			newbutton.get_node("job/Label").text = tr("TASKREST")
	elif person.get_work() == 'learning':
		newbutton.get_node('progress').value = variables.tutduration - person.get_quest_time_remains()
	elif person.get_work() == 'special':
		var task = person.find_worktask()
		newbutton.get_node("job/Label").text = tr("TASKMISSION")
	else:
		if !gatherable:
			newbutton.get_node("job/Label").text = tasks.tasklist[person.get_work()].name
		else:
			newbutton.get_node("job/Label").text =  Items.materiallist[person.get_work()].name
	
	
	newbutton.get_node("obed").max_value = person.get_stat('obedience_max')
	newbutton.get_node("obed").value = person.get_stat('obedience')

	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(1,1,1))
	# if !person.check_location('Aliron'):
	if person.get_work() == "disabled":
		newbutton.get_node('Location').text = tr("CHAR_UNAVALIABLE")
		person_location = null
	elif person.check_location('travel'):
		newbutton.get_node('Location').text = tr("MSLMRELOC") + ": " + tr("MSLMRE") + " " + str(ceil(person.travel.travel_time / person.travel_per_tick())) + tr("MSLMTURN") + ". "
	elif person.check_location('aliron') || person.get_location() == "mansion": # Temporary
		newbutton.get_node('Location').text = tr("MSLMMANSION")#ResourceScripts.world_gen.get_location_from_code(person.get_location()).name
	else:
		### Temporary
		if person.get_location() == "mansion":
			person_location = "aliron"
		else:
			person_location = person.get_location()

	if person_location != null:
		var ploc = ResourceScripts.world_gen.get_location_from_code(person_location)
		if ploc != null: 
			newbutton.get_node('Location').text = ploc.name
			#newbutton.get_node('Location').text = tr(ploc.name)
	newbutton.get_node("job").disabled = false
	newbutton.get_node("job/Label").set("custom_colors/font_color", variables.hexcolordict.k_gray)
	if !person.has_status('basic_servitude'):
		newbutton.get_node("job").disabled = true
		newbutton.get_node("job/Label").set("custom_colors/font_color", variables.hexcolordict['red'])
		globals.connecttexttooltip(newbutton.get_node("job"), person.translate("[name] lacks Training: Basic Servitude"))
	if person.travel.location == "travel" || person.is_on_quest():
		newbutton.get_node("job").disabled = true
		newbutton.get_node("job/Label").set("custom_colors/font_color", variables.hexcolordict['red'])
	newbutton.get_node("state").texture = person.get_class_icon()



var obed_textures = {
	high = load("res://assets/images/gui/gui icons/obedience1.png"),
	med = load("res://assets/images/gui/gui icons/obedience2.png"),
	low = load("res://assets/images/gui/gui icons/obedience3.png")
}
var fear_textures = {
	high = load('res://assets/images/gui/gui icons/fear1.png'),
	med = load("res://assets/images/gui/gui icons/fear2.png"),
	low = load("res://assets/images/gui/gui icons/fear3.png")
}

func get_obed_texture(tempchar):
	var rval
	if tempchar.obedience >= 50:
		rval = 'high'
	elif tempchar.obedience < tempchar.timid_factor * 7:
		rval = 'low'
	else:
		rval = 'med'
	return obed_textures[rval]

func get_fear_texture(tempchar):
	var rval
	if tempchar.submission >= 50:
		rval = 'high'
	elif tempchar.submission < tempchar.timid_factor * 7:
		rval = 'low'
	else:
		rval = 'med'
	return fear_textures[rval]

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
