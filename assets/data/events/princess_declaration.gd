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
		common_effects = [
			
		],
		options = [
			{
				code = 'final_words_1',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'decision', value = 'anastasia_added'}]
			},
		],
	},
	final_words_1 = {
		image = null,
		character = "duncan",
		character2 = "sigmund",
		tags = ['dialogue_scene','blackscreen_transition_common'],
		common_effects = [ # events after finishing act 1 act_1
			{code = 'add_timed_event', value = "amelia_herbs_start",
			args = [{type = 'add_to_date', date = [1,1], hour = 1}]}, 
		
			{code = 'add_timed_event', value = "zephyra_recruitment_letter",
			args = [{type = 'add_to_date', date = [2,2], hour = 1}]}, 

			{code = 'add_timed_event', value = "zephyra_sword_1",
			args = [{type = 'add_to_date', date = [2,2], hour = 1}]},
			
			{code = "decision", value = "mayor_election_finished"}
		],
		text = [
			{text = "FINAL_WORDS_1", reqs = []},
			{text = "", reqs = [{type = 'decision', value = 'anastasia_added', check = true}, {type = 'decision', value = 'mindbreak_completed', check = false}], bonus_effects = [
				{code = 'make_story_character', value = 'Anastasia'}]
			}, 
			{text = "", reqs = [{type = 'decision', value = 'anastasia_added', check = true}, {type = 'decision', value = 'mindbreak_completed', check = true}], bonus_effects = [
				{code = 'make_story_character', value = 'AnastasiaBroken'}]
			}, # broken part
			{text = "", reqs = [{type = 'decision', value = 'anastasia_added', check = true}, {type = 'decision', value = 'mindbreak_completed', check = true}, {type = 'decision', value = 'bracelet_returned', check = true}], bonus_effects = [{code = 'unique_character_changes',
					value = 'anastasiaBroken',
					args = [
						{code = 'create_and_equip', item = "anastasia_broken_bracelet", parts = {}}
						],
			}] # broken part
			},
			{text = "", reqs = [{type = 'decision', value = 'bracelet_returned', check = true},{type = 'decision', value = 'anastasia_added', check = true}, {type = 'decision', value = 'mindbreak_completed', check = false}], bonus_effects = [{code = 'unique_character_changes',
					value = 'anastasia',
					args = [
						{code = 'create_and_equip', item = "anastasia_bracelet", parts = {}}
						],
			},]},
			{text = "", reqs = [
					{type = 'decision', value = 'AireAnastasiaPersuasion', check = true},
					{type = 'decision', value = 'persuade_2_completed', check = true},
				], bonus_effects = [
				{code = 'make_story_character', value = 'Aire'}]
			},
			{text = '', reqs = [{type = 'decision', value = 'mindbreak_completed', check = true}], bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [ # broken part
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
				code = 'princess_cutscene_init',
				text = "DIALOGUECLOSE",
				reqs = [{type = 'decision', value = 'anastasia_added', check = true}],
				type = 'next_dialogue',
				dialogue_argument = 1,
				bonus_effects = [{code = 'update_city'}],
			},
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				reqs = [{type = 'decision', value = 'anastasia_added', check = false}],
				type = 'next_dialogue',
				dialogue_argument = 1,
				bonus_effects = [{code = 'update_city'}, {code = 'rewrite_save'}],
			},
		],
	},
#	final_words_2 = {
#		image = null,
#		tags = ['dialogue_scene'],
#		text = [
#			{text = "FINAL_WORDS_2", reqs = [],},
#		], 
#		common_effects = [],
#		options = [
#			{
#				code = 'princess_cutscene_init',
#				text = "DIALOGUECLOSE",
#				reqs = [{type = 'decision', value = 'anastasia_added', check = true}],
#				type = 'next_dialogue',
#				dialogue_argument = 1,
#				bonus_effects = [{code = 'update_city'}],
#			},
#			{
#				code = 'close',
#				text = "DIALOGUECLOSE",
#				reqs = [{type = 'decision', value = 'anastasia_added', check = false}],
#				type = 'next_dialogue',
#				dialogue_argument = 1,
#				bonus_effects = [{code = 'update_city'}],
#			},
#		],
#	},
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
						# CONSENT
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
						# RAPE
						code = 'princess_cutscene_bad_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_3",
						reqs = [{type = 'decision', value = 'marry_option', check = true}],
						type = 'next_dialogue',
						dialogue_argument = 1,
					},
					{
						# RAPE
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
				character = "AnastasiaBroken",
				tags = ['dialogue_scene', 'master_translate'],
				text = [
#					{text = "AFTER_ELECTION_PRINCESS_17", reqs = []},
					{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_0", reqs = []},
				],
				options = [
					{
						# MINDBREAK
						code = 'princess_cutscene_mindbreak_1',
						text = "AFTER_ELECTION_PRINCESS_OPTION_8",
						type = 'next_dialogue',
						reqs = [],
						dialogue_argument = 2,
					},
					{
						code = 'close',
						text = "AFTER_ELECTION_PRINCESS_OPTION_9",
						type = 'next_dialogue',
						reqs = [],
						bonus_effects = [{code = 'rewrite_save'}], 
						dialogue_argument = 1,
					},
				],
			}
		]
	},
	
	
	princess_cutscene_mindbreak_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_1", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	princess_cutscene_mindbreak_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_2", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2,
			}
		],
	},
	
	princess_cutscene_mindbreak_3 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_3", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	princess_cutscene_mindbreak_4 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_4", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	princess_cutscene_mindbreak_5 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_5", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	princess_cutscene_mindbreak_6 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_6", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	princess_cutscene_mindbreak_7 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_7", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_mindbreak_8',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	princess_cutscene_mindbreak_8 = {
		image = null,
		custom_background = "anastasia_rape_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_MINDBREAK_8", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				reqs = [],
				bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'submission', operant = '+', value = 25},
					{code = 'vaginal_virgin', operant = '=', value = false},
				]},
				{code = 'decision', value = 'anastasia_rape'},
				{code = "update_city"},
				{code = 'rewrite_save'}
				]
			}
		],
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
				bonus_effects = [{code = 'rewrite_save'}], 
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
				code = 'princess_cutscene_pre_sex_good_1',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
#				change_dialogue_type = 2
			}
		],
	},

#	princess_sex_good_1 = {
#		image = null,
#		custom_background = "anastasia_sex_1",
#		common_effects = [],
#		scene_type = "ero_scene",
#		save_scene_to_gallery = true,
#		tags = ['dialogue_scene','blackscreen_transition_common'],
#		text = [{text = "AFTER_ELECTION_PRINCESS_8", reqs = []},
#
#			{text = '', reqs = [], bonus_effects = [
#				{code = 'unique_character_changes', value = 'anastasia', args = [
#					{code = 'loyalty', operant = '+', value = 25},
#					{code = 'vaginal_virgin', operant = '=', value = false},
#					]},
#				{code = 'decision', value = 'anstasia_sex_scene'},
#				]
#				}
#		],
#		options = [
#			{
#				code = 'princess_sex_good_2',
#				text = "DIALOGUECONTINUE",
#				type = 'next_dialogue',
#				reqs = [],
#				dialogue_argument = 1,
#			}
#		],
#	},
	
	princess_cutscene_pre_sex_good_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_CONSENT_1", reqs = []},
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
	
	# unused. Needed for test_scene?
	princess_sex_good_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_2", reqs = []},

#			{text = '', reqs = [], bonus_effects = [
#				{code = 'unique_character_changes', value = 'anastasia', args = [
#					{code = 'loyalty', operant = '+', value = 25},
#					{code = 'vaginal_virgin', operant = '=', value = false},
#					]},
#				{code = 'decision', value = 'anstasia_sex_scene'},
#				]
#				}
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
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_2", reqs = []}],
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
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_3", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_sex_good_4 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_4", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},
	princess_sex_good_5 = {
		image = null,
		custom_background = "anastasia_sex_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_5", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_sex_good_6 = {
		image = null,
		custom_background = "anastasia_sex_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_6", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	princess_sex_good_7 = {
		image = null,
		custom_background = "anastasia_sex_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_7", reqs = []}],
		options = [
			{
				code = 'princess_sex_good_8',
				text = "AFTER_ELECTION_PRINCESS_CONSENT_OPTION_1",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			},
			{
				code = 'princess_sex_good_8',
				text = "AFTER_ELECTION_PRINCESS_CONSENT_OPTION_2",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 2,
			},
			{
				code = 'princess_sex_good_8',
				text = "AFTER_ELECTION_PRINCESS_CONSENT_OPTION_3",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 3,
			}
		],
	},
	princess_sex_good_8 = {
		image = null,
		custom_background = "anastasia_sex_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "AFTER_ELECTION_PRINCESS_CONSENT_REPLY_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_ELECTION_PRINCESS_CONSENT_REPLY_2", reqs = [], previous_dialogue_option = 2},
		{text = "AFTER_ELECTION_PRINCESS_CONSENT_REPLY_3", reqs = [], previous_dialogue_option = 3}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'loyalty', operant = '+', value = 25},
					{code = 'vaginal_virgin', operant = '=', value = false},
					]},
				{code = 'decision', value = 'anstasia_sex_scene'},
				{code = "update_city"},
				{code = 'rewrite_save'}
				]
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
				bonus_effects = [{code = 'update_city'}, {code = 'rewrite_save'}],
			}
		],
	},
	princess_cutscene_exit_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_16_OLD", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [{code = 'update_city'}, {code = 'rewrite_save'}],
			}
		],
	},
	# rape
	princess_cutscene_bad_1 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_13", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_bad_pre_2',
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
				bonus_effects = [{code = 'rewrite_save'}], 
			},
		],
	},
	princess_cutscene_bad_pre_2 = {
		image = null,
		character = "anastasia",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_PRE_14", reqs = []},
		],
		options = [
			{
				code = 'princess_cutscene_bad_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
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
#				change_dialogue_type = 2
			}
		],
	},
	princess_sex_bad_1 = {
		image = null,
		tags = ['dialogue_scene'],
		character = "anastasia",
		text = [
			{text = "AFTER_ELECTION_PRINCESS_15", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_bad_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				reqs = [],
			}
		],
	},

	princess_sex_bad_2 = {
		image = null,
		tags = ['dialogue_scene'],
		character = "anastasia",
		text = [
			{text = "AFTER_ELECTION_PRINCESS_16", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_bad_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				change_dialogue_type = 2,
				dialogue_argument = 1,
				reqs = [],
			}
		],
	},

	princess_sex_bad_3 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene','blackscreen_transition_common'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_17", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_bad_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				reqs = [],
			}
		],
	},

	princess_sex_bad_4 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_18", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_bad_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				reqs = [],
			}
		],
	},

	princess_sex_bad_5 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_19", reqs = []},
		],
		options = [
			{
				code = 'princess_sex_bad_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				reqs = [],
			}
		],
	},

	princess_sex_bad_6 = {
		image = null,
		custom_background = "anastasia_rape_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
			{text = "AFTER_ELECTION_PRINCESS_20", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				dialogue_argument = 1,
				reqs = [],
				bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'submission', operant = '+', value = 25},
					{code = 'vaginal_virgin', operant = '=', value = false},
				]},
				{code = 'decision', value = 'anastasia_rape'},
				{code = "update_city"},
				{code = 'rewrite_save'}, 
				]
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
				bonus_effects = [{code = 'update_city'}],
			}
		],
	},
}
