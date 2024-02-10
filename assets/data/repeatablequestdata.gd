extends Node


var questdata = {
	fighters_task_easy = {
		code = 'fighters_task_easy',
		name =  tr("FIGHTERS_TASK_EASY_NAME"),
		descript = tr("FIGHTERS_TASK_EASY_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("FIGHTERS_TASK_EASY_NAME")],
			amount = [12, 15],
			max_workers = [2, 3],
			workstat = 'physics',
			icon = "res://assets/images/gui/gui icons/icon_physics64.png",
			descript = tr("FIGHTERS_TASK_EASY_DESC"),
			function = ['fighters_task_easy']
			}],
		unlockreqs = [],
		reputation = [125,150],
		rewards = [
		[1, {code = 'gold', range = [145,160]}],
		],
		time_limit = [8,12],
	},
	fighters_task_medium = {
		code = 'fighters_task_medium',
		name = tr("FIGHTERS_TASK_MEDIUM_NAME"),
		descript = tr("FIGHTERS_TASK_MEDIUM_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("FIGHTERS_TASK_MEDIUM_NAME")],
			amount = [20, 25],
			max_workers = [2, 3],
			workstat = 'physics',
			icon = "res://assets/images/gui/gui icons/icon_physics64.png",
			descript = tr("FIGHTERS_TASK_MEDIUM_DESC"),
			function = ['fighters_task_medium']
			}],
		unlockreqs = [],
		reputation = [220,270],
		rewards = [
		[1, {code = 'gold', range = [300,350]}],
		],
		time_limit = [9,12],
	},
	fighters_task_hard = {
		code = 'fighters_task_hard',
		name = tr("FIGHTERS_TASK_HARD_NAME"),
		descript = tr("FIGHTERS_TASK_HARD_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("FIGHTERS_TASK_HARD_NAME")],
			amount = [35, 50],
			max_workers = [2, 3],
			workstat = 'physics',
			icon = "res://assets/images/gui/gui icons/icon_physics64.png",
			descript = tr("FIGHTERS_TASK_HARD_DESC"),
			function = ['fighters_task_hard']
			}],
		unlockreqs = [],
		reputation = [350, 450],
		rewards = [
		[1, {code = 'gold', range = [400,550]}],
		],
		time_limit = [9,12],
	},
	mages_task_easy = {
		code = 'mages_task_easy',
		name = tr("MAGES_TASK_EASY_NAME"),
		descript = tr("MAGES_TASK_EASY_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("MAGES_TASK_EASY_NAME")],
			amount = [12, 15],
			max_workers = [2, 3],
			workstat = 'wits',
			descript = tr("MAGES_TASK_EASY_DESC"),
			icon = "res://assets/images/gui/gui icons/icon_wits64.png",
			function = ['mages_task_easy']
			}],
		unlockreqs = [],
		reputation = [125,150],
		rewards = [
		[1, {code = 'gold', range = [145,160]}],
		],
		time_limit = [8,12],
	},
	mages_task_medium = {
		code = 'mages_task_medium',
		name =tr("MAGES_TASK_MEDIUM_NAME"),
		descript = tr("MAGES_TASK_MEDIUM_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("MAGES_TASK_MEDIUM_NAME")],
			amount = [20, 25],
			max_workers = [2, 3],
			workstat = 'wits',
			descript = tr("MAGES_TASK_MEDIUM_DESC"),
			icon = "res://assets/images/gui/gui icons/icon_wits64.png",
			function = ['mages_task_medium']
			}],
		unlockreqs = [],
		reputation = [220,270],
		rewards = [
		[1, {code = 'gold', range = [300,350]}],
		],
		time_limit = [9,12],
	},
	mages_task_hard = {
		code = 'mages_task_hard',
		name = tr("MAGES_TASK_HARD_NAME"),
		descript = tr("MAGES_TASK_HARD_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("MAGES_TASK_HARD_NAME")],
			amount = [35, 50],
			max_workers = [2, 3],
			workstat = 'wits',
			descript = tr("MAGES_TASK_HARD_DESC"),
			icon = "res://assets/images/gui/gui icons/icon_wits64.png",
			function = ['mages_task_hard']
			}],
		unlockreqs = [],
		reputation = [350, 450],
		rewards = [
		[1, {code = 'gold', range = [400,550]}],
		],
		time_limit = [9,12],
	},
	workers_task_easy = {
		code = 'workers_task_easy',
		name = tr("WORKERS_TASK_EASY_NAME"),
		descript = tr("WORKERS_TASK_EASY_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("WORKERS_TASK_EASY_NAME")],
			amount = [11, 13],
			max_workers = [1, 2],
			descript = tr("WORKERS_TASK_EASY_DESC"),
			workstat = 'physics',
			icon = "res://assets/images/gui/gui icons/icon_physics64.png",
			function = ['workers_task_easy']
			}],
		unlockreqs = [],
		reputation = [125,150],
		rewards = [
		[1, {code = 'gold', range = [145,160]}],
		],
		time_limit = [8,12],
	},
	workers_task_medium = {
		code = 'workers_task_medium',
		name = tr("WORKERS_TASK_MEDIUM_NAME"),
		descript = tr("WORKERS_TASK_MEDIUM_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("WORKERS_TASK_MEDIUM_NAME")],
			amount = [20, 25],
			max_workers = [2, 3],
			workstat = 'wits',
			descript = tr("WORKERS_TASK_MEDIUM_DESC"),
			icon = "res://assets/images/gui/gui icons/icon_wits64.png",
			function = ['workers_task_medium']
			}],
		unlockreqs = [],
		reputation = [220,270],
		rewards = [
		[1, {code = 'gold', range = [300,350]}],
		],
		time_limit = [9,12],
	},
	workers_task_hard = {
		code = 'workers_task_hard',
		name = tr("WORKERS_TASK_HARD_NAME"),
		descript = tr("WORKERS_TASK_HARD_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("WORKERS_TASK_HARD_NAME")],
			amount = [45, 60],
			max_workers = [2, 3],
			workstat = 'physics',
			descript = tr("WORKERS_TASK_HARD_DESC"),
			icon = "res://assets/images/gui/gui icons/icon_physics64.png",
			function = ['workers_task_hard']
			}],
		unlockreqs = [],
		reputation = [350, 450],
		rewards = [
		[1, {code = 'gold', range = [400,550]}],
		],
		time_limit = [9,12],
	},
	
	
	servants_task_easy = {
		code = 'servants_task_easy',
		name = tr("SERVANTS_TASK_EASY_NAME"),
		descript = tr("SERVANTS_TASK_EASY_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("SERVANTS_TASK_EASY_NAME")],
			amount = [11, 13],
			max_workers = [1, 1],
			descript = tr("SERVANTS_TASK_EASY_DESC"),
			workstat = 'charm',
			icon = "res://assets/images/gui/gui icons/icon_charm64.png",
			function = ['servants_task_easy']
			}],
		unlockreqs = [],
		reputation = [125,150],
		rewards = [
		[1, {code = 'gold', range = [145,160]}],
		],
		time_limit = [8,12],
	},
#	servants_task_medium = {
#		code = 'servants_task_medium',
#		name = '',
#		descript = '',
#		randomconditions = [{
#			code = 'special_task', 
#			location = 'aliron',
#			name = [''],
#			amount = [20, 25],
#			max_workers = [2, 3],
#			workstat = 'charm',
#			descript = 'The worker guild looks for tailors who can help with the recent order.',
#			icon = "res://assets/images/gui/gui icons/icon_charm64.png",
#			function = ['workers_ttask_medium']
#			}],
#		unlockreqs = [],
#		reputation = [220,270],
#		rewards = [
#		[1, {code = 'gold', range = [300,350]}],
#		],
#		time_limit = [9,12],
#	},
	servants_task_hard = {
		code = 'servants_task_hard',
		name = tr("SERVANTS_TASK_HARD_NAME"),
		descript = tr("SERVANTS_TASK_HARD_DESC"),
		randomconditions = [{
			code = 'special_task', 
			location = 'aliron',
			name = [tr("SERVANTS_TASK_HARD_NAME")],
			amount = [45, 60],
			max_workers = [2, 3],
			workstat = 'charm',
			descript = tr("SERVANTS_TASK_HARD_DESC"),
			icon = "res://assets/images/gui/gui icons/icon_charm64.png",
			function = ['servants_task_hard']
			}],
		unlockreqs = [],
		reputation = [350, 450],
		rewards = [
		[1, {code = 'gold', range = [400,550]}],
		],
		time_limit = [9,12],
	},
	
	
	
	
	
	workers_resources_easy = {
		code = 'workers_resources_easy',
		name = tr("WORKERS_RESOURCES_NAME"),
		descript = tr("WORKERS_RESOURCES_DESC"),
		randomconditions = [{code = 'random_material', function = 'range', type = ['wood','cloth','bone','leather'], range = [8,15]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1,{code = 'gold',  item_based = true, range = [1.4,1.5]}], #first value is a weight of reward
		[0.3,{code = 'gear', material_grade = [['easy', 5], ['medium',1]], name = ['axe','pickaxe','sickle']}],
		],
		time_limit = [8,12],
	},
	workers_resources_medium = {
		code = 'workers_resources_medium',
		name = tr("WORKERS_RESOURCES_NAME"),
		descript = tr("WORKERS_RESOURCES_DESC"),
		randomconditions = [{code = 'random_material', function = 'range', type = ['woodiron','iron','steel','clothmagic'], range = [8,15]}],
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.5,1.8]}],
		[0.3,{code = 'gear', material_grade = [['easy', 1], ['medium',4],['hard',1]], name = ['axe','pickaxe','sickle','hammer','fishingtools']}],
		],
		time_limit = [8,12],
	},
	workers_resources_hard = {
		code = 'workers_resources_hard',
		name = tr("WORKERS_RESOURCES_NAME"),
		descript = tr("WORKERS_RESOURCES_DESC"),
		randomconditions = [{code = 'random_material', function = 'range', type = ['woodmagic','boneancient','leathermythic','mithril','lizard_skin'], range = [8,15]}],
		unlockreqs = [],
		reputation = [250,400],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.7,1.95]}],
		[0.3,{code = 'gear', material_grade = [['easy', 1], ['medium',3],['hard',3]], name = ['axe','pickaxe','sickle','hammer','fishingtools']}],
		],
		time_limit = [8,12],
	},
	workers_food_easy = {
		code = 'workers_food_easy',
		name = tr("WORKERS_FOOD_NAME"),
		descript = tr("WORKERS_FOOD_DESC"),
		randomconditions = [{code = 'random_material', function = 'range', type =  ['meat','fish','vegetables','bread'], range = [35,55]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.5,1.7]}],
		[1,{code = 'material', name = ['wood', 'stone','leather','cloth', 'iron'], value = [15,20]}],
		[0.5,{code = 'gold', item_based = true, range = [0.5,0.6]},{code = 'metarial', type = ['steel', 'woodmagic','woodiron','clothsilk'], range = [5,10]}],
		],
		time_limit = [8,12],
	},
	workers_food_medium = {
		code = 'workers_food_medium',
		name = tr("WORKERS_FOOD_NAME"),
		descript = tr("WORKERS_FOOD_DESC"),
		randomconditions = [{code = 'random_material', function = 'range', type =  ['meat','fish','vegetables','bread'], range = [75,120]}],
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.7,1.9]}],
		#[1,{code = 'material', name = ['wood', 'stone','leather','cloth', 'iron'], value = [15,20]}],
		[0.5,{code = 'gold', item_based = true, range = [0.6,0.7]},{code = 'metarial', type = ['steel', 'obsidian','woodiron','clothmagic'], range = [10,15]}],
		],
		time_limit = [8,12],
	},
	workers_food_hard = {
		code = 'workers_food_hard',
		name = tr("WORKERS_FOOD_NAME"),
		descript = tr("WORKERS_FOOD_DESC"),
		randomconditions = [{code = 'random_material', function = 'range', type =  ['bread','fishcakes','meatsoup'], range = [75,120]}],
		unlockreqs = [],
		reputation = [250,450],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.8,2.1]}],
		#[1,{code = 'material', name = ['wood', 'stone','leather','cloth', 'iron'], value = [15,20]}],
		[0.5,{code = 'gold', item_based = true, range = [0.7,0.8]},{code = 'metarial', type = ['mithril', 'obsidian','woodancient','clothmagic'], range = [3,5]}],
		],
		time_limit = [8,12],
	},
	workers_craft_tools_easy = {
		code = 'workers_craft_tools_easy',
		name = tr("WORKERS_CRAFT_TOOLS_NAME"),
		descript = tr("WORKERS_CRAFT_TOOLS_DESC"),
		randomconditions = [{code = 'random_item', function = 'range', type = ['axe','pickaxe','sickle'], range = [1,1], parts = {ToolBlade = ['iron','bone']}}],
		unlockreqs = [],
		reputation = [150,200],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.7,2]}],
		],
		time_limit = [8,12],
	},
	workers_craft_tools_medium = {
		code = 'workers_craft_tools_medium',
		name = tr("WORKERS_CRAFT_TOOLS_NAME"),
		descript = tr("WORKERS_CRAFT_TOOLS_DESC"),
		randomconditions = [
			{code = 'random_item', function = 'range', type = ['axe','pickaxe','sickle','hammer','hunt_knife'], range = [1,1], parts = {ToolBlade = ['steel','obsidian']}},
			{code = 'random_item', function = 'range', type = ['axe','pickaxe','sickle','hammer','fishingtools','hunt_knife'], range = [1,1], parts = {ToolHandle = ['steel','woodmagic']}},
			],
		unlockreqs = [],
		reputation = [250,400],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2,2.2]}],
		],
		time_limit = [8,12],
	},
	workers_threat_easy = {
		code = 'workers_threat_easy',
		name = tr("WORKERS_THREAT_NAME"),
		descript = tr("WORKERS_THREAT_DESC"),
		randomconditions = [{code = 'complete_location', type = ['basic_threat_wolves'], difficulty = 'easy'}],
		unlockreqs = [],
		reputation = [150,200],
		rewards = [
		[1, {code = 'gold', range = [100,150]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['axe','pickaxe','sickle']}],
		[0.5, {code = 'gear_static', name = ['worker_outfit'], value = [1,1]}],
		],
		time_limit = [8,12],
	},
	workers_threat_medium = {
		code = 'workers_threat_medium',
		name = tr("WORKERS_THREAT_NAME"),
		descript = tr("WORKERS_THREAT_DESC"),
		randomconditions = [{code = 'complete_location', type = ['basic_threat_troll'], difficulty = 'medium'}],
		unlockreqs = [],
		reputation = [200,300],
		rewards = [
		[1, {code = 'gold', range = [250,400]}],
		[1, {code = 'gear', material_grade = [['easy', 1], ['medium',3]], name = ['axe','pickaxe','sickle','hunt_knife']}],
		],
		time_limit = [8,12],
	},
	fighters_threat_easy = {
		code = 'fighters_threat_easy',
		name = tr("FIGHTERS_THREAT_NAME"),
		descript = tr("FIGHTERS_THREAT_DESC"),
		randomconditions = [{code = 'complete_location', type = ['basic_threat_goblins','basic_threat_rebels']}],#,
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [125,175]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',1]], name = ['sword','spear','club','bow']}],
		],
		time_limit = [8,12],
	},
	fighters_threat_medium = {
		code = 'fighters_threat_medium',
		name = tr("FIGHTERS_THREAT_NAME"),
		descript = tr("FIGHTERS_THREAT_DESC"),
		randomconditions = [{code = 'complete_location', type = ['basic_threat_ogre']}],#,
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1, {code = 'gold', range = [200,300]}],
		[1, {code = 'gear', material_grade = [['easy',1], ['medium',4], ['hard',1]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}],
		],
		time_limit = [8,12],
	},
	fighters_dungeon_easy = {
		code = 'fighters_dungeon_easy',
		name = tr("FIGHTERS_DUNGEON_NAME"),
		descript = tr("FIGHTERS_DUNGEON_DESC"),
		randomconditions = [{code = 'complete_dungeon', type = ['dungeon_bandit_den', 'dungeon_goblin_cave']}],
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1, {code = 'gold', range = [200,300]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',3]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}, {code = 'gold', range = [25,50]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['chest_base_metal','legs_base_metal']}],
		],
		time_limit = [12,16],
	},
	fighters_dungeon_medium = {
		code = 'fighters_dungeon_medium',
		name = tr("FIGHTERS_DUNGEON_NAME"),
		descript = tr("FIGHTERS_DUNGEON_DESC"),
		randomconditions = [{code = 'complete_dungeon', type = ['dungeon_bandit_fort','dungeon_undead_crypt','dungeon_ancient_jungles']}],
		unlockreqs = [],
		reputation = [200,350],
		rewards = [
		[1, {code = 'gold', range = [350,500]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',3]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}, {code = 'gold', range = [75,100]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['chest_base_metal','legs_base_metal']}],
		],
		time_limit = [16,20],
	},
	fighters_dungeon_hard = {
		code = 'fighters_dungeon_hard',
		name = tr("FIGHTERS_DUNGEON_NAME"),
		descript = tr("FIGHTERS_DUNGEON_DESC"),
		randomconditions = [{code = 'complete_dungeon', type = ['dungeon_fire_depths','dungeon_ancient_jungles']}],
		unlockreqs = [],
		reputation = [300,500],
		rewards = [
		[1, {code = 'gold', range = [600,900]}],
		[1, {code = 'gear', material_grade = [['medium',3],['hard',2]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}, {code = 'gold', range = [150,250]}],
		[1, {code = 'gear', material_grade = [['medium',3],['hard',2]], name = ['chest_base_metal','legs_base_metal']}],
		[0.3, {code = 'gear', material_grade = [['medium',3],['hard',2]], name = ['chest_adv_metal','legs_adv_metal','swordadv','spearadv','bowadv','maceadv']}],
		],
		time_limit = [16,20],
	},
	fighters_monster_hunt_easy = {
		code = 'fighters_monster_hunt_easy',
		name = tr("FIGHTERS_MONSTER_HUNT_NAME"),
		descript = tr("FIGHTERS_MONSTER_HUNT_DESC"),
		randomconditions = [{code = 'kill_monsters', type = ['bandit','goblin'], range = [6,9]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [125,150]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',1]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}, {code = 'gold', range = [10,30]}],
		],
		time_limit = [8,12],
	},
	fighters_monster_hunt_medium = {
		code = 'fighters_monster_hunt_medium',
		name = tr("FIGHTERS_MONSTER_HUNT_NAME"),
		descript = tr("FIGHTERS_MONSTER_HUNT_DESC"),
		randomconditions = [{code = 'kill_monsters', type = ['bandit','undead'], range = [8,15]}],
		unlockreqs = [],
		reputation = [200,250],
		rewards = [
		[1, {code = 'gold', range = [200,300]}],
		[1, {code = 'gear', material_grade = [['easy', 1], ['medium',4], ['hard',1]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}, {code = 'gold', range = [50,100]}],
		],
		time_limit = [8,16],
	},
	fighters_monster_hunt_hard = {
		code = 'fighters_monster_hunt_hard',
		name = tr("FIGHTERS_MONSTER_HUNT_NAME"),
		descript = tr("FIGHTERS_MONSTER_HUNT_DESC"),
		randomconditions = [{code = 'kill_monsters', type = ['bandit','undead'], range = [15,25]}],
		unlockreqs = [],
		reputation = [400,500],
		rewards = [
		[1, {code = 'gold', range = [350,600]}],
		[1, {code = 'gear', material_grade = [['easy', 1], ['medium',4], ['hard',3]], name = ['sword','spear','club','bow','battleaxe','mace','crossbow']}, {code = 'gold', range = [150,250]}],
		],
		time_limit = [8,16],
	},
	
	fighters_craft_gear_medium = {
		code = 'fighters_craft_gear_medium',
		name = tr("FIGHTERS_CRAFT_GEAR_NAME"),
		descript = tr("FIGHTERS_CRAFT_GEAR_NAME"),
		randomconditions = [
			{code = 'random_item', function = 'range', type = ['dagger','sword','spear','bow','battleaxe','mace','crossbow'], range = [1,1], parts = {WeaponHandle = ['steel','boneancient','woodiron']}},
			{code = 'random_item', function = 'range', type = ['dagger','sword','spear','mace'], range = [1,1], parts = {Blade = ['steel','obsidian','boneancient']}},
			{code = 'random_item', function = 'range', type = ['chest_base_leather','legs_base_leather','chest_base_metal','legs_base_metal'], range = [1,1], parts = {ArmorTrim = ['steel','obsidian','clothmagic','woodmagic']}},
			{code = 'random_item', function = 'range', type = ['chest_base_leather','legs_base_leather'], range = [1,1], parts = {ArmorBaseMed = ['leatherthick','leathermythic','insect_chitin','lizard_skin','boneancient']}},
			],
		unlockreqs = [],
		reputation = [250,450],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2,2.2]}],
		],
		time_limit = [8,12],
	},
	fighters_craft_gear_hard = {
		code = 'fighters_craft_gear_hard',
		name = tr("FIGHTERS_CRAFT_GEAR_NAME"),
		descript = tr("FIGHTERS_CRAFT_GEAR_NAME"),
		randomconditions = [
			{code = 'random_item', function = 'range', type = ['dagger','sword','spear','bow','battleaxe','mace','crossbow'], range = [2,3], parts = {WeaponHandle = ['mithril','boneancient','woodiron','obsidian']}},
			{code = 'random_item', function = 'range', type = ['dagger','sword','spear','mace'], range = [2,3], parts = {Blade = ['mithril','obsidian','boneancient']}},
			
			
			
			{code = 'random_item', function = 'range', type = ['chest_adv_metal','legs_adv_metal','chest_adv_leather','legs_adv_leather'], range = [1,1], parts = {ArmorTrim = ['mithril','obsidian','boneancient','clothethereal','woodmagic']}},
			{code = 'random_item', function = 'range', type = ['swordadv','spearadv','maceadv'], range = [1,1], parts = {Blade = ['mithril','obsidian','boneancient','adamantine']}},
			],
		unlockreqs = [],
		reputation = [400,600],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2.7,3.5]}],
		],
		time_limit = [10,13],
	},
	
	
	mages_materials_easy = {
		code = 'mages_materials_easy',
		name = tr("MAGES_MATERIALS_NAME"),
		descript = tr("MAGES_MATERIALS_DESC"),
		randomconditions = [{code = 'random_material', type = ['wood','bone','cloth'], range = [7,12]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.6,1.8]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['staff']},  {code = 'gold', item_based = true, range = [0.5,0.7]}],
		],
		time_limit = [8,12],
	},
	mages_materials_medium = {
		code = 'mages_materials_medium',
		name =tr("MAGES_MATERIALS_NAME"),
		descript = tr("MAGES_MATERIALS_DESC"),
		randomconditions = [{code = 'random_material', type = ['woodmagic','clothmagic','obsidian'], range = [5,15]}],
		unlockreqs = [],
		reputation = [200,300],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.9,2.1]}],
		[1, {code = 'gear', material_grade = [['easy', 2], ['medium',4], ['hard',0.5]], name = ['staff']}, {code = 'gold', item_based = true, range = [0.5,0.7]}],
		],
		time_limit = [8,12],
	},
	mages_materials_hard = {
		code = 'mages_materials_hard',
		name = tr("MAGES_MATERIALS_NAME"),
		descript = tr("MAGES_MATERIALS_DESC"),
		randomconditions = [{code = 'random_material', type = ['woodancient','clothethereal','boneancient','mithril'], range = [6,12]}],
		unlockreqs = [],
		reputation = [300,500],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2,2.3]}],
		[1, {code = 'gear', material_grade = [['medium',4], ['hard',2]], name = ['staff','staffadv']}, {code = 'gold', item_based = true, range = [0.6,0.8]}],
		],
		time_limit = [8,12],
	},
	mages_craft_potions_easy = {
		code = 'mages_craft_potions_easy',
		name = tr("MAGES_CRAFT_POTIONS_NAME"),
		descript = tr("MAGES_CRAFT_POTIONS_DESC"),
		randomconditions = [{code = 'random_item', type = ['aphrodisiac', 'alcohol','energyshard'], range = [2,3]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.9,2.1]}],
		],
		time_limit = [8,12],
	},
	mages_craft_potions_medium = {
		code = 'mages_craft_potions_medium',
		name = tr("MAGES_CRAFT_POTIONS_NAME"),
		descript = tr("MAGES_CRAFT_POTIONS_DESC"),
		randomconditions = [{code = 'random_item', type = ['aphrodisiac', 'alcohol','energyshard'], range = [5,8]},{code = 'random_item', type = ['energyshard','energygem'], range = [2,4]}],
		unlockreqs = [],
		reputation = [200,300],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2.1,2.4]}],
		],
		time_limit = [8,12],
	},
	mages_craft_potions_hard = {
		code = 'mages_craft_potions_hard',
		name = tr("MAGES_CRAFT_POTIONS_NAME"),
		descript = tr("MAGES_CRAFT_POTIONS_DESC"),
		randomconditions = [{code = 'random_item', type = ['circlet'], range = [1,2]},{code = 'random_item', type = ['lifegem','energygem'], range = [2,4]}, {code = 'random_material', type = ['ink_mp'], range = [2,4]}],
		unlockreqs = [],
		reputation = [200,300],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2.3,2.5]}],
		],
		time_limit = [8,12],
	},
	mages_threat_easy = {
		code = 'mages_threat_easy',
		name = tr("MAGES_THREAT_NAME"),
		descript = tr("MAGES_THREAT_DESC"),
		randomconditions = [{code = 'complete_location', type = ['basic_threat_wolves'], difficulty = 'easy'}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [100,150]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['staff','chest_base_cloth','legs_base_cloth']}],

		],
		time_limit = [8,12],
	},
	
	mages_craft_gear_medium = {
		code = 'mages_craft_gear_medium',
		name = tr("MAGES_CRAFT_GEAR_NAME"),
		descript = tr("MAGES_CRAFT_GEAR_DESC"),
		randomconditions = [
			{code = 'random_item', function = 'range', type = ['staff'], range = [1,1], parts = {WeaponHandle = ['steel','boneancient','woodiron']}},
			{code = 'random_item', function = 'range', type = ['chest_base_cloth','legs_base_cloth'], range = [1,1], parts = {ArmorBaseCloth = ['clothmagic','clothsilk']}},
			],
		unlockreqs = [],
		reputation = [250,450],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2,2.2]}],
		],
		time_limit = [8,12],
	},
	mages_craft_gear_hard = {
		code = 'mages_craft_gear_hard',
		name = tr("MAGES_CRAFT_GEAR_NAME"),
		descript = tr("MAGES_CRAFT_GEAR_DESC"),
		randomconditions = [
			{code = 'random_item', function = 'range', type = ['staff'], range = [2,3], parts = {WeaponHandle = ['steel','boneancient','woodiron','mithril']}},
			{code = 'random_item', function = 'range', type = ['chest_base_cloth','legs_base_cloth'], range = [2,2], parts = {ArmorBaseCloth = ['clothmagic','clothsilk']}},
			
			
			
			{code = 'random_item', function = 'range', type = ['chest_adv_cloth','legs_adv_cloth'], range = [1,1], parts = {ArmorTrim = ['mithril','obsidian','boneancient','clothethereal','woodmagic']}},
			],
		unlockreqs = [],
		reputation = [400,600],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2.7,3.5]}],
		],
		time_limit = [10,13],
	},
	
	servants_craft_items_easy = {
		code = 'servants_craft_items_easy',
		name = "SERVANTS_CRAFT_NAME",
		descript = "SERVANTS_CRAFT_DESC",
		randomconditions = [{code = 'random_item', type = ['leather_collar','animal_gloves','animal_ears','handcuffs','bell_collar'], range = [1,2]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.5,1.8]}],
		],
		time_limit = [8,12],
	},
	servants_craft_items_medium = {
		code = 'servants_craft_items_medium',
		name = tr("SERVANTS_CRAFT_NAME"),
		descript = tr("SERVANTS_CRAFT_DESC"),
		randomconditions = [{code = 'random_item', type = ['chastity_belt','tail_plug','steel_collar','sexdrug','anal_beads','ribbon'], range = [1,3]}],
		unlockreqs = [],
		reputation = [250,350],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.8,2]}],
		],
		time_limit = [8,12],
	},
	servants_craft_items_hard = {
		code = 'servants_craft_items_hard',
		name = tr("SERVANTS_CRAFT_NAME"),
		descript = tr("SERVANTS_CRAFT_DESC"),
		randomconditions = [{code = 'random_item', type = ['pet_suit','elegant_choker','seethrough_underwear','latex_suit'], range = [1,2]}],
		unlockreqs = [],
		reputation = [400,550],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2,2.3]}],
		],
		time_limit = [8,12],
	},
	servants_slave_easy = {
		code = 'servants_slave_easy',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("SERVANTS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [1,1],
			mandatory_conditions = [],
			condition_number = [1,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','timid_factor'], range = [2,3]},
			{use_once = true, code = 'race', function = 'range', type = ['Human','Elf','Goblin','HalfkinCat','BeastkinCat','HalfkinWolf','BeastkinWolf'], range = [3,3]},
			],},
		],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [250,400]}],
		],
		time_limit = [8,12],
	},
	servants_slave_medium = {
		code = 'servants_slave_medium',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("SERVANTS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [2,2],
			mandatory_conditions = [],
			condition_number = [1,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','timid_factor','sexuals_factor'], range = [2,3]},
			{use_once = true, code = 'race', function = 'range', type = ['Human','Elf','TribalElf','Goblin','Orc','Dwarf','Fairy','HalfkinFox','BeastkinFox','HalfkinTanuki','BeastkinTanuki'], range = [2,3]},
			],},
		],
		unlockreqs = [],
		reputation = [300,450],
		rewards = [
		[1, {code = 'gold', range = [450,600]}],
		],
		time_limit = [8,12],
	},
	servants_slave_hard = {
		code = 'servants_slave_hard',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("SERVANTS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [3,4],
			mandatory_conditions = [],
			condition_number = [1,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','timid_factor','sexuals_factor'], range = [3,4]},
			{use_once = true, code = 'race', function = 'range', type = ['Human','Elf','TribalElf','Goblin','Orc','Dwarf','Gnome','Kobold','Dryad','Fairy','HalfkinFox','BeastkinFox'], range = [2,3]},
			],},
		],
		unlockreqs = [],
		reputation = [400,550],
		rewards = [
		[1, {code = 'gold', range = [600,750]}],
		],
		time_limit = [10,16],
	},
	servants_slave_rare_medium = {
		code = 'servants_slave_rare_hard',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("SERVANTS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [1,1],
			mandatory_conditions = [],
			condition_number = [2,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['charm_factor','sexuals_factor'], range = [3,4]},
			{use_once = true, code = 'race', function = 'range', type = ['TribalElf','Scylla','Lamia','Arachna','Nereid','Fairy','Dryad'], range = [2,2]},
			],},
		],
		unlockreqs = [],
		reputation = [400,550],
		rewards = [
		[1, {code = 'gold', range = [700,900]}],
		],
		time_limit = [10,16],
	},
	servants_slave_rare_hard = {
		code = 'servants_slave_rare_hard',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("SERVANTS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [1,1],
			mandatory_conditions = [],
			condition_number = [2,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['charm_factor','sexuals_factor'], range = [3,5]},
			{use_once = true, code = 'race', function = 'range', type = ['Demon','Seraph','DarkElf'], range = [2,2]},
			],},
		],
		unlockreqs = [],
		reputation = [400,550],
		rewards = [
		[1, {code = 'gold', range = [750,1000]}],
		],
		time_limit = [10,16],
	},
	
	fighters_slave_easy = {
		code = 'fighters_slave_easy',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("FIGHTERS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [1,1],
			mandatory_conditions = [],
			condition_number = [1,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['physics_factor','tame_factor'], range = [2,3]},
			{use_once = true, code = 'race', function = 'range', type = ['Human','Elf','Goblin','HalfkinCat','BeastkinCat','HalfkinWolf','BeastkinWolf'], range = [2,2]},
			],},
		],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [250,400]}],
		],
		time_limit = [8,12],
	},
	fighters_slave_medium = {
		code = 'fighters_slave_medium',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("FIGHTERS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [2,2],
			mandatory_conditions = [],
			condition_number = [1,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','physics_factor'], range = [2,3]},
			{use_once = true, code = 'race', function = 'range', type = ['Human','Elf','TribalElf','Goblin','Orc','Dwarf'], range = [2,2]},
			],},
		],
		unlockreqs = [],
		reputation = [300,450],
		rewards = [
		[1, {code = 'gold', range = [450,600]}],
		],
		time_limit = [8,12],
	},
	fighters_slave_hard = {
		code = 'fighters_slave_hard',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("FIGHTERS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [2,3],
			mandatory_conditions = [],
			condition_number = [1,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','physics_factor'], range = [3,4]},
			{use_once = true, code = 'race', function = 'range', type = ['Elf','TribalElf','Orc','Dwarf'], range = [2,2]},
			],},
		],
		unlockreqs = [],
		reputation = [400,550],
		rewards = [
		[1, {code = 'gold', range = [600,750]}],
		],
		time_limit = [10,16],
	},
	workers_slave_easy = {
		code = 'workers_slave_easy',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("WORKERS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [1,1],
			mandatory_conditions = [],
			condition_number = [0,1],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['wits_factor','physics_factor'], range = [2,3]},
			],},
		],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [250,400]}],
		],
		time_limit = [8,12],
	},
	workers_slave_medium = {
		code = 'workers_slave_medium',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("WORKERS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [2,2],
			mandatory_conditions = [],
			condition_number = [0,1],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['wits_factor','physics_factor'], range = [2,3]},
			{use_once = true, code = 'race', function = 'range', type = ['Human','Dwarf','Gnome'], range = [1,2]},
			],},
		],
		unlockreqs = [],
		reputation = [250,350],
		rewards = [
		[1, {code = 'gold', range = [450,600]}],
		],
		time_limit = [8,12],
	},
	workers_slave_hard = {
		code = 'workers_slave_hard',
		name = tr("SERVANTS_SLAVE_NAME"),
		descript = tr("WORKERS_SLAVE_DESC"),

		randomconditions = [
			{code = 'slave_delivery',
			range = [2,3],
			mandatory_conditions = [],
			condition_number = [0,1],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['wits_factor','physics_factor'], range = [3,4]},
			],},
		],
		unlockreqs = [],
		reputation = [400,550],
		rewards = [
		[1, {code = 'gold', range = [600,750]}],
		],
		time_limit = [10,16],
	},
	
	
	
#	servants_slave_work_easy = {
#		code = 'servants_slave_work_easy',
#		name = tr("SERVANTS_SLAVE_WORK_NAME"),
#		descript = tr("SERVANTS_SLAVE_WORK_DESC"),
#		randomconditions = [
#			{code = 'slave_work',
#			mandatory_conditions = [{code = 'sex', operant = 'eq', value = ['male','female']}],
#			condition_number = [1,2],
#			conditions = [
#
#				{use_once = true, code = 'class', function = 'range', range = [1,1], type = ['harlot','maid','dancer','pet','petbeast','thief']},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['tame_factor', 'timid_factor'], range = [2,3]},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['charm','sexuals'], range = [20,40]},
#			],
#			work_time = [2,4], #days
#			},
#		],
#		unlockreqs = [],
#		reputation = [100,150],
#		rewards = [
#			[1, {code = 'gold', range = [200,300]}],
#			[0.5, {code = 'gear_static', name  = ['maid_headband','handcuffs','animal_gloves','animal_ears','bell_collar','leather_collar'], value = [1,1]},
#				{code = 'gold', range = [100,150]}
#		],
#		],
#		time_limit = [8,12],
#	},
#	servants_slave_work_medium = {
#		code = 'servants_slave_work_medium',
#		name = tr("SERVANTS_SLAVE_WORK_NAME"),
#		descript = tr("SERVANTS_SLAVE_WORK_DESC"),
#		randomconditions = [
#			{code = 'slave_work',
#			mandatory_conditions = [],
#			condition_number = [1,2],
#			conditions = [
#
#				{use_once = true, code = 'class', function = 'range', range = [1,2], type = ['harlot','maid','dancer','bard','sextoy','succubus']},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['tame_factor', 'timid_factor'], range = [2,4]},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['charm','sexuals'], range = [30,60]},
#			],
#			work_time = [3,6], #days
#			},
#		],
#		unlockreqs = [],
#		reputation = [200,300],
#		rewards = [
#		[1, {code = 'gold', range = [300,500]}],
#
#			[
#			0.5,
#			{code = 'gear_static', name  = ['ribbon','maid_dress','steel_collar','chastity_belt'], value = [1,1]},
#			{code = 'gold', range = [300,400]}
#			],
#
#		],
#		time_limit = [10,15],
#	},
#	servants_slave_work_hard = {
#		code = 'servants_slave_work_hard',
#		name = tr("SERVANTS_SLAVE_WORK_NAME"),
#		descript = tr("SERVANTS_SLAVE_WORK_DESC"),
#		randomconditions = [
#			{code = 'slave_work',
#			mandatory_conditions = [],
#			condition_number = [2,3],
#			conditions = [
#
#				{use_once = true, code = 'class', function = 'range', range = [2,3], type = ['harlot','maid','geisha','pet','petbeast','dancer','bard','sextoy','succubus']},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['tame_factor', 'timid_factor'], range = [4,5]},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['charm','sexuals'], range = [50,80]},
#			],
#			work_time = [5,8], #days
#			},
#		],
#		unlockreqs = [],
#		reputation = [350,550],
#		rewards = [
#		[1, {code = 'gold', range = [400,650]}],
#			[
#			0.5,
#			{code = 'gear_static', name  = ['ribbon','maid_dress','steel_collar','chastity_belt','elegant_choker'], value = [1,1]},
#			{code = 'gold', range = [350,450]}
#			],
#
#		],
#		time_limit = [12,18],
#	},
#	fighters_slave_work_easy = {
#		code = 'fighters_slave_work_easy',
#		name = tr("FIGHTERS_SLAVE_WORK_NAME"),
#		descript = tr("FIGHTERS_SLAVE_WORK_DESC"),
#		randomconditions = [
#			{code = 'slave_work',
#			mandatory_conditions = [],
#			condition_number = [1,2],
#			conditions = [
#
#				{use_once = true, code = 'class', function = 'range', range = [1,1], type = ['fighter','archer','rogue']},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['physics_factor'], range = [2,3]},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['physics'], range = [20,40]},
#			],
#			work_time = [2,4], #days
#			},
#		],
#		unlockreqs = [],
#		reputation = [100,150],
#		rewards = [
#		[1, {code = 'gold', range = [200,300]}],
#		],
#		time_limit = [8,12],
#	},
#	fighters_slave_work_medium = {
#		code = 'fightersslave_work_medium',
#		name = tr("FIGHTERS_SLAVE_WORK_NAME"),
#		descript = tr("FIGHTERS_SLAVE_WORK_DESC"),
#		randomconditions = [
#			{code = 'slave_work',
#			mandatory_conditions = [],
#			condition_number = [1,2],
#			conditions = [
#
#				{use_once = true, code = 'class', function = 'range', range = [1,2], type = ['fighter','archer','rogue','sniper','knight']},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['physics_factor'], range = [2,4]},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['physics'], range = [30,60]},
#			],
#			work_time = [3,6], #days
#			},
#		],
#		unlockreqs = [],
#		reputation = [200,300],
#		rewards = [
#		[1, {code = 'gold', range = [300,500]}],
#		[1, {code = 'gear', material_grade = [['easy',1], ['medium',4], ['hard',1]], name = ['sword','spear','club','bow','chest_base_metal','legs_base_metal','chest_base_leather','legs_base_leather']}, {code = 'gold',range = [50,100]}],
#		],
#		time_limit = [10,15],
#	},
#	fighters_slave_work_hard = {
#		code = 'fighters_slave_work_hard',
#		name = tr("FIGHTERS_SLAVE_WORK_NAME"),
#		descript = tr("FIGHTERS_SLAVE_WORK_DESC"),
#		randomconditions = [
#			{code = 'slave_work',
#			mandatory_conditions = [],
#			condition_number = [2,3],
#			conditions = [
#
#				{use_once = true, code = 'class', function = 'range', range = [2,3], type = ['knight','sniper','paladin','watchdog']},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['physics_factor'], range = [4,5]},
#
#				{use_once = true, code = 'stat', function = 'range', operant = 'gte', type = ['physics'], range = [50,80]},
#			],
#			work_time = [5,8], #days
#			},
#		],
#		unlockreqs = [],
#		reputation = [350,550],
#		rewards = [
#		[1, {code = 'gold', range = [400,650]}],
#		[1, {code = 'gear', material_grade = [['easy',1], ['medium',4], ['hard',1]], name = ['sword','spear','club','bow','swordadv','spearadv','bowadv']}, {code = 'gold',range = [150,250]}],
#		],
#		time_limit = [12,18],
#	},
}

