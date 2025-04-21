extends Node
var exterior_stats_composite = ['hair_length'] #stats that are NOT backuped but used in regeneration procedure
var sex_binded_exterior = {
	beard = 'no',
	balls_size = '',
	tits_size = '',
	ass_size = '',
	penis_size = '',
	has_pussy = false,
	has_womb = false,
	chin = 'default',
	eye_tex = 'eyes1',
	eyebrows = 'style1',
	hair_base_length = '', 
	hair_fringe_length = '', 
	hair_back_length = '', 
	hair_assist_length = '',
}

var template_direct = {
	#basic
	is_hirable = false, #allows character to be hired from its tab
	hire_scene = '',
	unique = null,
	name = '',
	surname = '',
	nickname = '',
	bonus_description = '',
	race = 'Human',
	racegroup = 'humanoid',
	age = '',
	sex = 'male',
	masternoun = tr('PROFMASTER'),
	
	#numeric
	lust = 0.0,
	physics = 0.0,
	wits = 0.0,
	charm = 0.0,
	
	consent = 0,
	lastsexday = 0,
	asser = 0, #shuold be removed fo no real use
	
	#constant stats
	physics_factor = 1,
	magic_factor = 1,
	tame_factor = 1,
	authority_factor = 1, #authority factor
	growth_factor = 1,
	charm_factor = 1,
	wits_factor = 1,
	sexuals_factor = 1,
	
	#images
	icon_image = '', 
	dynamic_portrait = true,
	portrait_update = true,
	body_image = 'default',
	player_selected_icon = false,
	player_selected_body = false,
	unique_variation = null,
	
	#personality
	personality_bold = 0,
	personality_kind = 0,
	old_personality = 'kind',
	
	#other
	slave_class = '',
	
	#enemy combat/reward data
	xpreward = 10,
	loottable = "",
	
	#challenge charages
	chg_strength = 0,
	chg_dexterity = 0,
	chg_wisdom = 0,
	chg_persuasion = 0,
	
	#helpers
#	personality = '',
#	sexuals = 0.0,
#	skin = 'fair',
#	penis_virgin = true,
#	vaginal_virgin = true,
#	anal_virgin = true,
#	mouth_virgin = true,
	hair_length = 'ear', #hate to store those - but they are not orthogonal
	hair_color = 'black',
	hair_style = 'straight',
#	pose = 'default',
	
	#appearance
	height = 'average',
	ears = 'normal',
	eye_color = 'brown',
	eye_shape = 'normal',
	horns = '',
	wings = '',
	tail = '',
	arms = 'normal',
	legs = 'normal',
	body_lower = '',
	body_shape = 'humanoid',
	skin_coverage = '',
	facial_hair = '',
	#new ones
	eyeshape = 'face1',
	nose = 'default',
	lips = 'style1',
	
	#new skin, empty values SHOULD be set in remade char generating function or kept empty to indicate derivative nature
	body_color_skin = '', 
	body_color_wings = '', 
	body_color_tail = '', 
	body_color_horns = 'yellow3', 
	body_color_animal = '', 
	#new hair, empty values SHOULD be set in remade char generating function or kept empty to indicate derivative nature
	hair_base = '', 
	hair_assist = '', 
	hair_back = '', 
	hair_fringe = '', 
	hair_base_color_1 = '', 
	hair_fringe_color_1 = '', 
	hair_back_color_1 = '', 
	hair_assist_color_1 = '', 
	hair_base_color_2 = '', 
	hair_fringe_color_2 = '', 
	hair_back_color_2 = '', 
	hair_assist_color_2 = '', 

	hair_facial_color = "",
	
	#genitals
	
	penis_type = 'human',
	vagina = '',
	multiple_tits = 0,
	multiple_tits_developed = false,
	lactation = false,
	
	penis_virgin_lost = null,
	vaginal_virgin_lost = null,
	anal_virgin_lost = null,
	mouth_virgin_lost = null,
	
	#marriage
	was_proposed = false,
	had_cons_sex_with_mc = false,
	had_forced_sex_with_mc = false,
	agreed_to_marry = false,
}
var sexexp = {
	sexexp_partners = {}, 
	sexexp_watchers = {}, 
	sexexp_actions = {}, 
	sexexp_seenactions = {}, 
	sexexp_orgasms = {}, 
	sexexp_orgasmpartners = {},
}
var sex_skills = {
	sex_skills_petting = 0, 
	sex_skills_penetration = 0, 
	sex_skills_pussy = 0, 
	sex_skills_oral = 0, 
	sex_skills_anal = 0, 
	sex_skills_tail = 0,
}
var metrics = {
	metrics_ownership = 0, 
	metrics_sex = 0, 
	metrics_dates = 0, 
	metrics_partners = [], 
	metrics_randompartners = 0, 
	metrics_win = 0, 
	metrics_kills = 0, 
	metrics_goldearn = 0, 
	metrics_foodearn = 0, 
	metrics_materialearn = 0, 
	metrics_serviceperformed = 0, 
	metrics_socskillused = 0, 
	metrics_spellused = 0, 
	metrics_healused = 0, 
	metrics_foodeaten = 0, 
	metrics_birth = 0, 
	metrics_pregnancy = 0, 
	metrics_impregnation = 0,
}
var piercing = {
	piercing_earlobes = null, 
	piercing_eyebrow = null, 
	piercing_nose = null, 
	piercing_lips = null, 
	piercing_tongue = null, 
	piercing_navel = null, 
	piercing_nipples = null, 
	piercing_clit = null, 
	piercing_labia = null, 
	piercing_penis = null,
}
var armor_color = {
	armor_color_base = 'default',
	armor_color_lower = 'default',
	armor_color_collar = 'default',
	armor_color_weapon = 'default',
	armor_color_underwear = 'default',
}
var pregnancy = {
	pregnancy_fertility = 0, 
	pregnancy_duration = 0, 
	pregnancy_baby = null, 
	pregnancy_reported = false 
}
var tattoo = {
	tattoo_face = null, 
	tattoo_neck = null, 
	tattoo_arms = null, 
	tattoo_legs = null, 
	tattoo_chest = null, 
	tattoo_crotch = null, 
	tattoo_waist = null, 
	tattoo_ass = null
}


var template_dynamic = {
	#
	trainee_amount = 0,
	
	lusttick = variables.basic_lust_per_tick,
	hpmax = variables.basic_max_hp,
	mpmax = 50,
	hp_reg = variables.basic_hp_regen,
	mp_reg = variables.basic_mp_regen,
	damage_reduction = 0,
	magic_find = 0,
	atk = variables.basic_character_atk,
	matk = variables.basic_character_matk,
	damagetype = 'normal',
	hitrate = 100,
	evasion = 0,
	armor = 0,
	mdef = 0,
	armorpenetration = 0,
	critchance = 10,
	critmod = 1.5,
	speed = 30,
	taunt = null,
	productivity = 100.0,
	#productivity mods
	mod_build = 1.0,
	mod_collect = 1.0,
	mod_hunt = 1.0,
	mod_fish = 1.0,
	mod_cook = 1.0,
	mod_smith = 1.0,
	mod_tailor = 1.0,
	mod_alchemy = 1.0,
	mod_farm = 1.0,
	mod_pros = 1.0,
	mod_service = 1.0,
	mod_waitress = 1.0,
	mod_hostess = 1.0,
	mod_dancer = 1.0,
	mod_strip = 1.0,
	base_task_crit_chance = 0.0,
	
	exp_gain_mod = 1.0,
	manacost_mod = 1.0,
	
	burn_mod = 1.0,
	burn_damage = 0.07,
	darkflame_damage = 0.1,
	poison_mod = 1.0,
	poison_damage = 0.1,
	bleed_mod = 1.0,
	bleed_damage = 0.1,
	
	physics_bonus = 0.0,
	physics_cap = variables.basestat_cap,
	wits_bonus = 0.0,
	wits_cap = variables.basestat_cap,
	sexuals_bonus = 0.0,
	charm_bonus = 0.0,
	charm_cap = variables.basestat_cap,
	
	#challenge charages
	chg_strength_max = 0,
	chg_dexterity_max = 0,
	chg_wisdom_max = 0,
	chg_persuasion_max = 0,
	
	#mastery_points
	mastery_point_magic = 0,
	mastery_point_universal = 0,
	mastery_point_combat = 0,
	
	#food
	food_consumption = 1,
	
	#training
	training_loyalty = 0,
	training_spirit = 0,
	
	#helpers
#	upgrade_points_total = 0, 
#	lustmax = 50,
}
var manacost_mods = {
	manacost_mod_all = 1.0,
	manacost_mod_melee = 1.0, 
	manacost_mod_ranged = 1.0, 
	manacost_mod_normal = 1.0, 
	manacost_mod_fire = 1.0, 
	manacost_mod_earth = 1.0, 
	manacost_mod_air = 1.0, 
	manacost_mod_water = 1.0, 
	manacost_mod_light = 1.0, 
	manacost_mod_dark = 1.0, 
	manacost_mod_mind = 1.0, 
	manacost_mod_physic = 1.0, 
	manacost_mod_spell = 1.0, 
	manacost_mod_skill = 1.0, 
	manacost_mod_aoe = 1.0, 
	manacost_mod_true = 1.0, 
	manacost_mod_heal = 1.0,
}
var resists = {
	resist_normal = 0.0,
	resist_fire = 0.0,
	resist_earth = 0.0,
	resist_air = 0.0,
	resist_water = 0.0,
	resist_light = 0.0,
	resist_dark = 0.0,
	resist_mind = 0.0,
	resist_melee = 0.0,
	resist_ranged = 0.0,
	resist_aoe = 0.0,
	resist_heal = 0.0,
	resist_stun = 0.0,
	resist_freeze = 0.0,
	resist_disarm = 0.0,
	resist_silence = 0.0,
	resist_burn = 0.0,
	resist_confuse = 0.0,
	resist_bleed = 0.0,
	resist_poison = 0.0,
	resist_wet = 0.0,
	resist_shock = 0.0,
	resist_fear = 0.0,
	resist_cursed = 0.0,
}
var damage_mods = { 
	damage_mod_all = 1.0,
	damage_mod_melee = 1.0,
	damage_mod_ranged = 1.0,
	damage_mod_normal = 1.0,
	damage_mod_fire = 1.0,
	damage_mod_earth = 1.0,
	damage_mod_air = 1.0,
	damage_mod_water = 1.0,
	damage_mod_light = 1.0,
	damage_mod_dark = 1.0,
	damage_mod_mind = 1.0,
	damage_mod_physic = 1.0,
	damage_mod_spell = 1.0,
	damage_mod_skill = 1.0,
	damage_mod_aoe = 1.0, 
	damage_mod_true = 1.0,
	damage_mod_heal = 1.0,
}
