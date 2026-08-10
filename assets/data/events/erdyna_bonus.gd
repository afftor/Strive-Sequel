extends Reference
var data = {
	erdyna_campfire_1 = {
		image = null,
		character = "$erdyna",
		music = "intimate",
		tags = ["dialogue_scene"],
		reqs = [],
		unlocked_gallery_seq = "erdyna_campfire",
		save_scene_to_gallery = true,
		text = "ERDYNA_CAMPFIRE_1",
		options = [
			{code = "erdyna_campfire_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_campfire_2 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "erdyna_campfire1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ERDYNA_CAMPFIRE_2",
		options = [
			{code = "erdyna_campfire_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_campfire_3 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "erdyna_campfire2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ERDYNA_CAMPFIRE_3",
		options = [
			{code = "erdyna_campfire_4", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_campfire_4 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "erdyna_campfire3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ERDYNA_CAMPFIRE_4",
		options = [
			{code = "erdyna_campfire_5", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_campfire_5 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "erdyna_campfire3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ERDYNA_CAMPFIRE_5",
		options = [
			{code = "erdyna_campfire_6", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_campfire_6 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		custom_background = "erdyna_campfire4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ERDYNA_CAMPFIRE_6",
		options = [
			{code = "erdyna_campfire_epilogue", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_campfire_epilogue = {
		image = null,
		character = "$erdyna",
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = "ERDYNA_CAMPFIRE_EPILOGUE",
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [
				{code = "decision", value = "ErdynaCampfireHappened"},
				{code = "progress_quest", value = "erdyna_quest", stage = "erdyna_return"},
				{code = "remove_quest_location", value = "quest_thalendir_house"},
				{code = "plan_loc_event", loc = "empire_capital", event = "erdyna_capital_return_1"},
				{code = "update_city"}
			]}
		]
	},

	erdyna_rouge_after_campfire_1 = {
		image = null,
		character = "$erdyna",
		character2 = "$rouge",
		tags = ["dialogue_scene"],
		reqs = [
			{type = "decision", value = "ErdynaCampfireHappened", check = true},
			{type = "unique_available", name = "erdyna", check = true},
			{type = "unique_available", name = "rouge", check = true}
		],
		text = "ERDYNA_ROUGE_AFTER_CAMPFIRE_1",
		options = [
			{code = "erdyna_rouge_after_campfire_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_rouge_after_campfire_2 = {
		image = null,
		character = "$erdyna",
		character2 = "$rouge",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ERDYNA_ROUGE_AFTER_CAMPFIRE_2",
		options = [
			{code = "erdyna_rouge_after_campfire_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	erdyna_rouge_after_campfire_3 = {
		image = null,
		character = "$erdyna",
		character2 = "$rouge",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ERDYNA_ROUGE_AFTER_CAMPFIRE_3",
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue"}
		]
	},
}
