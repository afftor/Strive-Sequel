extends Reference
var data = {
	jean_sylas_next_day_start = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_NEXT_DAY_START", reqs = []},
		],
		options = [
			{code = "jean_sylas_next_day_followup", text = "JEAN_SYLAS_NEXT_DAY_OPTION_CHECK", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_next_day_followup", text = "JEAN_SYLAS_NEXT_DAY_OPTION_LATER", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_next_day_followup = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_NEXT_DAY_FOLLOWUP", reqs = []},
		],
		options = [
			{code = "jean_sylas_origin_full_1", text = "JEAN_SYLAS_ORIGIN_OPTION_FULL", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_origin_short", text = "JEAN_SYLAS_ORIGIN_OPTION_SHORT", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "jean_sylas_origin_repeat", text = "JEAN_SYLAS_ORIGIN_OPTION_REPEAT", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	jean_sylas_origin_full_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ORIGIN_FULL_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_origin_full_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_origin_full_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ORIGIN_FULL_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_help_prompt", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_origin_short = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ORIGIN_SHORT", reqs = []},
		],
		options = [
			{code = "jean_sylas_help_prompt", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_origin_repeat = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ORIGIN_REPEAT", reqs = []},
		],
		options = [
			{code = "jean_sylas_help_prompt", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_help_prompt = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_HELP_PROMPT", reqs = []},
		],
		options = [
			{code = "jean_sylas_help_response", text = "JEAN_SYLAS_HELP_OPTION_WITH_YOU", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_help_response", text = "JEAN_SYLAS_HELP_OPTION_FAVOR", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_help_response = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_HELP_RESPONSE_WITH_YOU", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_HELP_RESPONSE_FAVOR", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_SYLAS_GUILD_SUGGESTION", reqs = []},
		],
		options = [
			{code = "jean_sylas_guild_options_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_guild_options_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GUILD_OPTIONS_INTRO", reqs = []},
		],
		options = [
			{
				code = "jean_sylas_guild_choice_response",
				text = "JEAN_SYLAS_GUILD_OPTION_DUNCAN",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "JeanSylasHelpDuncan"},
				]
			},
			{
				code = "jean_sylas_guild_choice_response",
				text = "JEAN_SYLAS_GUILD_OPTION_MYR",
				reqs = [],
				dialogue_argument = 2,
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "JeanSylasHelpMyr"},
				]
			},
		]
	},
	jean_sylas_guild_choice_response = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GUILD_CHOICE_DUNCAN", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_GUILD_CHOICE_MYR", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_duncan_help_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "duncan",
		text = [
			{text = "JEAN_SYLAS_DUNCAN_HELP_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_duncan_help_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_duncan_help_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "duncan",
		text = [
			{text = "JEAN_SYLAS_DUNCAN_HELP_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_after_guild", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_help_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_HELP_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_help_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_help_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_HELP_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_help_device", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_help_device = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_HELP_DEVICE", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_help_reply", text = "JEAN_SYLAS_MYR_HELP_OPTION_THANKS", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_myr_help_reply", text = "JEAN_SYLAS_MYR_HELP_OPTION_WHAT_IS_IT", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_help_reply = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_HELP_RESPONSE_THANKS", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_MYR_HELP_RESPONSE_WHAT_IS_IT", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = "jean_sylas_after_guild", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_after_guild = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_AFTER_GUILD_RYNN_ALIVE", reqs = [{type = "decision", value = "RynnAlive", check = true}]},
			{text = "JEAN_SYLAS_AFTER_GUILD_RYNN_LEFT", reqs = [{type = "decision", value = "RynnAlive", check = false}]},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_capital_meet = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CAPITAL_MEET", reqs = []},
		],
		options = [
			{code = "jean_sylas_capital_reply", text = "JEAN_SYLAS_CAPITAL_OPTION_DELAY", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_capital_reply", text = "JEAN_SYLAS_CAPITAL_OPTION_USEFUL", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_capital_reply = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CAPITAL_REPLY_DELAY", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_CAPITAL_REPLY_USEFUL", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_SYLAS_CAPITAL_SYLAS_INFO", reqs = []},
		],
		options = [
			{code = "jean_sylas_capital_lead", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_capital_lead = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CAPITAL_LEAD_SUGGESTION", reqs = []},
		],
		options = [
			{
				code = "jean_sylas_arena_intro",
				text = "JEAN_SYLAS_CAPITAL_OPTION_ARENA_DUNCAN",
				reqs = [{type = "decision", value = "JeanSylasHelpDuncan", check = true}],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_arena_intro",
				text = "JEAN_SYLAS_CAPITAL_OPTION_ARENA_MYR",
				reqs = [{type = "decision", value = "JeanSylasHelpMyr", check = true}],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{code = "jean_sylas_merchants_intro", text = "JEAN_SYLAS_CAPITAL_OPTION_MERCHANTS", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},

	jean_sylas_arena_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_melchor", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_melchor = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_MELCHOR_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_reply_reason", text = "JEAN_SYLAS_ARENA_OPTION_REASON", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_arena_reply_not_friends", text = "JEAN_SYLAS_ARENA_OPTION_NOT_FRIENDS", reqs = [], dialogue_argument = 2, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_arena_reply_personal", text = "JEAN_SYLAS_ARENA_OPTION_PERSONAL", reqs = [], dialogue_argument = 3, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_arena_reply_dangerous", text = "JEAN_SYLAS_ARENA_OPTION_DANGEROUS", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_reply_reason = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_REPLY_REASON", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_melchor", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_reply_not_friends = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_REPLY_NOT_FRIENDS", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_melchor", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_reply_personal = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_REPLY_PERSONAL", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_melchor", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_reply_dangerous = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_REPLY_DANGEROUS", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_fighter_entry", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_fighter_entry = {
		variations = [
			{
				reqs = [{type = "decision", value = "JeanSylasHelpMyr", check = true}],
				image = null,
				tags = ["dialogue_scene", "master_translate"],
				text = [
					{text = "JEAN_SYLAS_ARENA_MYR_FIND", reqs = []},
				],
				options = [
					{
						code = "jean_sylas_arena_myr_bribe",
						text = "JEAN_SYLAS_ARENA_MYR_OPTION_BRIBE",
						reqs = [{type = "has_money", value = 500}],
						dialogue_argument = 1,
						type = "next_dialogue",
						bonus_effects = [{code = "money_change", operant = "-", value = 500}]
					},
					{
						code = "jean_sylas_arena_myr_arm_start",
						text = "JEAN_SYLAS_ARENA_MYR_OPTION_ARM",
						reqs = [],
						dialogue_argument = 2,
						type = "next_dialogue"
					},
				]
			},
			{
				reqs = [{type = "decision", value = "JeanSylasHelpDuncan", check = true}],
				image = null,
				tags = ["dialogue_scene", "master_translate"],
				text = [
					{text = "JEAN_SYLAS_ARENA_DUNCAN_INTRO", reqs = []},
				],
				options = [
					{code = "jean_sylas_arena_fighter_common_start", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
				]
			},
		]
	},
	jean_sylas_arena_myr_bribe = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_MYR_BRIBE", reqs = []},
			{text = "JEAN_SYLAS_ARENA_MYR_TALK", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_fighter_common_start", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_myr_arm_start = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_MYR_ARM_START", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_myr_arm_result", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_myr_arm_result = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_MYR_ARM_WIN", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics", operant = "gte", value = 5}]}]},
			{text = "JEAN_SYLAS_ARENA_MYR_ARM_LOSE", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics", operant = "lt", value = 5}]}], bonus_effects = [{code = "money_change", operant = "-", value = 100}]},
			{text = "JEAN_SYLAS_ARENA_MYR_TALK", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_fighter_common_start", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_fighter_common_start = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_FIGHTER_THINK", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_fighter_info_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_fighter_info_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_FIGHTER_INFO_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_fighter_info_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_fighter_info_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_FIGHTER_INFO_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_arena_fighter_end", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_arena_fighter_end = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARENA_FIGHTER_END", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_merchants_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_shop", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_shop = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_SHOP", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_talk_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_talk_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_TALK_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_talk_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_talk_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_TALK_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_talk_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_talk_3 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_TALK_3", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_reply_start", text = "JEAN_SYLAS_MERCHANTS_OPTION_START", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_merchants_reply_enemies", text = "JEAN_SYLAS_MERCHANTS_OPTION_ENEMIES", reqs = [], dialogue_argument = 2, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_merchants_deal", text = "JEAN_SYLAS_MERCHANTS_OPTION_DEAL", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_reply_start = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_REPLY_START", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_talk_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_reply_enemies = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_REPLY_ENEMIES", reqs = []},
		],
		options = [
			{code = "jean_sylas_merchants_talk_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_merchants_deal = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_MERCHANTS_REPLY_DEAL", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_search = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_SEARCH", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_approach", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_approach = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_APPROACH", reqs = []},
		],
		options = [
			{
				code = "jean_sylas_carriage_erdyna_1",
				text = "JEAN_SYLAS_CARRIAGE_OPTION_ERDYNA",
				reqs = [{type = "unique_character_checks", name = "erdyna", value = [{code = "true"}]}],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{code = "jean_sylas_carriage_diplomacy", text = "JEAN_SYLAS_CARRIAGE_OPTION_DIPLOMACY", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "jean_sylas_carriage_pay", text = "JEAN_SYLAS_CARRIAGE_OPTION_PAY", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "jean_sylas_carriage_intimidate", text = "JEAN_SYLAS_CARRIAGE_OPTION_INTIMIDATE", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_erdyna_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "erdyna",
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_ERDYNA_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_erdyna_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_erdyna_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "erdyna",
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_ERDYNA_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_after_fight", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_diplomacy = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_DIPLOMACY", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_fight_intro", text = "JEAN_SYLAS_OPTION_FIGHT_THUGS", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_pay = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_PAY", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_fight_intro", text = "JEAN_SYLAS_OPTION_FIGHT_THUGS", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_intimidate = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_INTIMIDATE_FAIL", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics", operant = "lt", value = 5}]}]},
			{text = "JEAN_SYLAS_CARRIAGE_INTIMIDATE_SUCCESS", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics", operant = "gte", value = 5}]}]},
		],
		options = [
			{code = "jean_sylas_carriage_intimidate_return", text = "DIALOGUECONTINUE", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics", operant = "gte", value = 5}]}], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_carriage_fight_intro", text = "JEAN_SYLAS_OPTION_FIGHT_THUGS", reqs = [{type = "master_check", value = [{code = "stat", stat = "physics", operant = "lt", value = 5}]}], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_intimidate_return = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_INTIMIDATE_RETURN", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_fight_intro", text = "JEAN_SYLAS_OPTION_FIGHT_THUGS", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_fight_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_FIGHT_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_after_fight", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_after_fight = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_AFTER_FIGHT", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_return_merchant", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_return_merchant = {
		image = null,
		tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_RETURN_MERCHANT", reqs = []},
		],
		options = [
			{code = "jean_sylas_carriage_routes", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_carriage_routes = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CARRIAGE_ROUTES", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_brothel_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_girls", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_girls = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_GIRLS", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_flirt", text = "JEAN_SYLAS_BROTHEL_OPTION_FLIRT", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_brothel_madam_intro", text = "JEAN_SYLAS_BROTHEL_OPTION_QUESTIONS", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_flirt = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_FLIRT_JEAN", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_madam_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_madam_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_MADAM_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_madam_dismiss", text = "JEAN_SYLAS_BROTHEL_MADAM_OPTION_DISAPPEAR", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_brothel_madam_dismiss", text = "JEAN_SYLAS_BROTHEL_MADAM_OPTION_LOOKING", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_madam_dismiss = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_MADAM_DISMISS", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_crying", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_crying = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_CRYING", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_girl_trust", text = "JEAN_SYLAS_BROTHEL_CRYING_OPTION_TRUST", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_brothel_girl_knows", text = "JEAN_SYLAS_BROTHEL_CRYING_OPTION_DISAPPEAR", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{
				code = "jean_sylas_brothel_amelia_intro",
				text = "JEAN_SYLAS_BROTHEL_CRYING_OPTION_AMELIA",
				reqs = [{type = "unique_character_checks", name = "amelia", value = [{code = "true"}]}],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
		]
	},
	jean_sylas_brothel_girl_trust = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_GIRL_TRUST", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_girl_bad", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_girl_knows = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_GIRL_KNOWS", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_girl_bad", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_girl_bad = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_GIRL_BAD", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_girl_daren", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_girl_daren = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_GIRL_DAREN", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_plan_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_amelia_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "amelia",
		text = [
			{text = "JEAN_SYLAS_BROTHEL_AMELIA_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_amelia_details", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_amelia_details = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "amelia",
		text = [
			{text = "JEAN_SYLAS_BROTHEL_AMELIA_DETAILS", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_amelia_daren", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_amelia_daren = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "amelia",
		text = [
			{text = "JEAN_SYLAS_BROTHEL_AMELIA_DAREN", reqs = []},
		],
		options = [
			{code = "jean_sylas_brothel_plan_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_brothel_plan_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_BROTHEL_PLAN_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_plan", text = "JEAN_SYLAS_BROTHEL_PLAN_OPTION_CLIENT", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_girl_plan_shock", text = "JEAN_SYLAS_BROTHEL_PLAN_OPTION_GIRL", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_client_plan = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_PLAN", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_return", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_return = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_RETURN", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_offer", text = "JEAN_SYLAS_CLIENT_OPTION_RUN_DOWN", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_client_offer", text = "JEAN_SYLAS_CLIENT_OPTION_RECOMMEND", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "jean_sylas_client_offer", text = "JEAN_SYLAS_CLIENT_OPTION_STORMED", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	jean_sylas_client_offer = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_OFFER", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_tell_more", text = "JEAN_SYLAS_CLIENT_OPTION_TELL_MORE", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_client_cost", text = "JEAN_SYLAS_CLIENT_OPTION_COST", reqs = [], dialogue_argument = 2, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_client_decline", text = "JEAN_SYLAS_CLIENT_OPTION_DECLINE", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{
				code = "jean_sylas_client_accept",
				text = "JEAN_SYLAS_CLIENT_OPTION_ACCEPT",
				reqs = [{type = "has_money", value = 200}],
				dialogue_argument = 4,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 200}]
			},
		]
	},
	jean_sylas_client_tell_more = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_TELL_MORE", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_offer", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_cost = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_COST", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_offer", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_decline = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_DECLINE", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_decline_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_decline_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_DECLINE_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_after", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_accept = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_ACCEPT", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_accept_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_accept_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_ACCEPT_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_after", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_client_after = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_AFTER", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_after_info", text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_HOW", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_client_after_info", text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_FOUND", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_client_after_info = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_AFTER_INFO", reqs = []},
		],
		options = [
			{code = "jean_sylas_client_after_followup", text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_PAY", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_client_after_followup", text = "JEAN_SYLAS_CLIENT_AFTER_OPTION_WHEN", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_client_after_followup = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CLIENT_AFTER_PAY_REPLY", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_CLIENT_AFTER_WHEN_REPLY", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_SYLAS_CLIENT_AFTER_TIMING", reqs = []},
		],
		options = [
			{code = "jean_sylas_ambush_wait", text = "JEAN_SYLAS_OPTION_PREPARE_AMBUSH", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_girl_plan_shock = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_SHOCK", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_objection", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_PRETEND", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_girl_plan_objection", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_UNDERCOVER", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_objection = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_OBJECTION", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_no_clothes", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DISGUISE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_girl_plan_no_clothes", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_CHANGE", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_no_clothes = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_NO_CLOTHES", reqs = []},
		],
		options = [
			{
				code = "jean_sylas_girl_plan_gold",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_GOLD",
				reqs = [{type = "has_money", value = 500}],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 500}]
			},
			{code = "jean_sylas_girl_plan_return", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_WAIT", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_return = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_RETURN", reqs = []},
		],
		options = [
			{
				code = "jean_sylas_girl_plan_gold",
				text = "JEAN_SYLAS_GIRL_PLAN_OPTION_GOLD",
				reqs = [{type = "has_money", value = 500}],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 500}]
			},
			{code = "jean_sylas_girl_plan_return", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_WAIT", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_gold = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_GOLD", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_gold_reply", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_BETTER", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_girl_plan_gold_reply", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_CATCH", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_gold_reply = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_GOLD_REPLY", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_disguise", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_disguise = {
		image = null,
		tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_DISGUISE", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_disguise_response", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_COMPLIMENT", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_girl_plan_disguise_response", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_BLEND", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_disguise_response = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_RESPONSE_COMPLIMENT", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_GIRL_PLAN_RESPONSE_BLEND", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_SYLAS_GIRL_PLAN_GO", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_hallway", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_hallway = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_HALLWAY", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_door_1", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR1", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_girl_plan_door_2", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR2", reqs = [], dialogue_argument = 2, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_girl_plan_door_3", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR3", reqs = [], dialogue_argument = 3, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_girl_plan_office", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_DOOR4", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_door_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_DOOR1", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_hallway", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_door_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_DOOR2", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_hallway", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_door_3 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_DOOR3", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_hallway", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_office = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_OFFICE", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_paintings", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_PAINTINGS", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_girl_plan_cabinets", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_CABINETS", reqs = [], dialogue_argument = 2, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_girl_plan_table", text = "JEAN_SYLAS_GIRL_PLAN_OPTION_TABLE", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_paintings = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_PAINTINGS", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_office", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_cabinets = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_CABINETS", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_office", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_table = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_TABLE", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_after", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_after = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_AFTER", reqs = []},
		],
		options = [
			{code = "jean_sylas_girl_plan_after_response", text = "JEAN_SYLAS_GIRL_PLAN_AFTER_OPTION_SLOW", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_girl_plan_after_response", text = "JEAN_SYLAS_GIRL_PLAN_AFTER_OPTION_LEARNED", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_girl_plan_after_response = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_GIRL_PLAN_AFTER_RESPONSE", reqs = []},
		],
		options = [
			{code = "jean_sylas_ambush_wait", text = "JEAN_SYLAS_OPTION_PREPARE_AMBUSH", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_ambush_wait = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_AMBUSH_WAIT", reqs = []},
		],
		options = [
			{code = "jean_sylas_sylas_confront", text = "JEAN_SYLAS_AMBUSH_OPTION_ATTACK", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sylas_confront = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SYLAS_CONFRONT", reqs = []},
		],
		options = [
			{code = "jean_sylas_sylas_reply", text = "JEAN_SYLAS_SYLAS_OPTION_MISTAKE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_sylas_reply", text = "JEAN_SYLAS_SYLAS_OPTION_FIGHT", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_sylas_reply = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SYLAS_REPLY_MISTAKE", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_SYLAS_SYLAS_REPLY_FIGHT", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_SYLAS_SYLAS_MONSTERS", reqs = []},
			{text = "JEAN_SYLAS_SYLAS_SERVANT_KILLED", reqs = [{type = "decision", value = "JeanQuest2ServantKilled", check = true}]},
			{text = "JEAN_SYLAS_SYLAS_SERVANT_FREED", reqs = [{type = "decision", value = "JeanQuest2ServantFreed", check = true}]},
			{text = "JEAN_SYLAS_SYLAS_DEVICE", reqs = [{type = "decision", value = "JeanSylasHelpMyr", check = true}]},
		],
		options = [
			{code = "jean_sylas_sylas_win_1", text = "JEAN_SYLAS_OPTION_FIGHT_SYLAS", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sylas_win_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SYLAS_WIN_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_sylas_win_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sylas_win_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SYLAS_WIN_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_sylas_win_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sylas_win_3 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SYLAS_WIN_3", reqs = []},
		],
		options = [
			{code = "jean_sylas_sylas_win_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sylas_win_4 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SYLAS_WIN_4", reqs = []},
		],
		options = [
			{code = "jean_sylas_return_aliron", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_return_aliron = {
		image = null,
		tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_RETURN_ALIRON", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_myr_issue_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_ISSUE_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_issue_library", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_issue_library = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_ISSUE_LIBRARY", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_issue_snark", text = "JEAN_SYLAS_MYR_ISSUE_OPTION_SNARK", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_myr_issue_archives", text = "JEAN_SYLAS_MYR_ISSUE_OPTION_ARCHIVES", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_issue_snark = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_ISSUE_SNARK", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_issue_library", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_issue_archives = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_ISSUE_ARCHIVES", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_library_complete = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_LIBRARY_COMPLETE", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_records_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_records_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_RECORDS_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_records_ruins", text = "JEAN_SYLAS_MYR_RECORDS_OPTION_RUINS", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_myr_records_plan", text = "JEAN_SYLAS_MYR_RECORDS_OPTION_SAVE", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_records_ruins = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_RECORDS_RUINS", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_records_plan", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_records_plan = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_RECORDS_PLAN", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_records_safe", text = "JEAN_SYLAS_MYR_RECORDS_OPTION_SAFE", reqs = [], dialogue_argument = 1, type = "next_dialogue", remove_after_first_use = true},
			{code = "jean_sylas_myr_records_artifact", text = "JEAN_SYLAS_MYR_RECORDS_OPTION_HOW", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_records_safe = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_RECORDS_SAFE", reqs = []},
		],
		options = [
			{code = "jean_sylas_myr_records_plan", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_myr_records_artifact = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "myr",
		text = [
			{text = "JEAN_SYLAS_MYR_RECORDS_ARTIFACT", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_artifact_crafted = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_ARTIFACT_CRAFTED", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_search_jean_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SEARCH_JEAN_INTRO", reqs = []},
		],
		options = [
			{code = "jean_sylas_demon_time_short", text = "JEAN_SYLAS_SEARCH_JEAN_OPTION_LONG", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_demon_time_short", text = "JEAN_SYLAS_SEARCH_JEAN_OPTION_VERY_LONG", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "jean_sylas_demon_time_long", text = "JEAN_SYLAS_SEARCH_JEAN_OPTION_RECORDS", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	jean_sylas_demon_time_short = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DEMON_TIME_SHORT", reqs = []},
		],
		options = [
			{code = "jean_sylas_demon_monologue_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_demon_time_long = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DEMON_TIME_LONG", reqs = []},
		],
		options = [
			{code = "jean_sylas_demon_monologue_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_demon_monologue_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DEMON_MONOLOGUE_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_demon_monologue_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_demon_monologue_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DEMON_MONOLOGUE_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_fight_jean_result", text = "JEAN_SYLAS_OPTION_FIGHT_JEAN", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_fight_jean_result = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_FIGHT_JEAN_RESULT", reqs = []},
		],
		options = [
			{code = "jean_sylas_dream_start", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_dream_start = {
		image = null,
		tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DREAM_START", reqs = []},
		],
		options = [
			{code = "jean_sylas_dream_praise", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_dream_praise = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DREAM_PRAISE", reqs = []},
		],
		options = [
			{code = "jean_sylas_dream_reply_fun", text = "JEAN_SYLAS_DREAM_OPTION_FUN", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_dream_reply_wake", text = "JEAN_SYLAS_DREAM_OPTION_WAKE", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_dream_reply_fun = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DREAM_REPLY_FUN", reqs = []},
		],
		options = [
			{code = "jean_sylas_dream_break", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_dream_reply_wake = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DREAM_REPLY_WAKE", reqs = []},
		],
		options = [
			{code = "jean_sylas_dream_break", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_dream_break = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DREAM_BREAK_PROMPT", reqs = []},
		],
		options = [
			{code = "jean_sylas_dream_break_response", text = "JEAN_SYLAS_DREAM_BREAK_OPTION_REMEMBER", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_dream_break_response", text = "JEAN_SYLAS_DREAM_BREAK_OPTION_ILLUSION", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_dream_break_response = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DREAM_BREAK_RESPONSE", reqs = []},
		],
		options = [
			{code = "jean_sylas_wake_reality", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_wake_reality = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_WAKE_REALITY", reqs = []},
		],
		options = [
			{code = "jean_sylas_demon_reveal", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_demon_reveal = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DEMON_REVEAL", reqs = []},
		],
		options = [
			{code = "jean_sylas_demon_fight_result", text = "JEAN_SYLAS_OPTION_FIGHT_DEMON", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_demon_fight_result = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DEMON_FIGHT_RESULT", reqs = []},
		],
		options = [
			{code = "jean_sylas_sphere_choice", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_choice = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_CHOICE", reqs = []},
		],
		options = [
			{
				code = "jean_sylas_sphere_church",
				text = "JEAN_SYLAS_SPHERE_OPTION_CHURCH",
				reqs = [{type = "decision", value = "RynnAlive", check = true}],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_research_alive",
				text = "JEAN_SYLAS_SPHERE_OPTION_RESEARCH",
				reqs = [{type = "decision", value = "RynnAlive", check = true}],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_research_dead",
				text = "JEAN_SYLAS_SPHERE_OPTION_RESEARCH",
				reqs = [{type = "decision", value = "RynnAlive", check = false}],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_destroy_alive",
				text = "JEAN_SYLAS_SPHERE_OPTION_DESTROY",
				reqs = [{type = "decision", value = "RynnAlive", check = true}],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_sphere_destroy_dead",
				text = "JEAN_SYLAS_SPHERE_OPTION_DESTROY",
				reqs = [{type = "decision", value = "RynnAlive", check = false}],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
		]
	},
	jean_sylas_sphere_church = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_CHURCH", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_research_dead = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_RESEARCH_DEAD", reqs = []},
		],
		options = [
			{code = "jean_sylas_keep_sphere_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_research_alive = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_RESEARCH_ALIVE", reqs = []},
		],
		options = [
			{code = "jean_sylas_sphere_right", text = "JEAN_SYLAS_SPHERE_OPTION_RIGHT", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "jean_sylas_sphere_up_to_you", text = "JEAN_SYLAS_SPHERE_OPTION_UP_TO_YOU", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_right = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_RIGHT", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_up_to_you = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_UP_TO_YOU", reqs = []},
		],
		options = [
			{code = "jean_sylas_keep_sphere_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_destroy_dead = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_DESTROY_DEAD", reqs = []},
		],
		options = [
			{code = "jean_sylas_destroy_epilogue_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_sphere_destroy_alive = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_SPHERE_DESTROY_ALIVE", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_church_event_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CHURCH_EVENT_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_church_event_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CHURCH_EVENT_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_church_event_3 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CHURCH_EVENT_3", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_church_event_4 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CHURCH_EVENT_4", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_church_event_5 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CHURCH_EVENT_5", reqs = []},
		],
		options = [
			{code = "jean_sylas_church_event_6", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_church_event_6 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_CHURCH_EVENT_6", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_keep_sphere_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_KEEP_SPHERE_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_keep_sphere_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_keep_sphere_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_KEEP_SPHERE_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_keep_sphere_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_keep_sphere_3 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_KEEP_SPHERE_3", reqs = []},
		],
		options = [
			{code = "jean_sylas_keep_sphere_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_keep_sphere_4 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_KEEP_SPHERE_4", reqs = []},
		],
		options = [
			{code = "jean_sylas_keep_sphere_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_keep_sphere_5 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_KEEP_SPHERE_5", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	jean_sylas_destroy_epilogue_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DESTROY_EPILOGUE_1", reqs = []},
		],
		options = [
			{code = "jean_sylas_destroy_epilogue_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_destroy_epilogue_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DESTROY_EPILOGUE_2", reqs = []},
		],
		options = [
			{code = "jean_sylas_destroy_epilogue_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_destroy_epilogue_3 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DESTROY_EPILOGUE_3", reqs = []},
		],
		options = [
			{code = "jean_sylas_destroy_epilogue_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	jean_sylas_destroy_epilogue_4 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{text = "JEAN_SYLAS_DESTROY_EPILOGUE_4", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
}
