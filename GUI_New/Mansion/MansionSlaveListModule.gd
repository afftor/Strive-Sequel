extends Panel

var active_person
onready var SlaveModule = get_parent().SlaveModule
onready var SlaveContainer = $ScrollContainer/VBoxContainer
onready var LocationsList = $TravelsContainer/HBoxContainer
var populatedlocations = []
var default_locations = ["show_all", "mansion"]
var selected_location = "show_all"


func _ready():
	globals.connect("slave_added", self, "rebuild")
	globals.connect("hour_tick", self, "rebuild")
	input_handler.slave_list_node = self
	#rebuild()

func rebuild():
	
	$population.text = "P: "+ str(ResourceScripts.game_party.characters.size()) +"/" + str(ResourceScripts.game_res.get_pop_cap())
	$food_consumption.text = "F:" + str(ResourceScripts.game_party.get_food_consumption())
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
		match get_parent().mansion_state:
			"travels":
				build_for_travel(person, newbutton)
			"skill":
				build_for_skills(person, newbutton)		
			"upgrades":
				build_for_upgrades(person, newbutton)
			"occupation", "default":
				continue

		update_dislocations()
		show_location_characters()
		
		
		


func set_hover_area():
	$HoverArea.rect_size = SlaveContainer.rect_size - Vector2(20, 20)
	$HoverArea.rect_position.x = $ScrollContainer.rect_position.x + 10
	$HoverArea.rect_position.y = $ScrollContainer.rect_position.y + 10
	
func is_in_area():
	var in_area = $HoverArea.get_global_rect().has_point(get_global_mouse_position())
	return in_area

func double_clicked(event):
	if event is InputEventMouseButton and event.doubleclick:
		get_parent().mansion_state = "char_info"

func build_for_travel(person, newbutton):
	var selected_travel_characters = get_parent().selected_travel_characters
	if person.get_work() == "travel":
		newbutton.modulate = Color(1,0,0,1)
	elif (person.get_stat('obedience') <= 0) && !person.is_controllable():
		newbutton.modulate = Color(1,0,0,1)
	else:
		if person in selected_travel_characters:
			newbutton.modulate = Color(0,1,0,1)

func update_dislocations():
	var temparray = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.travel.location in [ResourceScripts.game_world.mansion_location,'travel'] && !temparray.has(person.travel.location):
			temparray.append(person.travel.location)
	temparray.sort()
	populatedlocations = temparray
	build_locations_list()

func build_locations_list():
	input_handler.ClearContainer(LocationsList)
	for loca in default_locations + populatedlocations:
		var newbutton = input_handler.DuplicateContainerTemplate(LocationsList)
		if loca in default_locations:
			newbutton.text = loca.capitalize()
		else:
			newbutton.text = ResourceScripts.world_gen.get_location_from_code(loca).name
		newbutton.set_meta("location", loca)
		newbutton.connect("pressed", self, "show_location_characters", [newbutton])



func show_location_characters(button = null):
	if button != null:
		selected_location = button.get_meta("location")
	update_location_buttons()
	for person in SlaveContainer.get_children():
		var person_reference = person.get_meta("slave")
		if person_reference == null:
			continue
		var person_location = person_reference.travel.location
		if selected_location == "show_all":
			person.visible = true
		else:
			person.visible = (person_location == selected_location)


func update_location_buttons():
	for i in LocationsList.get_children():
		var pressed = (selected_location == i.get_meta("location"))
		i.pressed = pressed



func build_for_upgrades(person, newbutton):
	if get_parent().is_upgrade_selected:
		if person.get_work() == "building" || !person.check_location('mansion'):
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/panel_char_unavailable.png")
			newbutton.disabled = true
		else:
			newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/panel_char_available.png")
			newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/panel_char_available_hover.png")


func build_for_skills(person, newbutton):
	if get_parent().skill_source == person:
		return
	if !person in get_parent().chars_for_skill:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/panel_char_unavailable.png")
		newbutton.disabled = true
	else:
		newbutton.texture_normal = load("res://assets/Textures_v2/MANSION/panel_char_available.png")
		newbutton.texture_hover = load("res://assets/Textures_v2/MANSION/panel_char_available_hover.png")

func remove_from_travel(person):
	get_parent().persons_for_travel.erase(person)
	rebuild()

func update():
	for i in $ScrollContainer/VBoxContainer.get_children():
		update_button(i)

func update_button(newbutton):
	if newbutton.name == 'Button':
		return
	var person = newbutton.get_meta('slave')
	newbutton.get_node("icon").texture = person.get_icon()
	newbutton.get_node("name").text = person.get_full_name()
	newbutton.get_node("sex").texture = images.icons[person.get_stat('sex')]
	
	newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
	newbutton.get_node("stats/hp").value = person.hp
	newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
	newbutton.get_node("stats/mp").value = person.mp
	newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
	#newbutton.get_node("HBoxContainer/stats/hplabel").text = str(round(person.hp)) + "/" + str(round(person.hpmax))
	#newbutton.get_node("HBoxContainer/stats/mplabel").text = str(round(person.mp)) + "/" + str(round(person.mpmax))
	newbutton.get_node("explabel").text = str(round(person.get_stat('base_exp')))
	if person.get_work() == '':
		newbutton.get_node("job/Label").text = tr("TASKREST")
	else:
		newbutton.get_node("job/Label").text = races.tasklist[person.get_work()].name
	
	
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
	if !person.check_location('mansion'):
		if person.check_location('travel'):
			newbutton.get_node('job/Label').text = 'Relocating: in ' + str(ceil(person.travel.travel_time / person.travel_per_tick())) + " hours. " 
		else:
			newbutton.get_node('job/Label').text = 'Positioned: ' + ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[person.travel.location].area].name
	
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



