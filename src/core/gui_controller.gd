extends Node

# These vars are holding the references to the corresponding scenes.
var mansion
var nav_panel
var clock
var exploration
var explore_slaveinfo
var slavepanel
var inventory
var game_menu
var classinfo
var sex_panel
var date_panel
var mansion_tutorial_panel
var cheat_panel
var char_creation
var dialogue
var travel
var upgrades


var current_screen #reference to the current scene visible (Mansion, Exploration, Inventory, etc.).
var previous_screen #reference to the just-closed scene (Mansion, Exploration, etc.). Sometimes needed gui_controller to handle modules visibility.
var windows_opened = [] #an array of references to opened sub-modules (MansionJournal, GameMenu, etc.)
var window_button_connections = {} #a dictionary that contains pairs of sub-modules and corresponding buttons. A depth explanation can be found below.

var is_dialogue_just_started = true #a helper member which helps to handle InteractiveMessage module rendering.
var dialogue_window_type = 1 #holds an InteractiveMessage module type. (There are two different scenes for the that InteractiveMessageModuleAnimated.tscn and QuestDialogue.tscn)
var dialogue_txt = '' #holding text from previous dialogue scene type in case this type needs to be changed while dialogue still not finished.

signal screen_changed # You can call this if you need to force mudules update

# Visibility of submodules of main scenes with a lot of submodules (Mansion, Inventory, etc.) is handled by corresponding main modules.
# Basically, it is a set of switch statements in main modules that checks whether or not some modules should be updated or visible based on certain conditions.

# Ex. 
# CharInfoMainModule.gd

# func match_state():
# 	$CloseButton.visible = !ClassesModule.get_node("ClassPanel").is_visible()
# 	match char_module_state:
# 		"default":
# 			DetailsModule.hide()
# 			DietModule.hide()
# 			ClassesModule.hide()
# 			SummaryModule.update_buttons()
# 			DetailsModule.get_node("SexTraitsPanel").hide()
# 		"class":
# 			DetailsModule.hide()
# 			DietModule.hide()
# 			ClassesModule.class_category("all")
# 			ClassesModule.show()
# 			DetailsModule.get_node("SexTraitsPanel").hide()
# 		"details":
# 			...


func _ready():
	connect("screen_changed", self, "update_modules")


func update_modules():
	if current_screen == null:
		return
	if dialogue != null && dialogue.is_visible_in_tree():
		dialogue.raise()
	for subscene in current_screen.get_children():
		if subscene.get_class() == "Tween":
			continue
		subscene.update()
		if subscene == nav_panel:
			nav_panel.update_buttons()
	clock_visibility()


func clock_visibility():
	if !current_screen in [mansion, exploration]:
		if clock != null:
			clock.visible = false
		return
	if exploration == null:
		clock.visible = current_screen == mansion || current_screen == game_menu
	else:
		clock.visible = ((current_screen == mansion || current_screen == exploration) && !exploration.get_node("LocationGui").is_visible()) || current_screen == game_menu


func add_close_button(scene, position = "snap"):
	var closebuttonoffset = [0, 0]
	if position == "add_offset":
		closebuttonoffset = [15, 15]
	var pos_in_tree = scene.get_child_count()
	scene.rect_pivot_offset = Vector2(scene.rect_size.x / 2, scene.rect_size.y / 2)
	var closebutton = load(ResourceScripts.scenedict.close).instance()
	scene.add_child(closebutton)
	scene.move_child(closebutton, pos_in_tree)
	closebutton.connect("pressed", self, 'close_scene', [scene])
	var rect = scene.get_global_rect()
	var pos = Vector2(
		rect.end.x - closebutton.rect_size.x - closebuttonoffset[0],
		rect.position.y + closebuttonoffset[1]
	)
	closebutton.rect_global_position = pos

	return closebutton


func close_scene(scene):
	if char_creation != null && char_creation.is_visible():
		char_creation.hide()
		scene.hide()
		if previous_screen != null && (previous_screen in [mansion, slavepanel]) && current_screen != exploration:
			current_screen = previous_screen
		if current_screen != null:
			update_modules()
		return
	if scene == slavepanel:
		scene.SummaryModule.selected_person = null
	if window_button_connections.has(scene) && window_button_connections[scene] != null:
		window_button_connections[scene].pressed = false
		return
	scene.hide()
	if windows_opened.has(scene):
		windows_opened.erase(scene)
		return
	if previous_screen != null && (previous_screen in [mansion, slavepanel]):
		current_screen = previous_screen
		current_screen.raise()
		current_screen.show()
		if current_screen == slavepanel:
			previous_screen = mansion
		else:
			previous_screen = null
	if current_screen == mansion && mansion != null:
		mansion.mansion_state_set("default")
		gui_controller.clock.raise()
		gui_controller.clock.show()
	if current_screen == explore_slaveinfo and explore_slaveinfo != null && previous_screen == exploration:
		current_screen = exploration
		previous_screen = null
		var location = input_handler.active_location
		var capital = false
		capital = location.type == "capital"
		if capital:
			gui_controller.clock.raise()
			gui_controller.clock.show()
	update_modules()


func set_nav_size_postition():
	match current_screen:
		mansion:
			nav_panel.rect_position = Vector2(320, 15)


func open_exploration(location):
	exploration = input_handler.get_spec_node(input_handler.NODE_EXPLORATION)
	current_screen = exploration
	# exploration.show()
	exploration.open(location)


func show_class_info(classcode, person = null):
	if current_screen == game_menu:
		return
	if current_screen == exploration && exploration.get_node("GuildShop").is_visible() && classinfo != null && classinfo.is_visible():
		classinfo.hide()
		return
	if person == null:
		person = mansion.active_person
	var node = input_handler.get_spec_node(input_handler.NODE_CLASSINFO)  #get_class_info_panel()
	node.open(classcode, person)
	get_viewport().set_disable_input(true)
	ResourceScripts.core_animations.UnfadeAnimation(node, 0.3)
	yield(get_tree().create_timer(0.15), "timeout")
	node.show()
	get_viewport().set_disable_input(false)
	if ! windows_opened.has(node):
		windows_opened.append(node)
	classinfo = node


func close_top_window():
	var node = windows_opened.back()
	if window_button_connections.keys().has(node) && is_instance_valid(window_button_connections[node]):
		window_button_connections[node].pressed = false
		windows_opened.erase(node)
		return
	if typeof(node) == TYPE_STRING:
		return
	elif ResourceScripts.core_animations.BeingAnimated.has(node):
		return
	if node != null:
		node.hide()
	windows_opened.erase(node)
	#CloseableWindowsArray.pop_back(); #i think this is required #It's not, breaks multiple windows order


func close_all_closeable_windows():
	while windows_opened.size() > 0:
		close_top_window()
	window_button_connections.clear()



func gamemenu_esc_rmb_handler(event):
	var submodules = game_menu.submodules
	if !submodules.empty():
		submodules_handler(submodules)
	else:
		game_menu.hide()
		current_screen = previous_screen
		previous_screen = null


func is_classinfo_visible():
	var _visible = classinfo && classinfo.is_visible()
	if _visible:
		classinfo.hide()
		windows_opened.erase(classinfo)
	return _visible


func submodules_handler(submodules):
	var last_id = submodules.size() - 1
	var last = submodules[last_id]
	submodules[last_id].hide()
	submodules.erase(last)
	return submodules.size()



# There are the toggle buttons are used in some places where the logic of rendering is quite complicated. 
# Because there no easy way to handle the "pressed" state of regular buttons, the Toggle buttons used.
# When the toggle button pressed, “Window_button_connections” dictionary saves the opened scene as a key and button as a value. 
# This dictionary is used by methods in other scenes to handle opening and closing windows. (Ex. ExplorationModule.gd set_area_btn_pressed()). 
# The idea is to check if the just pressed button is the same which was pressed before that. If so, the state of the button sets as “not pressed” which automatically changes the toggle state. 
# Any “toggle” signal of these buttons connected to corresponding methods that set the visibility of a scene depending on the “pressed” state (pressed = visible, unpressed = not visible)


	
func win_btn_connections_handler(pressed, window, button = null):
	if pressed:
		window_button_connections[window] = button
	else:
		window_button_connections[window] = null
		windows_opened.erase(window)
	if pressed && !windows_opened.has(window):
		windows_opened.append(window)
