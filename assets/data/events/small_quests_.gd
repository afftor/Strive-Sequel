extends Reference
var data = {
	got_cali_1_1 = {
		music = "cali_theme",
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{text = "GOT_CALI_1_1_WOLF", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'race', operant = 'eq', value = "HalfkinWolf"}, {code = 'stat', stat = 'race', operant = 'eq', value = "BeastkinWolf", orflag = true}]}]},
			{text = "GOT_CALI_1_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'race', operant = 'neq', value = "HalfkinWolf"}, {code = 'stat', stat = 'race', operant = 'neq', value = "BeastkinWolf"}]}]}
		],
		options = [
			{
				code = "got_cali_2_1",
				text = "GOT_CALI_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "got_cali_2_2",
				text = "GOT_CALI_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		],
		custom_background = "force_cali1"
	},
	got_cali_1_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "cali_origin",
		text = [
			{
				text = "GOT_CALI_1_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "got_cali_2_1",
				text = "GOT_CALI_1_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "got_cali_2_2",
				text = "GOT_CALI_1_OPTION_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	got_cali_2_1 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		character = "$cali",
		text = [
			{
				text = "GOT_CALI_2_1",
				reqs = [

				]
			}
		],
		common_effects = [
			{code = "make_story_character", value = "Cali", recruit_from_location = true, slave_category = "slave"},
			{
				code = "decision",
				value = "cali_raped"
			},
			{
				code = "unique_character_changes",
				value = "cali",
				args = [
					{
						code = "take_virginity",
						type = "vaginal",
						partner = "master"
					},
					{
						code = "tag",
						operant = "add",
						value = "no_sex"
					}
				]
			}
		],
		options = [
			{
				code = "force_cali_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 2
			}
		]
	},
	force_cali_1 = {
		custom_background = "force_cali1",
		scene_type = "ero_scene",
		music = "intimate_dark",
		unlocked_gallery_seq = "force_cali",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "FORCE_CALI_1",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "force_cali_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	force_cali_2 = {
		custom_background = "force_cali2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "FORCE_CALI_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "force_cali_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	force_cali_3 = {
		custom_background = "force_cali3",
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
				text = "FORCE_CALI_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "force_cali_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	force_cali_4 = {
		custom_background = "force_cali4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "FORCE_CALI_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "force_cali_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	force_cali_5 = {
		custom_background = "force_cali5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "FORCE_CALI_5",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "force_cali_6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	force_cali_6 = {
		custom_background = "force_cali6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "FORCE_CALI_6",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "plan_mansion_event",
				value = "cali_act1_1"
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
						code = "decision",
						value = "cali_sex"
					},
					{
						code = "set_completed_active_location"
					}
				]
			}
		]
	},
}
