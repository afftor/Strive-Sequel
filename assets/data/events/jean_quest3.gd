extends Reference
var data = {
	jean_sylas_next_day_start = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_NEXT_DAY_START",
		options = [
			{
				code = "jean_sylas_next_day_followup",
				text = "JEAN_SYLAS_NEXT_DAY_OPTION_CHECK",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_next_day_followup",
				text = "JEAN_SYLAS_NEXT_DAY_OPTION_LATER",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_next_day_followup = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_NEXT_DAY_FOLLOWUP",
		options = [
			{
				code = "jean_sylas_origin_full_1",
				text = "JEAN_SYLAS_ORIGIN_OPTION_FULL",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_origin_short",
				text = "JEAN_SYLAS_ORIGIN_OPTION_SHORT",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_origin_repeat",
				text = "JEAN_SYLAS_ORIGIN_OPTION_REPEAT",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_origin_full_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ORIGIN_FULL_1",
		options = [
			{
				code = "jean_sylas_origin_full_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_origin_full_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ORIGIN_FULL_2",
		options = [
			{
				code = "jean_sylas_help_prompt",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_origin_short = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ORIGIN_SHORT",
		options = [
			{
				code = "jean_sylas_help_prompt",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_origin_repeat = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ORIGIN_REPEAT",
		options = [
			{
				code = "jean_sylas_help_prompt",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_help_prompt = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_HELP_PROMPT",
		options = [
			{
				code = "jean_sylas_help_response",
				text = "JEAN_SYLAS_HELP_OPTION_WITH_YOU",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_help_response",
				text = "JEAN_SYLAS_HELP_OPTION_FAVOR",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_help_response = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_HELP_RESPONSE_WITH_YOU",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_HELP_RESPONSE_FAVOR",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_GUILD_SUGGESTION",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_guild_options_intro",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_guild_options_intro = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GUILD_OPTIONS_INTRO",
		options = [
			{
				code = "jean_sylas_guild_choice_response",
				text = "JEAN_SYLAS_GUILD_OPTION_DUNCAN",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "JeanSylasHelpDuncan"
					}
				]
			},
			{
				code = "jean_sylas_guild_choice_response",
				text = "JEAN_SYLAS_GUILD_OPTION_MYR",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "JeanSylasHelpMyr"
					}
				]
			}
		]
	},
	jean_sylas_guild_choice_response = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_GUILD_CHOICE_DUNCAN",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_GUILD_CHOICE_MYR",
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
						value = "jean_sylas_quest",
						stage = "stage1"
					}
				]
			}
		]
	},
	jean_sylas_duncan_help_1 = {
		image = null,
		character2 = "jean",
		character = "duncan",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DUNCAN_HELP_1",
		options = [
			{
				code = "jean_sylas_duncan_help_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_duncan_help_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "duncan",
		character2 = "jean",
		text = [
			{
				text = "JEAN_SYLAS_DUNCAN_HELP_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_after_guild",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_help_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		character2 = "jean",
		text = "JEAN_SYLAS_MYR_HELP_1",
		options = [
			{
				code = "jean_sylas_myr_help_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_help_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		character2 = "jean",
		text = "JEAN_SYLAS_MYR_HELP_2",
		options = [
			{
				code = "jean_sylas_myr_help_device",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_help_device = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		character2 = "jean",
		text = "JEAN_SYLAS_MYR_HELP_DEVICE",
		options = [
			{
				code = "jean_sylas_myr_help_reply",
				text = "JEAN_SYLAS_MYR_HELP_OPTION_THANKS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_myr_help_reply",
				text = "JEAN_SYLAS_MYR_HELP_OPTION_WHAT_IS_IT",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_help_reply = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		character2 = "jean",
		text = [
			{
				text = "JEAN_SYLAS_MYR_HELP_RESPONSE_THANKS",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_MYR_HELP_RESPONSE_WHAT_IS_IT",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sylas_after_guild",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_after_guild = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_AFTER_GUILD_RYNN_ALIVE",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = true
					}
				]
			},
			{
				text = "JEAN_SYLAS_AFTER_GUILD_RYNN_LEFT",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = false
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
						value = "jean_sylas_quest",
						stage = "stage2"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_capital_meet = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CAPITAL_MEET",
		options = [
			{
				code = "jean_sylas_capital_reply",
				text = "JEAN_SYLAS_CAPITAL_OPTION_DELAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_capital_reply",
				text = "JEAN_SYLAS_CAPITAL_OPTION_USEFUL",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_capital_reply = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CAPITAL_REPLY_DELAY",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_CAPITAL_REPLY_USEFUL",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_CAPITAL_SYLAS_INFO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_capital_lead",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_capital_lead = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CAPITAL_LEAD_SUGGESTION",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "JEAN_SYLAS_CAPITAL_OPTION_ARENA_DUNCAN",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpDuncan",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_sylas_quest",
						stage = "stage3"
					},
					{
						code = "update_city"
					}
				]
			},
			{
				code = "close",
				text = "JEAN_SYLAS_CAPITAL_OPTION_ARENA_MYR",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpMyr",
						check = true
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_sylas_quest",
						stage = "stage3"
					},
					{
						code = "update_city"
					}
				]
			},
			{
				code = "close",
				text = "JEAN_SYLAS_CAPITAL_OPTION_MERCHANTS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_sylas_quest",
						stage = "stage4"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_arena_intro = {
		image = null,
		character = "jean",
		character2 = "chancellor",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARENA_INTRO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_arena_melchor",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_melchor = {
		character = "jean",
		character2 = "chancellor",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARENA_MELCHOR_INTRO",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_ARENA_REPLY_REASON",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_ARENA_REPLY_NOT_FRIENDS",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "JEAN_SYLAS_ARENA_REPLY_PERSONAL",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "jean_sylas_arena_melchor",
				text = "JEAN_SYLAS_ARENA_OPTION_REASON",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_arena_repljean_sylas_arena_melchory_not_friends",
				text = "JEAN_SYLAS_ARENA_OPTION_NOT_FRIENDS",
				reqs = [

				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_arena_melchor",
				text = "JEAN_SYLAS_ARENA_OPTION_PERSONAL",
				reqs = [

				],
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_arena_reply_dangerous",
				text = "JEAN_SYLAS_ARENA_OPTION_DANGEROUS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_reply_dangerous = {
		image = null,
		character = "jean",
		character2 = "chancellor",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARENA_REPLY_DANGEROUS",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_arena_fighter_entry",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpDuncan",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_arena_fighter_start",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpDuncan",
						check = true
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_fighter_entry = {
		reqs = [

		],
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "JEAN_SYLAS_ARENA_MYR_FIND",
		options = [
			{
				code = "jean_sylas_arena_bribe",
				text = "JEAN_SYLAS_ARENA_MYR_OPTION_BRIBE",
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
				code = "jean_sylas_arena_arm_start",
				text = "JEAN_SYLAS_ARENA_MYR_OPTION_ARM",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_bribe = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARENA_MYR_BRIBE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_arena_fighter_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_arm_start = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARENA_MYR_ARM_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_arena_arm_win",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						code = "stat",
						stat = "physics",
						operant = "gte",
						value = 5
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_arena_arm_lose",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						code = "stat",
						stat = "physics",
						operant = "lt",
						value = 5
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_arm_win = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ARENA_MYR_ARM_WIN",
		options = [
			{
				code = "jean_sylas_arena_fighter_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_arm_lose = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ARENA_MYR_ARM_LOSE",
		common_effects = [
			{
				code = "money_change",
				operant = "-",
				value = 100
			}
		],
		options = [
			{
				code = "close",
				text = "JEAN_SYLAS_ARENA_OPTION_MERCHANTS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_sylas_quest",
						stage = "stage4"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_arena_fighter_start = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARENA_MYR_TALK",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_ARENA_DUNCAN_INTRO",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_ARENA_FIGHTER_THINK",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_arena_fighter_info_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_fighter_info_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ARENA_FIGHTER_INFO_1",
		options = [
			{
				code = "jean_sylas_arena_fighter_info_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_fighter_info_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ARENA_FIGHTER_INFO_2",
		options = [
			{
				code = "jean_sylas_arena_fighter_end",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_arena_fighter_end = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_ARENA_FIGHTER_END",
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
						value = "jean_sylas_quest",
						stage = "stage6"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_merchants_intro = {
		image = "jean_trader",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_MERCHANTS_INTRO",
		options = [
			{
				code = "jean_sylas_merchants_talk_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_merchants_talk_1 = {
		image = "jean_trader",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_MERCHANTS_TALK_1",
		options = [
			{
				code = "jean_sylas_merchants_talk_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_merchants_talk_2 = {
		image = "jean_trader",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_MERCHANTS_TALK_2",
		options = [
			{
				code = "jean_sylas_merchants_talk_21",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_merchants_talk_21 = {
		image = "jean_trader",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_MERCHANTS_TALK_21",
		options = [
			{
				code = "jean_sylas_merchants_talk_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_merchants_talk_3 = {
		image = "jean_trader",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_MERCHANTS_TALK_3",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_MERCHANTS_REPLY_START",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_MERCHANTS_REPLY_ENEMIES",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sylas_merchants_talk_3",
				text = "JEAN_SYLAS_MERCHANTS_OPTION_START",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_merchants_talk_3",
				text = "JEAN_SYLAS_MERCHANTS_OPTION_ENEMIES",
				reqs = [

				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_merchants_deal",
				text = "JEAN_SYLAS_MERCHANTS_OPTION_DEAL",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_merchants_deal = {
		image = "jean_trader",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_MERCHANTS_REPLY_DEAL",
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
						value = "jean_sylas_quest",
						stage = "stage5"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_carriage_search = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_SEARCH",
		options = [
			{
				code = "jean_sylas_carriage_approach",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_approach = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_APPROACH",
		options = [
			{
				code = "jean_sylas_carriage_erdyna_1",
				text = "JEAN_SYLAS_CARRIAGE_OPTION_ERDYNA",
				reqs = [
					{
						type = "unique_character_checks",
						name = "erdyna",
						value = [
							{
								code = "is_free",
								check = true
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "JeanSylasHelpErdyna"
					}
				]
			},
			{
				code = "jean_sylas_carriage_diplomacy",
				text = "JEAN_SYLAS_CARRIAGE_OPTION_DIPLOMACY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_carriage_diplomacy",
				text = "JEAN_SYLAS_CARRIAGE_OPTION_PAY",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_carriage_intimidate_fail",
				text = "JEAN_SYLAS_CARRIAGE_OPTION_INTIMIDATE",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics",
								operant = "lt",
								value = 5
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_carriage_intimidate_1",
				text = "JEAN_SYLAS_CARRIAGE_OPTION_INTIMIDATE",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics",
								operant = "gte",
								value = 5
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_erdyna_1 = {
		image = null,
		character = "jean",
		character2 = "erdyna",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_ERDYNA_1",
		options = [
			{
				code = "jean_sylas_carriage_erdyna_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_erdyna_2 = {
		image = null,
		character = "jean",
		character2 = "erdyna",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_ERDYNA_2",
		options = [
			{
				code = "jean_sylas_carriage_after_fight",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_diplomacy = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CARRIAGE_DIPLOMACY",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_CARRIAGE_PAY",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sylas_carriage_fight_intro",
				text = "JEAN_SYLAS_OPTION_FIGHT_THUGS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_intimidate_fail = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		character = "jean",
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_INTIMIDATE_FAIL",
		options = [
			{
				code = "jean_sylas_carriage_fight_intro",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_intimidate_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_INTIMIDATE_SUCCESS",
		options = [
			{
				code = "jean_sylas_carriage_intimidate_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_intimidate_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_INTIMIDATE_RETURN",
		options = [
			{
				code = "jean_sylas_carriage_fight_intro",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_fight_intro = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_FIGHT_INTRO",
		options = [
			{
				code = "quest_fight",
				args = "jean_sylas_thugs",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_after_fight = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CARRIAGE_AFTER_FIGHT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_CARRIAGE_AFTER_FIGHT_DRIVER",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_carriage_return_merchant",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_return_merchant = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_RETURN_MERCHANT",
		options = [
			{
				code = "jean_sylas_carriage_routes",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_carriage_routes = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CARRIAGE_ROUTES",
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
						value = "jean_sylas_quest",
						stage = "stage6"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_brothel_intro = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_INTRO",
		options = [
			{
				code = "jean_sylas_brothel_girls",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_girls = {
		image = "jean_brothel",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_BROTHEL_GIRLS",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_BROTHEL_FLIRT_JEAN",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sylas_brothel_girls",
				text = "JEAN_SYLAS_BROTHEL_OPTION_FLIRT",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_brothel_madam_intro",
				text = "JEAN_SYLAS_BROTHEL_OPTION_QUESTIONS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_madam_intro = {
		image = "jean_brothel",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_MADAM_INTRO",
		options = [
			{
				code = "jean_sylas_brothel_madam_dismiss_1",
				text = "JEAN_SYLAS_BROTHEL_MADAM_OPTION_DISAPPEAR",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_brothel_madam_dismiss_1",
				text = "JEAN_SYLAS_BROTHEL_MADAM_OPTION_LOOKING",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_madam_dismiss_1 = {
		image = "jean_brothel",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_MADAM_DISMISS_1",
		options = [
			{
				code = "jean_sylas_brothel_madam_dismiss_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_madam_dismiss_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_MADAM_DISMISS_2",
		options = [
			{
				code = "jean_sylas_brothel_crying",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_crying = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_CRYING",
		options = [
			{
				code = "jean_sylas_brothel_girl_bad",
				text = "JEAN_SYLAS_BROTHEL_CRYING_OPTION_TRUST",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_brothel_girl_bad",
				text = "JEAN_SYLAS_BROTHEL_CRYING_OPTION_DISAPPEAR",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_brothel_amelia_intro",
				text = "JEAN_SYLAS_BROTHEL_CRYING_OPTION_AMELIA",
				rreqs = [
					{
						type = "unique_character_checks",
						name = "amelia",
						value = [
							{
								code = "is_free",
								check = true
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_girl_bad = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_BROTHEL_GIRL_TRUST",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_BROTHEL_GIRL_KNOWS",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_BROTHEL_GIRL_BAD",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_brothel_girl_daren",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_girl_daren = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_GIRL_DAREN",
		options = [
			{
				code = "jean_sylas_brothel_plan_intro",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_amelia_intro = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "amelia",
		text = "JEAN_SYLAS_BROTHEL_AMELIA_INTRO",
		options = [
			{
				code = "jean_sylas_brothel_amelia_details",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_amelia_details = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "amelia",
		text = "JEAN_SYLAS_BROTHEL_AMELIA_DETAILS",
		options = [
			{
				code = "jean_sylas_brothel_amelia_daren",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_amelia_daren = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "amelia",
		text = "JEAN_SYLAS_BROTHEL_AMELIA_DAREN",
		options = [
			{
				code = "jean_sylas_brothel_plan_intro",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_brothel_plan_intro = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_BROTHEL_PLAN_INTRO",
		options = [
			{
				code = "jean_sylas_client_plan",
				text = "JEAN_SYLAS_BROTHEL_PLAN_OPTION_CLIENT",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_girl_plan_shock",
				text = "JEAN_SYLAS_BROTHEL_PLAN_OPTION_GIRL",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_plan = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_PLAN",
		options = [
			{
				code = "jean_sylas_client_return",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_return = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_RETURN",
		options = [
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_RUN_DOWN",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_RECOMMEND",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_STORMED",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_offer = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CLIENT_OFFER",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_CLIENT_TELL_MORE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_CLIENT_COST",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_TELL_MORE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_COST",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				remove_after_first_use = true,
				bonus_effects = [
					{
						code = "decision",
						value = "JeanSylasBrothelBargain"
					}
				]
			},
			{
				code = "jean_sylas_client_decline",
				text = "JEAN_SYLAS_CLIENT_OPTION_DECLINE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_client_accept",
				text = "JEAN_SYLAS_CLIENT_OPTION_ACCEPT",
				reqs = [
					{
						type = "has_money",
						value = 200
					},
					{
						type = "decision",
						value = "JeanSylasBrothelBargain",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 200
					}
				]
			},
			{
				code = "jean_sylas_client_accept",
				text = "JEAN_SYLAS_CLIENT_OPTION_ACCEPT",
				reqs = [
					{
						type = "has_money",
						value = 100
					},
					{
						type = "decision",
						value = "JeanSylasBrothelBargain",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 100
					}
				]
			}
		]
	},
	jean_sylas_client_decline = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_DECLINE",
		options = [
			{
				code = "jean_sylas_client_decline_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_decline_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_DECLINE_2",
		options = [
			{
				code = "jean_sylas_client_after",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_accept = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_ACCEPT",
		options = [
			{
				code = "jean_sylas_client_accept_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_accept_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_ACCEPT_2",
		options = [
			{
				code = "jean_sylas_client_after",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_after = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_AFTER",
		options = [
			{
				code = "jean_sylas_client_after_info",
				text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_HOW",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_client_after_info",
				text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_FOUND",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_after_info = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_AFTER_INFO",
		options = [
			{
				code = "jean_sylas_client_after_followup",
				text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_PAY",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_client_after_followup",
				text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_WHEN",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_after_followup = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CLIENT_AFTER_PAY_REPLY",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_CLIENT_AFTER_WHEN_REPLY",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_CLIENT_AFTER_TIMING",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_ambush_wait",
				text = "JEAN_SYLAS_OPTION_PREPARE_AMBUSH",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_shock = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_SHOCK",
		options = [
			{
				code = "jean_sylas_girl_plan_objection",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_PRETEND",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_girl_plan_objection",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_UNDERCOVER",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_objection = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_OBJECTION",
		options = [
			{
				code = "jean_sylas_girl_plan_no_clothes",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DISGUISE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_girl_plan_no_clothes",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_CHANGE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_no_clothes = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_NO_CLOTHES",
		options = [
			{
				code = "jean_sylas_girl_plan_gold",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_GOLD",
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
				],
				not_hide = true
			},
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
						value = "jean_sylas_quest",
						stage = "stage7"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_girl_plan_return = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_RETURN",
		options = [
			{
				code = "jean_sylas_girl_plan_gold",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_GOLD",
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
				],
				not_hide = true
			},
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
	jean_sylas_girl_plan_gold = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_GOLD",
		options = [
			{
				code = "jean_sylas_girl_plan_gold_reply",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_BETTER",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_girl_plan_gold_reply",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_CATCH",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_gold_reply = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_GOLD_REPLY",
		options = [
			{
				code = "jean_sylas_girl_plan_disguise",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_disguise = {
		image = null,
		character = "jean_pb",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_DISGUISE",
		options = [
			{
				code = "jean_sylas_girl_plan_disguise_response",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_COMPLIMENT",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_girl_plan_disguise_response",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_BLEND",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_disguise_response = {
		image = null,
		character = "jean_pb",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_GIRL_PLAN_RESPONSE_COMPLIMENT",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_RESPONSE_BLEND",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_GO",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_girl_plan_hallway",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_hallway = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_GIRL_PLAN_HALLWAY",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_DOOR1",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_DOOR2",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_DOOR3",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "jean_sylas_girl_plan_hallway",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR1",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_girl_plan_hallway",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR2",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_girl_plan_hallway",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR3",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_girl_plan_office",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR4",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_office = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_GIRL_PLAN_OFFICE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_OFFICE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_GIRL_PLAN_OFFICE",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sylas_girl_plan_office",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_PAINTINGS",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_girl_plan_office",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_CABINETS",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_girl_plan_table",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_TABLE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_table = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_TABLE",
		options = [
			{
				code = "jean_sylas_girl_plan_after",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_after = {
		image = null,
		character = "jean_pb",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_AFTER",
		options = [
			{
				code = "jean_sylas_girl_plan_after_response",
				text = "JEAN_SYLAS_GIRL_PLAN_AFTER_OPTION_SLOW",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_girl_plan_after_response",
				text = "JEAN_SYLAS_GIRL_PLAN_AFTER_OPTION_LEARNED",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_girl_plan_after_response = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_GIRL_PLAN_AFTER_RESPONSE",
		options = [
			{
				code = "jean_sylas_ambush_wait",
				text = "JEAN_SYLAS_OPTION_PREPARE_AMBUSH",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_ambush_wait = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_AMBUSH_WAIT",
		options = [
			{
				code = "jean_sylas_sylas_confront",
				text = "JEAN_SYLAS_AMBUSH_OPTION_ATTACK",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sylas_confront = {
		image = "jean_sylas",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SYLAS_CONFRONT",
		options = [
			{
				code = "jean_sylas_sylas_reply",
				text = "JEAN_SYLAS_SYLAS_OPTION_MISTAKE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sylas_reply",
				text = "JEAN_SYLAS_SYLAS_OPTION_FIGHT",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sylas_reply = {
		image = "jean_sylas",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_SYLAS_REPLY_MISTAKE",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_SYLAS_REPLY_FIGHT",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_SYLAS_MONSTERS",
				reqs = [

				]
			},
			{
				text = "JEAN_SYLAS_SYLAS_SERVANT_KILLED",
				reqs = [
					{
						type = "decision",
						value = "jean_q2_captive_kill",
						check = true
					}
				]
			},
			{
				text = "JEAN_SYLAS_SYLAS_SERVANT_FREED",
				reqs = [
					{
						type = "decision",
						value = "jean_q2_captive_free",
						check = true
					}
				]
			},
			{
				text = "JEAN_SYLAS_SYLAS_MONSTERS_2",
				reqs = [

				]
			},
			{
				text = "JEAN_SYLAS_SYLAS_DEVICE",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpMyr",
						check = true
					}
				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "jean_sylas_1",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpMyr",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "quest_fight",
				args = "jean_sylas_2",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [
					{
						type = "decision",
						value = "JeanSylasHelpMyr",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sylas_win_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SYLAS_WIN_1",
		options = [
			{
				code = "jean_sylas_sylas_win_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sylas_win_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SYLAS_WIN_2",
		options = [
			{
				code = "jean_sylas_sylas_win_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sylas_win_3 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SYLAS_WIN_3",
		options = [
			{
				code = "jean_sylas_sylas_win_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sylas_win_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SYLAS_WIN_4",
		options = [
			{
				code = "jean_sylas_return_aliron",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_return_aliron = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_RETURN_ALIRON",
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
						code = "affect_unique_character",
						name = "jean",
						type = "set_availability",
						value = false
					},
					{
						code = "progress_quest",
						value = "jean_sylas_quest",
						stage = "stage8"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_myr_issue_intro = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = "JEAN_SYLAS_MYR_ISSUE_INTRO",
		options = [
			{
				code = "jean_sylas_myr_issue_library",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_issue_library = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = [
			{
				text = "JEAN_SYLAS_MYR_ISSUE_LIBRARY",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_MYR_ISSUE_SNARK",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sylas_myr_issue_snark",
				text = "JEAN_SYLAS_MYR_ISSUE_OPTION_SNARK",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_myr_issue_archives",
				text = "JEAN_SYLAS_MYR_ISSUE_OPTION_ARCHIVES",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_issue_archives = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = "JEAN_SYLAS_MYR_ISSUE_ARCHIVES",
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
						value = "jean_sylas_quest",
						stage = "stage9"
					},
					{
						code = "update_city"
					},
					{
						code = "add_special_task_for_location",
						location = "aliron",
						amount = 4,
						descript = "JEANMAGESSEARCHTASKDESCRIPT",
						name = "JEANMAGESSEARCHTASKNAME",
						max_workers = 1,
						icon = "res://assets/Textures_v2/MANSION/quest_task.png",
						args = [
							{
								code = "start_event",
								data = "jean_sylas_library_complete",
								args = {

								}
							}
						]
					}
				]
			}
		]
	},
	jean_sylas_library_complete = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_LIBRARY_COMPLETE",
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
						value = "jean_sylas_quest",
						stage = "stage10"
					},
					{
						code = "update_city"
					}
				]
			}
		]
	},
	jean_sylas_myr_records_intro_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = "JEAN_SYLAS_MYR_RECORDS_INTRO_1",
		options = [
			{
				code = "jean_sylas_myr_records_intro_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_records_intro_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = "JEAN_SYLAS_MYR_RECORDS_INTRO_2",
		options = [
			{
				code = "jean_sylas_myr_records_plan",
				text = "JEAN_SYLAS_MYR_RECORDS_OPTION_RUINS",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_myr_records_plan",
				text = "JEAN_SYLAS_MYR_RECORDS_OPTION_SAVE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_records_plan = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = [
			{
				text = "JEAN_SYLAS_MYR_RECORDS_RUINS",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_MYR_RECORDS_PLAN",
				reqs = [

				],
				previous_dialogue_option = [
					1,
					2
				]
			},
			{
				text = "JEAN_SYLAS_MYR_RECORDS_SAFE",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sylas_myr_records_plan",
				text = "JEAN_SYLAS_MYR_RECORDS_OPTION_SAFE",
				reqs = [

				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_myr_records_artifact",
				text = "JEAN_SYLAS_MYR_RECORDS_OPTION_HOW",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_myr_records_artifact = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "myr",
		text = "JEAN_SYLAS_MYR_RECORDS_ARTIFACT",
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
						value = "jean_sylas_quest",
						stage = "stage11"
					},
					{
						code = "update_city"
					},
					{
						code = "add_timed_event",
						value = "jean_sylas_artifact_crafted",
						args = [
							{
								type = "has_material",
								operant = "eq",
								value = 1,
								material = "mindlink",
								negative = "repeat_next_turn"
							},
							{
								type = "add_to_date",
								date = [
									1,
									1
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	jean_sylas_artifact_crafted = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_ARTIFACT_CRAFTED",
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
						value = "jean_sylas_quest",
						stage = "stage12"
					},
					{
						code = "make_quest_location",
						value = "quest_jean_demon_location"
					}
				]
			}
		]
	},
	jean_sylas_search_jean_intro_1 = {
		image = "jean_demon",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SEARCH_JEAN_INTRO_1",
		options = [
			{
				code = "jean_sylas_search_jean_intro_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_search_jean_intro_2 = {
		image = "jean_demon",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SEARCH_JEAN_INTRO_2",
		options = [
			{
				code = "jean_sylas_demon_time",
				text = "JEAN_SYLAS_SEARCH_JEAN_OPTION_LONG",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_demon_time",
				text = "JEAN_SYLAS_SEARCH_JEAN_OPTION_VERY_LONG",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_demon_time",
				text = "JEAN_SYLAS_SEARCH_JEAN_OPTION_RECORDS",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_demon_time = {
		image = "jean_demon",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_DEMON_TIME_LONG",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_DEMON_TIME_RECORDS",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_DEMON_MONOLOGUE_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "jean_sylas_demon_monologue",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_demon_monologue = {
		image = "jean_demon",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DEMON_MONOLOGUE_2",
		options = [
			{
				code = "quest_fight",
				args = "jean_demon_1",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_fight_jean_result = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_FIGHT_JEAN_RESULT",
		options = [
			{
				code = "jean_sylas_dream_start",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_dream_start = {
		image = null,
		character = "jean",
		character2 = "myr",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DREAM_START",
		options = [
			{
				code = "jean_sylas_dream_praise",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_dream_praise = {
		image = null,
		character = "jean",
		character2 = "myr",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DREAM_PRAISE",
		options = [
			{
				code = "jean_sylas_dream_reply",
				text = "JEAN_SYLAS_DREAM_OPTION_FUN",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_dream_reply",
				text = "JEAN_SYLAS_DREAM_OPTION_WAKE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_dream_reply = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_DREAM_REPLY_FUN",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_DREAM_REPLY_WAKE",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "jean_sylas_dream_break_response",
				text = "JEAN_SYLAS_DREAM_BREAK_OPTION_REMEMBER",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_dream_break_response",
				text = "JEAN_SYLAS_DREAM_BREAK_OPTION_ILLUSION",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_dream_break_response = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DREAM_BREAK_RESPONSE",
		options = [
			{
				code = "jean_sylas_wake_reality",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_wake_reality = {
		image = null,
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_WAKE_REALITY",
		common_effects = [
			{
				code = "affect_unique_character",
				name = "jean",
				type = "set_availability",
				value = true
			}
		],
		options = [
			{
				code = "jean_sylas_demon_reveal",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_demon_reveal = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DEMON_REVEAL",
		options = [
			{
				code = "quest_fight",
				args = "jean_demon_2",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_demon_fight_result = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DEMON_FIGHT_RESULT",
		options = [
			{
				code = "jean_sylas_sphere_choice",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sphere_choice = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SPHERE_CHOICE",
		options = [
			{
				code = "jean_sylas_sphere_church",
				text = "JEAN_SYLAS_SPHERE_OPTION_CHURCH",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_research_alive",
				text = "JEAN_SYLAS_SPHERE_OPTION_RESEARCH",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_research",
				text = "JEAN_SYLAS_SPHERE_OPTION_RESEARCH",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_church",
				text = "JEAN_SYLAS_SPHERE_OPTION_DESTROY",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = true
					}
				],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_destroy",
				text = "JEAN_SYLAS_SPHERE_OPTION_DESTROY",
				reqs = [
					{
						type = "decision",
						value = "rynn_cursed_at_church",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sphere_church = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_SPHERE_CHURCH",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_SPHERE_RIGHT",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_SPHERE_DESTROY_ALIVE",
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
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "jean_sylas_quest",
						stage = "stage13"
					},
					{
						code = "remove_quest_location",
						value = "quest_jean_demon_location"
					}
				]
			}
		]
	},
	jean_sylas_sphere_research = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_SPHERE_RESEARCH_DEAD",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_SPHERE_UP_TO_YOU",
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
						value = "jean_sylas_quest",
						stage = "stage14"
					},
					{
						code = "remove_quest_location",
						value = "quest_jean_demon_location"
					}
				]
			}
		]
	},
	jean_sylas_sphere_research_alive = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SPHERE_RESEARCH_ALIVE",
		options = [
			{
				code = "jean_sylas_sphere_church",
				text = "JEAN_SYLAS_SPHERE_OPTION_RIGHT",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_up_to_you",
				text = "JEAN_SYLAS_SPHERE_OPTION_UP_TO_YOU",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_sphere_destroy_dead = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_SPHERE_DESTROY_DEAD",
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
						code = "add_timed_event",
						value = "jean_sylas_destroy_epilogue_1",
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
						code = "remove_quest_location",
						value = "quest_jean_demon_location"
					}
				]
			}
		]
	},
	jean_sylas_church_event_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CHURCH_EVENT_1",
		options = [
			{
				code = "jean_sylas_church_event_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_church_event_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CHURCH_EVENT_2",
		options = [
			{
				code = "jean_sylas_church_event_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_church_event_3 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CHURCH_EVENT_3",
		options = [
			{
				code = "jean_sylas_church_event_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_church_event_4 = {
		image = "jean_rynn_farewell",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CHURCH_EVENT_4",
		options = [
			{
				code = "jean_sylas_church_event_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_church_event_5 = {
		image = "jean_rynn_farewell",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CHURCH_EVENT_5",
		options = [
			{
				code = "jean_sylas_church_event_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_church_event_6 = {
		image = "jean_rynn_farewell",
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CHURCH_EVENT_6",
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
						value = "jean_sylas_quest"
					}
				]
			}
		]
	},
	jean_sylas_keep_sphere_1 = {
		image = null,
		character = "jean",
		character2 = "myr",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_1",
		options = [
			{
				code = "jean_sylas_keep_sphere_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_2 = {
		image = null,
		character = "jean",
		character2 = "myr",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_2",
		options = [
			{
				code = "jean_sylas_keep_sphere_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_3 = {
		image = null,
		character = "jean",
		character2 = "myr",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_3",
		options = [
			{
				code = "jean_sylas_keep_sphere_31",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_31 = {
		image = null,
		character = "jean",
		character2 = "myr",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_31",
		options = [
			{
				code = "jean_sylas_keep_sphere_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_4 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_4",
		options = [
			{
				code = "jean_sylas_keep_sphere_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_5 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_5",
		options = [
			{
				code = "jean_sylas_keep_sphere_51",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_51 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_51",
		options = [
			{
				code = "jean_sylas_keep_sphere_52",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_keep_sphere_52 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_KEEP_SPHERE_52",
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
						value = "jean_sylas_quest"
					}
				]
			}
		]
	},
	jean_sylas_destroy_epilogue_1 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DESTROY_EPILOGUE_1",
		options = [
			{
				code = "jean_sylas_destroy_epilogue_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_destroy_epilogue_2 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DESTROY_EPILOGUE_2",
		options = [
			{
				code = "jean_sylas_destroy_epilogue_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_destroy_epilogue_3 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DESTROY_EPILOGUE_3",
		options = [
			{
				code = "jean_sylas_destroy_epilogue_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_destroy_epilogue_4 = {
		image = null,
		character = "jean",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_DESTROY_EPILOGUE_4",
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
						value = "jean_sylas_quest"
					}
				]
			}
		]
	}
}