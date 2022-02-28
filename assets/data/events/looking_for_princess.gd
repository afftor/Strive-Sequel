var data = {
	looking_for_princess_1 = {
		variations = [ {
			reqs = [{type = 'decision', value = 'PlayerFrontline', check = true}],
			image = null, tags = ['dialogue_scene'], character = "duncan",
			text = [{text = "LOOKING_FOR_PRINCESS_1", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_2", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_4", reqs = []}],
			common_effects = [{code = 'material_change', operant = '+', material = 'wood', value = 1}, #TODO add another item
			{code = 'money_change', operant = '+', value = 760}],
			options = [ {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_1", reqs = [], dialogue_argument = 3,
				bonus_effects = [{code = 'progress_quest', value = 'princess_search', stage = 'stage2'}, {code = "update_guild"}], type = 'next_dialogue',
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_2", reqs = [], dialogue_argument = 4,
				bonus_effects = [{code = "decision", value = "LookingForPrincessAccess"},
				{code = 'progress_quest', value = 'princess_search', stage = 'stage2'}, {code = "update_guild"}], type = 'next_dialogue',
			}],
		}, {
			reqs = [{type = 'decision', value = 'PlayerFrontline', check = false}],
			image = null, tags = ['dialogue_scene'], character = "duncan",
			text = [{text = "LOOKING_FOR_PRINCESS_1", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_3", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_4", reqs = []}],
			common_effects = [{code = 'money_change', operant = '+', value = 760}],
			options = [ {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_1", reqs = [], dialogue_argument = 3,
				bonus_effects = [{code = 'progress_quest', value = 'princess_search', stage = 'stage2'}, {code = "update_guild"}], type = 'next_dialogue',
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_2", reqs = [], dialogue_argument = 4,
				bonus_effects = [{code = "decision", value = "LookingForPrincessAccess"},
				{code = 'progress_quest', value = 'princess_search', stage = 'stage2'}, {code = "update_guild"}], type = 'next_dialogue',
			}],
		}
		]
	},

	looking_for_princess_2 = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "LOOKING_FOR_PRINCESS_5", reqs = []}],
		options = [ {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_4", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'remove_decision', value = 'LookingForPrincessAccess'}]
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_5", reqs = [], dialogue_argument = 2
		},],
	},

	# KOBOLD part
	looking_for_princess_3 = {
		image = "kobold", tags = ['dialogue_scene'],
		text = [{text = "LOOKING_FOR_PRINCESS_6", reqs = []}],
		options = [ {
			code = 'looking_for_princess_4', text = "LOOKING_FOR_PRINCESS_OPTION_6", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'remove_decision', value = 'LookingForPrincessAccess'}]
		}, {
			code = 'looking_for_princess_4', text = "LOOKING_FOR_PRINCESS_OPTION_7", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},],
	},

	looking_for_princess_4 = {
		image = "kobold", tags = ['dialogue_scene'],
		text = [{text = "LOOKING_FOR_PRINCESS_7", reqs = [], previous_dialogue_option = 1},
		{text = "LOOKING_FOR_PRINCESS_8", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'looking_for_princess_4', text = "LOOKING_FOR_PRINCESS_OPTION_8", reqs = [], dialogue_argument = 4, remove_after_first_use = true
		}, {
			code = 'looking_for_princess_5', text = "LOOKING_FOR_PRINCESS_OPTION_9", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},],
	},

	# =Search
	looking_for_princess_5 = {
		variations = [{
			# First time seeing
			reqs = [{type = 'decision', value = 'BraceletPreviousAttack', check = false},
			{type = 'dialogue_seen', check = false, value = 'LOOKING_FOR_PRINCESS_9'}],
			image = "kobold", tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_9", reqs = [], previous_dialogue_option = 2},
			{text = "LOOKING_FOR_PRINCESS_10", reqs = [], previous_dialogue_option = 4}],
			options = [ {
				code = 'looking_for_princess_5_5', text = "LOOKING_FOR_PRINCESS_OPTION_10", reqs = [], dialogue_argument = 4, remove_after_first_use = true
			}, {
				code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_11", reqs = [], dialogue_argument = 1
			}, {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE_500", reqs = [{type = "has_money", value = 500}], dialogue_argument = 2
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_13", reqs = [], dialogue_argument = 3
			},],
		}, {
			# Previously seen and BraceletPreviousAttack = false
			reqs = [{type = 'decision', value = 'BraceletPreviousAttack', check = false} ],
			#{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'lt', value = 1, check = true}],
			image = "kobold", tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_12", reqs= []}],
			options = [ {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_14_500", reqs = [{type = "has_money", value = 500}, {type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'lt', value = 1, check = true}], dialogue_argument = 2
			}, {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_14_1000", reqs = [{type = "has_money", value = 1000}, {type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'lt', value = 2, check = true}], dialogue_argument = 2
			}, {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_14_1500", reqs = [{type = "has_money", value = 1500}, {type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'gte', value = 2, check = true}], dialogue_argument = 2
			}, {
				code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_11", reqs = [], dialogue_argument = 1
			}, {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3
			},],
		}, {
			# Previously seen and BraceletPreviousAttack = true and attempts >= 1
			reqs = [{type = 'decision', value = 'BraceletPreviousAttack', check = true},
			{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'gte', value = 1, check = true},
			{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'lt', value = 2, check = true},],
			image = "kobold", tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_13", reqs= []}],
			common_effects = [{code = 'remove_decision', value = 'BraceletPreviousAttack'}],
			options = [ {
				code = 'looking_for_princess_7', text = "LOOKING_FOR_PRINCESS_OPTION_15", reqs = [],
				dialogue_argument = 9, remove_after_first_use = true
			}, {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE_1000", reqs = [{type = "has_money", value = 1000}], dialogue_argument = 3
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_THINK", reqs = [], dialogue_argument = 2
			}, {
				code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_17", reqs = [], dialogue_argument = 2,
				bonus_effects = [{code = 'dialogue_counter', name = 'BraceletAttackAttempt', op = '+'}]
			}],
		}, {
			# Previously seen and BraceletPreviousAttack = true and attempts >= 2
			reqs = [{type = 'decision', value = 'BraceletPreviousAttack', check = true},
			{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'gte', value = 2, check = true}],
			image = "kobold", tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_16", reqs= []}],
			common_effects = [{code = 'remove_decision', value = 'BraceletPreviousAttack'}],
			options = [ {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE_1500", reqs = [{type = "has_money", value = 1500}], dialogue_argument = 3
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_THINK", reqs = [], dialogue_argument = 2
			}, {
				code = 'looking_for_princess_8', text = "LOOKING_FOR_PRINCESS_OPTION_18", reqs = [], dialogue_argument = 3
			}],
		}
		]
	},

	#>That's rather expensive for something so simple (only once)
	looking_for_princess_5_5 = {
		image = "kobold", tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_10", reqs = [], }],
		options = [ {
			code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_11", reqs = [], dialogue_argument = 1
		}, {
			code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE_500", reqs = [{type = "has_money", value = 500}], dialogue_argument = 2
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_13", reqs = [], dialogue_argument = 3
		},],
	},

	looking_for_princess_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_11", reqs = [], previous_dialogue_option = 1},
		{text = "LOOKING_FOR_PRINCESS_15", reqs = [], previous_dialogue_option = 2} ],
		common_effects = [{code = 'dialogue_counter', name = 'BraceletAttackAttempt', op = '+'},
		{code = 'decision', value = 'BraceletPreviousAttack'}, # the fact that we tried to attack kobold
		{code = 'decision', value = 'BlockSearch'},
		{code = 'add_timed_event', value = "BlockSearch",
		args = [{type = 'action_to_date', date = [1,1], hour = 1, action = "remove_decision"}]}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1 , bonus_effects = [{code = 'update_location'}]
		}],
	},

	looking_for_princess_7 = {
		image = "kobold", tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_14", reqs = []}],
		options = [ {
			code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE_1000", reqs = [{type = "has_money", value = 1000}], dialogue_argument = 3
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_THINK", reqs = [], dialogue_argument = 2
		}, {
			code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_17", reqs = [], dialogue_argument = 2,
			bonus_effects = [{code = 'dialogue_counter', name = 'BraceletAttackAttempt', op = '+'}]
		}],
	},

	looking_for_princess_8 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_17", reqs = []}],
		common_effects = [{code = 'material_change', operant = '+', material = 'princess_bracelet', value = 1},
		{code = 'decision', value = 'bracelet_found'}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
		}],
	},

	take_the_gold = {
		variations = [{
			image = null, tags = ['dialogue_scene'], reqs = [{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'gte', value = 1, check = true}],
			text = [{text = "LOOKING_FOR_PRINCESS_18", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 1000},
			{code = 'material_change', operant = '+', material = 'princess_bracelet', value = 1},
			{code = 'decision', value = 'bracelet_found'}],
			options = [ {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
			}],
		}, {
			image = null, tags = ['dialogue_scene'], reqs = [{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'gte', value = 2, check = true}],
			text = [{text = "LOOKING_FOR_PRINCESS_18", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 1500},
			{code = 'material_change', operant = '+', material = 'princess_bracelet', value = 1},
			{code = 'decision', value = 'bracelet_found'}],
			options = [ {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
			}],
		}, {
			image = null, tags = ['dialogue_scene'], reqs = [],
			text = [{text = "LOOKING_FOR_PRINCESS_18", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 500},
			{code = 'material_change', operant = '+', material = 'princess_bracelet', value = 1},
			{code = 'decision', value = 'bracelet_found'}],
			options = [ {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
			}],
		}]
	},

	looking_for_princess_mages = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = "amelia", character2 = "myr",
		text = [{text = "LOOKING_FOR_PRINCESS_19", reqs = []}],
		options = [ {
			code = 'looking_for_princess_mages_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	#TODO Leave to town
	looking_for_princess_mages_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = "amelia", character2 = "myr",
		text = [{text = "LOOKING_FOR_PRINCESS_20", reqs = []}],
		options = [ {
			code = 'looking_for_princess_mages_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_mages_2 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_21", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'progress_quest', value = 'princess_search', stage = 'stage3'}],
		}],
	},

	looking_for_princess_elven_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_22", reqs = [{type = 'decision', value = 'interrogation_success', check = false}]},
		{text = "LOOKING_FOR_PRINCESS_23", reqs = [{type = 'decision', value = 'interrogation_success', check = true}]}],
		options = [ {
			code = 'looking_for_princess_elven_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_24", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_3', text = "LOOKING_FOR_PRINCESS_OPTION_20", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_3', text = "LOOKING_FOR_PRINCESS_OPTION_21", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},{
			code = 'looking_for_princess_elven_3', text = "LOOKING_FOR_PRINCESS_OPTION_22", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		},],
	},

	looking_for_princess_elven_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_25", reqs = [], previous_dialogue_option = 1},
		{text = "LOOKING_FOR_PRINCESS_26", reqs = [], previous_dialogue_option = 2},
		{text = "LOOKING_FOR_PRINCESS_27", reqs = [], previous_dialogue_option = 3}, ],
		options = [ {
			code = 'looking_for_princess_elven_4', text = "LOOKING_FOR_PRINCESS_OPTION_23", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_4', text = "LOOKING_FOR_PRINCESS_OPTION_24", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},{
			code = 'looking_for_princess_elven_4', text = "LOOKING_FOR_PRINCESS_OPTION_25", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		},],
	},

	looking_for_princess_elven_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_28", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_5 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_29", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_6', text = "LOOKING_FOR_PRINCESS_OPTION_26", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_6', text = "LOOKING_FOR_PRINCESS_OPTION_27", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},{
			code = 'looking_for_princess_elven_6', text = "LOOKING_FOR_PRINCESS_OPTION_28", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		},],
	},

	looking_for_princess_elven_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_30", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_7_1', text = "LOOKING_FOR_PRINCESS_OPTION_29", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_7', text = "LOOKING_FOR_PRINCESS_OPTION_30", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},{
			code = 'looking_for_princess_elven_7_1', text = "LOOKING_FOR_PRINCESS_OPTION_31", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		},],
	},

	looking_for_princess_elven_7 = {
		variations = [
			{
				reqs = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 5}],
				image = null, tags = ['dialogue_scene'], character = 'elf_priestess', character2 = 'anastasia',
				text = [{text = "LOOKING_FOR_PRINCESS_31", reqs = []}],
				common_effects = [{code = 'play_sound', value = 'slap'}, {code = 'decision', value = 'PrincessObtained'}, #Anastasia is captured alive
		{code = 'progress_quest', value = 'princess_search', stage = 'stage5'}],
				options = [ {
					code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'update_city'}]
				} ],
			}, {
				reqs = [{code = 'stat', stat = 'physics_factor', operant = 'lt', value = 5}], character = 'elf_priestess', character2 = 'anastasia',
				image = null, tags = ['dialogue_scene'], common_effects = [{code = 'play_sound', value = 'slap'}],
				text = [{text = "LOOKING_FOR_PRINCESS_32_f", reqs = [], previous_dialogue_option = 2},
				{text = "LOOKING_FOR_PRINCESS_32", reqs = []}],
				options = [ {
					code = 'looking_for_princess_elven_8', text = "LOOKING_FOR_PRINCESS_OPTION_32", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
				}, {
					code = 'looking_for_princess_elven_8', text = "LOOKING_FOR_PRINCESS_OPTION_33", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
				},{
					code = 'looking_for_princess_elven_8', text = "LOOKING_FOR_PRINCESS_OPTION_34", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
				},],
			},
		]
	},
	looking_for_princess_elven_7_1 = {

		character = 'elf_priestess', character2 = 'anastasia',
		image = null, tags = ['dialogue_scene'],
		text = [
		{text = "LOOKING_FOR_PRINCESS_32", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_8', text = "LOOKING_FOR_PRINCESS_OPTION_32", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_8', text = "LOOKING_FOR_PRINCESS_OPTION_33", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},{
			code = 'looking_for_princess_elven_8', text = "LOOKING_FOR_PRINCESS_OPTION_34", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		},],

	},

	looking_for_princess_elven_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_33", reqs = [], previous_dialogue_option = 1},
		{text = "LOOKING_FOR_PRINCESS_34", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_9 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_35", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_10', text = "LOOKING_FOR_PRINCESS_OPTION_35", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_36", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'yes_or_no_panel', yes = 'looking_for_princess_elven_execute', no = 'looking_for_princess_elven_9', text = "Let Anastasia be executed? This option is irreversible"}]
		}, ],
	},

	looking_for_princess_elven_10 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_36", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_11', text = "LOOKING_FOR_PRINCESS_OPTION_37", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_11', text = "LOOKING_FOR_PRINCESS_OPTION_38", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_11', text = "LOOKING_FOR_PRINCESS_OPTION_39", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ],
	},

	looking_for_princess_elven_11 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_37", reqs = [], previous_dialogue_option = 1},
		{text = "LOOKING_FOR_PRINCESS_38", reqs = [], previous_dialogue_option = 2},
		{text = "LOOKING_FOR_PRINCESS_39", reqs = [], previous_dialogue_option = 3},
		{text = "LOOKING_FOR_PRINCESS_40", reqs = [
				{type = "location_has_specific_slaves", value = 1, location = 'elf_capital', reqs = [
					{code = 'unique', value = 'zephyra'}]}] }],
		options = [ {
			code = 'looking_for_princess_elven_12', text = "LOOKING_FOR_PRINCESS_OPTION_40", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_15', text = "LOOKING_FOR_PRINCESS_OPTION_41", reqs = [
				{type = "location_has_specific_slaves", value = 1, location = 'elf_capital', reqs = [
					{code = 'unique', value = 'zephyra'}]}], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_42", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'yes_or_no_panel', yes = 'looking_for_princess_elven_execute', no = 'looking_for_princess_elven_11', text = "Let Anastasia be executed? This option is irreversible"}]
		}, ],
	},

	looking_for_princess_elven_12 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_41", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_13', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},

	looking_for_princess_elven_13 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'elf_priestess', character2 = 'anastasia',
		text = [{text = "LOOKING_FOR_PRINCESS_42", reqs = []}],
		options = [ {
			# *Accept* do sacrifice
			code = 'looking_for_princess_elven_14', remove_non_master = true, text = "LOOKING_FOR_PRINCESS_OPTION_43", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			# *Refuse*
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_44", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'yes_or_no_panel', yes = 'looking_for_princess_elven_execute', no = 'looking_for_princess_elven_13', text = "Let Anastasia be executed? This option is irreversible"}]
		}],
	},

	looking_for_princess_elven_14 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], character = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_43", reqs = []}], common_effects = [{code = 'decision', value = 'PrincessObtained'}, #Anastasia is captured alive
		{code = 'progress_quest', value = 'princess_search', stage = 'stage5'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		}],
	},

	looking_for_princess_elven_15 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'zephyra', character2 = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_45", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_16', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_16 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'zephyra', character2 = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_46", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_17', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_17 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra', character2 = 'elf_priestess',
		text = [{text = "LOOKING_FOR_PRINCESS_47", reqs = []}], common_effects = [{code = 'decision', value = 'PrincessObtained'}, #Anastasia is captured alive
		{code = 'progress_quest', value = 'princess_search', stage = 'stage5'}],
		options = [ {
			code = 'looking_for_princess_elven_18', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_18 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = 'zephyra',
		text = [{text = "LOOKING_FOR_PRINCESS_48", reqs = []}],
		options = [ {
			code = 'looking_for_princess_elven_19', text = "LOOKING_FOR_PRINCESS_OPTION_45", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_19', text = "LOOKING_FOR_PRINCESS_OPTION_46", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'looking_for_princess_elven_19', text = "LOOKING_FOR_PRINCESS_OPTION_47", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}],
	},

	looking_for_princess_elven_19 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'zephyra',
		text = [{text = "LOOKING_FOR_PRINCESS_49", reqs = [], previous_dialogue_option = 1},
		{text = "LOOKING_FOR_PRINCESS_50", reqs = [], previous_dialogue_option = 2},
		{text = "LOOKING_FOR_PRINCESS_51", reqs = [], previous_dialogue_option = 3}],

		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		}],
	},

	looking_for_princess_elven_execute = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_44", reqs = [], previous_dialogue_option = 4},
		{text = "LOOKING_FOR_PRINCESS_52", reqs = []}], common_effects = [{code = 'decision', value = 'PrincessDead'}, #Anastasia is captured dead
		{code = 'progress_quest', value = 'princess_search', stage = 'stage4'}],

		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		}],
	},
}
