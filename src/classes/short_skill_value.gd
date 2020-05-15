extends Reference

var parent
var template
var value
var dmgf
var receiver
var damagestat
var damage_type
var is_drain

func _init(caller, tmp):
	parent = caller
	template = tmp.duplicate()
	dmgf = template.dmgf
	receiver = template.receiver
	damagestat = template.damagestat
	damage_type = template.source
	is_drain = template.is_drain

func clone():
	var tmp = get_script().new(null, template)
	return tmp

func apply_atomic(tmp):
	if template.nomod: return
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
	var dmgmod = parent.caster.get_damage_mod(parent.template)
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
	apply_random()
	if damage_type == 'weapon':
		damage_type = parent.caster.get_weapon_element()
	#crit modification
	if parent.hit_res == variables.RES_CRIT and !template.nocrit and !template.nomod:
		value *= parent.caster.get_stat('critmod')
	#reduction
	var reduction = 0
	if parent.ability_type == 'skill':
		reduction = max(0, parent.target.get_stat('armor') - parent.armor_p)
		reduction = min(95, reduction)
	elif parent.ability_type == 'spell':
		reduction = max(0, parent.target.get_stat('mdef'))
		reduction = min(100, reduction)

	if !template.nodef and !template.nomod:
		value *= (float(100 - reduction)/100.0)
	
	value = round(value)
