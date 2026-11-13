extends Reference
var data = {
	zephyra_disappearance_ketch_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = "$zephyra",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_1b", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_7_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_7_2', text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_ketch_7_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = "$zephyra",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_7_1", reqs = []}
		],
		options = [ {
			code = 'zephyra_disappearance_sex_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2,
			bonus_effects = [{code = "affect_unique_character", name = "zephyra", type = "stat", stat = "affection", value = 10}],
		}, {
			code = 'zephyra_disappearance_ketch_9_2', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "zephyra", type = "stat", stat = "affection", value = -10}],
		}, ]
	},
	
	zephyra_disappearance_sex_1 = { # comply
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		music = "intimate",
		custom_background = "zephyra_back_1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "zephyra_disappearance_sex",
		common_effects = [{code = 'unique_character_changes', value = 'zephyra', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_1", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		custom_background = "zephyra_back_1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_2", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		custom_background = "zephyra_back_2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_3", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_4', text = "ZEPHYRA_DISAPPEARANCE_SEX_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, { 
			code = 'zephyra_disappearance_sex_4', text = "ZEPHYRA_DISAPPEARANCE_SEX_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, { 
			code = 'zephyra_disappearance_sex_4', text = "ZEPHYRA_DISAPPEARANCE_SEX_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = "decision", value = "ZephTailGrabbed"},
				{code = 'add_timed_event', value = "kuro_zeph_tailjob", args = [{type = 'add_to_date', date = [3,4], hour = 1}]}]
		}, ]
	},
	
	zephyra_disappearance_sex_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		custom_background = "zephyra_back_3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_SEX_4_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_DISAPPEARANCE_SEX_4_3", reqs = [], previous_dialogue_option = 3},
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		custom_background = "zephyra_back_4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_5", reqs = []}
		], 
		options = [ { 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'zephyra_disappearance_quest'},
			{code = 'affect_unique_character', name = 'zephyra', type = 'set_availability', value = true}, {code = "update_city"}] 
		}, ]
	},
	
	zephyra_disappearance_ketch_7_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = "$zephyra",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_7_2", reqs = []}
		],
		options = [ { # flashback
			code = 'zephyra_disappearance_ketch_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_ketch_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [], character = "$zephyra",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_8", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_sex_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2,
		}, {
			code = 'zephyra_disappearance_ketch_9_2', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [], character = 'demon_female', character2 = "ketch",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_10", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_11", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_12', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_12", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2,
		} ]
	},
	
	zephyra_disappearance_guards_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		music = "intimate_dark",
		custom_background = "zephyra_facefuck_1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "zephyra_disappearance_guards",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_1", reqs = []},
		],
		common_effects = [{code = 'unique_character_changes', value = 'zephyra', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		options = [ {
			code = 'zephyra_disappearance_guards_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		custom_background = "zephyra_facefuck_2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_2", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		custom_background = "zephyra_facefuck_3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_3", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		custom_background = "zephyra_facefuck_4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_4", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		custom_background = "zephyra_facefuck_4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_5", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_13', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1,
		} ]
	},
	
	zephyra_disappearance_ketch_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_13", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},]
	},
}
