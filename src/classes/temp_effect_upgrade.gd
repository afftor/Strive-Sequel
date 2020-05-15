extends base_effect
class_name temp_e_upgrade
#temp effect that can be upgraded
#designed for non-stackable using but do not force it
#all levels are upgradeble effects with the same name (still do not force it)

var tick_event := []
var rem_event := []
var remains = -1
var stage = 1
var stored_duration = -1

var template_name

func _init(caller).(caller):
	pass

func createfromtemplate(tmp):
	.createfromtemplate(tmp)
	if template.has('tick_event'):
		if typeof(template.tick_event) == TYPE_ARRAY:
			tick_event = template.tick_event.duplicate()
		else:
			tick_event.clear()
			tick_event.push_back(template.tick_event)
	if template.has('rem_event'):
		if typeof(template.rem_event) == TYPE_ARRAY:
			rem_event = template.rem_event.duplicate()
		else:
			rem_event.clear()
	template_name = template.name

func apply():
	.apply()
	if template.has('duration'):
		if typeof(template.duration) == TYPE_STRING:
			match template.duration:
				'parent':
					var par
					if typeof(parent) == TYPE_STRING:
						par = effects_pool.get_effect_by_id(parent)
					else:
						par = parent
					if par != null:
						stored_duration = int(par.self_args['duration'])
					else:
						print('error in template %s' % template_name)
						remains = -1
				'parent_arg':
					var par
					if typeof(parent) == TYPE_STRING:
						par = effects_pool.get_effect_by_id(parent)
					else:
						par = parent
					if par != null:
						stored_duration = int(par.get_arg('duration'))
					else:
						print('error in template %s' % template_name)
						remains = -1
		else:
			stored_duration = template.duration
		remains = stored_duration
	var obj = get_applied_obj()
	for eff in sub_effects:
		obj.apply_effect(eff)

func upgrade():
	if template.has('stages'):
		stage += 1
		if stage <= template.stages:
			remains = stored_duration
			reapply()
			return
	if !template.has('next_level'): return
	remove()
	createfromtemplate(template.next_level)
	if template.has('stages'):
		stage = 1
	get_applied_obj().apply_effect(id)
	pass

func downgrade():
	if template.has('stages'):
		stage -= 1
		if stage > 0:
			reapply()
			remains = stored_duration
			return variables.TE_RES_TICK
	if !template.has('prev_level'):
		remove()
		return variables.TE_RES_REMOVE
	remove()
	createfromtemplate(template.prev_level)
	if template.has('stages'):
		stage = template.stages
	get_applied_obj().apply_effect(id)
	return variables.TE_RES_DGRADE

func process_event(ev):
	if !is_applied: return
	var res = variables.TE_RES_NOACT
	if tick_event.has(ev):
		res = variables.TE_RES_TICK
		remains -= 1
		for b in buffs:
			b.calculate_args()
		if remains == 0:
			res = downgrade()
	if rem_event.has(ev):
		remove()
		res = variables.TE_RES_REMOVE
	return res

func serialize():
	var tmp = .serialize()
	tmp['type'] = 'temp_u'
	tmp['remains'] = remains
	tmp['stage'] = stage
	tmp['s_dur'] = stored_duration
	return tmp
	pass

func deserialize(tmp):
	.deserialize(tmp)
	if template.has('tick_event'):
		if typeof(template.tick_event) == TYPE_ARRAY:
			for tr in template.tick_event:
				tick_event.push_back(int(tr))
		else:
			tick_event.push_back(int(template.tick_event))
	rem_event.clear()
	if template.has('rem_event'):
		if typeof(template.rem_event) == TYPE_ARRAY:
			for tr in template.rem_event:
				rem_event.push_back(int(tr))
		else:
			rem_event.push_back(int(template.rem_event))
	remains = int(tmp.remains)
	template_name = template.name
	stage = int(tmp.stage)
	stored_duration = int(tmp.s_dur)

func remove():
	if !is_applied: return
	.remove()
	for e in sub_effects:
		var t = effects_pool.get_effect_by_id(e)
		t.remove()
	sub_effects.clear()
	is_applied = false
