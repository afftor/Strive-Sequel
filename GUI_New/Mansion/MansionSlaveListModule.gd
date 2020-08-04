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
	globals.connect("hour_tick", self, "update")


func rebuild():
	LocationsPanel.visible = (get_parent().mansion_state != "sex")
	$population.visible = LocationsPanel.is_visible()
	$food_consumption.visible = LocationsPanel.is_visible()
	$BedroomLimit.visible = !LocationsPanel.is_visible()
	$IterationsLimit.visible = !LocationsPanel.is_visible()
	$population.text = str(ResourceScripts.game_party.characters.size()) +"/" + str(ResourceScripts.game_res.get_pop_cap())
	
	$food_consumption.text = str(ResourceScripts.game_party.get_food_consumption()) + "/day"
	input_handler.ClearContainer(SlaveContainer)
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var newbutton = input_handler.DuplicateContainerTemplate(SlaveContainer)
		newbutton.disabled = false
		newbutton.pressed = (get_parent().active_person == person)
		newbutton.set_meta('slave', person)

		# globals.connectslavetooltip(newbutton, person)
		update_button(newbutton)
		newbutton.target_node = self
		newbutton.target_function = 'rebuild'
		newbutton.arraydata = i
		newbutton.parentnodearray = ResourceScripts.game_party.character_order
		
		newbutton.connect('pressed', get_parent(), 'set_active_person', [person])
		newbutton.connect('gui_input', self, 'double_clicked')
		newbutton.connect('mouse_entered', get_parent(), 'set_hovered_person', [newbutton, person])
		newbutton.connect('mouse_exited', get_parent(), 'remove_hovered_person')
		newbutton.get_node("job").connect("pressed", self, "open_job_panel", [person])
		newbutton.get_node("job").set_disabled(false)
		match get_parent().mansion_state:
			"travels":
				newbutton.get_node("job").set_disabled(true)
				build_for_travel(person, newbutton)
			"skill":
				newbutton.get_node("job").set_disabled(true)
				build_for_skills(person, newbutton)		
			"upgrades":
				build_for_upgrades(person, newbutton)
			"occupation", "default":
				continue
			"craft":
				build_for_craft(person, newbutton)
			"sex":
				build_sex_selection(person, newbutton)
	var pos = self.rect_size
	$TravelsContainerPanel.rect_position.y = pos.y - 100
	show_location_characters()


### Requires some magic method to force recalculate scroll container size (Known Godot issue, but no one knows how to fix that) ###
func count_visible_chars():
	var char_counter = 0
	for i in get_tree().get_root().get_node("GUIWorld/MansionMainModule/MansionSlaveListModule/ScrollContainer/VBoxContainer").get_children():
		if i.is_visible():
			char_counter += 1
	return char_counter


func set_hover_area():
	yield(get_tree(), 'idle_frame')
	var chars = count_visible_chars()
	var height
	height = BUTTON_HEIGHT * chars
	$HoverArea.rect_size = Vector2(1004, height) - Vector2(20, 20)
	$HoverArea.rect_position.x = $ScrollContainer.rect_position.x + 10
	$HoverArea.rect_position.y = $ScrollContainer.rect_position.y + 10

### =========================================================================================================================== ###

	
	
func is_in_area():
	var in_area = $HoverArea.get_global_rect().has_point(get_global_mouse_position())
	return in_area

func double_clicked(event):
	if event is InputEventMouseButton and event.doubleclick:
		get_parent().mansion_state = "char_info"

func build_for_travel(person, newbutton):
	var selected_travel_characters = get_parent().selected_travel_characters
	if person.travel.location == get_parent().selected_destination || get_parent().selected_destination == null || person.travel.location == "travel":
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true
	elif (person.get_stat('obedience') <= 0) && !person.is_controllable():
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
	newbutton.pressed = false
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
	for loca in default_locations + populatedlocations:
		if loca in ['Aliron']:
			continue
		
		var newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
		if loca in default_locations:
			newbutton.text = loca.capitalize()
		elif loca == "mansion":
			newbutton.text = "Mansion"
		else:
			newbutton.text = ResourceScripts.world_gen.get_location_from_code(loca).name
		newbutton.set_meta("location", loca)
		newbutton.connect("pressed", self, "show_location_characters", [newbutton])
		newbutton.connect("pressed", self, "set_hover_area")
		
		var newseparator = $TravelsContainerPanel/VSeparator.duplicate()
		LocationsList.add_child(newseparator)
		newseparator.visible = true
	LocationsList.get_children().back().queue_free()
	update_location_buttons()


func build_sex_selection(person, newbutton):
	calculate_sex_limits()
	var sex_participants = get_parent().sex_participants
	for button in SlaveContainer.get_children():
		if button == SlaveContainer.get_child(SlaveContainer.get_children().size()-1):
			continue
		button.pressed = sex_participants.has(button.get_meta("slave"))
		button.disabled = (sex_participants.size() >= limit && !button.is_pressed())
	update_description()


func update_description():
	var sex_participants = get_parent().sex_participants
	$BedroomLimit.text = 'Bedroom limit: '  +str(sex_participants.size()) +  '/' + str(calculate_sex_limits())
	$IterationsLimit.text = "Interactions per day: " + str(ResourceScripts.game_globals.daily_sex_left) + "/1"

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
				for visible in visible_persons:
					visible.pressed = false
				visible_persons[0].pressed = true
				# get_parent().set_active_person(visible_persons[0].get_meta("slave"))
	if !selected_location in ["show_all"]:
		get_parent().TravelsModule.dislocation_area = selected_location
	get_parent().TravelsModule.update_location_list()
	if visible_persons.size() < 1:
		selected_location = "show_all"			



func update_location_buttons():
	for i in LocationsList.get_children():
		if i == LocationsList.get_child(LocationsList.get_children().size()-1) || !i.has_meta('location'):
			continue
		i.pressed = selected_location == i.get_meta("location")



func build_for_upgrades(person, newbutton):
	if get_parent().select_chars_mode:
		if person.get_work() == "building" || !person.check_location('Aliron'):
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



func build_for_skills(person, newbutton):
	# if get_parent().skill_source == person:
	# 	return
	if !person in get_parent().chars_for_skill:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_unavailable.png")
		newbutton.disabled = true
	else:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/CharacterList/Buttons/panel_char_available_hover.png")

func remove_from_travel(person):
	get_parent().persons_for_travel.erase(person)
	rebuild()

func update():
	update_dislocations()
	get_parent().NavModule.build_accessible_locations()
	for i in $ScrollContainer/VBoxContainer.get_children():
		update_button(i)

func update_button(newbutton):
	var person_location
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')
	newbutton.get_node("icon").texture = person.get_icon()
	newbutton.get_node("name").text = person.get_short_name()
	newbutton.get_node("sex").texture = images.icons[person.get_stat('sex')]
	
	newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
	newbutton.get_node("stats/hp").value = person.hp
	newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
	newbutton.get_node("stats/mp").value = person.mp
	newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
	#newbutton.get_node("HBoxContainer/stats/hplabel").text = str(round(person.hp)) + "/" + str(round(person.hpmax))
	#newbutton.get_node("HBoxContainer/stats/mplabel").text = str(round(person.mp)) + "/" + str(round(person.mpmax))
	newbutton.get_node("explabel").text = str(round(person.get_stat('base_exp')))
	var gatherable = Items.materiallist.has(person.get_work())
	if person.get_work() == '':
		newbutton.get_node("job/Label").text = tr("TASKREST")
	else:
		if !gatherable:
			newbutton.get_node("job/Label").text = races.tasklist[person.get_work()].name
		else:
			newbutton.get_node("job/Label").text = Items.materiallist[person.get_work()].progress_formula.capitalize()
	
	
	if person.get_stat('loyalty') < 100 && person.get_stat('submission') < 100 && !person.has_profession('master'):
		newbutton.get_node("obed").text = str(ceil(person.get_stat('obedience')))
		if person.get_stat('obedience') <= 0:
			newbutton.get_node("obed").set("custom_colors/font_color", Color(variables.hexcolordict.red))
		elif person.get_stat('obedience') <= 10:
			newbutton.get_node("obed").set("custom_colors/font_color", Color(variables.hexcolordict.yellow))
		else:
			newbutton.get_node("obed").set("custom_colors/font_color", Color(variables.hexcolordict.green))
	else:
		newbutton.get_node("obed").text = "∞"
	
	if person.get_next_class_exp() <= person.get_stat('base_exp'):
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(variables.hexcolordict.levelup_text_color))
	else:
		newbutton.get_node("explabel").set("custom_colors/font_color", Color(1,1,1))
	# if !person.check_location('Aliron'):
	if person.check_location('travel'):
		newbutton.get_node('Location').text = 'Relocating: in ' + str(ceil(person.travel.travel_time / person.travel_per_tick())) + " hours. " 
	elif person.check_location('Aliron') || person.get_location() == "mansion": # Temporary
		# person.travel.location = "Aliron"
		newbutton.get_node('Location').text = "Mansion"#ResourceScripts.world_gen.get_location_from_code(person.get_location()).name
		
	else:
		### Temporary
		if person.get_location() == "mansion":
			person_location = "Aliron"
		else:
			person_location = person.get_location()
	if person_location != null:
		newbutton.get_node('Location').text = ResourceScripts.world_gen.get_location_from_code(person_location).name
	# 		# newbutton.get_node('job/Label').text = 'Positioned: ' + ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[person.travel.location].area].name
	
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

func open_job_panel(person):
	get_parent().set_active_person(person)
	get_parent().mansion_state_set("occupation")
