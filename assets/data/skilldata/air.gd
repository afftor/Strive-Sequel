extends Reference

var skills = {
	wind_blade = {
		code = 'wind_blade',
		descript = '',
		icon = "res://assets/images/iconsskills/windblade.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'air', 'damage_spread'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 3},
		repeat = 2,
		keep_target = variables.TARGET_KEEPFIRST,
		next_target = variables.NT_ANY,
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',
		sfx = [{code = 'wind_blade', target = 'target', period = 'predamage', duration = 0.2, no_repeat_delays = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = 0.6,
		random_factor_p = 0.1,
	},
	lightning = {
		code = 'lightning',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_lightning.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'air'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'shock', chance = 0.5, duration = 2})], 
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',
		sfx = [{code = 'lightning', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'spell_lightning', hit = null},
		value = 1.25
	},
	haste = {
		code = 'haste',
		descript = '',
		icon = "res://assets/images/iconsskills/tackle.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_haste', duration = 4})], 
		cost = {mp = 7},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',#not sure but not matters
		sfx = [{code = 'haste', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	chain_lightning = {
		code = 'chain_lightning',
		descript = '',
		icon = "res://assets/images/iconsskills/Drain.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe', 'damage', 'air'],
		reqs = [],
		targetreqs = [],
		effects = [],
		cost = {mp = 8},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'x_random',
		number_rnd_targets = [4, 6],
		target_range = 'any',
		damage_type = 'air',
		sfx = [{code = 'chain_lightning', target = 'target_group', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'spell_lightning', hit = null},
		value = 0.8,
		random_factor_p = 0.1,
	},
	air_shield = {
		code = 'air_shield',
		descript = '',
		icon = load("res://assets/images/iconsskills/shield_air.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_airshield', duration = 5})], 
		cost = {mp = 7},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',#not sure but not matters
		sfx = [{code = 'air_shield', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		variations = [
			{
				reqs = [
					{code = 'stat', stat = 'mastery_air', value = 5, operant = 'eq'},
					],
				set = {target_number = 'line'},
				add = {descript = '_1'}
			},
			{
				reqs = [{code = 'stat', stat = 'mastery_air', value = 6, operant = 'gte'}],
				set = {target_number = 'all'},
				add = {descript = '_2'}
			},
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {targetreqs = [{code = 'has_status', status = 'shield', check = false}],} #to prevent overuse of long-duration buffs
			}
		]
	},
	tempest = {
		code = 'tempest',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_energy_field.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'aoe', 'air'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'shock', duration = 2})], 
		cost = {mp = 13},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'air',
		sfx = [{code = 'tempest', target = 'target_group', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'spell_lightning', hit = null},
		value = 1.2,
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {combatcooldown = 5} #to prevent spaming
			}
		]
	},
	eyeofthestorm = {
		code = 'eyeofthestorm',
		descript = '',
		icon = "res://assets/images/iconsskills/Innervate.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff', 'instant'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'eyeofthestorm', check = false}],
		effects = [Effectdata.rebuild_template({effect = 'e_s_eye', duration = 6, push_value = true})], 
		cost = {mp = 15},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',#not sure but not matters
		sfx = [{code = 'eye_of_the_storm', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.matk', '*0.35']],
		damagestat = ['no_stat'],
	},
}
var effects = {
	e_t_haste = {
		type = 'temp_s',
		target = 'target',
		stack = 'haste',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['buff'],
		statchanges = {speed = 25},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/tackle.png",
				description = "TRAITEFFECTHASTE",
			}
		],
	},
	e_t_airshield = {
		type = 'temp_s',
		target = 'target',
		stack = 'airshield',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['buff', 'shield'],
		statchanges = {resist_earth = 40, resist_ranged = 0.1},
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png",
				description = "TRAITEFFECTAIRSHIELD",
			}
		],
	},
	e_s_eye = {
		type = 'temp_s',
		target = 'target',
		stack = 'eyeofthestorm',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['buff', 'eyeofthestorm'],
		args = {damage = {obj = 'process_value', func = 'eq'}},
		sub_effects = ['e_tr_eye'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Innervate.png",
				description = "TRAITEFFECTEYEOFTHESTORM",
			}
		],
	},
	e_tr_eye = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		args = {damage = {obj = 'parent', func = 'arg', arg = 'damage'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = {
					value = {obj = 'parent', func = 'arg', arg = 'damage'},
					src = {obj = 'self', func = 'src', src = 'air'}
					},
				atomic = ['a_eye_animation', 'a_damage_simple'],
			}
		],
		buffs = []
	},
}
var atomic_effects = {
	a_eye_animation = {type = 'sfx', value = 'targetattack'}, #2add and change animation
}
var buffs = {}

var stacks = {
	haste = {}, #stack 1
	airshield = {}, #stack 1
	eyeofthestorm = {}, #stack 1
}
