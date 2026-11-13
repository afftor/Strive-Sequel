extends Reference
var data = {

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
