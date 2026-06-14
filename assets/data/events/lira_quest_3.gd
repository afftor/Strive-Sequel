extends Reference
var data = {
	lira_quest3_intro_1 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_INTRO_1",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'start'}]
			}
		],
	},
	
	lira_quest3_start_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = "LIRA_QUEST3_START_1",
		options = [
			{code = "lira_quest3_start_2", text = "LIRA_QUEST3_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_start_2", text = "LIRA_QUEST3_START_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_start_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_START_2",
		options = [{code = "lira_quest3_start_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_start_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = "LIRA_QUEST3_START_3",
		options = [
			{code = "lira_quest3_start_4", text = "LIRA_QUEST3_START_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_start_4", text = "LIRA_QUEST3_START_OPTION_4", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_start_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "LIRA_QUEST3_START_4", reqs = []},
			{text = "LIRA_QUEST3_START_5", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}]},
			{text = "LIRA_QUEST3_START_6", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}]},
		],
		options = [{code = "lira_quest3_start_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_start_5 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_START_7",
		options = [
			{code = "lira_quest3_start_6", text = "LIRA_QUEST3_START_OPTION_5", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_start_6", text = "LIRA_QUEST3_START_OPTION_6", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
			{code = "lira_quest3_start_6", text = "LIRA_QUEST3_START_OPTION_7", reqs = [], dialogue_argument = 3, type = 'next_dialogue',},
		],
	},
	lira_quest3_start_6 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "LIRA_QUEST3_START_8", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_START_9", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_START_10", reqs = [], previous_dialogue_option = 3},
			{text = "LIRA_QUEST3_START_11", reqs = []},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'temple'}] #actually not. need replace with event planning
			}
		],
	},
	
	lira_quest3_temple_intro_1 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TEMPLE_INTRO_1",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'temple'}]
			}
		],
	},
	lira_quest3_temple_1 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_TEMPLE_0", reqs = [], previous_dialogue_option = 0},
			{text = "LIRA_QUEST3_TEMPLE_1", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_TEMPLE_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = "lira_quest3_temple_1", text = "LIRA_QUEST3_TEMPLE_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_temple_1", text = "LIRA_QUEST3_TEMPLE_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
			{code = "lira_quest3_temple_2", text = "LIRA_QUEST3_TEMPLE_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_temple_2 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TEMPLE_3",
		options = [{code = "lira_quest3_temple_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_temple_3 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TEMPLE_4",
		options = [{code = "lira_quest3_temple_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_temple_4 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TEMPLE_5",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'report_lira'},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_report_lira_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = "LIRA_QUEST3_REPORT_LIRA_1",
		options = [
			{code = "lira_quest3_report_lira_2", text = "LIRA_QUEST3_REPORT_LIRA_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
			{code = "", text = "LIRA_QUEST3_REPORT_LIRA_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
		],
	},
	lira_quest3_report_lira_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_REPORT_LIRA_2",
		options = [{code = "lira_quest3_report_lira_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_report_lira_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = "LIRA_QUEST3_REPORT_LIRA_3",
		options = [
			{code = "lira_quest3_report_lira_4", text = "LIRA_QUEST3_REPORT_LIRA_OPTION_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
			{code = "lira_quest3_report_lira_4", text = "LIRA_QUEST3_REPORT_LIRA_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
		],
	},
	lira_quest3_report_lira_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "LIRA_QUEST3_REPORT_LIRA_4", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_REPORT_LIRA_5", reqs = []},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'trader'}]
			}
		],
	},
	
	lira_quest3_trader_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_1",
		options = [
			{code = "lira_quest3_trader_2", text = "LIRA_QUEST3_TRADER_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_trader_2", text = "LIRA_QUEST3_TRADER_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_trader_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_2",
		options = [{code = "lira_quest3_trader_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_trader_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_3",
		options = [{code = "lira_quest3_trader_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_trader_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_TRADER_4", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_TRADER_5", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_TRADER_6", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = "lira_quest3_trader_4", text = "LIRA_QUEST3_TRADER_OPTION_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
			{code = "lira_quest3_trader_4", text = "LIRA_QUEST3_TRADER_OPTION_4", reqs = [], dialogue_argument = 3, type = 'next_dialogue',},
			{code = "lira_quest3_trader_5", text = "LIRA_QUEST3_TRADER_OPTION_5", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_trader_5 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_7",
		options = [{code = "lira_quest3_trader_6", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_trader_6 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_8",
		options = [{code = "lira_quest3_trader_7", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_trader_7 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_9",
		options = [{code = "lira_quest3_trader_8", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_trader_8 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_TRADER_10",
		options = [
			{code = "lira_quest3_trader_9", text = "LIRA_QUEST3_TRADER_OPTION_6", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = "lira_quest3_trader_9", text = "LIRA_QUEST3_TRADER_OPTION_7", reqs = [], dialogue_argument = 2, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest3_trader_9 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = [
			{text = "LIRA_QUEST3_TRADER_11", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_TRADER_12", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_TRADER_13", reqs = []},
		],
		options = [
			{code = "lira_quest3_trader_10", text = "LIRA_QUEST3_TRADER_OPTION_8", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_trader_10", text = "LIRA_QUEST3_TRADER_OPTION_9", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	
	lira_quest3_trader_10 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_TRADER_14",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'empire'},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_empire_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_EMPIRE_1",
		options = [
			{code = "lira_quest3_empire_2", text = "LIRA_QUEST3_EMPIRE_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_empire_2", text = "LIRA_QUEST3_EMPIRE_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_empire_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_EMPIRE_2",
		options = [{code = "lira_quest3_empire_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_empire_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_EMPIRE_3",
		options = [{code = "lira_quest3_empire_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_empire_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_EMPIRE_4",
		options = [{code = "lira_quest3_empire_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_empire_5 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_EMPIRE_5",
		options = [
			{code = "lira_quest3_empire_6", text = "LIRA_QUEST3_EMPIRE_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_empire_6", text = "LIRA_QUEST3_EMPIRE_OPTION_4", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_empire_6 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_EMPIRE_6",
		options = [
			{
				code = "lira_quest3_empire_7", 
				text = "LIRA_QUEST3_EMPIRE_OPTION_5", 
				reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
			{
				code = "lira_quest3_empire_9", 
				text = "LIRA_QUEST3_EMPIRE_OPTION_6", 
				reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], 
				dialogue_argument = 1, type = 'next_dialogue', 
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
			{
				code = "lira_quest3_empire_11", 
				text = "LIRA_QUEST3_EMPIRE_OPTION_6", 
				reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], 
				dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
		],
	},
	lira_quest3_empire_7 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = [
			{text = "LIRA_QUEST3_EMPIRE_7", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}]},
			{text = "LIRA_QUEST3_EMPIRE_8", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}]},
		],
		options = [{code = "lira_quest3_empire_8", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_empire_8 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_EMPIRE_9",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'road'},
					{code = 'decision', value = 'lira_quest_3_bait'},
					{code = 'make_quest_location', value = 'quest_lira_road_location'},
					{code = 'update_city'}
				]
			}
		],
	},
	lira_quest3_empire_9 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_EMPIRE_10",
		options = [
			{code = "lira_quest3_empire_7", text = "LIRA_QUEST3_EMPIRE_OPTION_7", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_empire_10", text = "LIRA_QUEST3_EMPIRE_OPTION_8", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_empire_10 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = [
			{text = "LIRA_QUEST3_EMPIRE_11", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_EMPIRE_14", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_EMPIRE_12", reqs = []},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'caravan_prepare'},
					{code = 'decision', value = 'lira_quest_3_caravan'},
					{code = 'update_city'}
				]
			}
		],
	},
	lira_quest3_empire_11 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_EMPIRE_13",
		options = [
			{code = "lira_quest3_empire_10", text = "LIRA_QUEST3_EMPIRE_OPTION_9", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
			{code = "lira_quest3_empire_10", text = "LIRA_QUEST3_EMPIRE_OPTION_10", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
		],
	},
	
	lira_quest3_caravan_prepare_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_CARAVAN_PREPARE_1",
		options = [
			{
				code = "lira_quest3_caravan_prepare_2", 
				text = "LIRA_QUEST3_CARAVAN_PREPARE_OPTION_1", 
				reqs = [{type = "has_money", value = 500}], dialogue_argument = 1, 
				type = 'next_dialogue', 
				bonus_effects = [
					{code = 'decision', value = 'lira_quest_3_guards_hired'},
					{code = "money_change", operant = "-", value = 500}
				]
			},
			{code = "lira_quest3_caravan_prepare_2", text = "LIRA_QUEST3_CARAVAN_PREPARE_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
		],
	},
	lira_quest3_caravan_prepare_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_CARAVAN_PREPARE_2", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_CARAVAN_PREPARE_3", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_CARAVAN_PREPARE_4", reqs = []},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'caravan_attack'},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_caravan_ambush_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_CARAVAN_AMBUSH_1",
		options = [
			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'lira_quest3_caravan', dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_caravan_ambush_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_CARAVAN_AMBUSH_2", reqs = []},
			{text = "LIRA_QUEST3_CARAVAN_AMBUSH_3", reqs = [{type = 'decision', value = 'lira_quest_3_guards_hired', check = true}]},
			{text = "LIRA_QUEST3_CARAVAN_AMBUSH_4", reqs = [{type = 'decision', value = 'lira_quest_3_guards_hired', check = false}]},
			{text = "LIRA_QUEST3_CARAVAN_AMBUSH_5", reqs = []},
		],
		options = [{code = "lira_quest3_bandit_leader_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	
	lira_quest3_road_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_ROAD_1",
		options = [{code = "lira_quest3_road_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_road_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_ROAD_2",
	},
	lira_quest3_road_postfight_1 = {
		image = null,
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_ROAD_POSTFIGHT_1",
		options = [{code = "lira_quest3_road_postfight_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_road_postfight_2 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_ROAD_POSTFIGHT_2", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_ROAD_POSTFIGHT_3", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = "lira_quest3_road_postfight_2", text = "LIRA_QUEST3_ROAD_POSTFIGHT_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true},
			{code = "lira_quest3_road_postfight_3", text = "LIRA_QUEST3_ROAD_POSTFIGHT_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_road_postfight_3 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_ROAD_POSTFIGHT_4", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_ROAD_POSTFIGHT_5", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_ROAD_POSTFIGHT_6", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = "lira_quest3_road_postfight_3", text = "LIRA_QUEST3_ROAD_POSTFIGHT_OPTION_3", reqs = [], dialogue_argument = 2},
			{code = "lira_quest3_road_postfight_3", text = "LIRA_QUEST3_ROAD_POSTFIGHT_OPTION_4", reqs = [], dialogue_argument = 3},
			{code = "lira_quest3_road_postfight_4", text = "LIRA_QUEST3_ROAD_POSTFIGHT_OPTION_5", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_road_postfight_4 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_ROAD_POSTFIGHT_7",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'den'},
					{code = 'make_quest_location', value = 'quest_lira_bandits_den'},
					{code = 'update_location'}
				]
			}
		],
	},
	
	lira_quest3_den_intro_1 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_DEN_INTRO_1",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_den_1 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_DEN_1",
		options = [
			{code = "lira_quest3_den_2", text = "LIRA_QUEST3_DEN_OPTION_1", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "gt", value = 4}]}], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'quest_fight', args = 'lira_quest3_den_boss', text = "LIRA_QUEST3_DEN_OPTION_2", reqs = [], dialogue_argument = 0, type = 'next_dialogue',},
		],
	},
	lira_quest3_den_2 = {
		image = null,
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_DEN_2",
		options = [{code = "lira_quest3_den_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_den_3 = {
		image = null,
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = [
			{text = "LIRA_QUEST3_DEN_3", reqs = [], previous_dialogue_option = 0},
			{text = "LIRA_QUEST3_DEN_4", reqs = []},
		],
		options = [{code = "lira_quest3_bandit_leader_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	
	lira_quest3_bandit_leader_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_BANDIT_LEADER_1",
		options = [
			{code = "lira_quest3_bandit_leader_2", text = "LIRA_QUEST3_BANDIT_LEADER_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_bandit_leader_2", text = "LIRA_QUEST3_BANDIT_LEADER_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_bandit_leader_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_BANDIT_LEADER_2",
		options = [{code = "lira_quest3_bandit_leader_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_bandit_leader_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_BANDIT_LEADER_3",
		options = [{code = "lira_quest3_bandit_leader_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_bandit_leader_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_BANDIT_LEADER_4",
		options = [{code = "lira_quest3_bandit_leader_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_bandit_leader_5 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_BANDIT_LEADER_5",
		options = [{code = "lira_quest3_bandit_leader_6", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_bandit_leader_6 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_BANDIT_LEADER_6",
		options = [
			{code = "lira_quest3_bandit_leader_7", text = "LIRA_QUEST3_BANDIT_LEADER_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
			{code = "lira_quest3_bandit_leader_7", text = "LIRA_QUEST3_BANDIT_LEADER_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
		],
	},
	lira_quest3_bandit_leader_7 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_BANDIT_LEADER_7", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_BANDIT_LEADER_8", reqs = [], previous_dialogue_option = 2},
		],
		options = [{code = "lira_quest3_bandit_leader_8", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_bandit_leader_8 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = [
			{text = "LIRA_QUEST3_BANDIT_LEADER_9", reqs = []},
			{text = "LIRA_QUEST3_BANDIT_LEADER_10", reqs = [{type = 'decision', value = 'lira_quest_3_bait', check = true}]},
			{text = "LIRA_QUEST3_BANDIT_LEADER_11", reqs = [{type = 'decision', value = 'lira_quest_3_caravan', check = true}]},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'follow_leader'},
					{code = "remove_quest_location", value = "quest_lira_bandits_den"},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_follow_leader_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_FOLLOW_LEADER_1",
		options = [{code = "lira_quest3_follow_leader_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_follow_leader_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_FOLLOW_LEADER_2",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'merchant'},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_merchant_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_1",
		options = [
			{code = "lira_quest3_merchant_2", text = "LIRA_QUEST3_MERCHANT_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_merchant_2", text = "LIRA_QUEST3_MERCHANT_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_merchant_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_2",
		options = [{code = "lira_quest3_merchant_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_3",
		options = [
			{code = "lira_quest3_merchant_4", text = "LIRA_QUEST3_MERCHANT_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_merchant_4", text = "LIRA_QUEST3_MERCHANT_OPTION_4", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_merchant_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_4",
		options = [{code = "lira_quest3_merchant_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_5 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_5",
		options = [{code = "lira_quest3_merchant_6", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_6 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_6",
		options = [{code = "lira_quest3_merchant_7", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_7 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_7",
		options = [{code = "lira_quest3_merchant_8", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_8 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_8",
		options = [{code = "lira_quest3_merchant_9", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_9 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_9",
		options = [
			{code = "lira_quest3_merchant_10", text = "LIRA_QUEST3_MERCHANT_OPTION_5", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_merchant_11", text = "LIRA_QUEST3_MERCHANT_OPTION_6", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
		],
	},
	lira_quest3_merchant_10 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_MERCHANT_10",
		options = [{code = "lira_quest3_merchant_11", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_merchant_11 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = [
			{text = "LIRA_QUEST3_MERCHANT_11", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_MERCHANT_12", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST3_MERCHANT_13", reqs = []},
		],
		options = [{code = "lira_quest3_aftermath_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_aftermath_1 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_1",
		options = [{code = "lira_quest3_aftermath_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_aftermath_2 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_2",
		options = [
			{code = "lira_quest3_aftermath_3", text = "LIRA_QUEST3_AFTERMATH_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_aftermath_3", text = "LIRA_QUEST3_AFTERMATH_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_aftermath_3 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_AFTERMATH_3",
		options = [
			{code = "lira_quest3_aftermath_4", text = "DIALOGUECONTINUE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_aftermath_7", text = "DIALOGUECONTINUE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_aftermath_4 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_4",
		options = [{code = "lira_quest3_aftermath_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_aftermath_5 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_5",
		options = [
			{code = "lira_quest3_aftermath_6", text = "LIRA_QUEST3_AFTERMATH_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = "lira_quest3_aftermath_6", text = "LIRA_QUEST3_AFTERMATH_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue',},
		],
	},
	lira_quest3_aftermath_6 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = [
			{text = "LIRA_QUEST3_AFTERMATH_6", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST3_AFTERMATH_7", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'return'},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_aftermath_7 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_8",
		options = [{code = "lira_quest3_aftermath_8", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_aftermath_8 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_9",
		options = [{code = "lira_quest3_aftermath_9", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_aftermath_9 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_10",
		options = [
			{
				code = "lira_quest3_aftermath_10", 
				text = "LIRA_QUEST3_AFTERMATH_OPTION_5",
				reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = "affect_unique_character", name = "lira", type = "slavetype", value = "servant"},]
			},
			{code = "lira_quest3_aftermath_12", text = "LIRA_QUEST3_AFTERMATH_OPTION_6", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	lira_quest3_aftermath_10 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene"],
		text = "LIRA_QUEST3_AFTERMATH_11",
		options = [{code = "lira_quest3_aftermath_11", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	lira_quest3_aftermath_11 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_AFTERMATH_12",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'return'},
					{code = 'update_city'}
				]
			}
		],
	},
	lira_quest3_aftermath_12 = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_AFTERMATH_13",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'lira_quest_3', stage = 'return'},
					{code = 'update_city'}
				]
			}
		],
	},
	
	lira_quest3_return = {
		image = null, character = "lira",
		reqs = [], tags = ["dialogue_scene", "master_translate",],
		text = "LIRA_QUEST3_RETURN",
		options = [
			{
				code = "lira_mansion_1", 
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'complete_quest', value = 'lira_quest_3'},]
			}
		],
	},
	
#	lira_quest_3_intro = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		common_effects = [
#			{code = 'remove_timed_events', value = ['lira_quest_3_intro']},
#		],
#		text = [{text = "LIRA_QUEST3_INTRO", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_talk_origin', text = "LIRA_QUEST3_OPTION_HOW_HAVE_YOU_BEEN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_talk_origin', text = "LIRA_QUEST3_OPTION_DISTRACTED", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_talk_origin = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_TALK_ORIGIN", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_origin_response', text = "LIRA_QUEST3_OPTION_PEOPLE_CRUEL", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_origin_response', text = "LIRA_QUEST3_OPTION_DIDNT_DESERVE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_origin_response = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_ORIGIN_DEP", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}]},
#			{text = "LIRA_QUEST3_ORIGIN_FREE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}]},
#		],
#		options = [
#			{code = 'lira_quest_3_offer_search', text = "LIRA_QUEST3_OPTION_PRESENT_MATTERS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_offer_search', text = "LIRA_QUEST3_OPTION_MAY_FIND_ANSWERS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#			{code = 'lira_quest_3_offer_search', text = "LIRA_QUEST3_OPTION_LOOK_INTO_IT", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_offer_search = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_OFFER_SEARCH_1", reqs = [], previous_dialogue_option = 1},
#			{text = "LIRA_QUEST3_OFFER_SEARCH_2", reqs = [], previous_dialogue_option = 2},
#			{text = "LIRA_QUEST3_OFFER_SEARCH_3", reqs = [], previous_dialogue_option = 3},
#			{text = "LIRA_QUEST3_OFFER_SEARCH_END", reqs = []},
#		],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'temple'}]},
#		],
#	},
#	lira_quest_3_temple_audience = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_TEMPLE_AUDIENCE", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_temple_root', text = "LIRA_QUEST3_OPTION_TEMPLE_WELCOME", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_temple_root', text = "LIRA_QUEST3_OPTION_ASK_LIRA", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#			{code = 'lira_quest_3_temple_origin', text = "LIRA_QUEST3_OPTION_BUSINESS", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_temple_root = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_TEMPLE_ROOT_1", reqs = [], previous_dialogue_option = 1},
#			{text = "LIRA_QUEST3_TEMPLE_ROOT_2", reqs = [], previous_dialogue_option = 2},
#		],
#		options = [
#			{code = 'lira_quest_3_temple_root', text = "LIRA_QUEST3_OPTION_TEMPLE_WELCOME", reqs = [], dialogue_argument = 1, previous_dialogue_option = [1, 2], type = 'next_dialogue'},
#			{code = 'lira_quest_3_temple_root', text = "LIRA_QUEST3_OPTION_ASK_LIRA", reqs = [], dialogue_argument = 2, previous_dialogue_option = [1, 2], type = 'next_dialogue'},
#			{code = 'lira_quest_3_temple_origin', text = "LIRA_QUEST3_OPTION_BUSINESS", reqs = [], dialogue_argument = 3, previous_dialogue_option = [1, 2], type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_temple_origin = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_TEMPLE_ORIGIN", reqs = []}],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'report_lira'}, {code = 'plan_mansion_event', value = 'lira_quest_3_report_lira'}]},
#		],
#	},
#	lira_quest_3_report_lira = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_REPORT_LIRA", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_report_lira_answer', text = "LIRA_QUEST3_OPTION_TELL_LEARNED", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
#			{code = 'lira_quest_3_report_lira_answer', text = "LIRA_QUEST3_OPTION_COME_WITH_ME", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
#		],
#	},
#	lira_quest_3_report_lira_answer = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_REPORT_LIRA_FREE", reqs = [], previous_dialogue_option = 1},
#			{text = "LIRA_QUEST3_REPORT_LIRA_DEP", reqs = [], previous_dialogue_option = 2},
#		],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'trader'}]},
#		],
#	},
#	lira_quest_3_slave_trader = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_SLAVE_TRADER", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_slave_trader_history', text = "LIRA_QUEST3_OPTION_DEAL_PAST", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_slave_trader_history', text = "LIRA_QUEST3_OPTION_TRIBAL_CHILD", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_slave_trader_history = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_SLAVE_TRADER_HISTORY", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_slave_trader_root', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_slave_trader_root = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_SLAVE_TRADER_ROOT", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_slave_trader_root', text = "LIRA_QUEST3_OPTION_MEDICINE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_slave_trader_root', text = "LIRA_QUEST3_OPTION_SURVIVED", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#			{code = 'lira_quest_3_slave_trader_lead', text = "LIRA_QUEST3_OPTION_WHERE_GET_KID", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_slave_trader_lead = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_SLAVE_TRADER_LEAD", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_slave_trader_lira_reacts', text = "LIRA_QUEST3_OPTION_FAIR_BUT_BAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
#			{code = 'lira_quest_3_slave_trader_lira_reacts', text = "LIRA_QUEST3_OPTION_WORLD_WORKS", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
#		],
#	},
#	lira_quest_3_slave_trader_lira_reacts = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_SLAVE_TRADER_LIRA_REACTS", reqs = []}],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'empire'}]},
#		],
#	},
#	lira_quest_3_empire_notice = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_EMPIRE_NOTICE", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_bait_choice', text = "LIRA_QUEST3_OPTION_USE_CARAVAN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_bait_choice', text = "LIRA_QUEST3_OPTION_BANDITS_FIND_US", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_bait_choice = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_BAIT_CHOICE", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_lira_bait_accept', text = "LIRA_QUEST3_OPTION_ALLOW_LIRA_BAIT", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}, {code = 'decision', value = 'lira_quest_3_bait_lira'}]},
#			{code = 'lira_quest_3_caravan_plan', text = "LIRA_QUEST3_OPTION_USE_CARAVAN_ANYWAY", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}, {code = 'decision', value = 'lira_quest_3_bait_caravan'}]},
#		],
#	},
#	lira_quest_3_lira_bait_accept = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_LIRA_BAIT_ACCEPT_FREE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}]},
#			{text = "LIRA_QUEST3_LIRA_BAIT_ACCEPT_DEP", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}]},
#		],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'road'}, {code = 'make_quest_location', value = 'quest_lira_road_location'}]},
#		],
#	},
#	lira_quest_3_caravan_plan = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_CARAVAN_PLAN_FREE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}]},
#			{text = "LIRA_QUEST3_CARAVAN_PLAN_DEP", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}]},
#		],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'caravan_prepare'}]},
#		],
#	},
#	lira_quest_3_road_ambush = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_ROAD_AMBUSH", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_road_after_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_road_after_fight = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_ROAD_AFTER_FIGHT", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_road_interrogate', text = "LIRA_QUEST3_OPTION_ASK_HIDEOUT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_road_interrogate', text = "LIRA_QUEST3_OPTION_BLADE_THROAT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_road_interrogate = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_ROAD_INTERROGATE", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_road_interrogate', text = "LIRA_QUEST3_OPTION_HOW_MANY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_road_interrogate', text = "LIRA_QUEST3_OPTION_SLAVE_TRADE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#			{code = 'close', text = "LIRA_QUEST3_OPTION_HIDEOUT", reqs = [], dialogue_argument = 3,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'den'}, {code = 'make_quest_location', value = 'quest_lira_bandits_den'}]},
#		],
#	},
#	lira_quest_3_den_entry = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_DEN_ENTRY", reqs = []}],
#		options = [
#			{code = 'close', text = "LIRA_QUEST3_OPTION_ENTER", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_den_boss = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_DEN_BOSS", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_den_surrender', text = "LIRA_QUEST3_OPTION_SURRENDER", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'gte', value = 4}]}], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'lira_quest3_den_boss', dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_den_surrender = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_DEN_SURRENDER", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_bandit_leader_questions', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_den_fight_aftermath = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_DEN_FIGHT_AFTERMATH", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_bandit_leader_questions', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_caravan_master = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_CARAVAN_MASTER", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_caravan_ready', text = "LIRA_QUEST3_OPTION_HIRE_GUARDS", reqs = [{type = "has_money", value = 500}], dialogue_argument = 1, type = 'next_dialogue',
#				bonus_effects = [{code = 'money_change', operant = '-', value = 500}, {code = 'decision', value = 'lira_quest_3_hired_guards'}]},
#			{code = 'lira_quest_3_caravan_ready', text = "LIRA_QUEST3_OPTION_IGNORE_ADVICE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_caravan_ready = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_CARAVAN_READY_HIRE", reqs = [], previous_dialogue_option = 1},
#			{text = "LIRA_QUEST3_CARAVAN_READY_NO_HIRE", reqs = [], previous_dialogue_option = 2},
#		],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'caravan_attack'}]},
#		],
#	},
#	lira_quest_3_caravan_attack = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_CARAVAN_ATTACK", reqs = []}],
#		options = [
#			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'lira_quest3_caravan', dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_caravan_fight_aftermath = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_CARAVAN_AFTER_HIRE", reqs = [{type = 'decision', value = 'lira_quest_3_hired_guards', check = true}]},
#			{text = "LIRA_QUEST3_CARAVAN_AFTER_NO_HIRE", reqs = [{type = 'decision', value = 'lira_quest_3_hired_guards', check = false}]},
#		],
#		options = [
#			{code = 'lira_quest_3_bandit_leader_questions', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_bandit_leader_questions = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_BANDIT_LEADER_QUESTIONS", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_bandit_leader_mother', text = "LIRA_QUEST3_OPTION_NOT_HEAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_bandit_leader_mother', text = "LIRA_QUEST3_OPTION_ASK_QUESTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_bandit_leader_mother = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_BANDIT_LEADER_MOTHER", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_bandit_leader_merchant', text = "LIRA_QUEST3_OPTION_MOTHER_REASONS", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
#			{code = 'lira_quest_3_bandit_leader_merchant', text = "LIRA_QUEST3_OPTION_FAMILY_NOT_WORTH", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
#				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
#		],
#	},
#	lira_quest_3_bandit_leader_merchant = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_BANDIT_LEADER_MERCHANT", reqs = []}],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'set_completed_active_location'}, {code = 'progress_quest', value = 'lira_quest_3', stage = 'follow_leader'}]},
#		],
#	},
#	lira_quest_3_follow_leader = {
#		image = null,
#		character = "bandits",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_FOLLOW_LEADER", reqs = []}],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'merchant'}]},
#		],
#	},
#	lira_quest_3_merchant_shop = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_MERCHANT_SHOP", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_merchant_confession', text = "LIRA_QUEST3_OPTION_SELL_CHILDREN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_merchant_confession', text = "LIRA_QUEST3_OPTION_SHADY_DEALS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_merchant_confession = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_MERCHANT_CONFESSION", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_merchant_amulet', text = "LIRA_QUEST3_OPTION_TELL_WHAT_HAPPENED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_merchant_amulet', text = "LIRA_QUEST3_OPTION_EXPLAIN_OLD_MAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_merchant_amulet = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_MERCHANT_AMULET", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_merchant_judgment', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_merchant_judgment = {
#		image = null,
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_MERCHANT_JUDGMENT", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_merchant_after', text = "LIRA_QUEST3_OPTION_KARMA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_merchant_after', text = "LIRA_QUEST3_OPTION_NOT_WORTH", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_merchant_after = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_MERCHANT_AFTER_KILL", reqs = [], previous_dialogue_option = 1},
#			{text = "LIRA_QUEST3_MERCHANT_AFTER_SPARE", reqs = [], previous_dialogue_option = 2},
#			{text = "LIRA_QUEST3_MERCHANT_AFTER", reqs = []},
#		],
#		options = [
#			{code = 'lira_quest_3_past_resolved', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_past_resolved = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_PAST_RESOLVED", reqs = []}],
#		options = [
#			{code = 'lira_quest_3_final_path', text = "LIRA_QUEST3_OPTION_SURVIVED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_final_path', text = "LIRA_QUEST3_OPTION_GODS_MERCIFUL", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_final_path = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_FINAL_COMMON", reqs = []},
#			{text = "LIRA_QUEST3_FINAL_DEP", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}]},
#			{text = "LIRA_QUEST3_FINAL_FREE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}]},
#		],
#		options = [
#			{code = 'lira_quest_3_final_answer', text = "LIRA_QUEST3_OPTION_STAY_BELONG", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
#			{code = 'lira_quest_3_final_answer', text = "LIRA_QUEST3_OPTION_SET_FREE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], dialogue_argument = 2, type = 'next_dialogue'},
#			{code = 'lira_quest_3_final_answer', text = "LIRA_QUEST3_OPTION_FREE_SERVANT", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], dialogue_argument = 3, type = 'next_dialogue'},
#			{code = 'lira_quest_3_final_answer', text = "LIRA_QUEST3_OPTION_KEEP_TREATING_WELL", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], dialogue_argument = 4, type = 'next_dialogue'},
#		],
#	},
#	lira_quest_3_final_answer = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [
#			{text = "LIRA_QUEST3_FINAL_ANSWER_DEP_STAY", reqs = [], previous_dialogue_option = 1},
#			{text = "LIRA_QUEST3_FINAL_ANSWER_DEP_FREE", reqs = [], previous_dialogue_option = 2},
#			{text = "LIRA_QUEST3_FINAL_ANSWER_FREE_FREE", reqs = [], previous_dialogue_option = 3},
#			{text = "LIRA_QUEST3_FINAL_ANSWER_FREE_STAY", reqs = [], previous_dialogue_option = 4},
#		],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
#				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_3', stage = 'return_home'}, {code = 'plan_mansion_event', value = 'lira_quest_3_return_home'}]},
#		],
#	},
#	lira_quest_3_return_home = {
#		image = null,
#		character = "lira",
#		tags = ['dialogue_scene', 'master_translate'],
#		reqs = [],
#		text = [{text = "LIRA_QUEST3_RETURN_HOME", reqs = []}],
#		options = [
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], dialogue_argument = 1,
#				bonus_effects = [
#					{code = 'complete_quest', value = 'lira_quest_3'},
#					{code = 'affect_unique_character', name = 'lira', type = 'stat', stat = 'physics_factor', value = 2},
#					{code = 'affect_unique_character', name = 'lira', type = 'stat', stat = 'growth_factor', value = 1},
#					{code = 'affect_unique_character', name = 'lira', type = 'stat', stat = 'authority_factor', value = 1},
#				]},
#			{code = 'close', text = "DIALOGUECLOSE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], dialogue_argument = 1,
#				bonus_effects = [
#					{code = 'complete_quest', value = 'lira_quest_3'},
#					{code = 'affect_unique_character', name = 'lira', type = 'stat', stat = 'wits_factor', value = 1},
#					{code = 'affect_unique_character', name = 'lira', type = 'stat', stat = 'growth_factor', value = 1},
#					{code = 'affect_unique_character', name = 'lira', type = 'stat', stat = 'tame_factor', value = 1},
#				]},
#		],
#	},
}
