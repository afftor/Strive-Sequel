extends Panel

var nav
var selected_location


func _ready():
	globals.connect("hour_tick", self, "update_buttons")
	globals.connect("hour_tick", self, "build_accessible_locations")
	pass


func update_buttons():
	nav = gui_controller.nav_panel.get_node("NavigationContainer/AreaSelection")
	if gui_controller.current_screen == gui_controller.mansion || gui_controller.current_screen == gui_controller.inventory:
		for button in nav.get_children():
			if button.name == "Button" || button.get_class() != 'Button' || !button.has_meta("data"):
				continue
			button.pressed = false
		nav.get_child(0).pressed = true
		return
	for button in nav.get_children():
		if button.name == "Button" || button.get_class() != 'Button' || !button.has_meta("data"):
			continue
		button.pressed = input_handler.selected_location == button.get_meta("data")


func sort_locations(locations_array):
	var capitals = ["Mansion"]
	var settlements = []
	var dungeons = []
	var quest_locations = []
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
			"dungeon","encounter":
				dungeons.append(loca)
			"quest_location":
				quest_locations.append(loca)
	return capitals + settlements + dungeons + quest_locations


func build_accessible_locations(args = null):
	nav = gui_controller.nav_panel.get_node("NavigationContainer/AreaSelection")
	input_handler.ClearContainer(nav)
	var location_array = ["aliron"]
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var person_location = person.get_location()
		if person_location == "mansion":
			person_location = "aliron"
		if (!location_array.has(person_location)):
			location_array.append(person_location)
	var sorted_locations = sort_locations(location_array)
	for i in sorted_locations:
		var newseparator = $VSeparator.duplicate()
		var newbutton = input_handler.DuplicateContainerTemplate(nav)
		nav.add_child(newseparator)
		if i == "Mansion":
			newbutton.text = "Mansion"
			newbutton.connect("pressed", self, "return_to_mansion")
			# newbutton.set_meta("data", i)
			newseparator.visible = true
			newbutton.pressed = gui_controller.current_screen == gui_controller.mansion
			newbutton.toggle_mode = !gui_controller.current_screen == gui_controller.mansion
			continue
		if i != sorted_locations[sorted_locations.size() - 1]:
			newseparator.visible = true
		else:
			newseparator.visible = false
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "select_location", [i])
		newbutton.set_meta("data", i)
		update_buttons()


func select_location(location):
	pass
	if gui_controller.exploration == null:
		gui_controller.exploration = input_handler.get_spec_node(input_handler.NODE_EXPLORATION, null, false, false)
	input_handler.selected_location = location
	input_handler.active_location = ResourceScripts.world_gen.get_location_from_code(location)

	if gui_controller.current_screen == gui_controller.mansion:
		input_handler.PlaySound("door_open")
		gui_controller.previous_screen = gui_controller.current_screen
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
		gui_controller.open_exploration(location)
		gui_controller.mansion.hide()
	else:
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')

	if location in ResourceScripts.game_world.capitals:
		gui_controller.exploration.open_city(location)#
		gui_controller.clock.raise()
		gui_controller.clock.show()
	else:
		var data = ResourceScripts.world_gen.get_location_from_code(location)
		var presented_characters = []
		for id in ResourceScripts.game_party.character_order:
			var i = ResourceScripts.game_party.characters[id]
			if i.check_location(data.id, true):
				presented_characters.append(i)
		if presented_characters.size() == 0:
			select_location('Aliron')
			return
		else:
			gui_controller.exploration.open_location(data)

	gui_controller.exploration.show()
	build_accessible_locations()
	gui_controller.close_all_closeable_windows()


func return_to_mansion(with_state = "default"):
	if gui_controller.current_screen == gui_controller.mansion:
		build_accessible_locations()
		update_buttons()
		return
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), 'timeout')
	if gui_controller.exploration != null:
		gui_controller.exploration.get_node("LocationGui").hide()
	gui_controller.previous_screen = null
	gui_controller.current_screen = gui_controller.mansion
	gui_controller.exploration.previous_guild = ''
	input_handler.PlaySound("door_open")
	input_handler.StopBackgroundSound()
	input_handler.SetMusicRandom("mansion")

	gui_controller.mansion.show()
	gui_controller.mansion.raise()
	gui_controller.clock.show()
	gui_controller.clock.raise()
	gui_controller.exploration.get_node("GuildBG").hide()
	gui_controller.exploration.active_faction = null
	gui_controller.mansion.mansion_state_set(with_state)
	build_accessible_locations()
	update_buttons()
	gui_controller.exploration.hide()
	gui_controller.close_all_closeable_windows()

	if gui_controller.dialogue != null:
		gui_controller.dialogue.raise()
