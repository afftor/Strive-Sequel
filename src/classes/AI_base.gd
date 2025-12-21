extends Reference
#class_name ai_base

var app_obj_ref  #applied character

var ai_data = {}
var skill_targets = {} #s_name:[targets]
var ai_position = 'melee'

var current_state
var next_state

func _init():
	current_state = 0
	next_state = 0


func set_obj(app_obj):
	app_obj_ref = weakref(app_obj)


func get_obj():
	return app_obj_ref.get_ref()


func get_weapon_range():
	return ai_position


func _ready():
	pass # Replace with function body.


func set_single_state(data):
	var state = {}
	state['transmissions'] = []
	state['choices'] = data.duplicate() 
	ai_data[0] = state


func set_simple_ai(profile):
	ai_data = AI_data.get(profile).duplicate()


func _set_next_state():
	#next state set up by previous action
	#only actual for inherited complex ais
	if next_state != current_state:
		current_state = next_state 
		return
	# controlled_object_state-based state change 
	for line in ai_data[current_state].transmissions:
		if get_obj().process_check(line.check):
			current_state = line.next_state
			return


func _calculate_target_value(app_obj, prop_target, skill):
	var r_target = characters_pool.get_char_by_id(input_handler.combat_node.battlefield[prop_target])
	if skill.has('targetreqs') and !r_target.checkreqs(skill.targetreqs):
		return 0.0
	
	var act_targets = input_handler.combat_node.CalculateTargets(skill, r_target)
	if act_targets.empty():
		return 0.0
	
	var res = 1.0
	#positive
	if skill.tags.has('heal'):
		for t in act_targets:
			res += t.need_heal() / act_targets.size()
	if skill.tags.has('buff'): 
		res = max(res, 1.0)
	if skill.tags.has('resurrect'):
		res = max(res, 1.0)
	#negative
	if skill.tags.has('damage'): 
		var _bonus = 0.0
		for t in act_targets:
			if skill.tags.has('aoe'):
				_bonus += t.need_heal() + 0.5
			else:
				_bonus = max(t.need_heal() + 0.5, _bonus)
		res += max(0.0, _bonus)
	if skill.tags.has('debuff') and !skill.tags.has('aoe'): 
		for t in act_targets:
			res += (1.0 - t.need_heal()) / act_targets.size()
	#aoe
	match skill.target_number:
		'all': 
			if act_targets.size() < 4:
				res *= 0.5
			if act_targets.size() < 2:
				res *= 0.5
		'line':
			if act_targets.size() < 2:
				res *= 0.4
		'row':
			if act_targets.size() < 2:
				res *= 0.5
		'x_random':
			if act_targets.size() < skill.number_rnd_targets:
				res *= 0.5
	#taunt
	if app_obj.has_status('taunt_soft'):
		if app_obj.get_stat('taunt') == r_target.id:
			res = 1.0
		else:
			res = 0
	return res



func _calculate_targets_for_skill(app_obj, s_id, hide_ignore = false):
	var t_skill = Skilldata.get_template(s_id, app_obj)
	var target_array = []
	match t_skill.target:
		'self':
			var target_dir = {target = app_obj.position, quality = _calculate_target_value(app_obj, app_obj.position, t_skill)}
			target_array.push_back(target_dir)
		'ally':
			var pos_targets = input_handler.combat_node.get_allied_targets(app_obj)
			if t_skill.target_range == 'dead':
				pos_targets = input_handler.combat_node.get_allied_targets(app_obj, true)
			for target in pos_targets:
				if t_skill.target_range == 'not_caster' and target.id == app_obj.id:
					continue
				var target_dir = {target = target.position, quality = _calculate_target_value(app_obj, target.position, t_skill)}
				target_array.push_back(target_dir)
		'enemy':
			var pos_targets
			match t_skill.target_range:
				'weapon':
					if get_weapon_range() == 'melee':
						pos_targets = input_handler.combat_node.get_enemy_targets_melee(app_obj, hide_ignore)
					else:
						pos_targets = input_handler.combat_node.get_enemy_targets_all(app_obj, hide_ignore)
				'melee': 
					pos_targets = input_handler.combat_node.get_enemy_targets_melee(app_obj, hide_ignore)
				'any': 
					pos_targets = input_handler.combat_node.get_enemy_targets_all(app_obj, hide_ignore)
			for target in pos_targets:
				var target_dir = {target = target.position, quality = _calculate_target_value(app_obj, target.position, t_skill)}
				target_array.push_back(target_dir)
	skill_targets[s_id] = target_array



func calculate_target_list(hide_ignore = false): #utility checks and targets calculating 
	#for most of the cases reimplementing this function in inherited classes is not reqired
	#works worser for skills with repeat and random targets
	var app_obj = get_obj()
	for s_n in app_obj.get_combat_skills():
		_calculate_targets_for_skill(app_obj, s_n, hide_ignore)


func _get_weight_for_skill(s_name):
	var res = 0
#	#check if skill is in cooldown
#	if app_obj.skills.combat_cooldowns.has(s_name): return res
#	#checks if skill can be used
	var app_obj = get_obj()
	var data = Skilldata.get_template(s_name, app_obj)
#	if data.ability_type == 'skill' and app_obj.has_status('disarm') and !data.tags.has('default'): return 0
#	if data.ability_type == 'spell' and app_obj.has_status('silence') and !data.tags.has('default'): return 0
	if !get_obj().can_use_skill(data): 
		return 0
	#no targets check
	if skill_targets[s_name].size() == 0: 
		return res
#	print(skill_targets[s_name])
	#empty ai_data check
	if ai_data[current_state].choices.size() == 0:
		return 1.0
	#calculate base weight for current state
	for tag in ai_data[current_state].choices:
		if data.tags.has(tag): 
			res += ai_data[current_state].choices[tag]
	#correct weight for skills with only bad-quality targets
	var tmp = 0.0
	for target in skill_targets[s_name]: 
		tmp = max(target.quality, tmp)
	if tmp > 0:
		tmp = clamp(tmp, 0.3, 0.75) * 2.0 - 0.5
#	print(tmp)
	res *= tmp
	return res


func _get_action(hide_ignore = false):
	var app_obj = get_obj()
#	print(app_obj.npc_reference)
#	print(ai_data[current_state].choices)
	calculate_target_list(hide_ignore)
	if !hide_ignore: 
		_set_next_state()
	var actions = []
	for s_n in app_obj.get_combat_skills():
		var curw = _get_weight_for_skill(s_n)
#		print (s_n, " ", curw)
		if curw > 0: 
			actions.push_back([s_n, curw])
	if actions.size() == 0:
#		print ('ERROR IN AI TEMPLATE')
		return app_obj.get_skill_by_tag('default')
	var res = input_handler.weightedrandom(actions)
	return res


func _get_target(s_name):#for chosen with _get_action() func
	var targets = []
	for t in skill_targets[s_name]:
		targets.push_back([t.target, t.quality])
	return input_handler.weightedrandom(targets)
