extends eff_stack
class_name eff_stack_limit
#stack class for limited stacking based on timestamp. 

func serialize():
	var tmp = .serialize()
	tmp.type = 'stack_l'
	return tmp


func add_effect(eff, timestamp):
	effects[eff] = timestamp
	if input_handler.combat_node != null and !Effectdata.effect_nolog.has(code):
		if effects.size() <= template.stack:
			input_handler.combat_node.combatlogadd(get_apply_message())
		else:
			input_handler.combat_node.combatlogadd(get_update_message())


func get_active_effects():
	if effects.size() <= template.stack:
		return effects.duplicate()
	var cash = []
	for eff in effects:
		cash.push_back([eff, effects[eff]])
	cash.sort_custom(input_handler, 'timestamp_sort')
	cash.invert()
	var res = {}
	for i in range (template.stack):
		res[cash[i][0]] = cash[i][1]
	return res


func get_duration():
	if effects.empty(): 
		return null
	var res = {}
	res.count = 0
	res.event = effects_pool.get_effect_by_id(effects.keys()[0]).get_duration().event
	for eff in effects:
		res.count = max(res.count, effects_pool.get_effect_by_id(eff).get_duration().count)
	return res
