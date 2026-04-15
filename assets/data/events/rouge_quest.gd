extends Reference
var data = {
	rouge_demoness_intermission_start = {
		reqs = [],
		image = null,
		character = "grotus",
		character2 = "demon_female",
		tags = ["dialogue_scene"],
		text = "ROUGE_DEMONESS_INTERMISSION_START",
		options = [{code = "rouge_demoness_intermission_mhyrana", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_demoness_intermission_mhyrana = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_DEMONESS_INTERMISSION_MHYRANA",
		options = [{code = "rouge_demoness_intermission_grotus", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_demoness_intermission_grotus = {
		reqs = [],
		image = null,
		character = "rouge",
		character2 = "demon_female",
		tags = ["dialogue_scene"],
		text = "ROUGE_DEMONESS_INTERMISSION_GROTUS",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue"}]
	},
	rouge_melchor_confrontation_start = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MELCHOR_CONFRONTATION_START",
		options = [
			{code = "rouge_melchor_confrontation_response", text = "ROUGE_MELCHOR_OPTION_MILD_EXERCISE", reqs = [], type = "next_dialogue"},
			{code = "rouge_melchor_confrontation_response", text = "ROUGE_MELCHOR_OPTION_CROWDS_PLEASED", reqs = [], type = "next_dialogue"},
			{code = "rouge_melchor_confrontation_response", text = "ROUGE_MELCHOR_OPTION_CIRCUMSTANCES", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_melchor_confrontation_response = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MELCHOR_CONFRONTATION_RESPONSE",
		options = [
			{code = "rouge_melchor_confrontation_accept", text = "ROUGE_MELCHOR_OPTION_ACCEPT_CUSTODY", reqs = [], type = "next_dialogue", bonus_effects = [{code = "make_story_character", value = "Rouge", recruit_from_location = true}, {code = "progress_quest", value = "rouge_quest", stage = "mansion"}]},
			{code = "rouge_melchor_confrontation_refuse", text = "ROUGE_MELCHOR_OPTION_REFUSE_TRAP", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_melchor_confrontation_accept = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_ACCEPT",
		options = [{code = "rouge_melchor_confrontation_depart", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_melchor_confrontation_refuse = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_REFUSE",
		options = [{code = "rouge_melchor_confrontation_depart", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_melchor_confrontation_depart = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MELCHOR_CONFRONTATION_DEPART",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "add_timed_event", value = "rouge_mansion_arrival", args = [{type = "add_to_date", date = [1,1], hour = 1}]}, {code = "update_city"}]}]
	},
	rouge_mansion_arrival = {
		reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true, negative = "repeat_next_day"}],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_MANSION_ARRIVAL",
		options = [
			{code = "rouge_mansion_reason", text = "ROUGE_MANSION_OPTION_REASON", reqs = [], type = "next_dialogue"},
			{code = "rouge_mansion_status", text = "ROUGE_MANSION_OPTION_STATUS", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_mansion_reason = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_MANSION_REASON", options = [{code = "rouge_mansion_handle", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_mansion_status = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene", "master_translate"], text = "ROUGE_MANSION_STATUS", options = [{code = "rouge_mansion_handle", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_mansion_handle = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MANSION_HANDLE",
		options = [
			{code = "rouge_mansion_custody_warning", text = "ROUGE_MANSION_OPTION_CUSTODY_WARNING", reqs = [], type = "next_dialogue"},
			{code = "rouge_mansion_show_quarters", text = "ROUGE_MANSION_OPTION_SHOW_QUARTERS", reqs = [], type = "next_dialogue"},
			{code = "rouge_mansion_slave_status", text = "ROUGE_MANSION_OPTION_SLAVE_STATUS", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_mansion_custody_warning = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_MANSION_CUSTODY_WARNING", options = [{code = "rouge_mansion_handle", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_mansion_slave_status = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MANSION_SLAVE_STATUS",
		options = [
			{code = "rouge_mansion_slave_confirm", text = "ROUGE_MANSION_OPTION_SLAVE_CONFIRM", reqs = [], type = "next_dialogue"},
			{code = "rouge_mansion_show_quarters", text = "ROUGE_MANSION_OPTION_NEVERMIND_QUARTERS", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_mansion_slave_confirm = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene", "blackscreen_transition_common"], text = "ROUGE_MANSION_SLAVE_CONFIRM", options = [{code = "rouge_mansion_show_quarters", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_mansion_show_quarters = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_MANSION_SHOW_QUARTERS",
		options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "add_timed_event", value = "rouge_room_complaint_start", args = [{type = "add_to_date", date = [1,1], hour = 1}]}, {code = "update_city"}]}]
	},
	rouge_room_complaint_start = {
		reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true, negative = "repeat_next_day"}],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_ROOM_COMPLAINT_START",
		options = [
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_BARELY_WORSE", reqs = [], type = "next_dialogue"},
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_NOTHING_WRONG", reqs = [], type = "next_dialogue"},
			{code = "rouge_room_complaint_demands", text = "ROUGE_ROOM_OPTION_GET_USED", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_room_complaint_demands = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_ROOM_COMPLAINT_DEMANDS",
		options = [
			{code = "rouge_room_complaint_demanding", text = "ROUGE_ROOM_OPTION_DEMANDING", reqs = [], type = "next_dialogue"},
			{code = "rouge_room_complaint_refuse", text = "ROUGE_ROOM_OPTION_REFUSE", reqs = [], type = "next_dialogue"},
			{code = "rouge_room_complaint_accept", text = "ROUGE_ROOM_OPTION_WORKERS_GUILD", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "furniture"}]}
		]
	},
	rouge_room_complaint_demanding = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_ROOM_COMPLAINT_DEMANDING", options = [{code = "rouge_room_complaint_demands", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_room_complaint_refuse = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_ROOM_COMPLAINT_REFUSE", options = [{code = "rouge_room_complaint_demands", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_room_complaint_accept = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_ROOM_COMPLAINT_ACCEPT", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue"}]},
	rouge_workers_furniture_start = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_WORKERS_FURNITURE_START",
		options = [{code = "rouge_workers_furniture_terms", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "screen_black_transition", value = 1}]}]
	},
	rouge_workers_furniture_terms = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_WORKERS_FURNITURE_TERMS",
		options = [
			{code = "rouge_workers_furniture_paid", text = "ROUGE_WORKERS_OPTION_PAY_GOLD", reqs = [{type = "has_money", value = 10000}], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "-", value = 10000}, {code = "progress_quest", value = "rouge_quest", stage = "letter"}]},
			{code = "rouge_workers_furniture_cannot_afford", text = "ROUGE_WORKERS_OPTION_CANNOT_AFFORD", reqs = [], type = "next_dialogue"},
			{code = "rouge_workers_furniture_materials_offer", text = "ROUGE_WORKERS_OPTION_DISCUSS", reqs = [], type = "next_dialogue"},
			{code = "rouge_workers_furniture_paid", text = "ROUGE_WORKERS_OPTION_MATERIALS", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "letter"}]},
			{code = "close", text = "ROUGE_WORKERS_OPTION_NEED_TIME", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_workers_furniture_cannot_afford = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_WORKERS_FURNITURE_CANNOT_AFFORD",
		options = [
			{code = "rouge_workers_furniture_paid", text = "ROUGE_WORKERS_OPTION_RECONSIDER", reqs = [], type = "next_dialogue"},
			{code = "rouge_workers_furniture_charm_success", text = "ROUGE_WORKERS_OPTION_NO_INDULGE", reqs = [{type = "master_check", value = [{code = "stat", stat = "charm_factor", operant = "gte", value = 5}]}], type = "next_dialogue"},
			{code = "rouge_workers_furniture_charm_fail", text = "ROUGE_WORKERS_OPTION_NO_INDULGE", reqs = [{type = "master_check", value = [{code = "stat", stat = "charm_factor", operant = "lt", value = 5}]}], type = "next_dialogue"}
		]
	},
	rouge_workers_furniture_materials_offer = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_WORKERS_FURNITURE_MATERIALS_OFFER", options = [{code = "rouge_workers_furniture_terms", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_workers_furniture_paid = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_WORKERS_FURNITURE_PAID", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "add_timed_event", value = "rouge_letter_request", args = [{type = "add_to_date", date = [2,2], hour = 3}]}, {code = "update_city"}]}]},
	rouge_workers_furniture_charm_success = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene", "master_translate"], text = "ROUGE_WORKERS_FURNITURE_CHARM_SUCCESS", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "letter"}, {code = "add_timed_event", value = "rouge_letter_request", args = [{type = "add_to_date", date = [2,2], hour = 3}]}, {code = "update_city"}]}]},
	rouge_workers_furniture_charm_fail = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene", "master_translate"], text = "ROUGE_WORKERS_FURNITURE_CHARM_FAIL", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "letter"}, {code = "add_timed_event", value = "rouge_letter_request", args = [{type = "add_to_date", date = [2,2], hour = 3}]}, {code = "update_city"}]}]},
	rouge_letter_request = {
		reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true, negative = "repeat_next_day"}],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_LETTER_REQUEST",
		options = [
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_FAVOR", reqs = [], type = "next_dialogue"},
			{code = "rouge_letter_request_details", text = "ROUGE_LETTER_OPTION_FISHY", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_letter_request_details = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_LETTER_REQUEST_DETAILS",
		options = [
			{code = "rouge_letter_request_contents", text = "ROUGE_LETTER_OPTION_CONTENTS", reqs = [], type = "next_dialogue"},
			{code = "rouge_letter_request_why_you", text = "ROUGE_LETTER_OPTION_WHY_YOU", reqs = [], type = "next_dialogue"},
			{code = "rouge_letter_request_rivals", text = "ROUGE_LETTER_OPTION_RIVALS", reqs = [], type = "next_dialogue"},
			{code = "rouge_letter_request_accept", text = "ROUGE_LETTER_OPTION_ACCEPT", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_letter_request_contents = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_LETTER_REQUEST_CONTENTS", options = [{code = "rouge_letter_request_details", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_letter_request_why_you = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_LETTER_REQUEST_WHY_YOU", options = [{code = "rouge_letter_request_details", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_letter_request_rivals = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_LETTER_REQUEST_RIVALS", options = [{code = "rouge_letter_request_details", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_letter_request_accept = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_LETTER_REQUEST_ACCEPT", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "melchor"}, {code = "update_city"}]}]},
	rouge_chat_root = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_CHAT_ROOT",
		options = [
			{code = "rouge_chat_cult", text = "ROUGE_CHAT_OPTION_CULT", reqs = [], type = "next_dialogue"},
			{code = "rouge_chat_melchor", text = "ROUGE_CHAT_OPTION_MELCHOR", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_chat_cult = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_CHAT_CULT",
		options = [
			{code = "rouge_chat_cult_ally", text = "ROUGE_CHAT_OPTION_CULT_ALLY", reqs = [], type = "next_dialogue"},
			{code = "rouge_chat_cult_kuro", text = "ROUGE_CHAT_OPTION_KURO", reqs = [{type = "unique_character_at_mansion", name = "kuro", check = true}], type = "next_dialogue"},
			{code = "rouge_chat_cult_goal", text = "ROUGE_CHAT_OPTION_CULT_GOAL", reqs = [], type = "next_dialogue"},
			{code = "close", text = "ROUGE_CHAT_OPTION_NO_MORE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_chat_cult_ally = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_CHAT_CULT_ALLY", options = [{code = "rouge_chat_cult", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_chat_cult_kuro = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_CHAT_CULT_KURO", options = [{code = "rouge_chat_cult", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_chat_cult_goal = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_CHAT_CULT_GOAL", options = [{code = "rouge_chat_cult", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_chat_melchor = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_CHAT_MELCHOR", options = [{code = "rouge_chat_root", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_meet_melchor_start = {
		reqs = [],
		image = null,
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
		tags = ["dialogue_scene"],
		text = "ROUGE_MEET_MELCHOR_REASON",
		options = [
			{code = "rouge_meet_melchor_letter", text = "ROUGE_MEET_OPTION_LETTER", reqs = [], type = "next_dialogue"},
			{code = "rouge_meet_melchor_letter", text = "ROUGE_MEET_OPTION_ROUGE_MESSAGE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_meet_melchor_letter = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene"],
		text = "ROUGE_MEET_MELCHOR_LETTER",
		options = [
			{code = "rouge_meet_melchor_cult", text = "ROUGE_MEET_OPTION_CULT", reqs = [], type = "next_dialogue"},
			{code = "rouge_meet_melchor_addresses", text = "ROUGE_MEET_OPTION_ADDRESSES", reqs = [], type = "next_dialogue"},
			{code = "rouge_meet_melchor_plan", text = "ROUGE_MEET_OPTION_PLAN", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_meet_melchor_cult = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_MEET_MELCHOR_CULT", options = [{code = "rouge_meet_melchor_letter", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_meet_melchor_addresses = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_MEET_MELCHOR_ADDRESSES", options = [{code = "rouge_meet_melchor_letter", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_meet_melchor_plan = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene"],
		text = "ROUGE_MEET_MELCHOR_PLAN",
		options = [
			{code = "rouge_meet_melchor_mutual_interest", text = "ROUGE_MEET_OPTION_MUTUAL_INTEREST", reqs = [], type = "next_dialogue"},
			{code = "rouge_meet_melchor_reward", text = "ROUGE_MEET_OPTION_REWARD", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_meet_melchor_mutual_interest = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_MEET_MELCHOR_MUTUAL_INTEREST", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "warehouse"}, {code = "update_city"}]}]},
	rouge_meet_melchor_reward = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_MEET_MELCHOR_REWARD", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "warehouse"}, {code = "update_city"}]}]},
	rouge_warehouse_search = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_WAREHOUSE_SEARCH", options = [{code = "rouge_warehouse_approach", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_warehouse_approach = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_WAREHOUSE_APPROACH_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = false}]},
			{text = "ROUGE_WAREHOUSE_APPROACH_HENCHMAN", reqs = [{type = "decision", value = "KetchKilled", check = true}]}
		],
		options = [
			{code = "rouge_warehouse_peek", text = "ROUGE_WAREHOUSE_OPTION_PEEK", reqs = [], type = "next_dialogue"},
			{code = "rouge_warehouse_slip_inside", text = "ROUGE_WAREHOUSE_OPTION_SLIP_INSIDE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_warehouse_peek = {
		reqs = [],
		image = null,
		character = "ketch",
		tags = ["dialogue_scene"],
		text = [
			{text = "ROUGE_WAREHOUSE_PEEK_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = false}]},
			{text = "ROUGE_WAREHOUSE_PEEK_HENCHMAN", reqs = [{type = "decision", value = "KetchKilled", check = true}]}
		],
		options = [{code = "rouge_warehouse_capture", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_warehouse_slip_inside = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_WAREHOUSE_SLIP_INSIDE", options = [{code = "rouge_warehouse_capture", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_warehouse_capture = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_slow"],
		text = "ROUGE_WAREHOUSE_CAPTURE",
		options = [
			{code = "rouge_interrogation_ketch_start", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = false}], type = "next_dialogue"},
			{code = "rouge_interrogation_henchman_start", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = true}], type = "next_dialogue"}
		]
	},
	rouge_interrogation_ketch_start = {
		reqs = [],
		image = null,
		character = "ketch",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_INTERROGATION_KETCH_START",
		options = [
			{code = "rouge_interrogation_ketch_tough", text = "ROUGE_INTERROGATION_OPTION_SILENT", reqs = [], type = "next_dialogue"},
			{code = "rouge_interrogation_ketch_tough", text = "ROUGE_INTERROGATION_OPTION_NOTHING", reqs = [], type = "next_dialogue"},
			{code = "rouge_interrogation_ketch_rouge", text = "ROUGE_INTERROGATION_OPTION_ROUGE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_interrogation_ketch_tough = {reqs = [], image = null, character = "ketch", tags = ["dialogue_scene"], text = "ROUGE_INTERROGATION_KETCH_TOUGH", options = [{code = "rouge_interrogation_ketch_rouge", text = "ROUGE_INTERROGATION_OPTION_ROUGE_SENT", reqs = [], type = "next_dialogue"}, {code = "rouge_interrogation_ketch_bitch", text = "ROUGE_INTERROGATION_OPTION_HIT_LIKE", reqs = [], type = "next_dialogue"}]},
	rouge_interrogation_ketch_rouge = {reqs = [], image = null, character = "ketch", tags = ["dialogue_scene"], text = "ROUGE_INTERROGATION_KETCH_ROUGE", options = [{code = "rouge_interrogation_over_ketch", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_interrogation_ketch_bitch = {reqs = [], image = null, character = "ketch", tags = ["dialogue_scene"], text = "ROUGE_INTERROGATION_KETCH_BITCH", options = [{code = "rouge_interrogation_over_ketch", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_interrogation_henchman_start = {reqs = [], image = null, tags = ["dialogue_scene", "master_translate"], text = "ROUGE_INTERROGATION_HENCHMAN_START", options = [{code = "rouge_interrogation_henchman_question", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_interrogation_henchman_question = {reqs = [], image = null, tags = ["dialogue_scene", "master_translate"], text = "ROUGE_INTERROGATION_HENCHMAN_QUESTION", options = [{code = "rouge_interrogation_over_henchman", text = "ROUGE_INTERROGATION_OPTION_BUSINESS", reqs = [], type = "next_dialogue"}, {code = "rouge_interrogation_over_henchman", text = "ROUGE_INTERROGATION_OPTION_SQUAD", reqs = [], type = "next_dialogue"}]},
	rouge_interrogation_over_ketch = {reqs = [], image = null, character = "ketch", tags = ["dialogue_scene"], text = "ROUGE_INTERROGATION_OVER_KETCH", options = [{code = "rouge_grotus_rescue", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_interrogation_over_henchman = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_INTERROGATION_OVER_HENCHMAN", options = [{code = "rouge_grotus_rescue", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_grotus_rescue = {reqs = [], image = null, character = "grotus", tags = ["dialogue_scene"], text = "ROUGE_GROTUS_RESCUE", options = [{code = "rouge_warehouse_escape", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_warehouse_escape = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_WAREHOUSE_ESCAPE", options = [{code = "rouge_warehouse_escape_win", text = "DIALOGUEFIGHTOPTION", reqs = [], type = "next_dialogue"}]},
	rouge_warehouse_escape_win = {reqs = [], image = null, character = "grotus", tags = ["dialogue_scene"], text = "ROUGE_WAREHOUSE_ESCAPE_WIN", options = [{code = "rouge_warehouse_grotus_reprimand", text = "ROUGE_WAREHOUSE_OPTION_FULL_OF_YOURSELF", reqs = [], type = "next_dialogue"}, {code = "rouge_warehouse_grotus_what_now", text = "ROUGE_WAREHOUSE_OPTION_WHAT_NOW", reqs = [], type = "next_dialogue"}]},
	rouge_warehouse_grotus_reprimand = {reqs = [], image = null, character = "grotus", tags = ["dialogue_scene"], text = "ROUGE_WAREHOUSE_GROTUS_REPRIMAND", options = [{code = "rouge_warehouse_escape_win", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_warehouse_grotus_what_now = {reqs = [], image = null, character = "grotus", tags = ["dialogue_scene"], text = "ROUGE_WAREHOUSE_GROTUS_WHAT_NOW", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "raid"}, {code = "update_city"}]}]},
	rouge_report_melchor_start = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		text = [
			{text = "ROUGE_REPORT_MELCHOR_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = false}]},
			{text = "ROUGE_REPORT_MELCHOR_NO_KETCH", reqs = [{type = "decision", value = "KetchKilled", check = true}]}
		],
		options = [{code = "rouge_report_melchor_raid", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]
	},
	rouge_report_melchor_raid = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene", "blackscreen_transition_common"],
		text = "ROUGE_REPORT_MELCHOR_RAID",
		options = [
			{code = "rouge_report_melchor_ketch_escape", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = false}], type = "next_dialogue"},
			{code = "rouge_report_melchor_return", text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "KetchKilled", check = true}], type = "next_dialogue"}
		]
	},
	rouge_report_melchor_ketch_escape = {reqs = [], image = null, character = "ketch", character2 = "rouge", tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"], text = "ROUGE_REPORT_MELCHOR_KETCH_ESCAPE", options = [{code = "rouge_report_melchor_ketch_dead", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_report_melchor_ketch_dead = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_REPORT_MELCHOR_KETCH_DEAD", options = [{code = "rouge_report_melchor_basement_intro", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "decision", value = "KetchKilled"}]}]},
	rouge_report_melchor_basement_intro = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene", "master_translate"],
		text = "ROUGE_REPORT_MELCHOR_BASEMENT_INTRO",
		options = [
			{code = "rouge_report_melchor_what_happened", text = "ROUGE_REPORT_OPTION_WHAT_HAPPENED", reqs = [], type = "next_dialogue"},
			{code = "rouge_report_melchor_capital", text = "ROUGE_REPORT_OPTION_CAPITAL", reqs = [], type = "next_dialogue"},
			{code = "rouge_report_melchor_basement", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_report_melchor_what_happened = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_REPORT_MELCHOR_WHAT_HAPPENED", options = [{code = "rouge_report_melchor_basement_intro", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_report_melchor_capital = {reqs = [], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_REPORT_MELCHOR_CAPITAL", options = [{code = "rouge_report_melchor_basement_intro", text = "DIALOGUECONTINUE", reqs = [], type = "next_dialogue"}]},
	rouge_report_melchor_basement = {
		reqs = [],
		image = null,
		character = "rouge",
		tags = ["dialogue_scene"],
		text = "ROUGE_REPORT_MELCHOR_BASEMENT",
		options = [
			{code = "close", text = "ROUGE_REPORT_OPTION_OTHER_PLACES", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "reward"}]},
			{code = "close", text = "ROUGE_REPORT_OPTION_CLEAR_OUT", reqs = [], type = "next_dialogue", bonus_effects = [{code = "progress_quest", value = "rouge_quest", stage = "reward"}]}
		]
	},
	rouge_report_melchor_return = {
		reqs = [],
		image = null,
		tags = ["dialogue_scene"],
		text = "ROUGE_REPORT_MELCHOR_RETURN",
		options = [
			{code = "rouge_report_melchor_reward_rouge", text = "ROUGE_REPORT_OPTION_IT_WAS_ROUGE", reqs = [], type = "next_dialogue"},
			{code = "rouge_report_melchor_reward_self", text = "ROUGE_REPORT_OPTION_I_DID_IT", reqs = [], type = "next_dialogue"}
		]
	},
	rouge_report_melchor_reward_rouge = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_REPORT_MELCHOR_REWARD_ROUGE", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "+", value = 1000}, {code = "progress_quest", value = "rouge_quest", stage = "rouge"}, {code = "update_city"}]}]},
	rouge_report_melchor_reward_self = {reqs = [], image = null, tags = ["dialogue_scene"], text = "ROUGE_REPORT_MELCHOR_REWARD_SELF", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "money_change", operant = "+", value = 1000}, {code = "progress_quest", value = "rouge_quest", stage = "rouge"}, {code = "update_city"}]}]},
	rouge_return_to_rouge = {reqs = [{type = "unique_character_at_mansion", name = "rouge", check = true, negative = "repeat_next_day"}], image = null, character = "rouge", tags = ["dialogue_scene"], text = "ROUGE_RETURN_TO_ROUGE", options = [{code = "close", text = "DIALOGUECLOSE", reqs = [], type = "next_dialogue", bonus_effects = [{code = "complete_quest", value = "rouge_quest"}, {code = "update_city"}]}]},
}
