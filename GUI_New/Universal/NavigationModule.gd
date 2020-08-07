extends Panel

onready var Navigation = $NavigationContainer/AreaSelection
var selected_location


func _ready():
	pass
#	$MansionButton.connect("pressed", self, "return_to_mansion")


func update_buttons():
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
	for button in Navigation.get_children():
		if button.name == "Button" || button.get_class() != 'Button' || !button.has_meta("data"):
			continue
		button.pressed = selected_location == button.get_meta("data")

func sort_locations(locations_array):
	var capitals = ["Mansion"]
	# if GUIWorld.BaseScene != null && GUIWorld.BaseScene == GUIWorld.gui_data.EXPLORATION.main_module:
	# 	capitals.append("Mansion")
	var settlements = []
	var dungeons = []
	for loca in locations_array:
		if loca == null:
			locations_array.erase(null)
			continue
		if loca == "mansion" || loca == "travel": continue
		match ResourceScripts.world_gen.get_location_from_code(loca).type:
			"capital":
				capitals.append(loca)
			"settlement":
				settlements.append(loca)
			"dungeon":
				dungeons.append(loca)
	return capitals + settlements + dungeons

func build_accessible_locations():
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
	input_handler.ClearContainer(Navigation)
	var location_array = ["Aliron"]
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var person_location = person.get_location()
		if person_location == "mansion":
			person_location = "Aliron"
		if (!location_array.has(person_location)):
			location_array.append(person_location)

	# var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
	# newbutton.text = "Aliron"
	# newbutton.connect("pressed", self, "select_location", ['Aliron'])
	# newbutton.set_meta("data", 'Aliron')
	var sorted_locations = sort_locations(location_array)
	for i in sorted_locations:
		var newseparator = $VSeparator.duplicate()
		var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
		if i == "Mansion":
			newbutton.text = "Mansion"
			newbutton.connect("pressed", self, "return_to_mansion")
			newbutton.set_meta("data", i)
			Navigation.add_child(newseparator)
			newseparator.visible = true
			if GUIWorld.BaseScene != null && GUIWorld.BaseScene == GUIWorld.gui_data.MANSION.main_module:
				newbutton.pressed = true
			continue
		Navigation.add_child(newseparator)
		newseparator.visible = true
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "select_location", [i])
		newbutton.set_meta("data", i)

	# if get_parent().selected_location != null:
	# 	for i in Navigation.get_children():
	# 		if i.has_meta("data"):
	# 			i.pressed = i.get_meta('data') == get_parent().selected_location
	if GUIWorld.BaseScene != null && GUIWorld.BaseScene != GUIWorld.gui_data.MANSION.main_module:
		update_buttons()

func select_location(location):
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
	if GUIWorld.BaseScene == GUIWorld.gui_data.MANSION.main_module:
		go_outside(location)
		return
	# get_parent().selected_location = location
	# for i in $NavigationPanel/NavigationContainer/AreaSelection.get_children():
	# 	if i.has_meta("data"):
	# 		i.pressed = i.get_meta('data') == location
	# if GUIWorld.BaseScene == get_parent():
	# 	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	# 	yield(get_tree().create_timer(0.5), "timeout")
	if GUIWorld.PreviousScene == GUIWorld.gui_data.MANSION.main_module:
		print("here")
		GUIWorld.PreviousScene = null
	else:
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
	if location in ResourceScripts.game_world.capitals:
		get_parent().City.open_city(location)
	else:
		var data = ResourceScripts.world_gen.get_location_from_code(location)
		var presented_characters = []
		for id in ResourceScripts.game_party.character_order:
			var i = ResourceScripts.game_party.characters[id]
			if i.check_location(data.id, true):
				presented_characters.append(i)
		if presented_characters.size() == 0:
			# if GUIWorld.BaseScene == get_parent():
			# 	ResourceScripts.core_animations.BlackScreenTransition(0.7)
			# 	yield(get_tree().create_timer(0.7), "timeout")
			select_location('Aliron')
			GUIWorld.BaseScene = get_parent()
			return
		else:
			get_parent().open_location(data)
	selected_location = location
	update_buttons()
	GUIWorld.BaseScene = get_parent()
	get_parent().show()

func return_to_mansion():
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
	if GUIWorld.BaseScene == GUIWorld.gui_data.MANSION.main_module:
		return
	GUIWorld.PreviousScene = null
	get_parent().selected_location = null
	input_handler.PlaySound("door_open")
	input_handler.StopBackgroundSound()
	input_handler.SetMusicRandom("mansion")
	ResourceScripts.core_animations.BlackScreenTransition()
	if GUIWorld.BaseScene != null && GUIWorld.BaseScene == GUIWorld.gui_data.EXPLORATION.main_module:
		get_parent().get_node("GuildBG").hide()
#	get_parent().City.enter_guild(get_parent().active_faction)
	# get_parent().City.get_node("GuildMenuBG").hide()
		get_parent().active_faction = null
		get_parent().active_location = null
	yield(get_tree().create_timer(0.5), 'timeout')
	GUIWorld.set_current_scene(GUIWorld.gui_data["MANSION"].main_module)
	GUIWorld.BaseScene = GUIWorld.gui_data["MANSION"].main_module
	GUIWorld.gui_data["MANSION"].main_module.mansion_state_set("default")


func go_outside(location):
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)
	GUIWorld.PreviousScene = get_parent()
	get_parent().selected_location = location
	input_handler.PlaySound("door_open")
	ResourceScripts.core_animations.BlackScreenTransition(0.5)
	yield(get_tree().create_timer(0.5), 'timeout')
	GUIWorld.set_current_scene(GUIWorld.gui_data["EXPLORATION"].main_module)
	GUIWorld.BaseScene = GUIWorld.gui_data["EXPLORATION"].main_module
	GUIWorld.gui_data["EXPLORATION"].main_module.open()
