extends Control
const DecisionsData = preload("res://assets/data/Decisions.gd")

var IsActive = false
var history = []
var history_index = -1
var decisions_data = DecisionsData.new()
onready var _RichTextLabel = get_node("Console/RichTextLabel")
onready var _TextEdit = get_node("Console/TextEdit")

func _ready():
	if log_alert != null and is_instance_valid(log_alert):
		log_alert.set_alert_node(self)
		$log_alert_panel.show()
		$log_alert_panel/CheckBox.connect("toggled", self, "on_hide_errors_toggled")
		$log_alert_panel/CheckBox.pressed = input_handler.globalsettings.stop_log_alert
		$log_alert_panel/close.connect("pressed", self, "close")

func _input(event):
	if event.is_action_pressed("ConsoleOpenButton"):
		if !IsActive:
			open()
		else:
			close()
	elif IsActive and event is InputEventKey and event.pressed:
		if event.scancode == KEY_UP and history.size() > 0:
			history_index = min(history_index + 1, history.size() - 1)
			_TextEdit.text = history[history_index]
			_TextEdit.caret_position = _TextEdit.text.length()
			get_tree().set_input_as_handled()
		elif event.scancode == KEY_DOWN and history_index >= 0:
			history_index -= 1
			_TextEdit.text = history[history_index] if history_index >= 0 else ""
			_TextEdit.caret_position = _TextEdit.text.length()
			get_tree().set_input_as_handled()
		elif event.scancode == KEY_TAB:
			_handle_tab_complete()
			get_tree().set_input_as_handled()

#func _unhandled_input(event):
#	pass

func open():
	raise()
#	var place = get_tree().root.get_child_count()
#	get_tree().root.call_deferred("move_child",self,place)
	
#	if IsActive: return
	#get_tree().root.set_disable_input(true)
	IsActive = true
	visible = true

func close():
#	if !IsActive: return
	#get_tree().root.set_disable_input(false)
	visible = false
	IsActive = false

func _on_TextEdit_text_entered(new_text):
	history.push_front(new_text)
	history_index = -1
	_TextEdit.clear()
	var splitstring = new_text.split(" ")
	if splitstring[0] == "/do" :
		var jsonstring = JSON.parse(splitstring[1])
		
		if jsonstring.error:
			add_text(jsonstring.error_string + "\n")
			return
		
		var command = [jsonstring.result]
		
		var a = globals.common_effects(command)
		
		var output_text = new_text + "\n"
		
		if a != null:
			output_text += a + "\n"
		else:
			output_text += "Command complete\n"
		add_text(output_text)
	elif splitstring[0] == "/add_item":
		if splitstring.size() < 2:
			add_text("/add_item requires an item code\n")
			return
		var item_code = splitstring[1]
		var QUALITIES = ['poor', 'average', 'good', 'epic', 'legendary']
		var count = 1
		var quality = ""
		if splitstring.size() >= 3:
			if splitstring[2] in QUALITIES:
				quality = splitstring[2]
			else:
				count = int(splitstring[2])
				if splitstring.size() >= 4 and splitstring[3] in QUALITIES:
					quality = splitstring[3]
		var command
		if Items.itemlist.has(item_code):
			var item_data = Items.itemlist[item_code]
			var effect = {code = 'add_item', item = item_code, number = count}
			if quality != "":
				if item_data.type == 'gear':
					effect['quality'] = quality
				else:
					add_text("Note: quality ignored (not a gear item)\n")
			command = [effect]
		elif Items.materiallist.has(item_code):
			if quality != "":
				add_text("Note: quality ignored (materials have no quality)\n")
			command = [{code = 'material_change', material = item_code, operant = '+', value = count}]
		else:
			add_text("Unknown item or material: " + item_code + "\n")
			return
		var a = globals.common_effects(command)
		var output_text = new_text + "\n"
		if a != null:
			output_text += a + "\n"
		else:
			output_text += "Added " + str(count) + "x " + item_code
			if quality != "":
				output_text += " (" + quality + ")"
			output_text += "\n"
		add_text(output_text)
	elif splitstring[0] == "/start_event":
		if splitstring.size() < 2:
			add_text("/start_event requires an event name\n")
			return
		var event_name = splitstring[1]
		if not scenedata.scenedict.has(event_name):
			add_text("Unknown event: " + event_name + "\n")
			return
		var command = [{code = 'start_event', data = event_name, args = {}}]
		var a = globals.common_effects(command)
		var output_text = new_text + "\n"
		if a != null:
			output_text += a + "\n"
		else:
			output_text += "Started event: " + event_name + "\n"
		add_text(output_text)
	elif splitstring[0] == "/decision":
		if splitstring.size() < 2:
			add_text("/decision requires a decision code\n")
			return
		var decision_name = splitstring[1]
		var add_decision = true
		if splitstring.size() >= 3:
			var mode = splitstring[2].to_lower()
			if mode in ["true", "add", "on", "1"]:
				add_decision = true
			elif mode in ["false", "remove", "off", "0"]:
				add_decision = false
			else:
				add_text("/decision mode must be true/add/on/1 or false/remove/off/0\n")
				return
		var active_decisions = ResourceScripts.game_progress.decisions
		var output_text = new_text + "\n"
		if not decisions_data.decisions.has(decision_name) and not active_decisions.has(decision_name):
			output_text += "Note: decision is not listed in Decisions.gd or current save; applying anyway.\n"
		if add_decision:
			if not active_decisions.has(decision_name):
				active_decisions.append(decision_name)
			output_text += "Decision added: " + decision_name + "\n"
		else:
			if active_decisions.has(decision_name):
				active_decisions.erase(decision_name)
			output_text += "Decision removed: " + decision_name + "\n"
		add_text(output_text)

func _common_prefix(strings):
	var prefix = strings[0]
	for s in strings:
		while not s.begins_with(prefix):
			prefix = prefix.substr(0, prefix.length() - 1)
			if prefix.empty():
				return ""
	return prefix

func _handle_tab_complete():
	var text = _TextEdit.text
	var parts = text.split(" ")
	var COMMANDS = ["/do", "/add_item", "/start_event", "/decision"]
	var matches = []

	if parts.size() <= 1:
		var prefix = parts[0] if parts.size() > 0 else ""
		for cmd in COMMANDS:
			if cmd.begins_with(prefix):
				matches.append(cmd)
	else:
		var cmd = parts[0]
		var arg_prefix = parts[1]
		if cmd == "/add_item":
			for key in Items.itemlist:
				if key.begins_with(arg_prefix):
					matches.append(key)
			for key in Items.materiallist:
				if key.begins_with(arg_prefix):
					matches.append(key)
		elif cmd == "/start_event":
			for key in scenedata.scenedict:
				if key.begins_with(arg_prefix):
					matches.append(key)
		elif cmd == "/decision":
			if parts.size() == 2:
				for key in decisions_data.decisions:
					if key.begins_with(arg_prefix):
						matches.append(key)
				for key in ResourceScripts.game_progress.decisions:
					if key.begins_with(arg_prefix) and not matches.has(key):
						matches.append(key)
			elif parts.size() == 3:
				for key in ["true", "false", "add", "remove", "on", "off"]:
					if key.begins_with(parts[2]):
						matches.append(key)

	if matches.size() == 0:
		return
	elif matches.size() == 1:
		if parts.size() <= 1:
			_TextEdit.text = matches[0] + " "
		elif parts.size() == 3:
			_TextEdit.text = parts[0] + " " + parts[1] + " " + matches[0]
		else:
			_TextEdit.text = parts[0] + " " + matches[0]
		_TextEdit.caret_position = _TextEdit.text.length()
	else:
		var MAX_SHOWN = 20
		var display = matches.slice(0, MAX_SHOWN - 1)
		var line = PoolStringArray(display).join("  ")
		if matches.size() > MAX_SHOWN:
			line += "  ... (" + str(matches.size() - MAX_SHOWN) + " more)"
		add_text(line + "\n")
		var common = _common_prefix(matches)
		var current_prefix = parts[0]
		if parts.size() == 2:
			current_prefix = parts[1]
		elif parts.size() == 3:
			current_prefix = parts[2]
		if common.length() > current_prefix.length():
			if parts.size() <= 1:
				_TextEdit.text = common
			elif parts.size() == 3:
				_TextEdit.text = parts[0] + " " + parts[1] + " " + common
			else:
				_TextEdit.text = parts[0] + " " + common
			_TextEdit.caret_position = _TextEdit.text.length()

func add_text(new_text :String):
	_RichTextLabel.text += new_text

func on_hide_errors_toggled(button_pressed):
	if button_pressed:
		log_alert.stop_check_log()
	else:
		log_alert.resume_check_log()
