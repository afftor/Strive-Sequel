extends Node

var statdata = {
	base_exp = {
		code = 'base_exp',
		name = '',
		descript = '',
		baseicon = 'stat_exp',
		type = 'misc',
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
	authority = {
		code = 'authority',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		direct = true
	},
	loyalty = {
		code = 'loyalty',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
		direct = true
	},
	submission = {
		code = 'submission',
		name = '',
		descript = '',
		baseicon = 'stat_df',
		type = '',
	},
	physics = { 
		code = 'physics',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		direct = true
	},
	wits = { 
		code = 'wits',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		direct = true
	},
	charm = { 
		code = 'charm',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		direct = true
	},
	sexuals = { 
		code = 'sexuals',
		name = '',
		descript = '',
		baseicon = 'stat_bf',
		type = 'primal',
		custom_get = true
	},
	obedience = {
		code = 'obedience',
		name = '',
		descript = '',
		baseicon = 'stat_obed',
		type = 'mental_stat',
		direct = true
	},
	loyaltyObedience = {
		code = 'loyaltyObedience',
		name = 'STATOBEDIENCE',
		descript = 'STATOBEDIENCEDESCRIPT',
		baseicon = 'stat_obed',
		type = 'mental_stat',
	},
	submissionObedience = {
		code = 'submissionObedience',
		name = 'STATOBEDIENCE',
		descript = 'STATOBEDIENCEDESCRIPT',
		baseicon = 'stat_obed',
		type = 'mental_stat',
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
	loyalty_gain_mod = {
		code = 'loyalty_gain_mod',
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
		default_bonus = 'add_part'
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
	mpmaxmod = {
		code = 'mpmaxmod',
		name = '',
		descript = '',
		percent = true,
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
	},
	matk = {
		code = 'matk',
		name = '',
		descript = '',
		baseicon = 'food_love',
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
	task_crit_chance = {
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
		percent = true,
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
	
	obDrainReduction = {
		code = 'obDrainReduction',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
		default_bonus = 'mul'
	},
	obDrainIncrease = {
		code = 'obDrainIncrease',
		name = '',
		descript = '',
		percent = true,
		baseicon = 'food_love',
	},
	authority_mod = {#never applied stat for some reasons
		code = 'authority_mod',
		name = '',
		descript = '',
		baseicon = 'food_love',
		default_bonus = 'add_part'
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
}

var slave_class_names = {
	'slave' : 'Slave',
	servant = 'Peon',
	'master' : '[Master]',
	hireling = 'Hireling',
}

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
	
	for val in statdata.values():
		if !val.has('percent'): val.percent = false
		if !val.has('default_bonus'): val.default_bonus = 'add'
		if !val.has('direct'): val.direct = false
		if !val.has('custom_get'): val.custom_get = false
		if !val.has('skip_process'): val.skip_process = false
	
#	for st in statdata:
#		print("'%s':" % st)
#		print("\t %s" % statdata[st].default_bonus)
#		if statdata[st].percent: print("\t percent conversion")
#	print('\n')
