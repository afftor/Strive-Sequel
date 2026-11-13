extends Reference
var data = {
	mae_ancient_jungle_ritual_choice = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$mae",
		text = "MAE_ANCIENT_JUNGLE_RITUAL_CHOICE",
		options = [
			{
				code = "mae_ancient_jungle_ritual_lewd",
				text = "MAE_ANCIENT_JUNGLE_RITUAL_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_ancient_jungle_ritual_finish",
				text = "MAE_ANCIENT_JUNGLE_RITUAL_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_lewd = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$mae",
		text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD",
		options = [
			{
				code = "mae_ancient_jungle_ritual_lewd_response",
				text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_ancient_jungle_ritual_lewd_response",
				text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_lewd_response = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$mae",
		text = [
			{
				text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_RESPONSE_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_RESPONSE_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "mae_ancient_jungle_ritual_scene",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_scene = {
		image = null,
		music = 'intimate_dark',
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_ANCIENT_JUNGLE_RITUAL_SCENE",
		options = [
			{
				code = "mae_ancient_jungle_ritual_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "mae_sex_actions",
						op = "+"
					},
					{
						code = "decision",
						value = "MaeRitualSex"
					}
				]
			}
		]
	},
	mae_ancient_jungle_ritual_1 = {
		unlocked_gallery_seq = "mae_sex_ritual",
		custom_background = "mae_ritual_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_1",
		options = [
			{
				code = "mae_ancient_jungle_ritual_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_2 = {
		custom_background = "mae_ritual_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_2",
		options = [
			{
				code = "mae_ancient_jungle_ritual_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_3 = {
		custom_background = "mae_ritual_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_3",
		options = [
			{
				code = "mae_ancient_jungle_ritual_4",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "mae_spirit_velhorn",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_ancient_jungle_ritual_finish",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "mae_spirit_velhorn",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	mae_ancient_jungle_ritual_4 = {
		custom_background = "mae_ritual_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_4",
		options = [
			{
				code = "mae_ancient_jungle_ritual_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_5 = {
		custom_background = "mae_ritual_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_5",
		options = [
			{
				code = "mae_ancient_jungle_ritual_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_6 = {
		custom_background = "mae_ritual_6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_6",
		options = [
			{
				code = "mae_ancient_jungle_ritual_7",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_ancient_jungle_ritual_7 = {
		custom_background = "mae_ritual_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "MAE_SEX_RITUAL_7",
		options = [
			{
				code = "mae_ancient_jungle_ritual_finish",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	mae_spirit_northern_offer_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$mae",
		text = "MAE_NORTHERN_TRIBE_OFFER_2",
		options = [
			{
				code = "mae_spirit_northern_ritual_consent",
				text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_northern_decline",
				text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_northern_missed",
				text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_3",
				reqs = [
					{
						type = "decision",
						value = "mae_druid_training_done",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "rakar"
	},
	mae_spirit_northern_ritual_consent = {
		variations = [
			{
				reqs = [
					{
						type = "local_counter",
						name = "mae_sex_actions",
						add_stat = "sexuals_factor",
						operant = "gte",
						value = 7,
						check = true
					}
				],
				image = null,
				tags = [
					"dialogue_scene"
				],
				character = "$mae",
				text = "MAE_NORTHERN_RITUAL_ACCEPT",
				options = [
					{
						code = "mae_spirit_northern_ritual_scene_1",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue",
						change_dialogue_type = 2
					}
				],
				character2 = "rakar"
			},
			{
				reqs = [

				],
				image = null,
				tags = [
					"dialogue_scene"
				],
				character = "$mae",
				text = "MAE_NORTHERN_RITUAL_REFUSE",
				options = [
					{
						code = "mae_spirit_northern_decline",
						text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_2",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					},
					{
						code = "mae_spirit_northern_missed",
						text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_3",
						reqs = [
							{
								type = "decision",
								value = "mae_druid_training_done",
								check = true
							}
						],
						dialogue_argument = 1,
						type = "next_dialogue"
					}
				]
			}
		]
	},
	mae_spirit_northern_ritual_scene_1 = {
		unlocked_gallery_seq = "mae_spirit_northern_ritual",
		custom_background = "mae_northern_1",
		music = 'intimate_dark',
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "MAE_SEX_TRIBE_1",
		options = [
			{
				code = "mae_spirit_northern_ritual_scene_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_spirit_northern_ritual_scene_2 = {
		custom_background = "mae_northern_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_TRIBE_2",
		options = [
			{
				code = "mae_spirit_northern_ritual_scene_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_spirit_northern_ritual_scene_3 = {
		custom_background = "mae_northern_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_TRIBE_3",
		options = [
			{
				code = "mae_spirit_northern_ritual_scene_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_spirit_northern_ritual_scene_4 = {
		custom_background = "mae_northern_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_TRIBE_4",
		options = [
			{
				code = "mae_spirit_northern_ritual_scene_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_spirit_northern_ritual_scene_5 = {
		custom_background = "mae_northern_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "MAE_SEX_TRIBE_5",
		options = [
			{
				code = "mae_spirit_northern_ritual_after",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1,
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "mae",
						args = [
							{code = "sexuals_factor", operant = "+", value = 1}
						]
					},
					{
						code = "decision",
						value = "MaeOrgy"
					}
				]
			}
		]
	},
	mae_spirit_northern_ritual_after = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		character = "$mae",
		reqs = [

		],
		text = "MAE_NORTHERN_RITUAL_AFTER",
		options = [
			{
				code = "mae_spirit_northern_ritual_gift",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "rakar"
	},
}
