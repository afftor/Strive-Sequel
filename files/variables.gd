extends Node
#Game Settings
var HoursPerDay = 24
var SecondsPerHour = 3
var NoScenes = false
var CombatAllyHpAlwaysVisible = true

enum {RES_MISS = 1, RES_HIT = 2, RES_CRIT = 4, RES_HITCRIT = 6}; 
enum {TR_CAST, TR_HIT, TR_DEF, TR_TURN_S, TR_TURN_F, TR_DEATH, TR_KILL, TR_DMG, TR_POSTDAMAGE, TR_HEAL, TR_COMBAT_S, TR_COMBAT_F, TR_SHIELD_DOWN};
enum {S_PHYS = 1, S_FIRE = 2, S_WATER = 4, S_AIR = 8, S_EARTH = 16, S_MAG = 30, S_FULL = 31}

#Items
var RepairCostMultiplierEasy = 0.5
var RepairCostMultiplierMedium = 0.65
var RepairCostMultiplierHard = 0.8
var ItemEffectNaturalMultiplier = 0.15
#Heroes
var all_races_array = []

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