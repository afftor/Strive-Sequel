extends Reference
var data = {
	emp_city_init = {
		image = 'letter',
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [{text = "EMP_CITY_INIT",reqs = [],}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "plan_loc_event", loc = "empire_capital", event = "emp_city_enter_0"}, #if not planned at world creating
					{code = "progress_quest", value = "act_4_capital", stage = "enter_capital"},
					{code = "decision", value = "act4_start"},
					]
			},
		]
	},
	emp_city_enter_0 = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene"],
		text = [
			{text = "EMP_CITY_ENTER_0", reqs = []},
			{
				text = "EMP_CITY_ENTER_0_BAD1",
				reqs = [
					{
						type = "decision",
						value = "act1_finish",
						check = false
					}
				]
			},
			{
				text = "EMP_CITY_ENTER_0_BAD2",
				reqs = [
					{
						type = "decision",
						value = "act1_finish",
						check = true
					},
					{
						type = "active_quest_stage",
						value = "act_4_capital",
						stage = "enter_capital",
						state = false
					}
				]
			},
			{
				text = "EMP_CITY_ENTER_0_GOOD",
				reqs = [
					{
						type = "active_quest_stage",
						value = "act_4_capital",
						stage = "enter_capital",
					}
				]
			},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "act_4_capital",
						stage = "enter_capital",
						state = false
					}
				],
				dialogue_argument = 9,
				bonus_effects = [
					{code = "return_to_mansion"},
					{code = "plan_loc_event", loc = "empire_capital", event = "emp_city_enter_0"}
				]
			},
			{
				code = "emp_city_enter_1",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "active_quest_stage",
						value = "act_4_capital",
						stage = "enter_capital",
					}
				],
				dialogue_argument = 1
			},
		],
	},
	emp_city_enter_1 = {
		reqs = [],
		image = null,
		character = "grotus",
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_CITY_ENTER_1",reqs = []}],
		options = [
			{code = "emp_city_enter_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_city_enter_2 = {
		reqs = [],
		image = null,
		character = "grotus",
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_CITY_ENTER_2",reqs = []}],
		options = [
			{code = "emp_city_enter_3", text = "EMP_CITY_ENTER_2_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "emp_city_enter_3", text = "EMP_CITY_ENTER_2_OPTION_2", reqs = [], type = "next_dialogue"},
			{code = "emp_city_enter_3", text = "EMP_CITY_ENTER_2_OPTION_3", reqs = [], type = "next_dialogue"},
		]
	},
	emp_city_enter_3 = {
		reqs = [],
		image = null,
		character = "grotus",
		tags = ["dialogue_scene",],
		text = "EMP_CITY_ENTER_3",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "act_4_capital", stage = "wait1"},
					{
						code = "add_timed_event",
						value = {quest = "act_4_capital", stage = "ceremony"},
						args = [{type = "action_to_date", date = [1, 1], hour = 1, action = "quest"}]
					}
				]
			}
		],
	},
	
	emp_ceremony_1 = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", 'blackscreen_transition_common'],
		text = [{text = "EMP_CEREMONY_1",reqs = []}],
		options = [
			{code = "emp_ceremony_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_ceremony_2 = {
		reqs = [],
		image = null,
		character = 'grotus', character2 = 'zephyras_sister',
		tags = ["dialogue_scene"],
		text = [{text = "EMP_CEREMONY_2",reqs = []}],
		options = [
			{code = "emp_ceremony_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_ceremony_3 = {
		reqs = [],
		image = null,
		character = 'emperor',
		tags = ["dialogue_scene", 'blackscreen_transition_common'],
		text = [{text = "EMP_CEREMONY_3",reqs = []}],
		options = [
			{code = "emp_ceremony_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_ceremony_4 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister',
		tags = ["dialogue_scene", 'blackscreen_transition_common'],
		text = [{text = "EMP_CEREMONY_4",reqs = []}],
		options = [
			{code = "emp_ceremony_5", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", dialogue_argument = 1, bonus_effects = [{code = 'screen_black_transition', value = 1}],},
		]
	},
	emp_ceremony_5 = {
		reqs = [],
		image = null,
		character = 'emperor',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [
			{text = "EMP_CEREMONY_5_0", reqs = [], previous_dialogue_option = 1},
			{text = "EMP_CEREMONY_5_1", reqs = [], previous_dialogue_option = 2},
			{text = "EMP_CEREMONY_5_2", reqs = [], previous_dialogue_option = 3},
			{text = "EMP_CEREMONY_5_3", reqs = [], previous_dialogue_option = 4},
			{text = "EMP_CEREMONY_5_4", reqs = [], previous_dialogue_option = 5},
		],
		options = [
			{code = "emp_ceremony_5", text = "EMP_CEREMONY_5_OPTION_1", reqs = [], dialogue_argument = 2, previous_dialogue_option = 1, remove_after_first_use = true},
			{code = "emp_ceremony_5", text = "EMP_CEREMONY_5_OPTION_2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
			{code = "emp_ceremony_5", text = "EMP_CEREMONY_5_OPTION_3", reqs = [],  dialogue_argument = 4, remove_after_first_use = true},
			{code = "emp_ceremony_5", text = "EMP_CEREMONY_5_OPTION_4", reqs = [], dialogue_argument = 5, remove_after_first_use = true},
			{code = "emp_ceremony_6", text = "EMP_CEREMONY_5_OPTION_5", reqs = [], type = "next_dialogue", dialogue_argument = 1, previous_dialogue_option = [3, 4, 5]},
			{code = "emp_ceremony_6", text = "EMP_CEREMONY_5_OPTION_6", reqs = [], type = "next_dialogue", dialogue_argument = 2, previous_dialogue_option = [3, 4, 5]},
		],
	},
	emp_ceremony_6 = {
		reqs = [],
		image = null,
		character = 'emperor',
		tags = ["dialogue_scene", 'master_translate'],
		text = [
			{text = "EMP_CEREMONY_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "EMP_CEREMONY_6_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [
			{code = "emp_ceremony_7", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_ceremony_7 = {
		variations = [
			{
				reqs = [
					{type = "location_has_specific_slaves", check = true, value = 1, location = 'empire_capital', reqs = [{code = 'unique', value = 'zephyra'}]},
					{type = "location_has_specific_slaves", check = true, value = 1, location = 'empire_capital', reqs = [{code = 'unique', value = 'kuro'}]},
					],
				image = null,
				character = 'zephyras_sister',
				tags = ["dialogue_scene", 'master_translate', 'blackscreen_transition_common'],
				text = [
					{text = "EMP_CEREMONY_7", reqs = []},
					{text = "EMP_CEREMONY_7_1", reqs = []},
					],
				options = [
					{code = "emp_foxes_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
				]
			},
			{
				reqs = [],
				image = null,
				character = 'zephyras_sister',
				tags = ["dialogue_scene", 'master_translate', 'blackscreen_transition_common'],
				text = [
					{text = "EMP_CEREMONY_7", reqs = []},
					],
				options = [
					{code = "emp_ceremony_8", text = "EMP_CEREMONY_7_OPTION_1", reqs = [], dialogue_argument = 1},
					{code = "emp_ceremony_8", text = "EMP_CEREMONY_7_OPTION_2", reqs = [], dialogue_argument = 2},
				]
			},
		]
	},
	emp_foxes_1 = {
		reqs = [],
		image = null,
		character = 'zephyra', character2 = 'kuro',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_FOXES_1",reqs = []}],
		options = [
			{code = "emp_foxes_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_foxes_2 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister', character2 = 'kuro',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_FOXES_2",reqs = []}],
		options = [
			{code = "emp_foxes_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_foxes_3 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister', character2 = 'zephyra',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_FOXES_3",reqs = []}],
		options = [
			{code = "emp_foxes_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_foxes_4 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister', character2 = 'kuro',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_FOXES_4",reqs = []}],
		options = [
			{code = "emp_ceremony_9", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_ceremony_8 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister',
		tags = ["dialogue_scene", 'master_translate'],
		text = [
			{text = "EMP_CEREMONY_8_1",reqs = [], previous_dialogue_option = 1},
			{text = "EMP_CEREMONY_8_2",reqs = [], previous_dialogue_option = 2},
			{text = "EMP_CEREMONY_8",reqs = []},
			],
		options = [
			{code = "emp_ceremony_9", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_ceremony_9 = {
		reqs = [],
		image = null,
		character = "zephyras_sister",
		tags = ["dialogue_scene",],
		text = "EMP_CEREMONY_9",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "act_4_capital", stage = "wait2"},
					{
						code = "add_timed_event",
						value = {quest = "act_4_capital", stage = "arena"},
						args = [{type = "action_to_date", date = [1, 1], hour = 1, action = "quest"}]
					},
					{code = "update_city"},
				]
			}
		],
	},
	
	emp_arena_1 = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_1",reqs = []}],
		options = [
			{code = "emp_arena_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_arena_2 = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_2",reqs = []}],
		options = [
			{code = "emp_arena_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_arena_3 = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene", 'master_translate', 'blackscreen_transition_common'],
		text = [{text = "EMP_ARENA_3",reqs = []}],
		options = [
			{code = "emp_arena_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_arena_4 = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_4",reqs = []}],
		options = [
			{code = "emp_arena_5", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_arena_5 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister',
		tags = ["dialogue_scene", 'master_translate', 'blackscreen_transition_common'],
		text = [{text = "EMP_ARENA_5",reqs = []}],
		options = [
			{
				code = "quest_fight",
				args = "arena_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	emp_arena_6 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_6",reqs = []}],
		options = [
			{code = "emp_arena_7", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_arena_7 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister', character2 = 'greg',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_7",reqs = []}],
		options = [
			{code = "emp_arena_8", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_arena_8 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister', character2 = 'greg',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_8",reqs = []}],
		options = [
			{
				code = "quest_fight",
				args = "greg_arena_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	emp_arena_9 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ARENA_9",reqs = []}],
		options = [
			{code = "emp_arena_10", text = "EMP_ARENA_9_OPTION_1", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "emp_arena_10", text = "EMP_ARENA_9_OPTION_2", reqs = [], type = "next_dialogue", dialogue_argument = 2},
			{code = "emp_arena_10", text = "EMP_ARENA_9_OPTION_3", reqs = [], type = "next_dialogue", dialogue_argument = 3},
		]
	},
	emp_arena_10 = {
		reqs = [],
		image = null,
		character = 'zephyras_sister',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [
			{text = "EMP_ARENA_10_1", reqs = [], previous_dialogue_option = 1},
			{text = "EMP_ARENA_10_2", reqs = [], previous_dialogue_option = 2},
			{text = "EMP_ARENA_10_3", reqs = [], previous_dialogue_option = 3},
			{text = "EMP_ARENA_10_4", reqs = [], previous_dialogue_option = 4},
			{text = "EMP_ARENA_10_5", reqs = [], previous_dialogue_option = 5},
		],
		options = [
			{code = "emp_arena_10", text = "EMP_ARENA_10_OPTION_1", reqs = [], dialogue_argument = 4},
			{code = "emp_arena_10", text = "EMP_ARENA_10_OPTION_2", reqs = [], dialogue_argument = 5},
			{code = "emp_arena_11", text = "EMP_ARENA_10_OPTION_3", reqs = [], type = "next_dialogue",},
		],
	},
	emp_arena_11 = {
		reqs = [],
		image = null,
		character = "zephyras_sister",
		tags = ["dialogue_scene",],
		text = "EMP_ARENA_11",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "act_4_capital", stage = "act4_continue"},
					{code = "update_city"},
				]
			}
		],
	},
	
	emp_erdyna_intro_1 = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ERDYNA_INTRO_1",reqs = []}],
		options = [
			{code = "emp_erdyna_intro_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_erdyna_intro_2 = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ERDYNA_INTRO_2",reqs = []}],
		options = [
			{
				code = "quest_fight",
				args = "erdyna_thugs_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_intro_3 = {
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [{text = "EMP_ERDYNA_INTRO_3", reqs = []}],
		options = [
			{code = "emp_erdyna_intro_5", text = "EMP_ERDYNA_INTRO_3_OPTION_1", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "emp_erdyna_intro_4", text = "EMP_ERDYNA_INTRO_3_OPTION_2", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "emp_erdyna_intro_5", text = "EMP_ERDYNA_INTRO_3_OPTION_3", reqs = [], type = "next_dialogue", dialogue_argument = 2},
		],
	},
	emp_erdyna_intro_4 = {
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [{text = "EMP_ERDYNA_INTRO_4", reqs = []}],
		options = [
			{code = "emp_erdyna_intro_duel", text = "EMP_ERDYNA_INTRO_DUEL_OPTION", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "emp_erdyna_intro_5", text = "EMP_ERDYNA_INTRO_4_OPTION_2", reqs = [], type = "next_dialogue", dialogue_argument = 3},
		],
	},
	emp_erdyna_intro_duel = {
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ERDYNA_INTRO_DUEL",reqs = []}],
		options = [
			{
				code = "quest_fight",
				args = "erdyna_duel_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_intro_6 = { #after duel route
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [
			{text = "EMP_ERDYNA_INTRO_6_1", reqs = [], previous_dialogue_option = 0},
			{text = "EMP_ERDYNA_INTRO_6_2", reqs = [], previous_dialogue_option = 1},
			],
		options = [
			{code = "emp_erdyna_intro_6", text = "EMP_ERDYNA_INTRO_6_OPTION_1", reqs = [], type = "next_dialogue", remove_after_first_use = true, dialogue_argument = 1},
			{code = "emp_erdyna_intro_10", text = "EMP_ERDYNA_INTRO_6_OPTION_2", reqs = [], type = "next_dialogue", dialogue_argument = 1},
		],
	},
	emp_erdyna_intro_5 = {
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [
			{text = "EMP_ERDYNA_INTRO_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "EMP_ERDYNA_INTRO_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "EMP_ERDYNA_INTRO_5_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = "emp_erdyna_intro_7", text = "EMP_ERDYNA_INTRO_5_OPTION_1", reqs = [], previous_dialogue_option = 1},
			{code = "emp_erdyna_intro_duel", text = "EMP_ERDYNA_INTRO_DUEL_OPTION", reqs = [], type = "next_dialogue", previous_dialogue_option = 2},
			{code = "emp_erdyna_intro_10", text = "EMP_ERDYNA_INTRO_5_OPTION_0", reqs = [], type = "next_dialogue", dialogue_argument = 1},
		],
	},
	emp_erdyna_intro_7 = { #guards route
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ERDYNA_INTRO_7",reqs = []}],
		options = [
			{code = "emp_erdyna_intro_8", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"},
		]
	},
	emp_erdyna_intro_8 = { #guards route
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_translate'],
		text = [{text = "EMP_ERDYNA_INTRO_8",reqs = []}],
		options = [
			{code = "emp_erdyna_intro_9", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", dialogue_argument = 1},
		]
	},
	emp_erdyna_intro_9 = { #guards route
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [
			{text = "EMP_ERDYNA_INTRO_9_1", reqs = [], previous_dialogue_option = 1},
			{text = "EMP_ERDYNA_INTRO_9_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [
			{code = "emp_erdyna_intro_9", text = "EMP_ERDYNA_INTRO_9_OPTION_1", reqs = [], type = "next_dialogue", remove_after_first_use = true, dialogue_argument = 2},
			{code = "emp_erdyna_intro_10", text = "EMP_ERDYNA_INTRO_9_OPTION_2", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			
		],
	},
	emp_erdyna_intro_10 = { 
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [
			{text = "EMP_ERDYNA_INTRO_10_1", reqs = [], previous_dialogue_option = 1},
			{text = "EMP_ERDYNA_INTRO_10_2", reqs = [], previous_dialogue_option = 2},
			{text = "EMP_ERDYNA_INTRO_10_3", reqs = [], previous_dialogue_option = 3},
			],
		options = [
			{code = "emp_erdyna_intro_10", text = "EMP_ERDYNA_INTRO_10_OPTION_1", reqs = [], type = "next_dialogue", remove_after_first_use = true, dialogue_argument = 2},
			{code = "emp_erdyna_intro_10", text = "EMP_ERDYNA_INTRO_10_OPTION_2", reqs = [], type = "next_dialogue", remove_after_first_use = true, dialogue_argument = 3},
			{code = "emp_erdyna_intro_11", text = "EMP_ERDYNA_INTRO_10_OPTION_3", reqs = [], type = "next_dialogue"},
		],
	},
	emp_erdyna_intro_11 = { 
		reqs = [],
		image = null,
		character = 'erdyna',
		tags = ["dialogue_scene", 'master_tarnslate'],
		text = [{text = "EMP_ERDYNA_INTRO_11", reqs = []},],
		options = [
			{code = "emp_erdyna_intro_12", text = "EMP_ERDYNA_INTRO_11_OPTION_1", reqs = [], type = "next_dialogue"},
			{code = "emp_erdyna_intro_12", text = "EMP_ERDYNA_INTRO_11_OPTION_2", reqs = [], type = "next_dialogue"},
		],
	},
	emp_erdyna_intro_12 = {
		reqs = [],
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene",],
		text = "EMP_ERDYNA_INTRO_12",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [ #2add new char
#					{code = "complete_quest", value = "act_4_capital"},
				]
			}
		],
	},
}
