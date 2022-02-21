var data = {
	leon_encounter_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_ENCOUNTER_START', reqs = []}], 
		options = [ {
			code = 'quest_fight', args = 'leon',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	}, 
	
	leon_encounter_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_ENCOUNTER_1', reqs = []}],
		common_effects = [{code = 'teleport_active_location', to_loc = {location = 'beastkin_capital', code = 'beastkin_capital', area = 'beastkin_tribe'}},
		{code = 'open_location', location = "beastkin_capital", area = "beastkin_tribe"}], #TODO change to open_city (not implemented)
		options = [ {
			code = 'leon_encounter_start_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'remove_active_location'}]
		},  ]
	},
	
	leon_encounter_start_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'leon',
		text = [{text = 'LEON_ENCOUNTER_2', reqs = []}], 
		options = [ {
			code = 'leon_encounter_start_3', text = "LEON_ENCOUNTER_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'leon_encounter_start_3', text = "LEON_ENCOUNTER_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	}, 
	
	leon_encounter_start_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'leon',
		text = [{text = 'LEON_ENCOUNTER_3', reqs = []}], 
		options = [ {
			code = 'leon_encounter_start_4', text = "LEON_ENCOUNTER_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'leon_encounter_start_4', text = "LEON_ENCOUNTER_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'leon_encounter_start_4', text = "LEON_ENCOUNTER_3_OPTION_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	}, 
	
	leon_encounter_start_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'leon',
		text = [{text = 'LEON_ENCOUNTER_4_1', reqs = [], previous_dialogue_option = 1},
		{text = 'LEON_ENCOUNTER_4_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage15'},
			{code = 'make_quest_location', value = 'quest_white_stag_location'}]
		}, ]
	},
	
	white_stag_encounter_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], character = 'leon',
		text = [{text = 'WHITE_STAG_ENCOUNTER_1', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_2', text = "WHITE_STAG_ENCOUNTER_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_2', text = "WHITE_STAG_ENCOUNTER_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	white_stag_encounter_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'leon',
		text = [{text = 'WHITE_STAG_ENCOUNTER_2_1', reqs = [], previous_dialogue_option = 1},
		{text = 'WHITE_STAG_ENCOUNTER_2_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'white_stag_encounter_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	white_stag_encounter_3 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = 'WHITE_STAG_ENCOUNTER_3', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_4', text = "WHITE_STAG_ENCOUNTER_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_4', text = "WHITE_STAG_ENCOUNTER_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	white_stag_encounter_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [{text = 'WHITE_STAG_ENCOUNTER_4', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_5', text = "WHITE_STAG_ENCOUNTER_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_5', text = "WHITE_STAG_ENCOUNTER_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	white_stag_encounter_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [{text = 'WHITE_STAG_ENCOUNTER_5', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_6', text = "WHITE_STAG_ENCOUNTER_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_6', text = "WHITE_STAG_ENCOUNTER_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}]
	},
	
	#fight
	white_stag_encounter_fight = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [ {text = 'WHITE_STAG_ENCOUNTER_7_1AND2', reqs = [], previous_dialogue_option = 1},
		{text = 'WHITE_STAG_ENCOUNTER_8_1AND2AND4', reqs = [], previous_dialogue_option = 2},
		{text = 'WHITE_STAG_ENCOUNTER_6_3', reqs = [], previous_dialogue_option = 3},
		{text = 'WHITE_STAG_ENCOUNTER_9_2AND3', reqs = [], previous_dialogue_option = 4},
		{text = 'WHITE_STAG_ENCOUNTER_10_5_1', reqs = [], previous_dialogue_option = 5},], 
		options = [ {
			code = 'quest_fight', args = 'elf_priestess',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},]
	},
	
	white_stag_encounter_fight_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'white_stag',
		text = [ {text = 'WHITE_STAG_ENCOUNTER_10_5_2', reqs = []} ], 
		options = [ {
			code = 'white_stag_encounter_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},]
	},
	
	white_stag_encounter_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [{text = 'WHITE_STAG_ENCOUNTER_6_1', reqs = [], previous_dialogue_option = 1},
		{text = 'WHITE_STAG_ENCOUNTER_6_2', reqs = [], previous_dialogue_option = 2}], 
		options = [ {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_6_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_7', text = "WHITE_STAG_ENCOUNTER_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}]
	},
	
	white_stag_encounter_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [{text = 'WHITE_STAG_ENCOUNTER_7_3', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_7_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_8', text = "WHITE_STAG_ENCOUNTER_7_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_7_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}]
	},
	
	white_stag_encounter_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [{text = 'WHITE_STAG_ENCOUNTER_8_3', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_9', text = "WHITE_STAG_ENCOUNTER_8_3_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_8_3_OPTION_2", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_8_3_OPTION_3", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		} ]
	},
	
	white_stag_encounter_9 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'elf_priestess',
		text = [{text = 'WHITE_STAG_ENCOUNTER_7_3', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_10', text = "WHITE_STAG_ENCOUNTER_9_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'smith', check = true}]}], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_10', text = "WHITE_STAG_ENCOUNTER_9_1_OPTION_2", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'bard', check = true}]}], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_10', text = "WHITE_STAG_ENCOUNTER_9_1_OPTION_3", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'knight', check = true}]}], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_10_4', text = "WHITE_STAG_ENCOUNTER_9_1_OPTION_4", reqs = [{type = "location_has_specific_slaves", value = 1, location = 'quest_white_stag_location', reqs = [
				{code = 'unique', value = 'zephyra'}]}], dialogue_argument = 4, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_9_1_OPTION_5", reqs = [], dialogue_argument = 5, type = 'next_dialogue', 
		}]
	},
	
	white_stag_encounter_10_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'zephyra',
		text = [{text = 'WHITE_STAG_ENCOUNTER_10_4', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_9', text = "WHITE_STAG_ENCOUNTER_8_3_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_8_3_OPTION_2", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, {
			code = 'white_stag_encounter_fight', text = "WHITE_STAG_ENCOUNTER_8_3_OPTION_3", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		} ]
	},
	
	white_stag_encounter_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'white_stag',
		text = [{text = 'WHITE_STAG_ENCOUNTER_10_1AND2AND3AND4', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	white_stag_encounter_11 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = 'WHITE_STAG_ENCOUNTER_11', reqs = []}], 
		options = [ {
			code = 'white_stag_encounter_12', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	white_stag_encounter_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "leon",
		text = [{text = 'WHITE_STAG_ENCOUNTER_12', reqs = []}], 
		options = [ {
			code = 'quest_fight', args = 'white_stag',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	white_stag_encounter_13 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = 'WHITE_STAG_ENCOUNTER_13', reqs = []}], 
		options = [ { # TODO add teleport to tribe_location
			code = 'white_stag_encounter_14', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'remove_active_location'}]
		} ]
	},
	
	white_stag_encounter_14 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "leon", character2 = "savra",
		text = [{text = 'WHITE_STAG_ENCOUNTER_14', reqs = []}], 
		common_effects = [
			{code = 'progress_quest', value = 'temple_quest', stage = 'stage1'},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'sword_artifact_quest'}, 
			{code = 'update_city'}]
		} ]
	},
	
	priestess_talk_start = {
		image = null, tags = ['dialogue_scene'],
		reqs = [],
		text = [{text = 'PRIESTESS_TALK_START', reqs = []}], 
		options = [ {
			code = 'priestess_talk_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	priestess_talk_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate','blackscreen_transition_common'],
		reqs = [], character = "elf_priestess",
		text = [{text = 'PRIESTESS_TALK_1', reqs = []}], 
		options = [ {
			code = 'priestess_talk_2', text = "PRIESTESS_TALK_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'priestess_talk_2', text = "PRIESTESS_TALK_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'priestess_talk_2', text = "PRIESTESS_TALK_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	priestess_talk_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'PRIESTESS_TALK_2_1', reqs = [], previous_dialogue_option = 1},
		{text = 'PRIESTESS_TALK_2_2', reqs = [], previous_dialogue_option = 2},
		{text = 'PRIESTESS_TALK_2_3', reqs = [], previous_dialogue_option = 3},
		{text = 'PRIESTESS_TALK_3_1', reqs = [], previous_dialogue_option = 4},], 
		options = [ {
			code = 'priestess_talk_2', text = "PRIESTESS_TALK_2_OPTION_1", reqs = [], dialogue_argument = 4, remove_after_first_use = true,
		}, {
			code = 'priestess_talk_3', text = "PRIESTESS_TALK_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'priestess_talk_3', text = "PRIESTESS_TALK_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	priestess_talk_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'PRIESTESS_TALK_3_2', reqs = [], previous_dialogue_option = 2},
		{text = 'PRIESTESS_TALK_3_3', reqs = [], previous_dialogue_option = 3},], 
		options = [ {
			code = 'close', text = "PRIESTESS_TALK_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage2'}, {code = 'update_city'},
				{code = 'make_quest_location', value = 'quest_temple_location'}]
		}, {
			code = 'close', text = "PRIESTESS_TALK_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage2'}, {code = 'update_city'},
				{code = 'make_quest_location', value = 'quest_temple_location'}]
		}, ]
	},
	
	temple_start = {
		image = 'temple_gates', tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_START', reqs = []}], 
		options = [ {
			code = 'temple_1', select_person = true, text = "TEMPLE_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'temple_1', text = "TEMPLE_START_OPTION_2", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'alchemist', check = true}]}], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'close', text = "TEMPLE_START_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	temple_1 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_1_1_1', reqs = [{type = 'active_character_checks', value = [{code = 'is_master', check = false}]}], previous_dialogue_option = 0},
		{text = 'TEMPLE_1_1_2', reqs = [{type = 'active_character_checks', value = [{code = 'is_master', check = true}]}], previous_dialogue_option = 0},
		{text = 'TEMPLE_1_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'temple_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	temple_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_2_2', reqs = [{type = "location_has_specific_slaves", check = true, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}]},
				{text = 'TEMPLE_2_1', reqs = [{type = "location_has_specific_slaves", check = false, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}]}], 
		options = [ {
			code = 'temple_4', text = "TEMPLE_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'money_change', operant = '+', value = 1000}], 
		}, {
			code = 'temple_3_1_1_good', text = "TEMPLE_2_OPTION_2", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 3}]}], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'temple_3_1_1_bad', text = "TEMPLE_2_OPTION_2", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 3}]}], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'temple_3_2', text = "TEMPLE_2_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	temple_3_1_1_good = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_3_1_1', reqs = []}], 
		options = [ {
			code = 'temple_4', text = "TEMPLE_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'money_change', operant = '+', value = 1500}],
		}, {
			code = 'temple_3_2', text = "TEMPLE_2_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	temple_3_1_1_bad = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_3_1_2', reqs = []}], 
		options = [ {
			code = 'temple_4', text = "TEMPLE_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'money_change', operant = '+', value = 1000}],
		}, {
			code = 'temple_3_2', text = "TEMPLE_2_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	#fight
	temple_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_3_2', reqs = []}], 
		options = [ {
			code = 'quest_fight', args = 'temple_raiders',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	temple_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], # TODO - 50 loyalty for aire
		bonus_effects = [{code = 'money_change', operant = '+', value = 1000}],
		text = [{text = 'TEMPLE_4_1', reqs = [{type = "location_has_specific_slaves", check = true, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}]},
				{text = 'TEMPLE_4_2', reqs = [{type = "location_has_specific_slaves", check = false, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}]}], 
		options = [ {
			code = 'temple_6', text = "DIALOGUECONTINUE", reqs = [{type = "location_has_specific_slaves", check = true, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'temple_6', text = "DIALOGUECONTINUE", reqs = [{type = "location_has_specific_slaves", check = false, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}], dialogue_argument = 1, type = 'next_dialogue', 
		},]
	},
	
	temple_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_5', reqs = []}], 
		options = [ {
			code = 'temple_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	# TODO (allow to restart on prev scene)
	temple_6 = {
		variations = [ {
				image = null, tags = ['dialogue_scene', 'master_translate',],
				reqs = [{type = "location_has_specific_slaves", check = false, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}], 
				text = [{text = 'TEMPLE_6_1', reqs = []}], 
				options = [ {
					code = 'quest_fight', args = 'temple_specters', text = "DIALOGUEFIGHT", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				}, {
					code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
					bonus_effects = [{code = 'progress_quest', value = 'temple_quest', stage = 'stage3'}]
				},]
			}, {
				image = null, tags = ['dialogue_scene', 'master_translate',],
				reqs = [{type = "location_has_specific_slaves", check = true, value = 1, location = 'quest_temple_location', reqs = [
					{code = 'unique', value = 'aire'}]}], character = 'aire',
				text = [{text = 'TEMPLE_6_2', reqs = []}], 
				options = [ {
					code = 'temple_7', text = "TEMPLE_6_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				}, {
					code = 'temple_7', text = "TEMPLE_6_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
				},]
			}
		]
	},
	
	temple_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = 'aire',
		text = [{text = 'TEMPLE_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'TEMPLE_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'temple_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	temple_8 = {
		image = "temple_source", tags = ['dialogue_scene', 'master_translate',],
		reqs = [], 
		text = [{text = 'TEMPLE_8', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'remove_active_location'},
			{code = 'progress_quest', value = 'temple_quest', stage = 'stage4'}]
		} ]
	},
	
	after_temple_priestess_1 = {
		image = null, tags = ['dialogue_scene',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_1', reqs = [],}], 
		options = [ {
			code = 'after_temple_priestess_2', text = "AFTER_TEMPLE_PRIESTESS_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	after_temple_priestess_2 = {
		image = null, tags = ['dialogue_scene',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_2', reqs = [],}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	after_temple_priestess_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_3', reqs = [],}], 
		options = [ {
			code = 'after_temple_priestess_4', text = "AFTER_TEMPLE_PRIESTESS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'after_temple_priestess_4', text = "AFTER_TEMPLE_PRIESTESS_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_temple_priestess_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_4', reqs = [],}], 
		options = [ {
			code = 'after_temple_priestess_5_1', text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true,
		}, {
			code = 'after_temple_priestess_5_1and2', text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'after_temple_priestess_5_1and2', text = "AFTER_TEMPLE_PRIESTESS_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	after_temple_priestess_5_1 = {
		variations = [ {
				image = null, tags = ['dialogue_scene', 'master_translate',],
				reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'neq', value = 'female'}]}], character = "elf_priestess",
				text = [{text = 'AFTER_TEMPLE_PRIESTESS_5_1_1_BAD', reqs = [],}], 
				options = [ {
					code = 'after_temple_priestess_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				}, ]
			}, {
				image = null, tags = ['dialogue_scene', 'master_translate',],
				reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}]}], character = "elf_priestess",
				text = [{text = 'AFTER_TEMPLE_PRIESTESS_5_1_1', reqs = [],}], 
				options = [ {
					code = 'after_temple_priestess_5_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				},  ]
			},
		]
	},
	
	after_temple_priestess_5_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_5_1_2', reqs = [],}], 
		options = [ {
			code = 'after_temple_priestess_5_1_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	after_temple_priestess_5_1_3 = { # TODO add sex scenes
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = "elf_priestess",
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_5_1_3', reqs = [],}], 
		options = [ {
			code = 'after_temple_priestess_5_1and2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	after_temple_priestess_5_1and2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = 'AFTER_TEMPLE_PRIESTESS_5_1AND2', reqs = [],}], 
		options = [ { 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage5'}, 
				{code = 'make_quest_location', value = 'quest_erlen_location'}, {code = 'update_city'}]
		},  ]
	},
	
	erlern_encounter_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'ERLERN_ENCOUNTER_START', reqs = [],}], 
		options = [ {
			code = 'erlern_encounter_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	erlern_encounter_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen',
		text = [{text = 'ERLERN_ENCOUNTER_1', reqs = [],}], 
		options = [ {
			code = 'erlern_encounter_2', text = "ERLERN_ENCOUNTER_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'erlern_encounter_2', text = "ERLERN_ENCOUNTER_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'erlern_encounter_2', text = "ERLERN_ENCOUNTER_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		},]
	},
	
	erlern_encounter_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen',
		text = [{text = 'ERLERN_ENCOUNTER_2_1AND2', reqs = [], previous_dialogue_option = [1,2]}, 
		{text = 'ERLERN_ENCOUNTER_2_3', reqs = [], previous_dialogue_option = 3}, ], 
		options = [ {
			code = 'erlern_encounter_3', text = "ERLERN_ENCOUNTER_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'close', text = "ERLERN_ENCOUNTER_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	erlern_encounter_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen',
		text = [{text = 'ERLERN_ENCOUNTER_3_1', reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage6'}, {code = 'update_location'} ]
		}, ]
	},
	
	lira_encounter_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'lira',
		text = [{text = 'LIRA_ENCOUNTER_1', reqs = []} ], 
		options = [ {
			code = 'lira_encounter_2', text = "LIRA_ENCOUNTER_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'lira_encounter_2', text = "LIRA_ENCOUNTER_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	lira_encounter_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'lira',
		text = [{text = 'LIRA_ENCOUNTER_2', reqs = []} ], 
		options = [ {
			code = 'lira_encounter_3', text = "LIRA_ENCOUNTER_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'close', text = "LIRA_ENCOUNTER_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage7'}, {code = 'update_city'} ]
		}, ]
	},
	
	lira_encounter_3 = {
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'wits_factor', operant = 'gte', value = 3}]}], character = 'lira',
			text = [{text = 'LIRA_ENCOUNTER_3_1_GOOD', reqs = []} ], 
			options = [ {
				code = 'close', text = "LIRA_ENCOUNTER_3_1_GOOD_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
				bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage8'}, {code = 'update_city'} ]
			}, ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'wits_factor', operant = 'lt', value = 3}]}], character = 'lira',
			text = [{text = 'LIRA_ENCOUNTER_3_1_BAD', reqs = []} ], 
			options = [ {
				code = 'close', text = "LIRA_ENCOUNTER_3_1_BAD_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
				bonus_effects = [ {code = 'progress_quest', value = 'temple_quest', stage = 'stage7'}, {code = 'update_city'} ]
			}, ]
		}, 
		]
	},
	
	lira_encounter_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'lira',
		text = [{text = 'LIRA_ENCOUNTER_4', reqs = []} ], 
		options = [ {
			code = 'lira_encounter_5_1_1', text = "LIRA_ENCOUNTER_4_OPTION_1", select_person = true, reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'lira_encounter_5_2_1', text = "LIRA_ENCOUNTER_4_OPTION_2", reqs = [{type = 'active_quest_stage', value = 'temple_quest', stage = 'stage8', state = true}, {type = 'has_items', operant = 'gte', value = 10, name = 'whiskey'},], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'close', text = "LIRA_ENCOUNTER_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	lira_encounter_5_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'lira',
		text = [{text = 'LIRA_ENCOUNTER_5_1_1', reqs = []} ], 
		options = [ {
			code = 'lira_encounter_5_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	lira_encounter_5_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = 'LIRA_ENCOUNTER_5_1_2', reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'temple_quest', stage = 'stage9'}, {code = 'update_city'}]
		}, ]
	},
	
	lira_encounter_5_2_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'lira',
		text = [{text = 'LIRA_ENCOUNTER_5_1_1', reqs = []} ], 
		options = [ {
			code = 'lira_encounter_5_2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	lira_encounter_5_2_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = 'LIRA_ENCOUNTER_5_1_2', reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'temple_quest', stage = 'stage9'},
			{code = 'remove_item', name = 'whiskey', number = 10}, {code = 'update_city'}]
		}, ]
	},
	
	erlen_lira_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'ERLEN_LIRA_1', reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_lira_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_2', reqs = []} ], 
		options = [ {
			code = 'erlen_lira_3', text = "ERLEN_LIRA_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_3', text = "ERLEN_LIRA_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_3', text = "ERLEN_LIRA_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_lira_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_3_1', reqs = [], previous_dialogue_option = 1}, 
		{text = 'ERLEN_LIRA_3_2', reqs = [], previous_dialogue_option = 2},
		{text = 'ERLEN_LIRA_3_3', reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'erlen_lira_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_lira_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_4', reqs = [], previous_dialogue_option = 1},
		{text = 'ERLEN_LIRA_5_1', reqs = [], previous_dialogue_option = 4},
		{text = 'ERLEN_LIRA_5_2_1', reqs = [], previous_dialogue_option = 5},
		{text = 'ERLEN_LIRA_5_2_2', reqs = [], previous_dialogue_option = 6},],
		options = [ {
			code = 'erlen_lira_4', text = "ERLEN_LIRA_4_OPTION_1", reqs = [], dialogue_argument = 4, remove_after_first_use = true,
		}, {
			code = 'erlen_lira_5_2', text = "ERLEN_LIRA_4_OPTION_2", reqs = [{type = 'dialogue_seen', check = true, value = 'ERLEN_LIRA_5_1'}], dialogue_argument = 2, remove_after_first_use = true,
		}, {
			code = 'erlen_lira_5_3', text = "ERLEN_LIRA_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_lira_5_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_5_2', reqs = []}],
		options = [ {
			code = 'erlen_lira_4', text = "ERLEN_LIRA_5_2_OPTION_1", reqs = [], dialogue_argument = 5, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_4', text = "ERLEN_LIRA_5_2_OPTION_2", reqs = [], dialogue_argument = 6, type = 'next_dialogue', 
		},  ]
	},
	
	erlen_lira_5_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_5_3', reqs = []}],
		options = [ {
			code = 'erlen_lira_6', text = "ERLEN_LIRA_5_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_6', text = "ERLEN_LIRA_5_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_6', text = "ERLEN_LIRA_5_3_OPTION_3", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'wits_factor', operant = 'gte', value = 5}]}], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_lira_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_6_1', reqs = [], previous_dialogue_option = 1},
		{text = 'ERLEN_LIRA_6_2', reqs = [], previous_dialogue_option = 2},
		{text = 'ERLEN_LIRA_6_3', reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'erlen_lira_7', text = "ERLEN_LIRA_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_7', text = "ERLEN_LIRA_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		},  ]
	},
	
	erlen_lira_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'ERLEN_LIRA_7_2', reqs = [], previous_dialogue_option = 2},
		{text = 'ERLEN_LIRA_8_1_2', reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'erlen_lira_8_1_1', text = "ERLEN_LIRA_7_OPTION_1", reqs = [], dialogue_argument = 1,  remove_after_first_use = true,
		}, {
			code = 'erlen_lira_8_2', text = "ERLEN_LIRA_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		},  ]
	},
	
	erlen_lira_8_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_8_1_1', reqs = []},],
		options = [ {
			code = 'erlen_lira_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		},]
	},
	
	erlen_lira_8_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_8_2', reqs = []},],
		options = [ {
			code = 'erlen_lira_9', text = "ERLEN_LIRA_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'erlen_lira_9', text = "ERLEN_LIRA_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		},]
	},
	
	erlen_lira_9 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'lira',
		text = [{text = 'ERLEN_LIRA_9_1', reqs = [], previous_dialogue_option = 1},
		{text = 'ERLEN_LIRA_9_2', reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'complete_quest', value = 'temple_quest'}, {code = 'update_location'}]
		} ]
	},
	
	erlen_leon_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'erlen', character2 = 'leon',
		text = [{text = 'ERLEN_LEON_1', reqs = []},],
		options = [ {
			code = 'erlen_leon_2', text = "ERLEN_LEON_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'erlen_leon_2', text = "ERLEN_LEON_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_leon_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = 'erlen', character2 = 'leon',
		text = [{text = 'ERLEN_LEON_2', reqs = []},],
		options = [ {
			code = 'erlen_leon_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_leon_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'erlen',
		text = [{text = 'ERLEN_LEON_3', reqs = []},],
		options = [ {
			code = 'quest_fight', args = 'bridge_guards',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	erlen_leon_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate',],
		reqs = [], character = 'erlen', character2 = 'leon',
		text = [{text = 'ERLEN_LEON_4', reqs = []},],
		options = [ {
			code = 'ceremony_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'elf_priestess', 
		text = [{text = 'CEREMONY_1', reqs = []},],
		options = [ {
			code = 'ceremony_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	# TODO LIST: white screen, teleport change, open city change,
	ceremony_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		common_effects = [ {code = 'play_sound', value = 'doorsmash'} ,
			{code = 'screen_shake', strength = 3, length = 0.3},],
		text = [{text = 'CEREMONY_2', reqs = []},],
		options = [ {
			code = 'ceremony_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate', ],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		text = [{text = 'CEREMONY_3', reqs = []},],
		options = [ {
			code = 'ceremony_heleviel_1', text = "CEREMONY_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ceremony_2', text = "CEREMONY_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_heleviel_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		text = [{text = 'CEREMONY_HELEVIEL_1', reqs = []},],
		options = [ {
			code = 'ceremony_heleviel_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	ceremony_heleviel_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		text = [{text = 'CEREMONY_HELEVIEL_2', reqs = []},],
		options = [ {
			code = 'ceremony_heleviel_3_1_1', text = "CEREMONY_HELEVIEL_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ceremony_heleviel_3_2', text = "CEREMONY_HELEVIEL_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_heleviel_3_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		text = [{text = 'CEREMONY_HELEVIEL_3_1', reqs = []},],
		options = [ {
			code = 'ceremony_heleviel_3_1_2', text = "CEREMONY_HELEVIEL_3_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ceremony_heleviel_3_1_2', text = "CEREMONY_HELEVIEL_3_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'ceremony_heleviel_3_2', text = "CEREMONY_HELEVIEL_3_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_heleviel_3_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		text = [{text = 'CEREMONY_HELEVIEL_3_1_1', reqs = [], previous_dialogue_option = 1},
		{text = 'CEREMONY_HELEVIEL_3_1_2', reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = 'make_story_character', value = 'Lira', recruit_from_location = true}]},],
		options = [ {
			code = 'ceremony_heleviel_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_heleviel_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'CEREMONY_HELEVIEL_3_2', reqs = []},],
		options = [ {
			code = 'ceremony_heleviel_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_heleviel_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'elf_priestess', 
		text = [{text = 'CEREMONY_HELEVIEL_4', reqs = []},],
		options = [ {
			code = 'close', text = "CEREMONY_HELEVIEL_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'close', text = "CEREMONY_HELEVIEL_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_lira_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen', character2 = 'elf_priestess', 
		text = [{text = 'CEREMONY_LIRA_1', reqs = []},],
		options = [ {
			code = 'ceremony_lira_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	ceremony_lira_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [],  
		text = [{text = 'CEREMONY_LIRA_2', reqs = []},],
		options = [ {
			code = 'ceremony_lira_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	ceremony_lira_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'erlen',
		text = [{text = 'CEREMONY_LIRA_3', reqs = []},],
		options = [ {
			code = 'ceremony_lira_4_1', text = "CEREMONY_LIRA_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'close', text = "CEREMONY_LIRA_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_lira_4_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'erlen',
		text = [{text = 'CEREMONY_LIRA_4_1', reqs = []},],
		options = [ {
			code = 'ceremony_lira_4_1_1', text = "CEREMONY_LIRA_4_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'close', text = "CEREMONY_LIRA_4_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ceremony_lira_4_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'erlen',
		text = [{text = 'CEREMONY_LIRA_4_1_1', reqs = []},],
		options = [ {
			code = 'close', text = "CEREMONY_LIRA_4_1_1_OPTION", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	demon_priestess_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], character = 'demon_female', character2 = 'elf_priestess',
		text = [{text = 'DEMON_PRIESTESS_1', reqs = []},],
		options = [ {
			code = 'demon_priestess_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	demon_priestess_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'demon_female', character2 = 'elf_priestess',
		text = [{text = 'DEMON_PRIESTESS_2', reqs = []},],
		options = [ {
			code = 'demon_priestess_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	demon_priestess_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = 'elf_priestess', 
		text = [{text = 'DEMON_PRIESTESS_3', reqs = []},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
}
