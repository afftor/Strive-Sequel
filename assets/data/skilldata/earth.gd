extends Reference

var skills = {
	earth_shield = {
		code = 'earth_shield',
		descript = '',
		icon = load("res://assets/images/iconsskills/shield_earth.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_earthshield'], 
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth',#not sure but not matters
		sfx = [{code = 'earth_shield', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.matk']],
		damagestat = ['no_stat'],
		variations = [
			{
				reqs = [{code = 'stat', stat = 'mastery_earth', value = 3, operant = 'gte'}],
				set = {effects = ['e_s_earthshield_1']},
				add = {descript = '_1'}
			},
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {targetreqs = [{code = 'has_status', status = 'shield', check = false}],} #to prevent overuse of long-duration buffs
			}
		]
	},
	impale = {
		code = 'impale',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earth.png"), 
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'earth'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'bleed', duration = 1, chance = 0.5}),
			Effectdata.rebuild_template({effect = 'e_impale', duration = 3}),
		], 
		cost = {mp = 4},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth', 
		sfx = [{code = 'acid_bomb', target = 'target', period = 'predamage'}], #fix
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.85,
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {targetreqs = [{code = 'has_status', status = 'bleed', check = false}],} #to prevent overuse of low-damage long-duration ads, prefer bleed to impale cause of hp impact
			}
		]
	},
	acidbomb = {
		code = 'acidbomb',
		descript = '',
		icon = load("res://assets/images/iconsskills/AcidBomb.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'earth', 'damage_spot'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_shred', duration = 3})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {unstable_concoction = 1},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth', 
		sfx = [{code = 'acid_bomb', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 2.5,
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {combatcooldown = 3} #to prevent spaming, due to high priority and zero cost for AI, looking for shredable target is ineffective 
			}
		]
	},
	overgrowth = {
		code = 'overgrowth',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_plant.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','aoe','earth', 'ads'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_ensnare', chance = 0.5, duration = 2})], 
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'overgrowth', target = 'target_group', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.5,
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {combatcooldown = 2} #to prevent spaming, due to high priority and zero cost for AI, looking for ensnarable target is ineffective 
			}
		]
	},
	earthquake = {
		code = 'earthquake',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe', 'damage', 'earth', 'ultimate'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 16},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'earthquake', target = 'target_group', period = 'windup'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 0.4,
		follow_up = 'eq_setup',
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {combatcooldown = 5} #to prevent spaming 
			}
		]
	},
	eq_setup = {
		code = 'eq_setup',
		new_syntax = true,
		name = "",
		descript = '',
		icon = null,
		type = 'combat', 
		ability_type = 'spell',
		tags = ['not_final'],
		reqs = [],
		targetreqs = [],
		repeat = 1,
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'setup_global',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = {skill = 'earthquake_glob', number = 3},
		not_final = true
	},
	earthquake_glob = {
		code = 'earthquake_glob',
		descript = '',
		icon = load("res://assets/images/iconsskills/firestorm.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe', 'damage', 'earth'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',# or 'full'
		target_number = 'all',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'earth_spike', target = 'target', period = 'postdamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 0.4
	},
	disintegrate = {
		code = 'disintegrate',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_disintegrate.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'debuf', 'earth', 'damage_spot'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = ['e_t_disintegrate', 'e_t_disintegrate_2'], 
		cost = {mp = 12},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'disintegrate', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [1.65, 2.75],
		damagestat = ['damage_hp', 'damage_hp'],
		value_target_reqs = {
			0:[{code = 'stat', stat = 'racegroup', value = 'golem', operant = 'neq'}, {code = 'stat', stat = 'racegroup', value = 'mech', operant = 'neq'}],
			1:[{code = 'stat', stat = 'racegroup', value = ['golem', 'mech'], operant = 'in'}],
			},
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {combatcooldown = 3} #to prevent spaming 
			}
		]
	},
}
var effects = {
	e_s_earthshield = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = {},
		sub_effects = [
			Effectdata.rebuild_remove_effect('shred'),
			Effectdata.rebuild_remove_effect('shatter'),
			'e_t_earthshield'
			],
		buffs = []
	},
	e_s_earthshield_1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = {},
		sub_effects = [
			Effectdata.rebuild_remove_effect('shred'),
			Effectdata.rebuild_remove_effect('shatter'),
			'e_t_earthshield_1',
			],
		buffs = []
	},
	e_t_earthshield = {
		type = 'temp_s',
		target = 'target',
		stack = 'earth_shield',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 5,
		tags = ['buff', 'shield'],
		args = {value = {obj = 'skill', func = 'get', arg = 'process_value'}},
		statchanges = {armor = [['arg', 'value'], '*', 0.5],},
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Knight.png",
				description = "TRAITEFFECTEARTHSHIELD",
			}
		],
	},
	e_t_earthshield_1 = {
		type = 'temp_s',
		target = 'target',
		stack = 'earth_shield',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 5,
		tags = ['buff', 'shield'],
		args = {value = {obj = 'skill', func = 'get', arg = 'process_value'}},
		statchanges = {
			armor = [['arg', 'value'], '*', 0.5],
			mdef = [['arg', 'value'], '*', 0.4],
			},
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Knight.png",
				description = "TRAITEFFECTEARTHSHIELD_1",
			}
		],
	},
	e_t_disintegrate = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'is_immune', status = 'stun', check = true}]}
		],
		args = {duration = {obj = 'self', func = 'dr', dr = 5},},
		req_skill = true,
		sub_effects = ['e_s_shred'],
	},
	e_t_disintegrate_2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'is_immune', status = 'stun', check = false}]}
		],
		args = {duration = {obj = 'self', func = 'dr', dr = 3},},
		req_skill = true,
		sub_effects = ['e_s_stun'],
	},
	e_impale = {
		type = 'temp_s',
		target = 'target',
		stack = 'impale',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['negative'],
		statchanges = {resist_heal = 75},
		buffs = ['b_slam'],
	},
}
var atomic_effects = {}
var buffs = {}

var stacks = {
	earth_shield = {}, #st 1
	impale = {} #st 1
}
