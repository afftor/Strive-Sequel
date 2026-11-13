extends Reference
var data = {
	kuro_church_start = {
		reqs = [

		],
		common_effects = [
			{
				code = 'affect_unique_character',
				name = 'kuro',
				type = 'set_availability',
				value = false
			}
		],
		tags = [
			"dialogue_scene"
		],
		image = "letter",
		text = [
			{
				text = "KURO_CHURCH_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_errand_quest",
						stage = "church"
					}
				]
			}
		]
	},
	kuro_church_note = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = 'ginny',
		text = [
			{
				text = "KURO_CHURCH_NOTE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_church_note2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_church_note2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = 'ginny',
		text = [
			{
				text = "KURO_CHURCH_NOTE2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_church_note3",
				text = "KURO_CHURCH_OPT_WARNING",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_church_note3",
				text = "KURO_CHURCH_OPT_PRANK",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_church_note3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = 'ginny',
		text = [
			{
				text = "KURO_CHURCH_NOTE3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_errand_quest",
						stage = "invite"
					},
					{
						code = "make_quest_location",
						value = "quest_cult_hideout"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	kuro_hideout_start = {
		reqs = [

		],
		music = "kuro_theme",
		tags = [
			"dialogue_scene"
		],
		character = '$kuro',
		start_dialogue_option = 9,
		text = [
			{
				text = "KURO_HIDEOUT_START",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_HIDEOUT_REPLY_WHYHERE",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "kuro_hideout_start",
				text = "KURO_HIDEOUT_OPT_WHYHERE",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_hideout_start2",
				text = "KURO_HIDEOUT_OPT_SURE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "decision",
						value = "KuroInHideout"
					}
				]
			},
			{
				code = "kuro_hideout_start2",
				text = "KURO_HIDEOUT_OPT_NOT",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_hideout_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = '$kuro',
		text = [
			{
				text = "KURO_HIDEOUT_REPLY_SURE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_HIDEOUT_REPLY_NOT",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "kuro_hideout_start3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_start3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO_HIDEOUT_START3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "kuro_cult_hideout",
				text = "DIALOGUEFIGHTOPTION",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_win = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "KuroInHideout",
						check = true
					}
				],
				music = "kuro_theme",
				tags = [
					"dialogue_scene"
				],
				character = '$kuro',
				common_effects = [
					{
						code = "remove_decision",
						value = "KuroInHideout"
					}
				],
				text = [
					{
						text = "KURO_HIDEOUT_FINISH",
						reqs = [

						]
					},
					{
						text = "KURO_HIDEOUT_FINISH_KURO",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "kuro_hideout_reply_behind",
						text = "KURO_HIDEOUT_OPT_BEHIND",
						dialogue_argument = 9,
						type = "next_dialogue",
						reqs = [

						],
						select_person = true,
						person_reqs = [{code = "is_master", check = true, silent = true}],
						challenge = "wisdom",
						not_hide = true
					},
					{
						code = "kuro_hideout_reply_key",
						text = "KURO_HIDEOUT_OPT_KEY",
						dialogue_argument = 9,
						type = "next_dialogue",
						reqs = [

						]
					},
				]
			},
			{
				reqs = [
					{
						type = "decision",
						value = "KuroInHideout",
						check = false
					}
				],
				music = "kuro_theme",
				tags = [
					"dialogue_scene"
				],
				common_effects = [
					{
						code = "add_special_task_for_location",
						location = 'quest_cult_hideout',
						amount = 4,
						descript = "KUROHIDEOUTTASKDESCRIPT",
						name = "KUROHIDEOUTTASKNAME",
						max_workers = 4,
						icon = 'res://assets/Textures_v2/MANSION/quest_task.png',
						args = [
							{
								code = 'start_event',
								data = 'kuro_hideout_search',
								args = {}
							}
						]
					}
				],
				text = [
					{
						text = "KURO_HIDEOUT_FINISH",
						reqs = [

						]
					},
					{
						text = "KURO_HIDEOUT_CLUES",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "close",
						text = "DIALOGUECLOSE",
						dialogue_argument = 9,
						type = "next_dialogue",
						reqs = [

						],
						bonus_effects = [
							{
								code = "progress_quest",
								value = "kuro_errand_quest",
								stage = "search"
							}
						]
					}
				]
			},
		]
	},
	kuro_hideout_reply_behind = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = '$kuro',
		common_effects = [
			{
				code = "add_special_task_for_location",
				location = 'quest_cult_hideout',
				amount = 2,
				descript = "KUROHIDEOUTTASKDESCRIPT",
				name = "KUROHIDEOUTTASKNAME",
				max_workers = 4,
				icon = 'res://assets/Textures_v2/MANSION/quest_task.png',
				args = [
					{
						code = 'start_event',
						data = 'kuro_hideout_search',
						args = {}
					}
				]
			}
		],
		text = [
			{
				text = "KURO_HIDEOUT_REPLY_BEHIND",
				reqs = [

				]
			},
			{
				text = "KURO_HIDEOUT_CLUES",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_errand_quest",
						stage = "search"
					}
				]
			}
		]
	},
	kuro_hideout_reply_key = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = '$kuro',
		common_effects = [
			{
				code = "add_special_task_for_location",
				location = 'quest_cult_hideout',
				amount = 4,
				descript = "KUROHIDEOUTTASKDESCRIPT",
				name = "KUROHIDEOUTTASKNAME",
				max_workers = 4,
				icon = 'res://assets/Textures_v2/MANSION/quest_task.png',
				args = [
					{
						code = 'start_event',
						data = 'kuro_hideout_search',
						args = {}
					}
				]
			}
		],
		text = [
			{
				text = "KURO_HIDEOUT_REPLY_KEY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_errand_quest",
						stage = "search"
					}
				]
			}
		]
	},
	kuro_hideout_search = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO_HIDEOUT_SEARCH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_errand_quest",
						stage = "base"
					},
					{
						code = "make_quest_location",
						value = "quest_cult_parentbase"
					}
				]
			}
		]
	},
	kuro_back_start4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_BACK_START4",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_BACK_REPLY_STRONG",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_BACK_REPLY_USEFUL",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_BACK_REPLY_LIKE",
				reqs = [

				],
				previous_dialogue_option = 3
			},
		],
		options = [
			{
				code = "kuro_back_start4",
				text = "KURO_BACK_OPT_STRONG",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_back_start4",
				text = "KURO_BACK_OPT_USEFUL",
				dialogue_argument = 2,
				reqs = [

				]
			},
			{
				code = "kuro_back_start4",
				text = "KURO_BACK_OPT_LIKE",
				dialogue_argument = 3,
				reqs = [

				]
			},
			{
				code = "kuro_back_end",
				text = "KURO_BACK_OPT_ALL",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [
					{
						type = 'dialogue_seen',
						check = true,
						value = 'KURO_BACK_REPLY_STRONG'
					},
					{
						type = 'dialogue_seen',
						check = true,
						value = 'KURO_BACK_REPLY_USEFUL'
					},
					{
						type = 'dialogue_seen',
						check = true,
						value = 'KURO_BACK_REPLY_LIKE'
					}
				]
			},
			{
				code = "kuro_back_end",
				text = "KURO_BACK_OPT_NO_IDEA",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_back_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_BACK_REPLY_ALL",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_BACK_REPLY_NO_IDEA",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "kuro_errand_quest"
					},
					{
						code = 'add_timed_event', value = "kuro3_init_1", args = [{type = 'add_to_date', date = [3, 3], hour = 1}]
					}
				]
			}
		]
	},
	#kuro_mansion events not in use! Obsolete. Replaced with kuro_back events.
	kuro_mansion_arrive = {
		reqs = [

		],
		music = "kuro_theme",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "set_completed_active_location"
			},
			{
				code = "return_to_mansion"
			},
#			{
#				code = "remove_quest_location",
#				value = "quest_cult_parentbase"
#			},
			{
				code = 'affect_unique_character',
				name = 'kuro',
				type = 'set_availability',
				value = true
			}
		],
		character = "$kuro",
		dialogue_type = 1,
		text = [
			{
				text = "KURO_MANSION_ARRIVE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_mansion_explain",
				text = "KURO_MANSION_OPT_EXPLAIN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_mansion_end",
				text = "KURO_MANSION_OPT_NOASK",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_mansion_explain = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_MANSION_EXPLAIN",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_mansion_notkill",
				text = "KURO_MANSION_OPT_WORRY",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_mansion_end",
				text = "KURO_MANSION_OPT_UNDERSTAND",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_mansion_notkill = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_MANSION_NOTKILL",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_mansion_end",
				text = "KURO_MANSION_OPT_SENSE",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_mansion_end",
				text = "KURO_MANSION_OPT_HUMANE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_mansion_end = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_MANSION_REPLY_HUMANE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_MANSION_REPLY_UNDERSTAND",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_MANSION_QUIET",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "kuro_errand_quest"
					},
					{
						code = 'add_timed_event', value = "kuro3_init_1", args = [{type = 'add_to_date', date = [3, 3], hour = 1}]
					}
				]
			}
		]
	},
}
