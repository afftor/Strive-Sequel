extends Reference
var data = {
	kuro3_dialogue_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DIALOGUE_1",
		options = [
			{
				code = "kuro3_dialogue_2",
				text = "KURO3_DIALOGUE_1_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dialogue_2",
				text = "KURO3_DIALOGUE_1_OPTION_2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dialogue_2",
				text = "KURO3_DIALOGUE_1_OPTION_3",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_dialogue_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO3_DIALOGUE_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO3_DIALOGUE_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO3_DIALOGUE_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_dialogue_3",
				text = "KURO3_DIALOGUE_2_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dialogue_6",
				text = "KURO3_DIALOGUE_2_OPTION_2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_dialogue_3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO3_DIALOGUE_3_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO3_DIALOGUE_3_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO3_DIALOGUE_3_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO3_DIALOGUE_3_4",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "kuro3_dialogue_3",
				text = "KURO3_DIALOGUE_3_OPTION_1",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dialogue_3",
				text = "KURO3_DIALOGUE_3_OPTION_2",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [
					{
						type = "dialogue_selected",
						check = true,
						value = "KURO3_DIALOGUE_3_OPTION_1"
					}
				]
			},
			{
				code = "kuro3_dialogue_3",
				text = "KURO3_DIALOGUE_3_OPTION_3",
				dialogue_argument = 4,
				type = "next_dialogue",
				reqs = [
					{
						type = "unique_character_checks",
						name = "zephyra",
						value = [
							{
								code = "is_free",
								check = true
							}
						]
					}
				]
			},
			{
				code = "kuro3_dialogue_4",
				text = "KURO3_DIALOGUE_3_OPTION_4",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [
					{
						type = "dialogue_selected",
						check = true,
						value = "KURO3_DIALOGUE_3_OPTION_2"
					},
					{
						type = "dialogue_selected",
						check = true,
						value = "KURO3_DIALOGUE_3_OPTION_3"
					}
				]
			},
			{
				code = "kuro_dialogue_start",
				text = "KURO3_DIALOGUE_3_OPTION_5",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_dialogue_4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO3_DIALOGUE_4_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO3_DIALOGUE_4_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "kuro3_dialogue_4",
				text = "KURO3_DIALOGUE_4_OPTION_1",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dialogue_5",
				text = "KURO3_DIALOGUE_4_OPTION_2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "wits",
								operant = "gte",
								value = 150
							}
						]
					}
				]
			},
			{
				code = "kuro_dialogue_start",
				text = "KURO3_DIALOGUE_4_OPTION_3",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_dialogue_5 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_DIALOGUE_5",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character = "kuro"
	},
	kuro3_dialogue_6 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_DIALOGUE_6",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character = "kuro"
	},
	kuro3_init_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO3_INIT_1_1",
				reqs = [

				]
			},
			{
				text = "KURO3_INIT_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO3_INIT_1_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "kuro3_init_1",
				text = "KURO3_INIT_1_OPTION_1",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_init_1",
				text = "KURO3_INIT_1_OPTION_2",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_init_2",
				text = "KURO3_INIT_1_OPTION_3",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_init_2 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_INIT_2",
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
						value = "kuro_quest_3",
						stage = "craft"
					}
				]
			}
		],
		image = "kuro_scroll"
	},
	kuro3_init_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_INIT_3",
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
						value = "kuro_quest_3",
						stage = "depths"
					}
				]
			}
		],
		character = "kuro"
	},
	kuro3_depths_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DEPTHS_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_depths_2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_depths_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DEPTHS_2",
		options = [
			{
				code = "kuro3_depths_3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_torture"
	},
	kuro3_depths_3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DEPTHS_3",
		options = [
			{
				code = "kuro3_depths_4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_torture"
	},
	kuro3_depths_4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DEPTHS_4",
		options = [
			{
				code = "kuro3_depths_5",
				text = "KURO3_DEPTHS_4_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_depths_6",
				text = "KURO3_DEPTHS_4_OPTION_2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_depths_7",
				text = "KURO3_DEPTHS_4_OPTION_3",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_torture"
	},
	kuro3_depths_5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DEPTHS_5",
		options = [
			{
				code = "kuro3_depths_10",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_torture"
	},
	kuro3_depths_6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DEPTHS_6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_depths_10",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_depths_7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "play_sound",
				value = "crunch"
			},
			{
				code = "play_sound",
				value = "groan"
			}
		],
		text = "KURO3_DEPTHS_7",
		options = [
			{
				code = "kuro3_depths_8",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_torture"
	},
	kuro3_depths_8 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "play_sound",
				value = "crunch"
			},
			{
				code = "play_sound",
				value = "groan"
			}
		],
		text = "KURO3_DEPTHS_8",
		options = [
			{
				code = "kuro3_depths_9",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_torture"
	},
	kuro3_depths_9 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DEPTHS_9",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_depths_10",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_depths_10 = {
		reqs = [

		],
		character = "kuro",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO3_DEPTHS_10_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO3_DEPTHS_10_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO3_DEPTHS_10_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO3_DEPTHS_10_4",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "kuro3_depths_10",
				text = "KURO3_DEPTHS_10_OPTION_1",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_depths_10",
				text = "KURO3_DEPTHS_10_OPTION_2",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_depths_10",
				text = "KURO3_DEPTHS_10_OPTION_3",
				dialogue_argument = 4,
				type = "next_dialogue",
				reqs = [

				],
				previous_dialogue_option = [
					2,
					3
				]
			},
			{
				code = "kuro3_depths_11",
				text = "KURO3_DEPTHS_10_OPTION_4",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_depths_11 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_DEPTHS_11",
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
						value = "kuro_quest_3",
						stage = "dungeon"
					},
					{
						code = "make_quest_location",
						value = "quest_dungeon_kuro3"
					}
				]
			}
		],
		character = "kuro"
	},
	kuro3_dungeon_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DUNGEON_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_dungeon_2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_dungeon_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DUNGEON_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_dungeon_3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_dungeon_3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DUNGEON_3",
		options = [
			{
				code = "kuro3_dungeon_4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_cage"
	},
	kuro3_dungeon_4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DUNGEON_4",
		options = [
			{
				code = "kuro3_dungeon_5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_cage"
	},
	kuro3_dungeon_5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DUNGEON_5",
		options = [
			{
				code = "kuro3_dungeon_6",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_cage"
	},
	kuro3_dungeon_6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		text = "KURO3_DUNGEON_6",
		options = [
			{
				code = "kuro3_dungeon_7",
				text = "KURO3_DUNGEON_6_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dungeon_7",
				text = "KURO3_DUNGEON_6_OPTION_2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dungeon_7",
				text = "KURO3_DUNGEON_6_OPTION_3",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_dungeon_7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DUNGEON_7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_dungeon_8",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_dungeon_8 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DUNGEON_8",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_dungeon_9",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro3_dungeon_9 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"blackscreen_transition_slow"
		],
		text = [
			{
				text = "KURO3_DUNGEON_9_1",
				reqs = [{type = "quest_completed", name = "zephyra_disappearance_quest", check = true}]
			},
			{
				text = "KURO3_DUNGEON_9_2",
				reqs = [{type = "quest_completed", name = "zephyra_disappearance_quest", check = false}]
			},
			{
				text = "KURO3_DUNGEON_9",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro3_dungeon_10",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "flash"
	},
	kuro3_dungeon_10 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "kuro",
		text = [
			{
				text = "KURO3_DUNGEON_10",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "nixx_group",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	kuro3_win = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_WIN",
		options = [
			{
				code = "kuro3_good_1",
				text = "KURO3_WIN_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_bad_1",
				text = "KURO3_WIN_OPTION_2",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		image = "kuro_cage"
	},
	kuro3_good_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "KURO3_GOOD_1",
		options = [
			{
				code = "kuro3_good_2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_good_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_GOOD_2",
		options = [
			{
				code = "kuro3_good_3",
				text = "KURO3_GOOD_2_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_good_3",
				text = "KURO3_GOOD_2_OPTION_2",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_good_3",
				text = "KURO3_GOOD_2_OPTION_3",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_good_3 = {
		reqs = [

		],
		character = "kuro",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "KURO3_GOOD_3_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO3_GOOD_3_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "KURO3_GOOD_3_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "KURO3_GOOD_3",
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
						code = "material_change",
						operant = "-",
						material = "vesperine_cage",
						value = 1
					},
					{
						code = "affect_unique_character",
						name = "kuro",
						type = "remove_class",
						class = "nixx_champion"
					},
					{
						code = "affect_unique_character",
						name = "kuro",
						type = "add_class",
						class = "satori"
					},
					{
						code = "complete_quest",
						value = "kuro_quest_3"
					},
					{
						code = "remove_quest_location",
						value = "quest_dungeon_kuro3"
					}
				]
			}
		]
	},
	kuro3_bad_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = "KURO3_BAD_1",
		options = [
			{
				code = "kuro3_bad_2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_bad_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_BAD_2",
		options = [
			{
				code = "kuro3_bad_3",
				text = "KURO3_BAD_2_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_bad_4",
				text = "KURO3_BAD_2_OPTION_2",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_bad_5",
				text = "KURO3_BAD_2_OPTION_3",
				dialogue_argument = 3,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_bad_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_BAD_3",
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
						code = "material_change",
						operant = "-",
						material = "vesperine_cage",
						value = 1
					},
					{
						code = "affect_master",
						type = "add_class",
						class = "asura"
					},
					{
						code = "affect_unique_character",
						name = "kuro",
						type = "remove_class",
						class = "nixx_champion"
					},
					{
						code = "complete_quest",
						value = "kuro_quest_3"
					},
					{
						code = "remove_quest_location",
						value = "quest_dungeon_kuro3"
					}
				]
			}
		],
		character = "kuro"
	},
	kuro3_bad_4 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_BAD_4",
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
						code = "material_change",
						operant = "-",
						material = "vesperine_cage",
						value = 1
					},
					{
						code = "affect_master",
						type = "add_class",
						class = "asura"
					},
					{
						code = "affect_unique_character",
						name = "kuro",
						type = "remove_class",
						class = "nixx_champion"
					},
					{
						code = "affect_unique_character",
						name = "kuro",
						type = "slavetype",
						value = "slave"
					},
					{
						code = "complete_quest",
						value = "kuro_quest_3"
					},
					{
						code = "remove_quest_location",
						value = "quest_dungeon_kuro3"
					}
				]
			}
		],
		character = "kuro"
	},
	kuro3_bad_5 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "KURO3_BAD_5",
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
						code = "material_change",
						operant = "-",
						material = "vesperine_cage",
						value = 1
					},
					{
						code = "affect_master",
						type = "add_class",
						class = "asura"
					},
					{
						code = "affect_unique_character",
						name = "kuro",
						type = "remove"
					},
					{
						code = "complete_quest",
						value = "kuro_quest_3"
					},
					{
						code = "remove_quest_location",
						value = "quest_dungeon_kuro3"
					}
				]
			}
		]
	},
	kuro3_dialogue2_1 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = "KURO3_DIALOGUE_1",
		options = [
			{
				code = "kuro3_dialogue2_2",
				text = "KURO3_DIALOGUE2_1_OPTION_1",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro3_dialogue2_2",
				text = "KURO3_DIALOGUE2_1_OPTION_2",
				dialogue_argument = 2,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	},
	kuro3_dialogue2_2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "KURO3_DIALOGUE2_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "KURO3_DIALOGUE2_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "kuro_dialogue_start",
				text = "DIALOGUEBACK",
				dialogue_argument = 1,
				type = "next_dialogue",
				reqs = [

				]
			}
		],
		character = "kuro"
	}
}
