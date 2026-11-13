extends Reference
var data = {
	zephyra_bath_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		music = "intimate_funny", 
		reqs = [
			{
				type = "has_bath",
				check = true,
				negative = "repeat_next_day"
			},
			{
				type = "unique_character_checks",
				name = "zephyra",
				value = [
					{
						code = "is_free",
						check = true
					}
				],
				negative = "repeat_next_day"
			}
		],
		character = "zephyra_nude",
		text = "ZEPHYRA_BATH_1",
		common_effects = [
			{
				code = "unique_character_changes",
				value = "zephyra",
				args = [
					{
						code = "tag",
						operant = "remove",
						value = "no_sex"
					}
				]
			}
		],
		options = [
			{
				code = "zephyra_bath_2",
				text = "ZEPHYRA_BATH_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "zephyra_bath_2",
				text = "ZEPHYRA_BATH_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "ZEPHYRA_BATH_1_O_0",
				reqs = [

				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "zephyra_bath_quest"
					}
				]
			}
		]
	},
	zephyra_bath_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "zephyra_nude",
		text = [
			{
				text = "ZEPHYRA_BATH_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ZEPHYRA_BATH_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "zephyra_bath_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	zephyra_bath_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "ZEPHYRA_BATH_3",
				reqs = [

				]
			}
		],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_bath_1",
		options = [
			{
				code = "zephyra_bath_4",
				reqs = [

				],
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	zephyra_bath_4 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "ZEPHYRA_BATH_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_bath_2",
		options = [
			{
				code = "zephyra_bath_5",
				reqs = [

				],
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	zephyra_bath_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "ZEPHYRA_BATH_5",
				reqs = [

				]
			}
		],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_bath_4",
		options = [
			{
				code = "zephyra_bath_6",
				reqs = [

				],
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				dialogue_argument = 1,
				change_dialogue_type = 1,
				close_speed = 1
			}
		]
	},
	zephyra_bath_6 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "$zephyra",
		text = [
			{
				text = "ZEPHYRA_BATH_6",
				reqs = [

				]
			},
			{
				text = "",
				reqs = [{type = "quest_completed", name = "getting_lira_quest", check = true}],
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "zephyra_painting_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									3
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
				value = "zephyra",
				args = [
					{
						code = "take_virginity",
						type = "vaginal",
						partner = "master"
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "zephyra_bath_quest"
					},
					{
						code = "add_timed_event",
						value = "zephyra_lilia_1",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									5
								],
								hour = 2
							}
						]
					}
				]
			}
		]
	},
	zephyra_lilia_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$zephyra",
		character2 = "$lilia",
		text = [
			{
				text = "ZEPHYRA_LILIA_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "zephyra_lilia_4_1",
				text = "ZEPHYRA_LILIA_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "zephyra", type = "stat", stat = "affection", value = 15},
				]
			},
			{
				code = "zephyra_lilia_4_2",
				text = "ZEPHYRA_LILIA_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "zephyra", type = "stat", stat = "affection", value = -15},
				]
			},
			{
				code = "zephyra_lilia_4_3",
				text = "ZEPHYRA_LILIA_3_OPTION_3",
				reqs = [
					{
						type = "has_money",
						value = 100
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "zephyra", type = "stat", stat = "affection", value = 10},
				]
			}
		]
	},
	zephyra_lilia_4_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$zephyra",
		character2 = "$lilia",
		text = [
			{
				text = "ZEPHYRA_LILIA_4_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "zephyra_lilia_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	zephyra_lilia_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		music = "intimate", 
		unlocked_gallery_seq = "zephyra_lilia",
		save_scene_to_gallery = true,
		reqs = [

		],
		character = "$zephyra",
		character2 = "$lilia",
		text = [
			{
				text = "ZEPHYRA_LILIA_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "zephyra_lilia_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	zephyra_lilia_6 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = [
			{
				text = "ZEPHYRA_LILIA_6",
				reqs = [

				]
			}
		],
		custom_background = "blackscreen",
		options = [
			{
				code = "zephyra_lilia_7",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	zephyra_lilia_7 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = [
			{
				text = "ZEPHYRA_LILIA_7",
				reqs = [

				]
			}
		],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_lilia_1",
		options = [
			{
				code = "zephyra_lilia_8",
				reqs = [

				],
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	zephyra_lilia_8 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "ZEPHYRA_LILIA_8",
				reqs = [

				]
			}
		],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_lilia_2",
		options = [
			{
				code = "zephyra_lilia_9",
				reqs = [

				],
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	zephyra_lilia_9 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "ZEPHYRA_LILIA_9",
				reqs = [

				]
			}
		],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_lilia_3",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	}
}
