var data = {
	gryphon_aire_start = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_START", reqs = []}],
		options = [ {
			code = 'gryphon_aire_1', text = "GRYPHON_AIRE_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_1', text = "GRYPHON_AIRE_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	gryphon_aire_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "GRYPHON_AIRE_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'gryphon_aire_2', text = "GRYPHON_AIRE_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_2', text = "GRYPHON_AIRE_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	gryphon_aire_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_2", reqs = []}],
		options = [ {
			code = 'gryphon_aire_3', text = "GRYPHON_AIRE_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_3', text = "GRYPHON_AIRE_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_3', text = "GRYPHON_AIRE_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', master_translate = true
		}, ]
	},
	
	gryphon_aire_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "GRYPHON_AIRE_3_2", reqs = [], previous_dialogue_option = 2},
		{text = "GRYPHON_AIRE_3_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'gryphon_aire_4', text = "GRYPHON_AIRE_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_4', text = "GRYPHON_AIRE_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', master_translate = true
		} ]
	},
	
	gryphon_aire_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "GRYPHON_AIRE_4_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'gryphon_aire_5', text = "GRYPHON_AIRE_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_5', text = "GRYPHON_AIRE_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_5', text = "GRYPHON_AIRE_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}  ]
	},
	
	gryphon_aire_5 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_5", reqs = []}],
		options = [ {
			code = 'gryphon_aire_6', text = "GRYPHON_AIRE_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_aire_6', text = "GRYPHON_AIRE_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ]
	},
	
	gryphon_aire_6 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "aire",
		text = [{text = "GRYPHON_AIRE_6", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'gryphon_quest', stage = 'stage1'}]
		} ]
	},
	
	gryphon_workers_start = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "sigmund",
		text = [{text = "GRYPHON_WORKERS_START", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'gryphon_quest', stage = 'stage2'}]
		} ]
	},
	
	gryphon_hunter_start = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = "GRYPHON_HUNTER_START", reqs = []}],
		options = [ {
			code = 'gryphon_hunter_1', text = "GRYPHON_HUNTER_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_hunter_1', text = "GRYPHON_HUNTER_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'gryphon_hunter_1', text = "GRYPHON_HUNTER_START_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ]
	},
	
	gryphon_hunter_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_HUNTER_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "GRYPHON_HUNTER_1_2", reqs = [], previous_dialogue_option = 2},
		{text = "GRYPHON_HUNTER_1_3", reqs = [], previous_dialogue_option = 3}],
		common_effects = [{code = "update_city"}, {code = 'make_quest_location', value = 'quest_gryphon_forest_location'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'gryphon_quest', stage = 'stage3'}]
		} ]
	},
	
	gryphon_forest_start = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_FOREST_START", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	gryphon_forest_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'aire',
		text = [{text = "GRYPHON_FOREST_1", reqs = []}],
#		common_effects = [{code = 'make_quest_location', value = 'quest_gryphon_cave_location'}],
		options = [ {
			code = 'gryphon_forest_2', text = "GRYPHON_FOREST_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'gryphon_forest_2', text = "GRYPHON_FOREST_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},]
	},
	
	gryphon_forest_2 = {
		image = 'tracking', tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_FOREST_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "GRYPHON_FOREST_1_2", reqs = [], previous_dialogue_option = 2}],
		common_effects = [],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'gryphon_quest', stage = 'stage4'}, {code = 'remove_active_location'}, {code = 'make_quest_location', value = 'quest_gryphon_cave_location'}]
		}, ]
	},
	
	gryphon_cave_start = {
		image = 'gryphon', tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_CAVE_START", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'gryphon',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},
	
	gryphon_cave_1 = {
		image = 'gryphon', tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_CAVE_1", reqs = []}],
		options = [ {
			code = 'gryphon_cave_2', text = "GRYPHON_CAVE_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_cave_bad', text = "GRYPHON_CAVE_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ]
	},
	
	gryphon_cave_2 = {
		image = 'aire_wound', tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_CAVE_2", reqs = []}],
		options = [ {
			code = 'gryphon_cave_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	gryphon_cave_3 = {
		image = 'aire_wound', tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_CAVE_3", reqs = []}],
		options = [ {
			code = 'gryphon_cave_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	gryphon_cave_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'aire',
		text = [{text = "GRYPHON_CAVE_4", reqs = []}],
		options = [ {
			code = 'gryphon_cave_5', text = "GRYPHON_CAVE_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'gryphon_cave_5', text = "GRYPHON_CAVE_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'gryphon_cave_5', text = "GRYPHON_CAVE_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ]
	},
	
	gryphon_cave_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'aire',
		text = [{text = "GRYPHON_CAVE_5", reqs = []}],
		options = [ {
			code = 'close', text = "GRYPHON_CAVE_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'remove_active_location'}, {code = 'complete_quest', value = 'gryphon_quest'}]
		}, {
			code = 'close', text = "GRYPHON_CAVE_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = 'remove_active_location'}, {code = 'complete_quest', value = 'gryphon_quest'}]
		} ]
	},
	
	gryphon_cave_bad = {
		image = 'aire_death', tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "GRYPHON_CAVE_BAD", reqs = []}],
		common_effects = [{code = 'unique_character_changes', value = 'aire', args = [{code = 'remove_character'}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'remove_active_location'}, {code = 'complete_quest', value = 'gryphon_quest'}]
		}, ]
	},
	
	aire_gryphon_sex_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'aire',
		text = [
			{text = "GRYPHON_AIRE_SEX_START", reqs = []},
		], 
		options = [
			{code = 'aire_gryphon_sex_1', text = 'GRYPHON_AIRE_SEX_START_OPTION_1',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
			{code = 'aire_dialogue_start', text = "GRYPHON_AIRE_SEX_START_OPTION_2", reqs = [], dialogue_argument = 3}
		],
	},
	
	aire_gryphon_sex_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'aire',
		text = [
			{text = "GRYPHON_AIRE_SEX_1", reqs = []},
		], 
		options = [
			{code = 'aire_gryphon_sex_2', text = 'GRYPHON_AIRE_SEX_1_OPTION_1',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
			{code = 'aire_dialogue_start', text = "GRYPHON_AIRE_SEX_1_OPTION_2", reqs = [], dialogue_argument = 3}
		],
	},
	
	aire_gryphon_sex_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'aire',
		text = [
			{text = "GRYPHON_AIRE_SEX_2", reqs = []},
		], 
		common_effects = [{code = 'decision', value = 'AnaAireThreesome'}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE",reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character2 = 'aire', character = 'anastasia',
		text = [
			{text = "GRYPHON_ANA_SEX_START", reqs = []},
		], 
		options = [
			{code = 'ana_gryphon_sex_1', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character2 = 'aire', character = 'anastasia',
		text = [
			{text = "GRYPHON_ANA_SEX_1", reqs = []},
		], 
		options = [
			{code = 'ana_gryphon_sex_2', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character2 = 'aire', character = 'anastasia',
		text = [
			{text = "GRYPHON_ANA_SEX_2", reqs = []},
		], 
		options = [
			{code = 'ana_gryphon_sex_3', text = 'GRYPHON_ANA_SEX_2_OPTION_1',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}, 
			{code = 'ana_gryphon_sex_3', text = 'GRYPHON_ANA_SEX_2_OPTION_2',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}, 
			{code = 'ana_gryphon_sex_3', text = 'GRYPHON_ANA_SEX_2_OPTION_3',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}, 
		],
	},
	
	ana_gryphon_sex_3 = {
		image = null,
		custom_background = "aire_ana1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_3", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_4', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_4 = {
		image = null,
		custom_background = "aire_ana2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_4", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_5', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_5 = {
		image = null,
		custom_background = "aire_ana2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_5", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_6', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_6 = {
		image = null,
		custom_background = "aire_ana3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_6", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_7', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_7 = {
		image = null,
		custom_background = "aire_ana4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_7", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_8', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_8 = {
		image = null,
		custom_background = "aire_ana4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_8", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_9', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_9 = {
		image = null,
		custom_background = "aire_ana5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_9", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_10', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_10 = {
		image = null,
		custom_background = "aire_ana6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_10", reqs = []}],
		options = [
			{code = 'close', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1}, 
		],
	},
}
