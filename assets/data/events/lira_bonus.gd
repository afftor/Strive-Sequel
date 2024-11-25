extends Reference
var data = {
	lira_lost_start = {
		variations = [
			{
				reqs = [
					{
						type = "capital_closed",
						name = "elf_capital",
						check = true
					}
				],
				common_effects = [
					{
						code = 'clear_subroom'
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "LIRA_LOST_START",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "lira_lost_start2",
						text = "DIALOGUECONTINUE",
						dialogue_argument = 9,
						type = "next_dialogue",
						reqs = [

						]
					}
				]
			},
			{
				reqs = [
					{
						type = "capital_closed",
						name = "elf_capital",
						check = false
					}
				],
				common_effects = [
					{
						code = 'clear_subroom'
					}
				],
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "LIRA_LOST_IDLE",
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
		]
	},
	lira_lost_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "lira",
		text = [
			{
				text = "LIRA_LOST_START2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lira_lost_reply_sure",
				text = "LIRA_LOST_OPT_SURE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "lira_lost_reply_price",
				text = "LIRA_LOST_OPT_PRICE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	lira_lost_reply_sure = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "lira",
		text = [
			{
				text = "LIRA_LOST_REPLY_SURE",
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
						value = "lira_lost_quest",
						stage = "capital"
					},
					{
						code = "plan_loc_event",
						loc = "elf_capital",
						event = "lira_lost_capital"
					}
				]
			}
		]
	},
	lira_lost_reply_price = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "lira",
		text = [
			{
				text = "LIRA_LOST_REPLY_PRICE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lira_lost_reply_sure",
				text = "LIRA_LOST_OPT_FREE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "lira_lost_reply_something",
				text = "LIRA_LOST_OPT_SOMETHING",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	lira_lost_reply_something = {
		reqs = [

		],
		common_effects = [
			{
				code = "money_change",
				operant = "+",
				value = 150
			}
		],
		tags = [
			"dialogue_scene"
		],
		character = "lira",
		text = [
			{
				text = "LIRA_LOST_REPLY_SOMETHING",
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
						value = "lira_lost_quest",
						stage = "capital"
					},
					{
						code = "plan_loc_event",
						loc = "elf_capital",
						event = "lira_lost_capital"
					}
				]
			}
		]
	},
	lira_lost_capital = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "lira",
		text = [
			{
				text = "LIRA_LOST_CAPITAL",
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
						value = "lira_lost_quest"
					}
				]
			}
		]
	},
}
