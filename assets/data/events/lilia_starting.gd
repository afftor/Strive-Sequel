var data = {
	lilia_startring_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_STARTING_1", reqs = []}],
		options = [ {
			code = 'lilia_startring_2', text = "LILIA_STARTING_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', master_translate = true,
		}, {
			code = 'lilia_startring_2', text = "LILIA_STARTING_1_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'lilia_startring_2', text = "LILIA_STARTING_1_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_startring_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_STARTING_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "LILIA_RECRUIT_NO", reqs = [], previous_dialogue_option = 6},
		{text = "LILIA_STARTING_2_2", reqs = [], previous_dialogue_option = 0},
		{text = "LILIA_STARTING_2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'lilia_seduction_1', text = "LILIA_STARTING_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', repeat_next_day = true
		}, {
			code = 'lilia_recruit_1', text = "LILIA_STARTING_2_OPTION_2", reqs = [], dialogue_argument = 8, type = 'next_dialogue', repeat_next_day = true
		}, {
			code = 'lilia_startring_2', text = "LILIA_STARTING_2_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'close', text = "LILIA_STARTING_2_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	# if didn't seduce her successfully before
	lilia_seduction_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_SEDUCTION_1", reqs = []},
		{text = "LILIA_SEDUCTION_2_2AND3", reqs = [], previous_dialogue_option = [2,3]}],
		options = [ {
			code = 'lilia_sex_scene_1', text = "LILIA_SEDUCTION_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sex_factor', operant = 'gte', value = 4}]}], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'lilia_seduction_1', text = "LILIA_SEDUCTION_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'lilia_seduction_1', text = "LILIA_SEDUCTION_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, {
			code = 'lilia_seduction_2_4', text = "LILIA_SEDUCTION_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_seduction_2_4 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_SEDUCTION_2_4", reqs = []},
		{text = "LILIA_SEDUCTION_2_4_2AND3", reqs = [], previous_dialogue_option = [2,3]}],
		options = [ {
			code = 'lilia_sex_scene_1', text = "LILIA_SEDUCTION_2_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'lilia_seduction_2_4', text = "LILIA_SEDUCTION_2_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
		}, {
			code = 'lilia_seduction_2_4', text = "LILIA_SEDUCTION_2_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_sex_scene_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_SEX_SCENE_1", reqs = []}],
		options = [ {
			code = 'lilia_sex_scene_1_1', text = "LILIA_SEDUCTION_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		} ]
	},
	
	lilia_recruit_1 = { # TODO add if seduced before
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_RECRUIT_1_1", reqs = []},
		{text = "LILIA_RECRUIT_1_2", reqs = []}],
		options = [ {
			code = 'lilia_recruited', text = "LILIA_RECRUIT_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 5}]}], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'lilia_startring_2', text = "LILIA_RECRUIT_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 5}]}], dialogue_argument = 6, type = 'next_dialogue'
		}, {
			code = 'lilia_startring_2', text = "LILIA_RECRUIT_1_OPTION_2", reqs = [], dialogue_argument = 6, type = 'next_dialogue', 
		}, {
			code = 'lilia_startring_2', text = "LILIA_RECRUIT_1_OPTION_3", reqs = [], dialogue_argument = 6, type = 'next_dialogue', 
		}, {
			code = 'lilia_recruit_1_4', text = "LILIA_RECRUIT_1_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue', 
		}, ]
	},
	
	lilia_recruited = { # TODO add remove event, recruit lilia
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_RECRUITED", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		},  ]
	},
	
	lilia_recruit_1_4 = { # TODO add remove event, recruit lilia
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_RECRUIT_1_4", reqs = []}],
		options = [ {
			code = 'lilia_startring_2', text = "LILIA_RECRUIT_1_4_OPTION_1", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		},  {
			code = 'lilia_recruited', text = "LILIA_RECRUIT_1_4_OPTION_2", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		},  {
			code = 'lilia_startring_2', text = "LILIA_RECRUIT_1_4_OPTION_3", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		}, ]
	},
	
	sick_lilia_start = { # TODO disable lilia
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilia", 
		text = [{text = "SICK_LILIA_START", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage1'}]
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
	
	sick_lilia_3 = { # TODO make xari location
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
	
	sick_lilia_4_1 = { # TODO make xari location
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_4_1", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'sick_lilia_quest', stage = 'stage2'}],
		}, ]
	},
	
	sick_lilia_4_2 = { # TODO make xari location
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_4_2", reqs = []}],
		options = [ {
			code = 'sick_lilia_5', text = "SICK_LILIA_4_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'sick_lilia_5', text = "SICK_LILIA_4_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_5 = { # TODO make xari location
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "myr", 
		text = [{text = "SICK_LILIA_5", reqs = []}],
		options = [ {
			code = 'sick_lilia_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	sick_lilia_6 = { # TODO make xari location
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
			code = 'xari_clothes_3', text = "XARI_CLOTHES_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'xari_clothes_3', text = "XARI_CLOTHES_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "XARI_CLOTHES_3_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'xari_clothes_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
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
	
	xari_clothes_6 = { # TODO add potion and prog quest
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_6", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_5_234 = { # make new loc
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_5_2AND3AND4", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	troll_clothes_1 = { # TODO add reqs to options
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "TROLL_CLOTHES_1", reqs = []}],
		options = [ {
			code = 'troll_clothes_2', text = "TROLL_CLOTHES_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'troll_clothes_2', text = "TROLL_CLOTHES_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = '', text = "TROLL_CLOTHES_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		}, ]
	},
	
	troll_clothes_2 = { 
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "TROLL_CLOTHES_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "TROLL_CLOTHES_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "TROLL_CLOTHES_2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	xari_clothes_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "xari", 
		text = [{text = "XARI_CLOTHES_7", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_mansion_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "LILIA_MANSION_1", reqs = []}],
		options = [ {
			code = 'lilia_mansion_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_mansion_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_MANSION_2", reqs = []}],
		options = [ {
			code = '', text = "", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
}
