extends Reference
var data = {
	kuro_hideout_medium = {
		reqs = [

		],
		music = "kuro_theme",
		common_effects = [
			{
				code = "remove_quest_location",
				value = "quest_cult_hideout"
			}
		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_medium2",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_medium2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_medium3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_medium3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_medium4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_medium4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_HIDEOUT_MEDIUM4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				change_dialogue_type = 2,
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex = {
		reqs = [

		],
		music = "intimate_dark",
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX",
				reqs = [

				]
			},
			{
				text = "KURO_HIDEOUT_SEX_SKIP",
				reqs = [
					{
						type = "decision",
						value = "KuroSkippedSex",
						check = true
					}
				]
			},
			{
				text = "KURO_HIDEOUT_SEX_NOSKIP",
				reqs = [
					{
						type = "decision",
						value = "KuroSkippedSex",
						check = false
					}
				]
			},
		],
		options = [
			{
				code = "kuro_hideout_reply_strug",
				text = "KURO_HIDEOUT_OPT_STRUG",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{code = "affect_unique_character", name = "kuro", type = "stat", stat = "affection", value = -10}
				]
			},
			{
				code = "kuro_hideout_sex2",
				text = "KURO_HIDEOUT_OPT_GIVEIN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{code = "affect_unique_character", name = "kuro", type = "stat", stat = "affection", value = 10}
				]
			},
		]
	},
	kuro_hideout_reply_strug = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		text = [
			{
				text = "KURO_HIDEOUT_REPLY_STRUG",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_refuse",
				text = "KURO_HIDEOUT_OPT_STRUG2",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{code = "affect_unique_character", name = "kuro", type = "stat", stat = "affection", value = -20}
				]
			},
			{
				code = "kuro_hideout_sex2",
				text = "KURO_HIDEOUT_OPT_GIVEIN",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
		]
	},
	kuro_hideout_refuse = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		text = [
			{
				text = "KURO_HIDEOUT_REFUSE",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				change_dialogue_type = 1,
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_1",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "kuro_hideout",
		dialogue_type = 2,
		text = [
			{
				text = "KURO_HIDEOUT_SEX2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex4 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex5",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex5 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex6",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex6 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{
				text = "KURO_HIDEOUT_SEX6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_hideout_sex7",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_hideout_sex7 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		custom_background = "kuro_top_5",
		text = [
			{
				text = "KURO_HIDEOUT_SEX7",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_back_start = {
		reqs = [

		],
		music = "kuro_theme",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common"
		],
		common_effects = [
			{
				code = "set_completed_active_location"
			},
			{
				code = "return_to_mansion"
			},
#			{
#				code = "remove_quest_location",
#				value = "quest_cult_parentbase"
#			},
			{
				code = 'affect_unique_character',
				name = 'kuro',
				type = 'set_availability',
				value = true
			}
		],
		character = "$kuro",
		dialogue_type = 1,
		text = [
			{
				text = "KURO_BACK_START",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start2",
				text = "KURO_BACK_OPT_WHAT",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "kuro_back_start2",
				text = "KURO_BACK_OPT_DESERVE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			},
			{
				code = "close",
				text = "KURO_BACK_OPT_SILENT",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				],
				bonus_effects = [
					{
						code = "complete_quest",
						value = "kuro_errand_quest"
					},
					{
						code = 'add_timed_event', value = "kuro3_init_1", args = [{type = 'add_to_date', date = [3,3], hour = 1}]
					}
				]
			},
		]
	},
	kuro_back_start2 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_BACK_START2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start3",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
	kuro_back_start3 = {
		reqs = [

		],
		tags = [
			"dialogue_scene"
		],
		character = "$kuro",
		text = [
			{
				text = "KURO_BACK_START3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "kuro_back_start4",
				text = "DIALOGUECONTINUE",
				dialogue_argument = 9,
				type = "next_dialogue",
				reqs = [

				]
			}
		]
	},
}
