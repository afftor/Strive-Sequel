extends Reference
var data = {
	xari_encounter5 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER5_1", reqs = [], previous_dialogue_option = 1},
			{text = "XARIENCOUNTER5_2", reqs = [], previous_dialogue_option = 2},
			{text = "XARIENCOUNTER5_3", reqs = [], previous_dialogue_option = 3},
			{text = "XARIENCOUNTER5_ANY", reqs = []},
		],
		options = [
			{code = 'xari_encounter6', text = "XARIENCOUNTER5REPLY1", reqs = [{type = 'dialogue_seen', check = true, value = 'XARIENCOUNTER4_3'}], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_encounter7', text = "XARIENCOUNTER5REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_ecnounter_apprentice', text = "XARI_ENCOUNTER_APPRENTICE_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = true}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter5', disabled = true, text = "SPECIAL_ACTION_CLASS", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = false}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'close', text = "XARIENCOUNTER5REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 3, bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage1'}]},
		]
	},

	xari_encounter6 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER6", reqs = []},
		],
		options = [
			{code = 'xari_encounter7', text = "XARIENCOUNTER5REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_ecnounter_apprentice', text = "XARI_ENCOUNTER_APPRENTICE_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = true}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter6', disabled = true, text = "SPECIAL_ACTION_CLASS", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = false}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'close', text = "XARIENCOUNTER5REPLY3", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage1'}]},
		]
	},
	
	xari_encounter7 = {
		variations = [
			{image = null,
			character = 'xari',
			tags = ['dialogue_scene'],
			text = [{text = "XARIENCOUNTER7_1", reqs = []}],
			reqs = [{type = 'master_check', value = [{code = 'one_of_races', value = ['Elf', 'TribalElf', 'DarkElf']}, {code = 'sex', operant = 'neq', value = 'female'}]}],
			options = [
				{code = 'xari_encounter8', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1, change_dialogue_type = 2},
			]
		},
			{image = null,
			character = 'xari',
			tags = ['dialogue_scene'],
			text = [{text = "XARIENCOUNTER7_2", reqs = []}], 
			reqs = [{type = 'master_check', value = [{code = 'sexuals_factor', operant = 'gte', value = 4}, {code = 'sex', operant = 'neq', value = 'female'}]}],
			options = [
				{code = 'xari_encounter8', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1, change_dialogue_type = 2},
			]
		},
			{image = null,
			character = 'xari',
			tags = [],
			text = [{text = "XARIENCOUNTER7_3", reqs = []}], 
			reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}]}],
			options = [
				{code = 'close', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage1'}, {code = "update_location"}]},
			]
		},
			{image = null,
			character = 'xari',
			tags = ['dialogue_scene'],
			text = [{ text = "XARIENCOUNTER7_4", reqs = [] }],
			reqs = [{type = 'master_check', value = [{code = 'sexuals_factor', operant = 'lt', value = 4}]}],
			options = [
				{code = 'close', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = "update_location"}]},
			]
		},
	],
	},

	xari_encounter8 = {
		image = null,
		custom_background = "xari_encounter8",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
#		dialogue_type = 2,
#		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER8_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 3}]}]},
			{text = "XARIENCOUNTER8_2", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 3}]}]},
			{text = "XARIENCOUNTER8_3", reqs = []},
		],
		options = [
			{code = 'close' , text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage2'}, {code = 'screen_black_transition', value = 1}, {code = 'decision', value = 'slept_with_xari'}]}
		]
	},
}
