var data = {
	zephyra_costume_1 = { 
		variations = [ {
			image = null, tags = ['dialogue_scene','master_translate'],
			reqs = [{type = "location_has_specific_slaves", check = true, value = 1, location = 'elf_capital', reqs = [{code = 'unique', value = 'zephyra'}]}],
			 character = 'zephyra',
			text = [ {text = "ZEPHYRA_COSTUME_2", reqs = []} ],
			options = [ {
				code = 'zephyra_costume_3', reqs = [], text = tr("ZEPHYRA_COSTUME_2_OPTION_1"), type = 'next_dialogue', dialogue_argument = 1
			}, {
				code = 'zephyra_costume_3', reqs = [], text = tr("ZEPHYRA_COSTUME_2_OPTION_2"), type = 'next_dialogue', dialogue_argument = 2
			},{
				code = 'zephyra_costume_3_3', reqs = [], text = tr("ZEPHYRA_COSTUME_2_OPTION_3"), type = 'next_dialogue', dialogue_argument = 3
			},]
		}, {
			image = null, tags = ['dialogue_scene','master_translate'], 
			reqs = [], 
			text = [ {text = "ZEPHYRA_COSTUME_1_1", reqs = [{type = 'dialogue_seen', check = false, value = 'ZEPHYRA_COSTUME_1_1'}]},
			{text = "ZEPHYRA_COSTUME_1_2", reqs = [{type = 'dialogue_seen', check = true, value = 'ZEPHYRA_COSTUME_1_1'}]} ],
			options = [ {
				code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 1, bonus_effects = [{code = 'update_city'}]
			} ]
		}, ]
	},
	
	zephyra_costume_3_3 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra',
		text = [ {text = "ZEPHYRA_COSTUME_3_3", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 1, bonus_effects = [{code = 'update_city'}]
		} ]
	}, 
	
	zephyra_costume_3 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra',
		text = [ {text = "ZEPHYRA_COSTUME_3_1", reqs = [{type = 'decision', value = 'LiraPriestess', check = false}]},
		{text = "ZEPHYRA_COSTUME_3_2", reqs = [{type = 'decision', value = 'LiraPriestess', check = true}]}, ], # check for lira
		options = [ {
			code = 'zephyra_costume_4', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1
		}, ]
	},
	
	zephyra_costume_4 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra',
		text = [ {text = "ZEPHYRA_COSTUME_4", reqs = []} ],
		options = [ {
			code = 'zephyra_costume_5_1', reqs = [], text = tr("ZEPHYRA_COSTUME_4_OPTION_1"), type = 'next_dialogue', dialogue_argument = 1
		}, {
			code = 'zephyra_costume_5_2', reqs = [], text = tr("ZEPHYRA_COSTUME_4_OPTION_2"), type = 'next_dialogue', dialogue_argument = 2
		},{
			code = 'zephyra_costume_3_3', reqs = [], text = tr("ZEPHYRA_COSTUME_4_OPTION_3"), type = 'next_dialogue', dialogue_argument = 3
		},]
	},
	
	zephyra_costume_5_1 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra',
		text = [ {text = "ZEPHYRA_COSTUME_5_1", reqs = []} ],
		options = [ {
			code = 'zephyra_costume_5_2', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1
		}, ]
	},
	
	zephyra_costume_5_2 = { 
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		reqs = [], 
		text = [ {text = "ZEPHYRA_COSTUME_5_2", reqs = []} ],
		options = [ {
			code = 'zephyra_costume_6_1', reqs = [], text = tr("ZEPHYRA_COSTUME_5_OPTION_1"), type = 'next_dialogue', dialogue_argument = 1
		}, {
			code = 'zephyra_costume_6_2', reqs = [], text = tr("ZEPHYRA_COSTUME_5_OPTION_2"), type = 'next_dialogue', dialogue_argument = 1
		}, ]
	},
	
	zephyra_costume_6_1 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra_costume_7',
		text = [ {text = "ZEPHYRA_COSTUME_6_1", reqs = []}],
		options = [ {
			code = 'zephyra_costume_7', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1
		}, ]
	},
	
	zephyra_costume_6_2 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra_costume_7',
		text = [ {text = "ZEPHYRA_COSTUME_6_2", reqs = []}],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 1, bonus_effects = [{code = 'update_city'}]
		} ]
	},
	
	zephyra_costume_7 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra_costume_7',
		text = [ {text = "ZEPHYRA_COSTUME_7", reqs = []}],
		options = [ {
			code = 'zephyra_costume_8', reqs = [], text = tr("ZEPHYRA_COSTUME_7_OPTION_1"), type = 'next_dialogue', dialogue_argument = 1
		}, {
			code = 'zephyra_costume_8', reqs = [], text = tr("ZEPHYRA_COSTUME_7_OPTION_2"), type = 'next_dialogue', dialogue_argument = 2
		}, ]
	},
	
	zephyra_costume_8 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra_costume_7',
		text = [ {text = "ZEPHYRA_COSTUME_8_1", reqs = [], previous_dialogue_option = 1}, 
		 {text = "ZEPHYRA_COSTUME_8_2", reqs = [], previous_dialogue_option = 2}, ],
		options = [ {
			code = 'zephyra_costume_9', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 1
		}, ]
	},
	
	zephyra_costume_9 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra_costume_7',
		text = [ {text = "ZEPHYRA_COSTUME_9", reqs = []}],
		options = [ {
			code = 'zephyra_costume_10', reqs = [], text = tr("ZEPHYRA_COSTUME_9_OPTION_1"), type = 'next_dialogue', dialogue_argument = 1, bonus_effects = [
			{code = 'unique_character_changes', value = 'zephyra', args = [
			{code = 'body_image', operant = '=', value = "zephyra_costume_7_body"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/zephyra_7_prt.png"}]}],
		}, {
			code = 'zephyra_costume_10', reqs = [], text = tr("ZEPHYRA_COSTUME_9_OPTION_2"), type = 'next_dialogue', dialogue_argument = 2
		}, {
			code = 'zephyra_costume_10', reqs = [], text = tr("ZEPHYRA_COSTUME_9_OPTION_3"), type = 'next_dialogue', dialogue_argument = 3
		}, ]
	},
	
	zephyra_costume_10 = { 
		image = null, tags = ['dialogue_scene','master_translate'],
		reqs = [], character = 'zephyra_costume_7',
		text = [ {text = "ZEPHYRA_COSTUME_10_1", reqs = [], previous_dialogue_option = 1}, 
		 {text = "ZEPHYRA_COSTUME_10_2", reqs = [], previous_dialogue_option = 2}, 
		 {text = "ZEPHYRA_COSTUME_10_3", reqs = [], previous_dialogue_option = 3}, ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 1, bonus_effects = [{code = 'update_city'}]
		} ]
	},
}
