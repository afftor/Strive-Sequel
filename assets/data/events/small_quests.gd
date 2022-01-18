var data = {
	generic_lose_scene = {
		image = null, tags = [],
		text = [ {text = "LOSE_MESSAGE", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "lose_game"}]
			}
		]
	},
	
	aire_recruiment_start = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [ {text = "AIRE_RECRUITMENT_REPLY_1", reqs = []} ],
		options = [ {
			code = 'aire_recruiment_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	aire_recruiment_1 = {
		variations = [ {
			reqs = [{type = 'decision', value = 'PrincessDead', check = true, orflag = true}, 
			{type = 'decision', value = 'aire_raped', check = true}], 
			
			image = null, tags = ['dialogue_scene'],  character = 'aire',
			text = [ {text = "AIRE_RECRUITMENT_REPLY_BAD_START", reqs = []} ],
			options = [ {
				code = 'aire_recruiment_bad', text = "AIRE_RECRUITMENT_OPTION_BAD_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			}, {
				code = 'aire_recruiment_bad', text = "AIRE_RECRUITMENT_OPTION_BAD_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			}, {
				code = 'aire_recruiment_bad', text = "AIRE_RECRUITMENT_OPTION_BAD_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			}, ], 
		},
		{
			reqs = [{type = 'decision', value = 'PrincessDead', check = false, orflag = true}, 
			{type = 'decision', value = 'aire_raped', check = false}], 
			
			image = null, tags = ['dialogue_scene'], character = 'aire',
			text = [ {text = "AIRE_RECRUITMENT_REPLY_GOOD_START", reqs = []} ],
			options = [ {
				code = 'aire_recruiment_good', text = "AIRE_RECRUITMENT_OPTION_GOOD_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			}, {
				code = 'aire_recruiment_good', text = "AIRE_RECRUITMENT_OPTION_GOOD_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			}, {
				code = 'aire_recruiment_good', text = "AIRE_RECRUITMENT_OPTION_GOOD_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			}, ], 
		}
		]
	},
	
	aire_recruiment_bad = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'aire',
		text = [{text = "AIRE_RECRUITMENT_REPLY_BAD_1", reqs = [], previous_dialogue_option = 1},
		{text = "AIRE_RECRUITMENT_REPLY_BAD_1_ANA", reqs = [{type = 'decision', value = 'anastasia_added', check = true}], previous_dialogue_option = 1},
		{text = "AIRE_RECRUITMENT_REPLY_BAD_2", reqs = [], previous_dialogue_option = 2},
		{text = "AIRE_RECRUITMENT_REPLY_BAD_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'make_story_character', value = 'Aire'}]
		}, ],
	},
	
	aire_recruiment_good = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'aire',
		text = [{text = "AIRE_RECRUITMENT_REPLY_GOOD_1", reqs = [], previous_dialogue_option = 1},
		{text = "AIRE_RECRUITMENT_REPLY_GOOD_2", reqs = [], previous_dialogue_option = 2},
		{text = "AIRE_RECRUITMENT_REPLY_GOOD_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'make_story_character', value = 'Aire'}]
		}, ],
	},
	
	jean_intro = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "JEAN_INTRO", reqs = []} ],
		options = [ {
			code = 'jean_intro_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	jean_intro_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'myr', character2 = 'jean',
		text = [ {text = "JEAN_INTRO_1", reqs = []} ],
		options = [ {
			code = 'jean_intro_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	jean_intro_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'myr', character2 = 'jean',
		text = [ {text = "JEAN_INTRO_2", reqs = []} ],
		options = [ {
			code = 'jean_intro_3', text = "JEAN_INTRO_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_intro_bad', text = "JEAN_INTRO_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},],
	},
	
	jean_intro_bad = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'myr', character2 = 'jean',
		text = [ {text = "JEAN_INTRO_BAD", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	jean_intro_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'myr', character2 = 'jean',
		text = [ {text = "JEAN_INTRO_3", reqs = []} ],
		options = [ {
			code = 'jean_intro_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	jean_intro_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = 'jean',
		common_effects = [{code = 'make_story_character', value = 'Jean', recruit_from_location = true}],
		text = [ {text = "JEAN_INTRO_4", reqs = []} ],
		options = [ {
			code = 'jean_intro_5', text = "JEAN_INTRO_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_intro_5', text = "JEAN_INTRO_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'jean_intro_5', text = "JEAN_INTRO_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		},],
	},
	
	jean_intro_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'jean',
		common_effects = [{code = 'make_story_character', value = 'Jean', recruit_from_location = true}],
		text = [ {text = "JEAN_INTRO_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "JEAN_INTRO_5_2", reqs = [], previous_dialogue_option = 2},
		{text = "JEAN_INTRO_5_3", reqs = [], previous_dialogue_option = 3, bonus_effects = [{
					code = 'unique_character_changes',
					value = 'jean',
					args = [
						{code = 'obedience', operant = "-", value = 24},
						{code = 'authority', operant = "-", value = 50},
					]
				}]}, ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	lilia_intro = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "LILIA_INTRO", reqs = []} ], character = 'lilia',
		options = [ {
			code = 'lilia_intro_2', master_translate = true, text = "LILIA_INTRO_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'lilia_intro_2', text = "LILIA_INTRO_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'lilia_intro_2', text = "LILIA_INTRO_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},
	
	lilia_intro_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "LILIA_INTRO_2", reqs = []} ], character = 'lilia',
		options = [ {
			code = 'lilia_intro_3', text = "LILIA_INTRO_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'lilia_intro_3', text = "LILIA_INTRO_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},
	
	lilia_intro_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "LILIA_INTRO_3_1", reqs = [], previous_dialogue_option = 1, bonus_effects = [{code = 'make_story_character', value = 'Lilia', recruit_from_location = true}]},
		 {text = "LILIA_INTRO_3_2", reqs = [], previous_dialogue_option = 2},], character = 'lilia',
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'update_location'}]
		},  ],
	},
	
	
	cali_intro = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_INTRO", reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_intro_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_INTRO_1", reqs = []} ], 
		options = [ {
			code = 'cila_intro_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_intro_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_INTRO_2", reqs = []} ], 
		options = [ {
			code = 'cali_intro_3', text = "CALI_INTRO_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_intro_3', text = "CALI_INTRO_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_intro_3', text = "CALI_INTRO_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, {
			code = 'cali_intro_fight', text = "CALI_INTRO_2_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		}, ],
	},
	
	cali_intro_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_INTRO_3_1", reqs = [], previous_dialogue_option = 1}, 
		 {text = "CALI_INTRO_3_2", reqs = [], previous_dialogue_option = 2},
		 {text = "CALI_INTRO_3_3", reqs = [], previous_dialogue_option = 3}, 
		 {text = "CALI_INTRO_4_1_1", reqs = [], previous_dialogue_option = 5},  # todo add charm check
		 {text = "CALI_INTRO_4_1_2", reqs = [], previous_dialogue_option = 5}, ], # todo add charm check  
		options = [ {
			code = 'lilia_intro_3', text = "CALI_INTRO_3_OPTION_1", reqs = [], dialogue_argument = 5,
				remove_after_first_use = true
		}, {
			code = 'close', text = "CALI_INTRO_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = '', text = "CALI_INTRO_3_OPTION_3", reqs = [{type = 'has_money', value = 1000},], # todo add charm check
			dialogue_argument = 3, type = 'next_dialogue',
		}, {
			code = '', text = "CALI_INTRO_3_OPTION_3", reqs = [{type = 'has_money', value = 750},], # todo add charm check
			dialogue_argument = 3, type = 'next_dialogue',
		}, {
			code = 'cali_intro_fight', text = "CALI_INTRO_3_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		}, ],
	},
	
	cali_intro_fight = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_INTRO_4_4", reqs = []}, ], 
		options = [ {
			code = 'quest_fight', args = 'slavers', # TODO CHANGE IT
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	
	got_cali_1_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "GOT_CALI_1_1", reqs = []}, ], 
		options = [ {
			code = 'got_cali_2_1', text = "GOT_CALI_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'got_cali_2_2', text = "GOT_CALI_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},
	
	got_cali_1_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "GOT_CALI_1_2", reqs = []}, ], 
		options = [ {
			code = 'got_cali_2_1', text = "GOT_CALI_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'got_cali_2_2', text = "GOT_CALI_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},
	
	got_cali_2_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "GOT_CALI_2_1", reqs = []}, ], 
		common_effects = [{code = 'make_story_character', value = 'Cali', recruit_from_location = true, slave_category = 'slave'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	got_cali_2_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "GOT_CALI_2_2", reqs = [], previous_dialogue_option = 2}, 
		{text = "GOT_CALI_3_1", reqs = [], previous_dialogue_option = 1}, ], 
		options = [ {
			code = 'got_cali_2_2', text = "CALI_INTRO_2_OPTION_1", reqs = [], dialogue_argument = 1, 
				remove_after_first_use = true
		}, {
			code = 'cali_intro_3', text = "CALI_INTRO_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_intro_3', text = "CALI_INTRO_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},
	
	got_cali_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "GOT_CALI_3_2", reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = 'make_story_character', value = 'Cali', recruit_from_location = true}]}, 
		{text = "GOT_CALI_3_3", reqs = [], previous_dialogue_option = 3}, ], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
}
