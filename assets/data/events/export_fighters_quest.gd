# Quest Data
var data = {
	fighters_introduction1 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSINTRODUCTION1", reqs = []},
		],
		options = [
		{code = 'fighters_introduction2', text = "FIGHTERSINTRODUCTION1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'fighters_introduction2', text = "FIGHTERSINTRODUCTION1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		
	},
	fighters_introduction2 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSINTRODUCTION2_1", reqs = [], previous_dialogue_option = 1, bonus_effects = [{code = "update_guild"}]},
		{text = "FIGHTERSINTRODUCTION2_2", reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = "update_guild"}]},
		{text = "FIGHTERSINTRODUCTION2_3", reqs = [], previous_dialogue_option = [1,2]},
		{text = "FIGHTERSINTRODUCTION2_3_1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}], previous_dialogue_option = [1,2]},
		{text = "FIGHTERSINTRODUCTION2_4", reqs = [], previous_dialogue_option = 3},
		{text = "FIGHTERSINTRODUCTION2_5", reqs = [], previous_dialogue_option = 4},
		{text = "FIGHTERSINTRODUCTION2_6", reqs = [], previous_dialogue_option = 5},
		],
		options = [
		{code = 'fighters_questions', text = "FIGHTERSASKQUESTIONS", reqs = [], dialogue_argument = 1},
		{code = 'fighters_join', text = "FIGHTERSINTRODUCTION2REPLY1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}], type = 'next_dialogue', dialogue_argument = 3},
		
		{code = 'fighters_election1', text = "FIGHTERSREQUESTELECTIONSUPPORT", reqs = [
			{type = 'active_quest_stage', value = 'election_global_quest', stage = 'stage1'}, 
			{type = 'faction_reputation', code = 'fighters', operant = 'gte', value = 500},
			{type = 'decision', name = 'fighters_election_support', value = false},
			{type = 'dialogue_seen', operant = 'neq', value = 'FIGHTERSELECTIONSTART1'}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'fighters_election5', text = "FIGHTERSINTRODUCTION2REPLY5", reqs = [{type = 'decision', name = 'fighters_election_support', value = false}, 
		{type = 'active_quest_stage', value = 'fighters_election_quest', stage = 'stage2'}, 
		#{type = 'has_material', operant = 'gte', value = 1, material = 'lich_skull'},
		{type = 'dialogue_seen', operant = 'eq',value = 'FIGHTERSELECTIONSTART1'}], dialogue_argument = 7, type = 'next_dialogue'}, 
		
		
		
		{code = 'workers_elections_continue1', text = "FIGHTERSINTRODUCTION2REPLY6", reqs = [{type = 'active_quest_stage', value = 'workers_election_quest', stage = 'stage2'}], type = 'next_dialogue', dialogue_argument = 6},
		{code = 'workers_election_initiate3', text = "FIGHTERSINTRODUCTION2REPLY7", reqs = [{type = 'active_quest_stage', value = 'workers_election_quest', stage = 'start'}], type = 'next_dialogue', dialogue_argument = 7}, 
		{code = 'fighters_leader_close', text = "FIGHTERSINTRODUCTION2REPLY2", reqs = [], dialogue_argument = 4, bonus_effects = [{code = "update_guild"}]},
		],
		
	},
	fighters_join = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSJOIN", reqs = []},
		],
		common_effects = [
		{code = 'reputation', name = 'fighters', operant = '+', value = 100}, 
		{code = 'make_loot', pool = [['fighters_join_reward',1]]}, 
		{code = 'open_loot'}],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'fighters'}, {code = 'main_progress', operant = '+', value = 1},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
		
	},
	fighters_leader_close = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSCLOSE1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}]},
		{text = "FIGHTERSCLOSE2", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start', state = false}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
		
	},
	fighters_questions = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene'],
		text = [
		{text = "FIGHTERSQUESTIONS_1", reqs = [], previous_dialogue_option = 1},
		{text = "FIGHTERSQUESTIONS_2", reqs = [], previous_dialogue_option = 2},
		{text = "FIGHTERSQUESTIONS_3", reqs = [], previous_dialogue_option = 3},
		{text = "FIGHTERSQUESTIONS_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [
		{code = 'fighters_questions', text = "FIGHTERSQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'fighters_questions', text = "FIGHTERSQUESTIONREPLY2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
		{code = 'fighters_questions', text = "FIGHTERSQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'fighters_introduction2', text = "FIGHTERSASKQUESTIONSRETURN", reqs = [], dialogue_argument = 5},
		],
		
	},
	
	fighters_election1 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART1", reqs = []},
		],
		options = [
		{code = 'fighters_election2', text = "FIGHTERSELECTIONSTARTREPLY1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'fighters_election2', text = "FIGHTERSELECTIONSTARTREPLY1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election2 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART2", reqs = []},
		],
		options = [
		{code = 'fighters_election3', text = "FIGHTERSELECTIONSTARTREPLY2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'fighters_election3', text = "FIGHTERSELECTIONSTARTREPLY2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election3 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART3", reqs = []},
		],
		options = [
		{code = 'fighters_election_details', text = "FIGHTERSELECTIONSTARTREPLY3_1", reqs = [], dialogue_argument = 1},
		{code = 'fighters_election4', text = "FIGHTERSELECTIONSTARTREPLY3_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election_details = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART4_1", reqs = []},
		],
		options = [
		{code = 'fighters_election4', text = "FIGHTERSELECTIONSTARTREPLY3_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},
	fighters_election4 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTIONSTART4_2", reqs = []},
		],
		options = [
		{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [
		{code = 'progress_quest', value = 'fighters_election_quest', stage = 'start'}, 
		{code = 'make_quest_location', value = 'quest_fighters_lich'}]},
		],
	},

	fighters_election5 = {
		image = null,
		character = 'duncan',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "FIGHTERSELECTION5", reqs = [], 
		bonus_effects = [
			{code = 'decision', value = 'fighters_election_support'},
			{code = 'material_change', operant = '-', name = 'lich_skull', value = 1},
			{code = 'complete_quest', value = 'fighters_election_quest'}]},
		],
		options = [
		{code = 'close', reqs = [], text = "FIGHTERSELECTIONTHANKS"},
		{code = 'close', reqs = [], text = "FIGHTERSELECTIONREPLY1"},
		],
	},

	lich_enc_initiate = {
		image = null,
		character = 'aire',
		tags = ['dialogue_scene'],
		text = [
		{text = tr("LICHENCINITIATE"), reqs = []}
		],
		options = [
		{code = 'lich_enc_fight', text = "LICHENCINITIATEREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_talk1', text = "LICHENCINITIATEREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	lich_enc_fight = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHENCFIGHT", reqs = []}
		],
		options = [
		{code = 'quest_fight', text = tr("DIALOGUEFIGHTOPTION"), reqs = [], args = 'lich_fight_easy', 
		bonus_effects = [{code = 'decision', value = 'aire_is_dead'}], dialogue_argument = 1},
		],
	},


	lich_enc_talk1 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK1",
		options = [
		{code = 'quest_fight', text = "LICHENCTALK1REPLY1", reqs = [], args = 'lich_fight_normal', dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_talk2', text = "LICHENCTALK1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_enc_talk2', text = "LICHENCTALK1REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	lich_enc_talk2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK2",
		options = [
		{code = 'quest_fight', text = "LICHENCTALK2REPLY1", reqs = [], args = 'lich_fight_normal', dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_talk3', text = "LICHENCTALK2REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'quest_fight', text = "LICHENCTALK2REPLY3", reqs = [], args = 'lich_fight_normal', dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	lich_enc_talk3 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK3",
		options = [
		{code = 'quest_fight', text = "LICHENCTALK3REPLY1", reqs = [], args = 'lich_fight_normal', dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_talk4', text = "LICHENCTALK3REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_enc_conclusion', text = "LICHENCTALK3REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		{code = 'lich_enc_talk5', text = "LICHENCTALK3REPLY4", reqs = [], dialogue_argument = 4},
		],
	},

	lich_enc_talk4 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK4",
		common_effects = [{code = 'decision', value = 'lich_extra_reward'},{code = 'make_loot', pool = [['fighters_lich_bonus_loot',1]]}, 
		{code = 'open_loot'}],
		options = [
		{code = 'quest_fight', text = "LICHENCTALK4REPLY1", reqs = [], args = 'lich_fight_normal', dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_conclusion', text = "LICHENCTALK4REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_enc_talk5', text = "LICHENCTALK4REPLY3", reqs = [], dialogue_argument = 3},
		],
	},

	lich_enc_talk5 = {
		image = null,
		tags = ['dialogue_scene'],
		text = "LICHENCTALK5",
		options = [
		{code = 'quest_fight', text = "LICHENCILLKILLYOU", reqs = [], args = 'lich_fight_normal', dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_enc_conclusion', text = "LICHENCFINE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_enc_talk6', text = "LICHENCTALK5REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	lich_enc_talk6 = {
		variations = [
		{reqs = [
			{type = 'master_check', value = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 4}]},
			{type = 'group_size', operant = 'gte', value = 5, orflag = true}],
		image = null,
		tags = ['dialogue_scene'],
		text = [{text = "LICHENCTALK6", reqs = []}],
		options = [
		{code = 'lich_aire_talk1', text = "DIALOGUECONTINUE", reqs = [],
		bonus_effects = [
			{code = 'decision', value = 'aire_is_saved'},
			{code = 'decision', value = 'deal_with_lich'},
			{code = 'material_change', operant = '+', name = 'lich_skull', value = 1},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			], dialogue_argument = 1, type = 'next_dialogue'},
		],
		},
		{reqs = [],
		image = null,
		tags  = ['dialogue_scene'],
		text = [{text = "LICHENCTALK6_1", reqs = []}],
		options = [
		{code = 'quest_fight', text = "LICHENCILLKILLYOU", reqs = [], args = 'lich_fight_normal', dialogue_argument = 1},
		{code = 'lich_enc_conclusion', text = "LICHENCTALK6REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		},
		],
	},
		
		lich_enc_conclusion = {
		image = null,
		tags = [],
		text = [
		{text = 'LICHENCCONLUSION', reqs =[]},
		],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION"), 
		bonus_effects = [
			{code = 'decision', value = 'aire_is_dead'},
			{code = 'decision', value = 'deal_with_lich'},
			{code = 'material_change', operant = '+', name = 'lich_skull', value = 1},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'remove_quest_location', value = 'quest_fighters_lich'}]},
		],
	},

	lich_enc_win = {
		variations = [
		{reqs = [{type = 'decision', name = 'aire_is_dead', value = false}],
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "", reqs = [],
		bonus_effects = [
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'remove_quest_location', value = 'quest_fighters_lich'}]},
		],
		options = [
		{code = 'lich_aire_talk1', reqs = [], text = "LICHENCWINAIRENOTDEAD", dialogue_argument = 1},
		],
		},
		{reqs = [],
		image = null,
		tags  = [],
		text = [
		{text = "LICHENCWINELSE", reqs = [],
		bonus_effects = [
			{code = 'remove_quest_location', value = 'quest_fighters_lich'},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'}]},
		],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION")},
		],
		},
		],
	},

	lich_aire_talk1 = {
		image = null,
		character = 'aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK1", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk2', text = "LICHAIRETALK1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_aire_talk3', text = "LICHAIRETALK1REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		{code = 'lich_aire_talk6', text = "LICHAIRETALK1REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],
	},


	lich_aire_talk2 = {
		image = null,
		character = 'aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK2", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk5', text = "LICHAIRETALK2REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_talk3', text = "LICHAIRETALK2REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK2REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	lich_aire_talk3 = {
		image = null,
		character = 'aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK3", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk4', text = "LICHAIRETALK3REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK3REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	lich_aire_talk4 = {
		variations = [
		{reqs = [
		{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}]},
		],
		image = null,
		character = 'aire',
		tags = [],
		text = [
		{text = "LICHAIRETALK4", reqs = []},
		],
		options = [
		{code = 'leave', reqs = [], text = tr("DIALOGUELEAVEOPTION"), dialogue_argument = 1, bonus_effects = [{code = 'decision', value = 'aire_had_sex'},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'remove_quest_location', value = 'quest_fighters_lich'}]
		
		},
		],
		},
		{reqs = [],
		image = null,
		character = 'aire',
		tags  = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK4_1", reqs = []},
		],
		options = [
		{code = 'lich_aire_leave', text = "LICHAIRETALK4_1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_talk6', text = "LICHAIRETALK4_1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		},
		],
	},

	lich_aire_talk5 = {
		image = null,
		character = 'aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK5", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk3', text = "LICHAIRETALK5REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK5REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_aire_talk6', text = "LICHAIRETALK5REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	lich_aire_talk6 = {
		image = null,
		character = 'aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk7', text = "LICHAIRETALK6REPLY1", reqs = [],
		bonus_effects = [{code = 'decision', value = 'aire_raped'}], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK6REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	lich_aire_talk7 = {
		image = null,
		tags = [],
		text = [
		{text = "LICHAIRETALK7", reqs = []},
		],
		options = [
		{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = [], bonus_effects = [{code = 'decision', value = 'aire_is_dead'},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'remove_quest_location', value = 'quest_fighters_lich'}]},
		],
	},

	lich_aire_leave = {
		image = null,
		character = 'aire',
		tags = [],
		text = [
		{text = "LICHAIRELEAVE", reqs = [], },
		],
		common_effects = [],
		options = [
		{code = 'leave', text = tr("DIALOGUELEAVEOPTION"), reqs = [], bonus_effects = [
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'remove_quest_location', value = 'quest_fighters_lich'}]},
		],
		},
}
