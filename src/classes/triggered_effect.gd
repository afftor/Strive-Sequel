extends base_effect
class_name triggered_effect
#triggers. please do not add atomic effects to triggers - put them into separate static effect

# warning-ignore-all:return_value_discarded
var triggered_event := []
var reset_event := []
var ready = true
var req_skill = false
#var skill :S_Skill

func _init(caller).(caller):
	is_applied = false


func createfromtemplate(buff_t):
	.createfromtemplate(buff_t)
#	triggered_event = template.trigger.duplicate()
	for ev in template.trigger:
		triggered_event.push_back(int(ev))
	if template.has('reset'):
#		reset_event = template.reset.duplicate()
		for ev in template.reset:
			reset_event.push_back(int(ev))
	req_skill = template.req_skill
	if template.has('ready'):
		ready = template.ready


func apply():
	is_applied = true


func serialize():
	var tmp = .serialize()
	tmp['type'] = 'trigger'
	tmp['ready'] = ready
	return tmp


func deserialize(tmp):
	.deserialize(tmp)
	#triggered_event = template.trigger.duplicate
	triggered_event.clear()
	for e in template.trigger: triggered_event.push_back(int(e))
	reset_event.clear()
	if template.has('reset'):
		#reset_event = template.reset.duplicate()
		for e in template.reset: reset_event.push_back(int(e))
	ready = tmp['ready']
	req_skill = template.req_skill


func process_act(ev, data = {}):
	if !is_applied: return
	calculate_args(data)
	if triggered_event.has(ev) and ready:
		if !req_skill or (get_arg('skill') != null):
			#check conditions
			var res = true
			for cond in template.conditions:
				match cond.type:
					'random': 
						res = res and (globals.rng.randf() < cond.value)
					'skill':
						var obj = get_arg('skill')
						res = res and obj.process_check(cond.value)
					'caster':
						var obj = get_arg('caster')
						res = res and obj.process_check(cond.value)
					'target':
						var obj = get_arg('target')
						res = res and obj.process_check(cond.value)
					'owner':
						var obj = get_applied_obj()
						res = res and obj.process_check(cond.value)
					_: #use with caution
						if args.size() == 0: 
							continue
						var obj = get_arg(cond.type)
						if obj == null or !(obj is ResourceScripts.scriptdict.class_slave):
							print('template error: arg0 is not character') 
						else:
							res = res and obj.process_check(cond.value)
			if res:
				ready = false
				.clear_buffs()
				#apply trigger
				e_apply()
	if reset_event.has(ev) or reset_event.size() == 0:
		ready = true
	pass


func e_apply(): #temporal solution until rework via apply_status
	sub_effects.clear()
	for e in template.sub_effects:
		sub_effects.push_back(e)
	
	if template.has('modal_sub_effects'): #2remove, but currently do not have proper raplacement
		var temp = input_handler.random_from_array(template.modal_sub_effects)
		sub_effects.push_back(temp)
	
	for e in sub_effects:
		var eff = e
		if eff is String:
			eff = Effectdata.effect_table[e] 
		var t1 = eff.target
		match t1:
			'self':
				match eff.execute:
					'remove':
						call_deferred('remove')
					'remove_parent':
						var obj = effects_pool.get_effect_by_id(parent)
						obj.remove()
			'skill':
				var obj = get_arg('skill')
				eff = effects_pool.e_createfromtemplate(eff, self)
				eff.applied_obj = obj
				obj.apply_effect(effects_pool.add_effect(eff))
			'caster':
				var obj = get_arg('caster')
				if eff.type == 'oneshot':
					eff = effects_pool.e_createfromtemplate(eff, self)
					eff.applied_obj = obj
					eff.apply(get_args_resolved())
				else:
					obj.apply_effect_code(e, get_args_resolved())
			'target':
				var obj = get_arg('target')
				if eff.type == 'oneshot':
					eff = effects_pool.e_createfromtemplate(eff, self)
					eff.applied_obj = obj
					eff.apply(get_args_resolved())
				else:
					obj.apply_effect_code(e, get_args_resolved())
			'receiver':
				var obj = get_arg('receiver')
				if eff.type == 'oneshot':
					eff = effects_pool.e_createfromtemplate(eff, self)
					eff.applied_obj = obj
					eff.apply(get_args_resolved())
				else:
					obj.apply_effect_code(e, get_args_resolved())
			'owner':
				var obj = get_applied_obj()
				if eff.type == 'oneshot':
					eff = effects_pool.e_createfromtemplate(eff, self)
					eff.applied_obj = obj
					eff.apply(get_args_resolved())
				else:
					obj.apply_effect_code(e, get_args_resolved())
			_:
				var obj = get_arg(eff.template.target)
				if obj == null or !(obj is ResourceScripts.scriptdict.class_slave):
					print('template error: arg is not character') 
					continue
				if eff.type == 'oneshot':
					eff = effects_pool.e_createfromtemplate(eff, self)
					eff.applied_obj = obj
					eff.apply(get_args_resolved())
				else:
					obj.apply_effect_code(e, get_args_resolved())
	sub_effects.clear()


func remove():
	var obj = get_applied_obj()
	if obj != null:
		obj.remove_effect(id)
	#.remove()
	is_applied = false


func has_status(status):
	return false


func rebuild_buffs():
	return []
