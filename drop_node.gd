extends Control

var target_node
var target_function
var metadata

func can_drop_data(position, data):
	#print(data)
	return true

func drop_data(position, data):
	data.combat_position = 0
	if target_node != null && target_function != null && !metadata is Dictionary:
		if metadata != null:
			target_node.call(target_function, metadata, data)
		else:
			target_node.call(target_function, data)
