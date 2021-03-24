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
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
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
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_4", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
		options = [ {
			code = 'quest_fight', args = 'betrayal_confirmed_rebels_2',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_rebels_2_win = {
		image = null, tags = ['dialogue_scene'], character = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_5", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
		options = [ {
			code = 'betrayal_confirmed_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		} ],
	},
	
	betrayal_confirmed_4 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_6", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
		options = [ {
			code = 'betrayal_confirmed_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_5 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_7", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
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
		image = null, tags = ['dialogue_scene'], character = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_8", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
		options = [ {
			code = 'betrayal_confirmed_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
		}],
	},
	
	betrayal_confirmed_8 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "greg",
		text = [{text = "BETRAYAL_CONFIRMED_9", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
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
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "myr",
		text = [{text = "BETRAYAL_CONFIRMED_11", reqs = []}],
		#common_effects = [{code = 'screen_black_transition', value = 0.5}],
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
		options = [ {
			code = 'close', text = "BETRAYAL_CONFIRMED_OPTION_3", reqs = [], dialogue_argument = 1,
		}, {
			code = 'close', text = "BETRAYAL_CONFIRMED_OPTION_4", reqs = [], dialogue_argument = 2,
		}, {
			code = 'close', text = "BETRAYAL_CONFIRMED_OPTION_5", reqs = [], dialogue_argument = 2,
		}],
	},
}
