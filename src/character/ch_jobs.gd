extends Reference

var parent: WeakRef

func hunt_meat():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/66.0)/1.2)

func fishing():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/150.0 + parent.get_ref().get_stat('wits')/100.0)/1.2)

func farming_veges():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/50.0 + parent.get_ref().get_stat('wits')/66.0)/1.2)

func farming_wheat():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/40.0 + parent.get_ref().get_stat('wits')/66.0)/1.2)

func farming_cloth():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/75.0 + parent.get_ref().get_stat('wits')/100.0))

func hunt_leather():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/66.0))

func hunt_leather_hard():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/33.0))

func hunt_leather_mythic():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/25.0))

func woodcutting_lumber():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/66.0))

func woodmagiccutting_lumber():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/30.0))

func woodironcutting_lumber():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/25.0))

func mining_stone():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/66.0))
	
func mining_iron():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/33.0))
	
func mining_mithril():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('physics')/30.0))


# Legacy formula for the old progress-based brothel production task.
# Current service income uses the gold_* formulas below via tasks.gold_tasks_data.
#func whoring_gold():
#	return (1 + parent.get_ref().get_stat('charm')/80.0)

 
func _non_sex_service_base_income():
	var tame_factor_mult = variables.non_sex_service_tame_factor_mult
	if parent.get_ref().has_profession('petbeast'):
		tame_factor_mult += variables.petbeast_service_tame_factor_mult
	return variables.non_sex_service_charm_factor_mult * parent.get_ref().get_stat('charm_factor') + tame_factor_mult * parent.get_ref().get_stat('tame_factor')

func gold_waitress():
	return parent.get_ref().get_stat('mod_waitress') * _non_sex_service_base_income()

func gold_hostess():
	return parent.get_ref().get_stat('mod_hostess') * _non_sex_service_base_income()

func gold_dancer():
	return parent.get_ref().get_stat('mod_dancer') * _non_sex_service_base_income()

func gold_stripper():
	return parent.get_ref().get_stat('mod_strip') * _non_sex_service_base_income()

func _sex_training_mult(skill_name):
	var level = parent.get_ref().get_stat('sex_training_' + skill_name)
	return variables.sex_training_gold_multiplier.get(level, variables.sex_training_gold_multiplier.novice)

func _sex_factor_income():
	return variables.sex_service_base_income_mult * parent.get_ref().get_stat('sexuals_factor')

func gold_petting():
	return _sex_factor_income() * _sex_training_mult('petting')

func gold_oral():
	return _sex_factor_income() * _sex_training_mult('oral')

func gold_pussy():
	return _sex_factor_income() * _sex_training_mult('pussy')

func gold_penetration():
	return _sex_factor_income() * _sex_training_mult('penetration')

func gold_anal():
	return _sex_factor_income() * _sex_training_mult('anal')

func _group_skill_level():#best training among all sex skills
	var best = 'novice'
	for skill in ['petting', 'oral', 'pussy', 'anal', 'penetration', 'tail']:
		var level = parent.get_ref().get_stat('sex_training_' + skill)
		if level == 'mastered':
			return 'mastered'
		elif level == 'skilled':
			best = 'skilled'
	return best

func gold_group():
	return _sex_factor_income() * variables.group_base_mult * (1.0 + variables.group_skill_income_bonus[_group_skill_level()])

func gold_sextoy():
	return _sex_factor_income() * variables.sextoy_base_mult * (1.0 + variables.sextoy_tame_factor_bonus * (parent.get_ref().get_stat('tame_factor') - 1))

func cooking_progress():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('wits')/50.0))

func tailor_progress():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('wits')/66.0 + parent.get_ref().get_stat('physics')/150.0))

func forge_progress():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('wits')/150.0 + parent.get_ref().get_stat('physics')/66.0)) * (1+0.25*ResourceScripts.game_res.upgrades.forgeworkshop)

func alchemy_progress():
	return variables.base_work_increment + (variables.stat_work_increment * (parent.get_ref().get_stat('wits')/50.0))

func building_progress():
	return (1 + parent.get_ref().get_stat('wits')/100.0 + parent.get_ref().get_stat('physics')/50.0) * (1 + 0.25 * ResourceScripts.game_res.upgrades.forgeworkshop)



func settlement_recruiting_easy():
	return (1 + parent.get_ref().get_stat('charm')/33.0)

func settlement_recruiting_hard():
	return (0.2 + parent.get_ref().get_stat('charm')/10.0)


func fighters_task_easy():
	return (1 + parent.get_ref().get_stat('physics')/33.0)

func fighters_task_medium():
	return (0.8 + parent.get_ref().get_stat('physics')/50.0)

func fighters_task_hard():
	return (0.75 + parent.get_ref().get_stat('physics')/66.0)



func mages_task_easy():
	return (1 + parent.get_ref().get_stat('wits')/33.0)

func mages_task_medium():
	return (0.8 + parent.get_ref().get_stat('wits')/50.0)

func mages_task_hard():
	return (0.75 + parent.get_ref().get_stat('wits')/66.0)

func workers_task_easy():
	return (1 + parent.get_ref().get_stat('physics')/33.0)

func workers_task_medium():
	return (0.8 + parent.get_ref().get_stat('wits')/50.0)

func workers_task_hard():
	return (0.75 + parent.get_ref().get_stat('physics')/66.0)

func servants_task_easy():
	return (1 + parent.get_ref().get_stat('charm')/33.0)

func servants_task_medium():
	return (0.8 + parent.get_ref().get_stat('charm')/50.0)

func servants_task_hard():
	return (0.75 + parent.get_ref().get_stat('charm')/66.0)


func farm_milk():
	var tits_size = 0
	match parent.get_ref().get_stat('tits_size'):
		'flat', 'masculine' :
			tits_size = 0
		'small':
			tits_size = 1
		'average','average_high', 'average_narrow','average_wide':
			tits_size = 2
		'big', 'big_high', 'big_narrow':
			tits_size = 3 
		'huge','huge_high','huge_narrow','huge_wide':
			tits_size = 4 
	var res = 1.0 + 0.2 * parent.get_ref().get_stat('physics_factor') + 0.3 * tits_size
	if parent.get_ref().get_stat('race') == 'Taurus':
		res *= 1.25
	return res

func farm_pheromones():
	return (1.0 + 0.4 * parent.get_ref().get_stat('charm_factor'))

func farm_seed():
	var balls_size = 0
	match parent.get_ref().get_stat('balls_size'):
		'small':
			balls_size = 1
		'average':
			balls_size = 2
		'big':
			balls_size = 3
	var res = 1.0 + 0.1 * parent.get_ref().get_stat('physics_factor') + 0.3 * balls_size
	return res

func farm_eggs():
	var ass_size = 0
	match parent.get_ref().get_stat('ass_size'):
		'small':
			ass_size = 1
		'average':
			ass_size = 2
		'big':
			ass_size = 3 
	var res = 1.0 + 0.2 * parent.get_ref().get_stat('physics_factor') + 0.3 * ass_size
	return res

func farm_dust():
	var res = 1.0 + 0.2 * parent.get_ref().get_stat('magic_factor')
	if parent.get_ref().get_stat('race') == 'Fairy':
		res *= 1.25
	return res

func farm_blood():
	var res = 2.0 + 0.1 * parent.get_ref().get_stat('physics_factor')
	if parent.get_ref().get_stat('race') == 'Dragon':
		res *= 0.5
	return res

func farm_lizard_skin():
	return 2

func farm_silk():
	return 2.5

func farm_scales():
	return 3.0

func farm_leatherdragon():
	return 0.3

func farm_light():
	return (1.0 + 0.1 * parent.get_ref().get_stat('tame_factor'))

func farm_dark():
	return (2.0 - 0.1 * parent.get_ref().get_stat('authority_factor'))
