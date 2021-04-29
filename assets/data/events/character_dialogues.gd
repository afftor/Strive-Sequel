var data = {
	zephyra_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_GREET", reqs = [
				{type = 'active_character_checks', value = [{code = 'slave_type', operant = 'neq', value = 'slave'}]}]},
			{text = "ZEPHYRA_EXTRA_GREET2", reqs = [
				{type = 'active_character_checks', value = [{code = 'slave_type', operant = 'eq', value = 'slave'}]}]}
		], 
		options = [ {
			code = 'zephyra_dialogue_1', text = "ZEPHYRA_EXTRA_OPTION1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},
	
	zephyra_dialogue_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "", reqs = [], previous_dialogue_option = 4},
			{text = "ZEPHYRA_EXTRA_REPLY3", reqs = [], previous_dialogue_option = 6},
			{text = "ZEPHYRA_EXTRA_REPLY1_2", reqs = [
				{type = 'active_character_checks', value = [{code = 'slave_type', operant = 'neq', value = 'slave'}]}], previous_dialogue_option = 1},
			{text = "ZEPHYRA_EXTRA_REPLY1_1", reqs = [
				{type = 'active_character_checks', value = [{code = 'slave_type', operant = 'eq', value = 'slave'}]}], previous_dialogue_option = 1}
		], 
		options = [ {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2", reqs = [], dialogue_argument = 5
		}, {
			code = 'zephyra_dialogue_1', text = "ZEPHYRA_EXTRA_OPTION3", reqs = [], dialogue_argument = 6
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}],
	},
	
	zephyra_dialogue_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "", reqs = [], previous_dialogue_option = 5},
			{text = "ZEPHYRA_EXTRA_REPLY2_2", reqs = [], previous_dialogue_option = 2},
			{text = "ZEPHYRA_EXTRA_REPLY2_3", reqs = [], previous_dialogue_option = 3}
		], 
		options = [ {
			code = 'zephyra_dialogue_3', text = "ZEPHYRA_EXTRA_OPTION2_1", reqs = [], dialogue_argument = 1,
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_2", reqs = [], dialogue_argument = 2,
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_3", reqs = [], dialogue_argument = 3,
		}, {
			code = 'zephyra_dialogue_1', text = "Back", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},
	
	zephyra_dialogue_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_REPLY2_1", reqs = [], previous_dialogue_option = 1},
			{text = "ZEPHYRA_EXTRA_REPLY2_1_1", reqs = [], previous_dialogue_option = 2},
			{text = "ZEPHYRA_EXTRA_REPLY2_1_2", reqs = [], previous_dialogue_option = 3},
			{text = "ZEPHYRA_EXTRA_REPLY2_1_3", reqs = [], previous_dialogue_option = 4}
		], 
		options = [ {
			code = 'zephyra_dialogue_3', text = "ZEPHYRA_EXTRA_OPTION2_1_1", reqs = [], dialogue_argument = 2,
		}, {
			code = 'zephyra_dialogue_3', text = "ZEPHYRA_EXTRA_OPTION2_1_2", reqs = [], dialogue_argument = 3,
		}, {
			code = 'zephyra_dialogue_3', text = "ZEPHYRA_EXTRA_OPTION2_1_3", reqs = [], dialogue_argument = 4,
		}, {
			code = 'zephyra_dialogue_2', text = "Back", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},
	
	zephyra_dialogue_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_REPLY3", reqs = []},
		], 
		options = [ {
			code = 'zephyra_dialogue_1', text = "ZEPHYRA_EXTRA_OPTION2", reqs = [], dialogue_argument = 4
		}, ],
	},
}
