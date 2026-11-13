extends Reference
var data = {
	cali_sex_1_1 = {
		image = null,  music = "intimate", tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		unlocked_gallery_seq = "cali_touching",
		text = [ {text = "CALI_SEX_1_1", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_1",
		common_effects = [{code = 'unique_character_changes', value = 'cali', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		options = [ {
			code = 'cali_sex_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_1_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_SEX_1_2", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_2",
		options = [ {
			code = 'cali_sex_2', text = "CALI_SEX_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sex_2', text = "CALI_SEX_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_sex_2_3', text = "CALI_SEX_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_2_1AND2", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_sex_3_1', text = "CALI_SEX_2_1AND2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sex_3_1', text = "CALI_SEX_2_1AND2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},  ],
	},
	
	cali_sex_3_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_3_1", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_sex_3_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_3_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [ {text = "CALI_SEX_3_2", reqs = []} ],
		dialogue_type = 2,
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_4",
		options = [ {
			code = 'cali_sex_4', text = "CALI_SEX_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_sex_4', text = "CALI_SEX_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},  ],
	},
	
	cali_sex_4 = {
		image = null,  music = "cali_theme", tags = ['dialogue_scene', 'master_translate'], reqs = [],character = "$cali",
		text = [ {text = "CALI_SEX_4_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_SEX_4_2", reqs = [], previous_dialogue_option = 2}, 
		{text = "CALI_SEX_4_ADDITIONAL", reqs = []},],
		dialogue_type = 1,
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},
	
	cali_sex_2_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [ {text = "CALI_SEX_2_3", reqs = []} ],
		dialogue_type = 1,
		options = [ {
			code = 'close', text = "CALI_SEX_2_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_sex_1_1", args = [{type = 'add_to_date', date = [3,3], hour = 3}]}]
		}, {
			code = 'close', text = "CALI_SEX_2_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},  ],
	},
}
