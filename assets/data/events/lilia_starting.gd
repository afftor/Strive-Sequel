var data = {
	lilia_startring_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_STARTING_1", reqs = []}],
		options = [ {
			code = 'lilia_starting_2', text = "LILIA_STARTING_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', master_translate = true,
		}, {
			code = 'lilia_starting_2', text = "LILIA_STARTING_1_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'lilia_starting_2', text = "LILIA_STARTING_1_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_starting_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_STARTING_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "LILIA_STARTING_2_2", reqs = [], previous_dialogue_option = [0, 12]},
		{text = "LILIA_RECRUIT_NO", reqs = [], previous_dialogue_option = 6},
		{text = "LILIA_RECRUIT_NO_RED", reqs = [], previous_dialogue_option = 66},
		{text = "LILIA_STARTING_2_3", reqs = [], previous_dialogue_option = 3},
		{text = "LILIA_SEDUCTION_2_2AND3", reqs = [], previous_dialogue_option = 7},
		{text = "LILIA_SEDUCTION_2_4_2AND3", reqs = [], previous_dialogue_option = 8}],
		options = [ {
			code = 'lilia_sex_scene_0', text = "LILIA_STARTING_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', repeat_next_day = true
		}, {
			code = 'lilia_recruit_1', text = "LILIA_STARTING_2_OPTION_2", reqs = [], dialogue_argument = 8, type = 'next_dialogue', repeat_next_day = true
		}, {
			code = 'lilia_starting_2', text = "LILIA_STARTING_2_OPTION_3", reqs = [], dialogue_argument = 3
		}, {
			code = 'close', text = "LILIA_STARTING_2_OPTION_4", reqs = [], dialogue_argument = 4, 
			bonus_effects = [{code = 'update_location'}]
		}, ]
	},
	
	lilia_sex_scene_0 = {
		variations = [ {
			image = null, tags = ['dialogue_scene', 'master_translate'],
			reqs = [{type = 'decision', value = 'seduced_lilia', check = true}], character = "lilia", 
			text = [{text = "LILIA_SEX_SCENE_0", reqs = []}],
			options = [ {
				code = 'lilia_sex_scene_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				change_dialogue_type = 2
			} ]
		}, { 
			image = null, tags = ['dialogue_scene'],
			reqs = [{type = 'decision', value = 'seduced_lilia', check = false}], character = "lilia", 
			text = [{text = "LILIA_SEDUCTION_1", reqs = []},],
			options = [ {
				code = 'lilia_sex_scene_1', text = "LILIA_SEDUCTION_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 4}]}], dialogue_argument = 10, type = 'next_dialogue',
			}, {
				code = 'lilia_starting_2', text = "LILIA_SEDUCTION_1_OPTION_2", reqs = [], dialogue_argument = 7, type = 'next_dialogue', 
			}, {
				code = 'lilia_starting_2', text = "LILIA_SEDUCTION_1_OPTION_3", reqs = [], dialogue_argument = 7, type = 'next_dialogue', 
			}, {
				code = 'lilia_seduction_2_4', text = "LILIA_SEDUCTION_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
			}, ]
		} ]
	},
	
	lilia_seduction_2_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_SEDUCTION_2_4", reqs = [], previous_dialogue_option = 4},
		],
		options = [ {
			code = 'lilia_sex_scene_1', text = "LILIA_SEDUCTION_2_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'lilia_starting_2', text = "LILIA_SEDUCTION_2_4_OPTION_2", reqs = [], dialogue_argument = 8, type = 'next_dialogue', 
		}, {
			code = 'lilia_starting_2', text = "LILIA_SEDUCTION_2_4_OPTION_3", reqs = [], dialogue_argument = 8, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_sex_scene_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_SEX_SCENE_1", reqs = []}],
		common_effects = [{code = 'decision', value = 'seduced_lilia'}],
		options = [ {
			code = 'lilia_sex_scene_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			change_dialogue_type = 2
		} ]
	},
	lilia_sex_scene_1_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		custom_background = "lilia_sex_1",
		text = [{text = "LILIA_SEX_SCENE_1_1", reqs = []}],
		common_effects = [],
		options = [ {
			code = 'lilia_sex_scene_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
#	lilia_sex_scene_1_2 = {
#		image = null, tags = ['dialogue_scene', 'master_translate'],
#		reqs = [], character = "lilia", 
#		text = [{text = "LILIA_SEX_SCENE_1_2", reqs = []}],
#		common_effects = [],
#		options = [ {
#			code = 'lilia_sex_scene_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
#		} ]
#	},
	lilia_sex_scene_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "LILIA_SEX_SCENE_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_1",
		options = [ {
			code = 'lilia_sex_scene_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	lilia_sex_scene_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "LILIA_SEX_SCENE_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_2",
		options = [ {
			code = 'lilia_starting_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 12, type = 'next_dialogue', 
			change_dialogue_type = 1
		} ]
	},
	
	lilia_recruit_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_RECRUIT_1_1", reqs = [{type = 'decision', value = 'seduced_lilia', check = false}]},
		{text = "LILIA_RECRUIT_1_2", reqs = [{type = 'decision', value = 'seduced_lilia', check = true}]}],
		options = [ {
			code = 'lilia_recruited', text = "LILIA_RECRUIT_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 5}]}], dialogue_argument = 11, type = 'next_dialogue'
		}, {
			code = 'lilia_starting_2', text = "LILIA_RECRUIT_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 5}]}], dialogue_argument = 66, type = 'next_dialogue'
		}, {
			code = 'lilia_starting_2', text = "LILIA_RECRUIT_1_OPTION_2", reqs = [], dialogue_argument = 6, type = 'next_dialogue', 
		}, {
			code = 'lilia_starting_2', text = "LILIA_RECRUIT_1_OPTION_3", reqs = [], dialogue_argument = 6, type = 'next_dialogue', 
		}, {
			code = 'lilia_recruit_1_4', text = "LILIA_RECRUIT_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_recruited = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_RECRUITED", reqs = [], previous_dialogue_option = 1},
		{text = "LILIA_RECRUITED_GREEN", reqs = [], previous_dialogue_option = 11},],
		common_effects = [{code = 'make_story_character', value = 'Lilia', recruit_from_location = true},
		{code = 'decision', value = 'recruited_lilia'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'add_timed_event', value = "sick_lilia_start", args = [{type = 'add_to_date', date = [2,2], hour = 1}]},
				{code = 'update_location'},
			]
		}, ]
	},
	
	lilia_recruit_1_4 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_RECRUIT_1_4", reqs = []}],
		options = [ {
			code = 'lilia_starting_2', text = "LILIA_RECRUIT_1_4_OPTION_1", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		},  {
			code = 'lilia_recruited', text = "LILIA_RECRUIT_1_4_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		},  {
			code = 'lilia_starting_2', text = "LILIA_RECRUIT_1_4_OPTION_3", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		}, ]
	},
	
	sick_lilia_start = { 
		image = 'lilia_sick', tags = ['dialogue_scene', 'master_translate'],
		reqs = [], #character = "lilia", 
		text = [{text = "SICK_LILIA_START", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage1'},
			{code = 'affect_unique_character', name = 'lilia', type = 'set_availability', value = false},
			{code = 'update_mansion'}]
		}, ]
	},
	
	sick_lilia_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_1", reqs = []}],
		options = [ {
			code = 'sick_lilia_2', text = "SICK_LILIA_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'sick_lilia_2', text = "SICK_LILIA_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "SICK_LILIA_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'sick_lilia_3', text = "SICK_LILIA_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'sick_lilia_3', text = "SICK_LILIA_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_3 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "SICK_LILIA_3_2", reqs = [], previous_dialogue_option = 2}],
		common_effects = [{code = 'make_quest_location', value = 'quest_mages_xari'}],
		options = [ {
			code = 'sick_lilia_4_1', text = "SICK_LILIA_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'sick_lilia_4_2', text = "SICK_LILIA_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_4_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_4_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage2'}],
		}, ]
	},
	
	sick_lilia_4_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_4_2", reqs = []}],
		options = [ {
			code = 'sick_lilia_5', text = "SICK_LILIA_4_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'sick_lilia_5', text = "SICK_LILIA_4_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_5 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_5", reqs = []}],
		options = [ {
			code = 'sick_lilia_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_6 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_6", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage2'}],
		}, ]
	},
	
	xari_clothes_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_1", reqs = []}],
		options = [ {
			code = 'xari_clothes_2', text = "XARI_CLOTHES_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'xari_clothes_2', text = "XARI_CLOTHES_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_2", reqs = []}],
		options = [ {
			code = 'xari_clothes_3_1', text = "XARI_CLOTHES_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'xari_clothes_3_2', text = "XARI_CLOTHES_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_3_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_3_1", reqs = []}],
		options = [ {
			code = 'xari_clothes_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_3_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_4", reqs = []}],
		options = [ {
			code = 'xari_clothes_5_1', text = "XARI_CLOTHES_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'xari_clothes_5_234', text = "XARI_CLOTHES_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'xari_clothes_5_234', text = "XARI_CLOTHES_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, {
			code = 'xari_clothes_5_234', text = "XARI_CLOTHES_4_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_5_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_5_1", reqs = []}],
		options = [ {
			code = 'xari_clothes_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_6 = { 
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_6", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage5'},
				{code = 'plan_mansion_event', value = 'lilia_mansion_1'},
				{code = 'update_location'},
				{code = 'remove_quest_location', value = 'quest_mages_xari'},
			]
		}, ]
	},
	
	xari_clothes_5_234 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_5_2AND3AND4", reqs = []},
		{text = "", reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = 'decision', value = 'potion_wit_magic'}]},
		{text = "", reqs = [], previous_dialogue_option = 3, bonus_effects = [{code = 'decision', value = 'potion_tame'}]},
		{text = "", reqs = [], previous_dialogue_option = 4, bonus_effects = [{code = 'decision', value = 'potion_sex'}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage3'},
			{code = 'make_quest_location', value = 'quest_troll_cave_location'}]
		}, ]
	},
	
	troll_clothes_1 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "TROLL_CLOTHES_1", reqs = []}],
		options = [ {
			code = 'troll_clothes_2', text = "TROLL_CLOTHES_1_OPTION_1", reqs = [{type = 'has_material', material = 'meat', operant = 'gte', value = 50}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'troll_clothes_2', text = "TROLL_CLOTHES_1_OPTION_2", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'hunter', check = true}]}], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'troll_clothes_1', disabled = true,
			text = "SPECIAL_ACTION_CLASS", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'hunter', check = false}]}], dialogue_argument = 6, type = 'next_dialogue',
		}, {
			code = 'quest_fight', args = 'troll_clothes', text = "TROLL_CLOTHES_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage35'},
			]
		}, ]
	},
	
	troll_clothes_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "TROLL_CLOTHES_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "TROLL_CLOTHES_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage4'},
				{code = 'update_location'}
			]
		}, ]
	},
	
	troll_clothes_win = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "TROLL_CLOTHES_2_3", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage4'},
				{code = 'update_location'}
			]
		}, ]
	},
	
	xari_clothes_7 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_7", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage5'},
				{code = 'plan_mansion_event', value = 'lilia_mansion_1'},
				{code = 'update_location'},
				{code = 'remove_quest_location', value = 'quest_mages_xari'},
				{code = 'remove_quest_location', value = 'quest_troll_cave_location'}
			]
		}, ]
	},
	
	lilia_mansion_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [{text = "LILIA_MANSION_1", reqs = [], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'set_availability', value = true},] },
			{text = "", reqs = [{type = 'decision', value = 'potion_tame', check = true}], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'tame_factor', value = 1}]},
			{text = "", reqs = [{type = 'decision', value = 'potion_sex', check = true}], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'sexuals_factor', value = 1}]},
			{text = "", reqs = [{type = 'decision', value = 'potion_wit_magic', check = true}], bonus_effects = [{code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'wits_factor', value = 1}, {code = 'affect_unique_character', name = 'lilia', type = 'stat', stat = 'magic_factor', value = 1}]},
		],
		options = [ {
			code = 'lilia_mansion_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_mansion_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'	],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_MANSION_2", reqs = []}],
		options = [ {
			code = 'lilia_mansion_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			change_dialogue_type = 2
		}, ]
	},
	
	lilia_mansion_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LILIA_MANSION_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_3",
		options = [ {
			code = 'lilia_mansion_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_mansion_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "LILIA_MANSION_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "lilia_sex_4",
		options = [ {
			code = 'lilia_mansion_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			change_dialogue_type = 1
		}, ]
	},
	
	lilia_mansion_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "LILIA_MANSION_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'complete_quest', value = 'sick_lilia_quest'},
			]
		}, ]
	},
}
