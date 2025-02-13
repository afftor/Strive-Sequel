extends Reference
#class_name S_Skill

var parent
var template

var caster
var target

var combatnode
var queuenode

var ability_type
var target_range
var target_number
var number_rnd_targets = 0
#var damagesrc
var animationdict

var tags setget _callerror, get_tags

var effects = []
var queued_effects = []
var queued_atomics = []

var affected_targets = []
var instances = []

var step = 0
var state_map = [
	'invoke_init', 
	'invoke_animations_2',
	'invoke_instancing',
	'invoke_predamage',
	'invoke_damage',
	'invoke_postdamage',
	'invoke_cleanup'
]


func _callerror(value):
	print('error - wrong tags set')

func _init():
	caster = null
	target = null
	target_range = 'any'
	target_number = 'single'


func get_from_template(attr):
	if template.has(attr):
		if typeof(template[attr]) == TYPE_ARRAY:
			set(attr, template[attr].duplicate())
			return
		set(attr, template[attr])


func get_tags():
	return parent.tags

func createfromskill():
	ability_type = template.ability_type
	target_range = parent.target_range
	target_number = parent.target_number
	get_from_template('number_rnd_targets')
	if number_rnd_targets is Array:
		number_rnd_targets = globals.rng.randi_range(number_rnd_targets[0], number_rnd_targets[1])


func setup_effects(arr): #call from callback handler
	for e in arr:
		var e_template = e
		if e_template is String:
			e_template = Effectdata.effect_table[e]
		if e_template.type == 'trigger':
			if e_template.trigger.has(variables.TR_CAST_TARGET): #mb not
				if e_template.trigger.size() > 1:
					queued_effects.push_back(e_template)
			else:
				queued_effects.push_back(e_template)
				continue
		
		var eff = effects_pool.e_createfromtemplate(e, self)
		apply_effect(effects_pool.add_effect(eff))


func process_check(check:Array):
	var op1 = check[0]
	var op2 = check[2]
	if op1 in variables.skill_args_checking_list_2:
		if op1 == 'damage_type':
			if check[1] == 'eq':
				for val in template.value:
					if val.source == op2: 
						return true
				return false
			elif check[1] == 'neq':
				for val in template.value:
					if val.source == op2: return false
				return true
		else:
			op1 = get(op1)
			return input_handler.operate(check[1], op1, op2)
	elif op1 in variables.skill_args_checking_list_1:
		return parent.process_check(check)
	elif !instances.empty():
		var res = false
		for i in instances:
			res = res and i.process_check(check)
		return res
	else:
		op1 = template[op1]
		if op1 is Array:
			op1 = input_handler.calculate_number_from_string_array(op1, caster, target)
		return input_handler.operate(check[1], op1, op2)


func apply_atomic(tmp):
	if tmp.has('stat') and tmp.stat in ['repeat', 'follow_up']:
		parent.apply_atomic(tmp)
		return
	if tmp.type in ['add_tag', 'clone', 'setup_instant']:
		parent.apply_atomic(tmp)
		return
	
	if tmp.has('stat') and !(tmp.stat in ['target_number', 'number_rnd_targets']): 
		queued_atomics.push_back(tmp)
		for instance in instances:
			instance.apply_atomic(tmp)
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
	for instance in instances:
		instance.process_event(ev)


#real queue part

func invoke():
	if queuenode.apply_cash():
		queuenode.call_deferred('invoke_resume')
		return
	if queuenode.check_animation():
		yield(queuenode.animationnode, 'alleffectsfinished')
	
	
	call(state_map[step])


func invoke_init():
	if combatnode.checkwinlose() and !parent.tags.has('run_after_eoc'):
		step = state_map.size() - 1
		queuenode.call_deferred('invoke_resume')
		return
	
	process_event(variables.TR_CAST_TARGET) 
	if !parent.tags.has('passive'):
		target.process_event(variables.TR_CAST_TARGET, self)
		effects_pool.process_event(variables.TR_CAST_TARGET, target)
	
	affected_targets = combatnode.CalculateTargets(self, target, true)
	
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_animations_2():
	for i in animationdict.predamage:
		if i.target in ['target_frame']:
			queuenode.add_sfx(target.displaynode, i.code)
	for i in affected_targets:
		if template.has('sounddata') and !template.sounddata.empty() and template.sounddata.strike != null:
			if template.sounddata.strike == 'weapon':
				caster.displaynode.process_sound(caster.get_weapon_sound())
			else:
				caster.displaynode.process_sound(template.sounddata.strike)
		for j in animationdict.predamage:
			if j.target in ['caster','target']:
				var sfxtarget = globals.ProcessSfxTarget(j.target, caster, i)
				if sfxtarget != null:
					queuenode.add_sfx(sfxtarget, j.code)
	
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_instancing():
	for i in affected_targets:
		#special results
		if template.has('damage_type') and template.damage_type == 'summon':
			combatnode.summon(template.value[0], template.value[1], caster.combatgroup, true);
		elif template.has('damage_type') and template.damage_type == 'resurrect':
			i.resurrect(input_handler.calculate_number_from_string_array(template.value[0], caster, target)) #not sure
		if template.has('damage_type') and template.damage_type == 'setup_global':
			combatnode.setup_autoskill(template.value, caster)
		else:
			#default skill result
			var s_skill2 = queuenode.skill_instance_handler.new()
			s_skill2.parent = self
			s_skill2.template = template
			s_skill2.queuenode = queuenode
			s_skill2.combatnode = combatnode
			s_skill2.createfromskill()
			s_skill2.setup_effects(queued_effects)
			for atomic in queued_atomics:
				s_skill2.apply_atomic(atomic)
			s_skill2.setup_caster(caster)
			s_skill2.setup_target(i)
			s_skill2.setup_final()
			#place for non-existing another trigger
			s_skill2.process_event(variables.TR_PREHIT)
			if parent.mode != variables.SKILL_AUTO and !parent.tags.has('passive'): 
				s_skill2.caster.process_event(variables.TR_PREHIT, s_skill2)
				effects_pool.process_event(variables.TR_PREHIT, s_skill2.caster)
			if !parent.tags.has('passive'):
				s_skill2.target.process_event(variables.TR_PREDEF, s_skill2)
				effects_pool.process_event(variables.TR_PREDEF, s_skill2.target)
			
			s_skill2.hit_roll()
			s_skill2.resolve_value(combatnode.CheckMeleeRange(caster.combatgroup))
			instances.push_back(s_skill2)
	
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_predamage():
	for s_skill2 in instances:
		s_skill2.process_event(variables.TR_HIT)
		if parent.mode != variables.SKILL_AUTO and !parent.tags.has('passive'): 
			s_skill2.caster.process_event(variables.TR_HIT, s_skill2)
			effects_pool.process_event(variables.TR_HIT, s_skill2.caster)
		if !parent.tags.has('passive'):
			s_skill2.target.process_event(variables.TR_DEF, s_skill2)
			effects_pool.process_event(variables.TR_DEF, s_skill2.target)
		s_skill2.setup_effects_final()
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_damage():
	for s_skill2 in instances:
		#check miss
		if s_skill2.hit_res == variables.RES_MISS:
			queuenode.add_sfx(s_skill2.target.displaynode, 'miss')
			queuenode.add_combatlog(target.get_short_name() + " evades the damage.")
		else:
			#hit landed animation
			if template.has('sounddata') and !template.sounddata.empty() and template.sounddata.hit != null:
				if template.sounddata.hittype == 'absolute':
					s_skill2.target.displaynode.process_sound(template.sounddata.hit)
				elif template.sounddata.hittype == 'bodyarmor':
					s_skill2.target.displaynode.process_sound(globals.calculate_hit_sound(template, caster, s_skill2.target))
			for j in animationdict.postdamage:
				var sfxtarget = globals.ProcessSfxTarget(j.target, caster, s_skill2.target)
				sfxtarget.process_sfx(j.code)
			#applying resists
			s_skill2.calculate_dmg()
			#logging result & dealing damage
			s_skill2.execute_skill()
	
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_postdamage():
	for s_skill2 in instances:
		s_skill2.process_event(variables.TR_POSTDAMAGE)
		if parent.mode != variables.SKILL_AUTO and !parent.tags.has('passive'): 
			s_skill2.caster.process_event(variables.TR_POSTDAMAGE, s_skill2)
			effects_pool.process_event(variables.TR_POSTDAMAGE, s_skill2.caster)
		if s_skill2.target.hp <= 0:
			process_event(variables.TR_KILL)
			if parent.mode != variables.SKILL_AUTO and !parent.tags.has('passive'): 
				caster.process_event(variables.TR_KILL, self)
				effects_pool.process_event(variables.TR_KILL, caster)
				caster.add_stat('metrics_kills', 1)
		else:
			if !parent.tags.has('passive'):
				s_skill2.target.process_event(variables.TR_POST_TARG, s_skill2)
				effects_pool.process_event(variables.TR_POST_TARG, s_skill2.target)
		if s_skill2.target.displaynode != null:
			s_skill2.target.displaynode.rebuildbuffs()
	
	combatnode.checkdeaths()
	
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_cleanup():
	for s_skill2 in instances:
		s_skill2.cleanup()
	
	instances.clear()
	affected_targets.clear()
	remove_effects()
	parent = null
	caster = null
	target = null
	
	step += 1
	queuenode.call_deferred('invoke_finished')

