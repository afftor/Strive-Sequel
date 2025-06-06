extends Reference
var data = {
	ana_letter_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_LETTER_1_1",
				reqs = [],
				previous_dialogue_option = 0,
				bonus_effects = []
			},
			{
				text = "ANA_LETTER_1_2",
				reqs = [],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "ana_letter_2",
				text = "ANA_LETTER_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ana_letter_end",
				text = "ANA_LETTER_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ana_letter_1",
				text = "ANA_LETTER_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 2,
				previous_dialogue_option = 0
			},
			{
				code = "ana_letter_2",
				text = "ANA_LETTER_1_OPTION_4",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				previous_dialogue_option = 2
			}
		]
	},
	ana_letter_end = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_LETTER_END",
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
			}
		]
	},
	ana_letter_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_LETTER_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ANA_LETTER_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "ana_letter_3",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	ana_letter_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "ANA_LETTER_3",
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
						code = "progress_quest",
						value = "anastasia_quest",
						stage = "stage2"
					}
				]
			}
		]
	},
	liora_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LIORA_1_1",
				reqs = [

				]
			},
			{
				text = "LIORA_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "liora_1",
				text = "LIORA_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "liora_2",
				text = "LIORA_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "liora_3",
				text = "LIORA_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "ana_widow"
	},
	liora_2 = {
		image = "ana_widow",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LIORA_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LIORA_2_2",
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
						code = "progress_quest",
						value = "anastasia_quest",
						stage = "stage3"
					},
					{
						code = "make_quest_location",
						value = "quest_ashen_ridge"
					}
				]
			}
		]
	},
	liora_3 = {
		image = "ana_widow",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "LIORA_3",
		options = [
			{
				code = "liora_4",
				text = "LIORA_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "liora_4",
				text = "LIORA_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "liora_2",
				text = "LIORA_3_OPTION_3",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	liora_4 = {
		image = "ana_widow",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "LIORA_4",
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
						value = "anastasia_quest",
						stage = "stage6"
					},
					{
						code = "decision",
						value = "ana_liora_lie"
					}
				]
			}
		]
	},
	ashen_ridge_1 = {
		image = "ana_battlefield",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "ASHEN_RIDGE_1",
		options = [
			{
				code = "ashen_ridge_2",
				text = "ASHEN_RIDGE_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ashen_ridge_2",
				text = "ASHEN_RIDGE_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ashen_ridge_end",
				text = "ASHEN_RIDGE_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ashen_ridge_end = {
		image = "ana_battlefield",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "ASHEN_RIDGE_END",
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
						value = "anastasia_quest",
						stage = "stage5"
					},
					{
						code = "decision",
						value = "ana_soldier_left"
					},
					{
						code = "remove_quest_location",
						value = "quest_ashen_ridge"
					}
				]
			}
		]
	},
	ashen_ridge_2 = {
		image = "ana_battlefield",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "ASHEN_RIDGE_2",
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
						value = "anastasia_quest",
						stage = "stage4"
					}
				]
			}
		]
	},
	ashen_ridge_3 = {
		image = "ana_wounded_soldier",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "ASHEN_RIDGE_3",
		options = [
			{
				code = "ashen_ridge_4",
				text = "ASHEN_RIDGE_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ashen_ridge_4",
				text = "ASHEN_RIDGE_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "ashen_ridge_4",
				text = "ASHEN_RIDGE_3_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	ashen_ridge_4 = {
		image = "ana_wounded_soldier",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "ASHEN_RIDGE_4_1",
				reqs = [

				],
				previous_dialogue_option = 1,
				bonus_effects = [
					{
						code = "decision",
						value = "ana_soldier_saved"
					}
				]
			},
			{
				text = "ASHEN_RIDGE_4_2",
				reqs = [

				],
				previous_dialogue_option = 2,
				bonus_effects = [
					{
						code = "decision",
						value = "ana_soldier_left"
					}
				]
			},
			{
				text = "ASHEN_RIDGE_4_3",
				reqs = [

				],
				previous_dialogue_option = 3,
				bonus_effects = [
					{
						code = "decision",
						value = "ana_soldier_killed"
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
						code = "progress_quest",
						value = "anastasia_quest",
						stage = "stage5"
					},
					{
						code = "remove_quest_location",
						value = "quest_ashen_ridge"
					}
				]
			}
		]
	},
	liora_return = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_soldier_saved"
					}
				],
				image = "ana_widow",
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "LIORA_RETURN_1",
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
								code = "progress_quest",
								value = "anastasia_quest",
								stage = "stage6"
							},
							{
								code = "decision",
								value = "ana_liora_good"
							}
						]
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_soldier_left"
					}
				],
				image = null,
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "LIORA_RETURN_2",
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
								code = "progress_quest",
								value = "anastasia_quest",
								stage = "stage6"
							},
							{
								code = "decision",
								value = "ana_liora_bad"
							}
						]
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_soldier_killed"
					}
				],
				image = null,
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "LIORA_RETURN_3",
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
								code = "progress_quest",
								value = "anastasia_quest",
								stage = "stage6"
							},
							{
								code = "decision",
								value = "ana_liora_bad"
							}
						]
					}
				]
			}
		]
	},
	anastasia_return_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "anastasia_return_2",
				text = "ANASTASIA_RETURN_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "anastasia_return_2",
				text = "ANASTASIA_RETURN_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "anastasia_return_2",
				text = "ANASTASIA_RETURN_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	anastasia_return_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_2_1",
				reqs = [

				],
				previous_dialogue_option = 1,
				bonus_effects = [
					{
						code = "decision",
						value = "ana_pt1_good"
					}
				]
			},
			{
				text = "ANASTASIA_RETURN_2_2",
				reqs = [

				],
				previous_dialogue_option = 2,
				bonus_effects = [
					{
						code = "decision",
						value = "ana_pt1_good"
					}
				]
			},
			{
				text = "ANASTASIA_RETURN_2_3",
				reqs = [

				],
				previous_dialogue_option = 3,
				bonus_effects = [
					{
						code = "decision",
						value = "ana_pt1_good"
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
						code = "comlete_quest",
						value = "anastasia_quest",
					},
					{
						code = "add_timed_event",
						value = "anastasia_pt2_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									2
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	anastasia_return_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_3_1",
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_liora_good"
					}
				]
			},
			{
				text = "ANASTASIA_RETURN_3_2",
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_liora_bad"
					}
				]
			}
		],
		options = [
			{
				code = "anastasia_return_4",
				text = "ANASTASIA_RETURN_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "anastasia_return_5",
				text = "ANASTASIA_RETURN_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	anastasia_return_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_blow_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				 change_dialogue_type = 2,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "ana_pt1_good"
					},
					{
						code = "complete_quest",
						value = "anastasia_quest",
					},
					{
						code = "add_timed_event",
						value = "anastasia_pt2_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									2
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	anastasia_return_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "ana_pt1_bad"
					},
					{
						code = "complete_quest",
						value = "anastasia_quest"
					}
				]
			}
		]
	},
	anastasia_pt2_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_PT2_1_1",
				reqs = [

				]
			},
			{
				text = "ANASTASIA_PT2_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "ANASTASIA_PT2_1_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "anastasia_pt2_1",
				text = "ANASTASIA_PT2_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "anastasia_pt2_1",
				text = "ANASTASIA_PT2_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "anastasia_pt2_2",
				text = "ANASTASIA_PT2_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	anastasia_pt2_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANASTASIA_PT2_2",
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
						code = "progress_quest",
						value = "anastasia_quest_2",
						stage = "stage8"
					}
				]
			}
		]
	},
	ana_duncan_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "duncan",
		text = [
			{
				text = "ANA_DUNCAN_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_duncan_2",
				text = "ANA_DUNCAN_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ana_duncan_2",
				text = "ANA_DUNCAN_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				previous_dialogue_option = 1
			}
		]
	},
	ana_duncan_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "duncan",
		text = [
			{
				text = "ANA_DUNCAN_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ANA_DUNCAN_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "ana_duncan_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_duncan_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "duncan",
		text = [
			{
				text = "ANA_DUNCAN_3_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ANA_DUNCAN_3_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "ANA_DUNCAN_3_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "ANA_DUNCAN_3_4",
				reqs = [

				],
				previous_dialogue_option = 4
			},
			{
				text = "ANA_DUNCAN_3_5",
				reqs = [

				],
				previous_dialogue_option = 5
			}
		],
		options = [
			{
				code = "ana_duncan_3",
				text = "ANA_DUNCAN_3_OPTION_1",
				reqs = [
					{
						type = "spouse_check",
						on_null = true,
						value = {
							code = "stat",
							stat = "unique",
							operant = "neq",
							value = "anastasia"
						}
					}
				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "ana_duncan_3",
				text = "ANA_DUNCAN_3_OPTION_2",
				reqs = [
					{
						type = "spouse_check",
						value = {
							code = "stat",
							stat = "unique",
							operant = "eq",
							value = "anastasia"
						}
					}
				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "ana_duncan_4",
				text = "ANA_DUNCAN_3_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "ana_duncan_5",
				text = "ANA_DUNCAN_3_OPTION_4",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_duncan_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "duncan",
		text = [
			{
				text = "ANA_DUNCAN_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_duncan_3",
				text = "ANA_DUNCAN_4_OPTION_1",
				reqs = [

				],
				dialogue_argument = 4
			},
			{
				code = "ana_duncan_3",
				text = "ANA_DUNCAN_4_OPTION_2",
				reqs = [

				],
				dialogue_argument = 5
			}
		]
	},
	ana_duncan_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "duncan",
		text = [
			{
				text = "ANA_DUNCAN_5",
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
						code = "progress_quest",
						value = "anastasia_quest_2",
						stage = "stage9"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	ana_travel_initiate = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_TRAVEL_INITIATE",
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
						code = "progress_quest",
						value = "anastasia_quest_2",
						stage = "stage10"
					},
					{
						code = "make_quest_location",
						value = "quest_dungeon_ana_fort"
					}
				]
			}
		]
	},
	ana_fort_1 = {
		image = "ana_mercenary",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "ANA_FORT_1",
		options = [
			{
				code = "ana_fort_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "ANA_FORT_2",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "anastasia_quest_2",
						stage = "stage11"
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "ANA_FORT_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "ANA_FORT_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "ana_mercenary"
	},
	ana_fort_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_fort_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_fort_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_fort_6",
				text = "ANA_FORT_5_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ana_fort_7",
				text = "ANA_FORT_5_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_6 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_6",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "ana_fort_8",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	ana_fort_7 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_7",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "jordan_boss_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_8 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_8",
				reqs = [

				],
				previous_dialogue_option = 1,
				bonus_effects = [
					{
						code = "progress_quest",
						value = "anastasia_quest_2",
						stage = "stage12"
					}
				]
			}
		],
		options = [
			{
				code = "ana_fort_9",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_9 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "ANA_FORT_9",
		options = [
			{
				code = "ana_fort_10",
				text = "ANA_FORT_9_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ana_fort_10",
				text = "ANA_FORT_9_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "ana_mercenary_2"
	},
	ana_fort_10 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "ANA_FORT_7",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "reyan_boss_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "ana_mercenary_2"
	},
	ana_fort_11 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_11",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_fort_12",
				text = "ANA_FORT_11_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "ana_fort_12",
				text = "ANA_FORT_11_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_fort_12 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FORT_12",
				reqs = [

				],
				previous_dialogue_option = 1
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
						value = "anastasia_quest_2",
						stage = "stage13"
					},
					{
						code = "remove_quest_location",
						value = "quest_dungeon_ana_fort"
					}
				]
			}
		]
	},
	ana_final_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		character2 = "duncan",
		text = [
			{
				text = "ANA_FINAL_1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "ana_final_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_final_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "anastasia",
		character2 = "duncan",
		text = [
			{
				text = "ANA_FINAL_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_final_3",
				text = "ANA_FINAL_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			},
			{
				code = "ana_final_3",
				text = "ANA_FINAL_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	ana_final_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "anastasia",
		text = [
			{
				text = "ANA_FINAL_3",
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
						value = "anastasia_quest_2"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	
	ana_blow_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		custom_background = "ana_blow_1",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "ana_blow",
		reqs = [], 
		text = [{text = "ANA_BLOW_1", reqs = [], }], 
		options = [ {code = 'ana_blow_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, ],
	},
	ana_blow_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		custom_background = "ana_blow_2",
		save_scene_to_gallery = true,
		reqs = [], 
		text = [{text = "ANA_BLOW_2", reqs = [], }], 
		options = [ {code = 'ana_blow_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, ],
	},
	ana_blow_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		custom_background = "ana_blow_3",
		save_scene_to_gallery = true,
		reqs = [], 
		text = [{text = "ANA_BLOW_3", reqs = [], }], 
		options = [ {code = 'ana_blow_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, ],
	},
	ana_blow_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		custom_background = "ana_blow_4",
		save_scene_to_gallery = true,
		reqs = [], 
		text = [{text = "ANA_BLOW_4", reqs = [], }], 
		options = [ {code = 'ana_blow_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, ],
	},
	ana_blow_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		custom_background = "ana_blow_5",
		save_scene_to_gallery = true,
		reqs = [], 
		text = [{text = "ANA_BLOW_5", reqs = [], }], 
		options = [ {code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, ],
	},
	
	
}
