var data = {
	zephyra_painting_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "ZEPHYRA_PAINTING_1", reqs = []}],
		options = [ {
			code = 'zephyra_painting_2', text = "ZEPHYRA_PAINTING_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_painting_2', text = "ZEPHYRA_PAINTING_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_painting_2', text = "ZEPHYRA_PAINTING_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_painting_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "zephyra",
		reqs = [],
		text = [{text = "ZEPHYRA_PAINTING_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_PAINTING_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_PAINTING_2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'zephyra_painting_3', text = "ZEPHYRA_PAINTING_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_painting_3', text = "ZEPHYRA_PAINTING_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_painting_3', text = "ZEPHYRA_PAINTING_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		},{
			code = 'zephyra_painting_3', text = "ZEPHYRA_PAINTING_2_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_painting_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "zephyra",
		reqs = [],
		text = [{text = "ZEPHYRA_PAINTING_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_PAINTING_3_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_PAINTING_3_3", reqs = [], previous_dialogue_option = 3},
		{text = "ZEPHYRA_PAINTING_3_4", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'zephyra_painting_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_painting_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "zephyra",
		reqs = [],
		text = [{text = "ZEPHYRA_PAINTING_4", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_PAINTING_5_1", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'zephyra_painting_4', text = "ZEPHYRA_PAINTING_4_OPTION_1", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, {
			code = 'zephyra_painting_5', text = "ZEPHYRA_PAINTING_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_painting_5', text = "ZEPHYRA_PAINTING_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_painting_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "zephyra",
		reqs = [],
		text = [{text = "ZEPHYRA_PAINTING_5_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_PAINTING_5_3", reqs = [], previous_dialogue_option = 3}],
		common_effects = [{code = 'affect_unique_character', name = 'zephyra', type = 'set_availability', value = false}, {code = 'add_timed_event', value = "zephyra_disappearance_1",
		args = [{type = 'add_to_date', date = [1,1], hour = 1}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'zephyra_disappearance_quest', stage = 'stage1'}]
		}, ]
	},
	
	zephyra_disappearance_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_2", reqs = []}],
		options = [ {
			code = 'zephyra_disappearance_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_3 = { # root
		image = 'forest_hut', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_3", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_4_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_2_1", reqs = [], previous_dialogue_option = 3},
		{text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_2_2", reqs = [], previous_dialogue_option = 4},
		{text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_2_3", reqs = [], previous_dialogue_option = 5},],
		options = [ {
			code = 'zephyra_disappearance_4', text = "ZEPHYRA_DISAPPEARANCE_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_3', text = "ZEPHYRA_DISAPPEARANCE_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_wakeup_1', text = "ZEPHYRA_DISAPPEARANCE_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_4_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'zephyra_disappearance_hut_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_wakeup_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_1", reqs = []},],
		options = [ {
			code = 'zephyra_disappearance_3', text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_1", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_3', text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_2", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_3', text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_3", reqs = [], dialogue_argument = 5, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_3', text = "ZEPHYRA_DISAPPEARANCE_WAKEUP_1_OPTION_4", reqs = [], dialogue_argument = 6, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_hut_1 = {
		image = 'interiour_hut', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_HUT_1", reqs = []},],
		options = [ {
			code = 'zephyra_disappearance_kitchen_1', text = "ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_1", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_2", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_bed_1_1', text = "ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', remove_after_first_use = true
		}, {
			code = 'zephyra_disappearance_bed_1_2', text = "ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_3", reqs = [{type = 'dialogue_selected', check = true, value = 'ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_3'}], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_bed_2', text = "ZEPHYRA_DISAPPEARANCE_HUT_1_OPTION_4", reqs = [{type = 'local_counter', name = 'trigger4', operant = 'gte', value = 1, check = true}], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bed_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BED_1_1", reqs = [], bonus_effects = [{code = 'dialogue_counter', name = 'trigger1', op = '+'}]},],
		options = [ {
			code = 'zephyra_disappearance_hut_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bed_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BED_1_2", reqs = []}],
		options = [ {
			code = 'zephyra_disappearance_hut_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bed_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BED_2", reqs = [], bonus_effects = [{code = 'dialogue_counter', name = 'trigger5', op = '+'}]},],
		options = [ {
			code = 'zephyra_disappearance_hut_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_kitchen_knife = {
		image = 'hut_knife', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KNIFE", reqs = [], bonus_effects = [{code = 'dialogue_counter', name = 'trigger3', op = '+'}]},
		],
		options = [ {
			code = 'zephyra_disappearance_kitchen_1', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_kitchen_1', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true # first time
		}, {
			code = 'zephyra_disappearance_kitchen_2_2', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2", reqs = [{type = 'dialogue_selected', check = true, value = 'ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2'}, {type = 'local_counter', name = 'trigger1', operant = 'gte', value = 1, check = true}], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true # second time
		}, {
			code = 'zephyra_disappearance_hut_1', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_4", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_kitchen_1 = {
		image = 'kitchen_hut', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1", reqs = [], previous_dialogue_option = 9},
		{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_1", reqs = [], previous_dialogue_option = 2}, #first time
		],
		options = [ {
			code = 'zephyra_disappearance_kitchen_1', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_kitchen_1', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true # first time
		}, {
			code = 'zephyra_disappearance_kitchen_2_2', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2_2", reqs = [{type = 'dialogue_selected', check = true, value = 'ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_2'}, {type = 'local_counter', name = 'trigger1', operant = 'gte', value = 1, check = true}], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true # second time
		},{
			code = 'zephyra_disappearance_kitchen_knife', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_3", reqs = [{type = 'local_counter', name = 'trigger2', operant = 'gte', value = 1, check = true}], dialogue_argument = 3, type = 'next_dialogue', remove_after_first_use = true # (needs trigger 2)
		}, {
			code = 'zephyra_disappearance_hut_1', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_1_OPTION_4", reqs = [], dialogue_argument = 9, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_kitchen_2_2 = { # window 2 times
		image = 'hut_window', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_2", reqs = [], previous_dialogue_option = 3},
		{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_3_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [ {
			code = 'zephyra_disappearance_kitchen_2_2', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', remove_after_first_use = true
		}, {
			code = 'zephyra_disappearance_kitchen_2_2', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true
		}, {
			code = 'zephyra_disappearance_kitchen_3', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_3", reqs = [{type = 'dialogue_selected', check = true, value = 'ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_1'}, {type = 'dialogue_selected', check = true, value = 'ZEPHYRA_DISAPPEARANCE_KITCHEN_2_2_OPTION_2'}], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_kitchen_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_3_3", reqs = [], previous_dialogue_option = 3},
		{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_4_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'zephyra_disappearance_kitchen_3', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', remove_after_first_use = true
		}, {
			code = 'zephyra_disappearance_kitchen_4', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', # adds trigger 2
		}, {
			code = 'zephyra_disappearance_kitchen_4', text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', # adds trigger 2
		}, ]
	},
	
	zephyra_disappearance_kitchen_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_4_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_DISAPPEARANCE_KITCHEN_4_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'zephyra_disappearance_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'trigger2', op = '+'}]
		}, ]
	},
	
	zephyra_disappearance_boy_1 = {
		image = 'interiour_hut_boy', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_1", reqs = [], previous_dialogue_option = 9},
		{text = "ZEPHYRA_DISAPPEARANCE_BOY_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_BOY_3_2", reqs = [], previous_dialogue_option = 23},
		{text = "ZEPHYRA_DISAPPEARANCE_BOY_3_3", reqs = [], previous_dialogue_option = 3, bonus_effects = [{code = 'dialogue_counter', name = 'trigger4', op = '+'}]}, # adds trigger 4
		],
		options = [ {
			code = 'zephyra_disappearance_boy_1_ask', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_4', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_OPTION_2", reqs = [{type = 'local_counter', name = 'trigger3', operant = 'gte', value = 1, check = true}], dialogue_argument = 2, type = 'next_dialogue', # needs trigger 3 
		}, {
			code = 'zephyra_disappearance_hut_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_boy_1_ask = {
		image = 'interiour_hut_boy', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "", reqs = []}],
		options = [ {
			code = 'zephyra_disappearance_boy_2', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_2', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_3", reqs = [], dialogue_argument = 23, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_1_ASK_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_boy_2 = {
		image = 'interiour_hut_boy', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_2_1AND2", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_2", reqs = [], dialogue_argument = 23, type = 'next_dialogue',
		}, {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'trigger4', op = '+'}] # adds trigger 4
		}, {
			code = 'zephyra_disappearance_boy_1', text = "ZEPHYRA_DISAPPEARANCE_BOY_2_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_boy_4 = {
		image = 'interiour_hut_boy', tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_4", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_boy_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_boy_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_5", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_boy_6', text = "ZEPHYRA_DISAPPEARANCE_BOY_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_6', text = "ZEPHYRA_DISAPPEARANCE_BOY_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_attack', text = "ZEPHYRA_DISAPPEARANCE_BOY_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_boy_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_6", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_boy_7', text = "ZEPHYRA_DISAPPEARANCE_BOY_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_7', text = "ZEPHYRA_DISAPPEARANCE_BOY_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_boy_attack', text = "ZEPHYRA_DISAPPEARANCE_BOY_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_boy_7 = { # add 3 day event
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_7_1AND2", reqs = []},
		], 
		common_effects = [{code = 'add_timed_event', value = "zephyra_disappearance_ketch_1",
		args = [{type = 'add_to_date', date = [3,3], hour = 1}]}],
		options = [ {
			code = 'zephyra_disappearance_boy_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_boy_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [], character = 'duncan',
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_8", reqs = [], previous_dialogue_option = 1},
		],
		options = [ {
			code = 'zephyra_disappearance_boy_9', text = "ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', remove_after_first_use = true,
		}, {
			code = 'zephyra_disappearance_boy_9', text = "ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true,
		}, {
			code = 'close', text = "ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = [{code = 'progress_quest', value = 'zephyra_disappearance_quest', stage = 'stage2'}]
		}, ]
	},
	
	zephyra_disappearance_boy_9 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'duncan',
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_9_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_BOY_9_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [ {
			code = 'zephyra_disappearance_boy_9', text = "ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', remove_after_first_use = true,
		}, {
			code = 'zephyra_disappearance_boy_9', text = "ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true,
		}, {
			code = 'close', text = "ZEPHYRA_DISAPPEARANCE_BOY_8_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = [{code = 'progress_quest', value = 'zephyra_disappearance_quest', stage = 'stage2'}]
		}, ]
	},
	
	zephyra_disappearance_boy_attack = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOY_ATTACK", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'zephyra_disappearance_quest'},
			{code = 'unique_character_changes', value = 'zephyra', args = [{code = 'remove_character'}]}] 
		}, ]
	},
	
	zephyra_disappearance_bowl_1 = {
		image = null, tags = ['dialogue_scene'], custom_background = "church_event", 
		reqs = [], character = "ginny",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOWL_1", reqs = [], previous_dialogue_option = 0},{text = "ZEPHYRA_DISAPPEARANCE_BOWL_2_1", reqs = [], previous_dialogue_option = 1},
		],
		options = [ {
			code = 'zephyra_disappearance_bowl_1', text = "ZEPHYRA_DISAPPEARANCE_BOWL_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', remove_after_first_use = true,
		}, {
			code = 'zephyra_disappearance_bowl_2', text = "ZEPHYRA_DISAPPEARANCE_BOWL_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bowl_2 = {
		image = null, tags = ['dialogue_scene'], custom_background = "church_event", 
		reqs = [], character = "ginny",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOWL_2_2", reqs = []}],
		options = [ {
			code = 'zephyra_disappearance_bowl_3_1', text = "ZEPHYRA_DISAPPEARANCE_BOWL_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_bowl_3_2', text = "ZEPHYRA_DISAPPEARANCE_BOWL_2_OPTION_2", reqs = [{type = "has_money", value = 1000}], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bowl_3_1 = {
		image = null, tags = ['dialogue_scene'], custom_background = "church_event", 
		reqs = [], character = "ginny",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOWL_3_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bowl_3_2 = {
		image = null, tags = ['dialogue_scene'], custom_background = "church_event", 
		reqs = [], character = "ginny",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOWL_3_2", reqs = []}],
		common_effects = [{code = 'money_change', operant = '-', value = 1000},
		{code = 'decision', value = 'GotZephyrasBowl'}],
		options = [ {
			code = 'zephyra_disappearance_bowl_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_bowl_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], custom_background = "church_event", 
		reqs = [], character = "ginny", # change stage of quest
		text = [{text = "ZEPHYRA_DISAPPEARANCE_BOWL_4", reqs = []}],
		options = [ {
			code = 'close', text = "ZEPHYRA_DISAPPEARANCE_BOWL_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'close', text = "ZEPHYRA_DISAPPEARANCE_BOWL_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_ketch_1 = {
		image = 'letter', tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_1", reqs = []},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 11, type = 'next_dialogue', bonus_effects = [{code = 'progress_quest', value = 'zephyra_disappearance_quest', stage = 'stage2'}]
		}, ]
	},
	
	zephyra_disappearance_ketch_2 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_2", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_3', text = "ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_1", reqs = [{type = 'decision', value = 'GotZephyrasBowl', check = true}], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_3', text = "ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_3_f_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_ketch_3_f_1 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_3_3", reqs = []},
		],
		options = [ {
			code = 'quest_fight', args = 'ketch_group', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',  
		}, ]
	},
	
	zephyra_disappearance_ketch_3_f_2 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_3_END", reqs = []},
		],
		options = [ { # rem zephyra 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'zephyra_disappearance_quest'},
			{code = 'unique_character_changes', value = 'zephyra', args = [{code = 'remove_character'}]}] 
		}, ]
	},
	
	zephyra_disappearance_ketch_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_3_1AND2", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',  
		}, ]
	},
	
	zephyra_disappearance_ketch_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_4", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_5', text = "ZEPHYRA_DISAPPEARANCE_KETCH_4_OPTION_1", reqs = [{type = 'decision', value = 'GotZephyrasBowl', check = true}], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_5', text = "ZEPHYRA_DISAPPEARANCE_KETCH_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_5', text = "ZEPHYRA_DISAPPEARANCE_KETCH_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_ketch_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_KETCH_5_2AND3", reqs = [], previous_dialogue_option = [2,3]}
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_6a', text = "ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_1", reqs = [{type = 'local_counter', name = 'trigger2', operant = 'gte', value = 1, check = true}, {type = 'dialogue_selected', check = true, value = 'ZEPHYRA_DISAPPEARANCE_KETCH_2_OPTION_2'}], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_6', text = "ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_1", reqs = [{type = 'local_counter', name = 'trigger2', operant = 'gte', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_6', text = "ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_6', text = "ZEPHYRA_DISAPPEARANCE_KETCH_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_disappearance_ketch_6a = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_1a", reqs = []},
		],
		options = [ { 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'zephyra_disappearance_quest'},
			{code = 'unique_character_changes', value = 'zephyra', args = [{code = 'remove_character'}]}]  
		}, ]
	},
	
	zephyra_disappearance_ketch_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_1b", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_2", reqs = [], previous_dialogue_option = 2},
		{text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_7_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'zephyra_disappearance_ketch_7_2', text = "ZEPHYRA_DISAPPEARANCE_KETCH_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_ketch_7_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_7_1", reqs = []}
		],
		options = [ {
			code = 'zephyra_disappearance_sex_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			#change_dialogue_type = 2,
		}, {
			code = 'zephyra_disappearance_ketch_9_2', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_1 = { # comply
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_1", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_2", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_3", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_4", reqs = []}
		], 
		options = [ { 
			code = 'zephyra_disappearance_sex_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_sex_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_SEX_5", reqs = []}
		], 
		options = [ { 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'zephyra_disappearance_quest'},
			{code = 'affect_unique_character', name = 'zephyra', type = 'set_availability', value = true}] 
		}, ]
	},
	
	zephyra_disappearance_ketch_9_2 = { # refuse
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_9_2", reqs = []}],
		options = [ { 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'zephyra_disappearance_quest'},
			{code = 'affect_unique_character', name = 'zephyra', type = 'set_availability', value = true}] 
		}, ]
	},
	
	zephyra_disappearance_ketch_7_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_7_2", reqs = []}
		],
		options = [ { # flashback
			code = 'zephyra_disappearance_ketch_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	zephyra_disappearance_ketch_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [],
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_8", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_sex_1', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			#change_dialogue_type = 2,
		}, {
			code = 'zephyra_disappearance_ketch_9_2', text = "ZEPHYRA_DISAPPEARANCE_KETCH_8_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'demon_female', #character2 = "ketch",
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_10", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_11", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_12', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_12", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_1", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_2", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_3", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_4", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_guards_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_guards_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_GUARDS_5", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_13', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	zephyra_disappearance_ketch_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "ZEPHYRA_DISAPPEARANCE_KETCH_13", reqs = []},
		],
		options = [ {
			code = 'zephyra_disappearance_ketch_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},]
	},
}
