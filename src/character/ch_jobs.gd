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


func whoring_gold():
	return (1 + parent.get_ref().get_stat('charm')/80.0)

 
func gold_waitress():
	return parent.get_ref().get_stat('mod_waitress') * (1.15 + parent.get_ref().get_stat('charm')/90.0)

func gold_hostess():
	return parent.get_ref().get_stat('mod_hostess') * (1.0 + parent.get_ref().get_stat('wits')/60.0)

func gold_dancer():
	return parent.get_ref().get_stat('mod_dancer') * (0.8 + parent.get_ref().get_stat('charm')/75.0 + parent.get_ref().get_stat('physics')/110.0)

func gold_stripper():
	return parent.get_ref().get_stat('mod_strip') * (1.3 * _sex_training_mult('petting'))

func _sex_training_mult(skill_name):
	var level = parent.get_ref().get_stat('sex_training_' + skill_name)
	if level == 'mastered': return 1.8
	elif level == 'skilled': return 1.35
	return 1.0

func gold_petting():
	return 0.99 * _sex_training_mult('petting')

func gold_oral():
	return 1.03 * _sex_training_mult('oral')

func gold_pussy():
	return 1.17 * _sex_training_mult('pussy')

func gold_penetration():
	return 1.40 * _sex_training_mult('penetration')

func gold_anal():
	return 1.24 * _sex_training_mult('anal')

func gold_group():
	var mult = (_sex_training_mult('anal') + _sex_training_mult('pussy')) / 2.0
	return 2.69 * mult

func gold_sextoy():
	var bonus = 0.0
	for skill in ['petting', 'oral', 'pussy', 'anal', 'penetration', 'tail']:
		var level = parent.get_ref().get_stat('sex_training_' + skill)
		if level == 'mastered': bonus += 0.35
		elif level == 'skilled': bonus += 0.15
	return 2.5 + bonus

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
