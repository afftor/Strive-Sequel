var data = {
	zephyra_recruitment_letter = {
		image = 'letter', tags = ["dialogue_scene"],
		reqs = [{type = 'has_hero', name = 'zephyra', check = false}],
		text = [
			{text = "ZEPHYRA_RECRUITMENT_LETTER", reqs = []}
		],
		options = [ {
			code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue",
			bonus_effects = [{code = 'progress_quest', value = 'pre_sword_artifact_quest', stage = 'stage1'}, {code = 'update_city'}]
		} ]
	},
	
	zephyra_recruitment_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "ginny",
		text = [{text = "ZEPHYRA_RECRUITMENT_1", reqs = []}],
		options = [ {
			code = 'zephyra_recruitment_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_recruitment_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_RECRUITMENT_2", reqs = []}],
		options = [ {
			code = 'zephyra_recruitment_3', text = "ZEPHYRA_RECRUITMENT_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'zephyra_recruitment_3', text = "ZEPHYRA_RECRUITMENT_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'zephyra_recruitment_3_3', text = "ZEPHYRA_RECRUITMENT_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_recruitment_3_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "ginny",
		text = [{text = "ZEPHYRA_RECRUITMENT_3_3", reqs = []}],
		options = [ {
			code = 'close', text = "ZEPHYRA_RECRUITMENT_3_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'pre_sword_artifact_quest'}, {code = 'update_city'}]
		}, {
			code = 'zephyra_recruitment_2', text = "ZEPHYRA_RECRUITMENT_3_3_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_recruitment_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_RECRUITMENT_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_RECRUITMENT_3_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_recruitment_4', text = "ZEPHYRA_RECRUITMENT_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'zephyra_recruitment_4', text = "ZEPHYRA_RECRUITMENT_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_recruitment_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_RECRUITMENT_4", reqs = []}],
		options = [ {
			code = 'zephyra_recruitment_5', text = "ZEPHYRA_RECRUITMENT_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'zephyra_recruitment_5', text = "ZEPHYRA_RECRUITMENT_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_recruitment_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_RECRUITMENT_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_RECRUITMENT_5_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_recruitment_6_good', text = "ZEPHYRA_RECRUITMENT_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'zephyra_recruitment_6_bad', text = "ZEPHYRA_RECRUITMENT_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_recruitment_6_good = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_RECRUITMENT_6_GOOD", reqs = []}],
		common_effects = [{code = 'make_story_character', value = 'Zephyra', recruit_from_location = true},
		{code = 'decision', value = 'ZephyraRecruited'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'pre_sword_artifact_quest'},
			{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage2'}, {code = 'update_city'}]
		} ]
	},
	
	zephyra_recruitment_6_bad = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_RECRUITMENT_6_BAD", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'pre_sword_artifact_quest'}, {code = 'update_city'}]
		} ]
	},
	
	zephyra_sword_1 = {
		image = null, tags = ["dialogue_scene", "master_translate"],
		reqs = [{type = 'has_hero', name = 'zephyra', check = true},
		{type = 'has_money', value = 55},], character = "zephyra",
		text = [
			{text = "ZEPHYRA_SWORD_1", reqs = []}
		],
		options = [ {
			code = 'zephyra_sword_2', text = "ZEPHYRA_SWORD_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'zephyra_sword_2', text = "ZEPHYRA_SWORD_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_sword_2 = {
		image = null, tags = ["dialogue_scene", "master_translate"],
		reqs = [], character = "zephyra",
		text = [
			{text = "ZEPHYRA_SWORD_2", reqs = []}
		],
		options = [ {
			code = 'zephyra_sword_3', text = "ZEPHYRA_SWORD_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'zephyra_sword_3', text = "ZEPHYRA_SWORD_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	zephyra_sword_3 = {
		image = null, tags = ["dialogue_scene", "master_translate"],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_SWORD_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_SWORD_3_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage2'}, {code = 'update_city'}]
		} ]
	},
	
	priestess_sword_talk_1  = {
		image = null, tags = ["dialogue_scene", "master_translate"],
		reqs = [], character = "elf_priestess",
		text = [{text = "PRIESTESS_SWORD_TALK_1_1", reqs = [], previous_dialogue_option = 0},
		{text = "PRIESTESS_SWORD_TALK_1_2", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'priestess_sword_talk_1', text = "PRIESTESS_SWORD_TALK_1_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'priestess_sword_talk_2', text = "PRIESTESS_SWORD_TALK_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, ]
	},
	
	priestess_sword_talk_2  = {
		image = null, tags = ["dialogue_scene"],
		reqs = [], character = "elf_priestess",
		text = [{text = "PRIESTESS_SWORD_TALK_2", reqs = []}],
		options = [ {
			code = 'priestess_sword_talk_3', text = "PRIESTESS_SWORD_TALK_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'priestess_sword_talk_3', text = "PRIESTESS_SWORD_TALK_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'priestess_sword_talk_3', text = "PRIESTESS_SWORD_TALK_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'priestess_sword_talk_3', text = "PRIESTESS_SWORD_TALK_2_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}, ]
	},
	
	priestess_sword_talk_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "elf_priestess",
		text = [{text = "PRIESTESS_SWORD_TALK_3_123", reqs = [], previous_dialogue_option = [1, 2, 3]},
		{text = "PRIESTESS_SWORD_TALK_3_4", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'priestess_sword_talk_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}, ]
	},
	
	priestess_sword_talk_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = "PRIESTESS_SWORD_TALK_4_0", reqs = [], previous_dialogue_option = 0},
		{text = "PRIESTESS_SWORD_TALK_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "PRIESTESS_SWORD_TALK_4_2", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'priestess_sword_talk_4_1', text = "PRIESTESS_SWORD_TALK_4_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'priestess_sword_talk_4_1', text = "PRIESTESS_SWORD_TALK_4_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'priestess_sword_talk_5', text = "PRIESTESS_SWORD_TALK_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},
	
	priestess_sword_talk_4_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "PRIESTESS_SWORD_TALK_4_0", reqs = [], previous_dialogue_option = 0},
		{text = "PRIESTESS_SWORD_TALK_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "PRIESTESS_SWORD_TALK_4_2", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'priestess_sword_talk_4_1', text = "PRIESTESS_SWORD_TALK_4_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'priestess_sword_talk_4_1', text = "PRIESTESS_SWORD_TALK_4_OPTION_2", reqs = [], dialogue_argument = 2, emove_after_first_use = true
		}, {
			code = 'priestess_sword_talk_5', text = "PRIESTESS_SWORD_TALK_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ]
	},
	
	priestess_sword_talk_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "PRIESTESS_SWORD_TALK_5", reqs = []}],
		options = [ {
			code = 'priestess_sword_talk_6', text = "PRIESTESS_SWORD_TALK_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'priestess_sword_talk_6', text = "PRIESTESS_SWORD_TALK_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	priestess_sword_talk_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "PRIESTESS_SWORD_TALK_6", reqs = []}],
		options = [ {
			code = 'priestess_sword_talk_7', text = "PRIESTESS_SWORD_TALK_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'priestess_sword_talk_7', text = "PRIESTESS_SWORD_TALK_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'priestess_sword_talk_7', text = "PRIESTESS_SWORD_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	priestess_sword_talk_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "PRIESTESS_SWORD_TALK_7_1", reqs = [], previous_dialogue_option = 1},
		{text = "PRIESTESS_SWORD_TALK_7_2", reqs = [], previous_dialogue_option = 2},
		{text = "PRIESTESS_SWORD_TALK_7_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage3'}, {code = 'update_city'}]
		} ]
	},
	
	chieftain_meeting_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "CHIEFTAIN_MEETING_1", reqs = [], previous_dialogue_option = 0},
		{text = "CHIEFTAIN_MEETING_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "CHIEFTAIN_MEETING_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'chieftain_meeting_1', text = "CHIEFTAIN_MEETING_1_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'chieftain_meeting_1', text = "CHIEFTAIN_MEETING_1_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'chieftain_meeting_2', text = "CHIEFTAIN_MEETING_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		} ]
	},
	
	chieftain_meeting_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "CHIEFTAIN_MEETING_2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'chieftain_meeting_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	chieftain_meeting_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = 'leon',
		text = [{text = "CHIEFTAIN_MEETING_3_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'race', operant = 'eq', value = "beastkin"}]}]},
		{text = "CHIEFTAIN_MEETING_3_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'race', operant = 'eq', value = "halfkin"}]}]},
		{text = "CHIEFTAIN_MEETING_3_2", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'race', operant = 'neq', value = "beastkin"}]},
		{type = 'master_check', value = [{code = 'stat', stat = 'race', operant = 'neq', value = "halfkin"}]}]},],
		options = [ {
			code = 'chieftain_meeting_4', text = "CHIEFTAIN_MEETING_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'chieftain_meeting_4', text = "CHIEFTAIN_MEETING_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		} ]
	},
	
	chieftain_meeting_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'leon',
		text = [{text = "CHIEFTAIN_MEETING_4", reqs = []}],
		options = [ {
			code = 'chieftain_meeting_5', text = "CHIEFTAIN_MEETING_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'chieftain_meeting_5', text = "CHIEFTAIN_MEETING_4_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'chieftain_meeting_5', text = "CHIEFTAIN_MEETING_4_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	chieftain_meeting_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'leon',
		text = [{text = "CHIEFTAIN_MEETING_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage4'}, {code = 'update_city'}]
		} ]
	},
	
	mae_meeting_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'mae',
		text = [{text = "MAE_MEETING_1", reqs = []}],
		options = [ {
			code = 'mae_meeting_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	mae_meeting_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "MAE_MEETING_2", reqs = []}],
		options = [ {
			code = 'mae_meeting_2_1', text = "MAE_MEETING_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'mae_meeting_3', text = "MAE_MEETING_2_OPTION_2", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, {
			code = 'mae_meeting_3', text = "MAE_MEETING_2_OPTION_3", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		} ]
	},
	
	mae_meeting_2_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "MAE_MEETING_2_1", reqs = []}],
		options = [ {
			code = 'mae_meeting_3', text = "MAE_MEETING_2_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'mae_meeting_3', text = "MAE_MEETING_2_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'mae_meeting_3', text = "MAE_MEETING_2_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		} ]
	},
	
	mae_meeting_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "MAE_MEETING_2_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "MAE_MEETING_2_1_2", reqs = [], previous_dialogue_option = 2},
		{text = "MAE_MEETING_2_1_3", reqs = [], previous_dialogue_option = 3},
		{text = "MAE_MEETING_2_2AND3", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'mae_meeting_4', text = "MAE_MEETING_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'mae_meeting_4', text = "MAE_MEETING_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'mae_meeting_4', text = "MAE_MEETING_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		} ]
	},
	
	mae_meeting_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "MAE_MEETING_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "MAE_MEETING_3_2AND3", reqs = [], previous_dialogue_option = [2,3]},
		{text = "MAE_MEETING_4_1", reqs = [], previous_dialogue_option = 6},
		{text = "MAE_MEETING_4_2", reqs = [], previous_dialogue_option = 7},
		{text = "MAE_MEETING_4_3", reqs = [], previous_dialogue_option = 8}],
		options = [ {
			code = 'mae_meeting_4', text = "MAE_MEETING_3_1_OPTION_1", reqs = [], dialogue_argument = 6, remove_after_first_use = true
		}, {
			code = 'mae_meeting_4', text = "MAE_MEETING_3_1_OPTION_2", reqs = [], dialogue_argument = 7, remove_after_first_use = true
		}, {
			code = 'mae_meeting_4', text = "MAE_MEETING_3_1_OPTION_3", reqs = [], dialogue_argument = 8, remove_after_first_use = true
		}, {
			code = 'close', text = "MAE_MEETING_3_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage6'}, {code = 'update_city'}, 
			{code = 'add_timed_event', value = "canStartRitualPrep",
		args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}] 
		}, {
			code = 'mae_meeting_4_5', text = "MAE_MEETING_3_1_OPTION_5", reqs = [], dialogue_argument = 5, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage5'}, {code = 'update_city'}]
		} ]
	},
	
	mae_meeting_4_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "MAE_MEETING_4_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 5, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage5'}, {code = 'update_city'}]
		} ]
	},
	
	savra_supplies_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "", reqs = []}],
		options = [ {
			code = 'savra_supplies_1', text = "SAVRA_SUPPLIES_START_OPTION", reqs = [{type = 'has_material', material = 'fish', operant = 'gte', value = 2000},
			{type = 'has_material', material = 'meat', operant = 'gte', value = 2000},], dialogue_argument = 1, type = 'next_dialogue', 
			
		}, {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}]
	},
	
	savra_supplies_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "SAVRA_SUPPLIES_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage6'},
			{code = 'update_city'},
			{code = 'material_change', operant = '-', material = 'meat', value = 2000},
			{code = 'material_change', operant = '-', material = 'fish', value = 2000},
			{code = 'add_timed_event', value = "canStartRitualPrep",
		args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
		}]
	},
	
	savra_ritual_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "SAVRA_RITUAL_START", reqs = []}],
		options = [ {
			code = 'close', text = "SAVRA_RITUAL_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'make_quest_location', value = 'ritual_location'},
			{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage7'},
			{code = 'update_city'}]
		}, {
			code = 'close', text = "SAVRA_RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			bonus_effects = [{code = 'make_quest_location', value = 'ritual_location'},
			{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage7'},
			{code = 'update_city'}]
		} ] 
	},
	
	pre_ritual_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "PRE_RITUAL_1", reqs = []}],
		options = [ {
			code = 'pre_ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	pre_ritual_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "PRE_RITUAL_2", reqs = []}],
		options = [ {
			code = 'pre_ritual_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	pre_ritual_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "PRE_RITUAL_3", reqs = []}],
		options = [ {
			code = 'pre_ritual_4_1', text = "PRE_RITUAL_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'pre_ritual_4_2', text = "PRE_RITUAL_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'pre_ritual_4_3', text = "PRE_RITUAL_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	pre_ritual_4_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "PRE_RITUAL_4_1_1_300", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'gte', value = 100}]}]},
		{text = "PRE_RITUAL_4_1_1_500", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 100}]}]}],
		options = [ {
			code = 'pre_ritual_4_1_2', text = "PRE_RITUAL_4_1_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'quest_fight', args = 'slavers',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	pre_ritual_4_1_2 = {
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 100}]}],
			text = [{text = "PRE_RITUAL_4_1_2", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 500}],
			options = [ {
				code = 'pre_ritual_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'gte', value = 100}]}],
			text = [{text = "PRE_RITUAL_4_1_2", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 300}],
			options = [ {
				code = 'pre_ritual_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, ]
		},  
		]
	},
	
	pre_ritual_4_2 = {
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'gte', value = 75}]}],
			text = [{text = "PRE_RITUAL_4_2_1", reqs = []}],
			options = [ { 
				code = 'pre_ritual_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 75}]}],
			text = [{text = "PRE_RITUAL_4_2_2", reqs = []}],
			options = [ {
				code = 'quest_fight', args = 'slavers',
				text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
		},  
		]
	},
	
	pre_ritual_4_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "PRE_RITUAL_4_3", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'slavers',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	pre_ritual_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "PRE_RITUAL_5", reqs = []}],
		options = [ {
			code = 'pre_ritual_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  ]
	},
	
	pre_ritual_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "mae",
		text = [{text = "PRE_RITUAL_6", reqs = []}],
		options = [ {
			code = 'pre_ritual_7_1and2and4', text = "PRE_RITUAL_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  {
			code = 'pre_ritual_7_1and2and4', text = "PRE_RITUAL_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		},  {
			code = 'pre_ritual_7_3_1', text = "PRE_RITUAL_6_OPTION_3", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 4}]}], dialogue_argument = 3, type = 'next_dialogue', 
		},  {
			code = 'pre_ritual_7_1and2and4', text = "PRE_RITUAL_6_OPTION_3", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 4}]}], dialogue_argument = 3, type = 'next_dialogue', 
		},  {
			code = 'pre_ritual_7_1and2and4', text = "PRE_RITUAL_6_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		},  ]
	},
	
	pre_ritual_7_1and2and4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae",
		text = [{text = "PRE_RITUAL_7_1AND2AND4", reqs = [], previous_dialogue_option = [1,2,4]},
		{text = "PRE_RITUAL_7_1AND2AND4", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'pre_ritual_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		},  ]
	},
	
	pre_ritual_7_3_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae",
		text = [{text = "PRE_RITUAL_7_3_1", reqs = []}],
		options = [ {
			code = 'pre_ritual_7_3_2', text = "PRE_RITUAL_7_3_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, {
			code = 'pre_ritual_7_3_2', text = "PRE_RITUAL_7_3_1_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		},  ]
	},
	
	pre_ritual_7_3_2 = {
		custom_background = "amelia_bondage1", # TODO change
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		text = [{text = "PRE_RITUAL_7_3_2", reqs = [], }],
		options = [ {
			code = 'pre_ritual_7_3_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1
		}, ],
	},
	
	pre_ritual_7_3_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae",
		text = [{text = "PRE_RITUAL_7_3_3", reqs = []}],
		options = [ {
			code = 'pre_ritual_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		}, ]
	},
	
	pre_ritual_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae",
		text = [{text = "PRE_RITUAL_8", reqs = [], previous_dialogue_option = 0},
		{text = "PRE_RITUAL_9_1", reqs = [], previous_dialogue_option = 1},
		{text = "PRE_RITUAL_9_2", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'pre_ritual_8', text = "PRE_RITUAL_8_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'pre_ritual_8', text = "PRE_RITUAL_8_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		},  {
			code = 'pre_ritual_10', text = "PRE_RITUAL_8_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		},   ]
	},
	
	pre_ritual_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae",
		text = [{text = "PRE_RITUAL_10", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage7_1'},
			{code = 'remove_active_location'},
			{code = 'add_timed_event', value = "canStartRitual",
		args = [{type = 'action_to_date', date = [1,1], hour = 3, action = "decision"}]}]
		} ]
	},
	
	ritual_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_START", reqs = []}],
		options = [ {
			code = 'ritual_1_1', text = "RITUAL_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ritual_1_2', text = "RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		} ]
	},
	
	ritual_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		common_effects = [{code = 'decision', value = 'putPowder'}],
		text = [{text = "RITUAL_1_1", reqs = []}],
		options = [ {
			code = 'ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_1_2", reqs = []}],
		common_effects = [{code = 'decision', value = 'maePregnant'}],
		options = [ {
			code = 'ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_2", reqs = []}],
		options = [ {
			code = 'ritual_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_3", reqs = []}],
		options = [ {
			code = 'ritual_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_4", reqs = []}],
		options = [ {
			code = 'ritual_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_5", reqs = []}],
		options = [ {
			code = 'ritual_6_1', text = "RITUAL_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'ritual_6_2', text = "RITUAL_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_6_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		common_effects = [{code = 'decision', value = 'letFuck'}],
		text = [{text = "RITUAL_6_1", reqs = []}],
		options = [ {
			code = 'after_ritual_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		}, ]
	},
	
	ritual_6_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "RITUAL_6_2", reqs = []}],
		options = [ {
			code = 'after_ritual_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_start = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "savra", character2 = "leon",
		text = [{text = "AFTER_RITUAL_START", reqs = [], previous_dialogue_option = 0},
		{text = "AFTER_RITUAL_1_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'after_ritual_start_1', text = "AFTER_RITUAL_START_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'after_ritual_1_2', text = "AFTER_RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_start_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra", character2 = "leon",
		text = [{text = "AFTER_RITUAL_START", reqs = [], previous_dialogue_option = 0},
		{text = "AFTER_RITUAL_1_1", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'after_ritual_1_2', text = "AFTER_RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra", character2 = "leon",
		text = [{text = "AFTER_RITUAL_1_2", reqs = []}],
		options = [ {
			code = 'after_ritual_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ]
	},
	
	after_ritual_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_2", reqs = []}],
		options = [ {
			code = 'after_ritual_3', text = "AFTER_RITUAL_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = 0}]
		}, {
			code = 'after_ritual_3', text = "AFTER_RITUAL_2_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = 0}]
		}, ]
	},
	
	after_ritual_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_3", reqs = []}],
		options = [ {
			code = 'after_ritual_4', text = "AFTER_RITUAL_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_4', text = "AFTER_RITUAL_3_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_4', text = "AFTER_RITUAL_3_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
		}, ]
	},
	
	after_ritual_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_4", reqs = []}],
		options = [ {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = []
		}, {
			code = 'after_ritual_5', text = "AFTER_RITUAL_4_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
		}, ]
	},
	
	after_ritual_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_RITUAL_5_2AND3", reqs = [], previous_dialogue_option = [2,3]},
		{text = "AFTER_RITUAL_5_4", reqs = [], previous_dialogue_option = 4},],
		options = [ {
			code = 'after_ritual_variant', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []
		},  ]
	},
	
	after_ritual_variant = {
		variations = [ { # BAD GROUP
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = "decision", value = "letFuck", check = true}], character = "mae", 
			text = [{text = "AFTER_RITUAL_GROUP_1", reqs = []}],
			common_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '-'},
			{code = 'dialogue_counter', name = 'mae_sympathy', op = '-'}],
			options = [ {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_group_2', text = "AFTER_RITUAL_GROUP_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
				bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
			}, ]
		}, { # BAD POWDER
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = "decision", value = "putPowder", check = false}], character = "mae", 
			text = [{text = "AFTER_RITUAL_POWDER_1", reqs = []}],
			common_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '-'}],
			options = [ {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
				bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
			}, {
				code = 'after_ritual_powder_2', text = "AFTER_RITUAL_POWDER_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [], character = "mae", 
			text = [{text = "AFTER_RITUAL_6", reqs = []}],
			options = [ {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
				bonus_effects = [{code = 'dialogue_counter', name = 'mae_sympathy', op = '+'}]
			}, {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			}, {
				code = 'after_ritual', text = "AFTER_RITUAL_6_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		} ]
	},
	
	after_ritual_group_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_GROUP_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_RITUAL_GROUP_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "AFTER_RITUAL_GROUP_2_3", reqs = [], previous_dialogue_option = 3},
		{text = "AFTER_RITUAL_GROUP_2_4", reqs = [], previous_dialogue_option = 4},],
		options = [ {
			code = 'after_ritual_group_3', text = "AFTER_RITUAL_GROUP_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  {
			code = 'after_ritual_group_3', text = "AFTER_RITUAL_GROUP_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_group_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_GROUP_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_RITUAL_GROUP_3_2", reqs = [], previous_dialogue_option = 2},],
		common_effects = [{code = 'remove_decision', value = 'letFuck'}],
		options = [ {
			code = 'after_ritual_variant', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	after_ritual_powder_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = "AFTER_RITUAL_POWDER_2_1AND2AND4", reqs = [], previous_dialogue_option = [1,2,4]},
		{text = "AFTER_RITUAL_POWDER_2_3", reqs = [], previous_dialogue_option = 3}],
		common_effects = [{code = 'decision', value = 'putPowder'}],
		options = [ {
			code = 'after_ritual_variant', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual = {
		variations = [ { # GOOD
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'local_counter', name = 'mae_sympathy', add_stat = 'charm_factor', operant = 'gte', value = 5, check = true}], character = "mae", 
			text = [{text = "AFTER_RITUAL_GOOD_1", reqs = []}],
			options = [ {
				code = 'after_ritual_good_2_1_1', text = "AFTER_RITUAL_GOOD_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'after_ritual_good_2_2', text = "AFTER_RITUAL_GOOD_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			} ]
		}, { # BAD
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'local_counter', name = 'mae_sympathy', add_stat = 'charm_factor', operant = 'lt', value = 5, check = true}], character = "mae", 
			text = [{text = "AFTER_RITUAL_BAD_1_1", reqs = [{type = "decision", value = "maePregnant", check = false}]},
			{text = "AFTER_RITUAL_BAD_1_2", reqs = [{type = "decision", value = "maePregnant", check = true}]}], 
			options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'add_timed_event', value = "canVisitLeon",
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
			} ]
		} ]
	}, 
	
	after_ritual_good_2_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = 'AFTER_RITUAL_GOOD_2_1_1', reqs = []}], 
		options = [ {
			code = 'after_ritual_good_2_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	after_ritual_good_2_1_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", character2 = "savra", 
		text = [{text = 'AFTER_RITUAL_GOOD_2_1_2', reqs = []}], 
		common_effects = [{code = 'make_story_character', value = 'Mae', recruit_from_location = true}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'update_city'},
			{code = 'add_timed_event', value = "canVisitLeon",
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
		}, ] 
	},
	
	after_ritual_good_2_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "mae", 
		text = [{text = 'AFTER_RITUAL_GOOD_2_2', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'add_timed_event', value = "canVisitLeon",
			args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
		}, ]
	},
	
	leon_visit_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_VISIT_START', reqs = []}], 
		options = [ {
			code = 'leon_visit_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	leon_visit_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "savra",
		text = [{text = 'LEON_VISIT_1_1', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage9'}, {code = 'update_city'}]
		}, ]
	},
	
	leon_visit_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'LEON_VISIT_1_2', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	ask_around = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = 'ASK_AROUND', reqs = []}], 
		common_effects = [{code = 'make_quest_location', value = 'leon_forest'},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage10'},
			{code = 'update_city'}]
		}, ]
	},
	
	leon_fight_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "leon",
		text = [{text = 'LEON_FIGHT_1', reqs = []}], 
		options = [ {
			code = 'leon_fight_2', text = "LEON_FIGHT_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'leon_fight_2', text = "LEON_FIGHT_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	leon_fight_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "leon",
		text = [{text = 'LEON_FIGHT_2_1', reqs = [], previous_dialogue_option = 1},
		{text = 'LEON_FIGHT_2_2', reqs = [], previous_dialogue_option = 2}], 
		options = [ {
			code = 'quest_fight', args = 'crazy_leon',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	leon_fight_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "leon",
		text = [{text = 'LEON_FIGHT_3', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage11'},
			{code = 'remove_active_location'},]
		}, ]
	},
	
	savra_talk_start = { 
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage11', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_1', text = "SAVRA_TALK_OPTION_1", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage12', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_4', text = "SAVRA_TALK_OPTION_2", reqs = [{type = 'has_material', material = 'woodmagic', operant = 'gte', value = 50},
				{type = 'has_material', material = 'woodiron', operant = 'gte', value = 25},
				{type = 'has_material', material = 'leathermythic', operant = 'gte', value = 15},], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'active_quest_stage', value = 'sword_artifact_quest', stage = 'stage13', state = true}], character = "savra",
			text = [{text = 'SAVRA_TALK', reqs = []}], 
			options = [ {
				code = 'savra_talk_5', text = "SAVRA_TALK_OPTION_3", select_person = true, reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			} ]
		} ]
	},
	
	savra_talk_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_1', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_2_1', reqs = [], previous_dialogue_option = 1},], 
		options = [ {
			code = 'savra_talk_1', text = "SAVRA_TALK_1_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'savra_talk_2', text = "SAVRA_TALK_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	savra_talk_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_2_2', reqs = []}], 
		options = [ {
			code = 'savra_talk_3', text = "SAVRA_TALK_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		},  {
			code = 'savra_talk_3', text = "SAVRA_TALK_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'savra_talk_3', text = "SAVRA_TALK_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	savra_talk_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_3', reqs = []}], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage12'},]
		}, ]
	},
	
	savra_talk_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_4', reqs = []}], 
		common_effects = [{code = 'material_change', operant = '-', material = 'woodmagic', value = 50},
		{code = 'material_change', operant = '-', material = 'woodiron', value = 25},
		{code = 'material_change', operant = '-', material = 'leathermythic', value = 15}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage13'},]
		},  ]
	}, 
	
	savra_talk_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_5', reqs = []}], 
		options = [ {
			code = 'savra_talk_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 0, type = 'next_dialogue', 
		},  ]
	},
	
	savra_talk_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_6', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'SAVRA_TALK_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'savra_talk_6_1', text = "SAVRA_TALK_6_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		},  {
			code = 'savra_talk_6_2', text = "SAVRA_TALK_6_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		},  {
			code = 'close', text = "SAVRA_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage14'},]
		} ] # TODO create new location
	},
	
	savra_talk_6_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_6', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'SAVRA_TALK_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'savra_talk_6_1', text = "SAVRA_TALK_6_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		},  {
			code = 'close', text = "SAVRA_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage14'},]
		} ] # TODO create new location
	},
	
	savra_talk_6_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "savra",
		text = [{text = 'SAVRA_TALK_6', reqs = [], previous_dialogue_option = 0},
		{text = 'SAVRA_TALK_7_1', reqs = [], previous_dialogue_option = 1},
		{text = 'SAVRA_TALK_7_2', reqs = [], previous_dialogue_option = 2},], 
		options = [ {
			code = 'savra_talk_6_2', text = "SAVRA_TALK_6_OPTION_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'close', text = "SAVRA_TALK_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage14'},]
		} ] # TODO create new location
	},
	
}
