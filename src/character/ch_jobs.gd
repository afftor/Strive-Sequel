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

 
func gold_waitress():
	return parent.get_ref().get_stat('mod_waitress') * (7 + parent.get_ref().get_stat('charm')/18.0)/6

func gold_hostess():
	return parent.get_ref().get_stat('mod_hostess') * (9 + parent.get_ref().get_stat('wits')/16.0)/6

func gold_dancer():
	return parent.get_ref().get_stat('mod_dancer') * (4 + parent.get_ref().get_stat('charm')/8.0 + parent.get_ref().get_stat('physics')/15.0)/6

func gold_stripper():
	return parent.get_ref().get_stat('mod_strip') *  (6 + parent.get_ref().get_stat('sexuals')/7.0)/6

func gold_petting():
	return (3 + parent.get_ref().get_stat('sex_skills_petting')/20.0)/6

func gold_oral():
	return (3 + parent.get_ref().get_stat('sex_skills_oral')/15.0)/6

func gold_pussy():
	return (5 + parent.get_ref().get_stat('sex_skills_pussy')/14.0)/6

func gold_penetration():
	return (4 + parent.get_ref().get_stat('sex_skills_penetration')/14.0)/6

func gold_anal():
	return (4 + parent.get_ref().get_stat('sex_skills_anal')/9.0)/6

func gold_group():
	return (1 + parent.get_ref().get_stat('sex_skills_anal')/7.0 + parent.get_ref().get_stat('sex_skills_pussy')/7.0) /6

func gold_sextoy():
	return (1 + parent.get_ref().get_stat('sexuals')/4.0) /6

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
