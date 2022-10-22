var data = {
	cali_act1_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [{text = "CALI_ACT1_1", reqs = []}],
		options = [ {
			code = 'cali_act1_2_12', text = "CALI_ACT1_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act1_2_12', text = "CALI_ACT1_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act1_2_3', text = "CALI_ACT1_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act1_2_12 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		dialogue_type = 2,
		text = [
			{text = "CALI_ACT1_2_1", reqs = [], previous_dialogue_option = 1, 
				bonus_effects = [
					{code = "decision", value = "cali_gone"},
					{code = 'add_timed_event', value = "cali_act2_gone", args = [{type = 'add_to_date', date = [3,3], hour = 1}]}
				]},
			{text = "CALI_ACT1_2_2", reqs = [], previous_dialogue_option = 2,
				bonus_effects = [
					{code = 'add_timed_event', value = "cali_act2_1", args = [{type = 'add_to_date', date = [3,3], hour = 1}]}
				]}
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	cali_act1_2_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [{text = "CALI_ACT1_2_3", reqs = []}],
		options = [ {
			code = 'cali_act1_1_3', text = "CALI_ACT1_2_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act1_1_3', text = "CALI_ACT1_2_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act1_1_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [{text = "CALI_ACT1_3", reqs = []}],
		common_effects = [{code = "decision", value = "cali_gone"}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'add_timed_event', value = "cali_act2_gone", args = [{type = 'add_to_date', date = [3,3], hour = 1}]}
			]
		} ]
	},
	
	cali_act2_gone = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],  
		text = [{text = "CALI_ACT2_GONE", reqs = []}],
		common_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'remove_character'}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	cali_act2_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [{text = "CALI_ACT2_1", reqs = []}],
		options = [ {
			code = 'cali_act2_2_1or2', text = "CALI_ACT2_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_2_1or2', text = "CALI_ACT2_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_2_3', text = "CALI_ACT2_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act2_2_1or2 = { # TODO add - obedence
		image = null, tags = ['dialogue_scene'],
		reqs = [],  
		text = [
			{text = "CALI_ACT2_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_ACT2_2_2", reqs = [], previous_dialogue_option = 1}
		],
		common_effects = [],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	cali_act2_2_3 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [],  
		text = [{text = "CALI_ACT2_2_3", reqs = []}],
		options = [ {
			code = 'cali_act2_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	cali_act2_3 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [],  
		text = [{text = "CALI_ACT2_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_collar_quest', stage = 'stage1'}]
		} ]
	},
	
	cali_act2_workers_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'sigmund',
		text = [{text = "CALI_ACT2_WORKERS_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'cali_collar_quest', stage = 'stage2'},
				{code = "update_guild"}
			]
		} ]
	},
	
	cali_act2_workers_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_2", reqs = []}],
		options = [ {
			code = 'cali_act2_workers_3', text = "CALI_ACT2_WORKERS_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_workers_3', text = "CALI_ACT2_WORKERS_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act2_workers_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_3", reqs = []}],
		options = [ {
			code = 'cali_act2_2_1or2', text = "CALI_ACT2_WORKERS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_2_1or2', text = "CALI_ACT2_WORKERS_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_2_3', text = "CALI_ACT2_WORKERS_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
}
