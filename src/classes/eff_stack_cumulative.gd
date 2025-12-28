extends eff_stack
class_name eff_stack_cumulative
#stack class for hard limited stacking with 'prolongation' of older effs


func serialize():
	var tmp = .serialize()
	tmp.type = 'stack_c'
	return tmp


func add_effect(eff, timestamp):
	if effects.size() < template.stack:
		effects[eff] = timestamp
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(code):
			input_handler.combat_node.combatlogadd(get_apply_message())
	else:
		var cash = []
		for eff in effects:
			cash.push_back([eff, effects[eff]])
		cash.sort_custom(input_handler, 'timestamp_sort')
		var eff_r = effects_pool.get_effect_by_id(cash[0][0])
		eff_r.remove()
		effects[eff] = timestamp
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(code):
			input_handler.combat_node.combatlogadd(get_update_message())


func process_tick(ev):
	var cash = []
	for eff in effects:
		cash.push_back([eff, effects[eff]])
	cash.sort_custom(input_handler, 'timestamp_sort')
	for rec in cash:
		var tmp = effects_pool.get_effect_by_id(rec[0])
		if tmp is temp_e_simple:
			if tmp.process_tick(ev) != variables.TE_RES_NOACT:
				break


func get_active_effects():
	if effects.size() <= template.stack: #effectively always
		return effects.duplicate()


func get_duration():
	if effects.empty(): 
		return null
	var res = {}
	res.count = 0
	res.event = effects_pool.get_effect_by_id(effects.keys()[0]).get_duration().event
	for eff in effects:
		res.count += effects_pool.get_effect_by_id(eff).get_duration().count
	return res
