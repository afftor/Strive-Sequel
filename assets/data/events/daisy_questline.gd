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
#		common_effects = [{code = 'add_timed_event', value = "daisy_clothes_1",
#		args = [{type = 'add_to_date', date = [1,1], hour = 8}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'add_timed_event', value = "daisy_clothes_1",
				args = [{type = 'add_to_date', date = [4,4], hour = 2}]}]
		}],
	},

	daisy_clothes_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'unique_character_checks', name = 'daisy', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'}], character = 'daisy_default',
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
		reqs = [],
		text = [{text = "DAISY_CLOTHES_REPLY_2_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_CLOTHES_REPLY_2_1_2", reqs = [], previous_dialogue_option = 2} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1
		}],
	},

	daisy_clothes_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_default_happy',
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
			code = 'daisy_clothes_amelia_2_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'daisy_clothes_amelia_2_2', text = "DAISY_CLOTHES_AMELIA_OPTION_2_2", reqs = [], dialogue_argument = 2,
		}, {
			code = 'close', text = "DAISY_CLOTHES_AMELIA_OPTION_2_3", reqs = [], dialogue_argument = 3,
		}],
	},

	daisy_clothes_amelia_2_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_2_1", reqs = []}],
		options = [ {
			code = 'daisy_clothes_amelia_3_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_1_1", reqs = [{type = "has_money", value = 150}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE", reqs = [], dialogue_argument = 3,
		}],
	},

	daisy_clothes_amelia_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_2_2", reqs = []}],
		options = [ {
			code = 'daisy_clothes_amelia_3_2', text = "DAISY_CLOTHES_AMELIA_OPTION_2_2_1", reqs = [{type = "has_money", value = 250}], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE", reqs = [], dialogue_argument = 3,
		}],
	},

	daisy_clothes_amelia_3_1 = {
		reqs = [],
		tags = ['dialogue_scene'], image = null,  character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_3_150", reqs = []}],
		common_effects = [{code = 'money_change', operant = '-', value = 150},
		{code = 'decision', value = 'DaisyDressNormal'}], # dress decision normal
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_dress_acquired_normal_1",
			args = [{type = 'add_to_date', date = [2,2], hour = 2}]}, {code = 'progress_quest', value = 'daisy_clothes', stage = 'stage3'}]
		}],
	},
	daisy_clothes_amelia_3_2 = {
		reqs = [],
		tags = ['dialogue_scene'], image = null,  character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_3_250", reqs = []}],
		common_effects = [{code = 'money_change', operant = '-', value = 250},
		{code = 'decision', value = 'DaisyDressLewd'}], # dress decision lewd
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_dress_acquired_lewd_1",
			args = [{type = 'add_to_date', date = [2,2], hour = 2}]}, {code = 'progress_quest', value = 'daisy_clothes', stage = 'stage3'}]
		}],
	},

	daisy_dress_acquired_normal_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0", reqs = [], }],
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'body_image', operant = '=', value = "daisy_maid_body"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/daisy_maid_portrait.png"}]},
			{code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'create_and_equip', item = "daisy_dress", parts = {}}
						],
			},
			{code = 'complete_quest', value = 'daisy_clothes'},
			{
				code = 'unique_character_changes',
				value = 'daisy',
				args = [
					{code = 'growth_factor', value = 1, operant = "+"},
				]
			},
			{code = 'affect_unique_character', name = 'daisy', type = 'remove_trait', value = 'coward'},
			
			{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 2}]}
			],
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
			bonus_effects = []
		} ],
	},

	daisy_dress_acquired_normal_3 = { # NON-LEWD DRESS / WILLING
		variations = [ {
			reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 3}],
			tags = ['dialogue_scene'], image = null, character = 'daisy_maid',
			text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_0", reqs = []}],
			options = [ {
				code = 'daisy_dress_acquired_normal_4_1', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_1", reqs = [], dialogue_argument = 1, change_dialogue_type = 2
			}, {
				code = 'daisy_dress_acquired_normal_4_1', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_2", reqs = [], dialogue_argument = 2, change_dialogue_type = 2
			}, {
				code = 'daisy_dress_acquired_normal_4_1', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_3", reqs = [], dialogue_argument = 3, change_dialogue_type = 2,
				bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] #right
			}, ],
		}, {
			reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 3}],
			tags = ['dialogue_scene'], image = null, character = 'daisy_maid',
			text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_BAD", reqs = []}],
			options = [ {
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
				bonus_effects = [],
			} ],
		} ]
	},

	daisy_dress_acquired_normal_4_1 = {
		image = null,
		custom_background = "daisy_bj1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_1", reqs = []}],
		options = [
#			{
#				code = 'close',
#				text = "DIALOGUECLOSE",
#				reqs = [],
#				dialogue_argument = 1,
#				change_dialogue_type = 1,
#				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'},
#				{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 8}]}],
#			}
			{
				code = 'daisy_dress_acquired_normal_4_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			}
		],
	},

	daisy_dress_acquired_normal_4_2 = {
		image = null,
		custom_background = "daisy_bj1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_normal_4_3',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			}
		],
	},

	daisy_dress_acquired_normal_4_3 = {
		image = null,
		custom_background = "daisy_bj1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_3", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_normal_4_4',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			}
		],
	},

	daisy_dress_acquired_normal_4_4 = {
		image = null,
		custom_background = "daisy_bj1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_4", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_normal_4_5',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			}
		],
	},

	daisy_dress_acquired_normal_4_5 = {
		image = null,
		custom_background = "daisy_bj3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_5", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [],
			}
		],
	},

	daisy_dress_acquired_lewd_1 = { # LEWD DRESS / RELUCTANT
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_0", reqs = [], }],
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'body_image', operant = '=', value = "daisy_maid_body"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/daisy_maid_portrait.png"}]},
			{code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'add_trait', trait = 'loyalty_dress_lewd'},
						{code = 'create_and_equip', item = "daisy_dress_lewd", parts = {}}
						],
			},
			{code = 'complete_quest', value = 'daisy_clothes'},
			{
				code = 'unique_character_changes',
				value = 'daisy',
				args = [
					{code = 'growth_factor', value = 1, operant = "+"},
				]
			},
			{code = 'affect_unique_character', name = 'daisy', type = 'remove_trait', value = 'coward'},
			{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 2}]}
			
			],
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
				bonus_effects = [],
		} ],
	},

	daisy_dress_acquired_lewd_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'daisy_maid_nude',
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2", reqs = [], }],
		options = [ {
			code = 'daisy_dress_acquired_lewd_4_1', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'daisy_dress_acquired_lewd_4_1', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'daisy_dress_acquired_lewd_4_1', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', change_dialogue_type = 2,
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] #right
		} ],
	},

	daisy_dress_acquired_lewd_4_1 = {
		image = null,
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_1", reqs = []}],
#		common_effects = [{
#					code = 'unique_character_changes',
#					value = 'daisy',
#					args = [
#						{code = 'sex_skills_oral', operant = "+", value = 20},
#						{code = 'submission', operant = '+', value = 15},
#					]
#				}],
		options = [
			{
				code = 'daisy_dress_acquired_lewd_4_2',
				text = "DIALOGUECONTINUE",
#				code = 'close',
#				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
#				change_dialogue_type = 1,
#				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'},
#				{code = 'add_timed_event', value = "daisy_training_message", args = [{type = 'add_to_date', date = [4,7], hour = 8}]}],
			}
		],
	},
	
	daisy_dress_acquired_lewd_4_2 = {
		image = null,
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_2", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_lewd_4_3',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	daisy_dress_acquired_lewd_4_3 = {
		image = null,
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_3", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_lewd_4_4',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	daisy_dress_acquired_lewd_4_4 = {
		image = null,
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_4", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_lewd_4_5',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	daisy_dress_acquired_lewd_4_5 = {
		image = null,
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_5", reqs = []}],
		options = [
			{
				code = 'daisy_dress_acquired_lewd_4_6',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	daisy_dress_acquired_lewd_4_6 = {
		image = null,
		custom_background = "daisy_bj6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2_6", reqs = []}],
		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'sex_skills_oral', operant = "+", value = 20},
						{code = 'submission', operant = '+', value = 15},
					]
				}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [],
			}
		],
	},

	daisy_training_message = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], character = 'daisy_maid',
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
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_1", reqs = [{type = "has_money", value = 200}], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "training_complete_serve_1", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'money_change', operant = '-', value = 200}],
		}, {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_4", reqs = [{type = "has_money", value = 300}, {type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_2'}], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "training_complete_sex_1", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'money_change', operant = '-', value = 300}]
		}, {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_5", reqs = [{type = "has_money", value = 400}, {type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_3'}], dialogue_argument = 5, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "daisy_training_intermission_1", args = [{type = 'add_to_date', date = [3,3], hour = 2}]}, {code = 'add_timed_event', value = "training_complete_fucktoy_1", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'money_change', operant = '-', value = 400}]
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
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = false}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'progress_quest', value = 'daisy_training', stage = 'stage2'}],
		} ],
	},
	daisy_training_intermission_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		common_effects = [
			{
				code = 'unique_character_changes',
				value = 'daisy',
				args = [
					{code = 'take_virginity', type = 'vaginal', partner = "guild_trainer"},
					{code = 'take_virginity', type = 'anal', partner = "guild_trainer"},
				]
			}],
		text = [{text = "DAISY_TRAINING_INTERMISSION_1", reqs = []}],
		options = [ {
			code = 'daisy_training_intermission_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	daisy_training_intermission_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "DAISY_TRAINING_INTERMISSION_2", reqs = []}],
		options = [ {
			code = 'daisy_training_intermission_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	daisy_training_intermission_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "DAISY_TRAINING_INTERMISSION_3", reqs = []}],
		options = [ {
			code = 'daisy_training_intermission_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	daisy_training_intermission_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "DAISY_TRAINING_INTERMISSION_4", reqs = []}],
		options = [ {
			code = 'daisy_training_intermission_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	daisy_training_intermission_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "DAISY_TRAINING_INTERMISSION_5", reqs = []}],
		options = [ {
			code = 'daisy_training_intermission_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	daisy_training_intermission_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "DAISY_TRAINING_INTERMISSION_6", reqs = []}],
		options = [ {
			code = 'daisy_training_intermission_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	daisy_training_intermission_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_training5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "DAISY_TRAINING_INTERMISSION_7", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	training_complete_serve_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_SERVE_REPLY_0", reqs = []}],
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = true},
		{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'charm_factor', operant = '+', value = 1},
						{code = 'tame_factor', operant = '+', value = 1},
						{code = 'charm', operant = "+", value = 15},
					]
				}
		],
		options = [ {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_SERVE_OPTION_1_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_SERVE_OPTION_1_2", reqs = [], dialogue_argument = 2,
		}],
	},

	training_complete_serve_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_SERVE_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "TRAINING_COMPLETE_SERVE_REPLY_1_2", reqs = [], previous_dialogue_option = 2}],
		common_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 2}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'complete_quest', value = 'daisy_training'}]
		}  ],
	},
	
	
	training_complete_sex_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_0", reqs = []}],
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = true},

			{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'charm_factor', operant = '+', value = 1},
						{code = 'sex_skills_oral', operant = "+", value = 15},
						{code = 'add_trait', trait = 'loyalty_sex_basic'},
						{code = 'add_trait', trait = 'loyalty_sex_oral'},
					]
				},

		],
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
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_2", reqs = [], previous_dialogue_option = 2},
		{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_3", reqs = [], previous_dialogue_option = 3},
		{text = "TRAINING_COMPLETE_SEX_REPLY_1_1_all", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 2}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}],
	},

	training_complete_sex_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_2_1", reqs = []}],
		options = [ {
			code = 'training_complete_sex_2', text = "TRAINING_COMPLETE_SEX_OPTION_1_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'training_complete_sex_5', text = "TRAINING_COMPLETE_SEX_OPTION_1_2_2", reqs = [], dialogue_argument = 2,
		}],
	},

	training_complete_sex_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_SEX_REPLY_1_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_message",
		args = [{type = 'add_to_date', date = [7,7], hour = 2}]}, {code = 'complete_quest', value = 'daisy_training'}]
		}]
	},

	training_complete_fucktoy_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_0", reqs = []}],
		common_effects = [
			{code = 'add_timed_event', value = "daisy_admirer_message",args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'unique_character_changes', value = 'daisy', args = [{code = 'add_profession', profession = "sextoy"}]},
			{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = true},
			{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'sexuals_factor', operant = '+', value = 1},
						{code = 'sex_skills_oral', operant = "+", value = 20},
						{code = 'sex_skills_petting', operant = "+", value = 20},
						{code = 'sex_skills_pussy', operant = "+", value = 25},
						{code = 'sex_skills_anal', operant = "+", value = 15},
						{code = 'add_trait', trait = 'loyalty_sex_basic'},
						{code = 'add_trait', trait = 'loyalty_sex_oral'},
						{code = 'add_trait', trait = 'loyalty_sex_anal'},
						{code = 'add_trait', trait = 'loyalty_sex_adv'},
						{code = 'add_trait', trait = 'loyalty_sex_group'},
					]
				},
			],
		options = [ {
			code = 'training_complete_fucktoy_2', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'close', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_2", reqs = [], dialogue_argument = 2, bonus_effects = [ {code = 'complete_quest', value = 'daisy_training'}]
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
			code = 'training_complete_fucktoy_3_1_1', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'training_complete_fucktoy_3_2_1', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'training_complete_fucktoy_3_3_1', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'dialogue_counter', name = 'daisy_sympathy', op = '-'}] # right
		}, {
			code = 'training_complete_fucktoy_4', text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_1_4", reqs = [], dialogue_argument = 4, change_dialogue_type = 1
		}]
	},

	training_complete_fucktoy_3_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_1", reqs = []}],
		options = [ {
#			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, bonus_effects = [{code = 'complete_quest', value = 'daisy_training'}]
			code = 'training_complete_fucktoy_3_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	training_complete_fucktoy_3_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_2", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_1_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_3_1_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_3", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_1_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_3_1_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_1_4", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'complete_quest', value = 'daisy_training'}], type = 'next_dialogue'
		}, ]
	},

	#gangbang
	training_complete_fucktoy_3_2_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_1", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},
	
	training_complete_fucktoy_3_2_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
#		common_effects = [{code = 'money_change', operant = '+', value = 50}],
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_2", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_2_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},
	
	training_complete_fucktoy_3_2_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_3", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_2_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},
	
	training_complete_fucktoy_3_2_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_2_4", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'complete_quest', value = 'daisy_training'}], type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_3_3_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public1",

		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'obedience', operant = "-", value = 25},
					]
				}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_1", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_3_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_3_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public5",

		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'obedience', operant = "-", value = 25},
					]
				}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_2", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_3_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_3_3_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public5",

		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'obedience', operant = "-", value = 25},
					]
				}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_3", reqs = []}],
		options = [ {
			code = 'training_complete_fucktoy_3_3_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_3_3_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_public5",

		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'obedience', operant = "-", value = 25},
					]
				}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_3_4", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'complete_quest', value = 'daisy_training'}], type = 'next_dialogue'
		}, ]
	},

	training_complete_fucktoy_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "TRAINING_COMPLETE_FUCKTOY_REPLY_1_1_4", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'complete_quest', value = 'daisy_training'}]
		}, ]
	},

	daisy_admirer_message = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
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
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_1_1", reqs = []}],
		common_effects = [{code = 'money_change', operant = '+', value = 2500},
		{code = 'unique_character_changes', value = 'daisy', args = [{code = 'remove_character'}]}],
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
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_2_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'unique_character_changes', value = 'daisy', args = [{code = 'remove_character'}]}]
		} ]
	},

	daisy_admirer_message_1_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "DAISY_ADMIRER_MESSAGE_REPLY_1_3", reqs = []}],
		options = [ {
			bonus_effects = [{code = 'add_timed_event', value = "daisy_admirer_first_event_1",
				args = [{type = 'add_to_date', date = [7,10], hour = 2}]}],
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		} ]
	},

	daisy_admirer_first_event_1 = {
		variations = [
			{
				reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}],
				tags = ['dialogue_scene', 'master_translate'], image = null, character = 'daisy_maid',
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
				tags = ['dialogue_scene', 'master_translate'], image = 'daisyevent', #character = 'daisy_maid',
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
		reqs = [], character = "daisy_maid",
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
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_2", reqs = [], previous_dialogue_option = 2},
		{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_lost_message",
		args = [{type = 'add_to_date', date = [6,8], hour = 3}]}], type = 'next_dialogue',
		} ]
	},

	daisy_admirer_first_event_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_2_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_lost_message",
		args = [{type = 'add_to_date', date = [6,8], hour = 3}]}], type = 'next_dialogue',
		} ]
	},

	daisy_admirer_first_event_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "daisy_discipline",
		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'obedience', operant = "+", value = 48},
						{code = 'submission', operant = "+", value = 20},
					]
				}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [{text = "SCENEDAISY_FIRST_EVENT_DISCIPLINE", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_lost_message",
		args = [{type = 'add_to_date', date = [6,8], hour = 3}]}], type = 'next_dialogue',
		}, ]
	},

	daisy_lost_message = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_MESSAGE", reqs = []}],
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = false}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'daisy_lost', stage = 'stage1'}]
		} ]
	},

	daisy_lost_amelia_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_LOST_AMELIA_REPLY_0", reqs = []}],
		options = [ {
			code = 'daisy_lost_amelia_2', text = "DAISY_LOST_AMELIA_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_lost_amelia_2', text = "DAISY_LOST_AMELIA_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},

	daisy_lost_amelia_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_LOST_AMELIA_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_LOST_AMELIA_REPLY_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'make_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'progress_quest', value = 'daisy_lost', stage = 'stage2'}]
		} ]
	},

	daisy_lost_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_0_1", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'daisy_admirer_guards1',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_0_2", reqs = []}],
		options = [ {
			code = 'daisy_lost_5', text = "DAISY_LOST_APPROACH_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_5', text = "DAISY_LOST_APPROACH_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_5', text = "DAISY_LOST_APPROACH_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_lost_5 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_1", reqs = []}],
		options = [ {
			code = 'daisy_lost_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_6 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_2", reqs = []}],
		options = [ {
			code = 'daisy_lost_8', text = "DAISY_LOST_APPROACH_OPTION_FIGHT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_13', text = "DAISY_LOST_APPROACH_OPTION_3_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_14', text = "DAISY_LOST_APPROACH_OPTION_3_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_lost_8 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_1", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'daisy_admirer_guards2',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_9 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_2", reqs = []}],
		options = [ {
			code = 'daisy_lost_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_3", reqs = []}],
		common_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'loyalty', operant = "+", value = 40},
					]
				}],
		options = [ {
			code = 'daisy_lost_11', text = "DAISY_LOST_APPROACH_OPTION_FIGHT_4_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_11', text = "DAISY_LOST_APPROACH_OPTION_FIGHT_4_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'daisy_lost_12', text = "DAISY_LOST_APPROACH_OPTION_FIGHT_4_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},

	daisy_lost_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_good", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}]},
		{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_4_1and2_bad", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}]}],
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = true}],
		options = [ {
			code = 'daisy_consensual_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'}, ]
		} ]
	},

	daisy_lost_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_FIGHT_4_3", reqs = []}],
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = true}],
		options = [ {
			code = 'daisy_consensual_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'}, ]
		} ]
	},

	# =Very well, let's see what she thinks
	daisy_lost_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_3_2", reqs = []},
		{text = "DAISY_LOST_APPROACH_REPLY_3_2_good", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}],
		bonus_effects = [{
					code = 'unique_character_changes',
					value = 'daisy',
					args = [
						{code = 'loyalty', operant = "+", value = 50},
					]
				}]
		},
		{text = "DAISY_LOST_APPROACH_REPLY_3_2_bad", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}]}],
		options = [ {
			code = 'daisy_lost_11', text = "DIALOGUECONTINUE", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'gte', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'close', text = "DIALOGUECLOSE", reqs = [{type = 'local_counter', name = 'daisy_sympathy', operant = 'lt', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'unique_character_changes', value = 'daisy', args = [{code = 'remove_character'}]}],
		},  ]
	},

	daisy_lost_14 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_LOST_APPROACH_REPLY_3_3_1", reqs = []}],
		options = [ {
			code = 'daisy_lost_15', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},

	daisy_lost_15 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		reqs = [], character = "daisy_maid",
		text = [{text = "DAISY_LOST_APPROACH_REPLY_3_3_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'daisy_lost'},
			{code = 'remove_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'unique_character_changes', value = 'daisy', args = [{code = 'remove_character'}]}],
		} ]
	},
	
	daisy_consensual_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], unique_character = "daisy",
		text = [{text = "DAISY_CONSENSUAL_1", reqs = []}],
		options = [ {
			code = 'daisy_consensual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	daisy_consensual_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "daisy",
		text = [{text = "DAISY_CONSENSUAL_2", reqs = []}],
		options = [ {
			code = 'daisy_consensual_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, open_speed = 2, change_dialogue_type = 2, type = 'next_dialogue'
		} ]
	},
	
	daisy_consensual_3 = {
		image = null,custom_background = "daisy_bent1", tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [],
		text = [{text = "DAISY_CONSENSUAL_3", reqs = []}],
		options = [ {
			code = 'daisy_consensual_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	daisy_consensual_4 = {
		image = null, custom_background = "daisy_bent2", tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_CONSENSUAL_4", reqs = []}],
		options = [ {
			code = 'daisy_consensual_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	daisy_consensual_5 = {
		image =  null, custom_background = "daisy_bent3", tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "DAISY_CONSENSUAL_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'screen_black_transition', value = 1}],
		} ]
	},
}
