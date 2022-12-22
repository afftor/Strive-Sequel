var data = {
	zephyra_recruitment_letter = {
		image = 'letter', tags = ["dialogue_scene"],
		reqs = [{type = 'has_hero', name = 'zephyra', check = false}],
		text = [
			{text = "ZEPHYRA_RECRUITMENT_LETTER", reqs = []}
		],
		common_effects = [{code = 'decision', value = 'startedAct2'}],
		options = [ {
			code = "close", text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = "next_dialogue",
			bonus_effects = [{code = 'progress_quest', value = 'pre_sword_artifact_quest', stage = 'stage1'}, {code = 'rewrite_save'}]
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
			code = "act2_scene", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2
		} ]
	},
	
	zephyra_recruitment_6_bad = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_RECRUITMENT_6_BAD", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	zephyra_sword_1 = {
		image = null, tags = ["dialogue_scene", "master_translate"],
		reqs = [{type = 'has_hero', name = 'zephyra', check = true}], character = "zephyra",
		text = [
			{text = "ZEPHYRA_SWORD_1", reqs = []}
		],
		common_effects = [{code = 'decision', value = 'startedAct2'}],
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
#			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
#			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage2'}]
			code = "act2_scene", text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = "next_dialogue", change_dialogue_type = 2
		} ]
	},
	
	priestess_sword_talk_1  = {
		image = null, tags = ["dialogue_scene", "master_translate", 'blackscreen_transition_common'],
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
		reqs = [], character = 'erlen',
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
		reqs = [], character = 'erlen',
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
		reqs = [], character = 'erlen',
		text = [{text = "PRIESTESS_SWORD_TALK_5", reqs = []}],
		options = [ {
			code = 'priestess_sword_talk_6', text = "PRIESTESS_SWORD_TALK_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'priestess_sword_talk_6', text = "PRIESTESS_SWORD_TALK_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, ]
	},
	
	priestess_sword_talk_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'erlen',
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
		reqs = [], character = 'erlen',
		text = [{text = "PRIESTESS_SWORD_TALK_7_1", reqs = [], previous_dialogue_option = 1},
		{text = "PRIESTESS_SWORD_TALK_7_2", reqs = [], previous_dialogue_option = 2},
		{text = "PRIESTESS_SWORD_TALK_7_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage3'}, {code = 'update_city'}, {code = 'screen_black_transition', value = 1}],
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
		image = 'mae_camp', tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "MAE_MEETING_1", reqs = []}],
		options = [ {
			code = 'mae_meeting_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	mae_meeting_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'mae',
		text = [{text = "MAE_MEETING_1_1", reqs = []}],
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
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage8'},
			{code = 'update_city'},
			{code = 'material_change', operant = '-', material = 'meat', value = 2000},
			{code = 'material_change', operant = '-', material = 'fish', value = 2000},
			{code = 'add_timed_event', value = "canVisitLeon",
		args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "decision"}]}]
		}]
	},
	
	savra_ritual_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = 'savra',
		text = [{text = "SAVRA_RITUAL_START", reqs = []}],
		options = [ {
			code = 'close', text = "SAVRA_RITUAL_START_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage7'},
				{code = 'update_city'},
				{code = 'make_quest_location', value = 'quest_ritual_location'},
			]
		}, {
			code = 'close', text = "SAVRA_RITUAL_START_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			bonus_effects = [{code = 'make_quest_location', value = 'quest_ritual_location'},
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
		options = [ { # TODO add money check and if false add disabled option
			code = 'pre_ritual_4_1_2', text = "PRE_RITUAL_4_1_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'quest_fight', args = 'mae_slavers',
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
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics', operant = 'lt', value = 75}]}],
			text = [{text = "PRE_RITUAL_4_2_2", reqs = []}],
			options = [ {
				code = 'quest_fight', args = 'mae_slavers',
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
			code = 'quest_fight', args = 'mae_slavers',
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
		custom_background = "mae_scene2", # TODO change
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		text = [{text = "PRE_RITUAL_7_3_2", reqs = [], }],
		options = [ {
			code = 'pre_ritual_7_3_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1
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
			bonus_effects = [{code = 'progress_quest', value = 'sword_artifact_quest', stage = 'stage77'},
			{code = 'remove_active_location'},
			{code = 'add_timed_event', value = "canStartRitual",
		args = [{type = 'action_to_date', date = [1,1], hour = 3, action = "decision"}]}]
		} ]
	},
}
