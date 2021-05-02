var data = {
	fred_intro = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "VISITFREDSHOMEINTRO", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = "next_dialogue",
				bonus_effects = [
					{code = 'progress_quest', value = 'civil_war_start', stage = 'stage3'},
					{code = 'make_quest_location', value = 'quest_mages_fred'},
					{code = 'update_city'},
					]},
			
			]
	},
	
	fred_bribe_take = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "VISITFREDSHOME_IF_BRIBE", reqs = []}
		],
		common_effects = [
			{code = 'money_change', operant = '+', value = 500},
			],
		options = [
			{code = "close", text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = "next_dialogue", bonus_effects = [{code= 'update_city'}]},
		]
	},
	
	
	
	fred_1 = {
		image = null,
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED1", reqs = []}
		],
		options = [
			{code = "fred_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	fred_2 = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED2", reqs = []}
		],
		options = [
			{code = "fred_talk_1", text = "FINDFRED_OPTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = 'quest_fight', text = "FINDFRED_OPTION2", reqs = [], args = 'mercenary_fred_quest', type = 'next_dialogue', dialogue_argument = 1},
		]
	},
	

	fred_talk_1 = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1", reqs = []}
		],
		options = [
			{code = "fred_talk_1_answer_1", text = "FINDFRED_TALK1_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_10", text = "FINDFRED_TALK1_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_QUESTION3", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "quest_fight", text = "FINDFRED_TALK1_QUESTION4", reqs = [], args = 'mercenary_fred_quest', dialogue_argument = 4},
		]
	},

	fred_talk_1_answer_1 = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 4}]},]},
			{text = "FINDFRED_TALK1_ANSWER1_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}]},]},
		],
		options = [
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_QUESTION5", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_QUESTION6", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_1_else", text = "FINDFRED_TALK1_QUESTION7", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_QUESTION8", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},

	fred_talk_1_else = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ELSE", reqs = []}
		],
		options = [
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_CONTRACTOR_DUNCAN", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_greg_1", text = "FINDFRED_TALK1_CONTRACTOR_GREG", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_CONTRACTOR_FRED", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_CONTRACTOR_AVERMIK", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},

	fred_talk_fail = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK_FAIL", reqs = []}
		],
		options = [
			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'mercenary_fred_quest', dialogue_argument = 1},
		]
	},

	fred_talk_1_if_greg_1 = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_IF_GREG1", reqs = []}
		],
		options = [
			{code = "fred_got_no_fight", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	
	fred_got_no_fight = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_IF_GREG2", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_2", text = "FINDFRED_AFTERWIN_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_3", text = "FINDFRED_AFTERWIN_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	
	fred_got_after_fight = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_AFTERWIN", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_2", text = "FINDFRED_AFTERWIN_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_3", text = "FINDFRED_AFTERWIN_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_2 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER2", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_4", text = "FINDFRED_AFTERWIN_QUESTION3", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_5", text = "FINDFRED_AFTERWIN_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_6", text = "FINDFRED_AFTERWIN_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_7", text = "FINDFRED_AFTERWIN_QUESTION6", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_3 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER3", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_4", text = "FINDFRED_AFTERWIN_QUESTION3", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_5", text = "FINDFRED_AFTERWIN_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_6", text = "FINDFRED_AFTERWIN_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_7", text = "FINDFRED_AFTERWIN_QUESTION6", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_4 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER4", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_5", text = "FINDFRED_AFTERWIN_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_6", text = "FINDFRED_AFTERWIN_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_7", text = "FINDFRED_AFTERWIN_QUESTION6", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_5 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER5", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_6", text = "FINDFRED_AFTERWIN_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_7", text = "FINDFRED_AFTERWIN_QUESTION6", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_6 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER6", reqs = []}
		],
		options = [
			{code = "fred_talk_line_end", text = "FINDFRED_AFTERWIN_QUESTION7", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_8", text = "FINDFRED_AFTERWIN_QUESTION8", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_7 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER7", reqs = []}
		],
		options = [
			{code = "fred_talk_line_end_kill", text = "FINDFRED_AFTERWIN_QUESTION9", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_8", text = "FINDFRED_AFTERWIN_QUESTION8", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_8 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER8", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_9", text = "FINDFRED_AFTERWIN_QUESTION10", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_9", text = "FINDFRED_AFTERWIN_QUESTION11", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_line_end", text = "FINDFRED_AFTERWIN_QUESTION12", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "fred_talk_line_end_kill", text = "FINDFRED_AFTERWIN_QUESTION13", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_9 = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		common_effects = [
			{code = 'decision', value = 'fred_bribe_taken'},
			],
		text = [
			{text = "FINDFRED_TALK1_ANSWER9", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'remove_quest_location', value = 'quest_mages_fred'}, 
				{code = 'progress_quest', value = 'civil_war_start', stage = 'stage4'},
				{code = 'add_timed_event', value = "intermission_greg_demon1", args = [{type = 'add_to_hour', hour = [1,1]}]}
				]
			},
		]
	},

	fred_talk_1_if_answer_10 = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER10", reqs = []}
		],
		options = [
			{code = "fred_talk_bribe_taken", text = "FINFRED_BRIBE_OPTION1", reqs = [{type = "has_money", value = 300}], dialogue_argument = 1},
			{code = "fred_talk_bribe_refused", text = "FINFRED_BRIBE_OPTION2", reqs = [], dialogue_argument = 2},
			{code = "quest_fight", text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'mercenary_fred_quest', dialogue_argument = 3},
		]
	},

	fred_talk_bribe_taken = {
		image = null,
		common_effects = [
			{code = 'money_change', operant = '-', value = 300},
			{code = 'decision', value = 'bribed_mercs'},
			],
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_BRIBE_TAKEN", reqs = []}
		],
		options = [
			{code = "fred_got_no_fight", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1},
		]
	},

	fred_talk_bribe_refused = {
		image = 'fred_mercs',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_BRIBE_REFUSED", reqs = []}
		],
		options = [
			{code = "quest_fight", text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'mercenary_fred_quest', dialogue_argument = 1},
		]
	},
	
	fred_talk_line_end = {
		image = "fred",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_LINE_END_KILL2", reqs = []}
		],
		common_effects = [
			{code = 'decision', value = 'capture_fred'},
			],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'remove_quest_location', value = 'quest_mages_fred'}, 
				{code = 'progress_quest', value = 'civil_war_start', stage = 'stage4'},
				{code = 'add_timed_event', value = "intermission_greg_demon1", args = [{type = 'add_to_hour', hour = [1,1]}]}
				],
			},
		]
	},
	
	fred_talk_line_end_kill = {
		image = 'fred',
		tags = ["dialogue_scene", "master_translate"],
		common_effects = [
			{code = 'decision', value = 'kill_fred'},
			],
		text = [
			{text = "FINDFRED_LINE_END_KILL", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, 
			bonus_effects = [
				{code = 'remove_quest_location', value = 'quest_mages_fred'}, 
				{code = 'progress_quest', value = 'civil_war_start', stage = 'stage4'},
				{code = 'add_timed_event', value = "intermission_greg_demon1", args = [{type = 'add_to_hour', hour = [1,1]}]}
				]
			},
		]
	},
	
	
	intermission_greg_demon1 = {
		image = null,
		character = "greg",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate","blackscreen_transition_slow"],
		text = [
			{text = "INTERMISSIONINTRO1", reqs = []}
		],
		options = [
			{code = "intermission_greg_demon2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},

	intermission_greg_demon2 = {
		image = null,
		character = "greg",
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSIONINTRO2", reqs = []}
		],
		options = [
			{code = "intermission_greg_demon3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},

	intermission_greg_demon3 = {
		image = null,
		#character = null,
		character2 = "demon_female",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSIONINTRO3", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue",
			bonus_effects = [{code = 'screen_black_transition', value = 1}],
				}, 
				
		]
	},
	
}
