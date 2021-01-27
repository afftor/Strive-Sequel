extends Reference

var parent

func hunt_meat():
	return 1 + (1 * (parent.get_stat('physics')/66.0))

func fishing():
	return 1 + (1 * (parent.get_stat('physics')/150.0 + parent.get_stat('wits')/100.0))

func farming_veges():
	return 1 + (1 * (parent.get_stat('physics')/50.0 + parent.get_stat('wits')/66.0))

func farming_wheat():
	return 1 + (1 * (parent.get_stat('physics')/40.0 + parent.get_stat('wits')/66.0))

func farming_cloth():
	return 1 + (1 * (parent.get_stat('physics')/75.0 + parent.get_stat('wits')/100.0))

func hunt_leather():
	return 1 + (1 * (parent.get_stat('physics')/66.0))

func hunt_leather_hard():
	return 1 + (1 * (parent.get_stat('physics')/33.0))

func hunt_leather_mythic():
	return 1 + (1 * (parent.get_stat('physics')/25.0))

func woodcutting_lumber():
	return 1 + (1*(parent.get_stat('physics')/66.0))

func woodmagiccutting_lumber():
	return 1 + (1*(parent.get_stat('physics')/30.0))

func woodironcutting_lumber():
	return 1 + (1*(parent.get_stat('physics')/25.0))

func mining_stone():
	return 1 + (1*(parent.get_stat('physics')/66.0))
	
func mining_iron():
	return 1 + (1*(parent.get_stat('physics')/33.0))
	
func mining_mithril():
	return 1 + (1*(parent.get_stat('physics')/30.0))

func whoring_gold():
	return (1 + parent.get_stat('sexuals')/40.0 + parent.get_stat('charm')/80.0)

func cooking_progress():
	return 1 + (1 * (parent.get_stat('wits')/50.0))

func tailor_progress():
	return 1 + (1 * (parent.get_stat('wits')/66.0 + parent.get_stat('physics')/150.0))

func forge_progress():
	return 1 + (1 * (parent.get_stat('wits')/150.0 + parent.get_stat('physics')/66.0)) * (1+0.25*ResourceScripts.game_res.upgrades.forgeworkshop)

func alchemy_progress():
	return 1 + (1 * (parent.get_stat('wits')/50.0))

func building_progress():
	return (1 + parent.get_stat('wits')/100.0 + parent.get_stat('physics')/50.0) * (1 + 0.25 * ResourceScripts.game_res.upgrades.forgeworkshop)

