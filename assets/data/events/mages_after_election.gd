var data = {
	mages_after_election = {
		image = null,
		character = "myr",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "MAGESAFTERELLECTION1", reqs = []}
		],
		options = [
			{code = "mages_after_election_answer1", text = "MAGESAFTERELLECTION1_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mages_after_election_answer2", text = "MAGESAFTERELLECTION1_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	
	mages_after_election_answer1 = {
		image = null,
		character = "myr",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "MAGESAFTERELLECTION1_ANSWER1", reqs = []}
		],
		options = [
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION3", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	
	mages_after_election_answer2 = {
		image = null,
		character = "myr",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "MAGESAFTERELLECTION1_ANSWER2", reqs = []}
		],
		options = [
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION3", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	
	mages_after_election_answer3 = {
		image = null,
		character = "myr",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "MAGESAFTERELLECTION1_ANSWER3", reqs = [], previous_dialogue_option = [1,2,3]},
			{text = "MAGESAFTERELLECTION1_ANSWER4", reqs = [], previous_dialogue_option = 4},
			{text = "MAGESAFTERELLECTION1_ANSWER5", reqs = [], previous_dialogue_option = 5},
		],
		options = [
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION6", reqs = [], dialogue_argument = 4, type = "next_dialogue", remove_after_first_use = true},
			{code = "mages_after_election_answer3", text = "MAGESAFTERELLECTION1_QUESTION7", reqs = [], dialogue_argument = 5, type = "next_dialogue", remove_after_first_use = true},
			{code = "mages_after_election_answer6", text = "MAGESAFTERELLECTION1_QUESTION8", reqs = [], dialogue_argument = 6, type = "next_dialogue"},
		]
	},
	
	mages_after_election_answer6 = {
		image = null,
		character = "myr",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "MAGESAFTERELLECTION1_ANSWER6", reqs = []},
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1},
		]
	},
}
