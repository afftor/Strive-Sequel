extends Tabs

#Hotkeys tab of the options panel. Lists every action from the hotkeys singleton grouped by
#context and rebinds them by grabbing the next key press.

var key_buttons = {} #code:button
var awaiting = '' #action code currently waiting for a key, empty when idle


func _ready():
	$Reset.connect("pressed", self, "reset_all")
	set_process_input(false)
	build()


func build():
	var box = $Scroll/Box
	input_handler.ClearContainer(box, ['Entry', 'Header'])
	key_buttons.clear()
	for context in hotkeys.CONTEXT_ORDER:
		var header = input_handler.DuplicateContainerTemplate(box, 'Header')
		header.text = "HOTKEYGROUP_" + context.to_upper() #labels are auto-translated
		for code in hotkeys.action_data:
			if hotkeys.action_data[code].context != context:
				continue
			var entry = input_handler.DuplicateContainerTemplate(box, 'Entry')
			entry.get_node("Label").text = "HOTKEY_" + code.to_upper()
			var button = entry.get_node("Key")
			button.connect("pressed", self, "start_capture", [code])
			key_buttons[code] = button
	update_labels()


func update_labels():
	for code in key_buttons:
		if code == awaiting:
			continue
		key_buttons[code].text = hotkeys.get_binding_text(code)


func start_capture(code):
	if awaiting != '':
		update_labels()
	awaiting = code
	hotkeys.capturing = true
	key_buttons[code].text = tr("HOTKEY_PRESSKEY")
	#otherwise the button keeps focus and Space/Enter would re-open the capture later
	key_buttons[code].release_focus()
	set_process_input(true)


func finish_capture():
	awaiting = ''
	hotkeys.capturing = false
	set_process_input(false)
	update_labels()


func _input(event):
	if awaiting == '':
		return
	if !(event is InputEventKey) or !event.pressed or event.is_echo():
		return
	get_tree().set_input_as_handled()
	var code = awaiting
	if event.scancode == KEY_ESCAPE:
		finish_capture()
		return
	if event.scancode in [KEY_DELETE, KEY_BACKSPACE]:
		hotkeys.set_binding(code, hotkeys.NO_KEY)
		finish_capture()
		return
	var scancode = hotkeys.event_to_scancode(event)
	if scancode == hotkeys.NO_KEY: #a bare modifier, keep waiting for a real key
		return
	var conflict = hotkeys.find_conflict(code, scancode)
	hotkeys.set_binding(code, scancode)
	if conflict != '':
		input_handler.SystemMessage(tr("HOTKEY_CONFLICT") % [hotkeys.get_scancode_text(scancode), hotkeys.get_action_name(conflict)])
	finish_capture()


func reset_all():
	if awaiting != '':
		finish_capture()
	hotkeys.reset_all()
	update_labels()


#the panel can be closed from outside while a key is awaited - never leave input captured
func _notification(what):
	if what == NOTIFICATION_VISIBILITY_CHANGED and awaiting != '' and !is_visible_in_tree():
		finish_capture()
