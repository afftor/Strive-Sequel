var data = {
	cali_sidequest_4 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SIDEQUEST_4", reqs = []} ], 
		options = [ {
			code = 'cali_sidequest_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_sidequest_5 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SIDEQUEST_5", reqs = []} ], 
		options = [ {
			code = 'cali_sidequest_6', text = "CALI_SIDEQUEST_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sidequest_6', text = "CALI_SIDEQUEST_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},

	cali_sidequest_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_SIDEQUEST_6_2", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
#				{code = 'complete_quest', value = 'cali_sidequest'},
				{code = 'add_timed_event', value = "cali_sidequest_7", args = [{type = 'add_to_date', date = [7,7], hour = 1}]},
			 ]
		},],
	}, 
	
	cali_sidequest_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SIDEQUEST_7", reqs = []} ], 
		options = [ {
			code = 'cali_sidequest_8', text = "CALI_SIDEQUEST_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sidequest_8', text = "CALI_SIDEQUEST_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_sidequest_8', text = "CALI_SIDEQUEST_7_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ],
	},
	cali_sidequest_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_8_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_SIDEQUEST_8_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_SIDEQUEST_8", reqs = []}
			],
		options = [ {
			code = 'cali_sidequest_9', text = "CALI_SIDEQUEST_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sidequest_9', text = "CALI_SIDEQUEST_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},],
	}, 
	cali_sidequest_9 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_9_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_SIDEQUEST_9_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'progress_quest', value = 'cali_servants_quest', stage = 'stage1'}
			 ]
		},],
	}, 
	
	cali_servants_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SERVANTS_1", reqs = []} ], 
		options = [ {
			code = 'cali_servants_2', text = "CALI_SERVANTS_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_servants_2', text = "CALI_SERVANTS_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_servants_2', text = "CALI_SERVANTS_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ],
	},
	cali_servants_2 = {
		character = "cali",
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_SERVANTS_2", reqs = []} ],
		options = [ {
			code = 'cali_servants_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	}, 
	cali_servants_3 = {
		character = "cali",
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		text = [ {text = "CALI_SERVANTS_3", reqs = []} ],
		options = [ {
			code = 'cali_servants_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	cali_servants_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		character = "cali",
		common_effects = [{code = 'money_change', operant = '-', value = 500}],
		text = [ {text = "CALI_SERVANTS_4", reqs = []} ],
		options = [ {
			code = 'cali_servants_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [],
		}, ],
	},
	cali_servants_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SERVANTS_5", reqs = []} ], 
		options = [ {
			code = 'cali_servants_6', text = "CALI_SERVANTS_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_servants_6', text = "CALI_SERVANTS_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_servants_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "cali",
		character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_6", reqs = []} ],
		options = [ {
			code = 'cali_servants_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', }, ],
	},
	cali_servants_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "cali",
		character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_7", reqs = []} ],
		options = [ {
			code = 'cali_servants_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', }, ],
	},
	cali_servants_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], reqs = [], 
		character = "cali",
		text = [ {text = "CALI_SERVANTS_8", reqs = []} ],
		options = [ 
			{
			code = 'cali_servants_9', text = "CALI_SERVANTS_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
			{
			code = 'cali_servants_9', text = "CALI_SERVANTS_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			},
			{
			code = 'cali_servants_9', text = "CALI_SERVANTS_8_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			},
			],
	},
	cali_servants_9 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "cali",
		character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_9", reqs = []} ],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'unique_character_changes', value = 'cali', args = [
					{code = 'charm', operant = '+', value = 10},
					{code = 'charm_factor', operant = '+', value = 1},
				]},
				{code = 'add_timed_event', value = "cali_sex_5", args = [{type = 'add_to_date', date = [2,2], hour = 2}]},
				{code = 'add_timed_event', value = "cali_heirloom_1", args = [{type = 'add_to_date', date = [5,5], hour = 2}]},
				{code = 'complete_quest', value = 'cali_servants_quest'},# or advance
			 ]
		},],
	},
	
	cali_sex_5 = {
		image = null,
		character = "cali",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "CALI_SEX_5", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_6',
				text = "CALI_SEX_5_OPTION_1",
				type = 'next_dialogue',
				reqs = [{type = 'has_money', value = 100}],
				dialogue_argument = 1,
			},
			{
				code = 'cali_sex_5_1',
				text = "CALI_SEX_5_OPTION_2",
				type = 'next_dialogue',
				reqs = [],
				bonus_effects = [], 
				dialogue_argument = 2,
			},
		],
	},
	cali_sex_5_1 = {
		character = "cali",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_SEX_5_1", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_sex_5", args = [{type = 'add_to_date', date = [3,3], hour = 2}]}]
		} ],
	},
	
	cali_sex_6 = {
		image = null,
		character = "cali",
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		common_effects = [{code = 'money_change', operant = '-', value = 100}],
		text = [
			{text = "CALI_SEX_6", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
#				change_dialogue_type = 2
			}
		],
	},
	cali_sex_7 = {
		image = null,
		character = "cali",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "CALI_SEX_7", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_8',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_8 = {
		image = null,
		character = "cali",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "CALI_SEX_8", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_9',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},

	cali_sex_9 = {
		image = null,
		custom_background = "cali_bj_happy_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = 'decision', value = 'cali_sex'}],
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [{text = "CALI_SEX_9", reqs = []}],
		options = [
			{
				code = 'cali_sex_10',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_10 = {
		image = null,
		custom_background = "cali_bj_happy_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "CALI_SEX_10", reqs = []}],
		options = [
			{
				code = 'cali_sex_11',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_11 = {
		image = null,
		custom_background = "cali_bj_happy_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "CALI_SEX_11", reqs = []}],
		options = [
			{
				code = 'cali_sex_12',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_12 = {
		image = null,
		custom_background = "cali_bj_happy_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene',],
		text = [{text = "CALI_SEX_12", reqs = []}],
		options = [
			{
				code = 'cali_sex_13',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [
				{code = 'screen_black_transition', value = 1}
				],
				change_dialogue_type = 1
			}
		],
	},
	cali_sex_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		character = "cali",
		text = [ {text = "CALI_SEX_13", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
			{code = 'screen_black_transition', value = 1}
			],
		} ],
	},


	cali_amelia_1 = {
		image = null,
		character = "cali",
		character2 = 'amelia',
		reqs = [{type = "decision", value = "cali_sex", check = false}],
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_1", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_2 = {
		image = null,
		character = "cali",
		character2 = 'amelia',
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_2", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_3 = {
		image = null,
		character = "cali",
		character2 = 'amelia',
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_3", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_3_1',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
		cali_amelia_3_1 = {
		image = null,
		character = "cali",
		character2 = 'amelia',
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_3_1", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	cali_amelia_4 = {
		image = null,
		character = "cali",
		character2 = 'amelia',
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_4", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_4_1',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},
	cali_amelia_4_1 = {
		image = null,
		custom_background = "amelia_cali_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_4_1", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_5 = {
		image = null,
		custom_background = "amelia_cali_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_5", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_6 = {
		image = null,
		custom_background = "amelia_cali_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_6", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1
			}
		],
	},
	cali_amelia_7 = {
		image = null,
		character = "cali",
		character2 = 'amelia',
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_7", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				bonus_effects = [
				{code = 'screen_black_transition', value = 1}
				],
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
}
