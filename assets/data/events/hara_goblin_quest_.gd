extends Reference
var data = {
	 goblin_quest_15 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "white_stag",
		text = [{text = "GOBLIN_QUEST_15_1", reqs = [], previous_dialogue_option = 1},
		{text = "GOBLIN_QUEST_15_2", reqs = [], previous_dialogue_option = 2},
		{text = "GOBLIN_QUEST_15_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 1, bonus_effects = [{code = 'complete_quest', value = 'goblin_quest'}, {code = 'remove_quest_location', value = 'quest_goblin_location'}]
		}, {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 2, bonus_effects = [{code = "make_loot", pool = [["holy_spear_reward",1]]},{code = "open_loot"}, {code = 'complete_quest', value = 'goblin_quest'}, {code = 'remove_quest_location', value = 'quest_goblin_location'}]
		}, {
			code = 'goblin_quest_sex_1', text = "GOBLIN_QUEST_15_3_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 3, change_dialogue_type = 2
		}, {
			code = 'goblin_quest_14', text = "GOBLIN_QUEST_15_3_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue', previous_dialogue_option = 3
		}, ]
	},

	goblin_quest_sex_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		music = "intimate_dark",
		reqs = [],
		text = [{text = "GOBLIN_QUEST_SEX_1", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "stag_sex_1",
		options = [ {
			code = 'goblin_quest_sex_2', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1,
		}, ]
	},

	goblin_quest_sex_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "GOBLIN_QUEST_SEX_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "stag_sex_2",
		options = [ {
			code = 'goblin_quest_sex_3', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1,
		}, ]
	},

	goblin_quest_sex_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "GOBLIN_QUEST_SEX_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "stag_sex_3",
		common_effects = [{code = 'unique_character_changes', value = 'master', args = [
			{code = 'add_trait', trait = 'stag_buff'}
		]}],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 1,
			bonus_effects = [{code = 'complete_quest', value = 'goblin_quest'}, {code = 'remove_quest_location', value = 'quest_goblin_location'}]
		}, ]
	},
}
