extends Panel
#The strip of portraits along the top. It is the pool the player drags people out of, and
#what it holds depends on the mode:
#	work  - everyone who is in the mansion and has no job. This is Rest.
#	sleep - everyone without a bed. In a settled mansion it is empty; anything left in it
#	        is what blocks the end of the turn.
#
#Characters who are away from the mansion never appear here. They are still drawn, faded,
#on whatever workplace they hold, because they walk back into it on their own.
#
#It is also where somebody is put down to be taken out of wherever they were - by dropping
#them on it, or by clicking it while carrying them.

const COLOR_TARGET = Color(1.5, 1.45, 1.0)

var view = null


func setup(view_node):
	view = view_node


func rebuild():
	#while rooms are being moved the panel has nothing to offer, and it sits over the top
	#of the plan - so it steps out of the way entirely rather than swallowing drops meant
	#for a room underneath it
	if view.mode == 'rearrange':
		visible = false
		return
	visible = true
	var ids = view.resting_characters()
	$Title.text = "%s (%d)" % [label_for_mode(), ids.size()]
	$Warning.visible = view.mode == 'sleep' and !ids.empty()
	#with somebody in hand who came out of a room, the panel is where they are set free
	self_modulate = COLOR_TARGET if accepts_pick() else Color(1, 1, 1, 1)
	input_handler.ClearContainer($List)
	for char_id in ids:
		var cell = input_handler.DuplicateContainerTemplate($List)
		cell.setup(view, char_id)


func label_for_mode():
	match view.mode:
		'sleep':
			return tr("MANSIONVIEW_UNHOUSED")
		'rearrange':
			return tr("MANSIONVIEW_REST")
	return tr("MANSIONVIEW_REST")


#Dropping somebody back onto the panel is how they are taken off a job or out of a bed.
func can_drop_data(_position, data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return false
	return data.get('from_slot', null) != null


func drop_data(_position, data):
	view.release_character(data.char_id, data.get('from_kind', 'work'))


#Somebody carried here by a click is set free the same way, and asks the same question.
func accepts_pick():
	return can_drop_data(Vector2.ZERO, view.pick_data())


func _gui_input(event):
	if !accepts_pick():
		return
	if !(event is InputEventMouseButton) or !event.pressed or event.button_index != BUTTON_LEFT:
		return
	var char_id = view.picked_char
	var from_kind = view.picked_char_kind
	view.clear_char_pick()
	view.release_character(char_id, from_kind)
	accept_event()
