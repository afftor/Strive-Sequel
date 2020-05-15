extends Reference
#class_name S_Skill_legacy

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
#		var eff = effects_pool.e_createfromtemplate(e, self)
#		apply_effect(effects_pool.add_effect(eff))
		pass
	if template.has('repeat'):
		repeat = template.repeat
	else:
		repeat = 1
	if template.has('is_drain'):
		is_drain = true

func convert_to_new_template():
	var res_res = {}
	res_res.new_syntax = true
	res_res.icon = template.icon
	res_res.reqs = template.reqs.duplicate()
	res_res.targetreqs = template.targetreqs.duplicate()
	#res_res.value = res_values.duplicate()
	res_res.value = []
	for i in range(long_value.size()):
		var tmp = {}
		tmp.damagestat = damagestat[i]
		if tmp.damagestat != "no_stat":
			match tmp.damagestat[0]:
				'+': tmp.dmgf = 0
				'-': tmp.dmgf = 1
				'=': tmp.dmgf = 2
			tmp.damagestat = tmp.damagestat.right(1)
			tmp.nocrit = true
			tmp.nodef = true
		else: 
			tmp.dmgf = 2
			tmp.nocrit = !variables.dmg_mod_list.has(damagestat[i])
			tmp.nodef = tags.has('noreduce')
		#res_res.dmgf = dmgf.selected
		tmp.receiver = receiver[i]
		tmp.source = damage_type
		tmp.nomod = !variables.dmg_mod_list.has(damagestat[i])
		if typeof(long_value[i]) != TYPE_ARRAY:
			tmp.value1 = [str(long_value[i])]
			tmp.value2 = ['0']
			tmp.value3 = ['0']
		else: 
			tmp.value1 = ['0']
			tmp.value2 = ['0']
			tmp.value3 = long_value[i].duplicate()
		tmp.random_factor = random_factor[i]
		tmp.random_factor_p = random_factor_p[i]
		tmp.is_drain = is_drain
		tmp.is_process = (i == 0)
		res_res.value.push_back(tmp)
	res_res.catalysts = {}
	res_res.effects = template.effects.duplicate()
	if template.has('catalysts'): res_res.catalysts = template.catalysts.duplicate()
	else: res_res.catalysts = {}
	res_res.code = template.code
	if template.has('name'): res_res.name = template.name
	else: res_res.name = ""
	if template.has('descript'): res_res.descript = template.descript
	res_res.type = template.type
	if template.has('ability_type'): res_res.ability_type = template.ability_type
	else: res_res.ability_type = 'social'
	res_res.manacost = manacost
	res_res.goldcost = goldcost
	if template.has('charges'): res_res.charges = template.charges
	if template.has('cooldown'): res_res.cooldown = template.cooldown
	if template.has('combatcooldown'): res_res.combatcooldown = template.combatcooldown
	if template.has('receiverdaylimit'): res_res.receiverdaylimit = template.receiverdaylimit
	if template.has('dialogue_report'): res_res.dialogue_report = template.dialogue_report
	if template.has('dialogue_image'): res_res.dialogue_image = template.dialogue_image
	if template.has('dialogue_show_repeat'): res_res.dialogue_show_repeat = template.dialogue_show_repeat
	if template.has('target'): res_res.target = template.target
	if template.has('target_number'): res_res.target_number = template.target_number
	if template.has('target_range'): res_res.target_range = template.target_range
	if template.has('sfx'): res_res.sfx = template.sfx.duplicate()
	else: res_res.sfx = []
	if template.has('sounddata'): res_res.sounddata = template.sounddata.duplicate()
	else: res_res.sounddata = {}
	res_res.repeat = repeat
	if template.has('custom_duration'): res_res.custom_duration = template.custom_duration.duplicate()
	if template.has('chance'): res_res.chance = template.chance
	if template.has('evade'): res_res.evade = template.evade
	if template.has('armor_p'): res_res.armor_p = template.armor_p
	if template.has('critchance'): res_res.critchance = template.critchance
	if template.has('process_no_stat'): res_res.process_no_stat = template.process_no_stat
	if template.has('energycost'): res_res.energycost = template.energycost
	if template.has('follow_up'): res_res.follow_up = template.follow_up
	if template.has('social_skill_stats'): res_res.social_skill_stats = template.social_skill_stats
	res_res.tags = tags.duplicate()
	return res_res

