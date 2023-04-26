extends Control

var dragdata
var target_node

func get_drag_data(position):
	set_drag_preview(self.duplicate())
	return dragdata

# fix for not being able to drop on each other to remove them

func can_drop_data(position, data):
	if data != null:
		return true
	else:
		return false

func drop_data(position, data):
	if data.has('position'):
		target_node.remove_skill_from_pos(data.position)
		
