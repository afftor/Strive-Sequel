extends Node
var infinite_dungeon_biomes = {
	biome_bandit_den = {
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		enemyarray = [["rats_easy", 0.5],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		character_data = {
			chance_mod = 1.5,#increases base chance to get slave after combat by this if its not guaranteed
			races = [['local', 3], ['common',1]]
		},
		event_room_number = [3,4],
		material_room_number = [5,6],
		main_route_length = [5,6], 
		bonus_rooms = [2,3],
		base_room_stamina_cost = [7,10],
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_den_res',
	},
	biome_bandit_fort = {
		background_pool = ['fort1', 'fort2', 'fort3'],
		enemyarray =  [["bandits_assassin", 1],['bandits_medium', 1],['bandits_medium2', 1],['bandits_golem', 0.5],['bandits_ballista', 0.5]],
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},

		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		base_room_stamina_cost = [7,10], 
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_fort_res'
	},
	biome_rebel_redoubt = {
		background_pool = ['fort1', 'fort2', 'fort3'],
		enemyarray =  [['event_rebels_1', 1],['event_rebels_2', 1],['rebels_small', 0.5]],
		character_data = {
			chance_mod = 1.2,
			races = [['local', 6], ['common',1]]
		},
		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [6,7],
		bonus_rooms = [2,3], 
		base_room_stamina_cost = [7,10], 
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_fort_res',
	},
	biome_undead_crypt = {
		background_pool = ['crypt1', 'crypt2', 'crypt3', 'crypt4', 'crypt5'],
		enemyarray =  [["skeletons_easy", 1],['skeletons_easy2', 1],['skeletons_zombies', 1],['skeletons_zombies2', 1],['skeletons_lich', 0.5]],
		character_data = {
			chance_mod = 0.7,
			races = [['common', 6], ['uncommon', 1]]
		},
		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		base_room_stamina_cost = [7,10], 
		gather_settings = 'base',
		gatherable_resources = 'biome_undead_crypt_res',
	},
	biome_goblin_cave = {
		background_pool = ['cave_1', 'cave_2', 'cave_3', 'cave_4', 'cave_5'],
		enemyarray =  [["rats_easy", 0.5],['spiders', 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		character_data = {
			chance_mod = 1.4,
			races = [["common", 1], ['local', 4], ['Goblin',5]]
		},
		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [5,6],
		bonus_rooms = [2,3],
		base_room_stamina_cost = [6,9],
		gather_settings = 'base',
		gatherable_resources = 'biome_goblin_cave_res',
	},
	biome_grove = {
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		enemyarray = [["rats_easy", 0.5],['wolves_easy1', 1],['wolves_easy2', 1],['spiders', 1]],
		character_data = {
			chance_mod = 0.8,
			races = [["common", 2], ['local', 4],['uncommon',1]]
		},
		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [5,6],
		bonus_rooms = [2,3],
		base_room_stamina_cost = [5,11], 
		gather_settings = 'base',
		gatherable_resources = 'biome_grove_res',
	},
	biome_ancient_jungles = {
		background_pool = ['jungle1','jungle2','jungle3','jungle4'],
		enemyarray = [['jungle_easy1', 1],['jungle_easy2', 1],['jungle_medium1', 1],['jungle_medium2', 1]],
		character_data = {
			chance_mod = 1.1,
			races = [["common", 2], ['uncommon', 4],['TribalElf',6], ['rare',1]]
		},
		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [6,7],
		bonus_rooms = [2,4],
		base_room_stamina_cost = [7,11],
		gather_settings = 'base',
		gatherable_resources = 'biome_ancient_jungles_res',
	},
	biome_fire_depths = {
		background_pool = ['fire_depths1', 'fire_depths2', 'fire_depths3', 'fire_depths4'],
		enemyarray = [['firedepths_easy1', 1],['firedepths_easy2', 1],['firedepths_medium1', 1],['firedepths_medium2', 1]],
		character_data = {
			chance_mod = 1.0,
			races = [["common", 2], ['uncommon', 4],['rare',1]]
		},
		event_room_number = [3,4],
		material_room_number = [4,5],
		main_route_length = [6,8],
		bonus_rooms = [3,4],
		base_room_stamina_cost = [7,11],
		gather_settings = 'base',
		gatherable_resources = 'biome_fire_depths_res',
	},
	biome_goblin_stronghold = {
		background_pool = ['cave_1', 'cave_4', 'cave_5'],
		enemyarray =  [["goblin_stronghold_easy", 1],['goblin_stronghold_easy1', 1],['goblin_stronghold_tormentor', 0.5],['goblin_stronghold_tormentor1', 0.5],['goblin_stronghold_vulture', 0.5]],
		character_data = {
			chance_mod = 1.4,
			races = [['local', 3], ['common',4], ['uncommon',2]]
		},
		event_room_number = [2,4],
		material_room_number = [4,5],
		main_route_length = [6,7],
		bonus_rooms = [3,4],
		base_room_stamina_cost = [7,10], 
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_fort_res'
	},
}
var dungeons = {
	infinite_aliron = {
		code = 'dungeon_infinite_example',
		type = 'dungeon',
		name = tr('INFINITEDUNGEONNAME'),
		altname = tr('INFINITEDUNGEONNAME'),
		classname = '',
		descript = tr("DUNGEON_BANDIT_DEN_DESC"),
		character_data = {
			chance_mod = 0.7,#increases base chance to get slave after combat by this if its not guaranteed
			races = [['local', 3], ['common',1]]
		},
		difficulty = 'easy',
#		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
#		enemyarray = [["rats_easy", 0.5],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
#		final_enemy = [], final_enemy_type = 'monster', final_enemy_class = ['combat'],
		travel_time = [1,1],
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 8,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [5,6],
		
		main_route_length = [5,6], #remember that first and last rooms in route are effectively empty 
		bonus_rooms = [2,3],
		levels = [1,1], 
		base_room_stamina_cost = [7,10], #random roll for every main/bonus rooms rounded
		
		
		#do not remove next ones - for they a used in generation
		resources = 'local1',
		bgm = "tower",
		purchase_price = 100,
		affiliation = 'local', #defines character races and events
		events = [],
		area = 'plains',
		tags = ['infinite'],
		biomes = [],#['test_biome1', 'test_biome2', 'test_biome2', 'test_biome1'], #fixed order of first levels
		avaliable_biomes = ['biome_bandit_den', 'biome_bandit_fort', 'biome_rebel_redoubt', 'biome_undead_crypt', 'biome_goblin_cave', 'biome_grove', 'biome_ancient_jungles', 'biome_fire_depths']
	},
	
	
	
	dungeon_bandit_den = {
		code = 'dungeon_bandit_den',
		type = 'dungeon',
		name = 'bandit_den',
		classname = '',
		descript = tr("DUNGEON_BANDIT_DEN_DESC"),
		character_data = {
			chance_mod = 1.2,#increases base chance to get slave after combat by this if its not guaranteed
			races = [['local', 3], ['common',1]]
		},
		difficulty = 'easy',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [["rats_easy", 0.5],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1], ['bandits_easy_boss2',1],['bandits_easy_boss3',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 8,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [5,6],
		
		main_route_length = [5,6], #remember that first and last rooms in route are effectively empty 
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [7,10], #random roll for every main/bonus rooms rounded
		
		
		#do not remove next ones - for they a used in generation
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_den_res',
		bgm = "dungeon",
		purchase_price = 100,
		affiliation = 'local', #defines character races and events
		events = [],
		tags = [],
	},
	
	dungeon_bandit_fort = {
		code = 'dungeon_bandit_fort',
		type = 'dungeon',
		name = 'bandit_fort',
		classname = '',
		descript = tr("DUNGEON_BANDIT_FORT_DESC"),
		character_data = {
			chance_mod = 1.2,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['fort1', 'fort2', 'fort3'],
		custom_background = 'combat_fort',
		enemyarray =  [["bandits_assassin", 1],['bandits_medium', 1],['bandits_medium2', 1],['bandits_golem', 0.5],['bandits_ballista', 0.5]],
		final_enemy = [['bandits_jarl_boss',0.7], ['bandits_hunter_boss',1], ['bandits_warlock_boss',0.5]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 6,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.1],
					['event_small_crack',1]
				],
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.2],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 2,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.2],
					['event_small_crack',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1]
				],
			},
			fountain = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'man',
				events = ['fountain'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.8]
				],
			},
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,3], 
		base_room_stamina_cost = [7,10], 
		
		
		resources = 'local2',
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_fort_res',
		
		bgm = "dungeon",
		gather_mod = [2,2.5],
		purchase_price = 200,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	dungeon_rebel_redoubt = {
		code = 'dungeon_rebel_redoubt',
		type = 'dungeon',
		name = 'bandit_fort',
		classname = '',
		descript = tr("DUNGEON_BANDIT_FORT_DESC"),
		character_data = {
			chance_mod = 1,
			races = [['local', 6], ['common',1]]
		},
		difficulty = 'medium',
		background_pool = ['fort1', 'fort2', 'fort3'],
		custom_background = 'combat_fort',
		enemyarray =  [['event_rebels_1', 1],['event_rebels_2', 1],['rebels_small', 0.5]],
		final_enemy = [['rebels_boss',1], ['rebels_sergeant_boss',1], ['rebels_castellan_boss',0.5]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 6,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.1],
					['event_small_crack',1]
				],
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.2],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 2,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.2],
					['event_small_crack',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1]
				],
			},
			fountain = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'man',
				events = ['fountain'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.8]
				],
			},
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,3], 
		base_room_stamina_cost = [7,10], 
		
		
		resources = 'local2',
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_fort_res',
		
		bgm = "dungeon",
		gather_mod = [2,2.5],
		purchase_price = 200,
		affiliation = 'local',
		events = [],
		tags = [],
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
		custom_background = 'combat_crypt',
		enemyarray =  [["skeletons_easy", 1],['skeletons_easy2', 1],['skeletons_zombies', 1],['skeletons_zombies2', 1],['skeletons_lich', 0.5]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			crypt_find_bones = {
				limit = 0,
				weight = 3,
				floor_range = [0,0],
				icon = 'chest',
				events = ['crypt_find_bones'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1]
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 7,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1]
				],
			},
			fountain = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'man',
				events = ['fountain'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.8]
				],
			},
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,3],
		levels = [2,3], 
		base_room_stamina_cost = [7,10], 
		
		resources = 'local3',
		gather_settings = 'base',
		gatherable_resources = 'biome_undead_crypt_res',
		bgm = "dungeon",
		purchase_price = 200,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	dungeon_goblin_cave = {
		code = 'dungeon_goblin_cave',
		type = 'dungeon',
		name = 'goblin_cave',
		classname = '',
		descript = tr("DUNGEON_GOBLIN_CAVE_DESC"),
		character_data = {
			chance_mod = 1.1,
			races = [["common", 1], ['local', 4], ['Goblin',5]]
		},
		background_pool = ['cave_1', 'cave_2', 'cave_3', 'cave_4', 'cave_5'],
		custom_background = 'combat_cave',
		bgm = "dungeon",
		enemyarray =  [["rats_easy", 0.5],['spiders', 0.2],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		final_enemy = [['goblins_easy_boss1',1],['goblins_easy_boss2',1]], final_enemy_type = 'monster',
		
		eventarray = [['dungeon_find_chest_easy', 1],['event_goblin_friendly',0.3],['celena_shrine_find',0.5],['erebus_shrine_find',1],['freya_shrine_find',0.2]],
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1],
				],
			},
			event_goblin_friendly = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['event_goblin_friendly'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 3,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.4],['erebus_shrine_find',1],['hybris_shrine_find',0.8],['freya_shrine_find',0.2]],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1],
				],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [5,6],
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [6,9], 
		
		resources = 'local4',
		gather_settings = 'base',
		gatherable_resources = 'biome_goblin_cave_res',
		gather_mod = [2,2.5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	dungeon_grove = {
		code = 'dungeon_grove',
		type = 'dungeon',
		name = 'grove',
		classname = '',
		descript = tr("DUNGEON_GROVE_DESC"),
		character_data = {
			chance_mod = 0.7,
			races = [["common", 2], ['local', 4],['uncommon',1]]
		},
		purchase_area = 'forests',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		custom_background = 'combat_forest',
		bgm = "dungeon",
		enemyarray = [["rats_easy", 0.3],['wolves_easy1', 1],['grove_1', 1],['grove_2', 1],['spiders', 0.5]],
		final_enemy = [['grove_easy_boss',1], ['grove_wolf_boss',1]], final_enemy_type = 'monster',
		
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
				],
			},
			grove_find_leather = {
				limit = 0,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['grove_find_leather'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
				],
			},
			event_fairy_friendly = {
				limit = 1,
				weight = 3,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_fairy_friendly'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1],['erebus_shrine_find',0.2],['freya_shrine_find',1],['hybris_shrine_find',0.5]],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
				],
			},
#			lira_lost_event = {
#				limit = 1,
#				weight = 57,#75% chance
#				floor_range = [0,0],
#				icon = 'man',
#				events = ['lira_lost_start'],
#				possible_challenges = [],
#			},
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [5,6],
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [5,11], 
		
		resources = 'local5',
		gather_settings = 'base',
		gatherable_resources = 'biome_grove_res',
		
		gather_mod = [2,2.5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	dungeon_spider_lair = {
		code = 'dungeon_spider_lair',
		type = 'dungeon',
		name = 'spider_lair',
		classname = '',
		descript = tr("DUNGEON_GROVE_DESC"),
		character_data = {
			chance_mod = 0.5,
			races = [["common", 2], ['local', 4],['uncommon',1]]
		},
		purchase_area = 'forests',
		background_pool = ['spider_lair1', 'spider_lair2', 'spider_lair3', 'spider_lair4'],
		custom_background = 'combat_forest',
		bgm = "dungeon",
		enemyarray = [['spiders2', 1],['spiders3', 0.8],['spiders_many', 0.4],['spiders_many2', 0.5]],
		final_enemy = [['spiders_alfa_boss',1], ['spiders_queen_boss',1]], final_enemy_type = 'monster',
		
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1],['erebus_shrine_find',0.2],['freya_shrine_find',0.2],['hybris_shrine_find',0.5]],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
				],
			},
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [5,6],
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [5,11], 
		
		resources = 'local5',
		gather_settings = 'base',
		gatherable_resources = 'biome_grove_res',
		
		gather_mod = [2,2.5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	dungeon_rebel_camp = {
		code = 'dungeon_rebel_camp',
		type = 'dungeon',
		name = 'rebel_camp',
		classname = '',
		descript = tr("DUNGEON_REBEL_CAMP_DESC"),
		character_data = {
			chance_mod = 1,
			races = [['local', 3], ['common',3], ['uncommon',4], ['rare',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1','cave_2','cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 0.5]],
		final_enemy = [['final_boss_start',1]], final_enemy_type = 'event',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [5,6],
		bonus_rooms = [2,3],
		levels = [2,2], 
		base_room_stamina_cost = [5,11], 
		
		resources = 'local5',
		gather_settings = 'base',
		gatherable_resources = 'dungeon_rebel_camp_res',
		
		gather_mod = [2.5,4], 
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],

		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
		]
	},
	
	dungeon_ancient_jungles = {
		code = 'dungeon_ancient_jungles',
		type = 'dungeon',
		name = 'ancient_jungle',
		classname = '',
		descript = tr("DUNGEON_ANCIENT_JUNGLES_DESC"),
		character_data = {
			chance_mod = 1,
			races = [["common", 2], ['uncommon', 4],['TribalElf',6], ['rare',1]]
		},
		purchase_area = 'forests',
		background_pool = ['jungle1','jungle2','jungle3','jungle4'],
		custom_background = 'combat_jungle',
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
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			event_tribal_elves = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_tribal_elves'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			spring = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['spring'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1], ['erebus_shrine_find',0.2], ['freya_shrine_find',0.5],['hybris_shrine_find',0.3]],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [2,4],
		levels = [3,4], 
		base_room_stamina_cost = [7,11], 
		
		resources = 'local6',
		gather_settings = 'base',
		gatherable_resources = 'biome_ancient_jungles_res',
		
		gather_mod = [2.5,3.5],
		difficulty = 'medium',
		purchase_price = 500,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	dungeon_fire_depths = {
		code = 'dungeon_fire_depths',
		type = 'dungeon',
		name = "fire_depths",
		classname = '',
		descript = tr("DUNGEON_FIRE_DEPTHS_DESC"),
		character_data = {
			chance_mod = 0.8,
			races = [["common", 2], ['uncommon', 4],['rare',1]]
		},
		purchase_area = 'mountains',
		background_pool = ['fire_depths1', 'fire_depths2', 'fire_depths3', 'fire_depths4'],
		custom_background = 'combat_volcano',
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
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			erebus_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['erebus_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			fountain = { #probably replace later
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'man',
				events = ['fountain'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.8]
				],
			}
		},
		
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [6,8],
		bonus_rooms = [3,4],
		levels = [3,4], 
		base_room_stamina_cost = [7,11], 
		
		
		resources = 'local7',
		gather_settings = 'base',
		gatherable_resources = 'biome_fire_depths_res',
		
		gather_mod = [2.5,4],
		difficulty = 'hard',
		purchase_price = 500,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	dungeon_goblin_stronghold = {
		code = 'dungeon_goblin_stronghold',
		type = 'dungeon',
		name = 'goblin_stronghold',
		classname = '',
		descript = tr("DUNGEON_GOBLIN_STRONHOLD_DESC"),
		character_data = {
			chance_mod = 1.1,
			races = [['local', 2], ['common',2], ['uncommon',2], ['rare',1]]
		},
		difficulty = 'medium',
		background_pool = ['goblin_stronghold1', 'goblin_stronghold1', 'goblin_stronghold1'],
		custom_background = 'combat_fort',
		enemyarray =  [["goblin_stronghold_easy", 1],['goblin_stronghold_easy1', 1],['goblin_stronghold_tormentor', 0.5],['goblin_stronghold_tormentor1', 0.5],['goblin_stronghold_vulture', 0.5]],
		final_enemy = [['goblin_stronghold_warlord_boss',1], ['goblin_stronghold_alchemist_boss',0.7], ['goblin_stronghold_battle_troll_boss',0.5]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 4,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.1],
					['event_small_crack',1]
				],
			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.2],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 2,
				weight = 6,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',0.2],
					['event_small_crack',1],
				],
			},
		},
		
		event_room_number = [2,4],
		material_room_number = [4,5],
		
		main_route_length = [6,7],
		bonus_rooms = [3,4],
		levels = [2,3], 
		base_room_stamina_cost = [7,10], 
		
		
		resources = 'local2',
		gather_settings = 'base',
		gatherable_resources = 'biome_goblin_stronghold_res',
		
		bgm = "dungeon",
		gather_mod = [2,2.5],
		purchase_price = 200,
		affiliation = 'local',
		events = [],
		tags = [],
	},
	
	quest_cali_bandits_location = {
		code = 'quest_cali_bandits_location',
		type = 'dungeon',
		name = tr("QUEST_CALI_BANDITS_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_CALI_BANDITS_LOCATION_DESC"),
		character_data = {
			chance_mod = 1.1,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			}
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'biome_bandit_den_res',
		
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		tags = ['quest'],
		options = [],
		events = [],
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'enter', args = 'cali_bandits_1'},
			{trigger = 'dungeon_complete', args = 'cali_bandits_3'}]
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
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['pre_final_boss_start',1]], final_enemy_type = 'event',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'dungeon_rebel_camp_res',
		
		gather_mod = [2.5,4],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],

		area = 'plains',
		travel_time = [1,1],

		scripteventdata = [
			{trigger = 'enter', args = 'mines_arrival_start'},
			{trigger = 'stage', event = 'custom_event', args = 'half_dungeon_explored_start', stage = 'half'},
#			{trigger = 'stage', event = 'custom_event', args = 'pre_final_boss_start', stage = '-1'}
		]
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
		custom_background = 'combat_cave',
		enemyarray = [['event_rebels_1', 1],['event_rebels_2', 1],['rebels_small', 0.5]],
		final_enemy = [['final_boss_start',1]], final_enemy_type = 'event',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
				],
			},
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [8,8],
		bonus_rooms = [1,1],
		levels = [1,1], 
		base_room_stamina_cost = [3,5],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'dungeon_rebel_camp_res',
		
		gather_mod = [2.5,4], 
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],

		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [ #2fix all, possibly add functional
			{trigger = 'enter', args = 'initiate_hideout_attack'},
			{trigger = 'stage', args = 'guild_attack_on_hideout_1', stage = 'half'},
			# hard no mages help
#			{trigger = 'finish_combat', args = 'guild_attack_on_hideout_1', reqs = [
#				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = false}, 
#				{code = 'value_check', type = 'event_seen', check = false, value = 'guild_attack_on_hideout_1'}, 
#				{code = 'stage', value = 3, operant = 'gte'}]},
#			{trigger = 'finish_combat', event = 'custom_event', args = 'final_boss_start',reqs = [
#				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = false},
#				{code = 'stage', value = 7, operant = 'gte'}]},
#			# easy with mages help
#			{trigger = 'finish_combat', event = 'custom_event', args = 'guild_attack_on_hideout_1',reqs = [
#				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = true}, 
#				{code = 'value_check', type = 'event_seen', check = false, value = 'guild_attack_on_hideout_1'}, 
#				{code = 'stage', value = 2, operant = 'gte'}]},
#			{trigger = 'finish_combat', event = 'custom_event', args = 'final_boss_start',reqs = [
#				{code = 'value_check', type = 'decision', value = 'MagesHelpDuncan', check = true}, 
#				{code = 'stage', value = 5, operant = 'gte'}]}
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
		custom_background = 'combat_forest',
		enemyarray = [['jungle_easy1', 1],['jungle_easy2', 1],['jungle_medium1', 1]],
		final_enemy = [['jungle_boss3',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find','hybris_shrine_find'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			}
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [3,5],
		
		resources = 'local8',
		gather_settings = 'base',
		gatherable_resources = 'quest_gryphon_forest_res',
		
		gather_mod = [2.5,4], 
		bgm = "exploration",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		area = 'plains',
		travel_time = [1,1], 
		options = [],
		scripteventdata = [
			{trigger = 'enter', args = 'gryphon_forest_start'},
			{trigger = 'dungeon_complete', args = 'gryphon_forest_1'}
		]
	},
	
#	quest_ritual_location = {
#		code = 'quest_ritual_location',
#		type = 'dungeon',
#		name = tr("QUEST_RITUAL_LOCATION_TEXT"),
#		classname = '',
#		descript = tr("QUEST_RITUAL_LOCATION_DESC"),
#		difficulty = 'easy',
#		character_data = {
#			chance_mod = 1,
#			races = [['local', 3], ['common',5], ['uncommon',2]]
#		},
#		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
#		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
#		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
#		event_data = {
#			dungeon_find_chest_medium = {
#				limit = 0,
#				weight = 10,
#				floor_range = [0,0],
#				icon = 'chest',
#				events = ['dungeon_find_chest_medium'],
#				possible_challenges = [
#					['event_locked_door',1],
#					['event_blocked_path',1],
#					['event_magic_barrier',1],
#					['event_fallen_bridge',1],
#					['event_small_crack',1],
#					['event_ancient_lock',1]
#				],
#			},
#			freya_shrine_find = {
#				limit = 1,
#				weight = 1,
#				floor_range = [0,0],
#				icon = 'shrine',
#				events = [],
#				possible_challenges = [
#					['event_locked_door',1],
#					['event_blocked_path',1],
#					['event_magic_barrier',1],
#					['event_fallen_bridge',1],
#					['event_small_crack',1],
#					['event_ancient_lock',1]
#				],
#			}
#		},
#
#		event_room_number = [3,3],
#		material_room_number = [4,4],
#
#		main_route_length = [6,7],
#		bonus_rooms = [2,3],
#		levels = [2,2], 
#		base_room_stamina_cost = [3,5],
#
#		resources = ['clothmagic','leatherthick','woodiron','woodmagic','clothsilk'],
#		gatherable_resources = {
#			woodmagic = {
#				amount = [25,40],
#				weight = 6,
#				gather_mod = [2,2.5],
#				stamina = [5,10],
#				},
#			iron = {
#				amount = [15,25],
#				weight = 2,
#				gather_mod = [2,2.5],
#				stamina = [5,10],
#				},
#			},
#		gather_mod = [2.5,4],
#		bgm = "dungeon",
#		purchase_price = 0,
#		affiliation = 'local', 
#		events = [],
#		tags = ['quest'],
#		area = 'forests',
#		travel_time = [2,2],
#		scripteventdata = [{trigger = 'enter', args = 'pre_ritual_1'}],
#	},
#
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
		custom_background = 'combat_cave',
		enemyarray = [['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1],
				],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [
					['event_locked_door',1],
					['event_blocked_path',1],
					['event_small_crack',1],
				],
			},
		},
		
		event_room_number = [2,2],
		material_room_number = [1,1],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'quest_amelia_bandits_res',
		
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		options = [],
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
		{trigger = 'dungeon_complete', args = 'amelia_prison_1'}]
	},
	
	quest_dungeon_cali_grove = {
		code = 'quest_dungeon_cali_grove',
		type = 'dungeon',
		name = tr("QUEST_DUNGEON_GROVE_TEXT"),
		classname = '',
		descript = tr("QUEST_DUNGEON_GROVE_DESC"),
		purchase_area = 'forests',
		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
		custom_background = 'combat_forest',
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
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
				],
			},
			event_fairy_friendly = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_fairy_friendly'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
				],
			}
		},
		
		event_room_number = [2,2],
		material_room_number = [2,2],
		
		main_route_length = [6,7],
		bonus_rooms = [2,2],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = 'local5',
		gather_settings = 'base',
		gatherable_resources = 'biome_grove_res',
		
		gather_mod = [2,2.5],
		stages_per_level = [3,5],
		difficulty = 'easy',
		purchase_price = 100,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'dungeon_complete', event = 'custom_event', args = 'cali_act3_jean_3', reqs = [{type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage6'}, {type = 'active_quest_stage', value = 'cali_taming_quest', stage = 'stage8', orflag = true}]}
		]
	},
	quest_zephyra_jungle_location = {
		code = 'quest_zephyra_jungle_location',
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
		custom_background = 'combat_jungle',
		enemyarray = [['jungle_easy1', 1],['jungle_easy2', 1],['jungle_medium1', 1],['jungle_medium2', 1]],
		final_enemy = [['jungle_boss1',1],['jungle_boss2',1],['jungle_boss3',1]], final_enemy_type = 'monster',
		
		event_data = {
			dungeon_find_chest_medium = {
				limit = 0,
				weight = 8,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_medium'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			event_tribal_elves = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_tribal_elves'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			spring = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['spring'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1], ['erebus_shrine_find',0.2], ['freya_shrine_find',0.5]],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [2,3],
		
		main_route_length = [7,8],
		bonus_rooms = [2,4],
		levels = [2,2], 
		base_room_stamina_cost = [7,11], 
		
		resources = 'local6',
		gather_settings = 'base',
		gatherable_resources = 'biome_ancient_jungles_res',
		
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		difficulty = 'medium',
		
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'dungeon_complete', args = 'zephyra_brush_3'}
		]
	},
#	quest_elven_ancient_jungle_location = {
#		code = 'quest_elven_ancient_jungle_location',
#		type = 'dungeon',
#		name = tr("QUEST_ELVEN_ANCIENT_JUNGLE_LOCATION_TEXT"),
#		classname = '',
#		descript = tr("QUEST_ELVEN_ANCIENT_JUNGLE_LOCATION_DESC"),
#		character_data = {
#			chance_mod = 1,
#			races = [['local', 3], ['common',3], ['uncommon',4], ['rare',1]]
#		},
#		difficulty = 'medium',
#		background_pool = ['cave_1'],
#		enemyarray = [['event_rebels_1', 1],['event_rebels_2', 1],['rebels_small', 0.5]],
#		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
#		eventarray = [],
#		levels = [1,1],
#		resources = '',
#		#gatherable_resources = {},
#		#gather_mod = [],
#		gatherable_resources = {number = [0,0], pool = {}}, #temp items for the game to work
#		gather_mod = [2.5,4], #temp mod for the game to work
#		stages_per_level = [10,10],
#		bgm = "dungeon",
#		purchase_price = 0,
#		affiliation = 'local', #defines character races and events
#		events = [],
#		quest = true,
#
#		area = 'forests',
#		travel_time = [1,1],#[4,6],
#		scripteventdata = [
#			{trigger = 'dungeon_complete', event = 'custom_event', args = 'lilia_finale_3', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'LILIA_FINALE_WORKERS_2'}]}
#		]
#	},
#	quest_lilia_dungeon_grove = {
#		code = 'quest_lilia_dungeon_grove',
#		type = 'dungeon',
#		name = tr("QUEST_LILIA_DUNGEON_GROVE_TEXT"),
#		classname = '',
#		descript = tr("QUEST_LILIA_DUNGEON_GROVE_DESC"),
#		purchase_area = 'forests',
#		background_pool = ['forest1','forest2', 'forest3', 'forest4'],
#		bgm = "dungeon",
#		enemyarray = [["rats_easy", 0.5],['wolves_easy1', 1],['wolves_easy2', 1],['spiders', 1]],
#		final_enemy = [['grove_easy_boss',1]], final_enemy_type = 'monster',
#		eventarray = [['dungeon_find_chest_easy', 1],['grove_find_wood',1],['grove_find_leather',0.5],['event_fairy_friendly', 0.5],['celena_shrine_find',0.1],['erebus_shrine_find',0.2],['freya_shrine_find',1]],
#		levels = [2,4],
#		resources = 'local5',
#		gatherable_resources = {number = [2,3], pool = {meat = [150,250], wood = [50,100], woodmagic = [15,25], woodiron = [15,25]}},
#		gather_mod = [2,2.5],
#		stages_per_level = [3,5],
#		difficulty = 'easy',
#		purchase_price = 100,
#		affiliation = 'local',
#		events = [],
#		quest = true,
#		area = 'plains',
#		travel_time = [1,1],
#		scripteventdata = [
#			{trigger = 'dungeon_complete', event = 'custom_event', args = 'lilith_finish_dungeon_1', reqs = [{code = 'active_quest_stage', value = 'lilia_finale_quest', stage = 'stage5'}]}
#		]
#	},

#	quest_patron_ancient_jungle_location = {
#		code = 'quest_patron_ancient_jungle_location',
#		type = 'dungeon',
#		name = tr("QUEST_PATRON_ANCIENT_JUNGLE_LOCATION_TEXT"),
#		classname = '',
#		descript = tr("QUEST_PATRON_ANCIENT_JUNGLE_LOCATION_DESC"),
#		character_data = {
#			chance_mod = 1,
#			races = [['local', 3], ['common',3], ['uncommon',4], ['rare',1]]
#		},
#		difficulty = 'medium',
#		background_pool = ['cave_1'],
#		enemyarray = [['event_rebels_1', 1],['event_rebels_2', 1],['rebels_small', 0.5]],
#		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
#		eventarray = [],
#		levels = [1,1],
#		resources = '',
#		#gatherable_resources = {},
#		#gather_mod = [],
#		gatherable_resources = {number = [0,0], pool = {}}, #temp items for the game to work
#		gather_mod = [2.5,4], #temp mod for the game to work
#		stages_per_level = [10,10],
#		bgm = "dungeon",
#		purchase_price = 0,
#		affiliation = 'local', #defines character races and events
#		events = [],
#		quest = true,
#
#		area = 'forests',
#		travel_time = [1,1],#[4,6],
#		scripteventdata = [
#			{trigger = 'dungeon_complete', event = 'custom_event', args = 'lilith_finish_new_dungeon', reqs = []}
#		]
#	},
	
	################### Old quest data with no dungeons
	quest_fighters_lich = {
		code = 'quest_fighters_lich',
		type = 'dungeon',
		name = tr("QUEST_FIGHTERS_LICH_TEXT"),
		classname = '',
		descript = tr("QUEST_FIGHTERS_LICH_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['tutorial_lich_fight', 1]],
		final_enemy = [['lich_enc_initiate',1]], final_enemy_type = 'event',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
				],
			},
		},
		
		event_room_number = [1,1],
		material_room_number = [1,1],
		
		main_route_length = [3,3],
		bonus_rooms = [0,0],
		levels = [1,1], 
		base_room_stamina_cost = [5,5],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'quest_fighters_lich_res',
		
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		options = [],
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
		{trigger = '', args = ''}]
	},
	
#	quest_fighters_lich = {
#		code = 'quest_fighters_lich',
#		type = 'quest_location',
#		name = tr("QUEST_FIGHTERS_LICH_TEXT"),
#		area = 'plains',
#		classname = '',
#		descript = tr("QUEST_FIGHTERS_LICH_DESC"),
#		difficulty = 'easy',
#		background = 'cave_1',
#		enemyarray =  [],
#		eventarray = [],
#		levels = [1,1],
#		resources = '',
#		stages_per_level = [1,1],
#		events = [],
#		travel_time = [1,1],#[2,2],
#	},
	quest_mages_xari = {
		code = 'quest_mages_xari',
		type = 'encounter',
		name = tr("QUEST_MAGES_XARI_TEXT"),
		area = 'plains',
		classname = '',
		descript = tr("QUEST_MAGES_XARI_DESC"),
		difficulty = 'easy',
		background = 'xari_hut',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		travel_time = [1,1], #[3,3],
		events = [],
		tags = ['quest'],
	},
	quest_rebels_backrooms = {
		code = 'quest_rebels_backrooms',
		type = 'encounter',
		name = tr("QUEST_REBEL_BACKROOMS"),
		area = 'plains',
		classname = '',
		descript = tr("QUEST_REBEL_BACKROOMSDESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		travel_time = [1,1], #[3,3],
		events = [],
		tags = ['quest'],
	},
	quest_ritual_location = {
		code = 'quest_ritual_location',
		type = 'encounter',
		name = tr("QUEST_RITUAL_LOCATION_TEXT"),
		area = 'forests',
		classname = '',
		descript = tr("QUEST_RITUAL_LOCATION_DESC"),
		difficulty = 'easy',
		bgm = "dungeon",
		background = 'forest3',
		custom_background = 'combat_forest',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		travel_time = [1,1], #[3,3],
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		travel_time = [1,1],#[2,2],
		events = [],
		tags = ['quest'],
	},

	basic_threat_wolves = {
		code = 'basic_threat_wolves',
		type = 'encounter',
		name = tr("BASIC_THREAT_WOLVES_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_WOLVES_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
	},
	basic_threat_rebels = {
		code = 'basic_threat_rebels',
		type = 'encounter',
		name = tr("BASIC_THREAT_REBELS_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_REBELS_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
	},
	basic_threat_goblins = {
		code = 'basic_threat_goblins',
		type = 'encounter',
		name = tr("BASIC_THREAT_GOBLINS_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_GOBLINS_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
	},
	basic_threat_ogre = {
		code = 'basic_threat_ogre',
		type = 'encounter',
		name = tr("BASIC_THREAT_OGRE_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_OGRE_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
	},
	basic_threat_troll = {
		code = 'basic_threat_troll',
		type = 'encounter',
		name = tr("BASIC_THREAT_TROLL_TEXT"),
		classname = '',
		descript = tr("BASIC_THREAT_TROLL_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
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
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
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
		resources = '',
		stages_per_level = [10,10],
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], #temp mod for the game to work
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', #defines character races and events
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_forest',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], #temp mod for the game to work
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', #defines character races and events
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['bandit_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_forest',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_forest',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_forest',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_forest',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 1],['spiders', 0.2]],
		final_enemy = [['elder_gryphon_boss',1]], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
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
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 1]],
		final_enemy = [], final_enemy_type = 'monster',
		eventarray = [],
		levels = [1,1],
		resources = '',
		gather_mod = [2.5,4], 
		stages_per_level = [10,10],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local', 
		events = [],
		tags = ['quest'],
		area = 'mountains',
		travel_time = [1,1],
		scripteventdata = []
	},
	quest_mountain_pass = {
		code = 'quest_mountain_pass',
		type = 'encounter',
		name = tr("QUEST_MOUNTAIN_PASS_TEXT"),
		classname = '',
		descript = tr("QUEST_MOUNTAIN_PASS_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
		area = 'mountains',
		travel_time = [1,1],
	},
	quest_hollow_passage = {
		code = 'quest_hollow_passage',
		type = 'encounter',
		name = tr("QUEST_HOLLOW_PASSAGE_TEXT"),
		classname = '',
		descript = tr("QUEST_HOLLOW_PASSAGE_DESC"),
		difficulty = 'easy',
		background = 'cave_3',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
		area = 'mountains',
		travel_time = [1,1],
	},
	quest_old_gods_temple = {
		code = 'quest_old_gods_temple',
		type = 'dungeon',
		name = tr("QUEST_OLD_GODS_TEMPLE_TEXT"),
		classname = '',
		descript = tr("QUEST_OLD_GODS_TEMPLE_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['bandits_easy', 1]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {},
		event_room_number = [0,0],
		material_room_number = [0,0],
		
		main_route_length = [3,3],
		bonus_rooms = [0,0],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = '',
		gather_settings = 'base',
		gatherable_resources = '',
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		tags = ['quest'],
		options = [],
		events = [],
		area = 'mountains',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'enter', args = 'old_temple_start', reqs = [{code = 'active_quest_stage', value = 'dking_hara_quest', stage = 'temple'}]},
			{trigger = 'dungeon_complete', args = 'old_temple_finish', reqs = [{code = 'active_quest_stage', value = 'dking_hara_quest', stage = 'temple'}]}]
	},
	quest_molten_grounds = {
		code = 'quest_molten_grounds',
		type = 'dungeon',
		name = tr("QUEST_MOLTEN_GROUNDS_TEXT"),
		classname = '',
		descript = tr("QUEST_MOLTEN_GROUNDS_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['bandits_easy', 1]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {},
		event_room_number = [0,0],
		material_room_number = [0,0],
		
		main_route_length = [3,3],
		bonus_rooms = [0,0],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = '',
		gather_settings = 'base',
		gatherable_resources = '',
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		tags = ['quest'],
		options = [],
		events = [],
		area = 'mountains',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'dungeon_complete', args = 'capacitor_molten_start', reqs = [{code = 'active_quest_stage', value = 'hara_scales_quest', stage = 'get_cap'}]}]
	},
	quest_whisky_crash = {
		code = 'quest_whisky_crash',
		type = 'encounter',
		name = tr("QUEST_WHISKY_CRASH_TEXT"),
		classname = '',
		descript = tr("QUEST_WHISKY_CRASH_DESC"),
		difficulty = 'easy',
		background = 'cave_1',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
		area = 'mountains',
		travel_time = [1,1],
	},
	quest_cult_hideout = {
		code = 'quest_cult_hideout',
		type = 'encounter',
		name = tr("QUEST_CULT_HIDEOUT_TEXT"),
		classname = '',
		descript = tr("QUEST_CULT_HIDEOUT_DESC"),
		difficulty = 'easy',
		background = 'village3',
		custom_background = 'combat_cave',
		enemyarray =  [],
		eventarray = [],
		levels = [1,1],
		resources = '',
		stages_per_level = [1,1],
		events = [],
		tags = [],
		area = 'plains',
		travel_time = [0,0],
	},
	quest_cult_parentbase = {
		code = 'quest_cult_parentbase',
		type = 'dungeon',
		name = tr("QUEST_CULT_PARENTBASE_TEXT"),
		classname = '',
		descript = tr("QUEST_CULT_PARENTBASE_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['bandits_easy', 1]],
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'monster',
		event_data = {},
		event_room_number = [0,0],
		material_room_number = [0,0],
		
		main_route_length = [3,3],
		bonus_rooms = [0,0],
		levels = [1,1], 
		base_room_stamina_cost = [5,8],
		
		resources = '',
		gather_settings = 'base',
		gatherable_resources = '',
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		tags = ['quest'],
		options = [],
		events = [],
		area = 'plains',
		travel_time = [1,1],
		scripteventdata = [
			{trigger = 'dungeon_complete', args = 'kuro_hideout_medium', reqs = []}]
	},
	quest_lilia_ancient_jungle_location = {
		code = 'quest_lilia_ancient_jungle_location',
		type = 'dungeon',
		name = tr("QUEST_ELVEN_ANCIENT_JUNGLE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_ELVEN_ANCIENT_JUNGLE_LOCATION_DESC"),
		character_data = {
			chance_mod = 1.1,
			races = [["common", 2], ['uncommon', 4],['TribalElf',6], ['rare',1]]
		},
		difficulty = 'medium',
		purchase_area = 'forests',
		background_pool = ['jungle1','jungle2','jungle3','jungle4'],
		custom_background = 'combat_jungle',
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
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			event_tribal_elves = {
				limit = 1,
				weight = 1,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_tribal_elves'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			spring = {
				limit = 1,
				weight = 2,
				floor_range = [0,0],
				icon = 'chest',
				events = ['spring'],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 4,
				floor_range = [0,0],
				icon = 'shrine',
				events = [['celena_shrine_find',0.1], ['erebus_shrine_find',0.2], ['freya_shrine_find',0.5],['hybris_shrine_find',0.3]],
				possible_challenges = [
					['event_blocked_path',1],
					['event_magic_barrier',1],
					['event_fallen_bridge',1],
					['event_small_crack',1],
					['event_ancient_lock',1]
				],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [4,5],
		
		main_route_length = [5,6],
		bonus_rooms = [2,4],
		levels = [1,2], 
		base_room_stamina_cost = [7,11], 
		
		resources = 'local6',
		gather_settings = 'base',
		gatherable_resources = 'biome_ancient_jungles_res',
		
		tags = ['quest'],
		options = [],
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
		{trigger = 'dungeon_complete', event = 'custom_event', args = 'lilia_finale_3', reqs = [{code = 'value_check', type = 'dialogue_seen', check = false, value = 'LILIA_FINALE_WORKERS_2'}]}]
	},
	quest_lilia_dungeon_grove = {
		code = 'quest_lilia_dungeon_grove',
		type = 'dungeon',
		name = tr("QUEST_LILIA_DUNGEON_GROVE_TEXT"),
		classname = '',
		descript = tr("QUEST_LILIA_DUNGEON_GROVE_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		enemyarray = [['rebels_small', 1]],
		final_enemy = [['rebels_small', 1]], 
		final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
				],
			},
		},
		
		event_room_number = [1,1],
		material_room_number = [1,1],
		
		main_route_length = [3,3],
		bonus_rooms = [0,0],
		levels = [1,1], 
		base_room_stamina_cost = [5,5],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'quest_fighters_lich_res',
		
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		options = [],
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
		{trigger = 'dungeon_complete', event = 'custom_event', args = 'lilith_finish_dungeon_1', reqs = [{code = 'active_quest_stage', value = 'lilia_finale_quest', stage = 'stage5'}]}]
	},
	quest_patron_lilia_location = {
		code = 'quest_patron_lilia_location',
		type = 'dungeon',
		name = tr("QUEST_PATRON_ANCIENT_JUNGLE_LOCATION_TEXT"),
		classname = '',
		descript = tr("QUEST_PATRON_ANCIENT_JUNGLE_LOCATION_DESC"),
		character_data = {
			chance_mod = 1.5,
			races = [['local', 3], ['common',5], ['uncommon',1]]
		},
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		custom_background = 'combat_cave',
		enemyarray = [['rebels_small', 1]],
		final_enemy = [['rebels_small', 1]], 
		final_enemy_type = 'monster',
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [
					['event_locked_door',1],
				],
			},
		},
		
		event_room_number = [1,1],
		material_room_number = [1,1],
		
		main_route_length = [3,3],
		bonus_rooms = [0,0],
		levels = [1,1], 
		base_room_stamina_cost = [5,5],
		
		resources = 'local1',
		gather_settings = 'base',
		gatherable_resources = 'quest_fighters_lich_res',
		
		gather_mod = [2,2.5],
		bgm = "dungeon",
		purchase_price = 0,
		affiliation = 'local',
		events = [],
		tags = ['quest'],
		options = [],
		area = 'forests',
		travel_time = [1,1],
		scripteventdata = [
		{trigger = 'dungeon_complete', event = 'custom_event', args = 'lilith_finish_new_dungeon', reqs = [{code = 'active_quest_stage', value = 'lilith_patron_quest', stage = 'stage15'}]}]
	},
}
