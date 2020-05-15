extends Reference

var parent

func hunt_meat():
	return 1 + (1 * (parent.get_stat('physics')/66))

func fishing():
	return 1 + (1 * (parent.get_stat('physics')/150 + parent.get_stat('wits')/100))

func farming_veges():
	return 1 + (1 * (parent.get_stat('physics')/50 + parent.get_stat('wits')/66))

func farming_wheat():
	return 1 + (1 * (parent.get_stat('physics')/40 + parent.get_stat('wits')/66))

func farming_cloth():
	return 1 + (1 * (parent.get_stat('physics')/75 + parent.get_stat('wits')/100))

func hunt_leather():
	return 1 + (1 * (parent.get_stat('physics')/66))

func hunt_leather_hard():
	return 1 + (1 * (parent.get_stat('physics')/33))

func hunt_leather_mythic():
	return 1 + (1 * (parent.get_stat('physics')/25))

func woodcutting_lumber():
	return 1 + (1*(parent.get_stat('physics')/66))

func woodmagiccutting_lumber():
	return 1 + (1*(parent.get_stat('physics')/30))

func woodironcutting_lumber():
	return 1 + (1*(parent.get_stat('physics')/25))

func mining_stone():
	return 1 + (1*(parent.get_stat('physics')/66))
	
func mining_iron():
	return 1 + (1*(parent.get_stat('physics')/33))
	
func mining_mythril():
	return 1 + (1*(parent.get_stat('physics')/30))

func whoring_gold():
	return (1 + parent.get_stat('sexuals')/40 + parent.get_stat('charm')/80)

func cooking_progress():
	return 1 + (1 * (parent.get_stat('wits')/50))

func tailor_progress():
	return 1 + (1 * (parent.get_stat('wits')/66 + parent.get_stat('physics')/150))

func forge_progress():
	return 1 + (1 * (parent.get_stat('wits')/66 + parent.get_stat('physics')/150)) * (1+0.25*ResourceScripts.game_res.upgrades.forgeworkshop)

func alchemy_progress():
	return 1 + (1 * (parent.get_stat('wits')/50))

func building_progress():
	return (1 + parent.get_stat('wits')/100 + parent.get_stat('physics')/50) * (1 + 0.25 * ResourceScripts.game_res.upgrades.forgeworkshop)

