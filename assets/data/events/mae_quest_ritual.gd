extends Reference
var data = {
	mae_spirit_quest_initiate = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [
			{type = "unique_available", name = "mae", check = true, negative = "repeat_next_day"},
			{type = "decision", value = "mae_spirit_quest_started", check = false}
		],
		character = "mae",
		text = "MAE_SPIRIT_QUEST_INITIATE",
		options = [
			{code = "mae_spirit_quest_response", text = "MAE_SPIRIT_QUEST_INITIATE_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_quest_response", text = "MAE_SPIRIT_QUEST_INITIATE_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mae_spirit_quest_response", text = "MAE_SPIRIT_QUEST_INITIATE_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"}
		]
	},
	mae_spirit_quest_response = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SPIRIT_QUEST_INITIATE_RESPONSE_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_SPIRIT_QUEST_INITIATE_RESPONSE_2", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_SPIRIT_QUEST_INITIATE_RESPONSE_3", reqs = [], previous_dialogue_option = 3}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_spirit_quest", stage = "stage0"},
					{code = "decision", value = "mae_spirit_quest_started"},
				]
			}
		]
	},
	mae_spirit_follow_start = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SPIRIT_FOLLOW_START",
		options = [
			{code = "mae_spirit_follow_savra", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_follow_savra = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		character = 'mae',
		character2 = 'savra',
		reqs = [],
		text = "MAE_SPIRIT_FOLLOW_SAVRA",
		options = [
			{code = "mae_spirit_follow_savra_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_follow_savra_2 = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'savra',
		reqs = [],
		text = "MAE_SPIRIT_FOLLOW_SAVRA_2",
		options = [
			{code = "mae_spirit_follow_midnight", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_follow_midnight = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		character = "mae",
		text = "MAE_SPIRIT_FOLLOW_MIDNIGHT",
		options = [
			{code = "mae_spirit_follow_response", text = "MAE_SPIRIT_FOLLOW_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_follow_response", text = "MAE_SPIRIT_FOLLOW_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mae_spirit_follow_response", text = "MAE_SPIRIT_FOLLOW_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"}
		]
	},
	mae_spirit_follow_response = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SPIRIT_FOLLOW_RESPONSE_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_SPIRIT_FOLLOW_RESPONSE_2", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_SPIRIT_FOLLOW_RESPONSE_3", reqs = [], previous_dialogue_option = 3}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_spirit_quest", stage = "stage1"},
					{code = "make_quest_location", value = "quest_mae_spirit_ritual"},
					{code = "update_city"}
				]
			}
		]
	},
	mae_spirit_ritual_start = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = "MAE_SPIRIT_RITUAL_START",
		options = [
			{code = "mae_spirit_ritual_stag_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_ritual_stag_intro = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'white_stag',
		reqs = [],
		text = "MAE_SPIRIT_RITUAL_STAG_INTRO",
		options = [
			{code = "mae_spirit_ritual_stag_challenge", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_ritual_stag_challenge = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'white_stag',
		reqs = [],
		text = "MAE_SPIRIT_RITUAL_STAG_CHALLENGE",
		options = [
			{
				code = "mae_spirit_ritual_stag_accept",
				text = "MAE_SPIRIT_RITUAL_OPTION_PROGRESS",
				reqs = [{type = "local_counter", name = "mae_perverted_actions", operant = "gte", value = 2, check = true}],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_ritual_stag_accept",
				text = "MAE_SPIRIT_RITUAL_OPTION_PERSUADE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				select_person = true,
				challenge = "persuasion"
			},
			{
				code = "mae_spirit_ritual_stag_hide",
				text = "MAE_SPIRIT_RITUAL_OPTION_BARGAIN",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_spirit_ritual_stag_accept = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'white_stag',
		reqs = [],
		text = "MAE_SPIRIT_RITUAL_STAG_ACCEPT",
		options = [
			{code = "mae_spirit_white_stag_continuation", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_ritual_stag_hide = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'white_stag',
		reqs = [],
		text = "MAE_SPIRIT_RITUAL_STAG_HIDE",
		options = [
			{
				code = "mae_spirit_ritual_stag_hide_2",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_spirit_ritual_stag_hide_2 = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		reqs = [],
		text = "MAE_SPIRIT_RITUAL_STAG_HIDE_2",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "mae_spirit_hide_unlocked"},
					{code = "progress_quest", value = "mae_spirit_quest", stage = "stage1_hide"},
					{code = "update_location"}
				]
			}
		]
	},
	mae_spirit_hide_return = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'white_stag',
		reqs = [],
		text = "MAE_SPIRIT_HIDE_RETURN",
		options = [
			{
				code = "mae_spirit_white_stag_continuation",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "material_change", operant = "-", material = "ancestral_hide", value = 1}
				]
			}
		]
	},
	mae_spirit_white_stag_continuation = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		character2 = 'white_stag',
		reqs = [],
		text = [
			{text = "MAE_SPIRIT_WHITE_STAG_CONTINUATION_1", reqs = []},
			{text = "MAE_SPIRIT_WHITE_STAG_CONTINUATION_2", reqs = [{type = "decision", value = "mae_druid_training_done", check = true}]},
			{text = "MAE_SPIRIT_WHITE_STAG_CONTINUATION_3", reqs = []},
			{text = "MAE_SPIRIT_WHITE_STAG_MAE_OWL", reqs = [{type = "decision", value = "mae_druid_training_done", check = true}]},
			{text = "MAE_SPIRIT_WHITE_STAG_MAE_SAFE", reqs = [
				{type = "decision", value = "mae_druid_training_done", check = false},
				{type = "local_counter", name = "mae_perverted_actions", operant = "lt", value = 2, check = true}
			]},
			{text = "MAE_SPIRIT_WHITE_STAG_MAE_SATYR", reqs = [
				{type = "decision", value = "mae_druid_training_done", check = false},
				{type = "local_counter", name = "mae_perverted_actions", operant = "gte", value = 2, check = true}
			]}
		],
		options = [
			{
				code = "mae_spirit_choice_result", 
				text = "MAE_SPIRIT_CHOICE_SUPPORT", 
				reqs = [{type = "decision", value = "mae_druid_training_done", check = true}], 
				dialogue_argument = 1, 
				bonus_effects = [
					{code = "decision", value = "mae_spirit_noctara"},
				],
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_choice_result", 
				text = "MAE_SPIRIT_CHOICE_SUPPORT", 
				reqs = [
					{type = "decision", value = "mae_druid_training_done", check = false},
					{type = "local_counter", name = "mae_perverted_actions", operant = "gte", value = 2, check = true}
				], 
				dialogue_argument = 1, 
				bonus_effects = [
					{code = "decision", value = "mae_spirit_velhorn"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"}
				],
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_choice_result", 
				text = "MAE_SPIRIT_CHOICE_SUPPORT", 
				reqs = [
					{type = "decision", value = "mae_druid_training_done", check = false},
					{type = "local_counter", name = "mae_perverted_actions", operant = "lt", value = 2, check = true}
				], 
				dialogue_argument = 1, 
				bonus_effects = [{code = "decision", value = "mae_spirit_hearthtusk"},],
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_choice_result", 
				text = "MAE_SPIRIT_CHOICE_HEARTH", 
				reqs = [], 
				dialogue_argument = 1, 
				bonus_effects = [{code = "decision", value = "mae_spirit_hearthtusk"},],
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_choice_result", 
				text = "MAE_SPIRIT_CHOICE_VELHORN", 
				reqs = [], 
				dialogue_argument = 1, 
				bonus_effects = [
					{code = "decision", value = "mae_spirit_velhorn"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"},
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"}
				],
				type = "next_dialogue"
			},
			{
				code = "mae_spirit_choice_result", 
				text = "MAE_SPIRIT_CHOICE_NOCTARA", 
				reqs = [{type = "decision", value = "mae_druid_training_done", check = true}], 
				dialogue_argument = 1, 
				bonus_effects = [{code = "decision", value = "mae_spirit_noctara"},],
				type = "next_dialogue"
			},
		]
	},
	mae_spirit_choice_result = {
		image = null,
		character = 'mae',
		character2 = 'white_stag',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SPIRIT_CHOICE_RESULT",
		options = [
			{code = "mae_spirit_after_choice", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_after_choice = {
		image = null,
		tags = ["dialogue_scene"],
		character = 'mae',
		reqs = [],
		text = "MAE_SPIRIT_AFTER_CHOICE",
		options = [
			{code = "mae_spirit_after_choice_response", text = "MAE_SPIRIT_AFTER_CHOICE_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_after_choice_response", text = "MAE_SPIRIT_AFTER_CHOICE_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mae_spirit_after_choice_response", text = "MAE_SPIRIT_AFTER_CHOICE_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"}
		]
	},
	mae_spirit_after_choice_response = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SPIRIT_AFTER_CHOICE_RESPONSE_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_SPIRIT_AFTER_CHOICE_RESPONSE_2", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_SPIRIT_AFTER_CHOICE_RESPONSE_3", reqs = [], previous_dialogue_option = 3},
			{text = "MAE_SPIRIT_AFTER_CHOICE_LEAVE", reqs = []}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "make_quest_location", value = "quest_mae_ancient_jungle"},
					{code = "progress_quest", value = "mae_spirit_quest", stage = "stage2"},
#					{code = "remove_quest_location", value = "quest_mae_spirit_ritual"},
					{code = "update_location"}
				]
			}
		]
	},
	mae_ancient_jungle_complete_start = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_ANCIENT_JUNGLE_START",
		options = [
			{code = "mae_ancient_jungle_ritual_choice", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_choice = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = "MAE_ANCIENT_JUNGLE_RITUAL_CHOICE",
		options = [
			{code = "mae_ancient_jungle_ritual_lewd", text = "MAE_ANCIENT_JUNGLE_RITUAL_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_ancient_jungle_ritual_finish", text = "MAE_ANCIENT_JUNGLE_RITUAL_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_lewd = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD",
		options = [
			{code = "mae_ancient_jungle_ritual_lewd_response", text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_ancient_jungle_ritual_lewd_response", text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_lewd_response = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_RESPONSE_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_ANCIENT_JUNGLE_RITUAL_LEWD_RESPONSE_2", reqs = [], previous_dialogue_option = 2}
		],
		options = [
			{code = "mae_ancient_jungle_ritual_scene", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_scene = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_ANCIENT_JUNGLE_RITUAL_SCENE",
		options = [
			{
				code = "mae_ancient_jungle_ritual_1", 
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = "next_dialogue", 
				change_dialogue_type = 2,
				bonus_effects = [
					{code = "dialogue_counter", name = "mae_sex_actions", op = "+"},
					{code = 'decision', value = 'MaeRitualSex'}
				],
			}
		]
	},
	mae_ancient_jungle_ritual_1 = {
		unlocked_gallery_seq = "mae_sex_ritual",
		custom_background = "mae_ritual_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_1",
		options = [
			{code = "mae_ancient_jungle_ritual_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_2 = {
		custom_background = "mae_ritual_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_2",
		options = [
			{code = "mae_ancient_jungle_ritual_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_3 = {
		custom_background = "mae_ritual_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_3",
		options = [
			{
				code = "mae_ancient_jungle_ritual_4", 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = "decision", value = "mae_spirit_velhorn", check = true}], 
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_ancient_jungle_ritual_finish", 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = "decision", value = "mae_spirit_velhorn", check = false}], 
				dialogue_argument = 1,
				type = "next_dialogue",
				change_dialogue_type = 1
			}
		]
	},
	mae_ancient_jungle_ritual_4 = {
		custom_background = "mae_ritual_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_4",
		options = [
			{code = "mae_ancient_jungle_ritual_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_5 = {
		custom_background = "mae_ritual_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_5",
		options = [
			{code = "mae_ancient_jungle_ritual_6", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_6 = {
		custom_background = "mae_ritual_6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_6",
		options = [
			{code = "mae_ancient_jungle_ritual_7", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_ancient_jungle_ritual_7 = {
		custom_background = "mae_ritual_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_RITUAL_7",
		options = [
			{code = "mae_ancient_jungle_ritual_finish", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue", change_dialogue_type = 1}
		]
	},
	
	mae_ancient_jungle_ritual_finish = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = [
			{text = "MAE_ANCIENT_JUNGLE_RITUAL_FINISH", reqs = []},
			{
				text = "MAE_ANCIENT_JUNGLE_RITUAL_HEARTHTUSK",
				reqs = [{type = "decision", value = "mae_spirit_hearthtusk", check = true}],
				bonus_effects = [{code = "affect_unique_character", name = "mae", type = "add_trait", trait = "spirit_boar"}]
			},
			{
				text = "MAE_ANCIENT_JUNGLE_RITUAL_VELHORN",
				reqs = [{type = "decision", value = "mae_spirit_velhorn", check = true}],
				bonus_effects = [{code = "affect_unique_character", name = "mae", type = "add_trait", trait = "spirit_satyr"}]
			},
			{
				text = "MAE_ANCIENT_JUNGLE_RITUAL_NOCTARA",
				reqs = [{type = "decision", value = "mae_spirit_noctara", check = true}],
				bonus_effects = [{code = "affect_unique_character", name = "mae", type = "add_trait", trait = "spirit_owl"}]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_spirit_quest", stage = "stage4"},
					{code = "set_completed_active_location"},
					{code = "remove_quest_location", value = "quest_mae_spirit_ritual"}, #was forced to do it here cause of proper travelling
				]
			}
		]
	},
	
	mae_spirit_visit_savra = {
		image = null,
		character = 'mae',
		character2 = 'savra',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SPIRIT_VISIT_SAVRA",
		options = [
			{code = "mae_spirit_visit_savra_response", text = "MAE_SPIRIT_VISIT_SAVRA_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_visit_savra_response", text = "MAE_SPIRIT_VISIT_SAVRA_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_visit_savra_response = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_SPIRIT_VISIT_SAVRA_RESPONSE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_spirit_quest", stage = "stage5"},
					{code = "make_quest_location", value = "quest_mae_northern_tribe"},
					{code = "update_city"}
				]
			}
		]
	},
	mae_spirit_northern_arrival = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_NORTHERN_TRIBE_START",
		options = [
			{code = "mae_spirit_northern_directions", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_directions = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_NORTHERN_TRIBE_DIRECTIONS",
		options = [
			{code = "mae_spirit_northern_shaman", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_shaman = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_NORTHERN_TRIBE_SHAMAN",
		options = [
			{code = "mae_spirit_northern_request", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_request = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_NORTHERN_TRIBE_REQUEST",
		options = [
			{code = "mae_spirit_northern_request_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_request_2 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_NORTHERN_TRIBE_REQUEST_2",
		options = [
			{code = "mae_spirit_northern_request_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_request_3 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_NORTHERN_TRIBE_REQUEST_3",
		options = [
			{code = "mae_spirit_northern_offer", text = "MAE_NORTHERN_TRIBE_REQUEST_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_northern_offer", text = "MAE_NORTHERN_TRIBE_REQUEST_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_offer = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_NORTHERN_TRIBE_OFFER",
		options = [
			{code = "mae_spirit_northern_offer_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_offer_2 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = "MAE_NORTHERN_TRIBE_OFFER_2",
		options = [
			{code = "mae_spirit_northern_ritual_consent", text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_northern_decline", text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_spirit_northern_missed", text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_3", reqs = [{type = "decision", value = "mae_druid_training_done", check = true}], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_ritual_consent = {
		variations = [
			{
				reqs = [{type = "local_counter", name = "mae_sex_actions", add_stat = "sexuals_factor", operant = "gte", value = 7, check = true}],
				image = null,
				tags = ["dialogue_scene"],
				character = "mae",
				text = "MAE_NORTHERN_RITUAL_ACCEPT",
				options = [{code = "mae_spirit_northern_ritual_scene_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2},]
			},
			{
				reqs = [],
				image = null,
				tags = ["dialogue_scene"],
				character = "mae",
				text = "MAE_NORTHERN_RITUAL_REFUSE",
				options = [
					{code = "mae_spirit_northern_decline", text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
					{code = "mae_spirit_northern_missed", text = "MAE_NORTHERN_TRIBE_OFFER_OPTION_3", reqs = [{type = "decision", value = "mae_druid_training_done", check = true}], dialogue_argument = 1, type = "next_dialogue"}
				]
			}
		]
	},
	mae_spirit_northern_ritual_scene_1 = {
		unlocked_gallery_seq = "mae_spirit_northern_ritual",
		custom_background = "mae_northern_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		text = "MAE_SEX_TRIBE_1",
		options = [
			{code = "mae_spirit_northern_ritual_scene_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_spirit_northern_ritual_scene_2 = {
		custom_background = "mae_northern_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_TRIBE_2",
		options = [
			{code = "mae_spirit_northern_ritual_scene_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_spirit_northern_ritual_scene_3 = {
		custom_background = "mae_northern_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_TRIBE_3",
		options = [
			{code = "mae_spirit_northern_ritual_scene_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_spirit_northern_ritual_scene_4 = {
		custom_background = "mae_northern_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_TRIBE_4",
		options = [
			{code = "mae_spirit_northern_ritual_scene_5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,type = "next_dialogue"}
		]
	},
	mae_spirit_northern_ritual_scene_5 = {
		custom_background = "mae_northern_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_SEX_TRIBE_5",
		options = [
			{
				code = "mae_spirit_northern_ritual_after", 
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = "next_dialogue", 
				change_dialogue_type = 1,
				bonus_effects = [
					{
						code = "unique_character_changes",
						value = "mae",
						args = [
							{code = "sex_skills_petting", operant = "+", value = 25},
							{code = "sex_skills_pussy", operant = "+", value = 25},
							{code = "sex_skills_oral", operant = "+", value = 25},
							{code = "sex_skills_anal", operant = "+", value = 25},
							{code = "sexuals_factor", operant = "+", value = 1}
						]
					},
					{code = 'decision', value = 'MaeOrgy'}
				],
			}
		]
	},
	mae_spirit_northern_ritual_after = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		character = 'mae',
		reqs = [],
		text = "MAE_NORTHERN_RITUAL_AFTER",
		options = [
			{code = "mae_spirit_northern_ritual_gift", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_ritual_gift = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		character = 'mae',
		reqs = [],
		text = "MAE_NORTHERN_RITUAL_GIFT",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "add_item", item = "ornate_leather_headdress", number = 1},
					{code = "complete_quest", value = "mae_spirit_quest"},
					{code = "remove_quest_location", value = "quest_mae_northern_tribe"},
				]
			}
		]
	},
	mae_spirit_northern_decline = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_NORTHERN_DECLINE",
		options = [
			{code = "mae_spirit_northern_decline_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_decline_2 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_NORTHERN_DECLINE_2",
		options = [
			{code = "mae_spirit_northern_decline_fade", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_decline_fade = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = "MAE_NORTHERN_DECLINE_FESTIVAL",
		options = [
			{code = "mae_spirit_northern_decline_after", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_decline_after = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = "MAE_NORTHERN_DECLINE_GIFT",
		options = [
			{code = "mae_spirit_northern_ritual_gift", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_missed = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_NORTHERN_MISSED",
		options = [
			{code = "mae_spirit_northern_missed_fade", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_spirit_northern_missed_fade = {
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		reqs = [],
		text = "MAE_NORTHERN_MISSED_AFTER",
		options = [
			{code = "mae_spirit_northern_ritual_gift", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	
}
