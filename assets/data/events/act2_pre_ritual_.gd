extends Reference
var data = {
	pre_ritual_6 = {
		image = null,
		music = "mae_theme",
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "PRE_RITUAL_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_7_1and2and4",
				text = "PRE_RITUAL_6_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "pre_ritual_7_1and2and4",
				text = "PRE_RITUAL_6_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "pre_ritual_7_3_1",
				text = "PRE_RITUAL_6_OPTION_3",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "sexuals_factor",
								operant = "gte",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "pre_ritual_7_1and2and4",
				text = "PRE_RITUAL_6_OPTION_3",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "sexuals_factor",
								operant = "lt",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "pre_ritual_7_1and2and4",
				text = "PRE_RITUAL_6_OPTION_4",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue"
			}
		]
	},
	pre_ritual_7_3_1 = {
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
				text = "PRE_RITUAL_7_3_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_blow_1",
				text = "PRE_RITUAL_7_3_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "pre_ritual_blow_1",
				text = "PRE_RITUAL_7_3_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	pre_ritual_blow_1 = {
		image = null,
		music = "intimate",
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		unlocked_gallery_seq = "pre_ritual_blow",
		save_scene_to_gallery = true,
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "PRE_RITUAL_BLOW_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_blow_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	pre_ritual_blow_2 = {
		custom_background = "mae_scene1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "PRE_RITUAL_BLOW_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_blow_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	pre_ritual_blow_3 = {
		custom_background = "mae_scene1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "PRE_RITUAL_BLOW_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_blow_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	pre_ritual_blow_4 = {
		custom_background = "mae_scene2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "PRE_RITUAL_BLOW_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_7_3_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1,
				bonus_effects = [
					{code = "dialogue_counter", name = "mae_perverted_actions", op = "+"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"},
					{code = 'decision', value = 'MaeBlow'}
				]
			}
		]
	},
	pre_ritual_7_3_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_slow"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "PRE_RITUAL_7_3_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "pre_ritual_8",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
}
