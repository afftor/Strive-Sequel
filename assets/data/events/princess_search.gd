#decisions:
#search_advice_1 - duncan -> amelia
#search_advice_2 - amelia -> duncan
#search_advice_3 - amelia -> myr
#search_advice_4 - amelia -> amelia (failed interragation)
#prison_avail - unlock
#amelia_help - not implemented - contionues questline


var data = {
	#fighters
	princess_search_fighters_main = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene'],

		text = [
			{text = "SEARCH_FIGHTERS_1", reqs = [], previous_dialogue_option = 0},
			{text = "SEARCH_FIGHTERS_1_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_FIGHTERS_1_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'princess_search_fighters_main',
				text = "SEARCH_FIGHTERS_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_fighters_3',
				text = "SEARCH_FIGHTERS_OPTION_4",
				reqs = [{type = 'decision', value = 'aire_is_dead', check = false}],
				dialogue_argument = 1,
				remove_after_first_use = true,
				type = 'next_dialogue'
			},
			{
				code = 'princess_search_fighters_main',
				text = "SEARCH_FIGHTERS_OPTION_2",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_fighters_leave',
				text = "SEARCH_FIGHTERS_OPTION_3",
				reqs = [],
				previous_dialogue_option = [1,2],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_fighters_3 = { #mb this IS used in place of _6 as a init scene of dialogue
		image = null,
		character = "duncan",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_FIGHTERS_3", reqs = []}],
		options = [
			{
				code = 'princess_search_fighters_4',
				text = "SEARCH_FIGHTERS_OPTION_5",
				reqs = [{type = 'decision', value = 'aire_is_saved', check = true}], #not sure about this
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_fighters_5',
				text = "SEARCH_FIGHTERS_OPTION_6",
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_fighters_4 = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_FIGHTERS_4", reqs = []}],
		options = [
			{
				code = 'princess_search_fighters_main',
				text = "SEARCH_FIGHTERS_OPTION_7",
				reqs = [],
				dialogue_argument = 2,
			},
			{
				code = 'princess_search_fighters_main',
				text = "SEARCH_FIGHTERS_OPTION_8",
				reqs = [],
				dialogue_argument = 3,

			},
		],
	},
	princess_search_fighters_leave = {
		image = null,
		character = "duncan",
		tags = [],
		text = [{text = "SEARCH_FIGHTERS_2", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				bonus_effects = [
					{code = 'progress_quest', value = 'princess_search', stage = 'stage2'}],
				reqs = [],
			},
		],
	},
	princess_search_fighters_5 = {
		image = null,
		character = "duncan",
		tags = [],
		text = [
			{text = "SEARCH_FIGHTERS_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_FIGHTERS_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_FIGHTERS_5_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_FIGHTERS_5", reqs = [], bonus_effects = [{code = 'decision', value = 'prison_avail'}]},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
			},
		],
	},
	princess_search_fighters_6 = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_FIGHTERS_6", reqs = []}],
		options = [
			{
				code = 'princess_search_fighters_3',
				text = "SEARCH_FIGHTERS_OPTION_4",
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
			},
		],
	},
	princess_search_fighters_7 = {
		image = null,
		character = "duncan",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_FIGHTERS_7", reqs = []}],
		options = [
			{
				code = 'princess_search_fighters_8',
				text = "SEARCH_FIGHTERS_OPTION_9",
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_fighters_8 = {
		image = null,
		character = "duncan",
		tags = [],
		text = [{text = "SEARCH_FIGHTERS_8", reqs = [], bonus_effects = [{code = 'decision', value = 'prison_avail'}]}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
			},
		],
	},
	#servants
	princess_search_servants_1 = {
		variations = [
			{
				reqs = [
					{type = 'decision', value = 'aire_is_dead', check = false},
				],
				image = null,
				character = "amelia",
				tags = [],
				text = [{text = "SEARCH_SERVANTS_1", reqs = []}],
				options = [
					{
						code = 'close',
						bonus_effects = [],
						text = "SEARCH_SERVANTS_OPTION",
						reqs = [],
					},
				],
			},
			{
				reqs = [],
				image = null,
				character = "amelia",
				tags = [],
				text = [{text = "SEARCH_SERVANTS_2", reqs = []}],
				options = [
					{
						code = 'close',
						bonus_effects = [],
						text = "SEARCH_SERVANTS_OPTION",
						reqs = [],
					},
				],
			},
		]
	},
	princess_search_servants_leave = {#not used
		image = null,
		character = "amelia",
		tags = [],
		text = [{text = "", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
			},
		],
	},
	#dungeon
	#look for some minor issues in translation file comments
	princess_search_dungeon_1 = {
		custom_background = "jail",
		image = null,
		character = 'amelia_shade',
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_DUNGEON_1", reqs = []}],
		common_effects = [{code = 'background_noise', value = 'stop'}],
		options = [
			{
				code = 'princess_search_dungeon_2',
				text = "SEARCH_DUNGEON_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_2 = {
		custom_background = "jail",
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SEARCH_DUNGEON_2_1", reqs = [{type = 'decision', value = 'search_advice_2', check = true}]},
			{text = "SEARCH_DUNGEON_2_2", reqs = [{type = 'decision', value = 'search_advice_2', check = false}]},
			{text = "SEARCH_DUNGEON_2_3", reqs = []},
		],
		options = [
			{
				code = 'princess_search_dungeon_3',
				text = "SEARCH_DUNGEON_OPTION_2",
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_3',
				text = "SEARCH_DUNGEON_OPTION_3",
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_3 = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'aire_raped', check = true}],
				custom_background = "jail",
				image = null,
				character = "aire",
				tags = ['dialogue_scene'],
				text = [{text = "SEARCH_DUNGEON_3_1", reqs = []}],
				options = [
					{
						code = 'princess_search_dungeon_4',
						text = "SEARCH_DUNGEON_OPTION_4",
						reqs = [],
						dialogue_argument = 1,
					},
					{
						code = 'princess_search_dungeon_4',
						text = "SEARCH_DUNGEON_OPTION_5",
						reqs = [],
						dialogue_argument = 2,
					},
					{
						code = 'princess_search_dungeon_4',
						text = "SEARCH_DUNGEON_OPTION_6",
						reqs = [],
						dialogue_argument = 3,
					},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_raped', check = false}],
				image = null,
				custom_background = "jail",
				character = "aire",
				tags = ['dialogue_scene'],
				text = [{text = "SEARCH_DUNGEON_3_2", reqs = [], bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = 0}]}],
				options = [
					{
						code = 'princess_search_dungeon_7',
						text = "SEARCH_DUNGEON_OPTION_17",
						reqs = [],
						dialogue_argument = 1,
					},
					{
						code = 'princess_search_dungeon_7',
						text = "SEARCH_DUNGEON_OPTION_18",
						reqs = [],
						dialogue_argument = 2,
					},

				],
			},
		]
	},
	princess_search_dungeon_4 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene'],
		text = [
			{text = "SEARCH_DUNGEON_4_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_4_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_4_3", reqs = [], previous_dialogue_option = 3},
			],
		options = [
			{
				code = 'princess_search_dungeon_5',
				text = "SEARCH_DUNGEON_OPTION_7",
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_5',
				text = "SEARCH_DUNGEON_OPTION_8",
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_5',
				text = "SEARCH_DUNGEON_OPTION_9",
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_5 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene'],
		text = [
			{text = "SEARCH_DUNGEON_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_5_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_DUNGEON_5_4", reqs = [], previous_dialogue_option = 4},
			],
		options = [
			{
				code = 'princess_search_dungeon_5',
				text = "SEARCH_DUNGEON_OPTION_10",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_5',
				text = "SEARCH_DUNGEON_OPTION_11",
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_5',
				text = "SEARCH_DUNGEON_OPTION_12",
				reqs = [],
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_6',
				text = "SEARCH_DUNGEON_OPTION_13",
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_6 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_6_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_6_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_DUNGEON_6_4", reqs = [], previous_dialogue_option = 4,bonus_effects = [{code = 'play_sound', value = 'slap'}]},
			],
		options = [
			{
				code = 'princess_search_dungeon_6',
				text = "SEARCH_DUNGEON_OPTION_14",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_6',
				text = "SEARCH_DUNGEON_OPTION_15",
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_6',
				text = "SEARCH_DUNGEON_OPTION_16",
				reqs = [],
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_16',#wrong, dungeon exit scene
				text = "SEARCH_DUNGEON_OPTION_LEAVE",
				reqs = [],
				bonus_effects = [{code = 'decision', value = 'interrogation_fail'}],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_7 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene'],
		text = [
			{text = "SEARCH_DUNGEON_7_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_7_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_7_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_DUNGEON_7_4", reqs = [], previous_dialogue_option = 4},
			{text = "SEARCH_DUNGEON_7_5", reqs = [], previous_dialogue_option = 5},
			{text = "SEARCH_DUNGEON_7_6", reqs = [], previous_dialogue_option = 6},
			{text = "SEARCH_DUNGEON_7_7", reqs = [], previous_dialogue_option = 7},
			],
		options = [
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_19",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_11',
				text = "SEARCH_DUNGEON_OPTION_20",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_16',
				text = "SEARCH_DUNGEON_OPTION_21",
				reqs = [],
				bonus_effects = [{code = 'decision', value = 'interrogation_fail'}],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_8 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_8_1", reqs = [{type = 'decision', value = 'aire_is_saved', check = false}], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_8_1_IF_MET", reqs = [{type = 'decision', value = 'aire_is_saved', check = true}], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_8_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_8_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_DUNGEON_8_4", reqs = [], previous_dialogue_option = 4},
			{text = "SEARCH_DUNGEON_8_5", reqs = [], previous_dialogue_option = 5},
			{text = "SEARCH_DUNGEON_8_6", reqs = [], previous_dialogue_option = 6},
			{text = "SEARCH_DUNGEON_8_7_1", reqs = [{type = 'decision', value = 'aire_had_sex', check = true}], previous_dialogue_option = 7},
			{text = "SEARCH_DUNGEON_8_7_2", reqs = [{type = 'decision', value = 'aire_had_sex', check = false}], previous_dialogue_option = 7},
			],
		options = [
			{
				code = 'princess_search_dungeon_9',
				text = "SEARCH_DUNGEON_OPTION_22",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_10',
				text = "SEARCH_DUNGEON_OPTION_23",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_24",
				reqs = [],
				dialogue_argument = 7,
				remove_after_first_use = true
			},
			{
				code = 'princess_search_dungeon_7',
				text = "SEARCH_DUNGEON_OPTION_25",
				reqs = [],
				dialogue_argument = 3,
			},
		],
	},
	princess_search_dungeon_9 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_9", reqs = [], previous_dialogue_option = 1},
			],
		options = [
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_26",
				reqs = [],
				dialogue_argument = 2,
			},
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_27",
				reqs = [],
				dialogue_argument = 3,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = '+'}]
			},
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_28",
				reqs = [],
				dialogue_argument = 4,
			},
		],
	},
	princess_search_dungeon_10 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_10", reqs = [], previous_dialogue_option = 1},
			],
		options = [
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_29",
				reqs = [],
				dialogue_argument = 5,
			},
			{
				code = 'princess_search_dungeon_8',
				text = "SEARCH_DUNGEON_OPTION_30",
				reqs = [],
				dialogue_argument = 6,
			},
		],
	},
	princess_search_dungeon_11 = {
		reqs = [],
		image = null,
		custom_background = "jail",
		character = "aire",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_11", reqs = [], previous_dialogue_option = 1},
			],
		options = [
			{
				code = 'princess_search_dungeon_12',
				text = "SEARCH_DUNGEON_OPTION_31",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = '+'}]
			},
			{
				code = 'princess_search_dungeon_12',
				text = "SEARCH_DUNGEON_OPTION_32",
				reqs = [],
				dialogue_argument = 2,
			},
			{
				code = 'princess_search_dungeon_12',
				text = "SEARCH_DUNGEON_OPTION_33",
				reqs = [],
				dialogue_argument = 3,
			},
			{
				code = 'princess_search_dungeon_12',
				text = "SEARCH_DUNGEON_OPTION_34",
				reqs = [],
				dialogue_argument = 4,
			},
		],
	},
	princess_search_dungeon_12 = {
		reqs = [],
		image = null,
		character = "aire",
		custom_background = "jail",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_12_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_12_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_12_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_DUNGEON_12_4", reqs = [], previous_dialogue_option = 4},
			],
		options = [
			{
				code = 'princess_search_dungeon_13',
				text = "SEARCH_DUNGEON_OPTION_35",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = '+'}]
			},
			{
				code = 'princess_search_dungeon_7',
				text = "SEARCH_DUNGEON_OPTION_36",
				reqs = [],
				dialogue_argument = 4,
			},
			{
				code = 'princess_search_dungeon_7',
				text = "SEARCH_DUNGEON_OPTION_37",
				reqs = [],
				dialogue_argument = 5,
			},
			{
				code = 'princess_search_dungeon_7',
				text = "SEARCH_DUNGEON_OPTION_38",
				reqs = [],
				dialogue_argument = 6,
			},
		],
	},
	princess_search_dungeon_13 = {
		reqs = [],
		image = null,
		character = "aire",
		custom_background = "jail",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_13", reqs = [], previous_dialogue_option = 1},
			],
		options = [
			{
				code = 'princess_search_dungeon_14',
				text = "SEARCH_DUNGEON_OPTION_39",
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_14',
				text = "SEARCH_DUNGEON_OPTION_40",
				reqs = [],
				dialogue_argument = 2,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = '+'}]
			},
			{
				code = 'princess_search_dungeon_14',
				text = "SEARCH_DUNGEON_OPTION_41",
				reqs = [],
				dialogue_argument = 3,
			},
			{
				code = 'princess_search_dungeon_14',
				text = "SEARCH_DUNGEON_OPTION_42",
				reqs = [],
				dialogue_argument = 4,
			},
		],
	},
	princess_search_dungeon_14 = {
		reqs = [],
		image = null,
		character = "aire",
		custom_background = "jail",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SEARCH_DUNGEON_14_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_14_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_14_3", reqs = [], previous_dialogue_option = 3},
			{text = "SEARCH_DUNGEON_14_4", reqs = [], previous_dialogue_option = 4},
			],
		options = [
			{
				code = 'princess_search_dungeon_15',
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 5}]},
					{type = 'local_counter', name = 'sympathy', operant = 'gte', value = 4, check = true}
				],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_15',
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 5}]},
					{type = 'local_counter', name = 'sympathy', operant = 'gte', value = 3, check = true}
				],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_7',
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 5}]},
					{type = 'local_counter', name = 'sympathy', operant = 'gte', value = 4, check = false}
				],
				dialogue_argument = 7,
			},
			{
				code = 'princess_search_dungeon_7',
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 5}]},
					{type = 'local_counter', name = 'sympathy', operant = 'gte', value = 3, check = false}
				],
				dialogue_argument = 7,
			},
		],
	},
	princess_search_dungeon_15 = {
		image = null,
		character = "aire",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_DUNGEON_15", reqs = [], bonus_effects = [{code = 'decision', value = 'interrogation_success'}]}],
		options = [
			{
				code = 'princess_search_dungeon_16',
				text = "DIALOGUELEAVE",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'progress_quest', value = 'princess_search', stage = 'stage3'}],
			},
		],
	},
	princess_search_dungeon_16 = {
		image = null,
		character = "amelia",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_DUNGEON_16", reqs = []}],
		options = [
			{
				code = 'princess_search_dungeon_17',
				text = "SEARCH_DUNGEON_OPTION_43",
				reqs = [{type = 'decision', value = 'interrogation_success', check = true}],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_18',
				text = "SEARCH_DUNGEON_OPTION_44_1",
				reqs = [{type = 'decision', value = 'interrogation_success', check = false}],
				dialogue_argument = 1,
			},
			{
				code = 'princess_search_dungeon_18',
				text = "SEARCH_DUNGEON_OPTION_44_2",
				reqs = [{type = 'decision', value = 'interrogation_success', check = false}],
				dialogue_argument = 1,
			},
		],
	},
	princess_search_dungeon_17 = {
		image = null,
		character = "amelia",
		custom_background = "jail",
		tags = [],
		text = [{text = "SEARCH_DUNGEON_17", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
			},
		],
	},
	princess_search_dungeon_18 = {
		image = null,
		character = "amelia",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [{text = "SEARCH_DUNGEON_18", reqs = []}],
		options = [
			{
				code = 'princess_search_dungeon_19',
				text = "SEARCH_DUNGEON_OPTION_45",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'amelia_help_interogation'}, {code = 'add_timed_event', value = "aire_amelia1", args = [{type = 'add_to_date', date = [2,2], hour = 3}]}, {code = 'add_timed_event', value = "aire_amelia_report", args = [{type = 'add_to_date', date = [3,3], hour = 1}]}]
			},
			{
				code = 'princess_search_dungeon_19',
				text = "SEARCH_DUNGEON_OPTION_46",
				reqs = [{type = 'decision', value = 'bracelet_found', check = false}],
				dialogue_argument = 2,
				bonus_effects = [{code = 'decision', value = 'search_advice_4'}]
			},
			{
				code = 'princess_search_dungeon_19',
				text = "SEARCH_DUNGEON_OPTION_47",
				reqs = [{type = 'decision', value = 'bracelet_found', check = true}],
				dialogue_argument = 3,
				bonus_effects = [{code = 'decision', value = 'search_advice_4'}]
			},
		],
	},
	princess_search_dungeon_19 = {
		image = null,
		character = "amelia",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [
			{text = "SEARCH_DUNGEON_19_1", reqs = [], previous_dialogue_option = 1},
			{text = "SEARCH_DUNGEON_19_2", reqs = [], previous_dialogue_option = 2},
			{text = "SEARCH_DUNGEON_19_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'close',
				text = "SEARCH_DUNGEON_OPTION_48",
				reqs = [],
				bonus_effects = [{code = 'update_city'},{code = 'background_noise', value = 'resume'}],
			},
		],
	},


	aire_amelia1 = {
		image = null,
		character = "aire",
		character2 = "amelia",
		tags = ['dialogue_scene'],
		reqs = [{type = 'quest_completed', name = 'princess_search', check = false}],
		text = [
			{text = "AIRE_AMELIA1", reqs = []},
		],
		options = [
			{code = 'aire_amelia2' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia2 = {
		image = null,
		custom_background = "aire_amelia1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA2", reqs = []},
		],
		options = [
			{code = 'aire_amelia3' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia3 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA3", reqs = []},
		],
		options = [
			{code = 'aire_amelia4' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia4 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA4", reqs = []},
		],
		options = [
			{code = 'aire_amelia5' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia5 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA5", reqs = []},
		],
		options = [
			{code = 'aire_amelia6' , text = tr("DIALOGUECONTINUE"), reqs = [], dialogue_argument = 1}
		]
	},
	aire_amelia6 = {
		image = null,
		custom_background = "aire_amelia2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_AMELIA6", reqs = []},
		],
		options = [
			{code = 'close' , text = tr("DIALOGUECONTINUE"), reqs = [], bonus_effects = [
				{code = 'rewrite_save'}, 
				{code = 'screen_black_transition', value = 1}
				]}
		]
	},

	aire_amelia_report = {
		image = null,
		tags = [],
		text = [{text = "AIREAMELIAREPORT", reqs = []}],
		common_effects = [{code = "decision", value = 'amelia_interrogation_success'}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				bonus_effects = [{code = 'rewrite_save'}], 
			},
		],

	},

	amelia_interrogation_report = {
		image = null,
		tags = [],
		text = [
			{text = "AIREAMELIAREPORT", reqs = []},
		],
		options = [
			{code = 'close' , text = tr("DIALOGUECLOSE"), reqs = [], dialogue_argument = 1, }
		]
	},

	amelia_ask_location = {
		character = 'amelia',
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIREAMELIAMEET1", reqs = []},
		],
		options = [
			{code = 'amelia_ask_location1' , text = "AIREAMELIAMEET1_OPTION1", reqs = [], dialogue_argument = 1},
			{code = 'amelia_ask_location2' , text = "AIREAMELIAMEET1_OPTION2", reqs = [], dialogue_argument = 2}
		]
	},
	amelia_ask_location1 = {
		character = 'amelia',
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIREAMELIAMEET2", reqs = []},
		],
		options = [
			{code = 'close' , text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'progress_quest', value = 'princess_search', stage = 'stage3'}, {code = "decision", value = 'amelia_accepted_interrogation_info'}]},
		]
	},
	amelia_ask_location2 = {
		character = 'amelia',
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIREAMELIAMEET2_1", reqs = []},
		],
		options = [
			{code = 'close' , text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		]
	},

	amelia_princess_advice = {
		character = 'amelia',
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AMELIAFINDPRINCESS1_1", reqs = [{type = 'decision', value = 'aire_is_dead', check = false},{type = 'decision', value = 'prison_avail', check = false}]},
			{text = "AMELIAFINDPRINCESS1_2", reqs = [{type = 'decision', value = 'aire_is_dead', check = false},{type = 'decision', value = 'prison_avail', check = true}]},
			{text = "AMELIAFINDPRINCESS1_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = true}]},
		],
		common_effects = [{code = "decision", value = "AllowSearch"}],
		options = [
			{code = 'amelia_princess_advice1' , text = "AMELIAFINDPRINCESSOPTION1", reqs = [], dialogue_argument = 1},
			{code = 'amelia_princess_advice1' , text = "AMELIAFINDPRINCESSOPTION2", reqs = [], dialogue_argument = 2},
			{code = 'amelia_princess_advice1' , text = "AMELIAFINDPRINCESSOPTION3", reqs = [], dialogue_argument = 3},
		]
	},
	amelia_princess_advice1 = {
		character = 'amelia',
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AMELIAFINDPRINCESS2_1", reqs = [], previous_dialogue_option = [1,2]},
			{text = "AMELIAFINDPRINCESS2_2", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = 'close' , text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		]
	},

}

