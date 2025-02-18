extends Reference
var data = {
	dking_second_task_start = {
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		common_effects = [
			{
				code = "complete_quest",
				value = "dking_hara_quest"
			}
		],
		reqs = [

		],
		text = [
			{
				text = "DKING_SECOND_TASK_START",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "DKING_SECOND_TASK_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DKING_SECOND_TASK_REPLY2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dking_second_task_start",
				text = "DKING_SECOND_TASK_OPT_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "dking_second_task_start",
				text = "DKING_SECOND_TASK_OPT_2",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "dking_second_task_1",
				text = "DKING_SECOND_TASK_OPT_3",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		]
	},
	dking_second_task_1 = {
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		reqs = [

		],
		text = [
			{
				text = "DKING_SECOND_TASK_1",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "DKING_SECOND_TASK_1_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DKING_SECOND_TASK_1_REPLY2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dking_second_task_1",
				text = "DKING_SECOND_TASK_1_OPT_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "dking_second_task_1",
				text = "DKING_SECOND_TASK_1_OPT_2",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "dking_second_task_2",
				text = "DKING_SECOND_TASK_1_OPT_3",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		]
	},
	dking_second_task_2 = {
		tags = [
			"dialogue_scene"
		],
		character = "dwarf_king",
		reqs = [

		],
		text = [
			{
				text = "DKING_SECOND_TASK_2",
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
						value = "hara_scales_quest",
						stage = "see_hara"
					}
				]
			}
		]
	},
	dking2task_hara_1 = {
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_workshop",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	dking2task_hara_3 = {
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_3",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "DKING2TASK_HARA_SO_KING",
				reqs = [
					{
						type = "dialogue_seen",
						check = false,
						value = "DKING2TASK_HARA_SO_KING"
					}
				],
				previous_dialogue_option = 0
			},
			{
				text = "DKING2TASK_HARA_3_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "dking2task_hara_4",
				text = "DKING2TASK_HARA_3_OPT_1",
				reqs = [
					{
						type = "active_quest_stage",
						value = "hara_scales_quest",
						stage = "see_hara"
					}
				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "dking2task_hara_3",
				text = "DKING2TASK_HARA_3_OPT_2",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "dking2task_hara_5",
				text = "DKING2TASK_HARA_3_OPT_3",
				reqs = [
					{
						type = "active_quest_stage",
						value = "hara_scales_quest",
						stage = "bring_ore"
					}
				],
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					}
				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "dking2task_hara_8",
				text = "DKING2TASK_HARA_3_OPT_4",
				reqs = [
					{
						type = "active_quest_stage",
						value = "hara_scales_quest",
						stage = "bring_sap"
					}
				],
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					}
				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "dking2task_hara_10",
				text = "DKING2TASK_HARA_3_OPT_5",
				reqs = [
					{
						type = "active_quest_stage",
						value = "hara_scales_quest",
						stage = "bring_cap"
					}
				],
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					}
				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "dwarf_workshop",
				text = "DIALOGUEWALKAWAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	dking2task_hara_4 = {
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_4",
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
						value = "hara_scales_quest",
						stage = "get_ore"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	shimmering_ore_start = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		common_effects = [
			{
				code = "dialogue_counter",
				name = "kuros_questions",
				op = "+"
			}
		],
		text = [
			{
				text = "SHIMMERING_ORE_START_REVISIT",
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "SHIMMERING_ORE_START"
					}
				]
			},
			{
				text = "SHIMMERING_ORE_START",
				reqs = [
					{
						type = "dialogue_seen",
						check = false,
						value = "SHIMMERING_ORE_START"
					}
				]
			}
		],
		options = [
			{
				code = "shimmering_ore_1",
				text = "SHIMMERING_ORE_START_OPT_1",
				reqs = [
					{
						type = "has_money",
						value = 1000
					}
				],
				type = "next_dialogue",
				dialogue_argument = 0,
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 1000
					}
				],
				not_hide = true
			},
			{
				code = "close",
				text = "SHIMMERING_ORE_START_OPT_2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "progress_quest",
						value = "hara_scales_quest",
						stage = "get_gold"
					}
				]
			}
		]
	},
	shimmering_ore_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "SHIMMERING_ORE_1",
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
						value = "hara_scales_quest",
						stage = "bring_ore"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	dking2task_hara_5 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "hara",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_5",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "DKING2TASK_HARA_5_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DKING2TASK_HARA_5_REPLY2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "dking2task_hara_5",
				text = "DKING2TASK_HARA_5_OPT_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "dking2task_hara_5",
				text = "DKING2TASK_HARA_5_OPT_2",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "dking2task_hara_6",
				text = "DKING2TASK_HARA_5_OPT_3",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	dking2task_hara_6 = {
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		character2 = "kuro",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dking2task_hara_7",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	dking2task_hara_7 = {
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_7",
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
						value = "hara_scales_quest",
						stage = "get_sap"
					}
				]
			}
		]
	},
	sacred_sap_heleviel_start = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "heleviel",
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_HELEVIEL_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_heleviel_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_heleviel_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "heleviel",
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_HELEVIEL_2",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "SACRED_SAP_HELEVIEL_2_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "sacred_sap_heleviel_2",
				text = "SACRED_SAP_HELEVIEL_2_OPT_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "sacred_sap_heleviel_3",
				text = "SACRED_SAP_HELEVIEL_2_OPT_2",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_heleviel_3 = {
		tags = [
			"dialogue_scene"
		],
		character = "heleviel",
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_HELEVIEL_3",
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
						value = "hara_scales_quest",
						stage = "h_scouts"
					},
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					},
					{
						code = "add_timed_event",
						value = "sacred_sap_intermission_start",
						args = [
							{
								type = "add_to_hour",
								hour = [
									1,
									1
								]
							}
						]
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	sacred_sap_fighters_start = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_START",
				reqs = [

				],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "sacred_sap_fighters_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_fighters_1 = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_1",
				reqs = [

				],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "sacred_sap_fighters_2",
				text = "SACRED_SAP_FIGHTERS_1_OPT1",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "sacred_sap_fighters_2",
				text = "SACRED_SAP_FIGHTERS_1_OPT2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		],
		image = "elven_prisoners"
	},
	sacred_sap_fighters_2 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_2",
				reqs = [

				],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "sacred_sap_fighters_3",
				text = "SACRED_SAP_FIGHTERS_2_OPT1",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 9
			},
			{
				code = "sacred_sap_fighters_3",
				text = "SACRED_SAP_FIGHTERS_2_OPT2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 9
			}
		],
		image = "elven_prisoners"
	},
	sacred_sap_fighters_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_3",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "SACRED_SAP_FIGHTERS_3_REVISIT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "sacred_sap_fighters_4",
				text = "SACRED_SAP_FIGHTERS_3_OPT1",
				reqs = [
					{
						type = "has_money",
						value = 1000
					},
					{
						type = "faction_reputation",
						code = "fighters",
						operant = "gte",
						value = 1000
					}
				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 1000
					}
				],
				not_hide = true
			},
			{
				code = "sacred_sap_fighters_slave",
				text = "SACRED_SAP_FIGHTERS_3_OPT2",
				reqs = [

				],
				select_person = true,
				person_reqs = [
					{
						code = "is_at_location",
						value = "aliron",
						check = true
					},
					{
						code = "race",
						race = "Elf",
						check = true
					},
					{
						code = "sex",
						operant = "eq",
						value = "female"
					}
				],
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "SACRED_SAP_FIGHTERS_3_OPT3",
				reqs = [

				],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "hara_scales_quest",
						stage = "h_price"
					},
					{
						code = "update_guild"
					}
				]
			}
		],
		image = "elven_prisoners"
	},
	sacred_sap_fighters_slave = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		common_effects = [
			{
				code = "affect_active_character",
				type = "remove"
			},
			{
				code = "dialogue_counter",
				name = "sacred_sap_slaves",
				op = "+"
			}
		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_3_REPLY2",
				reqs = [
					{
						type = "local_counter",
						name = "sacred_sap_slaves",
						operant = "eq",
						value = 1,
						check = true
					}
				]
			},
			{
				text = "SACRED_SAP_FIGHTERS_3_REPLY2_2",
				reqs = [
					{
						type = "local_counter",
						name = "sacred_sap_slaves",
						operant = "eq",
						value = 2,
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "sacred_sap_fighters_4",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "local_counter",
						name = "sacred_sap_slaves",
						operant = "gte",
						value = 2,
						check = true
					}
				],
				dialogue_argument = 0,
				type = "next_dialogue"
			},
			{
				code = "sacred_sap_fighters_3",
				dialogue_argument = 2,
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "local_counter",
						name = "sacred_sap_slaves",
						operant = "lt",
						value = 2,
						check = true
					}
				],
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_fighters_4 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_fighters_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_fighters_5 = {
		tags = [
			"dialogue_scene"
		],
		custom_background = "forest1",
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_FIGHTERS_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_heleviel_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_heleviel_4 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "elf_capital",
		character = "heleviel",
		reqs = [

		],
		text = [
			{
				text = "SACRED_SAP_HELEVIEL_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "hara_scales_quest",
						stage = "bring_sap"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	sacred_sap_erlen_start = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "erlen",
		text = [
			{
				text = "SACRED_SAP_ERLEN_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_erlen_1",
				text = "SACRED_SAP_ERLEN_START_OPT1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "sacred_sap_erlen_1",
				text = "SACRED_SAP_ERLEN_START_OPT2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_erlen_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "erlen",
		text = [
			{
				text = "SACRED_SAP_ERLEN_1_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "SACRED_SAP_ERLEN_1_REPLY2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "SACRED_SAP_ERLEN_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_lira_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_lira_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lira",
		text = [
			{
				text = "SACRED_SAP_LIRA_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_lira_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_lira_2 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lira",
		text = [
			{
				text = "SACRED_SAP_LIRA_2",
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
						value = "hara_scales_quest",
						stage = "l_price"
					},
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					},
					{
						code = "add_timed_event",
						value = "sacred_sap_intermission_start",
						args = [
							{
								type = "add_to_hour",
								hour = [
									1,
									1
								]
							}
						]
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	sacred_sap_lira_3 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lira",
		text = [
			{
				text = "SACRED_SAP_LIRA_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_lira_4",
				text = "SACRED_SAP_LIRA_3_OPT1",
				reqs = [
					{
						type = "has_material",
						operant = "gte",
						value = 1000,
						material = "wood"
					},
					{
						type = "has_material",
						operant = "gte",
						value = 100,
						material = "steel"
					}
				],
				dialogue_argument = 0,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "material_change",
						operant = "-",
						material = "wood",
						value = 1000
					},
					{
						code = "material_change",
						operant = "-",
						material = "steel",
						value = 100
					}
				],
				not_hide = true
			},
			{
				code = "close",
				text = "SACRED_SAP_LIRA_3_OPT2",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_lira_4 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lira",
		text = [
			{
				text = "SACRED_SAP_LIRA_4",
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
						value = "hara_scales_quest",
						stage = "bring_sap"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	sacred_sap_intermission_start = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "demon_female",
		character2 = "zephyras_sister",
		text = [
			{
				text = "SACRED_SAP_INTERMISSION_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "sacred_sap_intermission_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	sacred_sap_intermission_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "demon_female",
		character2 = "zephyras_sister",
		text = [
			{
				text = "SACRED_SAP_INTERMISSION_1",
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
						code = "screen_black_transition",
						value = 1
					}
				]
			}
		]
	},
	dking2task_hara_8 = {
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_8",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dking2task_hara_9",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 0
			}
		]
	},
	dking2task_hara_9 = {
		tags = [
			"dialogue_scene"
		],
		character = "hara",
		character2 = "kuro",
		reqs = [

		],
		text = [
			{
				text = "DKING2TASK_HARA_9",
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
				bonus_effects = [
					{
						code = "make_quest_location",
						value = "quest_molten_grounds"
					},
					{
						code = "progress_quest",
						value = "hara_scales_quest",
						stage = "get_cap"
					}
				]
			}
		]
	},
	capacitor_molten_start = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "zephyras_sister",
		text = [
			{
				text = "CAPACITOR_MOLTEN_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "capacitor_molten_z_1",
				text = "CAPACITOR_MOLTEN_START_OPT1",
				reqs = [
					{
						type = "location_has_specific_slaves",
						check = true,
						value = 1,
						location = 'quest_molten_grounds',
						reqs = [
							{
								code = 'unique',
								value = 'zephyra'
							}
						]
					}
				],
				dialogue_argument = 0,
				type = "next_dialogue"
			},
			{
				code = "capacitor_molten_k_1",
				text = "CAPACITOR_MOLTEN_START_OPT2",
				reqs = [

				],
				dialogue_argument = 0,
				type = "next_dialogue"
			}
		]
	},
	capacitor_molten_z_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "zephyras_sister",
		character2 = "zephyra",
		text = [
			{
				text = "CAPACITOR_MOLTEN_Z_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "capacitor_molten_z_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		]
	},
	capacitor_molten_z_2 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "zephyras_sister",
		character2 = "zephyra",
		text = [
			{
				text = "CAPACITOR_MOLTEN_Z_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "capacitor_molten_z_3",
				text = "CAPACITOR_MOLTEN_Z_2_OPT1",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			},
			{
				code = "close",
				text = "CAPACITOR_MOLTEN_Z_2_OPT2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		]
	},
	capacitor_molten_z_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character2 = "zephyra",
		text = [
			{
				text = "CAPACITOR_MOLTEN_Z_3",
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
				type = "next_dialogue",
				dialogue_argument = 0,
				bonus_effects = [
					{
						code = "progress_quest",
						value = "hara_scales_quest",
						stage = "bring_cap"
					},
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					}
				]
			}
		]
	},
	capacitor_molten_k_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "zephyras_sister",
		character2 = "kuro",
		text = [
			{
				text = "CAPACITOR_MOLTEN_K_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "capacitor_molten_k_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 0
			}
		]
	},
	capacitor_molten_k_2 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "zephyras_sister",
		character2 = "kuro",
		text = [
			{
				text = "CAPACITOR_MOLTEN_K_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "capacitor_molten_k_3",
				text = "CAPACITOR_MOLTEN_K_2_OPT1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "capacitor_molten_k_3",
				text = "CAPACITOR_MOLTEN_K_2_OPT2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "capacitor_molten_k_3",
				text = "CAPACITOR_MOLTEN_K_2_OPT3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	capacitor_molten_k_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character2 = "kuro",
		text = [
			{
				text = "CAPACITOR_MOLTEN_K_3_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "CAPACITOR_MOLTEN_K_3_REPLY2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "CAPACITOR_MOLTEN_K_3_REPLY3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "CAPACITOR_MOLTEN_K_3",
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
						value = "hara_scales_quest",
						stage = "bring_cap"
					},
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "+"
					}
				]
			}
		]
	},
	dking2task_hara_10 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "hara",
		text = [
			{
				text = "DKING2TASK_HARA_10",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "dwarf_workshop",
				text = "DIALOGUEWALKAWAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "hara_scales_quest",
						stage = "next_day"
					},
					{
						code = "add_timed_event",
						value = {
							quest = "hara_scales_quest",
							stage = "visit"
						},
						args = [
							{
								type = "action_to_date",
								date = [
									1,
									1
								],
								hour = 1,
								action = "quest"
							}
						]
					}
				]
			}
		]
	},
	dking2task_kuro_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		custom_background = "kuro_book_0_0",
		text = "DKING2TASK_KURO_1",
		options = [
			{
				code = "dking2task_kuro_2",
				text = "DKING2TASK_KURO_1_OPT1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "dking2task_kuro_2",
				text = "DKING2TASK_KURO_1_OPT2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	dking2task_kuro_2 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		custom_background = "kuro_book_0_0",
		text = [
			{
				text = "DKING2TASK_KURO_2_REPLY1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "DKING2TASK_KURO_2_REPLY2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "DKING2TASK_KURO_2_REPLY3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "dking2task_kuro_2",
				text = "DKING2TASK_KURO_2_OPT1",
				reqs = [

				],
				dialogue_argument = 3
			},
			{
				code = "dking2task_kuro_3",
				text = "DKING2TASK_KURO_2_OPT2",
				reqs = [

				],
				type = "next_dialogue"
			}
		]
	},
	dking2task_kuro_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		custom_background = "kuro_book_0_0",
		text = "DKING2TASK_KURO_3",
		options = [
			{
				code = "dwarf_workshop",
				text = "DIALOGUEWALKAWAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	kuro_questions = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		custom_background = "kuro_book_0_0",
		text = [
			{
				text = "KURO_QUESTIONS_REPLAY_SIDE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_QUESTIONS_REPLAY_PLAN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_QUESTIONS_REPLAY_ZEPH",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO_QUESTIONS_REPLAY_POWER",
				reqs = [

				],
				previous_dialogue_option = 4
			},
			{
				text = "KURO_QUESTIONS_REPLAY_LIKE",
				reqs = [

				],
				previous_dialogue_option = 5
			},
			{
				text = "KURO_QUESTIONS_REPLAY_RED",
				reqs = [

				],
				previous_dialogue_option = 6
			},
			{
				text = "KURO_QUESTIONS_HAS",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_QUESTIONS_NO",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "eq",
						value = 0,
						check = true
					},
					{
						type = "active_quest_stage",
						value = "hara_scales_quest",
						stage = "next_day",
						state = false
					}
				]
			},
			{
				text = "KURO_QUESTIONS_END",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "eq",
						value = 0,
						check = true
					},
					{
						type = "active_quest_stage",
						value = "hara_scales_quest",
						stage = "next_day"
					}
				]
			}
		],
		options = [
			{
				code = "kuro_questions",
				text = "KURO_QUESTIONS_OPT_SIDE",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "gt",
						value = 0,
						check = true
					}
				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "-"
					}
				],
				remove_after_first_use = true
			},
			{
				code = "kuro_questions",
				text = "KURO_QUESTIONS_OPT_PLAN",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "gt",
						value = 0,
						check = true
					},
					{
						type = "dialogue_seen",
						check = true,
						value = "KURO_QUESTIONS_REPLAY_SIDE"
					}
				],
				dialogue_argument = 2,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "-"
					}
				],
				remove_after_first_use = true
			},
			{
				code = "kuro_questions",
				text = "KURO_QUESTIONS_OPT_ZEPH",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "gt",
						value = 0,
						check = true
					}
				],
				dialogue_argument = 3,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "-"
					}
				],
				remove_after_first_use = true
			},
			{
				code = "kuro_questions",
				text = "KURO_QUESTIONS_OPT_POWER",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "gt",
						value = 0,
						check = true
					}
				],
				dialogue_argument = 4,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "-"
					}
				],
				remove_after_first_use = true
			},
			{
				code = "kuro_questions",
				text = "KURO_QUESTIONS_OPT_LIKE",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "gt",
						value = 0,
						check = true
					}
				],
				dialogue_argument = 5,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "-"
					}
				],
				remove_after_first_use = true
			},
			{
				code = "kuro_questions",
				text = "KURO_QUESTIONS_OPT_RED",
				reqs = [
					{
						type = "local_counter",
						name = "kuros_questions",
						operant = "gt",
						value = 0,
						check = true
					},
					{
						type = "dialogue_seen",
						check = true,
						value = "CAPACITOR_MOLTEN_START"
					}
				],
				dialogue_argument = 6,
				bonus_effects = [
					{
						code = "dialogue_counter",
						name = "kuros_questions",
						op = "-"
					}
				],
				remove_after_first_use = true
			},
			{
				code = "dwarf_workshop",
				text = "DIALOGUENEVERMIND",
				reqs = [
					{
						type = "dialogue_seen",
						check = false,
						value = "KURO_QUESTIONS_END"
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "dialogue_seen",
						check = true,
						value = "KURO_QUESTIONS_END"
					}
				],
				type = "next_dialogue"
			}
		]
	}
}
