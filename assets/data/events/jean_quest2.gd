extends Reference
var data = {
	jean_q2_start = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_RUINS_SQ_1",
		options = [{code = 'jean_q2_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_1 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_RUINS_SQ_2",
		options = [{code = 'jean_q2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_RUINS_SQ_21", 
		options = [
			{code = 'jean_q2_4', text = "JEAN_RUINS_SQ_21_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_4', text = "JEAN_RUINS_SQ_21_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}
		],
	},
	jean_q2_4 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_RUINS_SQ_22", 
		options = [
			{code = 'jean_q2_5', text = "JEAN_RUINS_SQ_OPT_HELP", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_5', text = "JEAN_RUINS_SQ_OPT_USEFUL", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	jean_q2_5 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = [
			{text = "JEAN_RUINS_SQ_3_KIND", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_RUINS_SQ_3_RUDE", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'jean_q2_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', previous_dialogue_option = 1},
			{code = 'jean_q2_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', previous_dialogue_option = 2},
		],
	},
	jean_q2_6 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = [
			{text = "JEAN_RUINS_SQ_4_KIND", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_RUINS_SQ_4_RUDE", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_RUINS_SQ_4_MYR", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = 'jean_q2_6', text = "JEAN_RUINS_SQ_OPT_MYR", reqs = [], dialogue_argument = 3, type = 'next_dialogue', remove_after_first_use = true},
			{code = 'jean_q2_church_agree', text = "JEAN_RUINS_SQ_OPT_CHURCH", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}
		],
	},
	jean_q2_church_agree = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_RUINS_SQ_5", 
		common_effects = [
			{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage1'},
			{code = 'update_city'}
			],
		options = [{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,}],
	},
	
	jean_q2_church = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'ginny',
		character2 = 'jean',
		text = "JEAN_Q2_CHURCH_ENTER",
		options = [{code = 'jean_q2_church_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_church_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'ginny',
		character2 = 'jean',
		text = "JEAN_Q2_CHURCH_2", 
		options = [{code = 'jean_q2_church_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_church_3 = {
		image = null, 
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		character = 'ginny',
		character2 = 'jean',
		text = [
			{text = "JEAN_Q2_CHURCH_3_ARTIFACT", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_DEMON_WARN", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_Q2_DEMON_INFO", reqs = [], previous_dialogue_option = 3},
			],
		options = [
			{code = 'jean_q2_church_3', text = "JEAN_Q2_CHURCH_4_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true}, 
			{code = 'jean_q2_church_3', text = "JEAN_Q2_CHURCH_4_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue', remove_after_first_use = true}, 
			{code = 'jean_q2_crossref_1', text = "JEAN_Q2_CHURCH_4_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}
		],
	},
	jean_q2_crossref_1 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'ginny',
		character2 = 'jean',
		text = "JEAN_Q2_CROSSREF_1", 
		options = [{code = 'jean_q2_crossref_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_crossref_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'ginny',
		character2 = 'jean',
		text = "JEAN_Q2_CROSSREF_2", 
		options = [{code = 'jean_q2_library', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_library = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'ginny',
		character2 = 'jean',
		text = "JEAN_Q2_LIBRARY",
		options = [
			{
				code = 'close', 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage2'},
					{code = 'update_city'},
#					{code = 'unique_character_changes', value = 'jean', args = [{code = 'assign_task', task = 'church_library_study'}]},
				],
			}
		],
	},
	
	jean_q2_research_done = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		text = "JEAN_Q2_RESEARCH_DONE", 
		options = [
			{
				code = 'close', 
				text = "DIALOGUECLOSE", 
				reqs = [], 
				dialogue_argument = 1,
				bonus_effects = [
					{code = 'make_quest_location', value = 'quest_jean_ruins_location'},
					{code = 'progress_quest', value = 'jean_ruins_quest', stage = 'stage3'}
				],
			}
		],
	},
	jean_q2_ruins_approach = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		text = "JEAN_Q2_RUINS_APPROACH", 
		options = [{code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,}],
	},
	
	jean_q2_central_hall = {
		image = 'jean_rynn_prisoner',  
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CENTRAL_HALL",
		options = [{code = 'jean_q2_central_hall_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_central_hall_2 = {
		image = 'jean_overseer', 
		tags = ['dialogue_scene'], 
		reqs = [],
		text = "JEAN_Q2_HALL_FIGURE",
		options = [{code = 'quest_fight', args = 'jean_ruins_monsters_1', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_after_fight = {
		image = 'jean_rynn_prisoner', 
		tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "JEAN_Q2_AFTER_FIGHT", reqs = []}],
		options = [
			{code = 'jean_q2_path_a', text = "JEAN_Q2_CHOICE_FREE_RYNN", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = "decision", value = "jean_q2_rynn_save"}]}, 
			{code = 'jean_q2_path_b', text = "JEAN_Q2_CHOICE_PURSUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	
	jean_q2_path_a = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_FREE_RYNN_1",
		options = [{
			code = 'jean_q2_rynn_1', text = "JEAN_Q2_FREE_RYNN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'jean_q2_rynn_1', text = "JEAN_Q2_FREE_RYNN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},
	jean_q2_rynn_1 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = [
			{text = "JEAN_Q2_RYNN_REPRIMAND", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_RYNN_GLAD", reqs = [], previous_dialogue_option = 2},
		],
		options = [{
			code = 'jean_q2_rynn_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},
	jean_q2_rynn_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_RYNN_HOW_FOUND",
		options = [{code = 'jean_q2_rynn_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_3 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_RYNN_HOW_FOUND_3",
		options = [{code = 'jean_q2_rynn_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_4 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_RYNN_CAMP_SETUP", 
		options = [{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	
	jean_q2_path_b = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_PURSUE_PAST_RYNN", 
		options = [{code = 'jean_q2_path_b_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_path_b_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_PURSUE_JEAN_DOUBTS", 
		options = [{code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	
	jean_q2_lab_1 = {
		variations = [
			{
				image = null, 
				tags = ['dialogue_scene'], 
				reqs = [{type = "decision", value = "jean_q2_rynn_save", check = true}], 
				character = 'jean',
				text = "JEAN_Q2_LAB_ESCAPED",
				options = [{code = 'jean_q2_lab_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
			},
			{
				image = 'jean_overseer', 
				tags = ['dialogue_scene'], 
				reqs = [{type = "decision", value = "jean_q2_rynn_save", check = false}], 
				text = "JEAN_Q2_BOSS_FIGHT_INTRO_1",
				options = [{code = 'jean_q2_boss_intro_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
			},
		]
	},
	jean_q2_boss_intro_2 = {
		image = 'jean_overseer', 
		tags = ['dialogue_scene'], 
		reqs = [],
		text = "JEAN_Q2_BOSS_FIGHT_INTRO_2", 
		options = [{code = 'quest_fight', args = 'jean_ruins_boss_fight', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_capture_figure_1 = {
		image = 'jean_interrogation', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTURE_FIGURE_1",
		options = [{code = 'jean_q2_capture_figure_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_capture_figure_2 = {
		image = 'jean_interrogation', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTURE_FIGURE_2",
		options = [{code = 'jean_q2_interrogate', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_interrogate = {
		image = 'jean_interrogation', 
		tags = ['dialogue_scene'], 
		reqs = [],
		text = [
			{text = "JEAN_Q2_CAPTURE_FIGURE_3", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_INTERROGATE_WHO", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_Q2_INTERROGATE_MASTERLOC", reqs = [], previous_dialogue_option = 3},
			],
		options = [
			{code = 'jean_q2_interrogate_who', text = "JEAN_Q2_INTERROGATE_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', remove_after_first_use = true,}, 
			{code = 'jean_q2_interrogate_master', text = "JEAN_Q2_INTERROGATE_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue',remove_after_first_use = true,}, 
			{code = 'jean_q2_interrogate_full', text = "JEAN_Q2_INTERROGATE_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_interrogate_full = {
		image = 'jean_interrogation', 
		tags = ['dialogue_scene'], 
		reqs = [],
		text = "JEAN_Q2_INTERROGATE_FULL_1",
		options = [{code = 'jean_q2_lab_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}],
	},
	jean_q2_lab_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = [
			{text = "JEAN_Q2_LAB_SEARCH", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_INTERROGATE_FULL_2", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_Q2_LAB_CONCLUDE", reqs = []},
		],
		options = [
			{code = 'jean_q2_lab_react', text = "JEAN_Q2_LAB_OPTION_LET", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_lab_press_1', text = "JEAN_Q2_LAB_OPTION_PRESS", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	jean_q2_lab_press_1 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_LAB_REACT_PRESS_1",
		options = [{code = 'jean_q2_lab_press_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_lab_press_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_LAB_REACT_PRESS_2",
		options = [{code = 'jean_q2_lab_react', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}],
	},
	jean_q2_lab_react = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = [
			{text = "JEAN_Q2_LAB_REACT_LET", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_LAB_REACT_PRESS_3", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_Q2_LAB_REACT", reqs = []},
		],
		options = [{code = 'jean_q2_lab_react', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}],
	},
	jean_q2_burn_lab_1 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_LAB_REACT_PRESS",
		options = [
			{code = 'jean_q2_burn_lab_2', text = "JEAN_Q2_LAB_BURN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_burn_lab_2', text = "JEAN_Q2_LAB_BURN_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}
		],
	},
	jean_q2_burn_lab_2 = {
		image = null, 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = [
			{text = "JEAN_Q2_BURN_LAB", reqs = []},
			{text = "JEAN_Q2_BURN_LAB_RYNN", reqs = [{type = "decision", value = "jean_q2_rynn_save", check = false}]},
		],
		options = [
			{
				code = 'jean_q2_rynn_camp_return', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = "decision", value = "jean_q2_rynn_save", check = true}], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
			},
			{
				code = 'jean_q2_rynn_camp_return_captive', 
				text = "DIALOGUECONTINUE", 
				reqs = [{type = "decision", value = "jean_q2_rynn_save", check = false}], 
				dialogue_argument = 1, 
				type = 'next_dialogue',
			},
		],
	},
	
	jean_q2_rynn_camp_return = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_RYNN_CAMP_RETURN",
		options = [
			{code = 'jean_q2_rynn_fever_1', text = "JEAN_Q2_RYNN_CAMP_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_rynn_fever_1', text = "JEAN_Q2_RYNN_CAMP_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	jean_q2_rynn_fever_1 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = [
			{text = "JEAN_Q2_RYNN_FEVER_1_1", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_RYNN_FEVER_1_2", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_Q2_RYNN_FEVER_1", reqs = []}
		],
		options = [
			{code = 'jean_q2_rynn_fever_2', text = "JEAN_Q2_RYNN_FEVER_ASK_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_rynn_fever_2', text = "JEAN_Q2_RYNN_FEVER_ASK_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	jean_q2_rynn_fever_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = [
			{text = "JEAN_Q2_RYNN_FEVER_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_RYNN_FEVER_2_2", reqs = [], previous_dialogue_option = 2}
		],
		options = [{code = 'jean_q2_rynn_fever_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_fever_3 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_RYNN_FEVER_3",
		options = [
			{code = 'jean_q2_rynn_voice_push', text = "JEAN_Q2_RYNN_PUSH_TELL_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_rynn_voice_push', text = "JEAN_Q2_RYNN_PUSH_TELL_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	jean_q2_rynn_voice_push = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = [
			{text = "JEAN_Q2_RYNN_VOICE_PUSH_1", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_RYNN_VOICE_PUSH_2", reqs = [], previous_dialogue_option = 2},
			{text = "JEAN_Q2_RYNN_OVERHEARD", reqs = []}
		],
		options = [{code = 'jean_q2_curse_reveal_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_curse_reveal_1 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_CURSE_REVEAL_1",
		options = [{code = 'jean_q2_curse_reveal_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_curse_reveal_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_CURSE_REVEAL_2",
		options = [{code = 'jean_q2_curse_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_curse_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_CURSE_2",
		options = [{
			code = 'jean_q2_curse_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},
	jean_q2_curse_3 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_CURSE_3", 
		options = [{
			code = 'jean_q2_curse_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},
	jean_q2_curse_4 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = "JEAN_Q2_CURSE_4", 
		options = [{
			code = 'jean_q2_curse_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},
	
	jean_q2_rynn_camp_return_captive = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_OUTSIDE_1", 
		options = [{code = 'jean_q2_rynn_camp_return_captive_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_OUTSIDE_2", 
		options = [{code = 'jean_q2_rynn_camp_return_captive_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_3 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_OUTSIDE_3", 
		options = [{code = 'jean_q2_rynn_camp_return_captive_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_4 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_OUTSIDE_4", 
		options = [{code = 'jean_q2_rynn_camp_return_captive_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_5 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_OUTSIDE_5", 
		options = [{code = 'jean_q2_rynn_camp_return_captive_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_6 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_OUTSIDE_6", 
		options = [
			{code = 'jean_q2_rynn_camp_return_captive_free_1', text = "JEAN_Q2_CAPTIVE_OPTION_FREE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'jean_q2_rynn_camp_return_captive_jail', text = "JEAN_Q2_CAPTIVE_OPTION_JAIL", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'jean_q2_rynn_camp_return_captive_kill_1', text = "JEAN_Q2_CAPTIVE_OPTION_KILL", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	jean_q2_rynn_camp_return_captive_free_1 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_FREE_1", 
		options = [
			{code = 'jean_q2_rynn_camp_return_captive_free_2', text = "JEAN_Q2_CAPTIVE_FREE_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'jean_q2_rynn_camp_return_captive_free_2', text = "JEAN_Q2_CAPTIVE_FREE_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	jean_q2_rynn_camp_return_captive_free_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_FREE_2", 
		common_effects = [{code = 'decision', value = 'jean_q2_captive_free'}],
		options = [{code = 'jean_q2_rynn_camp_return_captive_finale', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_jail = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_JAIL", 
		common_effects = [{code = 'decision', value = 'jean_q2_captive_jail'}],
		options = [{code = 'jean_q2_rynn_camp_return_captive_finale', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_kill_1 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_KILL_1", 
		options = [
			{code = 'jean_q2_rynn_camp_return_captive_kill_2', text = "JEAN_Q2_CAPTIVE_KILL_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'jean_q2_rynn_camp_return_captive_kill_2', text = "JEAN_Q2_CAPTIVE_KILL_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		],
	},
	jean_q2_rynn_camp_return_captive_kill_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_KILL_2", 
		common_effects = [{code = 'decision', value = 'jean_q2_captive_kill'}],
		options = [{code = 'jean_q2_rynn_camp_return_captive_finale', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_rynn_camp_return_captive_finale = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_CAPTIVE_FINAL", 
		options = [{code = 'jean_q2_curse_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}],
	},
	
	jean_q2_curse_5 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
#		character2 = 'rynn',
		text = [
			{text = "JEAN_Q2_CURSE_FINAL_0", reqs = [], previous_dialogue_option = 1},
			{text = "JEAN_Q2_CURSE_FINAL", reqs = []}
		],
		options = [
			{code = 'jean_q2_save_rynn_1', text = "JEAN_Q2_RYNN_SAVE_OPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_leave_rynn_1', text = "JEAN_Q2_RYNN_LEAVE_OPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}
		],
	},
	jean_q2_save_rynn_1 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_saved_rynn'}],
		text = "JEAN_Q2_SAVE_RYNN_1",
		options = [{code = 'jean_q2_save_rynn_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_save_rynn_2 = {
		image = 'jean_rynn_wounded', 
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		text = [{text = "JEAN_Q2_SAVE_RYNN_2", reqs = []}],
		options = [{
			code = 'jean_q2_church_rynn_arrive', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}],
	},
	jean_q2_church_rynn_arrive = {
		image = null,
		tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [], 
		character = 'jean',
		character2 = 'jinny',
		text = "JEAN_Q2_CHURCH_RYNN_ARRIVE",
		options = [
			{code = 'jean_q2_church_rynn_2', text = "JEAN_Q2_CHURCH_RYNN_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}, 
			{code = 'jean_q2_church_rynn_2', text = "JEAN_Q2_CHURCH_RYNN_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',}
		],
	},
	jean_q2_church_rynn_2 = {
		image = null,
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		character2 = 'jinny',
		text = [{text = "JEAN_Q2_CHURCH_RYNN_2", reqs = []}],
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", 
			reqs = [], 
			dialogue_argument = 1,
			bonus_effects = [
				{code = 'complete_quest', value = 'jean_ruins_quest'},
				{code = 'decision', value = 'rynn_cursed_at_church'},
				{
					code = "add_timed_event",
					value = "jean_sylas_next_day_start",
					args = [{type = "add_to_date", date = [1,1], hour = 1}]
				},
			],
		}],
	},
	
	jean_q2_leave_rynn_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		reqs = [], 
		character = 'jean',
		common_effects = [{code = 'decision', value = 'jean_q2_abandoned_rynn'}],
		text = "JEAN_Q2_LEAVE_RYNN_1", 
		options = [{code = 'jean_q2_leave_rynn_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',}],
	},
	jean_q2_leave_rynn_2 = {
		image = null,
		tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [], 
		character = 'jean',
		text = "JEAN_Q2_LEAVE_RYNN_2", 
		options = [{
			code = 'close', 
			text = "DIALOGUECLOSE", 
			reqs = [], 
			dialogue_argument = 1,
			bonus_effects = [
				{code = 'complete_quest', value = 'jean_ruins_quest'},
				{
					code = "add_timed_event",
					value = "jean_sylas_next_day_start",
					args = [{type = "add_to_date", date = [1,1], hour = 1}]
				},
			],
		}],
	},
}
