extends Reference
var data = {
	lira_quest1_day_usual_step_outside_mansion = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_DAY_USUAL_STEP_OUTSIDE_MANSION", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest1_find_lira_front_garden_tends = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_FIND_LIRA_FRONT_GARDEN_TENDS", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_know_special_occasion_today', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_know_special_occasion_today = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_KNOW_SPECIAL_OCCASION_TODAY", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_think_perhaps_chance_visit', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_think_perhaps_chance_visit = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_THINK_PERHAPS_CHANCE_VISIT", reqs = []}],
		options = [
			{code = 'lira_quest1_nods_immediately_trying_hard_hide', text = "LIRA_QUEST1_OPTION_FINE_TAKE_STAY_CLOSE_BEHAVE_LIKE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_nods_immediately_trying_hard_hide', text = "LIRA_QUEST1_OPTION_SURE_THING_RIGHT_SATISFY_CURIOSITY_YOURS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_nods_immediately_trying_hard_hide = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_NODS_IMMEDIATELY_TRYING_HARD_HIDE", reqs = []}],
		options = [
			{code = 'lira_quest1_reach_central_square_fair_already', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_reach_central_square_fair_already = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_REACH_CENTRAL_SQUARE_FAIR_ALREADY", reqs = []}],
		options = [
			{code = 'lira_quest1_turn_food_stalls_area_approach', text = "LIRA_QUEST1_OPTION_FOOD_STALLS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_turn_food_stalls_area_approach', text = "LIRA_QUEST1_OPTION_ACCESSORIES_AREA", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest1_turn_food_stalls_area_approach', text = "LIRA_QUEST1_OPTION_SHOOTING_RANGE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
			{code = 'lira_quest1_turn_food_stalls_area_approach', text = "LIRA_QUEST1_OPTION_ELVEN_PART_FAIR", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],
	},
	lira_quest1_turn_food_stalls_area_approach = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TURN_FOOD_STALLS_AREA_APPROACH", reqs = []}],
		options = [
			{code = 'lira_quest1_point_sample_pieces_explain_simple', text = "LIRA_QUEST1_OPTION_SUGGEST_TRIES_FREE_SAMPLES", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_point_sample_pieces_explain_simple', text = "LIRA_QUEST1_OPTION_OFFER_BUY_FOOD", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_point_sample_pieces_explain_simple = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_POINT_SAMPLE_PIECES_EXPLAIN_SIMPLE", reqs = []}],
		options = [
			{code = 'lira_quest1_doesn_need_told_twice_eyes', text = "LIRA_QUEST1_OPTION_COURSE_LIKE_REWARD_GOOD_BEHAVING_SERVANTS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_doesn_need_told_twice_eyes', text = "LIRA_QUEST1_OPTION_SURE_THING_KNOW_WANT_TRY_PICK", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_doesn_need_told_twice_eyes = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_DOESN_NEED_TOLD_TWICE_EYES", reqs = []}],
		options = [
			{code = 'lira_quest1_brief_hesitation_nods_points_hairpin', text = "LIRA_QUEST1_OPTION_DID_WANT_HAIRPIN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_brief_hesitation_nods_points_hairpin', text = "LIRA_QUEST1_OPTION_SOMETHING_CAUGHT_EYE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_brief_hesitation_nods_points_hairpin = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_BRIEF_HESITATION_NODS_POINTS_HAIRPIN", reqs = []}],
		options = [
			{code = 'lira_quest1_walk_stall_take_place_small', text = "LIRA_QUEST1_OPTION_SURE_SPOIL_SLAVE_LITTLE_ESPECIALLY_SINCE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_walk_stall_take_place_small', text = "LIRA_QUEST1_OPTION_PROBLEM_ALLOWED_GOOD_THINGS_CONSIDER_GIFT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_walk_stall_take_place_small = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_WALK_STALL_TAKE_PLACE_SMALL", reqs = []}],
		options = [
			{code = 'lira_quest1_turn_point_leaf_shaped_pin', text = "LIRA_QUEST1_OPTION_PAY_HAIRPIN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_turn_point_leaf_shaped_pin', text = "LIRA_QUEST1_OPTION_STEAL_HAIRPIN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_turn_point_leaf_shaped_pin = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TURN_POINT_LEAF_SHAPED_PIN", reqs = []}],
		options = [
			{code = 'lira_quest1_smile_face_grows_little_warmer', text = "LIRA_QUEST1_OPTION_SUITS_PERFECTLY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_smile_face_grows_little_warmer', text = "LIRA_QUEST1_OPTION_COURSE_LIKE_SLAVES_PRETTY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_smile_face_grows_little_warmer = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_SMILE_FACE_GROWS_LITTLE_WARMER", reqs = []}],
		options = [
			{code = 'lira_quest1_make_way_vendor_cover_entrance', text = "LIRA_QUEST1_OPTION_JOIN_COMPETITION_YOURSELF", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_make_way_vendor_cover_entrance', text = "LIRA_QUEST1_OPTION_LIRA_JOIN_COMPETITION", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_make_way_vendor_cover_entrance = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_MAKE_WAY_VENDOR_COVER_ENTRANCE", reqs = []}],
		options = [
			{code = 'lira_quest1_grit_teeth_keep_going_arms', text = "LIRA_QUEST1_OPTION_KEEP_SHOOTING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_grit_teeth_keep_going_arms', text = "LIRA_QUEST1_OPTION_PUSH_TRAINED_MUSCLES_DRAW_FULL_STRING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_grit_teeth_keep_going_arms = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_GRIT_TEETH_KEEP_GOING_ARMS", reqs = []}],
		options = [
			{code = 'lira_quest1_vendor_forces_lips_wider_smile', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_vendor_forces_lips_wider_smile = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_VENDOR_FORCES_LIPS_WIDER_SMILE", reqs = []}],
		options = [
			{code = 'lira_quest1_hands_over_prize_bow_polished', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_hands_over_prize_bow_polished = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_HANDS_OVER_PRIZE_BOW_POLISHED", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_want_participate_seems_bit', text = "LIRA_QUEST1_OPTION_HEY_TRY_WIN_SOMETHING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_lira_want_participate_seems_bit', text = "LIRA_QUEST1_OPTION_INTERESTED_AHEAD_MAYBE_YOULL_ENJOY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_want_participate_seems_bit = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_WANT_PARTICIPATE_SEEMS_BIT", reqs = []}],
		options = [
			{code = 'lira_quest1_make_way_vendor_cover_entrance_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_make_way_vendor_cover_entrance_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_MAKE_WAY_VENDOR_COVER_ENTRANCE_2", reqs = []}],
		options = [
			{code = 'lira_quest1_hits_fifth_sixth_seventh_shots', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_hits_fifth_sixth_seventh_shots = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_HITS_FIFTH_SIXTH_SEVENTH_SHOTS", reqs = []}],
		options = [
			{code = 'lira_quest1_vendor_congratulations_winner_ghm_see', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_vendor_congratulations_winner_ghm_see = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_VENDOR_CONGRATULATIONS_WINNER_GHM_SEE", reqs = []}],
		options = [
			{code = 'lira_quest1_finally_rush_people_subsides_lira', text = "LIRA_QUEST1_OPTION_PROUD_DID_GREAT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_finally_rush_people_subsides_lira', text = "LIRA_QUEST1_OPTION_SURE_DID_PRIZE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_finally_rush_people_subsides_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_FINALLY_RUSH_PEOPLE_SUBSIDES_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_huh_did_vendor_finally', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_huh_did_vendor_finally = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_HUH_DID_VENDOR_FINALLY", reqs = []}],
		options = [
			{code = 'lira_quest1_pat_lira_shoulder_tell_ignore', text = "LIRA_QUEST1_OPTION_LOOKS_LIKE_SOMEONE_SORE_LOSER_FORGET", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_pat_lira_shoulder_tell_ignore', text = "LIRA_QUEST1_OPTION_MAYOR_ALIRON_LET_TELL_SOMETHING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_pat_lira_shoulder_tell_ignore = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_PAT_LIRA_SHOULDER_TELL_IGNORE", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_see_knew_didn_break', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_see_knew_didn_break = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_SEE_KNEW_DIDN_BREAK", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_haven_seen_angry_kinda', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_haven_seen_angry_kinda = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_HAVEN_SEEN_ANGRY_KINDA", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_obsidian_figurines_knew_craftsman', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_obsidian_figurines_knew_craftsman = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_OBSIDIAN_FIGURINES_KNEW_CRAFTSMAN", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_look_one_pretty_reaches', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_look_one_pretty_reaches = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_LOOK_ONE_PRETTY_REACHES", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_looks_confusion_flickering_across', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_looks_confusion_flickering_across = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_LOOKS_CONFUSION_FLICKERING_ACROSS", reqs = []}],
		options = [
			{code = 'lira_quest1_vendor_gives_side_eye_vendor', text = "LIRA_QUEST1_OPTION_EXCUSE_COMPANION_ASKED_QUESTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_vendor_gives_side_eye_vendor', text = "LIRA_QUEST1_OPTION_MUCH_DOLL", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_vendor_gives_side_eye_vendor = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_VENDOR_GIVES_SIDE_EYE_VENDOR", reqs = []}],
		options = [
			{code = 'lira_quest1_elven_vendor_seems_ignore_questions', text = "LIRA_QUEST1_OPTION_MEANING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_elven_vendor_seems_ignore_questions', text = "LIRA_QUEST1_OPTION_LITERALLY_SAW_HIDE_DOLL", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_elven_vendor_seems_ignore_questions = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_ELVEN_VENDOR_SEEMS_IGNORE_QUESTIONS", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_hey_know_hear_least', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_hey_know_hear_least = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_HEY_KNOW_HEAR_LEAST", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_looks_around_desperately_searching', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_looks_around_desperately_searching = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_LOOKS_AROUND_DESPERATELY_SEARCHING", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_apologies_leave_abruptly_moment', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_apologies_leave_abruptly_moment = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_APOLOGIES_LEAVE_ABRUPTLY_MOMENT", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_looks_moment_offers_small', text = "LIRA_QUEST1_OPTION_PLACE_BESIDE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_lira_looks_moment_offers_small', text = "LIRA_QUEST1_OPTION_BECAUSE_NEED_APPROVAL_HAPPY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_looks_moment_offers_small = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_LOOKS_MOMENT_OFFERS_SMALL", reqs = []}],
		options = [
			{code = 'lira_quest1_two_walk_silence_while_leaving', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_two_walk_silence_while_leaving = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TWO_WALK_SILENCE_WHILE_LEAVING", reqs = []}],
		options = [
			{code = 'lira_quest1_watches_pair_spin_past_woman', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_watches_pair_spin_past_woman = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_WATCHES_PAIR_SPIN_PAST_WOMAN", reqs = []}],
		options = [
			{code = 'lira_quest1_tell_try_herself_take_wrist', text = "LIRA_QUEST1_OPTION_GRAB_HAND_PULL_CROWD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_tell_try_herself_take_wrist', text = "LIRA_QUEST1_OPTION_OFFER_HAND", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_tell_try_herself_take_wrist = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TELL_TRY_HERSELF_TAKE_WRIST", reqs = []}],
		options = [
			{code = 'lira_quest1_couple_dances_two_step_aside', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_couple_dances_two_step_aside = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_COUPLE_DANCES_TWO_STEP_ASIDE", reqs = []}],
		options = [
			{code = 'lira_quest1_near_one_taverns_two_men', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_near_one_taverns_two_men = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_NEAR_ONE_TAVERNS_TWO_MEN", reqs = []}],
		options = [
			{code = 'lira_quest1_rushes_toward_brawlers_lira_hey', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_rushes_toward_brawlers_lira_hey = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_RUSHES_TOWARD_BRAWLERS_LIRA_HEY", reqs = []}],
		options = [
			{code = 'lira_quest1_tries_swing_lira_grabs_arm', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_tries_swing_lira_grabs_arm = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TRIES_SWING_LIRA_GRABS_ARM", reqs = []}],
		options = [
			{code = 'lira_quest1_drunk_man_fuck_lira_looks', text = "LIRA_QUEST1_OPTION_SHES_SLAVE_GRATEFUL_LET_DEAL_INSTEAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_drunk_man_fuck_lira_looks', text = "LIRA_QUEST1_OPTION_SHES_SOMEONE_EASILY_BEAT_ASS_WANT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_drunk_man_fuck_lira_looks = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_DRUNK_MAN_FUCK_LIRA_LOOKS", reqs = []}],
		options = [
			{code = 'lira_quest1_step_yourself_pushing_drunk_back', text = "LIRA_QUEST1_OPTION_YEAH_DEAL", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_step_yourself_pushing_drunk_back', text = "LIRA_QUEST1_OPTION_NAH_STAY_HANDLE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_step_yourself_pushing_drunk_back = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_STEP_YOURSELF_PUSHING_DRUNK_BACK", reqs = []}],
		options = [
			{code = 'lira_quest1_drunk_man_mayor_realize_scrambles', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_drunk_man_mayor_realize_scrambles = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_DRUNK_MAN_MAYOR_REALIZE_SCRAMBLES", reqs = []}],
		options = [
			{code = 'lira_quest1_tavern_owner_exhales_loudly_wiping', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_tavern_owner_exhales_loudly_wiping = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TAVERN_OWNER_EXHALES_LOUDLY_WIPING", reqs = []}],
		options = [
			{code = 'lira_quest1_nods_immediately_presents_pouch_lira', text = "LIRA_QUEST1_OPTION_SLAVE_DOESNT_NEED_MONEY_PROVIDE_EVERYTHING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_nods_immediately_presents_pouch_lira', text = "LIRA_QUEST1_OPTION_EARNED_YOURS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_nods_immediately_presents_pouch_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_NODS_IMMEDIATELY_PRESENTS_POUCH_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest1_costume_consisting_headdress_crowned_long', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_costume_consisting_headdress_crowned_long = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_COSTUME_CONSISTING_HEADDRESS_CROWNED_LONG", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_feathers_seem_quite_nice', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_feathers_seem_quite_nice = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_FEATHERS_SEEM_QUITE_NICE", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_huh_want_wear_eyes', text = "LIRA_QUEST1_OPTION_THINK_MIGHT_ABLE_HELP", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_lira_huh_want_wear_eyes', text = "LIRA_QUEST1_OPTION_DON_WEAR_LIRA", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_huh_want_wear_eyes = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_HUH_WANT_WEAR_EYES", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_blinks_lira_proud_wearing', text = "LIRA_QUEST1_OPTION_WORRY_SOMEONE_ELSES_OPINION_SHOULDNT_FOCUS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_lira_blinks_lira_proud_wearing', text = "LIRA_QUEST1_OPTION_SAY_DISLIKE_MEANING_YOUD_WEAR_OPINION", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_blinks_lira_proud_wearing = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_BLINKS_LIRA_PROUD_WEARING", reqs = []}],
		options = [
			{code = 'lira_quest1_looks_current_clothing_pulls_down', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_looks_current_clothing_pulls_down = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LOOKS_CURRENT_CLOTHING_PULLS_DOWN", reqs = []}],
		options = [
			{code = 'lira_quest1_hand_reaches_brush_feathers_lira', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_hand_reaches_brush_feathers_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_HAND_REACHES_BRUSH_FEATHERS_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest1_toss_bag_coins_smiling_vendor', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_toss_bag_coins_smiling_vendor = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_TOSS_BAG_COINS_SMILING_VENDOR", reqs = []}],
		options = [
			{code = 'lira_quest1_catches_reflection_nearby_lantern_pauses', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_catches_reflection_nearby_lantern_pauses = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_CATCHES_REFLECTION_NEARBY_LANTERN_PAUSES", reqs = []}],
		options = [
			{code = 'lira_quest1_smile_widens_words_notice_eyes', text = "LIRA_QUEST1_OPTION_LOOK_INCREDIBLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_smile_widens_words_notice_eyes', text = "LIRA_QUEST1_OPTION_LIKE_MEANT_WEAR", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_smile_widens_words_notice_eyes = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_SMILE_WIDENS_WORDS_NOTICE_EYES", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_walks_slightly_front_letting', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_walks_slightly_front_letting = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_WALKS_SLIGHTLY_FRONT_LETTING", reqs = []}],
		options = [
			{code = 'lira_quest1_walk_back_mansion_quiet_hand', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_walk_back_mansion_quiet_hand = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_WALK_BACK_MANSION_QUIET_HAND", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_one_ever_taken_such', text = "LIRA_QUEST1_OPTION_COURSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest1_lira_one_ever_taken_such', text = "LIRA_QUEST1_OPTION_AHEAD", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_one_ever_taken_such = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_ONE_EVER_TAKEN_SUCH", reqs = []}],
		options = [
			{code = 'lira_quest1_lira_thought_happy_living_temple', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest1_lira_thought_happy_living_temple = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST1_LIRA_THOUGHT_HAPPY_LIVING_TEMPLE", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
}
