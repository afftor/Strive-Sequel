extends Reference
var data = {
	rouge_demoness_intermission_start = {
		reqs = [],
		image = null,
		music = "intimate_dark",
		character = "grotus",
		character2 = "demon_female",
		tags = ["dialogue_scene"],
		text = "ROUGE_DEMONESS_INTERMISSION_START",
		options = [{code = "rouge_demoness_intermission_mhyrana_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_demoness_intermission_mhyrana_1 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_DEMONESS_INTERMISSION_MHYRANA_1",
		options = [{code = "rouge_demoness_intermission_mhyrana_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_demoness_intermission_mhyrana_2 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "demon_female",
		tags = ["dialogue_scene"],
		text = "ROUGE_DEMONESS_INTERMISSION_MHYRANA_2",
		options = [{code = "rouge_demoness_intermission_grotus_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_demoness_intermission_grotus_1 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "demon_female",
		tags = ["dialogue_scene"],
		text = "ROUGE_DEMONESS_INTERMISSION_GROTUS_1",
		options = [{code = "rouge_demoness_intermission_grotus_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_demoness_intermission_grotus_2 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "demon_female",
		tags = ["dialogue_scene"],
		text = "ROUGE_DEMONESS_INTERMISSION_GROTUS_2",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue"}]
	},
	
	rouge_melchor_confrontation_start = {
		reqs = [],
		image = null,
		music = 'rouge_theme',
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MELCHOR_CONFRONTATION_START",
		options = [
			{code = "rouge_melchor_confrontation_response_1", text = "ROUGE_MELCHOR_OPTION_MILD_EXERCISE", reqs = [], type = "next_dialogue"},
			{code = "rouge_melchor_confrontation_response_1", text = "ROUGE_MELCHOR_OPTION_CROWDS_PLEASED", reqs = [], type = "next_dialogue"},
			{code = "rouge_melchor_confrontation_response_1", text = "ROUGE_MELCHOR_OPTION_CIRCUMSTANCES", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_melchor_confrontation_response_1 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_RESPONSE_1",
		options = [{code = "rouge_melchor_confrontation_response_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_melchor_confrontation_response_2 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MELCHOR_CONFRONTATION_RESPONSE_2",
		options = [{code = "rouge_melchor_confrontation_response_3", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_melchor_confrontation_response_3 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_RESPONSE_3",
		options = [
			{code = "rouge_melchor_confrontation_accept", text = "ROUGE_MELCHOR_OPTION_ACCEPT_CUSTODY", reqs = [], type = "next_dialogue"},
			{code = "rouge_melchor_confrontation_refuse_1", text = "ROUGE_MELCHOR_OPTION_REFUSE_TRAP", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_melchor_confrontation_accept = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_ACCEPT",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "rouge_accepted"},
					{code = "make_story_character", value = "Rouge", recruit_from_location = true},
					{code = 'plan_mansion_event', value = 'rouge_mansion_arrival'},
					{code = "progress_quest", value = "rouge_quest", stage = "mansion"},
					{code = "complete_quest", value = "act_4_capital"},
				]
			}
		]
	},
	rouge_melchor_confrontation_refuse_1 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_REFUSE_1",
		options = [{code = "rouge_melchor_confrontation_refuse_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_melchor_confrontation_refuse_2 = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "chancellor",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_REFUSE_2",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "rouge_refused"},
					{code = "complete_quest", value = "act_4_capital"},
				] #2add more
			}
		]
	},
	
	rouge_mansion_arrival = {
		reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true}],
		image = null,
		music = 'rouge_theme',
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MANSION_ARRIVAL",
		options = [
			{code = "rouge_mansion_arrival_2", text = "ROUGE_MANSION_OPTION_REASON", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_mansion_arrival_2", text = "ROUGE_MANSION_OPTION_STATUS", reqs = [], type = "next_dialogue", dialogue_argument = 2}
		]
	},
	rouge_mansion_arrival_2 = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ROUGE_MANSION_REASON", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_MANSION_STATUS", reqs = [], previous_dialogue_option = 2},
			{text = "ROUGE_MANSION_HANDLE", reqs = [], previous_dialogue_option = [1, 2]},
			{text = "ROUGE_MANSION_CUSTODY_WARNING", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = "rouge_mansion_arrival_2", text = "ROUGE_MANSION_OPTION_CUSTODY_WARNING", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
			{code = "rouge_mansion_lead", text = "ROUGE_MANSION_OPTION_SHOW_QUARTERS", reqs = []},
			{code = "rouge_mansion_slave_status", text = "ROUGE_MANSION_OPTION_SLAVE_STATUS", reqs = []},
		]
	},
	rouge_mansion_lead = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_MANSION_LEAD", 
		options = [{code = "rouge_mansion_show_quarters", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_mansion_slave_status = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MANSION_SLAVE_STATUS",
		options = [
			{code = "rouge_mansion_slave_confirm", text = "ROUGE_MANSION_OPTION_SLAVE_CONFIRM", reqs = []},
			{code = "rouge_mansion_lead", text = "ROUGE_MANSION_OPTION_NEVERMIND_QUARTERS", reqs = []},
		]
	},
	rouge_mansion_slave_confirm = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene", "blackscreen_transition_common"], 
		text = "ROUGE_MANSION_SLAVE_CONFIRM", 
		options = [{
			code = "rouge_mansion_show_quarters",
			text = "DIALOGUECONTINUE",
			reqs = [],
			type = "next_dialogue",
			bonus_effects = [
				{code = "affect_unique_character", name = "rouge", type = "slavetype", value = "slave"},
				{code = "unique_character_changes", value = "rouge", args = [{code = "add_trait", trait = "training_broke_in"}]},
			]
		}]
	},
	rouge_mansion_show_quarters = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		text = "ROUGE_MANSION_SHOW_QUARTERS",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue",
				 bonus_effects = [
					{
						code = "add_timed_event", 
						value = "rouge_room_complaint_start", 
						args = [{type = "add_to_hour", hour = [1, 1]}]
					}
				]
			}
		]
	},
	
	rouge_room_complaint_start = {
		reqs = [],
		image = null,
		music = 'rouge_theme',
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_ROOM_COMPLAINT_START",
		options = [
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_BARELY_WORSE", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_NOTHING_WRONG", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_GET_USED", reqs = [], type = "next_dialogue", dialogue_argument = 1}
		]
	},
	rouge_room_complaint_demands = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_ROOM_COMPLAINT_DEMANDS", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_ROOM_COMPLAINT_DEMANDING", reqs = [], previous_dialogue_option = 2},
			{text = "ROUGE_ROOM_COMPLAINT_REFUSE", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_DEMANDING", reqs = [], type = "next_dialogue", dialogue_argument = 2, remove_after_first_use = true},
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_REFUSE", reqs = [], type = "next_dialogue", dialogue_argument = 3, remove_after_first_use = true},
			{code = "rouge_room_complaint_accept", text = "ROUGE_ROOM_OPTION_WORKERS_GUILD", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_room_complaint_accept = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_ROOM_COMPLAINT_ACCEPT", 
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue",
				bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "furniture"}]
			}
		]
	},

	rouge_workers_furniture_start = {
		reqs = [],
		image = null,
		music = 'rouge_theme',
		character = "rouge",
		character2 = "sigmund",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_WORKERS_FURNITURE_START",
		options = [
			{
				code = "rouge_workers_furniture_terms", 
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				type = "next_dialogue", 
				dialogue_argument = 1,
				bonus_effects = [{code = "screen_black_transition", value = 1}]
			}
		]
	},
	rouge_workers_furniture_terms = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "sigmund",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ROUGE_WORKERS_FURNITURE_TERMS", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_WORKERS_FURNITURE_REENTER", reqs = [], previous_dialogue_option = 0},
			{text = "ROUGE_WORKERS_FURNITURE_MATERIALS_OFFER", reqs = [], previous_dialogue_option = 2},
			{text = "ROUGE_WORKERS_FURNITURE_RECONSIDER", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = "rouge_workers_furniture_paid", 
				text = "ROUGE_WORKERS_OPTION_PAY_GOLD", 
				reqs = [{type = "has_money", value = 10000}], 
				type = "next_dialogue", 
				not_hide = true,
				dialogue_argument = 1,
				bonus_effects = [
					{code = "money_change", operant = "-", value = 10000}, 
#					{code = "progress_quest", value = "rouge_quest", stage = "letter"},
				]
			},
			{code = "rouge_workers_furniture_cannot_afford", text = "ROUGE_WORKERS_OPTION_CANNOT_AFFORD", reqs = [], type = "next_dialogue", remove_after_first_use = true},
			{
				code = "rouge_workers_furniture_terms", 
				text = "ROUGE_WORKERS_OPTION_DISCUSS", 
				reqs = [], 
				type = "next_dialogue", 
				dialogue_argument = 2,
				bonus_effects = [{code = "decision", value = "rouge_furniture_bargained"}]
			},
			{
				code = "rouge_workers_furniture_paid", 
				text = "ROUGE_WORKERS_OPTION_MATERIALS", 
				reqs = [
					{type = "decision", value = "rouge_furniture_bargained", check = true},
					{type = "has_material", material = "leatherthick", operant = "gte", value = 150},
					{type = "has_material", material = "woodiron", operant = "gte", value = 100},
				], 
				type = "next_dialogue", 
				dialogue_argument = 2,
				bonus_effects = [
					{code = "material_change", operant = "-", material = "leatherthick", value = 150},
					{code = "material_change", operant = "-", material = "woodiron", value = 100},
				]
			},
			{
				code = "close", 
				text = "ROUGE_WORKERS_OPTION_NEED_TIME", 
				reqs = [], 
				type = "next_dialogue",
				bonus_effects = [
					{code = "progress_quest", value = "rouge_quest", stage = "furniture_get"},
				]
			}
		]
	},
	rouge_workers_furniture_paid = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		character2 = "sigmund",
		tags = ["dialogue_scene"], 
		text = [
			{text = "ROUGE_WORKERS_FURNITURE_PAID_GOLD", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_WORKERS_FURNITURE_PAID_MATERIALS", reqs = [], previous_dialogue_option = 2},
		], 
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "unique_character_changes", value = "rouge", args = [
						{code = "add_trait", trait = "training_s_combat", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "servant"}]},
						{code = "add_trait", trait = "training_s_relation", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "servant"}]},
						{code = "add_trait", trait = "training_s_sexservice", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "servant"}]},
						{code = "add_trait", trait = "training_obedience", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "slave"}]},
						{code = "add_trait", trait = "training_relation", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "slave"}]},
						{code = "add_trait", trait = "training_sexservice", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "slave"}]},
					]},
					{code = "progress_quest", value = "rouge_quest", stage = "letter"},
					{code = "add_timed_event", value = "rouge_letter_request", args = [{type = "add_to_date", date = [2,2], hour = 3}]}, 
					{code = "plan_mansion_event", value = "rouge_furniture_reward"},
					{code = "update_city"}
				]
			}
		]
	},
	rouge_workers_furniture_cannot_afford = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_WORKERS_FURNITURE_CANNOT_AFFORD",
		options = [
			{code = "rouge_workers_furniture_terms", text = "ROUGE_WORKERS_OPTION_RECONSIDER", reqs = [], type = "next_dialogue", dialogue_argument = 3},
			{
				code = "rouge_workers_furniture_charm_success", 
				text = "ROUGE_WORKERS_OPTION_NO_INDULGE", 
				reqs = [
					{
						type = "master_check", 
						value = [{code = "stat", stat = "charm_factor", operant = "gte", value = 5}]
					}
				], 
				type = "next_dialogue"},
			{
				code = "rouge_workers_furniture_charm_fail", 
				text = "ROUGE_WORKERS_OPTION_NO_INDULGE", 
				reqs = [
					{
						type = "master_check", 
						value = [{code = "stat", stat = "charm_factor", operant = "lt", value = 5}]
					}
				], 
				type = "next_dialogue"
			}
		]
	},
	rouge_workers_furniture_charm_success = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene", "master_translate"], 
		text = "ROUGE_WORKERS_FURNITURE_CHARM_SUCCESS", 
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue",
				bonus_effects = [
					{code = "decision", value = "rouge_furniture_paid"},
					{code = "unique_character_changes", value = "rouge", args = [
						{code = "add_trait", trait = "training_s_combat", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "servant"}]},
						{code = "add_trait", trait = "training_s_relation", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "servant"}]},
						{code = "add_trait", trait = "training_obedience", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "slave"}]},
						{code = "add_trait", trait = "training_relation", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "slave"}]},
					]},
					{code = "progress_quest", value = "rouge_quest", stage = "letter"}, 
					{code = "add_timed_event", value = "rouge_letter_request", args = [{type = "add_to_date", date = [2,2], hour = 3}]}, 
					{code = "update_city"},
					
				]
			}
		]
	},
	rouge_workers_furniture_charm_fail = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene", "master_translate"], 
		text = "ROUGE_WORKERS_FURNITURE_CHARM_FAIL", 
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "decision", value = "rouge_furniture_paid"},
					{code = "decision", value = "rouge_furniture_paid_disdain"},
					{code = "complete_quest", value = "rouge_quest"}, 
					{code = "update_city"}
				]
			}
		]
	},
	
	rouge_letter_request = {
		reqs = [],
		image = null,
		character = "rouge",
		music = 'rouge_theme',
		tags = ["dialogue_scene"],
		text = "ROUGE_LETTER_REQUEST",
		options = [
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_FAVOR", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_FISHY", reqs = [], type = "next_dialogue", dialogue_argument = 1}
		]
	},
	rouge_letter_request_details = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_LETTER_REQUEST_DETAILS", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_LETTER_REQUEST_CONTENTS", reqs = [], previous_dialogue_option = 2},
			{text = "ROUGE_LETTER_REQUEST_WHY_YOU", reqs = [], previous_dialogue_option = 3},
			{text = "ROUGE_LETTER_REQUEST_RIVALS", reqs = [], previous_dialogue_option = 4},
		],
		options = [
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_CONTENTS", reqs = [], type = "next_dialogue", dialogue_argument = 2},
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_WHY_YOU", reqs = [], type = "next_dialogue", dialogue_argument = 3},
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_RIVALS", reqs = [], type = "next_dialogue", dialogue_argument = 4},
			{code = "rouge_letter_request_accept", text = "ROUGE_LETTER_OPTION_ACCEPT", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_letter_request_accept = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_LETTER_REQUEST_ACCEPT", 
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "progress_quest", value = "rouge_quest", stage = "melchor"}, 
					{code = "update_city"}
				]
			}
		]
	},
	
	#not from here mostly
	
	#end
	
	rouge_meet_melchor_start = {
		reqs = [],
		music = 'empire_capital',
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MEET_MELCHOR_START",
		options = [
			{code = "rouge_meet_melchor_reason", text = "ROUGE_MEET_OPTION_INFORMED", reqs = [], type = "next_dialogue"},
			{code = "rouge_meet_melchor_reason", text = "ROUGE_MEET_OPTION_SPIES", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_meet_melchor_reason = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene"],
		text = "ROUGE_MEET_MELCHOR_REASON",
		options = [
			{code = "rouge_meet_melchor_letter", text = "ROUGE_MEET_OPTION_LETTER", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_meet_melchor_letter", text = "ROUGE_MEET_OPTION_ROUGE_MESSAGE", reqs = [], type = "next_dialogue", dialogue_argument = 1}
		]
	},
	rouge_meet_melchor_letter = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_MEET_MELCHOR_LETTER", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_MEET_MELCHOR_CULT", reqs = [], previous_dialogue_option = 2},
			{text = "ROUGE_MEET_MELCHOR_ADDRESSES", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = "rouge_meet_melchor_cult", text = "ROUGE_MEET_OPTION_CULT", reqs = [],  dialogue_argument = 2},
			{code = "rouge_meet_melchor_addresses", text = "ROUGE_MEET_OPTION_ADDRESSES", reqs = [], dialogue_argument = 3},
			{code = "rouge_meet_melchor_plan", text = "ROUGE_MEET_OPTION_PLAN", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_meet_melchor_plan = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene"],
		text = "ROUGE_MEET_MELCHOR_PLAN",
		options = [
			{code = "rouge_meet_melchor_finish", text = "ROUGE_MEET_OPTION_MUTUAL_INTEREST", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_meet_melchor_finish", text = "ROUGE_MEET_OPTION_REWARD", reqs = [], type = "next_dialogue", dialogue_argument = 2}
		]
	},
	rouge_meet_melchor_finish = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene"], 
		text = [
			{text = "ROUGE_MEET_MELCHOR_MUTUAL_INTEREST", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_MEET_MELCHOR_REWARD", reqs = [], previous_dialogue_option = 2},
		],
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [
			{code = "progress_quest", value = "rouge_quest", stage = "warehouse"}, 
			{code = "update_city"}]}
		]
	},
	
	rouge_warehouse_search = {
		reqs = [],
		image = "rouge_warehouse_1",
		music = 'intimate_dark',
		tags = ["dialogue_scene"], 
		text = "ROUGE_WAREHOUSE_SEARCH", 
		options = [{code = "rouge_warehouse_approach", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_warehouse_approach = {
		reqs = [],
		image = null,
		music = 'threat',
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_WAREHOUSE_APPROACH_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = false}]},
			{text = "ROUGE_WAREHOUSE_APPROACH_HENCHMAN", reqs = [{type = "decision", value = "KetchKilled", check = true}]}
		],
		options = [
			{code = "rouge_warehouse_peek", text = "ROUGE_WAREHOUSE_OPTION_PEEK", reqs = [], type = "next_dialogue"},
			{code = "rouge_warehouse_capture", text = "ROUGE_WAREHOUSE_OPTION_SLIP_INSIDE", reqs = [], type = "next_dialogue", dialogue_argument = 1}
		]
	},
	rouge_warehouse_peek = {
		variations = [
			{
				reqs = [{type = "decision", value = "KetchKilled", check = false}],
				image = null,
				character = "ketch",
				tags = ["dialogue_scene"],
				text = "ROUGE_WAREHOUSE_PEEK_KETCH",
				options = [{code = "rouge_warehouse_capture", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", dialogue_argument = 2}]
			},
			{
				reqs = [],
				image = null,
				tags = ["dialogue_scene"],
				text = "ROUGE_WAREHOUSE_PEEK_HENCHMAN",
				options = [{code = "rouge_warehouse_capture", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", dialogue_argument = 2}]
			},
		]
	},
	rouge_warehouse_capture = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_WAREHOUSE_SLIP_INSIDE", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_WAREHOUSE_CAPTURE_1", reqs = [], previous_dialogue_option = 2},
			{text = "ROUGE_WAREHOUSE_CAPTURE_2", reqs = []}
		],
		options = [
			{code = "rouge_interrogation_ketch_start", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = false}], type = "next_dialogue"},
			{code = "rouge_interrogation_henchman_start", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = true}], type = "next_dialogue"}
		]
	},
	
	rouge_interrogation_ketch_start = {
		reqs = [],
		image = null,
		character = "ketch",
		tags = ["dialogue_scene", "blackscreen_transition_slow"],
		text = "ROUGE_INTERROGATION_KETCH_START",
		options = [
			{code = "rouge_interrogation_ketch_tough", text = "ROUGE_INTERROGATION_OPTION_SILENT", reqs = [], type = "next_dialogue"},
			{code = "rouge_interrogation_ketch_tough", text = "ROUGE_INTERROGATION_OPTION_NOTHING", reqs = [], type = "next_dialogue"},
			{code = "rouge_interrogation_ketch_rouge", text = "ROUGE_INTERROGATION_OPTION_ROUGE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_interrogation_ketch_tough = {
		reqs = [], 
		image = null, 
		character = "ketch", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_KETCH_TOUGH", 
		options = [
			{code = "rouge_interrogation_ketch_rouge", text = "ROUGE_INTERROGATION_OPTION_ROUGE_SENT", reqs = [], type = "next_dialogue"}, 
			{code = "rouge_interrogation_ketch_bitch", text = "ROUGE_INTERROGATION_OPTION_HIT_LIKE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_interrogation_ketch_rouge = {
		reqs = [], 
		image = null, 
		character = "ketch", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_KETCH_ROUGE", 
		options = [{code = "rouge_interrogation_over_ketch", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_interrogation_ketch_bitch = {
		reqs = [], 
		image = null, 
		character = "ketch", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_KETCH_BITCH", 
		common_effects = [{code = 'affect_master', type = 'effect', value = 'e_quest_injury'}],
		options = [{code = "rouge_interrogation_over_ketch", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_interrogation_henchman_start = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene", "master_translate"], 
		text = "ROUGE_INTERROGATION_HENCHMAN_START", 
		options = [{code = "rouge_interrogation_henchman_question_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_interrogation_henchman_question_1 = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_HENCHMAN_QUESTION_1", 
		options = [
			{code = "rouge_interrogation_henchman_question_2", text = "ROUGE_INTERROGATION_OPTION_BUSINESS", reqs = [], type = "next_dialogue"}, 
			{code = "rouge_interrogation_henchman_question_2", text = "ROUGE_INTERROGATION_OPTION_SQUAD", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_interrogation_henchman_question_2 = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_HENCHMAN_QUESTION_2", 
		options = [{code = "rouge_interrogation_over_henchman", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_interrogation_over_ketch = {
		reqs = [], 
		image = null, 
		character = "ketch", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_OVER_KETCH", 
		options = [{code = "rouge_grotus_rescue", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_interrogation_over_henchman = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene"], 
		text = "ROUGE_INTERROGATION_OVER_HENCHMAN", 
		options = [{code = "rouge_grotus_rescue", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_grotus_rescue = {
		reqs = [], 
		image = null, 
		character = "grotus", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_GROTUS_RESCUE", 
		options = [{code = "rouge_warehouse_escape_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_warehouse_escape_1 = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene"], 
		text = "ROUGE_WAREHOUSE_ESCAPE_1", 
		options = [{code = "rouge_warehouse_escape_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_warehouse_escape_2 = {
		reqs = [], 
		image = null, 
		tags = ["dialogue_scene"], 
		text = "ROUGE_WAREHOUSE_ESCAPE_2", 
		options = [{code = "quest_fight_duel", args = "rouge_warehouse_escape", text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 0, type = "next_dialogue"}]
	},
	
	rouge_warehouse_escape_win = {
		reqs = [], 
		image = null, 
		music = 'threat',
		character = "grotus", 
		tags = ["dialogue_scene"], 
		text = [
			{text = "ROUGE_WAREHOUSE_ESCAPE_WIN", reqs = [], previous_dialogue_option = 0},
			{text = "ROUGE_WAREHOUSE_GROTUS_REPRIMAND", reqs = [], previous_dialogue_option = 2},
		], 
		options = [
			{code = "rouge_warehouse_escape_win", text = "ROUGE_WAREHOUSE_OPTION_FULL_OF_YOURSELF", reqs = [], type = "next_dialogue", dialogue_argument = 2}, 
			{code = "rouge_warehouse_grotus_what_now", text = "ROUGE_WAREHOUSE_OPTION_WHAT_NOW", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_warehouse_grotus_what_now = {
		reqs = [], 
		image = null, 
		character = "grotus", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_WAREHOUSE_GROTUS_WHAT_NOW", 
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "progress_quest", value = "rouge_quest", stage = "raid"}, 
					{code = "update_city"}
				]
			}
		]
	},
	
	rouge_report_melchor_start = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		text = [
			{text = "ROUGE_REPORT_MELCHOR_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = false}]},
			{text = "ROUGE_REPORT_MELCHOR_NO_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = true}]}
		],
		options = [{code = "rouge_report_melchor_raid", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_report_melchor_raid = {
		reqs = [],
		image = "rouge_warehouse_2",
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		text = "ROUGE_REPORT_MELCHOR_RAID",
		options = [
			{code = "rouge_report_melchor_ketch_escape_1", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = false}], type = "next_dialogue"},
			{code = "rouge_report_henchman_basement_intro", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = true}], type = "next_dialogue", bonus_effects = [{code = "screen_black_transition", value = 1}], dialogue_argument = 1}
		]
	},
	
	rouge_report_melchor_ketch_escape_1 = {
		reqs = [], 
		image = null, 
		music = 'threat',
		character = "ketch", 
		tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"], 
		text = "ROUGE_REPORT_MELCHOR_KETCH_ESCAPE_1", 
		options = [{code = "rouge_report_melchor_ketch_escape_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_report_melchor_ketch_escape_2 = {
		reqs = [], 
		image = null, 
		music = 'rouge_theme',
		character = "ketch", 
		character2 = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_REPORT_MELCHOR_KETCH_ESCAPE_2", 
		options = [{code = "rouge_report_melchor_ketch_dead", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_report_melchor_ketch_dead = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_REPORT_MELCHOR_KETCH_DEAD", 
		options = [
			{
				code = "rouge_report_ketch_basement_intro", 
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "decision", value = "RougeKetchKilled"},
					{code = "screen_black_transition", value = 1}
				], 
				dialogue_argument = 1
			}
		]
	},
	rouge_report_ketch_basement_intro = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ROUGE_REPORT_KETCH_BASEMENT_INTRO", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_REPORT_KETCH_WHAT_HAPPENED", reqs = [], previous_dialogue_option = [2, 4]},
			{text = "ROUGE_REPORT_KETCH_CAPITAL", reqs = [], previous_dialogue_option = [3, 5]},
		],
		options = [
			{code = "rouge_report_ketch_basement_intro", text = "ROUGE_REPORT_OPTION_WHAT_HAPPENED", reqs = [], type = "next_dialogue", dialogue_argument = 2, previous_dialogue_option = 1},
			{code = "rouge_report_ketch_basement_intro", text = "ROUGE_REPORT_OPTION_WHAT_HAPPENED", reqs = [], type = "next_dialogue", dialogue_argument = 4, previous_dialogue_option = 3},
			{code = "rouge_report_ketch_basement_intro", text = "ROUGE_REPORT_OPTION_CAPITAL", reqs = [], type = "next_dialogue", dialogue_argument = 3, previous_dialogue_option = 1},
			{code = "rouge_report_ketch_basement_intro", text = "ROUGE_REPORT_OPTION_CAPITAL", reqs = [], type = "next_dialogue", dialogue_argument = 5, previous_dialogue_option = 2},
			{code = "rouge_report_ketch_basement_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", previous_dialogue_option = [4, 5]}
		]
	},
	rouge_report_ketch_basement_1 = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_REPORT_KETCH_BASEMENT_1", 
		options = [{code = "rouge_report_ketch_basement_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_report_ketch_basement_2 = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_REPORT_KETCH_BASEMENT_2",
		options = [
			{code = "rouge_report_ketch_basement_3", text = "ROUGE_REPORT_OPTION_OTHER_PLACES", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_report_ketch_basement_3", text = "ROUGE_REPORT_OPTION_CLEAR_OUT", reqs = [], type = "next_dialogue", dialogue_argument = 2}
		]
	},
	rouge_report_ketch_basement_3 = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = [
			{text = "ROUGE_REPORT_KETCH_BASEMENT_3", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_REPORT_KETCH_BASEMENT_4", reqs = [], previous_dialogue_option = 2},
		],
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "reward"}]}]
	},
	
	rouge_report_henchman_basement_intro = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ROUGE_REPORT_HENCHMAN_BASEMENT_INTRO", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_REPORT_HENCHMAN_WHAT_HAPPENED", reqs = [], previous_dialogue_option = [2, 4]},
			{text = "ROUGE_REPORT_KETCH_CAPITAL", reqs = [], previous_dialogue_option = [3, 5]},
		],
		options = [
			{code = "rouge_report_henchman_basement_intro", text = "ROUGE_REPORT_OPTION_WHAT_DOING", reqs = [], type = "next_dialogue", dialogue_argument = 2, previous_dialogue_option = 1},
			{code = "rouge_report_henchman_basement_intro", text = "ROUGE_REPORT_OPTION_WHAT_DOING", reqs = [], type = "next_dialogue", dialogue_argument = 4, previous_dialogue_option = 3},
			{code = "rouge_report_henchman_basement_intro", text = "ROUGE_REPORT_OPTION_CAPITAL", reqs = [], type = "next_dialogue", dialogue_argument = 3, previous_dialogue_option = 1},
			{code = "rouge_report_henchman_basement_intro", text = "ROUGE_REPORT_OPTION_CAPITAL", reqs = [], type = "next_dialogue", dialogue_argument = 5, previous_dialogue_option = 2},
			{code = "rouge_report_henchman_basement_1", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", previous_dialogue_option = [4, 5], dialogue_argument = 1}
		]
	},
	rouge_report_henchman_basement_1 = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ROUGE_REPORT_HENCHMAN_BASEMENT_1", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_REPORT_HENCHMAN_BASEMENT_2", reqs = [], previous_dialogue_option = [2, 4]},
			{text = "ROUGE_REPORT_HENCHMAN_BASEMENT_3", reqs = [], previous_dialogue_option = [3, 5]},
		],
		options = [
			{code = "rouge_report_henchman_basement_1", text = "ROUGE_REPORT_OPTION_OTHER_PLACES", reqs = [], type = "next_dialogue", dialogue_argument = 2, previous_dialogue_option = 1},
			{code = "rouge_report_henchman_basement_1", text = "ROUGE_REPORT_OPTION_OTHER_PLACES", reqs = [], type = "next_dialogue", dialogue_argument = 4, previous_dialogue_option = 3},
			{code = "rouge_report_henchman_basement_1", text = "ROUGE_REPORT_OPTION_SHOW", reqs = [], type = "next_dialogue", dialogue_argument = 3, previous_dialogue_option = 1},
			{code = "rouge_report_henchman_basement_1", text = "ROUGE_REPORT_OPTION_SHOW", reqs = [], type = "next_dialogue", dialogue_argument = 5, previous_dialogue_option = 2},
			{code = "rouge_report_henchman_basement_2", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", previous_dialogue_option = [4, 5]}
		]
	},
	rouge_report_henchman_basement_2 = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_REPORT_HENCHMAN_BASEMENT_4",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "reward"}]}]
	},
	
	rouge_report_melchor_return = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene"],
		text = "ROUGE_REPORT_MELCHOR_RETURN",
		options = [
			{code = "rouge_report_melchor_reward", text = "ROUGE_REPORT_OPTION_IT_WAS_ROUGE", reqs = [], type = "next_dialogue", dialogue_argument = 1},
			{code = "rouge_report_melchor_reward", text = "ROUGE_REPORT_OPTION_I_DID_IT", reqs = [], type = "next_dialogue", dialogue_argument = 2}
		]
	},
	rouge_report_melchor_reward = {
		reqs = [], 
		image = null, 
		character = 'chancellor',
		tags = ["dialogue_scene"], 
		text = [
			{text = "ROUGE_REPORT_MELCHOR_REWARD_ROUGE", reqs = [], previous_dialogue_option = 1},
			{text = "ROUGE_REPORT_MELCHOR_REWARD_SELF", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "money_change", operant = "+", value = 1000}, 
					{code = "progress_quest", value = "rouge_quest", stage = "rouge"}, 
					{code = "update_city"}
				]
			}
		]
	},
	rouge_report_melchor_return_alternate = {
		reqs = [],
		image = null,
		character = 'chancellor',
		tags = ["dialogue_scene"],
		text = "ROUGE_REPORT_MELCHOR_RETURN_2",
		options = [
			{
				code = "close", 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = "next_dialogue", 
				bonus_effects = [
					{code = "money_change", operant = "+", value = 1000}, 
					{code = "progress_quest", value = "rouge_quest", stage = "rouge"}, 
					{code = "update_city"}
				]
			}
		]
	},
	
	rouge_return_to_rouge = {
		reqs = [], 
		image = null, 
		character = "rouge", 
		tags = ["dialogue_scene"], 
		text = "ROUGE_RETURN_TO_ROUGE", 
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [],
				type = "next_dialogue",
				bonus_effects = [
					{code = "unique_character_changes", value = "rouge", args = [
						{code = "add_trait", trait = "training_s_working", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "servant"}]},
						{code = "add_trait", trait = "training_callmaster", reqs = [{code = "stat", stat = "slave_class", operant = "eq", value = "slave"}]},
					]},
					{code = "complete_quest", value = "rouge_quest"},
				]
			}
		]
	},
	
	rouge_furniture_reward = {
		image = null,
		reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true}],
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_FURNITURE_REWARD",
		options = [
			{code = "rouge_sex_1", text = "ROUGE_FURNITURE_REWARD_OPTION_ACCEPT", type = "next_dialogue", reqs = [], dialogue_argument = 1},
			{code = "rouge_furniture_reward_refuse", text = "ROUGE_FURNITURE_REWARD_OPTION_REFUSE", type = "next_dialogue", reqs = [], dialogue_argument = 1}
		]
	},
	rouge_furniture_reward_refuse = {
		image = null,
		reqs = [],
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_FURNITURE_REWARD_REFUSE",
		options = [{code = "close", text = "DIALOGUECLOSE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	
	rouge_sex_1 = {
		image = null,
		reqs = [],
		music = 'intimacy_dark',
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "rouge_sex",
		text = "ROUGE_SEX_1",
		options = [{code = "rouge_sex_2", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_2 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_2",
		options = [{code = "rouge_sex_3", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_3 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_3",
		options = [{code = "rouge_sex_4", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_4 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_4",
		options = [{code = "rouge_sex_5", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_5 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_5",
		options = [{code = "rouge_sex_6", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_6 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_6",
		options = [{code = "rouge_sex_7", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_7 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene"],
		custom_background = "rouge_sex_7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_7",
		options = [{code = "rouge_sex_8", text = "DIALOGUECONTINUE", type = "next_dialogue", reqs = [], dialogue_argument = 1}]
	},
	rouge_sex_8 = {
		image = null,
		reqs = [],
		tags = ["dialogue_scene", "master_translate"],
		custom_background = "rouge_sex_8",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = "ROUGE_SEX_8",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue"}]
	},
}
