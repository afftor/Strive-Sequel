extends Reference
var data = {
	amelia_silk_1 = {
		image = null, music = "amelia_theme", tags = ['dialogue_scene', 'master_translate'], reqs = [], character = '$amelia',
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "amelia_titjob",
		save_scene_to_gallery = true,
		text = [{text = "AMELIA_SILK_REPLY_START", reqs = [], }],
		common_effects = [{code = 'material_change', operant = '-', material = 'clothsilk', value = 50}],
		options = [ {
			code = 'amelia_silk_2', text = "AMELIA_SILK_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_silk_1_finish', text = "AMELIA_SILK_OPTION_1_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	amelia_silk_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_1", reqs = [], }],
		options = [ {
			code = 'amelia_silk_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_silk_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_2", reqs = [], }],
		options = [ {
			code = 'amelia_silk_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_silk_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_3", reqs = [], }],
		options = [ {
			code = 'amelia_silk_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	amelia_silk_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_4", reqs = [], }],
		options = [ {
			code = 'amelia_silk_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},	amelia_silk_6 = {
		custom_background = "amelia_titjob1",
		music = "intimate_dark", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_SILK_REPLY_1_1_5", reqs = [], }],
		options = [ {
			code = 'amelia_silk_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},	amelia_silk_7 = {
		custom_background = "amelia_titjob2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "AMELIA_SILK_REPLY_1_1_6", reqs = [], }],
		options = [ {
			code = 'amelia_silk_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},	amelia_silk_8 = {
		custom_background = "amelia_titjob3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "AMELIA_SILK_REPLY_1_1_7", reqs = [], }],
		options = [ {
			code = 'amelia_silk_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ],
	},	amelia_silk_9 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_8", reqs = [], }],
		options = [ {
			code = 'amelia_silk_10', text = "AMELIA_SILK_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_silk_10', text = "AMELIA_SILK_OPTION_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'amelia_silk_10', text = "AMELIA_SILK_OPTION_2_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ],
	},
	
	amelia_silk_10 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_SILK_REPLY_2_1AND2", reqs = [], previous_dialogue_option = [1, 2]},
		{text = "AMELIA_SILK_REPLY_2_3", reqs = [], previous_dialogue_option = 3}],
		common_effects = [{code = 'money_change', operant = '+', value = 2000}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, 
			bonus_effects = [{code = 'complete_quest', value = 'amelia_silk_quest'}, 
			{code = 'add_item', item = 'lacy_underwear', number = 2}], type = 'next_dialogue'
		}, ],
	},
	
	amelia_herbs_end_1 = {
		variations = [ {
				reqs = [{type = 'has_material', material = 'herbs', operant = 'gte', value = 1}], music = "amelia_theme", 
				image = null, tags = ['dialogue_scene'], character = "$amelia",
				text = [{text = "AMELIA_HERBS_END_REPLY_START", reqs = []}],
				common_effects = [{code = 'material_change', operant = '-', material = 'herbs', value = 1},
				{code = 'money_change', operant = '+', value = 500}],
				options = [ {
					code = 'amelia_herbs_end_good_no_sex',
					text = "AMELIA_HERBS_END_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
					bonus_effects = []
					}, {
					code = 'amelia_herbs_end_1_2_1',
					text = "AMELIA_HERBS_END_OPTION_1_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
					},],
			}, {
				reqs = [{type = 'has_material', material = 'herbs', operant = 'lt', value = 1}],
				image = null, music = "amelia_theme", tags = ['dialogue_scene'], character = "$amelia",
				text = [{text = "AMELIA_HERBS_END_REPLY_START_FAIL", reqs = []}],
				options = [ {
					code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
					bonus_effects = [{code = 'complete_quest', value = 'amelia_herbs_quest'}]
				} ],
			},
		]
	},
	
	amelia_herbs_end_1_2_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_HERBS_END_REPLY_1_2_1", reqs = []}],
		options = [ {
			code = 'amelia_herbs_end_1_2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_herbs_end_1_2_2 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], #character = null,
		text = [{text = "AMELIA_HERBS_END_REPLY_1_2_2", reqs = []}],
		options = [ {
			code = 'amelia_bondage_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_herbs_end_1_2_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_HERBS_END_REPLY_1_2_3", reqs = []}],
		options = [ {
			code = 'amelia_herbs_end_1_2_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_herbs_end_1_2_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "AMELIA_HERBS_END_REPLY_1_2_4", reqs = []}],
		options = [ {
			code = 'amelia_herbs_end_1_2_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_herbs_end_1_2_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_HERBS_END_REPLY_1_2_5", reqs = []}],
		options = [ {
			code = 'amelia_bondage_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_bondage_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],  character = '$amelia',
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "amelia_bondage",
		save_scene_to_gallery = true,
		text = [{text = "AMELIA_BONDAGE_1", reqs = []}],
		options = [ {
			code = 'amelia_bondage_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_bondage_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],  character = '$amelia',
		text = [{text = "AMELIA_BONDAGE_2", reqs = []}],
		options = [ {
			code = 'amelia_bondage_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_bondage_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],  character = '$amelia',
		text = [{text = "AMELIA_BONDAGE_3", reqs = []}],
		options = [ {
			code = 'amelia_bondage_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},
	
	amelia_bondage_4 = { 
		custom_background = "amelia_bondage1",
		music = "intimate_dark", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_BONDAGE_4", reqs = []}],
		options = [ {
			code = 'amelia_bondage_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	amelia_bondage_5 = { 
		custom_background = "amelia_bondage1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_BONDAGE_5", reqs = []}],
		options = [ {
			code = 'amelia_bondage_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	amelia_bondage_6 = { 
		custom_background = "amelia_bondage2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_BONDAGE_6", reqs = []}],
		options = [ {
			code = 'amelia_bondage_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	amelia_bondage_7 = { 
		custom_background = "amelia_bondage3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_BONDAGE_7", reqs = []}],
		options = [ {
			code = 'amelia_bondage_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	amelia_bondage_8 = { 
		custom_background = "amelia_bondage3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_BONDAGE_8", reqs = []}],
		options = [ {
			code = 'amelia_bondage_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1, close_speed = 1.0
		}, ],
	},
	
	amelia_bondage_9 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], reqs = [],  character = '$amelia',
		text = [{text = "AMELIA_BONDAGE_9", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'amelia_herbs_quest'},
			{code = 'add_timed_event', value = "amelia_intro", args = [{type = 'add_to_date', date = [6,8], hour = 1}]}]
		}, ],
	},
}
