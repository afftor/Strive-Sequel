var data = {
	help_sigmund_start = {
		image = null, character = "sigmund", tags = ['dialogue_scene'],
		text = [ {text = "HELP_SIGMUND_START", reqs = []} ],
		options = [ {
			code = 'help_sigmund_1', remove_after_first_use = true,
			text = "HELP_SIGMUND_OPTION_1", reqs = [], dialogue_argument = 1, 
		}, {
			code = 'help_sigmund_2',
			text = "HELP_SIGMUND_OPTION_2", reqs = [], dialogue_argument = 2
		}
		],
	},
	
	help_sigmund_1 = {
		image = null, character = "sigmund", tags = ['dialogue_scene'],
		text = [ {text = "HELP_SIGMUND_1", reqs = []} ],
		options = [ {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_3", reqs = [], dialogue_argument = 1
		}, {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_4", reqs = [], dialogue_argument = 2
		}, {
			code = 'help_sigmund_end_2',
			text = "HELP_SIGMUND_OPTION_5", reqs = [], dialogue_argument = 2
		}
		],
	},
	
	help_sigmund_2 = {
		image = null, character = "sigmund", tags = ['dialogue_scene'],
		text = [ {text = "HELP_SIGMUND_2", reqs = []} ],
		options = [ {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_3", reqs = [], dialogue_argument = 1
		}, {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_4", reqs = [], dialogue_argument = 2
		}, {
			code = 'help_sigmund_end_2',
			text = "HELP_SIGMUND_OPTION_5", reqs = [], dialogue_argument = 2
		}
		],
	},
	
	help_sigmund_end_1 = {
		image = null, character = "sigmund", tags = [],
		text = [ {text = "HELP_SIGMUND_3", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},
	
	help_sigmund_end_2 = {
		image = null, character = "sigmund", tags = [],
		text = [ {text = "HELP_SIGMUND_4", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},
}
