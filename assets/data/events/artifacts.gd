var data = {
	zephyra_artifacts_init = {
		variations = [ {
			image = "letter", tags = ['dialogue_scene'], reqs = [{type = 'decision', value = 'ZephyraRecruited', check = false}],
			text = [{text = "NO_ZEPHYRA_ARTIFACTS_MESSAGE", reqs = []}],
			options = [ {
				code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
				bonus_effects = [{code = 'progress_quest', value = 'zephyra_artifacts_quest', stage = 'stage1'}],
			}],
		}, {
			image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [{type = 'decision', value = 'ZephyraRecruited', check = true}],
			text = [{text = "ZEPHYRA_ARTIFACTS_INIT", reqs = []}], character = "zephyra",
			options = [ {
				code = 'zephyra_artifacts_1', text = "ZEPHYRA_ARTIFACTS_INIT_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			}, {
				code = 'zephyra_artifacts_1', text = "ZEPHYRA_ARTIFACTS_INIT_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', 
			}],
		}, 
		]
	},
	
	zephyra_artifacts_1 = {
		character = "zephyra",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "ZEPHYRA_ARTIFACTS_1", reqs = []}],
		options = [ {
			code = 'zephyra_artifacts_2', text = "ZEPHYRA_ARTIFACTS_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'zephyra_artifacts_2', text = "ZEPHYRA_ARTIFACTS_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	
	zephyra_artifacts_2 = {
		character = "zephyra",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "ZEPHYRA_ARTIFACTS_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "ZEPHYRA_ARTIFACTS_2_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'zephyra_artifacts_quest', stage = 'stage2'}
			]
		}, ],
	},
	
	no_zephyra_artifacts_1 = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_1", reqs = []}],
		options = [ {
			code = 'no_zephyra_artifacts_2_ok', text = "NO_ZEPHYRA_ARTIFACTS_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'no_zephyra_artifacts_2_ok', text = "NO_ZEPHYRA_ARTIFACTS_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'no_zephyra_artifacts_2_no', text = "NO_ZEPHYRA_ARTIFACTS_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		}],
	},
	
	no_zephyra_artifacts_2_no = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_2_NO", reqs = []}],
		options = [ {
			code = 'no_zephyra_artifacts_2_no_close', text = "NO_ZEPHYRA_ARTIFACTS_2_NO_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'no_zephyra_artifacts_1', text = "NO_ZEPHYRA_ARTIFACTS_2_NO_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},
	
	no_zephyra_artifacts_2_no_close = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_2_NO_CLOSE", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	no_zephyra_artifacts_2_ok = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_2_OK_1", reqs = [], previous_dialogue_option = 1},
		{text = "NO_ZEPHYRA_ARTIFACTS_2_OK_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'no_zephyra_artifacts_3', text = "NO_ZEPHYRA_ARTIFACTS_2_OK_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'no_zephyra_artifacts_3', text = "NO_ZEPHYRA_ARTIFACTS_2_OK_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},
	
	no_zephyra_artifacts_3 = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_3_1", reqs = [], previous_dialogue_option = 1},
		{text = "NO_ZEPHYRA_ARTIFACTS_3_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'no_zephyra_artifacts_4_1', text = "NO_ZEPHYRA_ARTIFACTS_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'no_zephyra_artifacts_4_2', text = "NO_ZEPHYRA_ARTIFACTS_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}],
	},
	
	no_zephyra_artifacts_4_1 = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_4_1", reqs = []}],
		common_effects = [{code = 'make_story_character', value = 'Zephyra', recruit_from_location = true},
		{type = 'decision', value = 'ZephyraRecruited'},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'progress_quest', value = 'zephyra_artifacts_quest', stage = 'stage2'}
			]
		}, ],
	},
	
	no_zephyra_artifacts_4_2 = {
		character = "ginny", character2 = "zephyra",
		custom_background = "church_event",
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "NO_ZEPHYRA_ARTIFACTS_4_2", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [
				{code = 'complete_quest', value = 'zephyra_artifacts_quest'},
			],
		}, ],
	},
}
