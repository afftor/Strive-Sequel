extends Reference
var data = {
	lira_quest2_couple_days_passed_since_fair = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_COUPLE_DAYS_PASSED_SINCE_FAIR", reqs = []}],
		options = [
			{code = 'lira_quest2_find_corner_kitchen_resting_helping', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_find_corner_kitchen_resting_helping = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FIND_CORNER_KITCHEN_RESTING_HELPING", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_noticeable_chuckles_softly_looking', text = "LIRA_QUEST2_OPTION_BEEN_DOING_LATELY_SEEMS_SOMETHING_MIND", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_noticeable_chuckles_softly_looking', text = "LIRA_QUEST2_OPTION_YOUVE_SEEMED_DISTRACTED_LATELY_WHATS_TROUBLING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_noticeable_chuckles_softly_looking = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_NOTICEABLE_CHUCKLES_SOFTLY_LOOKING", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_sorry_nothing_serious_wondering', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_sorry_nothing_serious_wondering = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_SORRY_NOTHING_SERIOUS_WONDERING", reqs = []}],
		options = [
			{code = 'lira_quest2_folds_hands_lap_looking_down', text = "LIRA_QUEST2_OPTION_PEOPLE_RATHER_CRUEL_SOMETIMES", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_folds_hands_lap_looking_down', text = "LIRA_QUEST2_OPTION_DIDN_DESERVE_SUCH_TREATMENT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_folds_hands_lap_looking_down = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FOLDS_HANDS_LAP_LOOKING_DOWN", reqs = []}],
		options = [
			{code = 'lira_quest2_shakes_head_lightly_dismissing_own', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_shakes_head_lightly_dismissing_own = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SHAKES_HEAD_LIGHTLY_DISMISSING_OWN", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_agree_theres_point_dwelling', text = "LIRA_QUEST2_OPTION_THATS_RIGHT_WAY_LOOK_PRESENT_MATTERS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_agree_theres_point_dwelling', text = "LIRA_QUEST2_OPTION_LIFE_UNPREDICTABLE_MIGHT_FIND_ANSWERS_LEAST", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_agree_theres_point_dwelling', text = "LIRA_QUEST2_OPTION_TRY_LOOK_CHANCE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_agree_theres_point_dwelling = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_AGREE_THERES_POINT_DWELLING", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_journey_quite_familiar_waste_much = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_JOURNEY_QUITE_FAMILIAR_WASTE_MUCH", reqs = []}],
		options = [
			{code = 'lira_quest2_inside_temple_air_feels_still', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_inside_temple_air_feels_still = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_INSIDE_TEMPLE_AIR_FEELS_STILL", reqs = []}],
		options = [
			{code = 'lira_quest2_headmistress_grimaces_question_headmistress_tsk', text = "LIRA_QUEST2_OPTION_THOUGHT_TEMPLE_WELCOME_SOMEONE_CONTACT_GODDESS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_headmistress_grimaces_question_headmistress_tsk', text = "LIRA_QUEST2_OPTION_GOING_ASK_LIRA_DOING_BASICALLY_RAISED", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest2_headmistress_grimaces_question_headmistress_tsk', text = "LIRA_QUEST2_OPTION_STRAIGHT_BUSINESS_WANT_KNOW_LIRA_ORIGIN", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},
	lira_quest2_headmistress_grimaces_question_headmistress_tsk = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HEADMISTRESS_GRIMACES_QUESTION_HEADMISTRESS_TSK", reqs = []}],
		options = [
			{code = 'lira_quest2_headmistress_obvious_child_born_within', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_headmistress_obvious_child_born_within = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HEADMISTRESS_OBVIOUS_CHILD_BORN_WITHIN", reqs = []}],
		options = [
			{code = 'lira_quest2_headmistress_child_taken_care_raised', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_headmistress_child_taken_care_raised = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HEADMISTRESS_CHILD_TAKEN_CARE_RAISED", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_find_lira_garden_half_finished = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FIND_LIRA_GARDEN_HALF_FINISHED", reqs = []}],
		options = [
			{code = 'lira_quest2_recount_everything_headmistress_told_lira', text = "LIRA_QUEST2_OPTION_TELL_LEARNED", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_recount_everything_headmistress_told_lira', text = "LIRA_QUEST2_OPTION_COME_EXPLAIN_WAY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_recount_everything_headmistress_told_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_RECOUNT_EVERYTHING_HEADMISTRESS_TOLD_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest2_smirks_suddenly_lira_though_guess', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_smirks_suddenly_lira_though_guess = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SMIRKS_SUDDENLY_LIRA_THOUGH_GUESS", reqs = []}],
		options = [
			{code = 'lira_quest2_answer_question_directly_instead_turn', text = "LIRA_QUEST2_OPTION_CAME_CHECK_NEXT_CLUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_answer_question_directly_instead_turn', text = "LIRA_QUEST2_OPTION_LET_START_LOCAL_SLAVE_TRADER", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_answer_question_directly_instead_turn = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ANSWER_QUESTION_DIRECTLY_INSTEAD_TURN", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_familiar_noise_marketplace_greets_usual = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FAMILIAR_NOISE_MARKETPLACE_GREETS_USUAL", reqs = []}],
		options = [
			{code = 'lira_quest2_trader_raises_eyebrows_explain_request', text = "LIRA_QUEST2_OPTION_TODAY_INQUIRE_DEAL_MADE_PAST", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_trader_raises_eyebrows_explain_request', text = "LIRA_QUEST2_OPTION_REMEMBER_TRIBAL_ELVEN_CHILD_SOLD_OTHER", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_trader_raises_eyebrows_explain_request = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TRADER_RAISES_EYEBROWS_EXPLAIN_REQUEST", reqs = []}],
		options = [
			{code = 'lira_quest2_trader_huh_look_correct_did', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_trader_huh_look_correct_did = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TRADER_HUH_LOOK_CORRECT_DID", reqs = []}],
		options = [
			{code = 'lira_quest2_shrugs_trader_gods_know_kid', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_shrugs_trader_gods_know_kid = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SHRUGS_TRADER_GODS_KNOW_KID", reqs = []}],
		options = [
			{code = 'lira_quest2_trader_hey_hey_said_didn', text = "LIRA_QUEST2_OPTION_DIDN_TRY_CURE_KID_MEDICINE_AREN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_trader_hey_hey_said_didn', text = "LIRA_QUEST2_OPTION_LIVED_LONG_ENOUGH_COME_ASK_QUESTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest2_trader_hey_hey_said_didn', text = "LIRA_QUEST2_OPTION_DID_KID", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},
	lira_quest2_trader_hey_hey_said_didn = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TRADER_HEY_HEY_SAID_DIDN", reqs = []}],
		options = [
			{code = 'lira_quest2_trader_bit_persuasion_bought_whole', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_trader_bit_persuasion_bought_whole = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TRADER_BIT_PERSUASION_BOUGHT_WHOLE", reqs = []}],
		options = [
			{code = 'lira_quest2_closes_ledger_thud_trader_thats', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_closes_ledger_thud_trader_thats = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_CLOSES_LEDGER_THUD_TRADER_THATS", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_feels_weird_seeing_those', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_feels_weird_seeing_those = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_FEELS_WEIRD_SEEING_THOSE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_guess_right_think_back', text = "LIRA_QUEST2_OPTION_AREN_WRONG_FAIR_WORSE_WITHOUT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_guess_right_think_back', text = "LIRA_QUEST2_OPTION_THATS_WORLD_WORKS_STRONG_RISE_WEAK", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_guess_right_think_back = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_GUESS_RIGHT_THINK_BACK", reqs = []}],
		options = [
			{code = 'lira_quest2_inspired_words_lira_flashes_smile', text = "LIRA_QUEST2_OPTION_COURSE_WANT_BOTTOM_STORY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_inspired_words_lira_flashes_smile', text = "LIRA_QUEST2_OPTION_DOESNT_MATTER_EASY_WANT_SOMETHING_DONE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_inspired_words_lira_flashes_smile = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_INSPIRED_WORDS_LIRA_FLASHES_SMILE", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_following_lead_soon_arrive_empires = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FOLLOWING_LEAD_SOON_ARRIVE_EMPIRES", reqs = []}],
		options = [
			{code = 'lira_quest2_point_one_notice_boards_step', text = "LIRA_QUEST2_OPTION_MANY_WAYS_LOOSEN_TONGUES_NEED_WAIT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_point_one_notice_boards_step', text = "LIRA_QUEST2_OPTION_CHECK_NOTICE_BOARD_FIRST", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_point_one_notice_boards_step = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_POINT_ONE_NOTICE_BOARDS_STEP", reqs = []}],
		options = [
			{code = 'lira_quest2_wanted_renown_bandit_group_charges', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_wanted_renown_bandit_group_charges = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_WANTED_RENOWN_BANDIT_GROUP_CHARGES", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_studies_paper_beside_brow', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_studies_paper_beside_brow = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_STUDIES_PAPER_BESIDE_BROW", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_find_like_walk_camp', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_find_like_walk_camp = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_FIND_LIKE_WALK_CAMP", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_follows_gaze_notices_figures', text = "LIRA_QUEST2_OPTION_THINK_IDEA_USE_CARAVAN_LURE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_follows_gaze_notices_figures', text = "LIRA_QUEST2_OPTION_WOULDNT_NEED_LOOK_BANDITS_CAME_LOOKING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_follows_gaze_notices_figures = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_FOLLOWS_GAZE_NOTICES_FIGURES", reqs = []}],
		options = [
			{code = 'lira_quest2_liras_face_lights_genuine_smile', text = "LIRA_QUEST2_OPTION_WANT_RISK_LIFE_THATS_WANT_HANDLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_liras_face_lights_genuine_smile', text = "LIRA_QUEST2_OPTION_THATS_SOUND_PLAN_CARAVAN_STILL_MUCH", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_liras_face_lights_genuine_smile = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRAS_FACE_LIGHTS_GENUINE_SMILE", reqs = []}],
		options = [
			{code = 'lira_quest2_agreeing_plan_briefly_discuss_details', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_agreeing_plan_briefly_discuss_details = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_AGREEING_PLAN_BRIEFLY_DISCUSS_DETAILS", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_hide_among_thick_bushes_overgrown = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HIDE_AMONG_THICK_BUSHES_OVERGROWN", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_says_nothing_takes_step', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_says_nothing_takes_step = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_SAYS_NOTHING_TAKES_STEP", reqs = []}],
		options = [
			{code = 'lira_quest2_within_moment_three_bandits_down', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_within_moment_three_bandits_down = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_WITHIN_MOMENT_THREE_BANDITS_DOWN", reqs = []}],
		options = [
			{code = 'lira_quest2_turn_back_bandits_lying_ground', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_turn_back_bandits_lying_ground = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TURN_BACK_BANDITS_LYING_GROUND", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_gonna_try_girl_back', text = "LIRA_QUEST2_OPTION_ASK_HIDEOUT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_bandit_gonna_try_girl_back', text = "LIRA_QUEST2_OPTION_PUT_BLADE_THROAT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_gonna_try_girl_back = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_GONNA_TRY_GIRL_BACK", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_couple_dozens_maybe_few', text = "LIRA_QUEST2_OPTION_MANY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_bandit_couple_dozens_maybe_few', text = "LIRA_QUEST2_OPTION_FOCUSING_SLAVE_TRADE_SPECIFICALLY", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest2_bandit_couple_dozens_maybe_few', text = "LIRA_QUEST2_OPTION_HIDEOUT", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_couple_dozens_maybe_few = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_COUPLE_DOZENS_MAYBE_FEW", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_trail_leads_off_road_forest = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_TRAIL_LEADS_OFF_ROAD_FOREST", reqs = []}],
		options = [
			{code = 'lira_quest2_despite_previous_clashes_inside_leaders', text = "LIRA_QUEST2_OPTION_ENTER", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_despite_previous_clashes_inside_leaders = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_DESPITE_PREVIOUS_CLASHES_INSIDE_LEADERS", reqs = []}],
		options = [
			{code = 'lira_quest2_completely_caught_off_guard_sudden', text = "LIRA_QUEST2_OPTION_EVERYONE_ELSE_CAVE_ALREADY_DEAD_GIVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_completely_caught_off_guard_sudden', text = "LIRA_QUEST2_OPTION_FINISH_FIGHT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_completely_caught_off_guard_sudden = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_COMPLETELY_CAUGHT_OFF_GUARD_SUDDEN", reqs = []}],
		options = [
			{code = 'lira_quest2_element_surprise_works_favor_soon', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_element_surprise_works_favor_soon', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_element_surprise_works_favor_soon = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELEMENT_SURPRISE_WORKS_FAVOR_SOON", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_deep_sigh_doesnt_argue', text = "LIRA_QUEST2_OPTION_FINE_WAY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_deep_sigh_doesnt_argue', text = "LIRA_QUEST2_OPTION_DON_WANT_RISK_USING_CARAVAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_deep_sigh_doesnt_argue = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_DEEP_SIGH_DOESNT_ARGUE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_thank_settling_plan_briefly', text = "LIRA_QUEST2_OPTION_THATS_VALID_POINT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_thank_settling_plan_briefly', text = "LIRA_QUEST2_OPTION_THINK", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_thank_settling_plan_briefly = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_THANK_SETTLING_PLAN_BRIEFLY", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_find_caravan_local_tavern_grizzled = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FIND_CARAVAN_LOCAL_TAVERN_GRIZZLED", reqs = []}],
		options = [
			{code = 'lira_quest2_find_group_mercenaries_near_city', text = "LIRA_QUEST2_OPTION_HIRE_EXTRA_GUARDS_GOLD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_find_group_mercenaries_near_city', text = "LIRA_QUEST2_OPTION_IGNORE_ADVICE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_find_group_mercenaries_near_city = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FIND_GROUP_MERCENARIES_NEAR_CITY", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_journey_tense_couple_days_pass = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_JOURNEY_TENSE_COUPLE_DAYS_PASS", reqs = []}],
		options = [
			{code = 'lira_quest2_element_surprise_works_favor_leap', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_element_surprise_works_favor_leap = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_ELEMENT_SURPRISE_WORKS_FAVOR_LEAP", reqs = []}],
		options = [
			{code = 'lira_quest2_blinks_genuinely_puzzled_bandit_leader', text = "LIRA_QUEST2_OPTION_HEAD", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_blinks_genuinely_puzzled_bandit_leader', text = "LIRA_QUEST2_OPTION_ASK_QUESTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_blinks_genuinely_puzzled_bandit_leader = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BLINKS_GENUINELY_PUZZLED_BANDIT_LEADER", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_leader_hah_kidding_rough', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_leader_hah_kidding_rough = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_LEADER_HAH_KIDDING_ROUGH", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_leader_yeah_sure_remember', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_leader_yeah_sure_remember = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_LEADER_YEAH_SURE_REMEMBER", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_leader_myself_bought_off', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_leader_myself_bought_off = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_LEADER_MYSELF_BOUGHT_OFF", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_blinks_eyes_wide_open', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_blinks_eyes_wide_open = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_BLINKS_EYES_WIDE_OPEN", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_lowers_gaze_brow_furrowing', text = "LIRA_QUEST2_OPTION_MAYBE_REASONS_EVERYTHING_SIMPLE_SOUNDS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_lowers_gaze_brow_furrowing', text = "LIRA_QUEST2_OPTION_SOUNDS_LIKE_FAMILY_WASNT_WORTH_LOOKING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_lowers_gaze_brow_furrowing = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_LOWERS_GAZE_BROW_FURROWING", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_leader_hey_since_want', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_leader_hey_since_want = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_LEADER_HEY_SINCE_WANT", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_journey_back_took_eventually_returned = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_JOURNEY_BACK_TOOK_EVENTUALLY_RETURNED", reqs = []}],
		options = [
			{code = 'lira_quest2_bandit_leader_yep_sometimes_appearance', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_bandit_leader_yep_sometimes_appearance = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BANDIT_LEADER_YEP_SOMETIMES_APPEARANCE", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_push_door_open_small_bell = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_PUSH_DOOR_OPEN_SMALL_BELL", reqs = []}],
		options = [
			{code = 'lira_quest2_blinks_clearly_caught_off_guard', text = "LIRA_QUEST2_OPTION_YEAH_SELL_TRIBAL_ELVEN_CHILDREN", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_blinks_clearly_caught_off_guard', text = "LIRA_QUEST2_OPTION_LOOKING_UNCOVER_SHADY_DEALS_PAST", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_blinks_clearly_caught_off_guard = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_BLINKS_CLEARLY_CAUGHT_OFF_GUARD", reqs = []}],
		options = [
			{code = 'lira_quest2_hesitates_mouth_opening_closing_like', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_hesitates_mouth_opening_closing_like = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_HESITATES_MOUTH_OPENING_CLOSING_LIKE", reqs = []}],
		options = [
			{code = 'lira_quest2_flinches_tone_begins_talk_merchant', text = "LIRA_QUEST2_OPTION_TELL_HAPPENED_BACK", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_flinches_tone_begins_talk_merchant', text = "LIRA_QUEST2_OPTION_YOUD_BETTER_EXPLAIN_YOURSELF_OLD_MAN", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_flinches_tone_begins_talk_merchant = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_FLINCHES_TONE_BEGINS_TALK_MERCHANT", reqs = []}],
		options = [
			{code = 'lira_quest2_merchant_yeah_remember_details_said', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_merchant_yeah_remember_details_said = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MERCHANT_YEAH_REMEMBER_DETAILS_SAID", reqs = []}],
		options = [
			{code = 'lira_quest2_merchant_gave_paid_money_much', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_merchant_gave_paid_money_much = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MERCHANT_GAVE_PAID_MONEY_MUCH", reqs = []}],
		options = [
			{code = 'lira_quest2_merchant_kept_tribal_craftsmanship_quite', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_merchant_kept_tribal_craftsmanship_quite = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MERCHANT_KEPT_TRIBAL_CRAFTSMANSHIP_QUITE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_happened_next_else_did', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_happened_next_else_did = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_HAPPENED_NEXT_ELSE_DID", reqs = []}],
		options = [
			{code = 'lira_quest2_merchant_money_good_proud_lira', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_merchant_money_good_proud_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MERCHANT_MONEY_GOOD_PROUD_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest2_merchants_eyes_widen_tries_scream', text = "LIRA_QUEST2_OPTION_RIGHT_AFRAID_HIGH_KARMA_CAUGHT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_merchants_eyes_widen_tries_scream', text = "LIRA_QUEST2_OPTION_EVEN_WORTH_DIRTYING_HANDS_LIVE_WHATEVER", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_merchants_eyes_widen_tries_scream = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MERCHANTS_EYES_WIDEN_TRIES_SCREAM", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_home_voice_sounds_tired', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_home_voice_sounds_tired = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_HOME_VOICE_SOUNDS_TIRED", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_looks_like_story_past', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_looks_like_story_past = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_LOOKS_LIKE_STORY_PAST", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_which_means_abandon_like', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_which_means_abandon_like = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_WHICH_MEANS_ABANDON_LIKE", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_thats_true_everything_learned', text = "LIRA_QUEST2_OPTION_DID_THATS_MATTERS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_lira_thats_true_everything_learned', text = "LIRA_QUEST2_OPTION_SEEMS_GODS_MERCIFUL", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_thats_true_everything_learned = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_THATS_TRUE_EVERYTHING_LEARNED", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_gave_purpose_place_belong', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_gave_purpose_place_belong = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_GAVE_PURPOSE_PLACE_BELONG", reqs = []}],
		options = [
			{code = 'lira_quest2_smiles_visibly_relieved_shoulders_relaxing', text = "LIRA_QUEST2_OPTION_STAY_ALREADY_BELONG", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_smiles_visibly_relieved_shoulders_relaxing', text = "LIRA_QUEST2_OPTION_SET_FREE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_smiles_visibly_relieved_shoulders_relaxing = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_SMILES_VISIBLY_RELIEVED_SHOULDERS_RELAXING", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_lira_took_treated_treated_like = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_TOOK_TREATED_TREATED_LIKE", reqs = []}],
		options = [
			{code = 'lira_quest2_looks_down_amulet_clutches_hand', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_looks_down_amulet_clutches_hand = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LOOKS_DOWN_AMULET_CLUTCHES_HAND", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_looking_way_maybe_freya', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_looking_way_maybe_freya = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_LOOKING_WAY_MAYBE_FREYA", reqs = []}],
		options = [
			{code = 'lira_quest2_moment_stares_believe_heard_lira', text = "LIRA_QUEST2_OPTION_SCREW_FATE_MEANS_PUTTING_GENUINE_SMILE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest2_moment_stares_believe_heard_lira', text = "LIRA_QUEST2_OPTION_GLAD_ABLE_GIVE_YOUVE_BEEN_LOOKING", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest2_moment_stares_believe_heard_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_MOMENT_STARES_BELIEVE_HEARD_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest2_lira_even_know_say_thank', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest2_lira_even_know_say_thank = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_LIRA_EVEN_KNOW_SAY_THANK", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest2_journey_back_quiet_comfortable_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST2_JOURNEY_BACK_QUIET_COMFORTABLE_LIRA", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
}
