extends Reference
#Slave market quests and the slaver rank; the rules are in src/core/slave_quests.gd.

#Quest factions (flavour). wax: the seal colour under the icon in the captives' quest chooser.
var factions = {
	obsidian = {
		name = "SQ_OBSIDIAN_NAME",
		description = "SQ_OBSIDIAN_DESC",
		leader = "SQ_OBSIDIAN_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/obsidian_brotherhood.png"),
		wax = Color(0.202, 0.165, 0.058),
	},
	dravenmoor = {
		name = "SQ_DRAVENMOOR_NAME",
		description = "SQ_DRAVENMOOR_DESC",
		leader = "SQ_DRAVENMOOR_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/house_dravenmoor.png"),
		wax = Color(0.918, 0.875, 0.776),
	},
	verdant = {
		name = "SQ_VERDANT_NAME",
		description = "SQ_VERDANT_DESC",
		leader = "SQ_VERDANT_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/verdant_conclave.png"),
		wax = Color(0.086, 0.174, 0.140),
	},
	ironhold = {
		name = "SQ_IRONHOLD_NAME",
		description = "SQ_IRONHOLD_DESC",
		leader = "SQ_IRONHOLD_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/ironhold_syndicate.png"),
		wax = Color(0.918, 0.875, 0.776),
	},
	crimson = {
		name = "SQ_CRIMSON_NAME",
		description = "SQ_CRIMSON_DESC",
		leader = "SQ_CRIMSON_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/crimson_veil.png"),
		wax = Color(0.918, 0.875, 0.776),
	},
	gilded = {
		name = "SQ_GILDED_NAME",
		description = "SQ_GILDED_DESC",
		leader = "SQ_GILDED_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/gilded_consortium.png"),
		wax = Color(0.202, 0.167, 0.058),
	},
	azure = {
		name = "SQ_AZURE_NAME",
		description = "SQ_AZURE_DESC",
		leader = "SQ_AZURE_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/azure_covenant.png"),
		wax = Color(0.058, 0.171, 0.202),
	},
	stonebreaker = {
		name = "SQ_STONEBREAKER_NAME",
		description = "SQ_STONEBREAKER_DESC",
		leader = "SQ_STONEBREAKER_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/stonebreaker_clan.png"),
		wax = Color(0.918, 0.875, 0.776),
	},
	chalice = {
		name = "SQ_CHALICE_NAME",
		description = "SQ_CHALICE_DESC",
		leader = "SQ_CHALICE_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/silver_chalice.png"),
		wax = Color(0.058, 0.202, 0.143),
	},
	loom = {
		name = "SQ_LOOM_NAME",
		description = "SQ_LOOM_DESC",
		leader = "SQ_LOOM_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/golden_loom.png"),
		wax = Color(0.202, 0.126, 0.058),
	},
	ashen = {
		name = "SQ_ASHEN_NAME",
		description = "SQ_ASHEN_DESC",
		leader = "SQ_ASHEN_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/ashen_consort.png"),
		wax = Color(0.197, 0.202, 0.058),
		gen_req = [{type = 'decision', value = 'act2_start', check = true}],
	},
	ironvein = {
		name = "SQ_IRONVEIN_NAME",
		description = "SQ_IRONVEIN_DESC",
		leader = "SQ_IRONVEIN_LEAD",
		icon = load("res://assets/Textures_v2/slave_quests/ironvein.png"),
		wax = Color(0.132, 0.132, 0.128),
		gen_req = [{type = 'decision', value = 'act3_start', check = true}],
	},
}

#keep in mind(!) that there is factions with not 0 starting price_factor
var faction_dynamic_data_template = {
	rating = 0,
	price_factor = 0.0
}

#Lowest first. xp and sales are what it takes to leave a rank; *_slots are the open quests per kind;
#factor_upgrade_cap is the highest factor level the Upgrades tab sells (0 = none).
var ranks = [
	{code = 'D', basic_slots = 3, advanced_slots = 1, weights = {easy = 100, medium = 0, hard = 0}, sales = 5, xp = 300, factor_upgrade_cap = 0},
	{code = 'C', basic_slots = 3, advanced_slots = 2, weights = {easy = 70, medium = 30, hard = 0}, sales = 10, xp = 400, factor_upgrade_cap = 3},
	{code = 'B', basic_slots = 4, advanced_slots = 3, weights = {easy = 40, medium = 40, hard = 20}, sales = 15, xp = 600, factor_upgrade_cap = 4},
	{code = 'A', basic_slots = 5, advanced_slots = 3, weights = {easy = 10, medium = 60, hard = 30}, sales = 25, xp = 800, factor_upgrade_cap = 5},
	{code = 'S', basic_slots = 6, advanced_slots = 4, weights = {easy = 0, medium = 25, hard = 75}, sales = 0, xp = 0, factor_upgrade_cap = 6},
]

#days a new quest stays open, rolled per quest
var deadline = [5, 9]

#Tokens of Recognition: paid for quests, rank-ups and the sales target; spent on factor upgrades.
var tokens = {
	quest = {basic = 1, advanced = 2},
	per_difficulty = 1,
	rank_up = {first = 5, step = 5},
	sales_target = 10,
	top_sales = {every = 10, tokens = 10},
}

#A step to level L costs L tokens and gold_step gold; the top level costs top_tokens and top_gold.
var factor_upgrade = {
	gold_step = 250,
	top_level = 6,
	top_tokens = 10,
	top_gold = 1000,
	factors = ['growth_factor', 'physics_factor', 'magic_factor', 'wits_factor', 'charm_factor',
		'sexuals_factor', 'tame_factor', 'authority_factor'],
}

#Rank experience per completed quest; xp_decay lowers it from from_rank on.
var xp = {basic = 100, advanced = 150}
var xp_decay = {
	easy = {from_rank = 'B', mult = 0.33},
	medium = {from_rank = 'A', mult = 0.5},
}

#reqs: (min, max) requirements drawn from race / personality / factor / sex; gold: [base, spread].
var basic = {
	easy = {
		reqs = [2, 2],
		races = {tags = ['common', 'uncommon'], num = 3},
		factor = [3, 4],
		count = [],
		gold = [1000, 100],
	},
	medium = {
		reqs = [2, 3],
		races = {tags = ['common', 'uncommon', 'rare'], num = 2},
		factor = [4, 5],
		count = [2, 3],
		gold = [1700, 200],
	},
	hard = {
		reqs = [3, 3],
		races = {tags = ['uncommon', 'rare'], num = 1},
		factor = [5, 6],
		count = [3, 4],
		gold = [2500, 350],
	},
}

#basic_reqs are drawn as for a basic quest; adv_reqs from sex_skill / base_stat / consent / class / training.
var advanced = {
	easy = {
		basic_reqs = [1, 1],
		adv_reqs = 1,
		sex_skills = [{skilled = 1}],
		stat = [15, 20],
		consent = [2, 2],
		classes = [{basic = 1}],
		training = 'optional',
		gold = [1600, 200],
	},
	medium = {
		basic_reqs = [1, 2],
		adv_reqs = 2,
		sex_skills = [{skilled = 2}, {mastered = 1}],
		stat = [30, 40],
		consent = [3, 4],
		classes = [{basic = 2}, {advanced = 1}],
		training = 'mandatory',
		gold = [3100, 500],
	},
	hard = {
		basic_reqs = [2, 2],
		adv_reqs = 2,
		sex_skills = [{skilled = 3}, {mastered = 1, skilled = 1}],
		stat = [50, 70],
		consent = [5, 5],
		classes = [{advanced = 1, basic = 1}],
		training = 'mandatory',
		gold = [6000, 1000],
	},
}

var personalities = ['kind', 'bold', 'shy', 'serious']
var factor_stats = ['physics_factor', 'wits_factor', 'charm_factor', 'sexuals_factor', 'magic_factor']
#never 'sexuals': its base value is always 0
var base_stats = ['physics', 'wits', 'charm']

#Advanced classes a quest may ask for; one still locked is skipped until the player unlocks it.
var advanced_classes = [
	'shieldbearer', 'knight', 'deathknight', 'paladin', 'spellsword', 'ranger', 'sniper',
	'assassin', 'monk', 'priest', 'bishop',
]

var namepool = {
	basic = ['SQ_BASIC_NAME_1', 'SQ_BASIC_NAME_2', 'SQ_BASIC_NAME_3', 'SQ_BASIC_NAME_4', 'SQ_BASIC_NAME_5', 'SQ_BASIC_NAME_6'],
	advanced = ['SQ_ADVANCED_NAME_1', 'SQ_ADVANCED_NAME_2', 'SQ_ADVANCED_NAME_3', 'SQ_ADVANCED_NAME_4', 'SQ_ADVANCED_NAME_5', 'SQ_ADVANCED_NAME_6'],
}
#descriptions may say [factionname]; the quest panel puts the faction's name there
var descpool = {
	basic = ['SQ_BASIC_DESC_1', 'SQ_BASIC_DESC_2', 'SQ_BASIC_DESC_3'],
	advanced = ['SQ_ADVANCED_DESC_1', 'SQ_ADVANCED_DESC_2', 'SQ_ADVANCED_DESC_3'],
}


#--------------MANUAL-----------------
#* The pool (game_progress.slave_quests.quest_pool) holds basic_slots + advanced_slots quests of
#	the current rank. Every one of them counts as taken; the player only hands slaves over.
#* Each new quest rolls its difficulty from the rank's weights, then its requirements from the
#	tables above, a deadline from `deadline` and gold from its table (base +- spread, rounded to 10).
#	The master's charm bonus is added at payout, like for every other quest.
#* A quest with count > 1 pays per delivered slave (the total split evenly, the remainder on the
#	last one) and gives its experience when the last slave is handed over.
#* Completed and expired quests leave the pool at the daily tick, which then refills it.
#* Rank-up needs the rank's xp and its sales (slaves sold at the market or quick-sold from a
#	location's captives). Both reset on rank-up and the new rank's extra slots are filled at once.
