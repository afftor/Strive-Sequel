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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_declaration_4',
				text = "ANASTASIA_DECLARATION_OPTION_2",
				type = 'next_dialogue',
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
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
		],
	},
	final_words_1 = {
		image = null,
		character = "duncan",
		character2 = "sigmund",
		tags = ['dialogue_scene','blackscreen_transition_common'],
		text = [
			{text = "FINAL_WORDS_1", reqs = []},
			{text = "", reqs = [], bonus_effects = [
				{code = 'make_story_character', value = 'Anastasia'}]
			},
			{text = "", reqs = [{type = 'decision', value = 'bracelet_returned', check = true}], bonus_effects = [{code = 'add_item', item = 'anastasia_bracelet', number = 1}]},
			{text = "", reqs = [{type = 'decision', value = 'AireAnastasiaPersuasion', check = true}], bonus_effects = [
				{code = 'make_story_character', value = 'Aire'}]
			},
			{text = '', reqs = [{type = 'decision', value = 'mindbreak_completed', check = true}], bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'wits_factor', operant = '=', value = 1},
					{code = 'wits', operant = '=', value = 3},
					{code = 'charm', operant = '=', value = 8},
					{code = 'consent', operant = '=', value = 200},
					]
				},
				]
			}
		],
		options = [
			{
				code = 'final_words_2',
				text = "FINAL_WORDS_OPTION_1", 
				reqs = [], 
				type = 'next_dialogue',
				dialogue_argument = 1,
			},
			{
				code = 'final_words_2',
				text = "FINAL_WORDS_OPTION_2", 
				reqs = [], 
				type = 'next_dialogue',
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
				code = 'princess_cutscene_init',
				text = "DIALOGUECLOSE", 
				reqs = [], 
				type = 'next_dialogue',
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
					{text = "AFTER_ELECTION_PRINCESS_2", reqs = [{type = 'decision', value = 'marry_option', check = true}]},
					{text = "AFTER_ELECTION_PRINCESS_3", reqs = [{type = 'decision', value = 'enslave_option', check = true}]},
				],
				options = [
					{
						code = 'princess_cutscene_good_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_1", 
						reqs = [{type = 'decision', value = 'marry_option', check = true}], 
						type = 'next_dialogue',
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_exit_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_2", 
						reqs = [{type = 'decision', value = 'enslave_option', check = true}], 
						type = 'next_dialogue',
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_bad_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_3", 
						reqs = [{type = 'decision', value = 'marry_option', check = true}], 
						type = 'next_dialogue',
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_bad_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_4", 
						reqs = [{type = 'decision', value = 'enslave_option', check = true}], 
						type = 'next_dialogue',
						dialogue_argument = 1,
					},
					{
						code = 'princess_cutscene_exit_2',
						text = "AFTER_ELECTION_PRINCESS_OPTION_5", 
						type = 'next_dialogue',
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
						type = 'next_dialogue',
						reqs = [],
						dialogue_argument = 2,
						change_dialogue_type = 2
					},
					{
						code = 'close',
						text = "AFTER_ELECTION_PRINCESS_OPTION_9", 
						type = 'next_dialogue',
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
				type = 'next_dialogue',
				reqs = [], 
				dialogue_argument = 1,
			},
			{
				code = 'close',
				text = "AFTER_ELECTION_PRINCESS_6", 
				type = 'next_dialogue',
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
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},
	princess_sex_good_1 = {
		image = null,
		custom_background = "anastasia_sex_1",
		common_effects = [],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene','blackscreen_transition_common'],
		text = [{text = "AFTER_ELECTION_PRINCESS_8", reqs = []},
		
			{text = '', reqs = [], bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'loyalty', operant = '+', value = 25},
					{code = 'vaginal_virgin', operant = '=', value = false},
					]},
				{code = 'decision', value = 'anstasia_sex_scene'},
				]
				}
		],
		options = [
			{
				code = 'princess_sex_good_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
				type = 'next_dialogue',
				reqs = [], 
				dialogue_argument = 1,
			},
			{
				code = 'close',
				text = "AFTER_ELECTION_PRINCESS_OPTION_7", 
				type = 'next_dialogue',
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
				type = 'next_dialogue',
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
		tags = ['dialogue_scene','blackscreen_transition_common'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_15", reqs = [], previous_dialogue_option = 1},
			{text = "AFTER_ELECTION_PRINCESS_18", reqs = [], previous_dialogue_option = 2},
			{text = '', reqs = [], bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'submission', operant = '+', value = 25},
					{code = 'vaginal_virgin', operant = '=', value = false},
				]},
				{code = 'decision', value = 'anstasia_rape_scene'},
				],
			}
			
			
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				change_dialogue_type = 1,
				reqs = [],
			}
		],
	},
	
	aire_anastasia1 = {
		image = null,
		custom_background = "anastasia_aire1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "SCENEWIP", reqs = []}],
		options = [
			{
				code = 'aire_anastasia2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	aire_anastasia2 = {
		image = null,
		custom_background = "anastasia_aire2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "SCENEWIP", reqs = []}],
		options = [
			{
				code = 'aire_anastasia3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	aire_anastasia3 = {
		image = null,
		custom_background = "anastasia_aire3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "SCENEWIP", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1,
			}
		],
	},
	
	amelia_titjob1 = {
		image = null,
		custom_background = "amelia_titjob1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "SCENEWIP", reqs = []}],
		options = [
			{
				code = 'amelia_titjob2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	amelia_titjob2 = {
		image = null,
		custom_background = "amelia_titjob2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "SCENEWIP", reqs = []}],
		options = [
			{
				code = 'amelia_titjob3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	amelia_titjob3 = {
		image = null,
		custom_background = "amelia_titjob3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "SCENEWIP", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1,
			}
		],
	},
	
}
