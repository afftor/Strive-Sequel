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
				code = 'looking_for_princess_3', text = "LOOKING_FOR_PRINCESS_OPTION_1", reqs = [], dialogue_argument = 3,
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_2", reqs = [], dialogue_argument = 4,
				bonus_effects = [{code = "decision", value = "LookingForPrincessAccess"},
				{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'go_for_search'}]
			}], 
		}, {
			reqs = [{type = 'decision', value = 'PlayerFrontline', check = false}],
			image = null, tags = ['dialogue_scene'], character = "duncan",
			text = [{text = "LOOKING_FOR_PRINCESS_1", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_3", reqs = []},
			{text = "LOOKING_FOR_PRINCESS_4", reqs = []}],
			common_effects = [{code = 'money_change', operant = '+', value = 760}],
			options = [ {
				code = 'looking_for_princess_3', text = "LOOKING_FOR_PRINCESS_OPTION_1", reqs = [], dialogue_argument = 3,
			}, {
				code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_2", reqs = [], dialogue_argument = 4,
				bonus_effects = [{code = "decision", value = "LookingForPrincessAccess"},
				{code = 'progress_quest', value = 'looking_for_princess_quest', stage = 'go_for_search'}]
			}], 
		}
		]
	},
	
	looking_for_princess_2 = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "LOOKING_FOR_PRINCESS_5", reqs = []}],
		options = [ {
			code = 'looking_for_princess_3', text = "LOOKING_FOR_PRINCESS_OPTION_4", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'remove_decision', value = 'LookingForPrincessAccess'}]
		}, {
			code = 'close', text = "LOOKING_FOR_PRINCESS_OPTION_5", reqs = [], dialogue_argument = 2 
		},],
	},
}
