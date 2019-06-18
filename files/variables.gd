extends Node
#Game Settings
var HoursPerDay = 24
var SecondsPerHour = 3
var NoScenes = false
var CombatAllyHpAlwaysVisible = true

var timeforinteraction = 20

enum {RES_MISS = 1, RES_HIT = 2, RES_CRIT = 4, RES_HITCRIT = 6}; 
enum {TR_CAST,TR_CAST_TARGET, TR_HIT, TR_DEF, TR_TURN_S, TR_TURN_GET, TR_TURN_F, TR_DEATH, TR_KILL, TR_DMG, TR_POSTDAMAGE, TR_SKILL_FINISH, TR_HEAL, TR_COMBAT_S, TR_COMBAT_F, TR_SHIELD_DOWN, TR_DAY, TR_S_CAST, TR_S_TARGET, TR_SHACKLES_OFF, TR_TICK, TR_CUSTOM, TR_CUSTOM1};
enum {S_PHYS = 1, S_FIRE = 2, S_WATER = 4, S_AIR = 8, S_EARTH = 16, S_MAG = 30, S_FULL = 31}

enum {TE_RES_NOACT, TE_RES_TICK, TE_RES_UPGRADE, TE_RES_DGRADE, TE_RES_REMOVE}
#list for values modified by crits, effects etc
var dmg_mod_list = ['hp', 'mana', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion', 'energy', 'relation']
#list for values with relative values
var dmg_rel_list = ['hp', 'mana', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion', 'energy', 'relation']

var resists_list = ['fire','earth','air','water']
var fighter_stats_list = ['hp','mana','damage','armor','mdef','hitrate','evasion','armorpenetration','speed']

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

#Items
var RepairCostMultiplierEasy = 0.5
var RepairCostMultiplierMedium = 0.65
var RepairCostMultiplierHard = 0.8
var ItemEffectNaturalMultiplier = 0.15
#Heroes
var all_races_array = []
var starting_races_array = ['Human','Elf','DarkElf','Orc','BeastkinCat', 'BeastkinFox', 'BeastkinWolf', 'BeastkinBunny','HalfkinCat', 'HalfkinFox', 'HalfkinWolf', 'HalfkinBunny']

var master_starting_stats = 10
var slave_starting_stats = 15

#sex chances
var male_to_female_ratio = 0.5
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

#Cheats
var instant_travel = true
var instant_upgrades = true
var free_upgrades = true
var skip_combat = false

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

