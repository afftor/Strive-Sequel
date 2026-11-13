extends Reference
var data = {
	amelia_final_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "AMELIA_FINAL_5_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "AMELIA_FINAL_5_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "AMELIA_FINAL_5_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "AMELIA_FINAL_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "amelia_final_6",
				text = "AMELIA_FINAL_5_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "amelia_final_7",
				text = "AMELIA_FINAL_5_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	amelia_final_6 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "AMELIA_FINAL_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "amelia_sex_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		]
	},
	amelia_sex_1 = {
		custom_background = "amelia_sex1",
		 music = "intimate", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "amelia_sex",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "AMELIA_SEX_1",
		options = [
			{
				code = "amelia_sex_2",
				text = "AMELIA_SEX_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "amelia_sex_2",
				text = "AMELIA_SEX_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	amelia_sex_2 = {
		custom_background = "amelia_sex1",
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
				text = "AMELIA_SEX_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "AMELIA_SEX_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "AMELIA_SEX_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "amelia_sex_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	amelia_sex_3 = {
		custom_background = "amelia_sex2",
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
				text = "AMELIA_SEX_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "amelia_sex_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	amelia_sex_4 = {
		custom_background = "amelia_sex3",
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
				text = "AMELIA_SEX_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "amelia_sex_5",
				text = "AMELIA_SEX_4_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "amelia_sex_5",
				text = "AMELIA_SEX_4_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	amelia_sex_5 = {
		custom_background = "amelia_sex3",
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
				text = "AMELIA_SEX_5_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "AMELIA_SEX_5_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "AMELIA_SEX_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
}
