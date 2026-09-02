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
	hotkeys.connect("bindings_changed", self, "build_travel_tooltip")
	build_travel_tooltip()


func build_travel_tooltip():
	globals.connecttexttooltip($travelbutton, hotkeys.get_tooltip_text("BUTTONTRAVEL", 'mansion_travels'))

func tut_register_aliron_btn():
	input_handler.register_btn_source('aliron_btn', self, 'tut_get_aliron')
func tut_register_mansion_btn():
	input_handler.register_btn_source('mansion_btn', self, 'tut_get_mansion')
func tut_register_travel_btn():
	input_handler.register_btn_source('travel_btn', self, 'tut_get_travelbutton')
func tut_register_wolves_btn():
	input_handler.register_btn_source('quest_loc_nav_btn', self, 'tut_get_threat_wolves')
	input_handler.register_btn_source('quest_loc_nav_explore_btn', self,
		'tut_get_threat_wolves_explore')
	input_handler.register_btn_source('quest_loc_nav_work_btn', self,
		'tut_get_threat_wolves_work')


#Which navigation strip the tutorial is pointing at. Every screen carries its own copy of this
#panel and gui_controller.nav_panel is the one the player is looking at, so answering with
#`self` would go on naming buttons on the screen the lesson happened to start on. They stay
#alive when that screen is merely hidden, and they sit at exactly the coordinates of the strip
#that replaced them - a step framing one of those looks right and is deaf to every click.
func tut_nav():
	var live = gui_controller.nav_panel
	if live != null and is_instance_valid(live):
		return live
	return self


func tut_strip():
	return tut_nav().get_node("NavigationContainer/AreaSelection")


func tut_get_aliron():
	for btn in tut_strip().get_children():
		if btn.get_meta("data", "") == 'aliron':
			return btn
func tut_get_mansion():
	return tut_strip().get_children()[0]
func tut_get_travelbutton():
	return tut_nav().get_node("travelbutton")
func tut_get_threat_wolves():
	var loc_id
	for id in ResourceScripts.game_world.areas['plains'].questlocations:
		if ResourceScripts.game_world.areas['plains'].questlocations[id].code == 'tutorial_threat_wolves':
			loc_id = id
			break
	for btn in tut_strip().get_children():
		if btn.get_meta("data", "") == loc_id:
			return btn

#A place on this strip is not entered by pressing it - the button carries no press of its own.
#Hovering it swaps its picture for the pair inside it, and Explore is the one that goes there
#(configure_location_choices). A lesson that says "select it to enter" has to wait for that
#press, not for the picture's.
func tut_get_threat_wolves_explore():
	var button = tut_get_threat_wolves()
	if button == null or !button.has_node("LocationChoices/Combat"):
		return null
	return button.get_node("LocationChoices/Combat")


#The other half of that pair. The lesson frames the whole picture, because that is the thing
#the player has to find, and hovering it splits the frame between Work and Explore - aiming at
#the middle lands on Work as often as not, which staffs the place from the mansion instead of
#going there. It is named by the step only so it can be barred for the length of it.
func tut_get_threat_wolves_work():
	var button = tut_get_threat_wolves()
	if button == null or !button.has_node("LocationChoices/Work"):
		return null
	return button.get_node("LocationChoices/Work")


func open_travel():
	var map = gui_controller.mansion.get_node("map")
	if gui_controller.current_screen == gui_controller.mansion:
		map.set_return_context(null, null, null)
	else:
		map.set_return_context(gui_controller.current_screen, self, input_handler.selected_location)
		gui_controller.mansion.show()
		gui_controller.mansion.raise()
	#gui_controller.current_screen == gui_controller.mansion
	gui_controller.mansion.mansion_state = "travels"
#	gui_controller.mansion.show_map()

func update_buttons():
	nav = gui_controller.nav_panel.get_node("NavigationContainer/AreaSelection")
	var in_mansion = gui_controller.current_screen == gui_controller.mansion || gui_controller.current_screen == gui_controller.inventory
	for button in nav.get_children():
		if button.name == "Button" || !(button is BaseButton) || !button.has_meta("data"):
			continue
		if in_mansion:
			#Standing in the mansion does not mean looking at the mansion: its screen can be
			#showing another place's work, and that place is where the player is in every
			#sense that matters here. Marking Mansion regardless left the strip claiming they
			#were home while they were staffing Millford.
			button.pressed = button.get_meta("data") == mansion_place_shown()
		else:
			button.pressed = input_handler.selected_location == button.get_meta("data")


#Puts the mansion screen back on its own rooms, whichever way the player got here.
func show_mansion_rooms(with_state = "default"):
	var rooms = mansion_rooms()
	if rooms != null:
		rooms.set_local_tasks(false)
		rooms.set_place(rooms.LocationTasks.MANSION_CODE)
	if gui_controller.mansion != null:
		gui_controller.mansion.mansion_state_set(with_state)


#Which entry on the strip the mansion screen is currently answering for. "Mansion" is its own
#entry, separate from the town of Aliron, so the estate's own work answers as that one.
func mansion_place_shown():
	var rooms = mansion_rooms()
	if rooms == null or rooms.in_mansion():
		return "Mansion"
	return rooms.place


func mansion_rooms():
	if gui_controller.mansion == null:
		return null
	return gui_controller.mansion.get_node_or_null("MansionRoomsModule")


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
	#A place is on this strip because the player has somebody there - but a quest waiting where
	#nobody is standing is exactly the thing worth being told about, and it would have had no
	#button to be told on. Those places join the strip, showing 0 of 0.
	for where in ResourceScripts.game_res.unstaffed_quest_locations():
		if where == "aliron" or location_array.has(where):
			continue
		if ResourceScripts.world_gen.get_location_from_code(where) == null:
			continue
		location_array.append(where)
		free_chars[where] = 0
		chars[where] = 0
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
			globals.connecttexttooltip(newbutton, tr("MANSION_LABEL"))
			newbutton.get_node('amount').text = "%d/%d" % [free_chars.aliron, chars.aliron]
			newbutton2.get_node('Label').text = "%s - %d/%d" % [tr("MANSION_LABEL"), free_chars.aliron, chars.aliron]
			newbutton.set_meta("data", i)
#			newseparator.visible = true
			continue
		if i == "Infinite":
#			newbutton.text = tr("INFINITEDUNGEONNAME")
			globals.connecttexttooltip(newbutton, tr("INFINITEDUNGEONNAME"))
			newbutton2.get_node('Label').text = tr("INFINITEDUNGEONNAME")
			newbutton.get_node('amount').text = "" #temp solution
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
			globals.connecttexttooltip(newbutton, tr(locdata.name))
			newbutton.get_node('amount').text = ""
			newbutton2.get_node('Label').text = "%s" % tr(locdata.name)
		else:
			globals.connecttexttooltip(newbutton, "%s" % [tr(locdata.name)])
			newbutton.get_node('amount').text = "%d/%d" %  [free_chars[i], chars[i]]
			newbutton2.get_node('Label').text = "%s - %d/%d" % [tr(locdata.name), free_chars[i], chars[i]]
		if locdata.type == 'capital':
			newbutton.get_node('icon').texture = images.get_icon(worlddata.lands[locdata.area].capital_icon)
			newbutton2.get_node('icon').texture = images.get_icon(worlddata.lands[locdata.area].capital_icon)
		else:
			newbutton.get_node('icon').texture = images.get_background(locdata.background)
			newbutton2.get_node('icon').texture = images.get_background(locdata.background)
		if locdata.type == 'capital':
			newbutton.connect("pressed", self, "select_location", [i])
			newbutton2.connect("pressed", self, "select_location", [i])
		else:
			configure_location_choices(newbutton, i)
			configure_location_choices(newbutton2, i)
		newbutton.set_meta("data", i)
	#the screen's own bar can move it too, so the strip follows the place rather than being
	#told about it only by the buttons on this panel
	var rooms = mansion_rooms()
	if rooms != null and !rooms.is_connected("place_changed", self, "on_mansion_place_changed"):
		rooms.connect("place_changed", self, "on_mansion_place_changed")
	update_buttons()
	refresh_quest_shimmers()


func on_mansion_place_changed(_code = null):
	update_buttons()


#The same sheen the Local tasks button wears, for a place with a quest standing on it that
#nobody is doing. Built in code rather than added to the scene: the strip's buttons are made
#by duplicating one template, and an overlay put there by hand would be copied onto the
#capitals and the tower as well, which have no work to call anybody to.
const SHIMMER_SHADER = preload("res://gui_modules/Mansion/Modules/quest_attention_shimmer.shader")


func quest_shimmer_for(button, index):
	var sheen = button.get_node_or_null("QuestAttentionShimmer")
	if sheen != null:
		return sheen
	sheen = ColorRect.new()
	sheen.name = "QuestAttentionShimmer"
	sheen.color = Color(1, 1, 1, 1)
	sheen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sheen.anchor_right = 1.0
	sheen.anchor_bottom = 1.0
	sheen.visible = false
	var material = ShaderMaterial.new()
	material.shader = SHIMMER_SHADER
	#a row of buttons all sweeping together reads as one blinking bar, so each is nudged
	#along the cycle by a fixed step
	material.set_shader_param("phase", float(index) * 0.37)
	sheen.material = material
	button.add_child(sheen)
	return sheen


#What the strip was last told, so the buttons are only walked when the answer has changed.
var quest_shimmer_signature = ""


#Putting somebody on a quest emits no signal anyone here could listen for, so the question is
#asked each frame - but only the short list of quest tasks is built. The buttons are touched
#only when that list turns into a different answer than last time.
func _process(_delta):
	if nav == null or !is_visible_in_tree():
		return
	var waiting = ResourceScripts.game_res.unstaffed_quest_locations()
	var signature = PoolStringArray(waiting.keys()).join(",")
	if signature == quest_shimmer_signature:
		return
	quest_shimmer_signature = signature
	refresh_quest_shimmers(waiting)


func refresh_quest_shimmers(waiting = null):
	if nav == null:
		return
	if waiting == null:
		waiting = ResourceScripts.game_res.unstaffed_quest_locations()
	var index = 0
	for button in nav.get_children():
		if button.name == "Button" or !(button is BaseButton) or !button.has_meta("data"):
			continue
		var code = button.get_meta("data")
		#The estate already says so on its own Local tasks button, which is where the player
		#goes to staff it. Saying it a second time here would put two lights on one fact and
		#send them to the strip for something the strip cannot do anything about.
		var sheen = button.get_node_or_null("QuestAttentionShimmer")
		var wanted = code != "Mansion" and code != "aliron" and waiting.has(code)
		if wanted and sheen == null:
			sheen = quest_shimmer_for(button, index)
		if sheen != null:
			sheen.visible = wanted
		index += 1


func configure_location_choices(button, location):
	var choices = button.get_node("LocationChoices")
	var work_button = choices.get_node("Work")
	var explore_button = choices.get_node("Combat")
	work_button.text = tr("MSLMNAVWORK")
	explore_button.text = tr("MSLMNAVEXPLORE")
	work_button.connect("pressed", self, "open_location_work", [location])
	explore_button.connect("pressed", self, "select_location", [location])
	button.connect("mouse_entered", self, "show_location_choices", [button])
	button.connect("mouse_exited", self, "defer_hide_location_choices", [button])
	choices.connect("mouse_exited", self, "defer_hide_location_choices", [button])
	work_button.connect("mouse_exited", self, "defer_hide_location_choices", [button])
	explore_button.connect("mouse_exited", self, "defer_hide_location_choices", [button])


func show_location_choices(button):
	button.get_node("icon").hide()
	if button.has_node("amount"):
		button.get_node("amount").hide()
	if button.has_node("Label"):
		button.get_node("Label").hide()
	button.get_node("LocationChoices").show()


func defer_hide_location_choices(button):
	call_deferred("hide_location_choices_if_outside", button)


func hide_location_choices_if_outside(button):
	if !is_instance_valid(button) || button.get_global_rect().has_point(button.get_global_mouse_position()):
		return
	button.get_node("LocationChoices").hide()
	button.get_node("icon").show()
	if button.has_node("amount"):
		button.get_node("amount").show()
	if button.has_node("Label"):
		button.get_node("Label").show()


func open_location_work(location):
	toggle_drop_list(false)
	if gui_controller.current_screen != gui_controller.mansion:
		yield(return_to_mansion(), "completed")
	#The estate's own tasks and another place's are the same screen asking about different
	#ground: set_local_tasks pins it to the estate, so going through it on the way to Millford
	#would show the estate for a frame first. Each is asked for directly instead.
	var rooms = gui_controller.mansion.RoomsModule
	if location == rooms.LocationTasks.MANSION_CODE:
		rooms.set_local_tasks(true)
	else:
		rooms.set_place(location)


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
	if input_handler.active_location == null:
		return_to_mansion()
		return
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
		#Already at home, so there is no journey to make - but the screen may be standing on
		#another place's work, which is what the player is asking to leave.
		show_mansion_rooms(with_state)
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
	#Coming back from somewhere else, the screen is still standing on that place's work: the
	#journey home has to put it on the estate's own rooms as well, or the strip goes on
	#marking the place just left as the one being looked at.
	show_mansion_rooms(with_state)
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
