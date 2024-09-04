var data = {
	dking_second_task_start = {
		tags = ["dialogue_scene"],
		character = 'dwarf_king',
		reqs = [],
		text = [{
				text = "DKING_SECOND_TASK_START",
				reqs = [],
				previous_dialogue_option = 0
			},{
				text = "DKING_SECOND_TASK_REPLY1",
				reqs = [],
				previous_dialogue_option = 1
			},{
				text = "DKING_SECOND_TASK_REPLY2",
				reqs = [],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dking_second_task_start",
				text = "DKING_SECOND_TASK_OPT_1",
				reqs = [],
				dialogue_argument = 1
			},{
				code = "dking_second_task_start",
				text = "DKING_SECOND_TASK_OPT_2",
				reqs = [],
				dialogue_argument = 2
			},{
				code = "dking_second_task_1",
				text = "DKING_SECOND_TASK_OPT_3",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0
			}
		]
	},
	dking_second_task_1 = {
		tags = ["dialogue_scene"],
		character = 'dwarf_king',
		reqs = [],
		text = [{
				text = "DKING_SECOND_TASK_1",
				reqs = [],
				previous_dialogue_option = 0
			},{
				text = "DKING_SECOND_TASK_1_REPLY1",
				reqs = [],
				previous_dialogue_option = 1
			},{
				text = "DKING_SECOND_TASK_1_REPLY2",
				reqs = [],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dking_second_task_1",
				text = "DKING_SECOND_TASK_1_OPT_1",
				reqs = [],
				dialogue_argument = 1,
			},{
				code = "dking_second_task_1",
				text = "DKING_SECOND_TASK_1_OPT_2",
				reqs = [],
				dialogue_argument = 2,
			},{
				code = "dking_second_task_2",
				text = "DKING_SECOND_TASK_1_OPT_3",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0,
			}
		]
	},
	dking_second_task_2 = {
		tags = ["dialogue_scene"],
		character = 'dwarf_king',
		reqs = [],
		text = [{text = "DKING_SECOND_TASK_2", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					#add option "Visit Hara" in dwarf capital/palace
				]
			}
		]
	},
	dking2task_hara_start = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [{text = "DKING2TASK_HARA_START", reqs = []}],
		options = [
			{
				code = "dking2task_hara_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0
			}
		]
	},
	dking2task_hara_1 = {
		tags = ["dialogue_scene"],
		custom_background = "kuro_book_0",
		reqs = [],
		text = [{text = "DKING2TASK_HARA_1", reqs = []}],
		options = [
			{
				code = "dking2task_hara_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 1
			}
		]
	},
	dking2task_hara_2 = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{text = "DKING2TASK_HARA_2", reqs = [], previous_dialogue_option = 1}
			#add text for further starts
		],
		options = [
			{
				code = "dking2task_hara_3",
				text = "DKING2TASK_HARA_2_OPT_1",
				reqs = [
					{type = "quest_completed", name = "hara_capacitor_quest", check = false}
				],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = "dking2task_kuro_1",
				text = "DKING2TASK_HARA_2_OPT_2",
				reqs = [{type = 'dialogue_seen', check = false, value = 'DKING2TASK_KURO_3'}],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = "kuro_questions",
				text = "DKING2TASK_HARA_2_OPT_2",
				reqs = [{type = 'dialogue_seen', check = true, value = 'DKING2TASK_KURO_3'}],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = 'close',
				text = "DIALOGUELEAVE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	dking2task_hara_3 = {
		tags = ["dialogue_scene"],
		character = 'hara',
		reqs = [],
		text = [
			{
				text = "DKING2TASK_HARA_3",
				reqs = [],
				previous_dialogue_option = 0
			},{
				text = "DKING2TASK_HARA_SO_KING",
				reqs = [{type = 'dialogue_seen', check = false, value = 'DKING2TASK_HARA_SO_KING'}],
				previous_dialogue_option = 0
			},{
				text = "DKING2TASK_HARA_3_REPLY1",
				reqs = [],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "dking2task_hara_4",
				text = "DKING2TASK_HARA_3_OPT_1",
				reqs = [
					{type = "has_active_quest", name = "hara_shimore_quest", check = false},
					{type = "quest_completed", name = "hara_shimore_quest", check = false}
				],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = "dking2task_hara_3",
				text = "DKING2TASK_HARA_3_OPT_2",
				reqs = [],
				dialogue_argument = 1
			},{
				code = "dking2task_hara_5",
				text = "DKING2TASK_HARA_3_OPT_3",
				reqs = [{type = 'active_quest_stage', value = 'hara_shimore_quest', stage = 'bring_ore'}],
				bonus_effects = [
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'},#2nd
					{code = 'complete_quest', value = 'hara_shimore_quest'}
				],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = "dking2task_hara_8",
				text = "DKING2TASK_HARA_3_OPT_4",
				reqs = [{type = 'active_quest_stage', value = 'hara_sacsap_quest', stage = 'bring_sap'}],
				bonus_effects = [
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'},#4th
					{code = 'complete_quest', value = 'hara_sacsap_quest'}#or at the end of dialog?
				],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = "dking2task_hara_10",
				text = "DKING2TASK_HARA_3_OPT_5",
				reqs = [{type = 'active_quest_stage', value = 'hara_capacitor_quest', stage = 'bring_cap'}],
				bonus_effects = [
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'},#6th
					{code = 'complete_quest', value = 'hara_capacitor_quest'}#or at the end of dialog?
				],
				type = 'next_dialogue',
				dialogue_argument = 0
			}
		]
	},
	dking2task_hara_4 = {
		tags = ["dialogue_scene"],
		character = 'hara',
		reqs = [],
		text = [{text = "DKING2TASK_HARA_4", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_shimore_quest', stage = 'get_ore'}
				]
			}
		]
	},
	shimmering_ore_start = {
		tags = ["dialogue_scene"],
		reqs = [],
		common_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '+'}],#1st
		text = [
			{
				text = "SHIMMERING_ORE_START_REVISIT",
				reqs = [{type = 'dialogue_seen', check = true, value = 'SHIMMERING_ORE_START'}]
			},{
				text = "SHIMMERING_ORE_START",
				reqs = [{type = 'dialogue_seen', check = false, value = 'SHIMMERING_ORE_START'}]
			}
		],
		options = [
			{
				code = "shimmering_ore_1",
				text = "SHIMMERING_ORE_START_OPT_1",
				reqs = [{type = 'has_money', value = 1000}],
				type = 'next_dialogue',
				dialogue_argument = 0,
				bonus_effects = [
					{code = 'money_change', operant = '-', value = 1000}
				]
			},{
				code = "close",
				text = "SHIMMERING_ORE_START_OPT_2",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_shimore_quest', stage = 'get_gold'}
				]
			}
		]
	},
	shimmering_ore_1 = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [{text = "SHIMMERING_ORE_1", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_shimore_quest', stage = 'bring_ore'}
				]
			}
		]
	},
	dking2task_hara_5 = {
		tags = ["dialogue_scene", "master_translate"],
		character = 'hara',
		reqs = [],
		text = [
			{
				text = "DKING2TASK_HARA_5",
				reqs = [],
				previous_dialogue_option = 0,
			},{
				text = "DKING2TASK_HARA_5_REPLY1",
				reqs = [],
				previous_dialogue_option = 1
			},{
				text = "DKING2TASK_HARA_5_REPLY2",
				reqs = [],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dking2task_hara_5",
				text = "DKING2TASK_HARA_5_OPT_1",
				reqs = [],
				dialogue_argument = 1,
			},{
				code = "dking2task_hara_5",
				text = "DKING2TASK_HARA_5_OPT_2",
				reqs = [],
				dialogue_argument = 2,
			},{
				code = "dking2task_hara_6",
				text = "DKING2TASK_HARA_5_OPT_3",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	dking2task_hara_6 = {
		tags = ["dialogue_scene"],
		character = 'hara', character2 = 'kuro',
		reqs = [],
		text = [{text = "DKING2TASK_HARA_6", reqs = []}],
		options = [
			{
				code = "dking2task_hara_7",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	dking2task_hara_7 = {
		tags = ["dialogue_scene"],
		character = 'hara',
		reqs = [],
		text = [{text = "DKING2TASK_HARA_7", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_sacsap_quest', stage = 'get_sap'}
				]
			}
		]
	},
	
	sacred_sap_heleviel_start = {
		tags = ["dialogue_scene", "master_translate"],
		character = 'elf_priestess',
		reqs = [],
		text = [{text = "SACRED_SAP_HELEVIEL_START", reqs = []}],
		options = [
			{
				code = "sacred_sap_heleviel_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_heleviel_2 = {
		tags = ["dialogue_scene", "master_translate"],
		character = 'elf_priestess',
		reqs = [],
		text = [
			{text = "SACRED_SAP_HELEVIEL_2", reqs = [], previous_dialogue_option = 0},
			{text = "SACRED_SAP_HELEVIEL_2_REPLY1", reqs = [], previous_dialogue_option = 1}
		],
		options = [
			{
				code = "sacred_sap_heleviel_2",
				text = "SACRED_SAP_HELEVIEL_2_OPT_1",
				reqs = [],
				dialogue_argument = 1,
			},{
				code = "sacred_sap_heleviel_3",
				text = "SACRED_SAP_HELEVIEL_2_OPT_2",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_heleviel_3 = {
		tags = ["dialogue_scene"],
		character = 'elf_priestess',
		reqs = [],
		text = [{text = "SACRED_SAP_HELEVIEL_3", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_sacsap_quest', stage = 'h_scouts'},
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'},#3rd (parallel with Lira's)
					{code = 'add_timed_event', value = "sacred_sap_intermission_start", args = [{type = 'add_to_hour', hour = [1,1]}]}
				]
			}
		]
	},
	sacred_sap_fighters_start = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [{text = "SACRED_SAP_FIGHTERS_START", reqs = [], previous_dialogue_option = 0}],
		options = [
			{
				code = "sacred_sap_fighters_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_fighters_1 = {
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = [{text = "SACRED_SAP_FIGHTERS_1", reqs = [], previous_dialogue_option = 0}],
		options = [
			{
				code = "sacred_sap_fighters_2",
				text = "SACRED_SAP_FIGHTERS_1_OPT1",
				reqs = [],
				dialogue_argument = 0
			},{
				code = "sacred_sap_fighters_2",
				text = "SACRED_SAP_FIGHTERS_1_OPT2",
				reqs = [],
				dialogue_argument = 0
			}
		]
	},
	sacred_sap_fighters_2 = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [{text = "SACRED_SAP_FIGHTERS_2", reqs = [], previous_dialogue_option = 0}],
		options = [
			{
				code = "sacred_sap_fighters_3",
				text = "SACRED_SAP_FIGHTERS_2_OPT1",
				reqs = [],
				dialogue_argument = 0
			},{
				code = "sacred_sap_fighters_3",
				text = "SACRED_SAP_FIGHTERS_2_OPT2",
				reqs = [],
				dialogue_argument = 0
			}
		]
	},
	sacred_sap_fighters_3 = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{text = "SACRED_SAP_FIGHTERS_3", reqs = [], previous_dialogue_option = 0},
			{text = "SACRED_SAP_FIGHTERS_3_REVISIT", reqs = [], previous_dialogue_option = 1},
		],
		options = [
			{
				code = "sacred_sap_fighters_4",
				text = "SACRED_SAP_FIGHTERS_3_OPT1",
				reqs = [{type = 'has_money', value = 1000},
					{type = 'faction_reputation', code = 'fighters', operant = 'gte', value = 1000}],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [{code = 'money_change', operant = '-', value = 1000}]
			},{
				code = "sacred_sap_fighters_4",
				text = "SACRED_SAP_FIGHTERS_3_OPT2",
				reqs = [
					#has 2 female elven slaves
				],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					#remove 2 female elven slaves
				]
			},{
				code = "close",
				text = "SACRED_SAP_FIGHTERS_3_OPT3",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0,
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_sacsap_quest', stage = 'h_price'},
				]
			}
		]
	},
	sacred_sap_fighters_4 = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [{text = "SACRED_SAP_FIGHTERS_4", reqs = []}],
		options = [
			{
				code = "sacred_sap_fighters_5",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_fighters_5 = {
		tags = ["dialogue_scene"],
		reqs = [],
		text = [{text = "SACRED_SAP_FIGHTERS_5", reqs = []}],
		options = [
			{
				code = "sacred_sap_heleviel_4",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_heleviel_4 = {
		tags = ["dialogue_scene", "master_translate"],
		character = 'elf_priestess',
		reqs = [],
		text = [{text = "SACRED_SAP_HELEVIEL_4", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_sacsap_quest', stage = 'bring_sap'}
				],
			}
		]
	},
	sacred_sap_erlen_start = {#change name?
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = 'erlen',
		text = [{text = "SACRED_SAP_ERLEN_START", reqs = []}],
		options = [
			{
				code = "sacred_sap_erlen_1",
				text = "SACRED_SAP_ERLEN_START_OPT1",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			},{
				code = "sacred_sap_erlen_1",
				text = "SACRED_SAP_ERLEN_START_OPT2",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_erlen_1 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'erlen',
		text = [
			{text = "SACRED_SAP_ERLEN_1_REPLY1", reqs = [], previous_dialogue_option = 1},
			{text = "SACRED_SAP_ERLEN_1_REPLY2", reqs = [], previous_dialogue_option = 2},
			{text = "SACRED_SAP_ERLEN_1", reqs = []},
		],
		options = [
			{
				code = "sacred_sap_lira_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_lira_1 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'lira',
		text = [{text = "SACRED_SAP_LIRA_1", reqs = []}],
		options = [
			{
				code = "sacred_sap_lira_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_lira_2 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'lira',
		text = [{text = "SACRED_SAP_LIRA_2", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_sacsap_quest', stage = 'l_price'},
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'},#3rd (parallel with Heleviel's)
					{code = 'add_timed_event', value = "sacred_sap_intermission_start", args = [{type = 'add_to_hour', hour = [1,1]}]}
				]
			}
		]
	},
	sacred_sap_lira_3 = {
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = 'lira',
		text = [{text = "SACRED_SAP_LIRA_3", reqs = []}],
		options = [
			{
				code = "sacred_sap_lira_4",
				text = "SACRED_SAP_LIRA_3_OPT1",
				reqs = [
					{type = 'has_material', operant = 'gte', value = 1000, material = 'wood'},
					{type = 'has_material', operant = 'gte', value = 100, material = 'steel'}
				],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'material_change', operant = '-', material = 'wood', value = 1000},
					{code = 'material_change', operant = '-', material = 'steel', value = 100},
				]
			},{
				code = "close",
				text = "SACRED_SAP_LIRA_3_OPT2",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	sacred_sap_lira_4 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'lira',
		text = [{text = "SACRED_SAP_LIRA_4", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_sacsap_quest', stage = 'bring_sap'}
				]
			}
		]
	},
	
	#plays after visiting heleviel/lira first time, but I yet don't understand, how to do it
	sacred_sap_intermission_start = {
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		character = 'demon_female', character2 = 'zephyras_sister',
		text = [{text = "SACRED_SAP_INTERMISSION_START", reqs = []}],
		options = [
			{
				code = "sacred_sap_intermission_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
			}
		]
	},
	sacred_sap_intermission_1 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'demon_female', character2 = 'zephyras_sister',
		text = [{text = "SACRED_SAP_INTERMISSION_1", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'screen_black_transition', value = 1}#screen closes befor transition
				]
			}
		]
	},
	
	dking2task_hara_8 = {
		tags = ["dialogue_scene"],
		character = 'hara',
		reqs = [],
		text = [{text = "DKING2TASK_HARA_8",reqs = []}],
		options = [
			{
				code = "dking2task_hara_9",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0
			}
		]
	},
	dking2task_hara_9 = {
		tags = ["dialogue_scene"],
		character = 'hara', character2 = 'kuro',
		reqs = [],
		text = [{text = "DKING2TASK_HARA_9",reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				bonus_effects = [
					#add new fiery depths dungeon
					{code = 'progress_quest', value = 'hara_capacitor_quest', stage = 'get_cap'},
				]
			}
		]
	},
	
	capacitor_molten_start = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'zephyras_sister',
		text = [{text = "CAPACITOR_MOLTEN_START", reqs = []}],
		options = [
			{
				code = "capacitor_molten_z_1",
				text = "CAPACITOR_MOLTEN_START_OPT1",
				reqs = [{type = 'has_hero', name = 'zephyra', check = true}],
				dialogue_argument = 0,
			},{
				code = "capacitor_molten_k_1",
				text = "CAPACITOR_MOLTEN_START_OPT2",
				reqs = [],
				dialogue_argument = 0,
			}
		]
	},
	capacitor_molten_z_1 = {
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = 'zephyras_sister', character2 = "zephyra",
		text = [{text = "CAPACITOR_MOLTEN_Z_1", reqs = []}],
		options = [
			{
				code = "capacitor_molten_z_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0
			}
		]
	},
	capacitor_molten_z_2 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'zephyras_sister', character2 = "zephyra",
		text = [{text = "CAPACITOR_MOLTEN_Z_2", reqs = []}],
		options = [
			{
				code = "capacitor_molten_z_3",
				text = "CAPACITOR_MOLTEN_Z_2_OPT1",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0
			},{
				code = "close",
				text = "CAPACITOR_MOLTEN_Z_2_OPT2",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0
			}
		]
	},
	capacitor_molten_z_3 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character2 = "zephyra",
		text = [{text = "CAPACITOR_MOLTEN_Z_3", reqs = []}],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0,
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_capacitor_quest', stage = 'bring_cap'},
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'}#5th (parallel with Kuro's)
				]
			}
		]
	},
	capacitor_molten_k_1 = {
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = 'zephyras_sister', character2 = "kuro",
		text = [{text = "CAPACITOR_MOLTEN_K_1", reqs = []}],
		options = [
			{
				code = "capacitor_molten_k_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 0
			}
		]
	},
	capacitor_molten_k_2 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = 'zephyras_sister', character2 = "kuro",
		text = [{text = "CAPACITOR_MOLTEN_K_2", reqs = []}],
		options = [
			{
				code = "capacitor_molten_k_3",
				text = "CAPACITOR_MOLTEN_K_2_OPT1",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},{
				code = "capacitor_molten_k_3",
				text = "CAPACITOR_MOLTEN_K_2_OPT2",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},{
				code = "capacitor_molten_k_3",
				text = "CAPACITOR_MOLTEN_K_2_OPT3",
				reqs = [],
				dialogue_argument = 3,
				type = 'next_dialogue'
			}
		]
	},
	capacitor_molten_k_3 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character2 = "kuro",
		text = [
			{text = "CAPACITOR_MOLTEN_K_3_REPLY1", reqs = [], previous_dialogue_option = 1},
			{text = "CAPACITOR_MOLTEN_K_3_REPLY2", reqs = [], previous_dialogue_option = 2},
			{text = "CAPACITOR_MOLTEN_K_3_REPLY3", reqs = [], previous_dialogue_option = 3},
			{text = "CAPACITOR_MOLTEN_K_3", reqs = []}
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'progress_quest', value = 'hara_capacitor_quest', stage = 'bring_cap'},
					{code = 'dialogue_counter', name = 'kuros_questions', op = '+'}#5th (parallel with Zephyra's)
				]
			}
		]
	},
	dking2task_hara_10 = {
		tags = ["dialogue_scene"],
		reqs = [],
		character = "hara",
		text = [{text = "DKING2TASK_HARA_10", reqs = []}],
		options = [
			{
				code = 'dking2task_hara_2',
				text = "DIALOGUELEAVE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	
	
	dking2task_kuro_1 = {
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "kuro_book_0",
		text = [{text = "DKING2TASK_KURO_1", reqs = []}],
		options = [
			{
				code = 'dking2task_kuro_2',
				text = "DKING2TASK_KURO_1_OPT1",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},{
				code = 'dking2task_kuro_2',
				text = "DKING2TASK_KURO_1_OPT2",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			}
		]
	},
	dking2task_kuro_2 = {
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "kuro_book_0",
		text = [
			{text = "DKING2TASK_KURO_2_REPLY1", reqs = [], previous_dialogue_option = 1},
			{text = "DKING2TASK_KURO_2_REPLY2", reqs = [], previous_dialogue_option = 2},
			{text = "DKING2TASK_KURO_2_REPLY3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'dking2task_kuro_2',
				text = "DKING2TASK_KURO_2_OPT1",
				reqs = [],
				dialogue_argument = 3
			},{
				code = 'dking2task_kuro_3',
				text = "DKING2TASK_KURO_2_OPT2",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	dking2task_kuro_3 = {
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "kuro_book_0",
		text = [
			{text = "DKING2TASK_KURO_3", reqs = []},
		],
		options = [
			{
				code = 'dking2task_hara_2',
				text = "DIALOGUELEAVE",
				reqs = [],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
	kuro_questions = {
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "kuro_book_0",
		text = [
			{text = "KURO_QUESTIONS_REPLAY_SIDE", reqs = [], previous_dialogue_option = 1},
			{text = "KURO_QUESTIONS_REPLAY_PLAN", reqs = [], previous_dialogue_option = 2},
			{text = "KURO_QUESTIONS_REPLAY_ZEPH", reqs = [], previous_dialogue_option = 3},
			{text = "KURO_QUESTIONS_REPLAY_POWER", reqs = [], previous_dialogue_option = 4},
			{text = "KURO_QUESTIONS_REPLAY_LIKE", reqs = [], previous_dialogue_option = 5},
			{text = "KURO_QUESTIONS_REPLAY_RED", reqs = [], previous_dialogue_option = 6},
			
			{text = "KURO_QUESTIONS_HAS", previous_dialogue_option = 0, reqs = []},
			{text = "KURO_QUESTIONS_NO", reqs = [
				{type = 'local_counter', name = 'kuros_questions', operant = 'eq', value = 0, check = true},
				{type = "quest_completed", name = "hara_capacitor_quest", check = false}
			]},
			{text = "KURO_QUESTIONS_END", reqs = [
				{type = 'local_counter', name = 'kuros_questions', operant = 'eq', value = 0, check = true},
				{type = "quest_completed", name = "hara_capacitor_quest", check = true},
			]},
		],
		options = [
			{#first
				code = 'kuro_questions',
				text = "KURO_QUESTIONS_OPT_SIDE",
				reqs = [
					{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_REPLAY_SIDE'},
					{type = 'local_counter', name = 'kuros_questions', operant = 'gt', value = 0, check = true}
				],
				dialogue_argument = 1,
				bonus_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '-'}],
				remove_after_first_use = true
#			},{#archive
#				code = 'kuro_questions',
#				text = "KURO_QUESTIONS_OPT_SIDE",
#				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_SIDE'}],
#				dialogue_argument = 1,
			},{#first
				code = 'kuro_questions',
				text = "KURO_QUESTIONS_OPT_PLAN",
				reqs = [
					{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_REPLAY_PLAN'},
					{type = 'local_counter', name = 'kuros_questions', operant = 'gt', value = 0, check = true},
					{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_SIDE'}
				],
				dialogue_argument = 2,
				bonus_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '-'}],
				remove_after_first_use = true
#			},{#archive
#				code = 'kuro_questions',
#				text = "KURO_QUESTIONS_OPT_PLAN",
#				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_PLAN'}],
#				dialogue_argument = 2,
			},{#first
				code = 'kuro_questions',
				text = "KURO_QUESTIONS_OPT_ZEPH",
				reqs = [
					{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_REPLAY_ZEPH'},
					{type = 'local_counter', name = 'kuros_questions', operant = 'gt', value = 0, check = true},
				],
				dialogue_argument = 3,
				bonus_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '-'}],
				remove_after_first_use = true
#			},{#archive
#				code = 'kuro_questions',
#				text = "KURO_QUESTIONS_OPT_ZEPH",
#				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_ZEPH'}],
#				dialogue_argument = 3,
			},{#first
				code = 'kuro_questions',
				text = "KURO_QUESTIONS_OPT_POWER",
				reqs = [
					{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_REPLAY_POWER'},
					{type = 'local_counter', name = 'kuros_questions', operant = 'gt', value = 0, check = true},
				],
				dialogue_argument = 4,
				bonus_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '-'}],
				remove_after_first_use = true
#			},{#archive
#				code = 'kuro_questions',
#				text = "KURO_QUESTIONS_OPT_POWER",
#				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_POWER'}],
#				dialogue_argument = 4,
			},{#first
				code = 'kuro_questions',
				text = "KURO_QUESTIONS_OPT_LIKE",
				reqs = [
					{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_REPLAY_LIKE'},
					{type = 'local_counter', name = 'kuros_questions', operant = 'gt', value = 0, check = true},
				],
				dialogue_argument = 5,
				bonus_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '-'}],
				remove_after_first_use = true
#			},{#archive
#				code = 'kuro_questions',
#				text = "KURO_QUESTIONS_OPT_LIKE",
#				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_LIKE'}],
#				dialogue_argument = 5,
			},{#first
				code = 'kuro_questions',
				text = "KURO_QUESTIONS_OPT_RED",
				reqs = [
					{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_REPLAY_RED'},
					{type = 'local_counter', name = 'kuros_questions', operant = 'gt', value = 0, check = true},
					{type = "quest_completed", name = "hara_capacitor_quest", check = true}
				],
				dialogue_argument = 6,
				bonus_effects = [{code = 'dialogue_counter', name = 'kuros_questions', op = '-'}],
				remove_after_first_use = true
#			},{#archive
#				code = 'kuro_questions',
#				text = "KURO_QUESTIONS_OPT_RED",
#				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_REPLAY_RED'}],
#				dialogue_argument = 6,
			},{
				code = 'dking2task_hara_2',
				text = "DIALOGUENEVERMIND",
				reqs = [{type = 'dialogue_seen', check = false, value = 'KURO_QUESTIONS_END'}],
				dialogue_argument = 0,
				type = 'next_dialogue'
			},{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [{type = 'dialogue_seen', check = true, value = 'KURO_QUESTIONS_END'}],
				dialogue_argument = 0,
				type = 'next_dialogue'
			}
		]
	},
}
