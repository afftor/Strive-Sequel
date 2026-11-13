extends Reference
var data = {
	after_temple_priestess_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$heleviel",
		text = [
			{
				text = "AFTER_TEMPLE_PRIESTESS_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_temple_priestess_5_1",
				text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "after_temple_priestess_5_1and2",
				text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "after_temple_priestess_5_1and2",
				text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	after_temple_priestess_5_1 = {
		variations = [
			{
				image = null,
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "sex",
								operant = "neq",
								value = "female"
							}
						]
					}
				],
				character = "$heleviel",
				text = [
					{
						text = "AFTER_TEMPLE_PRIESTESS_5_1_1_BAD",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "after_temple_priestess_5_1and2",
						text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_2",
						reqs = [

						],
						dialogue_argument = 2,
						type = "next_dialogue"
					},
					{
						code = "after_temple_priestess_5_1and2",
						text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_3",
						reqs = [

						],
						dialogue_argument = 3,
						type = "next_dialogue"
					}
				]
			},
			{
				image = null,
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				reqs = [

				],
				character = "$heleviel",
				text = [
					{
						text = "AFTER_TEMPLE_PRIESTESS_5_1_1",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "after_temple_priestess_5_1_2",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					}
				]
			}
		]
	},
	after_temple_priestess_5_1_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$heleviel",
		text = [
			{
				text = "AFTER_TEMPLE_PRIESTESS_5_1_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_temple_priestess_5_1_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	after_temple_priestess_5_1_3 = {
		custom_background = "heleviel1",
		music = 'intimate',
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		common_effects = [
			{
				code = "unique_character_changes",
				value = "heleviel",
				args = [
					{
						code = "tag",
						operant = "remove",
						value = "no_sex"
					}
				]
			}
		],
		text = [
			{
				text = "AFTER_TEMPLE_PRIESTESS_5_1_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_temple_priestess_5_1_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	after_temple_priestess_5_1_4 = {
		custom_background = "heleviel2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "AFTER_TEMPLE_PRIESTESS_5_1_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_temple_priestess_5_1_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	after_temple_priestess_5_1_5 = {
		custom_background = "heleviel3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "AFTER_TEMPLE_PRIESTESS_5_1_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_temple_priestess_5_1_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	after_temple_priestess_5_1_6 = {
		custom_background = "heleviel4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "AFTER_TEMPLE_PRIESTESS_5_1_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_temple_priestess_5_1and2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1,
				close_speed = 1
			}
		]
	},
}
