extends Reference
var data = {
	mae_druid_return_1 = {
		image = null,
		music = 'mae_theme',
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "$mae",
		text = "MAE_DRUID_RETURN",
		common_effects = [
			{code = "affect_unique_character", name = "mae", type = "set_availability", value = true},
			{code = "affect_unique_character", name = "mae", type = "add_class", class = "druid"},
			{code = "decision", value = "mae_druid_training_done"},
		],
		options = [
			{code = "mae_sex_behind_1", text = "MAE_DRUID_RETURN_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2},
			{code = "mae_druid_return_2", text = "MAE_DRUID_RETURN_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue", bonus_effects = [{code = "affect_unique_character", name = "mae", type = "stat", stat = "affection", value = 15}]},
			{code = "mae_druid_return_2", text = "MAE_DRUID_RETURN_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue", bonus_effects = [{code = "affect_unique_character", name = "mae", type = "stat", stat = "affection", value = -15}]}
		]
	},
	
	mae_sex_behind_1 = {
		unlocked_gallery_seq = "mae_sex_behind",
		custom_background = "mae_scene8",
		scene_type = "ero_scene",
		music = 'intimate_funny',
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_1",
		options = [
			{code = "mae_sex_behind_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_sex_behind_2 = {
		custom_background = "mae_scene9",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_2",
		options = [
			{code = "mae_sex_behind_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_sex_behind_3 = {
		custom_background = "mae_scene9",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_3",
		options = [
			{code = "mae_sex_behind_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_sex_behind_4 = {
		custom_background = "mae_scene10",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_4",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1,
				type = "next_dialogue", 
				bonus_effects = [
					{code = "dialogue_counter", name = "mae_perverted_actions", op = "+"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"},
					{code = 'decision', value = 'MaeBehind'}
				],
				change_dialogue_type = 1
			}
		]
	},
}
