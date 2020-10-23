extends Node

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


var current_screen
var previous_screen
var windows_opened = []
var dialogue
var is_dialogue_just_started = true
var dialogue_window_type = 1
var dialogue_txt = ''

signal screen_changed

var window_button_connections = {}

func _ready():
	connect("screen_changed", self, "update_modules")


func update_modules():
	if dialogue != null && dialogue.is_visible_in_tree():
		dialogue.raise()
	for subscene in current_screen.get_children():
		if subscene.get_class() == "Tween":
			continue
		subscene.update()
	clock_visibility()

func clock_visibility():
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


func close_scene(scene):
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
		previous_screen = null
	if current_screen == mansion:
		mansion.mansion_state_set("default")
		gui_controller.clock.raise()
		gui_controller.clock.show()
	if current_screen == explore_slaveinfo && previous_screen == exploration:
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
	if !weakref(node).get_ref():
		windows_opened.erase(node)
		if window_button_connections.keys().has(node):
			window_button_connections.erase(node)
			return
	if window_button_connections.keys().has(node) && window_button_connections[node] != null:
		window_button_connections[node].pressed = false
		windows_opened.erase(node)
		return
	if typeof(node) == TYPE_STRING:
		return
	elif ResourceScripts.core_animations.BeingAnimated.has(node):
		return
	node.hide()
	windows_opened.erase(node)
	#CloseableWindowsArray.pop_back(); #i think this is required #It's not, breaks multiple windows order


func close_all_closeable_windows():
	while windows_opened.size() > 0:
		close_top_window()



func gamemenu_esc_rmb_handler(event):
	var submodules = game_menu.submodules
	if submodules != []:
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

func win_btn_connections_handler(pressed, window, button):
	if pressed:
		gui_controller.window_button_connections[window] = button
	else:
		gui_controller.window_button_connections[window] = null
	if pressed && !gui_controller.windows_opened.has(window):
		gui_controller.windows_opened.append(window)
