var data = {
	intermission_intro1 = {
		image = null,
		character = "greg",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSIONINTRO1", reqs = []}
		],
		options = [
			{code = "intermission_intro2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},

	intermission_intro2 = {
		image = null,
		character = "greg",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSIONINTRO2", reqs = []}
		],
		options = [
			{code = "intermission_intro3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},

	intermission_intro3 = {
		image = null,
		character = "greg",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSIONINTRO3", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
}
