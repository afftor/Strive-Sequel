extends Reference
var data = {
	lira_quest3_over_past_few_days_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_OVER_PAST_FEW_DAYS_LIRA", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
	lira_quest3_see_lira_walk_room_seems = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_SEE_LIRA_WALK_ROOM_SEEMS", reqs = []}],
		options = [
			{code = 'lira_quest3_couple_moments_knock_opens_door', text = "LIRA_QUEST3_OPTION_KNOCK_DOOR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_couple_moments_knock_opens_door', text = "LIRA_QUEST3_OPTION_WALK_ROOM", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_couple_moments_knock_opens_door = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_COUPLE_MOMENTS_KNOCK_OPENS_DOOR", reqs = []}],
		options = [
			{code = 'lira_quest3_hesitates_bit_taking_small_elven', text = "LIRA_QUEST3_OPTION_BUSY_DOING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_hesitates_bit_taking_small_elven', text = "LIRA_QUEST3_OPTION_OTHER_SERVANTS_TREAT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest3_hesitates_bit_taking_small_elven', text = "LIRA_QUEST3_OPTION_SEEM_WATCH_CLOSELY_YET_NEVER_STRIKE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},
	lira_quest3_hesitates_bit_taking_small_elven = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_HESITATES_BIT_TAKING_SMALL_ELVEN", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_takes_small_breath_lira', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_takes_small_breath_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_TAKES_SMALL_BREATH_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_okay_trying_say_spent', text = "LIRA_QUEST3_OPTION_FEEL_FREE_SHARE_THOUGHTS_LISTENING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_lira_okay_trying_say_spent', text = "LIRA_QUEST3_OPTION_DON_WORRY_UNDERSTAND_WANT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_okay_trying_say_spent = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_OKAY_TRYING_SAY_SPENT", reqs = []}],
		options = [
			{code = 'lira_quest3_nods_pauses_briefly_asking_directly', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_nods_pauses_briefly_asking_directly = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_NODS_PAUSES_BRIEFLY_ASKING_DIRECTLY", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_takes_couple_moments_think', text = "LIRA_QUEST3_OPTION_SERVE_DEVOTEDLY_SERVED_FREYA_THATS_WHOLE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_lira_takes_couple_moments_think', text = "LIRA_QUEST3_OPTION_WHILE_FORMALLY_SLAVE_PLACE_STRICT_RESTRICTIONS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_takes_couple_moments_think = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_TAKES_COUPLE_MOMENTS_THINK", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_exiled_forest_wasnt_allowed', text = "LIRA_QUEST3_OPTION_COURSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_lira_exiled_forest_wasnt_allowed', text = "LIRA_QUEST3_OPTION_HOPEFULLY_BOTHERSOME", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_exiled_forest_wasnt_allowed = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_EXILED_FOREST_WASNT_ALLOWED", reqs = []}],
		options = [
			{code = 'lira_quest3_bows_head_flashes_grateful_smile', text = "LIRA_QUEST3_OPTION_FINE_SHOW_GOOD_OBEDIENT_SLAVES", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_bows_head_flashes_grateful_smile', text = "LIRA_QUEST3_OPTION_ALRIGHT_LET_MOVE_MAYBE_THESE_THINGS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_bows_head_flashes_grateful_smile = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_BOWS_HEAD_FLASHES_GRATEFUL_SMILE", reqs = []}],
		options = [
			{code = 'lira_quest3_deeper_walk_beneath_tall_trees', text = "LIRA_QUEST3_OPTION_SEARCH_GROVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_deeper_walk_beneath_tall_trees = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_DEEPER_WALK_BENEATH_TALL_TREES", reqs = []}],
		options = [
			{code = 'lira_quest3_elf_patrol_leader_rebel_priestess', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_elf_patrol_leader_rebel_priestess = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_ELF_PATROL_LEADER_REBEL_PRIESTESS", reqs = []}],
		options = [
			{code = 'lira_quest3_tense_moment_patrol_leader_nods', text = "LIRA_QUEST3_OPTION_PRIESTESS_ANYMORE_SHES_SLAVE_PERSONAL_PROPERTY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_tense_moment_patrol_leader_nods', text = "LIRA_QUEST3_OPTION_EXILED_MEANS_LONGER_LIVE_AMONG_DOESNT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_tense_moment_patrol_leader_nods = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_TENSE_MOMENT_PATROL_LEADER_NODS", reqs = []}],
		options = [
			{code = 'lira_quest3_short_walk_reach_grove_place', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_short_walk_reach_grove_place = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_SHORT_WALK_REACH_GROVE_PLACE", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_did_come_always_thought', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_did_come_always_thought = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_DID_COME_ALWAYS_THOUGHT", reqs = []}],
		options = [
			{code = 'lira_quest3_lira', text = "LIRA_QUEST3_OPTION_STAY_BACK_HELP_LEAVE_FIGHTING", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_lira', text = "LIRA_QUEST3_OPTION_FIGHT_TOGETHER_SIDE_SIDE_CAPABLE_MORE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest3_together_slay_aggressive_beasts_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_together_slay_aggressive_beasts_fight = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_TOGETHER_SLAY_AGGRESSIVE_BEASTS_FIGHT", reqs = []}],
		options = [
			{code = 'lira_quest3_smiles_brightly_pleased_praise_lira', text = "LIRA_QUEST3_OPTION_DID_GREAT_ESPECIALLY_FIRST_FIGHT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_smiles_brightly_pleased_praise_lira', text = "LIRA_QUEST3_OPTION_LOOKS_LIKE_NATURAL_TYPE_MAGIC", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_smiles_brightly_pleased_praise_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_SMILES_BRIGHTLY_PLEASED_PRAISE_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest3_looks_back_hands_slain_centipedes', text = "LIRA_QUEST3_OPTION_MAYBE_PENT_RAGE_YEARS_OBEDIENCE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_looks_back_hands_slain_centipedes', text = "LIRA_QUEST3_OPTION_SOMETHING_RACE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest3_looks_back_hands_slain_centipedes = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LOOKS_BACK_HANDS_SLAIN_CENTIPEDES", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_goes_back_hollow_tree', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_goes_back_hollow_tree = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_GOES_BACK_HOLLOW_TREE", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_flips_through_few_pages', text = "LIRA_QUEST3_OPTION_DID_WRITE_DIARY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest3_lira_flips_through_few_pages', text = "LIRA_QUEST3_OPTION_DID_HIDE_THESE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'lira_quest3_lira_flips_through_few_pages', text = "LIRA_QUEST3_OPTION_FEEL_BETTER_GETTING_THESE_BACK", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
			{code = 'lira_quest3_lira_flips_through_few_pages', text = "LIRA_QUEST3_OPTION_ALRIGHT_HEAD_BACK_SHOULDNT_LINGER_FOREST", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_flips_through_few_pages = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_FLIPS_THROUGH_FEW_PAGES", reqs = []}],
		options = [
			{code = 'lira_quest3_points_another_entry_lira_part', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_points_another_entry_lira_part = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_POINTS_ANOTHER_ENTRY_LIRA_PART", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_first_kept_these_hidden', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_first_kept_these_hidden = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_FIRST_KEPT_THESE_HIDDEN", reqs = []}],
		options = [
			{code = 'lira_quest3_lira_one_made_myself_small', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest3_lira_one_made_myself_small = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST3_LIRA_ONE_MADE_MYSELF_SMALL", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		],
	},
}
