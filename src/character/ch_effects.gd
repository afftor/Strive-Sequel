extends Reference

var parent: WeakRef

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
	var pool = []
	for i in range(temp_effects.size()):
		var eff = effects_pool.get_effect_by_id(temp_effects[i])
		if eff.template.name != eff_code:
			continue
		pool.push_back(eff)
		nm += 1
		if eff.remains < tres:
			tres = eff.remains
			res = i
	return {num = nm, index = res}

func has_temp_effect(temp_name):
	return find_temp_effect(temp_name).num > 0

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

func find_eff_by_tattoo(slot, code):
	var tag = "%s_%s" % [slot, code]
	var res = []
	for e in (static_effects + triggered_effects + temp_effects):
		var eff = effects_pool.get_effect_by_id(e)
		if eff.self_args.has('tattoo'):
			if eff.self_args.tattoo == tag:
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
	var tres = parent.get_ref().get_stat('status_resists')
	for s in variables.status_list:
		if !eff.tags.has(s): 
			continue
		var res = tres[s]
		if parent.get_ref().has_status('boss_resists') and s in ['stun', 'freeze']:
			res = max(res, 90)
		var roll = globals.rng.randi_range(0, 99)
		if roll < res: return true
	return false


func check_status_immunity(eff_n):
	var tres = parent.get_ref().get_stat('status_resists')
	if !tres.has(eff_n):
		print ("error - no resist for %s status" % eff_n)
		return false
	else:
		return tres[eff_n] >= 100


func apply_temp_effect(eff_id, noresist = false):
	var eff = effects_pool.get_effect_by_id(eff_id)
	var eff_n = eff.template.name
	if !noresist and check_status_resist(eff):
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_n):
			input_handler.combat_node.combatlogadd("\n%s resists %s." % [parent.get_ref().get_short_name(), eff_n])
			parent.get_ref().play_sfx('resist')
		return
	if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_n):
		input_handler.combat_node.combatlogadd("\n%s is affected by %s." % [parent.get_ref().get_short_name(), eff_n])
	var tmp = find_temp_effect(eff_n)
	if eff.template.type == 'temp_inc':
		for e in tmp.pool:
			e.process_event(variables.TR_STACK)
		temp_effects.push_back(eff_id)
		eff.applied_char = parent.get_ref().id
		eff.apply()
	elif (tmp.num < eff.template.stack) or (eff.template.stack == 0):
		temp_effects.push_back(eff_id)
		#eff.applied_pos = position
		eff.applied_char = parent.get_ref().id
		eff.apply()
	else:
		var eff_a = effects_pool.get_effect_by_id(temp_effects[tmp.index])
		match eff_a.template.type:
			'temp_s':
				if eff.tags.has('reset_duration'):
					eff_a.reset_duration()
				elif eff.tags.has('merge_duration'):
					eff_a.merge_duration(eff)
				else:
					eff_a.add_duration(eff)
				eff.remove()
			'temp_toggle':
				eff_a.remove()
				eff.remove()
			'temp_p':
				eff_a.reset_duration() #i'm not sure if this case should exist or if it should be treated like this
				eff.remove()
			'temp_u':
				eff_a.upgrade() #i'm also not sure about this collision treatement, but for this i'm sure that upgradeable effects should have stack 1
				eff.remove()
			'temp_global':
				remove_temp_effect(temp_effects[tmp.index])
				temp_effects.push_back(eff_id)
				eff.applied_char = parent.get_ref().id
				eff.apply()

func recheck_effect_tag(tg):
	var e_list = find_temp_effect_tag(tg)
	for e in e_list:
		var tmp = effects_pool.get_effect_by_id(e)
		tmp.recheck()


func make_status_effect(template):
	var effect = template.effect
	#add custom template making
	match effect:
		'e_s_freeze1':
			effect = Effectdata.effect_table[effect].duplicate(true)
			effect.duration = template.duration
			if has_status('wet'):
				template.chance = 1.0
			if parent.get_ref().has_status('boss_resists'):
				effect.duration = 1
		'e_s_shock':
			if has_status('shock') and globals.rng.randf() < 0.2:
				effect = Effectdata.effect_table['e_s_stun1'].duplicate(true)
				effect.duration = 1
			else:
				effect = Effectdata.effect_table[effect].duplicate(true)
				effect.duration = template.duration
		'e_s_stun1':
			effect = Effectdata.effect_table[effect].duplicate(true)
			effect.duration = template.duration
			if parent.get_ref().has_status('boss_resists'):
				effect.duration = 1
		_:
			effect = Effectdata.effect_table[effect].duplicate(true)
			effect.duration = template.duration
	var eff = effects_pool.e_createfromtemplate(effect, template.parent)
	var eff_id = effects_pool.add_effect(eff)
	var eff_n = eff.template.name
	if parent.get_ref().is_koed() and !eff.tags.has('on_dead'): return
	if check_status_immunity(eff_n):
		if input_handler.combat_node != null and !Effectdata.effect_nolog.has(eff_n):
			input_handler.combat_node.combatlogadd("\n%s resists %s." % [parent.get_ref().get_short_name(), eff_n])
			parent.get_ref().play_sfx('resist')
		return
	if template.chance > 1.0:
		apply_temp_effect(eff_id, true)
	elif globals.rng.randf() <= template.chance:
		apply_temp_effect(eff_id)


func apply_effect(eff_id):
	var obj = effects_pool.get_effect_by_id(eff_id)
	for tg in ['negative', 'debuff', 'affliction']:
		if obj.tags.has(tg) and (parent.get_ref().has_status('d_warded') or parent.get_ref().has_status('d_warded_' + 'tg')):
			return
	match obj.template.type:
		'static', 'c_static', 'dynamic':
			if parent.get_ref().is_koed() and !obj.tags.has('on_dead'): return
			static_effects.push_back(eff_id)
			#obj.applied_pos = position
			obj.applied_char = parent.get_ref().id
			obj.apply()
		'trigger':
			if parent.get_ref().is_koed() and !obj.tags.has('on_dead'): return
			triggered_effects.push_back(eff_id)
			#obj.applied_pos = position
			obj.applied_char = parent.get_ref().id
			obj.apply()
		'temp_s','temp_p','temp_u', 'temp_global', 'temp_toggle', 'temp_inc':
			if parent.get_ref().is_koed() and !obj.tags.has('on_dead'): 
				return
			apply_temp_effect(eff_id)
#		'area':
#			if parent.is_coed(): return
#			add_area_effect(eff_id)
		'oneshot':
			obj.applied_obj = parent.get_ref()
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
		'temp_s', 'temp_inc', 'temp_p', 'temp_u', 'temp_global', 'temp_toggle': temp_effects.erase(eff_id)
	var nd = parent.get_ref().displaynode
	if nd != null:
		nd.rebuildbuffs()
#		'area': remove_area_effect(eff_id)

func clean_broken_effects():
	for e in temp_effects + static_effects + triggered_effects:
		var eff = effects_pool.get_effect_by_id(e)
		if eff == null:
			print("broken effect %s is removed" % e)
			temp_effects.erase(e)
			static_effects.erase(e)
			triggered_effects.erase(e)

func remove_temp_effect(eff_id):#warning!! this mathod can remove effect that is not applied to character
	var eff = effects_pool.get_effect_by_id(eff_id)
	eff.remove()

func remove_all_temp_effects():
	for e in temp_effects:
		var obj = effects_pool.get_effect_by_id(e)
		obj.call_deferred('remove')


func remove_all_temp_effects_tag(eff_tag):
	var tmp = find_temp_effect_tag(eff_tag)
	if tmp.size() == 0: return
	for e in tmp:
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
		if eff != null: eff.remove()

func process_event(ev, skill = null):
	for e in temp_effects.duplicate():
		var eff = effects_pool.get_effect_by_id(e)
		if eff is temp_e_global:
			continue
		if eff.tags.has('tick_after_trigger'): 
			continue
		eff.process_event(ev)
	for e in triggered_effects.duplicate():
		var eff:triggered_effect = effects_pool.get_effect_by_id(e)
		if skill != null and eff.req_skill:
			eff.set_args('skill', skill)
			eff.process_event(ev)
			eff.set_args('skill', null)
		else:
			eff.process_event(ev)
	for e in temp_effects.duplicate():
		var eff = effects_pool.get_effect_by_id(e)
		if eff is temp_e_global:
			continue
		if !eff.tags.has('tick_after_trigger'): 
			continue
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
		if eff == null:
			print(parent.get_ref().id)
			continue
		if !eff.is_applied: 
			continue
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
	
	var tbuff = Buff.new(null)
	var f = false
	tbuff.createfromtemplate('b_factor_maxed')
	var tdesc = ""
	for i in ['physics_factor','wits_factor','charm_factor','sexuals_factor','timid_factor','tame_factor','magic_factor']:
		if parent.get_ref().get_stat(i) >= 6:
			if f:
				tdesc += "\n"
			f = true
			tdesc +=  tr(i.to_upper() + "BONUSDESCRIPT")
	
	if f:
		tbuff.description = tdesc
		tmp.push_back(tbuff)
	
	for b_a in res.values():
		for b in b_a: 
			tmp.push_back(b)
	return tmp


func has_status(status):
	var res = false
	for e in static_effects + temp_effects + triggered_effects:
		var obj = effects_pool.get_effect_by_id(e)
		if !(obj is condition_effect) or obj.cond_true:
			if obj.template.has(status):
				res = true
			if obj.tags.has(status):
				res = true
	return res
