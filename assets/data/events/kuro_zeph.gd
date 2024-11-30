extends Reference
var data = {
	kuro_zeph_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
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
		character = "kuro",
		character2 = "zephyra",
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
		character = "kuro",
		character2 = "zephyra",
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

	kuro_zeph_tailjob = {
		reqs = [
			{
				type = "decision",
				value = "ZephTailGrabbed",
				check = true,
				negative = "repeat_next_day"
			},
			{
				type = "quest_completed",
				name = "kuro_errand_quest",
				check = true,
				negative = "repeat_next_day"
			},
			{
				type = "quest_completed",
				name = "zephyra_disappearance_quest",
				check = true,
				negative = "repeat_next_day"
			},
			{
				type = "has_hero",
				name = "zephyra",
				check = true,
				negative = "repeat_next_day"
			},
			{
				type = "has_hero",
				name = "kuro",
				check = true,
				negative = "repeat_next_day"
			}
		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_ZEPH_TAILJOB",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		text = [
			{
				text = "KURO_ZEPH_TAILJOB2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		character2 = "zephyra",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "kuro_zeph_tailjob",
		text = [
			{
				text = "KURO_ZEPH_TAILJOB3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_zephyra_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		text = [
			{
				text = "KURO_ZEPH_TAILJOB4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_zephyra_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_ZEPH_TAILJOB5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob6",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "kuro_zephyra_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_ZEPH_TAILJOB6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob7",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "kuro_zephyra_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_ZEPH_TAILJOB7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_zeph_tailjob8",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_zeph_tailjob8 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_zephyra_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_ZEPH_TAILJOB8",
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
