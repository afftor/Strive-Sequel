var data = {
	daisy_training_new_leader_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "DAISY_TRAINING_NEW_LEADER_REPLY_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_TRAINING_NEW_LEADER_REPLY_2_2", reqs = [], previous_dialogue_option = 2},
		{text = "DAISY_TRAINING_NEW_LEADER_REPLY_2_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'daisy_training_new_leader_2', text = "DAISY_TRAINING_NEW_LEADER_OPTION_2_1", reqs = [{type = "has_money", value = 200}], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "training_complete_serve_1", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'money_change', operant = '-', value = 200}],
		}, {
			code = 'daisy_training_new_leader_2', text = "DAISY_TRAINING_NEW_LEADER_OPTION_2_4", reqs = [{type = "has_money", value = 300}, {type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_NEW_LEADER_OPTION_2_2'}], dialogue_argument = 4, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "training_complete_sex_1", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'money_change', operant = '-', value = 300}]
		}, {
			code = 'daisy_training_new_leader_2', text = "DAISY_TRAINING_NEW_LEADER_OPTION_2_5", reqs = [{type = "has_money", value = 400}, {type = 'dialogue_selected', check = true, value = 'DAISY_TRAINING_NEW_LEADER_OPTION_2_3'}], dialogue_argument = 5, type = 'next_dialogue',
			bonus_effects = [{code = 'add_timed_event', value = "daisy_training_intermission_1", args = [{type = 'add_to_date', date = [3,3], hour = 2}]}, {code = 'add_timed_event', value = "training_complete_fucktoy_1", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'money_change', operant = '-', value = 400}]
		}, {
			code = 'daisy_training_new_leader_1', text = "DAISY_TRAINING_NEW_LEADER_OPTION_2_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'daisy_training_new_leader_1', text = "DAISY_TRAINING_NEW_LEADER_OPTION_2_3", reqs = [{type = 'dialogue_selected', check = true, value = 'DAISY_NEW_LEADER_TRAINING_OPTION_2_2'}], dialogue_argument = 3, remove_after_first_use = true
		}, {
			code = 'close', text = "DAISY_TRAINING_NEW_LEADER_OPTION_2_6", reqs = [], dialogue_argument = 6,
		} ],
	},

	daisy_training_new_leader_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		reqs = [], 
		text = [{text = "DAISY_TRAINING_NEW_LEADER_REPLY_2_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_TRAINING_NEW_LEADER_REPLY_2_4", reqs = [], previous_dialogue_option = 4},
		{text = "DAISY_TRAINING_NEW_LEADER_REPLY_2_5", reqs = [], previous_dialogue_option = 5}],
		common_effects = [{code = 'affect_unique_character', name = 'daisy', type = 'set_availability', value = false}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'progress_quest', value = 'daisy_training', stage = 'stage2'}],
		} ],
	},
	
	daisy_lost_new_leader_1 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "DAISY_LOST_NEW_LEADER_REPLY_0", reqs = []}],
		options = [ {
			code = 'daisy_lost_new_leader_2', text = "DAISY_LOST_NEW_LEADER_OPTION_1_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, {
			code = 'daisy_lost_new_leader_2', text = "DAISY_LOST_NEW_LEADER_OPTION_1_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		}, ]
	},

	daisy_lost_new_leader_2 = {
		image = null, tags = ['dialogue_scene'],
		reqs = [], 
		text = [{text = "DAISY_LOST_NEW_LEADER_REPLY_1_1", reqs = [], previous_dialogue_option = 1},
		{text = "DAISY_LOST_NEW_LEADER_REPLY_1_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'make_quest_location', value = 'quest_daisy_admirer_location'},
			{code = 'progress_quest', value = 'daisy_lost', stage = 'stage2'}]
		} ]
	},
	
	marriage_servants_new_leader_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		text = [
			{text = "MARRIAGE_SERVANTS_NEW_LEADER_1_1", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'eq', value = 'anastasia'}}]},
			{text = "MARRIAGE_SERVANTS_NEW_LEADER_1_2", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'neq', value = 'anastasia'}}]},
			{text = "MARRIAGE_SERVANTS_NEW_LEADER_1_3", reqs = []},
		],
		options = [ {
			code = 'marriage_servants_new_leader_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_servants_new_leader_2 = {
		image = null,
		tags = ['dialogue_scene'],
		text = [{text = "MARRIAGE_SERVANTS_NEW_LEADER_2", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'marriage_quest_servants', stage = 'stage1'}]}],
		options = [ 
				{code = 'marriage_servants_new_leader_completed_1', text = "MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_OPTION", reqs = [
					{type = 'has_money', value = 3000},
					{type = 'has_material', operant = 'gte', value = 200, material = 'fish'},
					{type = 'has_material', operant = 'gte', value = 200, material = 'meat'},
					{type = 'has_material', operant = 'gte', value = 200, material = 'vegetables'},
					{type = 'has_material', operant = 'gte', value = 200, material = 'grain'},
					{type = 'has_items', operant = 'gte', value = 25, name = 'beer'},
					{type = 'has_items', operant = 'gte', value = 10, name = 'alcohol'},
					], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'close', text = "RETURN", reqs = []}
			],
	},
	marriage_servants_new_leader_completed_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		text = [{text = "MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_1", reqs = [], bonus_effects = [
			{code = 'money_change', operant = '-', value = 3000},
			{code = 'material_change', operant = '-', material = 'fish', value = 200},
			{code = 'material_change', operant = '-', material = 'meat', value = 200},
			{code = 'material_change', operant = '-', material = 'vegetables', value = 200},
			{code = 'material_change', operant = '-', material = 'grain', value = 200},
			{code = 'remove_item', name = 'beer', number = 25},
			{code = 'remove_item', name = 'alcohol', number = 10},
		]}],
		options = [ {
			code = 'marriage_servants_new_leader_completed_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_servants_new_leader_completed_2 = {
		image = null,
		tags = ['dialogue_scene'], 
		text = [{text = "MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_2", reqs = []}],
		options = [ {code = 'marriage_servants_new_leader_completed_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'}],
	},
	marriage_servants_new_leader_completed_3 = {
		image = null,
		tags = ['dialogue_scene'], 
		text = [{text = "MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_3", reqs = []}],
		options = [ 
			{code = 'marriage_servants_new_leader_completed_4', text = "MARRIAGE_SERVANTS_NEW_LEADER_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'decision', value = 'marry_invitations_made'}]},
			{code = 'marriage_servants_new_leader_completed_4', text = "MARRIAGE_SERVANTS_NEW_LEADER_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			],
	},
	marriage_servants_new_leader_completed_4 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "MARRIAGE_SERVANTS_NEW_LEADER_COMPLETE_4", reqs = []}],
		options = [ 
				{code = 'close', text = "CLOSE", reqs = [], bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_servants'}], type = 'next_dialogue'}
			],
	},
	
	cali_servants_new_leader_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_1", reqs = []} ], 
		options = [ {
			code = 'cali_servants_new_leader_2', text = "CALI_SERVANTS_NEW_LEADER_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_servants_new_leader_2', text = "CALI_SERVANTS_NEW_LEADER_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_servants_new_leader_2', text = "CALI_SERVANTS_NEW_LEADER_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		} ],
	},
	cali_servants_new_leader_2 = {
		character = "cali",
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_2", reqs = []} ],
		options = [ {
			code = 'cali_servants_new_leader_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	}, 
	cali_servants_new_leader_3 = {
		character = "cali",
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_3", reqs = []} ],
		options = [ {
			code = 'cali_servants_new_leader_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	cali_servants_new_leader_4 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], reqs = [], 
		character = "cali",
		common_effects = [{code = 'money_change', operant = '-', value = 500}],
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_4", reqs = []} ],
		options = [ {
			code = 'cali_servants_new_leader_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [],
		}, ],
	},
	cali_servants_new_leader_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_5", reqs = []} ], 
		options = [ {
			code = 'cali_servants_new_leader_end_dialogue', text = "CALI_SERVANTS_NEW_LEADER_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_servants_new_leader_end_dialogue', text = "CALI_SERVANTS_NEW_LEADER_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_servants_new_leader_end_dialogue = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_END_DIALOGUE", reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = "update_guild"},
			{code = 'decision', value = 'CaliAmeliaBonus'},
			{code = 'complete_quest', value = 'cali_servants_quest'},
			{code = 'add_timed_event', value = "cali_sex_5", args = [{type = 'add_to_date', date = [2,2], hour = 2}]},
			{code = 'add_timed_event', value = "cali_heirloom_1", args = [{type = 'add_to_date', date = [5,5], hour = 2}]}]
		}, ],
	},
	cali_servants_new_leader_6 = { # optional part
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "cali", character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_6", reqs = []} ],
		options = [ {
			code = 'cali_servants_new_leader_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', }, ],
	},
	cali_servants_new_leader_7 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "cali", character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_7", reqs = []} ],
		options = [ {
			code = 'cali_servants_new_leader_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', }, ],
	},
	cali_servants_new_leader_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], reqs = [], 
		character = "cali", character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_8", reqs = []} ],
		options = [ 
			{
			code = 'cali_servants_new_leader_9', text = "CALI_SERVANTS_NEW_LEADER_8_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
			{
			code = 'cali_servants_new_leader_9', text = "CALI_SERVANTS_NEW_LEADER_8_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			},
			{
			code = 'cali_servants_new_leader_9', text = "CALI_SERVANTS_NEW_LEADER_8_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			},
			],
	},
	cali_servants_new_leader_9 = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		character = "cali", character2 = "amelia",
		text = [ {text = "CALI_SERVANTS_NEW_LEADER_9", reqs = []} ],
		options = [{
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
				{code = 'unique_character_changes', value = 'cali', args = [
					{code = 'charm', operant = '+', value = 10},
					{code = 'charm_factor', operant = '+', value = 1},
				]} ]
		},],
	},
	
	servants_new_leader_close = {
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "SERVANTS_NEW_LEADER_CLOSE", reqs = []},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
}
