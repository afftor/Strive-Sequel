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
		music = "erdyna_theme",
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
		tags = ["dialogue_scene",'master_translate'],
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
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_erdyna_hideout_3",
				text = "ACT4_ERDYNA_HIDEOUT_3_OPTION_BANDIT",
				reqs = [],
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
		music = "dungeon",
		character = "senerus",
		character2 = "erdyna",
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
		character = "senerus",
		character2 = "erdyna",
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
		character = "senerus",
		character2 = "erdyna",
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
		character = "senerus",
		character2 = "erdyna",
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
		character = "senerus",
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
		character = "senerus",
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
		character = "senerus",
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
		character = "senerus",
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
		character = "senerus",
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
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_hub",
				text = "ACT4_SENERUS_HUB_OPTION_DEMONS",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_HUB_OPTION_GODS",
				reqs = [],
				dialogue_argument = 3
			},
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_HUB_OPTION_CHAMPIONS",
				reqs = [],
				dialogue_argument = 4
			},
			{
				code = "emp_senerus_artifact_lead",
				text = "ACT4_SENERUS_HUB_OPTION_ARTIFACT",
				reqs = [],
				type = "next_dialogue",
				remove_after_first_use = true
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
		character = "senerus",
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
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_CELENA",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_ELISIA",
				reqs = [{type = "dialogue_selected", value = "ACT4_SENERUS_GODS_OPTION_CELENA", check = true}],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_FREYA",
				reqs = [],
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_gods",
				text = "ACT4_SENERUS_GODS_OPTION_MAGIC",
				reqs = [],
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
		character = "senerus",
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
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_CHAMPIONS_OPTION_NIXX",
				reqs = [{type = "unique_available", name = "kuro", check = true}],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "emp_senerus_champions",
				text = "ACT4_SENERUS_CHAMPIONS_OPTION_ASHMEDAI",
				reqs = [{type = "unique_available", name = "lilith", check = true}],
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
		character = "senerus",
		character2 = "erdyna",
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
		music = "dungeon",
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
		music = "dungeon",
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
		music = "dungeon",
		character = "erdyna",
		tags = ["dialogue_scene"],
		reqs = [],
		text = "ACT4_CATACOMB_DEEPER_1",
		options = [
			{
				code = "emp_catacomb_doors_heleviel",
				text = "ACT4_CATACOMB_DEEPER_1_OPTION_EXAMINE",
				reqs = [{type = "location_has_specific_slaves", check = true, reqs = [{code = "unique", value = "heleviel"}]}],
				type = "next_dialogue"
			},
			{
				code = "emp_catacomb_doors_myr",
				text = "ACT4_CATACOMB_DEEPER_1_OPTION_EXAMINE",
				reqs = [{type = "location_has_specific_slaves", check = false, reqs = [{code = "unique", value = "heleviel"}]}],
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
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_catacomb_doors_heleviel",
				text = "ACT4_CATACOMB_DOORS_HELEVIEL_OPTION_READ",
				reqs = [],
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
		music = "erdyna_theme",
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
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "emp_myr_catacomb_writing",
				text = "ACT4_MYR_CATACOMB_WRITING_OPTION_BELONG",
				reqs = [],
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
	},
	act4_erdyna_lineage_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_LINEAGE_1",
		options = [
			{
				code = "act4_erdyna_lineage_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_lineage_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_LINEAGE_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "make_quest_location", value = "quest_thalendir_house"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_erdyna_visit_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_VISIT_1",
		options = [
			{
				code = "act4_erdyna_visit_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_visit_2 = {
		image = null,
		character = "erdyna",
		character2 = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_VISIT_2",
		options = [
			{
				code = "act4_erdyna_visit_entry_reply",
				text = "ACT4_ERDYNA_VISIT_2_OPTION_CALM",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "act4_erdyna_visit_entry_reply",
				text = "ACT4_ERDYNA_VISIT_2_OPTION_WEAPON",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	act4_erdyna_visit_entry_reply = {
		image = null,
		character = "erdyna",
		character2 = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_VISIT_ENTRY_REPLY_CALM",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_VISIT_ENTRY_REPLY_WEAPON",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ERDYNA_VISIT_ENTRY_REPLY_ANY",
				reqs = []
			}
		],
		options = [
			{
				code = "act4_erdyna_ward_reply",
				text = "ACT4_ERDYNA_WARD_OPTION_WHAT",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "act4_erdyna_ward_reply",
				text = "ACT4_ERDYNA_WARD_OPTION_RELEASE",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2
			},
			{
				code = "act4_erdyna_ward_reply",
				text = "ACT4_ERDYNA_WARD_OPTION_DRAGONKIN",
				reqs = [{type = "master_check", value = [{code = "race", race = "dragonkin", check = true}]}],
				type = "next_dialogue",
				dialogue_argument = 3
			}
		]
	},
	act4_erdyna_ward_reply = {
		image = null,
		character = "erdyna",
		character2 = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_WARD_REPLY_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_WARD_REPLY_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ERDYNA_WARD_REPLY_3",
				reqs = [],
				previous_dialogue_option = 3
			},
			{
				text = "ACT4_ERDYNA_WARD_REPLY_ANY",
				reqs = []
			}
		],
		options = [
			{
				code = "act4_erdyna_negotiate_intro",
				text = "ACT4_ERDYNA_WARD_OPTION_NEGOTIATE",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "act4_erdyna_fight_entry",
				text = "ACT4_ERDYNA_WARD_OPTION_FIGHT",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_negotiate_intro = {
		image = null,
		character = "erdyna",
		character2 = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_NEGOTIATE_INTRO",
		options = [
			{
				code = "act4_erdyna_negotiate_hub",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_negotiate_hub = {
		image = null,
		character = "erdyna",
		character2 = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_NEGOTIATE_HUB_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_ERDYNA_NEGOTIATE_HUB_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_NEGOTIATE_HUB_4",
				reqs = [],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "act4_erdyna_negotiate_hub",
				text = "ACT4_ERDYNA_NEGOTIATE_OPTION_FATE",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_fight_entry",
				text = "ACT4_ERDYNA_NEGOTIATE_OPTION_FORCE",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "act4_erdyna_archive_request_1",
				text = "ACT4_ERDYNA_NEGOTIATE_OPTION_GATES",
				reqs = [],
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_negotiate_hub",
				text = "ACT4_ERDYNA_NEGOTIATE_OPTION_FREE",
				reqs = [{type = "dialogue_selected", value = "ACT4_ERDYNA_NEGOTIATE_OPTION_FATE", check = true}],
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = "close",
				text = "ACT4_ERDYNA_NEGOTIATE_OPTION_LEAVE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "update_city"}]
			}
		]
	},
	act4_erdyna_archive_request_1 = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_ARCHIVE_REQUEST_1",
		options = [
			{
				code = "act4_erdyna_archive_request_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_archive_request_2 = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_ARCHIVE_REQUEST_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "act4_erdyna_archives"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_erdyna_fight_entry = {
		image = null,
		character = "vaeloria",
		character2 = "erdyna",
		music = "threat",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_FIGHT_ENTRY",
		options = [
			{
				code = "act4_erdyna_negotiate_hub",
				text = "ACT4_ERDYNA_FIGHT_ENTRY_OPTION_DOWN",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "quest_fight",
				args = "act4_erdyna_estate_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_fight_win_1 = {
		image = null,
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_FIGHT_WIN_1",
		options = [
			{
				code = "act4_erdyna_fight_win_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_fight_win_2 = {
		image = null,
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_FIGHT_WIN_2",
		options = [
			{
				code = "act4_erdyna_fight_win_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_fight_win_3 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_FIGHT_WIN_3",
		options = [
			{
				code = "act4_erdyna_after_leave_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "decision", value = "ThalendirTakenByForce"}]
			}
		]
	},
	act4_erdyna_return_1 = {
		image = null,
		character = "vaeloria",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_RETURN_1",
		options = [
			{
				code = "act4_erdyna_records_result_1",
				text = "ACT4_3_RECORDS_RETURN_OPTION_HAND_OVER",
				reqs = [{type = "active_quest_stage", value = "erdyna_quest", stage = "act4_erdyna_records", state = true}],
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "DIALOGUELEAVE",
				reqs = [],
				type = "next_dialogue"
			},
		]
	},
	act4_erdyna_records_result_1 = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_RECORDS_RESULT_1",
		options = [
			{
				code = "act4_3_records_result_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_records_result_2 = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RECORDS_RESULT_2",
		options = [
			{
				code = "act4_3_records_negotiation",
				text = "ACT4_3_RECORDS_RESULT_OPTION_ERDYNA",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "act4_3_records_fight_entry",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "act4_3_records_leave_erdyna",
				text = "DIALOGUELEAVE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_records_negotiation = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_3_RECORDS_NEGOTIATION_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_3_RECORDS_CHARM_FAIL",
				reqs = [],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "act4_3_records_charm_result",
				text = "ACT4_3_RECORDS_OPTION_CHARM",
				reqs = [],
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "act4_3_records_bribe",
				text = "ACT4_3_RECORDS_OPTION_BRIBE",
				reqs = [{type = "has_money", value = 5000}],
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 5000}]
			},
			{
				code = "act4_3_records_leave_erdyna",
				text = "ACT4_3_RECORDS_OPTION_LEAVE_ERDYNA",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "act4_3_records_fight_entry",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_records_charm_result = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_3_RECORDS_CHARM_SUCCESS",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "charm_factor", operant = "gte", value = 6}]}]
			},
			{
				text = "ACT4_3_RECORDS_CHARM_FAIL",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "charm_factor", operant = "lt", value = 6}]}]
			}
		],
		options = [
			{
				code = "act4_3_erdyna_released_1",
				text = "DIALOGUECONTINUE",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "charm_factor", operant = "gte", value = 6}]}],
				type = "next_dialogue",
				bonus_effects = [{code = "decision", value = "ThalendirFreedByRecords"}]
			},
			{
				code = "act4_3_records_negotiation",
				text = "DIALOGUECONTINUE",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "charm_factor", operant = "lt", value = 6}]}],
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	act4_3_records_bribe = {
		image = null,
		character = "vaeloria",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RECORDS_BRIBE",
		options = [
			{
				code = "act4_3_erdyna_released_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "decision", value = "ThalendirFreedByBribe"}]
			}
		]
	},
	act4_3_records_fight_entry = {
		image = null,
		character = "vaeloria",
		music = "threat",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RECORDS_FIGHT_ENTRY",
		options = [
			{
				code = "quest_fight",
				args = "act4_erdyna_estate_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_records_leave_erdyna = {
		image = null,
		character = "vaeloria",
		music = "tragic",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RECORDS_LEAVE_ERDYNA",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "ThalendirErdynaAbandoned"},
					{code = "progress_quest", value = "erdyna_quest", stage = "catacombs_opened"},
					{code = "remove_quest_location", value = "quest_thalendir_house"},
					{code = "make_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_3_erdyna_released_1 = {
		image = null,
		character = "vaeloria",
		character2 = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_RELEASED_1",
		options = [
			{
				code = "act4_3_erdyna_released_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_erdyna_released_2 = {
		image = null,
		character = "vaeloria",
		character2 = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_RELEASED_2",
		options = [
			{
				code = "act4_3_erdyna_released_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_erdyna_released_3 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "blackscreen_transition_common", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_RELEASED_3",
		options = [
			{
				code = "act4_erdyna_after_leave_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "remove_quest_location", value = "quest_thalendir_house"}
				]
			}
		]
	},
	act4_erdyna_after_leave_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_AFTER_LEAVE_1",
		options = [
			{
				code = "act4_erdyna_after_leave_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_after_leave_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_AFTER_LEAVE_2",
		options = [
			{
				code = "act4_erdyna_after_leave_reveal",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_QUIET",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "act4_erdyna_after_leave_reveal",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_DRAGONKIN",
				reqs = [],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	act4_erdyna_after_leave_reveal = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_REVEAL_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_REVEAL_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_REVEAL_ANY_1",
				reqs = []
			}
		],
		options = [
			{
				code = "act4_erdyna_after_leave_reveal_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_after_leave_reveal_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_AFTER_LEAVE_REVEAL_ANY_2",
		options = [
			{
				code = "act4_erdyna_after_leave_hub",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_after_leave_hub = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_0",
				reqs = [],
				previous_dialogue_option = 0
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_1",
				reqs = [],
				previous_dialogue_option = 1
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_2",
				reqs = [],
				previous_dialogue_option = 2
			},
			{
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_3",
				reqs = [],
				previous_dialogue_option = 3
			},
		],
		options = [
			{
				code = "act4_erdyna_after_leave_hub",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_GANG",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_after_leave_hub",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_SORRY",
				reqs = [],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_after_leave_hub",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_HONOR",
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "act4_erdyna_flirt_result",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_FLIRT",
				reqs = [],
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "close",
				text = "ACT4_ERDYNA_AFTER_LEAVE_OPTION_REST",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "erdyna_return"},
					{code = "remove_quest_location", value = "quest_thalendir_house"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_erdyna_flirt_result = {
		variations = [
			{
				reqs = [{type = "master_check", value = [{code = "stat", stat = "sexuals_factor", operant = "gte", value = 5}]}],
				image = null,
				character = "erdyna",
				tags = ["dialogue_scene", "act4_erdyna"],
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_4_SUCCESS",
				options = [
					{
						code = "erdyna_campfire_1",
						text = "DIALOGUECONTINUE",
						reqs = [],
						type = "next_dialogue"
					}
				]
			},
			{
				reqs = [{type = "master_check", value = [{code = "stat", stat = "sexuals_factor", operant = "lt", value = 5}]}],
				image = null,
				character = "erdyna",
				tags = ["dialogue_scene", "act4_erdyna"],
				text = "ACT4_ERDYNA_AFTER_LEAVE_HUB_4_FAIL",
				options = [
					{
						code = "act4_erdyna_after_leave_hub",
						text = "DIALOGUECONTINUE",
						reqs = [],
						type = "next_dialogue"
					}
				]
			}
		]
	},
	act4_erdyna_melchor_archives_1 = {
		image = null,
		character = "chancellor",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_MELCHOR_ARCHIVES_1",
		options = [
			{
				code = "act4_erdyna_melchor_archives_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_melchor_archives_2 = {
		image = null,
		character = "chancellor",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_MELCHOR_ARCHIVES_2",
		options = [
			{
				code = "act4_erdyna_grotus_offer_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "screen_black_transition", value = 1}]
			}
		]
	},
	act4_erdyna_grotus_offer_1 = {
		image = null,
		character = "grotus",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_GROTUS_OFFER_1",
		options = [
			{
				code = "act4_erdyna_grotus_price",
				text = "ACT4_ERDYNA_GROTUS_OFFER_OPTION_PRICE",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "act4_erdyna_grotus_offer_2",
				text = "ACT4_ERDYNA_GROTUS_OFFER_OPTION_NOT_INTERESTED",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_grotus_price = {
		image = null,
		character = "grotus",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_GROTUS_PRICE",
		options = [
			{
				code = "act4_erdyna_grotus_delivery",
				text = "ACT4_ERDYNA_GROTUS_PRICE_OPTION_PAY",
				reqs = [{type = "has_money", value = 3000}],
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 3000}]
			},
			{
				code = "act4_erdyna_grotus_offer_2",
				text = "ACT4_ERDYNA_GROTUS_PRICE_OPTION_NO",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_grotus_offer_2 = {
		image = null,
		character = "grotus",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_GROTUS_OFFER_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [{type = "active_quest_stage", value = "erdyna_quest", stage = "act4_erdyna_archives", state = true}],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "archive_search"},
					{
						code = "add_special_task_for_location",
						location = "empire_capital",
						amount = 4,
						descript = "ACT4_ERDYNA_ARCHIVE_SEARCH_TASK_DESC",
						name = "ACT4_ERDYNA_ARCHIVE_SEARCH_TASK_NAME",
						max_workers = 2,
						workstat = "wits",
						icon = "res://assets/Textures_v2/MANSION/quest_task.png",
						args = [{code = "start_event", data = "act4_erdyna_archive_search_complete_1", args = {}}]
					},
					{code = "update_city"}
				]
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [{type = "active_quest_stage", value = "erdyna_quest", stage = "archive_search", state = true}],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_grotus_find = {
		image = null,
		character = "grotus",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_GROTUS_FIND",
		options = [
			{
				code = "act4_erdyna_grotus_delivery",
				text = "ACT4_ERDYNA_GROTUS_FIND_OPTION_PAY",
				reqs = [{type = "has_money", value = 3000}],
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 3000}]
			},
			{
				code = "act4_erdyna_grotus_offer_2",
				text = "ACT4_ERDYNA_GROTUS_FIND_OPTION_NOT_YET",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_grotus_delivery = {
		image = null,
		character = "grotus",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_GROTUS_DELIVERY_1",
		options = [
			{
				code = "act4_erdyna_grotus_delivery_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "screen_black_transition", value = 1}]
			}
		]
	},
	act4_erdyna_grotus_delivery_2 = {
		image = null,
		character = "grotus",
		tags = ["dialogue_scene", "blackscreen_transition_common", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_GROTUS_DELIVERY_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "remove_special_task_for_location",
						location = "empire_capital",
						event = "act4_erdyna_archive_search_complete_1"
					},
					{code = "progress_quest", value = "erdyna_quest", stage = "act4_erdyna_records"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_erdyna_archive_search_complete_1 = {
		image = null,
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_ARCHIVE_SEARCH_COMPLETE_1",
		options = [
			{
				code = "act4_erdyna_archive_search_complete_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_erdyna_archive_search_complete_2 = {
		image = null,
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_ARCHIVE_SEARCH_COMPLETE_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "archive_dungeon"},
					{code = "make_quest_location", value = "quest_thalendir_archive_hideout"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_erdyna_archive_dungeon_complete = {
		image = null,
		music = "dungeon",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_ERDYNA_ARCHIVE_DUNGEON_COMPLETE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "set_completed_active_location"},
					{code = "progress_quest", value = "erdyna_quest", stage = "act4_erdyna_records"},
					{code = "update_city"}
				]
			}
		]
	},
	erdyna_capital_return_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_CAPITAL_RETURN_1",
		options = [
			{
				code = "erdyna_capital_return_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	erdyna_capital_return_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_CAPITAL_RETURN_2",
		options = [
			{
				code = "erdyna_capital_return_3",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	erdyna_capital_return_3 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_CAPITAL_RETURN_3",
		options = [
			{
				code = "erdyna_capital_return_help",
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_OPTION_HELP",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "erdyna_capital_return_physics",
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_OPTION_PHYSICS",
				reqs = [],
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "erdyna_capital_return_leave",
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_OPTION_LEAVE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	erdyna_capital_return_help = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_CAPITAL_RETURN_HELP",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "erdyna_hideout"},
					{code = "update_city"}
				]
			}
		]
	},
	erdyna_capital_return_physics = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = [
			{
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_PHYSICS_SUCCESS",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "gte", value = 5}]}]
			},
			{
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_PHYSICS_FAIL",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "lt", value = 5}]}]
			}
		],
		options = [
			{
				code = "close",
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_OPTION_GOOD",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "gte", value = 5}]}],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "catacombs_opened"},
					{code = "make_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "update_city"}
				]
			},
			{
				code = "erdyna_capital_return_help",
				text = "ACT4_3_ERDYNA_CAPITAL_RETURN_OPTION_KIDDING",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "gte", value = 5}]}],
				type = "next_dialogue"
			},
			{
				code = "erdyna_capital_return_3",
				text = "DIALOGUECONTINUE",
				reqs = [{type = "master_check", value = [{code = "stat", stat = "physics_factor", operant = "lt", value = 5}]}],
				type = "next_dialogue"
			}
		]
	},
	erdyna_capital_return_leave = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_CAPITAL_RETURN_LEAVE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "ErdynaLeftForRedRooksAlone"},
					{code = "complete_quest", value = "erdyna_quest"},
					{code = "update_city"}
				]
			}
		]
	},
	erdyna_old_hideout_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_OLD_HIDEOUT_1",
		options = [
			{
				code = "erdyna_old_hideout_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	erdyna_old_hideout_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_OLD_HIDEOUT_2",
		options = [
			{
				code = "erdyna_old_hideout_move",
				text = "ACT4_3_ERDYNA_OLD_HIDEOUT_OPTION_CRUSH",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "erdyna_old_hideout_move",
				text = "ACT4_3_ERDYNA_OLD_HIDEOUT_OPTION_CAREFUL",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "erdyna_old_hideout_move",
				text = "ACT4_3_ERDYNA_OLD_HIDEOUT_OPTION_SORRY",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	erdyna_old_hideout_move = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ERDYNA_OLD_HIDEOUT_MOVE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "erdyna_quest", stage = "red_rooks_fort"},
					{code = "make_quest_location", value = "quest_red_rooks_old_fort"},
					{code = "update_city"}
				]
			}
		]
	},
	red_rooks_old_fort_complete_1 = {
		image = null,
		character = "erdyna",
		music = "threat",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_COMPLETE_1",
		options = [
			{
				code = "red_rooks_old_fort_complete_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	red_rooks_old_fort_complete_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_COMPLETE_2",
		options = [
			{
				code = "red_rooks_betrayal_entry",
				text = "ACT4_3_RED_ROOKS_OPTION_BETRAY",
				reqs = [],
				type = "next_dialogue"
			},
			{
				code = "red_rooks_leader_refuse",
				text = "ACT4_3_RED_ROOKS_OPTION_REFUSE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	red_rooks_betrayal_entry = {
		image = null,
		character = "erdyna",
		music = "threat",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_BETRAYAL_ENTRY",
		options = [
			{
				code = "quest_fight",
				args = "act4_3_erdyna_betrayal_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	red_rooks_betrayal_win_1 = {
		image = null,
		character = "erdyna",
		music = "tragic",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_BETRAYAL_WIN",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "money_change", operant = "+", value = 1000},
					{code = "affect_unique_character", name = "erdyna", type = "slavetype", value = "slave"},
					{code = "decision", value = "ErdynaBetrayedRedRooks"},
					{code = "complete_quest", value = "erdyna_quest"},
					{code = "set_completed_active_location"},
					{code = "update_city"}
				]
			}
		]
	},
	red_rooks_leader_refuse = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_REFUSE",
		options = [
			{
				code = "quest_fight",
				args = "act4_3_red_rooks_leader_fight",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	red_rooks_leader_win_1 = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_LEADER_WIN_1",
		options = [
			{
				code = "red_rooks_leader_win_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [{code = "screen_black_transition", value = 1}]
			}
		]
	},
	red_rooks_leader_win_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "blackscreen_transition_common", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_RED_ROOKS_LEADER_WIN_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "ErdynaBandRescued"},
					{code = "progress_quest", value = "erdyna_quest", stage = "catacombs_opened"},
					{code = "set_completed_active_location"},
					{code = "make_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_3_sealed_doors_alone_1 = {
		image = null,
		music = "dungeon",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_SEALED_DOORS_ALONE_1",
		options = [
			{
				code = "act4_3_sealed_doors_alone_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_sealed_doors_alone_2 = {
		image = null,
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_SEALED_DOORS_ALONE_2",
		options = [
			{
				code = "act4_3_opened_seal_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_sealed_doors_erdyna_1 = {
		image = null,
		character = "erdyna",
		music = "dungeon",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_SEALED_DOORS_ERDYNA_1",
		options = [
			{
				code = "act4_3_sealed_doors_erdyna_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_sealed_doors_erdyna_2 = {
		image = null,
		character = "erdyna",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_SEALED_DOORS_ERDYNA_2",
		options = [
			{
				code = "act4_3_opened_seal_1",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_opened_seal_1 = {
		image = null,
		music = "dungeon",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_OPENED_SEAL_1",
		options = [
			{
				code = "act4_3_opened_seal_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_opened_seal_2 = {
		image = null,
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_OPENED_SEAL_2",
		options = [
			{
				code = "quest_fight",
				args = "act4_3_opened_seal_cultists",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [],
				type = "next_dialogue"
			}
		]
	},
	act4_3_opened_seal_after_fight = {
		image = null,
		music = "dungeon",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_OPENED_SEAL_AFTER_FIGHT",
		options = [
			{
				code = "act4_3_artifact_found_alone",
				text = "DIALOGUECONTINUE",
				reqs = [{type = "decision", value = "ErdynaBetrayedRedRooks", check = true}],
				type = "next_dialogue"
			},
			{
				code = "act4_3_artifact_found_alone",
				text = "DIALOGUECONTINUE",
				reqs = [{type = "decision", value = "ThalendirErdynaAbandoned", check = true}],
				type = "next_dialogue"
			},
			{
				code = "act4_3_artifact_found_erdyna",
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = "decision", value = "ErdynaBetrayedRedRooks", check = false},
					{type = "decision", value = "ThalendirErdynaAbandoned", check = false}
				],
				type = "next_dialogue"
			}
		]
	},
	act4_3_artifact_found_alone = {
		image = null,
		music = "dungeon",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ARTIFACT_FOUND_ALONE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "remove_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "complete_quest", value = "erdyna_quest"},
					{code = "update_city"}
				]
			}
		]
	},
	act4_3_artifact_found_erdyna = {
		image = null,
		character = "erdyna",
		music = "erdyna_theme",
		tags = ["dialogue_scene", "act4_erdyna"],
		reqs = [],
		text = "ACT4_3_ARTIFACT_FOUND_ERDYNA",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "remove_quest_location", value = "quest_empire_catacomb_entry"},
					{code = "complete_quest", value = "erdyna_quest"},
					{code = "update_city"}
				]
			}
		]
	}
}
