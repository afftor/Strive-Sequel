extends Reference

var data = preload("res://assets/data/achievements_data.gd").new()

func try_add_achimnt(achi_name):
	if input_handler.progress_data['achievements'].has(achi_name):
		return
	input_handler.update_progress_data("achievements", achi_name)
	input_handler.get_spec_node(input_handler.NODE_ACHI_UNLOCK).add_achi(get_achimnt(achi_name))

func try_unlock_bonus(bonus_name):
	if input_handler.progress_data['achi_bonuses'].has(bonus_name):
		return
	input_handler.update_progress_data("achi_bonuses", bonus_name)
	input_handler.get_spec_node(input_handler.NODE_ACHI_UNLOCK).add_bonus(get_bonus(bonus_name))

func try_add_quest_achimnt(quest_name):
	if scenedata.quests[quest_name].has("achievement"):
		try_add_achimnt(scenedata.quests[quest_name].achievement)

func try_add_char_achimnt(unique_name):
	for pregen_char in worlddata.pregen_characters.values():
		if pregen_char.has("unique") and pregen_char.unique == unique_name:
			if pregen_char.has("achievement"):
				try_add_achimnt(pregen_char.achievement)
			if pregen_char.has("achi_bonus"):
				try_unlock_bonus(pregen_char.achi_bonus)
			break

func try_add_prof_achimnt(prof):
	var prof_data = classesdata.professions[prof]
	if prof_data.has('achievement'):
		try_add_achimnt(prof_data.achievement)


func get_achimnt(achi_name):
	#duplicate() here is practically redundant,
	#but I'm keeping it for security reasons
	var res = data.achievements[achi_name].duplicate()
	res.icon = load(res.icon)
	return res
func get_bonus(bonus_name):
	#duplicate() here is practically redundant,
	#but I'm keeping it for security reasons
	var res = data.bonuses[bonus_name].duplicate()
	res.icon = load(res.icon)
	return res

func get_all_points():
	var points = 0
	for achi in input_handler.progress_data['achievements']:
		points += data.achievements[achi].points
	return points

func prepare_bonuses(list):
	for bonus in list:
		if data.bonuses.has(bonus):
			call(data.bonuses[bonus].preparation)
		else:
			push_error("no such bonus in achievements: %s!" % bonus)

func get_unlocked_bonuses():
	var res = {}
	for bonus_name in input_handler.progress_data['achi_bonuses']:
		res[bonus_name] = data.bonuses[bonus_name].duplicate()
		res[bonus_name].icon = load(res[bonus_name].icon)
	return res

func get_locked_bonuses():
	var res = {}
	for bonus_name in data.bonuses:
		if bonus_name in input_handler.progress_data['achi_bonuses']:
			continue
		#only hint for now
		res[bonus_name] = {hint = data.bonuses[bonus_name].hint}
	return res

func get_unlocked_achimnts():
	var res = {}
	for achi_name in input_handler.progress_data['achievements']:
		res[achi_name] = data.achievements[achi_name].duplicate()
		res[achi_name].icon = load(res[achi_name].icon)
	return res

func get_locked_achimnts():
	var res = {}
	for achi_name in data.achievements:
		if achi_name in input_handler.progress_data['achievements']:
			continue
		#only hint for now
		res[achi_name] = {hint = data.achievements[achi_name].hint}
	return res

#bonus preparations
func prep_daisy_start():
	globals.common_effects([{code = 'make_story_character', value = 'Daisy'}])

func prep_kurdan_start():
	globals.common_effects([{code = 'make_story_character', value = 'Kurdan'}])

func prep_aire_start():
	globals.common_effects([{code = 'make_story_character', value = 'Aire'}])

func prep_kuro_start():
	globals.common_effects([{code = 'make_story_character', value = 'Kuro'}])
