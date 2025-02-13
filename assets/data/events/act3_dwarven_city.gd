extends Reference
var data = {
	act3_intro = {
		variations = [
			{
				image = "letter",
				reqs = [
					{
						type = "has_hero",
						name = "zephyra",
						check = false
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "ACT3_INTRO_NO_Z",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "act3_scene",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue",
						change_dialogue_type = 2,
					}
				],
				common_effects = [
					{
						code = "decision",
						value = "act3_start"
					}
				]
			},
			{
				character = "zephyra",
				reqs = [
					{
						type = "has_hero",
						name = "zephyra",
						check = true
					}
				],
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				text = [
					{
						text = "ACT3_INTRO_Z",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "act3_scene",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue",
						change_dialogue_type = 2,
					}
				]
			}
		]
	},
	enter_city_t_0 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ENTER_CITY_T_0",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "enter_city_t_1",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 9
			}
		],
		image = "dwarf_gates"
	},
	enter_city_t_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ENTER_CITY_T_1",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "ENTER_CITY_RESPOND_VISITORS_NOTDWARF",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = false
							}
						]
					}
				],
				previous_dialogue_option = 1
			},
			{
				text = "ENTER_CITY_RESPOND_VISITORS_DWARF",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = true
							}
						]
					}
				],
				previous_dialogue_option = 1
			},
			{
				text = "ENTER_CITY_RESPOND_ALERT_NOTDWARF",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = false
							}
						]
					}
				],
				previous_dialogue_option = 2
			},
			{
				text = "ENTER_CITY_RESPOND_ALERT_DWARF",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = true
							}
						]
					}
				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "enter_city_t_1",
				text = "ENTER_CITY_OPTION_VISITORS",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "enter_city_t_1",
				text = "ENTER_CITY_OPTION_ALERT",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "enter_city_introduce",
				text = "ENTER_CITY_OPTION_INTRODUCE",
				reqs = [

				],
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "ENTER_CITY_OPTION_TURN_AWAY",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "return_to_mansion"
					},
					{
						code = "plan_loc_event",
						loc = "dwarf_capital",
						event = "enter_city_t_0"
					}
				]
			}
		],
		image = "dwarf_gates"
	},
	enter_city_introduce = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "ENTER_CITY_RESPOND_INTRODUCE_NOTDWARF",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = false
							}
						]
					}
				]
			},
			{
				text = "ENTER_CITY_RESPOND_INTRODUCE_DWARF",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = true
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "enter_city_body_check",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		image = "dwarf_gates"
	},
	enter_city_body_check = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "ENTER_CITY_BODY_CHECK",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "visit_dwarfs_quest",
						stage = "audience"
					},
					{
						code = "update_city"
					}
				]
			}
		],
		image = "dwarf_gates"
	},
	dwarf_palace_first = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "DWARF_PALACE_FIRST",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "DWARF_PALACE_REPLY_PATTERN3",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "dwarf_palace_reply_pattern",
				text = "DWARF_PALACE_OPT_PATTERN",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "dwarf_palace_first_biz",
				text = "DWARF_PALACE_OPT_BIZ",
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "audience"
					}
				],
				dialogue_argument = 0
			},
			{
				code = "jean_report",
				text = "DWARF_PALACE_OPT_CRIME",
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "jean"
					}
				],
				dialogue_argument = 0
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	dwarf_palace_reply_pattern = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "DWARF_PALACE_REPLY_PATTERN1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DWARF_PALACE_REPLY_PATTERN2_NOSHORT",
				previous_dialogue_option = 1,
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "body_shape",
								operant = "neq",
								value = "shortstack"
							}
						]
					}
				]
			},
			{
				text = "DWARF_PALACE_REPLY_PATTERN2_SHORT",
				previous_dialogue_option = 1,
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "body_shape",
								operant = "eq",
								value = "shortstack"
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "dwarf_palace_first",
				dialogue_argument = 1,
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "dwarf_guard"
	},
	dwarf_palace_first_biz = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DWARF_PALACE_BIZ",
				reqs = [

				],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "dwarf_palace_reply_urgent",
				text = "DWARF_PALACE_OPT_URGENT",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dwarf_palace_reply_important",
				text = "DWARF_PALACE_OPT_IMPORTANT",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	dwarf_palace_reply_important = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DWARF_PALACE_REPLY_IMPORTANT1",
				reqs = [

				],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "dwarf_palace_first_end",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		],
		image = "dwarf_guard"
	},
	dwarf_palace_reply_urgent = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DWARF_PALACE_REPLY_URGENT",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "dwarf_palace_first_end",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_guard"
	},
	dwarf_palace_first_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DWARF_PALACE_REPLY_URGENT2",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DWARF_PALACE_REPLY_IMPORTANT2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dwarf_palace_first_end2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_guard"
	},
	dwarf_palace_first_end2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DWARF_PALACE_FIRST_END",
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
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "visit_dwarfs_quest",
						stage = "tavern"
					},
					{
						code = "update_city"
					}
				],
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	dwarf_workshop_closed2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DWARF_WORKSHOP_CLOSED2",
		options = [
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_machine"
	},
	dwarf_tavern_barkeep = {
		variations = [
			{
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = false
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "DTAVERN_BARK_CLOSED",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "dwarf_tavern_barkeep2",
						text = "DTAVERN_BARK_OPT_DOESNT",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					},
					{
						code = "dwarf_tavern_barkeep2",
						text = "DTAVERN_BARK_OPT_INFO",
						reqs = [

						],
						dialogue_argument = 2,
						type = "next_dialogue"
					},
					{
						code = "dwarf_tavern",
						text = "DIALOGUENEVERMIND",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					}
				],
				image = "dwarf_barman"
			},
			{
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = true
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "DTAVERN_BARK_HAVING",
						reqs = [

						],
						previous_dialogue_option = 0
					},
					{
						text = "DTAVERN_BARK_REPLY_GIRL_D",
						reqs = [

						],
						previous_dialogue_option = 1
					},
					{
						text = "DTAVERN_BARK_REPLY_DRINK",
						reqs = [

						],
						previous_dialogue_option = 2
					}
				],
				options = [
					{
						code = "dwarf_tavern_barkeep",
						text = "DTAVERN_BARK_OPT_GIRL_D",
						dialogue_argument = 1,
						reqs = [
							{
								type = "active_quest_stage",
								value = "visit_dwarfs_quest",
								stage = "tavern"
							}
						]
					},
					{
						code = "dwarf_tavern_barkeep",
						text = "DTAVERN_BARK_OPT_DRINK",
						reqs = [

						],
						dialogue_argument = 2,
						bonus_effects = [
							{
								code = "money_change",
								operant = "-",
								value = 10
							}
						]
					},
					{
						code = "dwarf_tavern_barkeep2_dwarf",
						text = "DTAVERN_BARK_OPT_INFO_D",
						reqs = [

						],
						dialogue_argument = 0,
						type = "next_dialogue"
					}
				]
			}
		]
	},
	dwarf_tavern_barkeep2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_BARK_REPLY_DOESNT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_BARK_REPLY_INFO",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_BARK_REPLY_GIRL",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "DTAVERN_BARK_REPLY_SIZE",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "dwarf_tavern_barkeep2",
				text = "DTAVERN_BARK_OPT_GIRL",
				dialogue_argument = 3,
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "tavern"
					}
				]
			},
			{
				code = "dwarf_tavern_barkeep2",
				text = "DTAVERN_BARK_OPT_SIZE",
				reqs = [

				],
				dialogue_argument = 4
			},
			{
				code = "dwarf_tavern_bark_conflict1",
				text = "DTAVERN_BARK_OPT_EASY",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_barman"
	},
	dwarf_tavern_bark_conflict1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_BARK_REPLY_EASY",
		options = [
			{
				code = "dwarf_tavern_bark_conflict2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_barman"
	},
	dwarf_tavern_bark_conflict2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_BARK_GROUP",
		options = [
			{
				code = "dwarf_tavern_bark_conflict3",
				text = "DTAVERN_BARK_OPT_WANTED",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_bark_conflict3",
				text = "DTAVERN_BARK_OPT_NANNIES",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		],
		image = "dwarf_goons"
	},
	dwarf_tavern_bark_conflict3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_BARK_REPLY_WANTED",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_BARK_REPLY_NANNIES",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_BARK_DAGGER",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_bark_physics",
				text = "DTAVERN_BARK_OPT_PHYSICS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_bark_trouble",
				text = "DTAVERN_BARK_OPT_NOTROUBLE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "quest_fight",
				args = "dwarf_tavern_patrons",
				text = "DTAVERN_BARK_OPT_FIGHT",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_goons"
	},
	dwarf_tavern_bark_physics = {
		variations = [
			{
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "gte",
								value = 5
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "DTAVERN_BARK_REPLY_PHYSICS_SUCCESS",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "dwarf_tavern",
						text = "DIALOGUEWALKAWAY",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					}
				],
				image = "dwarf_goons"
			},
			{
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "lt",
								value = 5
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "DTAVERN_BARK_REPLY_PHYSICS_FAILURE",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "quest_fight",
						args = "dwarf_tavern_patrons",
						text = "DIALOGUEFIGHTOPTION",
						reqs = [

						],
						dialogue_argument = 0,
						type = "next_dialogue"
					}
				]
			}
		]
	},
	dwarf_tavern_bark_after_fight = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_BARK_AFTER_FIGHT",
		options = [
			{
				code = "dwarf_tavern_bark_after_fight2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "tavern"
					}
				],
				dialogue_argument = 0
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "tavern",
						state = false
					}
				],
				dialogue_argument = 0
			}
		],
		image = "dwarf_goons"
	},
	dwarf_tavern_bark_after_fight2 = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_BARK_OUTSIDE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_after_fight",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_after_fight = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN_AFIGHT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_outside",
				text = "DTAVERN_JEAN_AFIGHT_OPT_HELP",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_jean_outside",
				text = "DTAVERN_JEAN_AFIGHT_OPT_THK",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_bark_trouble = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_BARK_REPLY_NOTROUBLE",
		options = [
			{
				code = "dwarf_tavern_bark_leave",
				text = "DTAVERN_BARK_OPT_LEAVE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "quest_fight",
				args = "dwarf_tavern_patrons",
				text = "DTAVERN_BARK_OPT_RESIST",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_goons"
	},
	dwarf_tavern_bark_leave = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_BARK_REPLY_LEAVE",
		options = [
			{
				code = "dwarf_tavern_jean_outside",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 4,
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "tavern"
					}
				]
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				type = "next_dialogue",
				reqs = [
					{
						type = "active_quest_stage",
						value = "visit_dwarfs_quest",
						stage = "tavern",
						state = false
					}
				],
				dialogue_argument = 0
			}
		],
		image = "dwarf_goons"
	},
	dwarf_tavern_patron = {
		variations = [
			{
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = false
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "DTAVERN_PATRONS1",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "dwarf_tavern_patron2",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 0,
						type = "next_dialogue"
					}
				],
				image = "dwarf_barman"
			},
			{
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "race",
								race = "Dwarf",
								check = true
							}
						]
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "DTAVERN_PATRONS_DWARF",
						reqs = [

						],
						previous_dialogue_option = 0
					},
					{
						text = "DTAVERN_PATRONS_REPLY_ASK",
						reqs = [

						],
						previous_dialogue_option = 1
					},
					{
						text = "DTAVERN_PATRONS_REPLY_FRIENDLY",
						reqs = [

						],
						previous_dialogue_option = 2
					}
				],
				options = [
					{
						code = "dwarf_tavern_patron",
						text = "DTAVERN_PATRONS_OPT_ASK",
						reqs = [

						],
						dialogue_argument = 1
					},
					{
						code = "dwarf_tavern_patron",
						text = "DTAVERN_PATRONS_OPT_FRIENDLY",
						reqs = [

						],
						dialogue_argument = 2
					},
					{
						code = "dwarf_tavern_patron_end",
						text = "DTAVERN_PATRONS_OPT_ENJOY",
						reqs = [

						],
						dialogue_argument = 0,
						type = "next_dialogue"
					}
				]
			}
		]
	},
	dwarf_tavern_patron2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_PATRONS2",
		options = [
			{
				code = "dwarf_tavern",
				text = "DIALOGUEWALKAWAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_barman"
	},
	dwarf_tavern_jean = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_outside",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_outside = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN2",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_JEAN_AFIGHT_REPLY_HELP",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_JEAN_AFIGHT_REPLY_THK",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "DTAVERN_JEAN_OUTSIDE_FORCED",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_outside2",
				text = "DTAVERN_JEAN_OPT_WHO",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_jean_outside2",
				text = "DTAVERN_JEAN_OPT_WHY",
				reqs = [
					{
						type = "event_seen",
						check = true,
						value = "dwarf_tavern_bark_after_fight"
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_jean_king",
				text = "DTAVERN_JEAN_OPT_KING",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_king = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN_REPLY_KING1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_outside2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_outside2 = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN_REPLY_WHO",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_JEAN_REPLY_WHY",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_JEAN_REPLY_KING2",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "DTAVERN_JEAN_HEARD",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_thing",
				text = "DTAVERN_JEAN_OPT_MET",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_jean_thing",
				text = "DTAVERN_JEAN_OPT_PLAN",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_thing = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN_REPLY_MET",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_JEAN_REPLY_PLAN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_JEAN_THING",
				reqs = [

				],
				previous_dialogue_option = [
					1,
					2
				]
			},
			{
				text = "DTAVERN_JEAN_REPLY_TRUST",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_thing",
				text = "DTAVERN_JEAN_OPT_TRUST",
				reqs = [

				],
				dialogue_argument = 3
			},
			{
				code = "dwarf_tavern_jean_map",
				text = "DTAVERN_JEAN_OPT_ALONE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dwarf_tavern_jean_map",
				text = "DTAVERN_JEAN_OPT_NODEAL",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_map = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN_REPLY_ALONE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_JEAN_REPLY_NODEAL",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_JEAN_MAP",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_tavern_jean_map2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	dwarf_tavern_jean_map2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_JEAN_MAP2",
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
				dialogue_argument = 0,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "visit_dwarfs_quest",
						stage = "jean"
					},
					{
						code = "make_quest_location",
						value = "quest_mountain_pass"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	dwarf_tavern_barkeep2_dwarf = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_BARK_REPLY_INFO_D",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "DTAVERN_BARK_REPLY_TENSE2",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DTAVERN_BARK_REPLY_COALITION",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DTAVERN_BARK_REPLY_CITY",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "DTAVERN_BARK_REPLY_KING",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "dtavern_bark_reply_tense",
				text = "DTAVERN_BARK_OPT_TENSE",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "dwarf_tavern_barkeep2_dwarf",
				text = "DTAVERN_BARK_OPT_COALITION",
				dialogue_argument = 2,
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "DTAVERN_BARK_REPLY_TENSE"
					}
				]
			},
			{
				code = "dwarf_tavern_barkeep2_dwarf",
				text = "DTAVERN_BARK_OPT_CITY",
				reqs = [

				],
				dialogue_argument = 3
			},
			{
				code = "dwarf_tavern_barkeep2_dwarf",
				text = "DTAVERN_BARK_OPT_KING",
				dialogue_argument = 4,
				reqs = [
					{
						type = "any_quest_stage",
						value = "visit_dwarfs_quest",
						stages = [
							"tavern",
							"jean"
						]
					}
				]
			},
			{
				code = "dwarf_tavern_barkeep_end",
				text = "DTAVERN_BARK_OPT_THATSALL",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_barman"
	},
	dtavern_bark_reply_tense = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "DTAVERN_BARK_REPLY_TENSE",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "dwarf_tavern_barkeep2_dwarf",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_barman"
	},
	dwarf_tavern_barkeep_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_BARK_REPLY_THATSALL",
		options = [
			{
				code = "dwarf_tavern",
				text = "DIALOGUEWALKAWAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_barman"
	},
	dwarf_tavern_patron_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "DTAVERN_PATRONS_REPLY_ENJOY",
		options = [
			{
				code = "dwarf_tavern",
				text = "DIALOGUEWALKAWAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_barman"
	},
	jean_mountain_start = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		common_effects = [
			{
				code = "decision",
				value = "JeanHelp"
			}
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_start2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_start2 = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_START2",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "JEAN_MOUNTAIN_REPLY_PLAN",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_MOUNTAIN_REPLY_LOOK",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_MOUNTAIN_REPLY_BACK",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "JEAN_MOUNTAIN_REPLY_GUARDS",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "jean_mountain_start2",
				text = "JEAN_MOUNTAIN_OPT_PLAN",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "jean_mountain_start2",
				text = "JEAN_MOUNTAIN_OPT_LOOK",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "jean_mountain_start2",
				text = "JEAN_MOUNTAIN_OPT_BACK",
				dialogue_argument = 3,
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "JEAN_MOUNTAIN_REPLY_PLAN"
					}
				]
			},
			{
				code = "jean_mountain_start2",
				text = "JEAN_MOUNTAIN_OPT_GUARDS",
				dialogue_argument = 4,
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "JEAN_MOUNTAIN_REPLY_PLAN"
					}
				]
			},
			{
				code = "jean_mountain_cast",
				text = "JEAN_MOUNTAIN_OPT_DOTHIS",
				dialogue_argument = 0,
				type = "next_dialogue",
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "JEAN_MOUNTAIN_REPLY_PLAN"
					}
				]
			}
		]
	},
	jean_mountain_cast = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_CAST",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_cast2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_cast2 = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_CAST2",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "JEAN_MOUNTAIN_REPLY_LOOKNOT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_MOUNTAIN_REPLY_FIRST",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_mountain_cast2",
				text = "JEAN_MOUNTAIN_OPT_LOOKNOT",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "jean_mountain_cast2",
				text = "JEAN_MOUNTAIN_OPT_FIRST",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "jean_mountain_push",
				text = "JEAN_MOUNTAIN_OPT_PUSH",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			},
			{
				code = "jean_mountain_jump",
				text = "JEAN_MOUNTAIN_OPT_JUMP",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_push = {
		reqs = [

		],
		common_effects = [
			{
				code = "play_sound",
				value = "fall"
			}
		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_PUSH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_push2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_push2 = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_PUSH2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_push_altar",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_push_altar = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_ALTAR",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_push_search",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_push_search = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_PUSH_SEARCH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_push_golem",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_push_golem = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_GOLEM",
				reqs = [

				]
			},
			{
				text = "JEAN_MOUNTAIN_PUSH_GOLEM",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "vault_golem",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_jump = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_MOUNTAIN_JUMP",
		options = [
			{
				code = "jean_mountain_jump_altar",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		image = "dwarf_treasury"
	},
	jean_mountain_jump_altar = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_MOUNTAIN_ALTAR",
		options = [
			{
				code = "jean_mountain_jump_search",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue"
			}
		],
		image = "dwarf_treasury"
	},
	jean_mountain_jump_search = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_JUMP_SEARCH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_mountain_jump_golem",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_jump_golem = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_GOLEM",
				reqs = [

				]
			},
			{
				text = "JEAN_MOUNTAIN_JUMP_GOLEM",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "vault_golem",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_mountain_guards = {
		reqs = [

		],
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_MOUNTAIN_GUARDS",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_dungeon_in",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_dungeon_in = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "teleport_active_location_all",
				to_loc = {
					location = "dwarf_capital",
					code = "dwarf_capital",
					area = "mountains"
				}
			},
			{
				code = "open_location",
				location = "dwarf_capital",
				area = "mountains"
			},
			{
				code = "remove_quest_location",
				value = "quest_mountain_pass"
			}
		],
		text = "JEAN_DUNGEON_INTRO",
		options = [
			{
				code = "jean_dungeon_guard",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		character = "jean"
	},
	jean_dungeon_guard = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_DUNGEON_GUARD",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "JEAN_DUNGEON_REPLY_WHAT",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "jean_dungeon_guard",
				text = "JEAN_DUNGEON_OPT_WHAT",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "jean_dungeon_reply_until",
				text = "JEAN_DUNGEON_OPT_UNTIL",
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "JEAN_DUNGEON_REPLY_WHAT"
					}
				],
				dialogue_argument = 0
			},
			{
				code = "jean_dungeon_obey",
				text = "JEAN_DUNGEON_OPT_OBEY",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	jean_dungeon_reply_until = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_DUNGEON_REPLY_UNTIL",
		options = [
			{
				code = "jean_dungeon_reply_until2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	jean_dungeon_reply_until2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_DUNGEON_REPLY_UNTIL2",
		options = [
			{
				code = "jean_dungeon_obey",
				text = "JEAN_DUNGEON_OPT_OBEY",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		character = "jean"
	},
	jean_dungeon_obey = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "JEAN_DUNGEON_REPLY_OBEY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_dungeon_end",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	jean_dungeon_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_DUNGEON_END",
		options = [
			{
				code = "jean_dungeon_end1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		]
	},
	jean_dungeon_end1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_DUNGEON_END1",
		options = [
			{
				code = "jean_dungeon_end2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	jean_dungeon_end2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_DUNGEON_END2",
		options = [
			{
				code = "dking_first_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	},
	jean_report = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		common_effects = [
			{
				code = "decision",
				value = "JeanReport"
			},
			{
				code = "remove_quest_location",
				value = "quest_mountain_pass"
			}
		],
		text = "JEAN_REPORT",
		options = [
			{
				code = "jean_report2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "dwarf_guard"
	},
	jean_report2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "JEAN_REPORT2",
		options = [
			{
				code = "dking_first_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "dwarf_guard"
	}
}
