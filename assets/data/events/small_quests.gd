var data = {
	amelia_silk_start = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_STARTUP", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'amelia_silk_quest', stage = 'stage1'}, {code = "update_guild"}]
		} ],
	},
	
	amelia_silk_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_START", reqs = [], }],
		common_effects = [{code = 'material_change', operant = '-', material = 'clothsilk', value = 50}],
		options = [ {
			code = 'amelia_silk_2', text = "AMELIA_SILK_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_silk_1_finish', text = "AMELIA_SILK_OPTION_1_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},
	
	amelia_silk_1_finish = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_2", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'amelia_silk_quest'}]
		} ],
	},
	
	amelia_silk_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_1", reqs = [], }],
		options = [ {
			code = 'amelia_silk_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_silk_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_2", reqs = [], }],
		options = [ {
			code = 'amelia_silk_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	amelia_silk_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_3", reqs = [], }],
		options = [ {
			code = 'amelia_silk_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},
	
	# amelia scene 1
	amelia_silk_5 = {
		custom_background = "amelia_titjob1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_SILK_REPLY_1_1_4", reqs = [], }],
		options = [ {
			code = 'amelia_silk_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	# amelia scene 2
	amelia_silk_6 = {
		custom_background = "amelia_titjob2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "AMELIA_SILK_REPLY_1_1_5", reqs = [], }],
		options = [ {
			code = 'amelia_silk_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	# amelia scene 3
	amelia_silk_7 = {
		custom_background = "amelia_titjob3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "AMELIA_SILK_REPLY_1_1_6", reqs = [], }],
		options = [ {
			code = 'amelia_silk_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ],
	},
	
	# normal scene
	amelia_silk_8 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_1_1_7", reqs = [], }],
		options = [ {
			code = 'amelia_silk_9', text = "AMELIA_SILK_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_silk_9', text = "AMELIA_SILK_OPTION_2_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'amelia_silk_9', text = "AMELIA_SILK_OPTION_2_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ],
	},
	
	amelia_silk_9 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_SILK_REPLY_2_1AND2", reqs = [], previous_dialogue_option = 1},
		{text = "AMELIA_SILK_REPLY_2_3", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, 
			bonus_effects = [{code = 'complete_quest', value = 'amelia_silk_quest'}]
		}, ],
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
			reqs = [{type = 'decision', value = 'PrincessDead', check = false}, 
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
}
