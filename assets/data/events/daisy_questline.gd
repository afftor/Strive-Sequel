extends Reference
var data = {
	help_init_test = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_default",
		text = [
			{
				text = "DAISY_RECRUITMENT_START",
				reqs = [

				]
			}
		],
		music = "daisy_theme",
		options = [
			{
				code = "close",
				text = "+",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "-",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_recruitment_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_default",
		text = [
			{
				text = "DAISY_RECRUITMENT_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_recruitment_2",
				text = "DAISY_RECRUITMENT_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_recruitment_2",
				text = "DAISY_RECRUITMENT_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "daisy_recruitment_2",
				text = "DAISY_RECRUITMENT_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = -15},
				]
			}
		]
	},
	daisy_recruitment_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_default",
		text = [
			{
				text = "DAISY_RECRUITMENT_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_RECRUITMENT_REPLY_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DAISY_RECRUITMENT_REPLY_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_clothes_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									2
								],
								hour = 2
							}
						]
					}
				]
			}
		]
	},
	daisy_clothes_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		music = "daisy_theme",
		reqs = [
			{
				type = "unique_character_checks",
				name = "daisy",
				value = [
					{
						code = "is_free",
						check = true
					}
				],
				negative = "repeat_next_day"
			}
		],
		character = "daisy_default",
		text = [
			{
				text = "DAISY_CLOTHES_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_clothes_2",
				text = "DAISY_CLOTHES_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_clothes_2",
				text = "DAISY_CLOTHES_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_clothes_2",
				text = "DAISY_CLOTHES_OPTION_1_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_clothes_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_default",
		text = [
			{
				text = "DAISY_CLOTHES_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_CLOTHES_REPLY_2_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "daisy_clothes_3",
				text = "DAISY_CLOTHES_OPTION_2_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_clothes_5",
				text = "DAISY_CLOTHES_OPTION_2_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "daisy_clothes_2",
				text = "DAISY_CLOTHES_OPTION_2_3",
				reqs = [

				],
				dialogue_argument = 3,
				remove_after_first_use = true
			}
		]
	},
	daisy_clothes_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_default",
		text = [
			{
				text = "DAISY_CLOTHES_REPLY_2_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_clothes_4",
				text = "DAISY_CLOTHES_OPTION_2_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "daisy_clothes",
						stage = "stage1"
					},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 15},
				]
			},
			{
				code = "daisy_clothes_4",
				text = "DAISY_CLOTHES_OPTION_2_1_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = -20},
				]
			}
		]
	},
	daisy_clothes_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "DAISY_CLOTHES_REPLY_2_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_CLOTHES_REPLY_2_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	daisy_clothes_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_default_happy",
		text = [
			{
				text = "DAISY_CLOTHES_REPLY_2_2",
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
				bonus_effects = [
					{
						code = "progress_quest",
						value = "daisy_clothes",
						stage = "stage1"
					}
				]
			}
		]
	},
	daisy_clothes_sigmund_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "sigmund",
		text = [
			{
				text = "DAISY_CLOTHES_SIGMUND_REPLY_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DAISY_CLOTHES_SIGMUND_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "daisy_clothes",
						stage = "stage2"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	daisy_clothes_amelia_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "DAISY_CLOTHES_AMELIA_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "daisy_clothes_amelia_2_1",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "daisy_clothes_amelia_2_2",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_2",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "close",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_3",
				reqs = [

				],
				dialogue_argument = 3
			}
		]
	},
	daisy_clothes_amelia_2_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "DAISY_CLOTHES_AMELIA_REPLY_2_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_clothes_amelia_3_1",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_1_1",
				reqs = [
					{
						type = "has_money",
						value = 150
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_clothes_amelia_1",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE",
				reqs = [

				],
				dialogue_argument = 3
			}
		]
	},
	daisy_clothes_amelia_2_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "DAISY_CLOTHES_AMELIA_REPLY_2_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_clothes_amelia_3_2",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_2_1",
				reqs = [
					{
						type = "has_money",
						value = 250
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "daisy_clothes_amelia_1",
				text = "DAISY_CLOTHES_AMELIA_OPTION_2_REFUSE",
				reqs = [

				],
				dialogue_argument = 3
			}
		]
	},
	daisy_clothes_amelia_3_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		image = null,
		character = "$amelia",
		text = [
			{
				text = "DAISY_CLOTHES_AMELIA_REPLY_3_150",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "money_change",
				operant = "-",
				value = 150
			},
			{
				code = "decision",
				value = "DaisyDressNormal"
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_dress_acquired_normal_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									2
								],
								hour = 2
							}
						]
					},
					{
						code = "progress_quest",
						value = "daisy_clothes",
						stage = "stage3"
					}
				]
			}
		]
	},
	daisy_clothes_amelia_3_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		image = null,
		character = "$amelia",
		text = [
			{
				text = "DAISY_CLOTHES_AMELIA_REPLY_3_250",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "money_change",
				operant = "-",
				value = 250
			},
			{
				code = "decision",
				value = "DaisyDressLewd"
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_dress_acquired_lewd_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									2
								],
								hour = 2
							}
						]
					},
					{
						code = "progress_quest",
						value = "daisy_clothes",
						stage = "stage3"
					}
				]
			}
		]
	},
	daisy_dress_acquired_normal_1 = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		music = "daisy_theme",
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "daisy_dress_acquired_normal",
		unlocked_char_sprites = {daisy = ["maid"]},
		save_scene_to_gallery = true,
		reqs = [

		],
		character = "daisy_maid",
		text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_0",
		common_effects = [
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "unique_variation",
						operant = "=",
						value = "maid"
					},
					{
						code = "body_image",
						operant = "=",
						value = "daisy_maid_body"
					},
					{
						code = "icon_image",
						operant = "=",
						value = "res://assets/images/portraits/daisy_maid_prt.png"
					}
				]
			},
			{
				code = "update_prts"
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "create_and_equip",
						item = "daisy_dress",
						parts = {

						}
					}
				]
			},
			{
				code = "complete_quest",
				value = "daisy_clothes"
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "growth_factor",
						value = 1,
						operant = "+"
					}
				]
			},
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "remove_trait",
				trait = "coward"
			},
			{
				code = "add_timed_event",
				value = "daisy_training_message",
				args = [
					{
						type = "add_to_date",
						date = [
							3,
							4
						],
						hour = 2
					}
				]
			}
		],
		options = [
			{
				code = "daisy_dress_acquired_normal_2",
				text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_dress_acquired_normal_2",
				text = "DAISY_DRESS_ACQUIRED_NORMAL_OPTION_1_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	daisy_dress_acquired_normal_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [

				]
			}
		]
	},
	daisy_dress_acquired_lewd_1 = {
		image = null,
		music = 'daisy_theme',
		unlocked_char_sprites = {daisy = ["maid_lewd"]},
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_0",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "unique_variation",
						operant = "=",
						value = "maid"
					},
					{
						code = "body_image",
						operant = "=",
						value = "daisy_maid_body"
					},
					{
						code = "icon_image",
						operant = "=",
						value = "res://assets/images/portraits/daisy_maid_prt.png"
					}
				]
			},
			{
				code = "update_prts"
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "create_and_equip",
						item = "daisy_dress_lewd",
						parts = {

						}
					}
				]
			},
			{
				code = "complete_quest",
				value = "daisy_clothes"
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "growth_factor",
						value = 1,
						operant = "+"
					}
				]
			},
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "remove_trait",
				trait = "coward"
			},
			{
				code = "add_timed_event",
				value = "daisy_training_message",
				args = [
					{
						type = "add_to_date",
						date = [
							3,
							4
						],
						hour = 2
					}
				]
			}
		],
		options = [
			{
				code = "daisy_dress_acquired_lewd_2",
				text = "DAISY_DRESS_ACQUIRED_LEWD_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 10},
				]
			},
		]
	},
	daisy_dress_acquired_lewd_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_DRESS_ACQUIRED_LEWD_REPLY_1_1",
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
				bonus_effects = [

				]
			}
		]
	},
	daisy_training_message = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_TRAINING_REPLY_0",
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
				bonus_effects = [
					{
						code = "progress_quest",
						value = "daisy_training",
						stage = "stage1"
					}
				]
			}
		]
	},
	daisy_training_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "DAISY_TRAINING_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_TRAINING_REPLY_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DAISY_TRAINING_REPLY_2_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "daisy_training_2",
				text = "DAISY_TRAINING_OPTION_2_1",
				reqs = [
					{
						type = "has_money",
						value = 200
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "training_complete_serve_1",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 2
							}
						]
					},
					{
						code = "money_change",
						operant = "-",
						value = 200
					},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "respect", value = 15},
				]
			},
			{
				code = "daisy_training_2",
				text = "DAISY_TRAINING_OPTION_2_4",
				reqs = [
					{
						type = "has_money",
						value = 300
					},
					{
						type = "dialogue_selected",
						check = true,
						value = "DAISY_TRAINING_OPTION_2_2"
					}
				],
				dialogue_argument = 4,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "training_complete_sex_1",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 2
							}
						]
					},
					{
						code = "money_change",
						operant = "-",
						value = 300
					},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = -10},
				]
			},
			{
				code = "daisy_training_2",
				text = "DAISY_TRAINING_OPTION_2_5",
				reqs = [
					{
						type = "has_money",
						value = 400
					},
					{
						type = "dialogue_selected",
						check = true,
						value = "DAISY_TRAINING_OPTION_2_3"
					}
				],
				dialogue_argument = 5,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_training_intermission_1",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									3
								],
								hour = 2
							}
						]
					},
					{
						code = "add_timed_event",
						value = "training_complete_fucktoy_1",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 2
							}
						]
					},
					{
						code = "money_change",
						operant = "-",
						value = 400
					},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = -30},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "respect", value = -25},
				]
			},
			{
				code = "daisy_training_1",
				text = "DAISY_TRAINING_OPTION_2_2",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "daisy_training_1",
				text = "DAISY_TRAINING_OPTION_2_3",
				reqs = [
					{
						type = "dialogue_selected",
						check = true,
						value = "DAISY_TRAINING_OPTION_2_2"
					}
				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "close",
				text = "DAISY_TRAINING_OPTION_2_6",
				reqs = [

				],
				dialogue_argument = 6
			}
		]
	},
	daisy_training_2 = {
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
				text = "DAISY_TRAINING_REPLY_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_TRAINING_REPLY_2_4",
				reqs = [

				],
				previous_dialogue_option = 4
			},
			{
				text = "DAISY_TRAINING_REPLY_2_5",
				reqs = [

				],
				previous_dialogue_option = 5
			}
		],
		common_effects = [
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "set_availability",
				value = false
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "progress_quest",
						value = "daisy_training",
						stage = "stage2"
					}
				]
			}
		]
	},
	training_complete_serve_1 = {
		music = "intimate",
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "TRAINING_COMPLETE_SERVE_REPLY_0",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "set_availability",
				value = true
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "charm_factor",
						operant = "+",
						value = 1
					},
					{
						code = "tame_factor",
						operant = "+",
						value = 1
					},
					{
						code = "charm",
						operant = "+",
						value = 15
					}
				]
			}
		],
		options = [
			{
				code = "training_complete_serve_2",
				text = "TRAINING_COMPLETE_SERVE_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "training_complete_serve_2",
				text = "TRAINING_COMPLETE_SERVE_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	training_complete_serve_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "TRAINING_COMPLETE_SERVE_REPLY_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "TRAINING_COMPLETE_SERVE_REPLY_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		common_effects = [
			{
				code = "add_timed_event",
				value = "daisy_admirer_message",
				args = [
					{
						type = "add_to_date",
						date = [
							2,
							3
						],
						hour = 2
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
				bonus_effects = [
					{
						code = "decision",
						value = "DaisyTrainingFinished"
					},
					{
						code = "complete_quest",
						value = "daisy_training"
					}
				]
			}
		]
	},
	training_complete_sex_1 = {
		image = null,
		music = "daisy_theme",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "TRAINING_COMPLETE_SEX_REPLY_0",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "set_availability",
				value = true
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "charm_factor",
						operant = "+",
						value = 1
					},
					{
						code = "sex_stamina",
						operant = "+",
						value = 1
					},
					{
						code = "sex_training_oral",
						operant = "=",
						value = "skilled",
						reqs = [
							{code = "stat", stat = "sex_training_oral", operant = "neq", value = "mastered"}
						]
					},
					{
						code = "sex_training_petting",
						operant = "=",
						value = "skilled",
						reqs = [
							{code = "stat", stat = "sex_training_petting", operant = "neq", value = "mastered"}
						]
					}
				]
			}
		],
		options = [
			{
				code = "training_complete_sex_4",
				text = "TRAINING_COMPLETE_SEX_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	training_complete_sex_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "TRAINING_COMPLETE_SEX_REPLY_1_2_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "training_complete_sex_5",
				text = "TRAINING_COMPLETE_SEX_OPTION_1_2_2",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	training_complete_sex_5 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = "TRAINING_COMPLETE_SEX_REPLY_1_2_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_admirer_message",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									3
								],
								hour = 2
							}
						]
					},
					{
						code = "complete_quest",
						value = "daisy_training"
					},
					{
						code = "decision",
						value = "DaisyTrainingFinished"
					}
				]
			}
		]
	},
	training_complete_fucktoy_1 = {
		image = null,
		music = "daisy_theme",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "daisy_public",
		save_scene_to_gallery = true,
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "TRAINING_COMPLETE_FUCKTOY_REPLY_0",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "add_timed_event",
				value = "daisy_admirer_message",
				args = [
					{
						type = "add_to_date",
						date = [
							2,
							3
						],
						hour = 2
					}
				]
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "add_profession",
						profession = "sextoy"
					}
				]
			},
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "set_availability",
				value = true
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "sex_stamina",
						operant = "+",
						value = 3
					},
					{
						code = "sex_training_oral",
						operant = "=",
						value = "skilled",
						reqs = [
							{code = "stat", stat = "sex_training_oral", operant = "neq", value = "mastered"}
						]
					},
					{
						code = "sex_training_pussy",
						operant = "=",
						value = "skilled",
						reqs = [
							{code = "stat", stat = "sex_training_pussy", operant = "neq", value = "mastered"}
						]
					},
					{
						code = "sex_training_anal",
						operant = "=",
						value = "skilled",
						reqs = [
							{code = "stat", stat = "sex_training_anal", operant = "neq", value = "mastered"}
						]
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "TRAINING_COMPLETE_FUCKTOY_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 2,
				bonus_effects = [
					{
						code = "complete_quest",
						value = "daisy_training"
					},
					{
						code = "decision",
						value = "DaisyTrainingFinished"
					}
				]
			}
		]
	},
	daisy_admirer_message = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "daisy_admirer",
		save_scene_to_gallery = true,
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_ADMIRER_MESSAGE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_admirer_message_1_1",
				text = "DAISY_ADMIRER_MESSAGE_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_admirer_message_1_2",
				text = "DAISY_ADMIRER_MESSAGE_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "daisy_admirer_message_1_3",
				text = "DAISY_ADMIRER_MESSAGE_OPTION_1_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	daisy_admirer_message_1_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "DAISY_ADMIRER_MESSAGE_REPLY_1_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_admirer_message_1_1_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_admirer_message_1_1_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_ADMIRER_MESSAGE_REPLY_1_1_1",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "money_change",
				operant = "+",
				value = 5000
			},
			{
				code = "unique_character_changes",
				value = "daisy",
				args = [
					{
						code = "remove_character"
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
				dialogue_argument = 1
			}
		]
	},
	daisy_admirer_message_1_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "DAISY_ADMIRER_MESSAGE_REPLY_1_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_admirer_message_1_2_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_admirer_message_1_2_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_ADMIRER_MESSAGE_REPLY_1_2_1",
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
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "daisy",
						args = [
							{
								code = "remove_character"
							}
						]
					}
				]
			}
		]
	},
	daisy_admirer_message_1_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "DAISY_ADMIRER_MESSAGE_REPLY_1_3",
				reqs = [

				]
			}
		],
		options = [
			{
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_admirer_first_event_1",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									4
								],
								hour = 2
							}
						]
					},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 25},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "respect", value = 20},
				],
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	daisy_admirer_first_event_1 = {
		variations = [
			{
				reqs = [
					{
						type = "unique_character_checks",
						name = "daisy",
						value = [
							{code = "stat", stat = "affection", operant = "gte", value = 50}
						]
					}
				],
				music = "daisy_theme",
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				image = null,
				character = "daisy_maid",
				text = [
					{
						text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_0",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "daisy_admirer_first_event_2",
						text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					},
					{
						code = "daisy_admirer_first_event_2",
						text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_2",
						reqs = [

						],
						dialogue_argument = 2,
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [
					{
						type = "unique_character_checks",
						name = "daisy",
						value = [
							{code = "stat", stat = "affection", operant = "lt", value = 50}
						]
					}
				],
				music = "daisy_theme",
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				image = "daisyevent",
				text = [
					{
						text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_2",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "daisy_admirer_first_event_4",
						text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_2_1",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue",
						bonus_effects = [
							{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 20},
						]
					},
				]
			}
		]
	},
	daisy_admirer_first_event_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_admirer_first_event_3",
				text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 10},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "respect", value = 10},
				]
			},
			{
				code = "daisy_admirer_first_event_3",
				text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 20},
				]
			},
			{
				code = "daisy_admirer_first_event_3",
				text = "DAISY_ADMIRER_FIRST_EVENT_OPTION_1_1AND2_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = -20},
				]
			}
		]
	},
	daisy_admirer_first_event_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_1_1AND2_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_lost_message",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									3
								],
								hour = 3
							}
						]
					}
				],
				type = "next_dialogue"
			}
		]
	},
	daisy_admirer_first_event_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_ADMIRER_FIRST_EVENT_REPLY_2_1",
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
				bonus_effects = [
					{
						code = "add_timed_event",
						value = "daisy_lost_message",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									3
								],
								hour = 3
							}
						]
					}
				],
				type = "next_dialogue"
			}
		]
	},
	daisy_lost_message = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "DAISY_LOST_MESSAGE",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "affect_unique_character",
				name = "daisy",
				type = "set_availability",
				value = false
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
						code = "progress_quest",
						value = "daisy_lost",
						stage = "stage1"
					}
				]
			}
		]
	},
	daisy_lost_amelia_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "DAISY_LOST_AMELIA_REPLY_0",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_lost_amelia_2",
				text = "DAISY_LOST_AMELIA_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_lost_amelia_2",
				text = "DAISY_LOST_AMELIA_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	daisy_lost_amelia_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$amelia",
		text = [
			{
				text = "DAISY_LOST_AMELIA_REPLY_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DAISY_LOST_AMELIA_REPLY_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
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
						code = "make_quest_location",
						value = "quest_daisy_admirer_location"
					},
					{
						code = "progress_quest",
						value = "daisy_lost",
						stage = "stage2"
					}
				]
			}
		]
	},
	daisy_lost_3 = {
		image = 'daisy_hostage',
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_0_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "daisy_admirer_guards1",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_lost_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "ramont",
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_0_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_lost_5",
				text = "DAISY_LOST_APPROACH_OPTION_1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "daisy_lost_5",
				text = "DAISY_LOST_APPROACH_OPTION_1_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "daisy_lost_5",
				text = "DAISY_LOST_APPROACH_OPTION_1_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	daisy_lost_5 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "ramont",
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_lost_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_lost_6 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "ramont",
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_lost_13",
				text = "DAISY_LOST_APPROACH_OPTION_3_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = 20},
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "respect", value = 20},
				]
			},
			{
				code = "daisy_lost_14",
				text = "DAISY_LOST_APPROACH_OPTION_3_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "daisy", type = "stat", stat = "affection", value = -40},
				]
			}
		]
	},
	daisy_lost_13 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		character2 = "ramont",
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_3_2",
				reqs = [

				]
			},
			{
				text = "DAISY_LOST_APPROACH_REPLY_3_2_good",
				reqs = [
					{
						type = "unique_character_checks",
						name = "daisy",
						value = [
							{code = "stat", stat = "affection", operant = "gte", value = 50}
						]
					}
				]
			},
			{
				text = "DAISY_LOST_APPROACH_REPLY_3_2_bad",
				reqs = [
					{
						type = "unique_character_checks",
						name = "daisy",
						value = [
							{code = "stat", stat = "affection", operant = "lt", value = 50}
						]
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "unique_character_checks",
						name = "daisy",
						value = [
							{code = "stat", stat = "affection", operant = "lt", value = 50}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "daisy_lost"
					},
					{
						code = "remove_quest_location",
						value = "quest_daisy_admirer_location"
					},
					{
						code = "unique_character_changes",
						value = "daisy",
						args = [
							{
								code = "remove_character"
							}
						]
					},
					{
						code = "set_faction_factor",
						faction = "obsidian",
						value = 0.15
					},
				]
			}
		]
	},
	daisy_lost_14 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "ramont",
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_3_3_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "daisy_lost_15",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	daisy_lost_15 = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"master_translate"
		],
		reqs = [

		],
		character = "daisy_maid",
		text = [
			{
				text = "DAISY_LOST_APPROACH_REPLY_3_3_2",
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
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "daisy_lost"
					},
					{
						code = "remove_quest_location",
						value = "quest_daisy_admirer_location"
					},
					{
						code = "unique_character_changes",
						value = "daisy",
						args = [
							{
								code = "remove_character"
							}
						]
					},
					{
						code = "set_faction_factor",
						faction = "obsidian",
						value = 0.15
					},
				]
			}
		]
	},
}
