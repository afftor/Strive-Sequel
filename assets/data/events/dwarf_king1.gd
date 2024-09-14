var data = {
	dking_first_start = {
		reqs = [],
		tags = ['dialogue_scene'],
		common_effects = [{code = 'complete_quest', value = 'visit_dwarfs_quest'}],
		character = 'dwarf_king',
		text = [{text = "DKING_START", reqs = []}],
		options = [{
			code = 'dking_first_start2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dking_first_start2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [{text = "DKING_START2", reqs = []}],
		options = [
			{
				code = 'dking_first_reported',
				text = "DIALOGUECONTINUE", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'decision', value = 'JeanReport', check = true}]
			},{
				code = 'dking_first_captured',
				text = "DIALOGUECONTINUE", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'decision', value = 'JeanHelp', check = true}]
			},
		]
	},
	dking_first_reported = {
		reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_GIRLSTOPS", reqs = []},
			{text = "DKING_FIRST_REPORTED", reqs = []},
		],
		options = [
			{
				code = 'dking_first_goal',
				text = "DKING_FIRST_OPT_ARTS", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},{
				code = 'dking_first_goal',
				text = "DKING_FIRST_OPT_INEED", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},
		]
	},
	dking_first_goal = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [{text = "DKING_FIRST_GOAL", reqs = []}],
		options = [{
			code = 'dking_first_task',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dking_first_captured = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_GIRLSTOPS", reqs = []},
			{text = "DKING_FIRST_CAPTURED", reqs = []},
		],
		options = [
			{
				code = 'dking_first_pay',
				text = "DKING_FIRST_OPT_ASKED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'dking_first_pay',
				text = "DKING_FIRST_OPT_MEET", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			},{
				code = 'dking_first_pay',
				text = "DKING_FIRST_OPT_RICH", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			},
		]
	},
	dking_first_pay = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_REPLY_ASKED", reqs = [], previous_dialogue_option = 1},
			{text = "DKING_FIRST_REPLY_MEET", reqs = [], previous_dialogue_option = 2},
			{text = "DKING_FIRST_REPLY_RICH", reqs = [], previous_dialogue_option = 3},
			{text = "DKING_FIRST_PAY", reqs = []},
		],
		options = [{
			code = 'dking_first_important',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dking_first_important = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_IMPORTANT", reqs = [], previous_dialogue_option = 0},
			{text = "DKING_FIRST_REPLY_EXCHANGE", reqs = [], previous_dialogue_option = 1},
			{text = "DKING_FIRST_REPLY_WITHOUT_J", reqs = [], previous_dialogue_option = 2},
			{text = "DKING_FIRST_REPLY_NOTCARE", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'dking_first_task',
				text = "DKING_FIRST_OPT_TASK", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},{
				code = 'dking_first_jean', remove_after_first_use = true,
				text = "DKING_FIRST_OPT_JEAN", reqs = [], dialogue_argument = 0,
			},{
				code = 'dking_first_important',
				text = "DKING_FIRST_OPT_EXCHANGE", reqs = [], dialogue_argument = 1
			},
		]
	},
	dking_first_jean = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_REPLY_JEAN", reqs = []},
		],
		options = [
			{
				code = 'dking_first_important',
				text = "DKING_FIRST_OPT_WITHOUT_J", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			},{
				code = 'dking_first_important',
				text = "DKING_FIRST_OPT_NOTCARE", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			}
		]
	},
	dking_first_task = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_TASK1_1", reqs = []},
			{text = "DKING_FIRST_TASK1_CAPTURED",
				reqs = [{type = 'decision', value = 'JeanHelp', check = true}]},
			{text = "DKING_FIRST_TASK1_2", reqs = []},
		],
		options = [{
			code = 'dking_first_task2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dking_first_task2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [{text = "DKING_FIRST_TASK2", reqs = []}],
		options = [{
			code = 'dking_first_task3',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dking_first_task3 = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_TASK3", reqs = [], previous_dialogue_option = 0},
			{text = "DKING_FIRST_REPLY_HARATASK", reqs = [], previous_dialogue_option = 1},
			{text = "DKING_FIRST_REPLY_GROUP", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'dking_first_task3',
				text = "DKING_FIRST_OPT_HARATASK", reqs = [], dialogue_argument = 1
			},{
				code = 'dking_first_task3',
				text = "DKING_FIRST_OPT_GROUP", reqs = [], dialogue_argument = 2,
			},{
				code = 'dking_first_plan',
				text = "DKING_FIRST_OPT_START", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},
		]
	},
	dking_first_plan = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_PLAN", reqs = [], previous_dialogue_option = 0},
			{text = "DKING_FIRST_REPLY_CANTBEAT", reqs = [], previous_dialogue_option = 1}
		],
		options = [
			{
				code = 'dking_first_end',
				text = "DKING_FIRST_OPT_GNOME", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},{
				code = 'dking_first_plan',
				text = "DKING_FIRST_OPT_CANTBEAT", reqs = [], dialogue_argument = 1,
			},{
				code = 'dking_first_torture',
				text = "DKING_FIRST_OPT_TORTURE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},
		]
	},
	dking_first_torture = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [{text = "DKING_FIRST_REPLY_TORTURE", reqs = []}],
		options = [
			{
				code = 'dking_first_end',
				text = "DKING_FIRST_OPT_DONE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},{
				code = 'dking_first_end',
				text = "DKING_FIRST_OPT_NEVERMIND", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			}
		]
	},
	dking_first_end = {
		reqs = [],
		tags = ['dialogue_scene'],
		character = 'dwarf_king',
		text = [
			{text = "DKING_FIRST_END", reqs = [], previous_dialogue_option = [1,2]},
			{text = "DKING_FIRST_END_GNOME", reqs = [], previous_dialogue_option = 2},
		],
		options = [{
			code = 'kuro_first_start',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'dking_hara_quest', stage = 'info'},
				{code = "update_city"}
			]
		}]
	},
	
	
	kuro_first_start = {
		reqs = [],
		tags = ['dialogue_scene'],
		character2 = 'kuro',
		text = [
			{text = "KURO_FIRST_START1", reqs = []},
			{text = "KURO_FIRST_START1_ZEPHYRA",
				reqs = [{type = "quest_completed", name = "zephyra_disappearance_quest", check = true}]},
			{text = "KURO_FIRST_START1_NOZEPHYRA",
				reqs = [{type = "quest_completed", name = "zephyra_disappearance_quest", check = false}]},
			{text = "KURO_FIRST_START2", reqs = []},
		],
		options = [
			{
				code = 'kuro_first_girl',
				text = "KURO_FIRST_OPT_GIRL", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},{
				code = 'close',
				text = "KURO_FIRST_OPT_IGNORE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},
		]
	},
	kuro_first_girl = {
		reqs = [],
		tags = ['dialogue_scene'],
		character2 = 'kuro',
		text = [
			{text = "KURO_FIRST_REPLY_GIRL", reqs = [], previous_dialogue_option = 0},
			{text = "KURO_FIRST_REPLY_EERIE", reqs = [], previous_dialogue_option = 1},
			{text = "KURO_FIRST_REPLY_FROM", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'kuro_first_girl',
				text = "KURO_FIRST_OPT_EERIE", reqs = [], dialogue_argument = 1
			},{
				code = 'kuro_first_girl',
				text = "KURO_FIRST_OPT_FROM", reqs = [], dialogue_argument = 2
			},{
				code = 'close',
				text = "KURO_FIRST_OPT_SILENT", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},
		]
	},
	
	
	dwarf_prison_start = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "", reqs = []}],
		options = [
			{
				code = 'dwarf_prison_slave',
				text = "DWARF_PRISON_OPT_SLAVE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
				select_person = true,
				person_reqs = [
					{code = 'is_at_location', value = 'dwarf_capital', check = true},
					{code = 'race', race = 'Gnome', check = true},
					{code = 'stat', stat = 'charm', operant = 'gte', value = 50},
					{code = "stat", stat = "tame_factor", operant = "gte", value = 4}
				]
			},{
				code = 'dwarf_prison_interrogate',
				text = "DWARF_PRISON_OPT_INTERROGATE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},{
				code = 'close',
				text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			},
		]
	},
	dwarf_prison_slave = {
		reqs = [],
		tags = ['dialogue_scene', 'active_character_translate'],
		text = [{text = "DWARF_PRISON_SLAVE1", reqs = []}],
		options = [{
			code = 'dwarf_prison_slave2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_prison_slave2 = {
		reqs = [],
		tags = ['dialogue_scene', 'active_character_translate'],
		text = [{text = "DWARF_PRISON_SLAVE2", reqs = []}],
		options = [{
			code = 'dwarf_prison_slave3',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_prison_slave3 = {
		reqs = [],
		tags = ['dialogue_scene', 'active_character_translate'],
		text = [{text = "DWARF_PRISON_SLAVE3", reqs = []}],
		options = [{
			code = 'dwarf_prison_attack',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_prison_interrogate = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "DWARF_PRISON_INTERROGATE1", reqs = []}],
		options = [{
			code = 'dwarf_prison_interrogate2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_prison_interrogate2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "DWARF_PRISON_INTERROGATE2", reqs = []}],
		options = [
			{
				code = 'dwarf_prison_interrogate_res',
				text = "DWARF_PRISON_OPT_PHYSICS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'dwarf_prison_interrogate_res',
				text = "DWARF_PRISON_OPT_MAGIC", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
#			},{
#				code = 'dwarf_prison_interrogate_res',
#				text = "DWARF_PRISON_OPT_CHARM", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},{
				code = 'dwarf_prison_attack',
				text = "DWARF_PRISON_OPT_CHARM", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},
		]
	},
	dwarf_prison_interrogate_res = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "DWARF_PRISON_PHYSICS", reqs = [], previous_dialogue_option = 1},
			{text = "DWARF_PRISON_MAGIC", reqs = [], previous_dialogue_option = 2},
		],
		options = [{
			code = 'dwarf_prison_attack',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_prison_attack = {
		reqs = [],
		common_effects = [{code = 'play_sound', value = 'explosion'}],
		tags = ['dialogue_scene'],
		text = [{text = "DWARF_PRISON_ATTACK1", reqs = []}],
		options = [{
			code = 'dwarf_prison_attack2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_prison_attack2 = {
		reqs = [],
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [{text = "DWARF_PRISON_ATTACK2", reqs = []}],
		options = [{
			code = 'close',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'dking_hara_quest', stage = 'tracks'},
				{code = "update_city"}
			]
		}]
	},
	
	
	dwarf_search = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "DWARF_SEARCH", reqs = []}],
		options = [{
			code = 'dwarf_search2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_search2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "DWARF_SEARCH2", reqs = []}],
		options = [{
			code = 'close',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'make_quest_location', value = 'quest_hollow_passage'},
				{code = "update_city"}
			]
		}]
	},
	
	hollow_pass_start = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "HOLLOW_PASS_START", reqs = []}],
		options = [{
			code = 'hollow_pass_kobolds',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_kobolds = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "HOLLOW_PASS_KOBOLDS", reqs = []}],
		options = [
			{
				code = 'hollow_pass_escort',
				text = "HOLLOW_PASS_OPT_EXPLORE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'hollow_pass_escort',
				text = "HOLLOW_PASS_OPT_KING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},{
				code = 'hollow_pass_escort',
				text = "HOLLOW_PASS_OPT_LEADER", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
		]
	},
	hollow_pass_escort = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_REPLY_EXPLORE", reqs = [], previous_dialogue_option = 1},
			{text = "HOLLOW_PASS_REPLY_KING", reqs = [], previous_dialogue_option = 2},
			{text = "HOLLOW_PASS_REPLY_LEADER", reqs = [], previous_dialogue_option = 3},
			{text = "HOLLOW_PASS_ESCORT", reqs = []},
		],
		options = [{
			code = 'hollow_pass_escort2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_escort2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_ESCORT2", reqs = []},
		],
		options = [{
			code = 'hollow_pass_escort3',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_escort3 = {
		reqs = [],
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [
			{text = "HOLLOW_PASS_ESCORT3", reqs = []},
		],
		options = [{
			code = 'hollow_pass_bolthar',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_bolthar = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_BOLTHAR", reqs = []},
		],
		options = [
			{
				code = 'hollow_pass_bolthar_reply',
				text = "HOLLOW_PASS_OPT_NOD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'hollow_pass_bolthar_reply',
				text = "HOLLOW_PASS_OPT_NOINTRO", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},{
				code = 'hollow_pass_bolthar_reply',
				text = "HOLLOW_PASS_OPT_CHAINS", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
		]
	},
	hollow_pass_bolthar_reply = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_REPLY_NOD", reqs = [], previous_dialogue_option = 1},
			{text = "HOLLOW_PASS_REPLY_NOINTRO", reqs = [], previous_dialogue_option = 2},
			{text = "HOLLOW_PASS_REPLY_CHAINS", reqs = [], previous_dialogue_option = 3}
		],
		options = [{
			code = 'hollow_pass_kingbiz',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_kingbiz = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_KINGBIZ", reqs = []},
		],
		options = [
			{
				code = 'hollow_pass_temple',
				text = "HOLLOW_PASS_OPT_MYBIZ", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},{
				code = 'hollow_pass_temple',
				text = "HOLLOW_PASS_OPT_FAVOR", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},{
				code = 'hollow_pass_temple',
				text = "HOLLOW_PASS_OPT_THING", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},
		]
	},
	hollow_pass_temple = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_TEMPLE", reqs = []},
		],
		options = [{
			code = 'hollow_pass_temple2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_temple2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_TEMPLE2", reqs = []},
		],
		options = [
			{
				code = 'hollow_pass_temple_reply',
				text = "HOLLOW_PASS_OPT_TAKE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'hollow_pass_temple_reply',
				text = "HOLLOW_PASS_OPT_NOWANDER", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},{
				code = 'hollow_pass_temple_reply',
				text = "HOLLOW_PASS_OPT_GAME", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},{
				code = 'hollow_pass_temple_reply',
				text = "HOLLOW_PASS_OPT_ASSURE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			},
		]
	},
	hollow_pass_temple_reply = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "HOLLOW_PASS_REPLY_TAKE", reqs = [], previous_dialogue_option = 1},
			{text = "HOLLOW_PASS_REPLY_NOWANDER", reqs = [], previous_dialogue_option = 2},
			{text = "HOLLOW_PASS_REPLY_GAME", reqs = [], previous_dialogue_option = 3},
			{text = "HOLLOW_PASS_REPLY_ASSURE", reqs = [], previous_dialogue_option = 4}
		],
		options = [{
			code = 'hollow_pass_end',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	hollow_pass_end = {
		reqs = [],
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [
			{text = "HOLLOW_PASS_END", reqs = []},
		],
		options = [{
			code = 'close',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'dking_hara_quest', stage = 'temple'},
				{code = 'make_quest_location', value = 'quest_old_gods_temple'},
				{code = "update_location"},#?
#				{code = 'remove_quest_location', value = 'quest_hollow_passage'}
			]
		}]
	},
	
	old_temple_start = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "OLD_TEMPLE_START", reqs = []},
		],
		options = [
			{
				code = 'old_temple_kobold',
				text = "DIALOGUECONTINUE", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'decision', value = 'met_kobold', check = true}]
			},{
				code = 'old_temple_nuisance',
				text = "DIALOGUECONTINUE", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'decision', value = 'met_kobold', check = false}]
			}
		]
	},
	old_temple_kobold = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "OLD_TEMPLE_KOBOLD", reqs = [], previous_dialogue_option = 0},
			{text = "OLD_TEMPLE_REPLY_WITHCOAL", reqs = [], previous_dialogue_option = 1},
		],
		options = [
			{
				code = 'old_temple_kobold',
				text = "OLD_TEMPLE_OPT_WITHCOAL", reqs = [], dialogue_argument = 1
			},{
				code = 'old_temple_nuisance',
				text = "OLD_TEMPLE_OPT_GOINGON", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			}
		]
	},
	old_temple_nuisance = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "OLD_TEMPLE_NUISANCE", reqs = [], previous_dialogue_option = 0},
			{text = "OLD_TEMPLE_REPLY_RUBBLE", reqs = [], previous_dialogue_option = 1},
			{text = "OLD_TEMPLE_REPLY_ITEM", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'old_temple_nuisance',
				text = "OLD_TEMPLE_OPT_RUBBLE", reqs = [], dialogue_argument = 1
			},{
				code = 'old_temple_nuisance',
				text = "OLD_TEMPLE_OPT_ITEM", reqs = [], dialogue_argument = 2
			},{
				code = 'old_temple_fine',
				text = "OLD_TEMPLE_OPT_FINE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			}
		]
	},
	old_temple_fine = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "OLD_TEMPLE_REPLY_FINE", reqs = []},
		],
		options = [{
			code = 'close',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
		}]
	},
	
	old_temple_finish = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "OLD_TEMPLE_FINISH", reqs = []},
		],
		options = [
			{
				code = 'old_temple_finish2',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			}
		]
	},
	old_temple_finish2 = {
		reqs = [],
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [
			{text = "OLD_TEMPLE_FINISH2", reqs = []},
		],
		options = [
			{
				code = 'old_temple_finish3',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			}
		]
	},
	old_temple_finish3 = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "OLD_TEMPLE_FINISH3", reqs = []},
		],
		options = [{
			code = 'close',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'dking_hara_quest', stage = 'wait'},
#				{code = 'remove_quest_location', value = 'quest_old_gods_temple'},
				{code = 'remove_quest_location', value = 'quest_hollow_passage'},
				{code = 'add_timed_event', value = {quest = 'dking_hara_quest', stage = 'rebeltavern'}, args = [{type = 'action_to_date', date = [3,3], hour = 1, action = 'quest'}]}
			]
		}]
	},
	
	
	dwarf_tavern_rebel = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "DTAVERN_REBEL", reqs = []}],
		options = [{
			code = 'dwarf_tavern_rebel2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	dwarf_tavern_rebel2 = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [{text = "DTAVERN_REBEL2", reqs = []}],
		options = [{
			code = 'bolthar_return',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	bolthar_return = {
		reqs = [],
		tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		text = [{text = "BOLTHAR_RETURN", reqs = []}],
		options = [
			{
				code = 'bolthar_return_to_hara',
				text = "BOLTHAR_RETURN_OPT_RECO", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'bolthar_return_to_hara',
				text = "BOLTHAR_RETURN_OPT_HARA", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},{
				code = 'bolthar_return_to_hara',
				text = "BOLTHAR_RETURN_OPT_GETDOWN", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
		]
	},
	bolthar_return_to_hara = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "BOLTHAR_RETURN_REPLY_RECO", reqs = [], previous_dialogue_option = 1},
			{text = "BOLTHAR_RETURN_REPLY_HARA", reqs = [], previous_dialogue_option = 2},
			{text = "BOLTHAR_RETURN_REPLY_GETDOWN", reqs = [], previous_dialogue_option = 3},
			{text = "BOLTHAR_RETURN_TO_HARA", reqs = []},
		],
		options = [{
			code = 'bolthar_return_hara',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	bolthar_return_hara = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "BOLTHAR_RETURN_HARA", reqs = []},
		],
		options = [{
			code = 'bolthar_hara_intro',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	bolthar_hara_intro = {
		reqs = [],
		character = 'hara',
		tags = ['dialogue_scene'],
		text = [
			{text = "BOLTHAR_HARA_INTRO", reqs = [], previous_dialogue_option = 0},
			{text = "BOLTHAR_HARA_REPLY_REBELS", reqs = [], previous_dialogue_option = 1},
			{text = "BOLTHAR_HARA_REPLY_KING", reqs = [], previous_dialogue_option = 2},
			{text = "BOLTHAR_HARA_REPLY_TREATMENT", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'bolthar_hara_intro',
				text = "BOLTHAR_HARA_OPT_REBELS", reqs = [], dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'TempHaraToKing'}]
			},{
				code = 'bolthar_hara_intro',
				text = "BOLTHAR_HARA_OPT_KING", reqs = [], dialogue_argument = 2,
				bonus_effects = [{code = 'decision', value = 'TempHaraToKing'}]
			},{
				code = 'bolthar_hara_intro',
				text = "BOLTHAR_HARA_OPT_TREATMENT", reqs = [], dialogue_argument = 3,
				bonus_effects = [{code = 'decision', value = 'TempHaraToKing'}]
			},{
				code = 'bolthar_hara_toking',
				text = "BOLTHAR_HARA_OPT_TOKING", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'decision', value = 'TempHaraToKing', check = true}],
				bonus_effects = [{code = 'remove_decision', value = 'TempHaraToKing'}]
			},
		]
	},
	bolthar_hara_toking = {
		reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "BOLTHAR_HARA_REPLY_TOKING", reqs = []},
		],
		options = [{
			code = 'bolthar_return_recruit',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'screen_black_transition', value = 0.5}#screen closes befor transition
			]
		}]
	},
	bolthar_return_recruit = {
		reqs = [],
		tags = ['dialogue_scene'],#'blackscreen_transition_common' - useless with need to return to this scene
		text = [
			{text = "BOLTHAR_RETURN_RECRUIT", reqs = [], previous_dialogue_option = 0},
			{text = "BOLTHAR_RETURN_REPLY_OFFER", reqs = [], previous_dialogue_option = 1},
		],
		options = [
			{
				code = 'bolthar_return_recruit_res',
				text = "BOLTHAR_RETURN_OPT_INDE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'bolthar_return_recruit_res',
				text = "BOLTHAR_RETURN_OPT_KING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'bolthar_return_recruit', remove_after_first_use = true,
				text = "BOLTHAR_RETURN_OPT_OFFER", reqs = [], dialogue_argument = 1
			},{
				code = 'bolthar_return_recruit_res',
				text = "BOLTHAR_RETURN_OPT_WITHYOU", dialogue_argument = 2, type = 'next_dialogue',
				reqs = [{type = 'dialogue_seen', check = true, value = 'BOLTHAR_RETURN_REPLY_OFFER'}],
				bonus_effects = [{code = 'decision', value = 'JoinCoalition'}]
			},
		]
	},
	bolthar_return_recruit_res = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "BOLTHAR_RETURN_REPLY_INDEKING", reqs = [], previous_dialogue_option = 1},
			{text = "BOLTHAR_RETURN_REPLY_WITHYOU", reqs = [], previous_dialogue_option = 2},
		],
		options = [{
			code = 'coalbase_attack_intro',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	
	coalbase_attack_intro = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_INTRO", reqs = []},
		],
		options = [{
			code = 'coalbase_attack_gates',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	coalbase_attack_gates = {
		reqs = [],
		character = 'kuro',
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_GATES", reqs = []},
		],
		options = [
			{
				code = 'coalbase_attack_bring_girl',
				text = "COALBASE_ATTACK_OPT_WHAT", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},{
				code = 'coalbase_attack_bring_girl',
				text = "COALBASE_ATTACK_OPT_FOLLOW", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			}
		]
	},
	coalbase_attack_bring_girl = {
		reqs = [],
		character = 'kuro',
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_REPLY_WHATFOLLOW", reqs = []},
		],
		options = [
			{
				code = 'coalbase_attack_itching',
				text = "COALBASE_ATTACK_OPT_SECURED", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			}
		]
	},
	coalbase_attack_itching = {
		reqs = [],
		character = 'kuro',
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_ITCHING", reqs = [], previous_dialogue_option = 0},
			{text = "COALBASE_ATTACK_REPLY_HARMED_FAIL", reqs = [], previous_dialogue_option = 1},
			{text = "", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'coalbase_attack_wits',
				text = "COALBASE_ATTACK_OPT_HARMED", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'wits_factor', operant = 'gte', value = 5}]}],
				bonus_effects = [{code = 'dialogue_counter', name = 'kuro_sympathy', op = '+'}]
			},{
				code = 'coalbase_attack_itching', remove_after_first_use = true,
				text = "COALBASE_ATTACK_OPT_HARMED", dialogue_argument = 1, type = 'next_dialogue',
				reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'wits_factor', operant = 'lt', value = 5}]}],
			},{
				code = 'coalbase_attack_reply_zephyra', remove_after_first_use = true,
				text = "COALBASE_ATTACK_OPT_ZEPHYRA", dialogue_argument = 0,
				reqs = [{type = 'has_hero', name = 'zephyra', check = true}],
				bonus_effects = [
					{code = 'dialogue_counter', name = 'kuro_sympathy', op = '+'},
					{code = 'dialogue_counter', name = 'kuro_sympathy', op = '+'},
				]
			},{
				code = 'quest_fight', args = 'coalition_base_kuro',
				text = "COALBASE_ATTACK_OPT_FIGHT", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},
		]
	},
	coalbase_attack_reply_zephyra = {
		reqs = [],
		character = 'kuro', character2 = "zephyra",
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_REPLY_ZEPHYRA", reqs = []},
		],
		options = [{
			code = 'coalbase_attack_itching',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}]
	},
	coalbase_attack_wits = {
		reqs = [],
		character = 'kuro',
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_REPLY_HARMED_SUC", reqs = []},
		],
		options = [{
			code = 'coalbase_attack_hara',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	coalbase_attack_after_fight = {
		reqs = [],
		character = 'kuro',
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_AFTER_FIGHT", reqs = []},
		],
		options = [
			{
				code = 'coalbase_attack_retreat',
				text = "COALBASE_ATTACK_OPT_TIME", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},{
				code = 'coalbase_attack_retreat',
				text = "COALBASE_ATTACK_OPT_NOTLET", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},{
				code = 'coalbase_attack_retreat',
				text = "COALBASE_ATTACK_OPT_COWARD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		]
	},
	coalbase_attack_retreat = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{text = "COALBASE_ATTACK_REPLY_TIMECOWARD", reqs = [], previous_dialogue_option = 1},
			{text = "COALBASE_ATTACK_REPLY_NOTLET", reqs = [], previous_dialogue_option = 2},
		],
		options = [{
			code = 'coalbase_attack_hara',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	coalbase_attack_hara = {
		reqs = [],
		character = 'hara',
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [
			{text = "COALBASE_ATTACK_HARA", reqs = []},
		],
		options = [{
			code = 'coalbase_attack_end',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}]
	},
	coalbase_attack_end = {
		reqs = [],
		character = 'hara',
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [
			{text = "COALBASE_ATTACK_END", reqs = []},
		],
		options = [{
			code = 'close',
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 0, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'dking_hara_quest', stage = 'nextday'},
				{code = 'add_timed_event', value = {quest = 'dking_hara_quest', stage = 'visit'}, args = [{type = 'action_to_date', date = [1,1], hour = 1, action = 'quest'}]}
			]
		}]
	},
}
