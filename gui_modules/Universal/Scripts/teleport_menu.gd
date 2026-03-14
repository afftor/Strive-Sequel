extends Panel

func make_list(chars, cast_obj, cast_func) -> bool:
	var can_teleport = false
	var teleport_list = $ScrollContainer/VBoxContainer
	input_handler.ClearContainer(teleport_list)
	for chid in chars:
		var person = characters_pool.get_char_by_id(chid)
		if person.valuecheck({code = 'has_skill', value = 'teleport', check = true}):
			can_teleport = true
			var skill = Skilldata.get_template('teleport', person)
			var new_button = input_handler.DuplicateContainerTemplate(teleport_list)
			new_button.get_node('Icon').texture = person.get_icon()
			new_button.get_node('Label').text = person.get_short_name()
			new_button.get_node('mp').max_value = person.get_stat('mpmax')
			new_button.get_node('mp').value = person.mp
			new_button.get_node('mp/Labelmp').text = "%s: %s(%s)" % [
				tr('STATMANACOST'),
				skill.cost.mp,
				round(person.mp)]
			
			if !person.check_cost(skill.cost):
				new_button.disabled = true
				new_button.get_node('disabled').show()
			new_button.connect("pressed", cast_obj, cast_func, [chid])
	return can_teleport
