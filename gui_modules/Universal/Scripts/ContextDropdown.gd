extends PopupMenu

var _actions = []

func _ready():
	connect("id_pressed", self, "_on_id_pressed")


func open_with_actions(person, actions, global_position):
	if actions == null:
		return
	hide()
	clear()
	_actions.clear()
	add_separator(person.get_short_name())
	for action in actions:
		if typeof(action) != TYPE_DICTIONARY:
			continue
		if !action.has("label") or !action.has("callback"):
			continue
		add_item(action.label)
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
