extends Reference
var data = {
	lira_quest_1_intro = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_INTRO", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'progress_quest', value = 'lira_quest_1', stage = 'start'}]},
		],
	},
	lira_quest_1_talk_to_lira = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_TALK_TO_LIRA", reqs = []}],
		options = [
			{code = 'lira_quest_1_room_entry', text = "LIRA_QUEST_1_OPTION_KNOCK_ON_THE_DOOR", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_room_entry', text = "LIRA_QUEST_1_OPTION_WALK_INTO_HER_ROOM", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_room_entry = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST_1_ROOM_ENTRY", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST_1_ROOM_ENTRY", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST_1_BUSY", reqs = [], previous_dialogue_option = 3},
			{text = "LIRA_QUEST_1_SERVANTS", reqs = [], previous_dialogue_option = 4},
		],
		options = [
			{code = 'lira_quest_1_room_entry', text = "LIRA_QUEST_1_OPTION_ARE_YOU_BUSY", reqs = [], dialogue_argument = 3, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
			{code = 'lira_quest_1_room_entry', text = "LIRA_QUEST_1_OPTION_HOW_DO_SERVANTS_TREAT_YOU", reqs = [], dialogue_argument = 4, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
			{code = 'lira_quest_1_watch_reason', text = "LIRA_QUEST_1_OPTION_YOU_SEEM_TO_WATCH_ME", reqs = [], dialogue_argument = 3, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
		],
	},
	lira_quest_1_watch_reason = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_WATCH_REASON", reqs = []}],
		options = [
			{code = 'lira_quest_1_watch_reason_followup', text = "LIRA_QUEST_1_OPTION_FEEL_FREE_TO_SHARE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_watch_reason_followup', text = "LIRA_QUEST_1_OPTION_DONT_WORRY_I_UNDERSTAND", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_watch_reason_followup = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_WATCH_REASON_FOLLOWUP", reqs = []}],
		options = [
			{code = 'lira_quest_1_expectations', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_expectations = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_EXPECTATIONS", reqs = []}],
		options = [
			{code = 'lira_quest_1_expectations_answer', text = "LIRA_QUEST_1_OPTION_SERVE_AS_YOU_SERVED_FREYA", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_expectations_answer', text = "LIRA_QUEST_1_OPTION_WHAT_WOULD_YOU_WANT", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_expectations_answer = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_EXPECTATIONS_ANSWER", reqs = []}],
		options = [
			{code = 'lira_quest_1_favor_request', text = "LIRA_QUEST_1_OPTION_OF_COURSE_WHAT_IS_IT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_favor_request', text = "LIRA_QUEST_1_OPTION_HOPEFULLY_NOT_TOO_BOTHERSOME", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_favor_request = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_FAVOR_REQUEST", reqs = []}],
		options = [
			{code = 'lira_quest_1_favor_accept', text = "LIRA_QUEST_1_OPTION_FINE_LETS_GO", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_favor_accept', text = "LIRA_QUEST_1_OPTION_ALRIGHT_LETS_MOVE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_favor_accept = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_FAVOR_ACCEPT", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'progress_quest', value = 'lira_quest_1', stage = 'grove'}, {code = 'make_quest_location', value = 'quest_lira_grove_location'}]},
		],
	},
	lira_quest_1_search_grove = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_SEARCH_GROVE", reqs = []}],
		options = [
			{code = 'lira_quest_1_patrol_confrontation', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_patrol_confrontation = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_PATROL_CONFRONTATION", reqs = []}],
		options = [
			{code = 'lira_quest_1_patrol_dependency', text = "LIRA_QUEST_1_OPTION_SHE_IS_NOT_A_PRIESTESS", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_patrol_freedom', text = "LIRA_QUEST_1_OPTION_EXILED_MEANS", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_patrol_dependency = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_PATROL_DEPENDENCY", reqs = []}],
		options = [
			{code = 'lira_quest_1_grove_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_patrol_freedom = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_PATROL_FREEDOM", reqs = []}],
		options = [
			{code = 'lira_quest_1_grove_arrival', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_grove_arrival = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_GROVE_ARRIVAL", reqs = []}],
		options = [
			{code = 'lira_quest_1_centipede_warning', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_centipede_warning = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_CENTIPEDE_WARNING", reqs = []}],
		options = [
			{code = 'lira_quest_1_fight_plan', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_fight_plan = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_FIGHT_PLAN", reqs = []}],
		options = [
			{code = 'lira_quest_1_fight_ready', text = "LIRA_QUEST_1_OPTION_STAY_BACK_AND_HELP", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_fight_ready', text = "LIRA_QUEST_1_OPTION_WE_FIGHT_TOGETHER", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_fight_ready = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST_1_FIGHT_READY", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST_1_FIGHT_READY", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'lira_grove_centipedes_dep', dialogue_argument = 1, previous_dialogue_option = 1, type = 'next_dialogue'},
			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'lira_grove_centipedes_free', dialogue_argument = 1, previous_dialogue_option = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_dependency_fight_aftermath = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_DEPENDENCY_FIGHT_AFTERMATH", reqs = []}],
		options = [
			{code = 'lira_quest_1_dependency_fight_praise', text = "LIRA_QUEST_1_OPTION_YOU_DID_GREAT", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_dependency_fight_praise', text = "LIRA_QUEST_1_OPTION_NATURAL_WITH_THIS_MAGIC", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_dependency_fight_praise = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_DEPENDENCY_FIGHT_PRAISE", reqs = []}],
		options = [
			{code = 'lira_quest_1_belongings_root', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_freedom_fight_aftermath = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_FREEDOM_FIGHT_AFTERMATH", reqs = []}],
		options = [
			{code = 'lira_quest_1_freedom_fight_reflection', text = "LIRA_QUEST_1_OPTION_PENT_UP_RAGE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'lira_quest_1_freedom_fight_reflection', text = "LIRA_QUEST_1_OPTION_SOMETHING_TO_DO_WITH_RACE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_freedom_fight_reflection = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_FREEDOM_FIGHT_REFLECTION", reqs = []}],
		options = [
			{code = 'lira_quest_1_belongings_root', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	lira_quest_1_belongings_root = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [
			{text = "LIRA_QUEST_1_BELONGINGS_ROOT", reqs = [], previous_dialogue_option = 1},
			{text = "LIRA_QUEST_1_DIARY_PART_2", reqs = [], previous_dialogue_option = 2},
			{text = "LIRA_QUEST_1_HIDDEN_BELONGINGS", reqs = [], previous_dialogue_option = 3},
			{text = "LIRA_QUEST_1_FEEL_BETTER", reqs = [], previous_dialogue_option = 4},
		],
		options = [
			{code = 'lira_quest_1_diary_part_1', text = "LIRA_QUEST_1_OPTION_WHAT_DID_YOU_WRITE", reqs = [], dialogue_argument = 1, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
			{code = 'lira_quest_1_belongings_root', text = "LIRA_QUEST_1_OPTION_WHY_DID_YOU_HIDE_THESE", reqs = [], dialogue_argument = 3, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
			{code = 'lira_quest_1_belongings_root', text = "LIRA_QUEST_1_OPTION_DO_YOU_FEEL_BETTER", reqs = [], dialogue_argument = 4, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
			{code = 'lira_quest_1_head_back', text = "LIRA_QUEST_1_OPTION_TIME_TO_HEAD_BACK", reqs = [], dialogue_argument = 4, previous_dialogue_option = [1, 2, 3, 4], type = 'next_dialogue'},
		],
	},
	lira_quest_1_diary_part_1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_DIARY_PART_1", reqs = []}],
		options = [
			{code = 'lira_quest_1_belongings_root', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	lira_quest_1_head_back = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LIRA_QUEST_1_HEAD_BACK", reqs = []}],
		options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'complete_quest', value = 'lira_quest_1'}]},
		],
	},
}
