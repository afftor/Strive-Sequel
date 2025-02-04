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
		tags = [
			"dialogue_scene"
		],
		character = 'kuro',
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
		character = 'kuro',
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
				tags = [
					"dialogue_scene"
				],
				character = 'kuro',
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
		character = 'kuro',
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
		character = 'kuro',
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
	kuro_hideout_medium = {
		reqs = [

		],
		common_effects = [
			{
				code = "remove_quest_location",
				value = "quest_cult_hideout"
			}
		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_medium2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_medium2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_medium3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_medium3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_medium4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_medium4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				change_dialogue_type = 2,
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX",
				reqs = [

				]
			},
			{
				text = "KURO_HIDEOUT_SEX_SKIP",
				reqs = [
					{
						type = "decision",
						value = "KuroSkippedSex",
						check = true
					}
				]
			},
			{
				text = "KURO_HIDEOUT_SEX_NOSKIP",
				reqs = [
					{
						type = "decision",
						value = "KuroSkippedSex",
						check = false
					}
				]
			},
		],
		options = [
			{
				code = "kuro_hideout_reply_strug",
				text = "KURO_HIDEOUT_OPT_STRUG",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_hideout_sex2",
				text = "KURO_HIDEOUT_OPT_GIVEIN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_hideout_reply_strug = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		text = [
			{
				text = "KURO_HIDEOUT_REPLY_STRUG",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_refuse",
				text = "KURO_HIDEOUT_OPT_STRUG2",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_hideout_sex2",
				text = "KURO_HIDEOUT_OPT_GIVEIN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_hideout_refuse = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		text = [
			{
				text = "KURO_HIDEOUT_REFUSE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				change_dialogue_type = 1,
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "kuro_hideout",
		dialogue_type = 2,
		text = [
			{
				text = "KURO_HIDEOUT_SEX2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex6",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex7",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_5",
		text = [
			{
				text = "KURO_HIDEOUT_SEX7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_back_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "return_to_mansion"
			},
			{
				code = "remove_quest_location",
				value = "quest_cult_parentbase"
			},
			{
				code = 'affect_unique_character',
				name = 'kuro',
				type = 'set_availability',
				value = true
			}
		],
		character = "kuro",
		dialogue_type = 1,
		text = [
			{
				text = "KURO_BACK_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start2",
				text = "KURO_BACK_OPT_WHAT",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_back_start2",
				text = "KURO_BACK_OPT_DESERVE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_BACK_OPT_SILENT",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "kuro_errand_quest"
					}
				]
			},
		]
	},
	kuro_back_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_BACK_START2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_back_start3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_BACK_START3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

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
		character = "kuro",
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
		character = "kuro",
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
					}
				]
			}
		]
	},
	#kuro_mansion events not in use! Obsolete. Replaced with kuro_back events.
	kuro_mansion_arrive = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "return_to_mansion"
			},
			{
				code = "remove_quest_location",
				value = "quest_cult_parentbase"
			},
			{
				code = 'affect_unique_character',
				name = 'kuro',
				type = 'set_availability',
				value = true
			}
		],
		character = "kuro",
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
		character = "kuro",
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
		character = "kuro",
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
		character = "kuro",
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
					}
				]
			}
		]
	},
}
