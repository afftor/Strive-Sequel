extends eff_stack
class_name eff_stack_toggle
#stack class for toggled effects
#works only with stack 1 and only with directly applied effects

#some update on replacing one effect with different instead of toggling off

func serialize():
	var tmp = .serialize()
	tmp.type = 'stack_t'
	return tmp


func process_event(ev, data = {}):
	for rec in effects: #either effects[0] or no one 
		var tmp = effects_pool.get_effect_by_id(rec)
		if tmp is triggered_effect:
			tmp.process_act(ev, data)
	for rec in effects:  #either effects[0] or no one 
		var tmp = effects_pool.get_effect_by_id(rec)
		if tmp is temp_e_simple:
			tmp.process_tick(ev)


func process_tick(ev):
	for rec in effects:  #either effects[0] or no one 
		var tmp = effects_pool.get_effect_by_id(rec)
		if tmp is temp_e_simple:
			tmp.process_tick(ev)


func add_effect(eff, timestamp):
	if effects.empty():
		effects[eff] = timestamp
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(code):
			input_handler.combat_node.combatlogadd(get_apply_message())
	else:
		var tmp = effects_pool.get_effect_by_id(effects.keys()[0])
		var tmp1 = effects_pool.get_effect_by_id(eff)
		if tmp.template_id == tmp1.template_id:
			tmp.remove()
			tmp1.is_applied = false
			if input_handler.combat_node != null and !Effectdata.effect_nolog.has(code):
				input_handler.combat_node.combatlogadd(get_turnoff_message())
		else:
			tmp.remove()
			effects[eff] = timestamp
			if input_handler.combat_node != null and !Effectdata.effect_nolog.has(code):
				input_handler.combat_node.combatlogadd(get_update_message())


func get_active_effects():
	if effects.size() <= template.stack:
		return effects.duplicate()
	var cash = []
	for eff in effects:
		cash.push_back([eff, effects[eff]])
	cash.sort_custom(input_handler, 'timestamp_sort')
	var res = {}
	for i in range (template.stack):
		res[cash[i][0]] = cash[i][1]
	return res
	


func get_update_message(): 
	var tres = tr('LOGEFFECTTOGGLEOFFON')
	return tres % [tr('EFFECTNAME_' + code.to_upper()), get_applied_object().get_short_name()]


func get_turnoff_message(): 
	var tres = tr('LOGEFFECTTOGGLEOFF')
	return tres % [tr('EFFECTNAME_' + code.to_upper()), get_applied_object().get_short_name()]


func get_apply_message(): 
	var tres = tr('LOGEFFECTTOGGLEON')
	return tres % [tr('EFFECTNAME_' + code.to_upper()), get_applied_object().get_short_name()]
