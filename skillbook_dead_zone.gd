extends Node
var target_node

func can_drop_data(position, data):
	if data != null:
		return true
	else:
		return false

func drop_data(position, data):
	if data.has('position'):
		target_node.remove_skill_from_pos(data.position)
