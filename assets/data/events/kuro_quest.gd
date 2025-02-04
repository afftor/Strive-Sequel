extends Reference
var data = {
	kuro_tome_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_TOME_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_want",
				text = "KURO_TOME_OPT_RUDE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_tome_want",
				text = "KURO_TOME_OPT_QUEEN",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_want = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_TOME_REPLY_RUDE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_TOME_REPLY_QUEEN",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_TOME_WANT",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_offer",
				text = "KURO_TOME_OPT_WHYDO",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_tome_offer",
				text = "KURO_TOME_OPT_WHATIN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_offer = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_TOME_OFFER",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_TOME_REPLY_SCOPE",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "kuro_tome_offer",
				text = "KURO_TOME_OPT_SCOPE",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_tome_handshake",
				text = "KURO_TOME_OPT_FORSURE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_tome_handshake",
				text = "KURO_TOME_OPT_FREE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_handshake = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_TOME_REPLY_FORSURE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_TOME_REPLY_FREE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_TOME_HANDSHAKE",
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
						value = "kuro_tome_quest",
						stage = "library"
					}
				]
			}
		]
	},
	kuro_lib_start = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "MAGESINTRODUCTION3_2",
		options = [
			{
				code = "kuro_lib_start2",
				text = "KURO_LIB_OPT_ACCESS",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "KURO_LIB_START",
		options = [
			{
				code = "kuro_lib_myaran",
				text = "KURO_LIB_OPT_AGREE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_lib_myaran",
				text = "KURO_LIB_OPT_RACIST",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_lib_myaran",
				text = "KURO_LIB_OPT_VOUCH",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_myaran = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = [
			{
				text = "KURO_LIB_REPLY_AGREE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_LIB_REPLY_RACIST",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_LIB_REPLY_VOUCH",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO_LIB_MYARAN",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_lib_access",
				text = "KURO_LIB_OPT_GOTMONEY",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [
					{
						type = "has_money",
						value = 500
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 500
					}
				]
			},
			{
				code = "close",
				text = "KURO_LIB_OPT_LATER",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_tome_quest",
						stage = "money"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	kuro_lib_return = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "MAGESINTRODUCTION3_2",
		options = [
			{
				code = "kuro_lib_access",
				text = "KURO_LIB_OPT_BROUGHTMONEY",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [
					{
						type = "has_money",
						value = 500
					}
				],
				not_hide = true,
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 500
					}
				]
			},
			{
				code = "close",
				text = "KURO_LIB_OPT_LATER",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_access = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "KURO_LIB_ACCESS",
		options = [
			{
				code = "kuro_lib_access2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_access2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "KURO_LIB_ACCESS2",
		options = [
			{
				code = "kuro_lib_access3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_access3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_LIB_ACCESS3",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_LIB_REPLY_WHAT",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "kuro_lib_access3",
				text = "KURO_LIB_OPT_WHAT",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_LIB_OPT_FREETIME",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_tome_quest",
						stage = "capital"
					},
					{
						code = "update_guild"
					}
				]
			},
			{
				code = "close",
				text = "KURO_LIB_OPT_CAPITAL",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_tome_quest",
						stage = "capital"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	kuro_whiskey_market = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO_WHISKEY_MARKET",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_market2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_market2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_MARKET2",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_WHISKEY_REPLY_WASTE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_WHISKEY_REPLY_SPECIAL",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "kuro_whiskey_market2",
				text = "KURO_WHISKEY_OPT_WASTE",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_market2",
				text = "KURO_WHISKEY_OPT_SPECIAL",
				dialogue_argument = 2,
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_WHISKEY_OPT_FINE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_tome_quest",
						stage = "carriage"
					},
					{
						code = "make_quest_location",
						value = "quest_whisky_crash"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	kuro_whiskey_crash = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_CRASH",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_crash2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_crash2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_CRASH2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_reply_hand",
				text = "KURO_WHISKEY_OPT_HAND",
				dialogue_argument = 9,
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_reply_feelwaste",
				text = "KURO_WHISKEY_OPT_FEELWASTE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_reply_hand = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = "KURO_WHISKEY_REPLY_HAND",
		options = [
			{
				code = "kuro_whiskey_reply_hand",
				text = "KURO_WHISKEY_OPT_HAND",
				dialogue_argument = 9,
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_reply_mean",
				text = "KURO_WHISKEY_OPT_MEAN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				select_person = true,
				challenge = "persuasion",
				not_hide = true
			},
			{
				code = "kuro_whiskey_reply_feelwaste",
				text = "KURO_WHISKEY_OPT_FEELWASTE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_reply_mean = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_REPLY_MEAN",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_dig",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_reply_feelwaste = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_REPLY_FEELWASTE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_dig",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_dig = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_DIG",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_dig2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_dig2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "bandits",
		text = [
			{
				text = "KURO_WHISKEY_DIG2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_dig3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_dig3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "bandits",
		text = [
			{
				text = "KURO_WHISKEY_DIG3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_dig4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_dig4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "bandits",
		text = [
			{
				text = "KURO_WHISKEY_DIG4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_dig5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_dig5 = {
		reqs = [

		],
		common_effects = [
			{
				code = "play_sound",
				value = "crash"
			}
		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_DIG5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_bottle",
				text = "KURO_WHISKEY_OPT_BLAME",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_bottle",
				text = "KURO_WHISKEY_OPT_RUINED",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_bottle",
				text = "KURO_WHISKEY_OPT_IDEAS",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_bottle = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_REPLY_BLAME",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO_WHISKEY_REPLY_RUINED",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO_WHISKEY_REPLY_IDEAS",
				reqs = [

				],
				previous_dialogue_option = [
					1,
					2,
					3
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
						value = "kuro_tome_quest",
						stage = "bottle"
					}
				]
			}
		]
	},
	kuro_whiskey_homebrew = {
		reqs = [

		],
		common_effects = [
			{
				code = "remove_quest_location",
				value = "quest_whisky_crash"
			}
		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_HOMEBREW",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_reply_authentic",
				text = "KURO_WHISKEY_OPT_AUTHENTIC",
				dialogue_argument = 9,
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_reply_poison",
				text = "KURO_WHISKEY_OPT_POISON",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_reply_authentic = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_REPLY_AUTHENTIC",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_whiskey_reply_authentic",
				text = "KURO_WHISKEY_OPT_AUTHENTIC",
				dialogue_argument = 9,
				reqs = [

				]
			},
			{
				code = "kuro_whiskey_reply_poison",
				text = "KURO_WHISKEY_OPT_POISON",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_whiskey_reply_poison = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_WHISKEY_REPLY_POISON",
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
						value = "kuro_tome_quest",
						stage = "back"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	kuro_lib_whiskey = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "MAGESINTRODUCTION3_2",
		options = [
			{
				code = "kuro_lib_whiskey2",
				text = "KURO_LIB_OPT_WHISKEY",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_whiskey2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "KURO_LIB_WHISKEY2",
		options = [
			{
				code = "kuro_lib_whiskey3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_whiskey3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		character2 = "myr",
		text = "KURO_LIB_WHISKEY3",
		options = [
			{
				code = "kuro_lib_whiskey4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_lib_whiskey4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_LIB_WHISKEY4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_lib_reply_work",
				text = "KURO_LIB_OPT_WORK",
				dialogue_argument = 9,
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_LIB_OPT_HOME",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_tome_quest",
						stage = "talk"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	kuro_lib_reply_work = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_LIB_REPLY_WORK",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_lib_reply_work",
				text = "KURO_LIB_OPT_WORK",
				dialogue_argument = 9,
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_LIB_OPT_HOME",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "progress_quest",
						value = "kuro_tome_quest",
						stage = "talk"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	kuro_tome_sex = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_0",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		dialogue_type = 2,
		start_dialogue_option = 9,
		text = [
			{
				text = "KURO_TOME_SEX",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_TOME_REPLY_MEANING",
				reqs = [

				],
				previous_dialogue_option = 1
			},
		],
		options = [
			{
				code = "kuro_tome_sex",
				text = "KURO_TOME_OPT_MEANING",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_tome_sex2",
				text = "KURO_TOME_OPT_DO",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_TOME_OPT_LEAVE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "decision",
						value = "KuroSkippedSex"
					},
					{
						code = "complete_quest",
						value = "kuro_tome_quest"
					},
					{
						code = 'add_timed_event',
						value = "kuro_church_start",
						args = [
							{
								type = 'add_to_date',
								date = [14,15],
								hour = 1
							}
						]
					},
					{
						code = 'add_timed_event',
						value = "kuro_zeph_start",
						args = [
							{
								type = 'add_to_date',
								date = [7,8],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	kuro_tome_sex2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_0",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "kuro_tome",
		text = [
			{
				text = "KURO_TOME_SEX2",
				reqs = [

				]
			},
		],
		options = [
			{
				code = "kuro_tome_sex3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex6",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_tome_sex7",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_tome_sex7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_book_0_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_TOME_SEX7",
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
						code = "complete_quest",
						value = "kuro_tome_quest"
					},
					{
						code = 'add_timed_event',
						value = "kuro_church_start",
						args = [
							{
								type = 'add_to_date',
								date = [14,15],
								hour = 1
							}
						]
					},
					{
						code = 'add_timed_event',
						value = "kuro_zeph_start",
						args = [
							{
								type = 'add_to_date',
								date = [7,8],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	kuro_after_tome = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		start_dialogue_option = 9,
		text = [
			{
				text = "KURO_AFTER_TOME",
				reqs = [

				],
				previous_dialogue_option = 9
			},
			{
				text = "KURO_AFTER_REPLY_BOOK",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "",
				reqs = [

				],
				previous_dialogue_option = 2
			},
		],
		options = [
			{
				code = "kuro_after_tome",
				text = "KURO_AFTER_OPT_BOOK",
				dialogue_argument = 1,
				reqs = [

				]
			},
			{
				code = "kuro_after_tome2",
				text = "KURO_AFTER_OPT_CAPABLE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_after_tome2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_AFTER_TOME2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_after_tome3",
				text = "KURO_AFTER_OPT_UNHAPPY",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_after_tome",
				text = "KURO_AFTER_OPT_ELSE",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [
					{
						type = 'dialogue_seen',
						check = false,
						value = 'KURO_AFTER_REPLY_BOOK'
					}
				]
			}
		]
	},
	kuro_after_tome3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO_AFTER_TOME3",
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

				]
			}
		]
	},
}
