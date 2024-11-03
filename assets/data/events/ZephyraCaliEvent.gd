extends Reference
var data = {
	ZCEvent_1 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [{type = 'unique_character_at_mansion', name = 'zephyra', check = true, negative = 'repeat_next_day'},
		{type = 'unique_character_at_mansion', name = 'cali', check = true, negative = 'repeat_next_day'},
		{type = 'dialogue_seen', check = false, value = 'ZCEVENT_2'}],
		text = [ {text = "ZCEVENT_1", reqs = []} ],
		options = [ {
			code = 'ZCEvent_2', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	}, 
	
	ZCEvent_2 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [],
		text = [ {text = "ZCEVENT_2", reqs = []} ],
		options = [ {
			code = 'ZCEvent_3', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0,
			bonus_effects = [#{code = 'teleport_active_location', to_loc = {location = 'aliron', code = 'aliron', area = 'plains'}},
			]
		} ]
	},
	
	ZCEvent_3 = { # to town
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [],
		text = [ {text = "ZCEVENT_3", reqs = []} ],
		options = [ {
			code = 'ZCEvent_4', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_4 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [],
		text = [ {text = "ZCEVENT_4", reqs = []} ],
		options = [ {
			code = 'ZCEvent_5', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_5 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [],
		text = [ {text = "ZCEVENT_5", reqs = []} ],
		options = [ {
			code = 'ZCEvent_6', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_6 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		reqs = [],
		text = [ {text = "ZCEVENT_6", reqs = []} ],
		options = [ {
			code = 'ZCEvent_7', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_7 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [],
		text = [ {text = "ZCEVENT_7", reqs = []} ],
		options = [ {
			code = 'ZCEvent_8', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_8 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'cali',
		character2 = 'zephyra',
		reqs = [],
		text = [ {text = "ZCEVENT_8", reqs = []} ],
		options = [ {
			code = 'ZCEvent_9', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0, change_dialogue_type = 2
		} ]
	},
	
	ZCEvent_9 = { # CG1
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		reqs = [],
		text = [{text = "ZCEVENT_9", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "cali_zephyra",
		custom_background = "cali_zephyra_1",
		
		options = [ {
			code = 'ZCEvent_10', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_10 = { # CG2
		image = null, tags = ['dialogue_scene','master_translate'],
		text = [{text = "ZCEVENT_10", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_zephyra_2",
		
		options = [ {
			code = 'ZCEvent_11', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	ZCEvent_11 = { # CG2
		image = null, tags = ['dialogue_scene','master_translate'],
		text = [{text = "ZCEVENT_11", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_zephyra_2",
		options = [ {
			code = 'ZCEvent_12', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0, change_dialogue_type = 1, close_speed = 1.0
		} ]
	},
	
	ZCEvent_12 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		reqs = [],
		text = [ {text = "ZCEVENT_12", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	
}
