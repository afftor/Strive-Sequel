extends PopupMenu

var _actions = []

func _ready():
	connect("id_pressed", self, "_on_id_pressed")


func open_with_actions(title, actions, global_position):
	if actions == null:
		return
	hide()
	clear()
	_actions.clear()
	if title != null:
		add_separator(title)
	for action in actions:
		if typeof(action) != TYPE_DICTIONARY:
			continue
		var is_valid_action = false
		if action.has("separator"):
			add_separator(action.separator)
			is_valid_action = true
		if action.has("label") and action.has("callback"):
			#a picture beside the words where the caller has one - a skill's own icon
			if action.has("icon") and action.icon != null:
				add_icon_item(action.icon, action.label)
			else:
				add_item(action.label)
			var index = get_item_count() - 1
			#A line that cannot be used is greyed rather than marked: the menu's own
			#font_color_disabled is what says so, and the reason rides on the tooltip -
			#the same way the character card states a refusal on its buttons.
			if action.has("disabled") and action.disabled:
				set_item_disabled(index, true)
			if action.has("tooltip") and action.tooltip != null and action.tooltip != "":
				set_item_tooltip(index, action.tooltip)
			is_valid_action = true
		if is_valid_action:
			_actions.append(action)
	if _actions.empty():
		hide()
		return
	if global_position == null:
		global_position = get_viewport().get_mouse_position()
	set_as_toplevel(true)
	rect_global_position = global_position
	popup()
	grab_focus()
	set_as_minsize()


func _on_id_pressed(id):
	if id < 1 or id-1 >= _actions.size():
		return
	var action = _actions[id-1]
	hide()
	var callback = action.callback
	var args = []
	if action.has("args"):
		args = action.args
	if callback is FuncRef:
		callback.call_funcv(args)
