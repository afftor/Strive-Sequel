var data = {
	dwarf_tavern = {
		reqs = [],
		tags = ['dialogue_scene'],
		text = [
			{
				text = "DTAVERN_START", reqs = [], previous_dialogue_option = 0
			},{
				text = "DTAVERN_INTRO", previous_dialogue_option = 0,
				reqs = [
					{type = 'master_check', value = [{code = 'race', race = 'Dwarf', check = false}]},
					{type = 'dialogue_seen', check = false, value = 'DTAVERN_INTRO'}
				]
			},{
				text = "DTAVERN_INTRO_DWARF", previous_dialogue_option = 0,
				reqs = [
					{type = 'master_check', value = [{code = 'race', race = 'Dwarf', check = true}]},
					{type = 'dialogue_seen', check = false, value = 'DTAVERN_INTRO_DWARF'}
				]
			},{
				text = "", reqs = [], previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = 'dwarf_tavern_barkeep',
				text = "DWARF_TAVERN_BARKEEP", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [
					{type = 'event_seen', check = false, value = 'dwarf_tavern_bark_physics'},
					{type = 'event_seen', check = false, value = 'dwarf_tavern_bark_leave'}
				]
			},{
				code = 'dwarf_tavern_patron',
				text = "DWARF_TAVERN_PATRONS", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},{
				code = 'dwarf_tavern_jean',
				text = "DWARF_TAVERN_GIRL", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'active_quest_stage', value = 'visit_dwarfs_quest', stage = 'tavern'}],
			},{
				code = 'dwarf_tavern_rebel',
				text = "DWARF_TAVERN_REBELS", dialogue_argument = 0, type = 'next_dialogue',
				reqs = [{type = 'active_quest_stage', value = 'dking_hara_quest', stage = 'rebeltavern'}],
			},{
				code = 'close',
				text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
			},
		]
	},
	
	
	
	dwarf_workshop = {
		variations = [
			{#closed
				reqs = [{type = "has_active_quest", name = "hara_scales_quest", check = false}],
				tags = ['dialogue_scene'],
				text = [{text = "DWARF_WORKSHOP_CLOSED1", reqs = []}],
				options = [
					{
						code = 'dwarf_workshop_closed2',
						text = "DIALOGUECONTINUE", dialogue_argument = 0, type = 'next_dialogue',
						reqs = []
					},
				]
			},{#first enter
				reqs = [{type = 'dialogue_seen', check = false, value = 'DKING2TASK_HARA_START'}],
				tags = ['dialogue_scene'],
				text = [
					{text = "DWARF_WARKSHOP_START", reqs = []},
					{text = "DKING2TASK_HARA_START", reqs = []},
				],
				options = [
					{
						code = 'dking2task_hara_1',
						text = "DIALOGUECONTINUE", dialogue_argument = 0, type = 'next_dialogue',
						reqs = []
					},
				]
			},{#normal
				reqs = [],
				tags = ['dialogue_scene'],
				text = [
					{text = "DWARF_WARKSHOP_START", reqs = [], previous_dialogue_option = 0},
					{text = "", reqs = [], previous_dialogue_option = 1},
					{text = "DKING2TASK_HARA_2", reqs = [], previous_dialogue_option = 2}
				],
				options = [
					{
						code = "dking2task_hara_3",
						text = "DKING2TASK_HARA_2_OPT_1",
						reqs = [{type = 'active_quest_stage', value = 'hara_scales_quest', stage = 'next_day', state = false}],
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
		],
	},
}
