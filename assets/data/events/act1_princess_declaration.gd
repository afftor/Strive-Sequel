extends Reference
var data = {
	princess_declaration_1 = {
		image = null,
		music = 'tragic',
		character = "$anastasia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ANASTASIA_DECLARATION_1",
				reqs = [

				],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "princess_declaration_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	princess_declaration_2 = {
		image = null,
		character = "$anastasia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ANASTASIA_DECLARATION_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "princess_declaration_3",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	princess_declaration_3 = {
		image = null,
		character = "$anastasia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ANASTASIA_DECLARATION_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "princess_declaration_4",
				text = "ANASTASIA_DECLARATION_OPTION_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "princess_declaration_4",
				text = "ANASTASIA_DECLARATION_OPTION_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	princess_declaration_4 = {
		image = null,
		character = "$anastasia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ANASTASIA_DECLARATION_4",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ANASTASIA_DECLARATION_5",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		common_effects = [

		],
		options = [
			{
				code = "final_words_1",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "decision",
						value = "anastasia_added"
					}
				]
			}
		]
	},
	final_words_1 = {
		character = "duncan",
		character2 = "sigmund",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "add_timed_event",
				value = "amelia_herbs_start",
				args = [
					{
						type = "add_to_date",
						date = [
							1,
							1
						],
						hour = 1
					}
				]
			},
			{
				code = "add_timed_event",
				value = "zephyra_recruitment_letter",
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
			},
			{
				code = "add_timed_event",
				value = "zephyra_sword_1",
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
			},
			{
				code = "add_master_points",
				value = 1
			},
			{
				code = "decision",
				value = "mayor_election_finished"
			},
			{
				code = "decision",
				value = "act1_finish"
			},
			{
				code = "check_masters_story_fame",
			},
			{
				code = "achievement",
				value = "act1"
			}
		],
		text = [
			{
				text = "FINAL_WORDS_1",
				reqs = [

				]
			},
			{
				text = "",
				reqs = [
					{
						type = "decision",
						value = "anastasia_added",
						check = true
					},
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					}
				],
				bonus_effects = [
					{
						code = "make_story_character",
						value = "Anastasia"
					},
					{
						code = "add_timed_event",
						value = "ana_letter_1",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									3
								],
								hour = 1
							}
						]
					}
				]
			},
			{
				text = "",
				reqs = [
					{
						type = "decision",
						value = "anastasia_added",
						check = true
					},
					{
						type = "decision",
						value = "mindbreak_completed",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "make_story_character",
						value = "AnastasiaBroken"
					}
				]
			},
			{
				text = "",
				reqs = [
					{
						type = "decision",
						value = "anastasia_added",
						check = true
					},
					{
						type = "decision",
						value = "mindbreak_completed",
						check = true
					},
					{
						type = "decision",
						value = "bracelet_returned",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "anastasiaBroken",
						args = [
							{
								code = "create_and_equip",
								item = "anastasia_broken_bracelet",
								parts = {

								}
							}
						]
					}
				]
			},
			{
				text = "",
				reqs = [
					{
						type = "decision",
						value = "bracelet_returned",
						check = true
					},
					{
						type = "decision",
						value = "anastasia_added",
						check = true
					},
					{
						type = "decision",
						value = "mindbreak_completed",
						check = false
					}
				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "anastasia",
						args = [
							{
								code = "create_and_equip",
								item = "anastasia_bracelet",
								parts = {

								}
							}
						]
					}
				]
			},
			{
				text = "",
				reqs = [
					{
						type = "decision",
						value = "AireAnastasiaPersuasion",
						check = true
					},
					{
						type = "decision",
						value = "persuade_2_completed",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "make_story_character",
						value = "Aire"
					}
				]
			},
			{
				text = "",
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "anastasia",
						args = [
							{
								code = "wits_factor",
								operant = "=",
								value = 1
							},
							{
								code = "wits",
								operant = "=",
								value = 3
							},
							{
								code = "charm",
								operant = "=",
								value = 8
							},
							{
								code = "consent",
								operant = "=",
								value = 6
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "princess_cutscene_init",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "decision",
						value = "anastasia_added",
						check = true
					}
				],
				type = "next_dialogue",
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "update_city"
					}
				]
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "decision",
						value = "anastasia_added",
						check = false
					}
				],
				type = "next_dialogue",
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "update_city"
					},
					{
						code = "rewrite_save"
					},
					{
						code = "complete_quest",
						value = "princess_persuasion"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	princess_cutscene_init = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "persuade_2_completed",
						check = true
					}
				],
				music = "intimate",
				image = null,
				character = "$anastasia",
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				text = [
					{
						text = "AFTER_ELECTION_PRINCESS_1",
						reqs = [

						]
					},
					{
						text = "AFTER_ELECTION_PRINCESS_2",
						reqs = [
							{
								type = "decision",
								value = "marry_option",
								check = true
							}
						]
					},
					{
						text = "AFTER_ELECTION_PRINCESS_3",
						reqs = [
							{
								type = "decision",
								value = "enslave_option",
								check = true
							}
						]
					}
				],
				options = [
					{
						code = "princess_cutscene_good_1",
						text = "AFTER_ELECTION_PRINCESS_OPTION_1",
						reqs = [
							{
								type = "decision",
								value = "marry_option",
								check = true
							}
						],
						type = "next_dialogue",
						dialogue_argument = 1
					},
					{
						code = "princess_cutscene_exit_1",
						text = "AFTER_ELECTION_PRINCESS_OPTION_2",
						reqs = [
							{
								type = "decision",
								value = "enslave_option",
								check = true
							}
						],
						type = "next_dialogue",
						dialogue_argument = 1
					},
					{
						code = "princess_cutscene_bad_1",
						text = "AFTER_ELECTION_PRINCESS_OPTION_3",
						reqs = [
							{
								type = "decision",
								value = "marry_option",
								check = true
							}
						],
						type = "next_dialogue",
						dialogue_argument = 1
					},
					{
						code = "princess_cutscene_bad_1",
						text = "AFTER_ELECTION_PRINCESS_OPTION_4",
						reqs = [
							{
								type = "decision",
								value = "enslave_option",
								check = true
							}
						],
						type = "next_dialogue",
						dialogue_argument = 1
					},
					{
						code = "princess_cutscene_exit_2",
						text = "AFTER_ELECTION_PRINCESS_OPTION_5",
						type = "next_dialogue",
						reqs = [

						],
						dialogue_argument = 1
					}
				]
			},
			{
				reqs = [
					{
						type = "decision",
						value = "mindbreak_completed",
						check = true
					}
				],
				image = null,
				music = "intimate_dark",
				character = "$anastasia",
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				text = [
					{
						text = "AFTER_ELECTION_PRINCESS_MINDBREAK_0",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "close",
						text = "AFTER_ELECTION_PRINCESS_OPTION_9",
						type = "next_dialogue",
						reqs = [

						],
						bonus_effects = [
							{
								code = "rewrite_save"
							}
						],
						dialogue_argument = 1
					}
				]
			}
		]
	},
	princess_cutscene_good_1 = {
		image = null,
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "anastasia_sex",
		save_scene_to_gallery = true,
		character = "$anastasia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "AFTER_ELECTION_PRINCESS_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "AFTER_ELECTION_PRINCESS_6",
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "rewrite_save"
					}
				],
				dialogue_argument = 1
			}
		]
	},
	princess_cutscene_exit_1 = {
		image = null,
		character = "$anastasia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "AFTER_ELECTION_PRINCESS_12",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "update_city"
					},
					{
						code = "rewrite_save"
					}
				]
			}
		]
	},
	princess_cutscene_exit_2 = {
		image = null,
		character = "$anastasia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "AFTER_ELECTION_PRINCESS_16_OLD",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "update_city"
					},
					{
						code = "rewrite_save"
					}
				]
			}
		]
	},
	princess_cutscene_bad_1 = {
		image = null,
		character = "$anastasia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "AFTER_ELECTION_PRINCESS_13",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "AFTER_ELECTION_PRINCESS_OPTION_7",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "rewrite_save"
					}
				]
			}
		]
	},
}
