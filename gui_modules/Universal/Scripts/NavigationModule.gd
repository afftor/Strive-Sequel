extends Panel

var nav
var nav2
var selected_location
onready var screen = $drop_list/screen
onready var drop_panel = $drop_list/Panel

func _ready():
	screen.set_global_position(Vector2(0, 0))
	globals.connect("hour_tick", self, "update_buttons")
	globals.connect("hour_tick", self, "build_accessible_locations")
	$drop_list.connect('pressed', self, 'toggle_drop_list', [true])
	$travelbutton.connect('pressed', self, 'open_travel')
	screen.connect('pressed', self, 'toggle_drop_list', [false])

func open_travel():
	var map = gui_controller.mansion.get_node("map")
	if gui_controller.current_screen == gui_controller.mansion:
		map.set_return_context(null, null, null)
	else:
		map.set_return_context(gui_controller.current_screen, self, input_handler.selected_location)
		gui_controller.mansion.show()
		gui_controller.mansion.raise()
	#gui_controller.current_screen == gui_controller.mansion
	gui_controller.mansion.show_map()

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
	var capitals = ["Mansion", "Infinite"]
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
	nav2 = gui_controller.nav_panel.get_node("drop_list/Panel/NavigationContainer/AreaSelection")
	input_handler.ClearContainer(nav, ['Button', 'VSeparator'])
	input_handler.ClearContainer(nav2)
	var location_array = ["aliron"]
	var free_chars = {aliron = 0}
	var chars = {aliron = 0}
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var person_location = person.get_location()
		if person_location == "mansion":
			person_location = "aliron"
		if (!location_array.has(person_location)):
			location_array.append(person_location)
			free_chars[person_location] = 0
			chars[person_location] = 0
		if person.get_work() == '':
			free_chars[person_location] += 1
		chars[person_location] += 1
	var sorted_locations = sort_locations(location_array)
	for i in sorted_locations:
		var newbutton = input_handler.DuplicateContainerTemplate(nav, 'Button')
		var newbutton2 = input_handler.DuplicateContainerTemplate(nav2)
#		var newseparator = input_handler.DuplicateContainerTemplate(nav, 'VSeparator')
#		nav.add_child(newseparator)
		if i == "Mansion":
#			newbutton.text = "Mansion"
			newbutton.get_node('icon').texture = images.get_background('mansion')
			newbutton2.get_node('icon').texture = images.get_background('mansion')
			newbutton.connect("pressed", self, "return_to_mansion")
			newbutton2.connect("pressed", self, "return_to_mansion")
			globals.connecttexttooltip(newbutton, "%s" % ["Mansion"])
			newbutton.get_node('amount').text = "%d/%d" % [free_chars.aliron, chars.aliron]
			newbutton2.get_node('Label').text = "%s - %d/%d" % ["Mansion", free_chars.aliron, chars.aliron]
			# newbutton.set_meta("data", i)
#			newseparator.visible = true
			newbutton.pressed = gui_controller.current_screen == gui_controller.mansion
			newbutton.toggle_mode = !gui_controller.current_screen == gui_controller.mansion
			continue
		if i == "Infinite":
#			newbutton.text = tr("INFINITEDUNGEONNAME")
			globals.connecttexttooltip(newbutton, tr("INFINITEDUNGEONNAME"))
			newbutton2.get_node('Label').text = tr("INFINITEDUNGEONNAME")
			newbutton.get_node('icon').texture = images.get_icon('tower')
			newbutton2.get_node('icon').texture = images.get_icon('tower')
			newbutton.connect("pressed", self, "open_infinite")
			newbutton2.connect("pressed", self, "open_infinite")
			# newbutton.set_meta("data", i)
#			newseparator.visible = true
			if !ResourceScripts.game_progress.decisions.has('unlock_infinite'):
#				newseparator.visible = false
				newbutton.visible = false
				newbutton2.visible = false
			continue
#		if i == sorted_locations.back():
#			newseparator.visible = false
#		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		var locdata = ResourceScripts.world_gen.get_location_from_code(i)
#		globals.connecttexttooltip(newbutton, locdata.name)
		if i == 'aliron':
			globals.connecttexttooltip(newbutton, locdata.name)
			newbutton.get_node('amount').text = ""
			newbutton2.get_node('Label').text = "%s" % locdata.name
		else:
			globals.connecttexttooltip(newbutton, "%s" % [locdata.name])
			newbutton.get_node('amount').text = "%d/%d" %  [free_chars[i], chars[i]]
			newbutton2.get_node('Label').text = "%s - %d/%d" % [locdata.name, free_chars[i], chars[i]]
		if locdata.type == 'capital':
			newbutton.get_node('icon').texture = images.get_icon(worlddata.lands[locdata.area].capital_icon)
			newbutton2.get_node('icon').texture = images.get_icon(worlddata.lands[locdata.area].capital_icon)
		else:
			newbutton.get_node('icon').texture = images.get_background(locdata.background)
			newbutton2.get_node('icon').texture = images.get_background(locdata.background)
		newbutton.connect("pressed", self, "select_location", [i])
		newbutton2.connect("pressed", self, "select_location", [i])
		newbutton.set_meta("data", i)
		update_buttons()


func open_infinite():
	toggle_drop_list(false)
	input_handler.selected_location = 'aliron'
	var data = ResourceScripts.world_gen.get_location_from_code(input_handler.selected_location)
	input_handler.active_location = data
	input_handler.active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[input_handler.selected_location].area]
	if gui_controller.exploration == null:
		gui_controller.exploration = input_handler.get_spec_node(input_handler.NODE_EXPLORATION, null, false, false)
	if gui_controller.exploration_city == null:
		gui_controller.exploration_city = input_handler.get_spec_node(input_handler.NODE_EXPLORATION_CITY, null, false, false)
	if gui_controller.exploration_dungeon == null:
		gui_controller.exploration_dungeon = input_handler.get_spec_node(input_handler.NODE_EXPLORATION_DUNGEON, null, false, false)
	if gui_controller.current_screen == gui_controller.mansion:
		input_handler.PlaySound("door_open")
		gui_controller.previous_screen = gui_controller.current_screen
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
#		gui_controller.open_exploration(location)
		gui_controller.mansion.hide()
	gui_controller.nav_panel.build_accessible_locations()
	gui_controller.close_all_closeable_windows()
	
	var presented_characters = []
	for id in ResourceScripts.game_party.character_order:
		var i = ResourceScripts.game_party.characters[id]
		if i.check_location(data.id, true):
			presented_characters.append(i)
	if presented_characters.size() == 0:
		select_location('aliron')
		return
	gui_controller.current_screen = gui_controller.exploration_dungeon
	gui_controller.exploration_dungeon.open_location(data)
	gui_controller.exploration_dungeon.show()
	gui_controller.exploration_city.hide()
	gui_controller.exploration.hide()


func select_location(location):
	toggle_drop_list(false)
	input_handler.selected_location = location
	input_handler.active_location = ResourceScripts.world_gen.get_location_from_code(location)
	input_handler.active_area = ResourceScripts.game_world.areas[ResourceScripts.game_world.location_links[location].area] #only for postloading location change, cause this forces exploration node to be built before open_X call
	if gui_controller.exploration == null:
		gui_controller.exploration = input_handler.get_spec_node(input_handler.NODE_EXPLORATION, null, false, false)
	if gui_controller.exploration_city == null:
		gui_controller.exploration_city = input_handler.get_spec_node(input_handler.NODE_EXPLORATION_CITY, null, false, false)
	if gui_controller.exploration_dungeon == null:
		gui_controller.exploration_dungeon = input_handler.get_spec_node(input_handler.NODE_EXPLORATION_DUNGEON, null, false, false)

	if gui_controller.current_screen == gui_controller.mansion:
		input_handler.PlaySound("door_open")
		gui_controller.previous_screen = gui_controller.current_screen
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
#		gui_controller.open_exploration(location)
		gui_controller.mansion.hide()
	else:
		ResourceScripts.core_animations.BlackScreenTransition(0.5)
		yield(get_tree().create_timer(0.5), 'timeout')
	
	gui_controller.nav_panel.build_accessible_locations()
	gui_controller.close_all_closeable_windows()
	
	if location in ResourceScripts.game_world.capitals:
		#planned_loc_events for now is only for cities
		ResourceScripts.game_progress.try_planned_loc_event(location)
		
		gui_controller.current_screen = gui_controller.exploration_city
		gui_controller.exploration_city.open_city(location)#
		gui_controller.exploration_dungeon.hide()
		gui_controller.exploration.hide()
		gui_controller.exploration_city.show()
		gui_controller.clock.raise()
		gui_controller.clock.show()
#		var data = ResourceScripts.world_gen.get_location_from_code(location)
#		gui_controller.current_screen = gui_controller.exploration_dungeon
#		gui_controller.exploration_dungeon.open_location(data)
#		gui_controller.exploration_dungeon.show()
#		gui_controller.exploration_city.hide()
#		gui_controller.exploration.hide()
	else:
		var data = ResourceScripts.world_gen.get_location_from_code(location)
		var presented_characters = []
		for id in ResourceScripts.game_party.character_order:
			var i = ResourceScripts.game_party.characters[id]
			if i.check_location(data.id, true):
				presented_characters.append(i)
		if presented_characters.size() == 0:
			select_location('aliron')
			return
		else:
			if data.type == 'dungeon':
				gui_controller.current_screen = gui_controller.exploration_dungeon
				gui_controller.exploration_dungeon.open_location(data)
				gui_controller.exploration_dungeon.show()
				gui_controller.exploration_city.hide()
				gui_controller.exploration.hide()
			else:
				gui_controller.current_screen = gui_controller.exploration
				gui_controller.exploration.open_location(data)
				gui_controller.exploration.show()
				gui_controller.exploration_city.hide()
				gui_controller.exploration_dungeon.hide()

#	gui_controller.exploration.show()



func return_to_mansion(with_state = "default"):
	toggle_drop_list(false)
	if gui_controller.current_screen == gui_controller.mansion:
		build_accessible_locations()
		update_buttons()
		return
	ResourceScripts.core_animations.BlackScreenTransition()
	yield(get_tree().create_timer(0.5), 'timeout')
	if gui_controller.exploration != null:
		gui_controller.exploration.get_node("LocationGui").hide()
		gui_controller.exploration.set_process_input(false)
		gui_controller.exploration.visible = false
	if gui_controller.exploration_dungeon != null:
		gui_controller.exploration_dungeon.get_node("LocationGui").hide()
		gui_controller.exploration_dungeon.set_process_input(false)
		gui_controller.exploration_dungeon.visible = false
	if gui_controller.exploration_city != null:
		gui_controller.exploration_city.visible = false
	gui_controller.previous_screen = null
	gui_controller.current_screen = gui_controller.mansion
	if gui_controller.exploration_city != null:
		gui_controller.exploration_city.previous_guild = ''
	input_handler.PlaySound("door_open")
	input_handler.StopBackgroundSound()
	input_handler.SetMusicRandom("mansion")
	
	if !ResourceScripts.game_progress.planned_mansion_events.empty():
		var to_rem = []
		for i in ResourceScripts.game_progress.planned_mansion_events:
			if globals.checkreqs(scenedata.scenedict[i].duplicate(true).reqs):
				input_handler.interactive_message(i, '', {})
				to_rem.append(i)
		for rem in to_rem:
			ResourceScripts.game_progress.planned_mansion_events.erase(rem)
	
	gui_controller.mansion.show()
	gui_controller.mansion.raise()
	gui_controller.clock.show()
	gui_controller.clock.raise()
	gui_controller.exploration_city.get_node("GuildBG").hide()
	gui_controller.exploration_city.active_faction = null
	gui_controller.mansion.mansion_state_set(with_state)
	gui_controller.nav_panel.build_accessible_locations()
	gui_controller.nav_panel.update_buttons()
	gui_controller.exploration.hide()
	gui_controller.close_all_closeable_windows()

	if gui_controller.dialogue != null:
		gui_controller.dialogue.raise()


func toggle_drop_list(val):
	if val and drop_panel.visible:
		val = false
	screen.visible = val
	drop_panel.visible = val
	$drop_list.pressed = val
