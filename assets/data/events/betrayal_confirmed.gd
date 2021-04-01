var data = {
	betrayal_confirmed_advance = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "BETRAYAL_CONFIRMED_ADVANCE", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'betrayal_confirmed_rebels_1',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1,
		} ],
	},
	
	betrayal_confirmed_rebels_1_win = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "BETRAYAL_CONFIRMED_1", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		} ],
	},
	
	betrayal_confirmed_1 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_2", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1
		}],
	},
	
	betrayal_confirmed_2 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_3", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1
		}],
	},
	
	betrayal_confirmed_3 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [{text = "BETRAYAL_CONFIRMED_4", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'betrayal_confirmed_rebels_2',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_rebels_2_win = {
		image = null, tags = ['dialogue_scene'], character = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_5", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		} ],
	},
	
	betrayal_confirmed_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_6", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_5 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_7", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_6 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_8", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_7 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], character = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_8", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_8 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_9", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_9 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "BETRAYAL_CONFIRMED_10", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_10 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], character = "duncan", character2 = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_11", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_11', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_11 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_12", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_12', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_12 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan", character2 = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_13", reqs = []}],
		options = [ {
			code = 'betrayal_confirmed_13', text = "BETRAYAL_CONFIRMED_OPTION_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'betrayal_confirmed_13', text = "BETRAYAL_CONFIRMED_OPTION_2", reqs = [], dialogue_argument = 2,
		}],
	},
	
	betrayal_confirmed_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan", character2 = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_14", reqs = []}],
		common_effects = [{code = 'decision', value = "DivineSymbolStart"}],
		options = [ {
			code = 'close', text = "BETRAYAL_CONFIRMED_OPTION_3", reqs = [], dialogue_argument = 1,
		}, {
			code = 'close', text = "BETRAYAL_CONFIRMED_OPTION_4", reqs = [], dialogue_argument = 2,
		}, {
			code = 'close', text = "BETRAYAL_CONFIRMED_OPTION_5", reqs = [], dialogue_argument = 2,
		}],
	},
	
	divine_symbol_1 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene'], character = "ginny",
		text = [{text = "DIVINE_SYMBOL_1", reqs = []}],
		options = [ {
			code = 'divine_symbol_2', text = "DIVINE_SYMBOL_OPTION_2", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_2 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene'], character = "ginny",
		text = [{text = "DIVINE_SYMBOL_2", reqs = [], previous_dialogue_option = 1},
		{text = "DIVINE_SYMBOL_3", reqs = [], previous_dialogue_option = 3},],
		options = [ {
			code = 'divine_symbol_2', text = "DIVINE_SYMBOL_OPTION_3", reqs = [], dialogue_argument = 3,
		}, {
			code = 'divine_symbol_3', text = "DIVINE_SYMBOL_OPTION_4", reqs = [], dialogue_argument = 4,
		}, ],
	},
	
	divine_symbol_3 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene'], character = "ginny",
		text = [{text = "DIVINE_SYMBOL_4", reqs = []}],
		options = [ {
			code = 'divine_symbol_4', text = "DIVINE_SYMBOL_OPTION_5", reqs = [], dialogue_argument = 3,
		}, {
			code = 'divine_symbol_4', text = "DIVINE_SYMBOL_OPTION_6", reqs = [], dialogue_argument = 4,
		}, ],
	},
	
	divine_symbol_4 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene'], character = "ginny",
		common_effects = [{code = 'progress_quest', value = 'divine_symbol_quest', stage = 'stage1'}],
		text = [{text = "DIVINE_SYMBOL_5", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 3,
		}],
	},
	
	divine_symbol_5 = {
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "ginny",
		common_effects = [{code = 'complete_quest', value = 'divine_symbol_quest'},
		{code = 'material_change', operant = '-', material = 'divine_symbol', value = 1},
		{code = 'material_change', operant = '+', material = 'blessed_divine_symbol', value = 1},],
		text = [{text = "DIVINE_SYMBOL_6", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3,
		}],
	},
	
	# duncan and myr part
	divine_symbol_6 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "myr",
		text = [{text = "DIVINE_SYMBOL_7", reqs = []}],
		options = [ {
			code = 'divine_symbol_7', text = "DIVINE_SYMBOL_OPTION_8", 
			reqs = [{type = 'has_material', operant = 'gte', value = 1, material = 'blessed_divine_symbol'}], 
			dialogue_argument = 1
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3,
		}],
	},
	
	divine_symbol_7 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "myr",
		text = [{text = "DIVINE_SYMBOL_8", reqs = []}],
		options = [ {
			code = 'divine_symbol_8', text = "DIVINE_SYMBOL_OPTION_9", reqs = [], dialogue_argument = 2,
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3,
		}],
	},
	
	divine_symbol_8 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "myr",
		text = [{text = "DIVINE_SYMBOL_9", reqs = []}],
		options = [ {
			code = 'divine_symbol_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 3,
		}],
	},
	
	divine_symbol_9 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [{text = "DIVINE_SYMBOL_10", reqs = []}],
		options = [ {
			code = 'divine_symbol_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 3,
		}],
	},
	
	divine_symbol_10 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_11", reqs = []}],
		options = [ {
			code = 'divine_symbol_11', text = "DIVINE_SYMBOL_OPTION_10", reqs = [], dialogue_argument = 1,
		}, {
			code = 'quest_fight', args = 'patrol', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 2,
		}],
	},
	
	divine_symbol_11 = {
		variations = [ {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 50}]}],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "DIVINE_SYMBOL_12", reqs = []}],
			options = [ {
				code = 'divine_symbol_12', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1
			}],
		}, {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'physics_factor', operant = 'lt', value = 50}]}],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "DIVINE_SYMBOL_13", reqs = []}],
			options = [ {
				code = 'quest_fight', args = 'patrol', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1
			}],
		}
		]
	},
	
	patrol_win = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_14", reqs = []}],
		options = [ {
			code = 'divine_symbol_12', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_12 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_15", reqs = []}],
		common_effects = [{code = 'dialogue_counter', name = 'search_attempts', op = '+'}, 
		{code = 'dialogue_counter', name = 'search_attempts', op = '-'}], #init counter
		options = [ {
			code = 'divine_symbol_13', text = "DIVINE_SYMBOL_OPTION_11", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_13 = {
		variations = [ {
			reqs = [{type = 'wits_factor_check', from = 0, to = 100, value = 20}, 
			{type = 'local_counter', name = 'search_attempts', operant = 'lt', value = 4, check = true}],
			common_effects = [{code = 'dialogue_counter', name = 'search_attempts', op = '+'}],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "DIVINE_SYMBOL_16", reqs = []}],
			options = [ {
				code = 'quest_fight', args = 'wrong_building_rebels', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 4
			}],
		}, {
			reqs = [],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "DIVINE_SYMBOL_18", reqs = []}],
			options = [ {
				code = 'divine_symbol_15', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1
			}],
		}
		]
	},
	
	wrong_building_rebels_win = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_17", reqs = []}],
		options = [ {
			code = 'divine_symbol_13', text = "DIVINE_SYMBOL_OPTION_11", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_14 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_18", reqs = []}],
		options = [ {
			code = 'divine_symbol_15', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_15 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_19", reqs = []}],
		options = [ {
			code = 'divine_symbol_16', text = "DIVINE_SYMBOL_OPTION_12", reqs = [], dialogue_argument = 1,
		},{
			code = 'divine_symbol_17', text = "DIVINE_SYMBOL_OPTION_13", reqs = [], dialogue_argument = 2,
		}],
	},
	
	divine_symbol_16 = {
		variations = [ {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 5}]}], 
			image = null, tags = ['dialogue_scene'],
			text = [{text = "DIVINE_SYMBOL_20", reqs = []}],
			options = [ {
				code = 'divine_symbol_18', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4
			}],
		}, {
			reqs = [],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "", reqs = []}],
			options = [ {
				code = 'quest_fight', args = '', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1
			}],
		}
		]
	},
	
	#fight them
	divine_symbol_17 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_21", reqs = []}],
		options = [ {
			code = 'quest_fight', args = '', text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1,
		}],
	},
	
	two_guards_win = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "DIVINE_SYMBOL_22", reqs = []}],
		options = [ {
			code = 'divine_symbol_18', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_18 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_23", reqs = []}],
		options = [ {
			code = 'divine_symbol_19', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_19 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_24", reqs = []}],
		options = [ {
			code = 'divine_symbol_20', text = "DIVINE_SYMBOL_OPTION_14", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_20', text = "DIVINE_SYMBOL_OPTION_15", reqs = [], dialogue_argument = 2,
		}, {
			code = 'divine_symbol_20', text = "DIVINE_SYMBOL_OPTION_16", reqs = [], dialogue_argument = 3,
		}, ],
	},
	
	divine_symbol_20 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_25", reqs = [], previous_dialogue_option = 1}, 
		{text = "DIVINE_SYMBOL_26", reqs = [], previous_dialogue_option = 2}, 
		{text = "DIVINE_SYMBOL_27", reqs = [], previous_dialogue_option = 3}, 
		{text = "DIVINE_SYMBOL_28", reqs = []}, ],
		options = [ {
			code = 'divine_symbol_21', text = "DIVINE_SYMBOL_OPTION_18", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_21', text = "DIVINE_SYMBOL_OPTION_19", reqs = [], dialogue_argument = 2,
		}, ],
	},
	
	divine_symbol_21 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_29", reqs = [], previous_dialogue_option = 1}, 
		{text = "DIVINE_SYMBOL_30", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'divine_symbol_22', text = "DIVINE_SYMBOL_OPTION_20", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_22', text = "DIVINE_SYMBOL_OPTION_21", reqs = [], dialogue_argument = 2,
		}, ],
	},
	
	divine_symbol_22 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_31", reqs = []}],
		options = [ {
			code = 'divine_symbol_23', text = "DIVINE_SYMBOL_OPTION_22", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_23', text = "DIVINE_SYMBOL_OPTION_23", reqs = [], dialogue_argument = 1,
		}, ],
	},
	
	divine_symbol_23 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_32", reqs = [], previous_dialogue_option = 1}, 
		{text = "DIVINE_SYMBOL_33", reqs = [], previous_dialogue_option = 2}, 
		{text = "DIVINE_SYMBOL_34", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'divine_symbol_23', text = "DIVINE_SYMBOL_OPTION_24", reqs = [], dialogue_argument = 2,
		}, {
			code = 'divine_symbol_23', text = "DIVINE_SYMBOL_OPTION_25", reqs = [], dialogue_argument = 3,
		}, {
			code = 'divine_symbol_24', text = "DIVINE_SYMBOL_OPTION_26", reqs = [
			{type = 'dialogue_seen', check = true, value = 'DIVINE_SYMBOL_33'},
			{type = 'dialogue_seen', check = true, value = 'DIVINE_SYMBOL_34'} ], dialogue_argument = 4,
		}, ],
	},
	
	divine_symbol_24 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_35", reqs = []}],
		options = [ {
			code = 'divine_symbol_27', text = "DIVINE_SYMBOL_OPTION_27", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_29', text = "DIVINE_SYMBOL_OPTION_28", reqs = [], dialogue_argument = 2,
		}, {
			code = 'divine_symbol_25', text = "DIVINE_SYMBOL_OPTION_29", reqs = [], dialogue_argument = 3,
		}, ],
	},
	
	divine_symbol_25 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_36", reqs = []}],
		options = [ {
			code = 'divine_symbol_26', text = "DIVINE_SYMBOL_OPTION_30", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_28', text = "DIVINE_SYMBOL_OPTION_31", reqs = [], dialogue_argument = 2,
		}, {
			code = 'divine_symbol_29', text = "DIVINE_SYMBOL_OPTION_32", reqs = [], dialogue_argument = 3,
		}, ],
	},
	
	#recruit and type=slave
	divine_symbol_26 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_37", reqs = []}],
		common_effects = [{code = 'make_story_character', value = 'Zephyra', recruit_from_location = true, slave_category = 'slave'},
		{code = 'decision', value = 'ZephyraRecruited'}, {code = 'decision', value = 'ZephyraEnslaved'}],
		options = [ {
			code = 'divine_symbol_30', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	#=Alright, why not
	divine_symbol_27 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_38", reqs = []}],
		common_effects = [{code = 'make_story_character', value = 'Zephyra', recruit_from_location = true},
		{code = 'decision', value = 'ZephyraRecruited'}],
		options = [ {
			code = 'divine_symbol_30', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	#=That was a joke, you can join me
	divine_symbol_28 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_39", reqs = []}],
		common_effects = [{code = 'make_story_character', value = 'Zephyra', recruit_from_location = true},
		{code = 'decision', value = 'ZephyraRecruited'}],
		options = [ {
			code = 'divine_symbol_30', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	#=No I can't trust you/No, after all I can't trust you
	divine_symbol_29 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [{text = "DIVINE_SYMBOL_40", reqs = []}],
		options = [ {
			code = 'divine_symbol_30', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	#=Continue
	divine_symbol_30 = {
		image = null, tags = ['dialogue_scene'], #character = "zephyra",
		text = [ {text = "DIVINE_SYMBOL_41", reqs = []}, 
		{text = "DIVINE_SYMBOL_42", reqs = [{type = 'decision', value = 'ZephyraRecruited', check = false}]},
		{text = "DIVINE_SYMBOL_43", reqs = [{type = 'decision', value = 'ZephyraRecruited', check = true}]} ],
		options = [ {
			code = 'divine_symbol_31', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_31 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		text = [ {text = "DIVINE_SYMBOL_44", reqs = []}],
		options = [ {
			code = 'divine_symbol_32', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_32 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], character = "greg", character2 = "aire",
		text = [ {text = "DIVINE_SYMBOL_45", reqs = []}],
		options = [ {
			code = 'divine_symbol_33', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_33 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], character = "myr", character2 = "duncan",
		text = [ {text = "DIVINE_SYMBOL_46", reqs = []}],
		options = [ {
			code = 'divine_symbol_34', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_34 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "myr", character2 = "duncan",
		text = [ {text = "DIVINE_SYMBOL_47", reqs = []}],
		options = [ {
			code = 'divine_symbol_35', text = "DIVINE_SYMBOL_OPTION_33", reqs = [], dialogue_argument = 1,
		}, {
			code = 'divine_symbol_35', text = "DIVINE_SYMBOL_OPTION_34", reqs = [], dialogue_argument = 2,
		}, ],
	},
	
	divine_symbol_35 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "myr", character2 = "duncan",
		text = [ {text = "DIVINE_SYMBOL_48", reqs = []}],
		options = [ {
			code = 'divine_symbol_36', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	divine_symbol_36 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan",
		text = [ {text = "DIVINE_SYMBOL_49", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
		}],
	},
}
