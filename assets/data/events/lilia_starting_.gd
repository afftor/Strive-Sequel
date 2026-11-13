extends Reference
var data = {
	lilia_starting_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "$lilia",
		text = [{text = "LILIA_STARTING_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "LILIA_STARTING_2_2", reqs = [], previous_dialogue_option = [0, 12]},
		{text = "LILIA_RECRUIT_NO", reqs = [], previous_dialogue_option = 6},
		{text = "LILIA_RECRUIT_NO_RED", reqs = [], previous_dialogue_option = 66},
		{text = "LILIA_STARTING_2_3", reqs = [], previous_dialogue_option = 3},
		{text = "LILIA_SEDUCTION_2_2AND3", reqs = [], previous_dialogue_option = 7},
		{text = "LILIA_SEDUCTION_2_4_2AND3", reqs = [], previous_dialogue_option = 8}],
		options = [ {
			code = 'lilia_sex_scene_0', text = "LILIA_STARTING_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', repeat_next_day = true
		}, {
			code = 'lilia_recruit_1', text = "LILIA_STARTING_2_OPTION_2", reqs = [], dialogue_argument = 8, type = 'next_dialogue', repeat_next_day = true
		}, {
			code = 'lilia_starting_2', text = "LILIA_STARTING_2_OPTION_3", reqs = [], dialogue_argument = 3
		}, {
			code = 'close', text = "LILIA_STARTING_2_OPTION_4", reqs = [], dialogue_argument = 4,
			bonus_effects = [{code = 'update_location'}]
		}, ]
	},

	lilia_sex_scene_0 = {
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'decision', value = 'seduced_lilia', check = true}], character = "$lilia",
			music = "intimate_funny",
			text = [{text = "LILIA_SEX_SCENE_0", reqs = []}],
			options = [ {
				code = 'lilia_sex_scene_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				change_dialogue_type = 2
			} ]
		}, {
			image = null, tags = ['dialogue_scene'],
			reqs = [{type = 'decision', value = 'seduced_lilia', check = false}], character = "$lilia",
			music = "intimate_funny",
			text = [{text = "LILIA_SEDUCTION_1", reqs = []},],
			options = [ {
				code = 'lilia_sex_scene_1', text = "LILIA_SEDUCTION_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 4}]}], dialogue_argument = 10, type = 'next_dialogue',
			}, {
				code = 'lilia_starting_2', text = "LILIA_SEDUCTION_1_OPTION_2", reqs = [], dialogue_argument = 7, type = 'next_dialogue',
			}, {
				code = 'lilia_starting_2', text = "LILIA_SEDUCTION_1_OPTION_3", reqs = [], dialogue_argument = 7, type = 'next_dialogue',
			}, {
				code = 'lilia_seduction_2_4', text = "LILIA_SEDUCTION_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		} ]
	},

	lilia_seduction_2_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "$lilia",
		text = [{text = "LILIA_SEDUCTION_2_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [ {
			code = 'lilia_sex_scene_1', text = "LILIA_SEDUCTION_2_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'lilia_starting_2', text = "LILIA_SEDUCTION_2_4_OPTION_2", reqs = [], dialogue_argument = 8, type = 'next_dialogue',
		}, {
			code = 'lilia_starting_2', text = "LILIA_SEDUCTION_2_4_OPTION_3", reqs = [], dialogue_argument = 8, type = 'next_dialogue',
		}, ]
	},

	lilia_sex_scene_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "lilia_sex",
		save_scene_to_gallery = true,
		reqs = [], character = "$lilia",
		text = [{text = "LILIA_SEX_SCENE_1", reqs = []}],
		common_effects = [{code = 'decision', value = 'seduced_lilia'}],
		options = [ {
			code = 'lilia_sex_scene_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			change_dialogue_type = 2
		} ]
	},
	lilia_sex_scene_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lilia_sex_1_1",
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		text = [{text = "LILIA_SEX_SCENE_1_1", reqs = []}],
		options = [ {
			code = 'lilia_sex_scene_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	lilia_sex_scene_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lilia_sex_1_2",
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		text = [{text = "LILIA_SEX_SCENE_1_2", reqs = []}],
		common_effects = [],
		options = [ {
			code = 'lilia_sex_scene_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	lilia_sex_scene_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LILIA_SEX_SCENE_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_1_3",
		options = [ {
			code = 'lilia_sex_scene_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},

	lilia_sex_scene_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LILIA_SEX_SCENE_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_1_4",
		options = [ {
			code = 'lilia_starting_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 12, type = 'next_dialogue',
			change_dialogue_type = 1
		} ]
	},

	lilia_mansion_1 = {
		image = null, music = "lilia_theme", tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [],
		text = [
			{text = "LILIA_MANSION_1", reqs = [], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'set_availability', value = true},] },
			{text = "", reqs = [{type = 'decision', value = 'potion_tame', check = true}], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'tame_factor', value = 1}]},
			{text = "", reqs = [{type = 'decision', value = 'potion_sex', check = true}], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'sexuals_factor', value = 1}]},
			{text = "", reqs = [{type = 'decision', value = 'potion_wit_magic', check = true}], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'wits_factor', value = 1}, {code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'magic_factor', value = 1}]},
		],
		options = [ {
			code = 'lilia_mansion_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	lilia_mansion_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'	],
		reqs = [], character = "$lilia",
		text = [{text = "LILIA_MANSION_2", reqs = []}],
		options = [ {
			code = 'lilia_mansion_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			change_dialogue_type = 2
		}, ]
	},

	lilia_mansion_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		music = "intimate_funny",
		text = [{text = "LILIA_MANSION_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilia_sex_2",
		custom_background = "lilia_sex_2_1",
		options = [ {
			code = 'lilia_mansion_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	lilia_mansion_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LILIA_MANSION_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_2_2",
		options = [ {
			code = 'lilia_mansion_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			change_dialogue_type = 1
		}, ]
	},

	lilia_mansion_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LILIA_MANSION_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'complete_quest', value = 'sick_lilia_quest'},
				{code = 'update_mansion'},
				{code = 'add_timed_event', value = "lilia_finale_1", args = [{type = 'add_to_date', date = [5, 5], hour = 1}]}
			]
		}, ]
	},
}
