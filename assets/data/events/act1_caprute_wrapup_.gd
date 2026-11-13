extends Reference
var data = {
	guilds_meeting_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = '$amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_16", reqs = []}],
		options = [ {
			code = 'guilds_meeting_6', text = "PRE_ANASTASIA_EXECUTION_OPTION_9", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'guilds_meeting_15', text = "PRE_ANASTASIA_EXECUTION_OPTION_10", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		}],
	},
	
	guilds_meeting_15 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan', character2 = '$amelia',
		text = [{text = "PRE_ANASTASIA_EXECUTION_28", reqs = []}],
		options = [ {
			code = 'anastasia_execution_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = "close_guild_window"}],
		}],
	},
	
	about_princess_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "MIND_CONTROL_7", reqs = []}],
		options = [ {
			code = 'about_princess_2', text = "YES", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'fighters_introduction2', text = "NO", reqs = [], dialogue_argument = 0, type = 'next_dialogue'
		}],
	},
	
	about_princess_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = 'duncan',
		text = [{text = "MIND_CONTROL_8", reqs = []}],
		options = [ {
			code = 'anastasia_execution_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = "close_guild_window"}],
		}],
	},	anastasia_execution_start = {
		image = null,  music = 'intimate_dark', tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], character = '$amelia',
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "anastasia_execution",
		save_scene_to_gallery = true,
		text = [{text = "ANASTASIA_EXECUTION_1", reqs = []}],
		options = [ {
			code = 'anastasia_execution_1', text = "ANASTASIA_EXECUTION_OPTION_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'anastasia_execution_1', text = "ANASTASIA_EXECUTION_OPTION_2", reqs = [], dialogue_argument = 2,
		}],
	},
	
	anastasia_execution_1 = {
		image = null, tags = ['dialogue_scene'], reqs = [], character = '$amelia',
		text = [{text = "ANASTASIA_EXECUTION_2", reqs = [], previous_dialogue_option = 1},
		{text = "ANASTASIA_EXECUTION_3", reqs = [], previous_dialogue_option = 2},
		{text = "ANASTASIA_EXECUTION_4", reqs = []}],
		options = [ {
			code = 'anastasia_execution_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, change_dialogue_type = 2, open_speed = 0.5, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_2 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_5", reqs = []}], 
		custom_background = "anastasia_execution1", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_3 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_6", reqs = []}], custom_background = "anastasia_execution2", 
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		options = [ {
			code = 'anastasia_execution_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_4 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_7", reqs = []}], custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_5', text = "ANASTASIA_EXECUTION_OPTION_3", reqs = [], dialogue_argument = 1,
		}, {
			code = 'anastasia_execution_5', text = "ANASTASIA_EXECUTION_OPTION_4", reqs = [], dialogue_argument = 2,
		}, {
			code = 'anastasia_execution_5', text = "ANASTASIA_EXECUTION_OPTION_5", reqs = [], dialogue_argument = 3,
		}],
	},
	
	anastasia_execution_5 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [
#		{text = "ANASTASIA_EXECUTION_8", reqs = [], previous_dialogue_option = 1},
#		{text = "ANASTASIA_EXECUTION_9", reqs = [], previous_dialogue_option = 2},
#		{text = "ANASTASIA_EXECUTION_10", reqs = [], previous_dialogue_option = 3},
		{text = "ANASTASIA_EXECUTION_11", reqs = []}], 
		custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_6 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_12", reqs = []}], custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,  type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_13", reqs = []}], custom_background = "anastasia_execution2", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'anastasia_execution_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},
	
	anastasia_execution_8 = {
		image = null, tags = ['dialogue_scene'], reqs = [],
		text = [{text = "ANASTASIA_EXECUTION_14", reqs = []}], custom_background = "anastasia_execution3", 
		save_scene_to_gallery = true,
		scene_type = "ero_scene",
		options = [ {
			code = 'duncans_declaration_start', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, change_dialogue_type = 1, close_speed = 1, type = 'next_dialogue'
		}],
	},
	
	duncans_declaration_start = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], character = 'duncan',
		text = [{text = "DUNCANS_DECLARATION_START", reqs = []}], 
		options = [ {
			code = 'final_words_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	}
}
