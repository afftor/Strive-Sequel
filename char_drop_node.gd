extends Control

var target_node
var target_function
var metadata
var character
var position

func can_drop_data(position, data):
	if data is ResourceScripts.scriptdict.class_slave:
		return true
	elif data is Item || data is Dictionary:
		if character != null:
			return true
		else:
			return false

func drop_data(position, data):
	if data is ResourceScripts.scriptdict.class_slave:
		if target_node != null && target_function != null:
			if metadata != null:
				target_node.call(target_function, metadata, data)
			else:
				target_node.call(target_function, data)
	elif data is Item:
		if character != null:
			target_node.use_item_on_character(character, data)
	elif data is Dictionary:
		if character != null:
			target_node.use_e_combat_skill(data.caster, character, data.skill)
			#target_node.use_skill_explore(data.character, data.skill)
