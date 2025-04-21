extends eff_stack
class_name eff_stack_single
#stack class for limited stacking witch summaraze durations
#effects effectively acts (ticks or removes) one per event
#better with stack 1

func serialize():
	var tmp = .serialize()
	tmp.type = 'stack_s'
	return tmp


func process_event(ev, data = {}):
	var cash = []
	for eff in effects:
		cash.push_back([eff, effects[eff]])
	cash.sort_custom(input_handler, 'timestamp_sort')
	for rec in get_active_effects():
		var tmp = effects_pool.get_effect_by_id(rec)
		if tmp is triggered_effect:
			tmp.process_act(ev, data)
	for rec in cash:
		var tmp = effects_pool.get_effect_by_id(rec[0])
		if tmp is temp_e_simple:
			if tmp.process_tick(ev) != variables.TE_RES_NOACT:
				break


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


func add_effect(eff, timestamp):
	effects[eff] = timestamp


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
