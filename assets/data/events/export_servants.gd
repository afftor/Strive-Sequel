var data = {
	servants_introduction = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "SERVANTSINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
		{text = "SERVANTSINTRODUCTION1_1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}], previous_dialogue_option = 1},
		{text = "SERVANTSINTRODUCTION1_2", reqs = [], previous_dialogue_option = 2},
		{text = "SERVANTSINTRODUCTION1_3", reqs = [], previous_dialogue_option = 3},
		{text = "SERVANTSINTRODUCTION1_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [
		{code = 'servants_questions', text = "SERVANTSASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'servants_join', text = "SERVANTSINTRODUCTION1REPLY3", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}], type = 'next_dialogue', dialogue_argument = 3},
		{code = 'servants_election', text = "SERVANTSREQUESTELECTIONSUPPORT", reqs = [
			{type = 'active_quest_stage', value = 'election_global_quest', stage = 'stage1'}, 
			{type = 'faction_reputation', code = 'servants', operant = 'gte', value = 500},
			{type = 'decision', name = 'servants_election_support', value = false}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'servants_election_finish1', text = "SERVANTSINTRODUCTION1REPLY5", reqs = [{type = "has_multiple_decisions", decisions = ['fighters_election_support', 'workers_election_support', 'servants_election_support', 'mages_election_support'], operant = 'gte', value = 3}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'servants_leader_close', text = "SERVANTSINTRODUCTION1REPLY4", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
	},
	servants_join = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTSJOIN", reqs = []},
		],
		common_effects = [{code = 'reputation', name = 'servants', operant = '+', value = 100},
		{code = 'make_loot', pool = [['servants_join_reward',1]]}, 
		{code = 'open_loot'}
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'servants'}, {code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
	},
	servants_leader_close = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTSCLOSE1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}]},
		{text = "SERVANTSCLOSE2", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start', state = false}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
	servants_questions = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTSQUESTIONS_1", reqs = [], previous_dialogue_option = 1},
		{text = "SERVANTSQUESTIONS_2", reqs = [], previous_dialogue_option = 2},
		{text = "SERVANTSQUESTIONS_3", reqs = [], previous_dialogue_option = 3},
		{text = "SERVANTSQUESTIONS_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [
		{code = 'servants_questions', text = "SERVANTSQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'servants_questions', text = "SERVANTSQUESTIONREPLY2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
		{code = 'servants_questions', text = "SERVANTSQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'servants_introduction', text = "SERVANTSASKQUESTIONSRETURN", reqs = [], dialogue_argument = 4},
		],
		
	},
	servants_election = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "SERVANTSELECTIONCONFIRM", reqs = []},
		],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'decision', value = 'servants_election_support'}]},
		],
	},
	elections_start1 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART1", reqs = [], previous_dialogue_option = 1},
		],
		common_effects = [{code = 'progress_quest', value = 'election_global_quest', stage = 'stage1'},
		{code = 'complete_quest', value = 'guilds_introduction'}
		],
		options = [
		{code = 'elections_start2', text = "ELECTIONSTARTREPLY1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'elections_start2', text = "ELECTIONSTARTREPLY1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	elections_start2 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART2", reqs = []},
		],
		options = [
		{code = 'elections_start3', text = "ELECTIONSTARTREPLY2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'elections_start3', text = "ELECTIONSTARTREPLY2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	elections_start3 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART3", reqs = []},
		],
		options = [
		{code = 'elections_persuade', text = "ELECTIONSTARTREPLY3_1", reqs = [], dialogue_argument = 1},
		{code = 'elections_start4', text = "ELECTIONSTARTREPLY3_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	elections_persuade = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONPERSUADE1", reqs = [], previous_dialogue_option = 1},
		{text = "ELECTIONPERSUADESUCCESS", reqs = [{type = 'master_check', value = [{code = 'stat', type = 'charm_factor', operant = 'gte', value = 3}]}], previous_dialogue_option = 2},
		{text = "ELECTIONPERSUADEFAILURE", reqs = [{type = 'master_check', value = [{code = 'stat', type = 'charm_factor', operant = 'lte', value = 2}]}], previous_dialogue_option = 2},
		],
		options = [
		{code = 'elections_persuade', text = "ELECTIONSTARTREPLY3_2", reqs = [{type = 'dialogue_selected', operant = 'neq', value = 'ELECTIONSTARTREPLY3_2'}], dialogue_argument = 2},
		{code = 'elections_start4', text = "ELECTIONSTARTREPLY3_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	elections_start4 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART4", reqs = []},
		{text = "ELECTIONSTART4_1", reqs = [{type = "faction_reputation", code = 'servants', operant = 'gte', value = 300}], bonus_effects = [{code = 'decision', value = 'servants_election_support'}]},
		{text = "ELECTIONSTART4_2", reqs = []},
		],
		options = [
		{code = 'elections_start5', text = "ELECTIONSTARTREPLY4_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'elections_start5', text = "ELECTIONSTARTREPLY4_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	elections_start5 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "ELECTIONSTART5_1", reqs = [], previous_dialogue_option = 1},
		{text = "ELECTIONSTART5_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = "update_guild"}]},
		],
	},

	servants_election_finish1 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "SERVANTSELECTIONFINISH1", reqs = []},
			{text = "SERVANTSELECTIONFINISH1_2", reqs = [{type = "has_multiple_decisions", decisions = ['fighters_election_support', 'workers_election_support', 'servants_election_support', 'mages_election_support'], operant = 'gte', value = 4}], bonus_effects = [{code = 'make_loot', pool = [['servants_election_bonus',1]]}, {code = 'open_loot'}]},
			{text = "SERVANTSELECTIONFINISH1_3", reqs = []},
		],
		common_effects = [{code = 'progress_quest', value = 'election_global_quest', stage = 'stage2'}, {code = 'complete_quest', value = 'main_quest_loan'}, {code = 'remove_timed_events', value = ['loan_event1','loan_event2','loan_event3','loan_event4']}],
		options = [
			{code = 'servants_election_finish2', text = "SERVANTSELECTIONFINISH1REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'servants_election_finish2', text = "SERVANTSELECTIONFINISH1REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
		]
	},

	servants_election_finish2 = { 
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SERVANTSELECTIONFINISH2_1", reqs = [], previous_dialogue_option = 1},
			{text = "SERVANTSELECTIONFINISH2_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'servants_election_finish3', text = "SERVANTSELECTIONFINISH2REPLY1", reqs = [], dialogue_argument = 3},
			{code = 'servants_election_finish4', text = "SERVANTSELECTIONFINISH2REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'servants_election_finish4', text = "SERVANTSELECTIONFINISH2REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
		],
	},

	servants_election_finish3 = { 
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','master_translate'],
		text = [
			{text = "SERVANTSELECTIONFINISH3", reqs = []},
		],
		options = [
			{code = 'servants_election_finish4', text = "SERVANTSELECTIONFINISH2REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'servants_election_finish4', text = "SERVANTSELECTIONFINISH2REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
		],
	},

	servants_election_finish4 = { 
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SERVANTSELECTIONFINISH4_1", reqs = [], previous_dialogue_option = 1},
			{text = "SERVANTSELECTIONFINISH4_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'servants_election_finish5', text = "SERVANTSELECTIONFINISH4REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'servants_election_finish5', text = "SERVANTSELECTIONFINISH4REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
		],
	},

	servants_election_finish5 = { 
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SERVANTSELECTIONFINISH5_1", reqs = [], previous_dialogue_option = 1},
			{text = "SERVANTSELECTIONFINISH5_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'servants_election_finish6', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1},
		],
	},

	servants_election_finish6 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene','blackscreen_transition_common'],
		text = [
			{text = "SERVANTSELECTIONFINISH6", reqs = []},
		],
		options = [
			{code = 'servants_election_finish7', text = "SERVANTSELECTIONFINISH6REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'servants_election_finish7', text = "SERVANTSELECTIONFINISH6REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'servants_election_finish7', text = "SERVANTSELECTIONFINISH6REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 3},
		],
	},

	servants_election_finish7 = {
		image = null,
		character = 'amelia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SERVANTSELECTIONFINISH7_1", reqs = [], previous_dialogue_option = 1},
			{text = "SERVANTSELECTIONFINISH7_2", reqs = [], previous_dialogue_option = 2},
			{text = "SERVANTSELECTIONFINISH7_3", reqs = [], previous_dialogue_option = 3},
			{text = "SERVANTSELECTIONFINISH7_ANY", reqs = []},
		],
		options = [
			{code = 'servants_election_finish8', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1},
		],
	},

	servants_election_finish8 = {
		image = null,
		character = 'anastasia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SERVANTSELECTIONFINISH8", reqs = []}
		],
		common_effects = [{code = 'set_music', value = 'battle2'}],
		options = [
			{code = 'servants_election_finish9', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1}
		]
	},

	servants_election_finish9 = {
		image = null,
		character = 'anastasia',
		tags = ['dialogue_scene'],
		text = [
			{text = "SERVANTSELECTIONFINISH9", reqs = []}
		],
		options = [
			{code = 'start_finale', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1}
		]
	},

	start_finale = {
		image = null,
		tags = ['dialogue_scene','blackscreen_transition_slow'],
		text = [
			{text = "STARTFINALE", reqs = []}
		],
		common_effects = [{code = 'set_music', value = 'ending'}],
		options = [
			{code = 'close', text = tr("DIALOGUECLOSE"), reqs = []}
		]
	},
}
