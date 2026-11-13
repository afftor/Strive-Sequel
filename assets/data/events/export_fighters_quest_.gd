extends Reference
# Quest Data
var data = {
	lich_aire_talk1 = {
		image = null,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK1", reqs = [{type = 'decision', value = 'deal_with_lich', check = false}]},
		{text = "LICHAIRETALK1_DEAL_WITH_LICH", reqs = [{type = 'decision', value = 'deal_with_lich', check = true}]},
		],
		options = [
		{code = 'lich_aire_talk2', text = "LICHAIRETALK1REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK1REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_aire_talk3', text = "LICHAIRETALK1REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		{code = 'lich_aire_talk6_1', text = "LICHAIRETALK1REPLY4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'},
		],
	},

	lich_aire_talk3 = {
		image = null,
		unlocked_gallery_seq = "lich_aire_talkk",
		save_scene_to_gallery = true,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK3", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk4', text = "LICHAIRETALK3REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK3REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
	},

	lich_aire_talk4 = {
		variations = [
		{reqs = [
		{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 4}]},
		],
#		dialogue_type = 2,
#		custom_background = "lich_aire_talk4",
#		scene_type = "ero_scene",
#		save_scene_to_gallery = true,
		image = null,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK4", reqs = []},
		],
		options = [
#		{code = 'leave', reqs = [], change_dialogue_type = 1, text = tr("DIALOGUELEAVE"), dialogue_argument = 1, bonus_effects = [{code = 'decision', value = 'aire_had_sex'},
#			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
#			{code = 'remove_quest_location', value = 'quest_fighters_lich'}]
#		},
		{code = 'lich_aire_talk4_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'}
		],
		},
		{reqs = [],
		image = null,
		character = '$aire',
		tags  = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK4_BAD", reqs = []},
		],
		options = [
		{code = 'lich_aire_leave', text = "LICHAIRETALK4_BADREPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_talk6_1', text = "LICHAIRETALK4_BADREPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		],
		},
		],
	},

	lich_aire_talk4_1 = {
		image = null,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK4_1", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk4_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},

	lich_aire_talk4_2 = {
		image = null,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK4_2", reqs = []},
		],
		options = [
#		{code = 'lich_aire_talk4_3', text = tr("DIALOGUECONTINUE") + tr("DIALOGUESKIPSEXSCENE"), reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2},
		{code = 'lich_aire_talk4_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2},
		],
	},

	lich_aire_talk4_3 = {
		custom_background = "lich_aire_talk4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK4_3", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk4_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},

	lich_aire_talk4_4 = {
		custom_background = "lich_aire_talk4",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null,
		tags = [],
		text = [
		{text = "LICHAIRETALK4_4", reqs = []},
		],
		options = [
			{code = 'leave', reqs = [], text = tr("DIALOGUELEAVE"), dialogue_argument = 1, bonus_effects = [{code = 'decision', value = 'aire_had_sex'},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'set_completed_active_location'}]
		},
		],
	},

	lich_aire_talk5 = {
		image = null,
		unlocked_gallery_seq = "lich_aire_talk",
		save_scene_to_gallery = true,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK5", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk3', text = "LICHAIRETALK5REPLY1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		{code = 'lich_aire_leave', text = "LICHAIRETALK5REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		{code = 'lich_aire_talk6_1', text = "LICHAIRETALK5REPLY3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'},
		],
	},

	lich_aire_talk6_1 = {
		image = null,
		character = '$aire',
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6_1", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk6_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 2}
		],
	},
	
	lich_aire_talk6_2 = {
		image = null,
		custom_background = "lich_aire_talk7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6_2", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk6_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	
	lich_aire_talk6_3 = {
		image = null,
		custom_background = "lich_aire_talk7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6_3", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk6_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	
	lich_aire_talk6_4 = {
		image = null,
		custom_background = "lich_aire_talk7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6_4", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk6_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	
	lich_aire_talk6_5 = {
		image = null,
		custom_background = "lich_aire_talk7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6_5", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk6_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	
	lich_aire_talk6_6 = {
		image = null,
		custom_background = "lich_aire_talk7",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		text = [
		{text = "LICHAIRETALK6_6", reqs = []},
		],
		options = [
		{code = 'lich_aire_talk7', text = "LICHAIRETALK6REPLY1", reqs = [],
		bonus_effects = [{code = 'decision', value = 'aire_is_dead'}], dialogue_argument = 1, type = 'next_dialogue', change_dialogue_type = 1},
		{code = 'lich_aire_leave', text = "LICHAIRETALK6REPLY2", reqs = [], dialogue_argument = 2, type = 'next_dialogue', change_dialogue_type = 1, bonus_effects = [{code = 'decision', value = 'aire_raped'}]},
		],
	},
	

	lich_aire_talk7 = {
		image = null,
		tags = [],
		text = [
		{text = "LICHAIRETALK7", reqs = []},
		],
		options = [
		{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = [], bonus_effects = [{code = 'decision', value = 'aire_is_dead'},
			{code = 'progress_quest', value = 'fighters_election_quest', stage = 'stage2'},
			{code = 'set_completed_active_location'}]},
		],
	},
}
