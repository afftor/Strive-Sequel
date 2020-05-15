extends Reference

var parent

var static_effects = []
var temp_effects = []
var triggered_effects = []
#var area_effects = []
#var own_area_effects = []
var counters = []

func find_temp_effect(eff_code):
	var res = -1
	var tres = 9999999
	var nm = 0
	for i in range(temp_effects.size()):
		var eff = effects_pool.get_effect_by_id(temp_effects[i])
		if eff.template.name != eff_code:continue
		nm += 1
		if eff.remains < tres:
			tres = eff.remains
			res = i
	return {num = nm, index = res}

func find_temp_effect_tag(eff_tag):
	var res = []
	for e in temp_effects + static_effects:
		var eff = effects_pool.get_effect_by_id(e)
		if eff.tags.has(eff_tag):
			res.push_back(e)
	return res

func find_eff_by_trait(trait_code):
	var res = []
	for e in (static_effects + triggered_effects + temp_effects):
		var eff = effects_pool.get_effect_by_id(e)
		if eff.self_args.has('trait'):
			if eff.self_args.trait == trait_code:
				res.push_back(e)
	return res


func find_eff_by_item(item_id):
	var res = []
	for e in (static_effects + triggered_effects + temp_effects):
		var eff = effects_pool.get_effect_by_id(e)
		if eff.self_args.has('item'):
			if eff.self_args.item == item_id:
				res.push_back(e)
	return res

func check_status_resist(eff):
	for s in variables.status_list:
		if !eff.tags.has(s): continue
		var res = parent.get_stat('status_resists')[s]
		var roll = globals.rng.randi_range(0, 99)
		if roll < res: return true
	return false

func apply_temp_effect(eff_id):
	var eff = effects_pool.get_effect_by_id(eff_id)
	var eff_n = eff.template.name
	if check_status_resist(eff): 
		if input_handler.combat_node != null:
			input_handler.combat_node.combatlogadd("\n%s resists %s." % [parent.get_stat('name'), eff_n]) 
			parent.play_sfx('resist')
		return
	if input_handler.combat_node != null:
		input_handler.combat_node.combatlogadd("\n%s is afflicted by %s." % [parent.get_stat('name'), eff_n]) 
	var tmp = find_temp_effect(eff_n)
	if (tmp.num < eff.template.stack) or (eff.template.stack == 0):
		temp_effects.push_back(eff_id)
		#eff.applied_pos = position
		eff.applied_char = parent.id
		eff.apply()
	else:
		var eff_a = effects_pool.get_effect_by_id(temp_effects[tmp.index])
		match eff_a.template.type:
			'temp_s':eff_a.reset_duration()
			'temp_p':eff_a.reset_duration() #i'm not sure if this case should exist or if it should be treated like this
			'temp_u':eff_a.upgrade() #i'm also not sure about this collision treatement, but for this i'm sure that upgradeable effects should have stack 1
		eff.remove()

func recheck_effect_tag(tg):
	var e_list = find_temp_effect_tag(tg)
	for e in e_list:
		var tmp = effects_pool.get_effect_by_id(e)
		tmp.recheck()

func apply_effect(eff_id):
	var obj = effects_pool.get_effect_by_id(eff_id)
	match obj.template.type:
		'static', 'c_static':
			if parent.is_koed(): return
			static_effects.push_back(eff_id)
			#obj.applied_pos = position
			obj.applied_char = parent.id
			obj.apply()
		'trigger':
			if parent.is_koed(): return
			triggered_effects.push_back(eff_id)
			#obj.applied_pos = position
			obj.applied_char = parent.id
			obj.apply()
		'temp_s','temp_p','temp_u':
			if parent.is_koed(): return
			apply_temp_effect(eff_id)
#		'area':
#			if parent.is_coed(): return
#			add_area_effect(eff_id)
		'oneshot':
			obj.applied_obj = parent
			obj.apply()

func get_static_effect_by_code(code):
	for i in static_effects:
		var eff = effects_pool.get_effect_by_id(i)
		if eff.template.has('code') == false:
			continue
		if eff.template.code == code:
			return eff

func remove_static_effect_by_code(code):
	var eff = get_static_effect_by_code(code)
	eff.remove()

func remove_effect(eff_id):
	var obj = effects_pool.get_effect_by_id(eff_id)
	match obj.template.type:
		'static','c_static': static_effects.erase(eff_id)
		'trigger': triggered_effects.erase(eff_id)
		'temp_s','temp_p','temp_u': temp_effects.erase(eff_id)
#		'area': remove_area_effect(eff_id)

func remove_temp_effect(eff_id):#warning!! this mathod can remove effect that is not applied to character
	var eff = effects_pool.get_effect_by_id(eff_id)
	eff.remove()

func remove_all_temp_effects():
	for e in temp_effects:
		var obj = effects_pool.get_effect_by_id(e)
		obj.call_deferred('remove')

func remove_temp_effect_tag(eff_tag):#function for non-direct temps removing, like heal or dispel
	var tmp = find_temp_effect_tag(eff_tag)
	if tmp.size() == 0: return
	var i = globals.rng.randi_range(0, tmp.size()-1)
	remove_temp_effect(tmp[i])

func clean_effects():#clean effects before deleting character
	for e in temp_effects + static_effects + triggered_effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()

func process_event(ev, skill = null):
	for e in temp_effects.duplicate():
		var eff = effects_pool.get_effect_by_id(e)
		eff.process_event(ev)
	for e in triggered_effects.duplicate():
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if skill != null and eff.req_skill:
			eff.set_args('skill', skill)
			eff.process_event(ev)
			eff.set_args('skill', null)
		else:
			eff.process_event(ev)

#func process_skill_cast_event(s_skill, event):
#	for e in triggered_effects:
#		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
#		if eff.req_skill:
#			eff.set_args('skill', s_skill)
#			eff.process_event(event)
#			eff.set_args('skill', null)
#		else:
#			eff.process_event(event)

func get_all_buffs():
	var res = {}
	for e in temp_effects + static_effects + triggered_effects:
		var eff = effects_pool.get_effect_by_id(e)
		#eff.calculate_args()
		for b in eff.buffs:
			b.calculate_args()
			if !res.has(b.template_name):
				if !(b.template.has('limit') and b.template.limit == 0):
					res[b.template_name] = []
					res[b.template_name].push_back(b)
			elif (!b.template.has('limit')) or (res[b.template_name].size() < b.template.limit):
				res[b.template_name].push_back(b)
#	for e in area_effects:
#		var eff:area_effect = effects_pool.get_effect_by_id(e)
#		if !eff.is_applied_to_pos(position) :
#			continue
#		#eff.calculate_args()
#		for b in eff.buffs:
#			b.calculate_args()
#			if !res.has(b.template_name):
#				if !(b.template.has('limit') and b.template.limit == 0):
#					res[b.template_name] = []
#					res[b.template_name].push_back(b)
#			elif (!b.template.has('limit')) or (res[b.template_name].size() < b.template.limit):
#				res[b.template_name].push_back(b)
	var tmp = []
	for b_a in res.values():
		for b in b_a: tmp.push_back(b)
	return tmp

func can_act():
	for e in static_effects + temp_effects + triggered_effects:
		var obj = effects_pool.get_effect_by_id(e)
		if obj.template.has('disable'):
			return false
	return true

func can_evade():
	var res = parent.can_act()
	if has_status('defend'): res = false
	return res

func has_status(status):
	var res = false
	for e in static_effects + temp_effects + triggered_effects:
		var obj = effects_pool.get_effect_by_id(e)
		if obj.template.has(status):
			res = true
		if obj.tags.has(status):
			res = true
	return res

func can_be_damaged(s_name):
	var skill = Skilldata.Skilllist[s_name]
	match skill.ability_type:
		'skill': return !has_status('banish')
		'spell': return !has_status('void')
