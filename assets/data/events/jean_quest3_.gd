extends Reference
var data = {
	jean_sylas_client_offer = {
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = [
			{
				text = "JEAN_SYLAS_CLIENT_OFFER",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "JEAN_SYLAS_CLIENT_TELL_MORE",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "JEAN_SYLAS_CLIENT_COST",
				reqs = [

				],
				previous_dialogue_option = 3
			}
		],
		options = [
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_TELL_MORE",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue",
				remove_after_first_use = true
			},
			{
				code = "jean_sylas_client_offer",
				text = "JEAN_SYLAS_CLIENT_OPTION_COST",
				reqs = [

				],
				dialogue_argument = 3,
				type = "next_dialogue",
				remove_after_first_use = true,
				bonus_effects = [
					{
						code = "decision",
						value = "JeanSylasBrothelBargain"
					}
				]
			},
			{
				code = "jean_sylas_client_decline",
				text = "JEAN_SYLAS_CLIENT_OPTION_DECLINE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "jean_sylas_client_accept",
				text = "JEAN_SYLAS_CLIENT_OPTION_ACCEPT",
				reqs = [
					{
						type = "has_money",
						value = 200
					},
					{
						type = "decision",
						value = "JeanSylasBrothelBargain",
						check = false
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 200
					}
				]
			},
			{
				code = "jean_sylas_client_accept",
				text = "JEAN_SYLAS_CLIENT_OPTION_ACCEPT",
				reqs = [
					{
						type = "has_money",
						value = 100
					},
					{
						type = "decision",
						value = "JeanSylasBrothelBargain",
						check = true
					}
				],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "money_change",
						operant = "-",
						value = 100
					}
				]
			}
		]
	},
	jean_sylas_client_accept = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_ACCEPT",
		options = [
			{
				code = "jean_sylas_client_accept_2",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_sylas_client_accept_2 = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		reqs = [

		],
		text = "JEAN_SYLAS_CLIENT_ACCEPT_2",
		options = [
			{
				code = "jean_dream_1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	jean_dream_1 = {
		image = null,
		tags = ["dialogue_scene"],
		unlocked_gallery_seq = "jean_dream",
		save_scene_to_gallery = true,
		reqs = [],
		text = "JEAN_DREAM_1",
		options = [
			{code = "jean_dream_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2}
		]
	},
	jean_dream_2 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene",],
		custom_background = "jean_dream_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "JEAN_DREAM_2",
		options = [
			{code = "jean_dream_3", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}
		]
	},
	jean_dream_3 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene",],
		custom_background = "jean_dream_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "JEAN_DREAM_3",
		options = [
			{code = "jean_dream_4", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}
		]
	},
	jean_dream_4 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene",],
		custom_background = "jean_dream_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "JEAN_DREAM_4",
		options = [
			{code = "jean_dream_5", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}
		]
	},
	jean_dream_5 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene",],
		custom_background = "jean_dream_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "JEAN_DREAM_5",
		options = [
			{code = "jean_dream_6", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}
		]
	},
	jean_dream_6 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene",],
		custom_background = "jean_dream_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "JEAN_DREAM_6",
		options = [
			{code = "jean_sylas_client_after", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1, change_dialogue_type = 1}
		]
	},
}
