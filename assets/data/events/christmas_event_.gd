extends Reference
var data = {
	christmas_pre_start = {
		image = null, tags = ['dialogue_scene', "blackscreen_transition_slow",'master_translate'],
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "christmas",
		save_scene_to_gallery = true,
		character = 'zephyra',
		reqs = [
			{type = 'unique_character_checks', name = 'daisy', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'},
			{type = 'quest_completed', name = 'sword_artifact_quest', check = true, negative = 'repeat_next_day'}
			],
		text = [ {text = "CHRISTMAS_EVENT_PRE_INTRO", reqs = []} ],
		options = [ {
			code = 'christmas_start', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_start = {
		image = null, tags = ['dialogue_scene', "blackscreen_transition_common",'master_translate'],
		character = 'daisy_default',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_INTRO", reqs = []} ],
		options = [ {
			code = 'christmas_1', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_1 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'daisy_default',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_1", reqs = []} ],
		options = [ {
			code = 'christmas_2', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_2 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'daisy_default',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_2", reqs = []} ],
		options = [ {
			code = 'christmas_3', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_3 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'daisy_default',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_3", reqs = []} ],
		options = [ {
			code = 'christmas_4', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_4 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'daisy_christmas',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_4", reqs = []} ],
		options = [ {
			code = 'christmas_5', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_5 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'daisy_christmas',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_5", reqs = []} ],
		options = [ {
			code = 'christmas_6', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_6 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'daisy_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_6", reqs = []} ],
		options = [ {
			code = 'christmas_7', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0, change_dialogue_type = 2
		} ]
	},
	
	christmas_7 = { #  CG
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CHRISTMAS_EVENT_7", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "christmas_scene",
		
		options = [ {
			code = 'christmas_8', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0, change_dialogue_type = 1, close_speed = 1.0
		} ]
	},
	
	christmas_8 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'daisy_christmas',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_8", reqs = []} ],
		options = [ {
			code = 'christmas_9', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_9 = {
		image = null, tags = ['dialogue_scene','master_translate'],
		character = 'daisy_christmas',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_9", reqs = []} ],
		options = [ {
			code = 'christmas_10', reqs = [], text = tr("DIALOGUECONTINUE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
	
	christmas_10 = {
		image = null, tags = ['dialogue_scene','master_translate', 'blackscreen_transition_common'],
		character = 'daisy_christmas',
		character2 = 'white_stag_christmas',
		reqs = [],
		text = [ {text = "CHRISTMAS_EVENT_10", reqs = []} ],
		options = [ {
			code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue', dialogue_argument = 0
		} ]
	},
}
