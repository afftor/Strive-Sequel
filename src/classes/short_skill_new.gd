extends Reference
#class_name S_Skill

var code
var template

var type

var ability_type
var tags
var value = []
var manacost
var energycost
var goldcost
var target_range
var target_number
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
var pval_i
var process_value
var random_factor
var random_factor_p
var tempdur

var sskill_value = ResourceScripts.scriptdict.class_sskill_value 


func _init():
	caster = null
	target = null
	target_range = 'any'
	target_number = 'single'
	goldcost = 0
	random_factor = 0
	random_factor_p = 0.0

func clone():
	var res = dict2inst(inst2dict(self))
	res.effects.clear()
	for e in template.effects:
		var eff = effects_pool.e_createfromtemplate(e, res)
		res.apply_effect(effects_pool.add_effect(eff))
	res.value = []
	for v in value:
		res.value.push_back(v.clone())
	for v in res.value: 
		v.parent = res
	return res

func get_from_template(attr):
	if template.has(attr):
		if typeof(template[attr]) == TYPE_ARRAY:
			set(attr, template[attr].duplicate())
			return
		set(attr, template[attr])

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
	
	pval_i = 0
	for v in range(template.value.size()): 
		value.push_back(sskill_value.new(self, template.value[v]))
		if value[v].template.is_process: pval_i = v
	
	for e in template.effects:
		var eff = effects_pool.e_createfromtemplate(e, self)
		apply_effect(effects_pool.add_effect(eff))
	
	repeat = template.repeat


func process_check(check:Array):
	var op1 = check[0]
	var op2 = check[2]
	if typeof(op1) == TYPE_STRING:
		op1 = get(op1)
#	if typeof(op2) == TYPE_STRING && check[1] != 'has':
#		op2 = get(op2)
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
					value[i].apply_atomic(tmp)
			else: set(tmp.stat, get(tmp.stat) + tmp.value)
		'stat_mul':
			if tmp.stat == 'value':
				for i in range(value.size()):
					value[i].apply_atomic(tmp)
				pass
			else: set(tmp.stat, get(tmp.stat) * tmp.value)
		'stat_set':
			if tmp.stat == 'value':
				for i in range(value.size()):
					value[i].apply_atomic(tmp)
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
	for v in value: v.resolve_value(check_m)
	process_value = value[pval_i].value

func setup_effects_final():
	process_value = value[pval_i].value
	if template.has('custom_duration'):
		for e in effects:
			var eff = effects_pool.get_effect_by_id(e)
			eff.set_args('duration', tempdur)

func calculate_dmg():
	for v in value: v.calculate_dmg()

func apply_random():
	for v in value: v.apply_random()
