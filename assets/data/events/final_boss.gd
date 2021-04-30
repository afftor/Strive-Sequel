var data = {
	final_boss_start = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'aire_is_dead', check = true}],
				image = null,
				tags = ['master_translate'],
				text = [{text = "FINAL_BOSS_1", reqs = []}],
				options = [
					{code = 'quest_fight', args = 'greg_boss_fight', text = "DIALOGUEFIGHTOPTION", reqs = []},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_is_saved', check = false}],
				image = null,
				tags = ['master_translate'],
				text = [{text = "FINAL_BOSS_2", reqs = []}],
				options = [
					{ code = 'quest_fight', args = 'aire_boss_fight', text = "DIALOGUEFIGHTOPTION", reqs = []},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_raped', check = true}],
				image = null,
				tags = ['master_translate'],
				text = [{text = "FINAL_BOSS_3", reqs = []}],
				options = [
					{
						code = 'quest_fight', args = 'aire_boss_fight',
						text = "DIALOGUEFIGHTOPTION",
						reqs = [],
						dialogue_argument = 1,
						type = 'next_dialogue'
					},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_raped', check = false}],
				image = null,
				tags = ['master_translate'],
				text = [{text = "FINAL_BOSS_4", reqs = []}],
				options = [
					{
						code = 'quest_fight', args = 'aire_boss_fight',
						text = "DIALOGUEFIGHTOPTION",
						reqs = [],
						dialogue_argument = 1,
						type = 'next_dialogue'
					},
				],
			},
		]
	},
	aire_combat_on_win_2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "AIRE_COMBAT_ON_WIN_2", reqs = []},
		],
		options = [
			{
				code = 'aire_combat_on_win_3',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	aire_combat_on_win_3 = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'aire_is_dead', check = false}],
				image = null,
				tags = ['master_translate'],
				text = [{text = "AIRE_COMBAT_ON_WIN_3", reqs = []}],
				options = [
					{code = 'close', text = "DIALOGUECLOSE", reqs = []},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_is_dead', check = true}],
				image = null,
				tags = ['master_translate'],
				text = [{text = "AIRE_COMBAT_ON_WIN_3_1", reqs = []}],
				options = [
					{
						code = 'close',
						text = "DIALOGUECLOSE",
						reqs = [],
					},
				],
			},
		]
	},
	greg_combat_on_win_1 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "GREG_COMBAT_ON_WIN_1", reqs = []},
		],
		options = [
			{
				code = 'greg_combat_on_win_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	greg_combat_on_win_2 = {
		variations = [
			{
				reqs = [], # if fought greg
				image = null,
				tags = ['master_translate', 'dialogue_scene'],
				text = [{text = "GREG_COMBAT_ON_WIN_2", reqs = []}],
				options = [
					{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 10},
					{code = 'greg_combat_on_win_5', text = "GREG_COMBAT_OPTION_2", reqs = [], dialogue_argument = 20, remove_after_first_use = true},
					{code = 'greg_combat_on_win_6', text = "GREG_COMBAT_OPTION_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = false}], dialogue_argument = 3},
					{code = 'greg_combat_on_win_7', text = "GREG_COMBAT_OPTION_4", reqs = [{type = 'decision', value = 'aire_is_dead', check = true}], dialogue_argument = 4},
					{code = 'greg_combat_on_win_8', text = "GREG_COMBAT_OPTION_5", reqs = [], dialogue_argument = 5},
					{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_is_dead', check = true}],
				image = null,
				tags = ['master_translate', 'dialogue_scene'],
				text = [{text = "GREG_COMBAT_ON_WIN_3", reqs = []}],
				options = [
					{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 1},
					{code = 'greg_combat_on_win_5', text = "GREG_COMBAT_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
					{code = 'greg_combat_on_win_6', text = "GREG_COMBAT_OPTION_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = false}], dialogue_argument = 3},
					{code = 'greg_combat_on_win_7', text = "GREG_COMBAT_OPTION_4", reqs = [{type = 'decision', value = 'aire_is_dead', check = true}], dialogue_argument = 4},
					{code = 'greg_combat_on_win_8', text = "GREG_COMBAT_OPTION_5", reqs = [], dialogue_argument = 5},
					{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_is_dead', check = false}],
				image = null,
				tags = ['master_translate', 'dialogue_scene'],
				text = [{text = "GREG_COMBAT_ON_WIN_4", reqs = []}],
				options = [
					{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 1},
					{code = 'greg_combat_on_win_5', text = "GREG_COMBAT_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
					{code = 'greg_combat_on_win_6', text = "GREG_COMBAT_OPTION_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = false}], dialogue_argument = 3},
					{code = 'greg_combat_on_win_7', text = "GREG_COMBAT_OPTION_4", reqs = [{type = 'decision', value = 'aire_is_dead', check = true}], dialogue_argument = 4},
					{code = 'greg_combat_on_win_8', text = "GREG_COMBAT_OPTION_5", reqs = [], dialogue_argument = 5},
					{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
				],
			},
		]
	},
	greg_combat_on_win_5 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "GREG_COMBAT_ON_WIN_5", reqs = []},
		],
		options = [
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 1},
			{code = 'greg_combat_on_win_6', text = "GREG_COMBAT_OPTION_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = false}, {type = 'dialogue_seen', check = false, value = 'GREG_COMBAT_ON_WIN_6'}], dialogue_argument = 3},
			{code = 'greg_combat_on_win_7', text = "GREG_COMBAT_OPTION_4", reqs = [{type = 'decision', value = 'aire_is_dead', check = true}], dialogue_argument = 4},
			{code = 'greg_combat_on_win_8', text = "GREG_COMBAT_OPTION_5", reqs = [], dialogue_argument = 5},
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
		],
	},
	greg_combat_on_win_7 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "GREG_COMBAT_ON_WIN_7", reqs = []},
		],
		options = [
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 1},
			{code = 'greg_combat_on_win_5', text = "GREG_COMBAT_OPTION_2", reqs = [{type = 'dialogue_seen', check = false, value = 'GREG_COMBAT_ON_WIN_5'}], dialogue_argument = 2},
			{code = 'greg_combat_on_win_6', text = "GREG_COMBAT_OPTION_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = false}, {type = 'dialogue_seen', check = false, value = 'GREG_COMBAT_ON_WIN_6'}], dialogue_argument = 3},
			{code = 'greg_combat_on_win_8', text = "GREG_COMBAT_OPTION_5", reqs = [], dialogue_argument = 5},
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
		],
	},
	greg_combat_on_win_6 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "GREG_COMBAT_ON_WIN_6", reqs = []},
		],
		options = [
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 1},
			{code = 'greg_combat_on_win_5', text = "GREG_COMBAT_OPTION_2", reqs = [{type = 'dialogue_seen', check = false, value = 'GREG_COMBAT_ON_WIN_5'}], dialogue_argument = 2},
			{code = 'greg_combat_on_win_8', text = "GREG_COMBAT_OPTION_5", reqs = [], dialogue_argument = 5},
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
		],
	},
	greg_combat_on_win_8 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "GREG_COMBAT_ON_WIN_8", reqs = []},
		],
		options = [
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_1", reqs = [], dialogue_argument = 1},
			{code = 'greg_combat_on_win_5', text = "GREG_COMBAT_OPTION_2", reqs = [{type = 'dialogue_seen', check = false, value = 'GREG_COMBAT_ON_WIN_5'}], dialogue_argument = 2},
			{code = 'greg_combat_on_win_6', text = "GREG_COMBAT_OPTION_3", reqs = [{type = 'decision', value = 'aire_is_dead', check = false}, {type = 'dialogue_seen', check = false, value = 'GREG_COMBAT_ON_WIN_6'}], dialogue_argument = 3},
			{code = 'greg_combat_on_win_7', text = "GREG_COMBAT_OPTION_4", reqs = [{type = 'decision', value = 'aire_is_dead', check = true}], dialogue_argument = 4},
			{code = 'greg_combat_on_win_9', text = "GREG_COMBAT_OPTION_6", reqs = [], dialogue_argument = 6},
		],
	},
	greg_combat_on_win_9 = {
		image = null,
		tags = [],
		text = [
			{text = "GREG_COMBAT_ON_WIN_9", reqs = []},
		],
		common_effects = [{code = 'complete_quest', value = 'final_operation'}],
		options = [
			{code = 'leave', text = "DIALOGUELEAVE", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'princess_search', stage = 'stage1'}]},
		],
	},
}
