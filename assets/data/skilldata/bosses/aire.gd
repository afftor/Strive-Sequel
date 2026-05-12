extends Reference

var skills = {
	#Behind the scene skill zone
	underwatched = {
		code = 'underwatched',
		descript = '',
		icon =  "res://assets/images/iconsskills/comboattack.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'ts_underwatched', duration = 1})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null, hittype = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
		not_final = true
	},
	aire_cover_fire_request = {
		code = 'aire_cover_fire_request',
		descript = '',
		icon =  "res://assets/images/iconsskills/arrowshower.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe','support','noreduce', 'noevade','passive','instant'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'e_spotted_by_overwatch'}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'air',
		value = [['0']],
		damagestat = 'no_stat',
		critchance = 0,
	},
	aire_cover_fire = {
		code = 'aire_cover_fire',
		descript = '',
		icon = load("res://assets/images/iconsskills/heavyshot.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'default', 'basic', 'stealth_casting'],
		reqs = [],
		targetreqs = [],
		effects = ['expose_cover'], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 0.65,
		sfx = [{code = 'ranged_attack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	aire_eye_for_an_eye_request = {
		code = 'aire_eye_for_an_eye_request',
		descript = '',
		icon =  "res://assets/images/iconsskills/arrowshower.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe','support','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'e_eye_for_an_eye'}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'air',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat',
		critchance = 0,
	},
	aire_eye_for_an_eye = {
		code = 'aire_eye_for_an_eye',
		descript = '',
		icon = load("res://assets/images/iconsskills/heavyshot.png"),
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'default', 'basic', 'stealth_casting'],
		reqs = [],
		targetreqs = [],
		effects = ['expose_cover'], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 1.5,
		armor_p = [['target.armor','*0.3']],
		sfx = [{code = 'provocation', target = 'caster', period = 'windup'},{code = 'ranged_attack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	#Actual skill zone.
	for_the_princess = {
		code = 'for_the_princess',
		descript = '',
		icon = load("res://assets/images/iconsskills/Warn.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 1.1,
		sfx = [{code = 'ranged_attack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		follow_up = 'for_the_princess_1',
		not_final = true
	},
	for_the_princess_1 = {
		code = 'for_the_princess_1',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive','aoe','support','buff','noreduce', 'noevade'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('fear')}),
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('taunt')}),
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('silence')}),
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('sleep')}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'air',
		sfx = [{code = 'inspire', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat',
	},
	ricochet_shot = {
		code = 'ricochet_shot',
		descript = '',
		icon = "res://assets/images/iconsskills/windblade.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'damage_spot', 'stealth_casting'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 8},
		repeat = 2,
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		random_target = true,
		not_final = true,
		sfx = [
				{code = 'ranged_attack',target = 'target', period = 'predamage',},
				{code = '', code_repeat = {
				1 : "devastation_1", 2 : "devastation_2", 3 : "devastation_3", 4 : "devastation_4",}, 
				target = 'target', period = 'predamage', duration = 0.2, no_repeat_delays = true},
				
			],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.5,
		random_factor_p = 0.1,
		keep_target = variables.TARGET_KEEPFIRST,
		next_target = variables.NT_ANY_NOREPEAT,
		variations = [
			{
				reqs = [{code = 'random', value = 66}],
				set = { 
						repeat = 3,
					},
			},
			{
				reqs = [{code = 'random', value = 33}],
				set = { 
						repeat = 4,
					},
			},
		]
	},
}
var effects = {
	overwatch_assignment = {
		type = 'simple',
		statchanges = {},
		tags = ['overwatch_assignment'],
		buffs = [{
			icon = "res://assets/images/iconsskills/takeposition.png",
			description = "TRAIT_OVERWATCH_ASSIGNMENT",
		}]
	},
	overwatch_apply = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S, variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'underwatched'}]
			},
		],
	},
	ts_underwatched = {
		type = 'temp_s',
		target = 'target',
		duration = 1,
		tick_event = [variables.TR_TURN_S,],
		rem_event = [variables.TR_COMBAT_F],
		conditions = [],
		buffs = [],
		statchanges = {},
		sub_effects = [
			'tr_underwatched',
			'tr_eye_for_an_eye'
		],
		tags = ['underwatched'],
	},
	tr_underwatched = {
		type = 'trigger',
		trigger = [variables.TR_PREHIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'target', value = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}] },
			{type = 'target', value = [{code = 'trait', trait = 'aire_overwatch_assignment', check = false}] }
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'use_combat_skill', skill = 'aire_cover_fire_request'}],
			},
		]
	},
	e_spotted_by_overwatch = {
		type = 'oneshot',
		target = 'target',
		tags = [],
		conditions = [
			{code = 'trait', trait = 'aire_overwatch_assignment', check = true},
			{code = 'has_status', status = 'disable', check = false},
			{code = 'has_status', status = 'disarm', check = false},
		],
		args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
		atomic = [{type = 'use_combat_skill', skill = 'aire_cover_fire', target = ['parent_args', 'targetValue']},],
	},
	tr_eye_for_an_eye = {
		type = 'trigger',
		trigger = [variables.TR_KILL],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}] },
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'use_combat_skill', skill = 'aire_eye_for_an_eye_request'}],
			},
		]
	},
	e_eye_for_an_eye = {
		type = 'oneshot',
		target = 'target',
		tags = [],
		conditions = [
			{code = 'trait', trait = 'aire_overwatch_assignment', check = true},
			{code = 'has_status', status = 'disable', check = false},
			{code = 'has_status', status = 'disarm', check = false},
			#{type = 'target', value = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]}
		],
		args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
		atomic = [{type = 'use_combat_skill', skill = 'aire_eye_for_an_eye', target = ['parent_args', 'targetValue']},],
	},
	trait_behind_cover = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S],
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'behind_cover', check = false}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['trait_behind_cover'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'sfx', value = 'earth_shield'},]
			},
			'behind_cover'
		],
	},
	behind_cover = {
		type = 'temp_s',
		target = 'owner',
		stack = 'behind_cover',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_DEATH, variables.TR_COMBAT_F],
		duration = 1,
		tags = ['behind_cover'],
		statchanges = {},
		sub_effects = ['behind_cover_tr_melee_aoe','behind_cover_tr_range'],
		buffs = ['b_behind_cover'],
	},
	behind_cover_tr_melee_aoe = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'aoe'] },
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			{type = 'caster', value = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'neq'}] },
		],
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
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'remove_all_effects', value = 'behind_cover'},]
			},
		]
	},
	behind_cover_tr_range = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['target_range', 'eq', 'any']},
			{type = 'caster', value = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'neq'}] },
		],
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
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'remove_all_effects', value = 'behind_cover'},]
			},
		]
	},
	expose_cover = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'behind_cover'}],
			},
		],
	},
	tr_aim_adjustment = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['target_range', 'eq', 'any']},
			{type = 'skill', value = ['target_number', 'eq', 'single']},
			{type = 'caster', value = [{code = 'buff_number', operant = 'lt', status = 'aim_adjustment', value = 3}] },
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		sub_effects = [
			'aim_adjustment'
		]
	},
	aim_adjustment_tr = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'owner', value = [{code = 'buff_number', operant = 'gte', status = 'aim_adjustment', value = 3}] },
		],
		args = {skill = {obj = 'skill', func = 'eq'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_CRIT}],
			},
		]
	},
	aim_adjustment = {
		type = 'temp_s',
		target = 'caster',
		stack = 'aim_adjustment',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['aim_adjustment'],
		duration = 1,
		statchanges = {},
		sub_effects = ['aim_adjustment_tr','aim_adjustment_removal'],
		buffs = ['b_aim_adjustment']
	},
	aim_adjustment_removal = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'owner', value = [{code = 'buff_number', operant = 'gte', status = 'aim_adjustment', value = 3}] },
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'aim_adjustment'}],
			},
		],
	},
}
var atomic_effects = {}
var buffs = {
	b_behind_cover = {
		icon = "res://assets/images/iconsitems/item_stone.png",
		description = "EFFECT_BEHIND_COVER",
	},
	b_aim_adjustment = {
		icon = "res://assets/images/iconsskills/icon_hunters_mark.png",
		description = "EFFECT_AIM_ADJUSTMENT",
		tags = ['show_amount']
	},
}
var stacks = {
	behind_cover = {
		type = 'stack_s',
		stack = 1,
		buff = 'b_behind_cover'
	},
	aim_adjustment = {
		type = 'stack_a',
		stack = 3,
		buff = 'b_aim_adjustment',
	},
}
