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
					code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2
				} ],
			},
		]
	},
	
	after_mines_sigmund_1 = {
		image = null, tags = ['dialogue_scene'], character = "sigmund",
		text = [{text = "AFTER_MINES_SIGMUND_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_SIGMUND_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2
		}
		],
	}
}
