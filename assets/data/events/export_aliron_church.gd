extends Reference
var data = {
	ginny_visit = {
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
		{text = "GINNYVISIT", reqs = []},
		],
		common_effects = [{code = 'decision', value = 'ginny_visit'}],
		options = [
		{code = 'ginny_visit2', text = "GINNYVISITREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'ginny_visit2', text = "GINNYVISITREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'ginny_visit2', text = "GINNYVISITREPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
		
	},

	ginny_visit2 = {
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "GINNYVISIT2_1", reqs = [], previous_dialogue_option = 1},
			{text = "GINNYVISIT2_2", reqs = [], previous_dialogue_option = 2},
			{text = "GINNYVISIT2_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = 'close', reqs = [], text = "DIALOGUECLOSE", bonus_effects = [{code = 'rewrite_save'}],
			},
		],
		
	},

	aliron_church_firstcome = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		common_effects = [{code = 'background_noise', value = 'stop'}],
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ALIRONCHURCHFIRSTCOME", reqs = []},
		],
		options = [
			{code = 'aliron_church_introduction', text = "ALIRONCHURCHFIRSTCOMEREPLY1", reqs = [], dialogue_argument = 1, remove_after_first_use = true},
			{code = 'aliron_church_introduction', text = "ALIRONCHURCHFIRSTCOMEREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'close', text = "ALIRONCHURCHFIRSTCOMEREPLY3", reqs = [], dialogue_argument = 3, bonus_effects = [
				{code = 'update_city'},
			]},
		],
		
	},

	aliron_church_introduction = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		common_effects = [{code = 'background_noise', value = 'stop'}],
		text = [
			{text = "ALIRONCHURCHINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
			{text = "ALIRONCHURCHINTRODUCTION2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'aliron_church_celena', reqs = [], text = "ALIRONCHURCHINTRODUCTIONREPLY1", dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'aliron_church_quest_start', reqs = [{type = 'active_quest_stage', value = 'aliron_church_quest', stage = 'stage1', state = false}], text = "ALIRONCHURCHINTRODUCTIONREPLY2", dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'aliron_church_leave', reqs = [], text = "ALIRONCHURCHINTRODUCTIONREPLY3", dialogue_argument = 3, type = 'next_dialogue'},
		],
		
	},


	aliron_church_leave = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ALIRONCHURCHLEAVE", reqs = []},
		],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'background_noise', value = 'resume'}]},
		],
		
	},

	aliron_church_celena = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ALIRONCHURCHCELENA", reqs = [], previous_dialogue_option = 1},
			{text = "ALIRONCHURCHCELENAANSWER_1", reqs = [], previous_dialogue_option = 2},
			{text = "ALIRONCHURCHCELENAANSWER_2", reqs = [], previous_dialogue_option = 3},
			{text = "ALIRONCHURCHCELENAANSWER_3", reqs = [], previous_dialogue_option = 4},
		],
		options = [
			{code = 'aliron_church_celena', reqs = [{type = 'dialogue_seen', check = false, value = 'ALIRONCHURCHCELENAREPLY1'}], text = "ALIRONCHURCHCELENAREPLY1", dialogue_argument = 2, remove_after_first_use = true},
			{code = 'aliron_church_celena', reqs = [{type = 'dialogue_seen', check = false, value = 'ALIRONCHURCHCELENAREPLY2'}], text = "ALIRONCHURCHCELENAREPLY2", dialogue_argument = 3, remove_after_first_use = true},
			{code = 'aliron_church_celena', reqs = [{type = 'dialogue_seen', check = false, value = 'ALIRONCHURCHCELENAREPLY3'}], text = "ALIRONCHURCHCELENAREPLY3", dialogue_argument = 4, remove_after_first_use = true},
			{code = 'aliron_church_enter', reqs = [], text = "ALIRONCHURCHCELENAREPLY4", dialogue_argument = 5, type = 'next_dialogue'},
		],
		
	},

	aliron_church_enter = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ALIRONCHURCHENTER2", reqs = [],  previous_dialogue_option = 5},
			{text = "ALIRONCHURCHENTER1", reqs = [],  previous_dialogue_option = 0},
		],
		options = [
			{code = 'aliron_church_celena', reqs = [], text = "ALIRONCHURCHINTRODUCTIONREPLY1", dialogue_argument = 1},
			{code = 'aliron_church_quest_start', reqs = [{type = 'dialogue_seen', check = false, value = 'ALIRONCHURCHQUESTSTART'}], text = "ALIRONCHURCHENTERREPLY1", dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true},
			{code = 'aliron_church_quest_complete', reqs = [
				{type = 'dialogue_seen', check = true, value = 'ALIRONCHURCHQUESTSTART'},
				{type = 'has_material', material = 'meatsoup', operant = 'gte', value = 25},
			], text = "ALIRONCHURCHENTERREPLY2", dialogue_argument = 3, type = 'next_dialogue', previous_dialogue_option = 0, remove_after_first_use = true},
			{code = 'aliron_church_quest_complete', reqs = [
				{type = 'dialogue_seen', check = true, value = 'ALIRONCHURCHQUESTCOMPLETE1'},
				{type = 'has_material', material = 'meatsoup', operant = 'gte', value = 25},
				{type = 'timed_option', value = 7, quest = "aliron_church"},
			], text = "ALIRONCHURCHENTERREPLY2", dialogue_argument = 3, type = 'next_dialogue', previous_dialogue_option = 0},
			
			{code = 'divine_symbol_1', text = "DIVINE_SYMBOL_OPTION_1", dialogue_argument = 5, type = 'next_dialogue', reqs = [{type = 'active_quest_stage', value = 'divine_symbol_quest', stage = 'stage1'}], remove_after_first_use = true},
			{code = 'divine_symbol_5', text = "DIVINE_SYMBOL_OPTION_7", dialogue_argument = 6, type = 'next_dialogue', reqs = [{type = 'has_material', operant = 'gte', value = 1, material = 'divine_symbol'},{type = 'active_quest_stage', value = 'divine_symbol_quest', stage = 'stage2'}]},
			{code = 'marriage_church_1', text = "MARRIAGE_CHURCH_CORE", reqs = [{type = 'dialogue_seen', value = 'MARRIAGE_CHURCH_TEXT_4', check = false}], dialogue_argument = 1 },
			{code = 'marriage_final_init', text = "MARRIAGE_CHURCH_FINISH_CORE", reqs = [
				{type = 'active_quest_stage', value = 'marriage_quest_main', stage = 'stage2'},
				{type = 'has_spouse', check = true},
				{type = 'quest_completed', name = 'marriage_quest_servants', check = true},
				{type = 'quest_completed', name = 'marriage_quest_workers', check = true},
				], dialogue_argument = 1},
			{code = 'zephyra_disappearance_bowl_1', text = "ZEPHYRA_DISAPPEARANCE_BOWL_OPTION_1", reqs = [{type = 'active_quest_stage', value = 'zephyra_disappearance_quest', stage = 'stage2'},{type = 'dialogue_seen', value = 'ZEPHYRA_DISAPPEARANCE_BOWL_1', check = false}, {type = 'decision', value = 'GotFakeZephyraBowl', check = false}], dialogue_argument = 0, type = 'next_dialogue'},
			{code = 'zephyra_disappearance_bowl_2', text = "ZEPHYRA_DISAPPEARANCE_BOWL_OPTION_1", reqs = [{type = 'active_quest_stage', value = 'zephyra_disappearance_quest', stage = 'stage2'}, {type = 'dialogue_seen', value = 'ZEPHYRA_DISAPPEARANCE_BOWL_1', check = true}, {type = 'decision', value = 'GotFakeZephyraBowl', check = false}], dialogue_argument = 0, type = 'next_dialogue'},
			{code = 'heleviel_slave_church_intro', text = tr("HELEVIEL_CITY_OPTION"), reqs = [{type = 'active_quest_stage', value = 'heleviel_slave_quest', stage = 'stage3'}], dialogue_argument = 0, type = 'next_dialogue'},
			
			{code = 'aliron_church_leave', reqs = [], text = "DIALOGUELEAVE", dialogue_argument = 4},
		],
		
	},

	aliron_church_quest_start = {
		custom_background = "church_event", 
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ALIRONCHURCHQUESTSTART", reqs = [], 			bonus_effects = [
				{code = 'progress_quest', value = 'aliron_church_quest', stage = 'stage1'},
			]},
		],
		options = [
			{code = 'aliron_church_quest_start1', reqs = [], text = "ALIRONCHURCHQUESTSTARTREPLY1", dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'aliron_church_quest_start1', reqs = [], text = "ALIRONCHURCHQUESTSTARTREPLY2", dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'aliron_church_quest_start1', reqs = [], text = "ALIRONCHURCHQUESTSTARTREPLY3", dialogue_argument = 3, type = 'next_dialogue'},
		],
		
	},

	aliron_church_quest_start1 = {
		custom_background = "church_event",
		image = null,
		character = 'ginny',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ALIRONCHURCHQUESTSTART1_1", reqs = [],  previous_dialogue_option = 1},
			{text = "ALIRONCHURCHQUESTSTART1_2", reqs = [],  previous_dialogue_option = 2},
			{text = "ALIRONCHURCHQUESTSTART1_3", reqs = [],  previous_dialogue_option = 3},
		],
		options = [
			{code = 'aliron_church_quest_start1', reqs = [], text = "ALIRONCHURCHQUESTSTARTREPLY2", dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 1},
			{code = 'aliron_church_quest_start1', reqs = [], text = "ALIRONCHURCHQUESTSTARTREPLY3", dialogue_argument = 3, type = 'next_dialogue', previous_dialogue_option = 1},
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], previous_dialogue_option = [2,3], bonus_effects = [{code = 'background_noise', value = 'resume'}]},
		],
		
	},

	aliron_church_quest_complete = {
		variations = [
			{
				reqs = [
					{type = 'active_quest_stage', value = 'aliron_church_quest', stage = 'stage1'},
					{type = 'dialogue_seen', check = false, value = 'ALIRONCHURCHQUESTCOMPLETE1'},
				],
				image = null,
				custom_background = "church_event",
				character = 'ginny',
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ALIRONCHURCHQUESTCOMPLETE1", 
					reqs = []},
				],
				options = [
					{code = 'aliron_church_enter', 
					reqs = [], 
					text = "DIALOGUECONTINUE", 
					dialogue_argument = 5, 
					type = 'next_dialogue',
					bonus_effects = [
						# {code = 'complete_quest', value = 'aliron_church_quest'},
						{code = "material_change", material = "meatsoup", operant = '-', value = 25},
						{code = 'make_loot', pool = [['aliron_church_bonus',5]]}, {code = 'open_loot'},
						{code = "unlock_class", name = "priest"},
						{code = 'reset_day_count', quest = "aliron_church"},
						{code = 'complete_quest', value = 'aliron_church_quest'},
				]}],	
			},
			{
				reqs = [{type = 'dialogue_seen', check = true, value = 'ALIRONCHURCHQUESTCOMPLETE1'},],
				image = null,
				custom_background = "church_event",
				character = 'ginny',
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ALIRONCHURCHQUESTCOMPLETE2", reqs = []},
				],
				options = [
					{code = 'aliron_church_enter', reqs = [], text = "DIALOGUECONTINUE", dialogue_argument = 5, type = 'next_dialogue',
					bonus_effects = [
						{code = "material_change", material = "meatsoup", operant = '-', value = 25},
						{code = 'make_loot', pool = [['aliron_church_bonus',5]]}, {code = 'open_loot'},
						{code = 'reset_day_count', quest = "aliron_church"},
				],	
				},
				],
			}
		]
		
	},

}
