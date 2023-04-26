extends Control

var target_node
var target_function
var metadata
var dragdata

func can_drop_data(position, data):
	if data != null and not data is TextureButton:
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


func get_drag_data(position):
	set_drag_preview(self.duplicate())
	return dragdata
