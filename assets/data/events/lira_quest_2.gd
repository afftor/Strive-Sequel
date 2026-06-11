extends Reference
var data = {
	lira_quest2_day_usual_step_outside_mansion = {
		image = null,
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_DAY_USUAL_STEP_OUTSIDE_MANSION",
		options = [
			{
				code = 'close', 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1,
				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_2', stage = 'start'},] #or not
			},
		],
	},
	lira_quest2_find_lira_front_garden_tends = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_FIND_LIRA_FRONT_GARDEN_TENDS", 
		options = [
			{code = 'lira_quest2_lira_know_special_occasion_today', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_know_special_occasion_today = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_KNOW_SPECIAL_OCCASION_TODAY", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_think_perhaps_chance_visit', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_think_perhaps_chance_visit = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_THINK_PERHAPS_CHANCE_VISIT", reqs = []}],
		options = [
			{
				code = 'lira_quest2_agree', 
				text = "LIRA_QUEST2_OPTION_FINE_TAKE_STAY_CLOSE_BEHAVE_LIKE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
			{
				code = 'lira_quest2_agree', 
				text = "LIRA_QUEST2_OPTION_SURE_THING_RIGHT_SATISFY_CURIOSITY_YOURS", 
				reqs = [], 
				dialogue_argument = 2, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
		],
	},
	lira_quest2_agree = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_AGREE_DEP", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QULIRA_QUEST2_AGREE_FREE", reqs = [], previous_dialogue_option = 1},
		],
		options = [
			{
				code = 'close', 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'progress_quest', value = 'lira_quest_2', stage = 'fair'},]
			},
		],
	},
	
	lira_quest2_fair_arrival = {
		reqs = [],
		tags = ['dialogue_scene', 'master_translate'], character = 'lira',
		text = [
			{text = "LIRA_QUEST2_FAIR_ARRIVAL", reqs = [], previous_dialogue_option = 0},
			{text = "LIRA_QUEST2_FOOD_FREE_RESULT", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_FOOD_BUY_RESULT", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST2_ACC_HAIRPIN_CONCLUSION", reqs = [], previous_dialogue_option = 3},
			{text = "LIRA_QUEST2_SHOOTING_4", reqs = [], previous_dialogue_option = 4},
			{text = "LIRA_QUEST2_LIRA_VENDOR_IGNORE_2", reqs = [], previous_dialogue_option = 5},
			{text = "LIRA_QUEST2_LIRA_VENDOR_PUNISH_2", reqs = [], previous_dialogue_option = 6},
			{text = "LIRA_QUEST2_COUPLE_DANCES_TWO_STEP_ASIDE", reqs = [], previous_dialogue_option = 7},
			{text = "LIRA_QUEST2_LIRA_BRAWL_RETURN", reqs = [], previous_dialogue_option = 8},
		],
		options = [
			{
				code = 'lira_quest2_food_intro', 
				text = "LIRA_QUEST2_OPTION_FOOD_STALLS", 
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'neq', value = 2, check = true}], 
				remove_after_first_use = true,
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'total_visits', op = '+'},]
				},
			{
				code = 'lira_quest2_acc_intro', 
				text = "LIRA_QUEST2_OPTION_ACCESSORIES_AREA", 
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'neq', value = 2, check = true}], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				remove_after_first_use = true,
				bonus_effects = [{code = 'dialogue_counter', name = 'total_visits', op = '+'},]
			},
			{
				code = 'lira_quest2_shooting_intro', 
				text = "LIRA_QUEST2_OPTION_SHOOTING_RANGE", 
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'neq', value = 2, check = true}], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				remove_after_first_use = true,
				bonus_effects = [{code = 'dialogue_counter', name = 'total_visits', op = '+'},]
			},
			{
				code = 'lira_quest2_elven_intro', 
				text = "LIRA_QUEST2_OPTION_ELVEN_PART_FAIR", 
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'neq', value = 2, check = true}], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				remove_after_first_use = true,
				bonus_effects = [{code = 'dialogue_counter', name = 'total_visits', op = '+'},]
			},
			{
				code = 'lira_quest2_brawler_incident', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'eq', value = 2, check = true}], 
				dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'total_visits', op = '+'},]
			},
			{
				code = 'lira_quest2_costume_reveal', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'eq', value = 5, check = true}], 
				dialogue_argument = 1, type = 'next_dialogue',
			},
		],
	},
	
	lira_quest2_food_intro = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_TURN_FOOD_STALLS_AREA_APPROACH",
		options = [
			{
				code = 'lira_quest2_fair_arrival', 
				text = "LIRA_QUEST2_OPTION_SUGGEST_TRIES_FREE_SAMPLES", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue'
			},
			{
				code = 'lira_quest2_food_buy_offer',
				text = "LIRA_QUEST2_OPTION_OFFER_BUY_FOOD", 
				reqs = [{type = "has_money", value = 200}], 
				dialogue_argument = 1, 
				type = 'next_dialogue'
			},
		],
	},
	lira_quest2_food_buy_offer = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_POINT_BUY", 
		options = [
			{
				code = 'lira_quest2_fair_arrival', 
				text = "LIRA_QUEST2_OPTION_COURSE_LIKE_REWARD_GOOD_BEHAVING_SERVANTS", 
				reqs = [], 
				dialogue_argument = 2, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = "money_change", operant = "-", value = 200}
				]
			},
			{
				code = 'lira_quest2_fair_arrival', 
				text = "LIRA_QUEST2_OPTION_SURE_THING_KNOW_WANT_TRY_PICK", 
				reqs = [], 
				dialogue_argument = 2, 
				type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = "money_change", operant = "-", value = 200}
				]
			},
		],
	},
	
	lira_quest2_acc_intro = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_FAIR_ACCESSORIES_1", 
		options = [
			{
				code = 'lira_quest2_acc_1', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], 
				dialogue_argument = 1, 
				type = 'next_dialogue'
			},
			{
				code = 'lira_quest2_acc_2', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], 
				dialogue_argument = 1, 
				type = 'next_dialogue'
			},
		],
	},
	lira_quest2_acc_1 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_FAIR_ACCESSORIES_2", 
		options = [
			{code = 'lira_quest2_acc_2', text = "LIRA_QUEST2_OPTION_DID_WANT_HAIRPIN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest2_acc_2', text = "LIRA_QUEST2_OPTION_SOMETHING_CAUGHT_EYE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_2 = {
		reqs = [],
		tags = ['dialogue_scene', 'master_translate'], character = 'lira',
		text = [
			{text = "LIRA_QUEST2_FAIR_ACCESSORIES_3", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_ACC_DEP_CONFIRM", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'lira_quest2_acc_stall_queue', 
				text = "LIRA_QUEST2_OPTION_SURE_SPOIL_SLAVE_LITTLE_ESPECIALLY_SINCE", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
			{
				code = 'lira_quest2_acc_stall_queue', 
				text = "LIRA_QUEST2_OPTION_PROBLEM_ALLOWED_GOOD_THINGS_CONSIDER_GIFT", 
				reqs = [], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
		],
	},
	lira_quest2_acc_stall_queue = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_WALK_STALL_TAKE_PLACE_SMALL", 
		options = [
			{
				code = 'lira_quest2_acc', 
				text = "LIRA_QUEST2_OPTION_PAY_HAIRPIN", 
				reqs = [{type = "has_money", value = 300}], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'money_change', operant = '-', value = 300},]
			},
			{
				code = 'lira_quest2_acc', 
				text = "LIRA_QUEST2_OPTION_STEAL_HAIRPIN", 
				reqs = [], 
				dialogue_argument = 2, 
				type = 'next_dialogue'
			},
		],
	},
	lira_quest2_acc = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_TURN_POINT_PIN_1", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_TURN_POINT_PIN_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'lira_quest2_acc_hairpin_present', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_hairpin_present = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_TURN_POINT_PIN_3", 
		options = [
			{
				code = 'lira_quest2_fair_arrival', 
				text = "LIRA_QUEST2_OPTION_SUITS_PERFECTLY", 
				reqs = [], 
				dialogue_argument = 3, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
			{
				code = 'lira_quest2_fair_arrival', 
				text = "LIRA_QUEST2_OPTION_COURSE_LIKE_SLAVES_PRETTY", 
				reqs = [], 
				dialogue_argument = 3, 
				type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
		],
	},
	
	lira_quest2_shooting_intro = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_FAIR_SHOOTING",
		options = [
			{code = 'lira_quest2_player_setup', text = "LIRA_QUEST2_OPTION_JOIN_COMPETITION_YOURSELF", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_shooting_lira_intro', text = "LIRA_QUEST2_OPTION_LIRA_JOIN_COMPETITION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_setup = {
		image = null, 
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_SHOOTING_SELF", 
		options = [
			{code = 'lira_quest2_shooting_lira_intro', text = "LIRA_QUEST2_OPTION_KEEP_SHOOTING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{
				code = 'lira_quest2_player_win_setup', 
				text = "LIRA_QUEST2_OPTION_PUSH_TRAINED_MUSCLES_DRAW_FULL_STRING",
				reqs = [{type = 'master_check', value = [
					{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 5},
					{code = 'has_any_profession', value = ['archer', 'ranger', 'sniper']},
				]}],
				dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	lira_quest2_player_win_setup = {
		image = null,
		tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SHOOTING_2", reqs = []}],
		options = [
			{code = 'lira_quest2_player_win_vendor', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_win_vendor = {
		image = null, 
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_SHOOTING_3",
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],
	},
	lira_quest2_shooting_lira_intro = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_SHOOTING_LIRA_1", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_SHOOTING_1", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'lira_quest2_lira_shooting', 
				text = "LIRA_QUEST2_OPTION_HEY_TRY_WIN_SOMETHING", 
				reqs = [], dialogue_argument = 1, type = 'next_dialogue', master_translate = true,
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
			{
				code = 'lira_quest2_lira_shooting', 
				text = "LIRA_QUEST2_OPTION_INTERESTED_AHEAD_MAYBE_YOULL_ENJOY", 
				reqs = [], dialogue_argument = 2, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
		],
	},
	lira_quest2_lira_shooting = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_SHOOTING_LIRA_2", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_SHOOTING_LIRA_3", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'lira_quest2_lira_shooting_setup', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_setup = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_SHOOTING_LIRA_4",
		options = [
			{code = 'lira_quest2_lira_shooting_progress', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_progress = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_SHOOTING_LIRA_5", 
		options = [
			{code = 'lira_quest2_lira_shooting_wins', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_wins = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_SHOOTING_LIRA_6", 
		options = [
			{code = 'lira_quest2_lira_shooting_booth', text = "LIRA_QUEST2_OPTION_PROUD_DID_GREAT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_shooting_booth', text = "LIRA_QUEST2_OPTION_SURE_DID_PRIZE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_booth = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_FINALLY_RUSH_PEOPLE_SUBSIDES_LIRA",
		options = [
			{code = 'lira_quest2_lira_shooting_vendor_insult', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_vendor_insult = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_HUH_DID_VENDOR_FINALLY", 
		options = [
			{code = 'lira_quest2_lira_shooting_sore1', text = "LIRA_QUEST2_OPTION_LOOKS_LIKE_SOMEONE_SORE_LOSER_FORGET", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_shooting_mayor1', text = "LIRA_QUEST2_OPTION_MAYOR_ALIRON_LET_TELL_SOMETHING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_sore1 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_VENDOR_IGNORE_1",
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 5, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_mayor1 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_VENDOR_PUNISH_1", 
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6, type = 'next_dialogue'},
		],
	},
	
	lira_quest2_elven_intro = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_FAIR_ELVEN",
		options = [
			{code = 'lira_quest2_elven_figurines', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_figurines = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_OBSIDIAN_FIGURINES_KNEW_CRAFTSMAN",
		options = [
			{code = 'lira_quest2_elven_doll_stall', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_doll_stall = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_LOOK_ONE_PRETTY_REACHES", 
		options = [
			{code = 'lira_quest2_elven_confusion', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_confusion = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_LOOKS_CONFUSION_FLICKERING_ACROSS", 
		options = [
			{code = 'lira_quest2_elven_ask', text = "LIRA_QUEST2_OPTION_EXCUSE_COMPANION_ASKED_QUESTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_elven_ask', text = "LIRA_QUEST2_OPTION_MUCH_DOLL", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_ask = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_ELVEN_VENDOR_COMPANION", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_ELVEN_VENDOR_DIRECT", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'lira_quest2_elven_vendor_ignores', text = "LIRA_QUEST2_OPTION_MEANING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_elven_vendor_ignores', text = "LIRA_QUEST2_OPTION_LITERALLY_SAW_HIDE_DOLL", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_vendor_ignores = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_ELVEN_VENDOR_SEEMS_IGNORE_QUESTIONS",
		options = [
			{code = 'lira_quest2_elven_herbs_stall', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_herbs_stall = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_HEY_KNOW_HEAR_LEAST",
		options = [
			{code = 'lira_quest2_elven_exile_reveal', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_exile_reveal = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_LOOKS_AROUND_DESPERATELY_SEARCHING",
		options = [
			{code = 'lira_quest2_elven_lira_reaction', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_lira_reaction = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_APOLOGIES_LEAVE_ABRUPTLY_MOMENT", 
		options = [
			{
				code = 'lira_quest2_elven_response', 
				text = "LIRA_QUEST2_OPTION_PLACE_BESIDE", reqs = [], 
				dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
				]
			},
			{
				code = 'lira_quest2_elven_response', 
				text = "LIRA_QUEST2_OPTION_BECAUSE_NEED_APPROVAL_HAPPY", 
				reqs = [], dialogue_argument = 2, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
				]
			},
		],
	},
	lira_quest2_elven_response = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_ELVEN_DEP_RESPONSE", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_ELVEN_FREE_RESPONSE", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'lira_quest2_elven_dancing_approach', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_dancing_approach = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_TWO_WALK_SILENCE_WHILE_LEAVING",
		options = [
			{code = 'lira_quest2_elven_dancing_invite', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_dancing_invite = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_WATCHES_PAIR_SPIN_PAST_WOMAN", 
		options = [
			{
				code = 'lira_quest2_elven_dancing', 
				text = "LIRA_QUEST2_OPTION_GRAB_HAND_PULL_CROWD",
				 reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
			{
				code = 'lira_quest2_elven_dancing', 
				text = "LIRA_QUEST2_OPTION_OFFER_HAND", 
				reqs = [], dialogue_argument = 2, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
		],
	},
	lira_quest2_elven_dancing = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_DANCING_DEP", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_DANCING_FREE", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 7, type = 'next_dialogue'},
		],
	},
	
	lira_quest2_brawler_incident = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_FAIR_REST", 
		options = [
			{code = 'lira_quest2_brawler_branch', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_branch = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_NEAR_ONE_TAVERNS_TWO_MEN", 
		options = [
			{code = 'lira_quest2_brawler_free_intro', text = "DIALOGUECONTINUE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_brawler_dep', text = "DIALOGUECONTINUE", reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_free_intro = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_BRAWL_1",
		options = [
			{code = 'lira_quest2_brawler_struggle', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_struggle = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		common_effects = [{code = 'decision', value = 'lira_handled_drunk'}],
		text = "LIRA_QUEST2_TRIES_SWING_LIRA_GRABS_ARM", 
		options = [
			{
				code = 'lira_quest2_brawler_mayor_recognition', 
				text = "LIRA_QUEST2_OPTION_SHES_SLAVE_GRATEFUL_LET_DEAL_INSTEAD", 
				reqs = [], dialogue_argument = 2, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
			{
				code = 'lira_quest2_brawler_mayor_recognition', 
				text = "LIRA_QUEST2_OPTION_SHES_SOMEONE_EASILY_BEAT_ASS_WANT", 
				reqs = [], dialogue_argument = 2, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
		],
	},
	lira_quest2_brawler_dep = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_BRAWL_2", 
		options = [
			{
				code = 'lira_quest2_brawler_free_intro', 
				text = "LIRA_QUEST2_OPTION_YEAH_DEAL", 
				reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]
			},
			{
				code = 'lira_quest2_brawler_mayor_recognition', 
				text = "LIRA_QUEST2_OPTION_NAH_STAY_HANDLE", 
				reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]
			},
		],
	},
	lira_quest2_brawler_mayor_recognition = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_BRAWLER_PLAYER_HANDLES", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_DRUNK_MAN_FUCK_LIRA_LOOKS", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST2_LIRA_BRAWL_3", reqs = []},
		],
		options = [
			{code = 'lira_quest2_brawler_apology', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_apology = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_DRUNK_MAN_MAYOR_REALIZE_SCRAMBLES", 
		options = [
			{code = 'lira_quest2_brawler_owner_scene', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_owner_scene = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_TAVERN_OWNER_EXHALES_LOUDLY_WIPING", reqs = []},
			{text = "LIRA_QUEST2_LIRA_BRAWL_4", reqs = [{type = "decision", value = "lira_handled_drunk", check = true}]},
		],
		options = [
			{
				code = 'lira_quest2_fair_arrival', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = "decision", value = "lira_handled_drunk", check = false}], 
				dialogue_argument = 8, type = 'next_dialogue'
			},
			{
				code = 'lira_quest2_brawler_reward', 
				text = "LIRA_QUEST2_OPTION_SLAVE_DOESNT_NEED_MONEY_PROVIDE_EVERYTHING", 
				reqs = [{type = "decision", value = "lira_handled_drunk", check = true},], 
				dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
				]
			},
			{
				code = 'lira_quest2_brawler_reward', 
				text = "LIRA_QUEST2_OPTION_EARNED_YOURS", 
				reqs = [{type = "decision", value = "lira_handled_drunk", check = true},], 
				dialogue_argument = 2, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
				]
			},
		],
	},
	lira_quest2_brawler_reward = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST2_LIRA_BRAWL_5", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST2_LIRA_BRAWL_6", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 8, type = 'next_dialogue'},
		],
	},
	
	lira_quest2_costume_reveal = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_FAIR_FINISH", 
		options = [
			{code = 'lira_quest2_costume_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_2 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_COSTUME_CONSISTING_HEADDRESS_CROWNED_LONG", 
		options = [
			{code = 'lira_quest2_costume_show', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_show = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_FEATHERS_SEEM_QUITE_NICE", 
		options = [
			{code = 'lira_quest2_costume_lira_react', text = "LIRA_QUEST2_OPTION_THINK_MIGHT_ABLE_HELP", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_costume_lira_react', text = "LIRA_QUEST2_OPTION_DON_WEAR_LIRA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_lira_react = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_HUH_WANT_WEAR_EYES",
		options = [
			{code = 'lira_quest2_costume_dep_speech1', text = "LIRA_QUEST2_OPTION_WORRY_SOMEONE_ELSES_OPINION_SHOULDNT_FOCUS", reqs = [], dialogue_argument = 1, type = 'next_dialogue', master_translate = true,
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
				]},
			{code = 'lira_quest2_costume_free_speech1', text = "LIRA_QUEST2_OPTION_SAY_DISLIKE_MEANING_YOUD_WEAR_OPINION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
				]},
		],
	},
	lira_quest2_costume_dep_speech1 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_OUTFIT_1_1",
		options = [
			{code = 'lira_quest2_costume_dep_speech2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_dep_speech2 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_OUTFIT_2_1", 
		options = [
			{code = 'lira_quest2_costume_purchase', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_free_speech1 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_OUTFIT_1_2", 
		options = [
			{code = 'lira_quest2_costume_free_speech2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_free_speech2 = {
		image = null, character = 'lira',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_OUTFIT_2_2", 
		options = [
			{code = 'lira_quest2_costume_purchase', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_purchase = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_TOSS_BAG_COINS_SMILING_VENDOR", 
		options = [
			{code = 'lira_quest2_costume_admire', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_admire = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_CATCHES_REFLECTION_NEARBY_LANTERN_PAUSES",
		options = [
			{code = 'lira_quest2_costume_compliment', text = "LIRA_QUEST2_OPTION_LOOK_INCREDIBLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_costume_compliment', text = "LIRA_QUEST2_OPTION_LIKE_MEANT_WEAR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_compliment = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_SMILE_WIDENS_WORDS_NOTICE_EYES",
		options = [
			{code = 'lira_quest2_costume_walk', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_walk = {
		image = null, character = 'lira',
		tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_WALKS_SLIGHTLY_FRONT_LETTING", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_epilogue_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_epilogue_start = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_WALK_BACK_MANSION_QUIET_HAND",
		options = [
			{code = 'lira_quest2_epilogue1', text = "LIRA_QUEST2_OPTION_COURSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_epilogue1', text = "LIRA_QUEST2_OPTION_AHEAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_epilogue1 = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_ONE_EVER_TAKEN_SUCH", 
		options = [
			{code = 'lira_quest2_epilogue2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_epilogue2 = {
		image = null, character = 'lira_tribal',
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = "LIRA_QUEST2_LIRA_THOUGHT_HAPPY_LIVING_TEMPLE",
		options = [
			{
				code = 'close', 
				text = "DIALOGUECLOSE", 
				reqs = [], dialogue_argument = 1,
				bonus_effects = [
					{code = 'complete_quest', value = 'lira_quest_2'}, 
#					{code = 'progress_quest', value = 'lira_quest_3', stage = 'start'}, 
					{code = 'add_timed_event', value = "lira_quest_3_intro", args = [{type = 'add_to_date', date = [3,3], hour = 1}]},
					{code = 'update_city'}
				]
			},
		],
	},
}
