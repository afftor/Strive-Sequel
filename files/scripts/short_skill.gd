extends Reference
class_name S_Skill

var code
var template

var type

var is_drain = false
var ability_type
var tags
var value = []
var long_value = []
var damagestat = []
var receiver = []
var manacost
var energycost
var goldcost
var target_range
var target_number
var damage_type
#var damagesrc
var repeat

var chance
var evade
var critchance
var armor_p
var caster
var target
var hit_res

var effects = []
var process_value
var random_factor
var random_factor_p
var tempdur

func _init():
	caster = null
	target = null
	target_range = 'any'
	target_number = 'single'
	damage_type = 'direct'
	goldcost = 0
	damagestat = '+damage_hp'

	receiver = 'target'
	random_factor = 0
	random_factor_p = 0.0

func clone():
	var res = dict2inst(inst2dict(self))
	res.effects.clear()
	for e in template.effects:
		var eff = effects_pool.e_createfromtemplate(e, res)
		res.apply_effect(effects_pool.add_effect(eff))
	return res

func get_from_template(attr, val_rel = false):
	if template.has(attr): 
		if typeof(template[attr]) == TYPE_ARRAY:
			set(attr, template[attr].duplicate())
			return
		set(attr, template[attr])
	if val_rel:
		var tres = []
		for i in range(long_value.size()): tres.push_back(get(attr))
		set(attr, tres)

func createfromskill(s_code):
	template = Skilldata.Skilllist[s_code]
	code = s_code
	type = template.type
	ability_type = template.ability_type
	tags = template.tags.duplicate()
	manacost = template.manacost
	energycost = template.energycost
	get_from_template('goldcost')
	get_from_template('target_range')
	get_from_template('target_number')
	get_from_template('damage_type')

	
	if typeof(template.value) == TYPE_ARRAY: 
		if typeof(template.value[0]) == TYPE_ARRAY:
			long_value = template.value.duplicate()
		else:
			long_value.push_back(template.value.duplicate())
	else:
		long_value.push_back(template.value)
	
	get_from_template('damagestat', true)
	for s in range(damagestat.size()):
		if damagestat[s] == 'no_stat': continue
		if !(damagestat[s][0] in ['+','-','=']):
			damagestat[s] = '+'+damagestat[s]
	get_from_template('receiver', true)
	get_from_template('random_factor', true)
	get_from_template('random_factor_p', true)
	
	for e in template.effects:
		var eff = effects_pool.e_createfromtemplate(e, self)
		apply_effect(effects_pool.add_effect(eff))
	if template.has('repeat'):
		repeat = template.repeat
	else:
		repeat = 1
	if template.has('is_drain'):
		is_drain = true


func process_check(check:Array):
	var op1 = check[0]
	var op2 = check[2]
	if typeof(op1) == TYPE_STRING:
		op1 = get(op1)
	if typeof(op2) == TYPE_STRING && check[1] != 'has':
		op2 = get(op2)
	return input_handler.operate(check[1], op1, op2)

func setup_caster(c):
	caster = c
	if type == 'combat' and c!= null:
		chance = caster.get_stat('hitrate')
		critchance = caster.get_stat('critchance')
		armor_p = caster.get_stat('armorpenetration')
	else:
		chance = 100
		critchance = 0
		armor_p = 0

func setup_target(t):
	target = t
	if type == 'combat':
		evade = target.get_stat('evasion')
	else:
		evade = 0

func setup_final():
	get_from_template('chance')
	if typeof(chance) == TYPE_ARRAY:
		chance = input_handler.calculate_number_from_string_array(chance, caster, target)
	get_from_template('evade')
	if typeof(evade) == TYPE_ARRAY:
		evade = input_handler.calculate_number_from_string_array(evade, caster, target)
	get_from_template('armor_p')
	if typeof(armor_p) == TYPE_ARRAY:
		armor_p = input_handler.calculate_number_from_string_array(armor_p, caster, target)
	get_from_template('critchance')
	if typeof(critchance) == TYPE_ARRAY:
		critchance = input_handler.calculate_number_from_string_array(critchance, caster, target)
	if target == null or caster.combatgroup == target.combatgroup:
		critchance = 0
	if template.has('custom_duration'):
		tempdur = input_handler.calculate_number_from_string_array(template.custom_duration, caster, target)


func hit_roll():#not implemented various chance stat rolls due to not having formulaes
	if type == 'social':
		hit_res = variables.RES_HIT
		return
	var prop = chance - evade
	if (!target.can_evade()): prop = 100 #target can not evade
	if (caster != null) and (caster.combatgroup == target.combatgroup): prop = 100 #targeting ally
	if prop < randf()*100:
		hit_res = variables.RES_MISS
	elif critchance < randf()*100:
		hit_res = variables.RES_HIT
	else:
		hit_res = variables.RES_CRIT

func apply_atomic(tmp):
	match tmp.type:
		'stat_add':
			if tmp.stat == 'value':
				for i in range(value.size()): 
					if !(damagestat[i] in variables.dmg_mod_list): continue
					if (tmp.has('stats') && !tmp.stats.has(damagestat[i])): continue
					if (tmp.has('statignore') && tmp.statignore.has(damagestat[i])): continue
					value[i] += tmp.value
				pass
			else: set(tmp.stat, get(tmp.stat) + tmp.value)
		'stat_mul':
			if tmp.stat == 'value':
				for i in range(value.size()): 
					if !(damagestat[i] in variables.dmg_mod_list): continue
					if (tmp.has('stats') && !tmp.stats.has(damagestat[i])): continue
					if (tmp.has('statignore') && tmp.statignore.has(damagestat[i])): continue
					value[i] *= tmp.value
				pass
			else: set(tmp.stat, get(tmp.stat) * tmp.value)
		'stat_set':
			if tmp.stat == 'value':
				for i in range(value.size()): 
					if !(damagestat[i] in variables.dmg_mod_list): continue
					if (tmp.has('stats') && !tmp.stats.has(damagestat[i])): continue
					if (tmp.has('statignore') && tmp.statignore.has(damagestat[i])): continue
					value[i] = tmp.value
				pass
			else: set(tmp.stat, tmp.value)
		'add_tag':
			tags.push_back(tmp.value)


func apply_effect(eff):
	var obj = effects_pool.get_effect_by_id(eff)
	match obj.template.type:
		'trigger':
			obj.set_args('skill', self)
			effects.push_back(obj.id)
			obj.apply()
		'oneshot':
			obj.applied_obj = self
			obj.apply()


func remove_effects():
	for e in effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()

func process_event(ev):
	for e in effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.set_args('skill', self)
		eff.process_event(ev)



func resolve_value(check_m):
	value.resize(long_value.size())
	var dmgmod = caster.get_damage_mod(template)
	for i in range(long_value.size()):
		var endvalue
		if typeof(long_value[i]) != TYPE_ARRAY:#value as dmg multiplier, combat only
			var atk
			var stat
			var data = caster.get_stat_data()
			if ability_type == 'skill':
				stat = caster.get_stat(data['skill_stat'])
				atk = caster.get_stat(data['skill_atk'])
			elif ability_type == 'spell':
				stat = caster.get_stat(data['spell_stat'])
				atk = caster.get_stat(data['spell_atk'])
			else: 
				print('ERROR IN SKILL TEMPLATE %s' % code)
				return
			endvalue = long_value[i] * atk * (1 + stat/100.0)
		else: endvalue = input_handler.calculate_number_from_string_array(long_value[i], caster, target)
		#modify melee atk from backrow and apply dmgmod
		if variables.dmg_mod_list.has(damagestat[i]): 
			var rangetype = target_range
			if target_range == 'weapon':
				if caster.gear.rhand == null:
					rangetype = 'melee'
				else:
					var weapon = state.items[caster.gear.rhand]
					rangetype = weapon.weaponrange
			if rangetype == 'melee' && globals.combat_node.FindFighterRow(caster) == 'backrow' && check_m:
				endvalue /= 2
			endvalue *= dmgmod
		value[i] = endvalue

func setup_effects_final():
	process_value = value[0]
	if template.has('custom_duration'):
		for e in effects:
			var eff = effects_pool.get_effect_by_id(e)
			eff.set_args('duration', tempdur)

func calculate_dmg():
	apply_random() 
	
	if damage_type == 'weapon':
		damage_type = caster.get_weapon_element()
	#	damagesrc = variables.S_PHYS #maybe needs to get from weapon
#	elif damage_type == 'fire':
#		damagesrc = variables.S_FIRE
#	elif damage_type == 'water':
#		damagesrc = variables.S_WATER
#	elif damage_type == 'air':
#		damagesrc = variables.S_AIR
#	elif damage_type == 'earth':
#		damagesrc = variables.S_EARTH
	
	#crit modification
	if hit_res == variables.RES_CRIT and !tags.has('nocritmod'):
		for i in range(value.size()): 
			if variables.dmg_mod_list.has(damagestat[i]):
				value[i] *= caster.get_stat('critmod')
	
	#reduction
	var reduction
	if ability_type == 'skill':
		reduction = max(0, target.get_stat('armor') - armor_p)
		reduction = min(95, reduction)
	elif ability_type == 'spell':
		reduction = max(0, target.get_stat('mdef'))
		reduction = min(100, reduction)
	else: 
		print('ERROR IN SKILL TEMPLATE %s' % code)
		return
	
	if !tags.has('noreduce'):#tag for all reduction-ignoring skills i.e heals and others
		for i in range(value.size()): 
			if variables.dmg_mod_list.has(damagestat[i]):
				 value[i] *= (float(100 - reduction)/100.0)
	
	#resist
#	if variables.resists_list.has(damage_type) and !tags.has('noresist'):
#		for i in range(value.size()): 
#			if variables.dmg_mod_list.has(damagestat[i]):
#				 value[i] *= (float(100 - target.get_stat('resists')[damage_type])/100.0)
	
	for v in value: v = round(v)


func apply_random():
	for i in range(value.size()):
		var rmin
		var rmax
		if variables.relative_random_add:
			rmin = 0
			rmax = random_factor[i]
		else:
			rmin = -random_factor[i]
			rmax = random_factor[i]
		var val_add = globals.rng.randi_range(rmin, rmax)
		rmin = 1.0 - random_factor_p[i]
		rmax = 1.0 + random_factor_p[i]
		var val_mul = globals.rng.randf_range(rmin,rmax)
		value[i] += val_add
		value[i] *= val_mul
