extends eff_stack
class_name eff_stack_limit
#stack class for limited stacking based on timestamp. 

func serialize():
	var tmp = .serialize()
	tmp.type = 'stack_l'
	return tmp


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
	
