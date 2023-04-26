extends Node


func can_drop_data(position, data):
	if data != null and data is TextureButton:
		return true
	else:
		return false

func drop_data(position, data):
	if data is TextureButton:
#		data.get_node("Icon").texture = null
		data.set_meta("skill", null)
		data.get_node("Icon").texture = null
#		get_parent().update_combat_skill_panel(null)
