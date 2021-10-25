var data = {
	after_election_line1 = {
		image = null,
		character = "duncan",
		character2 = "myr",
		tags = ["dialogue_scene", "master_translate",'blackscreen_transition_slow'],
		text = [
			{text = "ALIRONELECTIONSFINISH_LINE1", reqs = []}
		],
		common_effects = [{code = 'set_music', value = 'exploration'}],
		options = [
			{code = "after_election_line2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},

	after_election_line2 = {
		image = null,
		character = "sigmund",
		character2 = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_LINE2", reqs = []}
		],
		options = [
			{code = "after_election_line3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	after_election_line3 = {
		image = null,
		character = "duncan",
		character2 = "sigmund",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_LINE3", reqs = []}
		],
		options = [
			{code = "after_election_line4", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	after_election_line4 = {
		image = null,
		character = "duncan",
		character2 = "myr",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_LINE4", reqs = []}
		],
		options = [
			{code = "after_election_line5", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	after_election_line5 = {
		image = null,
		character = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_LINE5", reqs = []}
		],
		common_effects = [
			{code = 'progress_quest', value = 'civil_war_start', stage = 'stage1'},
			],
		options = [
			{code = "after_election_answer1", text = "ALIRONELECTIONSFINISH_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "after_election_answer2", text = "ALIRONELECTIONSFINISH_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},
	
	after_election_answer1 = {
		image = null,
		character = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_ANSWER1", reqs = []}
		],
		options = [
			{code = "after_election_answer3", text = "ALIRONELECTIONSFINISH_QUESTION3", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "after_election_answer4", text = "ALIRONELECTIONSFINISH_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "after_election_answer5", text = "ALIRONELECTIONSFINISH_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	
	after_election_answer2 = {
		image = null,
		character = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_ANSWER2", reqs = []}
		],
		
		options = [
			{code = "after_election_answer3", text = "ALIRONELECTIONSFINISH_QUESTION3", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "after_election_answer4", text = "ALIRONELECTIONSFINISH_QUESTION4", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
			{code = "after_election_answer5", text = "ALIRONELECTIONSFINISH_QUESTION5", reqs = [], dialogue_argument = 3, type = "next_dialogue"},
		]
	},
	
	after_election_answer3 = {
		image = null,
		character = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_ANSWER3", reqs = []}
		],
		options = [
			{code = "act1_scene", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2}
		]
	},
	
	after_election_answer4 = {
		image = null,
		character = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_ANSWER4", reqs = []}
		],
		options = [
			{code = "act1_scene", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2}
		]
	},
	
	after_election_answer5 = {
		image = null,
		character = "amelia",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "ALIRONELECTIONSFINISH_ANSWER5", reqs = []}
		],
		options = [
			{code = "act1_scene", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2}
		]
	},
	
	act1_scene = {
		image = null,
		tags = ["dialogue_scene", "master_translate", "blackscreen_transition_common"],
		custom_background = "act1_art",
		scene_type = "story_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "", reqs = []}
		],
		common_effects = [{code = 'add_timed_event', value = "zephyra_artifacts_init", args = [{type = 'add_to_date', date = [1,1], hour = 8}], },  ],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 1}
		]
	}
}
