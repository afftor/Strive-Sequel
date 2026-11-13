extends Reference
var data = {
	rouge_furniture_reward = {
		image = null,
		reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true}],
		character = "$rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_FURNITURE_REWARD",
		options = [
			{code = "rouge_sex_1", text = "ROUGE_FURNITURE_REWARD_OPTION_ACCEPT", type = "next_dialogue", reqs = [], dialogue_argument = 1},
			{code = "rouge_furniture_reward_refuse", text = "ROUGE_FURNITURE_REWARD_OPTION_REFUSE", type = "next_dialogue", reqs = [], dialogue_argument = 1}
		]
	},

	rouge_sex_1 = {
		image = null,
		reqs = [],
		music = 'intimate_dark',
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "rouge_sex",
		text = "ROUGE_SEX_1",
		options = [{code = "rouge_sex_2", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_2 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_2",
		options = [{code = "rouge_sex_3", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_3 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_3",
		options = [{code = "rouge_sex_4", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_4 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_4",
		options = [{code = "rouge_sex_5", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_5 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_5",
		options = [{code = "rouge_sex_6", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_6 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_6",
		options = [{code = "rouge_sex_7", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_7 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_7",
		options = [{code = "rouge_sex_8", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_8 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene", "master_translate"],
		custom_background = "rouge_sex_8",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_8",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue"}]
	},
}
