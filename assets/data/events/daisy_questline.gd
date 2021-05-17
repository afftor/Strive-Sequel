var data = {
	daisy_recruitment_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], 
		reqs = [], character = 'daisy_default',
		text = [{text = "DAISY_RECRUITMENT_START", reqs = [], }],
		options = [ {
			#TODO add +1 sympathy
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
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
			code = 'close', text = "DAISY_CLOTHES_SIGMUND_OPTION_2", reqs = [], dialogue_argument = 1,
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
			code = 'daisy_clothes_amelia_3', text = "DAISY_CLOTHES_AMELIA_OPTION_2_1_1", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_CLOTHES_AMELIA_OPTION_2_1'}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE", reqs = [], dialogue_argument = 3, 
		}],
	},
	
	daisy_clothes_amelia_2_2 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [], character = 'amelia',
		text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_2_2", reqs = []}],
		options = [ {
			code = 'daisy_clothes_amelia_3', text = "DAISY_CLOTHES_AMELIA_OPTION_2_2_1", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_CLOTHES_AMELIA_OPTION_2_2'}], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_amelia_1', text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE", reqs = [], dialogue_argument = 3, 
		}],
	},
	
	daisy_clothes_amelia_3 = {
		variations = [ {
			reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_CLOTHES_AMELIA_OPTION_2_1_1'}],
			tags = ['dialogue_scene'], image = null,
			text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_3_150", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 150}],
			options = [ {
				# TODO add daisy_dress_acquired_normal_1 after 1 day
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, 
			}],
		}, {
			reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_CLOTHES_AMELIA_OPTION_2_2_1'}],
			tags = ['dialogue_scene'], image = null,
			text = [{text = "DAISY_CLOTHES_AMELIA_REPLY_3_250", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 250}],
			options = [ {
				# TODO add daisy_dress_acquired_lewd_1 after 1 day
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, 
			}],
		} ]
	},
	
	daisy_dress_acquired_normal_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], 
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0", reqs = [], }],
		options = [ {
			code = 'daisy_dress_acquired_normal_2', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
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
		#TODO add +1 sympathy
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
				#TODO add -1 sympathy
				code = 'daisy_dress_acquired_normal_4', text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_2_3", reqs = [], dialogue_argument = 3, change_dialogue_type = 2
			}, ],
		}, {
			reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 3}],
			tags = ['dialogue_scene'], image = null, character = 'daisy_maid',
			text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2", reqs = []}],
			options = [ {
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, 
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'}],
			} ],
		} ]
	}, 
	
	daisy_dress_acquired_normal_4 = {
		image = null,
		custom_background = "fire_depths4", # TODO change art
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
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'}],
			}
		],
	},
	
	daisy_dress_acquired_lewd_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], 
		reqs = [], character = 'daisy_maid',
		text = [{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0", reqs = [], }],
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
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'}],
		} ],
	},
	
	daisy_dress_acquired_lewd_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daist_maid_nude',
		text = [{text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_2", reqs = [], }],
		options = [ {
			code = 'daisy_dress_acquired_lewd_4', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'daisy_dress_acquired_lewd_4', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'daisy_dress_acquired_lewd_4', text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_2_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', change_dialogue_type = 2
		} ],
	},
	
	daisy_dress_acquired_lewd_4 = {
		image = null,
		custom_background = "fire_depths2", # TODO change art
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
				bonus_effects = [{code = 'complete_quest', value = 'daisy_clothes'}],
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
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'add_timed_event', value = "daisy_training_intermission", args = [{type = 'add_to_date', date = [3,3], hour = 10}]}]
		}, {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_4", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_2'}], dialogue_argument = 4, type = 'next_dialogue', bonus_effects = [{code = 'add_timed_event', value = "training_complete_serve_1", args = [{type = 'add_to_date', date = [7,7], hour = 8}]}]
		}, {
			code = 'daisy_training_2', text = "DAISY_TRAINING_OPTION_2_5", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_OPTION_2_3'}], dialogue_argument = 5, type = 'next_dialogue', bonus_effects = [{code = 'add_timed_event', value = "training_complete_sex_1", args = [{type = 'add_to_date', date = [7,7], hour = 8}]}]
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
		reqs = [], character = "daisy_maid", # TODO change sprite?
		text = [{text = "TRAINING_COMPLETE_REPLY_0", reqs = []}],
		options = [ {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_OPTION_1_1", reqs = [], dialogue_argument = 1, 
		}, {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_OPTION_1_2", reqs = [], dialogue_argument = 2, 
		}],
	},
	
	training_complete_serve_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = "daisy_maid", # TODO change sprite?
		text = [{text = "TRAINING_COMPLETE_SERVE_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "TRAINING_COMPLETE_SERVE_REPLY_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, 
		}  ],
	},
	
	training_complete_sex_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], 
		reqs = [], character = "daisy_maid", # TODO change sprite?
		text = [{text = "TRAINING_COMPLETE_SERVE_REPLY_0", reqs = []}],
		options = [ {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_SERVE_OPTION_1_1", reqs = [], dialogue_argument = 1, 
		}, {
			code = 'training_complete_serve_2', text = "TRAINING_COMPLETE_SERVE_OPTION_1_2", reqs = [], dialogue_argument = 2, 
		}],
	},
}
