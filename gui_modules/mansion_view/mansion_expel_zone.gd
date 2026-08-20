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


#### the carrying protocol ####

func refusal_for(data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return 'MANSIONVIEW_ERR_VOID'
	if view.mode != 'sleep':
		return 'MANSIONVIEW_ERR_VOID'
	if !view.can_expel(data.char_id):
		return 'MANSIONVIEW_ERR_MASTEREXPEL'
	return ''


func take_carried(data):
	view.request_expel(data.char_id)
	return true


func can_drop_data(_position, data):
	return refusal_for(data) == ''


func drop_data(_position, data):
	take_carried(data)


func accepts_pick():
	var carried = view.pick_data()
	return carried != null and refusal_for(carried) == ''


func _gui_input(event):
	if view.picked_char == null:
		return
	if !(event is InputEventMouseButton) or !event.pressed or event.button_index != BUTTON_LEFT:
		return
	view.drop_carried_on(self)
	accept_event()
