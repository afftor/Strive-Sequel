#decisions:
#mindbreak_completed
#persuade_1_completed
#AireAnastasiaPersuasionAgree
#AnastasiaRejected
#persuade_2_completed
#marry_proposed
#enslave_proposed
#AireAnastasiaPersuasion

#previous decisions
#mindbreak_enabled
#marry_option
#enslave_option
#enslave_bracelet
#has_bracelet


var data = {
	princess_persuation_init = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_1", reqs = [], previous_dialogue_option = 0},
		],
		options = [
			{
				code = 'princess_recriut_early_1',
				text = "ANASTASIA_PERSUASION_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
				remove_after_first_use = true,
				type = 'next_dialogue'
			},
			{
				code = 'princess_mindbreak_1',
				text = "ANASTASIA_PERSUASION_OPTION_2",
				reqs = [{type = 'decision', value = 'mindbreak_enabled', check = true}],
				dialogue_argument = 1,
				remove_after_first_use = true,
				type = 'next_dialogue'
			},
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
			},
		],
	},
	princess_mindbreak_1 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_2", reqs = [], previous_dialogue_option = 1},
		],
		options = [
			{
				code = 'princess_mindbreak_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_mindbreak_2 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_3", reqs = [{type = 'decision', value = 'enslave_bracelet', check = true}], previous_dialogue_option = 1},#stub req
			{text = "ANASTASIA_PERSUASION_4", reqs = [{type = 'decision', value = 'enslave_bracelet', check = false}], previous_dialogue_option = 1},#stub req
			{text = "ANASTASIA_PERSUASION_5", reqs = [], previous_dialogue_option = 1},
		],
		options = [
			{
				code = 'princess_declaration_1',
				text = 'DIALOGUECONTINUE',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'mindbreak_completed'}, {code = 'complete_quest', value = 'princess_persuasion'}],
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_early_1 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [],#no text here for some reason
		options = [
			{
				code = 'princess_recriut_early_2',
				text = "ANASTASIA_PERSUASION_OPTION_3",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_early_2',
				text = "ANASTASIA_PERSUASION_OPTION_4",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_early_2',
				text = "ANASTASIA_PERSUASION_OPTION_5",
				reqs = [],
				dialogue_argument = 3,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_early_2 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_6", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_PERSUASION_7", reqs = [], previous_dialogue_option = 2},
			{text = "ANASTASIA_PERSUASION_8", reqs = [], previous_dialogue_option = 3},
			{text = "ANASTASIA_PERSUASION_9", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_early_3',
				text = "ANASTASIA_PERSUASION_OPTION_6",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_early_3',
				text = "ANASTASIA_PERSUASION_OPTION_7",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_early_3',
				text = "ANASTASIA_PERSUASION_OPTION_8",
				reqs = [],
				dialogue_argument = 3,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_early_3 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_10", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_PERSUASION_11", reqs = [], previous_dialogue_option = 2},
			{text = "ANASTASIA_PERSUASION_12", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{
				code = 'princess_recriut_early_4',
				text = "ANASTASIA_PERSUASION_OPTION_9",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_early_4',
				text = "ANASTASIA_PERSUASION_OPTION_10",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_early_4 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_13", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_1',
				text = "ANASTASIA_PERSUASION_OPTION_11",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_1',
				text = "ANASTASIA_PERSUASION_OPTION_12",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_1 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_14", reqs = [], bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = 0}]},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_marry',
				text = "ANASTASIA_PERSUASION_OPTION_13",
				reqs = [{type = 'decision', value = 'marry_option', check = true}],
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'marry_proposed'}],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_marry',
				text = "ANASTASIA_PERSUASION_OPTION_14",
				reqs = [{type = 'decision', value = 'marry_option', check = true}],
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'marry_proposed'}],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_enslave',
				text = "ANASTASIA_PERSUASION_OPTION_15",
				reqs = [{type = 'decision', value = 'enslave_option', check = true}],
				dialogue_argument = 1,
				bonus_effects = [],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_enslave',
				text = "ANASTASIA_PERSUASION_OPTION_16",
				reqs = [{type = 'decision', value = 'enslave_option', check = true}],
				dialogue_argument = 1,
				bonus_effects = [],
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_marry = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_15", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_3',
				text = "ANASTASIA_PERSUASION_OPTION_17",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_3',
				text = "ANASTASIA_PERSUASION_OPTION_18",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_3',
				text = "ANASTASIA_PERSUASION_OPTION_19",
				reqs = [],
				dialogue_argument = 3,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_enslave = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_19", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_3',
				text = "ANASTASIA_PERSUASION_OPTION_20",
				reqs = [],
				dialogue_argument = 4,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = '+'}],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_3',
				text = "ANASTASIA_PERSUASION_OPTION_21",
				reqs = [],
				dialogue_argument = 5,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_3',
				text = "ANASTASIA_PERSUASION_OPTION_22",
				reqs = [],
				dialogue_argument = 6,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_3 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_16", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_PERSUASION_17", reqs = [], previous_dialogue_option = 2},
			{text = "ANASTASIA_PERSUASION_18", reqs = [], previous_dialogue_option = 3},
			{text = "ANASTASIA_PERSUASION_20", reqs = [], previous_dialogue_option = 4},
			{text = "ANASTASIA_PERSUASION_21", reqs = [], previous_dialogue_option = [5, 6]},
			{text = "ANASTASIA_PERSUASION_22", reqs = [], previous_dialogue_option = [4, 5, 6]},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_4',
				text = "ANASTASIA_PERSUASION_OPTION_23",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy', op = '+'}],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_4',
				text = "ANASTASIA_PERSUASION_OPTION_24",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_4',
				text = "ANASTASIA_PERSUASION_OPTION_25",
				reqs = [],
				dialogue_argument = 3,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_4 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_23", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_PERSUASION_24", reqs = [], previous_dialogue_option = 2},
			{text = "ANASTASIA_PERSUASION_25", reqs = [], previous_dialogue_option = 3},
			{text = "ANASTASIA_PERSUASION_26", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_amelia_1',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_amelia_1 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		character2 = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_27", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_amelia_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_amelia_2 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		character2 = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_28", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_7',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_7 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		character2 = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_29", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_8',
				text = "ANASTASIA_PERSUASION_OPTION_26",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'dialogue_counter', name = 'sympathy', op = '+'},
					{code = 'dialogue_counter', name = 'sympathy', op = '+'},
					{code = 'dialogue_counter', name = 'sympathy', op = '+'},
					],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_8',
				text = "ANASTASIA_PERSUASION_OPTION_27",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_8',
				text = "ANASTASIA_PERSUASION_OPTION_28",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_8 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		character2 = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_30", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_1st_persuation_9',
				text = "ANASTASIA_PERSUASION_OPTION_29",
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'dialogue_counter', name = 'sympathy', op = '+'},
					{code = 'dialogue_counter', name = 'sympathy', op = '+'},
					{code = 'dialogue_counter', name = 'sympathy', op = '+'},
					],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_9',
				text = "ANASTASIA_PERSUASION_OPTION_30",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_1st_persuation_9',
				text = "ANASTASIA_PERSUASION_OPTION_31",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_1st_persuation_9 = {
		custom_background = "jail",
		image = null,
		character = "anastasia",
		character2 = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_31", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_intermission_1',
				text = "DIALOGUECONTINUE",
				reqs = [{type = 'local_counter', name = 'sympathy', add_stat = 'charm_factor', operant = 'gte', value = 10, check = true}],
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'persuade_1_completed'}, {code = 'update_city'}],
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_intermission_1',
				text = "DIALOGUECONTINUE",
				reqs = [{type = 'local_counter', name = 'sympathy', add_stat = 'charm_factor', operant = 'gte', value = 10, check = false}],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_intermission_1 = {
		custom_background = "jail",
		image = null,
		character = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_32", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_intermission_2',
				text = "ANASTASIA_PERSUASION_OPTION_32",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue'
			},
			{
				code = 'princess_recriut_intermission_2',
				text = "ANASTASIA_PERSUASION_OPTION_33",
				reqs = [],
				dialogue_argument = 2,
				type = 'next_dialogue'
			},
		],
	},
	princess_recriut_intermission_2 = {
		variations = [
			{
				reqs = [
					{type = 'decision', value = 'aire_is_dead', check = false},
					{type = 'decision', value = 'persuade_1_completed', check = true},
				],
				image = null,
				custom_background = "jail",
				character = "amelia",
				tags = ['dialogue_scene'],
				text = [
					{text = "ANASTASIA_PERSUASION_33", reqs = [], previous_dialogue_option = 1},
					{text = "ANASTASIA_PERSUASION_34", reqs = [], previous_dialogue_option = 2},
					{text = "ANASTASIA_PERSUASION_35", reqs = []},
				],
				options = [
					{
						code = 'princess_recriut_intermission_3',
						text = "ANASTASIA_PERSUASION_OPTION_34",
						reqs = [],
						dialogue_argument = 1,
						bonus_effects = [{code = 'decision', value = 'AireAnastasiaPersuasionAgree'}],
						type = 'next_dialogue'
					},
					{
						code = 'princess_recriut_intermission_3',
						text = "ANASTASIA_PERSUASION_OPTION_35",
						reqs = [],
						dialogue_argument = 2,
						type = 'next_dialogue'
					},
				],
			},
			{
				reqs = [
					{type = 'decision', value = 'aire_is_dead', check = true},
					{type = 'decision', value = 'persuade_1_completed', check = true},
				],
				image = null,
				character = "amelia",
				custom_background = "jail",
				tags = ['dialogue_scene'],
				text = [
					{text = "ANASTASIA_PERSUASION_33", reqs = [], previous_dialogue_option = 1},
					{text = "ANASTASIA_PERSUASION_34", reqs = [], previous_dialogue_option = 2},
					{text = "ANASTASIA_PERSUASION_38", reqs = []},
				],
				options = [
					{
						code = 'close',
						text = "DIALOGUECLOSE",
						reqs = [],
						dialogue_argument = 1,
						type = 'next_dialogue',
						bonus_effects = [{code = 'add_timed_event', value = 'princess_recruit_timeout_message', args = [{type = 'add_to_date', date = [1,1], hour = 1}]}, {code = 'update_city'}],
					},
				],
			},
			{
				reqs = [
					{type = 'decision', value = 'persuade_1_completed', check = false},
				],
				image = null,
				character = "amelia",
				custom_background = "jail",
				tags = ['dialogue_scene'],
				text = [
					{text = "ANASTASIA_PERSUASION_33", reqs = [], previous_dialogue_option = 1},
					{text = "ANASTASIA_PERSUASION_34", reqs = [], previous_dialogue_option = 2},
					{text = "ANASTASIA_PERSUASION_38", reqs = []},
				],
				options = [
					{
						code = 'close',
						text = "DIALOGUECLOSE",
						reqs = [],
						dialogue_argument = 1,
						type = 'next_dialogue',
						bonus_effects = [{code = 'add_timed_event', value = 'princess_recruit_timeout_message', args = [{type = 'add_to_date', date = [1,1], hour = 1}]}, {code = 'update_city'}], #add second persuation trigger here
					},
				],
			},
		]
	},
	princess_recriut_intermission_3 = {
		image = null,
		character = "amelia",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_36", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_PERSUASION_37", reqs = [], previous_dialogue_option = 2},
			{text = "ANASTASIA_PERSUASION_38", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
				bonus_effects = [{code = 'add_timed_event', value = 'princess_recruit_timeout_message', args = [{type = 'add_to_date', date = [1,1], hour = 1}]}, {code = 'update_city'}], #add second persuation trigger here
			},
		],
	},

	princess_recruit_timeout_message = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_NEXTDAY", reqs = []},
		],

		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'decision', value = 'AnastasiaPersuasionNextday'}, {code = 'update_city'},
					{code = 'dialogue_counter', name = 'sympathy2', op = 0}
				], #add second persuation trigger here
			},
		],
	},



	princess_persuation_2_init = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'persuade_1_completed', check = true}],
				image = null,
				character = "anastasia",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_39", reqs = [], previous_dialogue_option = 0},
					{text = "ANASTASIA_PERSUASION_42", reqs = [], previous_dialogue_option = 0},
					{text = "ANASTASIA_PERSUASION_45", reqs = [], previous_dialogue_option = 1},
					{text = "ANASTASIA_PERSUASION_50", reqs = [], previous_dialogue_option = 2},
					{text = "ANASTASIA_PERSUASION_51", reqs = [], previous_dialogue_option = 3},
				],
				options = [
					{
						code = 'princess_persuation_2_aire_1',
						text = "ANASTASIA_PERSUASION_OPTION_36",
						reqs = [{type = 'decision', value = 'AireAnastasiaPersuasionAgree', check = true}],
						dialogue_argument = 1,
						type = 'next_dialogue',
						remove_after_first_use = true
					},
					{
						code = 'princess_persuation_2_init',#'princess_persuation_2_bracelet',
						text = "ANASTASIA_PERSUASION_OPTION_37",
						reqs = [{type = 'has_material', material = 'princess_bracelet', operant = 'gte', value = 1}],
						dialogue_argument = 3,
						remove_after_first_use = true,
						type = 'next_dialogue',
						bonus_effects = [
							{code = 'dialogue_counter', name = 'sympathy2', op = '+'},
							{code = 'decision', value = 'bracelet_returned'},
							{code = 'material_change', operant = '-', material = 'princess_bracelet', value = 1},
							{code = 'remove_decision', value = 'mindbreak_enabled'}
						]
					},
					{
						code = 'princess_persuation_2_2',
						text = "ANASTASIA_PERSUASION_OPTION_38",
						reqs = [],
						dialogue_argument = 1,
						type = 'next_dialogue',
						remove_after_first_use = true,
					},
					{
						code = 'princess_mindbreak_1',
						text = "ANASTASIA_PERSUASION_OPTION_2",
						reqs = [{type = 'decision', value = 'mindbreak_enabled', check = true}],
						dialogue_argument = 1,
						type = 'next_dialogue',
						remove_after_first_use = true
					},
					{
						code = 'close',
						text = "ANASTASIA_PERSUASION_OPTION_39",
						reqs = [],
						dialogue_argument = 1,
					},
				],
			},
			{
				reqs = [{type = 'decision', value = 'persuade_1_completed', check = false}],
				image = null,
				character = "anastasia",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_39", reqs = []},
					{text = "ANASTASIA_PERSUASION_40", reqs = []},
				],
				options = [
					{
						code = 'princess_persuation_2_fail',
						text = "DIALOGUECONTINUE",
						reqs = [],
						dialogue_argument = 1,
						type = 'next_dialogue',
						bonus_effects = [],
					},
				],
			},
		]
	},
	princess_persuation_2_fail = {
		image = null,
		character = "amelia",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_41", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
				bonus_effects = [{code = 'decision',value = "anastasia_persuasion_fail"}]
			},
		],
	},
	princess_persuation_2_aire_1 = {
		image = null,
		character = "anastasia",
		character2 = "aire",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_43", reqs = [], bonus_effects = [{code = 'decision', value = 'AireAnastasiaPersuasion'}]},
		],
		options = [
			{
				code = 'princess_persuation_2_aire_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				type = 'next_dialogue',
			},
		],
	},
	princess_persuation_2_aire_2 = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'aire_raped', check = true}],
				image = null,
				character = "anastasia",
				character2 = "aire",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_44", reqs = []},
				],
				options = [
					{
						code = 'princess_persuation_2_init',
						text = "DIALOGUECONTINUE",
						reqs = [],
						dialogue_argument = 1,
						bonus_effects = [
							{code = 'dialogue_counter', name = 'sympathy2', op = '-'},
							{code = 'dialogue_counter', name = 'sympathy2', op = '-'},
							],
						type = 'next_dialogue',
					},
				],
			},
			{
				reqs = [{type = 'decision', value = 'aire_raped', check = false}],
				image = null,
				character = "anastasia",
				character2 = "aire",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_46", reqs = []},
					{text = "ANASTASIA_PERSUASION_47", reqs = [{type = 'decision', value = 'aire_is_saved', check = true}], bonus_effects = [
						{code = 'dialogue_counter', name = 'sympathy2', op = '+'},
						{code = 'dialogue_counter', name = 'sympathy2', op = '+'},
						{code = 'dialogue_counter', name = 'sympathy2', op = '+'},
					]},
					{text = "ANASTASIA_PERSUASION_48", reqs = [{type = 'decision', value = 'aire_is_saved', check = false}], bonus_effects = [
						{code = 'dialogue_counter', name = 'sympathy2', op = '+'},
						{code = 'dialogue_counter', name = 'sympathy2', op = '+'},
					]},
					{text = "ANASTASIA_PERSUASION_49", reqs = []},
				],
				options = [
					{
						code = 'princess_persuation_2_init',
						text = "DIALOGUECONTINUE",
						reqs = [],
						dialogue_argument = 2,
						bonus_effects = [],
						type = 'next_dialogue',
					},
				],
			},
		]
	},
	princess_persuation_2_2 = {
		image = null,
		character = "anastasia",
		custom_background = "jail",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_52", reqs = []},
		],
		options = [
			{
				code = 'princess_persuation_2_2_1',
				text = "ANASTASIA_PERSUASION_OPTION_40",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_persuation_2_2_1',
				text = "ANASTASIA_PERSUASION_OPTION_41",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]
			},
			{
				code = 'princess_persuation_2_2_1',
				text = "ANASTASIA_PERSUASION_OPTION_42",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},

	princess_persuation_2_2_1 = {
		variations = [{
			reqs = [{type = 'decision', value = 'marry_option', check = true}],
			image = null,
			character = "anastasia",
			custom_background = "jail",
			tags = ['dialogue_scene'],
			text = [
				{text = "ANASTASIA_PERSUASION_2_MARRY1", reqs = []},
			],
			options = [
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_MARRY1_OPTION1",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 1,
				},
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_MARRY1_OPTION2",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 2,
				},
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_MARRY1_OPTION3",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 3,
				},
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_MARRY1_OPTION4",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 4,
				},
			],
		},

		{
			reqs = [{type = 'decision', value = 'enslave_option', check = true}],
			image = null,
			character = "anastasia",
			custom_background = "jail",
			tags = ['dialogue_scene'],
			text = [
				{text = "ANASTASIA_PERSUASION_2_ENSLAVE1", reqs = []},
			],
			options = [
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION1",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 1,
				},
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION2",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 2,
				},
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION3",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 3,
				},
				{
					code = 'princess_persuation_2_2_2',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE1_OPTION4",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 4,
				},
			],
		},

		]

	},

	princess_persuation_2_2_2 = {
		variations = [{
			reqs = [{type = 'decision', value = 'marry_option', check = true}],
			image = null,
			character = "anastasia",
			custom_background = "jail",
			tags = ['dialogue_scene'],
			text = [
				{text = "ANASTASIA_PERSUASION_2_MARRY2_1", reqs = [], previous_dialogue_option = 2},
				{text = "ANASTASIA_PERSUASION_2_MARRY2", reqs = []},
				{text = "", reqs = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}], previous_dialogue_option = 1, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'},{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
				{text = "", reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 5}], previous_dialogue_option = 2, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'},{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
				{text = "", reqs = [], previous_dialogue_option = 3, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
			],
			options = [
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_MARRY2_OPTION1",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 1,
				},
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_MARRY2_OPTION2",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 2,
				},
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_MARRY2_OPTION3",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 3,
				},
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_MARRY2_OPTION4",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 4,
				},
			],
		},

		{
			reqs = [{type = 'decision', value = 'enslave_option', check = true}],
			image = null,
			character = "anastasia",
			custom_background = "jail",
			tags = ['dialogue_scene'],
			text = [
				{text = "", reqs = [], previous_dialogue_option = 1,
				bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
				{text = "ANASTASIA_PERSUASION_2_ENSLAVE2", reqs = []},
				{text = "ANASTASIA_PERSUASION_2_ENSLAVE2_1", reqs = [], previous_dialogue_option = 4},
			],
			options = [
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION1",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 1,
				},
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION2",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 2,
				},
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION3",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 3,
				},
				{
					code = 'princess_persuation_2_2_3',
					text = "ANASTASIA_PERSUASION_2_ENSLAVE2_OPTION4",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 4,
				},
			],
		},

		]

	},

	princess_persuation_2_2_3 = {
		variations = [{
			reqs = [{type = 'decision', value = 'marry_option', check = true}],
			image = null,
			character = "anastasia",
			custom_background = "jail",
			tags = ['dialogue_scene'],
			text = [
				{text = "", reqs = []},
				{text = "", reqs = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 3}], previous_dialogue_option = 1, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'},{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
				{text = "", reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 4}], previous_dialogue_option = 2, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'},{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
				{text = "", reqs = [], previous_dialogue_option = 4, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
			],
			options = [
				{
					code = 'princess_persuation_2_3',
					text = "DIALOGUECONTINUE",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 1,
				},
			],
		},

		{
			reqs = [{type = 'decision', value = 'enslave_option', check = true}],
			image = null,
			character = "anastasia",
			custom_background = "jail",
			tags = ['dialogue_scene'],
			text = [
				{text = "", reqs = []},
				{text = "", reqs = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 4}], previous_dialogue_option = 1, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'},{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
				{text = "", reqs = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}], previous_dialogue_option = 2, bonus_effects = [{code = 'dialogue_counter', name = 'sympathy2', op = '+'},{code = 'dialogue_counter', name = 'sympathy2', op = '+'}]},
			],
			options = [
				{
					code = 'princess_persuation_2_3',
					text = "DIALOGUECONTINUE",
					type = 'next_dialogue',
					reqs = [],
					dialogue_argument = 1,
				},
			],
		},

		]

	},



	princess_persuation_2_3 = {
		variations = [
			{
				reqs = [
					{type = 'local_counter', name = 'sympathy2', add_stat = 'sexuals_factor', operant = 'gte', value = 11, check = true},
					{type = 'decision', value = 'marry_option', check = true}],
				image = null,
				character = "anastasia",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_53", reqs = []},
					{text = "ANASTASIA_ACCEPT_MARRY", reqs = []}, #req same as variation's
					{text = "ANASTASIA_PERSUASION_57", reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = true}]},
				],
				options = [
					{
						code = 'princess_persuation_2_amelia',
						text = "DIALOGUECONTINUE",
						reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = true}],
						type = 'next_dialogue',
						dialogue_argument = 1,
						bonus_effects = [{code = 'decision', value = 'persuade_2_completed'}]
					},
					{
						code = 'princess_recriut_finish_1',
						text = "DIALOGUECONTINUE",
						reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = false}],
						type = 'next_dialogue',
						dialogue_argument = 1,
						bonus_effects = [{code = 'decision', value = 'persuade_2_completed'}]
					},
				],
			},
			{
				reqs = [
					{type = 'local_counter', name = 'sympathy2', add_stat = 'charm_factor', operant = 'gte', value = 8, check = true},
					{type = 'decision', value = 'enslave_option', check = true}],
				image = null,
				character = "anastasia",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_53", reqs = []},
					{text = "ANASTASIA_ACCEPT_ENSLAVE", reqs = []}, #req same as variation's
					{text = "ANASTASIA_PERSUASION_57", reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = true}]},
				],
				options = [
					{
						code = 'princess_persuation_2_amelia',
						text = "DIALOGUECONTINUE",
						reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = true}],
						type = 'next_dialogue',
						dialogue_argument = 1,
						bonus_effects = [{code = 'decision', value = 'persuade_2_completed'}]
					},
					{
						code = 'princess_recriut_finish_1',
						text = "DIALOGUECONTINUE",
						reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = false}],
						type = 'next_dialogue',
						dialogue_argument = 1,
						bonus_effects = [{code = 'decision', value = 'persuade_2_completed'}]
					},
				],
			},
			{
				reqs = [], #failcase, abusing current variation selection in imm. should be last variation!
				image = null,
				character = "anastasia",
				custom_background = "jail",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "ANASTASIA_PERSUASION_53", reqs = []},
					{text = "ANASTASIA_PERSUASION_54", reqs = []},
				],
				options = [
					{
						code = 'princess_persuation_2_fail',
						text = "DIALOGUECONTINUE",
						reqs = [],
						type = 'next_dialogue',
						dialogue_argument = 1,
						bonus_effects = [{code = 'decision', value = 'AnastasiaRejected'}] #this decision for some reason not added onto first persuation fail
					},
				],
			},
		]
	},
	princess_persuation_2_amelia = {
		image = null,
		custom_background = "jail",
		character = "anastasia",
		character2 = "amelia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ANASTASIA_PERSUASION_58", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_finish_1',
				text = "DIALOGUELEAVE",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 1,
			},
		],
	},
	princess_recriut_finish_1 = {
		image = null,
		custom_background = "jail",
		character = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_59", reqs = []},
		],
		options = [
			{
				code = 'princess_recriut_finish_2',
				text = "ANASTASIA_PERSUASION_OPTION_43",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 1,
			},
			{
				code = 'princess_recriut_finish_2',
				text = "ANASTASIA_PERSUASION_OPTION_44",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 2,
			},
			{
				code = 'princess_recriut_finish_2',
				text = "ANASTASIA_PERSUASION_OPTION_45",
				reqs = [],
				type = 'next_dialogue',
				dialogue_argument = 3,
			},
		],
	},
	princess_recriut_finish_2 = {
		image = null,
		custom_background = "jail",
		character = "amelia",
		tags = ['dialogue_scene'],
		text = [
			{text = "ANASTASIA_PERSUASION_60", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_PERSUASION_61", reqs = [], previous_dialogue_option = 2},
			{text = "ANASTASIA_PERSUASION_62", reqs = [], previous_dialogue_option = 3},
			{text = "ANASTASIA_PERSUASION_63", reqs = [],},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				bonus_effects = [{code = 'add_timed_event', value = 'princess_declaration_1', args = [{type = 'add_to_date', date = [3,3], hour = 1}]}, {code = 'update_city'}, {code = 'complete_quest', value = 'princess_persuasion'}],
				dialogue_argument = 1,
			},
		],
	},


	#testing scenes
	princess_recriut_good_setup = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "DIALOGUECONTINUE", reqs = [], previous_dialogue_option = 0, bonus_effects = [
				{code = 'decision', value = 'mindbreak_enabled'},
				{code = 'decision', value = 'marry_option'},
				{code = 'decision', value = 'enslave_option'},
				{code = 'decision', value = 'enslave_bracelet'},
				{code = 'decision', value = 'aire_is_saved'},
				{code = 'decision', value = 'AireAnastasiaPersuasionAgree'},
				{code = 'decision', value = 'persuade_1_completed'},
				{code = 'decision', value = 'has_bracelet'},
			]},
		],
		options = [
			{
				code = 'princess_persuation_init',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
			},
			{
				code = 'princess_persuation_2_init',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
			},
		],
	},
	princess_recriut_bad_setup = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "DIALOGUECONTINUE", reqs = [], previous_dialogue_option = 0, bonus_effects = [
				{code = 'decision', value = 'mindbreak_enabled'},
				{code = 'decision', value = 'marry_option'},
				{code = 'decision', value = 'enslave_option'},
				{code = 'decision', value = 'aire_raped'},
				{code = 'decision', value = 'AireAnastasiaPersuasionAgree'},
			]},
		],
		options = [
			{
				code = 'princess_persuation_init',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
			},
			{
				code = 'princess_persuation_2_init',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 0,
			},
		],
	},

}
