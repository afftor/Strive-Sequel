extends Reference
var data = {
	jean_sidequest_start = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_START_1",
		options = [
			{
				code = "jean_sidequest_start_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_start_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_START_2",
		options = [
			{
				code = "jean_sidequest_start_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_start_3 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_START_3",
		options = [
			{
				code = "jean_sidequest_response",
				text = "JEAN_SIDEQUEST_REQUEST_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_response",
				text = "JEAN_SIDEQUEST_REQUEST_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_response",
				text = "JEAN_SIDEQUEST_REQUEST_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_response = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RESPONSE_12",
				reqs = [

				],
				previous_dialogue_option = [
					1,
					2
				]
			},
			{
				text = "JEAN_SIDEQUEST_RESPONSE_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "JEAN_SIDEQUEST_RESPONSE_COMMON",
				reqs = [

				],
				previous_dialogue_option = [
					1,
					2,
					3
				]
			},
			{
				text = "JEAN_SIDEQUEST_DECISION_QUESTION",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "jean_sidequest_accept",
				text = "JEAN_SIDEQUEST_DECISION_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_question",
				text = "JEAN_SIDEQUEST_DECISION_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sidequest_accept",
				text = "JEAN_SIDEQUEST_DECISION_OPTION_3",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_question = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_QUESTION",
		options = [
			{
				code = "jean_sidequest_response",
				text = "JEAN_SIDEQUEST_QUESTION_OPTION",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_accept = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_CLOSE_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_CLOSE_2",
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
						value = "jean_first_sidequest",
						stage = "capital"
					}
				]
			}
		]
	},
	jean_sidequest_capital_start = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_CAPITAL_START",
		options = [
			{
				code = "jean_sidequest_capital_library",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_capital_library = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_CAPITAL_LIBRARY",
		options = [
			{
				code = "jean_sidequest_capital_guard",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_capital_guard = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_CAPITAL_GUARD",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_CAPITAL_GUARD_RETURN",
				reqs = [

				]
			},
			{
				text = "JEAN_SIDEQUEST_GUARD_REFUSE_5",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sidequest_capital_entry",
				text = "JEAN_SIDEQUEST_GUARD_OPTION_1",
				reqs = [
					{
						type = "has_money",
						value = 500
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 500
					}
				]
			},
			{
				code = "jean_sidequest_capital_entry",
				text = "JEAN_SIDEQUEST_GUARD_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_capital_refuse_1",
				text = "JEAN_SIDEQUEST_GUARD_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "close",
				text = "JEAN_SIDEQUEST_GUARD_OPTION_4",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_first_sidequest",
						stage = "capital_1"
					}
				]
			}
		]
	},
	jean_sidequest_capital_refuse_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_GUARD_REFUSE_1",
		options = [
			{
				code = "jean_sidequest_capital_refuse_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_capital_refuse_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_GUARD_REFUSE_2",
		options = [
			{
				code = "jean_sidequest_capital_refuse_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_capital_refuse_3 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_GUARD_REFUSE_3",
		options = [
			{
				code = "jean_sidequest_capital_refuse_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_capital_refuse_4 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_GUARD_REFUSE_4",
		options = [
			{
				code = "jean_sidequest_capital_guard",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_capital_entry = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_GUARD_ENTRY_BRIBE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_GUARD_ENTRY_MELCHOR",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sidequest_library_inside_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_library_inside_1 = {
		image = "jean_librarian",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_LIBRARY_INSIDE_1",
		options = [
			{
				code = "jean_sidequest_library_inside_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_library_inside_2 = {
		image = "jean_librarian",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_LIBRARY_INSIDE_2",
		options = [
			{
				code = "jean_sidequest_library_address_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_library_address_1 = {
		image = "jean_librarian",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_LIBRARY_ADDRESS_1",
		options = [
			{
				code = "jean_sidequest_library_address_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_library_address_2 = {
		image = "jean_librarian",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_LIBRARY_ADDRESS_2",
		options = [
			{
				code = "jean_sidequest_library_note",
				text = "JEAN_SIDEQUEST_LIBRARY_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_library_note",
				text = "JEAN_SIDEQUEST_LIBRARY_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_bargain"
					}
				]
			}
		]
	},
	jean_sidequest_library_note = {
		image = "jean_librarian",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_LIBRARY_NOTE_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_LIBRARY_NOTE_2",
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
						value = "jean_first_sidequest",
						stage = "mansion"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sidequest_mansion_start_1 = {
		image = "jean_beggar",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_START_1",
		options = [
			{
				code = "jean_sidequest_mansion_start_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_start_2 = {
		image = "jean_beggar",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_MANSION_START_2",
				reqs = [

				],
				previous_dialogue_option = [
					0,
					1
				]
			},
			{
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_FAIL",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sidequest_mansion_beggar",
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_OPTION_1",
				reqs = [
					{
						type = "has_item_with_tag",
						value = "alcohol"
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				not_hide = true,
				select_item = true,
				item_reqs = [
					{
						code = "tag",
						value = "alcohol"
					}
				]
			},
			{
				code = "jean_sidequest_mansion_beggar",
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_OPTION_2",
				reqs = [
					{
						type = "has_money",
						value = 100
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue",
				not_hide = true,
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 100
					}
				]
			},
			{
				code = "jean_sidequest_mansion_beggar",
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_OPTION_3",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "gte",
								value = 4
							}
						]
					},
					{
						type = "event_seen",
						check = false,
						value = "jean_sidequest_mansion_beggar_fail"
					}
				],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_mansion_start_2",
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_OPTION_3",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "lt",
								value = 4
							}
						]
					},
					{
						type = "event_seen",
						check = false,
						value = "jean_sidequest_mansion_beggar_fail"
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_first_sidequest",
						stage = "mansion_1"
					}
				]
			}
		]
	},
	jean_sidequest_mansion_beggar = {
		image = "jean_beggar",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_PAY",
				reqs = [

				],
				previous_dialogue_option = [
					1,
					2
				]
			},
			{
				text = "JEAN_SIDEQUEST_MANSION_BEGGAR_THREAT",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sidequest_mansion_lock",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_lock = {
		image = "jean_mansion",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_LOCK",
		options = [
			{
				code = "jean_sidequest_mansion_front",
				text = "JEAN_SIDEQUEST_MANSION_LOCK_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_mansion_window",
				text = "JEAN_SIDEQUEST_MANSION_LOCK_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_front = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_FRONT",
		options = [
			{
				code = "jean_sidequest_mansion_enter_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_door"
					}
				]
			}
		]
	},
	jean_sidequest_mansion_window = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_WINDOW",
		options = [
			{
				code = "jean_sidequest_mansion_enter_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_window"
					}
				]
			}
		]
	},
	jean_sidequest_mansion_enter_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_ENTER_1",
		options = [
			{
				code = "jean_sidequest_mansion_enter_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_enter_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_ENTER_2",
		options = [
			{
				code = "jean_sidequest_mansion_golems_start",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_door",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_mansion_window_noise",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_window",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_golems_start = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_GOLEMS_1",
		options = [
			{
				code = "jean_sidequest_mansion_golems_15",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_golems_15 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_GOLEMS_15",
		options = [
			{
				code = "quest_fight",
				args = "jean_golems_door",
				text = "DIALOGUEFIGHTOPTION",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	jean_sidequest_mansion_golems_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_GOLEMS_2",
		options = [
			{
				code = "quest_fight",
				args = "jean_golems_door_2",
				text = "DIALOGUEFIGHTOPTION",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	jean_sidequest_mansion_window_noise = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_WINDOW_NOISE_1",
		options = [
			{
				code = "jean_sidequest_mansion_window_noise_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_window_noise_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_MANSION_WINDOW_NOISE_2",
		options = [
			{
				code = "quest_fight",
				args = "jean_golems_window_1",
				text = "JEAN_SIDEQUEST_MANSION_HELP_OPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_window_help"
					}
				]
			},
			{
				code = "jean_sidequest_mansion_wait_fight",
				text = "JEAN_SIDEQUEST_MANSION_WAIT_OPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_window_wait"
					}
				]
			}
		]
	},
	jean_sidequest_mansion_wait_fight = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_MANSION_WAIT_FIGHT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "jean_golems_window_2",
				text = "JEAN_SIDEQUEST_MANSION_HELP_OPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_intro_1 = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RYNN_INTRO_1",
		options = [
			{
				code = "jean_sidequest_mansion_rynn_intro_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_intro_2 = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RYNN_INTRO_1",
		options = [
			{
				code = "jean_sidequest_mansion_rynn_chat_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_chat_1 = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RYNN_CHAT_1",
		options = [
			{
				code = "jean_sidequest_mansion_rynn_chat_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_chat_2 = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RYNN_CHAT_2",
				reqs = [

				]
			},
			{
				text = "JEAN_SIDEQUEST_RYNN_HELPED",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_window_help",
						check = true
					}
				]
			},
			{
				text = "JEAN_SIDEQUEST_RYNN_HELPED_YOU",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_door",
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "jean_sidequest_mansion_rynn_chat_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_chat_3 = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RYNN_CHAT_3",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_RYNN_HISTORY",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SIDEQUEST_RYNN_BROTHER_2",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sidequest_mansion_rynn_chat_3",
				text = "JEAN_SIDEQUEST_RYNN_OPTION_1",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "jean_sidequest_mansion_rynn_brother",
				text = "JEAN_SIDEQUEST_RYNN_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "jean_sidequest_mansion_rynn_join",
				text = "JEAN_SIDEQUEST_RYNN_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_brother = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RYNN_BROTHER_1",
		options = [
			{
				code = "jean_sidequest_mansion_rynn_chat_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_mansion_rynn_join = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RYNN_JOIN",
		options = [
			{
				code = "jean_sidequest_underground_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_start = {
		image = "jean_lab",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_START",
		options = [
			{
				code = "jean_sidequest_underground_descend_1",
				text = "JEAN_SIDEQUEST_UNDERGROUND_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_underground_descend_1",
				text = "JEAN_SIDEQUEST_UNDERGROUND_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_descend_1 = {
		image = "jean_lab",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_DESCEND_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_DESCEND_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sidequest_underground_descend_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_descend_2 = {
		image = "jean_lab",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_DESCEND_COMMON",
		options = [
			{
				code = "jean_sidequest_underground_cages",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_cages = {
		image = "jean_lab",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_CAGES",
		options = [
			{
				code = "jean_sidequest_underground_circle_1",
				text = "JEAN_SIDEQUEST_UNDERGROUND_CAGES_OPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_circle_1 = {
		image = "jean_lab",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_CIRCLE_1",
		options = [
			{
				code = "jean_sidequest_underground_circle_2",
				text = "JEAN_SIDEQUEST_UNDERGROUND_CAGES_OPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_circle_2 = {
		image = "jean_lab",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_CIRCLE_2",
		options = [
			{
				code = "jean_sidequest_underground_react",
				text = "JEAN_SIDEQUEST_UNDERGROUND_CIRCLE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_underground_react",
				text = "JEAN_SIDEQUEST_UNDERGROUND_CIRCLE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_react = {
		image = "jean_lab",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_REACT_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_REACT_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sidequest_underground_book_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_book_1 = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_BOOK_1",
		options = [
			{
				code = "jean_sidequest_underground_book_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_book_2 = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_BOOK_2",
		options = [
			{
				code = "jean_sidequest_underground_shelf",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_shelf = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_FAIL_1",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_FAIL_2",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sidequest_underground_shelf_success",
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_OPTION_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "gte",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_underground_shelf",
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_OPTION_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "lt",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue",
				remove_after_first_use = true,
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_shelf_fail_1"
					}
				]
			},
			{
				code = "jean_sidequest_underground_shelf_success",
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_OPTION_2",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "wits_factor",
								operant = "gte",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_underground_shelf",
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_OPTION_2",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "wits_factor",
								operant = "lt",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 3,
				type = "next_dialogue",
				remove_after_first_use = true,
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_shelf_fail_2"
					}
				]
			},
			{
				code = "jean_sidequest_underground_shelf_jean",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_shelf_fail_1",
						check = true
					},
					{
						type = "decision",
						value = "jean_sidequest_shelf_fail_2",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_shelf_jean = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_JEAN_1",
		options = [
			{
				code = "jean_sidequest_underground_shelf_success",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_shelf_success = {
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_SUCCESS_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_SUCCESS_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_SHELF_JEAN_2",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sidequest_underground_tunnel_choice",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_tunnel_choice = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_CHOICE",
		options = [
			{
				code = "jean_sidequest_underground_tunnel_1",
				text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_tunnel"
					}
				]
			},
			{
				code = "jean_sidequest_underground_leave_1",
				text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "jean_sidequest_leave"
					}
				]
			}
		],
		image = "jean_rynn"
	},
	jean_sidequest_underground_tunnel_1 = {
		image = "jean_rynn",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_1",
		options = [
			{
				code = "jean_sidequest_underground_tunnel_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_tunnel_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_2",
		options = [
			{
				code = "quest_fight",
				args = "jean_tunnel",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_tunnel_3 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_3",
		options = [
			{
				code = "jean_sidequest_underground_tunnel_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_tunnel_4 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_4",
		options = [
			{
				code = "jean_sidequest_underground_tunnel_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_tunnel_5 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_TUNNEL_5",
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
						value = "jean_first_sidequest",
						stage = "return"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sidequest_underground_leave_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_UNDERGROUND_LEAVE_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sidequest_underground_leave_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_underground_leave_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_UNDERGROUND_LEAVE_2",
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
						value = "jean_first_sidequest",
						stage = "return"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sidequest_return_start = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RETURN_START",
		options = [
			{
				code = "jean_sidequest_return_librarian",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character = "jean"
	},
	jean_sidequest_return_librarian = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "JEAN_SIDEQUEST_RETURN_LIBRARIAN",
		options = [
			{
				code = "jean_sidequest_return_pass",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "jean_librarian"
	},
	jean_sidequest_return_pass = {
		image = "jean_librarian",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_PASS",
				reqs = [

				]
			},
			{
				text = "JEAN_SIDEQUEST_RETURN_PASS_BARGAIN",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_bargain",
						check = true
					}
				],
				bonus_effects = [
					{
						code = "money_change",
						operant = "+",
						value = 200
					}
				]
			},
			{
				text = "JEAN_SIDEQUEST_RETURN_PASS_NO_BARGAIN",
				reqs = [
					{
						type = "decision",
						value = "jean_sidequest_bargain",
						check = false
					}
				]
			}
		],
		options = [
			{
				code = "jean_sidequest_return_end_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_return_end_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_END_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sidequest_return_end_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_return_end_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_END_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sidequest_return_thanks",
				text = "JEAN_SIDEQUEST_RETURN_END_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_return_question_1",
				text = "JEAN_SIDEQUEST_RETURN_END_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_return_thanks = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_THANKS",
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
						value = "jean_first_sidequest"
					},
					{
						code = "add_timed_event",
						value = "jean_q2_start",
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
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sidequest_return_question_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_QUESTION",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sidequest_return_tease",
				text = "JEAN_SIDEQUEST_RETURN_QUESTION_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_return_question_2",
				text = "JEAN_SIDEQUEST_RETURN_QUESTION_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_return_tease = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_TEASE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sidequest_return_question_2",
				text = "JEAN_SIDEQUEST_RETURN_TEASE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sidequest_return_question_2",
				text = "JEAN_SIDEQUEST_RETURN_TEASE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sidequest_return_question_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SIDEQUEST_RETURN_TRUST",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SIDEQUEST_RETURN_TEASE_RESPONSE",
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
						code = "complete_quest",
						value = "jean_first_sidequest"
					},
					{
						code = "add_timed_event",
						value = "jean_q2_start",
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
					},
					{
						code = "update_city"
					}
				]
			}
		]
	}
}