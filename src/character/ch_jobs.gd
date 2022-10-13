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
	return (1 + parent.get_ref().get_stat('sexuals')/60.0 + parent.get_ref().get_stat('charm')/80.0)

#had to divide by 6, probably should remove multiplier at work tick for these

var gold_tasks_data = {
	waitress = {
		code = 'waitress',
		formula = 'gold_waitress',
		text_events = [],
		workstats = ['physics'],
		workmod = 'mod_pros',
		tags = [],
	},
	hostess = {
		code = 'hostess',
		formula = 'gold_hostess',
		text_events = [],
		workstats = ['wits'],
		workmod = 'mod_pros',
		tags = [],
	},
	dancer = {
		code = 'dancer',
		formula = 'gold_dancer',
		text_events = [],
		workstats = ['charm'],
		workmod = 'mod_pros',
		tags = [],
	},
	stripper = {
		code = 'stripper',
		formula = 'gold_stripper',
		text_events = [],
		workstats = ['sexuals'],
		workmod = 'mod_pros',
		tags = [],
	},
	
	
	petting = {
		code = 'petting',
		formula = 'gold_petting',
		text_events = [],
		workstats = ['sex_skills_petting'],
		workmod = 'mod_pros',
		req_training = 'loyalty_sex_basic',
		tags = [],
	},
	oral = {
		code = 'oral',
		formula = 'gold_oral',
		text_events = [],
		workstats = ['sex_skills_oral'],
		workmod = 'mod_pros',
		req_training = 'loyalty_sex_oral',
		tags = [],
	},
	pussy = {
		code = 'petting',
		formula = 'gold_petting',
		text_events = [],
		workstats = ['sex_skills_pussy'],
		workmod = 'mod_pros',
		req_training = 'loyalty_sex_basic',
		tags = ['virginity','impregnation'],
	},
	anal = {
		code = 'anal',
		formula = 'gold_anal',
		text_events = [],
		workstats = ['sex_skills_anal'],
		req_training = 'loyalty_sex_anal',
		workmod = 'mod_pros',
		tags = [],
	},
	penetration = {
		code = 'penetration',
		formula = 'gold_penetration',
		text_events = [],
		workstats = ['sex_skills_penetration'],
		req_training = 'loyalty_sex_basic',
		workmod = 'mod_pros',
		tags = [],
	},
	group = {
		code = 'group',
		formula = 'gold_group',
		text_events = [],
		workstats = ['sex_skills_pussy','sex_skills_anal'],
		workmod = 'mod_pros',
		req_training = 'loyalty_sex_group',
		tags = ['virginity','impregnation'],
	},
	sextoy = {
		code = 'sextoy',
		formula = 'gold_sextoy',
		text_events = [],
		workstats = ['sex_skills_anal','sex_skills_oral','sex_skills_petting'],
		workmod = 'mod_pros',
		req_training = 'loyalty_sex_adv',
		tags = ['virginity','impregnation'],
	},
}
 
func gold_waitress():
	return (5 + parent.get_ref().get_stat('charm')/20.0)/6

func gold_hostess():
	return (7 + parent.get_ref().get_stat('wits')/18.0)/6

func gold_dancer():
	return (2 + parent.get_ref().get_stat('charm')/10.0 + parent.get_ref().get_stat('physics')/25.0)/6

func gold_strip():
	return (4 + parent.get_ref().get_stat('sexuals')/8.0)/6

func gold_petting():
	return (3 + parent.get_ref().get_stat('sex_skills_petting')/25.0)/6

func gold_oral():
	return (3 + parent.get_ref().get_stat('sex_skills_oral')/20.0)/6

func gold_pussy():
	return (5 + parent.get_ref().get_stat('sex_skills_pussy')/17.0)/6

func gold_anal():
	return (4 + parent.get_ref().get_stat('sex_skills_anal')/12.0)/6

func gold_group():
	return (1 + parent.get_ref().get_stat('sex_skills_anal')/10.0 + parent.get_ref().get_stat('sex_skills_pussy')/10.0) /6

func gold_sextoy():
	return (1 + parent.get_ref().get_stat('sexuals')/5.0) /6

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

