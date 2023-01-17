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
	
	cali_act2_2_1or2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [
			{text = "CALI_ACT2_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_ACT2_2_2", reqs = [], previous_dialogue_option = 2}
		],
		common_effects = [],
		options = [ {
			code = 'cali_act2_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'obedience', operant = '-', value = 10},]},]
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
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage1'}]
		} ]
	},
	
	cali_act2_workers_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'sigmund',
		text = [{text = "CALI_ACT2_WORKERS_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage2'},
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
			code = 'cali_act2_workers_4_1', text = "CALI_ACT2_WORKERS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_workers_4_2', text = "CALI_ACT2_WORKERS_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_workers_4_3', text = "CALI_ACT2_WORKERS_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act2_limnrov = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_LIMNROV", reqs = []}],
		options = [ {
			code = 'cali_act2_workers_4_1', text = "CALI_ACT2_WORKERS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_workers_4_2', text = "CALI_ACT2_WORKERS_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act2_workers_4_3', text = "CALI_ACT2_WORKERS_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act2_workers_4_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_4_1", reqs = []}],
		options = [ {
			code = 'cali_act2_workers_5_1', text = "CALI_ACT2_WORKERS_4_1_OPTION_1", reqs = [{type = 'has_material', operant = 'gte', value = 10, material = 'leatherthick'}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act2_workers_3', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},  ]
	},
	
	cali_act2_workers_4_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_4_2", reqs = []}],
		options = [ {
			code = 'cali_act2_workers_5_2', text = "CALI_ACT2_WORKERS_4_2_OPTION_1", reqs = [{type = 'has_material', operant = 'gte', value = 10, material = 'leatherthick'}, {type = 'has_material', operant = 'gte', value = 10, material = 'clothsilk'}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act2_workers_3', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_workers_4_3 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_4_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage3'},
				{code = "update_guild"}
			]
		} ]
	},
	
	cali_act2_workers_5_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_5_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
					{code = 'material_change', operant = '-', material = 'leatherthick', value = 10},
					{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage4'},
					{code = 'add_timed_event', value = "cali_act2_workers_6_1", args = [{type = 'add_to_date', date = [3,3], hour = 1}]},
					{code = "update_guild"}
				]
		}, ]
	},
	
	cali_act2_workers_5_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_5_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
					{code = 'material_change', operant = '-', material = 'leatherthick', value = 10},
					{code = 'material_change', operant = '-', material = 'clothsilk', value = 10},
					{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage4'},
					{code = 'add_timed_event', value = "cali_act2_workers_6_2", args = [{type = 'add_to_date', date = [3,3], hour = 1}]},
					{code = "update_guild"}
				]
		}, ]
	},
	
	cali_act2_workers_6_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_6_1", reqs = []}],
		options = [ {
			code = 'cali_act2_simple_collar_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_workers_6_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT2_WORKERS_6_2", reqs = []}],
		options = [ {
			code = 'cali_act2_exquisite_collar_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_simple_collar_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "cali",
		text = [{text = "CALI_ACT2_SIMPLE_COLLAR_1", reqs = []}],
		common_effects = [{code = 'unique_character_changes', value = 'cali', args = [
			{code = 'body_image', operant = '=', value = "cali_collar_body"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/cali_collar_prt.png"}]}],
		options = [ {
			code = 'cali_act2_simple_collar_2_1', text = "CALI_ACT2_SIMPLE_COLLAR_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act2_simple_collar_2_2', text = "CALI_ACT2_SIMPLE_COLLAR_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_simple_collar_2_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT2_SIMPLE_COLLAR_2_1", reqs = []}],
		options = [ {
			code = 'cali_act2_simple_collar_3', text = "CALI_ACT2_SIMPLE_COLLAR_2_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act2_simple_collar_3', text = "CALI_ACT2_SIMPLE_COLLAR_2_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_simple_collar_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT2_SIMPLE_COLLAR_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
					{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage5'},
					{code = 'add_timed_event', value = "cali_act3_magic_1", args = [{type = 'add_to_date', date = [5,5], hour = 1}]},
					{code = "decision", value = "cali_normal_collar"},
					{code = 'unique_character_changes', value = 'cali', args = [{code = 'loyalty', operant = '+', value = 20},]},
					{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_collar", parts = {}}
						],
					},
				]
		}, ]
	},
	
	cali_act2_simple_collar_2_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT2_SIMPLE_COLLAR_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
					{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage5'},
					{code = 'add_timed_event', value = "cali_act3_magic_1", args = [{type = 'add_to_date', date = [5,5], hour = 1}]},
					{code = "decision", value = "cali_normal_collar"},
					{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_collar", parts = {}}
						],
					},
				]
		}, ]
	},
	
	cali_act2_exquisite_collar_1_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "cali",
		text = [{text = "CALI_ACT2_EXQUISITE_COLLAR_1_1", reqs = []}],
		options = [ {
			code = 'cali_act2_exquisite_collar_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_exquisite_collar_1_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "cali",
		text = [{text = "CALI_ACT2_EXQUISITE_COLLAR_1_2", reqs = []}],
		common_effects = [{code = 'unique_character_changes', value = 'cali', args = [
			{code = 'body_image', operant = '=', value = "cali_collar_body"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/cali_collar_prt.png"}]}],
		options = [ {
			code = 'cali_act2_exquisite_collar_2', text = "CALI_ACT2_EXQUISITE_COLLAR_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act2_exquisite_collar_2', text = "CALI_ACT2_EXQUISITE_COLLAR_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	cali_act2_exquisite_collar_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT2_EXQUISITE_COLLAR_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
					{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage5'},
					{code = 'add_timed_event', value = "cali_act3_magic_1", args = [{type = 'add_to_date', date = [5,5], hour = 1}]},
					{code = "decision", value = "cali_exquisite_collar"},
					{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_exquisite_collar", parts = {}}
						],
					},
				]
		}, ]
	},
	
	cali_act3_magic_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT3_MAGIC_1", reqs = []}],
		options = [ {
			code = 'cali_act3_magic_2_1AND2', text = "CALI_ACT3_MAGIC_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act3_magic_2_1AND2', text = "CALI_ACT3_MAGIC_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_act3_magic_2_3', text = "CALI_ACT3_MAGIC_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_magic_2_1AND2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT3_MAGIC_2_1AND2", reqs = []}],
		options = [ {
			code = 'cali_act3_magic_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_magic_2_3 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT3_MAGIC_2_3", reqs = []}],
		common_effects = [
			{code = 'add_timed_event', value = "cali_act3_magic_1", args = [{type = 'add_to_date', date = [7,7], hour = 1}]},
			{code = 'affect_unique_character', name = 'cali', type = 'set_availability', value = false},
			{code = 'add_timed_event', value = {name = 'cali', type = 'set_availability', value = true},
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "affect_unique_character"}]}
		], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'update_mansion'},
				{code = 'unique_character_changes', value = 'cali', args = [{code = 'obedience', operant = '+', value = 10},]},
			]
		}, ]
	},
	
	cali_act3_magic_3 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT3_MAGIC_3_1", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'dominator', check = false}]},]},
		{text = "CALI_ACT3_MAGIC_3_2", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'dominator', check = true}]},]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage6'}]
		},  ]
	},
	
	cali_act3_jean_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "jean",
		text = [{text = "CALI_ACT3_JEAN_1", reqs = []}],
		options = [ {
			code = 'cali_act3_jean_2', text = "CALI_ACT3_JEAN_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act3_jean_2', text = "CALI_ACT3_JEAN_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_jean_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "jean",
		text = [{text = "CALI_ACT3_JEAN_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_ACT3_JEAN_2_2", reqs = [], previous_dialogue_option = 2},],
		common_effects = [{code = 'make_quest_location', value = 'quest_dungeon_grove'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},  ]
	},
	
	cali_act3_jean_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "jean",
		text = [{text = "CALI_ACT3_JEAN_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage7'},
				{code = 'remove_quest_location', value = 'quest_dungeon_grove'},
			]
		},  ]
	},
	
	cali_act3_jean_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "jean",
		text = [{text = "CALI_ACT3_JEAN_4", reqs = []}],
		options = [ {
			code = 'cali_act3_jean_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},  ]
	},
	
	cali_act3_jean_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = "CALI_ACT3_JEAN_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage10'}],
		},  ]
	},
	
	cali_act3_mages_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT3_MAGES_1", reqs = []}],
		options = [ {
			code = 'cali_act3_mages_2', text = "CALI_ACT3_MAGES_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act3_mages_2', text = "CALI_ACT3_MAGES_1_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_mages_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT3_MAGES_2", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_ACT3_MAGES_3_2", reqs = [], previous_dialogue_option = 2},
		{text = "CALI_ACT3_MAGES_4", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'cali_act3_mages_3_1', text = "CALI_ACT3_MAGES_2_OPTION_1", reqs = [{type = 'has_money', value = 500}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act3_mages_2', text = "CALI_ACT3_MAGES_2_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'cali_act3_mages_3_3', text = "CALI_ACT3_MAGES_2_OPTION_3", reqs = [], dialogue_argument = 3, 
		}, ]
	},
	
	cali_act3_mages_3_3 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT3_MAGES_3_3", reqs = []}],
		options = [ {
			code = 'close', text = "CALI_ACT3_MAGES_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage8'},
			{code = "update_guild"}]
		}, ]
	},
	
	cali_act3_mages_3_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT3_MAGES_3_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage9'},
			{code = 'money_change', operant = '-', value = 500},
			{code = "update_guild"},
			{code = 'remove_quest_location', value = 'quest_dungeon_grove'},
			{code = 'add_timed_event', args = [{type = 'action_to_date', date = [2,2], hour = 1, action = 'quest'}], value = {quest = 'cali_taming_quest', stage = 'stage10'}}]
		}, ]
	},
	
	cali_act3_blow_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali",
		text = [{text = "CALI_ACT3_BLOW_1", reqs = []}],
		options = [ {
			code = 'cali_act3_blow_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_blow_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT3_BLOW_2", reqs = []}],
		options = [ {
			code = 'cali_act3_blow_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ]
	},
	
	cali_act3_blow_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_1",
		options = [ {
			code = 'cali_act3_blow_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_blow_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_1",
		options = [ {
			code = 'cali_act3_blow_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_blow_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_1",
		options = [ {
			code = 'cali_act3_blow_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_blow_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_6", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_2",
		options = [ {
			code = 'cali_act3_blow_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_blow_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_7", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_2",
		options = [ {
			code = 'cali_act3_blow_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act3_blow_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_8", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_3",
		options = [ {
			code = 'cali_act3_blow_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},
	
	cali_act3_blow_9 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT3_BLOW_9", reqs = []},
			{text = "", reqs = [{type = 'decision', value = 'cali_normal_collar', check = true}],
				bonus_effects = [{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_collar_enchanted", parts = {}}
						],
			},]},
			{text = "", reqs = [{type = 'decision', value = 'cali_exquisite_collar', check = true}],
				bonus_effects = [{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_collar_enchanted_2", parts = {}}
						],
			},]},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage11'},
				{code = 'add_timed_event', value = "cali_act4_merchant_start", args = [{type = 'add_to_date', date = [5,5], hour = 1}]},
			]
		}, ]
	},
	
	cali_act4_merchant_start = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_START", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage12'}]
		}, ]
	},
	
	cali_act4_merchant_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_1", reqs = []}],
		options = [ {
			code = 'cali_act4_merchant_2_1', text = "CALI_ACT4_MERCHANT_1_OPTION_1", reqs = [], dialogue_argument = 1, 
		}, {
			 code = 'cali_act4_merchant_3', text = "CALI_ACT4_MERCHANT_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	cali_act4_merchant_2_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_2_1", reqs = []}],
		options = [ {
			 code = 'cali_act4_merchant_3', text = "CALI_ACT4_MERCHANT_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	cali_act4_merchant_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_3", reqs = []}],
		options = [ {
			code = 'cali_act4_merchant_4_1', text = "CALI_ACT4_MERCHANT_3_OPTION_1", reqs = [{type = 'has_money', value = 50}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act4_merchant_4_2', text = "CALI_ACT4_MERCHANT_3_OPTION_2", reqs = [], dialogue_argument = 2, 
		}, ]
	},
	
	cali_act4_merchant_4_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_4_1", reqs = []}],
		options = [ {
			code = 'cali_act4_merchant_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'money_change', operant = '-', value = 50}]
		}, ]
	},
	
	cali_act4_merchant_4_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_4_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage13'},
			{code = 'update_city'}]
		}, ]
	},
	
	# return to merchant
	cali_act4_merchant_5 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_5", reqs = []}],
		options = [ {
			code = 'cali_act4_merchant_4_1', text = "CALI_ACT4_MERCHANT_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act4_merchant_4_2', text = "CALI_ACT4_MERCHANT_3_OPTION_2", reqs = [], dialogue_argument = 2, 
		}, ]
	},
	
	cali_act4_merchant_6 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MERCHANT_6", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'add_timed_event', value = "cali_act4_mast_1", args = [{type = 'add_to_date', date = [1,1], hour = 4}]},
				{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage14'},
				{code = 'update_city'}
			]
		}, ]
	},
	
	cali_act4_mast_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'unique_character_checks', name = 'cali', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'}], 
		text = [{text = "CALI_ACT4_MAST_1", reqs = [], }], 
		options = [ {
			code = 'cali_act4_mast_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},
	
	cali_act4_mast_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_1",
		options = [ {
			code = 'cali_act4_mast_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act4_mast_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_1",
		options = [ {
			code = 'cali_act4_mast_4', text = "CALI_ACT4_MAST_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act4_mast_4_leave', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},
	
	cali_act4_mast_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_2",
		options = [ {
			code = 'cali_act4_mast_5', text = "CALI_ACT4_MAST_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act4_mast_6', text = "CALI_ACT4_MAST_4_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	cali_act4_mast_4_leave = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "CALI_ACT4_MAST_4_LEAVE", reqs = [], }], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'add_timed_event', value = "cali_act5_pet_start", args = [{type = 'add_to_date', date = [5,5], hour = 1}]}]
		}, ],
	},
	
	cali_act4_mast_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_act4_fuck_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act4_fuck_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_FUCK_1", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_fuck_1",
		options = [ {
			code = 'cali_act4_fuck_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act4_fuck_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_FUCK_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_fuck_2",
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_act5_pet_start", args = [{type = 'add_to_date', date = [5,5], hour = 1}]}]
		}, ]
	},
	
	cali_act4_mast_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_6", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_act4_fuck_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act5_pet_start = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "CALI_ACT5_PET_START", reqs = [], }], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage15'}]
		}, ],
	},
	
	cali_act5_pet_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		unlocked_gallery_seq = "cali_act5_pet",
		save_scene_to_gallery = true,
		reqs = [], 
		text = [{text = "CALI_ACT5_PET_1", reqs = [], }], 
		options = [ {
			code = 'cali_act5_pet_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "CALI_ACT5_PET_2", reqs = [], }], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage16'},
			{code = 'update_city'}]
		}, ],
	},
	
	cali_act5_pet_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_3", reqs = [], }], 
		options = [ {
			code = 'cali_act5_pet_4', text = "CALI_ACT5_PET_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act5_pet_4', text = "CALI_ACT5_PET_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_4", reqs = [], }], 
		options = [ {
			code = 'cali_act5_pet_5', text = "CALI_ACT5_PET_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act5_pet_5', text = "CALI_ACT5_PET_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act5_pet_5_3', text = "CALI_ACT5_PET_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_5_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_5_3", reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage17'},
			{code = 'add_timed_event', args = [{type = 'action_to_date', date = [1,1], hour = 1, action = 'quest'}], value = {quest = 'cali_taming_quest', stage = 'stage16'}},
			{code = 'unique_character_changes', value = 'cali', args = [{code = 'obedience', operant = '-', value = 10},]},]
		},  ],
	},
	
	cali_act5_pet_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_ACT5_PET_5_2", reqs = [], previous_dialogue_option = 2}], 
		options = [ {
			code = 'cali_act5_pet_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_6 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_6", reqs = [], }], 
		options = [ {
			code = 'cali_act5_pet_7', text = "CALI_ACT5_PET_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'cali_act5_pet_7', text = "CALI_ACT5_PET_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'cali_act5_pet_7_gone', text = "CALI_ACT5_PET_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_7_gone = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_7_GONE", reqs = []}], 
		common_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'remove_character'}]},
		{code = 'play_sound', value = 'doorsmash'} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'cali_taming_quest'}]
		}, ],
	},
	
	cali_act5_pet_7 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "CALI_ACT5_PET_7", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_1",
		options = [ {
			code = 'cali_act5_pet_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act5_pet_8 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "CALI_ACT5_PET_8", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_2",
		options = [ {
			code = 'cali_act5_pet_9_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},
	
	cali_act5_pet_9_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_9_1", reqs = [], }], 
		options = [ {
			code = 'cali_act5_pet_9_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_9_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_9_2", reqs = [], }], 
		options = [ {
			code = 'cali_act5_pet_10', text = "CALI_ACT5_PET_9_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'cali_act5_pet_10', text = "CALI_ACT5_PET_9_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act5_pet_10 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT5_PET_10_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_ACT5_PET_10_2", reqs = [], previous_dialogue_option = 2}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'cali_taming_quest'},
			{code = 'add_timed_event', value = "cali_act6_naked_1", args = [{type = 'add_to_date', date = [1,1], hour = 3}]}]
		}, ],
	},
	
	cali_act6_naked_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		unlocked_gallery_seq = "cali_act6_naked",
		save_scene_to_gallery = true,
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT6_NAKED_1", reqs = [], }], 
		options = [ {
			code = 'cali_act6_naked_2', text = "CALI_ACT6_NAKED_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act6_naked_2', text = "CALI_ACT6_NAKED_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'cali_act6_naked_2_3', text = "CALI_ACT6_NAKED_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ],
	},
	
	cali_act6_naked_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT6_NAKED_2_1", reqs = [], previous_dialogue_option = 1}, 
		{text = "CALI_ACT6_NAKED_2_2", reqs = [], previous_dialogue_option = 2}, ], 
		options = [ {
			code = 'cali_act6_naked_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},
	
	cali_act6_naked_2_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT6_NAKED_2_3", reqs = []}], 
		options = [ { 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'add_timed_event', value = "cali_act6_naked_1", args = [{type = 'add_to_date', date = [1,1], hour = 3}]},
			{code = 'unique_character_changes', value = 'cali', args = [{code = 'obedience', operant = '-', value = 10},]},]
		}, ],
	},
	
	cali_act6_naked_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_1",
		options = [ {
			code = 'cali_act6_naked_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act6_naked_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_2",
		options = [ {
			code = 'cali_act6_naked_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act6_naked_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_3",
		options = [ {
			code = 'cali_act6_naked_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_act6_naked_6 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_6", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_4",
		options = [ {
			code = 'cali_act6_naked_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},
	
	cali_act6_naked_7 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], unique_character = "cali",
		text = [{text = "CALI_ACT6_NAKED_7", reqs = []}], 
		common_effects = [{code = 'plan_mansion_event', value = 'ZCEvent_1'}],
		options = [ {
			code = 'close', text = "CALI_ACT6_NAKED_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'add_profession', profession = "petbeast"}]},]
		}, ],
	},
}
