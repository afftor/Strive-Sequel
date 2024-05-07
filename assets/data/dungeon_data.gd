extends Node

var dungeons = {
	
	dungeon_bandit_den = {
		code = 'dungeon_bandit_den',
		type = 'dungeon',
		name = 'bandit_den',
		classname = '',
		descript = tr("DUNGEON_BANDIT_DEN_DESC"),
		character_data = {
			chance_mod = 1.5,#increases base chance to get slave after combat by this if its not guaranteed
			races = [['local', 3], ['common',1]]
		},
		difficulty = 'easy',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		enemyarray = [["rats_easy", 0.5],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1], ['bandits_easy_boss2',1],['bandits_easy_boss',3]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], #list of future challenges to get to this room
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 8,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [5,6],
		
		main_route_length = [6,7], #remember that first and last rooms in route are effectively empty 
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [7,10], #random roll for every main/bonus rooms rounded
		
		
		#do not remove next ones - for they a used in generation
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			wood = {
				amount = [25,40],
				weight = 10,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			stone = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
		bgm = "dungeon",
		purchase_price = 100,
		affiliation = 'local', #defines character races and events
		events = [],
	},
	
	dungeon_bandit_fort = {
		code = 'dungeon_bandit_fort',
		type = 'dungeon',
		name = 'bandit_fort',
		classname = '',
		descript = tr("DUNGEON_BANDIT_FORT_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['fort1', 'fort2', 'fort3'],
		enemyarray =  [["bandits_assassin", 1],['bandits_medium', 1],['bandits_medium2', 1],['bandits_golem', 0.5],['bandits_ballista', 0.5]],
		final_enemy = [['bandits_medium_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 6,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [], 
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [],
			},
			event_dungeon_prisoner = {
				limit = 2,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [3,3], 
		base_room_stamina_cost = [7,10], 
		
		
		resources = ['woodiron','leatherthick','iron','steel','clothsilk','mithril'],
		gatherable_resources = {
			wood = {
				amount = [45,60],
				weight = 10,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			stone = {
				amount = [35,50],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			woodiron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
			
		bgm = "dungeon",
		gather_mod = [2,2.5],
		purchase_price = 200,
		affiliation = 'local', #defines character races and events
		events = [],
	},
	
	dungeon_undead_crypt = {
		code = 'dungeon_undead_crypt',
		type = 'dungeon',
		name = "crypt",
		classname = '',
		difficulty = 'medium',
		descript = tr("DUNGEON_UNDEAD_CRYPT_DESC"),
		character_data = {
			chance_mod = 0.7,
			races = [['common', 6], ['uncommon', 1]]
		},
		background_pool = ['crypt1', 'crypt2', 'crypt3', 'crypt4', 'crypt5'],
		enemyarray =  [["skeletons_easy", 1],['skeletons_easy2', 1],['skeletons_zombies', 1],['skeletons_zombies2', 1],['skeletons_lich', 0.5]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			crypt_find_bones = {
				limit = 0,
				weight = 3,
				floor_range = [0,0],
				icon = 'chest',
				events = ['crypt_find_bones'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 7,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,3], 
		base_room_stamina_cost = [7,10], 
		
		resources = ['bone','leather','boneancient','woodmagic','clothsilk','iron','mithril','bonedragon','leathermythic'],
		gatherable_resources = {
			stone = {
				amount = [45,60],
				weight = 10,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			bone = {
				amount = [35,50],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			boneancient = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
		bgm = "dungeon",
		purchase_price = 200,
		affiliation = 'local',
		events = [],
	},
	
	dungeon_goblin_cave = {
		code = 'dungeon_goblin_cave',
		type = 'dungeon',
		name = 'goblin_cave',
		classname = '',
		descript = tr("DUNGEON_GOBLIN_CAVE_DESC"),
		character_data = {
			chance_mod = 1.7,
			races = [["common", 1], ['local', 4], ['Goblin',5]]
		},
		background_pool = ['cave_1', 'cave_2', 'cave_3', 'cave_4', 'cave_5'],
		bgm = "dungeon",
		enemyarray =  [["rats_easy", 0.5],['spiders', 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		final_enemy = [['goblins_easy_boss1',1],['goblins_easy_boss2',1]], final_enemy_type = 'monster',
		
		eventarray = [['dungeon_find_chest_easy', 1],['event_trap_easy', 1],['event_goblin_friendly',0.3],['celena_shrine_find',0.5],['erebus_shrine_find',1],['freya_shrine_find',0.2]],
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			event_goblin_friendly = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['event_goblin_friendly'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 3,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.5],['erebus_shrine_find',1],['freya_shrine_find',0.2]],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [3,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,3], 
		base_room_stamina_cost = [6,9], 
		
		resources = ['bone','leather','stone','wood'],
		gatherable_resources = {
			stone = {
				amount = [45,60],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			bone = {
				amount = [35,50],
				weight = 3,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			leather = {
				amount = [15,25],
				weight = 4,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
		gather_mod = [2,2.5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
	},
	
	dungeon_grove = {
		code = 'dungeon_grove',
		type = 'dungeon',
		name = 'grove',
		classname = '',
		descript = tr("DUNGEON_GROVE_DESC"),
		character_data = {
			chance_mod = 0.8,
			races = [["common", 2], ['local', 4],['uncommon',1]]
		},
		purchase_area = 'forests',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		bgm = "dungeon",
		enemyarray = [["rats_easy", 0.5],['wolves_easy1', 1],['wolves_easy2', 1],['spiders', 1]],
		final_enemy = [['grove_easy_boss',1]], final_enemy_type = 'monster',
		
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			grove_find_leather = {
				limit = 0,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['grove_find_leather'],
				possible_challenges = [],
			},
			event_fairy_friendly = {
				limit = 1,
				weight = 3,
				floor_range = [0,0],
				icon = 'person',
				events = ['event_fairy_friendly'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1],['erebus_shrine_find',0.2],['freya_shrine_find',1]],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,3], 
		base_room_stamina_cost = [5,11], 
		
		resources = ['cloth','leather','woodmagic','wood','woodiron'],
		gatherable_resources = {
			meat = {
				amount = [90,120],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			wood = {
				amount = [60,90],
				weight = 8,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			woodmagic = {
				amount = [15,25],
				weight = 3,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			woodiron = {
				amount = [15,25],
				weight = 1,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
		gather_mod = [2,2.5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
	},
	
	dungeon_ancient_jungles = {
		code = 'dungeon_ancient_jungles',
		type = 'dungeon',
		name = 'ancient_jungle',
		classname = '',
		descript = tr("DUNGEON_ANCIENT_JUNGLES_DESC"),
		character_data = {
			chance_mod = 1.1,
			races = [["common", 2], ['uncommon', 4],['TribalElf',6], ['rare',1]]
		},
		purchase_area = 'forests',
		background_pool = ['jungle1','jungle2','jungle3','jungle4'],
		bgm = "dungeon",
		enemyarray = [['jungle_easy1', 1],['jungle_easy2', 1],['jungle_medium1', 1],['jungle_medium2', 1]],
		final_enemy = [['jungle_boss1',1],['jungle_boss2',1],['jungle_boss3',1]], final_enemy_type = 'monster',
		
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 8,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [], 
			},
			event_tribal_elves = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'person',
				events = ['event_tribal_elves'],
				possible_challenges = [],
			},
			spring = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['spring'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1], ['erebus_shrine_find',0.2], ['freya_shrine_find',0.5]],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [7,8],
		bonus_rooms = [2,4],
		levels = [3,4], 
		base_room_stamina_cost = [7,11], 
		
		resources = ['woodmagic','woodiron','leatherthick','leathermythic','insect_chitin','iron'],
		gatherable_resources = {
			woodmagic = {
				amount = [25,45],
				weight = 5,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			woodiron = {
				amount = [30,45],
				weight = 8,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			leatherthick = {
				amount = [20,35],
				weight = 4,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			leathermythic = {
				amount = [10,15],
				weight = 1,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			}, 
		
		
		gather_mod = [2.5,3.5],
		difficulty = 'medium',
		purchase_price = 500,
		affiliation = 'local',
		events = [],
	},
	
	dungeon_fire_depths = {
		code = 'dungeon_fire_depths',
		type = 'dungeon',
		name = "fire_depths",
		classname = '',
		descript = tr("DUNGEON_FIRE_DEPTHS_DESC"),
		character_data = {
			chance_mod = 1.0,
			races = [["common", 2], ['uncommon', 4],['rare',1]]
		},
		purchase_area = 'mountains',
		background_pool = ['fire_depths1', 'fire_depths2', 'fire_depths3', 'fire_depths4'],
		bgm = "dungeon",
		enemyarray = [['firedepths_easy1', 1],['firedepths_easy2', 1],['firedepths_medium1', 1],['firedepths_medium2', 1]],
		final_enemy = [['firedepths_boss1',1],['firedepths_boss2',1]], final_enemy_type = 'monster',
		eventarray = [['dungeon_find_chest_medium', 1], ['erebus_shrine_find',0.2]],
		
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 8,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [], 
			},
			erebus_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['erebus_shrine_find'],
				possible_challenges = [],
			}
		},
		
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,8],
		bonus_rooms = [3,4],
		levels = [3,4], 
		base_room_stamina_cost = [7,11], 
		
		
		resources = ['steel','mithril','obsidian','leatherthick','leather'],
		gatherable_resources = {
			iron = {
				amount = [40,70],
				weight = 8,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			mithril = {
				amount = [25,40],
				weight = 4,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			adamantine = {
				amount = [10,20],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			},
		gather_mod = [2.5,4],
		difficulty = 'hard',
		purchase_price = 500,
		affiliation = 'local',
		events = [],
	},
	
	quest_cali_bandits_location = {
		code = 'quest_cali_bandits_location',
		type = 'dungeon',
		name = tr("QUEST_CALI_BANDITS_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_CALI_BANDITS_LOCATION_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		enemyarray = [['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			wood = {
				amount = [25,40],
				weight = 10,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			stone = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			}, 
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		quest = true,
		options = [],
		events = [],
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [{trigger = 'enter', event = 'custom_event', args = 'cali_bandits_1', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'CALI_BANDITS_1'}]},
		{trigger = 'dungeon_complete', event = 'custom_event', args = 'cali_bandits_3', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'CALI_BANDITS_3'}]}]
	},
	
	quest_mines_dungeon = {
		code = 'quest_mines_dungeon',
		type = 'dungeon',
		name = tr("QUEST_MINES_DUNGEON_TEXT"),
		classname = '',
		descript = tr("QUEST_MINES_DUNGEON_DESC"),
		character_data = {
			chance_mod = 1.2,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'easy',
		background_pool = ['cave_1'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			stone = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			}, 
		gather_mod = [2.5,4],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		quest = true,

		area = 'plains',
		travel_time = [1,1],

		scripteventdata = [{trigger = 'enter', event = 'custom_event', args = 'mines_arrival_start', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'MINES_ARRIVAL_START'}]},
		{trigger = 'finish_combat', event = 'custom_event', args = 'half_dungeon_explored_start',reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'HALF_DUNGEON_EXPLORED_START'}, {code = 'stage', value = 10 / 2 - 1, operant = 'gte'}]},
		{trigger = 'finish_combat', event = 'custom_event', args = 'pre_final_boss_start',reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'PRE_FINAL_BOSS_START'}, {code = 'stage', value = 9 - 2, operant = 'gte'}]}]
	},
	
	quest_final_operation_location = {
		code = 'quest_final_operation_location',
		type = 'dungeon',
		name = tr("QUEST_FINAL_OPERATION_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_FINAL_OPERATION_LOCATION_DESC"),
		character_data = {
			chance_mod = 1,
			races = [['local', 3], ['common',3], ['uncommon',4], ['rare',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1'],
		enemyarray = [['betrayal_confirmed_rebels_1', 1],['betrayal_confirmed_rebels_2', 1],['rebels_small', 0.5]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [3,5],
		
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			stone = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			}, 
		gather_mod = [2.5,4], 
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		quest = true,

		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'enter', event = 'custom_event', args = 'initiate_hideout_attack', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'INITIATE_HIDEOUT_ATTACK_6'}]},
			# hard no mages help
			{trigger = 'finish_combat', event = 'custom_event', args = 'guild_attack_on_hideout_1',reqs = [
				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = false}, 
				{code = 'value_check', type = 'event_seen', check = false, value = 'guild_attack_on_hideout_1'}, 
				{code = 'stage', value = 3, operant = 'gte'}]},
			{trigger = 'finish_combat', event = 'custom_event', args = 'final_boss_start',reqs = [
				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = false},
				{code = 'stage', value = 7, operant = 'gte'}]},
			# easy with mages help
			{trigger = 'finish_combat', event = 'custom_event', args = 'guild_attack_on_hideout_1',reqs = [
				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = true}, 
				{code = 'value_check', type = 'event_seen', check = false, value = 'guild_attack_on_hideout_1'}, 
				{code = 'stage', value = 2, operant = 'gte'}]},
			{trigger = 'finish_combat', event = 'custom_event', args = 'final_boss_start',reqs = [
				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = true}, 
				{code = 'stage', value = 5, operant = 'gte'}]}
		]
	},
	
	quest_gryphon_forest_location = {
		code = 'quest_gryphon_forest_location',
		type = 'dungeon',
		name = tr("QUEST_GRYPHON_FOREST_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_GRYPHON_FOREST_LOCATION_DESC"),
		character_data = {
			chance_mod = 1,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['forest1'],
		enemyarray = [['jungle_easy1', 1],['jungle_easy2', 1],['jungle_medium1', 1]],
		final_enemy = [['jungle_boss3',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			celena_shrine_find = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [3,5],
		
		resources = ['clothmagic','leatherthick','iron','wood','clothsilk'],
		gatherable_resources = {
			wood = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			leather = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			},
		gather_mod = [2.5,4], 
		bgm = "exploration",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		quest = true,
		area = 'plains',
		travel_time = [1,1], 
		options = [],
		scripteventdata = [{trigger = 'enter', event = 'custom_event', args = 'gryphon_forest_start', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'GRYPHON_FOREST_START'}]},
		{trigger = 'dungeon_complete', event = 'custom_event', args = 'gryphon_forest_1', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'GRYPHON_FOREST_1'}]}]
	},
	
	quest_ritual_location = {
		code = 'quest_ritual_location',
		type = 'dungeon',
		name = tr("QUEST_RITUAL_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_RITUAL_LOCATION_DESC"),
		difficulty = 'easy',
		character_data = {
			chance_mod = 1,
			races = [['local', 3], ['common',5], ['uncommon',2]]
		},
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [], 
			},
			freya_shrine_find = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'shrine',
				events = [],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,3],
		material_room_number = [4,4],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [3,5],
		
		resources = ['clothmagic','leatherthick','woodiron','woodmagic','clothsilk'],
		gatherable_resources = {
			woodmagic = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			},
		gather_mod = [2.5,4],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [2,2],
		scripteventdata = [{trigger = 'enter', event = 'custom_event', args = 'pre_ritual_1', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'PRE_RITUAL_1'}]}],
	},
	
	quest_amelia_bandits_location = {
		code = 'quest_amelia_bandits_location',
		type = 'dungeon',
		name = tr("QUEST_AMELIA_BANDITS_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_AMELIA_BANDITS_LOCATION_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		enemyarray = [['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
		},
		
		event_room_number = [2,2],
		material_room_number = [1,1],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			}, 
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		quest = true,
		options = [],
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
		{trigger = 'dungeon_complete', event = 'custom_event', args = 'amelia_prison_1', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'AMELIA_PRISON_1'}]}]
	},
	
	quest_dungeon_grove = {
		code = 'quest_dungeon_grove',
		type = 'dungeon',
		name = tr("QUEST_DUNGEON_GROVE_TEXT"),
		classname = '',
		descript = tr("QUEST_DUNGEON_GROVE_DESC"),
		purchase_area = 'forests',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		bgm = "dungeon",
		enemyarray = [["rats_easy", 0.5],['wolves_easy1', 1],['wolves_easy2', 1],['spiders', 1]],
		final_enemy = [['grove_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], 
			},
			event_fairy_friendly = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_fairy_friendly'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = ['cloth','leather','woodmagic','wood','woodiron'],
		gatherable_resources = {
			meat = {
				amount = [90,120],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			wood = {
				amount = [60,90],
				weight = 8,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			woodmagic = {
				amount = [15,25],
				weight = 3,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			woodiron = {
				amount = [15,25],
				weight = 1,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			}, 
		
		gather_mod = [2,2.5],
		stages_per_level = [3,5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'dungeon_complete', event = 'custom_event', args = 'cali_act3_jean_3', reqs = [{code = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage6'}, {code = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage8', orflag = true}]}
		]
	},
	quest_ancient_jungle_location = {
		code = 'quest_ancient_jungle_location',
		type = 'dungeon',
		name = tr("QUEST_ANCIENT_JUNGLE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_ANCIENT_JUNGLE_LOCATION_DESC"),
		character_data = {
			chance_mod = 1.1,
			races = [["common", 2], ['uncommon', 4],['TribalElf',6], ['rare',1]]
		},
		purchase_area = 'forests',
		background_pool = ['jungle4'],
		enemyarray = [['jungle_easy1', 1],['jungle_easy2', 1],['jungle_medium1', 1],['jungle_medium2', 1]],
		final_enemy = [['jungle_boss1',1],['jungle_boss2',1],['jungle_boss3',1]], final_enemy_type = 'monster',
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 8,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [], 
			},
			event_tribal_elves = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'person',
				events = ['event_tribal_elves'],
				possible_challenges = [],
			},
			spring = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['spring'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1], ['erebus_shrine_find',0.2], ['freya_shrine_find',0.5]],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [2,3],
		
		main_route_length = [7,8],
		bonus_rooms = [2,4],
		levels = [2,2], 
		base_room_stamina_cost = [7,11], 
		
		resources = ['woodmagic','woodiron','leatherthick','leathermythic','insect_chitin','iron'],
		gatherable_resources = {
			woodmagic = {
				amount = [25,45],
				weight = 5,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			woodiron = {
				amount = [30,45],
				weight = 8,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			leatherthick = {
				amount = [20,35],
				weight = 4,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			leathermythic = {
				amount = [10,15],
				weight = 1,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},
			}, 
		
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		quest = true,

		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'dungeon_complete', event = 'custom_event', args = 'zephyra_brush_3', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'ZEPHYRA_BRUSH_3'}]}
		]
	},
	
	################### Old quest data with no dungeons
	
	quest_fighters_lich = {
		code = 'quest_fighters_lich',
		type = 'quest_location',
		name = tr("QUEST_FIGHTERS_LICH_TEXT"),
		area = 'plains',
		classname = '',
		descript = tr("QUEST_FIGHTERS_LICH_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = [],
		travel_time = [1,1],#[2,2],
	},
	quest_mages_xari = {
		code = 'quest_mages_xari',
		type = 'encounter',
		name = tr("QUEST_MAGES_XARI_TEXT"),
		area = 'plains',
		classname = '',
		descript = tr("QUEST_MAGES_XARI_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		travel_time = [1,1], #[3,3],
		events = [],
	},
	quest_mages_fred = {
		code = 'quest_mages_fred',
		type = 'encounter',
		name = tr("QUEST_MAGES_FRED_TEXT"),
		area = 'plains',
		classname = '',
		descript = tr("QUEST_MAGES_FRED_DESC"),
		difficulty = 'easy',
		background = 'cave_3',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		travel_time = [1,1],#[2,2],
		events = [],
	},

	basic_threat_wolves = {
		code = 'basic_threat_wolves',
		type = 'encounter',
		name = tr("BASIC_THREAT_WOLVES_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_WOLVES_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = [],
	},
	basic_threat_rebels = {
		code = 'basic_threat_rebels',
		type = 'encounter',
		name = tr("BASIC_THREAT_REBELS_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_REBELS_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = [],
	},
	basic_threat_goblins = {
		code = 'basic_threat_goblins',
		type = 'encounter',
		name = tr("BASIC_THREAT_GOBLINS_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_GOBLINS_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = []
	},
	basic_threat_ogre = {
		code = 'basic_threat_ogre',
		type = 'encounter',
		name = tr("BASIC_THREAT_OGRE_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_OGRE_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = [],
	},
	basic_threat_troll = {
		code = 'basic_threat_troll',
		type = 'encounter',
		name = tr("BASIC_THREAT_TROLL_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_TROLL_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = [],
	},
	quest_cali_village = {
		code = 'quest_cali_village',
		type = 'encounter',
		name = tr("QUEST_CALI_VILLAGE_TEXT"),
		classname = '',
		descript = tr("QUEST_CALI_VILLAGE_DESC"),
		difficulty = 'easy',
		background = 'village1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [1,1],
		events = [],
		area = 'plains',
		travel_time = [1,1],
	},
	quest_daisy_admirer_location = {
		code = 'quest_daisy_admirer_location',
		type = 'encounter',
		name = tr("QUEST_DAISY_ADMIRER_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_DAISY_ADMIRER_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['village1'],
		enemyarray = [['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		stages_per_level = [10,10],
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		quest = true,
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_gryphon_cave_location = {
		code = 'quest_gryphon_cave_location',
		type = 'encounter',
		name = tr("QUEST_GRYPHON_CAVE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_GRYPHON_CAVE_LOCATION_DESC"),
		character_data = {
			chance_mod = 1,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'easy',
		background_pool = ['cave_1'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, #temp items for the game to work
		gather_mod = [2.5,4], #temp mod for the game to work
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', #defines character races and events
		events = [],
		quest = true,
		area = 'plains',
		travel_time = [1,1], #[4,6],
		scripteventdata = []
	},
	quest_leon_forest = {
		code = 'quest_leon_forest',
		type = 'encounter',
		name = tr("QUEST_LEON_FOREST_TEXT"),
		classname = '',
		descript = tr("QUEST_LEON_FOREST_DESC"),
		character_data = {
			chance_mod = 1,
			races = [['local', 3], ['common',2], ['uncommon',5],['rare',1]]
		},
		difficulty = 'easy',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, #temp items for the game to work
		gather_mod = [2.5,4], #temp mod for the game to work
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', #defines character races and events
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [2,2],
		scripteventdata = [],
	},
	quest_cali_cave_location = {
		code = 'quest_cali_cave_location',
		type = 'encounter',
		name = tr("QUEST_CALI_CAVE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_CALI_CAVE_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['cave_1'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['bandit_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_leon_forest_2 = {
		code = 'quest_leon_forest_2',
		type = 'encounter',
		name = tr("QUEST_LEON_FOREST_2_TEXT"),
		classname = '',
		descript = tr("QUEST_LEON_FOREST_2_DESC"),
		difficulty = 'easy',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_white_stag_location = {
		code = 'quest_white_stag_location',
		type = 'encounter',
		name = tr("QUEST_WHITE_STAG_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_WHITE_STAG_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_temple_location = {
		code = 'quest_temple_location',
		type = 'encounter',
		name = tr("QUEST_TEMPLE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_TEMPLE_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_erlen_location = {
		code = 'quest_erlen_location',
		type = 'encounter',
		name = tr("QUEST_ERLEN_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_ERLEN_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_cali_goblins_location = {
		code = 'quest_cali_goblins_location',
		type = 'encounter',
		name = tr("QUEST_CALI_GOBLINS_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_CALI_GOBLINS_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['village1', 'village2', 'village3', 'village4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['bandits_medium_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_troll_cave_location = {
		code = 'quest_troll_cave_location',
		type = 'encounter',
		name = tr("QUEST_TROLL_CAVE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_TROLL_CAVE_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['cave_4'],
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'mountains',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_goblin_location = {
		code = 'quest_goblin_location',
		type = 'encounter',
		name = tr("QUEST_GOBLIN_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_GOBLIN_LOCATION_DESC"),
		difficulty = 'easy',
		background_pool = ['cave_4'],
		enemyarray = [['rebels_small', 1]],
		final_enemy = [], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = [],
		gatherable_resources = {number = [0,0], pool = {}}, 
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		quest = true,
		area = 'mountains',
		travel_time = [1,1],
		scripteventdata = []
	},
}
