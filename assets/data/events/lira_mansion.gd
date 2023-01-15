var data = {
	
	lira_mansion_1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_MANSION_1", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	lira_mansion_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_MANSION_2", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	lira_mansion_3 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_MANSION_3", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_4',
				text = "LIRA_MANSION_3_OPTION_1",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			},
			{
				code = 'lira_mansion_4',
				text = "LIRA_MANSION_3_OPTION_2",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 2,
				change_dialogue_type = 2
			},
		],
	},
	lira_mansion_4 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lira_sex_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "LIRA_MANSION_4_1", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_MANSION_4_2", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_MANSION_4", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	lira_mansion_5 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lira_sex_1",
		scene_type = "ero_scene",
		text = [
			{text = "LIRA_MANSION_5", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	lira_mansion_6 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lira_sex_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "LIRA_MANSION_6", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	lira_mansion_7 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lira_sex_2",
		scene_type = "ero_scene",
		text = [
			{text = "LIRA_MANSION_7", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_8',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	lira_mansion_8 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lira_sex_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "LIRA_MANSION_8", reqs = []},
		],
		options = [
			{
				code = 'lira_mansion_9',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1
			},
		],
	},
	lira_mansion_9 = {
		image = null,
		character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_MANSION_9", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
}
