extends Reference
var data = {
	heleviel_quest_12 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_12",
		options = [
			{
				code = "heleviel_bar_sex_1",
				text = "HELEVIEL_QUEST_12_OPTION_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				change_dialogue_type = 2
			},
			{
				code = "heleviel_quest_13",
				text = "HELEVIEL_QUEST_12_OPTION_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		image = "heleviel_bar"
	},
	heleviel_slave_ritual_interlude = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_INTERLUDE",
		options = [
			{
				code = "heleviel_slave_ritual_end",
				text = "HELEVIEL_SLAVE_RITUAL_INTERLUDE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_ritual_sex_attempt",
				text = "HELEVIEL_SLAVE_RITUAL_INTERLUDE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_sex_attempt = {
		variations = [
			{
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "sexuals_factor",
								operant = "gte",
								value = 5
							}
						]
					}
				],
				character = "$heleviel",
				text = [
					{
						text = "HELEVIEL_SLAVE_RITUAL_SEX_ATTEMPT_1",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "heleviel_forest_sex_1",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						change_dialogue_type = 2,
						type = "next_dialogue"
					}
				]
			},
			{
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				reqs = [

				],
				character = "$heleviel",
				text = [
					{
						text = "HELEVIEL_SLAVE_RITUAL_SEX_ATTEMPT_2",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "heleviel_slave_ritual_end",
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
	heleviel_bar_sex_1 = {
		reqs = [

		],
		music = "intimate", 
		unlocked_gallery_seq = "heleviel_bar_sex",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_BAR_SEX_1",
		options = [
			{
				code = "heleviel_bar_sex_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_bar_sex_2 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_BAR_SEX_2",
		options = [
			{
				code = "heleviel_bar_sex_3",
				text = "HELEVIEL_BAR_SEX_2_OPTOPN_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "heleviel_bar_sex_3",
				text = "HELEVIEL_BAR_SEX_2_OPTOPN_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_bar_sex_3 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_4",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_4 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_5",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "HELEVIEL_BAR_SEX_5",
		options = [
			{
				code = "heleviel_bar_sex_6",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_6 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_7",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_7 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_8",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_8 = {
		reqs = [

		],
		music = "heleviel_theme", 
		save_scene_to_gallery = true,
		unlocked_char_sprites = {heleviel = ["waitress"]},
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_BAR_SEX_8",
		options = [
			{
				code = "close",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "complete_quest",
						value = "heleviel_quest1",
					},
					{
						code = "progress_quest",
						value = "heleviel_quest2",
						stage = "stage3"
					},
				]
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_forest_sex_1 = {
		unlocked_gallery_seq = "heleviel_forest_sex",
		music = "intimate", 
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "HELEVIEL_FOREST_SEX_1",
		options = [
			{
				code = "heleviel_forest_sex_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_forest_sex_2 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_FOREST_SEX_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_forest_sex_3",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_forest_sex_3 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_FOREST_SEX_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_forest_sex_4",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_forest_sex_4 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_FOREST_SEX_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_end",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_1 = {
		reqs = [

		],
		music = "intimate", 
		unlocked_gallery_seq = "heleviel_wedding",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_WEDDING_1",
		options = [
			{
				code = "heleviel_wedding_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
		character = "heleviel_wed"
	},
	heleviel_wedding_2 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "heleviel_wed_1",
		text = "HELEVIEL_WEDDING_2",
		options = [
			{
				code = "heleviel_wedding_3",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_3 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "heleviel_wed_2",
		text = "HELEVIEL_WEDDING_3",
		options = [
			{
				code = "heleviel_wedding_4",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_4 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "heleviel_wed_3",
		text = "HELEVIEL_WEDDING_4",
		options = [
			{
				code = "heleviel_wedding_5",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_5 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "heleviel_wed_4",
		text = "HELEVIEL_WEDDING_5",
		options = [
			{
				code = "heleviel_wedding_6",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_6 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		scene_type = "ero_scene",
		custom_background = "heleviel_wed_4",
		text = "HELEVIEL_WEDDING_6",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'complete_quest', value = 'marriage_quest_main'}, 
					{code = 'complete_wedding'} ]
			}
		]
	}
}
