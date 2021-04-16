var data = {
	message_before_looking_operation = {
		common_effects = [{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'meet_duncan'}], #adds option to talk to duncan in intoduction
		image = null, tags = ['dialogue_scene'],
		text = [{text = "LOOKING_FOR_PRINCESS_START", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2 
		}],
	},
	
	looking_for_princess_1 = {
		variations = [ {
			reqs = [{type = 'decision', value = 'PlayerFrontline', check = true}],
			image = null, tags = ['dialogue_scene'], character = "duncan",
			text = [{text = "LOOKING_FOR_PRINCESS_1", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_2", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_4", reqs = []}],
			common_effects = [{code = 'material_change', operant = '+', material = 'wood', value = 1},
			{code = 'money_change', operant = '+', value = 760}],
			options = [ {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_1", reqs = [], dialogue_argument = 3,
				bonus_effects = [{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'go_for_search'}]
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_2", reqs = [], dialogue_argument = 4,
				bonus_effects = [{code = "decision", value = "LookingForPrincessAccess"},
				{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'go_for_search'}, {code = "update_guild"}]
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
				bonus_effects = [{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'go_for_search'}]
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_2", reqs = [], dialogue_argument = 4,
				bonus_effects = [{code = "decision", value = "LookingForPrincessAccess"},
				{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'go_for_search'}, {code = "update_guild"}]
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
		image = null, tags = ['dialogue_scene'],
		text = [{text = "LOOKING_FOR_PRINCESS_6", reqs = []}],
		options = [ {
			code = 'looking_for_princess_4', text = "LOOKING_FOR_PRINCESS_OPTION_6", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'remove_decision', value = 'LookingForPrincessAccess'}]
		}, {
			code = 'looking_for_princess_4', text = "LOOKING_FOR_PRINCESS_OPTION_7", reqs = [], dialogue_argument = 1 
		},],
	},
	
	looking_for_princess_4 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "LOOKING_FOR_PRINCESS_7", reqs = [], previous_dialogue_option = 1}, 
		{text = "LOOKING_FOR_PRINCESS_8", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'looking_for_princess_4', text = "LOOKING_FOR_PRINCESS_OPTION_8", reqs = [], dialogue_argument = 4, remove_after_first_use = true
		}, {
			code = 'looking_for_princess_5', text = "LOOKING_FOR_PRINCESS_OPTION_9", reqs = [], dialogue_argument = 2 
		},],
	},
	
	# =Search
	looking_for_princess_5 = {
		variations = [{
			# First time seeing
			reqs = [{type = 'decision', value = 'BraceletPreviousAttack', check = false},
			{type = 'dialogue_seen', check = false, value = 'LOOKING_FOR_PRINCESS_9'}],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_9", reqs = [], previous_dialogue_option = 2}, 
			{text = "LOOKING_FOR_PRINCESS_10", reqs = [], previous_dialogue_option = 4}],
			options = [ {
				code = 'looking_for_princess_5_5', text = "LOOKING_FOR_PRINCESS_OPTION_10", reqs = [], dialogue_argument = 4, remove_after_first_use = true
			}, {
				code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_11", reqs = [], dialogue_argument = 1 
			}, {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE", reqs = [], dialogue_argument = 2 
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_13", reqs = [], dialogue_argument = 3
			},],
		}, {
			# Previously seen and BraceletPreviousAttack = false
			reqs = [{type = 'decision', value = 'BraceletPreviousAttack', check = false} ], 
			#{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'lt', value = 1, check = true}],
			image = null, tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_12", reqs= []}],
			options = [ {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_14", reqs = [], dialogue_argument = 2 
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
			image = null, tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_13", reqs= []}],
			common_effects = [{code = 'remove_decision', value = 'BraceletPreviousAttack'}], 
			options = [ {
				code = 'looking_for_princess_7', text = "LOOKING_FOR_PRINCESS_OPTION_15", reqs = [], 
				dialogue_argument = 9, remove_after_first_use = true
			}, {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE", reqs = [], dialogue_argument = 3
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
			image = null, tags = ['dialogue_scene'],
			text = [{text = "LOOKING_FOR_PRINCESS_16", reqs= []}],
			common_effects = [{code = 'remove_decision', value = 'BraceletPreviousAttack'}], 
			options = [ {
				code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE", reqs = [], dialogue_argument = 3
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_THINK", reqs = [], dialogue_argument = 2 
			}, {
				code = 'looking_for_princess_8', text = "LOOKING_FOR_PRINCESS_OPTION_18", reqs = [], dialogue_argument = 3,
				bonus_effects = [{}]
			}],
		}
		]
	},
	
	#>That's rather expensive for something so simple (only once)
	looking_for_princess_5_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_10", reqs = [], }],
		options = [ {
			code = 'looking_for_princess_6', text = "LOOKING_FOR_PRINCESS_OPTION_11", reqs = [], dialogue_argument = 1 
		}, {
			code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE", reqs = [], dialogue_argument = 2 
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_13", reqs = [], dialogue_argument = 3
		},],
	},
	
	#TODO block search for 1 day
	looking_for_princess_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_11", reqs = [], previous_dialogue_option = 1}, 
		{text = "LOOKING_FOR_PRINCESS_15", reqs = [], previous_dialogue_option = 2} ],
		common_effects = [{code = 'dialogue_counter', name = 'BraceletAttackAttempt', op = '+'}, 
		{code = 'decision', value = 'BraceletPreviousAttack'}], # the fact that we tried to attack kobold
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1 
		}],
	},
	
	looking_for_princess_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "LOOKING_FOR_PRINCESS_14", reqs = []}], 
		options = [ {
			code = 'take_the_gold', text = "LOOKING_FOR_PRINCESS_OPTION_FINE", reqs = [], dialogue_argument = 3
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
		{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'bracelet_found'}],
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
			{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'bracelet_found'}],
			options = [ {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
			}],
		}, {
			image = null, tags = ['dialogue_scene'], reqs = [{type = 'local_counter', name = 'BraceletAttackAttempt', operant = 'gte', value = 2, check = true}],
			text = [{text = "LOOKING_FOR_PRINCESS_18", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 1500},
			{code = 'material_change', operant = '+', material = 'princess_bracelet', value = 1},
			{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'bracelet_found'}],
			options = [ {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
			}],
		}, {
			image = null, tags = ['dialogue_scene'], reqs = [],
			text = [{text = "LOOKING_FOR_PRINCESS_18", reqs = []}],
			common_effects = [{code = 'money_change', operant = '-', value = 500},
			{code = 'material_change', operant = '+', material = 'princess_bracelet', value = 1},
			{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'bracelet_found'}],
			options = [ {
				code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'remove_active_location'}]
			}],
		}]
	},
	
	looking_for_princess_mages = {
		
	},
}
