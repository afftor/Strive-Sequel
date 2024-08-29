var data = {
	
	cali_heirloom_1 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_HEIRLOOM_1", reqs = []} ], 
		options = [ {
			code = 'cali_heirloom_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_heirloom_2 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HEIRLOOM_2", reqs = []} ], 
		options = [ {
			code = 'cali_heirloom_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_heirloom_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HEIRLOOM_3", reqs = []} ], 
		options = [ {
			code = 'cali_heirloom_4', text = "CALI_HEIRLOOM_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_heirloom_4', text = "CALI_HEIRLOOM_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_heirloom_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HEIRLOOM_4_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_HEIRLOOM_4_1", reqs = [], previous_dialogue_option = 2},],
		options = [ {
			code = 'cali_heirloom_5', text = "CALI_HEIRLOOM_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_heirloom_finish', text = "CALI_HEIRLOOM_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_heirloom_finish = {
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_HEIRLOOM_FINISH", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'remove_character'}]}]
		} ],
	},
	cali_heirloom_5 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HEIRLOOM_5", reqs = []} ], 
		options = [ {
			code = 'cali_heirloom_6_init', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_heirloom_6_init = {
		image = null, tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HEIRLOOM_6_INIT", reqs = [], previous_dialogue_option = 1},],
		options = [ {
			code = 'cali_heirloom_6', text = "CALI_HEIRLOOM_6_OPTION_1", reqs = [], dialogue_argument = 1
		},
		{
			code = 'cali_heirloom_6', text = "CALI_HEIRLOOM_6_OPTION_2", reqs = [], dialogue_argument = 2
		},
		{
			code = 'cali_heirloom_6', text = "CALI_HEIRLOOM_6_OPTION_3", reqs = [], dialogue_argument = 3
		},
		{
			code = 'cali_heirloom_7', text = "CALI_HEIRLOOM_6_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		},
		 ],
	},
	cali_heirloom_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_HEIRLOOM_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_HEIRLOOM_6_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_HEIRLOOM_6_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [ {
			code = 'cali_heirloom_6', text = "CALI_HEIRLOOM_6_OPTION_1", reqs = [], dialogue_argument = 1
		},
		{
			code = 'cali_heirloom_6', text = "CALI_HEIRLOOM_6_OPTION_2", reqs = [], dialogue_argument = 2
		},
		{
			code = 'cali_heirloom_6', text = "CALI_HEIRLOOM_6_OPTION_3", reqs = [], dialogue_argument = 3
		},
		{
			code = 'cali_heirloom_7', text = "CALI_HEIRLOOM_6_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		},
		 ],
	},
	cali_heirloom_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HEIRLOOM_7", reqs = []},],
		options = [ {
			code = 'cali_heirloom_8', text = "CALI_HEIRLOOM_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_heirloom_8', text = "CALI_HEIRLOOM_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		 ],
	},
	cali_heirloom_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_HEIRLOOM_8_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_HEIRLOOM_8_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_HEIRLOOM_8", reqs = []},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage1'},
				{code = 'set_location_param', location = 'settlement_plains2', area = 'plains', param = 'locked', value = true},
				#2add/fix location part
			]
		},
		 ],
	},
	cali_farmer_1 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FARMER_1", reqs = []} ], 
		options = [ {
			code = 'cali_farmer_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_farmer_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FARMER_2", reqs = []} ], 
		options = [ {
			code = 'cali_farmer_3', text = "CALI_FARMER_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_farmer_3', text = "CALI_FARMER_2_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_farmer_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FARMER_3", reqs = []} ], 
		options = [ {
			code = 'cali_farmer_4', text = "CALI_FARMER_3_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_farmer_4', text = "CALI_FARMER_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_farmer_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_FARMER_4_1", reqs = [{type = 'active_quest_stage', value = 'cali_heirloom_quest', stage = 'stage2'}]}, #return text
			{text = "CALI_FARMER_4_2", reqs = [], previous_dialogue_option = 2}, #normal first time text
			{text = "CALI_FARMER_4_3", reqs = [], previous_dialogue_option = 3}, #get discount text
			], 
		options = [ {
			code = 'cali_farmer_5', text = "CALI_FARMER_4_OPTION_1", reqs = [{type = 'has_material', operant = 'gte', value = 200, material = 'wood'},{type = "decision", value = "cali_wood_discount", check = false}], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_farmer_5', text = "CALI_FARMER_4_OPTION_1_1", reqs = [{type = 'has_material', operant = 'gte', value = 100, material = 'wood'},{type = "decision", value = "cali_wood_discount", check = true}], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_farmer_4', text = "CALI_FARMER_4_OPTION_2", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'worker', check = true}]}], dialogue_argument = 3, type = 'next_dialogue', remove_after_first_use = true, bonus_effects = [{code = 'decision', value = 'cali_wood_discount'},],
		},
		{
			code = 'cali_farmer_6', text = "CALI_FARMER_4_OPTION_3", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_farmer_5 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FARMER_5", reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [{type = "decision", value = "cali_wood_discount", check = false}], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage3'},
				{code = 'update_location'},
				{code = 'material_change', operant = '-', material = 'wood', value = 200},
				{code = 'make_quest_location', value = 'quest_cali_bandits_location'},
				{code = 'set_location_param', location = 'settlement_plains2', area = 'plains', param = 'locked', value = false}
			]
		},
		{
			code = 'close', text = "DIALOGUECLOSE", reqs = [{type = "decision", value = "cali_wood_discount", check = true}], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage3'},
				{code = 'update_location'},
				{code = 'material_change', operant = '-', material = 'wood', value = 100},
				{code = 'make_quest_location', value = 'quest_cali_bandits_location'},
				{code = 'set_location_param', location = 'settlement_plains2', area = 'plains', param = 'locked', value = false},
			]
		},
		 ],
	},
	cali_farmer_6 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FARMER_6", reqs = []} ], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [
				{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage2'}, {code = 'update_location'}
			]
		}, ],
	},
	
	
	cali_bandits_1 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_BANDITS_1", reqs = []},],
		options = [ {
			code = 'cali_bandits_2', text = "CALI_BANDITS_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_bandits_2', text = "CALI_BANDITS_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_bandits_2', text = "CALI_BANDITS_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		},
		 ],
	},
	cali_bandits_2 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_BANDITS_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_BANDITS_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_BANDITS_2_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = []
		} ],
	},
	cali_bandits_3 = {
		image = 'cali_bandit_win', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_BANDITS_3", reqs = []} ], 
		options = [ {
			code = 'cali_bandits_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'play_sound', value = 'slap'}]
		} ],
	},
	cali_bandits_4 = {
		image = 'cali_bandit_win', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_BANDITS_4", reqs = [], previous_dialogue_option = 1},],
		options = [ {
			code = 'cali_bandits_5', text = "CALI_BANDITS_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_bandits_5', text = "CALI_BANDITS_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		 ],
	},
	cali_bandits_5 = {
		image = 'cali_bandit_win', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ 
			{text = "CALI_BANDITS_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_BANDITS_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_BANDITS_5", reqs = []},
		],
		options = [ {
			code = 'cali_bandits_6', text = "CALI_BANDITS_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_bandits_6', text = "CALI_BANDITS_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_bandits_6', text = "CALI_BANDITS_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		},
		 ],
	},
	cali_bandits_6 = {
		image = 'cali_bandit_win', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ 
			{text = "CALI_BANDITS_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_BANDITS_6_2", reqs = [], previous_dialogue_option = 2},
			{text = "CALI_BANDITS_6_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [ {
			code = 'cali_bandits_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = []
		} ],
	},
	cali_bandits_7 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_BANDITS_7", reqs = [], previous_dialogue_option = 1},],
		options = [ {
			code = 'cali_bandits_8', text = "CALI_BANDITS_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_bandits_8', text = "CALI_BANDITS_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		 ],
	},
	cali_bandits_8 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [{text = "CALI_BANDITS_8", reqs = [],}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'set_completed_active_location'}, {code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage4'}]
		} ],
	},
	
	cali_william_init = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [{text = "CALI_WILLIAM_INIT", reqs = [],}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage5'},{code = 'update_city'}]
		} ],
	},
	cali_william_1 = {
		variations = [
			{
				reqs = [{type = "decision", value = "mayor_election_finished", check = false}],
				image = null, tags = ['dialogue_scene'], 
				text = [{text = "CALI_WILLIAM_REFUSE", reqs = [],}],
				options = [ {
					code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				} ],
			},
			{
				image = 'cali_meeting',
				tags = ['dialogue_scene'], 
				reqs = [],
				text = [ {text = "CALI_WILLIAM_1", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage5_1'}]}],
				options = [ {
					code = 'cali_william_2', text = "CALI_WILLIAM_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				},
				{
					code = 'cali_william_2', text = "CALI_WILLIAM_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
				},
				 ],
			},
		]
	},
	cali_william_2 = {
		image = 'cali_meeting',
		tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_WILLIAM_2", reqs = []},],
		options = [ {
			code = 'cali_william_3', text = "CALI_WILLIAM_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_william_3', text = "CALI_WILLIAM_2_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		 ],
	},
	cali_william_3 = {
		image = 'cali_meeting',
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [ 
			{text = "CALI_WILLIAM_3_1", reqs = [{type = 'active_quest_stage', value = 'cali_heirloom_quest', stage = 'stage6'}]}, #return
			{text = "CALI_WILLIAM_3_2", reqs = [], previous_dialogue_option = 3}, #bargain fail
			{text = "CALI_WILLIAM_3", reqs = [{type = 'active_quest_stage', value = 'cali_heirloom_quest', stage = 'stage5_1'}], bonus_effects = [{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage6'}], previous_dialogue_option = 1},
		],
		options = [ {
			code = 'cali_william_4', text = "CALI_WILLIAM_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', remove_after_first_use = true, bonus_effects = [{code = 'decision', value = 'cali_heirloom_bargain'}],
		},
#		{
#			code = 'cali_william_5', text = "CALI_WILLIAM_4_OPTION_1", reqs = [{type = "decision", value = "cali_heirloom_bargain", check = true}], dialogue_argument = 1, type = 'next_dialogue',
#		},
		{
			code = 'cali_william_11', text = "CALI_WILLIAM_4_OPTION_2", reqs = [{type = "decision", value = "cali_heirloom_bargain", check = true}, {type = "decision", value = "cali_keep", check = false},], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_william_10', text = "CALI_WILLIAM_4_OPTION_3", reqs = [{type = "decision", value = "cali_heirloom_bargain", check = true}, {type = "decision", value = "cali_keep", check = false},], dialogue_argument = 3, type = 'next_dialogue',
		},
		{
			code = 'cali_grat_1', text = "CALI_WILLIAM_3_OPTION_2", reqs = [{type = 'has_money', value = 5000}], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = 'money_change', operant = '-', value = 5000}, {code = 'decision', value = 'cali_heirloom_good'},{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage8'},{code = 'update_city'}, {code = 'add_timed_event', args = [{type = 'action_to_date', date = [1,1], hour = 2, action = 'quest'}], value = {quest = 'cali_heirloom_quest', stage = 'stage9'}}],
		},
		{
			code = 'close', text = "CALI_WILLIAM_3_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		},
		 ],
	},
	cali_william_4 = {
		image = 'cali_meeting',
		tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "CALI_WILLIAM_4", reqs = [], previous_dialogue_option = 1}],
		options = [ {
			code = 'cali_william_5', text = "CALI_WILLIAM_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		{
			code = 'cali_william_11', text = "CALI_WILLIAM_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_william_10', text = "CALI_WILLIAM_4_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
		},
		{
			code = 'cali_william_6', text = "CALI_WILLIAM_4_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue',
		},
		 ],
	},
	cali_william_5 = {
		image = 'cali_meeting', 
		tags = ['dialogue_scene'], 
		reqs = [],
		text = [{text = "CALI_WILLIAM_5", reqs = []}],
		options = [ {
			code = 'cali_william_9', text = "SELECT", reqs = [], dialogue_argument = 1, type = 'next_dialogue', select_person = true
		}, 
		{code = 'cali_william_4', text = "CALI_WILLIAM_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		 ],
	},
	cali_william_6 = {
		image = 'cali_meeting', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_WILLIAM_6", reqs = []} ], 
		options = [ {
			code = 'cali_william_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_william_7 = {
		image = null, 
		tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [],
		character = "cali",
		text = [{text = "CALI_WILLIAM_7", reqs = []}],
		options = [ {
			code = 'cali_william_8', text = "CALI_WILLIAM_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		{
			code = 'cali_william_8', text = "CALI_WILLIAM_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		],
	},
	cali_william_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_WILLIAM_8_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_WILLIAM_8_2", reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = 'decision', value = 'cali_keep'}]},],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		},
		 ],
	},
	cali_william_11 = {
		variations = [
			{
				image = 'cali_meeting',
				tags = ['dialogue_scene'], 
				reqs = [{type = 'unique_character_checks', name = 'cali', value = [{code = 'stat', stat = 'sexuals', operant = 'gte', value = 50}, {code = 'stat', stat = 'charm', operant = 'gte', value = 50, orflag = true}]}],
				text = [ {text = "CALI_WILLIAM_11_1", reqs = []}],
				options = [ {
					code = 'cali_william_12', text = "CALI_WILLIAM_11_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
				},
				{
					code = 'cali_william_12', text = "CALI_WILLIAM_11_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', bonus_effects = [{code = 'decision', value = 'cali_heirloom_discount'},]
				},
				 ],
			},
			{
				image = 'cali_meeting',
				tags = ['dialogue_scene'], 
				reqs = [],
				text = [ {text = "CALI_WILLIAM_11_2", reqs = []}],
				options = [ {
					code = 'cali_william_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
				},
				 ],
			},
		]
	},
	cali_william_12 = {
		image = 'cali_meeting', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_WILLIAM_12", reqs = []} ], 
		options = [ {
			code = 'cali_william_13_1', text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "cali_heirloom_discount", check = false}], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_william_13_2', text = "DIALOGUECONTINUE", reqs = [{type = "decision", value = "cali_heirloom_discount", check = true}], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	
	cali_william_9 = { #proxy for effects
		image = 'cali_meeting', tags = ['dialogue_scene'], 
		reqs = [],
		text = [], 
		common_effects = [ #add quest progress
			{code = 'affect_active_character', type = 'quest', duration = 7, id = 'cali_heirloom', name = 'Assignment'},
			{code = 'decision', value = 'cali_heirloom_good'},
			{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage8'}
			
		],
		options = [ {
			code = 'cali_grat_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}, {code = 'add_timed_event', args = [{type = 'action_to_date', date = [1,1], hour = 2, action = 'quest'}], value = {quest = 'cali_heirloom_quest', stage = 'stage9'}}]
		} ],
	},
	cali_william_10 = { #proxy for effects mostly
		image = 'cali_meeting', tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_WILLIAM_10", reqs = []} ], 
		common_effects = [ #add quest progress
			{code = 'affect_unique_character', name = 'cali', type = 'set_availability', value = false},
			{code = 'add_timed_event', value = "cali_returns", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage7'},{code = 'update_city'}
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		} ],
	},
	cali_william_13_1 = { #proxy for effects mostly
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_WILLIAM_13", reqs = []} ], 
		common_effects = [ #add quest progress
			{code = 'affect_unique_character', name = 'cali', type = 'set_availability', value = false},
			{code = 'add_timed_event', value = "cali_returns", args = [{type = 'add_to_date', date = [7,7], hour = 2}]},
			{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage7'},
			{code = 'money_change', operant = '+', value = 3000},{code = 'update_city'}
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		} ],
	},
	cali_william_13_2 = { #proxy for effects mostly
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		text = [ {text = "CALI_WILLIAM_13", reqs = []} ], 
		common_effects = [ #add quest progress
			{code = 'affect_unique_character', name = 'cali', type = 'set_availability', value = false},
			{code = 'add_timed_event', value = "cali_returns", args = [{type = 'add_to_date', date = [3,3], hour = 2}]},
			{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage7'}
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'update_city'}]
		} ],
	},
#
#	cali_returns = { #proxy for effects
#		image = null, tags = ['dialogue_scene'], 
#		reqs = [],
#		character = "cali",
#		text = [ {text = "CALI_RETURNS", reqs = []} ], 
#		options = [ {
#			code = 'cali_grat_bad', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
#		} ],
#	},
	cali_returns = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_GRAT_BAD", reqs = []} ],
		common_effects = [ #add quest progress
			{code = 'affect_unique_character', name = 'cali', type = 'set_availability', value = true},
			{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage8'},
			
			{
				code = 'unique_character_changes',
				value = 'cali',
				args = [
					{code = 'take_virginity', type = 'vaginal', partner = 'william'},
					{code = 'take_virginity', type = 'anal', partner = 'william'},
					{code = 'metrics_randompartners', operant = '+', value = 3},
				]
			},
		],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'add_timed_event', args = [{type = 'action_to_date', date = [1,1], hour = 2, action = 'quest'}], value = {quest = 'cali_heirloom_quest', stage = 'stage9'}}]
		} ],
	},
	cali_grat_1 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_GRAT_1", reqs = []} ], 
		options = [ {
			code = 'cali_grat_2', text = "CALI_GRAT_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
			{
			code = 'cali_grat_4', text = "CALI_GRAT_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			},
			{
			code = 'cali_grat_5', text = "CALI_GRAT_1_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			} 
		],
	},
	cali_grat_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
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
	cali_grat_3 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_GRAT_3", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'add_timed_event', value = "cali_amelia_1", args = [{type = 'add_to_date', date = [1,1], hour = 2}]}]
		} ],
	},
	cali_grat_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
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
	cali_grat_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_GRAT_5", reqs = []} ], 
		options = [ {
			code = 'cali_grat_1', text = "CALI_GRAT_5_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
			code = 'cali_grat_6', text = "CALI_GRAT_5_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
		],
	},
	cali_grat_6 = { #bad
		image = null, tags = ['dialogue_scene'], reqs = [], 
		text = [ {text = "CALI_GRAT_6", reqs = []} ],
		character = "cali",
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'unique_character_changes', value = 'cali', args = [{code = 'remove_character'}]}, {code = 'complete_quest', value = 'cali_heirloom_quest'}]
		} ],
	},
	cali_grat_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_GRAT_7", reqs = []} ], 
		options = [ {
			code = 'cali_grat_8', text = "CALI_GRAT_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
			{
			code = 'cali_grat_8', text = "CALI_GRAT_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			},
			{
			code = 'cali_grat_8', text = "CALI_GRAT_7_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue',
			} 
		],
	},
	cali_grat_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
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
	
	cali_sword_return_1 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_1", reqs = []} ], 
		options = [ {
			code = 'cali_sword_return_2', text = "CALI_SWORD_RETURN_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sword_return_2', text = "CALI_SWORD_RETURN_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_sword_return_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_2", reqs = []} ], 
		options = [ {
			code = 'cali_sword_return_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
		],
	},
	cali_sword_return_3 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_3", reqs = []} ], 
		options = [ {
			code = 'cali_sword_return_4', text = "CALI_SWORD_RETURN_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sword_return_4', text = "CALI_SWORD_RETURN_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_sword_return_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_4", reqs = []} ], 
		options = [ {
			code = 'cali_sword_return_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			},
		],
	},
	cali_sword_return_5 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_5", reqs = []} ], 
		options = [ {
			code = 'cali_sword_return_6', text = "CALI_SWORD_RETURN_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sword_return_6', text = "CALI_SWORD_RETURN_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_sword_return_6 = {
		image = null, tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_6", reqs = []} ], 
		options = [ {
			code = 'cali_sword_return_7', text = "CALI_SWORD_RETURN_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_sword_return_7', text = "CALI_SWORD_RETURN_6_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_sword_return_7 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_SWORD_RETURN_7", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'progress_quest', value = 'cali_heirloom_quest', stage = 'stage10'}, {code = 'make_quest_location', value = 'quest_cali_village'},] 
		} ],
	},
	
	cali_hector_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_1", reqs = []} ], 
		options = [ {
			code = 'cali_hector_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_2", reqs = []} ], 
		options = [ {
			code = 'cali_hector_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_3", reqs = []} ], 
		options = [ {
			code = 'cali_hector_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_4", reqs = []} ], 
		options = [ {
			code = 'cali_hector_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_5", reqs = []} ], 
		options = [ {
			code = 'cali_hector_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_6", reqs = []} ], 
		options = [ {
			code = 'cali_hector_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_7", reqs = []} ], 
		options = [ {
			code = 'cali_hector_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	cali_hector_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_HECTOR_8", reqs = []} ], 
		options = [ {
			code = 'quest_fight', args = 'hector',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			},
		],
	},
	
	cali_finale_1 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FINALE_1", reqs = []} ], 
		options = [ {
			code = 'cali_finale_2', text = "CALI_FINALE_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_finale_2', text = "CALI_FINALE_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		} ],
	},
	cali_finale_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_FINALE_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "CALI_FINALE_2_2", reqs = [], previous_dialogue_option = 2, bonus_effects = [{code = 'play_sound', value = 'slap'}]},
		],
		options = [ {
			code = 'cali_finale_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		 ],
	},
	cali_finale_3 = {
		image = 'cali_mother_dead',
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [ {text = "CALI_FINALE_3", reqs = [], previous_dialogue_option = 1},],
		options = [ {code = 'cali_finale_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		 ],
	},
	cali_finale_4 = {
		image = 'cali_mother_dead', 
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [],
		text = [ {text = "CALI_FINALE_4", reqs = [], previous_dialogue_option = 1},],
		options = [ {code = 'cali_finale_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',},
		 ],
	},
	cali_finale_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate', "blackscreen_transition_slow"], 
		reqs = [],
		character = "cali",
		text = [ {text = "CALI_FINALE_5", reqs = [], previous_dialogue_option = 1},],
		options = [ {
			code = 'cali_finale_6', text = "CALI_FINALE_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		},
		{
			code = 'cali_finale_6', text = "CALI_FINALE_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
		},
		{
			code = 'cali_finale_6', text = "CALI_FINALE_5_OPTION_3", reqs = [{type = "decision", value = "cali_sex", check = true}], dialogue_argument = 3, type = 'next_dialogue',
		},
		 ],
	},
	cali_finale_6 = {
		image = null, tags = ['dialogue_scene'], 
		reqs = [],
		character = "cali",
		text = [ 
			{text = "CALI_FINALE_6_1", reqs = [], previous_dialogue_option = [1, 2]},
			{text = "CALI_FINALE_6_3", reqs = [], previous_dialogue_option = 3},
		],
		common_effects = [{code = 'plan_mansion_event', value = 'ZCEvent_1'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
			bonus_effects = [{code = 'complete_quest', value = 'cali_heirloom_quest'}, {code = 'set_completed_active_location'}, {code = 'unique_character_changes',
					value = 'cali',
					args = [
						{code = 'create_and_equip', item = "cali_heirloom_active", parts = {}}
						],
			},]
		} ],
	},
	cali_grat_sex_1 = {
		image = null,
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
		image = null,
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
