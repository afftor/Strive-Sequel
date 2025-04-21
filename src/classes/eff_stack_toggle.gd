extends eff_stack
class_name eff_stack_toggle
#stack class for toggled effects
#works only with stack 1 and only with directly applied effects

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
	else:
		var tmp = effects_pool.get_effect_by_id(effects[0])
		tmp.remove()
		eff.is_applied = false


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
	
