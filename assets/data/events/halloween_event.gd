var data = {
	halloween_start = {
		image = null, tags = ['dialogue_scene', "blackscreen_transition_slow",'master_translate'],
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "halloween_start",
		save_scene_to_gallery = true,
		character = 'zephyra',
		reqs = [{type = 'decision', value = 'mayor_election_finished', check = true, negative = 'repeat_next_day'},
		{type = 'unique_character_checks', name = 'anastasia', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'},
		{type = 'unique_character_checks', name = 'cali', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'},],
		text = [ {text = "HALLOWEEN_EVENT_INTRO", reqs = []} ],
		options = [ {
			code = 'halloween_1', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ] 
	},
	halloween_1 = {
		image = null, tags = ['dialogue_scene', "blackscreen_transition_slow"],
		character = 'anastasia_halloween',
		text = [ {text = "HALLOWEEN_EVENT1", reqs = []} ],
		options = [ {
			code = 'halloween_2', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_2 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		text = [ {text = "HALLOWEEN_EVENT2", reqs = []} ],
		options = [ {
			code = 'halloween_3', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_3 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		text = [ {text = "HALLOWEEN_EVENT3", reqs = []} ],
		options = [ {
			code = 'halloween_4', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_4 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		character2 = 'bandits',
		text = [ {text = "HALLOWEEN_EVENT4", reqs = []} ],
		options = [ {
			code = 'halloween_5', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_5 = {
		image = null, tags = ['dialogue_scene', "blackscreen_transition"],
		character = 'anastasia_halloween',
		character2 = 'cali_halloween',
		text = [ {text = "HALLOWEEN_EVENT5", reqs = []} ],
		options = [ {
			code = 'halloween_6', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_6 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		character2 = 'cali_halloween',
		text = [ {text = "HALLOWEEN_EVENT6", reqs = []} ],
		options = [ {
			code = 'halloween_7', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_7 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		character2 = 'cali_halloween',
		text = [ {text = "HALLOWEEN_EVENT7", reqs = []} ],
		options = [ {
			code = 'halloween_8', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_8 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		character2 = 'cali_halloween',
		text = [ {text = "HALLOWEEN_EVENT8", reqs = []} ],
		options = [ {
			code = 'halloween_9', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_9 = {
		image = null, tags = ['dialogue_scene'],
		character = 'anastasia_halloween',
		character2 = 'cali_halloween',
		text = [ {text = "HALLOWEEN_EVENT9", reqs = []} ],
		options = [ {
			code = 'halloween_10', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0, change_dialogue_type = 2
			}
		]
	},
	halloween_10 = {
		image = null, tags = ['dialogue_scene'],
		custom_background = "halloween_scene",
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		text = [ {text = "HALLOWEEN_EVENT10", reqs = []} ],
		options = [ {
			code = 'halloween_11', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
			}
		]
	},
	halloween_11 = {
		image = null, tags = ['dialogue_scene'],
		text = [ {text = "HALLOWEEN_EVENT11", reqs = []} ],
		options = [ {
			code = 'halloween_12', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0, change_dialogue_type = 1, close_speed = 2.0
			}
		]
	},
	halloween_12 = {
		image = null, tags = ['dialogue_scene', "blackscreen_transition_slow",'master_translate'],
		character = 'anastasia_halloween',
		character2 = 'cali_halloween',
		common_effects = [
			{code = 'unique_character_changes', value = 'cali', args = [
			{code = 'body_image', operant = '=', value = "cali_halloween_body"},
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/cali_halloween_prt.png"}]},
			{code = 'unique_character_changes', value = 'anastasia', args = [
			{code = 'body_image', operant = '=', value = "anastasia_halloween_body"}, 
			{code = 'icon_image', operant = '=', value = "res://assets/images/portraits/anastasia_halloween_prt.png"}]},
			
			
			],
		text = [ {text = "HALLOWEEN_EVENT12", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE")
			}
		]
	},
	
}
