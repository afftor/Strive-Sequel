extends Reference
var data = {
	
	heleviel_mansion_1 = {
		image = null, reqs = [],
		unlocked_gallery_seq = "heleviel_mansion",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "HELEVIEL_MANSION_1", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	heleviel_mansion_2 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "HELEVIEL_MANSION_2", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	heleviel_mansion_3 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "HELEVIEL_MANSION_3", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			},
		],
	},
	heleviel_mansion_4 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		custom_background = "heleviel_bj_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = 'unique_character_changes', value = 'heleviel', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		text = [
			{text = "HELEVIEL_MANSION_4", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	heleviel_mansion_5 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		custom_background = "heleviel_bj_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "HELEVIEL_MANSION_5", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	heleviel_mansion_6 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		custom_background = "heleviel_bj_2",
		scene_type = "ero_scene",
		text = [
			{text = "HELEVIEL_MANSION_6", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	heleviel_mansion_7 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		custom_background = "heleviel_bj_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "HELEVIEL_MANSION_7", reqs = []},
		],
		options = [
			{
				code = 'heleviel_mansion_8',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1
			},
		],
	},
	heleviel_mansion_8 = {
		image = null, reqs = [],
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "HELEVIEL_MANSION_8", reqs = []},
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
