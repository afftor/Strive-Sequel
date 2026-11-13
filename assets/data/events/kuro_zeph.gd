extends Reference
var data = {
	kuro_zeph_start = {
		reqs = [

		],
		music = "zephyra_theme",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "$kuro",
		character2 = "$zephyra",
		text = [
			{
				text = "KURO_ZEPH_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_start2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "$kuro",
		character2 = "$zephyra",
		text = [
			{
				text = "KURO_ZEPH_START2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_start3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_start3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "$kuro",
		character2 = "$zephyra",
		text = [
			{
				text = "KURO_ZEPH_START3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
}
