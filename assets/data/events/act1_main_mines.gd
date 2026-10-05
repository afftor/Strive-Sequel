extends Reference
var data = {
	help_sigmund_start = {
		image = null, character = "sigmund", tags = ['dialogue_scene'],
		text = [ {text = "HELP_SIGMUND_START", reqs = []} ],
		options = [ {
			code = 'help_sigmund_1', remove_after_first_use = true,
			text = "HELP_SIGMUND_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'help_sigmund_2',
			text = "HELP_SIGMUND_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}
		],
	},
	
	help_sigmund_1 = {
		image = null, character = "sigmund", tags = ['dialogue_scene'],
		text = [ {text = "HELP_SIGMUND_1", reqs = []} ],
		options = [ {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'help_sigmund_end_2',
			text = "HELP_SIGMUND_OPTION_5", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}
		],
	},
	
	help_sigmund_2 = {
		image = null, character = "sigmund", tags = ['dialogue_scene'],
		text = [ {text = "HELP_SIGMUND_2", reqs = []} ],
		options = [ {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'help_sigmund_end_1',
			text = "HELP_SIGMUND_OPTION_4", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}, {
			code = 'help_sigmund_end_2',
			text = "HELP_SIGMUND_OPTION_5", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}
		],
	},
	
	help_sigmund_end_1 = {
		image = null, character = "sigmund", tags = [],
		text = [ {text = "HELP_SIGMUND_3", reqs = []} ],
		common_effects = [{code = 'make_quest_location', value = 'quest_mines_dungeon'},
		{code = 'progress_quest', value = 'civil_war_mines', stage = 'stage2'}],
		
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], type = 'next_dialogue'
			}
		],
	},
	
	help_sigmund_end_2 = {
		image = null, character = "sigmund", tags = [],
		text = [ {text = "HELP_SIGMUND_4", reqs = []} ],
		common_effects = [{code = 'make_quest_location', value = 'quest_mines_dungeon'},
		{code = 'progress_quest', value = 'civil_war_mines', stage = 'stage2'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], type = 'next_dialogue'
			}
		],
	},
	
	mines_arrival_start = {
		image = 'mines_quest', 
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "MINES_ARRIVAL_START", reqs = [], previous_dialogue_option = 0},
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
			text = "MINES_ARRIVAL_OPTION_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}
		],
	},
	
	mines_arrival_1 = {
		image = 'mines_quest', tags = ['dialogue_scene'],
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
		image = 'mines_quest', tags = [],
		text = [ {text = "MINES_ARRIVAL_6", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},
	
	half_dungeon_explored_start = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [ {text = "GRASHA_MINES_START", reqs = []} ],
		options = [ {
			code = 'grasha_mines_introduction',
			text = "HALF_DUNGEON_EXPLORED_OPTION_1", reqs = [], dialogue_argument = 1
		}, {
			code = 'grasha_mines_introduction',
			text = "HALF_DUNGEON_EXPLORED_OPTION_2", reqs = [], dialogue_argument = 2
		}
		],
	},

	grasha_mines_introduction = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [ {text = "GRASHA_MINES_INTRODUCTION", reqs = []} ],
		options = [ {
			code = 'grasha_mines_orc_magic',
			text = "HALF_DUNGEON_EXPLORED_OPTION_3", reqs = [], dialogue_argument = 3
		}, {
			code = 'grasha_mines_amulet_question',
			text = "GRASHA_MINES_OPTION_LETTER", reqs = [], dialogue_argument = 4
		}, {
			code = 'grasha_mines_no_answer',
			text = "HALF_DUNGEON_EXPLORED_OPTION_5", reqs = [], dialogue_argument = 5
		}
		],
	},

	grasha_mines_orc_magic = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [ {text = "GRASHA_MINES_ORC_MAGIC", reqs = []} ],
		options = [ {
			code = 'grasha_mines_amulet_question',
			text = "GRASHA_MINES_OPTION_LETTER", reqs = [], dialogue_argument = 4
		}, {
			code = 'grasha_mines_no_answer',
			text = "HALF_DUNGEON_EXPLORED_OPTION_5", reqs = [], dialogue_argument = 5
		}
		],
	},

	grasha_mines_amulet_question = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [ {text = "GRASHA_MINES_AMULET_QUESTION", reqs = []} ],
		options = [ {
			code = 'grasha_mines_offer',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6
		} ],
	},

	grasha_mines_no_answer = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [ {text = "GRASHA_MINES_NO_ANSWER", reqs = []} ],
		options = [ {
			code = 'grasha_mines_offer',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6
		} ],
	},

	grasha_mines_offer = {
		image = null, character = "$grasha", tags = ['dialogue_scene'],
		text = [ {text = "GRASHA_MINES_OFFER", reqs = []} ],
		options = [ {
			code = 'grasha_mines_leave',
			text = "GRASHA_MINES_OPTION_LEAVE", reqs = [], dialogue_argument = 7
		}, {
			code = 'grasha_mines_mansion_offer',
			text = "GRASHA_MINES_OPTION_MANSION", reqs = [], dialogue_argument = 8
		}, {
			code = 'grasha_mines_follow',
			text = "GRASHA_MINES_OPTION_FOLLOW", reqs = [], dialogue_argument = 9
		}
		],
	},

	grasha_mines_leave = {
		image = null, character = "$grasha", tags = [],
		text = [ {text = "GRASHA_MINES_LEAVE", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},

	grasha_mines_mansion_offer = {
		variations = [ {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}]}],
			image = null, character = "$grasha", tags = ['dialogue_scene'],
			text = [ {text = "GRASHA_MINES_MANSION_OFFER", reqs = []} ],
			options = [ {
			code = 'grasha_mines_accept_offer',
			text = "HALF_DUNGEON_EXPLORED_OPTION_9", reqs = [], dialogue_argument = 10
			}, {
			code = 'grasha_mines_offer',
			text = "HALF_DUNGEON_EXPLORED_OPTION_10", reqs = [], dialogue_argument = 11
			} ]
			}, {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 4}]}],
			image = null, character = "$grasha", tags = ['dialogue_scene'],
			text = [ {text = "GRASHA_MINES_MANSION_OFFER_FAILURE", reqs = []} ],
			options = [ {
				code = 'grasha_mines_follow',
				text = "GRASHA_MINES_OPTION_FOLLOW", reqs = [], dialogue_argument = 9
			} ],
			}
		]
		},

	grasha_mines_accept_offer = {
		image = null, character = "$grasha", tags = [],
		text = [ {text = "GRASHA_MINES_ACCEPT_OFFER", reqs = []} ],
		common_effects = [
			{code = 'decision', value = 'GrashaRecruited'},
			{code = 'make_story_character', value = 'Grasha', recruit_from_location = true, send_to_mansion = true},
			{code = 'add_timed_event', value = 'grasha_old_crew_rumor', args = [{type = 'add_to_date', date = [3,3], hour = 1}]},
			{code = 'decision', value = 'GrashaCrewScheduled'},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},

	grasha_mines_follow = {
		image = null, character = "$grasha", tags = [],
		text = [ {text = "GRASHA_MINES_FOLLOW", reqs = []} ],
		common_effects = [{code = 'decision', value = 'GrashaFollowing'}], #she follows into the finale, where the demon takes her over
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	}
}
