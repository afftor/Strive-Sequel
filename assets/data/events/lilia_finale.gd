extends Reference
var data = {
	lilia_finale_1 = {
		image = "letter",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINALE_LETTER",
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
						value = "lilia_finale_quest",
						stage = "stage1"
					}
				]
			}
		]
	},
	lilia_finale_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "sigmund",
		text = [
			{
				text = "LILIA_FINALE_WORKERS_1",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "make_quest_location",
				value = "quest_elven_ancient_jungle_location"
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
						value = "lilia_finale_quest",
						stage = "stage2"
					}
				]
			}
		]
	},
	lilia_finale_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINALE_WORKERS_2",
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
						value = "lilia_finale_quest",
						stage = "stage3"
					},
					{
						code = "remove_quest_location",
						value = "quest_elven_ancient_jungle_location"
					}
				]
			}
		]
	},
	lilia_finale_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "sigmund",
		text = [
			{
				text = "LILIA_FINALE_WORKERS_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_finale_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "return_to_mansion"
					}
				]
			}
		]
	},
	lilia_finale_5 = {
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "LILIA_FINALE_1",
		options = [
			{
				code = "lilia_finale_6",
				text = "LILIA_FINALE_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilia_finale_7",
				text = "LILIA_FINALE_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		],
		image = "lilia_gem"
	},
	lilia_finale_6 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINALE_2",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "lilia_finale_8",
				text = "LILIA_FINALE_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilia_finale_8",
				text = "LILIA_FINALE_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilia_finale_9",
				text = "LILIA_FINALE_2_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		],
		image = "lilia_gem"
	},
	lilia_finale_7 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FINALE_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "lilia_finale_8",
				text = "LILIA_FINALE_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilia_finale_8",
				text = "LILIA_FINALE_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilia_finale_9",
				text = "LILIA_FINALE_2_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilia_finale_8 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FINALE_2_1AND2",
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
						code = "add_timed_event",
						value = "lilith_flirting_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									4
								],
								hour = 1
							}
						]
					},
					{
						code = "progress_quest",
						value = "lilia_finale_quest",
						stage = "stage4"
					}
				]
			}
		]
	},
	lilia_finale_9 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FINALE_2_3",
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
						code = "add_timed_event",
						value = "lilith_flirting_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									4
								],
								hour = 1
							}
						]
					},
					{
						code = "progress_quest",
						value = "lilia_finale_quest",
						stage = "stage4"
					}
				]
			}
		]
	},
	lilith_flirting_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FLIRTING_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_flirting_2",
				text = "LILIA_FLIRTING_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_flirting_2",
				text = "LILIA_FLIRTING_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_flirting_2",
				text = "LILIA_FLIRTING_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilith_flirting_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FLIRTING_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_flirting_3",
				text = "LILIA_FLIRTING_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_flirting_3",
				text = "LILIA_FLIRTING_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_flirting_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FLIRTING_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_flirting_4",
				text = "LILIA_FLIRTING_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_flirting_4",
				text = "LILIA_FLIRTING_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_flirting_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_FLIRTING_3",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "make_quest_location",
				value = "quest_lilia_dungeon_grove"
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
						value = "lilia_finale_quest",
						stage = "stage5"
					}
				]
			}
		]
	},
	lilith_finish_dungeon_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINISH_DUNGEON_1",
				reqs = [

				]
			},
			{
				text = "LILIA_FINISH_DUNGEON_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LILIA_FINISH_DUNGEON_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "LILIA_FINISH_DUNGEON_2_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "lilith_finish_dungeon_1",
				text = "LILIA_FINISH_DUNGEON_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_1",
				text = "LILIA_FINISH_DUNGEON_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_1",
				text = "LILIA_FINISH_DUNGEON_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_2",
				text = "LILIA_FINISH_DUNGEON_1_OPTION_4",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue"
			}
		],
		character = "lilia"
	},
	lilith_finish_dungeon_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINISH_DUNGEON_2_4",
				reqs = [

				],
				previous_dialogue_option = 4
			},
			{
				text = "LILIA_FINISH_DUNGEON_3_1_GOOD",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm_factor",
								operant = "gte",
								value = 3
							}
						]
					}
				],
				previous_dialogue_option = 1
			},
			{
				text = "LILIA_FINISH_DUNGEON_3_1_BAD",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm_factor",
								operant = "lt",
								value = 3
							}
						]
					}
				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "lilith_finish_dungeon_2",
				text = "LILIA_FINISH_DUNGEON_2_4_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_fight",
				text = "LILIA_FINISH_DUNGEON_2_4_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_3",
				text = "LILIA_FINISH_DUNGEON_2_4_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_3",
				text = "LILIA_FINISH_DUNGEON_2_4_OPTION_4",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue"
			}
		],
		character = "lilia"
	},
	lilith_finish_dungeon_fight = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINISH_DUNGEON_3_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "robbed_man",
				text = "DIALOGUEFIGHTOPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_finish_dungeon_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_FINISH_DUNGEON_3_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "LILIA_FINISH_DUNGEON_3_4",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "lilith_finish_dungeon_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_finish_dungeon_4 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "LILIA_FINISH_DUNGEON_4",
		options = [
			{
				code = "lilia_transform_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		],
		character = "lilia"
	},
	lilith_finish_dungeon_after_scene = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_finish_dungeon_after_scene_1",
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_after_scene_1",
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_finish_dungeon_after_scene_1",
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilith_finish_dungeon_after_scene_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "LILIA_FINISH_DUNGEON_AFTER_SCENE_1_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		common_effects = [
			{
				code = "unique_character_changes",
				value = "lilia",
				args = [
					{
						code = "transform_to_unique_character",
						unique = "Lilith"
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
						code = "add_timed_event",
						value = "lilith_bad_route_1",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									3
								],
								hour = 1
							}
						]
					},
					{
						code = "complete_quest",
						value = "lilia_finale_quest",
#						stage = "stage6"
					},
					{
						code = "remove_quest_location",
						value = "quest_lilia_dungeon_grove"
					}
				]
			}
		]
	},
	lilith_good_route_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_2",
				text = "LILIA_GOOD_ROUTE_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_2",
				text = "LILIA_GOOD_ROUTE_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_1_CHOICE_1",
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
						code = "add_timed_event",
						value = "lilith_good_route_3",
						args = [
							{
								type = "add_to_date",
								date = [
									3,
									3
								],
								hour = 1
							}
						]
					},
					{
						code = "progress_quest",
						value = "lilia_finale_quest",
						stage = "stage7"
					},
					{
						code = "remove_quest_location",
						value = "quest_lilia_dungeon_grove"
					}
				]
			}
		]
	},
	lilith_good_route_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_4",
				text = "LILIA_GOOD_ROUTE_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_4",
				text = "LILIA_GOOD_ROUTE_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LILIA_GOOD_ROUTE_2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "LILIA_GOOD_ROUTE_2_CONTINUE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_5",
				text = "LILIA_GOOD_ROUTE_2_CONTINUE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "lilith_good_route_5",
				text = "LILIA_GOOD_ROUTE_2_CONTINUE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2
			}
		]
	},
	lilith_good_route_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_2_CLOSE",
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
						value = "lilia_finale_quest",
						stage = "stage8"
					}
				]
			}
		]
	},
	lilith_good_route_village = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_village_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_village_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3_CONTINUE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_village_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_village_2 = {
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		text = "LILIA_GOOD_ROUTE_3_CONTINUE_2",
		options = [
			{
				code = "lilith_good_route_village_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "lilia_unicorn"
	},
	lilith_good_route_village_3 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILIA_GOOD_ROUTE_3_CONTINUE_3",
		options = [
			{
				code = "lilith_good_route_village_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "lilia_unicorn"
	},
	lilith_good_route_village_4 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "bandits",
		text = "LILIA_GOOD_ROUTE_3_BANDIT",
		options = [
			{
				code = "lilith_good_route_village_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_village_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3_CONTINUE_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_village_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_village_6 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "bandits",
		text = "LILIA_GOOD_ROUTE_3_CONTINUE_5",
		options = [
			{
				code = "lilith_good_route_village_7",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		character2 = "lilia"
	},
	lilith_good_route_village_7 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "bandits",
		text = "LILIA_GOOD_ROUTE_3_CONTINUE_6",
		options = [
			{
				code = "lilith_good_route_village_8",
				text = "LILIA_GOOD_ROUTE_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "quest_fight",
				args = "lilia_boss",
				text = "LILIA_GOOD_ROUTE_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "quest_fight",
				args = "lilia_boss",
				text = "LILIA_GOOD_ROUTE_3_OPTION_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_village_11",
				text = "LILIA_GOOD_ROUTE_3_OPTION_4",
				reqs = [

				],
				dialogue_argument = 4,
				type = "next_dialogue"
			}
		],
		character2 = "lilia"
	},
	lilith_good_route_village_8 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3_CHOICE_1",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "money_change",
				operant = "+",
				value = 700
			}
		],
		options = [
			{
				code = "lilith_good_route_village_8_1",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_1_OPTION_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm_factor",
								operant = "gte",
								value = 5
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_village_8_2",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_1_OPTION_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm_factor",
								operant = "lt",
								value = 5
							}
						]
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_village_8_2",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_village_8_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3_CHOICE_1_1",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "make_scene_character",
				value = [
					{
						type = "function",
						function = "make_local_recruit",
						args = {
							races = [
								[
									"Fairy",
									3
								]
							],
							difficulty = [
								0,
								1
							],
							type = "slave"
						}
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "lilia_finale_quest"
					},
					{
						code = "update_location"
					}
				]
			}
		]
	},
	lilith_good_route_village_8_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILIA_GOOD_ROUTE_3_CHOICE_1_2",
		common_effects = [
			{
				code = "unique_character_changes",
				value = "lilia",
				args = [
					{
						code = "remove_character"
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "lilia_finale_quest"
					},
					{
						code = "update_location"
					}
				]
			}
		]
	},
	lilith_good_route_village_win = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3_CHOICE_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_good_route_village_8_1",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_2_OPTION_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm",
								operant = "gte",
								value = 80
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_village_9_2",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_2_OPTION_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm",
								operant = "lt",
								value = 80
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_good_route_village_9_2",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_set_fairies_free",
				text = "LILIA_GOOD_ROUTE_3_CHOICE_2_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilith_good_route_village_9_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILIA_GOOD_ROUTE_3_CHOICE_2_2",
		common_effects = [
			{
				code = "unique_character_changes",
				value = "lilia",
				args = [
					{
						code = "remove_character"
					}
				]
			},
			{
				code = "make_scene_character",
				value = [
					{
						type = "function",
						function = "make_local_recruit",
						args = {
							races = [
								[
									"Fairy",
									3
								]
							],
							difficulty = [
								0,
								1
							],
							type = "slave"
						}
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "complete_quest",
						value = "lilia_finale_quest"
					},
					{
						code = "update_location"
					}
				]
			}
		]
	},
	lilith_good_route_village_11 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_GOOD_ROUTE_3_CHOICE_4",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "gte",
								value = 4
							}
						]
					}
				]
			},
			{
				text = "LILIA_GOOD_ROUTE_3_CHOICE_4_1",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "lt",
								value = 4
							}
						]
					}
				]
			}
		],
		options = [
			{
				code = "lilith_good_route_village_win",
				text = "DIALOGUECONTINUE",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "gte",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "quest_fight",
				text = "DIALOGUEFIGHT",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "physics_factor",
								operant = "lt",
								value = 4
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				args = "lilia_boss"
			}
		]
	},
	lilith_set_fairies_free = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_SET_FAIRIES_FREE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_set_fairies_free_1",
				text = "LILIA_SET_FAIRIES_FREE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_set_fairies_free_1",
				text = "LILIA_SET_FAIRIES_FREE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_set_fairies_free_1",
				text = "LILIA_SET_FAIRIES_FREE_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilith_set_fairies_free_1 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_SET_FAIRIES_FREE_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LILIA_SET_FAIRIES_FREE_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "LILIA_SET_FAIRIES_FREE_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "lilith_set_fairies_free_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "lilia_farewell"
	},
	lilith_set_fairies_free_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilia",
		text = [
			{
				text = "LILIA_SET_FAIRIES_FREE_CONTINUE",
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
						code = "complete_quest",
						value = "lilia_finale_quest"
					},
					{
						code = "update_location"
					}
				]
			}
		]
	},
	lilith_bad_route_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BAD_ROUTE_1",
				reqs = [

				],
				previous_dialogue_option = 0
			},
			{
				text = "LILITH_BAD_ROUTE_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		options = [
			{
				code = "lilith_bad_route_1",
				text = "LILITH_BAD_ROUTE_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_bad_route_2",
				text = "LILITH_BAD_ROUTE_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_bad_route_2",
				text = "LILITH_BAD_ROUTE_1_OPTION_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilith_bad_route_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BAD_ROUTE_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "LILITH_BAD_ROUTE_1_3",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "lilith_bad_route_3",
				text = "LILITH_BAD_ROUTE_1_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "lilith_blow_1",
				text = "LILITH_BAD_ROUTE_1_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				change_dialogue_type = 2
			}
		]
	},
	lilith_bad_route_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BAD_ROUTE_1_3_1",
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
						value = "lilith_patron_quest",
						stage = "stage10"
					}
				]
			}
		]
	},
	lilith_bad_route_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BAD_ROUTE_1_3_2",
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
				bonus_effects = [
					{
						code = "progress_quest",
						value = "lilith_patron_quest",
						stage = "stage10"
					}
				]
			}
		]
	},
	lilith_bad_route_village = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BAD_ROUTE_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_bad_route_village_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_bad_route_village_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BAD_ROUTE_2_CONTINUE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_bad_route_village_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_bad_route_village_2 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILITH_BAD_ROUTE_2_CONTINUE_2",
		options = [
			{
				code = "lilith_bad_route_village_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		],
		image = "lilith_angry"
	},
	lilith_bad_route_village_3 = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "LILITH_BAD_ROUTE_2_CONTINUE_3",
		options = [
			{
				code = "lilith_bad_route_village_4",
				text = "LILITH_BAD_ROUTE_2_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_bad_route_village_4",
				text = "LILITH_BAD_ROUTE_2_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		],
		image = "lilith_angry"
	},
	lilith_bad_route_village_4 = {
		image = "lilith_angry",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_BAD_ROUTE_2_CHOICE_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LILITH_BAD_ROUTE_2_CHOICE_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "lilith_proposal_1",
				text = "LILITH_BAD_ROUTE_2_CHOICE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_proposal_2",
				text = "LILITH_BAD_ROUTE_2_CHOICE_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_proposal_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_ACCEPT_PROPOSAL_1",
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
						value = "lilith_patron_quest",
						stage = "stage11"
					},
					{
						code = "add_timed_event",
						value = "lilith_ride_1",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	lilith_proposal_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_REFUSE_PROPOSAL_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_proposal_3",
				text = "LILITH_REFUSE_OPTION_0_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_proposal_4",
				text = "LILITH_REFUSE_OPTION_0_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "lilith_proposal_4",
				text = "LILITH_REFUSE_OPTION_0_3",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	lilith_proposal_3 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_REFUSE_OPTION_1",
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
						value = "lilith_patron_quest",
						stage = "stage11"
					},
					{
						code = "add_timed_event",
						value = "lilith_ride_1",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	lilith_proposal_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_REFUSE_OPTION_2",
				reqs = [

				],
				previous_dialogue_option = 2,
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "lilith",
						args = [
							{
								code = "loyalty",
								operant = "+",
								value = 50
							}
						]
					}
				]
			},
			{
				text = "LILITH_REFUSE_OPTION_3",
				reqs = [

				],
				previous_dialogue_option = 3,
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "lilith",
						args = [
							{
								code = "loyalty",
								operant = "+",
								value = 20
							}
						]
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
						value = "lilith_patron_quest",
						stage = "stage11"
					},
					{
						code = "add_timed_event",
						value = "lilith_ride_1",
						args = [
							{
								type = "add_to_date",
								date = [
									5,
									5
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	lilith_after_sex_scene = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_NEW_SEX_SCENE",
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
						value = "lilith_patron_quest",
						stage = "stage12"
					}
				]
			}
		]
	},
	lilith_mage_guild_option = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "myr",
		text = [
			{
				text = "LILITH_MAGE_GUILD_OPTION",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "make_quest_location",
				value = "quest_mages_xari"
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
						value = "lilith_patron_quest",
						stage = "stage13"
					}
				]
			}
		]
	},
	lilith_xari_location = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "xari",
		text = [
			{
				text = "LILITH_XARI_LOCATION",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_thank_xari",
				text = "LILITH_THANK_XARI_OPTION",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_thank_xari = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "xari",
		text = [
			{
				text = "LILITH_THANK_XARI",
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
						value = "lilith_patron_quest",
						stage = "stage14"
					},
					{
						code = "update_location"
					}
				]
			}
		]
	},
	lilith_patron_meeting = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_PATRON_MEETING",
				reqs = [
					{
						type = "unique_character_checks",
						name = "lilith",
						value = [
							{
								code = "trait",
								trait = "loyalty_callmaster",
								check = false
							}
						]
					}
				]
			},
			{
				text = "LILITH_PATRON_MEETING_2",
				reqs = [
					{
						type = "unique_character_checks",
						name = "lilith",
						value = [
							{
								code = "trait",
								trait = "loyalty_callmaster",
								check = true
							}
						]
					}
				],
				bonus_effects = [
					{
						code = "make_quest_location",
						value = "quest_patron_ancient_jungle_location"
					}
				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "unique_character_checks",
						name = "lilith",
						value = [
							{
								code = "trait",
								trait = "loyalty_callmaster",
								check = false
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [
					{
						type = "unique_character_checks",
						name = "lilith",
						value = [
							{
								code = "trait",
								trait = "loyalty_callmaster",
								check = true
							}
						]
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "lilith_patron_quest",
						stage = "stage15"
					}
				]
			}
		]
	},
	lilith_finish_new_dungeon = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_FINISH_NEW_DUNGEON",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_deal_1",
				text = "LILITH_FINISH_NEW_DUNGEON_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_deal_1",
				text = "LILITH_FINISH_NEW_DUNGEON_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_deal_1 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_DEAL_1_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "LILITH_DEAL_1_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "lilith_demon_voice",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_demon_voice = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_DEMON_VOICE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "quest_fight",
				args = "lilith_patron",
				text = "LILITH_DEMON_VOICE_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilith_demon_submission",
				text = "LILITH_DEMON_VOICE_OPTION_2",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "has_profession",
								profession = "warlock",
								check = true
							}
						]
					},
					{
						type = "master_check",
						value = [
							{
								code = "has_profession",
								profession = "witch",
								check = true
							}
						],
						orflag = true
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	lilith_beat_demon = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_BEAT_DEMON",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_after_demon_defeat",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_demon_submission = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_DEMON_SUBMISSION",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_after_demon_defeat",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_after_demon_defeat = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate",
			"blackscreen_transition_common"
		],
		reqs = [

		],
		character = "lilith",
		text = [
			{
				text = "LILITH_AFTER_DEMON_DEFEAT",
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
						code = "complete_quest",
						value = "lilith_patron_quest"
					}
				]
			}
		]
	},
	lilia_transform_1 = {
		custom_background = "lilia_transform_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilia_transform",
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_transform_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilia_transform_2 = {
		custom_background = "lilia_transform_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_transform_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilia_transform_3 = {
		custom_background = "lilia_transform_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_transform_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilia_transform_4 = {
		custom_background = "lilia_transform_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_transform_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilia_transform_5 = {
		custom_background = "lilia_transform_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_transform_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilia_transform_6 = {
		custom_background = "lilia_transform_6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILIA_TRANSFORM_6",
		options = [
			{
				code = "lilia_transform_7",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilia_transform_7 = {
		custom_background = "lilia_transform_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_finish_dungeon_after_scene",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	lilith_blow_1 = {
		custom_background = "lilith_blow_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilith_blow",
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_BLOW_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_blow_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_blow_2 = {
		custom_background = "lilith_blow_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_BLOW_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_blow_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_blow_3 = {
		custom_background = "lilith_blow_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_BLOW_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_blow_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_blow_4 = {
		custom_background = "lilith_blow_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_BLOW_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_blow_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	lilith_blow_5 = {
		custom_background = "lilith_blow_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_BLOW_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_bad_route_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	lilith_ride_1 = {
		custom_background = "lilith_ride_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilith_ride",
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_RIDE_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_ride_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_ride_2 = {
		custom_background = "lilith_ride_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_RIDE_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_ride_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_ride_3 = {
		custom_background = "lilith_ride_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_RIDE_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_ride_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	lilith_ride_4 = {
		custom_background = "lilith_ride_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILITH_RIDE_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilith_after_sex_scene",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	}
}
