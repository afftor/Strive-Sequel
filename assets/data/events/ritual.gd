var data = {
	ritual_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_START", reqs = []}],
		options = [ {
			code = 'ritual_1_1', text = "RITUAL_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ritual_1_2', text = "RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		} ]
	},
	
	ritual_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "RITUAL_1_1_GOOD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'gte', value = 30}]}],
				bonus_effects = [{code = 'decision', value = 'putPowder'}]},
			{text = "RITUAL_1_1_BAD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'lt', value = 30}]}]}],
		options = [ {
			code = 'ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_1_2", reqs = []}],
		common_effects = [{code = 'decision', value = 'maePregnant'}],
		options = [ {
			code = 'ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_2", reqs = []}],
		options = [ {
			code = 'ritual_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_3", reqs = []}],
		options = [ {
			code = 'ritual_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_4", reqs = []}],
		options = [ {
			code = 'ritual_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_5", reqs = []}],
		options = [ {
			code = 'ritual_6_1', text = "RITUAL_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ritual_6_2', text = "RITUAL_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_6_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		common_effects = [{code = 'decision', value = 'letFuck'}],
		text = [{text = "RITUAL_6_1", reqs = []}],
		options = [ {
			code = 'after_ritual_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_6_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_6_2", reqs = []}],
		options = [ {
			code = 'after_ritual_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_start = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "savra", character2 = "leon",
		text = [{text = "AFTER_RITUAL_START", reqs = [], previous_dialogue_option = 0},
		{text = "AFTER_RITUAL_1_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'after_ritual_start_1', text = "AFTER_RITUAL_START_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'after_ritual_1_2', text = "AFTER_RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_start_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra", character2 = "leon",
		text = [{text = "AFTER_RITUAL_START", reqs = [], previous_dialogue_option = 0},
		{text = "AFTER_RITUAL_1_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'after_ritual_1_2', text = "AFTER_RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra", character2 = "leon",
		text = [{text = "AFTER_RITUAL_1_2", reqs = []}],
		options = [ {
			code = 'after_ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	after_ritual_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_2", reqs = []}],
		options = [ {
			code = 'after_ritual_3', text = "AFTER_RITUAL_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = 0}]
		}, {
			code = 'after_ritual_3', text = "AFTER_RITUAL_2_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = 0}]
		}, ]
	},
	
	after_ritual_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_3", reqs = []}],
		options = [ {
			code = 'after_ritual_4', text = "AFTER_RITUAL_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_4', text = "AFTER_RITUAL_3_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_4', text = "AFTER_RITUAL_3_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
		}, ]
	},
	
	after_ritual_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_4", reqs = []}],
		options = [ {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
		}, ]
	},
	
	after_ritual_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_RITUAL_5_2AND3", reqs = [], previous_dialogue_option = [2,3]},
		{text = "AFTER_RITUAL_5_4", reqs = [], previous_dialogue_option = 4},],
		options = [ {
			code = 'after_ritual_variant', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		},  ]
	},
	
	after_ritual_variant = {
		variations = [ { # BAD GROUP
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = "decision", value = "letFuck", check = true}], character = "mae", 
			text = [{text = "AFTER_RITUAL_GROUP_1", reqs = []}],
			common_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '-'},
			{code = 'dialogue_counter', name = 'mae_sympathy', op = '-'}],
			options = [ {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
			}, ]
		}, { # BAD POWDER
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = "decision", value = "putPowder", check = false}], character = "mae", 
			text = [{text = "AFTER_RITUAL_POWDER_1", reqs = []}],
			common_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '-'}],
			options = [ {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
				bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
			}, {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [], character = "mae", 
			text = [{text = "AFTER_RITUAL_6", reqs = []}],
			options = [ {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
				bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
			}, {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			}, {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		} ]
	},
	
	after_ritual_group_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_GROUP_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_RITUAL_GROUP_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "AFTER_RITUAL_GROUP_2_3", reqs = [], previous_dialogue_option = 3},
		{text = "AFTER_RITUAL_GROUP_2_4", reqs = [], previous_dialogue_option = 4},],
		options = [ {
			code = 'after_ritual_group_3', text = "AFTER_RITUAL_GROUP_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  {
			code = 'after_ritual_group_3', text = "AFTER_RITUAL_GROUP_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_group_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_GROUP_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_RITUAL_GROUP_3_2", reqs = [], previous_dialogue_option = 2},],
		common_effects = [{code = 'remove_decision', value = 'letFuck'}],
		options = [ {
			code = 'after_ritual_variant', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	after_ritual_powder_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_POWDER_2_1AND2AND4", reqs = [], previous_dialogue_option = [1,2,4]},
		{text = "AFTER_RITUAL_POWDER_2_3", reqs = [], previous_dialogue_option = 3}],
		common_effects = [{code = 'decision', value = 'putPowder'}],
		options = [ {
			code = 'after_ritual_variant', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual = {
		variations = [ { # GOOD
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'local_counter', name = 'mae_sympathy', add_stat = 'charm_factor', operant = 'gte', value = 5, check = true}], character = "mae", 
			text = [{text = "AFTER_RITUAL_GOOD_1", reqs = []}],
			options = [ {
				code = 'after_ritual_good_2_1_1', text = "AFTER_RITUAL_GOOD_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_good_2_2', text = "AFTER_RITUAL_GOOD_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			} ]
		}, { # BAD
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'local_counter', name = 'mae_sympathy', add_stat = 'charm_factor', operant = 'lt', value = 5, check = true}], character = "mae", 
			text = [{text = "AFTER_RITUAL_BAD_1_1", reqs = [{type = "decision", value = "maePregnant", check = false}]},
			{text = "AFTER_RITUAL_BAD_1_2", reqs = [{type = "decision", value = "maePregnant", check = true}]}], 
			options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'add_timed_event', value = "canVisitLeon", 
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}, {code = 'update_city'}]
			} ]
		} ]
	}, 
	
	after_ritual_good_2_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = 'AFTER_RITUAL_GOOD_2_1_1', reqs = []}], 
		options = [ {
			code = 'after_ritual_good_2_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_good_2_1_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", character2 = "savra", 
		text = [{text = 'AFTER_RITUAL_GOOD_2_1_2', reqs = []}], 
		common_effects = [{code = 'make_story_character', value = 'Mae', recruit_from_location = true}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'update_city'},
			{code = 'add_timed_event', value = "canVisitLeon",
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
		}, ] 
	},
	
	after_ritual_good_2_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = 'AFTER_RITUAL_GOOD_2_2', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'add_timed_event', value = "canVisitLeon",
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
		}, ]
	},
	
	leon_visit_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_VISIT_START', reqs = []}], 
		options = [ {
			code = 'leon_visit_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	leon_visit_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "savra",
		text = [{text = 'LEON_VISIT_1_1', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage9'}, {code = 'update_city'}]
		}, ]
	},
	
	leon_visit_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_VISIT_1_2', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ask_around = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'ASK_AROUND', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage10'},
				{code = 'update_city'}, {code = 'make_quest_location', value = 'quest_leon_forest'}]
		}, ]
	},
	
	leon_fight_1 = {
		image = 'leon', tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_FIGHT_1', reqs = []}], 
		options = [ {
			code = 'leon_fight_2', text = "LEON_FIGHT_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'leon_fight_2', text = "LEON_FIGHT_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	leon_fight_2 = {
		image = 'leon', tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_FIGHT_2_1', reqs = [], previous_dialogue_option = 1},
		{text = 'LEON_FIGHT_2_2', reqs = [], previous_dialogue_option = 2}], 
		options = [ {
			code = 'quest_fight', args = 'leon',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	leon_fight_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "leon",
		text = [{text = 'LEON_FIGHT_3', reqs = []}], 
		options = [ {
			code = 'demon_priestess_1', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage11'},
			{code = 'remove_active_location'},]
		}, ]
	},
	
	savra_talk_start = { 
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage11', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_1', text = "SAVRA_TALK_OPTION_1", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage12', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_4', text = "SAVRA_TALK_OPTION_2", reqs = [{type = 'has_material', material = 'woodmagic', operant = 'gte', value = 50},
				{type = 'has_material', material = 'woodiron', operant = 'gte', value = 25},
				{type = 'has_material', material = 'leathermythic', operant = 'gte', value = 15},], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage13', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_5', text = "SAVRA_TALK_OPTION_3", select_person = true, reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, { # ask about white stag
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage15', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_white_stag', text = "SAVRA_STAG_QUESTION", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				bonus_effects = [{code = "update_city"}]
			} ]
		} ]
	},
	
	savra_talk_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_1', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_2_1', reqs = [], previous_dialogue_option = 1},], 
		options = [ {
			code = 'savra_talk_1', text = "SAVRA_TALK_1_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'savra_talk_2', text = "SAVRA_TALK_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	savra_talk_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_2_2', reqs = []}], 
		options = [ {
			code = 'savra_talk_3', text = "SAVRA_TALK_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  {
			code = 'savra_talk_3', text = "SAVRA_TALK_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'savra_talk_3', text = "SAVRA_TALK_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	savra_talk_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_3', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage12'}, {code = "update_city"}]
		}, ]
	},
	
	savra_talk_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_4', reqs = []}], 
		common_effects = [{code = 'material_change', operant = '-', material = 'woodmagic', value = 50},
		{code = 'material_change', operant = '-', material = 'woodiron', value = 25},
		{code = 'material_change', operant = '-', material = 'leathermythic', value = 15}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage13'}, {code = "update_city"}]
		},  ]
	}, 
	
	savra_talk_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_5', reqs = []}], 
		options = [ {
			code = 'savra_talk_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		},  ]
	},
	
	savra_talk_6 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate', 'blackscreen_transition_common'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_6', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'SAVRA_TALK_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'savra_talk_6_1', text = "SAVRA_TALK_6_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'savra_talk_6_2', text = "SAVRA_TALK_6_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		},  {
			code = 'close', text = "SAVRA_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage14'},
			{code = 'make_quest_location', value = 'quest_leon_forest_2'},
			{code = "update_city"}]
		} ] 
	},
	
	savra_talk_6_1 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_6', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'SAVRA_TALK_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'savra_talk_6_1', text = "SAVRA_TALK_6_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		},  {
			code = 'close', text = "SAVRA_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage14'},
			{code = 'make_quest_location', value = 'quest_leon_forest_2'},
			{code = "update_city"}]
		} ]
	},
	
	savra_talk_6_2 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_6', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'SAVRA_TALK_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'savra_talk_6_2', text = "SAVRA_TALK_6_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'close', text = "SAVRA_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage14'},
			{code = "update_city"}, {code = 'make_quest_location', value = 'quest_leon_forest_2'}, ]
		} ]
	},
	
	savra_talk_white_stag = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_STAG_ANSWER', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = "update_city"}]
		}, ]
	},
	
}
