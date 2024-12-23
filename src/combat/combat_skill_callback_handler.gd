extends Reference
#class_name S_Skill

var code
var template

var caster
var target
var last_target

var combatnode
var queuenode

var ability_type
var tags
var mode

var target_range
var target_number
#var number_rnd_targets = 0
var keep_target = variables.TARGET_FORCED
var next_target = variables.NT_MELEE
#var damagesrc
var repeat
var iterations_played = 0

var follow_up = null
var parent = null

var animationdict =  {windup = [], predamage = [], postdamage = []}

var effects = []
var queued_effects = []
var queued_atomics = []

var active_instance = null 

var step = 0
var state_map = [
	'invoke_init', #init, pay costs, logging
	'invoke_animations_1', #animations sorting
	'invoke_instancing', # repeat cycle, refine targets
	'invoke_skillfinish', # finishing triggers, setup fa
	'invoke_finalize', # setup endturn
	'invoke_cleanup'
]


func _init(md = variables.SKILL_BASE):
	caster = null
	target = null
	target_range = 'any'
	target_number = 'single'
	repeat = 1
	mode = md


func clone(): #2remake, 2move to queue part 
	if mode == variables.SKILL_FA:
		parent.clone()
		return
	
	var tmp_handler = queuenode.add_skill_callback(true)
	tmp_handler.mode = variables.SKILL_COPY
	tmp_handler.createfromskill(template)
	tmp_handler.setup_caster(caster)
	tmp_handler.setup_target(target)


func setup_instant():
	if mode == variables.SKILL_FA:
		parent.setup_instant()
		return
	tags.push_back('instant')


func get_from_template(attr):
	if template.has(attr):
		if typeof(template[attr]) == TYPE_ARRAY:
			set(attr, template[attr].duplicate())
		else:
			set(attr, template[attr])


func createfromskill(temp):
	template = temp.duplicate(true)
	code = template.code
	ability_type = template.ability_type
	tags = template.tags.duplicate()
	get_from_template('target_range')
	get_from_template('target_number')
#	get_from_template('number_rnd_targets')
#	if number_rnd_targets is Array:
#		number_rnd_targets = globals.rng.randi_range(number_rnd_targets[0], number_rnd_targets[1])
	get_from_template('repeat')
	get_from_template('keep_target')
	get_from_template('next_target')
	
	get_from_template('follow_up')
	
	setup_effects()
	


func process_check(check:Array):
	var op1 = check[0]
	var op2 = check[2]
	if op1 in variables.skill_args_checking_list_1:
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
	elif active_instance != null:
		return active_instance.process_check(check)
	else:
		op1 = template[op1]
		if op1 is Array:
			op1 = input_handler.calculate_number_from_string_array(op1, caster, target)
		return input_handler.operate(check[1], op1, op2)


func setup_caster(c):
	caster = c
	if c!= null:
		if target_range == 'weapon':
			target_range = caster.get_weapon_range()
	else: 
		caster = combatnode.dummy


func setup_target(t):
	target = t
	last_target = t


func apply_atomic(tmp):
	if tmp.has('stat') and !(tmp.stat in ['repeat', 'follow_up']): #possibly wrong
		queued_atomics.push_back(tmp)
		if active_instance != null:
			active_instance.apply_atomic(tmp)
		return
	#assume tmp.stat == 'repeat'
	match tmp.type:
		'stat_add':
			set(tmp.stat, get(tmp.stat) + tmp.value)
		'stat_mul':
			set(tmp.stat, get(tmp.stat) * tmp.value)
		'stat_set':
			set(tmp.stat, tmp.value)
		'add_tag':
			tags.push_back(tmp.value)
		'clone':
			clone()
		'setup_instant':
			setup_instant()


func setup_effects():
	for e in template.effects:
		var e_template = e
		if e_template is String:
			e_template = Effectdata.effect_table[e]
		if e_template.type == 'trigger':
			if e_template.trigger.has(variables.TR_CAST): #possibly more
				if e_template.trigger.size() > 1:
					queued_effects.push_back(e_template)
			else:
				queued_effects.push_back(e_template)
				continue
		
		var eff = effects_pool.e_createfromtemplate(e, self)
		apply_effect(effects_pool.add_effect(eff))


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
	if active_instance != null:
		active_instance.process_event(ev)



func refine_target(skill, caster, ttarget): #s_skill, caster, target
	var target = ttarget.position
	var change = false
	#var skill = Skillsdata.skilllist[s_code]
	if skill.keep_target == variables.TARGET_FORCED: 
		change = false #intentional target lock
	elif ttarget == null: 
		change = true #forced change
	elif ttarget.defeated or ttarget.hp <= 0: 
		change = true #forced change. or not. nvn error
	elif skill.keep_target == variables.TARGET_NOKEEP: 
		change = true #intentional change
	elif skill.keep_target == variables.TARGET_KEEPFIRST: 
		skill.keep_target = variables.TARGET_NOKEEP
	elif skill.keep_target == variables.TARGET_MOVEFIRST:
		skill.keep_target = variables.TARGET_KEEP
		change = true
	if !change: 
		return ttarget
	#fing new target
	match skill.next_target:
		variables.NT_ANY:
			var avtargets = combatnode.get_enemy_targets_all(caster)
			if avtargets.empty(): return null
			return input_handler.random_from_array(avtargets)
		variables.NT_ANY_NOREPEAT:
			var avtargets = combatnode.get_enemy_targets_all(caster)
			if avtargets.empty(): return null
			avtargets.erase(target)
			return input_handler.random_from_array(avtargets)
		variables.NT_MELEE:
			var avtargets = combatnode.get_enemy_targets_melee(caster)
			if avtargets.empty(): return null
			return input_handler.random_from_array(avtargets)
		variables.NT_WEAK:
			var avtargets = combatnode.get_enemy_targets_all(caster)
			if avtargets.empty(): return null
			var t = 0
			for i in range(avtargets.size()):
				if avtargets[i].hp < avtargets[t].hp: t = i
			return avtargets[t]
		variables.NT_WEAK_MELEE:
			var avtargets = combatnode.get_enemy_targets_melee(caster)
			if avtargets.empty(): return null
			var t = 0
			for i in range(avtargets.size()):
				if avtargets[i].hp < avtargets[t].hp: t = i
			return avtargets[t]
		variables.NT_BACK:
			if combatnode.FindFighterRow(ttarget) == 'backrow': 
				return null
			else: 
				return combatnode.get_char_by_pos(target + 3)
		variables.NT_CASTER:
			return caster

#real queue part
func invoke():
	if queuenode.apply_cash():
		queuenode.call_deferred('invoke_resume')
		return
	if queuenode.check_animation():
		yield(queuenode.animationnode, 'alleffectsfinished')
	
	
	call(state_map[step])


func invoke_init():
	if combatnode.checkwinlose() and !tags.has('run_after_eoc'):
		step = state_map.size() - 1
		queuenode.call_deferred('invoke_resume')
		return
	
	match mode:
		variables.SKILL_BASE:
			queuenode.add_combatlog("\n" + caster.get_short_name() + ' uses ' + template.name + ". ")
			caster.pay_cost(template.cost)
			if template.combatcooldown != 0:
				caster.skills.combat_cooldowns[code] = template.combatcooldown
			if caster.combatgroup == 'ally':
				if !caster.has_status('ignore_catalysts_for_%s' % code):
					for i in template.catalysts:
						ResourceScripts.game_res.materials[i] -= template.catalysts[i]
				if template.charges > 0:
					if caster.skills.combat_skill_charges.has(code):
						caster.skills.combat_skill_charges[code] += 1
					else:
						caster.skills.combat_skill_charges[code] = 1
					caster.skills.daily_cooldowns[code] = template.cooldown
				if ability_type == 'skill':
					caster.add_stat('physics', rand_range(0.1,0.3))
				elif ability_type == 'spell':
					caster.add_stat('wits', rand_range(0.1,0.3))
					caster.add_stat('metrics_spellused', 1)
				if tags.has('heal'):
					caster.add_stat('metrics_healused', 1)
		
		variables.SKILL_ITEM:
			queuenode.add_combatlog("\n" + caster.get_short_name() + ' uses ' + combatnode.activeitem.name + ". ")
			combatnode.activeitem.amount -= 1
			combatnode.activeitem = null
			caster.selectedskill = caster.get_skill_by_tag('default')
		
		variables.SKILL_AUTO:
			queuenode.add_combatlog("\n" + template.name + "! ")
		
		variables.SKILL_COPY:
			queuenode.add_combatlog("\n" + caster.get_short_name() + ' copied ' + template.name + ". ")
	
	if mode != variables.SKILL_AUTO and !tags.has('passive'):
		process_event(variables.TR_CAST) 
		caster.process_event(variables.TR_CAST, self)
		effects_pool.process_event(variables.TR_CAST, caster)
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_animations_1():
	var animations = template.sfx.duplicate(true)
	#sort animations
	for i in animations:
		if i.code == 'weapon':
			i.code = caster.get_weapon_animation()
		animationdict[i.period].append(i)
	#casteranimations
	#for sure at windup there should not be real_target-related animations
	if template.has('sounddata') and !template.sounddata.empty() and template.sounddata.initiate != null:
		caster.displaynode.process_sound(template.sounddata.initiate)
	for i in animationdict.windup:
		var sfxtarget = globals.ProcessSfxTarget(i.target, caster, target)
		queuenode.add_sfx(sfxtarget, i.code)
	
	combatnode.turns += 1
	step += 1
	queuenode.call_deferred('invoke_resume')


func invoke_instancing():
	if combatnode.checkwinlose():
		
		step += 1 #forward to finalize
	elif iterations_played < repeat:
		#refine target
		combatnode.UpdateSkillTargets(caster, template, true)
		last_target = refine_target(self, caster, last_target)
		
		#make instance
		iterations_played += 1
		active_instance = queuenode.add_iteration()
		active_instance.template = template
		active_instance.parent = self
		active_instance.createfromskill()
		active_instance.animationdict = animationdict
		active_instance.caster = caster
		active_instance.target = last_target
		active_instance.setup_effects(queued_effects)
		for atomic in queued_atomics:
			active_instance.apply_atomic(atomic)
	else:
		step += 1
	combatnode.turns += 1
	queuenode.call_deferred('invoke_resume')


func invoke_skillfinish():
	if mode != variables.SKILL_AUTO and !tags.has('passive'):
		process_event(variables.TR_SKILL_FINISH)
		caster.process_event(variables.TR_SKILL_FINISH, self)
		effects_pool.process_event(variables.TR_SKILL_FINISH, caster)
	
	if follow_up != null:
		var tmp_handler = queuenode.add_skill_callback()
		tmp_handler.mode = variables.SKILL_FA
		tmp_handler.parent = self
		tmp_handler.createfromskill(Skilldata.get_template_combat(follow_up, caster))
		tmp_handler.setup_caster(caster)
		tmp_handler.setup_target(target)
	
	step += 1
	combatnode.turns += 1
	queuenode.call_deferred('invoke_resume')


func invoke_finalize():
	if !(mode in [variables.SKILL_FA, variables.SKILL_EFFECT, variables.SKILL_COPY]):
		if !tags.has('instant') or caster.hp <= 0 or !caster.can_act():
			queuenode.add_end_action(caster)
		else:
			queuenode.add_end_action(caster, true)
	
	step += 1
	combatnode.turns += 1
	queuenode.call_deferred('invoke_resume')


func invoke_cleanup():
	if combatnode.fighterhighlighted == true:
		combatnode.FighterMouseOver(target.id)
	
	combatnode.Off_Target_Glow()
	remove_effects()
	parent = null
	active_instance = null
	caster = null
	target = null
	
	queuenode.call_deferred('invoke_finished')

