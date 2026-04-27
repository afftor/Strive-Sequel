extends Reference

var data = {
	emp_erdyna_followup_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_ERDYNA_FOLLOWUP_1",
		options = [
			{
				code = "emp_erdyna_hideout_1",
				text = "ACT4_ERDYNA_FOLLOWUP_1_OPTION_GO",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "emp_erdyna_followup_later",
				text = "ACT4_ERDYNA_FOLLOWUP_1_OPTION_LATER",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_followup_later = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_ERDYNA_FOLLOWUP_LATER",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "update_city"}]
			}
		]
	},
	emp_erdyna_hideout_1 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_ERDYNA_HIDEOUT_1",
		options = [
			{
				code = "emp_erdyna_hideout_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_hideout_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_ERDYNA_HIDEOUT_2",
		options = [
			{
				code = "emp_erdyna_hideout_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_hideout_3 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_HIDEOUT_3_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_ERDYNA_HIDEOUT_3_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_HIDEOUT_3_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ERDYNA_HIDEOUT_3_3",
				reqs = []
			}
		],
		options = [
			{
				code = "emp_erdyna_hideout_3",
				text = "ACT4_ERDYNA_HIDEOUT_3_OPTION_KING",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_erdyna_hideout_3",
				text = "ACT4_ERDYNA_HIDEOUT_3_OPTION_BANDIT",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_erdyna_paul_1",
				text = "ACT4_ERDYNA_HIDEOUT_3_OPTION_MOVE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_paul_1 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_ERDYNA_PAUL_1",
		options = [
			{
				code = "emp_erdyna_paul_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_paul_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_ERDYNA_PAUL_2",
		options = [
			{
				code = "emp_erdyna_paul_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_erdyna_paul_3 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = "ACT4_ERDYNA_PAUL_3",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "senerus"},
					{code = "update_city"}
				]
			}
		]
	},
	emp_senerus_home_1 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_HOME_1",
		options = [
			{
				code = "emp_senerus_home_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_home_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_HOME_2",
		options = [
			{
				code = "emp_senerus_home_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "screen_black_transition", value = 1}]
			}
		]
	},
	emp_senerus_home_3 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_HOME_3",
		options = [
			{
				code = "emp_senerus_home_4",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_home_4 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_HOME_4",
		options = [
			{
				code = "emp_senerus_long_1",
				text = "ACT4_SENERUS_HOME_4_OPTION_LISTEN",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "emp_senerus_short_1",
				text = "ACT4_SENERUS_HOME_4_OPTION_SHORT",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_repeat_1 = {
		image = null,
		character = "senerus",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_REPEAT_1",
		options = [
			{
				code = "emp_senerus_hub",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_long_1 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_LONG_1",
		options = [
			{
				code = "emp_senerus_long_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_long_2 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_LONG_2",
		options = [
			{
				code = "emp_senerus_hub",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 5
			}
		]
	},
	emp_senerus_short_1 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_SHORT_1",
		options = [
			{
				code = "emp_senerus_short_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_short_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_SHORT_2",
		options = [
			{
				code = "emp_senerus_hub",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 6
			}
		]
	},
	emp_senerus_hub = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_SENERUS_HUB_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_SENERUS_HUB_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_SENERUS_HUB_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_SENERUS_HUB_3",
				reqs = [],
				previous_dialogue_option = 3
			},
			{
				text = "ACT4_SENERUS_HUB_4",
				reqs = [],
				previous_dialogue_option = 4
			},
			{
				text = "ACT4_SENERUS_LONG_3",
				reqs = [],
				previous_dialogue_option = 5
			},
			{
				text = "ACT4_SENERUS_SHORT_3",
				reqs = [],
				previous_dialogue_option = 6
			}
		],
		options = [
			{
				code = "emp_senerus_hub",
				text = "ACT4_SENERUS_HUB_OPTION_FIRST_GOD",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_hub",
				text = "ACT4_SENERUS_HUB_OPTION_DEMONS",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_HUB_OPTION_GODS",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 3
			},
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_HUB_OPTION_CHAMPIONS",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 4
			},
			{
				code = "emp_senerus_artifact_lead",
				text = "ACT4_SENERUS_HUB_OPTION_ARTIFACT",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "ACT4_SENERUS_HUB_OPTION_LEAVE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "update_city"}]
			}
		]
	},
	emp_senerus_gods = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_SENERUS_GODS_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_SENERUS_GODS_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_SENERUS_GODS_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_SENERUS_GODS_3",
				reqs = [],
				previous_dialogue_option = 3
			},
			{
				text = "ACT4_SENERUS_GODS_4",
				reqs = [],
				previous_dialogue_option = 4
			},
			{
				text = "ACT4_SENERUS_GODS_5",
				reqs = [],
				previous_dialogue_option = 5
			},
			{
				text = "ACT4_SENERUS_GODS_6",
				reqs = []
			}
		],
		options = [
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_EREBUS",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_CELENA",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_ELISIA",
				reqs = [{type = "dialogue_selected", value = "ACT4_SENERUS_GODS_OPTION_CELENA", check = true}],
				type = "next_dialogue",
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_FREYA",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_MAGIC",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 5,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_hub",
				text = "ACT4_SENERUS_GODS_OPTION_RETURN",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_champions = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_SENERUS_CHAMPIONS_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_SENERUS_CHAMPIONS_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_SENERUS_CHAMPIONS_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_SENERUS_CHAMPIONS_3",
				reqs = [],
				previous_dialogue_option = 3
			},
			{
				text = "ACT4_SENERUS_CHAMPIONS_4",
				reqs = []
			}
		],
		options = [
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_CHAMPIONS_OPTION_ALIOS",
				reqs = [{type = "unique_available", name = "zephyra", check = true}],
				type = "next_dialogue",
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_CHAMPIONS_OPTION_NIXX",
				reqs = [{type = "unique_available", name = "kuro", check = true}],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_CHAMPIONS_OPTION_ASHMEDAI",
				reqs = [{type = "unique_available", name = "lilith", check = true}],
				type = "next_dialogue",
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_hub",
				text = "ACT4_SENERUS_CHAMPIONS_OPTION_RETURN",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_senerus_artifact_lead = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_SENERUS_ARTIFACT_LEAD",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "catacombs"},
					{code = "make_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "update_city"}
				]
			}
		]
	},
	emp_catacomb_entry_1 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_CATACOMB_ENTRY_1",
		options = [
			{
				code = "emp_catacomb_entry_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_catacomb_entry_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = "ACT4_CATACOMB_ENTRY_2",
		options = [
			{
				code = "emp_catacomb_entry_2b",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_catacomb_entry_2b = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = "ACT4_CATACOMB_ENTRY_2B",
		options = [
			{
				code = "emp_catacomb_entry_3",
				text = "ACT4_CATACOMB_ENTRY_2_OPTION_PHYSICS",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "emp_catacomb_entry_3",
				text = "ACT4_CATACOMB_ENTRY_2_OPTION_DIPLOMACY",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2
			},
			{
				code = "emp_catacomb_entry_3",
				text = "ACT4_CATACOMB_ENTRY_2_OPTION_ATTACK",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 3
			}
		]
	},
	emp_catacomb_entry_3 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_CATACOMB_ENTRY_3_1_STRONG",
				reqs = [
					{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "gte", value = 5}]}
				],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_CATACOMB_ENTRY_3_1_WEAK",
				reqs = [
					{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "lt", value = 5}]}
				],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_CATACOMB_ENTRY_3_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_CATACOMB_ENTRY_3_3",
				reqs = [],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "emp_catacomb_intimidated_1",
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "gte", value = 5}]}
				],
				type = "next_dialogue",
				previous_dialogue_option = 1
			},
			{
				code = "quest_fight",
				args = "red_rooks_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [
					{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "lt", value = 5}]}
				],
				type = "next_dialogue",
				previous_dialogue_option = 1
			},
			{
				code = "quest_fight",
				args = "red_rooks_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue",
				previous_dialogue_option = [2, 3]
			}
		]
	},
	emp_catacomb_intimidated_1 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_CATACOMB_INTIMIDATED_1",
		options = [
			{
				code = "emp_catacomb_deeper_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_catacomb_after_fight = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_CATACOMB_AFTER_FIGHT",
		options = [
			{
				code = "emp_catacomb_deeper_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	emp_catacomb_deeper_1 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_CATACOMB_DEEPER_1",
		options = [
			{
				code = "emp_catacomb_doors_heleviel",
				text = "ACT4_CATACOMB_DEEPER_1_OPTION_EXAMINE",
				reqs = [{type = "unique_available", name = "heleviel", check = true}],
				type = "next_dialogue"
			},
			{
				code = "emp_catacomb_doors_myr",
				text = "ACT4_CATACOMB_DEEPER_1_OPTION_EXAMINE",
				reqs = [{type = "unique_available", name = "heleviel", check = false}],
				type = "next_dialogue"
			}
		]
	},
	emp_catacomb_doors_heleviel = {
		image = null,
		character = "heleviel",
		character2 = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_3",
				reqs = [],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "emp_catacomb_doors_heleviel",
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_OPTION_CONNECTED",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_catacomb_doors_heleviel",
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_OPTION_READ",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "close",
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_OPTION_VISIT",
				reqs = [],
				type = "next_dialogue",
				previous_dialogue_option = [0, 1, 2],
				dialogue_argument = 3,
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "dragonhunters"},
					{code = "remove_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "update_city"}
				]
			}
		]
	},
	emp_catacomb_doors_myr = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_CATACOMB_DOORS_MYR",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "myr_translation"},
					{code = "remove_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "update_city"}
				]
			}
		]
	},
	emp_myr_catacomb_writing = {
		image = null,
		character = "myr",
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_MYR_CATACOMB_WRITING_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_MYR_CATACOMB_WRITING_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_MYR_CATACOMB_WRITING_2",
				reqs = [],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "emp_myr_catacomb_writing",
				text = "ACT4_MYR_CATACOMB_WRITING_OPTION_READ",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_myr_catacomb_writing",
				text = "ACT4_MYR_CATACOMB_WRITING_OPTION_BELONG",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_myr_catacomb_followup",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				previous_dialogue_option = 2
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				previous_dialogue_option = [3, 4],
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "dragonhunters"},
					{code = "update_city"}
				]
			}
		]
	},
	emp_myr_catacomb_followup = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_MYR_CATACOMB_FOLLOWUP_0",
				reqs = [],
				previous_dialogue_option = 0
			}
		],
		options = [
			{
				code = "emp_myr_catacomb_reply",
				text = "ACT4_MYR_CATACOMB_WRITING_OPTION_CURIOUS",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 3,
				previous_dialogue_option = 0
			},
			{
				code = "emp_myr_catacomb_reply",
				text = "ACT4_MYR_CATACOMB_WRITING_OPTION_VISIT",
				reqs = [],
				type = "next_dialogue",
				previous_dialogue_option = 0,
				dialogue_argument = 4
			}
		]
	},
	emp_myr_catacomb_reply = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{
				text = "ACT4_MYR_CATACOMB_REPLY_1",
				reqs = [],
				previous_dialogue_option = 3
			},
			{
				text = "ACT4_MYR_CATACOMB_REPLY_2",
				reqs = [],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				previous_dialogue_option = [3, 4],
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "dragonhunters"},
					{code = "update_city"}
				]
			}
		]
	}
}
