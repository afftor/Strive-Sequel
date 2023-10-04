var data = {
	zephyra_quest_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", 
		text = [{text = "ZEPHYRA_QUEST_1", reqs = []}],
		options = [ {
			code = 'zephyra_quest_2', text = "ZEPHYRA_QUEST_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'zephyra_bath_quest', stage = 'stage0'}]
		}, { 
			code = 'close', text = "ZEPHYRA_QUEST_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", 
		text = [{text = "ZEPHYRA_QUEST_2", reqs = []}],
		options = [ {
			code = 'zephyra_quest_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_3 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], character = "zephyra", character2 = "ginny",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_3", reqs = []}],
		options = [ {
			code = 'zephyra_quest_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", character2 = "ginny",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_4", reqs = []}],
		options = [ {
			code = 'zephyra_quest_5', text = "ZEPHYRA_QUEST_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_5', text = "ZEPHYRA_QUEST_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "ginny",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_5_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_QUEST_5_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_quest_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_6 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		reqs = [], character = "zephyra", 
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_6", reqs = []}],
		options = [ {
			code = 'zephyra_quest_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_7 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", 
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_7", reqs = []}],
		options = [ {
			code = 'zephyra_quest_8', text = "ZEPHYRA_QUEST_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_8', text = "ZEPHYRA_QUEST_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_8', text = "ZEPHYRA_QUEST_7_OPTION_3", reqs = [{type = 'has_money', value = 300}], dialogue_argument = 3, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_8 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_8_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_QUEST_8_2_GOOD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'gte', value = 50}]}], previous_dialogue_option = 2,
		bonus_effects = [
				{code = 'unique_character_changes', value = 'zephyra', args = [
					{code = 'loyalty', operant = '+', value = 30},
					]}],}, 
		{text = "ZEPHYRA_QUEST_8_2_BAD", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 50}]}], previous_dialogue_option = 2}, 
		{text = "ZEPHYRA_QUEST_8_3", reqs = [], previous_dialogue_option = 3, bonus_effects = [{code = 'money_change', operant = '-', value = 300}, 
			{code = 'unique_character_changes', value = 'zephyra', args = [
					{code = 'loyalty', operant = '+', value = 50},
					]}]}],
		options = [ { 
			code = 'zephyra_daisy_1', text = "DIALOGUECONTINUE", reqs = [{type = "quest_completed", name = "daisy_training", check = true}, {type = 'unique_character_checks', name = 'daisy', value = [{code = 'is_free', check = true}]},], dialogue_argument = 1, type = 'next_dialogue',
		}, { 
			code = 'zephyra_visitor_1', text = "DIALOGUECONTINUE", reqs = [{type = "quest_completed", name = "daisy_training", check = false}, {type = 'unique_character_checks', name = 'daisy', value = [{code = 'is_free', check = false}], orflag = true},], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_daisy_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra", unique_character2 = "daisy",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_DAISY_1", reqs = []}],
		options = [ {
			code = 'zephyra_daisy_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_daisy_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", unique_character2 = "daisy",
		custom_background = "church_event",
		text = [
			{text = "ZEPHYRA_DAISY_2_1", reqs = [{type = 'dialogue_seen', check = true, value = 'TRAINING_COMPLETE_FUCKTOY_REPLY_0'}]},
			{text = "ZEPHYRA_DAISY_2_2", reqs = [{type = 'dialogue_seen', check = true, value = 'TRAINING_COMPLETE_SERVE_REPLY_0'}, {type = 'dialogue_seen', check = true, value = 'TRAINING_COMPLETE_SEX_REPLY_0', orflag = true} ]},
		],
		options = [ {
			code = 'zephyra_visitor_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_visitor_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_VISITOR_1", reqs = []}],
		options = [ {
			code = 'zephyra_visitor_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_visitor_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_VISITOR_2", reqs = []}],
		options = [ {
			code = 'zephyra_visitor_3', text = "ZEPHYRA_VISITOR_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_visitor_3', text = "ZEPHYRA_VISITOR_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_visitor_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_VISITOR_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_VISITOR_3_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_man_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_man_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_MAN_1", reqs = []}],
		options = [ {
			code = 'zephyra_man_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_man_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_MAN_2", reqs = []}],
		options = [ {
			code = 'zephyra_man_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_man_3 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_MAN_3", reqs = []}],
		options = [ {
			code = 'zephyra_man_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_man_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_MAN_4", reqs = []}],
		options = [ {
			code = 'zephyra_quest_9', text = "ZEPHYRA_MAN_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_9', text = "ZEPHYRA_MAN_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_9 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_9_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_QUEST_9_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_quest_10', text = "ZEPHYRA_QUEST_9_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_10', text = "ZEPHYRA_QUEST_9_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'zephyra_quest_10', text = "ZEPHYRA_QUEST_9_OPTION_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_10 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "zephyra",
		custom_background = "church_event",
		text = [{text = "ZEPHYRA_QUEST_10_1", reqs = [], previous_dialogue_option = 1, bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'loyalty', operant = '-', value = 30},
					]}],},
		{text = "ZEPHYRA_QUEST_10_2", reqs = [], previous_dialogue_option = 2, bonus_effects = [
				{code = 'unique_character_changes', value = 'anastasia', args = [
					{code = 'loyalty', operant = '+', value = 40},
					]}],},
		{text = "ZEPHYRA_QUEST_10_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'zephyra_quest_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_quest_11 = {
		variations = [ {
				image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
				reqs = [{type = "has_upgrade", name = 'resting', value = 1}], character = "zephyra", character2 = "ginny",
				custom_background = "church_event",
				text = [{text = "ZEPHYRA_QUEST_11", reqs = []}],
				options = [ {
					code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
					bonus_effects = [{code = 'progress_quest', value = 'zephyra_bath_quest', stage = 'stage2'},
					{code = 'add_timed_event', value = "zephyra_bath_1", args = [{type = 'add_to_date', date = [1,1], hour = 3}]}] # visit bath
				}, ]
			}, {
				image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
				reqs = [], character = "zephyra", character2 = "ginny",
				custom_background = "church_event",
				text = [{text = "ZEPHYRA_QUEST_11", reqs = []}],
				options = [ {
					code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
					bonus_effects = [{code = 'progress_quest', value = 'zephyra_bath_quest', stage = 'stage1'},
					{code = 'add_timed_event', value = "zephyra_bath_1", args = [{type = 'add_to_date', date = [1,1], hour = 3}]}] # build and visit bath
				}, ]
			}, 
		]
	},
	
	zephyra_bath_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = "has_upgrade", name = 'resting', value = 1, negative = 'repeat_next_day'}, {type = 'unique_character_checks', name = 'zephyra', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'}], character = "zephyra",
		text = [{text = "ZEPHYRA_BATH_1", reqs = []}],
		options = [ {
			code = 'zephyra_bath_2', text = "ZEPHYRA_BATH_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_bath_2', text = "ZEPHYRA_BATH_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	zephyra_bath_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_BATH_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_BATH_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'zephyra_bath_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ]
	},
	
	zephyra_bath_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "ZEPHYRA_BATH_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_bath_1",
		options = [ {
			code = 'zephyra_bath_4', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1
		}, ]
	},
	
	zephyra_bath_4 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "ZEPHYRA_BATH_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_bath_2",
		options = [ {
			code = 'zephyra_bath_5', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1,
		}, ]
	},
	
	zephyra_bath_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "ZEPHYRA_BATH_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_bath_4",
		options = [ {
			code = 'zephyra_bath_6', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1, change_dialogue_type = 1, close_speed = 1.0
		}, ]
	},
	
	zephyra_bath_6 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "zephyra",
		text = [{text = "ZEPHYRA_BATH_6", reqs = []},
		{text = '', reqs = [{type = "quest_completed", name = "getting_lira_quest", check = true}], bonus_effects = [{code = 'add_timed_event', value = "zephyra_painting_1", args = [{type = 'add_to_date', date = [2,5], hour = 1}]}]}
		],
		common_effects = [ {
			code = 'unique_character_changes',
			value = 'zephyra',
			args = [
				{code = 'take_virginity', type = 'vaginal', partner = 'master'}
			]
		} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'complete_quest', value = 'zephyra_bath_quest'},
				{code = 'add_timed_event', value = "zephyra_lilia_1", args = [{type = 'add_to_date', date = [5,10], hour = 2}]},
				]
			}],
	},
	
	
	zephyra_lilia_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'unique_character_checks', name = 'lilia', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'}],
		character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_1", reqs = []}],
		options = [ {
			code = 'zephyra_lilia_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	zephyra_lilia_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_2", reqs = []}],
		options = [ {
			code = 'zephyra_lilia_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	zephyra_lilia_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_3", reqs = []}],
		options = [ {
			code = 'zephyra_lilia_4_1', text = "ZEPHYRA_LILIA_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, 
		{
			code = 'zephyra_lilia_4_2', text = "ZEPHYRA_LILIA_3_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, 
		{
			code = 'zephyra_lilia_4_3', text = "ZEPHYRA_LILIA_3_OPTION_3", reqs = [{type = 'has_money', value = 100}], dialogue_argument = 1, type = 'next_dialogue', 
		}, 
		]
	},
	zephyra_lilia_4_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_4_1", reqs = [], bonus_effects = [{code = 'money_change', operant = '-', value = 100}],}],
		options = [{ 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'unique_character_changes', value = 'zephyra', args = [{code = 'loyalty', operant = '+', value = 50},
			]}]
		}, ]
	},
	zephyra_lilia_4_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_4_2", reqs = []}],
		options = [{ 
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'unique_character_changes', value = 'lilia', args = [{code = 'loyalty', operant = '+', value = 50},
			]}]
		}, ]
	},
	zephyra_lilia_4_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_4_3", reqs = []}],
		options = [ {
			code = 'zephyra_lilia_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	zephyra_lilia_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		unlocked_gallery_seq = "zephyra_lilia",
		save_scene_to_gallery = true,
		reqs = [], character = "zephyra", character2 = "lilia",
		text = [{text = "ZEPHYRA_LILIA_5", reqs = []}],
		options = [ {
			code = 'zephyra_lilia_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ]
	},
	zephyra_lilia_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = "ZEPHYRA_LILIA_6", reqs = []}],
		custom_background = "blackscreen",
		options = [ {
			code = 'zephyra_lilia_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	zephyra_lilia_7 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [],
		text = [{text = "ZEPHYRA_LILIA_7", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_lilia_1",
		options = [ {
			code = 'zephyra_lilia_8', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1,
		}, ]
	},
	zephyra_lilia_8 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "ZEPHYRA_LILIA_8", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_lilia_2",
		options = [ {
			code = 'zephyra_lilia_9', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1,
		}, ]
	},
	zephyra_lilia_9 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "ZEPHYRA_LILIA_9", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "zephyra_lilia_3",
		options = [ {code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'} ]
	},
}
