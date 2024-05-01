extends Node

#Game Settings
#timeflow
var HoursPerDay = 4
var DaysPerWeek = 7
var shop_restock_days = 1
var timeword = {
	1:"MORNING",
	2:"NOON",
	3:"EVENING",
	4:"NIGHT",
	0:"NIGHT",
}
#var timeword = {
#	1:"6:00",
#	2:"12:00",
#	3:"18:00",
#	4:"00:00",
#	0:"00:00",
#}
var SecndsPerTransition = 1.0
var SecondsPerHour = 3
var NoScenes = false
var CombatAllyHpAlwaysVisible = true

var timeforinteraction = 20

var permanent_classes = ['master','renown_royalty','broken_royalty','alios_champion']


var debug_mode = false
var no_obedience_drain = false

#var hour_turn_limit = 8

enum {PANEL_SOC, PANEL_COM}

enum {RES_MISS = 1, RES_HIT = 2, RES_CRIT = 4, RES_HITCRIT = 6};
enum {TR_CAST,TR_CAST_TARGET, TR_HIT, TR_DEF, TR_TURN_S, TR_TURN_GET, TR_TURN_F, TR_DEATH, TR_KILL, TR_DMG, TR_POSTDAMAGE, TR_POST_TARG, TR_SKILL_FINISH, TR_HEAL, TR_COMBAT_S, TR_COMBAT_F, TR_SHIELD_DOWN, TR_TAUNT_FAIL, TR_DAY, TR_S_CAST, TR_S_TARGET, TR_SHACKLES_OFF, TR_TICK, TR_RES, TR_SOC_SPEC, TR_MOVE, TR_REMOVE, TR_CUSTOM, TR_CUSTOM1, TR_EXPLORE_POSTDAMAGE, TR_NONE};
enum {S_PHYS = 1, S_FIRE = 2, S_WATER = 4, S_AIR = 8, S_EARTH = 16, S_MAG = 30, S_FULL = 31}

enum {TE_RES_NOACT, TE_RES_TICK, TE_RES_UPGRADE, TE_RES_DGRADE, TE_RES_REMOVE}
#list for values modified by crits, effects etc

var dmg_mod_list = ['+damage_hp', "+hp", '+restore_mana', '+lust', '+obedience', '+loyalty', '+consent', '+energy', '-damage_hp', "-hp", '-restore_mana', '-lust', '-obedience', '-loyalty', '-energy','no_stat'] #not sure about these
#list for values modified by random_mod
var dmg_rnd_list = ['damage_hp', 'restore_mana', 'hp', 'mp', 'lust', 'obedience', 'loyalty', 'fatigue', 'exhaustion', 'energy']
#list for values with relative values
var dmg_rel_list = ['hp', 'mp', 'lust', 'obedience', 'loyalty', 'consent', 'exhaustion', 'energy', 'base_exp','physics_factor','wits_factor','charm_factor','sexuals_factor','tame_factor','timid_factor','brave_factor','growth_factor']
#list for various types of damage mods
var damage_mods_list = ['all','melee','ranged','normal','fire','earth','air','water','light','dark','mind','physic','spell', 'skill', 'aoe', 'true', 'heal']

var resists_list = ['normal','fire','earth','air','water','light','dark','mind','all']
var resists_damage_list = ['melee', 'ranged', 'aoe', 'heal']
var status_list = ['stun','freeze','disarm','silence','burn','confuse','bleed','poison']
var fighter_stats_list = ['hpmax','mpmax','atk','matk','armor','mdef','hitrate','evasion','armorpenetration','speed', 'critchance','critmod']


var enemy_rarechance = 0.1
var enemy_doublerarechance = 0.1
var rare_enemy_traits = ['rare_sturdy', 'rare_nimble', 'rare_strong', 'rare_deadly', 'rare_precise']

#list for stats with stored bonuses that use generic getter (not custom getter!!)
#to add them all :)
var bonuses_stat_list = ['productivity','mod_collect','speed','hitrate','evasion','armor','mdef','critchance', 'critmod', 'armorpenetration', 'lusttick','mod_build','mod_hunt','mod_fish','mod_collect','mod_cook','mod_smith','mod_tailor','mod_alchemy','mod_farm','mod_pros', 'hp_reg_mod', 'mp_reg_mod']
#list for stats that do not uses bonuses system
#imho must include all of dmg_rel stats
var direct_access_stat_list = ['hp', 'mp', 'lust', 'obedience', 'loyalty', 'submission', 'energy', 'physics_bonus', 'wits_bonus','charm_bonus','sexuals_bonus','physics_factor','wits_factor','charm_factor','tame_factor','timid_factor', 'sexuals_factor','magic_factor','growth_factor', 'food_consumption', 'consent', 'physics','wits','charm']


var productivity_mods = ['mod_build','mod_hunt', 'mod_fish','mod_collect','mod_cook','mod_smith','mod_tailor','mod_alchemy','mod_farm','mod_pros']

var longtails = ['fox','cat','wolf','dragon','demon','tanuki','fish','lizard']
var longears = ['fox','cat','wolf','bunny_standing','bunny_drooping','elven','tanuki']

var impregnation_compatibility = ['Human','Elf','DarkElf','TribalElf','Beastkin','Halfkin'] #the rest is only for same race
var inheritedassets = ['ears','eye_color','eye_shape', 'hair_color', 'horns', 'tail', 'wings', 'skin_coverage', 'arms', 'legs', 'body_shape']
var inheritedstats = ['growth_factor','magic_factor','physics_factor','wits_factor','charm_factor','sexuals_factor']
var work_rules = ['ration', 'shifts', 'constrain', 'luxury', 'contraceptive', 'bindings', 'nudity', 'personality_lock']
var brothel_rules = ['waitress', 'hostess', 'dancer', 'stripper', 'petting', 'oral', 'anal', 'penetration', 'pussy', 'group', 'sextoy', 'males', 'females','futa']
var brothel_non_sex_options = ['waitress','hostess','dancer','stripper']
var farming_rules = ['milk', 'pheromones', 'seed', 'eggs', 'magic_dust', 'reptile_blood', 'spider_silk', 'draconic_scales', 'light_essence', 'dark_essence', 'lizard_skin', 'leatherdragon']

var skin_coverage_false = ['scale','fur_white','fur_grey','fur_brown','fur_stripped','fur_black','fur_orange','fur_orange_white'] #list of skincoverage blocking skin desription
var booster_tiers = {
	1:['milk', 'pheromones', 'seed'],
	2:['eggs', 'magic_dust', 'reptile_blood', 'spider_silk'],
	3:['draconic_scales', 'light_essence', 'dark_essence']
}
var booster_value = [2.0, 4.0, 8.0]
var farm_produce_slots = 2
var farm_produce_slots_per_upgrade = 1

var system_messages = {
	no_resources = "MESSAGE_NORESOURCE",
	no_crafting_item = "MESSAGE_NOCRAFTINGITEM",

}
var enemy_types = {
	bandit = "ENEMYTYPEBANDITS",
	wolf = "ENEMYTYPEWOLVES",
	undead = "ENEMYTYPEUNDEAD",
	goblin = "ENEMYTYPEGOBLIN"
}

var hexcolordict = {
	red = '#ff5e5e',
	yellow = "#ffff00",
	brown = "#8B572A",
	gray = "#4B4B4B",
	gray_text_dialogue = "#90d4aa",
	green = '#00b700',
	white = '#ffffff',
	aqua = '#24ffdb',
	pink = '#f824ff',
	factor1 = '#ff5e5e',
	factor2 = '#f6922a',
	factor3 = '#4dff83',
	factor4 = '#13a40d',
	factor5 = '#25b8ff',
	factor6 = '#bc53ff',
	levelup_text_color = "#10ff10",
	k_yellow = "#f9e181",
	k_yellow_dark = "#99836f",
	k_gray = "#e0e0e0",
	k_green = "#51fe84",
	k_red = "#fe515d",
	magenta = "#ff84ff",
	unique = '#D4AF37',
	quality_poor = '#4B4B4B',
	quality_average = '#ffffff',
	quality_good = '#00b700',
	quality_epic = '#ff84ff',
	quality_legendary = '#D4AF37',
	
}


var textcodedict = { #not used for some reason...
	color = {start = '[color=', end = '[/color]'},
	url = {start = '[url=',end = '[/url]'}
}

var gearlist = ['chest', 'gloves', 'boots', 'rhand', 'lhand', 'neck', 'ring1', 'ring2']
#var punishcategories = ['spanking', 'whipping', 'nippleclap', 'clitclap', 'nosehook', 'mashshow', 'facesit', 'afacesit', 'grovel']

var LocalizationFolder = "res://localization/"
#var state

var userfolder = 'user://'
var portraits_folder = 'user://userportraits/'
var portrait_width = 250
var portrait_height = 250

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

var sex_factor_skill_multiplier = {
	1 : 0.5,
	2 : 0.75,
	3 : 1.0,
	4 : 1.33,
	5 : 1.75,
	6 : 2.2,
}

var growth_factor = {
1 : 150,
2 : 70,
3 : 30,
4 : 10,
5 : 3,
6 : 1,
}

var basestats_factor_mod = {
1 : 0.5,
2 : 0.67,
3 : 1,
4 : 1.3,
5 : 1.65,
6 : 2,
}

var growth_factor_upgrade = {
1 : 0,
2 : 1000,
3 : 2000,
4 : 3500,
5 : 5000,
6 : 10000,
}

var growth_factor_cost_mod = {
	1 : 1,
	2 : 1.2,
	3 : 1.7,
	4 : 2.5,
	5 : 3.5,
	6 : 5
}

var basestat_factor_upgrade = {
1 : 0,
2 : 100,
3 : 300,
4 : 500,
5 : 750,
6 : 1500,
}

#slave & quest timings

var guild_slave_update_time = 7
var guild_quest_update_time = 3


#mansion & ugprades
var base_population_cap = 5
var population_cap_per_room_upgrade = 5
var max_population_cap = 30
var stable_boost_per_level = 1

#Items

var material_sell_multiplier = 0.5
var crafter_material_sell_multiplier = 0.5
var item_sell_multiplier = 0.75

#Heroes
var all_races_array = []
var starting_races_array = ['Human','Elf','TribalElf','Orc','BeastkinCat', 'BeastkinFox', 'BeastkinWolf', 'BeastkinBunny','HalfkinCat', 'HalfkinFox', 'HalfkinWolf', 'HalfkinBunny']

var master_starting_classes = ['fighter','archer','worker','rogue','apprentice','hunter','acolyte']
var slave_starting_classes = ['attendant', 'fighter', 'archer', 'worker', 'harlot', 'apprentice','hunter','acolyte']

var fighters_starting_classes = ['fighter','archer','rogue']
var mages_starting_classes = ['apprentice','scholar','acolyte']
var servants_starting_classes = ['harlot','pet','petbeast','thief','attendant']
var workers_starting_classes = ['worker','hunter','farmer']

var guild_order = ['fighters','workers','servants','mages','slavemarket']

var master_starting_stats = 10
var slave_starting_stats = 15

var minimum_factor_value = 1
var maximum_factor_value = 6

var basic_character_atk = 15
var basic_character_matk = 15

var enslavement_price = 100

var basestat_cap = 100

var power_adjustments_per_difficulty = {
	easy = [1,2],
	medium = [2,4],
	hard = [3,6]
}
var difficulty_per_level = 0.05 #% enemy stat increase
var slave_class_list = ['slave', 'servant', 'heir', 'master']#incomplete?
#sex chances

var teen_age_weight = 1
var adult_age_weight = 1
var mature_age_weight = 1

var furry_multiple_nipples_number = 3

var female_vagina_virgin_default_chance = 50
var male_penis_virgin_default_chance = 50
var female_ass_virgin_default_chance = 90
var male_ass_virgin_default_chance = 90

var hard_level_reqs = [150,250,400,650,900,1250,1750,2500,3350,4100,5000]

#Slave values
var slave_basic_sizes = ['masculine','flat','small','average','big','huge']
var slave_genital_sizes = ['small','average','big']
var slave_heights = ['tiny','petite','short','average','tall','towering']

var stat_description = {
	1:"[color=white]Very Low[/color]",
	2:'[color=green]Low[/color]',
	3:"[color=blue]Average[/color]",
	4:"[color=purple]Good[/color]",
	5:"[color=yellow]Great[/color]",
	6:"[color=red]Superb[/color]"
}

var basic_max_hp = 100
var basic_max_mp = 30
var basic_hp_regen = 6
var basic_mp_regen = 1.2
var mp_regen_per_magic = 0.1
var max_mp_per_magic_factor = 10
var basic_obed_drain = 20
var basic_max_obed = 100

var basic_lust_per_tick = 0.57 * 6

var authority_lines = { #possibly obsolete
	low = "Defiance",
	medium = "Respect",
	high = 'Reverence',
}


var base_loan_sum = [1000, 3000, 10000, 30000]
var base_loan_dates = [15, 29, 50, 99]

# obsolete
#var obed_mod_per_difficuty = {
#	easy = 1.0,
#	medium = 0.5,
#	hard = 0.25
#}
#
#
#var authority_threshold_base = 200
#var authority_threshold_per_timid = 25


var master_charm_quests_gold_bonus = {
	1 : 0,
	2 : 0.05,
	3 : 0.1,
	4 : 0.2,
	5 : 0.3,
	6 : 0.4,
}
var master_charm_quests_rep_bonus = {
	1 : 0,
	2 : 0.05,
	3 : 0.1,
	4 : 0.15,
	5 : 0.2,
	6 : 0.25,
}


#World settings
var dungeon_encounter_chance = 0.2
var dungeon_unique_encounter_chance = 0.1
var exp_scroll_quest_reward = false

var subroom_chance = 0.7
#var additional_subroom_chance = 0.9 #0.2
var additional_subroom_chance = 0.2

#debug_only
var allow_remote_intereaction = false
var no_event_wait_time = false
var ignore_quest_requirements = false

var generate_test_chars = true
var combat_tests = false #for combat testing
var ai_setup = 'old' # 'off' - no setup, 'old' - using data convertion, 'new' - pass data as is



var base_work_increment = 0.85
var stat_work_increment = 1.4



var new_stat_bonuses_syntax = false


var pregenabled = true
var brothel_pregnancy_chance = 0.1
var pregduration = 120
var tutduration = 14 #days

var slave_classes_per_difficulty = {
	0 : [0, 0],
	1 : [0, 0],
	2 : [0, 1],
	3 : [0, 1],
	4 : [0, 2],
	5 : [0, 2],
	6 : [0, 2],
	7 : [0, 3],
	8 : [0, 3],
	9 : [0, 3],
	10 : [0, 4],
	11 : [0, 4],
	12 : [0, 4],
	13 : [0, 4],
	14 : [0, 4],
	15 : [0, 4],
}



var autosave_number_min = 0
var autosave_number_max = 10
var autosave_frequency_min = 1
var autosave_frequency_max = 30


var personality_array = ['neutral','kind','bold','shy','serious']
var dynamic_text_vars = ['name', 'He','he', 'his', 'him', "His", 'raceadj', 'race','age', 'male', 'eye_color','hair_color', 'boy']

#editor data
var atomic_types = ['kill','damage','heal','mana','stat_set','stat_set_revert','stat_add','stat_mul','stat_add_p','bonus','remove_effect','remove_all_effects','add_trait','add_sex_trait','unlock_sex_trait','resurrect','use_combat_skill','use_social_skill','add_soc_skill','add_combat_skill','sfx', 'add_tag']
var char_dmg_stats = ['no_stat//prev value', 'hp', 'mp', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion', 'energy', 'physics_bonus', 'taunt', 'shield', 'damage_hp', 'restore_mana', 'wits_bonus','charm_bonus','sexuals_bonus','physics_factor','wits_factor','charm_factor','tame_factor',
'sexuals_factor','magic_factor','growth_factor', 'food_consumption']#incomplete
var ss_dmg_stats = ['value']
var damagestat_list = ['no_stat', 'hp', 'mp', 'lust', 'obedience', 'fear', 'loyal', 'fatigue', 'exhaustion',  'energy', 'physics_bonus', 'taunt', 'shield', 'damage_hp', 'restore_mana']#possibly incomplete
var condtypes = ['conditional static//oneshot', 'random', 'skill', 'caster', 'target', 'owner(skill)', 'owner(character)']
#var char_condtypes = ['stats', 'stat_index', 'gear', 'race', 'trait', 'class', 'dead']
var ops = ['==', '!=', '>=', '>', '<=', '<', 'has', '!has']
var real_ops = ['eq', 'neq', 'gte', 'gt', 'lte', 'lt', 'has', 'hasno']
var skill_condstats = ['name', 'type', 'ability_type', 'tags', 'damage_type']
var char_condstats = ['hp', 'hpmax', 'mp', 'mpmax', 'is_players_character', 'age', 'sex', 'physics_factor', 'magic_factor', 'tame_factor', 'brave_factor', 'growth_factor', 'charm_factor', 'wits_factor', 'sexuals_factor']#incomplete
var char_indexstats = ['counters', 'bonuses']#possibly incomplete
var eventlist = ['TR_CAST','TR_HIT', 'TR_DEF', 'TR_TURN_S', 'TR_TURN_GET', 'TR_TURN_F', 'TR_DEATH', 'TR_KILL', 'TR_DMG', 'TR_POSTDAMAGE', 'TR_SKILL_FINISH', 'TR_HEAL', 'TR_COMBAT_S', 'TR_COMBAT_F', 'TR_DAY', 'TR_S_CAST', 'TR_S_TARGET', 'TR_TICK', 'TR_MOVE', 'TR_REMOVE']
var eventhelp = [self.TR_CAST, self.TR_HIT, self.TR_DEF, self.TR_TURN_S, self.TR_TURN_GET, self.TR_TURN_F, self.TR_DEATH, self.TR_KILL, self.TR_DMG, self.TR_POSTDAMAGE, self.TR_SKILL_FINISH, self.TR_HEAL, self.TR_COMBAT_S, self.TR_COMBAT_F, self.TR_DAY, self.TR_S_CAST, self.TR_S_TARGET, self.TR_TICK, self.TR_MOVE, self.TR_REMOVE]
var short_res = [self.RES_HITCRIT, self.RES_CRIT, self.RES_MISS]
var eventdesc = ['skill used by caster','before skill take effect per target', 'before skill take effect on target', 'beginning of combat turn', 'character get action', 'character ends action', 'character is dead', 'character kills opponent', 'character is damaged', 'after skill take effect per target', 'skill using is completed', 'character is healed', 'combat start', 'combat end', 'per day', 'social skill is used', 'social skill used on target', 'per hour', 'character changes location', 'character is removed from player']
var targetlist = ['not a trigger child', 'self', 'skill', 'caster', 'target', 'receiver', 'owner', 'parent']
var effecttypes = ['oneshot', 'static', 'trigger','temp_s','temp_p','temp_u','c_static', 'dynamic']
var effectdesc = ['oneshot', 'static', 'trigger','temp_s','temp_p','temp_u','c_static', 'dynamic']
var argtypes = ['self','parent','template','app_obj','parent_args','parent_arg_get']
var argtypesdesc = ['outside assigned argument of effect instance',"parameter of effect's parent",'argument defined in effect template','parameter of object effect applied to','runtime argument of parent effect','parameter of runtime argument of parent effect']
var receiver_list = ['target', 'caster', 'all']
var bodypart_list = ['skin', 'height', 'hair_length', 'hair_color', 'hair_style', 'ears', 'eye_color', 'eye_shape', 'horns', 'wings', 'tail', 'arms', 'legs', 'body_lower', 'body_shape', 'skin_coverage', 'fur', 'facial_hair', 'penis_size', 'penis_type', 'balls_size', 'tits_size', 'vagina', 'ass_size', 'has_pussy', 'multiple_tits', 'multiple_tits_developed', 'has_womb','lactation', 'penis_virgin', 'vaginal_virgin', 'anal_virgin', 'mouth_virgin']
var slots = ["chest","underwear", "legs", "hands", "rhand", "lhand", "neck", "head", "ass", "croach"]
var interactioneffs = ['alcohol','aphrodisiac','sensitivity_pot']


var personality_conversion_rates = {
	bold = 0.65,
	shy = 0.1,
	kind = 0.2,
	serious = 0.5
}

var reputation_tresholds = [0, 300, 500, 1000, 1500]

var itemquality_multiplier = {
	"" : 1.0,
	poor = 1.0,
	average = 1.1,
	good = 1.25,
	epic = 1.4,
	legendary = 1.75
}

var enchantment_chance = 0.15
var enchantment_chance_2 = 0.4
var enchantment_chance_3 = 0.2
var curse_chance = 0.25
var majorcurse_chance = 0.3

var roman_numbers = {
	1: "I",
	2: "II",
	3: "III",
	4: "IV",
	5: "V",
	6: "VI",
	7: "VII",
	8: "VIII",
	9: "IX",
	10: "X",
	
}

var quality_colors = {
	poor = load("res://assets/images/iconsitems/quality_bg/gray.png"),
	average = load("res://assets/images/iconsitems/quality_bg/green.png"),
	good = load("res://assets/images/iconsitems/quality_bg/blue.png"),
	epic = load("res://assets/images/iconsitems/quality_bg/purple.png"),
	legendary = load("res://assets/images/iconsitems/quality_bg/orange.png"),
	
}

var factor_personality_changes = { #chance of change of primary and seondary axies based on tame/timid factors
	1 : [50, 100],
	2 : [60, 50],
	3 : [70, 33],
	4 : [80, 25],
	5 : [90, 10],
	6 : [100, 0]
}

var mentorship_list = ['loyalty_basic_servitude', 'loyalty_combatant']
