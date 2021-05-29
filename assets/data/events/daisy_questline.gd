var data = {

	help_init_test = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_RECRUITMENT_START", reqs = [], }],
		common_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = 0}],
		options = [ {
			code = 'close', text = "+", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '+'}]
		}, {
			code = 'close', text = "-", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}]
		}, ],
	},

	daisy_recruitment_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_RECRUITMENT_START", reqs = [], }],
		common_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = 0}],
		options = [ {
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '+'}]
		}, {
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ],
	},
	daisy_recruitment_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_RECRUITMENT_REPLY_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_RECRUITMENT_REPLY_2", reqs = [], previous_dialogue_option = 2},
		{text = "DAISY_RECRUITMENT_REPLY_3", reqs = [], previous_dialogue_option = 3}, ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_clothes_1",
		args = [{type = 'add_to_date', date = [10,10], hour = 8}]}]
		}],
	},

	daisy_clothes_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_CLOTHES_START", reqs = [], }],
		options = [ {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_1_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_1_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},

	daisy_clothes_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_CLOTHES_REPLY_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_CLOTHES_REPLY_2_3", reqs = [], previous_dialogue_option = 3}, ],
		options = [ {
			code = 'daisy_clothes_3', text = "DAISY_CLOTHES_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_5', text = "DAISY_CLOTHES_OPTION_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_2_3", reqs = [], dialogue_argument = 3, remove_after_first_use = true
		} ],
	},

	daisy_clothes_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_CLOTHES_REPLY_2_1", reqs = [], }],
		options = [ {
			code = 'daisy_clothes_4', text = "DAISY_CLOTHES_OPTION_2_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage1'}]
		}, {
			code = 'daisy_clothes_4', text = "DAISY_CLOTHES_OPTION_2_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},

	daisy_clothes_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_CLOTHES_REPLY_2_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_CLOTHES_REPLY_2_1_2", reqs = [], previous_dialogue_option = 2} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1
		}],
	},

	daisy_clothes_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_CLOTHES_REPLY_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage1'}]
		}],
	},

	daisy_clothes_sigmund_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'sigmund',
		text = [{text = "DAISY_CLOTHES_SIGMUND_REPLY_1", reqs = []}],
		options = [ {
			code = 'close', text = "DAISY_CLOTHES_SIGMUND_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'daisy_clothes', stage = 'stage2'}, {code = "update_guild"}]
		}],
	},

	daisy_clothes_amelia_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'daisy_clothes_amelia_2_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_2_2', text = "DAISY_CLOTHES_AMELIA_OPTION_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'close', text = "DAISY_CLOTHES_AMELIA_OPTION_2_3", reqs = [], dialogue_argument = 3,
		}],
	},

	daisy_clothes_amelia_2_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_2_1", reqs = []}],
		options = [ {
			code = 'daisy_clothes_amelia_3_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE", reqs = [], dialogue_argument = 3,
		}],
	},

	daisy_clothes_amelia_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_2_2", reqs = []}],
		options = [ {
			code = 'daisy_clothes_amelia_3_2', text = "DAISY_CLOTHES_AMELIA_OPTION_2_2_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE", reqs = [], dialogue_argument = 3,
		}],
	},

	daisy_clothes_amelia_3_1 = {
		reqs = [],
		tags = ['dialogue_scene'], image = null,
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_3_150", reqs = []}],
		common_effects = [{code = 'money_change', operant = '-', value = 150},
		{code = 'decision', value = 'DaisyDressNormal'}], # dress decision normal
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_dress_acquired_normal_1",
			args = [{type = 'add_to_date', date = [1,1], hour = 8}]}, {code = 'progress_quest', value = 'daisy_clothes', stage = 'stage3'}]
		}],
	},
	daisy_clothes_amelia_3_2 = {
		reqs = [],
		tags = ['dialogue_scene'], image = null,
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_3_250", reqs = []}],
		common_effects = [{code = 'money_change', operant = '-', value = 250},
		{code = 'decision', value = 'DaisyDressLewd'}], # dress decision lewd
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_dress_acquired_lewd_1",
			args = [{type = 'add_to_date', date = [1,1], hour = 8}]}, {code = 'progress_quest', value = 'daisy_clothes', stage = 'stage3'}]
		}],
	},

	daisy_dress_acquired_normal_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0", reqs = [], }],
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'body_image', operant = '=', value = "res://assets/images/sprites/daisy_maid_body.png"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/daisy_maid_portrait.png"}]}],
		options = [ {
			code = 'daisy_dress_acquired_normal_2', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '+'}]
		}, {
			code = 'daisy_dress_acquired_normal_3', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_dress_acquired_normal_2', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ],
	},

	daisy_dress_acquired_normal_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		} ],
	},

	daisy_dress_acquired_normal_3 = {
		variations = [ {
			reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 3}],
			tags = ['dialogue_scene'], image = null, character = 'daisy_maid',
			text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_1", reqs = []}],
			options = [ {
				code = 'daisy_dress_acquired_normal_4', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_1", reqs = [], dialogue_argument = 1, change_dialogue_type = 2
			}, {
				code = 'daisy_dress_acquired_normal_4', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_2", reqs = [], dialogue_argument = 2, change_dialogue_type = 2
			}, {
				code = 'daisy_dress_acquired_normal_4', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_3", reqs = [], dialogue_argument = 3, change_dialogue_type = 2,
				bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] #right
			}, ],
		}, {
			reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 3}],
			tags = ['dialogue_scene'], image = null, character = 'daisy_maid',
			text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2", reqs = []}],
			options = [ {
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'},
				{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 8}]}],
			} ],
		} ]
	},

	daisy_dress_acquired_normal_4 = {
		image = null,
		custom_background = "daisy_bj3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1,
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'},
				{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 8}]}],
			}
		],
	},

	daisy_dress_acquired_lewd_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0", reqs = [], }],
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'body_image', operant = '=', value = "res://assets/images/sprites/daisy_maid_body.png"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/daisy_maid_portrait.png"}]}],
		options = [ {
			code = 'daisy_dress_acquired_lewd_2', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_dress_acquired_lewd_3', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},

	daisy_dress_acquired_lewd_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_1", reqs = [], }],
		options = [ {
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'},
				{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 8}]}],
		} ],
	},

	daisy_dress_acquired_lewd_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_maid_nude',
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2", reqs = [], }],
		options = [ {
			code = 'daisy_dress_acquired_lewd_4', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'daisy_dress_acquired_lewd_4', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'daisy_dress_acquired_lewd_4', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', change_dialogue_type = 2,
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] #right
		} ],
	},

	daisy_dress_acquired_lewd_4 = {
		image = null,
		custom_background = "daisy_bj6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_1", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1,
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'},
				{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 8}]}],
			}
		],
	},

	daisy_training_message = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [],
		text = [{text = "DAISY_TRAINING_REPLY_0", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'progress_quest', value = 'daisy_training', stage = 'stage1'}],
		}],
	},

	daisy_training_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_TRAINING_REPLY_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_TRAINING_REPLY_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "DAISY_TRAINING_REPLY_2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "training_complete_serve_1", args = [{type = 'add_to_date', date = [7,7], hour = 8}]}]
		}, {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_4", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_2'}], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "training_complete_sex_1", args = [{type = 'add_to_date', date = [7,7], hour = 8}]}]
		}, {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_5", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_3'}], dialogue_argument = 5, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "daisy_training_intermission", args = [{type = 'add_to_date', date = [3,3], hour = 10}]}, {code = 'add_timed_event', value = "training_complete_fucktoy_1", args = [{type = 'add_to_date', date = [7,7], hour = 8}]}]
		}, {
			code = 'daisy_training_1', text = "DAISY_TRAINING_OPTION_2_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'daisy_training_1', text = "DAISY_TRAINING_OPTION_2_3", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_2'}], dialogue_argument = 3, remove_after_first_use = true
		}, {
			code = 'close', text = "DAISY_TRAINING_OPTION_2_6", reqs = [], dialogue_argument = 6,
		} ],
	},

	daisy_training_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_TRAINING_REPLY_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_TRAINING_REPLY_2_4", reqs = [], previous_dialogue_option = 4},
		{text = "DAISY_TRAINING_REPLY_2_5", reqs = [], previous_dialogue_option = 5}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'progress_quest', value = 'daisy_training', stage = 'stage2'}],
		} ],
	},

	daisy_training_intermission = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [],
		text = [{text = "DAISY_TRAINING_INTERMISSION", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		}],
	},

	training_complete_serve_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_REPLY_0", reqs = []}],
		options = [ {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_OPTION_1_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_OPTION_1_2", reqs = [], dialogue_argument = 2,
		}],
	},

	training_complete_serve_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_SERVE_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "TRAINING_COMPLETE_SERVE_REPLY_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}  ],
	},

	training_complete_sex_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_0", reqs = []}],
		options = [ {
			code = 'training_complete_sex_2', text = "TRAINING_COMPLETE_SEX_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'training_complete_sex_4', text = "TRAINING_COMPLETE_SEX_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}],
	},

	training_complete_sex_2 = {
		image = null,
		custom_background = "daisy_bj3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_1", reqs = []}],
		options = [
			{
				code = 'training_complete_sex_3',
				text = "TRAINING_COMPLETE_SEX_OPTION_1_1_1",
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1,
				type = 'next_dialogue'
			}, {
				code = 'training_complete_sex_3',
				text = "TRAINING_COMPLETE_SEX_OPTION_1_1_2",
				reqs = [],
				dialogue_argument = 2,
				change_dialogue_type = 1,
				type = 'next_dialogue'
			}, {
				code = 'training_complete_sex_3',
				text = "TRAINING_COMPLETE_SEX_OPTION_1_1_3",
				reqs = [],
				dialogue_argument = 3,
				change_dialogue_type = 1,
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] #right
			}
		],
	},

	training_complete_sex_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_2", reqs = [], previous_dialogue_option = 2},
		{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_3", reqs = [], previous_dialogue_option = 3},
		{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_all", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}],
	},

	training_complete_sex_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_2_1", reqs = []}],
		options = [ {
			code = 'training_complete_sex_2', text = "TRAINING_COMPLETE_SEX_OPTION_1_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'training_complete_sex_5', text = "TRAINING_COMPLETE_SEX_OPTION_1_2_2", reqs = [], dialogue_argument = 2,
		}],
	},

	training_complete_sex_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}]
	},

	training_complete_fucktoy_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_0", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_2', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'close', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_2", reqs = [], dialogue_argument = 2, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}, ]
	},

	training_complete_fucktoy_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1", reqs = []}],
		custom_background = "daisy_public1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		options = [ {
			code = 'training_complete_fucktoy_3_1', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'training_complete_fucktoy_3_2', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'training_complete_fucktoy_3_3', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] # right
		}, {
			code = 'training_complete_fucktoy_4', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_4", reqs = [], dialogue_argument = 4, change_dialogue_type = 1
		}]
	},

	training_complete_fucktoy_3_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}, ]
	},

	training_complete_fucktoy_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}, ]
	},

	training_complete_fucktoy_3_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}, ]
	},

	training_complete_fucktoy_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_4", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 8}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}, ]
	},

	daisy_admirer_message = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "DAISY_ADMIRER_MESSAGE", reqs = []}],
		options = [ {
			code = 'daisy_admirer_message_1_1', text = "DAISY_ADMIRER_MESSAGE_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_admirer_message_1_2', text = "DAISY_ADMIRER_MESSAGE_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_admirer_message_1_3', text = "DAISY_ADMIRER_MESSAGE_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_admirer_message_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_1", reqs = []}],
		options = [ {
			code = 'daisy_admirer_message_1_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_admirer_message_1_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_1_1", reqs = []}],
		common_effects = [{code = 'money_change', operant = '+', value = 2500},
		{code = 'remove_slave_by_name', name = "Daisy"}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		} ]
	},

	daisy_admirer_message_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_2", reqs = []}],
		options = [ {
			code = 'daisy_admirer_message_1_2_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_admirer_message_1_2_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_2_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'remove_slave_by_name', name = "Daisy"}]
		} ]
	},

	daisy_admirer_message_1_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_3", reqs = []}],
		options = [ {
			bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_first_event_1",
				args = [{type = 'add_to_date', date = [7,10], hour = 8}]}],
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		} ]
	},

	daisy_admirer_first_event_1 = {
		variations = [
			{
				reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}],
				tags = ['dialogue_scene', 'master_translate'], image = null, character = 'daisy_default',
				text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_0", reqs = []}],
				options = [ {
					code = 'daisy_admirer_first_event_2', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
				}, {
					code = 'daisy_admirer_first_event_2', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
				},
				#{ #blank
				#	code = '', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue' },
					 ],
			},
			{
				reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}],
				tags = ['dialogue_scene', 'master_translate'], image = null, character = 'daisy_default',
				text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_2", reqs = []}],
				options = [ {
					code = 'daisy_admirer_first_event_4', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
				}, {
					code = 'daisy_admirer_first_event_5', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
				} ],
			}
		]
	},

	daisy_admirer_first_event_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2", reqs = []}],
		options = [ {
			code = 'daisy_admirer_first_event_3', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_admirer_first_event_3', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_admirer_first_event_3', text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		} ]
	},

	daisy_admirer_first_event_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_2", reqs = [], previous_dialogue_option = 2},
		{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_lost_message",
		args = [{type = 'add_to_date', date = [6,8], hour = 22}]}], type = 'next_dialogue',
		} ]
	},

	daisy_admirer_first_event_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_2_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_lost_message",
		args = [{type = 'add_to_date', date = [6,8], hour = 22}]}], type = 'next_dialogue',
		} ]
	},

	daisy_admirer_first_event_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_discipline",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_lost_message",
		args = [{type = 'add_to_date', date = [6,8], hour = 22}]}], type = 'next_dialogue',
		}, ]
	},

	daisy_lost_message = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_MESSAGE", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'daisy_lost', stage = 'stage1'}]
		} ]
	},

	daisy_lost_amelia_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_AMELIA_REPLY_0", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_2', text = "DAISY_LOST_AMELIA_OPTION_1_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'daisy_lost_amelia_2', text = "DAISY_LOST_AMELIA_OPTION_1_2", reqs = [], dialogue_argument = 2,
		}, ]
	},

	daisy_lost_amelia_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_AMELIA_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_LOST_AMELIA_REPLY_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'make_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'progress_quest', value = 'daisy_lost', stage = 'stage2'}]
		} ]
	},

	daisy_lost_amelia_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_0_1", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'daisy_admirer_guards1',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_amelia_lose = {
		image = null, tags = [],
		text = [ {text = "", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', bonus_effects = [{code = 'lose_game'}]
			}
		]
	},

	daisy_lost_amelia_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_0_2", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_5', text = "DAISY_LOST_APPROACH_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_amelia_5', text = "DAISY_LOST_APPROACH_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_amelia_5', text = "DAISY_LOST_APPROACH_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_lost_amelia_5 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_1", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_amelia_6 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_2", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_8', text = "DAISY_LOST_APPROACH_OPTION_FIGHT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_amelia_13', text = "DAISY_LOST_APPROACH_OPTION_3_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_amelia_14', text = "DAISY_LOST_APPROACH_OPTION_3_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_lost_amelia_8 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_1", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'daisy_admirer_guards2',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_amelia_9 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_2", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_amelia_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_3", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_11', text = "DAISY_LOST_APPROACH_OPTION_FIGHT_4_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_amelia_11', text = "DAISY_LOST_APPROACH_OPTION_FIGHT_4_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_amelia_12', text = "DAISY_LOST_APPROACH_OPTION_FIGHT_4_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_lost_amelia_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_good", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}]},
		{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_bad", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'}, ]
		} ]
	},

	daisy_lost_amelia_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_4_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'}, ]
		} ]
	},

	# =Very well, let's see what she thinks
	daisy_lost_amelia_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_3_2", reqs = []},
		{text = "DAISY_LOST_APPROACH_REPLY_3_2_good", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}]},
		{text = "DAISY_LOST_APPROACH_REPLY_3_2_bad", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}]}],
		options = [ {
			code = 'daisy_lost_amelia_11', text = "DIALOGUECONTINUE", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'close', text = "DIALOGUECLOSE", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'remove_slave_by_name', name = "Daisy"}],
		},  ]
	},

	daisy_lost_amelia_14 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_3_3_1", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_15', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_amelia_15 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_default",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_3_3_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'remove_slave_by_name', name = "Daisy"}],
		} ]
	},
}
