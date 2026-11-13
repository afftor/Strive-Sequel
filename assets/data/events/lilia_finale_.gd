extends Reference

var data = {
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
				bonus_effects = [{code = 'decision', value = 'JoinLiliaTransformation'}],
				dialogue_argument = 4,
				type = "next_dialogue"
			}
		],
		character = "$lilia"
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
		character = "$lilia"
	},
	lilith_finish_dungeon_after_scene = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		music = "lilith_theme",
		reqs = [

		],
		character = "$lilith",
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
		character = "$lilith",
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
			{code = 'affect_unique_character', name = 'lilia', type = 'turn_into_unique', value = 'Lilith'},
#			{
#				code = "unique_character_changes",
#				value = "lilia",
#				args = [
#					{
#						code = "transform_to_unique_character",
#						unique = "Lilith"
#					}
#				]
#			}
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
						code = "set_completed_active_location"
					}
#					{
#						code = "remove_quest_location",
#						value = "quest_lilia_dungeon_grove"
#					}
				]
			}
		]
	},
	lilith_bad_route_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$lilith",
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
	lilith_bad_route_4 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$lilith",
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
	lilia_transform_1 = {
		custom_background = "lilia_transform_1",
		scene_type = "ero_scene",
		music = "intimate_dark",
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
					{type = 'decision', value = 'JoinLiliaTransformation', check = false}
				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "lilia_transform_5",
				text = "DIALOGUECONTINUE",
				reqs = [
					{type = 'decision', value = 'JoinLiliaTransformation', check = true}
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
		unlocked_gallery_seq = "lilia_transform_t",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_2_T",
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
				text = "LILIA_TRANSFORM_3_T",
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
				text = "LILIA_TRANSFORM_4_T",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "lilia_transform_9",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	lilia_transform_5 = {
		custom_background = "lilia_transform_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		unlocked_gallery_seq = "lilia_transform_mc",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_5_MC",
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
		text = "LILIA_TRANSFORM_6_MC",
		options = [
			{
				code = "lilia_transform_7",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
			}
		]
	},
	lilia_transform_7 = {
		custom_background = "lilia_transform_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILIA_TRANSFORM_7_MC",
		options = [
			{
				code = "lilia_transform_8",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
			}
		]
	},
	lilia_transform_8 = {
		custom_background = "lilia_transform_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = "LILIA_TRANSFORM_8_MC",
		options = [
			{
				code = "lilia_transform_9",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	lilia_transform_9 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		text = [
			{
				text = "LILIA_TRANSFORM_9",
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
		music = "intimate_funny",
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
		music = "intimate_funny",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilith_ride",
		image = null,
		dialogue_type = 2,
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
