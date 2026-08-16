extends Panel
#The corner a character can be dropped into to be let go for good. Only exists while beds
#are being arranged, because that is the mode where the whole household is on screen and
#the question "is there room for everyone" is being asked.
#
#It never acts on the drop by itself - it asks first, through the project's standard
#yes/no panel. Carrying somebody here by a click works the same, and asks the same.

const COLOR_TARGET = Color(1.6, 1.2, 1.2)

var view = null


func setup(view_node):
	view = view_node
	visible = false


func refresh():
	self_modulate = COLOR_TARGET if accepts_pick() else Color(1, 1, 1, 1)


func can_drop_data(_position, data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return false
	if view.mode != 'sleep':
		return false
	return view.can_expel(data.char_id)


func drop_data(_position, data):
	view.request_expel(data.char_id)


func accepts_pick():
	return can_drop_data(Vector2.ZERO, view.pick_data())


func _gui_input(event):
	if !accepts_pick():
		return
	if !(event is InputEventMouseButton) or !event.pressed or event.button_index != BUTTON_LEFT:
		return
	var char_id = view.picked_char
	view.clear_char_pick()
	view.request_expel(char_id)
	accept_event()
