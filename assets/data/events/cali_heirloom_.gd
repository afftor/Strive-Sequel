extends Reference
var data = {
	cali_william_evening_1 = {
		image = null, music = "intimate_dark",
		dialogue_type = 2,
		scene_type = "ero_scene",
		unlocked_gallery_seq = "cali_william_evening",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		custom_background = "cali_william_evening_1",
		text = [ {text = "CALI_WILLIAM_EVENING_1", reqs = []} ],
		options = [ {
			code = 'cali_william_evening_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_william_evening_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_william_evening_2",
		text = [ {text = "CALI_WILLIAM_EVENING_2", reqs = []} ],
		options = [ {
		code = 'cali_william_evening_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_william_evening_3 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_william_evening_3",
		text = [ {text = "CALI_WILLIAM_EVENING_3", reqs = []} ],
		options = [ {
		code = 'cali_william_evening_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_william_evening_4 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_william_evening_4",
		text = [ {text = "CALI_WILLIAM_EVENING_4", reqs = []} ],
		options = [ {
		code = 'cali_william_evening_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_william_evening_5 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_william_evening_5",
		text = [ {text = "CALI_WILLIAM_EVENING_5", reqs = []} ],
		options = [ {
		code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_grat_1 = {
		image = null,  music = "cali_theme", tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [],
		character = "$cali",
		text = [ {text = "CALI_GRAT_1", reqs = []} ], 
		options = [ {
			code = 'cali_grat_2', text = "CALI_GRAT_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = 20}],
			},
			{
			code = 'cali_grat_4', text = "CALI_GRAT_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = -10}],
			},
			{
			code = 'cali_grat_5', text = "CALI_GRAT_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = -15}],
			}
		],
	},
	cali_grat_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
		text = [ {text = "CALI_GRAT_2", reqs = []} ], 
		options = [ {
			code = 'cali_grat_sex_1', text = "CALI_GRAT_2_OPTION_1", reqs = [{type = "decision", value = "cali_sex", check = true}], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
			},
			{
			code = 'cali_grat_sex_alter_1', text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "cali_sex", check = false}], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
			},
			{
			code = 'cali_grat_3', text = "CALI_GRAT_2_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
		],
	},
	cali_grat_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
		common_effects = [
		{
			code = 'unique_character_changes',
			value = 'cali',
			args = [
				{code = 'take_virginity', type = 'vaginal', partner = 'master'},
			]
		},],
		text = [ {text = "CALI_GRAT_4", reqs = []} ], 
		options = [ {
			code = 'cali_grat_sex_1', text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "cali_sex", check = true}], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
			},
			{
			code = 'cali_grat_sex_alter_1', text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "cali_sex", check = false}], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
			},
		],
	},
	cali_grat_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
		text = [ {text = "CALI_GRAT_7", reqs = []} ], 
		options = [ {
			code = 'cali_grat_8', text = "CALI_GRAT_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = 25}],
			},
			{
			code = 'cali_grat_8', text = "CALI_GRAT_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = -20}],
			},
			{
			code = 'cali_grat_8', text = "CALI_GRAT_7_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = 10}],
			}
		],
	},
	cali_grat_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "$cali",
		text = [ 
			{text = "CALI_GRAT_8_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_GRAT_8_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_GRAT_8_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = []
		} ],
	},
	cali_grat_sex_1 = {
		image = null, music = "intimate",
		custom_background = "cali_riding_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = 'decision', value = 'cali_sex'}],
		tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_1", reqs = []}],
		options = [
			{
				code = 'cali_grat_sex_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_grat_sex_2 = {
		image = null,
		custom_background = "cali_riding_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_2", reqs = []}],
		options = [
			{
				code = 'cali_grat_sex_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_grat_sex_3 = {
		image = null,
		custom_background = "cali_riding_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_3", reqs = []}],
		options = [
			{
				code = 'cali_grat_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1
			}
		],
	},
	cali_grat_sex_alter_1 = {
		image = null, music = "intimate",
		custom_background = "cali_riding_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = 'decision', value = 'cali_sex'}],
		tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_ALTER_1", reqs = []}],
		options = [
			{
				code = 'cali_grat_sex_alter_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_grat_sex_alter_2 = {
		image = null,
		custom_background = "cali_riding_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_ALTER_2", reqs = []}],
		options = [
			{
				code = 'cali_grat_sex_alter_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_grat_sex_alter_3 = {
		image = null,
		custom_background = "cali_riding_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_ALTER_3", reqs = []}],
		options = [
			{
				code = 'cali_grat_sex_alter_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_grat_sex_alter_4 = {
		image = null,
		custom_background = "cali_riding_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "CALI_GRAT_SEX_ALTER_4", reqs = []}],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
}
