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
#			event_trap_easy = { #pointless with all other rooms being bonuses
#				limit = 0,
#				weight = 1,
#				floor_range = [0,0],
#				icon = 'chest',
#				events = ['event_trap_easy'],
#			},
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
		levels = [3,3], 
		base_room_stamina_cost = [7,10], #random roll for every main/bonus rooms rounded
		
		
		#do not remove next ones - for they a used in generation
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			wood = {
				value = [25,40],
				weight = 10,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			stone = {
				value = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				value = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
		bgm = "dungeon",
		purchase_price = 100,
		affiliation = 'local', #defines character races and events
		events = [],
	}
}
