var data = {
	 goblin_quest_0 = {
		image = 'letter', tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'dialogue_seen', check = false, value = 'GOBLIN_QUEST_0'}], 
		text = [{text = "GOBLIN_QUEST_0", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage0'}]
		}, ]
	},
	
	 goblin_quest_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'dialogue_seen', check = false, value = 'GOBLIN_QUEST_1'}], character = "savra", 
		text = [{text = "GOBLIN_QUEST_1", reqs = []}],
		options = [ {
			code = 'goblin_quest_2', text = "GOBLIN_QUEST_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = []
		}, { 
			code = 'goblin_quest_2', text = "GOBLIN_QUEST_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = []
		}, ]
	},
	
	 goblin_quest_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra", 
		text = [{text = "GOBLIN_QUEST_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "GOBLIN_QUEST_2_2", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage1'},
			{code = 'update_city'},
			{code = 'make_quest_location', value = 'quest_goblin_location'}] 
		}, ]
	},
	
	 goblin_quest_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_3", reqs = []}],
		options = [ {
			code = 'goblin_quest_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	goblin_quest_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "white_stag", 
		text = [{text = "GOBLIN_QUEST_4", reqs = []}],
		options = [ {
			code = 'goblin_quest_5', text = "GOBLIN_QUEST_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, { 
			code = 'goblin_quest_5', text = "GOBLIN_QUEST_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},{
			code = 'goblin_quest_5', text = "GOBLIN_QUEST_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	 goblin_quest_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "white_stag", 
		text = [{text = "GOBLIN_QUEST_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "GOBLIN_QUEST_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "GOBLIN_QUEST_5_3", reqs = [], previous_dialogue_option = 3},
			{text = "GOBLIN_QUEST_6_1", reqs = [], previous_dialogue_option = 4},],
		options = [ {
			code = 'goblin_quest_5', text = "GOBLIN_QUEST_5_OPTION_1", reqs = [], dialogue_argument = 4, 
		}, { 
			code = 'goblin_quest_6', text = "GOBLIN_QUEST_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},{
			code = 'goblin_quest_6', text = "GOBLIN_QUEST_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		},  ]
	},
	
	goblin_quest_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "white_stag", 
		text = [{text = "GOBLIN_QUEST_6_2", reqs = [], previous_dialogue_option = 2},
			{text = "GOBLIN_QUEST_6_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 2,
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage2'}, {code = 'update_location'}]
		}, {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 3,
			bonus_effects = [{code = 'update_location'}]
		}, ]
	},
	
	goblin_quest_track_1 = {
		image = "goblins_traps", tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_TRACK_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage3'}, {code = 'update_location'}] 
		}, ]
	},
	
	goblin_quest_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "sigmund", 
		text = [{text = "GOBLIN_QUEST_7", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage4'}, {code = 'update_guild'}] 
		}, ]
	},
	
	goblin_quest_8 = {
		image = "mae_camp", tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_8", reqs = []}],
		options = [ {
			code = 'goblin_quest_9', text = "GOBLIN_QUEST_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, { 
			code = 'goblin_quest_9', text = "GOBLIN_QUEST_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	goblin_quest_9 = {
		image = "mae_camp", tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_9_1", reqs = [], previous_dialogue_option = 1},
		{text = "GOBLIN_QUEST_9_2_GOOD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'gte', value = 70}]}], previous_dialogue_option = 2},
		{text = "GOBLIN_QUEST_9_2_BAD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'lt', value = 70}]}], previous_dialogue_option = 2},],
		options = [ { # fight
			code = 'quest_fight', args = 'goblin_quest', text = "DIALOGUEFIGHTOPTION", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'lt', value = 70}]}], dialogue_argument = 1, previous_dialogue_option = 2, type = 'next_dialogue',
		}, { # fight
			code = 'quest_fight', args = 'goblin_quest', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 1
		}, { 
			code = 'goblin_quest_10', text = "DIALOGUECONTINUE", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'gte', value = 70}]}], dialogue_argument = 1, previous_dialogue_option = 2, type = 'next_dialogue',
		}, ]
	},
	
	goblin_quest_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_10", reqs = []}],
		options = [ {
			code = 'goblin_quest_11', text = "GOBLIN_QUEST_10_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, { 
			code = 'goblin_quest_11', text = "GOBLIN_QUEST_10_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, { 
			code = 'goblin_quest_11', text = "GOBLIN_QUEST_10_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	 goblin_quest_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_11_1", reqs = [], previous_dialogue_option = 1},
			{text = "GOBLIN_QUEST_11_2", reqs = [], previous_dialogue_option = 2},
			{text = "GOBLIN_QUEST_11_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'goblin_quest_12', text = "GOBLIN_QUEST_11_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, { 
			code = 'goblin_quest_12', text = "GOBLIN_QUEST_11_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},{
			code = 'goblin_quest_12', text = "GOBLIN_QUEST_11_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		},  ]
	},
	
	 goblin_quest_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_12_1", reqs = [], previous_dialogue_option = 1},
			{text = "GOBLIN_QUEST_12_2", reqs = [], previous_dialogue_option = 2},
			{text = "GOBLIN_QUEST_12_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, previous_dialogue_option = [1,2], type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage5'}, {code = 'update_location'}]
		}, { 
			code = 'close', text = "GOBLIN_QUEST_12_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 3, 
			bonus_effects = [{code = 'progress_quest', value = 'goblin_quest', stage = 'stage5'}, {code = 'update_location'}]
		}, { 
			code = 'goblin_quest_13', text = "GOBLIN_QUEST_12_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 3
		}, ]
	},
	
	 goblin_quest_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "GOBLIN_QUEST_13", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'money_change', operant = '+', value = 1000}, {code = 'progress_quest', value = 'goblin_quest', stage = 'stage5'}, {code = 'update_location'}], type = 'next_dialogue',
		}, ]
	},
	
	goblin_quest_14 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "white_stag", 
		text = [{text = "GOBLIN_QUEST_14", reqs = [], previous_dialogue_option = 0},
		{text = "", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'goblin_quest_15', text = "GOBLIN_QUEST_14_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = []
		}, { 
			code = 'goblin_quest_15', text = "GOBLIN_QUEST_14_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			
		}, {
			code = 'goblin_quest_15', text = "GOBLIN_QUEST_14_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ]
	},
	
	 goblin_quest_15 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "white_stag", 
		text = [{text = "GOBLIN_QUEST_15_1", reqs = [], previous_dialogue_option = 1},
		{text = "GOBLIN_QUEST_15_2", reqs = [], previous_dialogue_option = 2},
		{text = "GOBLIN_QUEST_15_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 1, bonus_effects = [{code = 'money_change', operant = '+', value = 5000}, {code = 'complete_quest', value = 'goblin_quest'}, {code = 'remove_quest_location', value = 'quest_goblin_location'}]
		}, {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 2, bonus_effects = [{code = 'add_item', item = 'holy_spear', number = 1}, {code = 'complete_quest', value = 'goblin_quest'}, {code = 'remove_quest_location', value = 'quest_goblin_location'}]
		}, { 
			code = 'goblin_quest_sex_1', text = "GOBLIN_QUEST_15_3_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 3, change_dialogue_type = 2 
		}, { 
			code = 'goblin_quest_14', text = "GOBLIN_QUEST_15_3_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue', previous_dialogue_option = 3
		}, ]
	},
	
	goblin_quest_hara_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "hara", 
		text = [{text = "GOBLIN_QUEST_HARA_1", reqs = []}],
		options = [ {
			code = 'goblin_quest_hara_2', text = "GOBLIN_QUEST_HARA_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, { 
			code = 'goblin_quest_hara_2', text = "GOBLIN_QUEST_HARA_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	goblin_quest_hara_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "hara", 
		text = [{text = "GOBLIN_QUEST_HARA_2_1", reqs = [], bonus_effects = [{code = 'make_story_character', value = 'Hara', recruit_from_location = true},
		{code = 'unique_character_changes', value = 'hara', args = [
			{code = 'tag', operant = 'add', value = 'no_sex'}]}], previous_dialogue_option = 1}, 
			{text = "GOBLIN_QUEST_HARA_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'update_city'}] 
		}, ]
	},
	
	goblin_quest_sex_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
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
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 1,
			bonus_effects = [{code = 'complete_quest', value = 'goblin_quest'}, {code = 'remove_quest_location', value = 'quest_goblin_location'},
				{
					code = 'unique_character_changes',
					value = 'master',
					args = [
						{code = 'sexuals_factor', operant = '+', value = 1},
					]
				},]
		}, ]
	},
	
}
