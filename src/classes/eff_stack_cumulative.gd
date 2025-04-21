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
	else:
		var cash = []
		for eff in effects:
			cash.push_back([eff, effects[eff]])
		cash.sort_custom(input_handler, 'timestamp_sort')
		var eff_r = effects_pool.get_effect_by_id(cash[0][0])
		eff_r.remove()
		effects[eff] = timestamp


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
