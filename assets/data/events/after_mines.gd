var data = {
	after_mines_sigmund_start = {
		variations = [ {
				reqs = [{type = 'decision', value = 'SaveRebels', check = true}],
				image = null, tags = ['dialogue_scene'], character = "sigmund",
				text = [{text = "AFTER_MINES_SIGMUND_START", reqs = []}],
				common_effects = [{code = 'money_change', operant = '+', value = 500}],
				options = [ {
				code = 'after_mines_sigmund_1',
				text = "AFTER_MINES_SIGMUND_OPTION_1", reqs = [], dialogue_argument = 1
				}, {
				code = 'after_mines_sigmund_1',
				text = "AFTER_MINES_SIGMUND_OPTION_2", reqs = [], dialogue_argument = 2
				} ],
			}, {
				reqs = [{type = 'decision', value = 'SaveRebels', check = false}],
				image = null, tags = ['dialogue_scene'], character = "sigmund",
				text = [{text = "AFTER_MINES_SIGMUND_3", reqs = []}],
				options = [ {
					code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2, 
					bonus_effects = [{code = 'decision', value = 'AfterMinesTalkedToSigmund'}],
				} ],
			},
		]
	},
	
	after_mines_sigmund_1 = {
		image = null, tags = ['dialogue_scene'], character = "sigmund",
		text = [{text = "AFTER_MINES_SIGMUND_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_SIGMUND_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2,
			bonus_effects = [{code = 'decision', value = 'AfterMinesTalkedToSigmund'}],
		}
		],
	},
	
	after_mines_duncan_start = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "AFTER_MINES_DUNCAN_1", reqs = [], previous_dialogue_option = 8},
		{text = "AFTER_MINES_DUNCAN_2", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_DUNCAN_5", reqs = [], previous_dialogue_option = 4},
		{text = "AFTER_MINES_DUNCAN_6", reqs = [], previous_dialogue_option = 5},
		{text = "AFTER_MINES_DUNCAN_7", reqs = [], previous_dialogue_option = 6}],
		options = [ {
			code = 'after_mines_duncan_start', text = "AFTER_MINES_DUNCAN_OPTION_1", reqs = [], dialogue_argument = 1
		}, {
			code = 'after_mines_duncan_1', text = "AFTER_MINES_DUNCAN_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'close', text = "AFTER_MINES_DUNCAN_OPTION_3", reqs = [
				{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_1'}, 
			{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_2'}, ], dialogue_argument = 3
		}, 
		],
	},
	
	after_mines_duncan_1 = {
		variations = [ {
				reqs = [{type = 'decision', value = 'SaveRebels', check = false}],
				image = null, tags = ['dialogue_scene'], character = "duncan",
				text = [{text = "AFTER_MINES_DUNCAN_3_4", reqs = []}],
				common_effects = [{code = 'money_change', operant = '+', value = 500}],
				options = [ {
				code = 'after_mines_duncan_start',
				text = "AFTER_MINES_DUNCAN_OPTION_4", reqs = [], dialogue_argument = 4
				}, {
				code = 'after_mines_duncan_start',
				text = "AFTER_MINES_DUNCAN_OPTION_5", reqs = [], dialogue_argument = 5
				}, {
				code = 'after_mines_duncan_start',
				text = "AFTER_MINES_DUNCAN_OPTION_6", reqs = [], dialogue_argument = 6
				} ],
			}, {
				reqs = [{type = 'decision', value = 'SaveRebels', check = true}],
				image = null, tags = ['dialogue_scene'], character = "duncan",
				text = [{text = "AFTER_MINES_DUNCAN_1", reqs = [], previous_dialogue_option = 8},
				{text = "AFTER_MINES_DUNCAN_2", reqs = [], previous_dialogue_option = 1},
				{text = "AFTER_MINES_DUNCAN_5", reqs = [], previous_dialogue_option = 4},
				{text = "AFTER_MINES_DUNCAN_6", reqs = [], previous_dialogue_option = 5},
				{text = "AFTER_MINES_DUNCAN_7", reqs = [], previous_dialogue_option = 6},
				{text = "AFTER_MINES_DUNCAN_3", reqs = [], previous_dialogue_option = 2}],
				options = [ {
					code = 'after_mines_duncan_start', text = "AFTER_MINES_DUNCAN_OPTION_1", reqs = [], dialogue_argument = 1
				}, {
					code = 'close', text = "AFTER_MINES_DUNCAN_OPTION_3", reqs = [
						{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_1'}, 
					{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_2'}, ], dialogue_argument = 3
				}, 
				],
			},
				]
	},
	
}
