extends Control

var target_node
var metadata
var dragdata

func can_drop_data(position, data):
	if data != null:
		return true
	else:
		return false

func drop_data(position, data):
	if data.has('position'):
		target_node.swap_positions(data.position, dragdata.position)
	if data.has('skill'):
		target_node.set_skill_to_pos(data.skill, dragdata.position)


func get_drag_data(position):
	set_drag_preview(self.duplicate())
	return dragdata
