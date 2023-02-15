var data = {
	zephyra_quest_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", 
		text = [{text = "ZEPHYRA_QUEST_1", reqs = []}],
		options = [ {
			code = 'zephyra_quest_2', text = "ZEPHYRA_QUEST_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, { # TODO (Close, reset the interaction next day)
			code = 'close', text = "ZEPHYRA_QUEST_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", 
		text = [{text = "ZEPHYRA_QUEST_2", reqs = []}],
		options = [ {
			code = 'zephyra_quest_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_QUEST_3", reqs = []}],
		options = [ {
			code = 'zephyra_quest_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_QUEST_4", reqs = []}],
		options = [ {
			code = 'zephyra_quest_5', text = "ZEPHYRA_QUEST_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_5', text = "ZEPHYRA_QUEST_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_5 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_QUEST_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_QUEST_5_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_quest_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_6 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_QUEST_6", reqs = []}],
		options = [ {
			code = 'zephyra_quest_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_7 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_QUEST_7", reqs = []}],
		options = [ {
			code = 'zephyra_quest_8', text = "ZEPHYRA_QUEST_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_8', text = "ZEPHYRA_QUEST_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_8', text = "ZEPHYRA_QUEST_7_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_8 = { # TODO add loyalty in 2 cases
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_QUEST_8_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_QUEST_8_2_GOOD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'gte', value = 50}]}], previous_dialogue_option = 2}, 
		{text = "ZEPHYRA_QUEST_8_2_BAD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 50}]}], previous_dialogue_option = 2}, 
		{text = "ZEPHYRA_QUEST_8_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'zephyra_quest_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	
}
