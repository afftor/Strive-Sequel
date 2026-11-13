extends Reference
var data = {
	kuro_tome_sex = {
		reqs = [

		],
		music = 'intimate_dark',
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		start_dialogue_option = 9,
		text = [
			{
				text = "KURO_TOME_SEX",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_TOME_REPLY_MEANING",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "kuro_tome_sex",
				text = "KURO_TOME_OPT_MEANING",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_tome_sex2",
				text = "KURO_TOME_OPT_DO",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_TOME_OPT_LEAVE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{code = "affect_unique_character", name = "kuro", type = "stat", stat = "respect", value = 20},
					{
						code = "decision",
						value = "KuroSkippedSex"
					},
					{
						code = "complete_quest",
						value = "kuro_tome_quest"
					},
					{
						code = "add_timed_event",
						value = "kuro_church_start",
						args = [
							{
								type = "add_to_date",
								date = [
									6,
									6
								],
								hour = 1
							}
						]
					},
					{
						code = "add_timed_event",
						value = "kuro_zeph_start",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									4
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	kuro_tome_sex2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_1",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "kuro_tome",
		text = "KURO_TOME_SEX2",
		options = [
			{
				code = "kuro_tome_sex3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "KURO_TOME_SEX3",
		options = [
			{
				code = "kuro_tome_sex4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex6",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex7",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "KURO_TOME_SEX7",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "kuro_tome_quest"
					},
					{
						code = "add_timed_event",
						value = "kuro_church_start",
						args = [
							{
								type = "add_to_date",
								date = [
									6,
									6
								],
								hour = 1
							}
						]
					},
					{
						code = "add_timed_event",
						value = "kuro_zeph_start",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									4
								],
								hour = 1
							}
						]
					}
				]
			}
		],
		common_effects = [
			{
				code = "unique_character_changes",
				value = "kuro",
				args = [
					{
						code = "take_virginity",
						type = "vaginal",
						partner = "master"
					},
					{
						code = "tag",
						operant = "remove",
						value = "no_sex"
					}
				]
			}
		]
	},
}
