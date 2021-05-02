var data = {
	fred_return_to_myr_1 = {
		variations = [
			# Var 1
			{reqs = [{type = 'decision', value = 'capture_fred', check = true}],
			image = null,
			character = "myr",
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTOMYR_IF_FRED", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'civil_war_start', stage = 'stage5'}]}],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'kill_fred', check = true}],
			image = null,
			character = "myr",
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTOMYR_IF_NOT_FRED", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'civil_war_start', stage = 'stage5'}]}],
			},
			# Var 3
			{reqs = [{type = 'decision', value = 'fred_bribe_taken', check = true}],
			image = null,
			character = "myr",
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTOMYR", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'civil_war_start', stage = 'stage5'}]}],
			},
		]
	},
	
	
	fred_return_to_duncan_1 = {
		variations = [
			# Var 1
			{reqs = [{type = 'decision', value = 'brought_fred', check = true}],
			image = null,
			character = "duncan",
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTODUNCAN_IF_FRED", reqs = []}],
			options = [
			{code = 'fred_return_to_duncan_answer_1', text = "RETURNTODUNCAN_IF_FRED_QUESTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'kill_fred', check = true}],
			image = null,
			character = "duncan",
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
			character = "duncan",
			tags = ['dialogue_scene'],
			text = [{text = "RETURNTODUNCAN1", reqs = []}],
			options = [
			{code = 'fred_return_to_duncan_2', text = "RETURNTODUNCAN_IF_FRED_QUESTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'}],
			},
		]
	},

	fred_return_to_duncan_2 = {
		image = null,
		character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "RETURNTODUNCAN2", reqs = []}
		],
		common_effects = [],
		options = [
				{code = "fred_return_to_duncan_answer_1_1", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"}
		]
	},
	
	fred_return_to_duncan_answer_1_1 = {
		image = null,
		character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "RETURNTODUNCAN_ANSWER1", reqs = []}
		],
		options = [
			{code = "fred_return_to_duncan_answer_1_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
		]
	},
	
	fred_return_to_duncan_answer_1_2 = {
		image = null,
		character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		common_effects = [
			{code = 'play_sound', value = 'doorsmash'},
			{code = 'screen_shake', strength = 3, length = 0.3},
			{code = 'set_location_param', location = 'settlement_plains1', area = 'plains', param = 'captured', value = true},
			#{code = 'return_characters_from_location', value = 'settlement_plains1'},
			],
		text = [
			{text = "RETURNTODUNCAN_TOWNCAPTURE", reqs = []},
			{text = "RETURNTODUNCAN_ANSWER1_1", reqs = []}
		],
		options = [
			{code = "fred_return_to_duncan_answer_2", text = "RETURNTODUNCAN_QUESTION1", reqs = [], dialogue_argument = 1, type = "next_dialogue"},
			{code = "fred_return_to_duncan_answer_2", text = "RETURNTODUNCAN_QUESTION2", reqs = [], dialogue_argument = 2, type = "next_dialogue"},
		]
	},

	fred_return_to_duncan_answer_2 = {
		image = null,
		character = "duncan",
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "RETURNTODUNCAN_ANSWER2", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [], bonus_effects = [
				{code = 'complete_quest', value = 'civil_war_start'},
				{code = 'progress_quest', value = 'civil_war_mines', stage = 'stage1'},
				]
			},
		]
	},

	intermission_2_intro_1 = {
		image = null,
		character = "anastasia",
		character2 = 'greg',
		tags = ["dialogue_scene", "master_translate","blackscreen_transition_slow"],
		text = [
			{text = "INTERMISSION2INTRO1", reqs = []}
		],
		options = [
			{code = "intermission_2_intro_2", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		]
	},

	intermission_2_intro_2 = {
		image = null,
		character = "anastasia",
		character2 = 'greg',
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
		character = "anastasia",
		character2 = 'greg',
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
			character = "anastasia",
			character2 = 'greg',
			tags = ['dialogue_scene'],
			text = [{text = "INTERMISSION2_IF_AIRE_DEAD", reqs = []}],
			options = [
			{code = 'close', text = "DIALOGUECLOSE", reqs = [],
			bonus_effects = [{code = 'screen_black_transition', value = 1}],},
			],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'aire_is_dead', check = false}],
			image = null,
			character = "anastasia",
			character2 = 'aire',
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
			character = "anastasia",
			character2 = 'aire',
			tags = ['dialogue_scene'],
			text = [{text = "INTERMISSION2_IF_AIRE_RAPED1", reqs = []}],
			options = [
			{code = 'intermission_2_aire_raped', text = "DIALOGUECONTINIE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
			},
			# Var 2
			{reqs = [{type = 'decision', value = 'aire_raped', check = false}],
			image = null,
			character = "anastasia",
			character2 = 'aire',
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
		character = "anastasia",
		character2 = 'aire',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2_IF_AIRE_RAPED2", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [],
			bonus_effects = [{code = 'screen_black_transition', value = 1}],},
		]
	},

	intermission_2_aire_not_raped_1 = {
		image = null,
		character = "anastasia",
		character2 = 'aire',
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
		character = "anastasia",
		character2 = 'aire',
		tags = ["dialogue_scene", "master_translate"],
		text = [
			{text = "INTERMISSION2_IF_AIRE_NOT_RAPED3", reqs = []}
		],
		options = [
			{code = "close", text = "DIALOGUECLOSE", reqs = [],
			bonus_effects = [{code = 'screen_black_transition', value = 1}],},
		]
	},
}
