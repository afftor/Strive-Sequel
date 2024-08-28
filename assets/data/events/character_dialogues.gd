#!!!needs complete rework of reqs
var data = {
	zephyra_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{
				text = "DIALOGUEZEPHINITIATEL", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					},
					], previous_dialogue_option = 0
			},
			{
				text = "DIALOGUEZEPHINITIATEH", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					},
					], previous_dialogue_option = 0
			},
			{
				text = "DIALOGUEZEPHINITIATEM", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'has_profession', profession = 'spouse', check = true},
						]
					},
					], previous_dialogue_option = 0
			},
			
			{text = "", reqs = [], previous_dialogue_option = 4},
			{text = "ZEPHYRA_EXTRA_REPLY3", reqs = [], previous_dialogue_option = 6},
			{text = "ZEPHYRA_EXTRA_REPLY1_2", reqs = [
				{type = 'active_character_checks', value = [{code = 'slave_type', operant = 'neq', value = 'slave'}]}], previous_dialogue_option = 1},
			{text = "ZEPHYRA_EXTRA_REPLY1_1", reqs = [
				{type = 'active_character_checks', value = [{code = 'slave_type', operant = 'eq', value = 'slave'}]}], previous_dialogue_option = 1}
		], 
		options = [ {
			code = 'zephyra_dialogue_start', text = "ZEPHYRA_EXTRA_OPTION1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2", reqs = [], dialogue_argument = 7
		}, {
			code = 'zephyra_dialogue_start', text = "ZEPHYRA_EXTRA_OPTION3", reqs = [], dialogue_argument = 6, remove_after_first_use = true
		}, 
#		{
#			code = 'zephyra_quest_1', text = "ZEPHYRA_QUEST_INIT_OPTION_1", reqs = [{type = 'decision', value = 'mayor_election_finished', check = true}, {type = 'dialogue_seen', check = false, value = 'ZEPHYRA_QUEST_2'}], dialogue_argument = 1, repeat_next_day = true
#		},
		 {
			code = 'zephyra_brush_8', text = "ZEPHYRA_BRUSH_8_OPTION_0", reqs = [{type = 'decision', value = 'GotZephyrasBrush', check = true}, {type = 'dialogue_seen', check = false, value = 'ZEPHYRA_BRUSH_8'}], dialogue_argument = 1, repeat_next_day = true
		}, {
			code = 'zephyra_brush_19', text = "ZEPHYRA_BRUSH_19_OPTION_0", reqs = [{type = 'dialogue_seen', check = false, value = 'ZEPHYRA_BRUSH_19'}, {type = 'dialogue_selected', check = true, value = 'ZEPHYRA_BRUSH_6_OPTION_1'}, {type = 'dialogue_selected', check = true, value = 'ZEPHYRA_BRUSH_8_OPTION_0'}], dialogue_argument = 1, repeat_next_day = true
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}],
	},
	
	zephyra_dialogue_2 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "", reqs = [], previous_dialogue_option = 7},
			{text = "ZEPHYRA_EXTRA_REPLY2_2", reqs = [], previous_dialogue_option = 2},
			{text = "ZEPHYRA_EXTRA_REPLY2_3", reqs = [], previous_dialogue_option = 3},
			
			{text = "ZEPHYRA_EXTRA_REPLY2_1_1", reqs = [], previous_dialogue_option = 4},
			{text = "ZEPHYRA_EXTRA_REPLY2_1_2", reqs = [], previous_dialogue_option = 5},
			{text = "ZEPHYRA_EXTRA_REPLY2_1_3", reqs = [], previous_dialogue_option = 6}
		], 
		options = [ {
			code = 'zephyra_dialogue_3', text = "ZEPHYRA_EXTRA_OPTION2_1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_3", reqs = [], dialogue_argument = 3, remove_after_first_use = true
		}, {
			code = 'zephyra_dialogue_start', text = "Back", reqs = [], dialogue_argument = 4
		} ],
	},
	
	zephyra_dialogue_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_REPLY2_1", reqs = [], previous_dialogue_option = 1},
		], 
		options = [ {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_1_1", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_1_2", reqs = [], dialogue_argument = 5, type = 'next_dialogue'
		}, {
			code = 'zephyra_dialogue_2', text = "ZEPHYRA_EXTRA_OPTION2_1_3", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		},],
	},
	
	zephyra_dialogue_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'zephyra',
		text = [
			{text = "ZEPHYRA_EXTRA_REPLY3", reqs = []},
		], 
		options = [ {
			code = 'zephyra_dialogue_start', text = "ZEPHYRA_EXTRA_OPTION2", reqs = [], dialogue_argument = 4
		}, ],
	},
	
	
	
	
	
	kurdan_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'kurdan',
		text = [
			{text = "KURDAN_EXTRA_GREET", reqs = [], previous_dialogue_option = 0},
			{text = "KURDAN_EXTRA_REPLY1", reqs = [], previous_dialogue_option = 1},
			{text = "KURDAN_EXTRA_REPLY2", reqs = [], previous_dialogue_option = 2},
			{text = "KURDAN_EXTRA_REPLY3", reqs = [], previous_dialogue_option = 3},
		], 
		options = [ {
			code = 'kurdan_dialogue_start', text = "KURDAN_EXTRA_OPTION1", reqs = [], dialogue_argument = 1, remove_after_first_use = true
		}, {
			code = 'kurdan_dialogue_start', text = "KURDAN_EXTRA_OPTION2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'kurdan_dialogue_start', text = "KURDAN_EXTRA_OPTION3", reqs = [], dialogue_argument = 3, remove_after_first_use = true
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4
		} ],
	},
	
	
	
	amelia_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [
			{text = "DIALOGUEAMELIAINITIATE", reqs = [], previous_dialogue_option = 0}
		], 
		options = [ {
			code = 'cali_servants_new_leader_6', text = "CALI_SERVANTS_AMELIA_OPTION_1", reqs = [{type = 'decision', value = 'CaliAmeliaBonus', check = true}, {type = 'dialogue_seen', check = false, value = 'CALI_SERVANTS_NEW_LEADER_6'}], dialogue_argument = 4, type = 'next_dialogue'
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4
		} ],
	},
	
	
	
	anastasia_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'anastasia',
		text = [
			{
				text = "DIALOGUEANAINITIATELP", 
				reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = false},
					{type = 'decision', value = 'anastasia_rape_scene', check = false},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUEANAINITIATEHP", 
				reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = false},
					{type = 'decision', value = 'anastasia_rape_scene', check = false},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUEANAINITIATELN", 
				reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = false},
					{type = 'decision', value = 'anastasia_rape_scene', check = true},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						]
					}],
			},
			{
				text = "DIALOGUEANAINITIATEHN", 
				reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = false},
					{type = 'decision', value = 'anastasia_rape_scene', check = true},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						]
					}],
			},
			{
				text = "DIALOGUEANAINITIATEM", 
				reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = false},
					{type = 'decision', value = 'anastasia_rape_scene', check = false},
					{type = 'active_character_checks', value = [
						{code = 'has_profession', profession = 'spouse', check = true},
						]
					}],
			},
			{
				text = "DIALOGUEANAINITIATEB", 
				reqs = [
					{type = 'decision', value = 'mindbreak_completed', check = true},
					]
			},
		],
		options = [
			{code = 'ana_gryphon_sex_start', text = 'GRYPHON_ANA_SEX_OPTION_INIT',reqs = [{type = 'decision', value = 'AnaAireThreesome', check = true}, {type = 'dialogue_seen', check = false, value = 'GRYPHON_ANA_SEX_10'}], dialogue_argument = 1},
			
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4}
		],
	},
	
	
	
	daisy_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], unique_character = 'daisy',
		text = [
			{
				text = "DIALOGUEDAISYINITIATEL", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUEDAISYINITIATEH", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUEDAISYINITIATEM", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'has_profession', profession = 'spouse', check = true},
						]
					}],
			},
			
		],
		options = [
#			{code = 'daisy_dialogue_1_1', text = 'DAISY_EXTRA_OPTION_1_1',reqs = [{type = 'decision', value = 'DaisyDressLewd', check = true},
#			{type = 'active_character_checks', value = [
#				{code = 'body_image', operant = 'eq', value = "daisy_maid_body"},
#				]}], dialogue_argument = 1},
#			{code = 'daisy_dialogue_1_2', text = "DAISY_EXTRA_OPTION_1_2", reqs = [{type = 'decision', value = 'DaisyDressLewd', check = true},
#			{type = 'active_character_checks', value = [
#				{code = 'body_image', operant = 'eq', value = "daisy_maid_nude_body"},
#				]}], dialogue_argument = 2},
			{ # Serve
			code = 'daisy_serve_start', text = "DAISY_SERVE_OPTION_START", reqs = [{type = "quest_completed", name = "daisy_training", check = true}], dialogue_argument = 3, repeat_next_day = true
		}, 
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 4},
		],
	},
	
	daisy_dialogue_1_1 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], unique_character = 'daisy',
		text = [
			{text = "DAISY_EXTRA_REPLY_1_1_NO", reqs = [{type = 'active_character_checks', value = [
				{code = 'stat', stat = 'consent', operant = 'lt', value = 3},
				{code = 'has_profession', profession = 'sextoy', check = false},
				]}]}, 
			{text = "DAISY_EXTRA_REPLY_1_1_YES", reqs = []},
		], 
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'body_image', operant = '=', value = "daisy_maid_nude_body"}]}],
		options = [
			{code = 'close', text = 'DIALOGUELEAVE',reqs = [], dialogue_argument = 1},
		],
	},
	
	daisy_dialogue_1_2 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], unique_character = 'daisy',
		text = [
			{text = "DAISY_EXTRA_REPLY_1_2_NO", reqs = [{type = 'active_character_checks', value = [
				{code = 'stat', stat = 'consent', operant = 'lt', value = 3},
				{code = 'has_profession', profession = 'sextoy', check = false},
				]}]}, 
			{text = "DAISY_EXTRA_REPLY_1_2_YES", reqs = []},
		], 
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'body_image', operant = '=', value = "daisy_maid_body"}]}],
		options = [
			{code = 'close', text = 'DIALOGUELEAVE',reqs = [], dialogue_argument = 1},
		],
	},
	
	daisy_serve_start = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], unique_character = 'daisy',
		text = [
			{text = "DAISY_SERVE_START_1", reqs = [{type = 'active_character_checks', value = [
				{code = 'has_profession', profession = 'sextoy', check = true},
				]}],
			},
			{text = "DAISY_SERVE_START_2", reqs = [{type = 'active_character_checks', value = [
				{code = 'has_profession', profession = 'sextoy', check = false},
				]}],
			},
		],
		options = [
			{
			code = 'daisy_serve_1_1', text = "DAISY_SERVE_OPTION_1_1", reqs = [
				{type = "quest_completed", name = "daisy_training", check = true}
				], 
			dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, 
			{
			code = 'daisy_serve_2_1', text = "DAISY_SERVE_OPTION_1_2", reqs = [
				{type = "quest_completed", name = "daisy_lost", check = true}], 
			dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
		}, 
			{
			code = 'daisy_dialogue_start', text = "DAISY_SERVE_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, 
		],
	},
	
	daisy_serve_1_1 = {
		image = null, tags = ['dialogue_scene','active_character_translate'], reqs = [],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_1", reqs = []},
		], 
		options = [ {
			code = 'daisy_serve_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	daisy_serve_1_2 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_2", reqs = []},
		], 
		options = [ {
			code = 'daisy_serve_1_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	daisy_serve_1_3 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_3", reqs = []},
		], 
		options = [ {
			code = 'daisy_serve_1_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	daisy_serve_1_4 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bj4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_4", reqs = []},
		], 
		options = [ {
			code = 'daisy_serve_1_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	
	daisy_serve_1_5 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bj6",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_DRESS_ACQUIRED_NORMAL_REPLY_1_2_5", reqs = []},
		], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	daisy_serve_2_1 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bent1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		common_effects = [{code = 'unique_character_changes', value = 'daisy', args = [
			{code = 'tag', operant = 'remove', value = 'no_sex'}]}],
		text = [
			{text = "DAISY_CONSENSUAL_3_SERVE", reqs = []},
		], 
		options = [ {
			code = 'daisy_serve_2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	daisy_serve_2_2 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bent2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_CONSENSUAL_4", reqs = []},
		], 
		options = [ {
			code = 'daisy_serve_2_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	daisy_serve_2_3 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "daisy_bent3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "DAISY_CONSENSUAL_5", reqs = []},
		], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	aire_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], character = 'aire',
		text = [
			{
				text = "DIALOGUEAIREINITIATELP", 
				reqs = [
					{type = 'has_multiple_decisions', decisions = ['anastasia_rape_scene','aire_raped','PrincessDead'], operant = 'eq', value = 0},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						]
					}],
			},
			{
				text = "DIALOGUEAIREINITIATEHP", 
				reqs = [
					{type = 'has_multiple_decisions', decisions = ['anastasia_rape_scene','aire_raped','PrincessDead'], operant = 'eq', value = 0},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						]
					}],
			},
			{
				text = "DIALOGUEAIREINITIATELN", 
				reqs = [
					{type = 'has_multiple_decisions', decisions = ['anastasia_rape_scene','aire_raped','PrincessDead'], operant = 'gte', value = 1},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						]
					}],
			},
			{
				text = "DIALOGUEAIREINITIATEHN", 
				reqs = [
					{type = 'has_multiple_decisions', decisions = ['anastasia_rape_scene','aire_raped','PrincessDead'], operant = 'gte', value = 1},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						]
					}],
			},
		],
		options = [
			{code = 'aire_gryphon_sex_start', text = 'GRYPHON_AIRE_SEX_START_OPTION_INIT',reqs = [{type = 'quest_completed', name = 'gryphon_quest', check = true}, {type = 'dialogue_seen', check = false, value = 'GRYPHON_AIRE_SEX_2'}], dialogue_argument = 1}, 
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3}
		],
	},
	cali_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], unique_character = 'cali',
		text = [
			{
				text = "DIALOGUECALIINITIATELP", 
				reqs = [
					{type = 'decision', value = 'cali_raped', check = false},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUECALIINITIATEHP", 
				reqs = [
					{type = 'decision', value = 'cali_raped', check = false},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUECALIINITIATELN", 
				reqs = [
					{type = 'decision', value = 'cali_raped', check = true},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						]
					}],
			},
			{
				text = "DIALOGUECALIINITIATEHN", 
				reqs = [
					{type = 'decision', value = 'cali_raped', check = true},
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						]
					}],
			},
			{
				text = "DIALOGUECALIINITIATEM", 
				reqs = [
					{type = 'decision', value = 'cali_raped', check = false},
					{type = 'active_character_checks', value = [
						{code = 'has_profession', profession = 'spouse', check = true},
						]
					}],
			},
		], 
		options = [
			{code = 'cali_sword_return_1', text = 'CALI_SWORD_RETURN_INIT',reqs = [{type = 'active_quest_stage', value = 'cali_heirloom_quest', stage = 'stage9'}], dialogue_argument = 1, type = 'next_dialogue', },
			{code = 'cali_act3_blow_1', text = 'CALI_ACT3_BLOW_OPTION_INIT',reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage10'}], dialogue_argument = 1, type = 'next_dialogue', },
			{code = 'cali_act5_pet_3', text = 'CALI_ACT3_BLOW_OPTION_INIT',reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage16'}], dialogue_argument = 1, type = 'next_dialogue', },
			{code = 'cali_serve_start', text = 'DAISY_SERVE_OPTION_START',reqs = [], dialogue_argument = 1}, 
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3}
		],
	},
	
	cali_serve_start = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], unique_character = 'cali',
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "cali_riding",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_SERVE_START_1", reqs = [{type = 'active_character_checks', value = [
				{code = 'has_profession', profession = 'sextoy', check = true},
				]}],
			},
			{text = "CALI_SERVE_START_2", reqs = [{type = 'active_character_checks', value = [
				{code = 'has_profession', profession = 'sextoy', check = false},
				]}],
			},
		],
		options = [
			{
			code = 'cali_serve_1_1', text = "CALI_SERVE_OPTION_1_1", reqs = [
				{type = "quest_completed", name = "cali_heirloom_quest", check = true}
				], 
			dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2
		}, 
			{
			code = 'cali_serve_2_1', text = "CALI_SERVE_OPTION_1_2", reqs = [
				{type = "quest_completed", name = "cali_heirloom_quest", check = true}], 
			dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 2
		}, 
			{
			code = 'cali_dialogue_start', text = "CALI_SERVE_OPTION_1_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue', 
		}, 
		],
	},
	
	
	
	cali_serve_1_1 = {
		image = null, tags = ['dialogue_scene','active_character_translate'], reqs = [],
		custom_background = "cali_bj_happy_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_SEX_8", reqs = []},
		], 
		options = [ {
			code = 'cali_serve_1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	cali_serve_1_2 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_bj_happy_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_SEX_9", reqs = []},
		], 
		options = [ {
			code = 'cali_serve_1_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	cali_serve_1_3 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_bj_happy_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_SEX_10", reqs = []},
		], 
		options = [ {
			code = 'cali_serve_1_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	cali_serve_1_4 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_bj_happy_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_SEX_11", reqs = []},
			{text = "CALI_SEX_12", reqs = []},
		], 
		options = [ {
			code = 'cali_serve_1_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}, ],
	},
	cali_serve_1_5 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_bj_happy_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_SEX_13", reqs = []},
		], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_serve_2_1 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_riding_1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_GRAT_SEX_1", reqs = []},
		], 
		options = [ {
			code = 'cali_serve_2_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_serve_2_2 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_riding_2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_GRAT_SEX_2", reqs = []},
		], 
		options = [ {
			code = 'cali_serve_2_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	cali_serve_2_3 = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [],
		custom_background = "cali_riding_3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		text = [
			{text = "CALI_GRAT_SEX_3", reqs = []},
		], 
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue',
		}, ],
	},
	
	
	
	lilia_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], character = 'lilia',
		text = [
			{
				text = "DIALOGUELILIAINITIATEL", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUELILIAINITIATEH", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = true},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},
			{
				text = "DIALOGUELILIAINITIATEM", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'has_profession', profession = 'spouse', check = true},
						]
					}],
			},
		], 
		options = [
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3}
		],
	},
	
	lilith_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'active_character_translate'], reqs = [], character = 'lilith',
		text = [
			{
				text = "DIALOGUELILITHINIT", 
				reqs = [],
			},
		], 
		options = [
			{code = 'lilith_patron_meeting', text = "LILITH_PATRON_MEETING_OPTION", reqs = [{type = 'active_quest_stage', value = 'lilith_patron_quest', stage = 'stage14'}], dialogue_argument = 1, },
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 3},
		],
	},
	
	jean_dialogue_start = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'jean',
		text = [
			{
				text = "DIALOGUEJEANINITIATEM", 
				reqs = [
					{type = 'active_character_checks', value = [
						{code = 'trait', trait = 'loyalty_adv_servitude', check = false},
						{code = 'has_profession', profession = 'spouse', check = false},
						]
					}],
			},	
		], 
		options = [
			{code = 'cali_act3_jean_1', text = "CALI_ACT3_JEAN_START_OPTION", reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage6'}, {type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage8', orflag = true}], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'cali_act3_jean_4', text = "CALI_ACT3_JEAN_3_OPTION_1", reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage7'}], dialogue_argument = 1, type = 'next_dialogue',},
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1}
		],
	},
}
	
