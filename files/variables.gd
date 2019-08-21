extends Node
#Game Settings
var HoursPerDay = 24
var SecondsPerHour = 3
var NoScenes = false
var CombatAllyHpAlwaysVisible = true

var timeforinteraction = 20

enum {RES_MISS = 1, RES_HIT = 2, RES_CRIT = 4, RES_HITCRIT = 6}; 
enum {TR_CAST,TR_CAST_TARGET, TR_HIT, TR_DEF, TR_TURN_S, TR_TURN_GET, TR_TURN_F, TR_DEATH, TR_KILL, TR_DMG, TR_POSTDAMAGE, TR_SKILL_FINISH, TR_HEAL, TR_COMBAT_S, TR_COMBAT_F, TR_SHIELD_DOWN, TR_DAY, TR_S_CAST, TR_S_TARGET, TR_SHACKLES_OFF, TR_TICK, TR_RES, TR_CUSTOM, TR_CUSTOM1};
enum {S_PHYS = 1, S_FIRE = 2, S_WATER = 4, S_AIR = 8, S_EARTH = 16, S_MAG = 30, S_FULL = 31}

enum {TE_RES_NOACT, TE_RES_TICK, TE_RES_UPGRADE, TE_RES_DGRADE, TE_RES_REMOVE}
#list for values modified by crits, effects etc

var dmg_mod_list = ['damage_hp', 'restore_mana', 'lust', 'obedience', 'fear', 'loyal', 'energy']
#list for values modified bu random_mod
var dmg_rnd_list = ['damage_hp', 'restore_mana', 'hp', 'mp', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion', 'energy']
#list for values with relative values
var dmg_rel_list = ['hp', 'mp', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion', 'energy', 'base_exp','physics_factor','wits_factor','charm_factor','sexuals_factor','tame_factor','brave_factor','growth_factor']

var resists_list = ['normal','fire','earth','air','water','light','dark','mind']
var fighter_stats_list = ['hp','mp','atk','matk','armor','mdef','hitrate','evasion','armorpenetration','speed', 'critchance','critmod']

#list for stats with stored bonuses that use generic getter (not custom getter!!)
#to add them all :)
var bonuses_stat_list = ['productivity','mod_collect','atk','matk','hitrate','evasion','armor','mdef','critrate','critmod', 'lusttick','mod_build','mod_hunt','mod_fish','mod_collect','mod_cook','mod_smith','mod_tailor','mod_alchemy','mod_farm','mod_pros','fear_degrade_mod','obed_degrade_mod']
#list for stats that do not uses bonuses system
#imho must include all of dmg_rel stats
var direct_access_stat_list = ['hp', 'mp', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion', 
'energy', 'physics_bonus', 'wits_bonus','charm_bonus','sexuals_bonus','physics_factor','wits_factor','charm_factor',
'sexuals_factor','magic_factor','growth_factor']
var productivity_mods = ['mod_build','mod_hunt', 'mod_fish','mod_collect','mod_cook','mod_smith','mod_tailor','mod_alchemy','mod_farm','mod_pros']

#mode for applying absolute random damage mod
const relative_random_add = true

const playerparty = [1, 2, 3, 4, 5, 6]
const enemyparty = [7, 8, 9, 10, 11, 12]
const rows = {
	1:[1,4],
	2:[2,5],
	3:[3,6],
	4:[7,10],
	5:[8,11],
	6:[9,12],
} 
const lines = {
	1 : [1,2,3],
	2 : [4,5,6],
	3 : [7,8,9],
	4 : [10,11,12],
}

#mansion & ugprades
var base_population_cap = 5
var population_cap_per_room_upgrade = 5
var max_population_cap = 30
var stable_boost_per_level = 0.2

#Items
var RepairCostMultiplierEasy = 0.5
var RepairCostMultiplierMedium = 0.65
var RepairCostMultiplierHard = 0.8
var ItemEffectNaturalMultiplier = 0.15
#Heroes
var all_races_array = []
var starting_races_array = ['Human','Elf','DarkElf','Orc','BeastkinCat', 'BeastkinFox', 'BeastkinWolf', 'BeastkinBunny','HalfkinCat', 'HalfkinFox', 'HalfkinWolf', 'HalfkinBunny']

var master_starting_classes = ['fighter','archer','worker','smith','apprentice','hunter']
var slave_starting_classes = ['attendant', 'fighter', 'archer', 'worker', 'smith', 'apprentice','hunter']

var master_starting_stats = 10
var slave_starting_stats = 15

var minimum_factor_value = 1
var maximum_factor_value = 6

var power_adjustments_per_difficulty = {
	easy = [1,2],
	medium = [2,4],
	hard = [3,6]
}
#sex chances
var male_to_female_ratio = 0.0
var futa_to_female_ratio = 0.1

var teen_age_weight = 1
var adult_age_weight = 1
var mature_age_weight = 1

var furry_multiple_nipples_number = 3

var female_vagina_virgin_default_chance = 50
var male_penis_virgin_default_chance = 50
var female_ass_virgin_default_chance = 90
var male_ass_virgin_default_chance = 90

var class_cap_basic = 2
var class_cap_per_growth = 1
var soft_level_reqs = [100,150,200,300,400,500,650,800,950]
var hard_level_reqs = [1000,1500,2000,3000,4000,5000]

#Slave values
var slave_basic_sizes = ['masculine','flat','small','average','big','huge']
var slave_genital_sizes = ['small','average','big']

var basic_max_hp = 100
var basic_max_mp = 30
var basic_hp_regen = 1
var basic_mp_regen = 0.2
var mp_regen_per_magic = 0.1
var max_mp_per_magic_factor = 10

var basic_lust_per_tick = 0.57
var basic_energy_per_work_tick = 8.35

#Cheats
var instant_travel = false
var skip_combat = false
var free_upgrades = true
var instant_upgrades = true
var unlock_all_upgrades = false
var invincible_player = true
var show_enemy_hp = true
var social_skill_unlimited_charges = false

#debug_only
var allow_remote_intereaction = false
var no_event_wait_time = false

var generate_test_chars = true
var new_stat_bonuses_syntax = false



var pregduration = 90

var slave_classes_per_difficulty = {
	0 : [0, 2],
	1 : [0, 3],
	2 : [1, 4],
	3 : [2, 5],
	4 : [3, 6],
	5 : [4, 7],
	6 : [5, 8],
	7 : [6, 9],
	8 : [6, 10],
	9 : [6, 10],
	10 : [6, 10],
}

var starting_resources = {
	meat = 25,
	fish = 25,
	bread = 25,
	vegetables = 25,
}

var dynamic_text_vars = ['name', 'He','he', 'his', 'him', "His", 'raceadj', 'race','age', 'male', 'eye_color','hair_color', 'boy']