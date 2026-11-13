extends Reference
var data = {
	ana_gryphon_sex_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character2 = '$aire', character = '$anastasia',
		text = [
			{text = "GRYPHON_ANA_SEX_START", reqs = []},
		], 
		options = [
			{code = 'ana_gryphon_sex_1', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character2 = '$aire', character = '$anastasia',
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "aire_gryphon",
		save_scene_to_gallery = true,
		text = [
			{text = "GRYPHON_ANA_SEX_1", reqs = []},
		], 
		options = [
			{code = 'ana_gryphon_sex_2', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character2 = '$aire', character = '$anastasia',
		text = [
			{text = "GRYPHON_ANA_SEX_2", reqs = []},
		], 
		options = [
			{code = 'ana_gryphon_sex_3', text = 'GRYPHON_ANA_SEX_2_OPTION_1',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}, 
			{code = 'ana_gryphon_sex_3', text = 'GRYPHON_ANA_SEX_2_OPTION_2',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}, 
			{code = 'ana_gryphon_sex_3', text = 'GRYPHON_ANA_SEX_2_OPTION_3',reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}, 
		],
	},
	
	ana_gryphon_sex_3 = {
		image = null,
		custom_background = "aire_ana1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_3", reqs = []}],
		common_effects = [{code = 'unique_character_changes', value = 'aire', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		options = [
			{code = 'ana_gryphon_sex_4', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_4 = {
		image = null,
		custom_background = "aire_ana2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_4", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_5', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_5 = {
		image = null,
		custom_background = "aire_ana2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_5", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_6', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_6 = {
		image = null,
		custom_background = "aire_ana3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_6", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_7', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_7 = {
		image = null,
		custom_background = "aire_ana4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_7", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_8', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_8 = {
		image = null,
		custom_background = "aire_ana4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_8", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_9', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_9 = {
		image = null,
		custom_background = "aire_ana5",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_9", reqs = []}],
		options = [
			{code = 'ana_gryphon_sex_10', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
	
	ana_gryphon_sex_10 = {
		image = null,
		custom_background = "aire_ana6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "GRYPHON_ANA_SEX_10", reqs = []}],
		options = [
			{code = 'close', text = 'DIALOGUECONTINUE',reqs = [], dialogue_argument = 1, type = 'next_dialogue'}, 
		],
	},
}
