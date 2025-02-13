extends Reference
#class_name S_Skill

var parent
var template

var caster
var target

var sskill_value = ResourceScripts.scriptdict.class_sskill_value_combat 
var combatnode
var queuenode

var value = []

var target_range
var ability_type

var tags setget _callerror, get_tags

var chance
var evade
var critchance
var armor_p

var hit_res

var pval_i
var process_value
var random_factor
var random_factor_p
var critmod = 1.0
var tempdur

var effects = []


func _init():
	caster = null
	target = null
	random_factor = 0
	random_factor_p = 0.0


func get_from_template(attr):
	if template.has(attr):
		if typeof(template[attr]) == TYPE_ARRAY:
			set(attr, template[attr].duplicate())
			return
		set(attr, template[attr])


func createfromskill():
	target_range = parent.target_range
	ability_type = parent.ability_type
	pval_i = 0
	for v in range(template.value.size()): 
		value.push_back(sskill_value.new(self, template.value[v]))
		if value[v].template.is_process:
			 pval_i = v


func process_check(check:Array): #2remake
	var op1 = check[0]
	var op2 = check[2]
	if op1 in variables.skill_args_checking_list_3:
		if op1 == 'damage_type':
			if check[1] == 'eq':
				for val in value:
					if val.damage_type == op2: return true
				return false
			elif check[1] == 'neq':
				for val in value:
					if val.damage_type == op2: return false
				return true
		elif typeof(op1) == TYPE_STRING: 
			op1 = get(op1)
		return input_handler.operate(check[1], op1, op2)
	elif op1 in variables.skill_args_checking_list_1 or op1 in variables.skill_args_checking_list_2:
		return parent.process_check(check)
	else:
		print ("error in matching skill arg check: %s" % str(check))
		return false


func _callerror(value):
	print('error - wrong tags set')


func get_tags():
	return parent.parent.tags


func setup_caster(c):
	caster = c
	if c!= null:
		if parent.ability_type == 'spell':
			chance = 100
		else:
			chance = caster.get_stat('hitrate')
		critchance = caster.get_stat('critchance')
		critmod = caster.get_stat('critmod')
		armor_p = caster.get_stat('armorpenetration')
	else:
		chance = 100
		critchance = 0
		armor_p = 0
	setup_weapon_element()


func setup_target(t):
	target = t
	if t == null: 
		return
	if parent.ability_type == 'spell':
		evade = 0
	else:
		evade = target.get_stat('evasion')


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


func setup_effects(arr): #call from iteration handler
	for e in arr:
		var e_template = e
		if e_template is String:
			e_template = Effectdata.effect_table[e]
		if e_template.type == 'trigger':
			if e_template.trigger.has(variables.TR_CAST_TARGET) or e_template.trigger.has(variables.TR_CAST): #applied at upper levels
				continue
		
		var eff = effects_pool.e_createfromtemplate(e, self)
		apply_effect(effects_pool.add_effect(eff))


func hit_roll():#not implemented various chance stat rolls due to not having formulaes
	var prop = chance - evade
	if (!target.can_evade()): 
		prop = 100 #target can not evade
	if (caster != null) and (caster.combatgroup == target.combatgroup): 
		prop = 100 #targeting ally
	if prop < 5: 
		prop = 5
	if prop < randf()*100:
		hit_res = variables.RES_MISS
	elif critchance < randf()*100:
		hit_res = variables.RES_HIT
	else:
		hit_res = variables.RES_CRIT


func apply_atomic(tmp): 
	if tmp.has('stat') and tmp.stat in ['repeat', 'follow_up', 'target_number', 'number_rnd_targets']:
		parent.apply_atomic(tmp)
		return
	if tmp.type in ['add_tag', 'clone', 'setup_instant']:
		parent.apply_atomic(tmp)
		return
	
	if tmp.has('stat') and tmp.stat in ['value', 'is_drain', 'cap']:
		for i in range(value.size()):
			value[i].apply_atomic(tmp)
		return
	match tmp.type:
		'stat_add':
			set(tmp.stat, get(tmp.stat) + tmp.value)
		'stat_mul':
			set(tmp.stat, get(tmp.stat) * tmp.value)
		'stat_set':
			set(tmp.stat, tmp.value)


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
	for v in value: 
		v.resolve_value(check_m)
	process_value = value[pval_i].value


func setup_effects_final():
	process_value = value[pval_i].value
	if template.has('custom_duration'):
		for e in effects:
			var eff = effects_pool.get_effect_by_id(e)
			eff.set_args('duration', tempdur)


func calculate_dmg():
	for v in value: 
		v.calculate_dmg()


func apply_random():
	for v in value: 
		v.apply_random()


func setup_weapon_element():
	for v in value: 
		v.setup_weapon_element()


func execute_skill():
	var text = ''
	if hit_res == variables.RES_CRIT:
		text += "[color=yellow]Critical!![/color] "
		queuenode.add_crit(target.displaynode)
	#new section applying conception of multi-value skills
	#TO POLISH & REMAKE
	for i in value:
		text += i.execute()
	queuenode.add_combatlog(text)
	for i in ['ice']: #add other custom death overlays here
		if get_tags().has("kill_animation_%s" % i):
			target.displaynode.setup_overlay(i)


func cleanup():
	remove_effects()
	parent = null
	caster = null
	target = null
