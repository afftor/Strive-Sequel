extends Reference
var data = {
	amelia_infinite_1 = {
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		reqs = [],
		character = "amelia_halloween",
		text = [{text = "AMELIA_INFINITE_1", reqs = [], previous_dialogue_option = 0, bonus_effects = []}
		],
		options = [
			{code = "amelia_infinite_2", text = "AMELIA_INFINITE_1_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "amelia_infinite_2", text = "AMELIA_INFINITE_1_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "amelia_infinite_2", text = "AMELIA_INFINITE_1_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	amelia_infinite_2 = {
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		reqs = [],
		character = "amelia_halloween",
		text = [
			{text = "AMELIA_INFINITE_2_1", reqs = [], previous_dialogue_option = 1, bonus_effects = []},
			{text = "AMELIA_INFINITE_2_2", reqs = [], previous_dialogue_option = 2, bonus_effects = []},
			{text = "AMELIA_INFINITE_2_3", reqs = [], previous_dialogue_option = 3, bonus_effects = []},
			{text = "AMELIA_INFINITE_2", reqs = [], bonus_effects = []},
		],
		options = [
			{code = "amelia_infinite_3", text = "AMELIA_INFINITE_2_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "amelia_infinite_3", text = "AMELIA_INFINITE_2_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "amelia_infinite_3", text = "AMELIA_INFINITE_2_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	amelia_infinite_3 = {
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		reqs = [],
		character = "amelia_halloween",
		text = [
			{text = "AMELIA_INFINITE_3_1", reqs = [], previous_dialogue_option = 1, bonus_effects = []},
			{text = "AMELIA_INFINITE_3_2", reqs = [], previous_dialogue_option = 2, bonus_effects = []},
			{text = "AMELIA_INFINITE_3_3", reqs = [], previous_dialogue_option = 3, bonus_effects = []},
			{text = "AMELIA_INFINITE_3", reqs = [], bonus_effects = []},
		],
		options = [
			{code = "amelia_infinite_4", text = "AMELIA_INFINITE_3_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "amelia_infinite_4", text = "AMELIA_INFINITE_3_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	amelia_infinite_4 = {
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		reqs = [],
		character = "amelia_halloween",
		text = [
			{text = "AMELIA_INFINITE_4_1", reqs = [], previous_dialogue_option = 1, bonus_effects = []},
			{text = "AMELIA_INFINITE_4_2", reqs = [], previous_dialogue_option = 2, bonus_effects = []},
			{text = "AMELIA_INFINITE_4", reqs = [], bonus_effects = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue", bonus_effects = []},
		]
	},
	
	amelia_bonus = {
		image = null,
		tags = ["dialogue_scene", 'master_translate'],
		music = "amelia_theme", 
		reqs = [],
		character = "amelia",
		text = [{text = "AMELIA_BONUS", reqs = [], bonus_effects = []},],
		options = [
			{code = "servants_introduction", text = "DIALOGUEBACK", reqs = [], dialogue_argument = 1, type = "next_dialogue", previous_dialogue_option = 10},
			{code = "amelia_dialogue_start", text = "DIALOGUEBACK", reqs = [], dialogue_argument = 1, type = "next_dialogue", previous_dialogue_option = 11},
		]
	},
}
