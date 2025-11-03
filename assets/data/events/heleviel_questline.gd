extends Reference
var data = {
	heleviel_quest_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "heleviel",
		text = "HELEVIEL_QUEST_1",
		options = [
			{
				code = "heleviel_quest_2",
				text = "HELEVIEL_QUEST_1_OPTION_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "heleviel_quest_2",
				text = "HELEVIEL_QUEST_1_OPTION_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	heleviel_quest_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "HELEVIEL_QUEST_2_1",
				reqs = [
					{
						code = "race",
						race = "Elf",
						check = false
					}
				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_QUEST_2_1a",
				reqs = [
					{
						code = "race",
						race = "Elf",
						check = true
					}
				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_QUEST_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "HELEVIEL_QUEST_2",
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
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage1"
					},
					{
						code = "add_timed_event",
						value = "heleviel_quest_3",
						args = [
							{
								type = "add_to_hour",
								hour = [
									1,
									1
								]
							}
						]
					}
				]
			}
		],
		character = "heleviel"
	},
	heleviel_quest_3 = {
		reqs = [
			{
				type = "unique_character_checks",
				name = "heleviel",
				value = [
					{
						code = "stat",
						stat = "metrics_waitress",
						operant = "gte",
						value = 1
					}
				],
				negative = "repeat_next_turn"
			}
		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "heleviel_waitress",
		text = "HELEVIEL_QUEST_3",
		options = [
			{
				code = "heleviel_quest_4",
				text = "HELEVIEL_QUEST_3_OPTION_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "heleviel_quest_4",
				text = "HELEVIEL_QUEST_3_OPTION_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	heleviel_quest_4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "HELEVIEL_QUEST_4_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_QUEST_4_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "heleviel_quest_5",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_quest_5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_5",
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
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage2"
					},
					{
						code = "add_timed_event",
						value = "heleviel_quest_6",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 3
							}
						]
					}
				]
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_quest_6 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "heleviel_waitress",
		text = "HELEVIEL_QUEST_6",
		options = [
			{
				code = "heleviel_quest_7",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_quest_7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		text = "HELEVIEL_QUEST_7",
		options = [
			{
				code = "heleviel_quest_8",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		image = "heleviel_bar_grab"
	},
	heleviel_quest_8 = {
		image = "heleviel_bar_grab",
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_8",
		options = [
			{
				code = "heleviel_quest_9",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_quest_9 = {
		reqs = [

		],
		character = "heleviel_waitress",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_9",
		options = [
			{
				code = "heleviel_quest_10",
				text = "HELEVIEL_QUEST_9_OPTION_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "heleviel_quest_10",
				text = "HELEVIEL_QUEST_9_OPTION_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	heleviel_quest_10 = {
		image = null,
		reqs = [

		],
		character = "heleviel_waitress",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "HELEVIEL_QUEST_10_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_QUEST_10_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "heleviel_quest_11",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_quest_11 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_11",
		options = [
			{
				code = "heleviel_quest_12",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		image = "heleviel_bar"
	},
	heleviel_quest_12 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_12",
		options = [
			{
				code = "heleviel_bar_sex_1",
				text = "HELEVIEL_QUEST_12_OPTION_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "heleviel_quest_13",
				text = "HELEVIEL_QUEST_12_OPTION_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		image = "heleviel_bar"
	},
	heleviel_quest_13 = {
		image = null,
		reqs = [

		],
		character = "heleviel_waitress",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_QUEST_13",
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
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage3"
					}
				]
			}
		]
	},
	heleviel_slave_church_intro = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		character2 = "ginny",
		text = [
			{
				text = "HELEVIEL_SLAVE_CHURCH_INTRO_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_church_position",
				text = "HELEVIEL_SLAVE_CHURCH_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_church_position",
				text = "HELEVIEL_SLAVE_CHURCH_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_church_position",
				text = "HELEVIEL_SLAVE_CHURCH_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_church_position = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		character2 = "ginny",
		text = [
			{
				text = "HELEVIEL_SLAVE_CHURCH_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_SLAVE_CHURCH_REPLY_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "HELEVIEL_SLAVE_CHURCH_REPLY_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "HELEVIEL_SLAVE_CHURCH_ASSIGN_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_church_healing",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_church_healing = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_HEALING_TEXT",
		options = [
			{
				code = "heleviel_slave_church_argument",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_argument = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_ARGUMENT_TEXT",
		options = [
			{
				code = "heleviel_slave_church_argument_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_argument_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_ARGUMENT_TEXT2",
		options = [
			{
				code = "heleviel_slave_church_argument_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_argument_3 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_ARGUMENT_TEXT3",
		options = [
			{
				code = "heleviel_slave_church_foot_choice",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_foot_choice = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_FOOT_TEXT",
		options = [
			{
				code = "heleviel_slave_church_foot_response_1",
				text = "HELEVIEL_SLAVE_CHURCH_FOOT_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_church_foot_response_2",
				text = "HELEVIEL_SLAVE_CHURCH_FOOT_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_foot_response_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_FOOT_REPLY_1",
		options = [
			{
				code = "heleviel_slave_church_foot_response_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_foot_response_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_FOOT_REPLY_2",
		options = [
			{
				code = "heleviel_slave_church_poison_question",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_foot_response_3 = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_CHURCH_AFTER_FOOT",
		options = [
			{
				code = "heleviel_slave_church_poison_question",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_heal"
	},
	heleviel_slave_church_poison_question = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_CHURCH_POISON_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_church_poison_follow",
				text = "HELEVIEL_SLAVE_CHURCH_POISON_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_church_poison_follow",
				text = "HELEVIEL_SLAVE_CHURCH_POISON_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_church_poison_follow = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_CHURCH_POISON_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_SLAVE_CHURCH_POISON_REPLY_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "heleviel_slave_church_poison_follow_2",
				text = "HELEVIEL_SLAVE_CHURCH_POISON_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_church_poison_follow_2",
				text = "HELEVIEL_SLAVE_CHURCH_POISON_OPTION_4",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_church_poison_follow_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_CHURCH_POISON_REPLY",
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
				bonus_effects = [
					{
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage4"
					}
				]
			}
		]
	},
	heleviel_slave_beastkin_intro = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		character2 = "savra",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_INTRO_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_beastkin_choice",
				text = "HELEVIEL_SLAVE_BEASTKIN_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_beastkin_choice",
				text = "HELEVIEL_SLAVE_BEASTKIN_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_beastkin_choice = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		character2 = "savra",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_REPLY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_beastkin_child",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_beastkin_child = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_CHILD_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_beastkin_child_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_beastkin_child_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_CHILD_TEXT_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_beastkin_child_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_beastkin_child_3 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_BEASTKIN_CHILD_TEXT_3",
		options = [
			{
				code = "heleviel_slave_beastkin_child_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_halfkin"
	},
	heleviel_slave_beastkin_child_4 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_BEASTKIN_CHILD_TEXT_4",
		options = [
			{
				code = "heleviel_slave_beastkin_savra",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_halfkin"
	},
	heleviel_slave_beastkin_savra = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "savra",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_TEXT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_REPLY_2",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "heleviel_slave_beastkin_savra",
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_OPTION_1",
				reqs = [

				],
				dialogue_argument = 2
			},
			{
				code = "heleviel_slave_beastkin_savra",
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_OPTION_2",
				reqs = [

				],
				dialogue_argument = 3
			},
			{
				code = "heleviel_slave_beastkin_savra_response",
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_beastkin_savra_response = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "savra",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_SAVRA_REPLY_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_beastkin_return",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_beastkin_return = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_RETURN_TEXT",
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
				bonus_effects = [
					{
						code = "plan_mansion_event",
						value = "heleviel_slave_beastkin_return_2"
					},
					{
						code = "return_to_mansion"
					}
				]
			}
		]
	},
	heleviel_slave_beastkin_return_2 = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_BEASTKIN_RETURN_TEXT_2",
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
				bonus_effects = [
					{
						code = "affect_unique_character",
						name = "heleviel",
						type = "remove_trait",
						trait = "cruel"
					},
					{
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage5"
					},
					{
						code = "add_timed_event",
						value = "heleviel_slave_ritual_request",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 3
							}
						]
					}
				]
			}
		]
	},
	heleviel_slave_ritual_request = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_REQUEST_TEXT",
				reqs = [

				]
			},
			{
				text = "HELEVIEL_SLAVE_RITUAL_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_request",
				text = "HELEVIEL_SLAVE_RITUAL_OPTION_1",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "heleviel_slave_ritual_request_response",
				text = "HELEVIEL_SLAVE_RITUAL_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_ritual_request_response",
				text = "HELEVIEL_SLAVE_RITUAL_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_request_response = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_REPLY_2",
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
						value = "heleviel_slave_quest",
						stage = "stage5_2"
					}
				]
			}
		]
	},
	heleviel_slave_ritual_erlen = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "erlen",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_ERLEN_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_erlen_response",
				text = "HELEVIEL_SLAVE_RITUAL_ERLEN_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_ritual_erlen_response",
				text = "HELEVIEL_SLAVE_RITUAL_ERLEN_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_erlen_response = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "erlen",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_ERLEN_REPLY_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "HELEVIEL_SLAVE_RITUAL_ERLEN_REPLY_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_lira",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_lira = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "lira_priestess",
		text = "HELEVIEL_SLAVE_RITUAL_LIRA_TEXT",
		options = [
			{
				code = "heleviel_slave_ritual_lira_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_lira_2 = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "lira_priestess",
		text = "HELEVIEL_SLAVE_RITUAL_LIRA_TEXT_2",
		options = [
			{
				code = "heleviel_slave_ritual_pay",
				text = "HELEVIEL_SLAVE_RITUAL_PAY_OPTION",
				reqs = [
					{
						type = "has_money",
						value = 2500
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 2500
					},
					{
						code = "add_timed_event",
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
						],
						value = {
							quest = "heleviel_slave_quest",
							stage = "stage6"
						}
					},
					{
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage5_4"
					},
					{
						code = "update_city"
					},
					{
						code = "return_to_mansion"
					}
				]
			},
			{
				code = "heleviel_slave_ritual_postpone",
				text = "HELEVIEL_SLAVE_RITUAL_LATER_OPTION",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage5_3"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	heleviel_slave_ritual_pay = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lira_priestess",
		text = "HELEVIEL_SLAVE_RITUAL_PAY",
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
	heleviel_slave_ritual_postpone = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lira_priestess",
		text = "HELEVIEL_SLAVE_RITUAL_POSTPONE",
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
	heleviel_slave_ritual_pay_after = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lira_priestess",
		text = "HELEVIEL_SLAVE_RITUAL_PAY_TEXT",
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
						code = "money_change",
						operant = "-",
						value = 2500
					},
					{
						code = "add_timed_event",
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
						],
						value = {
							quest = "heleviel_slave_quest",
							stage = "stage6"
						}
					},
					{
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage5_4"
					},
					{
						code = "update_city"
					},
					{
						code = "return_to_mansion"
					}
				]
			}
		]
	},
	heleviel_slave_ritual_ceremony_intro = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_INTRO",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_mid",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "heleviel_town"
	},
	heleviel_slave_ritual_ceremony_mid = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_MID",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_freya",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_ceremony_freya = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_FREYA",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_freya_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_freya_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_FREYA_2",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_freya_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_freya_3 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_FREYA_3",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_freya_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_freya_4 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_FREYA_4",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_order",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_order = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_ORDER",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_order_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_order_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_ORDER_2",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_order_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_order_3 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_ORDER_3",
		options = [
			{
				code = "heleviel_slave_ritual_ceremony_conclusion",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lira_priestess"
	},
	heleviel_slave_ritual_ceremony_conclusion = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_CEREMONY_CONCLUSION",
		options = [
			{
				code = "heleviel_slave_ritual_interlude",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_interlude = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = "HELEVIEL_SLAVE_RITUAL_INTERLUDE",
		options = [
			{
				code = "heleviel_slave_ritual_end",
				text = "HELEVIEL_SLAVE_RITUAL_INTERLUDE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "heleviel_slave_ritual_sex_attempt",
				text = "HELEVIEL_SLAVE_RITUAL_INTERLUDE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	heleviel_slave_ritual_sex_attempt = {
		variations = [
			{
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "sexuals_factor",
								operant = "gte",
								value = 5
							}
						]
					}
				],
				character = "heleviel",
				text = [
					{
						text = "HELEVIEL_SLAVE_RITUAL_SEX_ATTEMPT_1",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "heleviel_forest_sex_1",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					}
				]
			},
			{
				tags = [
					"dialogue_scene",
					"master_translate"
				],
				reqs = [

				],
				character = "heleviel",
				text = [
					{
						text = "HELEVIEL_SLAVE_RITUAL_SEX_ATTEMPT_2",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "heleviel_slave_ritual_end",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						dialogue_argument = 1,
						type = "next_dialogue"
					}
				]
			}
		]
	},
	heleviel_slave_ritual_end = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_END_TEXT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_end_2",
				text = "HELEVIEL_SLAVE_RITUAL_END_OPTION_1",
				reqs = [

				],
				bonus_effects = [

				]
			},
			{
				code = "heleviel_slave_ritual_end_2",
				text = "HELEVIEL_SLAVE_RITUAL_END_OPTION_2",
				reqs = [

				],
				bonus_effects = [

				]
			}
		]
	},
	heleviel_slave_ritual_end_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "heleviel",
		text = [
			{
				text = "HELEVIEL_SLAVE_RITUAL_END_2",
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
				bonus_effects = [
					{
						code = "decision",
						value = "HelevielTrainingFinished"
					},
					{
						code = "unique_character_changes",
						value = "heleviel",
						args = [
							{
								code = "add_trait",
								trait = "training_s_combat"
							}
						]
					},
					{
						code = "complete_quest",
						value = "heleviel_slave_quest"
					}
				]
			}
		]
	},
	heleviel_bar_sex_1 = {
		reqs = [

		],
		unlocked_gallery_seq = "heleviel_bar_sex",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_BAR_SEX_1",
		options = [
			{
				code = "heleviel_bar_sex_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_bar_sex_2 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_BAR_SEX_2",
		options = [
			{
				code = "heleviel_bar_sex_3",
				text = "HELEVIEL_BAR_SEX_2_OPTOPN_1",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "heleviel_bar_sex_3",
				text = "HELEVIEL_BAR_SEX_2_OPTOPN_2",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_bar_sex_3 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_4",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_4 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_5",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "HELEVIEL_BAR_SEX_5",
		options = [
			{
				code = "heleviel_bar_sex_6",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_6 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_7",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_7 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_bar_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_BAR_SEX_7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_bar_sex_8",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_bar_sex_8 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_BAR_SEX_8",
		options = [
			{
				code = "close",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1,
				bonus_effects = [
					{
						code = "progress_quest",
						value = "heleviel_slave_quest",
						stage = "stage3"
					}
				]
			}
		],
		character = "heleviel_waitress"
	},
	heleviel_forest_sex_1 = {
		unlocked_gallery_seq = "heleviel_forest_sex",
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "HELEVIEL_FOREST_SEX_1",
		options = [
			{
				code = "heleviel_forest_sex_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_forest_sex_2 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_FOREST_SEX_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_forest_sex_3",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_forest_sex_3 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_FOREST_SEX_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_forest_sex_4",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_forest_sex_4 = {
		image = null,
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_forest_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "HELEVIEL_FOREST_SEX_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "heleviel_slave_ritual_end",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_1 = {
		reqs = [

		],
		unlocked_gallery_seq = "heleviel_wedding",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "HELEVIEL_WEDDING_1",
		options = [
			{
				code = "heleviel_wedding_2",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		],
		character = "heleviel"
	},
	heleviel_wedding_2 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_wed_1",
		text = "HELEVIEL_WEDDING_2",
		options = [
			{
				code = "heleviel_wedding_3",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_3 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_wed_2",
		text = "HELEVIEL_WEDDING_3",
		options = [
			{
				code = "heleviel_wedding_4",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_4 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_wed_3",
		text = "HELEVIEL_WEDDING_4",
		options = [
			{
				code = "heleviel_wedding_5",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_5 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		custom_background = "heleviel_wed_4",
		text = "HELEVIEL_WEDDING_5",
		options = [
			{
				code = "heleviel_wedding_6",
				text = "DIALOGUECONTINUE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	},
	heleviel_wedding_6 = {
		reqs = [

		],
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		custom_background = "heleviel_wed_4",
		text = "HELEVIEL_WEDDING_6",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				reqs = [

				],
				dialogue_argument = 1
			}
		]
	}
}