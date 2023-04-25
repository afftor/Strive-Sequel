extends Control

var target_node
var target_function
var metadata

func can_drop_data(position, data):
	if data != null:
		return true
	else:
		return false

func drop_data(position, data):
	if target_node != null && target_function != null && !metadata is Dictionary:
		self.get_node("Icon").texture = data.icon
		self.set_meta("Skill", data)
		if metadata != null:
			target_node.call(target_function, metadata, data)
		else:
			target_node.call(target_function, data)
