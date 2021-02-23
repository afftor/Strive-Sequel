var data = {
	mines_arrival_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [ {text = "MINES_ARRIVAL_START", reqs = [], previous_dialogue_option = 0},
		{text = "MINES_ARRIVAL_1", reqs = [], previous_dialogue_option = 1},
		{text = "MINES_ARRIVAL_5", reqs = [], previous_dialogue_option = 6}],
		options = [ {
			code = 'mines_arrival_start',
			text = "MINES_ARRIVAL_OPTION_1", reqs = [], dialogue_argument = 1
		}, {
			code = 'mines_arrival_1',
			text = "MINES_ARRIVAL_OPTION_2", reqs = [], dialogue_argument = 2
		}, {
			code = 'mines_arrival_end',
			text = "MINES_ARRIVAL_OPTION_3", reqs = [], dialogue_argument = 2
		}
		],
	},
	
	mines_arrival_1 = {
		image = null, tags = ['dialogue_scene'],
		text = [ {text = "MINES_ARRIVAL_2", reqs = [], previous_dialogue_option = 2},
		{text = "MINES_ARRIVAL_3", reqs = [], previous_dialogue_option = 4},
		{text = "MINES_ARRIVAL_4", reqs = [], previous_dialogue_option = 5} ],
		options = [ {
			code = 'mines_arrival_1',
			text = "MINES_ARRIVAL_OPTION_4", reqs = [], dialogue_argument = 4
		}, {
			code = 'mines_arrival_1',
			text = "MINES_ARRIVAL_OPTION_5", reqs = [], dialogue_argument = 5
		}, {
			code = 'mines_arrival_start',
			text = "MINES_ARRIVAL_OPTION_6", reqs = [], dialogue_argument = 6
		}
		],
	},
	
	mines_arrival_end = {
		image = null, tags = [],
		text = [ {text = "MINES_ARRIVAL_6", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	}
}
