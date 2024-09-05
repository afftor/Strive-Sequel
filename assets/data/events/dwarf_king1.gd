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
#		character = 'kuro',#?
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
#		character = 'kuro',#?
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
				text = "DWARF_PRISON_OPT_SLAVE", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [],#has correct slave
				bonus_effects = []#remove slave
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
		tags = ['dialogue_scene', 'active_character_translate'],#how make slave active_character?
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
			bonus_effects = [{code = 'progress_quest', value = 'dking_hara_quest', stage = 'tracks'}]
		}]
	},
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	search_rebel_tracks_complete = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SEARCH_REBEL_TRACKS_COMPLETE", reqs = []
		}],
		options = [{
			code = 'hollow_passage_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_INTRO", reqs = []
		}],
		options = [{
			code = 'hollow_passage_search', 
			text = "HOLLOW_PASSAGE_SEARCH", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_search = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_LOCATION", reqs = []
		}],
		options = [{
			code = 'hollow_passage_kobolds_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_kobolds_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_KOBOLDS_INTRO", reqs = []
		}],
		options = [
			{
				code = 'hollow_passage_response_1', 
				text = "HOLLOW_PASSAGE_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'hollow_passage_response_2', 
				text = "HOLLOW_PASSAGE_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'hollow_passage_response_3', 
				text = "HOLLOW_PASSAGE_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	hollow_passage_response_1 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_RESPONSE_1", reqs = []
		}],
		options = [{
			code = 'hollow_passage_follow', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_response_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_RESPONSE_2", reqs = []
		}],
		options = [{
			code = 'hollow_passage_follow', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_response_3 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_RESPONSE_3", reqs = []
		}],
		options = [{
			code = 'hollow_passage_follow', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_follow = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_FOLLOW", reqs = []
		}],
		options = [{
			code = 'hollow_passage_journey', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_journey = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_JOURNEY", reqs = []
		}],
		options = [{
			code = 'hollow_passage_arrival', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hollow_passage_arrival = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HOLLOW_PASSAGE_ARRIVAL", reqs = []
		}],
		options = [{
			code = 'coalition_hq_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_INTRO", reqs = []
		}],
		options = [
			{
				code = 'coalition_hq_response_1', 
				text = "COALITION_HQ_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_response_2', 
				text = "COALITION_HQ_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_response_3', 
				text = "COALITION_HQ_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	coalition_hq_response_1 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_RESPONSE_1", reqs = []
		}],
		options = [{
			code = 'coalition_hq_bolthar_question', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_response_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_RESPONSE_2", reqs = []
		}],
		options = [{
			code = 'coalition_hq_bolthar_question', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_response_3 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_RESPONSE_3", reqs = []
		}],
		options = [{
			code = 'coalition_hq_bolthar_question', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_bolthar_question = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_BOLTHAR_QUESTION", reqs = []
		}],
		options = [
			{
				code = 'coalition_hq_bolthar_response', 
				text = "COALITION_HQ_OPTION_KING_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_bolthar_response', 
				text = "COALITION_HQ_OPTION_KING_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_bolthar_response', 
				text = "COALITION_HQ_OPTION_KING_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	coalition_hq_bolthar_response = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_BOLTHAR_RESPONSE", reqs = []
		}],
		options = [{
			code = 'coalition_hq_map', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_map = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_MAP", reqs = []
		}],
		options = [
			{
				code = 'coalition_hq_map_response_1', 
				text = "COALITION_HQ_MAP_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_map_response_2', 
				text = "COALITION_HQ_MAP_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_map_response_3', 
				text = "COALITION_HQ_MAP_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
			{
				code = 'coalition_hq_map_response_4', 
				text = "COALITION_HQ_MAP_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			}
		]
	},

	coalition_hq_map_response_1 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_MAP_RESPONSE_1", reqs = []
		}],
		options = [{
			code = 'coalition_hq_end', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_map_response_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_MAP_RESPONSE_2", reqs = []
		}],
		options = [{
			code = 'coalition_hq_end', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_map_response_3 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_MAP_RESPONSE_3", reqs = []
		}],
		options = [{
			code = 'coalition_hq_end', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_map_response_4 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_MAP_RESPONSE_4", reqs = []
		}],
		options = [{
			code = 'coalition_hq_end', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_hq_end = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HQ_END", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_old_gods_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_OLD_GODS_INTRO", reqs = []
		}],
		options = [{
			code = 'temple_kobold_remember', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_kobold_remember = {
		image = null, reqs = ["met_kobold"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_KOBOLD_REMEMBER", reqs = []
		}],
		options = [
			{
				code = 'temple_kobold_questions', 
				text = "TEMPLE_KOBOLD_OPTION_QUESTIONS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'temple_kobold_problem', 
				text = "TEMPLE_KOBOLD_OPTION_WHATS_GOING_ON", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	temple_kobold_questions = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_KOBOLD_RESPONSE_LIFE", reqs = []
		}],
		options = [{
			code = 'temple_kobold_problem', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_kobold_problem = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_KOBOLD_RESPONSE_PROBLEM", reqs = []
		}],
		options = [
			{
				code = 'temple_kobold_rubble', 
				text = "TEMPLE_KOBOLD_OPTION_RUBBLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'temple_kobold_item', 
				text = "TEMPLE_KOBOLD_OPTION_ITEM", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'temple_kobold_fine', 
				text = "TEMPLE_KOBOLD_OPTION_FINE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	temple_kobold_rubble = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_KOBOLD_RESPONSE_RUBBLE", reqs = []
		}],
		options = [{
			code = 'temple_kobold_problem', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_kobold_item = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_KOBOLD_RESPONSE_ITEM", reqs = []
		}],
		options = [{
			code = 'temple_kobold_problem', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_kobold_fine = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_KOBOLD_RESPONSE_FINE", reqs = []
		}],
		options = [{
			code = 'temple_final_room', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_final_room = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_FINAL_ROOM", reqs = []
		}],
		options = [{
			code = 'temple_return_kobold', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_return_kobold = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_RETURN_KOBOLD", reqs = []
		}],
		options = [{
			code = 'temple_teleport_kobolds', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	temple_teleport_kobolds = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "TEMPLE_TELEPORT_KOBOLDS", reqs = []
		}],
		options = [{
			code = 'dwarven_tavern_search_rebel', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	dwarven_tavern_search_rebel = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "DWARVEN_TAVERN_SEARCH_REBEL", reqs = []
		}],
		options = [{
			code = 'dwarven_tavern_alleyway', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	dwarven_tavern_alleyway = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "DWARVEN_TAVERN_ALLEYWAY", reqs = []
		}],
		options = [{
			code = 'returning_bolthar', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	returning_bolthar = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "RETURNING_BOLTHAR", reqs = []
		}],
		options = [
			{
				code = 'returning_bolthar_response_recognize', 
				text = "RETURNING_BOLTHAR_OPTION_RECOGNIZE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'returning_bolthar_response_hara', 
				text = "RETURNING_BOLTHAR_OPTION_HARA", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'returning_bolthar_response_compliments', 
				text = "RETURNING_BOLTHAR_OPTION_COMPLIMENTS", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	returning_bolthar_response_recognize = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "RETURNING_BOLTHAR_RESPONSE_RECOGNIZE", reqs = []
		}],
		options = [{
			code = 'bolthar_leads_to_hara', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	returning_bolthar_response_hara = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "RETURNING_BOLTHAR_RESPONSE_HARA", reqs = []
		}],
		options = [{
			code = 'bolthar_leads_to_hara', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	returning_bolthar_response_compliments = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "RETURNING_BOLTHAR_RESPONSE_COMPLIMENTS", reqs = []
		}],
		options = [{
			code = 'bolthar_leads_to_hara', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	bolthar_leads_to_hara = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "BOLTHAR_LEADS_TO_HARA", reqs = []
		}],
		options = [{
			code = 'hara_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_INTRO", reqs = []
		}],
		options = [
			{
				code = 'hara_response_rebels', 
				text = "HARA_OPTION_REBELS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'hara_response_king', 
				text = "HARA_OPTION_KING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'hara_response_treatment', 
				text = "HARA_OPTION_TREATMENT", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
			{
				code = 'hara_response_back_to_king', 
				text = "HARA_OPTION_BACK_TO_KING", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			}
		]
	},

	hara_response_rebels = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_REBELS", reqs = []
		}],
		options = [{
			code = 'hara_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_response_king = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_KING", reqs = []
		}],
		options = [{
			code = 'hara_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_response_treatment = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_TREATMENT", reqs = []
		}],
		options = [{
			code = 'hara_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_response_back_to_king = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_BACK_TO_KING", reqs = []
		}],
		options = [{
			code = 'bolthar_private_talk', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	bolthar_private_talk = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "BOLTHAR_PRIVATE_TALK", reqs = []
		}],
		options = [
			{
				code = 'bolthar_response_independent', 
				text = "BOLTHAR_OPTION_INDEPENDENT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'bolthar_response_king', 
				text = "BOLTHAR_OPTION_KING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'bolthar_response_offer', 
				text = "BOLTHAR_OPTION_OFFER", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
			{
				code = 'bolthar_response_coalition', 
				text = "BOLTHAR_OPTION_COALITION", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			}
		]
	},

	bolthar_response_independent = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "BOLTHAR_RESPONSE_INDEPENDENT", reqs = []
		}],
		options = [{
			code = 'coalition_attack_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	bolthar_response_king = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "BOLTHAR_RESPONSE_KING", reqs = []
		}],
		options = [{
			code = 'coalition_attack_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	bolthar_response_offer = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "BOLTHAR_RESPONSE_OFFER", reqs = []
		}],
		options = [{
			code = 'bolthar_private_talk', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	bolthar_response_coalition = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "BOLTHAR_RESPONSE_COALITION", reqs = []
		}],
		options = [{
			code = 'coalition_attack_intro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_INTRO", reqs = []
		}],
		options = [{
			code = 'coalition_attack_approach', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_approach = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_APPROACH", reqs = []
		}],
		options = [
			{
				code = 'coalition_attack_response_1_2', 
				text = "COALITION_ATTACK_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'coalition_attack_response_1_2', 
				text = "COALITION_ATTACK_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	coalition_attack_response_1_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_1_2", reqs = []
		}],
		options = [{
			code = 'coalition_attack_secured', 
			text = "COALITION_ATTACK_OPTION_SECURED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_secured = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_SECURED", reqs = []
		}],
		options = [
			{
				code = 'coalition_attack_response_wits', 
				text = "COALITION_ATTACK_OPTION_WITS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'coalition_attack_response_zephyra', 
				text = "COALITION_ATTACK_OPTION_ZEPHYRA", reqs = ["has_zephyra"], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'coalition_attack_response_fight', 
				text = "COALITION_ATTACK_OPTION_FIGHT", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	coalition_attack_response_wits = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_WITS", reqs = ["wits_factor_gte_5"]
		}],
		options = [{
			code = 'hara_return', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_response_zephyra = {
		image = null, reqs = ["has_zephyra"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_ZEPHYRA", reqs = []
		}],
		options = [{
			code = 'hara_return', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_response_fight = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_FIGHT", reqs = []
		}],
		options = [
			{
				code = 'coalition_attack_2_option_1', 
				text = "COALITION_ATTACK_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'coalition_attack_2_option_2', 
				text = "COALITION_ATTACK_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'coalition_attack_2_option_3', 
				text = "COALITION_ATTACK_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	coalition_attack_2_option_1 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_EXIT", reqs = []
		}],
		options = [{
			code = 'hara_return', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_2_option_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_EXIT", reqs = []
		}],
		options = [{
			code = 'hara_return', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_attack_2_option_3 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_ATTACK_RESPONSE_EXIT", reqs = []
		}],
		options = [{
			code = 'hara_return', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_return = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RETURN", reqs = []
		}],
		options = [{
			code = 'hara_return_exit', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_return_exit = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RETURN_EXIT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},
	
	king_second_task_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_INTRO", reqs = []
		}],
		options = [
			{
				code = 'king_second_task_response_hara_unharmed', 
				text = "KING_SECOND_TASK_OPTION_HARA_UNHARMED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'king_second_task_response_surprised_by_kuro', 
				text = "KING_SECOND_TASK_OPTION_SURPRISED_BY_KURO", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'king_second_task_response_about_reward', 
				text = "KING_SECOND_TASK_OPTION_ABOUT_REWARD", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	king_second_task_response_hara_unharmed = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_RESPONSE_HARA_UNHARMED", reqs = []
		}],
		options = [{
			code = 'king_second_task_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	king_second_task_response_surprised_by_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_RESPONSE_SURPRISED_BY_KURO", reqs = []
		}],
		options = [{
			code = 'king_second_task_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	king_second_task_response_about_reward = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_RESPONSE_ABOUT_REWARD", reqs = []
		}],
		options = [
			{
				code = 'king_second_task_response_about_machine', 
				text = "KING_SECOND_TASK_OPTION_ABOUT_MACHINE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'king_second_task_response_no_way', 
				text = "KING_SECOND_TASK_OPTION_NO_WAY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'king_second_task_response_agree_task', 
				text = "KING_SECOND_TASK_OPTION_AGREE_TASK", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	king_second_task_response_about_machine = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_RESPONSE_ABOUT_MACHINE", reqs = []
		}],
		options = [{
			code = 'king_second_task_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	king_second_task_response_no_way = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_RESPONSE_NO_WAY", reqs = []
		}],
		options = [{
			code = 'king_second_task_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	king_second_task_response_agree_task = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KING_SECOND_TASK_RESPONSE_AGREE_TASK", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},
	
	hara_visit_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_VISIT_INTRO", reqs = []
		}],
		options = [{
			code = 'hara_visit_intro_kuro_present', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_visit_intro_kuro_present = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_VISIT_INTRO_KURO_PRESENT", reqs = []
		}],
		options = [{
			code = 'hara_visit_no_attention', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_visit_no_attention = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_VISIT_NO_ATTENTION", reqs = []
		}],
		options = [
			{
				code = 'hara_dialogue_greeting', 
				text = "HARA_VISIT_OPTION_APPROACH_HARA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'kuro_dialogue_intro', 
				text = "HARA_VISIT_OPTION_TALK_TO_KURO", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	hara_dialogue_greeting = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_DIALOGUE_GREETING", reqs = []
		}],
		options = [
			{
				code = 'hara_response_what_do_you_need', 
				text = "HARA_OPTION_WHAT_DO_YOU_NEED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'hara_response_what_are_you_making', 
				text = "HARA_OPTION_WHAT_ARE_YOU_MAKING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	hara_response_what_do_you_need = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_WHAT_DO_YOU_NEED", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	hara_response_what_are_you_making = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_WHAT_ARE_YOU_MAKING", reqs = []
		}],
		options = [{
			code = 'hara_dialogue_greeting', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	market_search_shimmering_ore_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MARKET_SEARCH_SHIMMERING_ORE_INTRO", reqs = []
		}],
		options = [{
			code = 'market_search_shimmering_ore_offer', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	market_search_shimmering_ore_offer = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MARKET_SEARCH_SHIMMERING_ORE_OFFER", reqs = []
		}],
		options = [
			{
				code = 'market_search_shimmering_ore_purchase', 
				text = "MARKET_SEARCH_SHIMMERING_ORE_OPTION_PAY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'close_scene', 
				text = "MARKET_SEARCH_SHIMMERING_ORE_OPTION_RETURN_LATER", reqs = [], dialogue_argument = 2, type = 'close_scene'
			}
		]
	},

	market_search_shimmering_ore_purchase = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MARKET_SEARCH_SHIMMERING_ORE_PURCHASE", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	market_search_shimmering_ore_revisit = {
		image = null, reqs = ["not_purchased_shimmering_ore"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MARKET_SEARCH_SHIMMERING_ORE_REVISIT", reqs = []
		}],
		options = [
			{
				code = 'market_search_shimmering_ore_purchase', 
				text = "MARKET_SEARCH_SHIMMERING_ORE_OPTION_PAY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'close_scene', 
				text = "MARKET_SEARCH_SHIMMERING_ORE_OPTION_RETURN_LATER", reqs = [], dialogue_argument = 2, type = 'close_scene'
			}
		]
	},

	hara_give_shimmering_ore = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_GIVE_SHIMMERING_ORE", reqs = []
		}],
		options = [
			{
				code = 'hara_response_flirt', 
				text = "HARA_OPTION_FLIRT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'hara_response_light_attitude', 
				text = "HARA_OPTION_LIGHT_ATTITUDE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'hara_response_whats_next', 
				text = "HARA_OPTION_WHATS_NEXT", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	hara_response_flirt = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_FLIRT", reqs = []
		}],
		options = [{
			code = 'hara_give_shimmering_ore', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_response_light_attitude = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_LIGHT_ATTITUDE", reqs = []
		}],
		options = [{
			code = 'hara_give_shimmering_ore', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_response_whats_next = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_WHATS_NEXT", reqs = []
		}],
		options = [{
			code = 'kuro_response_sacred_sap', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_response_sacred_sap = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_SACRED_SAP", reqs = []
		}],
		options = [{
			code = 'hara_response_after_kuro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_response_after_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_RESPONSE_AFTER_KURO", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	sacred_sap_heleviel_intro = {
		image = null, reqs = ["chosen_heleviel"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_HELEVIEL_INTRO", reqs = []
		}],
		options = [
			{
				code = 'sacred_sap_heleviel_response_spying', 
				text = "SACRED_SAP_HELEVIEL_OPTION_SPYING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'sacred_sap_heleviel_response_i_will_help', 
				text = "SACRED_SAP_HELEVIEL_OPTION_I_WILL_HELP", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	sacred_sap_heleviel_response_spying = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_HELEVIEL_RESPONSE_SPYING", reqs = []
		}],
		options = [{
			code = 'sacred_sap_heleviel_intro', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_heleviel_response_i_will_help = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_HELEVIEL_RESPONSE_I_WILL_HELP", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	sacred_sap_prisoner_inquiry = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_PRISONER_INQUIRY", reqs = []
		}],
		options = [{
			code = 'sacred_sap_jail_visit', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_jail_visit = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_JAIL_VISIT", reqs = []
		}],
		options = [
			{
				code = 'sacred_sap_response_roughed_up', 
				text = "SACRED_SAP_OPTION_ROUGHED_UP", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'sacred_sap_response_why_keep_prisoners', 
				text = "SACRED_SAP_OPTION_WHY_KEEP_PRISONERS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	sacred_sap_response_roughed_up = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_RESPONSE_ROUGHED_UP", reqs = []
		}],
		options = [{
			code = 'sacred_sap_response_free_them', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_response_why_keep_prisoners = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_RESPONSE_WHY_KEEP_PRISONERS", reqs = []
		}],
		options = [{
			code = 'sacred_sap_response_free_them', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_response_free_them = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_RESPONSE_FREE_THEM", reqs = []
		}],
		options = [
			{
				code = 'sacred_sap_pay', 
				text = "SACRED_SAP_OPTION_PAY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'sacred_sap_deliver_slaves', 
				text = "SACRED_SAP_OPTION_DELIVER_SLAVES", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'close_scene', 
				text = "SACRED_SAP_OPTION_RETURN_LATER", reqs = [], dialogue_argument = 3, type = 'close_scene'
			}
		]
	},

	sacred_sap_pay = {
		image = null, reqs = ["gold_gte_1000", "fighter_guild_reputation_gte_1000"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_RESPONSE_PAY_OR_DELIVER", reqs = []
		}],
		options = [{
			code = 'sacred_sap_return_to_heleviel', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_deliver_slaves = {
		image = null, reqs = ["has_two_elven_slaves"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_RESPONSE_PAY_OR_DELIVER", reqs = []
		}],
		options = [{
			code = 'sacred_sap_return_to_heleviel', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_return_to_heleviel = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_RETURN_TO_HELEVIEL", reqs = []
		}],
		options = [{
			code = 'sacred_sap_heleviel_final_response', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	sacred_sap_heleviel_final_response = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "SACRED_SAP_HELEVIEL_FINAL_RESPONSE", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	erlen_event = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "ERLEN_EVENT", reqs = []
		}],
		options = [
			{
				code = 'erlen_response_encourage', 
				text = "ERLEN_OPTION_ENCOURAGE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'erlen_response_discourage', 
				text = "ERLEN_OPTION_DISCOURAGE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	erlen_response_encourage = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "ERLEN_RESPONSE_ENCOURAGE", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	erlen_response_discourage = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "ERLEN_RESPONSE_DISCOURAGE", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	lira_sap_intro = {
		image = null, reqs = ["chosen_lira"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "LIRA_SAP_INTRO", reqs = []
		}],
		options = [{
			code = 'lira_sap_request', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	lira_sap_request = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "LIRA_SAP_REQUEST", reqs = []
		}],
		options = [
			{
				code = 'lira_provide_resources', 
				text = "LIRA_OPTION_PROVIDE_RESOURCES", reqs = ["has_1000_wood", "has_100_steel"], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'close_scene', 
				text = "LIRA_OPTION_NOT_YET", reqs = [], dialogue_argument = 2, type = 'close_scene'
			}
		]
	},

	lira_provide_resources = {
		image = null, reqs = ["has_1000_wood", "has_100_steel"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "LIRA_SAP_FINAL_RESPONSE", reqs = []
		}],
		options = [{
			code = 'close_scene', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},
	
	intermission_scene = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "INTERMISSION_SCENE", reqs = []
		}],
		options = [{
			code = 'intermission_continue', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	intermission_continue = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "INTERMISSION_CONTINUE", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_sap_delivery = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_SAP_DELIVERY", reqs = []
		}],
		options = [{
			code = 'hara_sap_delivery_suspicion', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_sap_delivery_suspicion = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_SAP_DELIVERY_SUSPICION", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	molten_grounds_completion = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_COMPLETION", reqs = []
		}],
		options = [
			{
				code = 'molten_grounds_response_look_zephyra', 
				text = "MOLTEN_GROUNDS_OPTION_LOOK_ZEPHYRA", reqs = ["has_zephyra"], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'molten_grounds_response_not_sure', 
				text = "MOLTEN_GROUNDS_OPTION_NOT_SURE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	molten_grounds_response_look_zephyra = {
		image = null, reqs = ["has_zephyra"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_RESPONSE_LOOK_ZEPHYRA", reqs = []
		}],
		options = [{
			code = 'molten_grounds_continue_look_zephyra', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	molten_grounds_continue_look_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_CONTINUE_LOOK_ZEPHYRA", reqs = []
		}],
		options = [
			{
				code = 'molten_grounds_response_other_sister', 
				text = "MOLTEN_GROUNDS_OPTION_OTHER_SISTER", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'close', 
				text = "MOLTEN_GROUNDS_OPTION_STAY_SILENT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	molten_grounds_response_other_sister = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_RESPONSE_OTHER_SISTER", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	molten_grounds_response_not_sure = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_RESPONSE_NOT_SURE", reqs = []
		}],
		options = [{
			code = 'molten_grounds_kuro_banishes', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	molten_grounds_kuro_banishes = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_KURO_BANISHES", reqs = []
		}],
		options = [
			{
				code = 'molten_grounds_response_who_was_that', 
				text = "MOLTEN_GROUNDS_OPTION_WHO_WAS_THAT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'molten_grounds_response_been_following', 
				text = "MOLTEN_GROUNDS_OPTION_BEEN_FOLLOWING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'molten_grounds_response_sister_hot', 
				text = "MOLTEN_GROUNDS_OPTION_SISTER_HOT", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	molten_grounds_response_who_was_that = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_RESPONSE_WHO_WAS_THAT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	molten_grounds_response_been_following = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_RESPONSE_BEEN_FOLLOWING", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	molten_grounds_response_sister_hot = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "MOLTEN_GROUNDS_RESPONSE_SISTER_HOT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	hara_capacitor_return = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HARA_CAPACITOR_RETURN", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_dialogue_intro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_DIALOGUE_INTRO", reqs = []
		}],
		options = [
			{
				code = 'kuro_response_reading_place', 
				text = "KURO_OPTION_READING_PLACE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'kuro_response_why_here', 
				text = "KURO_OPTION_WHY_HERE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	kuro_response_reading_place = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_READING_PLACE", reqs = []
		}],
		options = [
			{
				code = 'kuro_option_helping_out', 
				text = "KURO_OPTION_HELPING_OUT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'kuro_option_more_questions', 
				text = "KURO_OPTION_MORE_QUESTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	kuro_response_why_here = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_WHY_HERE", reqs = []
		}],
		options = [
			{
				code = 'kuro_option_helping_out', 
				text = "KURO_OPTION_HELPING_OUT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'kuro_option_more_questions', 
				text = "KURO_OPTION_MORE_QUESTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	kuro_option_helping_out = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_HELPING_OUT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_option_more_questions = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_MORE_QUESTIONS", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_no_questions_left = {
		image = null, reqs = ["has_no_question_points"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_NO_QUESTIONS_LEFT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_questions_left = {
		image = null, reqs = ["has_question_points"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTIONS_LEFT", reqs = []
		}],
		options = [
			{
				code = 'kuro_question_side', 
				text = "KURO_OPTION_SIDE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'kuro_question_artifacts', 
				text = "KURO_OPTION_ARTIFACTS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'kuro_question_zephyra', 
				text = "KURO_OPTION_ZEPHYRA", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
			{
				code = 'kuro_question_powers', 
				text = "KURO_OPTION_POWERS", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			},
			{
				code = 'kuro_question_likes_hates', 
				text = "KURO_OPTION_LIKES_HATES", reqs = [], dialogue_argument = 5, type = 'next_dialogue'
			},
			{
				code = 'kuro_question_rouge', 
				text = "KURO_OPTION_ROUGE", reqs = ["completed_3rd_quest"], dialogue_argument = 6, type = 'next_dialogue'
			},
			{
				code = 'close', 
				text = "KURO_OPTION_NEVERMIND", reqs = [], dialogue_argument = 7, type = 'next_dialogue'
			}
		]
	},

	kuro_question_side = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTION_SIDE", reqs = []
		}],
		options = [{
			code = 'kuro_questions_left', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_question_artifacts = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTION_ARTIFACTS", reqs = []
		}],
		options = [{
			code = 'kuro_questions_left', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_question_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTION_ZEPHYRA", reqs = []
		}],
		options = [{
			code = 'kuro_questions_left', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_question_powers = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTION_POWERS", reqs = []
		}],
		options = [{
			code = 'kuro_questions_left', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_question_likes_hates = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTION_LIKES_HATES", reqs = []
		}],
		options = [{
			code = 'kuro_questions_left', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_question_rouge = {
		image = null, reqs = ["completed_3rd_quest"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_QUESTION_ROUGE", reqs = []
		}],
		options = [{
			code = 'kuro_questions_left', 
			text = "DIALOGUERETURN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},
	
	# (after all quests complete and questions exhausted)
	kuro_final_advice = {
		image = null, reqs = ["all_quests_complete", "questions_exhausted"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_FINAL_ADVICE", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},
	ceremony_start = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CEREMONY_START", reqs = []
		}],
		options = [
			{
				code = 'ceremony_response_payment', 
				text = "CEREMONY_OPTION_PAYMENT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'ceremony_response_safety', 
				text = "CEREMONY_OPTION_SAFETY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	ceremony_response_payment = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CEREMONY_RESPONSE_PAYMENT", reqs = []
		}],
		options = [{
			code = 'ceremony_if_in_vault', 
			text = "DIALOGUECONTINUE", reqs = ["was_in_vault"], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'ceremony_if_not_in_vault', 
			text = "DIALOGUECONTINUE", reqs = ["not_in_vault"], dialogue_argument = 2, type = 'next_dialogue'
		}]
	},

	ceremony_response_safety = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CEREMONY_RESPONSE_SAFETY", reqs = []
		}],
		options = [{
			code = 'ceremony_if_in_vault', 
			text = "DIALOGUECONTINUE", reqs = ["was_in_vault"], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'ceremony_if_not_in_vault', 
			text = "DIALOGUECONTINUE", reqs = ["not_in_vault"], dialogue_argument = 2, type = 'next_dialogue'
		}]
	},

	ceremony_if_in_vault = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CEREMONY_IF_IN_VAULT", reqs = []
		}],
		options = [{
			code = 'ceremony_continue', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	ceremony_if_not_in_vault = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CEREMONY_IF_NOT_IN_VAULT", reqs = []
		}],
		options = [{
			code = 'ceremony_continue', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	ceremony_continue = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CEREMONY_CONTINUE", reqs = []
		}],
		options = [{
			code = 'kings_route_finale', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kings_route_finale = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KINGS_ROUTE_FINALE", reqs = []
		}],
		options = [
			{
				code = 'kings_route_finale_dex_challenge', 
				text = "KINGS_ROUTE_FINALE_DEX_CHALLENGE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'kings_route_finale_fight', 
				text = "KINGS_ROUTE_FINALE_FIGHT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	kings_route_finale_dex_challenge = {
		image = null, reqs = ["dexterity_check_success"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KINGS_ROUTE_FINALE_SUCCESS", reqs = []
		}],
		options = [{
			code = 'chase_after_kuro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kings_route_finale_fight = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KINGS_ROUTE_FINALE_SUCCESS", reqs = []
		}],
		options = [{
			code = 'chase_after_kuro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_after_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_AFTER_KURO", reqs = []
		}],
		options = [
			{
				code = 'chase_response_1', 
				text = "CHASE_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'chase_response_2', 
				text = "CHASE_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'chase_response_3', 
				text = "CHASE_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	chase_response_1 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_RESPONSE_1", reqs = []
		}],
		options = [{
			code = 'chase_after_response', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_response_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_RESPONSE_2", reqs = []
		}],
		options = [{
			code = 'chase_after_response', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_response_3 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_RESPONSE_3", reqs = []
		}],
		options = [{
			code = 'chase_after_response', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_after_response = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_AFTER_RESPONSE", reqs = []
		}],
		options = [{
			code = 'coalition_not_helped', 
			text = "DIALOGUECONTINUE", reqs = ["not_helped_coalition"], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'coalition_helped', 
			text = "DIALOGUECONTINUE", reqs = ["helped_coalition"], dialogue_argument = 2, type = 'next_dialogue'
		}]
	},

	coalition_not_helped = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_NOT_HELPED", reqs = []
		}],
		options = [{
			code = 'fight_after_win', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	coalition_helped = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "COALITION_HELPED", reqs = []
		}],
		options = [{
			code = 'fight_after_win', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	fight_after_win = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "FIGHT_AFTER_WIN", reqs = []
		}],
		options = [{
			code = 'chase_after_kuro_coalition_help', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_after_kuro_coalition_help = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_AFTER_KURO_COALITION_HELP", reqs = []
		}],
		options = [{
			code = 'finale_without_ketch', 
			text = "DIALOGUECONTINUE", reqs = ["ketch_not_present"], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'finale_with_ketch', 
			text = "DIALOGUECONTINUE", reqs = ["ketch_present"], dialogue_argument = 2, type = 'next_dialogue'
		}]
	},

	finale_without_ketch = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "FINALE_WITHOUT_KETCH", reqs = []
		}],
		options = [{
			code = 'kuro_response_to_betrayal', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_response_to_betrayal = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_TO_BETRAYAL", reqs = []
		}],
		options = [{
			code = 'kuro_falls_knees', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_falls_knees = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_FALLS_KNEES", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	finale_with_ketch = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "FINALE_WITH_KETCH", reqs = []
		}],
		options = [{
			code = 'kuro_response_ketch', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	kuro_response_ketch = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KURO_RESPONSE_KETCH", reqs = []
		}],
		options = [{
			code = 'ketch_finale_no_zephyra', 
			text = "DIALOGUECONTINUE", reqs = ["no_zephyra"], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'ketch_finale_with_zephyra', 
			text = "DIALOGUECONTINUE", reqs = ["with_zephyra"], dialogue_argument = 2, type = 'next_dialogue'
		}]
	},

	ketch_finale_no_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KETCH_FINALE_NO_ZEPHYRA", reqs = []
		}],
		options = [{
			code = 'ketch_attack_kuro', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	ketch_attack_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KETCH_ATTACK_KURO", reqs = []
		}],
		options = [
			{
				code = 'help_kuro', 
				text = "HELP_KURO_OPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'chase_after_ketch', 
				text = "CHASE_AFTER_KETCH_OPTION", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	help_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "HELP_KURO", reqs = []
		}],
		options = [{
			code = 'fade_to_black', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	fade_to_black = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "FADE_TO_BLACK", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	ketch_finale_with_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KETCH_FINALE_WITH_ZEPHYRA", reqs = []
		}],
		options = [{
			code = 'ketch_attack_kuro_zephyra', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	ketch_attack_kuro_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "KETCH_ATTACK_KURO_ZEPHYRA", reqs = []
		}],
		options = [
			{
				code = 'rush_to_zephyra', 
				text = "Rush to Zephyra", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'chase_after_ketch', 
				text = "Chase after Ketch", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	rush_to_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "RUSH_TO_ZEPHYRA", reqs = []
		}],
		options = [
			{
				code = 'zephyra_help_1', 
				text = "ZEPHYRA_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
				code = 'zephyra_help_2', 
				text = "ZEPHYRA_OPTION_2", reqs = ["is_bishop_class"], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
				code = 'zephyra_help_3', 
				text = "ZEPHYRA_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	zephyra_help_1 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "ZEPHYRA_HELP_1", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	zephyra_help_2 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "ZEPHYRA_HELP_2", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	zephyra_help_3 = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "ZEPHYRA_HELP_3", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_after_ketch = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_AFTER_KETCH", reqs = []
		}],
		options = [{
			code = 'chase_ketch_success', 
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	chase_ketch_success = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "CHASE_KETCH_SUCCESS", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}]
	},

	# Aftermath event for King's Route where Kuro is dead
	aftermath_king_route_kuro_dead = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KING_ROUTE_KURO_DEAD", reqs = []
		}],
		options = [
			{
				code = 'aftermath_king_response_hara', 
				text = "AFTERMATH_KING_OPTION_HARA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_king_response_jean', 
				text = "AFTERMATH_KING_OPTION_JEAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_KING_OPTION_LEAVE", reqs = [], dialogue_argument = 3, type = 'close_scene'
			}
		]
	},

	# Aftermath event for King's Route where Kuro is alive
	aftermath_king_route_kuro_alive = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KING_ROUTE_KURO_ALIVE", reqs = []
		}],
		options = [
			{
				code = 'aftermath_king_response_hara', 
				text = "AFTERMATH_KING_OPTION_HARA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_king_response_jean', 
				text = "AFTERMATH_KING_OPTION_JEAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'aftermath_king_response_kuro', 
				text = "AFTERMATH_KING_OPTION_KURO", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_KING_OPTION_LEAVE", reqs = [], dialogue_argument = 4, type = 'close_scene'
			}
		]
	},

	# King's response to Hara
	aftermath_king_response_hara = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KING_RESPONSE_HARA", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# King's response to Jean
	aftermath_king_response_jean = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_JEAN_KING_NEGOTIATION", reqs = []
		}],
		options = [
			{
				code = 'aftermath_jean_king_treasury', 
				text = "AFTERMATH_JEAN_KING_TREASURY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_JEAN_KING_OPTION_LEAVE", reqs = [], dialogue_argument = 2, type = 'close_scene'
			}
		]
	},

	# King's response to Kuro being alive
	aftermath_king_response_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KING_RESPONSE_KURO", reqs = []
		}],
		options = [
			{
				code = 'aftermath_king_response_kuro_point', 
				text = "AFTERMATH_KING_RESPONSE_KURO_POINT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_king_response_kuro_agree', 
				text = "AFTERMATH_KING_RESPONSE_KURO_AGREE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	# King's response when player suggests a point about Kuro
	aftermath_king_response_kuro_point = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KING_RESPONSE_KURO_POINT_CONTINUE", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Aftermath event for Bolthar's Route where Kuro is dead
	aftermath_bolthar_route_kuro_dead = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_BOLTHAR_ROUTE_KURO_DEAD", reqs = []
		}],
		options = [
			{
				code = 'aftermath_bolthar_response_hara', 
				text = "AFTERMATH_BOLTHAR_OPTION_HARA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_bolthar_response_jean', 
				text = "AFTERMATH_BOLTHAR_OPTION_JEAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_BOLTHAR_OPTION_LEAVE", reqs = [], dialogue_argument = 3, type = 'close_scene'
			}
		]
	},

	# Aftermath event for Bolthar's Route where Kuro is alive
	aftermath_bolthar_route_kuro_alive = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_BOLTHAR_ROUTE_KURO_ALIVE", reqs = []
		}],
		options = [
			{
				code = 'aftermath_bolthar_response_hara', 
				text = "AFTERMATH_BOLTHAR_OPTION_HARA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_bolthar_response_jean', 
				text = "AFTERMATH_BOLTHAR_OPTION_JEAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'aftermath_bolthar_response_kuro', 
				text = "AFTERMATH_BOLTHAR_OPTION_KURO", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}, {
				code = 'aftermath_bolthar_response_cult', 
				text = "AFTERMATH_BOLTHAR_OPTION_CULT", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_BOLTHAR_OPTION_LEAVE", reqs = [], dialogue_argument = 5, type = 'close_scene'
			}
		]
	},

	# Bolthar's response to Hara
	aftermath_bolthar_response_hara = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_BOLTHAR_RESPONSE_HARA", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Bolthar's response to Kuro being alive
	aftermath_bolthar_response_kuro = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_BOLTHAR_RESPONSE_KURO", reqs = []
		}],
		options = [
			{
				code = 'aftermath_bolthar_response_kuro_point', 
				text = "AFTERMATH_BOLTHAR_RESPONSE_KURO_POINT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_bolthar_response_kuro_agree', 
				text = "AFTERMATH_BOLTHAR_RESPONSE_KURO_AGREE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	# Bolthar's response when player suggests taking Kuro instead
	aftermath_bolthar_response_kuro_point = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_BOLTHAR_RESPONSE_KURO_POINT_CONTINUE", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Jean-Bolthar Negotiation outcome
	aftermath_jean_bolthar_negotiation = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_JEAN_BOLTHAR_NEGOTIATION", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Jean-King Negotiation outcome
	aftermath_jean_king_negotiation = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_JEAN_KING_NEGOTIATION", reqs = []
		}],
		options = [
			{
				code = 'aftermath_jean_king_treasury', 
				text = "AFTERMATH_JEAN_KING_TREASURY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_JEAN_KING_OPTION_LEAVE", reqs = [], dialogue_argument = 2, type = 'close_scene'
			}
		]
	},

	# King's response if player asks about paying or replacing Jean
	aftermath_jean_king_treasury = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_JEAN_KING_RESPONSE_PAY", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# King's response to Jean's fate if player ratted her out
	aftermath_jean_king_ratted_out = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_JEAN_KING_RATTED_OUT", reqs = []
		}],
		options = [
			{
				code = 'aftermath_jean_king_option_slave', 
				text = "AFTERMATH_JEAN_KING_OPTION_SLAVE_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_jean_king_option_free', 
				text = "AFTERMATH_JEAN_KING_OPTION_FREE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_JEAN_KING_OPTION_NEVERMIND", reqs = [], dialogue_argument = 3, type = 'close_scene'
			}
		]
	},

	# Kuro Recruitment Dialogue
	aftermath_kuro_recruitment_dialogue = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RECRUITMENT_DIALOGUE", reqs = []
		}],
		options = [
			{
				code = 'aftermath_kuro_response_questions', 
				text = "AFTERMATH_KURO_OPTION_QUESTIONS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_response_join', 
				text = "AFTERMATH_KURO_OPTION_JOIN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'leave', 
				text = "AFTERMATH_KURO_OPTION_LEAVE", reqs = [], dialogue_argument = 3, type = 'close_scene'
			}
		]
	},

	# Kuro's response when player asks questions
	aftermath_kuro_response_questions = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_QUESTIONS", reqs = []
		}],
		options = [
			{
				code = 'aftermath_kuro_response_trust', 
				text = "AFTERMATH_KURO_OPTION_TRUST", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_response_palace', 
				text = "AFTERMATH_KURO_OPTION_PALACE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_response_cult_join', 
				text = "AFTERMATH_KURO_OPTION_CULT_JOIN", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_response_cult_plan', 
				text = "AFTERMATH_KURO_OPTION_CULT_PLAN", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_response_plan', 
				text = "AFTERMATH_KURO_OPTION_PLAN", reqs = [], dialogue_argument = 5, type = 'next_dialogue'
			}, {
				code = 'close', 
				text = "AFTERMATH_KURO_OPTION_ENOUGH", reqs = [], dialogue_argument = 6, type = 'close_scene'
			}
		]
	},

	# Response when player opts for Kuro to join
	aftermath_kuro_response_join = {
		image = null, reqs = ["has_zephyra"], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_JOIN_ZEPHYRA", reqs = []
		}],
		options = [
			{
				code = 'aftermath_kuro_recruit_zephyra_sprite', 
				text = "AFTERMATH_KURO_RECRUIT_ZEPHYRA_SPRITE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}
		]
	},

	# If Zephyra is present to help recruit Kuro
	aftermath_kuro_recruit_zephyra_sprite = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_HELP_ZEPHYRA", reqs = []
		}],
		options = [
			{
				code = 'aftermath_kuro_option_worried', 
				text = "AFTERMATH_KURO_OPTION_WORRIED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_option_listen_silently', 
				text = "AFTERMATH_KURO_OPTION_LISTEN_SILENTLY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		]
	},

	# Kuro's response if player decides to listen silently
	aftermath_kuro_option_listen_silently = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_LISTEN_SILENTLY", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# If Zephyra is not present to help recruit Kuro
	aftermath_kuro_response_no_zephyra = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_NO_ZEPHYRA", reqs = []
		}],
		options = [
			{
				code = 'aftermath_kuro_option_punishment', 
				text = "AFTERMATH_KURO_OPTION_PUNISHMENT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_option_fair', 
				text = "AFTERMATH_KURO_OPTION_FAIR", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_option_quiz', 
				text = "AFTERMATH_KURO_OPTION_QUIZ", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	# Kuro's response if player chooses punishment option
	aftermath_kuro_option_punishment = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_PUNISHMENT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Kuro's response if player chooses fair option
	aftermath_kuro_option_fair = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_FAIR", reqs = []
		}],
		options = [
			{
				code = 'aftermath_kuro_option_believe', 
				text = "AFTERMATH_KURO_OPTION_BELIEVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_option_sensibility', 
				text = "AFTERMATH_KURO_OPTION_SENSIBILITY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}, {
				code = 'aftermath_kuro_option_distrust', 
				text = "AFTERMATH_KURO_OPTION_DISTRUST", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
		]
	},

	# Kuro's response if player chooses quiz option
	aftermath_kuro_option_quiz = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_OPTION_QUIZ", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Kuro's response to player choosing Believe option
	aftermath_kuro_option_believe = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_BELIEVE", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Kuro's response to player choosing Sensibility option
	aftermath_kuro_option_sensibility = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_SENSIBILITY", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Kuro's response to player choosing Distrust option
	aftermath_kuro_option_distrust = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_DISTRUST", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	},

	# Final sequence after successful recruitment of Kuro
	aftermath_kuro_response_recruit = {
		image = null, reqs = [], 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{
			text = "AFTERMATH_KURO_RESPONSE_RECRUIT", reqs = []
		}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'close_scene'
		}]
	}
}
