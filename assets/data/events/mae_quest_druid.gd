extends Reference
var data = {
	mae_druid_event_start = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [
			{type = "unique_available", name = "mae", check = true, negative = "repeat_next_day"},
			{type = "class_unlocked", class = "druid", operant = "eq", check = true, negative = "repeat_next_day"},
			{type = "decision", value = "mae_druid_event_seen", check = false}
		],
		character = "mae",
		text = "MAE_DRUID_EVENT_START",
		common_effects = [{code = "decision", value = "mae_druid_event_seen"}],
		options = [
			{code = "mae_druid_event_followup", text = "MAE_DRUID_EVENT_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_druid_event_followup", text = "MAE_DRUID_EVENT_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_druid_event_followup = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_DRUID_EVENT_FOLLOWUP",
		options = [
			{code = "close", text = "MAE_DRUID_EVENT_FOLLOWUP_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue", bonus_effects = [{code = "decision", value = "mae_druid_lorien_unlocked"}]},
			{code = "close", text = "MAE_DRUID_EVENT_FOLLOWUP_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue", bonus_effects = [{code = "decision", value = "mae_druid_lorien_unlocked"}]}
		]
	},
	mae_druid_lorien_intro = {
		image = "elf_druid",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_DRUID_LORIEN_INTRO",
		options = [
			{code = "mae_druid_lorien_time", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_druid_lorien_time = {
		image = "elf_druid",
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = "MAE_DRUID_LORIEN_TIME",
		options = [
			{code = "mae_druid_lorien_offer", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_druid_lorien_offer = {
		image = "elf_druid",
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{
				text = "MAE_DRUID_LORIEN_OFFER_HIGH",
				reqs = [
					{type = "decision", value = "act2_finish", check = false},
					{type = "decision", value = "HelevielPriestess", check = true, orflag = true}
				],
				previous_dialogue_option = 1,
			},
			{text = "MAE_DRUID_LORIEN_OFFER_LOW", reqs = [{type = "decision", value = "LiraPriestess", check = true}], previous_dialogue_option = 1,},
			{text = "MAE_DRUID_LORIEN_INVESTMENT", reqs = [], previous_dialogue_option = 2,}
		],
		options = [
			{
				code = "mae_druid_lorien_offer",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_1",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true,
			},
			{
				code = "mae_druid_lorien_paid",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_PAY_HIGH",
				reqs = [
					{type = "has_money", value = 2000},
					{type = "decision", value = "act2_finish", check = false},
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 2000},]
			},
			{
				code = "mae_druid_lorien_paid",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_PAY_HIGH",
				reqs = [
					{type = "has_money", value = 2000},
					{type = "decision", value = "HelevielPriestess", check = true}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 2000},]
			},
			{
				code = "mae_druid_lorien_paid",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_PAY_LOW",
				reqs = [
					{type = "has_money", value = 500},
					{type = "decision", value = "LiraPriestess", check = true}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 500},]
			},
			{
				code = "close",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_THINK",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "mae_druid_offer_pending"},
					{code = "update_city"}
				]
			}
		]
	},
	mae_druid_lorien_paid = {
		image = "elf_druid",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_DRUID_LORIEN_PAID",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "mae_druid_offer_accepted"},
					{code = "remove_decision", value = "mae_druid_offer_pending"},
					{code = "remove_decision", value = "mae_druid_lorien_unlocked"},
					{code = "affect_unique_character", name = "mae", type = "set_availability", value = false},
					{code = "add_timed_event", value = "mae_druid_return_1", args = [{type = "add_to_date", date = [5, 5], hour = 1}]},
					{code = "update_city"}
				]
			}
		]
	},
	mae_druid_lorien_reinitiate = {
		image = "elf_druid",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_DRUID_LORIEN_REINITIATE",
		options = [
			{
				code = "mae_druid_lorien_paid",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_PAY_HIGH_SHORT",
				reqs = [
					{type = "has_money", value = 2000},
					{type = "decision", value = "act2_finish", check = false},
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 2000},]
			},
			{
				code = "mae_druid_lorien_paid",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_PAY_HIGH_SHORT",
				reqs = [
					{type = "has_money", value = 2000},
					{type = "decision", value = "HelevielPriestess", check = true}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 2000},]
			},
			{
				code = "mae_druid_lorien_paid",
				text = "MAE_DRUID_LORIEN_OFFER_OPTION_PAY_LOW_SHORT",
				reqs = [
					{type = "has_money", value = 500},
					{type = "decision", value = "LiraPriestess", check = true}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 500},]
			},
			{code = "close", text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_druid_return_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = "MAE_DRUID_RETURN",
		common_effects = [
			{code = "affect_unique_character", name = "mae", type = "set_availability", value = true},
			{code = "affect_unique_character", name = "mae", type = "add_class", class = "druid"},
			{code = "decision", value = "mae_druid_training_done"},
		],
		options = [
			{code = "mae_sex_behind_1", text = "MAE_DRUID_RETURN_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2},
			{code = "mae_druid_return_affection", text = "MAE_DRUID_RETURN_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mae_druid_return_work", text = "MAE_DRUID_RETURN_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"}
		]
	},
	mae_druid_return_2 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_DRUID_RETURN_AFFECTION", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_DRUID_RETURN_WORK", reqs = [], previous_dialogue_option = 3},
			],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	mae_sex_behind_1 = {
		unlocked_gallery_seq = "mae_sex_behind",
		custom_background = "mae_scene8",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_1",
		options = [
			{code = "mae_sex_behind_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_sex_behind_2 = {
		custom_background = "mae_scene9",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_2",
		options = [
			{code = "mae_sex_behind_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_sex_behind_3 = {
		custom_background = "mae_scene9",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_3",
		options = [
			{code = "mae_sex_behind_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_sex_behind_4 = {
		custom_background = "mae_scene10",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_BEHIND_4",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1,
				type = "next_dialogue", 
				bonus_effects = [
					{code = "dialogue_counter", name = "mae_perverted_actions", op = "+"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"},
					{code = 'decision', value = 'MaeBehind'}
				],
				change_dialogue_type = 1
			}
		]
	},
}
