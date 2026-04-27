extends Reference
var data = {
	lira_quest2_day_usual_step_outside_mansion = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_DAY_USUAL_STEP_OUTSIDE_MANSION", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_find_lira_front_garden_tends = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FIND_LIRA_FRONT_GARDEN_TENDS", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_know_special_occasion_today', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_know_special_occasion_today = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_KNOW_SPECIAL_OCCASION_TODAY", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_think_perhaps_chance_visit', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_think_perhaps_chance_visit = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_THINK_PERHAPS_CHANCE_VISIT", reqs = []}],
		options = [
			{code = 'lira_quest2_agree_dep', text = "LIRA_QUEST2_OPTION_FINE_TAKE_STAY_CLOSE_BEHAVE_LIKE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = 'lira_quest2_agree_free', text = "LIRA_QUEST2_OPTION_SURE_THING_RIGHT_SATISFY_CURIOSITY_YOURS", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest2_agree_dep = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_AGREE_DEP", reqs = []}],
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_agree_free = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_AGREE_FREE", reqs = []}],
		options = [
			{code = 'lira_quest2_fair_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_fair_arrival = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FAIR_ARRIVAL", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_hub = {
		variations = [
			{
				reqs = [{type = 'local_counter', name = 'total_visits', operant = 'gte', value = 4, check = true}],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_FAIR_WINDING_DOWN", reqs = []}],
				options = [
					{code = 'lira_quest2_costume_reveal', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				],
			},
			{
				reqs = [
					{type = 'local_counter', name = 'total_visits', operant = 'gte', value = 2, check = true},
					{type = 'local_counter', name = 'brawler_done', operant = 'lt', value = 1, check = true},
				],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_BENCH_BRAWLER_INTRO", reqs = []}],
				options = [
					{code = 'lira_quest2_brawler_incident', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				],
			},
			{
				reqs = [],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_HUB_TEXT", reqs = []}],
				options = [
					{code = 'lira_quest2_food_intro', text = "LIRA_QUEST2_OPTION_FOOD_STALLS", reqs = [{type = 'local_counter', name = 'food_visited', operant = 'lt', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
					{code = 'lira_quest2_acc_intro', text = "LIRA_QUEST2_OPTION_ACCESSORIES_AREA", reqs = [{type = 'local_counter', name = 'acc_visited', operant = 'lt', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
					{code = 'lira_quest2_shooting_intro', text = "LIRA_QUEST2_OPTION_SHOOTING_RANGE", reqs = [{type = 'local_counter', name = 'shooting_visited', operant = 'lt', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
					{code = 'lira_quest2_elven_intro', text = "LIRA_QUEST2_OPTION_ELVEN_PART_FAIR", reqs = [{type = 'local_counter', name = 'elven_visited', operant = 'lt', value = 1, check = true}], dialogue_argument = 1, type = 'next_dialogue'},
				],
			},
		],
	},
	lira_quest2_food_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TURN_FOOD_STALLS_AREA_APPROACH", reqs = []}],
		options = [
			{code = 'lira_quest2_food_free_result', text = "LIRA_QUEST2_OPTION_SUGGEST_TRIES_FREE_SAMPLES", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_food_buy_offer', text = "LIRA_QUEST2_OPTION_OFFER_BUY_FOOD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_food_free_result = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'food_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_FOOD_FREE_RESULT", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_food_buy_offer = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FOOD_BUY_OFFER", reqs = []}],
		options = [
			{code = 'lira_quest2_food_buy_result', text = "LIRA_QUEST2_OPTION_COURSE_LIKE_REWARD_GOOD_BEHAVING_SERVANTS", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = 'lira_quest2_food_buy_result', text = "LIRA_QUEST2_OPTION_SURE_THING_KNOW_WANT_TRY_PICK", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest2_food_buy_result = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'money_change', operant = '-', value = 200},
			{code = 'dialogue_counter', name = 'food_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_FOOD_BUY_RESULT", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ACC_INTRO", reqs = []}],
		options = [
			{code = 'lira_quest2_acc_lira_reaction', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_lira_reaction = {
		variations = [
			{
				reqs = [{type = 'local_counter', name = 'df_balance', operant = 'gte', value = 0, check = true}],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_ACC_DEP_FLUSTERED", reqs = []}],
				options = [
					{code = 'lira_quest2_acc_dep_confirm', text = "LIRA_QUEST2_OPTION_DID_WANT_HAIRPIN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
					{code = 'lira_quest2_acc_dep_confirm', text = "LIRA_QUEST2_OPTION_SOMETHING_CAUGHT_EYE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				],
			},
			{
				reqs = [],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_ACC_FREE_APPROACH", reqs = []}],
				options = [
					{code = 'lira_quest2_acc_stall_queue', text = "LIRA_QUEST2_OPTION_SURE_SPOIL_SLAVE_LITTLE_ESPECIALLY_SINCE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
						bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
					{code = 'lira_quest2_acc_stall_queue', text = "LIRA_QUEST2_OPTION_PROBLEM_ALLOWED_GOOD_THINGS_CONSIDER_GIFT", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
						bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
				],
			},
		],
	},
	lira_quest2_acc_dep_confirm = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ACC_DEP_CONFIRM", reqs = []}],
		options = [
			{code = 'lira_quest2_acc_stall_queue', text = "LIRA_QUEST2_OPTION_SURE_SPOIL_SLAVE_LITTLE_ESPECIALLY_SINCE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = 'lira_quest2_acc_stall_queue', text = "LIRA_QUEST2_OPTION_PROBLEM_ALLOWED_GOOD_THINGS_CONSIDER_GIFT", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest2_acc_stall_queue = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_WALK_STALL_TAKE_PLACE_SMALL", reqs = []}],
		options = [
			{code = 'lira_quest2_acc_pay', text = "LIRA_QUEST2_OPTION_PAY_HAIRPIN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_acc_steal', text = "LIRA_QUEST2_OPTION_STEAL_HAIRPIN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_pay = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'money_change', operant = '-', value = 300},
		],
		text = [{text = "LIRA_QUEST2_ACC_PAY_RESULT", reqs = []}],
		options = [
			{code = 'lira_quest2_acc_hairpin_present', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_steal = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ACC_STEAL_RESULT", reqs = []}],
		options = [
			{code = 'lira_quest2_acc_hairpin_present', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_acc_hairpin_present = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ACC_HAIRPIN_PRESENT", reqs = []}],
		options = [
			{code = 'lira_quest2_acc_hairpin_conclusion', text = "LIRA_QUEST2_OPTION_SUITS_PERFECTLY", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
			{code = 'lira_quest2_acc_hairpin_conclusion', text = "LIRA_QUEST2_OPTION_COURSE_LIKE_SLAVES_PRETTY", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
		],
	},
	lira_quest2_acc_hairpin_conclusion = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'acc_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_ACC_HAIRPIN_CONCLUSION", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_shooting_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SHOOTING_INTRO", reqs = []}],
		options = [
			{code = 'lira_quest2_player_setup', text = "LIRA_QUEST2_OPTION_JOIN_COMPETITION_YOURSELF", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_shooting_lira_intro', text = "LIRA_QUEST2_OPTION_LIRA_JOIN_COMPETITION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_setup = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MAKE_WAY_VENDOR_COVER_ENTRANCE", reqs = []}],
		options = [
			{code = 'lira_quest2_player_fail', text = "LIRA_QUEST2_OPTION_KEEP_SHOOTING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_player_win_setup', text = "LIRA_QUEST2_OPTION_PUSH_TRAINED_MUSCLES_DRAW_FULL_STRING",
				reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 5}]}],
				dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_fail = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'shooting_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_PLAYER_FAIL", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_win_setup = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_PLAYER_WIN_SETUP", reqs = []}],
		options = [
			{code = 'lira_quest2_player_win_vendor', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_win_vendor = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_VENDOR_FORCES_LIPS_WIDER_SMILE", reqs = []}],
		options = [
			{code = 'lira_quest2_player_win_prize', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_player_win_prize = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'shooting_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_PLAYER_WIN_PRIZE", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_shooting_lira_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SHOOTING_LIRA_INTRO", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_dep', text = "LIRA_QUEST2_OPTION_HEY_TRY_WIN_SOMETHING", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = 'lira_quest2_lira_shooting_free', text = "LIRA_QUEST2_OPTION_INTERESTED_AHEAD_MAYBE_YOULL_ENJOY", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest2_lira_shooting_dep = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_SHOOTING_DEP", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_setup', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_free = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_SHOOTING_FREE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_setup', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_setup = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MAKE_WAY_VENDOR_COVER_ENTRANCE_2", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_progress', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_progress = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HITS_FIFTH_SIXTH_SEVENTH_SHOTS", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_wins', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_wins = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_VENDOR_CONGRATULATIONS_WINNER_GHM_SEE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_booth', text = "LIRA_QUEST2_OPTION_PROUD_DID_GREAT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_shooting_booth', text = "LIRA_QUEST2_OPTION_SURE_DID_PRIZE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_booth = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FINALLY_RUSH_PEOPLE_SUBSIDES_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_vendor_insult', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_vendor_insult = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_HUH_DID_VENDOR_FINALLY", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_sore1', text = "LIRA_QUEST2_OPTION_LOOKS_LIKE_SOMEONE_SORE_LOSER_FORGET", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_shooting_mayor1', text = "LIRA_QUEST2_OPTION_MAYOR_ALIRON_LET_TELL_SOMETHING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_sore1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_PAT_LIRA_SHOULDER_TELL_IGNORE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_sore2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_sore2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'shooting_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_LIRA_SHOOTING_SORE_REFLECT", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_mayor1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_SHOOTING_MAYOR_SPEECH", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_shooting_mayor2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_shooting_mayor2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'shooting_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_LIRA_SHOOTING_MAYOR_AFTERMATH", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELVEN_INTRO", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_figurines', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_figurines = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_OBSIDIAN_FIGURINES_KNEW_CRAFTSMAN", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_doll_stall', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_doll_stall = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_LOOK_ONE_PRETTY_REACHES", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_confusion', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_confusion = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_LOOKS_CONFUSION_FLICKERING_ACROSS", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_ask_companion', text = "LIRA_QUEST2_OPTION_EXCUSE_COMPANION_ASKED_QUESTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_elven_ask_direct', text = "LIRA_QUEST2_OPTION_MUCH_DOLL", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_ask_companion = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELVEN_VENDOR_COMPANION", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_vendor_ignores', text = "LIRA_QUEST2_OPTION_MEANING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_elven_vendor_ignores', text = "LIRA_QUEST2_OPTION_LITERALLY_SAW_HIDE_DOLL", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_ask_direct = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELVEN_VENDOR_DIRECT", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_vendor_ignores', text = "LIRA_QUEST2_OPTION_MEANING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_elven_vendor_ignores', text = "LIRA_QUEST2_OPTION_LITERALLY_SAW_HIDE_DOLL", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_vendor_ignores = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELVEN_VENDOR_SEEMS_IGNORE_QUESTIONS", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_herbs_stall', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_herbs_stall = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_HEY_KNOW_HEAR_LEAST", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_exile_reveal', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_exile_reveal = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_LOOKS_AROUND_DESPERATELY_SEARCHING", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_lira_reaction', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_lira_reaction = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_APOLOGIES_LEAVE_ABRUPTLY_MOMENT", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dep_response', text = "LIRA_QUEST2_OPTION_PLACE_BESIDE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
					{code = 'dialogue_counter', name = 'df_balance', op = '+'},
				]},
			{code = 'lira_quest2_elven_free_response', text = "LIRA_QUEST2_OPTION_BECAUSE_NEED_APPROVAL_HAPPY", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
					{code = 'dialogue_counter', name = 'df_balance', op = '-'},
				]},
		],
	},
	lira_quest2_elven_dep_response = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELVEN_DEP_RESPONSE", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dancing_approach', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_free_response = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELVEN_FREE_RESPONSE", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dancing_approach', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_dancing_approach = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TWO_WALK_SILENCE_WHILE_LEAVING", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dancing_invite', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_dancing_invite = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_WATCHES_PAIR_SPIN_PAST_WOMAN", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dancing_dep', text = "LIRA_QUEST2_OPTION_GRAB_HAND_PULL_CROWD", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = 'lira_quest2_elven_dancing_free', text = "LIRA_QUEST2_OPTION_OFFER_HAND", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest2_elven_dancing_dep = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_DANCING_DEP", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dancing_end', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_dancing_free = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_DANCING_FREE", reqs = []}],
		options = [
			{code = 'lira_quest2_elven_dancing_end', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_elven_dancing_end = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'elven_visited', op = '+'},
			{code = 'dialogue_counter', name = 'total_visits', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_COUPLE_DANCES_TWO_STEP_ASIDE", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_incident = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_NEAR_ONE_TAVERNS_TWO_MEN", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_branch', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_branch = {
		variations = [
			{
				reqs = [{type = 'local_counter', name = 'df_balance', operant = 'lt', value = 0, check = true}],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_RUSHES_TOWARD_BRAWLERS_LIRA_HEY", reqs = []}],
				options = [
					{code = 'lira_quest2_brawler_struggle', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				],
			},
			{
				reqs = [],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_BRAWLER_DEP_ENTRY", reqs = []}],
				options = [
					{code = 'lira_quest2_brawler_free_intro', text = "LIRA_QUEST2_OPTION_YEAH_DEAL", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
						bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
					{code = 'lira_quest2_brawler_dep_player_handles', text = "LIRA_QUEST2_OPTION_NAH_STAY_HANDLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
						bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
				],
			},
		],
	},
	lira_quest2_brawler_free_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_RUSHES_TOWARD_BRAWLERS_LIRA_HEY", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_struggle', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_struggle = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'lira_handled_drunk', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_TRIES_SWING_LIRA_GRABS_ARM", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_free_aftermath', text = "LIRA_QUEST2_OPTION_SHES_SLAVE_GRATEFUL_LET_DEAL_INSTEAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '+'}]},
			{code = 'lira_quest2_brawler_free_aftermath', text = "LIRA_QUEST2_OPTION_SHES_SOMEONE_EASILY_BEAT_ASS_WANT", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'df_balance', op = '-'}]},
		],
	},
	lira_quest2_brawler_free_aftermath = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BRAWLER_FREE_AFTERMATH", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_mayor_recognition', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_dep_player_handles = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BRAWLER_PLAYER_HANDLES", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_mayor_recognition', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_mayor_recognition = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_DRUNK_MAN_MAYOR_REALIZE_SCRAMBLES", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_owner_thanks', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_owner_thanks = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [
			{code = 'dialogue_counter', name = 'brawler_done', op = '+'},
		],
		text = [{text = "LIRA_QUEST2_BRAWLER_OWNER_THANKS", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_owner_scene', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_owner_scene = {
		variations = [
			{
				reqs = [{type = 'local_counter', name = 'lira_handled_drunk', operant = 'gte', value = 1, check = true}],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_BRAWLER_OWNER_REWARD", reqs = []}],
				options = [
					{code = 'lira_quest2_brawler_reward_dep', text = "LIRA_QUEST2_OPTION_SLAVE_DOESNT_NEED_MONEY_PROVIDE_EVERYTHING", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
						bonus_effects = [
							{code = 'dialogue_counter', name = 'df_balance', op = '+'},
							{code = 'dialogue_counter', name = 'df_balance', op = '+'},
							{code = 'dialogue_counter', name = 'df_balance', op = '+'},
						]},
					{code = 'lira_quest2_brawler_reward_free', text = "LIRA_QUEST2_OPTION_EARNED_YOURS", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
						bonus_effects = [
							{code = 'dialogue_counter', name = 'df_balance', op = '-'},
							{code = 'dialogue_counter', name = 'df_balance', op = '-'},
							{code = 'dialogue_counter', name = 'df_balance', op = '-'},
						]},
				],
			},
			{
				reqs = [],
				tags = ['dialogue_scene', 'master_translate'],
				text = [{text = "LIRA_QUEST2_BRAWLER_RETURN_TEXT", reqs = []}],
				options = [
					{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				],
			},
		],
	},
	lira_quest2_brawler_reward_dep = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BRAWLER_REWARD_DEP", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_return', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_reward_free = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BRAWLER_REWARD_FREE", reqs = []}],
		options = [
			{code = 'lira_quest2_brawler_return', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_brawler_return = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BRAWLER_RETURN_TEXT", reqs = []}],
		options = [
			{code = 'lira_quest2_hub', text = "LIRA_QUEST2_OPTION_RETURN_TO_FAIR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_reveal = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_COSTUME_CONSISTING_HEADDRESS_CROWNED_LONG", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_show', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_show = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_FEATHERS_SEEM_QUITE_NICE", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_lira_react', text = "LIRA_QUEST2_OPTION_THINK_MIGHT_ABLE_HELP", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_costume_lira_react', text = "LIRA_QUEST2_OPTION_DON_WEAR_LIRA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_lira_react = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_HUH_WANT_WEAR_EYES", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_dep_speech1', text = "LIRA_QUEST2_OPTION_WORRY_SOMEONE_ELSES_OPINION_SHOULDNT_FOCUS", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
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
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_BLINKS_LIRA_PROUD_WEARING", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_dep_speech2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_dep_speech2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_COSTUME_DEP_CONCLUSION", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_purchase', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_free_speech1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_COSTUME_FREE_REFLECTION", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_free_speech2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_free_speech2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HAND_REACHES_BRUSH_FEATHERS_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_purchase', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_purchase = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TOSS_BAG_COINS_SMILING_VENDOR", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_admire', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_admire = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_CATCHES_REFLECTION_NEARBY_LANTERN_PAUSES", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_compliment', text = "LIRA_QUEST2_OPTION_LOOK_INCREDIBLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_costume_compliment', text = "LIRA_QUEST2_OPTION_LIKE_MEANT_WEAR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_compliment = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SMILE_WIDENS_WORDS_NOTICE_EYES", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_walk', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_walk = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_WALKS_SLIGHTLY_FRONT_LETTING", reqs = []}],
		options = [
			{code = 'lira_quest2_costume_epilogue_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_costume_epilogue_start = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_WALK_BACK_MANSION_QUIET_HAND", reqs = []}],
		options = [
			{code = 'lira_quest2_epilogue1', text = "LIRA_QUEST2_OPTION_COURSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_epilogue1', text = "LIRA_QUEST2_OPTION_AHEAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_epilogue1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_ONE_EVER_TAKEN_SUCH", reqs = []}],
		options = [
			{code = 'lira_quest2_epilogue2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_epilogue2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_THOUGHT_HAPPY_LIVING_TEMPLE", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
				bonus_effects = [{code = 'complete_quest', value = 'lira_quest_2'}]},
		],
	},
}
