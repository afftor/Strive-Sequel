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
	},
	
	half_dungeon_explored_start = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "HALF_DUNGEON_EXPLORED_START", reqs = []} ],
		options = [ {
			code = 'half_dungeon_explored_1',
			text = "HALF_DUNGEON_EXPLORED_OPTION_1", reqs = [], dialogue_argument = 1
		}, {
			code = 'half_dungeon_explored_1',
			text = "HALF_DUNGEON_EXPLORED_OPTION_2", reqs = [], dialogue_argument = 2
		}
		],
	},
	
	half_dungeon_explored_1 = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "HALF_DUNGEON_EXPLORED_1", reqs = []} ],
		options = [ {
			code = 'half_dungeon_explored_2',
			text = "HALF_DUNGEON_EXPLORED_OPTION_3", reqs = [], dialogue_argument = 3
			}, {
			code = 'half_dungeon_explored_3',
			text = "HALF_DUNGEON_EXPLORED_OPTION_5", reqs = [], dialogue_argument = 5
		}
		],
	},
	
	half_dungeon_explored_2 = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "HALF_DUNGEON_EXPLORED_2", reqs = [], previous_dialogue_option = 3},
		{text = "HALF_DUNGEON_EXPLORED_3", reqs = [], previous_dialogue_option = 4},
		],
		options = [ {
			code = 'half_dungeon_explored_2',
			text = "HALF_DUNGEON_EXPLORED_OPTION_3", reqs = [], dialogue_argument = 3
			}, {
			code = 'half_dungeon_explored_2',
			text = "HALF_DUNGEON_EXPLORED_OPTION_4", reqs = [], dialogue_argument = 4
		}, {
			code = 'half_dungeon_explored_3',
			text = "HALF_DUNGEON_EXPLORED_OPTION_5", reqs = [], dialogue_argument = 5
		}
		],
	},
	
	half_dungeon_explored_3 = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "HALF_DUNGEON_EXPLORED_4", reqs = []} ],
		options = [ {
			code = 'half_dungeon_explored_end_left',
			text = "HALF_DUNGEON_EXPLORED_OPTION_6", reqs = [], dialogue_argument = 6
			}, {
			code = 'half_dungeon_explored_5',
			text = "HALF_DUNGEON_EXPLORED_OPTION_7", reqs = [], dialogue_argument = 7
		}, {
			code = 'half_dungeon_explored_end_follow',
			text = "HALF_DUNGEON_EXPLORED_OPTION_8", reqs = [], dialogue_argument = 8
		}
		],
	},
	
	half_dungeon_explored_end_left = {
		image = null, character = "kurdan", tags = ['KurdanLeft'],
		text = [ {text = "HALF_DUNGEON_EXPLORED_5", reqs = [], previous_dialogue_option = 6}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},
	
	half_dungeon_explored_5 = {
		variations = [ {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}]}],
			image = null, character = "kurdan", tags = ['dialogue_scene'],
			text = [ {text = "HALF_DUNGEON_EXPLORED_6", reqs = []} ],
			options = [ {
			code = 'half_dungeon_explored_im_sure',
			text = "HALF_DUNGEON_EXPLORED_OPTION_9", reqs = [], dialogue_argument = 9
			}, {
			code = 'half_dungeon_explored_3',
			text = "HALF_DUNGEON_EXPLORED_OPTION_10", reqs = [], dialogue_argument = 10
			} ]
			}, {
			reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm_factor', operant = 'lt', value = 4}]}],
			image = null, character = "kurdan", tags = ['dialogue_scene'],
			text = [ {text = "HALF_DUNGEON_EXPLORED_7", reqs = []} ],
			options = [ {
				code = 'half_dungeon_explored_end_left',
				text = "HALF_DUNGEON_EXPLORED_OPTION_6", reqs = [], dialogue_argument = 6
				}, {
				code = 'half_dungeon_explored_5',
				text = "HALF_DUNGEON_EXPLORED_OPTION_7", reqs = [], dialogue_argument = 7
			}, {
				code = 'half_dungeon_explored_end_follow',
				text = "HALF_DUNGEON_EXPLORED_OPTION_8", reqs = [], dialogue_argument = 8
			} 
			],
			}
		]
		},
		
	half_dungeon_explored_im_sure = {
		image = null, character = "kurdan", tags = [],
		text = [ {text = "HALF_DUNGEON_EXPLORED_8", reqs = [], previous_dialogue_option = 9, bonus_effects = [{code = 'decision', value = 'KurdanRecruited'}]
		}],
		common_effects = [{code = 'make_story_character', value = 'Kurdan', recruit_from_location = true, send_to_mansion = true}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	},
	
	half_dungeon_explored_end_follow = {
		image = null, character = "kurdan", tags = [],
		text = [ {text = "HALF_DUNGEON_EXPLORED_9", reqs = [], previous_dialogue_option = 8, bonus_effects = [{code = 'decision', value = 'KurdanFollowing'}]}], #Kurdan is following us in the dungeon and will be transformed by demon to fight us
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = []
			}
		],
	}
}
