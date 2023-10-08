var data = {
	amelia_intro = {
		image = 'letter',
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		text = [{text = "AMELIA_INTRO", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage0'},
#				{code = "update_city"}
				]
		} ],
	},
	
	amelia_main_guild_1 = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [{text = "AMELIA_MAIN_GUILD_1", reqs = [], }],
		options = [ 
			{
			code = 'amelia_main_guild_2', text = "AMELIA_MAIN_GUILD_1_OPTION_1", reqs = [], dialogue_argument = 1
			},
			{
			code = 'amelia_main_guild_2', text = "AMELIA_MAIN_GUILD_1_OPTION_2", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_main_guild_2', text = "AMELIA_MAIN_GUILD_1_OPTION_3", reqs = [], dialogue_argument = 3
			},
		],
	},
	amelia_main_guild_2 = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_MAIN_GUILD_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_MAIN_GUILD_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_MAIN_GUILD_2_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_MAIN_GUILD_2", reqs = [], },
			],
		options = [ 
			{
			code = 'amelia_main_guild_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1
			},
		],
	},
	amelia_main_guild_3 = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_MAIN_GUILD_3_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_MAIN_GUILD_3_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_MAIN_GUILD_3_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_main_guild_3', text = "AMELIA_MAIN_GUILD_3_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_main_guild_3', text = "AMELIA_MAIN_GUILD_3_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_main_guild_4', previous_dialogue_option = [2,3], text = "AMELIA_MAIN_GUILD_3_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_main_guild_4 = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_MAIN_GUILD_4_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_MAIN_GUILD_4_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_MAIN_GUILD_4_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_main_guild_4', text = "AMELIA_MAIN_GUILD_4_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_main_guild_4', text = "AMELIA_MAIN_GUILD_4_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_main_guild_5', text = "AMELIA_MAIN_GUILD_4_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_main_guild_5 = {
		image = 'amelia_norlan', 
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		text = [{text = "AMELIA_MAIN_GUILD_5", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage1'},
				{code = "add_special_task_for_location", location = 'aliron', amount = 5, descript = "AMELIATASKDESCRIPT", name = "AMELIATASKNAME", max_workers = 4, icon = 'res://assets/Textures_v2/MANSION/quest_task.png', 
				args = [{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage2'}]},
				{code = "update_guild"}
			]
		} ],
	},
	
	
	amelia_main_interlude = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_MAIN_INTERLUDE_1", reqs = [{type = 'decision', value = 'amelia_slave_found', check = false}], previous_dialogue_option = 1 },
			{text = "AMELIA_MAIN_INTERLUDE_2", reqs = [{type = 'decision', value = 'amelia_slave_found', check = true}], previous_dialogue_option = 1 },
			{text = "AMELIA_MAIN_GUILD_4_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_MAIN_GUILD_4_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_main_interlude', text = "AMELIA_MAIN_GUILD_4_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_main_interlude', text = "AMELIA_MAIN_GUILD_4_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'close', text = "AMELIA_MAIN_INTERLUDE_OPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	
	
	amelia_slave1_1 = {
		image = 'amelia_box', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_SLAVE1_1", reqs = []}],
		options = [ {
			code = 'amelia_slave1_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	
	amelia_slave1_1_1 = {
		image = 'amelia_box', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_SLAVE1_1_1", reqs = []}],
		options = [ {
			code = 'amelia_slave1_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_slave1_2 = {
		image = 'amelia_box', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE1_2_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_SLAVE1_2_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_SLAVE1_2_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_slave1_2', text = "AMELIA_SLAVE1_2_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_slave1_2', text = "AMELIA_SLAVE1_2_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_slave1_3', previous_dialogue_option = [2,3], text = "AMELIA_SLAVE1_2_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave1_3 = {
		image = 'amelia_box', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE1_3_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_SLAVE1_3_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_SLAVE1_3_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_slave1_3', text = "AMELIA_SLAVE1_3_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave1_3', text = "AMELIA_SLAVE1_3_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave1_4', previous_dialogue_option = [2,3], text = "AMELIA_SLAVE1_3_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave1_4 = {
		image = 'amelia_box', 
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		text = [{text = "AMELIA_SLAVE1_4", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'decision', value = 'amelia_slave_found'},
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage3'},
				{code = "add_special_task_for_location", location = 'aliron', amount = 5, descript = "AMELIATASKDESCRIPT", name = "AMELIATASKNAME", max_workers = 4, icon = 'res://assets/Textures_v2/MANSION/quest_task.png', 
				args = [{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage4'}]},
				{code = 'update_city'}
			]
		} ],
	},
	amelia_slave2_1 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_1", reqs = [] },
			],
		options = [ {
			code = 'amelia_slave2_1_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	
	amelia_slave2_1_1 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_1_1", reqs = [] },
			],
		options = [ 
			{
			code = 'amelia_slave2_2', text = "AMELIA_SLAVE2_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave2_6', text = "AMELIA_SLAVE2_1_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_1_OPTION_3", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_2 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_2", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_2_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave2_4', text = "AMELIA_SLAVE2_2_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_3 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_3_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_SLAVE2_3_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_SLAVE2_3_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_SLAVE2_3_4", reqs = [], previous_dialogue_option = 4},
			],
		options = [ 
			{
			code = 'amelia_slave2_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_4 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_4", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave2_5', text = "AMELIA_SLAVE2_4_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_5 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_5", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_5_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_5_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_6 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_6", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_6_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave2_3', text = "AMELIA_SLAVE2_6_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_7 = {
		image = "amelia_guards", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE2_7_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_SLAVE2_7_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_SLAVE2_7_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_slave2_7', text = "AMELIA_SLAVE2_7_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_slave2_7', text = "AMELIA_SLAVE2_7_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_slave2_8', text = "AMELIA_SLAVE2_7_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave2_8 = {
		image = "amelia_guards", 
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		text = [{text = "AMELIA_SLAVE2_8", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'decision', value = 'amelia_slave_found'},
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage5'},
				{code = "add_special_task_for_location", location = 'aliron', amount = 5, descript = "AMELIATASKDESCRIPT", name = "AMELIATASKNAME", max_workers = 4, icon = 'res://assets/Textures_v2/MANSION/quest_task.png', 
				args = [{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage6'}]},
				{code = 'update_city'}
			]
		} ],
	},
	
	amelia_slave3_1 = {
		image = "amelia_slave", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE3_1_1", reqs = [], previous_dialogue_option = 0 },
			{text = "AMELIA_SLAVE3_1_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_SLAVE3_1_3", reqs = [], previous_dialogue_option = 3 }
			],
		options = [ 
			{
			code = 'amelia_slave3_1', text = "AMELIA_SLAVE3_1_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_slave3_1', text = "AMELIA_SLAVE3_1_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_slave3_2', previous_dialogue_option = [2,3], text = "AMELIA_SLAVE3_1_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave3_2 = {
		image = "amelia_slave", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE3_2_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_SLAVE3_2_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_SLAVE3_2_3", reqs = [], previous_dialogue_option = 3 },
			{text = "AMELIA_SLAVE3_2_4", reqs = [], previous_dialogue_option = 4 }
			],
		options = [ 
			{
			code = 'amelia_slave3_2', text = "AMELIA_SLAVE3_2_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_slave3_2', text = "AMELIA_SLAVE3_2_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_slave3_2', text = "AMELIA_SLAVE3_2_OPTION_3", reqs = [], dialogue_argument = 4
			},
			{
			code = 'amelia_slave3_3', text = "AMELIA_SLAVE3_2_OPTION_4", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_slave3_3 = {
		image = "amelia_slave", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE3_3", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_slave3_4', text = "AMELIA_SLAVE3_3_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
			{
			code = 'amelia_slave3_4', text = "AMELIA_SLAVE3_3_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
		],
	},
	amelia_slave3_4 = {
		image = "amelia_slave", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_SLAVE3_4_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_SLAVE3_4_2", reqs = [], previous_dialogue_option = 2 },
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'decision', value = 'amelia_slave_found'},
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage7'},
				{code = 'make_quest_location', value = 'quest_amelia_bandits_location'},
				{code = 'update_city'}
			]
		}
		],
	},
	
	amelia_prison_1 = {
		image = "amelia_dungeon", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_PRISON_1", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_prison_2', text = "AMELIA_PRISON_1_OPTION_1", reqs = [], dialogue_argument = 1
			},
			{
			code = 'amelia_prison_2', text = "AMELIA_PRISON_1_OPTION_2", reqs = [], dialogue_argument = 2
			},
		],
	},
	amelia_prison_2 = {
		image = "amelia_dungeon", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_PRISON_2_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_PRISON_2_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_PRISON_2_3", reqs = [], previous_dialogue_option = 3 },
			{text = "AMELIA_PRISON_2_4", reqs = [], previous_dialogue_option = 4 },
			],
		options = [ 
			{
			code = 'amelia_prison_2', text = "AMELIA_PRISON_2_OPTION_1", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_prison_2', text = "AMELIA_PRISON_2_OPTION_2", reqs = [], dialogue_argument = 4
			},
			{
			code = 'amelia_prison_3', text = "AMELIA_PRISON_2_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_prison_3 = {
		image = "amelia_dungeon", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_PRISON_3_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_PRISON_3_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_PRISON_3_3", reqs = [], previous_dialogue_option = 3 },
			{text = "AMELIA_PRISON_3_4", reqs = [], previous_dialogue_option = 4 },
			],
		options = [ 
			{
			code = 'amelia_prison_3', text = "AMELIA_PRISON_3_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_prison_3', text = "AMELIA_PRISON_3_OPTION_2", reqs = [], dialogue_argument = 3
			},
			{
			code = 'amelia_prison_3', text = "AMELIA_PRISON_3_OPTION_3", reqs = [], dialogue_argument = 4
			},
			{
			code = 'amelia_prison_4', previous_dialogue_option = [3, 4], text = "AMELIA_PRISON_3_OPTION_4", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_prison_4 = {
		image = "amelia_dungeon", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_PRISON_4_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_PRISON_4_2", reqs = [], previous_dialogue_option = 2 },
			],
		options = [ 
			{
			code = 'amelia_prison_4', text = "AMELIA_PRISON_4_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_prison_5', text = "AMELIA_PRISON_4_OPTION_2", reqs = [], dialogue_argument = 1
			},
			{
			code = 'amelia_prison_6', text = "AMELIA_PRISON_4_OPTION_3", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_prison_5 = {
		image = "amelia_dungeon", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_PRISON_5", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_prison_6', text = "AMELIA_PRISON_5_OPTION_1", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			},
			{
			code = 'amelia_prison_6', text = "AMELIA_PRISON_5_OPTION_2", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
			{
			code = 'amelia_prison_6', text = "AMELIA_PRISON_5_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			},
		],
	},
	amelia_prison_6 = {
		image = "amelia_dungeon", tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_PRISON_6_1", reqs = [], previous_dialogue_option = 1 },
			{text = "AMELIA_PRISON_6_2", reqs = [], previous_dialogue_option = 2 },
			{text = "AMELIA_PRISON_6_3", reqs = [], previous_dialogue_option = 3 },
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'remove_active_location'},
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage8'},
#				{code = "update_city"}
			]
		}
		],
	},
	
	amelia_interlude2_1 = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_INTERLUDE2_1_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_INTERLUDE2_1_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [ 
			{
			code = 'amelia_interlude2_1', text = "AMELIA_INTERLUDE2_1_OPTION_1", reqs = [], dialogue_argument = 2
			},
			{
			code = 'amelia_interlude2_2', text = "AMELIA_INTERLUDE2_1_OPTION_2", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
			},
		],
	},
	amelia_interlude2_2 = {
		image = 'amelia_norlan', tags = ['dialogue_scene', 'master_translate'], reqs = [],
		text = [
			{text = "AMELIA_INTERLUDE2_2", reqs = [] },
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage9'},
				{code = 'add_timed_event', value = "amelia_trial_1", args = [{type = 'add_to_date', date = [2,2], hour = 2}]},
				{code = "update_guild"}
			]
		}
		],
	},
	
	amelia_trial_1 = {
		image = 'letter', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_1", reqs = []}],
		options = [ {
			code = 'amelia_trial_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_2 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'blackscreen_transition_common', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_2", reqs = []}],
		options = [ {
			code = 'amelia_trial_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_3 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_3", reqs = []}],
		options = [ {
			code = 'amelia_trial_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_4 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_4", reqs = []}],
		options = [ {
			code = 'amelia_trial_4_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_4_ = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_4_", reqs = []}],
		options = [ {
			code = 'amelia_trial_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_5 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_5", reqs = []}],
		options = [ {
			code = 'amelia_trial_5_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_5_ = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_5_", reqs = []}],
		options = [ {
			code = 'amelia_trial_6', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_6 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_6", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_7', text = "AMELIA_TRIAL_6_OPTION_1", reqs = [], dialogue_argument = 1, 
			},
			{
			code = 'amelia_trial_8', text = "AMELIA_TRIAL_6_OPTION_2", reqs = [], dialogue_argument = 1, 
			},
		],
	},
	amelia_trial_7 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_7", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_8', text = "AMELIA_TRIAL_7_OPTION_1", reqs = [], dialogue_argument = 2, 
			},
			{
			code = 'amelia_trial_8', text = "AMELIA_TRIAL_7_OPTION_2", reqs = [], dialogue_argument = 3, 
			},
		],
	},
	amelia_trial_8 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_8_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_8_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_TRIAL_8_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_TRIAL_8", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_trial_9', text = "AMELIA_TRIAL_8_OPTION_1", reqs = [], dialogue_argument = 1, 
			},
			{
			code = 'amelia_trial_9', text = "AMELIA_TRIAL_8_OPTION_2", reqs = [], dialogue_argument = 2, 
			},
		],
	},
	amelia_trial_9 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_9_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_9_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_TRIAL_9", reqs = []},
			],
		options = [ 
			{code = 'amelia_trial_9_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,}
		],
	},
	amelia_trial_9_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_9_", reqs = []},],
		options = [ 
			{
			code = 'amelia_trial_10', text = "AMELIA_TRIAL_9_OPTION_1", reqs = [], dialogue_argument = 1, 
			},
			{
			code = 'amelia_trial_12', text = "AMELIA_TRIAL_9_OPTION_2", reqs = [], dialogue_argument = 1, 
			},
		],
	},
	amelia_trial_10 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_10", reqs = []}],
		options = [ 
			{code = 'amelia_trial_10_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,}
		],
	},
	amelia_trial_10_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_10_", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_11', text = "AMELIA_TRIAL_10_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_11', text = "AMELIA_TRIAL_10_OPTION_2", reqs = [], dialogue_argument = 2,
			},
			{
			code = 'amelia_trial_11', text = "AMELIA_TRIAL_10_OPTION_3", reqs = [], dialogue_argument = 3,
			},
		],
	},
	amelia_trial_11 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_11_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_11_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_TRIAL_11_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_TRIAL_11", reqs = [], previous_dialogue_option = [1,2]},
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'complete_quest', value = 'amelia_main_quest'},
				{code = 'decision', value = 'amelia_lost'}
			]
		}
		],
	},
	amelia_trial_12 = {
		character = 'amelia', tags = ['dialogue_scene','master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_12", reqs = []}],
		options = [ {
			code = 'amelia_trial_12_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_12_ = {
		character = 'amelia', tags = ['dialogue_scene','master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_12_", reqs = []}],
		options = [ {
			code = 'amelia_trial_13', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_13 = {
		character = 'amelia', tags = ['dialogue_scene','master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_13", reqs = []}],
		options = [ {
			code = 'amelia_trial_13_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_13_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_13_", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_14', text = "AMELIA_TRIAL_13_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_14', text = "AMELIA_TRIAL_13_OPTION_2", reqs = [], dialogue_argument = 2,
			},
		],
	},
	amelia_trial_14 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_14_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_14_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_TRIAL_14", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_trial_15', text = "AMELIA_TRIAL_14_OPTION_1", reqs = [], dialogue_argument = 1, 
			},
			{
			code = 'amelia_trial_15', text = "AMELIA_TRIAL_14_OPTION_2", reqs = [], dialogue_argument = 2, 
			},
		],
	},
	amelia_trial_15 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_15_2", reqs = [], previous_dialogue_option = 2}, #starngely no _1 text
			{text = "AMELIA_TRIAL_15", reqs = []},
			],
		options = [ {
			code = 'amelia_trial_15_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_15_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_15_", reqs = []},],
		options = [ {
			code = 'amelia_trial_16', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_16 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_16", reqs = []},],
		options = [ {
			code = 'amelia_trial_16_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_16_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_16_", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_17', text = "AMELIA_TRIAL_16_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = true}]}], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_18', text = "AMELIA_TRIAL_16_OPTION_2", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_18', text = "AMELIA_TRIAL_16_OPTION_3", reqs = [], dialogue_argument = 2,
			},
			{
			code = 'amelia_trial_19', text = "AMELIA_TRIAL_16_OPTION_4", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_17 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_17", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_normal_1', text = "AMELIA_TRIAL_17_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_bad_1', text = "AMELIA_TRIAL_17_OPTION_2", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_18 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_18_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_18_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [ 
			{
			code = 'amelia_trial_bad_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_19 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_19", reqs = [], previous_dialogue_option = 1},
			],
		options = [ 
			{
			code = 'amelia_trial_normal_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	
	amelia_trial_normal_1 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_1", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_1_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_1_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_1_", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_1__', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_1__ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_1__", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_normal_2', text = "AMELIA_TRIAL_NORMAL_1_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_normal_3', text = "AMELIA_TRIAL_NORMAL_1_OPTION_2", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_normal_3', text = "AMELIA_TRIAL_NORMAL_1_OPTION_3", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'alchemist', check = true}]}], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_2 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_NORMAL_2", reqs = [], previous_dialogue_option = 1},
			],
		options = [ 
			{
			code = 'amelia_trial_bad_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_3 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_3", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_3_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_3_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_NORMAL_3_", reqs = [], previous_dialogue_option = 1},
			],
		options = [ 
			{
			code = 'amelia_trial_normal_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_4 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_NORMAL_4", reqs = [], previous_dialogue_option = 1},
			],
		options = [ 
			{
			code = 'amelia_trial_normal_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_5 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_5", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_normal_6', text = "AMELIA_TRIAL_NORMAL_5_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_normal_7', text = "AMELIA_TRIAL_NORMAL_5_OPTION_2", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_normal_6', text = "AMELIA_TRIAL_NORMAL_5_OPTION_3", reqs = [], dialogue_argument = 2,
			},
		],
	},
	amelia_trial_normal_6 = {
		character = 'amelia',tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_NORMAL_6_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_NORMAL_6_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [ 
			{
			code = 'amelia_trial_bad_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_7 = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_7", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_7_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_7_ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_7_", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_7__', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_7__ = {
		character = 'amelia', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_NORMAL_7__", reqs = [], previous_dialogue_option = 1},
			],
		options = [ 
			{
			code = 'amelia_trial_normal_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_8 = {
		image = 'amelia_hostage', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_8", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_8_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_8_ = {
		image = 'amelia_hostage', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_8_", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_8__', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_8__ = {
		image = 'amelia_hostage', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_NORMAL_8__", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_normal_9', text = "AMELIA_TRIAL_NORMAL_8_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_normal_9', text = "AMELIA_TRIAL_NORMAL_8_OPTION_2", reqs = [], dialogue_argument = 2,
			},
		],
	},
	amelia_trial_normal_9 = {
		tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [
			{text = "AMELIA_TRIAL_NORMAL_9_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_NORMAL_9_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_TRIAL_NORMAL_9", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_trial_normal_9_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_normal_9_ = {
		tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_TRIAL_NORMAL_9_", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_10 = {
		tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_TRIAL_NORMAL_10", reqs = []},],
		options = [ {
			code = 'amelia_trial_normal_10_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_normal_10_ = {
		tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [
			{text = "AMELIA_TRIAL_NORMAL_10_", reqs = []},
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage10'},
#				{code = "update_guild"}
			]
		}
		],
	},
	
	amelia_trial_bad_1 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_BAD_1", reqs = []},],
		options = [ {
			code = 'amelia_trial_bad_1_', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, 
		}, ],
	},
	amelia_trial_bad_1_ = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_TRIAL_BAD_1_", reqs = []}],
		options = [ 
			{
			code = 'amelia_trial_bad_2', text = "AMELIA_TRIAL_BAD_1_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_trial_bad_2', text = "AMELIA_TRIAL_BAD_1_OPTION_2", reqs = [], dialogue_argument = 2,
			},
			{
			code = 'amelia_trial_bad_2', text = "AMELIA_TRIAL_BAD_1_OPTION_3", reqs = [], dialogue_argument = 3,
			},
		],
	},
	amelia_trial_bad_2 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_BAD_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_TRIAL_BAD_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_TRIAL_BAD_2_3", reqs = [], previous_dialogue_option = 3},
			],
		options = [ 
			{
			code = 'amelia_trial_bad_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_trial_bad_3 = {
		image = 'amelia_court', tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_TRIAL_BAD_3", reqs = []},
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = [
				{code = 'complete_quest', value = 'amelia_main_quest'},
				{code = 'decision', value = 'amelia_lost'}
			]
		}
		],
	},
	
	amelia_interlude3_1 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_INTERLUDE3_1_1", reqs = [{type = 'decision', value = 'amelia_discount', check = false},], previous_dialogue_option = 1},
			{text = "AMELIA_INTERLUDE3_1_1a", reqs = [{type = 'decision', value = 'amelia_discount', check = true},], previous_dialogue_option = 1},
			{text = "AMELIA_INTERLUDE3_1_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_INTERLUDE3_1_3", reqs = [], previous_dialogue_option = 3},
			],
		options = [ 
			{
			code = 'amelia_interlude3_1', text = "AMELIA_INTERLUDE3_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'gte', value = 90}]}], dialogue_argument = 2, remove_after_first_use = true, bonus_effects = [{code = 'decision', value = 'amelia_discount'}]
			},
			{
			code = 'amelia_interlude3_1', text = "AMELIA_INTERLUDE3_1_OPTION_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'charm', operant = 'lt', value = 90}]}], dialogue_argument = 3, remove_after_first_use = true
			},
			{
			code = 'amelia_interlude3_2', text = "AMELIA_INTERLUDE3_1_OPTION_2", reqs = [{type = 'decision', value = 'amelia_discount', check = false}, {type = 'has_money', value = 3000}], dialogue_argument = 1, bonus_effects = [{code = 'money_change', operant = '-', value = 3000}, {code = 'decision', value = 'amelia_bought'}, {code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage11'},{code = "update_guild"}, {code = 'make_story_character', value = 'Amelia'}]
			},
			{
			code = 'amelia_interlude3_2', text = "AMELIA_INTERLUDE3_1_OPTION_2", reqs = [{type = 'decision', value = 'amelia_discount', check = true}, {type = 'has_money', value = 1500}], dialogue_argument = 1, bonus_effects = [{code = 'money_change', operant = '-', value = 1500}, {code = 'decision', value = 'amelia_bought'}, {code = 'progress_quest', value = 'amelia_main_quest', stage = 'stage11'},{code = "update_guild"}, {code = 'make_story_character', value = 'Amelia'}]
			},
			{
			code = 'amelia_interlude3_2', text = "AMELIA_INTERLUDE3_1_OPTION_3", reqs = [], dialogue_argument = 2,
			},
		],
	},
	amelia_interlude3_2 = { 
		tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_INTERLUDE3_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_INTERLUDE3_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_INTERLUDE3_2_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_INTERLUDE3_2_4", reqs = [], previous_dialogue_option = 4},
			],
		options = [ 
			{
			code = 'amelia_interlude3_2', text = "AMELIA_INTERLUDE3_2_OPTION_1", reqs = [], dialogue_argument = 3,
			},
			{
			code = 'amelia_interlude3_2', text = "AMELIA_INTERLUDE3_2_OPTION_2", reqs = [], dialogue_argument = 4,
			},
			{
			code = 'amelia_interlude3_3', text = "AMELIA_INTERLUDE3_2_OPTION_3", reqs = [], dialogue_argument = 1,
			},
		],
	},
	amelia_interlude3_3 = {
		tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_INTERLUDE3_3", reqs = []},
			],
		options = [ 
			{
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
		}
		],
	},
	
	amelia_final_1 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_FINAL_1", reqs = []}],
		bonus_effects = [{code = 'complete_quest', value = 'amelia_main_quest'},],
		options = [ 
			{
			code = 'amelia_final_2', text = "AMELIA_FINAL_1_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_final_2', text = "AMELIA_FINAL_1_OPTION_2", reqs = [], dialogue_argument = 2,
			},
			{
			code = 'amelia_final_2', text = "AMELIA_FINAL_1_OPTION_3", reqs = [], dialogue_argument = 3,
			},
		],
	},
	amelia_final_2 = { 
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia', 
		text = [
			{text = "AMELIA_FINAL_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_FINAL_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_FINAL_2_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_FINAL_2", reqs = [], previous_dialogue_option = 4},
			],
		options = [ 
			{
			code = 'amelia_final_3', text = "AMELIA_FINAL_2_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_final_3', text = "AMELIA_FINAL_2_OPTION_2", reqs = [], dialogue_argument = 1,
			},

		],
	},
	amelia_final_3 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [
			{text = "AMELIA_FINAL_3_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_FINAL_3_2", reqs = [], previous_dialogue_option = 2},
			],
		options = [ 
			{
			code = 'amelia_final_3', text = "AMELIA_FINAL_3_OPTION_1", reqs = [], dialogue_argument = 2, remove_after_first_use = true
			},
			{
			code = 'amelia_final_4', text = "AMELIA_FINAL_3_OPTION_2", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_final_4', text = "AMELIA_FINAL_3_OPTION_3", reqs = [], dialogue_argument = 2,
			},
		],
	},
	amelia_final_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [
			{text = "AMELIA_FINAL_4_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_FINAL_4_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_FINAL_4", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_final_5', text = "AMELIA_FINAL_4_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_final_5', text = "AMELIA_FINAL_4_OPTION_2", reqs = [], dialogue_argument = 2,
			},
			{
			code = 'amelia_final_5', text = "AMELIA_FINAL_4_OPTION_3", reqs = [], dialogue_argument = 3,
			},
		],
	},
	amelia_final_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [
			{text = "AMELIA_FINAL_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_FINAL_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_FINAL_5_3", reqs = [], previous_dialogue_option = 3},
			{text = "AMELIA_FINAL_5", reqs = []},
			],
		options = [ 
			{
			code = 'amelia_final_6', text = "AMELIA_FINAL_5_OPTION_1", reqs = [], dialogue_argument = 1,
			},
			{
			code = 'amelia_final_7', text = "AMELIA_FINAL_5_OPTION_2", reqs = [], dialogue_argument = 2,
			},
		],
	},
	amelia_final_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_FINAL_6", reqs = []}],
		options = [ 
			{
			code = 'amelia_sex_1', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, change_dialogue_type = 2
			},
		],
	},
	amelia_final_7 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], character = 'amelia',
		text = [{text = "AMELIA_FINAL_7", reqs = []}],
		options = [ 
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', bonus_effects = []}
		],
	},
	
	amelia_sex_1 = { 
		custom_background = "amelia_sex1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		unlocked_gallery_seq = "amelia_sex",
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_SEX_1", reqs = []}],
		options = [ 
			{code = 'amelia_sex_2', text = "AMELIA_SEX_1_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'amelia_sex_2', text = "AMELIA_SEX_1_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		 ],
	},
	amelia_sex_2 = { 
		custom_background = "amelia_sex1",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_SEX_2_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_SEX_2_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_SEX_2", reqs = []}
			],
		options = [ 
			{code = 'amelia_sex_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		 ],
	},
	amelia_sex_3 = { 
		custom_background = "amelia_sex2",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_SEX_3", reqs = []}
			],
		options = [ 
			{code = 'amelia_sex_4', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		 ],
	},
	amelia_sex_4 = { 
		custom_background = "amelia_sex3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [{text = "AMELIA_SEX_4", reqs = []}],
		options = [ 
			{code = 'amelia_sex_5', text = "AMELIA_SEX_4_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'amelia_sex_5', text = "AMELIA_SEX_4_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'},
		 ],
	},
	amelia_sex_5 = { 
		custom_background = "amelia_sex3",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
		image = null, tags = ['dialogue_scene', 'master_translate'], reqs = [], 
		text = [
			{text = "AMELIA_SEX_5_1", reqs = [], previous_dialogue_option = 1},
			{text = "AMELIA_SEX_5_2", reqs = [], previous_dialogue_option = 2},
			{text = "AMELIA_SEX_5", reqs = []}
			],
		options = [ 
			{code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		 ],
	},
	
	amelia_interlude4 = {
		image = null,
		tags = ['dialogue_scene', 'master_translate'], 
		reqs = [], 
		text = [{text = "AMELIA_INTERLUDE4", reqs = [], }],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 1, type = 'next_dialogue', 
			bonus_effects = []
		} ],
	},
}
