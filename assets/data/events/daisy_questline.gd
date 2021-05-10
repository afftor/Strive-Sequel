var data = {
	daisy_recruitment_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_RECRUITMENT_START", reqs = [], }],
		options = [ {
			#TODO add +1 sympathy
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_recruitment_2', text = "DAISY_RECRUITMENT_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ],
	},
	daisy_recruitment_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_RECRUITMENT_REPLY_1", reqs = [], previous_dialogue_option = 1}, 
		{text = "DAISY_RECRUITMENT_REPLY_2", reqs = [], previous_dialogue_option = 2}, 
		{text = "DAISY_RECRUITMENT_REPLY_3", reqs = [], previous_dialogue_option = 3}, ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'add_timed_event', value = "daisy_clothes_1", 
		args = [{type = 'add_to_date', date = [10,10], hour = 8}]}]
		}],
	},
	
	daisy_clothes_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_CLOTHES_START", reqs = [], }],
		options = [ {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_1_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_1_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	
	daisy_clothes_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_CLOTHES_REPLY_1", reqs = [], previous_dialogue_option = 1}, 
		{text = "DAISY_CLOTHES_REPLY_2_3", reqs = [], previous_dialogue_option = 3}, ],
		options = [ {
			code = 'daisy_clothes_3', text = "DAISY_CLOTHES_OPTION_2_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'daisy_clothes_5', text = "DAISY_CLOTHES_OPTION_2_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, {
			code = 'daisy_clothes_2', text = "DAISY_CLOTHES_OPTION_2_3", reqs = [], dialogue_argument = 3, remove_after_first_use = true
		} ],
	},
	
	daisy_clothes_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_CLOTHES_REPLY_2_1", reqs = [], }],
		options = [ {
			#TODO  start quest
			code = 'daisy_clothes_4', text = "DAISY_CLOTHES_OPTION_2_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, {
			code = 'daisy_clothes_4', text = "DAISY_CLOTHES_OPTION_2_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ],
	},
	
	daisy_clothes_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_CLOTHES_REPLY_2_1_1", reqs = [], previous_dialogue_option = 1}, 
		{text = "DAISY_CLOTHES_REPLY_2_1_2", reqs = [], previous_dialogue_option = 2} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1
		}],
	},
	
	daisy_clothes_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], character = 'daisy',
		text = [{text = "DAISY_CLOTHES_REPLY_2_2", reqs = []}],
		options = [ {
			#TODO start quest
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1
		}],
	},
}
