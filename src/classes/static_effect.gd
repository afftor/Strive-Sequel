extends base_effect
class_name static_effect



func _init(caller).(caller):
	pass

func apply():
	.apply()
	var obj = get_applied_obj()
	for eff in sub_effects:
		obj.apply_effect(eff)
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
	tmp['type'] = 'static'
	return tmp

func deserialize(tmp):
	.deserialize(tmp)




