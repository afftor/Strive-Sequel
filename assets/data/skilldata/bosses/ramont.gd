extends Reference

var skills = {
	ramont_riposte_stance_skill = {
		code = 'ramont_riposte_stance_skill',
		descript = '',
		icon = load("res://assets/images/iconsskills/takeposition.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff','defensive',],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'ramont_parry_n_riposte', duration = 2})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'devastation_3', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'bow', hit = null},
		value = ['0'],
		damagestat = 'no_stat'
	},
	command_embargo = {
		code = 'command_embargo',
		descript = '',
		icon = load("res://assets/images/iconsskills/Command.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['buff','defensive','support'],
		reqs = [],
		targetreqs = [
			{code = 'trait', trait = 'boss_resists', check = false},
			{code = 'has_status', status = 'stun', check = false}, 
			{code = 'has_status', status = 'freeze', check = false}, 
			{code = 'is_in_ranged_zone', check = false} 
		],
		effects = [
			Effectdata.rebuild_template({effect = 'ramont_embargo_order'}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 1,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		damage = 0,
		sfx = [{code = 'leader_mark', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'bow', hit = null},
		value = ['0'],
		damagestat = 'no_stat'
	},
	ramont_embrago = {
		code = 'ramont_embrago',
		descript = '',
		icon = "res://assets/images/iconsskills/tackle.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'taunt'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'provoke', duration = 2, res_condition = variables.RES_MISS}),
			Effectdata.rebuild_template({effect = 'provoke', duration = 2}),
		], 
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_MELEE,
		damage_type = 'weapon',
		sfx = [{code = 'earth_spike', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.7,
	},
	ramont_eviction_notice = {
		code = 'ramont_eviction_notice',
		descript = '',
		icon = load("res://assets/images/iconsskills/Innervate.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads','debuff'],
		reqs = [],
		targetreqs = [],
		effects = [#Apply Eviction Notice even when miss
			{
				type = 'trigger',
				req_skill = true,
				trigger = [variables.TR_POSTDAMAGE],
				conditions = [],
				buffs = [],
				duration = 2,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'target',
						conditions = [],
						atomic = [{type = 'effect', value = 'eviction_notice'}],
					},
				],
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
					receiver = {obj = 'receiver', func = 'eq'},
				},
			},
		],
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		sfx = [{code = 'ranged_attack', target = 'target', period = 'predamage'}, {code = 'trap_cast', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.85,
	},
	ramont_piercing_obsidian = {
		code = 'ramont_piercing_obsidian',
		descript = '',
		icon = load("res://assets/images/iconsskills/Aimed-strike.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','aoe','ultimate','piercing_obsidian'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'eviction_notice', check = true}],
		effects = [Effectdata.rebuild_template({effect = 'bleed', duration = 2})],
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'row',
		target_range = 'melee',
		damage_type = 'weapon',
		value = 1.35,
		sfx = [{code = 'strike_through', target = 'target_row', period = 'windup'}, {code = 'draw_blood', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
}
var effects = {
	ramont_parry_n_riposte_stance = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S],
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'ramont_parry_n_riposte', check = false}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['ramont_riposte_stance'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'ramont_riposte_stance_skill'}]
			},
		],
	},
	ramont_parry_n_riposte = {
		type = 'temp_s',
		target = 'target',
		stack = 'ramont_parry_n_riposte',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['stance', 'ramont_parry_n_riposte', 'defensive', 'counterattack'],
		duration = 1,
		statchanges = {},
		sub_effects = ['ramont_parry','ramont_riposte','ramont_parry_remove'],
		buffs = ['b_ramont_parry_n_riposte'],
	},
	ramont_parry = {
		type = 'trigger',
		target = 'target',
		trigger = [variables.TR_DEF],
		req_skill = false,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'neq', 'spell']},
		],
		atomic = [],
		buffs = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			receiver = {obj = 'receiver', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS},],
			},
		]
	},
	ramont_riposte = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [{type = 'use_combat_skill', skill = 'attack', target = ['parent_args', 'targetValue']}],
			},
		]
	},
	ramont_parry_remove = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'ramont_parry_n_riposte'}],
			},
		]
	},
	eviction_notice = {
		type = 'temp_s',
		duration = 2,
		stack = 'eviction_notice',
		tick_event = [variables.TR_TURN_S],
		remove_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tags = ['eviction_notice',],
		statchanges = {},
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			'ramont_eviction_bonus','ramont_remove_notice',
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/abuse.png",
			description = "EFFECT_EVICTION_NOTICE",
		}]
	},
	ramont_eviction_bonus = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'piercing_obsidian'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [],
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2},],
			},
		]
	},
	ramont_remove_notice = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [{type = 'skill', value = ['tags', 'has', 'piercing_obsidian'] },],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'eviction_notice'}],
			},
		]
	},
	ramont_embargo_order = {
		type = 'oneshot',
		target = 'target',
		tags = [],
		atomic = [{type = 'use_combat_skill', skill = 'ramont_embrago'},]
	},
}
var atomic_effects = {}
var buffs = {
	b_ramont_parry_n_riposte = {
		icon = "res://assets/images/iconsskills/strongattack.png",
		description = "EFFECT_RAMONTPARRY",
	},
}
var stacks = {
	eviction_notice = {
		type = 'stack_s',
		stack = 2,
	},
}
