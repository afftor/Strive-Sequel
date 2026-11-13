extends Reference
var data = {
	anastasia_dialogue_start = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$anastasia",
		text = [
			{
				text = "DIALOGUEANAINITIATELP",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					},
					{
						type = "decision",
						value = "anastasia_rape_scene",
						check = false
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = false
							},
							{
								code = "has_profession",
								profession = "spouse",
								check = false
							}
						]
					}
				]
			},
			{
				text = "DIALOGUEANAINITIATEHP",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					},
					{
						type = "decision",
						value = "anastasia_rape_scene",
						check = false
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = true
							},
							{
								code = "has_profession",
								profession = "spouse",
								check = false
							}
						]
					}
				]
			},
			{
				text = "DIALOGUEANAINITIATELN",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					},
					{
						type = "decision",
						value = "anastasia_rape_scene",
						check = true
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = false
							}
						]
					}
				]
			},
			{
				text = "DIALOGUEANAINITIATEHN",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					},
					{
						type = "decision",
						value = "anastasia_rape_scene",
						check = true
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = true
							}
						]
					}
				]
			},
			{
				text = "DIALOGUEANAINITIATEM",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					},
					{
						type = "decision",
						value = "anastasia_rape_scene",
						check = false
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "has_profession",
								profession = "spouse",
								check = true
							}
						]
					}
				]
			},
			{
				text = "DIALOGUEANAINITIATEB",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "ana_gryphon_sex_start",
				text = "GRYPHON_ANA_SEX_OPTION_INIT",
				reqs = [
					{
						type = "decision",
						value = "AnaAireThreesome",
						check = true
					},
					{
						type = "dialogue_seen",
						check = false,
						value = "GRYPHON_ANA_SEX_10"
					}
				],
				dialogue_argument = 1
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				dialogue_argument = 4
			}
		]
	},
	daisy_serve_start = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		character = "$daisy",
		text = [
			{
				text = "DAISY_SERVE_START_1",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "has_profession",
								profession = "sextoy",
								check = true
							}
						]
					}
				]
			},
			{
				text = "DAISY_SERVE_START_2",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "has_profession",
								profession = "sextoy",
								check = false
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "daisy_serve_1_1",
				text = "DAISY_SERVE_OPTION_1_1",
				reqs = [
					{
						type = "quest_completed",
						name = "daisy_training",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			},
			{
				code = "daisy_serve_2_1",
				text = "DAISY_SERVE_OPTION_1_2",
				reqs = [
					{
						type = "quest_completed",
						name = "daisy_lost",
						check = true
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue",
				change_dialogue_type = 2
			},
			{
				code = "daisy_dialogue_start",
				text = "DAISY_SERVE_OPTION_1_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_1_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		additionally_open = [
			"daisy_bj_old_3"
		],
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_serve_1_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_1_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_serve_1_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_1_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_serve_1_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_1_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_serve_1_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_1_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bj6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		additionally_open = [
			"daisy_bj_old_4"
		],
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_5",
				reqs = [

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
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_2_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bent1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [
			{
				code = "unique_character_changes",
				value = "daisy",
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
				text = "DAISY_CONSENSUAL_3_SERVE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_serve_2_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_2_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bent2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "DAISY_CONSENSUAL_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_serve_2_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_serve_2_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "daisy_bent3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "DAISY_CONSENSUAL_5",
				reqs = [

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
				type = "next_dialogue"
			}
		]
	},
	cali_dialogue_start = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		character = "$cali",
		text = [
			{
				text = "DIALOGUECALIINITIATELP",
				reqs = [
					{
						type = "decision",
						value = "cali_raped",
						check = false
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = false
							},
							{
								code = "has_profession",
								profession = "spouse",
								check = false
							}
						]
					}
				]
			},
			{
				text = "DIALOGUECALIINITIATEHP",
				reqs = [
					{
						type = "decision",
						value = "cali_raped",
						check = false
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = true
							},
							{
								code = "has_profession",
								profession = "spouse",
								check = false
							}
						]
					}
				]
			},
			{
				text = "DIALOGUECALIINITIATELN",
				reqs = [
					{
						type = "decision",
						value = "cali_raped",
						check = true
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = true
							}
						]
					}
				]
			},
			{
				text = "DIALOGUECALIINITIATEHN",
				reqs = [
					{
						type = "decision",
						value = "cali_raped",
						check = true
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "trait",
								trait = "training_s_relation",
								check = true
							}
						]
					}
				]
			},
			{
				text = "DIALOGUECALIINITIATEM",
				reqs = [
					{
						type = "decision",
						value = "cali_raped",
						check = false
					},
					{
						type = "active_character_checks",
						value = [
							{
								code = "has_profession",
								profession = "spouse",
								check = true
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "cali_sword_return_1",
				text = "CALI_SWORD_RETURN_INIT",
				reqs = [
					{
						type = "active_quest_stage",
						value = "cali_heirloom_quest",
						stage = "stage9"
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "cali_act3_blow_1",
				text = "CALI_ACT3_BLOW_OPTION_INIT",
				reqs = [
					{
						type = "active_quest_stage",
						value = "cali_taming_quest",
						stage = "stage10"
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "cali_act5_pet_3",
				text = "CALI_ACT3_BLOW_OPTION_INIT",
				reqs = [
					{
						type = "active_quest_stage",
						value = "cali_taming_quest",
						stage = "stage16"
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "cali_serve_start",
				text = "DAISY_SERVE_OPTION_START",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				dialogue_argument = 3
			}
		]
	},
	cali_serve_start = {
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		character = "$cali",
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "cali_riding",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_SERVE_START_1",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "has_profession",
								profession = "sextoy",
								check = true
							}
						]
					}
				]
			},
			{
				text = "CALI_SERVE_START_2",
				reqs = [
					{
						type = "active_character_checks",
						value = [
							{
								code = "has_profession",
								profession = "sextoy",
								check = false
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "cali_serve_1_1",
				text = "CALI_SERVE_OPTION_1_1",
				reqs = [
					{
						type = "quest_completed",
						name = "cali_heirloom_quest",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			},
			{
				code = "cali_serve_2_1",
				text = "CALI_SERVE_OPTION_1_2",
				reqs = [
					{
						type = "quest_completed",
						name = "cali_heirloom_quest",
						check = true
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue",
				change_dialogue_type = 2
			},
			{
				code = "cali_dialogue_start",
				text = "CALI_SERVE_OPTION_1_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_1_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_bj_happy_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_SEX_8",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "cali_serve_1_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_1_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_bj_happy_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_SEX_9",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "cali_serve_1_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_1_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_bj_happy_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_SEX_10",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "cali_serve_1_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_1_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_bj_happy_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_SEX_11",
				reqs = [

				]
			},
			{
				text = "CALI_SEX_12",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "cali_serve_1_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_1_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_bj_happy_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_SEX_13",
				reqs = [

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
				type = "next_dialogue"
			}
		]
	},
	cali_serve_2_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_riding_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_GRAT_SEX_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "cali_serve_2_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_2_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_riding_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_GRAT_SEX_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "cali_serve_2_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	cali_serve_2_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"active_character_translate"
		],
		reqs = [

		],
		custom_background = "cali_riding_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "CALI_GRAT_SEX_3",
				reqs = [

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
				type = "next_dialogue"
			}
		]
	},
}
