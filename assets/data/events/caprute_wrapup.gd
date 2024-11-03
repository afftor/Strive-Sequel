extends Reference
var data = {
	capture_wrapup_start = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'PrincessDead', check = true}],
				image = null, tags = ['dialogue_scene'], character = 'duncan',
				text = [{text = "PRE_ANASTASIA_EXECUTION_1", reqs = [], previous_dialogue_option = 0},
				{text = "PRE_ANASTASIA_EXECUTION_2", reqs = [{type = 'decision', value = 'SiegeLostSupplies', check = true}], previous_dialogue_option = 1},
				{text = "PRE_ANASTASIA_EXECUTION_3", reqs = [{type = 'decision', value = 'SiegeLostSupplies', check = false}], previous_dialogue_option = 1}],
				options = [ {
					code = 'capture_wrapup_start', text = "PRE_ANASTASIA_EXECUTION_OPTION_1", 
					reqs = [{type = 'decision', value = 'aire_is_saved', check = true}, {type = 'decision', value = 'aire_is_dead', check = false},], dialogue_argument = 1, remove_after_first_use = true,
				}, {
					code = 'capture_wrapup_1', text = "PRE_ANASTASIA_EXECUTION_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
				}, {
					code = 'capture_wrapup_1', text = "PRE_ANASTASIA_EXECUTION_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
				}],
			}, 
			{
				reqs = [{type = 'decision', value = 'PrincessDead', check = false}],
				image = null, tags = ['dialogue_scene'], character = 'duncan',
				text = [{text = "PRE_ANASTASIA_EXECUTION_5", reqs = [], previous_dialogue_option = 0},
				{text = "PRE_ANASTASIA_EXECUTION_7", reqs = [], previous_dialogue_option = 4},
				{text = "PRE_ANASTASIA_EXECUTION_8", reqs = [], previous_dialogue_option = 5}],
				options = [ {
					code = 'capture_wrapup_2', text = "PRE_ANASTASIA_EXECUTION_OPTION_4", 
					reqs = [], dialogue_argument = 1
				}, {
					code = 'capture_wrapup_3', text = "PRE_ANASTASIA_EXECUTION_OPTION_5", reqs = [], dialogue_argument = 2, type = 'next_dialogue'  
				}, {
					code = 'capture_wrapup_3', text = "PRE_ANASTASIA_EXECUTION_OPTION_6", reqs = [], dialogue_argument = 3, type = 'next_dialogue'  
				}],
			}
		]
	},
	
	capture_wrapup_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "PRE_ANASTASIA_EXECUTION_4", reqs = [], }],
		common_effects = [{code = 'add_timed_event', value = "duncans_declaration_start", 
		args = [{type = 'add_to_date', date = [7,7], hour = 1}]}], 
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'princess_search'}, {code = "update_guild"},
			{code = 'remove_quest_location', value = 'quest_final_operation_location'}]
		} ],
	},
	
	capture_wrapup_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "PRE_ANASTASIA_EXECUTION_6", reqs = [], }],
		options = [ {
			code = 'capture_wrapup_start', text = "PRE_ANASTASIA_EXECUTION_OPTION_7", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}, {
				code = 'capture_wrapup_start', text = "PRE_ANASTASIA_EXECUTION_OPTION_8", reqs = [], dialogue_argument = 5, type = 'next_dialogue'
		}],
	},
	
	capture_wrapup_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "PRE_ANASTASIA_EXECUTION_9", reqs = [], previous_dialogue_option = 2},
		{text = "PRE_ANASTASIA_EXECUTION_10", reqs = [], previous_dialogue_option = 3}],
		common_effects = [{code = 'add_timed_event', value = "guilds_meeting_start", 
		args = [{type = 'add_to_date', date = [1,1], hour = 1}]}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'princess_search'}, {code = "update_guild"},
			{code = 'remove_quest_location', value = 'quest_final_operation_location'}]
		} ],
	},
	
	guilds_meeting_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'duncan', character2 = 'myr',
		text = [{text = "PRE_ANASTASIA_EXECUTION_11", reqs = []}],
		options = [ {
			code = 'guilds_meeting_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	guilds_meeting_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'sigmund', character2 = 'myr',
		text = [{text = "PRE_ANASTASIA_EXECUTION_12", reqs = []}],
		options = [ {
			code = 'guilds_meeting_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	guilds_meeting_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_13", reqs = []}],
		options = [ {
			code = 'guilds_meeting_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	guilds_meeting_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_14", reqs = []}],
		options = [ {
			code = 'guilds_meeting_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	guilds_meeting_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'sigmund', character2 = 'myr',
		text = [{text = "PRE_ANASTASIA_EXECUTION_15", reqs = []}],
		options = [ {
			code = 'guilds_meeting_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	guilds_meeting_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_16", reqs = []}],
		options = [ {
			code = 'guilds_meeting_6', text = "PRE_ANASTASIA_EXECUTION_OPTION_9", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'guilds_meeting_15', text = "PRE_ANASTASIA_EXECUTION_OPTION_10", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_19", reqs = []}],
		options = [ {
			code = 'guilds_meeting_7', text = "PRE_ANASTASIA_EXECUTION_OPTION_11", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'neq', value = 'female'}]}], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'decision', value = 'marry_option'}]
		}, {
			code = 'guilds_meeting_12', text = "PRE_ANASTASIA_EXECUTION_OPTION_12", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = 'decision', value = 'enslave_option'}]
		}],
	},
	
	guilds_meeting_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'myr',
		text = [{text = "PRE_ANASTASIA_EXECUTION_20", reqs = []}],
		options = [ {
			code = 'guilds_meeting_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_8 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_21", reqs = []}],
		options = [ {
			code = 'guilds_meeting_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_9 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_22", reqs = []}],
		options = [ {
			code = 'guilds_meeting_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'myr', character2 = 'sigmund',
		text = [{text = "PRE_ANASTASIA_EXECUTION_23", reqs = []}],
		options = [ {
			code = 'guilds_meeting_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_24", reqs = []}],
		common_effects = [{code = 'decision', value = 'AnastasiaMarryAttempt'}],
		options = [ {
			code = 'amelia_intermission_start', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	# =I want to make her my slave
	guilds_meeting_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_25", reqs = []}],
		options = [ {
			code = 'guilds_meeting_13', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'myr', character2 = 'sigmund',
		text = [{text = "PRE_ANASTASIA_EXECUTION_26", reqs = []}],
		options = [ {
			code = 'guilds_meeting_14', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	
	guilds_meeting_14 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "PRE_ANASTASIA_EXECUTION_27", reqs = []}],
		common_effects = [{code = 'decision', value = 'AnastasiaEnslaveAttempt'}],
		options = [ {
			code = 'amelia_intermission_start', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_15 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = 'amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_28", reqs = []}],
		options = [ {
			code = 'anastasia_execution_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = "close_guild_window"}],
		}],
	},
	
	amelia_intermission_start = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = 'amelia',
		text = [{text = "MIND_CONTROL_1", reqs = []}],
		options = [ {
			code = 'amelia_intermission_1', text = "MIND_CONTROL_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_intermission_1', text = "MIND_CONTROL_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ],
	},
	
	amelia_intermission_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "MIND_CONTROL_2", reqs = [], previous_dialogue_option = 2},
		{text = "MIND_CONTROL_3", reqs = []}],
		options = [ {
			code = 'amelia_intermission_2', text = "MIND_CONTROL_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_intermission_2', text = "MIND_CONTROL_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ],
	},
	
	amelia_intermission_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "MIND_CONTROL_4", reqs = [], previous_dialogue_option = 1},
		{text = "MIND_CONTROL_5", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'progress_quest', value = 'princess_persuasion', stage = 'stage1'},{code = 'rewrite_save'}]
		} ],
	},
	
	about_princess_start = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "MIND_CONTROL_6", reqs = []}],
		options = [ {
			code = 'about_princess_1', text = "MIND_CONTROL_OPTION_6", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'fighters_introduction2', text = "MIND_CONTROL_OPTION_7", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}  ],
	},
	
	about_princess_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "MIND_CONTROL_7", reqs = []}],
		options = [ {
			code = 'about_princess_2', text = "YES", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'fighters_introduction2', text = "NO", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}],
	},
	
	about_princess_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "MIND_CONTROL_8", reqs = []}],
		options = [ {
			code = 'anastasia_execution_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = "close_guild_window"}],
		}],
	},
	
	mindcontrol_start = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'myr',
		text = [{text = "MIND_CONTROL_9", reqs = []}],
		common_effects = [{code = 'make_quest_location', value = 'quest_mages_xari'}],
		options = [ {
			code = 'mages_introduction3', text = "MIND_CONTROL_OPTION_9", reqs = [], dialogue_argument = 4,
		}, {
			code = 'mages_introduction3', text = "MIND_CONTROL_OPTION_10", reqs = [], dialogue_argument = 4,
		}],
	},
	
	mindcontrol_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_11", reqs = []}],
		options = [ {
			code = 'mindcontrol_2', text = "MIND_CONTROL_12", reqs = [], dialogue_argument = 1,
		}, {
			code = 'close', text = "MIND_CONTROL_13", reqs = [], dialogue_argument = 2,
		}],
	},
	
	mindcontrol_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_14", reqs = []}],
		options = [ {
			code = 'mindcontrol_3', text = "MIND_CONTROL_OPTION_11", reqs = [{type = "has_money", value = 5000}], dialogue_argument = 1,
			bonus_effects = [{code = 'money_change', operant = '-', value = 5000}],
		}, {
			code = 'close', text = "MIND_CONTROL_OPTION_12", reqs = [], dialogue_argument = 2,
		}],
	},
	
	mindcontrol_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_15", reqs = []}],
		options = [ {
			code = 'mindcontrol_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	mindcontrol_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_16", reqs = []}],
		options = [ {
			code = 'mindcontrol_5', text = "MIND_CONTROL_OPTION_13", reqs = [{type = 'decision', value = 'bracelet_found', check = true}], dialogue_argument = 1,
		}, {
			code = 'mindcontrol_7', text = "NO", reqs = [], dialogue_argument = 2,
		}],
	},
	
	mindcontrol_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_17", reqs = []}],
		options = [ {
			code = 'mindcontrol_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	mindcontrol_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_18", reqs = []}],
		common_effects = [{code = 'decision', value = 'mindbreak_enabled'}],
		options = [ {
			code = 'close', text = "MIND_CONTROL_OPTION_14", reqs = [], dialogue_argument = 1
		}, {
			code = 'close', text = "MIND_CONTROL_OPTION_15", reqs = [], dialogue_argument = 2
		}],
	},
	
	mindcontrol_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_19", reqs = []}],
		options = [ {
			code = 'mindcontrol_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	mindcontrol_8 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'xari',
		text = [{text = "MIND_CONTROL_20", reqs = []}],
		common_effects = [{code = 'decision', value = 'mindbreak_enabled'}],
		options = [ {
			code = 'close', text = "MIND_CONTROL_OPTION_14", reqs = [], dialogue_argument = 1
		}, {
			code = 'close', text = "MIND_CONTROL_OPTION_15", reqs = [], dialogue_argument = 2
		}],
	},
	
	#Close guild window before so that Aliron is on the screen
	anastasia_execution_start = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = 'amelia',
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "anastasia_execution",
		save_scene_to_gallery = true,
		text = [{text = "ANASTASIA_EXECUTION_1", reqs = []}],
		options = [ {
			code = 'anastasia_execution_1', text = "ANASTASIA_EXECUTION_OPTION_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'anastasia_execution_1', text = "ANASTASIA_EXECUTION_OPTION_2", reqs = [], dialogue_argument = 2,
		}],
	},
	
	anastasia_execution_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "ANASTASIA_EXECUTION_2", reqs = [], previous_dialogue_option = 1},
		{text = "ANASTASIA_EXECUTION_3", reqs = [], previous_dialogue_option = 2},
		{text = "ANASTASIA_EXECUTION_4", reqs = []}],
		options = [ {
			code = 'anastasia_execution_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, change_dialogue_type = 2, open_speed = 0.5, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_5", reqs = []}], 
		custom_background = "anastasia_execution1", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_6", reqs = []}], custom_background = "anastasia_execution2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		options = [ {
			code = 'anastasia_execution_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_7", reqs = []}], custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_5', text = "ANASTASIA_EXECUTION_OPTION_3", reqs = [], dialogue_argument = 1,
		}, {
			code = 'anastasia_execution_5', text = "ANASTASIA_EXECUTION_OPTION_4", reqs = [], dialogue_argument = 2,
		}, {
			code = 'anastasia_execution_5', text = "ANASTASIA_EXECUTION_OPTION_5", reqs = [], dialogue_argument = 3,
		}],
	},
	
	anastasia_execution_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [
#		{text = "ANASTASIA_EXECUTION_8", reqs = [], previous_dialogue_option = 1},
#		{text = "ANASTASIA_EXECUTION_9", reqs = [], previous_dialogue_option = 2},
#		{text = "ANASTASIA_EXECUTION_10", reqs = [], previous_dialogue_option = 3},
		{text = "ANASTASIA_EXECUTION_11", reqs = []}], 
		custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_12", reqs = []}], custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,  type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_13", reqs = []}], custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_8 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_14", reqs = []}], custom_background = "anastasia_execution3", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'duncans_declaration_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, close_speed = 1, type = 'next_dialogue'
		}],
	},
	
	duncans_declaration_start = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], character = 'duncan',
		text = [{text = "DUNCANS_DECLARATION_START", reqs = []}], 
		options = [ {
			code = 'final_words_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	}
}
