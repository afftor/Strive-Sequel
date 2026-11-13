extends Reference
var data = {
	cali_sidequest_4 = {
		image = null, tags = ['dialogue_scene'], 
		music = "cali_theme",
		reqs = [],
		character = "$cali",
		text = [ {text = "CALI_SIDEQUEST_4", reqs = []} ], 
		options = [ {
			code = 'cali_sidequest_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_sidequest_5 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "$cali",
		text = [ {text = "CALI_SIDEQUEST_5", reqs = []} ], 
		options = [ {
			code = 'cali_sidequest_6', text = "CALI_SIDEQUEST_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sidequest_6', text = "CALI_SIDEQUEST_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},

	cali_sidequest_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "$cali",
		text = [ {text = "CALI_SIDEQUEST_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_SIDEQUEST_6_2", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'complete_quest', value = 'cali_fighters_quest'},
				{code = 'add_timed_event', value = "cali_sidequest_7", args = [{type = 'add_to_date', date = [4,4], hour = 1}]},
			 ]
		},],
	}, 
	
	cali_sidequest_7 = {
		image = null, music = "cali_theme", tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
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
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "$cali",
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
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "$cali",
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
		image = null, music = "cali_theme", tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
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
		character = "$cali",
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_SERVANTS_2", reqs = []} ],
		options = [ {
			code = 'cali_servants_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	}, 
	cali_servants_3 = {
		character = "$cali",
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		text = [ {text = "CALI_SERVANTS_3", reqs = []} ],
		options = [ {
			code = 'cali_servants_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	cali_servants_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		character = "$cali",
		common_effects = [{code = 'money_change', operant = '-', value = 500}],
		text = [ {text = "CALI_SERVANTS_4", reqs = []} ],
		options = [ {
			code = 'cali_servants_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [],
		}, ],
	},
	cali_servants_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
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
		character = "$cali",
		character2 = "$amelia",
		text = [ {text = "CALI_SERVANTS_6", reqs = []} ],
		options = [ {
			code = 'cali_servants_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', }, ],
	},
	cali_servants_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "$cali",
		character2 = "$amelia",
		text = [ {text = "CALI_SERVANTS_7", reqs = []} ],
		options = [ {
			code = 'cali_servants_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', }, ],
	},
	cali_servants_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], reqs = [], 
		character = "$cali",
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
		character = "$cali",
		character2 = "$amelia",
		text = [ {text = "CALI_SERVANTS_9", reqs = []} ],
		common_effects = [
			{code = 'unique_character_changes', value = 'cali', args = [
				{code = 'charm', operant = '+', value = 10},
				{code = 'charm_factor', operant = '+', value = 1},
			]},
		],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'add_timed_event', value = "cali_new_look", args = [{type = 'add_to_date', date = [1,1], hour = 1}]},
				{code = 'add_timed_event', value = "cali_sex_5", args = [{type = 'add_to_date', date = [2,2], hour = 2}]},
				{code = 'add_timed_event', value = "cali_heirloom_1", args = [{type = 'add_to_date', date = [4,4], hour = 2}]},
				{code = 'complete_quest', value = 'cali_servants_quest'},# or advance
			 ]
		},],
	},

	cali_new_look = {
		image = null, music = "cali_theme", tags = ['dialogue_scene', 'master_translate'],
		reqs = [
			{type = 'unique_character_checks', name = 'cali', value = [{code = 'true'}], negative = 'cancel'},
			{type = 'unique_character_at_mansion', name = 'cali', check = true, negative = 'repeat_next_day'},
		],
		character = "$cali",
		unlocked_char_sprites = {cali = ["feminine", "feminine_collar"]},
		common_effects = [{code = 'unique_character_changes', value = 'cali', args = [
			{code = 'body_image', operant = '=', value = "cali_body"}]}],
		text = [ {text = "CALI_NEW_LOOK", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		} ],
	},

	cali_sex_5 = {
		image = null,
		music = "cali_theme",
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "cali_bj_happy",
		save_scene_to_gallery = true,
		character = "$cali",
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'unique_character_checks', name = 'cali', value = [{code = 'true'}], negative = 'cancel'}],
		text = [
			{text = "CALI_SEX_5", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_5_1',
				text = "CALI_SEX_5_OPTION_2",
				type = 'next_dialogue',
				reqs = [{type = 'dialogue_seen', value = 'CALI_SEX_5_1', check = false}],
				dialogue_argument = 2,
			},
			{
				code = 'cali_sex_5_2',
				text = "CALI_SEX_5_OPTION_2",
				type = 'next_dialogue',
				reqs = [{type = 'dialogue_seen', value = 'CALI_SEX_5_1', check = true}],
				dialogue_argument = 2,
			},
		],
	},
	cali_sex_5_1 = {
		character = "$cali",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_5_1", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_sex_5", args = [{type = 'add_to_date', date = [3,3], hour = 2}]},
				{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = -10}]
		} ],
	},
	cali_sex_5_2 = {
		character = "$cali",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_5_2", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = -20}]
		} ],
	},
}
