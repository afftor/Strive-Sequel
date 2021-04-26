#decisions:
#anastasia_added

#previous decisions
#mindbreak_completed
#persuade_2_completed
#marry_proposed
#enslave_proposed

var data = {
	princess_declaration_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ANASTASIA_DECLARATION_1", reqs = [], previous_dialogue_option = 0},
		],
		options = [
			{
				code = 'princess_declaration_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_declaration_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ANASTASIA_DECLARATION_2", reqs = []},
		],
		options = [
			{
				code = 'princess_declaration_3',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_declaration_3 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ANASTASIA_DECLARATION_3", reqs = []},
		],
		options = [
			{
				code = 'princess_declaration_4',
				text = "ANASTASIA_DECLARATION_OPTION_1",
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_declaration_4',
				text = "ANASTASIA_DECLARATION_OPTION_2",
				reqs = [],
				dialogue_argument = 2,
			},
		],
	},
	princess_declaration_4 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "ANASTASIA_DECLARATION_4", reqs = [], previous_dialogue_option = 1},
			{text = "ANASTASIA_DECLARATION_5", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{
				code = 'final_words_1',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	final_words_1 = {
		image = null,
		character = "duncan",
		character2 = "sigmund",
		tags = ['dialogue_scene'],
		text = [
			{text = "FINAL_WORDS_1", reqs = []},
		],
		options = [
			{
				code = 'final_words_2',
				text = "FINAL_WORDS_OPTION_1", 
				reqs = [], 
				dialogue_argument = 1,
			},
			{
				code = 'final_words_2',
				text = "FINAL_WORDS_OPTION_2", 
				reqs = [], 
				dialogue_argument = 1,
			},
		],
	},
	final_words_2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "FINAL_WORDS_2", reqs = [],},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'anastasia_added'}]
			},
		],
	},
	#somewhere here should be recruit effects
	#my opinion is those should be at the close options to reflect char status changes (i'm not sure there are different templates for her though) 
	princess_cutscene_init = {
		variations = [
			{
				reqs = [{type = 'decision', value = 'persuade_2_completed', check = true}],
				image = null,
				character = "anastasia",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "AFTER_ELECTION_PRINCESS_1", reqs = []},
					{text = "AFTER_ELECTION_PRINCESS_2", reqs = [{type = 'decision', value = 'marry_proposed', check = true}]},
					{text = "AFTER_ELECTION_PRINCESS_3", reqs = [{type = 'decision', value = 'enslave_proposed', check = true}]},
				],
				options = [
					{
						code = 'princess_cutscene_good_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_1", 
						reqs = [{type = 'decision', value = 'marry_proposed', check = true}], 
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_exit_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_2", 
						reqs = [{type = 'decision', value = 'enslave_proposed', check = true}], 
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_bad_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_3", 
						reqs = [{type = 'decision', value = 'marry_proposed', check = true}], 
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_bad_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_4", 
						reqs = [{type = 'decision', value = 'enslave_proposed', check = true}], 
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_exit_2',
						text = "AFTER_ELECTION_PRINCESS_OPTION_5", 
						reqs = [], 
						dialogue_argument = 1,
					},
				],
			},
			{
				reqs = [{type = 'decision', value = 'mindbreak_completed', check = true}],
				image = null,
				character = "anastasia",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
					{text = "AFTER_ELECTION_PRINCESS_17", reqs = []},
				],
				options = [
					{
						code = 'princess_sex_bad_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_8",
						reqs = [],
						dialogue_argument = 2,
						change_dialogue_type = 2
					},
					{
						code = 'close',
						text = "AFTER_ELECTION_PRINCESS_OPTION_9", 
						reqs = [], 
						dialogue_argument = 1,
					},
				],
			}
		]
	},
	princess_cutscene_good_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_4", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_good_2',
				text = "AFTER_ELECTION_PRINCESS_5", 
				reqs = [], 
				dialogue_argument = 1,
			},
			{
				code = 'close',
				text = "AFTER_ELECTION_PRINCESS_6", 
				reqs = [], 
				dialogue_argument = 1,
			},
		],
	},
	princess_cutscene_good_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_7", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_good_1',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},
	princess_sex_good_1 = {
		image = null,
		custom_background = "anastasia_sex_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_8", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_2',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_sex_good_2 = {
		image = null,
		custom_background = "anastasia_sex_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_9", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_3',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_sex_good_3 = {
		image = null,
		custom_background = "anastasia_sex_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_10", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_4',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1
			}
		],
	},
	princess_sex_good_4 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_11", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_cutscene_exit_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_12", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_cutscene_exit_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_16", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_cutscene_bad_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_13", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_bad_2',
				text = "AFTER_ELECTION_PRINCESS_OPTION_6", 
				reqs = [], 
				dialogue_argument = 1,
			},
			{
				code = 'close',
				text = "AFTER_ELECTION_PRINCESS_OPTION_7", 
				reqs = [], 
				dialogue_argument = 1,
			},
		],
	},
	princess_cutscene_bad_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_14", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_bad_1',
				text = "DIALOGUECONTINUE",
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},
	princess_sex_bad_1 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_15", reqs = [], previous_dialogue_option = 1},
			{text = "AFTER_ELECTION_PRINCESS_18", reqs = [], previous_dialogue_option = 1}
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				dialogue_argument = 1,
				change_dialogue_type = 1,
				reqs = [],
			}
		],
	},
	
	#testing scenes
	princess_dec_good_setup = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "DIALOGUECONTINUE", reqs = [], previous_dialogue_option = 0, bonus_effects = [
				{code = 'decision', value = 'marry_proposed'},
				{code = 'decision', value = 'enslave_proposed'},
				{code = 'decision', value = 'persuade_2_completed'},
			]},
		],
		options = [
			{
				code = 'princess_declaration_1',
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 0,
			},
			{
				code = 'princess_cutscene_init',
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 0,
			},
		],
	},
	princess_dec_bad_setup = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
			{text = "DIALOGUECONTINUE", reqs = [], previous_dialogue_option = 0, bonus_effects = [
				{code = 'decision', value = 'mindbreak_completed'},
			]},
		],
		options = [
			{
				code = 'princess_declaration_1',
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 0,
			},
			{
				code = 'princess_cutscene_init',
				text = "DIALOGUECONTINUE", 
				reqs = [], 
				dialogue_argument = 0,
			},
		],
	},
	
}
