extends Reference
var data = {
	marriage_church_1 = {
		variations = [
			{
				reqs = [{type = "decision", value = "mayor_election_finished", check = true}], #main 
				image = null, 
				tags = ['dialogue_scene'],
				custom_background = "church_event", character = "ginny",
				text = [{text = "MARRIAGE_CHURCH_TEXT_1", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'marriage_quest_main', stage = 'stage1'}],}],
				options = [ 
						{code = 'marriage_church_2', text = "SELECT", select_person = true, reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
						{code = 'close', text = "CANCEL", reqs = []}
					],
			},
			{ 
				reqs = [], #default
				image = null, 
				tags = [],
				custom_background = "church_event", character = "ginny",
				text = [{text = "MARRIAGE_CHURCH_DEFAULT", reqs = [], bonus_effects = [],}],
				options = [ 
						{code = 'close', text = "DIALOGUECLOSE", reqs = []}
					],
			}
		]
	},
	marriage_church_2 = {
		image = null,
		tags = ['dialogue_scene'],
		custom_background = "church_event", character = "ginny",
		text = [{text = "MARRIAGE_CHURCH_TEXT_2", reqs = []}],
		options = [ 
				{code = 'marriage_church_3', text = "PAY", reqs = [{type = 'has_money', value = 500}], bonus_effects = [{code = 'set_spouse'}], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'close', text = "CANCEL", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'marriage_quest_main', stage = 'stage1'}]}
			],
	},
	marriage_church_3 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'], 
		custom_background = "church_event", character = "ginny",
		text = [{text = "MARRIAGE_CHURCH_TEXT_3", reqs = []}],
		options = [ {
			code = 'marriage_church_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_church_4 = {
		image = null,
		tags = ['dialogue_scene'],
		custom_background = "church_event", character = "ginny",
		text = [{text = "MARRIAGE_CHURCH_TEXT_4", reqs = []}],
		options = [ 
				{code = 'close', text = "MARRIAGE_CHURCH_CLOSE_OPTION", reqs = [], type = 'next_dialogue', bonus_effects = [{code = 'money_change', operant = '-', value = 500},{code = 'progress_quest', value = 'marriage_quest_main', stage = 'stage2'}],}
			],
	},
	
	marriage_servants_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		character = "amelia",
		text = [
			{text = "MARRIAGE_SERVANTS_1_1", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'eq', value = 'anastasia'}}]},
			{text = "MARRIAGE_SERVANTS_1_2", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'neq', value = 'anastasia'}}]},
			{text = "MARRIAGE_SERVANTS_1_3", reqs = []},
		],
		options = [ {
			code = 'marriage_servants_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_servants_2 = {
		image = null,
		tags = ['dialogue_scene'],
		character = "amelia",
		text = [{text = "MARRIAGE_SERVANTS_2", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'marriage_quest_servants', stage = 'stage1'}]}],
		options = [ 
				{code = 'marriage_servants_completed_1', text = "MARRIAGE_SERVANTS_COMPLETE_OPTION", reqs = [
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
	marriage_servants_completed_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		character = "amelia",
		text = [{text = "MARRIAGE_SERVANTS_COMPLETE_1", reqs = [], bonus_effects = [
			{code = 'money_change', operant = '-', value = 3000},
			{code = 'material_change', operant = '-', material = 'fish', value = 200},
			{code = 'material_change', operant = '-', material = 'meat', value = 200},
			{code = 'material_change', operant = '-', material = 'vegetables', value = 200},
			{code = 'material_change', operant = '-', material = 'grain', value = 200},
			{code = 'remove_item', name = 'beer', number = 25},
			{code = 'remove_item', name = 'alcohol', number = 10},
		]}],
		options = [ {
			code = 'marriage_servants_completed_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_servants_completed_2 = {
		image = null,
		tags = ['dialogue_scene'], 
		character = "amelia",
		text = [{text = "MARRIAGE_SERVANTS_COMPLETE_2", reqs = []}],
		options = [ {code = 'marriage_servants_completed_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'}],
	},
	marriage_servants_completed_3 = {
		image = null,
		tags = ['dialogue_scene'], 
		character = "amelia",
		text = [{text = "MARRIAGE_SERVANTS_COMPLETE_3", reqs = []}],
		options = [ 
			{code = 'marriage_servants_completed_4', text = "MARRIAGE_SERVANTS_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'decision', value = 'marry_invitations_made'}]},
			{code = 'marriage_servants_completed_4', text = "MARRIAGE_SERVANTS_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			],
	},
	marriage_servants_completed_4 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		character = "amelia",
		text = [{text = "MARRIAGE_SERVANTS_COMPLETE_4", reqs = []}],
		options = [ 
				{code = 'close', text = "CLOSE", reqs = [], bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_servants'}], type = 'next_dialogue'}
			],
	},
	
	marriage_workers_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		character = "sigmund",
		text = [{text = "MARRIAGE_WORKERS_1", reqs = []}],
		options = [ {
			code = 'marriage_workers_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_workers_2 = {
		image = null,
		tags = ['dialogue_scene'],
		character = "sigmund",
		text = [{text = "MARRIAGE_WORKERS_2", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'marriage_quest_workers', stage = 'stage1'}]}],
		options = [ 
				{code = 'marriage_workers_completed_1', text = "MARRIAGE_WORKERS_COMPLETE_OPTION", reqs = [
					{type = 'has_money', value = 1000},
					{type = 'has_material', operant = 'gte', value = 150, material = 'clothsilk'},
					{type = 'has_material', operant = 'gte', value = 50, material = 'clothmagic'},
					], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'close', text = "RETURN", reqs = []}
			],
	},
	marriage_workers_completed_1 = {
		image = null,
		tags = ['dialogue_scene'], 
		character = "sigmund",
		text = [{text = "MARRIAGE_WORKERS_COMPLETE_1", reqs = [], bonus_effects = [
			{code = 'money_change', operant = '-', value = 1000},
			{code = 'material_change', operant = '-', material = 'clothsilk', value = 150},
			{code = 'material_change', operant = '-', material = 'clothmagic', value = 50},
		]}],
		options = [
			{code = 'close', text = "CLOSE", reqs = [], type = 'next_dialogue', bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_workers'}],}
			],
	},
	
	marriage_final_init = {
		image = null,
		tags = ['dialogue_scene'], 
#		custom_background = "church_event",
		character = "ginny",
		text = [{text = "MARRIAGE_FINAL_INIT", reqs = []}],
		options = [ {
			code = 'marriage_final_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_final_1 = {
		image = null,
		tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		text = [{text = "MARRIAGE_FINAL_1", reqs = []}],
		options = [ 
			{code = 'marriage_final_anastasia_1', text = "DIALOGUECONTINUE", reqs = [
				{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'eq', value = 'anastasia'}},
				{type = 'has_hero', name = 'aire', check = true}
				], dialogue_argument = 1, type = 'next_dialogue'}, #anastasia spouse, have aire
			{code = 'marriage_final_2', text = "DIALOGUECONTINUE", reqs = [
				{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'eq', value = 'anastasia'}},
				{type = 'has_hero', name = 'aire', check = false}
				], dialogue_argument = 1, type = 'next_dialogue'}, #anastasia spouse, no aire
			{code = 'marriage_final_2', text = "DIALOGUECONTINUE", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'unique', operant = 'neq', value = 'anastasia'}}], dialogue_argument = 1, type = 'next_dialogue'}, #default
		],
	},
	marriage_final_anastasia_1 = {
		image = null,
		tags = ['dialogue_scene', 'blackscreen_transition_common'],
		character = 'aire', character2 = 'anastasia', 
		text = [{text = "MARRIAGE_ANASTASIA_1", reqs = []}],
		options = [ {
			code = 'marriage_final_anastasia_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_final_anastasia_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		character = 'aire', character2 = 'anastasia', 
		text = [{text = "MARRIAGE_ANASTASIA_2", reqs = []}],
		options = [ {
			code = 'marriage_final_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_final_2 = {
#		custom_background = "church_event",
		image = 'wedding',
		character = 'ginny',
		tags = ['dialogue_scene', 'blackscreen_transition_common'], 
		text = [{text = "MARRIAGE_FINAL_2", reqs = []}],
		options = [ {
			code = 'marriage_final_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_final_3 = {
#		custom_background = "church_event",
		image = 'wedding',
		character = 'ginny',
		character2 = 'spouse',
		tags = ['dialogue_scene', 'master_translate'], 
		text = [{text = "MARRIAGE_FINAL_3", reqs = []}],
		options = [ {
			code = 'marriage_final_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_final_4 = {
#		custom_background = "church_event",
		image = 'wedding',
#		character = 'ginny',
#		character2 = 'spouse',
		tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'], 
		text = [{text = "MARRIAGE_FINAL_4", reqs = []}],
		options = [ {code = 'marriage_final_5', text = "MARRIAGE_FINAL_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'marriage_final_5', text = "MARRIAGE_FINAL_4_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'marriage_final_5', text = "MARRIAGE_FINAL_4_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	marriage_final_5 = {
#		custom_background = "church_event",
		image = 'wedding',
#		character = 'ginny',
#		character2 = 'spouse',
		tags = ['dialogue_scene', 'master_translate'], 
		text = [{text = "MARRIAGE_FINAL_5", reqs = []}],
		options = [ {
			code = 'marriage_final_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}],
	},
	marriage_final_6 = {
		variations = [ { # Unique after wedding scene
			# we check if our spouse has unique event from wedding_events
			reqs = [{type = 'spouse_has_event'}],
			image = null,
			tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
			text = [{text = "MARRIAGE_FINAL_6", reqs = []}],
			options = [ 
				{code = 'marriage_final_7', text = "DIALOGUECONTINUE", reqs = [{type = 'decision', value = 'marry_invitations_made', check = true}], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'close', text = "DIALOGUECONTINUE", reqs = [{type = 'decision', value = 'marry_invitations_made', check = false}], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'after_wedding_event'}]}
				],
		}, { # default
			reqs = [], image = null,
			tags = ['dialogue_scene', 'master_translate', 'blackscreen_transition_common'],
			text = [{text = "MARRIAGE_FINAL_6", reqs = []}],
			options = [ 
				{code = 'marriage_final_7', text = "DIALOGUECONTINUE", reqs = [{type = 'decision', value = 'marry_invitations_made', check = true}], dialogue_argument = 1, type = 'next_dialogue'},
				{code = 'marriage_night_1', text = "DIALOGUECONTINUE", reqs = [{type = 'decision', value = 'marry_invitations_made', check = false}], dialogue_argument = 1, type = 'next_dialogue'},
				],
		}
		]
	},
	marriage_final_7 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "MARRIAGE_FINAL_7", reqs = []}],
		options = [ 
			{code = 'marriage_final_8', text = "MARRIAGE_FINAL_7_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'marriage_final_8', text = "MARRIAGE_FINAL_7_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			{code = 'marriage_night_group_1', text = "MARRIAGE_FINAL_7_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			],
	},
	marriage_final_8 = {
		variations = [ { # Unique after wedding scene
			# we check if our spouse has unique event from wedding_events
			reqs = [{type = 'spouse_has_event'}],
			image = null,
			tags = ['dialogue_scene', 'master_translate'],
			text = [{text = "MARRIAGE_FINAL_8_1", reqs = [], previous_dialogue_option = 1},
				{text = "MARRIAGE_FINAL_8_2", reqs = [], previous_dialogue_option = 2},],
			options = [ 
				{code = 'close', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = [{code = 'after_wedding_event'}]}
				],
		}, { # default
			reqs = [], image = null,
			tags = ['dialogue_scene', 'master_translate'],
			text = [
				{text = "MARRIAGE_FINAL_8_1", reqs = [], previous_dialogue_option = 1},
				{text = "MARRIAGE_FINAL_8_2", reqs = [], previous_dialogue_option = 2},
			],
			options = [ 
				{code = 'marriage_night_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
				],
		} ]
	},
	marriage_night_group_1 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "MARRIAGE_NIGHT_GROUP_1_1", reqs = []},
			{text = "MARRIAGE_NIGHT_GROUP_1_2", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'consent', operant = 'gte', value = 5}}, {type = 'spouse_check', value = {code = 'trait', trait = 'group', check = true}}]},
			{text = "MARRIAGE_NIGHT_GROUP_1_3", reqs = [{type = 'spouse_check', value = {code = 'stat', stat = 'consent', operant = 'lt', value = 5}}, {type = 'spouse_check', value = {code = 'trait', trait = 'group', check = true}}]},
			{text = "MARRIAGE_NIGHT_GROUP_1_3", reqs = [{type = 'spouse_check', value = {code = 'trait', trait = 'group', check = false}}]},
			{text = "MARRIAGE_NIGHT_GROUP_1_4", reqs = []},
			],
		options = [ 
			{code = 'marriage_night_group_2', text = "MARRIAGE_NIGHT_GROUP_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'marriage_night_group_2', text = "MARRIAGE_NIGHT_GROUP_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			],
	},
	marriage_night_group_2 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "MARRIAGE_NIGHT_GROUP_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "MARRIAGE_NIGHT_GROUP_2_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [ 
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'money_change', operant = '+', value = 5000},{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]}
			],
	},
	marriage_night_1 = {
		reqs = [], image = null,
		character = "spouse",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "MARRIAGE_NIGHT_1", reqs = []},
			],
		options = [ 
			{code = 'marriage_night_2', text = "MARRIAGE_NIGHT_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'marriage_night_2', text = "MARRIAGE_NIGHT_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
			],
	},
	marriage_night_2 = {
		image = null,
		character = "spouse",
		tags = ['dialogue_scene', 'master_translate'],
		text = [
			{text = "MARRIAGE_NIGHT_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "MARRIAGE_NIGHT_2_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [ 
			{code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'complete_quest', value = 'marriage_quest_main'}, {code = 'complete_wedding'} ]}
			],
	},
}
