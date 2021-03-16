var data = {
	fred_intro = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "VISITFREDSHOMEINTRO", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	fred_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED1", reqs = []}
		],
		options = [
			{code = "fred_talk_1", text = "FINDFRED_OPTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = 'quest_fight', text = "FINDFRED_OPTION2", reqs = [], args = 'lich_fight_easy', dialogue_argument = 1},
		]
	},

	fred_talk_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1", reqs = []}
		],
		options = [
			{code = "fred_talk_1_answer_1", text = "FINDFRED_TALK1_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_10", text = "FINDFRED_TALK1_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_fail", text = "FINDFRED_TALK1_QUESTION3", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "quest_fight", text = "FINDFRED_TALK1_QUESTION4", reqs = [], args = 'lich_fight_easy', dialogue_argument = 4},
		]
	},

	fred_talk_1_answer_1 = {
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK_FAIL", reqs = []}
		],
		options = [
			{code = 'quest_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], args = 'lich_fight_easy', dialogue_argument = 1},
		]
	},

	fred_talk_1_if_greg_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_IF_GREG1", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_greg_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},

	fred_talk_1_if_greg_2 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_IF_GREG2", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_answer_2", text = "FINDFRED_AFTERWIN_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_talk_1_if_answer_3", text = "FINDFRED_AFTERWIN_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	
	fred_talk_1_if_answer_2 = {
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
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
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER9", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		]
	},

	fred_talk_1_if_answer_10 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER10", reqs = []}
		],
		options = [
			{code = "fred_talk_bribe_taken", text = "FINFRED_BRIBE_OPTION1", reqs = [], dialogue_argument = 1},
			{code = "fred_talk_bribe_refused", text = "FINFRED_BRIBE_OPTION2", reqs = [], dialogue_argument = 2},
			{code = "quest_fight", text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 3},
		]
	},

	fred_talk_bribe_taken = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_BRIBE_TAKEN", reqs = []}
		],
		options = [
			{code = "fred_talk_1_if_greg_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1},
		]
	},

	fred_talk_bribe_refused = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_BRIBE_REFUSED", reqs = []}
		],
		options = [
			{code = "quest_fight", text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1},
		]
	},
	
	fred_talk_line_end = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_LINE_END", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		]
	},
	
	fred_talk_line_end_kill = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_LINE_END", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		]
	},

}
