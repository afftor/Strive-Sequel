extends Reference
var data = {
	cali_act3_blow_1 = {
		image = null, music = "intimate_dark", tags = ['dialogue_scene'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT3_BLOW_1", reqs = []}],
		options = [ {
			code = 'cali_act3_blow_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act3_blow_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT3_BLOW_2", reqs = []}],
		options = [ {
			code = 'cali_act3_blow_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ]
	},

	cali_act3_blow_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_1",
		options = [ {
			code = 'cali_act3_blow_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act3_blow_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_1",
		options = [ {
			code = 'cali_act3_blow_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act3_blow_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_1",
		options = [ {
			code = 'cali_act3_blow_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act3_blow_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_6", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_2",
		options = [ {
			code = 'cali_act3_blow_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act3_blow_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_7", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_2",
		options = [ {
			code = 'cali_act3_blow_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act3_blow_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT3_BLOW_8", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bj_happy_3",
		options = [ {
			code = 'cali_act3_blow_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},

	cali_act3_blow_9 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT3_BLOW_9", reqs = []},
			{text = "", reqs = [{type = 'decision', value = 'cali_normal_collar', check = true}],
				bonus_effects = [{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_collar_enchanted", parts = {}}
						],
			},]},
			{text = "", reqs = [{type = 'decision', value = 'cali_exquisite_collar', check = true}],
				bonus_effects = [{code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_collar_enchanted_2", parts = {}}
						],
			},]},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_taming_quest', stage = 'stage11'},
				{code = 'add_timed_event', value = "cali_act4_merchant_start", args = [{type = 'add_to_date', date = [3,3], hour = 1}]},
			{code = 'decision', value = 'cali_dating_unlocked'}
			]
		}, ]
	},

	cali_act4_mast_1 = {
		image = null, music = "intimate",  tags = ['dialogue_scene', 'master_translate'],
		reqs = [{type = 'unique_character_checks', name = 'cali', value = [{code = 'is_free', check = true}], negative = 'repeat_next_day'}],
		text = [{text = "CALI_ACT4_MAST_1", reqs = [], }],
		options = [ {
			code = 'cali_act4_mast_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},

	cali_act4_mast_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_1",
		options = [ {
			code = 'cali_act4_mast_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act4_mast_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_1",
		options = [ {
			code = 'cali_act4_mast_4', text = "CALI_ACT4_MAST_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = -10}],
		}, {
			code = 'cali_act4_mast_4_leave', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1,
			bonus_effects = [{code = "affect_unique_character", name = "cali", type = "stat", stat = "affection", value = 5}],
		}, ]
	},

	cali_act4_mast_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_2",
		options = [ {
			code = 'cali_act4_mast_5', text = "CALI_ACT4_MAST_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act4_mast_6', text = "CALI_ACT4_MAST_4_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act4_mast_4_leave = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_4_LEAVE", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_act5_pet_start", args = [{type = 'add_to_date', date = [3,3], hour = 1}]}]
		}, ],
	},

	cali_act4_mast_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_act4_fuck_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act4_fuck_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_FUCK_1", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_fuck_1",
		options = [ {
			code = 'cali_act4_fuck_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act4_fuck_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_FUCK_2", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_fuck_2",
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "cali_act5_pet_start", args = [{type = 'add_to_date', date = [3,3], hour = 1}]}]
		}, ]
	},

	cali_act4_mast_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT4_MAST_6", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_touching_3",
		options = [ {
			code = 'cali_act4_fuck_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act5_pet_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT5_PET_6", reqs = [], }],
		options = [ {
			code = 'cali_act5_pet_7', text = "CALI_ACT5_PET_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2,
		}, {
			code = 'cali_act5_pet_7', text = "CALI_ACT5_PET_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2,
		}, {
			code = 'cali_act5_pet_7_gone', text = "CALI_ACT5_PET_6_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},

	cali_act5_pet_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT5_PET_7", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_1",
		options = [ {
			code = 'cali_act5_pet_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act5_pet_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT5_PET_8", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_2",
		options = [ {
			code = 'cali_act5_pet_9_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},

	cali_act5_pet_9_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT5_PET_9_1", reqs = [], }],
		options = [ {
			code = 'cali_act5_pet_9_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},

	cali_act5_pet_9_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT5_PET_9_2", reqs = [], }],
		options = [ {
			code = 'cali_act5_pet_10', text = "CALI_ACT5_PET_9_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act5_pet_10', text = "CALI_ACT5_PET_9_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},

	cali_act5_pet_10 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT5_PET_10_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_ACT5_PET_10_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'cali_taming_quest'},
			{code = 'add_timed_event', value = "cali_act6_naked_1", args = [{type = 'add_to_date', date = [1,1], hour = 3}]}]
		}, ],
	},

	cali_act6_naked_1 = {
		image = null, music = "intimate_dark", tags = ['dialogue_scene', 'master_translate'],
		unlocked_gallery_seq = "cali_act6_naked",
		save_scene_to_gallery = true,
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT6_NAKED_1", reqs = [], }],
		options = [ {
			code = 'cali_act6_naked_2', text = "CALI_ACT6_NAKED_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'cali_act6_naked_2', text = "CALI_ACT6_NAKED_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'cali_act6_naked_2_3', text = "CALI_ACT6_NAKED_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}, ],
	},

	cali_act6_naked_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT6_NAKED_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "CALI_ACT6_NAKED_2_2", reqs = [], previous_dialogue_option = 2}, ],
		options = [ {
			code = 'cali_act6_naked_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, ],
	},

	cali_act6_naked_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_3", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_1",
		options = [ {
			code = 'cali_act6_naked_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act6_naked_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_4", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_2",
		options = [ {
			code = 'cali_act6_naked_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act6_naked_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_5", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_3",
		options = [ {
			code = 'cali_act6_naked_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ]
	},

	cali_act6_naked_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [],
		text = [{text = "CALI_ACT6_NAKED_6", reqs = []}],
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		custom_background = "cali_bowl_naked_4",
		options = [ {
			code = 'cali_act6_naked_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1
		}, ]
	},

	cali_act6_naked_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], character = "$cali",
		text = [{text = "CALI_ACT6_NAKED_7", reqs = []}],
		common_effects = [{code = 'plan_mansion_event', value = 'ZCEvent_1'},
					{code = 'decision', value = "cali_training_unlocked"}],
		options = [ {
			code = 'close', text = "CALI_ACT6_NAKED_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'add_profession', profession = "petbeast"}]},]
		}, ],
	},
}
