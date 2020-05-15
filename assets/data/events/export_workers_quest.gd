# Quest data
var data = {
	workers_introduction1 = {
		image = null,
		character = 'sigmund',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "WORKERSINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'workers_introduction2', text = "WORKERSINTRODUCTIONREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'workers_introduction2', text = "WORKERSINTRODUCTIONREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	workers_introduction2 = {
		image = null,
		character = 'sigmund',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "WORKERSINTRODUCTION2_1", reqs = [], previous_dialogue_option = 1},
		{text = "WORKERSINTRODUCTION2_2", reqs = [], previous_dialogue_option = 2},
		{text = "WORKERSINTRODUCTION2_3", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}], previous_dialogue_option = 1},
		{text = "WORKERSINTRODUCTION2_4", reqs = [], previous_dialogue_option = 3},
		{text = "WORKERSINTRODUCTION2_5", reqs = [], previous_dialogue_option = 4},
		{text = "WORKERSINTRODUCTION2_6", reqs = [], previous_dialogue_option = 5},
		],
		options = [
		{code = 'workers_questions', text = "WORKERSASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'workers_join', text = "WORKERSINTRODUCTION1REPLY3", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}], type = 'next_dialogue', dialogue_argument = 3},
		{code = 'workers_election_initiate1', text = "WORKERSREQUESTELECTIONSUPPORT", 
			reqs = [
			{type = 'active_quest_stage', value = 'election_global_quest', stage = 'stage1'},
			{type = 'faction_reputation', code = 'workers', operant = 'gte', value = 500}, 
			{type = 'dialogue_seen', operant = 'neq', value = 'WORKERSELECTIONINITIATE1'}, 
			{type = 'decision', name = 'workers_election_support', value = false}], 
			type = 'next_dialogue', dialogue_argument = 1},
		{code = 'workers_election_initiate5', text = "WORKERSINTRODUCTION1REPLY6", reqs = [{type = 'active_quest_stage', value = 'election_global_quest', stage = 'stage1'},{type = 'active_quest_stage', value = 'workers_election_quest', stage = 'stage3'}], bonus_effects = [{code = 'complete_quest', value = 'workers_election_quest'}], dialogue_argument = 6, type = 'next_dialogue'},
		{code = 'workers_leader_close', text = "WORKERSINTRODUCTION1REPLY4", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
	},
	workers_join = {
		image = null,
		character = 'sigmund',
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSJOIN", reqs = []},
		],
		common_effects = [{code = 'reputation', name = 'workers', operant = '+', value = 100},
		{code = 'make_loot', pool = [['workers_join_reward',1]]}, 
		{code = 'open_loot'}
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'workers'},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
	},
	workers_leader_close = {
		image = null,
		character = 'sigmund',
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSCLOSE1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}]},
		{text = "WORKERSCLOSE2", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start', state = false}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
	workers_questions = {
		image = null,
		character = 'sigmund',
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSQUESTIONS_1", reqs = [], previous_dialogue_option = 1, remove_after_first_use = true},
		{text = "WORKERSQUESTIONS_2", reqs = [], previous_dialogue_option = 2, remove_after_first_use = true},
		{text = "WORKERSQUESTIONS_4", reqs = [], previous_dialogue_option = 4, remove_after_first_use = true},
		],
		options = [
		{code = 'workers_questions', text = "WORKERSQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'workers_questions', text = "WORKERSQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'workers_introduction2', text = "WORKERSASKQUESTIONSRETURN", reqs = [], dialogue_argument = 5},
		],
		
	},
	
	workers_election_initiate1 = {
		image = null,
		character = 'sigmund',
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSELECTIONINITIATE1", reqs = []},
		],
		options = [
			{code = 'workers_election_initiate2', text = "WORKERSELECTIONINITIATE1REPLY1",
			reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'workers_election_initiate2', text = "WORKERSELECTIONINITIATE1REPLY2",
			reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	
	workers_election_initiate2 = {
			image = null,
			character = 'sigmund',
			tags = ['dialogue_scene'],
			text = [
			{text = "WORKERSELECTIONINITIATE2_1", reqs = []},
			],
			common_effects = [{code = 'progress_quest', value = 'workers_election_quest', stage = 'start'}],
			options = [
				{code = 'close', text = "WORKERSELECTIONINITIATE2_1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
	},

	workers_election_initiate3 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "WORKERSELECTIONINITIATE2_2", reqs = [],
		bonus_effects = [{code = 'progress_quest', value = 'workers_election_quest', stage = 'stage1'}]},
		],
		options = [
			{code = 'workers_election_initiate4', text = "WORKERSELECTIONINITIATE2_2REPLY1",
			reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'workers_election_initiate4', text = "WORKERSELECTIONINITIATE2_2REPLY2",
			reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	workers_election_initiate4 = {
		image = null,
		character = 'duncan',
		tags = [],
		text = [
		{text = "WORKERSELECTIONINITIATE3", reqs = []},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = []},
		],
	},
	
	workers_election_initiate5 = {
		image = null,
		character = 'sigmund',
		tags = [],
		text = [
			{text = "WORKERSELECTIONINITIATE5", reqs = [],
			bonus_effects = [{code = 'decision', value = 'workers_election_support'}]},
		],
		options = [
			{code = 'close', text = "WORKERSELECTIONINITIATE5REPLY1", reqs = [],},
			{code = 'close', text = "WORKERSELECTIONINITIATE5REPLY2", reqs = [],},
		],
	},

	reim_encounter = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "REIMENCOUNTER", reqs = [],
			bonus_effects = [{code = 'progress_quest', value = 'workers_election_quest', stage = 'stage2'}]}
		],
		options = [
			{code = 'reim_encounter2', text = "REIMENCOUNTERREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'reim_encounter2', text = "REIMENCOUNTERREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'reim_encounter2', text = "REIMENCOUNTERREPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	reim_encounter2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "REIMENCOUNTER2", reqs = []}
		],
		options = [
			{code = 'reim_encounter5', text = "REIMENCOUNTER2REPLY1", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
			{code = 'reim_encounter3', text = "REIMENCOUNTER2REPLY2", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
			{code = 'reim_encounter4', text = "REIMENCOUNTER2REPLY3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'reim_encounter4', text = "REIMENCOUNTER2REPLY4", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	reim_encounter3 = {
		variations = [
			{reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 1}]}],
			image = null,
			tags = [],
			text = [
				{text = "REIMENCOUNTER3_1", reqs = []}
			],
			options = [
				{code = 'close', text = "REIMENCOUNTER3_1REPLY1", reqs = [],
				bonus_effects = [{code = 'decision', value = 'reim_persuaded'}]},
			]},
			{reqs = [],
			image = null,
			tags = ['dialogue_scene'],
			text = [
				{text = "REIMENCOUNTER3_2", reqs = []}
			],
			options = [
				{code = 'reim_encounter4', text = "REIMENCOUNTER2REPLY3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'reim_encounter4', text = "REIMENCOUNTER2REPLY4", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			]
		}
		],
	},

	reim_encounter4 = {
		image = null,
		tags = [],
		text = [
		{text = "REIMENCOUNTER4_1", reqs = [], previous_dialogue_option = 1},
		{text = "REIMENCOUNTER4_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = []},
		],
	},

	reim_encounter5 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "REIMENCOUNTER5", reqs = []}
		],
		options = [
			{code = 'reim_encounter4', text = "REIMENCOUNTER2REPLY3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'reim_encounter4', text = "REIMENCOUNTER2REPLY4", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	workers_elections_continue1 = {
		image = null,
		tags = ['dialogue_scene'],
		character = 'duncan',
		text = [
			{text = "WORKERSELECTIONCONTINUE1", reqs = []},
		],
		options = [
			{code = 'workers_elections_continue2', text = "WORKERSELECTIONCONTINUE1REPLY1",
			reqs = [{type = "has_money", value = 150}], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'workers_elections_continue2', text = "WORKERSELECTIONCONTINUE1REPLY2",
			reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'close', text = "WORKERSELECTIONCONTINUE1REPLY3", reqs = []},
		],
	},

	workers_elections_continue2 = {
		image = null,
		character = 'duncan',
		tags = [],
		text = [
			{text = "WORKERSELECTIONCONTINUE2_1", reqs = [], previous_dialogue_option = 1,
			bonus_effects = [
				{code = 'money_change', operant = '-', value = 150},
				{code = 'decision', value = 'helped_reim'}]},
			{text = "WORKERSELECTIONCONTINUE2_2", reqs = [], previous_dialogue_option = 2,
			bonus_effects = [
				{code = 'decision', value = 'turned_in_reim'}]},
			
		],
		options = [
			{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = [],
			bonus_effects = [{code = 'progress_quest', value = 'workers_election_quest', stage = 'stage3'}]},
		],
	},
}
