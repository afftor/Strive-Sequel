extends base_effect
class_name condition_effect
#this is satic effect type that is always applied but can be turn on and off depending on state of applied character
#can be used 'as is' or as proxy effect to add triggered effects
#temporal effects can also be added as sub_effects but be cautious because every successful recheck will reapply those temp effects. for example, every item-based effect is rechecked at learning any item-based trait - so be sure not to put condition that wil be passed if not trait-based. or put those effects under another proxy effect


var cond_true = false

func _init(caller).(caller):
	pass

func apply():
	is_applied = true
	recheck()

func remove():
	if !is_applied: return
	if cond_true:
		.remove()
		for e in sub_effects:
			var t = effects_pool.get_effect_by_id(e)
			t.remove()
		sub_effects.clear()
	else:
		get_applied_obj().remove_effect(id)
	is_applied = false

func serialize():
	var tmp = .serialize()
	tmp['type'] = 'c_static'
	tmp['cond'] = cond_true
	return tmp

func deserialize(tmp):
	.deserialize(tmp)
	cond_true = tmp['cond']

func recheck():
	if !is_applied: return
	var tres = true
	var obj = get_applied_obj()
	for cond in template.conditions:
		tres = tres && obj.process_check(cond)
	if tres == cond_true: return
	if tres:
		cond_true = true
		atomic.clear()
		calculate_args()
		for a in template.atomic:
			var tmp := atomic_effect.new(a, id)
			tmp.resolve_template()
			#tmp.apply_template(obj)
			obj.apply_atomic(tmp.template)
			atomic.push_back(tmp.template)
		sub_effects.clear()
		for e in template.sub_effects:
			var tmp = effects_pool.e_createfromtemplate(e, id)
			#tmp.calculate_args()
			sub_effects.push_back(effects_pool.add_effect(tmp))
			pass
		for eff in sub_effects:
			obj.apply_effect(eff)
		setup_siblings()
		buffs.clear()
		for e in template.buffs:
			var tmp = Buff.new(id)
			tmp.createfromtemplate(e)
			tmp.calculate_args()
			buffs.push_back(tmp)
	else:
		cond_true = false
		for a in atomic:
			obj.remove_atomic(a)
		atomic.clear()
		buffs.clear()
		for e in sub_effects:
			var t = effects_pool.get_effect_by_id(e)
			t.remove()
		sub_effects.clear()
	pass


