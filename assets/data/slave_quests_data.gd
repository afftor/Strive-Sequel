extends Reference

var factions = {
	obsidian = {
		name = "SQ_OBSIDIAN_NAME",
		description = "SQ_OBSIDIAN_DESC",
		leader = "SQ_OBSIDIAN_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/obsidian_brotherhood.png"),
		quest_pool = [
			'gardener', 'maid', 'miner', 'craftsman', 'alchemist', 'hunter',
			'fighter', 'ranger', 'healer', 'thief', 'fighter_t2', 'healer_t2',
			'mage', 'assassin_t2'],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		}
	},
	dravenmoor = {
		name = "SQ_DRAVENMOOR_NAME",
		description = "SQ_DRAVENMOOR_DESC",
		leader = "SQ_DRAVENMOOR_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/house_dravenmoor.png"),
		quest_pool = [
			'elf', 'ratkin', 'any_beastkin', 'fairy', 'miner', 'craftsman',
			'alchemist', 'hunter', 'shortstack', 'fighter', 'ranger',
			'fighter_t2', 'healer_t2', 'rare_race', 'elf_archer', 'assassin_t2'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		}
	},
	verdant = {
		name = "SQ_VERDANT_NAME",
		description = "SQ_VERDANT_DESC",
		leader = "SQ_VERDANT_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/verdant_conclave.png"),
		quest_pool = [
			'elf', 'any_beastkin', 'fairy', 'gardener', 'maid', 'alchemist',
			'hunter', 'ranger', 'healer', 'sex_generic', 'rare_race',
			'elf_archer', 'miko', 'sex_generic_t2', 'mage'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		}
	},
	ironhold = {
		name = "SQ_IRONHOLD_NAME",
		description = "SQ_IRONHOLD_DESC",
		leader = "SQ_IRONHOLD_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/ironhold_syndicate.png"),
		quest_pool = [
			'ratkin', 'any_beastkin', 'miner', 'craftsman', 'hunter', 'shortstack',
			'fighter', 'healer', 'fighter_t2', 'healer_t2', 'rare_race', 'assassin_t2'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
		req_add = [
			[
				{
					has_no_req = {code = "has_profession", check = true},
					reqs = {code = "has_profession", profession = "worker", check = true},
					chance = 1.0,
					stop_on_me = true
				},
				{
					has_tags = ['t2'],
					generate_func = 'getreq_roll_stat',
					generate_args = ['physics', [40,60], 'gte', 5],
					chance = 1.0,
					stop_on_me = true
				},
				{
					generate_func = 'getreq_roll_stat',
					generate_args = ['physics', [20,40], 'gte', 5],
					chance = 1.0
				},
			]
		]
	},
	crimson = {
		name = "SQ_CRIMSON_NAME",
		description = "SQ_CRIMSON_DESC",
		leader = "SQ_CRIMSON_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/crimson_veil.png"),
		quest_pool = [
			'elf', 'any_beastkin', 'fairy', 'maid', 'craftsman', 'alchemist',
			'fighter', 'thief', 'sex_generic', 'fighter_t2', 'rare_race',
			'elf_archer', 'sex_generic_t2', 'mage', 'assassin_t2'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
	},
	gilded = {
		name = "SQ_GILDED_NAME",
		description = "SQ_GILDED_DESC",
		leader = "SQ_GILDED_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/gilded_consortium.png"),
		quest_pool = [
			'any_beastkin', 'fairy', 'gardener', 'maid', 'hunter', 'fighter',
			'ranger', 'healer', 'thief', 'sex_generic', 'fighter_t2',
			'healer_t2', 'rare_race', 'miko', 'sex_generic_t2', 'mage'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
	},
	azure = {
		name = "SQ_AZURE_NAME",
		description = "SQ_AZURE_DESC",
		leader = "SQ_AZURE_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/azure_covenant.png"),
		quest_pool = [
			'elf', 'ratkin', 'craftsman', 'alchemist', 'hunter', 'shortstack',
			'fighter', 'thief', 'sex_generic', 'fighter_t2', 'healer_t2',
			'rare_race', 'elf_archer', 'miko', 'sex_generic_t2', 'mage',
			'assassin_t2'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
	},
	stonebreaker = {
		name = "SQ_STONEBREAKER_NAME",
		description = "SQ_STONEBREAKER_DESC",
		leader = "SQ_STONEBREAKER_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/stonebreaker_clan.png"),
		quest_pool = [
			'elf', 'fairy', 'gardener', 'maid', 'hunter', 'shortstack', 'healer',
			'sex_generic', 'healer_t2', 'miko', 'sex_generic_t2', 'mage'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
	},
	chalice = {
		name = "SQ_CHALICE_NAME",
		description = "SQ_CHALICE_DESC",
		leader = "SQ_CHALICE_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/silver_chalice.png"),
		quest_pool = [
			'gardener', 'miner', 'hunter', 'shortstack', 'fighter', 'healer',
			'fighter_t2', 'healer_t2', 'miko', 'mage'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
	},
	loom = {
		name = "SQ_LOOM_NAME",
		description = "SQ_LOOM_DESC",
		leader = "SQ_LOOM_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/golden_loom.png"),
		quest_pool = [
			'elf', 'fairy', 'gardener', 'maid', 'shortstack', 'sex_generic',
			'rare_race', 'sex_generic_t2', 'assassin_t2'
		],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
	},
	ashen = {
		name = "SQ_ASHEN_NAME",
		description = "SQ_ASHEN_DESC",
		leader = "SQ_ASHEN_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/ashen_consort.png"),
		quest_pool = [
			'elf', 'gardener', 'maid', 'craftsman', 'alchemist', 'hunter',
			'fighter', 'ranger', 'healer', 'thief', 'fighter_t2', 'healer_t2',
			'elf_archer', 'miko', 'mage', 'assassin_t2'
		],
		gen_req = [{type = 'decision', value = 'act2_start', check = true}],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
		req_add = [
			{
				override = [
					{code = "race"},
					{code = "one_of_races"}
				],
				reqs = {code = 'one_of_races', value = ['TribalElf', 'Elf']},
				chance = 1.0
			},
		]
	},
	ironvein = {
		name = "SQ_IRONVEIN_NAME",
		description = "SQ_IRONVEIN_DESC",
		leader = "SQ_IRONVEIN_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/ironvein.png"),
		quest_pool = [
			'ratkin', 'fairy', 'gardener', 'maid', 'miner', 'craftsman',
			'alchemist', 'hunter', 'shortstack', 'fighter', 'ranger', 'thief',
			'sex_generic', 'fighter_t2', 'healer_t2', 'sex_generic_t2', 'mage',
			'assassin_t2'
		],
		gen_req = [{type = 'decision', value = 'act3_start', check = true}],
		gen_chance = {
			1 : 1.0, 2 : 0.8, 3 : 0.5
		},
		req_add = [
			[
				{
					exceptions = ['ratkin', 'fairy'],
					override = [
						{code = "race"},
						{code = "one_of_races"}
					],
					generate_func = 'getreq_race_by_tags',
					generate_args = [['midget'], 2],
					chance = 0.5,
					reward_func = "getrwd_race_tag",
					reward_func_args = ['rare', 0.1],
					stop_on_me = true
				},
				{
					exceptions = ['ratkin', 'fairy'],
					override = [
						{code = "race"},
						{code = "one_of_races"}
					],
					generate_func = 'getreq_race_by_tags',
					generate_args = [['midget']],
					chance = 1.0,
					reward_func = "getrwd_race_tag",
					reward_func_args = ['rare', 0.1]
				},
			]
		]
	}
}

#keep in mind(!) that there is factions with not 0 starting price_factor
var faction_dynamic_data_template = {
	rating = 0,
	price_factor = 0.0
}

#var no_faction = {
#	name = "no name",
#	description = "no description",
#	leader = "no leader",
#	icon = null,
#	quest_pool = [],
#	gen_chance = {}
#}

var quests = {
	elf = {
		namepool = ["SQ_ELF_NAME1"],
		description = "SQ_ELF_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 5,
		slave_req_primary = [
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 1.0
			},
			[
				{
					reqs = {code = "race", race = "DarkElf", check = true},
					chance = 0.1,
					reward_bonus = 0.1,
					stop_on_me = true
				},
				{
					reqs = {code = "race", race = "TribalElf", check = true},
					chance = 0.3,
					stop_on_me = true
				},
				{
					reqs = {code = "race", race = "Elf", check = true},
					chance = 1.0,
				},
			]
		],
		slave_req = [
			{
				has_no_req = {code = "sex", value = 'male'},
				reqs = {code = 'stat', stat = 'vaginal_virgin', operant = 'eq', value = true},
				chance = 0.25
			},
			{
				reqs = {code = 'stat', stat = 'hair_length', operant = 'in', value = ['shoulder', 'waist', 'hips']},
				chance = 0.5
			},
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'kind'},
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'bold'},
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'shy'},
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'serious'},
				], 1],
				chance = 0.3,
			},
			{
				generate_func = "getreq_random_starting_class",
				chance = 0.5,
			},
		],
		slave_number = [1, 1]
	},
	ratkin = {
		namepool = ["SQ_RATKIN_NAME1"],
		description = "SQ_RATKIN_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				reqs = {code = "race", race = "Ratkin", check = true},
				chance = 1.0
			},
		],
		slave_req = [
			{
				reqs = {code = 'stat', stat = 'personality', operant = 'eq', value = 'shy'},
				chance = 0.5,
			},
			{
				reqs = {code = "stat", stat = "growth_factor", operant = "gte", value = 4},
				chance = 0.5
			},
			{
				reqs = {code = 'trait', trait = 'training_callmaster', check = true},
				chance = 0.5,
			},
			{
				reqs = {code = 'trait', trait = 'etiquette', check = true},
				chance = 0.3,
			},
			{
				generate_func = "getreq_random_starting_class",
				chance = 0.7,
			},
		],
		slave_number = [1, 1]
	},
	any_beastkin = {
		namepool = ["SQ_BEASTKIN_NAME1"],
		description = "SQ_BEASTKIN_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 5,
		slave_req_primary = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['beast', 'halfbeast']],
				chance = 1.0,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
		],
		slave_req = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'kind'},
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'bold'},
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'shy'},
					{code = 'stat', stat = 'personality', operant = 'eq', value = 'serious'},
				], 1],
				chance = 0.3,
			},
			{
				generate_func = "getreq_random_sex_skills",
				generate_args = [1, [30,50], "gte"],
				chance = 0.7
			},
			{
				reqs = [
					{code = 'trait', trait = 'training_callmaster', check = true},
					{code = 'trait', trait = 'training_relation', check = true},
					{code = 'trait', trait = 'training_sexservice', check = true},
				],
				chance = 0.5,
			},
			{
				generate_func = "getreq_random_starting_class",
				chance = 0.5,
			},
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = 'trait', trait = 'animal_handling', check = true},
					{code = 'trait', trait = 'table_manners', check = true}
				], 1],
				chance = 0.5,
			},
		],
		slave_number = [1, 1]
	},
	any_monster = {
		namepool = ["SQ_MONSTER_NAME1"],
		description = "SQ_MONSTER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 5,
		slave_req_primary = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['monster']],
				chance = 1.0,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				reqs = [
					{code = 'trait', trait = 'training_callmaster', check = true},
					{code = 'trait', trait = 'training_relation', check = true},
					{code = 'trait', trait = 'training_sexservice', check = true},
				],
				chance = 1.0,
			},
			[
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'trait', trait = 'etiquette', check = true},
						{code = 'trait', trait = 'literacy', check = true},
						{code = 'trait', trait = 'table_manners', check = true}
					], 2],
					chance = 0.3,
					stop_on_me = true
				},
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'trait', trait = 'etiquette', check = true},
						{code = 'trait', trait = 'literacy', check = true},
						{code = 'trait', trait = 'table_manners', check = true}
					], 1],
					chance = 1.0,
				},
			],
		],
		slave_req = [
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.5
			},
			{
				reqs = {code = "has_profession", profession = "pet", check = true},
				chance = 0.25
			},
		],
		slave_number = [1, 1]
	},
	fairy = {
		namepool = ["SQ_FAIRY_NAME1"],
		description = "SQ_FAIRY_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				reqs = {code = "race", race = "Fairy", check = true},
				chance = 1.0
			},
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 1.0
			},
		],
		slave_req = [
			{
				has_no_req = {code = "sex", value = 'male'},
				reqs = {code = 'stat', stat = 'vaginal_virgin', operant = 'eq', value = true},
				chance = 0.75
			},
			{
				has_no_req = {code = "sex", value = 'male'},
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = 'stat', stat = 'tits_size', operant = 'in', value = ['flat', 'small', 'average']},
					{code = 'stat', stat = 'tits_size', operant = 'in', value = ['average', 'big', 'huge']},
				], 1],
				chance = 0.5
			},
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "apprentice", check = true},
					{code = "has_profession", profession = "scholar", check = true},
					{code = "has_profession", profession = "bard", check = true},
					{code = "has_profession", profession = "dancer", check = true},
				], 1],
				chance = 0.75
			},
		],
		slave_number = [1, 1]
	},
	gardener = {
		namepool = ["SQ_GARDENER_NAME1"],
		description = "SQ_GARDENER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			[
				{
					reqs = [
						{code = 'has_profession', profession = 'farmer', check = true},
						{code = 'has_profession', profession = 'worker', check = true},
					],
					chance = 0.5,
					stop_on_me = true
				},
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'has_profession', profession = 'farmer', check = true},
						{code = 'has_profession', profession = 'worker', check = true},
					], 1],
					chance = 1.0,
				},
			],
			{
				reqs = {code = 'trait', trait = 'gardening', check = true},
				chance = 1.0,
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [30,60], 'gte', 5],
				chance = 0.6
			},
			{
				reqs = {code = 'stat', stat = 'growth_factor', operant = 'gte', value = 3},
				chance = 0.75
			},
		],
		slave_number = [1, 1]
	},
	maid = {
		namepool = ["SQ_MAID_NAME1"],
		description = "SQ_MAID_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			[
				{
					reqs = {code = 'has_profession', profession = 'maid', check = true},
					chance = 1.0,
				},
				{
					reqs = {code = 'has_profession', profession = 'geisha', check = true},
					chance = 0.5,
				},
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'has_profession', profession = 'pet', check = true},
						{code = 'has_profession', profession = 'petbeast', check = true},
					], 1],
					chance = 0.3,
				},
			],
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [25,50], 'gte', 5],
				chance = 0.5
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['charm', [25,50], 'gte', 5],
				chance = 0.5
			},
			[
				{
					reqs = {code = 'trait', trait = 'etiquette', check = true},
					chance = 0.5,
				},
				{
					reqs = {code = 'trait', trait = 'table_manners', check = true},
					chance = 0.5,
				},
				{
					reqs = {code = 'trait', trait = 'mentorship', check = true},
					chance = 0.25,
				},
				{
					reqs = {code = 'trait', trait = 'gardening', check = true},
					chance = 0.5,
				},
			],
			{
				reqs = {code = 'gear_equiped', value = 'maid_dress', check = true},
				chance = 0.5,
				reward_bonus = 0.05
			},
		],
		slave_number = [1, 1],
		special_rule = "spec_rename_maid"
	},
	miner = {
		namepool = ["SQ_MINER_NAME1"],
		description = "SQ_MINER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			[
				{
					reqs = {code = 'has_profession', profession = 'worker', check = true},
					chance = 1.0,
				},
				{
					reqs = {code = 'has_profession', profession = 'foreman', check = true},
					chance = 0.5,
				},
			],
		],
		slave_req = [
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics_factor', [2,4], 'gte'],
				chance = 0.75
			},
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				reqs = {code = 'stat', stat = 'growth_factor', operant = 'gte', value = 3},
				chance = 0.33
			},
			{
				reqs = {code = 'gear_equiped', value = 'worker_outfit', check = true},
				chance = 0.5,
				reward_bonus = 0.05
			},
		],
		slave_number = [1, 1]
	},
	craftsman = {
		namepool = ["SQ_CRAFTSMAN_NAME1"],
		description = "SQ_CRAFTSMAN_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "worker", check = true},
					{code = "has_profession", profession = "smith", check = true},
					{code = "has_profession", profession = "chef", check = true},
					{code = "has_profession", profession = "engineer", check = true},
				], 1],
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				reqs = {code = 'stat', stat = 'growth_factor', operant = 'gte', value = 3},
				chance = 0.5
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [25,50], 'gte', 5],
				chance = 0.5
			},
			{
				reqs = {code = 'gear_equiped', value = 'craftsman_suit', check = true},
				chance = 0.33,
				reward_bonus = 0.05
			},
		],
		slave_number = [1, 1]
	},
	alchemist = {
		namepool = ["SQ_ALCHEMIST_NAME1"],
		description = "SQ_ALCHEMIST_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				reqs = {code = "has_profession", profession = "alchemist", check = true},
				chance = 1.0
			},
			[
				{
					reqs = {code = 'trait', trait = 'literacy', check = true},
					chance = 1.0,
				},
				{
					reqs = {code = 'trait', trait = 'penmanship', check = true},
					chance = 0.5,
				},
			],
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.25,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'wits_factor', operant = 'gte', value = 4},
				chance = 0.5
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['wits', [25,50], 'gte', 5],
				chance = 0.5
			},
		],
		slave_number = [1, 1]
	},
	hunter = {
		namepool = ["SQ_HUNTER_NAME1"],
		description = "SQ_HUNTER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				reqs = {code = "has_profession", profession = "hunter", check = true},
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.33,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				reqs = {code = "sex", operant = "eq", value = "male"},
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'growth_factor', operant = 'gte', value = 3},
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'physics_factor', operant = 'gte', value = 3},
				chance = 0.75
			},
			{
				reqs = {code = 'trait', trait = 'animal_handling', check = true},
				chance = 0.75,
			},
		],
		slave_number = [1, 1]
	},
	shortstack = {
		namepool = ["SQ_SHORTSTACK_NAME1"],
		description = "SQ_SHORTSTACK_DESC",
		gen_req = [{type = 'global_settings', param = 'malechance', operant = 'lt', value = 100}],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = 'stat', stat = 'height', operant = 'in', value = ['tiny','petite','short']},
					{code = 'stat', stat = 'height', operant = 'in', value = ['tiny','petite']},
				], 1],
				chance = 1.0
			},
			{
				reqs = {code = "sex", operant = "eq", value = "female"},
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['midget']],
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['sexuals', [10,20], 'gte', 5],
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'ass_size', operant = 'in', value = ['average', 'big', 'huge']},
				chance = 0.5
			},
		],
		slave_number = [1, 1]
	},
	fighter = {
		namepool = ["SQ_FIGHTER_NAME1"],
		description = "SQ_FIGHTER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "fighter", check = true},
					{code = "has_profession", profession = "archer", check = true},
					{code = "has_profession", profession = "rogue", check = true},
				], 1],
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.33,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'physics_factor', operant = 'gte', value = 3},
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'height', operant = 'in', value = ['average','tall','towering']},
				chance = 0.5
			},
			{
				reqs = {code = 'trait', trait = 'courtly_arms', check = true},
				chance = 0.75,
			},
		],
		slave_number = [1, 1]
	},
	ranger = {
		namepool = ["SQ_RANGER_NAME1"],
		description = "SQ_RANGER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "ranger", check = true},
					{code = "has_profession", profession = "archer", check = true},
					{code = "has_profession", profession = "hunter", check = true},
				], 1],
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.5
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [25,50], 'gte', 5],
				chance = 0.5
			},
			{
				reqs = {code = 'trait', trait = 'courtly_arms', check = true},
				chance = 0.5,
			},
		],
		slave_number = [1, 1]
	},
	healer = {
		namepool = ["SQ_HEALER_NAME1"],
		description = "SQ_HEALER_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 3,
		slave_req_primary = [
			[
				{
					reqs = {code = "has_profession", profession = "acolyte", check = true},
					chance = 1.0
				},
				{
					reqs = {code = "has_profession", profession = "priest", check = true},
					chance = 0.5
				}
			],
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['wits', [15,30], 'gte', 5],
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'magic_factor', operant = 'gte', value = 3},
				chance = 0.5
			},
		],
		slave_number = [1, 1]
	},
	thief = {
		namepool = ["SQ_THIEF_NAME1"],
		description = "SQ_THIEF_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 3,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "rogue", check = true},
					{code = "has_profession", profession = "thief", check = true},
				], 1],
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'personality', operant = 'in', value = ['bold', 'serious']},
				chance = 0.5
			},
			[
				{
					reqs = {code = 'trait', trait = 'courtly_arms', check = true},
					chance = 0.3,
				},
				{
					reqs = {code = 'trait', trait = 'foreign_diplomacy', check = true},
					chance = 0.2,
				},
			],
		],
		slave_number = [1, 1]
	},
	sex_generic = {
		namepool = ["SQ_SEX_GENERIC_NAME1"],
		description = "SQ_SEX_GENERIC_DESC",
		gen_req = [],
		time_limit = [20, 25],
		rewardpool = [4500],
		req_max = 3,
		slave_req_primary = [
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 1.0
			},
			{
				generate_func = 'getreq_random_starting_race',
				chance = 0.25,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = "getreq_random_sex_skills",
				generate_args = [1, [20,30], "gte", 5],
				chance = 1.0
			},
		],
		slave_req = [
			
		],
		slave_number = [1, 1]
	},
	
	#Advanced
	fighter_t2 = {
		namepool = ["SQ_FIGHTER_T2_NAME1"],
		description = "SQ_FIGHTER_T2_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "knight", check = true},
					{code = "has_profession", profession = "paladin", check = true},
					{code = "has_profession", profession = "templar", check = true},
					{code = "has_profession", profession = "assassin", check = true},
				], 1],
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['starting_race', 'rare']],
				chance = 0.33,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics_factor', [3,4], 'gte'],
				chance = 0.75
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [30,50], 'gte', 5],
				chance = 0.75
			},
			{
				reqs = {code = 'trait', trait = 'courtly_arms', check = true},
				chance = 0.75,
			},
		],
		slave_number = [1, 1]
	},
	healer_t2 = {
		namepool = ["SQ_HEALER_T2_NAME1"],
		description = "SQ_HEALER_T2_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 5,
		slave_req_primary = [
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = "has_profession", profession = "priest", check = true},
					{code = "has_profession", profession = "shaman", check = true},
				], 1],
				chance = 1.0
			},
			{
				generate_func = "getreq_random_from_array",
				generate_args = [[
					{code = 'stat', stat = 'mastery_water', value = 4, operant = 'gte'},
					{code = 'stat', stat = 'mastery_light', value = 4, operant = 'gte'},
				], 1],
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['starting_race', 'rare']],
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['wits', [25,40], 'gte', 5],
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'magic_factor', operant = 'gte', value = 3},
				chance = 0.5
			},
		],
		slave_number = [1, 1]
	},
	rare_race = {
		namepool = ["SQ_RARE_RACE_NAME1"],
		description = "SQ_RARE_RACE_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['rare']],
				chance = 1.0,
				reward_bonus = 0.1
			},
			{
				reqs = [
					{code = 'trait', trait = 'training_callmaster', check = true},
					{code = 'trait', trait = 'training_relation', check = true},
					{code = 'trait', trait = 'training_sexservice', check = true},
				],
				chance = 1.0,
			},
			[
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'trait', trait = 'etiquette', check = true},
						{code = 'trait', trait = 'literacy', check = true},
						{code = 'trait', trait = 'table_manners', check = true}
					], 2],
					chance = 0.3,
					stop_on_me = true
				},
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'trait', trait = 'etiquette', check = true},
						{code = 'trait', trait = 'literacy', check = true},
						{code = 'trait', trait = 'table_manners', check = true}
					], 1],
					chance = 1.0,
				},
			],
		],
		slave_req = [
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.75
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['growth_factor', [3,4], 'gte'],
				chance = 0.5
			},
		],
		slave_number = [1, 1]
	},
	elf_archer = {
		namepool = ["SQ_ELF_ARCHER_NAME1"],
		description = "SQ_ELF_ARCHER_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 5,
		slave_req_primary = [
			{
				generate_func = 'getreq_fill_param_random_from_array',
				generate_args = [{code = 'one_of_races', value = []}, 'value',
					['DarkElf', 'TribalElf', 'Elf'], 2],
				chance = 1.0,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['mastery_marksmanship', [4,5], 'gte'],
				chance = 1.0
			}
		],
		slave_req = [
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['growth_factor', [3,4], 'gte'],
				chance = 0.75
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [40,60], 'gte', 5],
				chance = 0.75
			},
			{
				reqs = {code = "has_profession", profession = "sniper", check = true},
				chance = 0.75
			},
		],
		slave_number = [1, 1]
	},
	miko = {
		namepool = ["SQ_MIKO_NAME1"],
		description = "SQ_MIKO_DESC",
		gen_req = [
			{type = 'decision', value = 'act1_finish', check = true},
			{type = 'global_settings', param = 'malechance', operant = 'lt', value = 100}
		],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 5,
		slave_req_primary = [
			{
				reqs = {code = "has_profession", profession = "acolyte", check = true},
				chance = 1.0
			},
			{
				reqs = {code = "sex", operant = "eq", value = "female"},
				chance = 1.0
			},
			{
				reqs = {code = 'stat', stat = 'vaginal_virgin', operant = 'eq', value = true},
				chance = 1.0
			},
			[
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'trait', trait = 'etiquette', check = true},
						{code = 'trait', trait = 'literacy', check = true},
						{code = 'trait', trait = 'gardening', check = true}
					], 2],
					chance = 0.5,
					stop_on_me = true
				},
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = 'trait', trait = 'etiquette', check = true},
						{code = 'trait', trait = 'literacy', check = true},
						{code = 'trait', trait = 'gardening', check = true}
					], 1],
					chance = 1.0,
				},
			],
		],
		slave_req = [
			{
				reqs = {code = 'one_of_races', value = ['BeastkinFox', 'HalfkinFox']},
				chance = 0.5
			},
		],
		slave_number = [1, 1]
	},
	sex_generic_t2 = {
		namepool = ["SQ_SEX_GENERIC_T2_NAME1"],
		description = "SQ_SEX_GENERIC_T2_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 4,
		slave_req_primary = [
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 1.0
			},
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['starting_race', 'rare']],
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			[
				{
					generate_func = "getreq_random_sex_skills",
					generate_args = [2, [30,50], "gte", 5],
					chance = 0.5,
					stop_on_me = true
				},
				{
					generate_func = "getreq_random_sex_skills",
					generate_args = [1, [30,50], "gte", 5],
					chance = 1.0
				},
			],
			[
				{#!!!!!!!!!check if orflag works here!!!!!!!!!!!!!!!
					has_no_req = {code = "sex", value = 'male'},
					reqs = [
						{code = 'gear_equiped', value = 'lacy_underwear', check = true},
						{code = 'gear_equiped', value = 'seethrough_underwear', check = true, orflag = true},
					],
					chance = 0.5,
					reward_bonus = 0.05,
					stop_on_me = true
				},
				{
					reqs = {code = 'gear_equiped', value = 'seethrough_underwear', check = true},
					chance = 1.0,
					reward_bonus = 0.05
				},
			]
		],
		slave_req = [
			
		],
		slave_number = [1, 1]
	},
	mage = {
		namepool = ["SQ_MAGE_NAME1"],
		description = "SQ_MAGE_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 4,
		slave_req_primary = [
			[
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = "has_profession", profession = "caster", check = true},
						{code = "has_profession", profession = "shaman", check = true},
					], 1],
					chance = 0.5
				},
				{
					generate_func = "getreq_random_from_array",
					generate_args = [[
						{code = "has_profession", profession = "scholar", check = true},
						{code = "has_profession", profession = "apprentice", check = true},
					], 1],
					chance = 1.0
				},
			]
		],
		slave_req = [
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['starting_race', 'rare']],
				chance = 0.5,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['wits', [30,50], 'gte', 5],
				chance = 0.5
			},
			{
				reqs = {code = 'stat', stat = 'magic_factor', operant = 'gte', value = 4},
				chance = 0.5
			},
			{
				generate_func = "getreq_roll_random_stats",
				generate_args = [[
						'mastery_fire', 'mastery_water', 'mastery_earth',
						'mastery_air', 'mastery_light', 'mastery_dark', 'mastery_mind'
					], 1, [4,5], 'gte'],
				chance = 0.75
			},
		],
		slave_number = [1, 1]
	},
	assassin_t2 = {
		namepool = ["SQ_ASSASSIN_T2_NAME1"],
		description = "SQ_ASSASSIN_T2_DESC",
		gen_req = [{type = 'decision', value = 'act1_finish', check = true}],
		tags = ['t2'],
		difficulty = 'medium',
		time_limit = [20, 25],
		rewardpool = [9000],
		req_max = 4,
		slave_req_primary = [
			{
				reqs = {code = "has_profession", profession = "assassin", check = true},
				chance = 1.0
			},
		],
		slave_req = [
			{
				generate_func = 'getreq_sex_by_ratio',
				chance = 0.75
			},
			{
				generate_func = 'getreq_race_by_tags',
				generate_args = [['starting_race', 'rare']],
				chance = 0.66,
				reward_func = "getrwd_race_tag",
				reward_func_args = ['rare', 0.1]
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['mastery_stealth', [3,4], 'gte'],
				chance = 0.75
			},
			{
				generate_func = 'getreq_roll_stat',
				generate_args = ['physics', [30,50], 'gte', 5],
				chance = 0.75
			},
		],
		slave_number = [1, 1]
	},
}

