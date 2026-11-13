extends Reference
var data = {
	daisy_wedding_1 = {
		image = null, music = "daisy_theme", tags = ['dialogue_scene'],
		reqs = [], character = "daisy_wed", 
		text = [{text = "DAISY_WEDDING_1", reqs = []}],
		options = [ {
			code = 'daisy_wedding_2_2', text = "DAISY_WEDDING_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	}, 
	
	daisy_wedding_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "daisy_wed", 
		text = [{text = "DAISY_WEDDING_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		},  ]
	},
	
	
	amelia_wedding_1 = {
		image = null, music = "daisy_theme", tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "amelia_wed_body", 
		text = [{text = "AMELIA_WEDDING_1", reqs = []}],
		options = [ {
			code = 'amelia_wedding_2_2', text = "AMELIA_WEDDING_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	}, 
	
	amelia_wedding_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "amelia_wed_body", 
		text = [{text = "AMELIA_WEDDING_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		}, ],
	},
	
	
	cali_wedding_1 = {
		variations = [ { # GOOD ROUTE
			reqs = [{type = 'decision', value = 'cali_raped', check = false}], 
			image = null,
			music = "cali_theme", tags = ['dialogue_scene'],
			character = "cali_wed", 
			text = [{text = "CALI_WEDDING_GOOD_1", reqs = []}],
			options = [ {
				code = 'cali_wedding_2_2', text = "CALI_WEDDING_GOOD_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			}, ]
		}, { # BAD ROUTE
			reqs = [], 
			music = "cali_theme",
			image = null, tags = ['dialogue_scene'],
			character = "cali_wed", 
			text = [{text = "CALI_WEDDING_BAD_1", reqs = []}],
			options = [ {
				code = 'cali_wedding_2_2', text = "CALI_WEDDING_BAD_1_OPTION_2", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		}, 
	]},
	
	cali_wedding_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali_wed", 
		text = [{text = "CALI_WEDDING_GOOD_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "CALI_WEDDING_BAD_2_2", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		}, ],
	},
}
