var data = {
	fred_return_to_duncan_1 = {
		variations = [
			# Var 1
			{reqs = [{type = 'decision', value = 'brought_fred', check = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTODUNCAN_IF_FRED", reqs = []}],
			options = [
			{code = 'fred_return_to_duncan_answer_1', text = "RETURNTODUNCAN_IF_FRED_QUESTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'kill_fred', check = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTODUNCAN_IF_NOT_FRED", reqs = []}],
			options = [
			{code = 'fred_return_to_duncan_2', text = "RETURNTODUNCAN_IF_NOT_FRED_QUESTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'fred_return_to_duncan_2', text = "RETURNTODUNCAN_IF_NOT_FRED_QUESTION2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			],
			},
			# Var 3
			{reqs = [], #{type = 'decision', value = 'bribe_from_fred_taken', check = true}
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTODUNCAN1", reqs = []}],
			options = [
			{code = 'fred_return_to_duncan_answer_1', text = "RETURNTODUNCAN_IF_FRED_QUESTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'}],
			},
		]
	},

	fred_return_to_duncan_2 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "RETURNTODUNCAN2", reqs = []}
		],
		bonus_effects = [{code = 'decision', value = 'HelpSigmundAvailable'}],
		options = [
				{code = "fred_return_to_duncan_answer_1", text = "RETURNTODUNCAN_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	fred_return_to_duncan_answer_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "RETURNTODUNCAN_ANSWER1", reqs = []}
		],
		options = [
			{code = "fred_return_to_duncan_answer_2", text = "RETURNTODUNCAN_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_return_to_duncan_answer_2", text = "RETURNTODUNCAN_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},

	fred_return_to_duncan_answer_2 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "RETURNTODUNCAN_ANSWER2", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = []},
		]
	},

	intermission_2_intro_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2INTRO1", reqs = []}
		],
		options = [
			{code = "intermission_2_intro_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		]
	},

	intermission_2_intro_2 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2INTRO2", reqs = []}
		],
		options = [
			{code = "intermission_2_intro_3", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		]
	},
	
	intermission_2_intro_3 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2INTRO3", reqs = []}
		],
		options = [
			{code = "intermission_2_aire_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		]
	},
	
	intermission_2_aire_1 = {
		variations = [
			# Var 1
			{reqs = [{type = 'decision', value = 'aire_is_dead', check = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "INTERMISSION2_IF_AIRE_DEAD", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = []},
			],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'aire_is_dead', check = false}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "INTERMISSION2_IF_AIRE_ALIVE", reqs = []}],
			options = [
			{code = 'intermission_2_aire_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
			},
		]
	},
	
	intermission_2_aire_2 = {
		variations = [
			# Var 1
			{reqs = [{type = 'decision', value = 'aire_raped', check = true}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "INTERMISSION2_IF_AIRE_RAPED1", reqs = []}],
			options = [
			{code = 'intermission_2_aire_raped', text = "DIALOGUECONTINIE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'aire_raped', check = false}],
			image = null,
			tags = ['dialogue_scene'],
			text = [{text = "INTERMISSION2_IF_AIRE_NOT_RAPED1", reqs = []}],
			options = [
			{code = 'intermission_2_aire_not_raped_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
			},
		]
	},
	
	intermission_2_aire_raped = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2_IF_AIRE_RAPED2", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = []},
		]
	},

	intermission_2_aire_not_raped_1 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2_IF_AIRE_NOT_RAPED2", reqs = []}
		],
		options = [
			{code = "intermission_2_aire_not_raped_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		]
	},

	intermission_2_aire_not_raped_2 = {
		image = null,
		# character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2_IF_AIRE_NOT_RAPED3", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = []},
		]
	},
}
