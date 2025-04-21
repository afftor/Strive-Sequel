extends Reference

var parent_ref
var template
var value
var dmgf
var damagestat
var damage_type
var is_drain
var cap

func _init(caller, tmp):
	set_parent(caller)
	template = tmp.duplicate()
	dmgf = template.dmgf
	damagestat = template.damagestat
	damage_type = template.source
	is_drain = template.is_drain
	cap = template.cap

func set_parent(caller):
	parent_ref = weakref(caller)

func get_parent():
	return parent_ref.get_ref()

func clone():
	var tmp = template.duplicate()
	tmp.is_drain = is_drain
	tmp.source = damage_type
	var tmp_ = get_script().new(null, tmp)
	return tmp_

func apply_atomic(tmp):
	if template.nomod: return
	if tmp.stat == 'is_drain':
		match tmp.type:
			'stat_add':
				is_drain += tmp.value
			'stat_mul':
				is_drain *= tmp.value
			'stat_set':
				is_drain = tmp.value
		return
	if tmp.stat == 'cap':
		match tmp.type:
			'stat_add':
				cap += tmp.value
			'stat_mul':
				cap *= tmp.value
			'stat_set': #not really
				cap = tmp.value
		return
	if (tmp.has('stats') && !tmp.stats.has(template.damagestat)): return
	if (tmp.has('statignore') && tmp.statignore.has(template.damagestat)): return
	match tmp.type:
		'stat_add':
			value += tmp.value
		'stat_mul':
			value *= tmp.value
		'stat_set':
			value = tmp.value

func resolve_value(check_m):
	var parent = get_parent()
	var dmgmod = parent.caster.get_damage_mod(parent.template) * parent.caster.get_value_damage_mod(self)
	var endvalue
	var atk
	var stat
	var data = parent.caster.get_stat_data()
	if parent.ability_type == 'skill':
		stat = parent.caster.get_stat(data['skill_stat'])
		atk = parent.caster.get_stat(data['skill_atk'])
	elif parent.ability_type == 'spell':
		stat = parent.caster.get_stat(data['spell_stat'])
		atk = parent.caster.get_stat(data['spell_atk'])
	else:
		stat = 0
		atk = 0
	var t1 = input_handler.calculate_number_from_string_array(template.value1, parent.caster, parent.target)
	var t2 = input_handler.calculate_number_from_string_array(template.value2, parent.caster, parent.target)
	var t3 = input_handler.calculate_number_from_string_array(template.value3, parent.caster, parent.target)
	endvalue = (t1 * atk + t2) * (1 + stat/100.0) + t3
	#modify melee atk from backrow and apply dmgmod
	if !template.nomod:
		var rangetype = parent.target_range
		if rangetype == 'weapon': rangetype = parent.caster.get_weapon_range()
		if rangetype == 'melee' && input_handler.combat_node.FindFighterRow(parent.caster) == 'backrow' && check_m:
			endvalue /= 2
		endvalue *= dmgmod
	value = endvalue

func apply_random():
	var rmin
	var rmax
	if variables.relative_random_add:
		rmin = 0
		rmax = template.random_factor
	else:
		rmin = -template.random_factor
		rmax = template.random_factor
	var val_add = globals.rng.randi_range(rmin, rmax)
	rmin = 1.0 - template.random_factor_p
	rmax = 1.0 + template.random_factor_p
	var val_mul = globals.rng.randf_range(rmin,rmax)
	value += val_add
	value *= val_mul

func calculate_dmg():
	var parent = get_parent()
	apply_random()
	#crit modification
	if parent.hit_res == variables.RES_CRIT and !template.nocrit and !template.nomod:
		value *= parent.critmod
	
#	if parent.ability_type == 'skill':
	#current formulae add ap to spell damage cap
	cap += parent.armor_p * 0.5
	var reduction = 0
	if parent.ability_type == 'skill':
#		reduction = max(0, parent.target.get_stat('armor') - parent.armor_p)
		reduction = parent.target.get_stat('armor')
		if reduction <= 2 * parent.armor_p:
			reduction *= 0.25
		else:
			reduction -= 1.25 * parent.armor_p
		reduction = max(0, reduction)
	elif parent.ability_type == 'spell':
		reduction = max(0, parent.target.get_stat('mdef'))
	if !template.nodef and !template.nomod and !parent.get_tags().has('nodef'):
		value -= reduction
	
	value = max(value, cap)
	#reduction
#	var reduction = 0
#	if parent.ability_type == 'skill':
#		reduction = max(0, parent.target.get_stat('armor') - parent.armor_p)
#		reduction = min(95, reduction)
#	elif parent.ability_type == 'spell':
#		reduction = max(0, parent.target.get_stat('mdef'))
#		reduction = min(100, reduction)
#
#	if !template.nodef and !template.nomod:
#		value *= (float(100 - reduction)/100.0)
		
	#damage resists
	reduction = 0
	if parent.get_tags().has('aoe'):
		reduction = parent.target.get_stat('resist_aoe')
	elif parent.target_range == 'any': #or add tags for this
		reduction = parent.target.get_stat('resist_ranged')
	elif parent.target_range == 'melee': #or add tags for this
		reduction = parent.target.get_stat('resist_melee')
	if !template.nodef and !template.nomod and !parent.get_tags().has('nodef'):
		value *= (float(100 - reduction)/100.0)
	if parent.get_tags().has('heal'):
		reduction = parent.target.get_stat('resist_heal')
	if !template.nomod: #there may be errors due to damagestat templating
		value *= (float(100 - reduction)/100.0)
	
	value = round(value)

func check_conditions():
	var parent = get_parent()
	var res = true
	if template.has('caster_reqs'): res = res and parent.caster.checkreqs(template.caster_reqs)
	if template.has('target_reqs'): res = res and parent.target.checkreqs(template.target_reqs)
	return res

func setup_weapon_element():
	if damage_type == 'weapon':
		damage_type = get_parent().caster.get_weapon_element()

func execute():
	var parent = get_parent()
	var text = ""
	
	if !check_conditions(): 
		return text
	if damagestat == 'no_stat': 
		return text
	if damagestat == 'damage_hp' and dmgf == 0: #drain, damage, damage no log, drain no log
		if is_drain > 0.0 && parent.get_tags().has('no_log'):
			var rval = parent.target.deal_damage(value, damage_type)
			var rval2 = parent.caster.heal(rval * is_drain)
		elif is_drain > 0.0:
			var rval = parent.target.deal_damage(value, damage_type)
			var rval2 = parent.caster.heal(rval * is_drain)
			text += "%s drained %d health from %s and gained %d health." %[parent.caster.get_short_name(), rval, parent.target.get_short_name(), rval2]
		elif parent.get_tags().has('no_log') && is_drain <= 0.0:
			var rval = parent.target.deal_damage(value, damage_type)
		else:
			var rval = parent.target.deal_damage(value, damage_type)
			text += "%s is hit for %d damage. " %[parent.target.get_short_name(), rval]#, s_skill2.value[i]]
	elif damagestat == 'damage_hp' and dmgf == 1: #heal, heal no log
		if parent.get_tags().has('no_log'):
			var rval = parent.target.heal(value)
		else:
			var rval = parent.target.heal(value)
			text += "%s is healed for %d health." %[parent.target.get_short_name(), rval]
	elif damagestat == 'restore_mana' and dmgf == 0: #heal, heal no log
		if !parent.get_tags().has('no log'):
			var rval = parent.target.mana_update(value)
			text += "%s restored %d mana." %[parent.target.get_short_name(), rval]
		else:
			parent.target.mana_update(value)
	elif damagestat == 'restore_mana' and dmgf == 1: #drain, damage, damage no log, drain no log
		var rval = parent.target.mana_update(-value)
		if is_drain > 0.0:
			var rval2 = parent.caster.mana_update(rval * is_drain)
			if !parent.get_tags().has('no log'):
				text += "%s drained %d mana from %s and gained %d mana." %[parent.caster.get_short_name(), rval, parent.target.get_short_name(), rval2]
		if !parent.get_tags().has('no log'):
			text += "%s lost %d mana." %[parent.target.get_short_name(), rval]
	else:
		var mod = dmgf
		var stat = damagestat
		if mod == 0:
			var rval = parent.target.stat_update(stat, value)
			if !parent.get_tags().has('no log'):
				text += "%s restored %d %s." %[parent.target.get_short_name(), rval, tr(stat)]
		elif mod == 1:
			var rval = parent.target.stat_update(stat, -value)
			if is_drain > 0.0:
				var rval2 = parent.caster.stat_update(stat, -rval * is_drain)
				if !parent.get_tags().has('no log'):
					text += "%s drained %d %s from %s." %[parent.caster.get_short_name(), value, tr(stat),  parent.target.get_short_name()]
			elif !parent.get_tags().has('no log'):
				text += "%s loses %d %s." %[parent.target.get_short_name(), -rval, tr(stat)]
		elif mod == 2:
			var rval = parent.target.stat_update(stat, value, true)
			if is_drain > 0.0:# use this on your own risk
				var rval2 = parent.caster.stat_update(stat, -rval * is_drain)
				if !parent.get_tags().has('no log'):
					text += "%s drained %d %s from %s." %[parent.caster.get_short_name(), value, tr(stat),  parent.target.get_short_name()]
			elif !parent.get_tags().has('no log'):
				text += "%s's %s is now %d." %[parent.target.get_short_name(), tr(stat), value]
		else:
			print('error in damagestat %s' % damagestat) #obsolete in new format
	
	return text
