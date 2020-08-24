extends base_effect
class_name dynamic_effect
#this is satic effect type that is always applied but self atomic effect values are not fixed on applying but are depending on state of applied character
#can be used 'as is' or as proxy effect to add triggered effects
#sub-effects dependin on args may have unexpected behviour
#be aware of possible infinite loops of rechhecking (f.e. 'if stat > X another_stat += Y' may be safe and may be not and 'if stat > X stat += Y' is always broken)


func _init(caller).(caller):
	pass


func remove():
	if !is_applied: return
	.remove()
	for e in sub_effects:
		var t = effects_pool.get_effect_by_id(e)
		t.remove()
	sub_effects.clear()
	is_applied = false

func serialize():
	var tmp = .serialize()
	tmp['type'] = 'dynamic'
	return tmp


func recheck():
	if !is_applied: return
	var tres = false
	var obj = get_applied_obj()
	var old_args = args.duplicate()
	calculate_args()
	for i in range(args.size()):
		if args[i] == null:
			args[i] = old_args[i]
			continue
		if args[i] != old_args[i]: 
			tres = true
			break
	if tres:
		.reapply()
