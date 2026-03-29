extends Reference

var data = preload("res://assets/data/achievements_data.gd").new()

func prepare_data():
	data.prepare_data()

func try_add_achimnt(achi_name):
	if input_handler.progress_data['achievements'].has(achi_name):
		return
	input_handler.update_progress_data("achievements", achi_name)
	input_handler.get_spec_node(input_handler.NODE_ACHI_UNLOCK).add_achi(get_achimnt(achi_name))
	
	var achi = data.achievements[achi_name]
	if achi.has("sub_to"):
		var subs = get_subs(achi.sub_to)
		var unlock = true
		for sub in subs:
			if !input_handler.progress_data['achievements'].has(sub):
				unlock = false
				break
		if unlock:
			try_add_achimnt(achi.sub_to)

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
			if pregen_char.has("achievement"):#not in use for now, but it's functional
				try_add_achimnt(pregen_char.achievement)
			if pregen_char.has("achi_bonus"):
				try_unlock_bonus(pregen_char.achi_bonus)
			break

#not in use for now, but it's functional
func try_add_prof_achimnt(prof):
	var prof_data = classesdata.professions[prof]
	if prof_data.has('achievement'):
		try_add_achimnt(prof_data.achievement)

func try_add_wed_achimnt(unique_name):
	for pregen_char in worlddata.pregen_characters.values():
		if pregen_char.has("unique") and pregen_char.unique == unique_name:
			if pregen_char.has("achi_wedding"):
				try_add_achimnt(pregen_char.achi_wedding)

func try_add_upgrade_achimnt(upgrade_id):
	var level = ResourceScripts.game_res.findupgradelevel(upgrade_id)
	var data = upgradedata.upgradelist[upgrade_id]
	if data.has("levels") and data.levels.has(level) and data.levels[level].has("achievement"):
		try_add_achimnt(data.levels[level].achievement)

func try_add_dungeon_achimnt(dungeon_id):
	if DungeonData.dungeons.has(dungeon_id) and DungeonData.dungeons[dungeon_id].has("achievement"):
		try_add_achimnt(DungeonData.dungeons[dungeon_id].achievement)

func try_add_inf_dungeon_achimnt(level_raw):
	var level = int(level_raw + 1)#true levels counts from 0, so we need to make +1
	if DungeonData.infinite_dungeon_achievements.has(level):
		try_add_achimnt(DungeonData.infinite_dungeon_achievements[level])

func try_add_item_achimnt(item_id):
	if Items.itemlist.has(item_id) and Items.itemlist[item_id].has("achievement"):
		try_add_achimnt(Items.itemlist[item_id].achievement)


func get_achimnt(achi_name):
	#duplicate() here is practically redundant,
	#but I'm keeping it for security reasons
	var res = data.achievements[achi_name].duplicate()
	res.icon = load(res.icon)
	res.id = achi_name
	return res

func get_bonus(bonus_name):
	#duplicate() here is practically redundant,
	#but I'm keeping it for security reasons
	var res = data.bonuses[bonus_name].duplicate()
	res.icon = load(res.icon)
	res.id = bonus_name
	return res

func get_group(group_name):
	#duplicate() here is practically redundant,
	#but I'm keeping it for security reasons
	var res = data.achi_groups[group_name].duplicate()
	res.icon = load(res.icon)
	res.id = group_name
#	res.max_points = 0
	res.points = 0
	for achi_name in data.achievements:
		var achi = data.achievements[achi_name]
		if !achi.has("group") or achi.group != group_name:
			continue
#		res.max_points += achi.points
		if achi_name in input_handler.progress_data['achievements']:
			res.points += achi.points
	return res

func get_subs(achi_name):
	var list = []
	for entry_name in data.achievements:
		var entry = data.achievements[entry_name]
		if entry.has("sub_to") and entry.sub_to == achi_name:
			list.append(entry_name)
	return list


func get_all_points():
	var points = 0
	for achi in input_handler.progress_data['achievements']:
		if !data.achievements.has(achi):#for obsolete or temporally removed achievements
			continue
		if data.achievements[achi].has("points"):
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
		if !data.bonuses.has(bonus_name):#for obsolete or temporally removed bonuses
			continue
		res[bonus_name] = get_bonus(bonus_name)
	for bonus_name in data.always_ulocked_bonuses:
		res[bonus_name] = get_bonus(bonus_name)
	return res

func get_locked_bonuses():
	var res = {}
	for bonus_name in data.bonuses:
		if (bonus_name in input_handler.progress_data['achi_bonuses']
				or bonus_name in data.always_ulocked_bonuses):
			continue
		res[bonus_name] = get_bonus(bonus_name)
	return res

func get_unlocked_achimnts():
	var res = {}
	for achi_name in input_handler.progress_data['achievements']:
		if !data.achievements.has(achi_name):#for obsolete or temporally removed achievements
			continue
		res[achi_name] = get_achimnt(achi_name)
	return res

func get_locked_achimnts():
	var res = {}
	for achi_name in data.achievements:
		if achi_name in input_handler.progress_data['achievements']:
			continue
		res[achi_name] = get_achimnt(achi_name)
	return res


#bonus preparations
func prep_daisy_start():
	globals.common_effects([{code = 'make_story_character', value = 'Daisy'}])

func prep_cali_start():
	globals.common_effects([{code = 'make_story_character', value = 'Cali'}])

func prep_aire_start():
	globals.common_effects([{code = 'make_story_character', value = 'Aire'}])

func prep_kuro_start():
	globals.common_effects([{code = 'make_story_character', value = 'Kuro'}])

func prep_ana_start():
	globals.common_effects([{code = 'make_story_character', value = 'Anastasia'}])

func prep_amelia_start():
	globals.common_effects([{code = 'make_story_character', value = 'Amelia'}])

func prep_heleviel_start():
	globals.common_effects([{code = 'make_story_character', value = 'Heleviel'}])

func prep_lira_start():
	globals.common_effects([{code = 'make_story_character', value = 'Lira'}])

func prep_zephyra_start():
	globals.common_effects([{code = 'make_story_character', value = 'Zephyra'}])

func prep_mae_start():
	globals.common_effects([{code = 'make_story_character', value = 'Mae'}])

func prep_jean_start():
	globals.common_effects([{code = 'make_story_character', value = 'Jean'}])

func prep_hara_start():
	globals.common_effects([{code = 'make_story_character', value = 'Hara'}])

func prep_lilia_start():
	globals.common_effects([{code = 'make_story_character', value = 'Lilia'}])

func prep_lilith_start():
	globals.common_effects([{code = 'make_story_character', value = 'Lilith'}])

func prep_rouge_start():
	globals.common_effects([{code = 'make_story_character', value = 'Rouge'}])

func prep_exp_scrolls():
	globals.AddItemToInventory(globals.CreateUsableItem("exp_scroll", 10))

func prep_talent_points():
	ResourceScripts.game_progress.master_points += 2

func prep_craftsman():
	ResourceScripts.game_res.level_up_upgrade("forge", 1)
	ResourceScripts.game_res.level_up_upgrade("tailor", 1)
	ResourceScripts.game_res.level_up_upgrade("alchemy", 1)

func prep_rooms():
	ResourceScripts.game_res.level_up_upgrade("rooms", 1)

