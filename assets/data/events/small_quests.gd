var data = {
	generic_lose_scene = {
		image = null, tags = [],
		text = [ {text = "LOSE_MESSAGE", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effect = [{code = "lose_game"}]
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
