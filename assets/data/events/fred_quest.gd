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
			{code = "close", text = "FINDFRED_OPTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
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
			{code = "close", text = "FINDFRED_TALK1_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "close", text = "FINDFRED_TALK1_QUESTION3", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "close", text = "FINDFRED_TALK1_QUESTION4", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
		]
    },

    fred_talk_1_answer_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "FINDFRED_TALK1_ANSWER1", reqs = []}
		],
		options = [
			{code = "close", text = "FINDFRED_TALK1_QUESTION5", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "close", text = "FINDFRED_TALK1_QUESTION6", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "fred_talk_1_else", text = "FINDFRED_TALK1_QUESTION7", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
			{code = "close", text = "FINDFRED_TALK1_QUESTION8", reqs = [], dialogue_argument = 4, type = "next_dialogue"},
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
            {code = 'quest_fight', text = tr("DIALOGUEFIGHTOPTION"), reqs = [], args = 'lich_fight_easy', 
            bonus_effects = [{code = 'decision', value = 'aire_is_dead'}], dialogue_argument = 1},
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
			{code = "close", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
    },

}