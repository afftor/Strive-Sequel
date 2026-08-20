extends Node

#Central hotkey registry.
#Every rebindable key lives in action_data, gets registered in the InputMap as an 'hk_'
#action, and is dispatched from input_handler._input() through dispatch().
#
#Each action belongs to a context. Global actions always fire; mansion and combat actions
#only fire while that screen is the active one, and the two are mutually exclusive - so the
#same physical key can mean 'advance one hour' in the mansion and 'use skill 1' in a battle
#without ever being ambiguous. Conflict checking follows the same rule (see find_conflict).

const CTX_GLOBAL = 'global'
const CTX_MANSION = 'mansion'
const CTX_COMBAT = 'combat'

const CONTEXT_ORDER = [CTX_GLOBAL, CTX_MANSION, CTX_COMBAT]

const PREFIX = 'hk_'
const CONFIG_FILE = 'Hotkeys.ini'
const CONFIG_SECTION = 'hotkeys'
const NO_KEY = 0

#'default' is a scancode, optionally OR'ed with KEY_MASK_* bits for modifiers.
#Order here is the order the options list is built in.
var action_data = {
	#--- global ---
	quicksave = {context = CTX_GLOBAL, default = KEY_F5},
	quickload = {context = CTX_GLOBAL, default = KEY_F9},
	fullscreen = {context = CTX_GLOBAL, default = KEY_F11},
	#--- mansion ---
	mansion_time_1 = {context = CTX_MANSION, default = KEY_1},
	mansion_time_2 = {context = CTX_MANSION, default = KEY_2},
	mansion_time_3 = {context = CTX_MANSION, default = KEY_3},
	mansion_work = {context = CTX_MANSION, default = KEY_W},
	mansion_travels = {context = CTX_MANSION, default = KEY_T},
	mansion_upgrades = {context = CTX_MANSION, default = KEY_U},
	mansion_sex = {context = CTX_MANSION, default = KEY_D},
	mansion_inventory = {context = CTX_MANSION, default = KEY_I},
	mansion_craft = {context = CTX_MANSION, default = KEY_C},
	mansion_journal = {context = CTX_MANSION, default = KEY_J},
	mansion_menu = {context = CTX_MANSION, default = KEY_O},
	mansion_char_info = {context = CTX_MANSION, default = KEY_P},
	mansion_tutorial = {context = CTX_MANSION, default = KEY_F1},
	#--- combat ---
	combat_skill_1 = {context = CTX_COMBAT, default = KEY_1},
	combat_skill_2 = {context = CTX_COMBAT, default = KEY_2},
	combat_skill_3 = {context = CTX_COMBAT, default = KEY_3},
	combat_skill_4 = {context = CTX_COMBAT, default = KEY_4},
	combat_skill_5 = {context = CTX_COMBAT, default = KEY_5},
	combat_skill_6 = {context = CTX_COMBAT, default = KEY_6},
	combat_skill_7 = {context = CTX_COMBAT, default = KEY_7},
	combat_skill_8 = {context = CTX_COMBAT, default = KEY_8},
	combat_skill_9 = {context = CTX_COMBAT, default = KEY_9},
	combat_row_up = {context = CTX_COMBAT, default = KEY_Q},
	combat_row_down = {context = CTX_COMBAT, default = KEY_E},
	combat_skillbook = {context = CTX_COMBAT, default = KEY_B},
	combat_items = {context = CTX_COMBAT, default = KEY_I},
	combat_run = {context = CTX_COMBAT, default = KEY_R},
}

var bindings = {} #code:scancode

#set by the options panel while it waits for a key, so nothing else reacts to that press
var capturing = false

#panels that print a key in their tooltip listen to this to stay truthful after a rebind
signal bindings_changed


func _init():
	for code in action_data:
		bindings[code] = action_data[code].default
	load_bindings()
	apply_all()


#### storage ####

func load_bindings():
	var config = ConfigFile.new()
	if config.load(variables.userfolder + CONFIG_FILE) != OK:
		return
	if !config.has_section(CONFIG_SECTION):
		return
	for code in config.get_section_keys(CONFIG_SECTION):
		if !bindings.has(code): #binding of an action that no longer exists
			continue
		bindings[code] = int(config.get_value(CONFIG_SECTION, code, bindings[code]))


func save_bindings():
	var config = ConfigFile.new()
	for code in bindings:
		config.set_value(CONFIG_SECTION, code, bindings[code])
	config.save(variables.userfolder + CONFIG_FILE)


#### InputMap ####

func apply_all():
	for code in action_data:
		apply_action(code)


func apply_action(code):
	var action = PREFIX + code
	if InputMap.has_action(action):
		InputMap.erase_action(action)
	InputMap.add_action(action)
	if bindings[code] == NO_KEY:
		return
	InputMap.action_add_event(action, make_event(bindings[code]))
	#the number row and the numpad have always been interchangeable in this game, keep it so
	var key = bindings[code] & KEY_CODE_MASK
	if key >= KEY_0 and key <= KEY_9:
		InputMap.action_add_event(action, make_event(bindings[code] - KEY_0 + KEY_KP_0))


func make_event(scancode):
	var event = InputEventKey.new()
	event.scancode = scancode & KEY_CODE_MASK
	event.control = (scancode & KEY_MASK_CTRL) != 0
	event.shift = (scancode & KEY_MASK_SHIFT) != 0
	event.alt = (scancode & KEY_MASK_ALT) != 0
	return event


#packs an incoming key press back into a scancode+modifiers int. Returns NO_KEY for
#presses that carry no key of their own (a bare Shift/Ctrl/Alt is not a binding)
func event_to_scancode(event):
	if !(event is InputEventKey):
		return NO_KEY
	if event.scancode in [KEY_SHIFT, KEY_CONTROL, KEY_ALT, KEY_META]:
		return NO_KEY
	var scancode = event.scancode
	if event.control: scancode |= KEY_MASK_CTRL
	if event.shift: scancode |= KEY_MASK_SHIFT
	if event.alt: scancode |= KEY_MASK_ALT
	return scancode


#### rebinding ####

func get_scancode_text(scancode):
	if scancode == NO_KEY:
		return tr("HOTKEY_UNBOUND")
	return OS.get_scancode_string(scancode)


func get_binding_text(code):
	return get_scancode_text(bindings[code])


func get_action_name(code):
	return tr("HOTKEY_" + code.to_upper())


#tooltip body for a button that has a hotkey - an unbound action just gets its own name
func get_tooltip_text(name_key, code):
	var text = tr(name_key)
	if bindings.get(code, NO_KEY) != NO_KEY:
		text += "\n" + tr("HOTKEY_TOOLTIP") % get_binding_text(code)
	return text


func contexts_overlap(context1, context2):
	return context1 == CTX_GLOBAL or context2 == CTX_GLOBAL or context1 == context2


#returns the code of an already bound action that would clash with 'scancode' if it was
#given to 'code', or an empty string when the key is free
func find_conflict(code, scancode):
	if scancode == NO_KEY:
		return ''
	for other in action_data:
		if other == code:
			continue
		if bindings[other] != scancode:
			continue
		if contexts_overlap(action_data[code].context, action_data[other].context):
			return other
	return ''


#unbinds whatever else held the key, so the player never ends up with a dead binding
func set_binding(code, scancode):
	if !bindings.has(code):
		return
	var conflict = find_conflict(code, scancode)
	if conflict != '':
		bindings[conflict] = NO_KEY
		apply_action(conflict)
	bindings[code] = scancode
	apply_action(code)
	save_bindings()
	emit_signal("bindings_changed")


func reset_binding(code):
	set_binding(code, action_data[code].default)


func reset_all():
	for code in action_data:
		bindings[code] = action_data[code].default
	apply_all()
	save_bindings()
	emit_signal("bindings_changed")


#### dispatch ####

func get_active_context():
	if input_handler.combat_node != null and is_instance_valid(input_handler.combat_node) \
		and input_handler.combat_node.visible:
		return CTX_COMBAT
	var mansion = gui_controller.mansion
	if mansion != null and is_instance_valid(mansion) and mansion.visible:
		var screen = gui_controller.current_screen
		#the travel map and the upgrades panel are mansion children that claim current_screen
		#while open - they are still the mansion as far as hotkeys are concerned. Panels that
		#live outside it (inventory, character info, game menu) are their own screens
		if screen == mansion or (screen != null and is_instance_valid(screen) \
			and screen is Node and mansion.is_a_parent_of(screen)):
			return CTX_MANSION
	return ''


#modal panels and text entry own the keyboard while they are up
func is_input_blocked():
	if capturing or input_handler.hard_tutorial_active or input_handler.text_field_input:
		return true
	if input_handler.text_field_focused():
		return true
	var dialogue = gui_controller.dialogue
	if dialogue != null and is_instance_valid(dialogue) and dialogue.is_visible_in_tree():
		return true
	for node in get_tree().get_nodes_in_group("disable_rmb_esc"):
		if node.is_visible_in_tree():
			return true
	return false


#returns true when the press was consumed
func dispatch(event):
	if !(event is InputEventKey) or !event.pressed or event.is_echo():
		return false
	if is_input_blocked():
		return false
	var context = get_active_context()
	for code in action_data:
		var action_context = action_data[code].context
		if action_context != CTX_GLOBAL and action_context != context:
			continue
		if !event.is_action_pressed(PREFIX + code):
			continue
		return run_action(code)
	return false


func run_action(code):
	if code.begins_with('mansion_'):
		return run_mansion_action(code)
	if code.begins_with('combat_'):
		return input_handler.combat_node.hotkey_action(code)
	match code:
		'quicksave':
			return globals.QuickSave()
		'quickload':
			return globals.QuickLoad()
		'fullscreen':
			OS.window_fullscreen = !OS.window_fullscreen
			input_handler.globalsettings.fullscreen = OS.window_fullscreen
			if !input_handler.globalsettings.fullscreen:
				OS.window_position = Vector2(0, 0)
			return true
	return false


func run_mansion_action(code):
	#the map hides the rest of the mansion and holds current_screen while it is open, and
	#unlike the other panels it has no hide() of its own, so match_state() cannot dismiss it.
	#Close it properly first, and let the travels key be what closes it
	var map = gui_controller.mansion.get_node_or_null("map")
	if map != null and map.visible:
		map.close()
		if code == 'mansion_travels':
			return true
	match code:
		'mansion_time_1':
			return advance_turn(1)
		'mansion_time_2':
			return advance_turn(2)
		'mansion_time_3':
			return advance_turn(4)
		'mansion_char_info':
			if gui_controller.mansion.active_person == null:
				return false
			gui_controller.mansion.mansion_state_set("char_info")
			return true
		'mansion_tutorial':
			return toggle_tutorial()
	return gui_controller.mansion.MenuModule.activate_category(code.trim_prefix('mansion_'))


func advance_turn(amount):
	var clock = gui_controller.clock
	if clock == null or !is_instance_valid(clock) or !clock.is_visible_in_tree():
		return false
	clock.advance_turn(amount)
	return true


func toggle_tutorial():
	var panel = gui_controller.mansion_tutorial_panel
	if panel == null or !is_instance_valid(panel) or !panel.is_visible():
		gui_controller.mansion.show_tutorial()
	else:
		panel.hide()
	return true
