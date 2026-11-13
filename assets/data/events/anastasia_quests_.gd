extends Reference
var data = {
	anastasia_return_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_3_1",
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_liora_good"
					}
				],
				bonus_effects = [
					{code = "affect_unique_character", name = "anastasia", type = "stat", stat = "affection", value = 15}
				]
			},
			{
				text = "ANASTASIA_RETURN_3_2",
				reqs = [
					{
						type = "decision",
						check = true,
						value = "ana_liora_bad"
					}
				],
				bonus_effects = [
					{code = "affect_unique_character", name = "anastasia", type = "stat", stat = "affection", value = -15}
				]
			}
		],
		options = [
			{
				code = "anastasia_return_4",
				text = "ANASTASIA_RETURN_3_OPTION_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "anastasia", type = "stat", stat = "affection", value = 10}
				]
			},
			{
				code = "anastasia_return_5",
				text = "ANASTASIA_RETURN_3_OPTION_2",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "affect_unique_character", name = "anastasia", type = "stat", stat = "affection", value = -15}
				]
			}
		]
	},
	anastasia_return_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		reqs = [

		],
		character = "$anastasia",
		text = [
			{
				text = "ANASTASIA_RETURN_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_blow_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				change_dialogue_type = 2,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "decision",
						value = "ana_pt1_good"
					},
					{
						code = "complete_quest",
						value = "anastasia_quest"
					},
					{
						code = "add_timed_event",
						value = "anastasia_pt2_1",
						args = [
							{
								type = "add_to_date",
								date = [
									2,
									2
								],
								hour = 1
							}
						]
					}
				]
			}
		]
	},
	ana_blow_1 = {
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "ana_blow_1",
		save_scene_to_gallery = true,
		unlocked_char_sprites = {anastasia = ["nighgown"]},
		unlocked_gallery_seq = "ana_blow",
		reqs = [

		],
		text = "ANA_BLOW_1",
		options = [
			{
				code = "ana_blow_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_blow_2 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "ana_blow_2",
		save_scene_to_gallery = true,
		reqs = [

		],
		text = [
			{
				text = "ANA_BLOW_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_blow_3",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_blow_3 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "ana_blow_4",
		save_scene_to_gallery = true,
		reqs = [

		],
		text = [
			{
				text = "ANA_BLOW_3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_blow_4",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_blow_4 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "ana_blow_4",
		save_scene_to_gallery = true,
		reqs = [

		],
		text = [
			{
				text = "ANA_BLOW_4",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "ana_blow_5",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	ana_blow_5 = {
		image = null,
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		scene_type = "ero_scene",
		custom_background = "ana_blow_5",
		save_scene_to_gallery = true,
		reqs = [

		],
		text = [
			{
				text = "ANA_BLOW_5",
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
				type = "next_dialogue"
			}
		]
	}
}
