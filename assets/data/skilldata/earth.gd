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
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.matk']],
		damagestat = ['no_stat'],
		variations = [
			{
				reqs = [{code = 'stat', stat = 'mastery_earth', value = 3, operant = 'gte'}],
				set = {effects = ['e_s_earthshield_1']},
				add = {descript = '_1'}
			}
		]
	},
	acidbomb = {
		code = 'acidbomb',
		descript = '',
		icon = load("res://assets/images/iconsskills/AcidBomb.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template_globals({effect = 'e_s_shred3'})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {unstable_concoction = 1},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth', 
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 2.5
	},
	overgrowth = {
		code = 'overgrowth',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_plant.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','aoe','earth'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template_globals({effect = 'e_s_ensnare2', chance = 0.5})], 
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.5
	},
	earthquake = {
		code = 'earthquake',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe', 'damage'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'earth_spike', target = 'target', period = 'postdamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 0.4,
		follow_up = 'eq_setup'
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
		tags = ['aoe', 'damage'],
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
		icon = load("res://assets/images/iconsskills/WeaponRefine.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'debuf', 'earth'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = ['e_t_disintegrate', 'e_t_disintegrate_2'], 
		cost = {mp = 12},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'earth',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = 2.5,
	},
}
var effects = {
	e_s_earthshield = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'process_value'}], #{obj = 'parent_args', param = 0}
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
		args = [{obj = 'parent', param = 'process_value'}], #{obj = 'parent_args', param = 0}
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
		name = 'earth_shield',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 5,
		stack = 1,
		tags = ['buff'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [],
		atomic = [{type = 'stat_add', stat = 'def', value = [['parent_args', 0], '*', 0.5]}],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Knight.png",
				description = "TRAITEFFECTEARTHSHIELD",
				limit = 1,
				t_name = 'earthshield'
			}
		],
	},
	e_t_earthshield_1 = {
		type = 'temp_s',
		target = 'target',
		name = 'earth_shield',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 5,
		stack = 1,
		tags = ['buff'],
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'def', value = [['parent_args', 0], '*', 0.5]},
			{type = 'stat_add', stat = 'mdef', value = [['parent_args', 0], '*', 0.4]}
			],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Knight.png",
				description = "TRAITEFFECTEARTHSHIELD_1",
				limit = 1,
				t_name = 'earthshield'
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
		duration = 3,
		req_skill = true,
		args = [],
		sub_effects = ['e_s_shred3'],
		buffs = []
	},
	e_t_disintegrate_2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'is_immune', status = 'stun', check = false}]}
		],
		duration = 3,
		req_skill = true,
		args = [],
		sub_effects = ['e_s_stun1'],
		buffs = []
	},
}
var atomic_effects = {}
var buffs = {}
