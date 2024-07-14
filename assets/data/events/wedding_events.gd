var data = {
	daisy_wedding_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "daisy_wed", 
		text = [{text = "DAISY_WEDDING_1", reqs = []}],
		options = [ {
			code = 'daisy_wedding_2_1', text = "DAISY_WEDDING_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_wedding_2_2', text = "DAISY_WEDDING_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	}, 
	
	daisy_wedding_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "daisy_wed", 
		text = [{text = "DAISY_WEDDING_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		},  ]
	}, 
	
	daisy_wedding_2_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "daisy_wed", 
		text = [{text = "DAISY_WEDDING_2_1", reqs = []}],
		options = [ {
			code = 'daisy_wedding_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		},  ]
	}, 
	
	daisy_wedding_3 = {
		custom_background = "daisy_wedding1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "daisy_wedding",
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "DAISY_WEDDING_3", reqs = [], }],
		options = [ {
			code = 'daisy_wedding_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	daisy_wedding_4 = {
		custom_background = "daisy_wedding2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "DAISY_WEDDING_4", reqs = [], }],
		options = [ {
			code = 'daisy_wedding_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	daisy_wedding_5 = {
		custom_background = "daisy_wedding3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "DAISY_WEDDING_5", reqs = [], }],
		options = [ {
			code = 'daisy_wedding_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, ],
	},
	
	daisy_wedding_6 = {
		custom_background = "daisy_wedding4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "DAISY_WEDDING_6", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		}, ],
	},
	
	
	amelia_wedding_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "amelia", 
		text = [{text = "AMELIA_WEDDING_1", reqs = []}],
		options = [ {
			code = 'amelia_wedding_2_1', text = "AMELIA_WEDDING_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'amelia_wedding_2_2', text = "AMELIA_WEDDING_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	}, 
	
	amelia_wedding_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "amelia", 
		text = [{text = "AMELIA_WEDDING_2_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		}, ],
	}, 
	
	amelia_wedding_2_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "amelia", 
		text = [{text = "AMELIA_WEDDING_2_1", reqs = []}],
		options = [ {
			code = 'amelia_wedding_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		},  ]
	}, 
	
	amelia_wedding_3 = {
		custom_background = "amelia_wedding1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "amelia_wedding",
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_WEDDING_3", reqs = [], }],
		options = [ {
			code = 'amelia_wedding_4_1', text = "AMELIA_WEDDING_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'amelia_wedding_4_2', text = "AMELIA_WEDDING_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},
	
	amelia_wedding_4_1 = {
		custom_background = "amelia_wedding2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_WEDDING_4_1", reqs = [], }],
		options = [ {
			code = 'amelia_wedding_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	amelia_wedding_4_2 = {
		custom_background = "amelia_wedding3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_WEDDING_4_2", reqs = [], }],
		options = [ {
			code = 'amelia_wedding_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	amelia_wedding_5 = {
		custom_background = "amelia_wedding3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_WEDDING_5", reqs = [], }],
		options = [ {
			code = 'amelia_wedding_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ]
	},
	
	amelia_wedding_6 = {
		custom_background = "amelia_wedding4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "AMELIA_WEDDING_6", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		} ]
	},
	
	
	cali_wedding_1 = {
		variations = [ { # GOOD ROUTE
			reqs = [{type = 'decision', value = 'cali_raped', check = false}], 
			image = null, tags = ['dialogue_scene'],
			character = "cali", 
			text = [{text = "CALI_WEDDING_GOOD_1", reqs = []}],
			options = [ {
				code = 'cali_wedding_2_1', text = "CALI_WEDDING_GOOD_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			}, {
				code = 'cali_wedding_2_2', text = "CALI_WEDDING_GOOD_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			}, ]
		}, { # BAD ROUTE
			reqs = [], 
			image = null, tags = ['dialogue_scene'],
			character = "cali", 
			text = [{text = "CALI_WEDDING_BAD_1", reqs = []}],
			options = [ {
				code = 'cali_wedding_2_1', text = "CALI_WEDDING_BAD_1_OPTION_1", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			}, {
				code = 'cali_wedding_2_2', text = "CALI_WEDDING_BAD_1_OPTION_2", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
			}, ]
		}, 
	]},
	
	cali_wedding_2_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [{text = "CALI_WEDDING_GOOD_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "CALI_WEDDING_BAD_2_2", reqs = [], previous_dialogue_option = 4}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		}, ],
	}, 
	
	cali_wedding_2_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "cali", 
		text = [{text = "CALI_WEDDING_GOOD_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_WEDDING_BAD_2_1", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'cali_wedding_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	}, 
	
	cali_wedding_3 = {
		custom_background = "cali_wedding1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "cali_wedding",
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "CALI_WEDDING_3", reqs = [{type = 'decision', value = 'cali_raped', check = false}]}, {text = "CALI_WEDDING_3_BAD", reqs = [{type = 'decision', value = 'cali_raped', check = true}]}],
		options = [ {
			code = 'cali_wedding_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_wedding_4 = {
		custom_background = "cali_wedding2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "CALI_WEDDING_4", reqs = [], }],
		options = [ {
			code = 'cali_wedding_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_wedding_5 = {
		custom_background = "cali_wedding3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "CALI_WEDDING_5", reqs = [{type = 'decision', value = 'cali_raped', check = false}]}, {text = "CALI_WEDDING_5_BAD", reqs = [{type = 'decision', value = 'cali_raped', check = true}]}],
		options = [ {
			code = 'cali_wedding_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	cali_wedding_6 = {
		custom_background = "cali_wedding4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [{text = "CALI_WEDDING_6", reqs = [{type = 'decision', value = 'cali_raped', check = false}]}, {text = "CALI_WEDDING_6_BAD", reqs = [{type = 'decision', value = 'cali_raped', check = true}]}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]
		}, ]
	},
	
	lilia_wedding_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilia", 
		text = [{text = "LILIA_WEDDING_1", reqs = []}],
		options = [ {
			code = 'lilia_wedding_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		},  ]
	}, 
	
	lilia_wedding_2 = {
		custom_background = "lilia_wedding_1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilia_wedding",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILIA_WEDDING_2", reqs = [], }],
		options = [ {
			code = 'lilia_wedding_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_wedding_3 = {
		custom_background = "lilia_wedding_2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILIA_WEDDING_3", reqs = [], }],
		options = [ {
			code = 'lilia_wedding_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_wedding_4 = {
		custom_background = "lilia_wedding_3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILIA_WEDDING_4", reqs = [], }],
		options = [ {
			code = 'lilia_wedding_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_wedding_5 = {
		custom_background = "lilia_wedding_4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILIA_WEDDING_5", reqs = [], }],
		options = [ {
			code = 'lilia_wedding_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_wedding_6 = {
		custom_background = "lilia_wedding_5", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILIA_WEDDING_6", reqs = [], }],
		options = [ {
			code = 'lilia_wedding_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilia_wedding_7 = {
		custom_background = "lilia_wedding_7", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILIA_WEDDING_7", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilith_wedding_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "lilith", 
		text = [{text = "LILITH_WEDDING_1", reqs = []}],
		options = [ {
			code = 'lilith_wedding_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		},  ]
	}, 
	
	lilith_wedding_2 = {
		custom_background = "lilith_wedding_1", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "lilith_wedding",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILITH_WEDDING_2", reqs = [], }],
		options = [ {
			code = 'lilith_wedding_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilith_wedding_3 = {
		custom_background = "lilith_wedding_2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILITH_WEDDING_3", reqs = [], }],
		options = [ {
			code = 'lilith_wedding_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilith_wedding_4 = {
		custom_background = "lilith_wedding_3", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILITH_WEDDING_4", reqs = [], }],
		options = [ {
			code = 'lilith_wedding_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilith_wedding_5 = {
		custom_background = "lilith_wedding_4", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILITH_WEDDING_5", reqs = [], }],
		options = [ {
			code = 'lilith_wedding_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
	
	lilith_wedding_6 = {
		custom_background = "lilith_wedding_5", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "LILITH_WEDDING_6", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},
}
