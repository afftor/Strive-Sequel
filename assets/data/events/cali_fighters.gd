var data = {
	cali_sidequest_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [{type = 'unique_character_checks', name = 'cali', value = [{code = 'stat', stat = 'loyalty_total', operant = 'gte', value = 40}], negative = 'repeat_next_day'}], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_1", reqs = []} ], 
		options = [ {
			code = 'cali_sidequest_2', text = "CALI_SIDEQUEST_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sidequest_2', text = "CALI_SIDEQUEST_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_sidequest_2', text = "CALI_SIDEQUEST_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},
	
	cali_sidequest_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_1_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_SIDEQUEST_1_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_SIDEQUEST_1_3", reqs = [], previous_dialogue_option = 3}, 
			{text = "CALI_SIDEQUEST_1_ADDITIONAL", reqs = []}, ], 
		options = [ {
			code = 'cali_sidequest_3', text = "CALI_SIDEQUEST_2_OPTION_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'cali_sidequest_2_1', text = "CALI_SIDEQUEST_2_OPTION_2", reqs = [], dialogue_argument = 2,
		}, {
			code = 'cali_sidequest_2_1', text = "CALI_SIDEQUEST_2_OPTION_3", reqs = [], dialogue_argument = 3,
		}, {
			code = 'cali_sidequest_2_1', text = "CALI_SIDEQUEST_2_OPTION_4", reqs = [], dialogue_argument = 4,
		}, ],
	}, 
	
	cali_sidequest_2_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_SIDEQUEST_2_3", reqs = [], previous_dialogue_option = 3}, 
			{text = "CALI_SIDEQUEST_2_4", reqs = [], previous_dialogue_option = 4}, ], 
		options = [ {
			code = 'cali_sidequest_3', text = "CALI_SIDEQUEST_2_OPTION_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'cali_sidequest_2_1', text = "CALI_SIDEQUEST_2_OPTION_2", reqs = [], dialogue_argument = 2,
		}, {
			code = 'cali_sidequest_2_1', text = "CALI_SIDEQUEST_2_OPTION_3", reqs = [], dialogue_argument = 3,
		}, {
			code = 'cali_sidequest_2_1', text = "CALI_SIDEQUEST_2_OPTION_4", reqs = [], dialogue_argument = 4,
		},],
	},
	
	cali_sidequest_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_SIDEQUEST_3_1", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_fighters_quest', stage = 'stage1'}]
		}, ],
	}, 
	
	cali_fighters_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_FIGHTERS_1", reqs = []} ],
		options = [ {
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', master_translate = true
		}, { # Female Halfkin
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2F", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}, {code = 'stat', stat = 'race', operant = 'eq', value = "HalfkinWolf"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Female Beastkin
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2M", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}, {code = 'stat', stat = 'race', operant = 'eq', value = "BeastkinWolf"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Female Human
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2M", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}, {code = 'stat', stat = 'race', operant = 'eq', value = "Human"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Male Halfkin
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2F", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'male'}, {code = 'stat', stat = 'race', operant = 'eq', value = "HalfkinWolf"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Male Beastkin
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2F", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'male'}, {code = 'stat', stat = 'race', operant = 'eq', value = "BeastkinWolf"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Male Human
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2F", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'male'}, {code = 'stat', stat = 'race', operant = 'eq', value = "Human"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Not human or wolf Female
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2SM", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}, {code = 'stat', stat = 'race', operant = 'neq', value = "Human"}, {code = 'stat', stat = 'race', operant = 'neq', value = "HalfkinWolf"}, {code = 'stat', stat = 'race', operant = 'neq', value = "BeastkinWolf"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, { # Not human or wolf Male
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_2SF", reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'male'}, {code = 'stat', stat = 'race', operant = 'neq', value = "Human"}, {code = 'stat', stat = 'race', operant = 'neq', value = "HalfkinWolf"}, {code = 'stat', stat = 'race', operant = 'neq', value = "BeastkinWolf"}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_fighters_2', text = "CALI_FIGHTERS_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_fighters_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_FIGHTERS_2_1AND3", reqs = [], previous_dialogue_option = [1,3]},
		{text = "CALI_FIGHTERS_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "CALI_FIGHTERS_2_ADDITIONAL", reqs = []} ],
		options = [ {
			code = 'cali_fighters_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_fighters_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_FIGHTERS_3", reqs = []} ],
		options = [ {
			code = 'cali_fighters_4', text = "CALI_FIGHTERS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_fighters_4', text = "CALI_FIGHTERS_3_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_fighters_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_FIGHTERS_4", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_fighters_quest', stage = 'stage2'},
			{code = 'make_quest_location', value = 'quest_cali_goblins_location'}, {code = 'update_guild'}]
		}, ],
	}, 
	
	cali_goblins_1 = {
		variations = [ { # NO CALI
			image = null, tags = ['dialogue_scene'],
			reqs = [{type = "location_has_specific_slaves", check = false, value = 1, location = 'quest_cali_goblins_location', reqs = [
					{code = 'unique', value = 'cali'}]}], 
			text = [{text = 'CALI_GOBLINS_NO_CALI', reqs = []}], 
			options = [ {
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [{type = "location_has_specific_slaves", check = true, value = 1, location = 'quest_cali_goblins_location', reqs = [
					{code = 'unique', value = 'cali'}]}], character = "cali",
			text = [ {text = "CALI_GOBLINS_1", reqs = []} ],
			options = [ {
				code = 'quest_fight', args = 'cali_goblins_first',
				text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, ],
		},
		]
	},
	
	cali_goblins_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_GOBLINS_2", reqs = []} ],
		options = [ {
			code = 'cali_goblins_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_goblins_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_GOBLINS_3", reqs = []} ],
		options = [ {
			code = 'cali_goblins_4', text = "CALI_GOBLINS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_goblins_4', text = "CALI_GOBLINS_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_goblins_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_GOBLINS_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_GOBLINS_4_2", reqs = [], bonus_effects = [], previous_dialogue_option = 2}, ], # TODO apply 12 turn injury to cali
		options = [ {
			code = 'quest_fight', args = 'cali_goblins_second',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	}, 
	
	cali_goblins_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_GOBLINS_5", reqs = []} ],
		options = [ {
			code = 'cali_goblins_6', text = "CALI_GOBLINS_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_goblins_6', text = "CALI_GOBLINS_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_goblins_6', text = "CALI_GOBLINS_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_goblins_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_GOBLINS_6_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_GOBLINS_6_2AND3", reqs = [], previous_dialogue_option = [2,3]} ],
		options = [ {
			code = 'cali_goblins_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_goblins_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "cali",
		text = [ {text = "CALI_GOBLINS_7", reqs = []} ],
		options = [ {
			code = 'cali_goblins_8', text = "CALI_GOBLINS_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_goblins_8', text = "CALI_GOBLINS_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_goblins_8', text = "CALI_GOBLINS_7_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	}, 
	
	cali_goblins_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "cali",
		text = [ {text = "CALI_GOBLINS_8_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_GOBLINS_8_2", reqs = [], previous_dialogue_option = 2}, 
		{text = "CALI_GOBLINS_8_3", reqs = [], previous_dialogue_option = 3},
		{text = "CALI_GOBLINS_8_ADDITIONAL", reqs = []},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [ {code = 'complete_quest', value = 'cali_fighters_quest'},
			{code = 'add_timed_event', value = "cali_sex_1_1", args = [{type = 'add_to_date', date = [1,1], hour = 3}]},
			{code = 'remove_active_location'}, ]
		}, ],
	},
	
	cali_sex_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_SEX_1_1", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_1",
		options = [ {
			code = 'cali_sex_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_SEX_1_2", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_2",
		options = [ {
			code = 'cali_sex_2', text = "CALI_SEX_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sex_2', text = "CALI_SEX_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_sex_2_3', text = "CALI_SEX_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_2_1AND2", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_sex_3_1', text = "CALI_SEX_2_1AND2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sex_3_1', text = "CALI_SEX_2_1AND2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},  ],
	},
	
	cali_sex_3_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_3_1", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_sex_3_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_3_2", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_4",
		options = [ {
			code = 'cali_sex_4', text = "CALI_SEX_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sex_4', text = "CALI_SEX_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},  ],
	},
	
	cali_sex_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],character = "cali",
		text = [ {text = "CALI_SEX_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_SEX_4_2", reqs = [], previous_dialogue_option = 2}, 
		{text = "CALI_SEX_4_ADDITIONAL", reqs = []},],
		dialogue_type = 1,
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_2_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_SEX_2_3", reqs = []} ],
		dialogue_type = 1,
		options = [ {
			code = 'close', text = "CALI_SEX_2_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_sex_1_1", args = [{type = 'add_to_date', date = [3,3], hour = 3}]}]
		}, {
			code = 'close', text = "CALI_SEX_2_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},  ],
	},
}
