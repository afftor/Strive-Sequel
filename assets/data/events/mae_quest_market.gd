extends Reference
var data = {
	mae_initiate_start = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_QUEST_INITIATE_START",
		options = [
			{
				code = "mae_initiate_start_followup",
				text = "MAE_QUEST_INITIATE_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_initiate_start_followup",
				text = "MAE_QUEST_INITIATE_OPTION_2",
				reqs = [],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	mae_initiate_start_followup = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_QUEST_INITIATE_REPLY_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_QUEST_INITIATE_REPLY_2", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_QUEST_INITIATE_FAVOR", reqs = [], previous_dialogue_option = [1, 2]},
			{text = "MAE_QUEST_INITIATE_FAVOR_RETURN", reqs = [], previous_dialogue_option = 3}
		],
		options = [
			{
				code = "mae_initiate_start_followup",
				text = "MAE_QUEST_INITIATE_FAVOR_OPTION_1",
				reqs = [],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "mae_initiate_request",
				text = "MAE_QUEST_INITIATE_FAVOR_OPTION_2",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_initiate_request = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_QUEST_INITIATE_REQUEST",
		options = [
			{
				code = "mae_initiate_close",
				text = "MAE_QUEST_INITIATE_REQUEST_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_initiate_close",
				text = "MAE_QUEST_INITIATE_REQUEST_OPTION_2",
				reqs = [],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	mae_initiate_close = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_QUEST_INITIATE_CLOSE",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "progress_quest", value = "mae_city_quest", stage = "stage0"}]
			}
		]
	},
	
	mae_market_start = {
		image = 'mae_market',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_START",
		options = [
			{
				code = "mae_market_fruit_intro",
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	mae_market_fruit_intro = {
		image = 'mae_market',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_FRUIT_INTRO",
		options = [
			{
				code = "mae_market_fruit_buy",
				text = "MAE_MARKET_FRUIT_OPTION_BUY",
				reqs = [{type = "has_money", value = 250}],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "money_change", operant = "-", value = 250}]
			},
			{
				code = "mae_market_fruit_steal",
				text = "MAE_MARKET_FRUIT_OPTION_STEAL",
				reqs = [
					{
						type = "master_check",
						value = [{code = "has_profession", profession = "thief", check = true}]
					}
				],
				dialogue_argument = 2,
				type = "next_dialogue"
			},
			{
				code = "mae_market_fruit_move_on",
				text = "MAE_MARKET_FRUIT_OPTION_MOVE",
				reqs = [],
				dialogue_argument = 3,
				type = "next_dialogue"
			}
		]
	},
	mae_market_fruit_buy = {
		image = 'mae_market',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_FRUIT_BUY",
		options = [
			{code = "mae_market_fruit_after", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_fruit_steal = {
		image = 'mae_market',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_FRUIT_STEAL",
		options = [
			{code = "mae_market_fruit_after", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_fruit_after = {
		image = 'mae_market',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_FRUIT_AFTER",
		options = [
			{code = "mae_market_shelia_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_fruit_move_on = {
		image = 'mae_market',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_FRUIT_MOVE_ON",
		options = [
			{code = "mae_market_shelia_intro", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_shelia_intro = {
		image = 'mae_friend',
		tags = ["dialogue_scene"],
		text = "MAE_MARKET_SHELIA_INTRO",
		options = [
			{code = "mae_market_shelia_talk", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_shelia_talk = {
		image = 'mae_friend',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_SHELIA_TALK",
		options = [
			{code = "mae_market_shelia_request", text = "MAE_MARKET_SHELIA_REL_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_market_shelia_request", text = "MAE_MARKET_SHELIA_REL_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_shelia_request = {
		image = 'mae_friend',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_SHELIA_REQUEST",
		options = [
			{code = "mae_market_shelia_wait", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_market_shelia_wait = {
		image = 'mae_friend',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_MARKET_SHELIA_WAIT",
		options = [
			{
				code = "mae_market_shelia_response",
				text = "MAE_MARKET_SHELIA_RESPONSE_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "mae_market_shelia_response",
				text = "MAE_MARKET_SHELIA_RESPONSE_OPTION_2",
				reqs = [],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	mae_market_shelia_response = {
		image = 'mae_friend',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_MARKET_SHELIA_RESPONSE_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_MARKET_SHELIA_RESPONSE_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_city_quest", stage = "stage1"},
					{code = "update_city"}
				]
			}
		]
	},
	
	mae_friend_visit_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = "MAE_FRIEND_VISIT_1",
		options = [
			{code = "mae_friend_visit_1_after", text = "MAE_FRIEND_VISIT_1_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_friend_visit_1_after", text = "MAE_FRIEND_VISIT_1_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_friend_visit_1_after = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_FRIEND_VISIT_1_AFTER",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "progress_quest",
						value = "mae_city_quest",
						stage = "stage2"
					},
					{
						code = "add_special_task_for_location",
						location = "aliron",
						amount = 60, #?
						descript = "MAE_POTION_TASK_DESC",
						name = "MAE_POTION_TASK_NAME",
						max_workers = 3, #?
						icon = "res://assets/Textures_v2/MANSION/quest_task.png",
						workstat = "wits", #?
						args = [{code = "progress_quest", value = "mae_city_quest", stage = "stage25"}]
					},
					{code = "update_city"}
				]
			}
		]
	},
	mae_potion_ready = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [{type = "active_quest_stage", value = "mae_city_quest", stage = "stage25"}],
		character = "mae",
		text = "MAE_POTION_READY",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [{code = "progress_quest", value = "mae_city_quest", stage = "stage3"}]
			}
		]
	},
	mae_friend_visit_2_start = {
		image = 'mae_ritual',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_FRIEND_VISIT_2_START",
		options = [
			{code = "mae_friend_visit_2_wait", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_friend_visit_2_wait = {
		image = 'mae_ritual',
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_FRIEND_VISIT_2_WAIT",
		options = [
			{code = "mae_friend_visit_2_crash", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_friend_visit_2_crash = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_FRIEND_VISIT_2_CRASH",
		common_effects = [
			{
				code = "affect_unique_character",
				name = "mae",
				type = "set_availability",
				value = false
			},
		],
		options = [
			{
				code = "mae_friend_visit_2_track_success",
				text = "MAE_FRIEND_VISIT_2_OPTION_WISDOM",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				select_person = true,
				person_reqs = [{code = "is_master", check = true}],
				challenge = "wisdom",
				not_hide = true
			},
			{
				code = "close",
				text = "MAE_FRIEND_VISIT_2_OPTION_CLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_city_quest", stage = "stage4"},
					{
						code = "add_special_task_for_location",
						location = "aliron",
						amount = 100,
						descript = "MAE_SEARCH_TASK_DESC",
						name = "MAE_SEARCH_TASK_NAME",
						max_workers = 4, #?
						icon = "res://assets/Textures_v2/MANSION/quest_task.png",
						workstat = "wits",
						args = [
							{
								code = "start_event",
								data = "mae_search_complete_start",
								args = {}
							}
						]
					},
					{code = "update_city"}
				]
			}
		]
	},
	mae_friend_visit_2_track_success = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		text = "MAE_FRIEND_VISIT_2_TRACK_SUCCESS",
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "mae_city_quest", stage = "stage4"},
					{
						code = "add_special_task_for_location",
						location = "aliron",
						amount = 30,
						descript = "MAE_SEARCH_TASK_DESC",
						name = "MAE_SEARCH_TASK_NAME",
						max_workers = 4, #?
						icon = "res://assets/Textures_v2/MANSION/quest_task.png",
						workstat = "wits",
						args = [
							{
								code = "start_event",
								data = "mae_search_complete_start",
								args = {}
							}
						]
					},
					{code = "update_city"}
				]
			}
		]
	},
	mae_search_complete_start = {
		image = 'mae_debuff',
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = "MAE_SEARCH_COMPLETE_START",
		common_effects = [
			{
				code = "affect_unique_character",
				name = "mae",
				type = "set_availability",
				value = true
			},
		],
		options = [
			{code = "mae_search_complete_voice_1", text = "MAE_SEARCH_COMPLETE_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_search_complete_voice_1", text = "MAE_SEARCH_COMPLETE_OPTION_2", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_search_complete_voice_1 = {
		image = 'mae_debuff',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_SEARCH_COMPLETE_VOICE_1",
		options = [
			{code = "mae_search_complete_voice_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_search_complete_voice_2 = {
		image = 'mae_debuff',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_SEARCH_COMPLETE_VOICE_2",
		options = [
			{code = "mae_search_complete_voice_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_search_complete_voice_3 = {
		image = 'mae_debuff',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_SEARCH_COMPLETE_VOICE_3",
		options = [
			{code = "mae_search_complete_voice_4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_search_complete_voice_4 = {
		image = 'mae_debuff',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SEARCH_COMPLETE_VOICE_4A", reqs = [{type = "decision", value = "letFuck", check = false}]},
			{text = "MAE_SEARCH_COMPLETE_VOICE_4B", reqs = [{type = "decision", value = "letFuck", check = true}]},
			{text = "MAE_SEARCH_COMPLETE_VOICE_4C", reqs = []}
		],
		options = [
			{code = "mae_search_complete_voice_5", text = "MAE_SEARCH_COMPLETE_OPTION_HELP", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_search_complete_voice_5", text = "MAE_SEARCH_COMPLETE_OPTION_STAND", reqs = [], dialogue_argument = 2, type = "next_dialogue"}
		]
	},
	mae_search_complete_voice_5 = {
		image = 'mae_debuff',
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SEARCH_COMPLETE_HELP", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_SEARCH_COMPLETE_STAND", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = "mae_search_complete_home", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	mae_search_complete_home = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = "MAE_SEARCH_COMPLETE_HOME",
		options = [
			{code = "mae_search_complete_response_1", text = "MAE_SEARCH_COMPLETE_HOME_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_search_complete_response_1", text = "MAE_SEARCH_COMPLETE_HOME_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mae_search_complete_response_1", text = "MAE_SEARCH_COMPLETE_HOME_OPTION_3", reqs = [], dialogue_argument = 3, type = "next_dialogue"}
		]
	},
	mae_search_complete_response_1 = {
		image = null,
		tags = ["dialogue_scene"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SEARCH_COMPLETE_RESPONSE_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_SEARCH_COMPLETE_RESPONSE_2", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_SEARCH_COMPLETE_RESPONSE_3", reqs = [], previous_dialogue_option = 3},
			{text = "MAE_SEARCH_COMPLETE_CONCERN", reqs = []},
		],
		options = [
			{code = "mae_search_complete_final", text = "MAE_SEARCH_COMPLETE_FINAL_OPTION_1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mae_search_complete_final", text = "MAE_SEARCH_COMPLETE_FINAL_OPTION_2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{
				code = "mae_search_complete_final", 
				text = "MAE_SEARCH_COMPLETE_FINAL_OPTION_3", 
				reqs = [], 
				dialogue_argument = 3, 
				type = "next_dialogue",
				bonus_effecs = [
					{code = "dialogue_counter", name = "mae_perverted_actions", op = "+"},
					{code = 'decision', value = 'MaeEndorse'}
				]
			},
		]
	},
	mae_search_complete_final = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		reqs = [],
		character = "mae",
		text = [
			{text = "MAE_SEARCH_COMPLETE_FINAL_1", reqs = [], previous_dialogue_option = 1},
			{text = "MAE_SEARCH_COMPLETE_FINAL_2", reqs = [], previous_dialogue_option = 2},
			{text = "MAE_SEARCH_COMPLETE_FINAL_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = "next_dialogue",
				bonus_effects = [
					{code = "complete_quest", value = "mae_city_quest"},
					{code = "add_timed_event", value = "mae_druid_event_start", args = [{type = "add_to_date", date = [2, 2], hour = 2}]},
					{code = "add_timed_event", value = "mae_spirit_quest_initiate", args = [{type = "add_to_date", date = [4, 4], hour = 1}]}
				]
			}
		]
	},
}
