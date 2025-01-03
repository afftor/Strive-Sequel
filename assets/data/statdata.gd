extends Node

var statdata = {
	base_exp = {
		code = 'base_exp',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
	},
	
	mastery_point_magic = {
		code = 'mastery_point_magic',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		skip_process = true,
		show_in_header = true
	},
	mastery_point_universal = {
		code = 'mastery_point_universal',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		skip_process = true,
		show_in_header = true
	},
	mastery_point_combat = {
		code = 'mastery_point_combat',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
		skip_process = true,
		show_in_header = true
	},
	
	growth_factor = {
		code = 'growth_factor',
		name = '',
		descript = '',
		baseicon = 'stat_gf',
		type = 'factor',
		abb = 'GRO',
		direct = true
	},
	physics_factor = {
		code = 'physics_factor',
		name = '',
		descript = '',
		baseicon = 'stat_pf',
		type = 'factor',
		abb = 'PHY',
		direct = true
	},
	wits_factor = {
		code = 'wits_factor',
		name = '',
		descript = '',
		baseicon = 'stat_wit',
		type = 'factor',
		abb = 'WIT',
		direct = true
	},
	charm_factor = {
		code = 'charm_factor',
		name = '',
		descript = '',
		baseicon = 'stat_charm',
		type = 'factor',
		abb = 'CHA',
		direct = true
	},
	physics_cap = {
		code = 'physics_cap',
		name = '',
		descript = '',
		baseicon = 'stat_pf',
		type = 'cap',
		abb = 'PHY',
		custom_get = true
	},
	wits_cap = {
		code = 'wits_cap',
		name = '',
		descript = '',
		baseicon = 'stat_wit',
		type = 'cap',
		abb = 'WIT',
		custom_get = true
	},
	charm_cap = {
		code = 'charm_cap',
		name = '',
		descript = '',
		baseicon = 'stat_charm',
		type = 'cap',
		abb = 'CHA',
		custom_get = true
	},
	sexuals_factor = {
		code = 'sexuals_factor',
		name = '',
		descript = '',
		baseicon = 'stat_sf',
		type = 'factor',
		abb = 'SEX',
		direct = true
	},

	magic_factor = {
		code = 'magic_factor',
		name = '',
		descript = '',
		baseicon = 'stat_mf',
		type = 'factor',
		abb = 'MAG',
		direct = true
	},

	tame_factor = {
		code = 'tame_factor',
		name = '',
		descript = '',
		baseicon = 'stat_tf',
		type = 'factor',
		abb = 'TAM',
		direct = true
	},
	timid_factor = {
		code = 'timid_factor',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = 'factor',
		abb = 'TIM',
		direct = true
	},
	physics = {
		code = 'physics',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		direct = true,
		custom_get = true
	},
	wits = {
		code = 'wits',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		direct = true,
		custom_get = true
	},
	charm = {
		code = 'charm',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		direct = true,
		custom_get = true
	},
	sexuals = {
		code = 'sexuals',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		custom_get = true
	},
	fear = {
		code = 'fear',
		name = '',
		descript = '',
		baseicon = 'stat_fear',
		type = 'mental_stat',
	},
	lust = {
		code = 'lust',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		direct = true
	},
	loyal = {
		code = 'loyal',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
	},
	loyalty = {
		code = 'loyalty',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
	},
	spirit = {
		code = 'spirit',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
	},
	training_loyalty = {
		code = 'training_loyalty',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	training_spirit = {
		code = 'training_spirit',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	trainee_amount = {
		code = 'trainee_amount',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	personality_bold = {
		code = 'personality_bold',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	personality_kind = {
		code = 'personality_kind',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	personality_shy = {
		code = 'personality_shy',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	personality_serious = {
		code = 'personality_serious',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	exp_gain_mod = {
		code = 'exp_gain_mod',
		percent = true,
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
	},
	manacost_mod = {
		code = 'manacost_mod',
		percent = true,
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
	},
	lusttick = {
		code = 'lusttick',
		name = '',
		descript = '',
		baseicon = 'stat_cf',
		type = 'mental_stat',
		default_bonus = 'add_part',
		custom_get = true
	},
	food_consumption = {
		code = 'food_consumption',
		name = '',
		descript = '',
		baseicon = 'stat_food',
		type = 'misc',
		direct = true
	},

	food_hate = {
		code = 'food_hate',
		name = '',
		descript = '',
		baseicon = 'food_hate',
		type = 'misc',
	},
	food_love = {
		code = 'food_love',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},

	hp = {
		code = 'hp',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		direct = true
	},
	hpmax = {
		code = 'hpmax',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		custom_get = true
	},
	hpmaxmod = {
		code = 'hpmaxmod',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
	},
	hpfactor = {
		code = 'hpfactor',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
	},
	mp = {
		code = 'mp',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		direct = true
	},
	mpmax = {
		code = 'mpmax',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		custom_get = true
	},
	upgrade_points_total = {
		code = 'upgrade_points_total',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		custom_get = true
	},
	mpmaxmod = {
		code = 'mpmaxmod',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
	},
	hp_reg_mod = {
		code = 'hp_reg_mod',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
	},
	mp_reg_mod = {
		code = 'mp_reg_mod',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		type = 'misc',
	},
	hp_reg_add = {
		code = 'hp_reg_add',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	mp_reg_add = {
		code = 'mp_reg_add',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	hitrate = {
		code = 'hitrate',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	evasion = {
		code = 'evasion',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	speed = {
		code = 'speed',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	energy = {
		code = 'energy',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	fatigue = {
		code = 'fatigue',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	exhaustion = {
		code = 'exhaustion',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	atk = {
		code = 'atk',
		name = '',
		descript = '',
		baseicon = 'food_love',
		custom_get = true
	},
	matk = {
		code = 'matk',
		name = '',
		descript = '',
		baseicon = 'food_love',
		custom_get = true
	},
	armor = {
		code = 'armor',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	mdef = {
		code = 'mdef',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	damage_reduction = {
		code = 'damage_reduction',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
		custom_get = true
	},
	armorpenetration = {
		code = 'armorpenetration',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	critchance = {
		code = 'critchance',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	critmod = {
		code = 'critmod',
		percent = true,
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	price = { #not a real stat
		code = 'price',
		name = '',
		descript = '',
		baseicon = 'food_love',
		hidden = false
	},
	pricemod = { #not a real stat, stub for generating descriptions
		code = 'pricemod',
		name = 'STATPRICE',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'add_part',
		hidden = false
	},
	price_add = { #not a real stat, stub for generating descriptions
		code = 'price_add',
		name = 'STATPRICE',
		descript = '',
		baseicon = 'food_love',
		hidden = false
	},
	magic_find = {
		code = 'magic_find',
		name = '',
		descript = '',
		baseicon = 'food_love',
		type = 'misc',
	},
	
	physics_bonus = {
		code = 'physics_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true
	},
	wits_bonus = {
		code = 'wits_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true
	},
	charm_bonus = {
		code = 'charm_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true
	},
	sexuals_bonus = {
		code = 'sexuals_bonus',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true
	},
	productivity = {
		code = 'productivity',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_collect = {
		code = 'mod_collect',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_build = {
		code = 'mod_build',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_hunt = {
		code = 'mod_hunt',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_fish = {
		code = 'mod_fish',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_cook = {
		code = 'mod_cook',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_smith = {
		code = 'mod_smith',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_tailor = {
		code = 'mod_tailor',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_alchemy = {
		code = 'mod_alchemy',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_farm = {
		code = 'mod_farm',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_pros = {
		code = 'mod_pros',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_service = {
		code = 'mod_service',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_waitress = {
		code = 'mod_waitress',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_hostess = {
		code = 'mod_hostess',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_dancer = {
		code = 'mod_dancer',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	mod_strip = {
		code = 'mod_strip',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'add_part'
	},
	base_task_crit_chance = { # for char
		code = 'base_task_crit_chance',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
	},
	task_crit_chance = { # for item desc
		code = 'task_crit_chance',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		skip_process = true
	},
	task_efficiency_tool = {
		code = 'task_efficiency_tool',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		skip_process = true
	},
	consent = {
		code = 'consent',
		name = '',
		descript = '',
		direct = true,
		baseicon = 'food_love',
	},
	xpreward = {
		code = 'xpreward',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},

	damagemod = { #possibly obsolete
		code = 'damagemod',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		skip_process = true
	},
	#container stats
	resists = {
		code = 'resists',
		name = '',
		descript = '',
		baseicon = 'food_love',
		custom_get = true
	},
	status_resists = {
		code = 'status_resists',
		name = '',
		descript = '',
		baseicon = 'food_love',
		custom_get = true
	},
	resist_damage = {
		code = 'resist_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		custom_get = true
	},
	damage_mods = {
		code = 'damage_mods',
		name = '',
		descript = '',
		baseicon = 'food_love',
		custom_get = true
	},
	burn_mod = {
		code = 'burn_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
	},
	bleed_mod = {
		code = 'bleed_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
	},
	poison_mod = {
		code = 'poison_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
	},
	burn_damage = {
		code = 'burn_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		negative = true,
		default_bonus = 'mul'
	},
	bleed_damage = {
		code = 'bleed_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		negative = true,
		default_bonus = 'mul'
	},
	poison_damage = {
		code = 'poison_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		negative = true,
		default_bonus = 'mul'
	},
	darkflame_damage = {
		code = 'darkflame_damage',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		negative = true,
		default_bonus = 'mul'
	},
	enchant_capacity_mod = {
		code = 'enchant_capacity_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		percent = true,
		default_bonus = 'add_part'
	},
	enchant_capacity = {
		code = 'enchant_capacity',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	slave_class = {
		code = 'slave_class',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	
	chg_strength = {
		code = 'chg_strength',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true,
	},
	chg_strength_max = {
		code = 'chg_strength_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	chg_dexterity = {
		code = 'chg_dexterity',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true,
	},
	chg_dexterity_max = {
		code = 'chg_dexterity_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	chg_wisdom = {
		code = 'chg_wisdom',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true,
	},
	chg_wisdom_max = {
		code = 'chg_wisdom_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	chg_persuasion = {
		code = 'chg_persuasion',
		name = '',
		descript = '',
		baseicon = 'food_love',
		direct = true,
	},
	chg_persuasion_max = {
		code = 'chg_persuasion_max',
		name = '',
		descript = '',
		baseicon = 'food_love',
	},
	enabled_masteries = {
		code = 'enabled_masteries',
		name = '',
		descript = '',
		baseicon = 'food_love',
		default_bonus = 'array',
		array_type = 'mastery'
	},
	disabled_masteries = {
		code = 'disabled_masteries',
		name = '',
		descript = '',
		is_negative = true,
		baseicon = 'food_love',
		default_bonus = 'array',
		array_type = 'mastery'
	},
}

#var slave_class_names = {
#	'slave' : 'Slave',
#	servant = 'Peon',
#	'master' : '[Master]',
#	hireling = 'Hireling',
#	heir = "Heir",
#	spouse = "Spouse",
#	'slave_trained' : 'Trained Slave'
#}

var worktoolnames = {
	bow = '',
	axe = '',
	pickaxe = '',
	rod = '',
	sickle = '',
	hammer = '',
	hunt_knife = '',
}

func _ready():
	for i in variables.resists_list:
		statdata['resist_'+i] = {
				code = "resist_"+i,
			}
	for i in variables.status_list:
		statdata['resist_'+i] = {
				code = "resist_"+i,
			}
		statdata['resist_status_'+i] = {
				code = "resist_status_"+i,
			}
	for i in variables.resists_damage_list:
		statdata['resist_'+i] = {
				code = "resist_"+i,
			}
		statdata['resist_damage_'+i] = {
				code = "resist_damage_"+i,
			}
	for i in variables.damage_mods_list:
		statdata['damage_mod_'+i] = {
				code = "damage_mod_"+i,
				percent = true,
			}
	for i in Skilldata.masteries:
		statdata['mastery_'+i] = {
				code = "mastery_"+i,
				skip_process = true,
				show_in_header = true
			}
#		statdata['enable_mastery_'+i] = {
#				code = "enable_mastery_"+i,
#				default_bonus = 'set',
#				skip_process = true
#			}
	
	
	for val in statdata.values():
		if !val.has('percent'): val.percent = false
		if !val.has('default_bonus'): val.default_bonus = 'add'
		if !val.has('direct'): val.direct = false
		if !val.has('custom_get'): val.custom_get = false
		if !val.has('skip_process'): val.skip_process = false
		if !val.has('is_negative'): val.is_negative = false
		if !val.has('hidden'): val.hidden = false
		if !val.has('show_in_header'): val.show_in_header = false

#	for st in statdata:
#		print("'%s':" % st)
#		print("\t %s" % statdata[st].default_bonus)
#		if statdata[st].percent: print("\t percent conversion")
#	print('\n')
