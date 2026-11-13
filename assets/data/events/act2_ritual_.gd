extends Reference
var data = {
	ritual_start = {
		image = null,
		music = "intimate_dark",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "RITUAL_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ritual_1_1",
				text = "RITUAL_START_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ritual_1_2",
				text = "RITUAL_START_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	ritual_1_1 = {
		image = "ritual",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "RITUAL_1_1_GOOD",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics",
								operant = "gte",
								value = 30
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "decision",
						value = "putPowder"
					}
				]
			},
			{
				text = "RITUAL_1_1_BAD",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics",
								operant = "lt",
								value = 30
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "ritual_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	ritual_1_2 = {
		image = "ritual",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "RITUAL_1_2",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "decision",
				value = "maePregnant"
			}
		],
		options = [
			{
				code = "ritual_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	ritual_2 = {
		custom_background = "mae_scene3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "RITUAL_2",
		options = [
			{
				code = "ritual_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ritual_3 = {
		custom_background = "mae_scene4",
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
				text = "RITUAL_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ritual_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ritual_4 = {
		custom_background = "mae_scene4",
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
				text = "RITUAL_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ritual_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ritual_5 = {
		custom_background = "mae_scene5",
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
				text = "RITUAL_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ritual_6_1_1",
				text = "RITUAL_5_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ritual_6_2",
				text = "RITUAL_5_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	ritual_6_1_1 = {
		custom_background = "mae_scene6",
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
				code = "decision",
				value = "letFuck"
			},
			{code = "dialogue_counter", name = "mae_perverted_actions", op = "+"}
		],
		text = [
			{
				text = "RITUAL_6_1_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ritual_6_1_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	ritual_6_1_2 = {
		custom_background = "mae_scene7",
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
				text = "RITUAL_6_1_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_ritual_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue",
				change_dialogue_type = 1,
				close_speed = 1
			}
		]
	},
	ritual_6_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "RITUAL_6_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_ritual_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	after_ritual_start = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		music = "mae_theme",
		reqs = [

		],
		character = "savra",
		character2 = "leon",
		text = [
			{
				text = "AFTER_RITUAL_START",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "AFTER_RITUAL_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "after_ritual_start_1",
				text = "AFTER_RITUAL_START_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "after_ritual_1_2",
				text = "AFTER_RITUAL_START_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	after_ritual_start_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "savra",
		character2 = "leon",
		text = [
			{
				text = "AFTER_RITUAL_START",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "AFTER_RITUAL_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "after_ritual_1_2",
				text = "AFTER_RITUAL_START_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	after_ritual_1_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "savra",
		character2 = "leon",
		text = [
			{
				text = "AFTER_RITUAL_1_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_ritual_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	after_ritual_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "AFTER_RITUAL_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_ritual_3",
				text = "AFTER_RITUAL_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "mae_sympathy",
						op = 0
					}
				]
			},
			{
				code = "after_ritual_3",
				text = "AFTER_RITUAL_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "mae_sympathy",
						op = 0
					}
				]
			}
		]
	},
	after_ritual_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "AFTER_RITUAL_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_ritual_4",
				text = "AFTER_RITUAL_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [

				]
			},
			{
				code = "after_ritual_4",
				text = "AFTER_RITUAL_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [

				]
			},
			{
				code = "after_ritual_4",
				text = "AFTER_RITUAL_3_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "mae_sympathy",
						op = "+"
					}
				]
			}
		]
	},
	after_ritual_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "AFTER_RITUAL_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "after_ritual_5",
				text = "AFTER_RITUAL_4_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [

				]
			},
			{
				code = "after_ritual_5",
				text = "AFTER_RITUAL_4_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [

				]
			},
			{
				code = "after_ritual_5",
				text = "AFTER_RITUAL_4_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				bonus_effects = [

				]
			},
			{
				code = "after_ritual_5",
				text = "AFTER_RITUAL_4_OPTION_4",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "mae_sympathy",
						op = "+"
					}
				]
			}
		]
	},
	after_ritual_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "AFTER_RITUAL_5_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "AFTER_RITUAL_5_2AND3",
				reqs = [

				],
				previous_dialogue_option = [
					2,
					3
				]
			},
			{
				text = "AFTER_RITUAL_5_4",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "after_ritual_variant",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [

				]
			}
		]
	},
}
