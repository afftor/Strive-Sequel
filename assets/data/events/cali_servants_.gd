extends Reference
var data = {
	cali_sex_5 = {
		image = null,
		music = "cali_theme",
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "cali_bj_happy",
		save_scene_to_gallery = true,
		character = "$cali",
		tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'unique_character_checks', name = 'cali', value = [{code = 'true'}], negative = 'cancel'}],
		text = [
			{text = "CALI_SEX_5", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_6',
				text = "CALI_SEX_5_OPTION_1",
				type = 'next_dialogue',
				reqs = [{type = 'has_money', value = 100}],
				dialogue_argument = 1,
				bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = 15}],
			},
			{
				code = 'cali_sex_5_1',
				text = "CALI_SEX_5_OPTION_2",
				type = 'next_dialogue',
				reqs = [{type = 'dialogue_seen', value = 'CALI_SEX_5_1', check = false}],
				dialogue_argument = 2,
			},
			{
				code = 'cali_sex_5_2',
				text = "CALI_SEX_5_OPTION_2",
				type = 'next_dialogue',
				reqs = [{type = 'dialogue_seen', value = 'CALI_SEX_5_1', check = true}],
				dialogue_argument = 2,
			},
		],
	},
	
	cali_sex_6 = {
		image = null,
		character = "$cali",
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		common_effects = [{code = 'money_change', operant = '-', value = 100}],
		text = [
			{text = "CALI_SEX_6", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
#				change_dialogue_type = 2
			}
		],
	},
	cali_sex_7 = {
		image = null,
		character = "$cali",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "CALI_SEX_7", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_8',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_8 = {
		image = null,
		character = "$cali",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "CALI_SEX_8", reqs = []},
		],
		options = [
			{
				code = 'cali_sex_9',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
#				open_speed = 1.0,
				change_dialogue_type = 2
			}
		],
	},

	cali_sex_9 = {
		image = null,
		music = "intimate",
		custom_background = "cali_bj_happy_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = 'decision', value = 'cali_sex'}, {code = 'unique_character_changes', value = 'cali', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		text = [{text = "CALI_SEX_9", reqs = []}],
		options = [
			{
				code = 'cali_sex_10',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_10 = {
		image = null,
		custom_background = "cali_bj_happy_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "CALI_SEX_10", reqs = []}],
		options = [
			{
				code = 'cali_sex_11',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_11 = {
		image = null,
		custom_background = "cali_bj_happy_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [{text = "CALI_SEX_11", reqs = []}],
		options = [
			{
				code = 'cali_sex_12',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_sex_12 = {
		image = null,
		custom_background = "cali_bj_happy_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene',],
		text = [{text = "CALI_SEX_12", reqs = []}],
		options = [
			{
				code = 'cali_sex_13',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				bonus_effects = [
				{code = 'screen_black_transition', value = 1}
				],
				change_dialogue_type = 1
			}
		],
	},
	cali_sex_13 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		character = "$cali",
		text = [ {text = "CALI_SEX_13", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
			{code = 'screen_black_transition', value = 1}
			],
		} ],
	},


	cali_amelia_1 = {
		image = null,
		music = "cali_theme",
		character = "$cali",
		character2 = '$amelia',
		reqs = [{type = "decision", value = "cali_sex", check = false}],
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_1", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_2',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_2 = {
		image = null,
		character = "$cali",
		character2 = '$amelia',
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_2", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_3',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_3 = {
		image = null,
		character = "$cali",
		character2 = '$amelia',
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_3", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_3_1',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
		cali_amelia_3_1 = {
		image = null,
		character = "$cali",
		character2 = '$amelia',
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_3_1", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_4',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	
	cali_amelia_4 = {
		image = null,
		character = "$cali",
		character2 = '$amelia',
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_4", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_4_1',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		],
	},
	cali_amelia_4_1 = {
		image = null,
		music = "intimate",
		custom_background = "amelia_cali_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "amelia_cali",
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_4_1", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_5',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_5 = {
		image = null,
		custom_background = "amelia_cali_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_5", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_6',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
	cali_amelia_6 = {
		image = null,
		custom_background = "amelia_cali_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene', 'master_translate',],
		text = [
			{text = "CALI_AMELIA_6", reqs = []},
		],
		options = [
			{
				code = 'cali_amelia_7',
				text = "DIALOGUECONTINUE",
				type = 'next_dialogue',
				reqs = [],
				dialogue_argument = 1,
				change_dialogue_type = 1,
				close_speed = 1.0
			}
		],
	},
	cali_amelia_7 = {
		image = null,
		character = "$cali",
		character2 = '$amelia',
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
		text = [
			{text = "CALI_AMELIA_7", reqs = []},
		],
		options = [
			{
				code = 'close',
				text = "DIALOGUECLOSE",
				type = 'next_dialogue',
				bonus_effects = [
				{code = 'screen_black_transition', value = 1}
				],
				reqs = [],
				dialogue_argument = 1,
			}
		],
	},
}
