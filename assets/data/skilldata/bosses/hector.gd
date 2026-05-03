extends Reference

var skills = {
		hector_blood_of_mother = {
		code = 'hector_blood_of_mother',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_blood_explosion.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive','aoe','debuff', 'noevade',],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'cali_vengeful_wrath_apply',})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'normal',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat',
		random_target = true,
	},
	hector_protect_me = {
		code = 'hector_protect_me',
		descript = '',
		icon = load("res://assets/images/iconsskills/Command.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['buff','defensive','selfish'],
		reqs = [{code = 'has_status', status = 'vip', check = false}],
		targetreqs = [
			{code = 'trait', trait = 'boss_resists', check = false},
			{code = 'has_status', status = 'disable', check = false}, 
			{code = 'is_in_ranged_zone', check = false} 
		],
		effects = [
			Effectdata.rebuild_template({effect = 'bodyguard', duration = 3}),
			{sub_effects = ['vip'],
				type = 'trigger',
				req_skill = true,
				trigger = [variables.TR_POSTDAMAGE],
				conditions = [],
				buffs = [],
				duration = 1,
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'caster', func = 'eq'},
					receiver = {obj = 'receiver', func = 'eq'},
				},
			},
		], 
		cost = {},
		charges = 0,
		combatcooldown = 4,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		damage = 0,
		sfx = [{code = 'leader_mark', target = 'target', period = 'predamage'},{code = 'taunt', target = 'caster', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'bow', hit = null},
		value = ['0'],
		damagestat = 'no_stat'
	},
	enraging_belittlement = {
		code = 'enraging_belittlement',
		descript = '',
		icon = load("res://assets/images/iconsskills/skill_bloodboil.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['debuff','taunt'],
		reqs = [{code = 'has_status', status = 'hector_vain_pride_s', check = true}],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'provoke', duration = 1}),
			Effectdata.rebuild_template({effect = 'blind', duration = 1})
		], 
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		damage = 0,
		sfx = [{code = 'malediction', target = 'caster', period = 'windup'},{code = 'provocation', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = ['0'],
		damagestat = 'no_stat',
		variations = [
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'hector_vain_pride_s', value = 3}],
				set = { effects = [ 
					Effectdata.rebuild_template({effect = 'provoke', duration = 1}),
					Effectdata.rebuild_template({effect = 'blind', duration = 1}),
					Effectdata.rebuild_template({effect = 'fear', duration = 1}),
				]},
			}
		],
	},
	enraging_belittlement_cali = {
		code = 'enraging_belittlement_cali',
		descript = '',
		icon = load("res://assets/images/iconsskills/skill_bloodboil.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['debuff','taunt'],
		reqs = [{code = 'has_status', status = 'hector_vain_pride_s', check = true}],
		targetreqs = [{code = 'stat', stat = 'unique', operant = 'eq', value = "cali"},],
		effects = [
			Effectdata.rebuild_template({effect = 'provoke', duration = 1}),
			Effectdata.rebuild_template({effect = 'blind', duration = 1})
		], 
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		damage = 0,
		sfx = [{code = 'malediction', target = 'caster', period = 'windup'},{code = 'provocation', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = ['0'],
		damagestat = 'no_stat',
		variations = [
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'hector_vain_pride_s', value = 3}],
				set = { effects = [ 
					Effectdata.rebuild_template({effect = 'provoke', duration = 1}),
					Effectdata.rebuild_template({effect = 'blind', duration = 1}),
					Effectdata.rebuild_template({effect = 'fear', duration = 1}),
				]},
			}
		],
	},
	out_of_my_way = {
		code = 'out_of_my_way',
		descript = '',
		icon = load("res://assets/images/iconsskills/tackle.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','aoe'],
		reqs = [],
		targetreqs = [{code = 'is_in_ranged_zone', check = false}, {code = 'in_front_of_someone', check = true}],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'row',
		target_range = 'melee',
		damage_type = 'weapon',
		value = 0.4,
		sfx = [{code = 'devastation_2', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		follow_up = 'out_of_my_way_1'
	},
	out_of_my_way_1 = {
		code = 'out_of_my_way_1',
		descript = '',
		icon = load("res://assets/images/iconsskills/slash.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage',],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_BACK,
		value = 0.6,
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	you_ungratful_mutt = {
		code = 'you_ungratful_mutt',
		descript = '',
		icon = "res://assets/images/iconsskills/swipe.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'aoe'],
		reqs = [{code = 'buff_number', operant = 'gte', status = 'hector_vain_pride_s', value = 5}],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'bleed', duration = 2}), Effectdata.rebuild_template({effect = 'e_s_shred',  duration = 2})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'line',
		target_range = 'melee',
		damage_type = 'weapon',
		sfx = [{code = 'provocation', target = 'caster', period = 'windup'},{code = 'cleave', target = 'target_line', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = ['caster.atk','*1.85'],
	},
}
var effects = {
		hector_blood_of_mother = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['hector_blood_of_mother'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'hector_blood_of_mother'}]
			},
		],
	},
	cali_vengeful_wrath_apply = {
		type = 'oneshot',
		target = 'target',
		tags = [],
		conditions = [
			{code = 'stat', stat = 'unique', operant = 'eq', value = "cali"},
		],
		atomic = [{type = 'sfx', value = 'provocation'},{type = 'effect', value = 'cali_vengeful_wrath'},],
	},
	cali_vengeful_wrath = {
		type = 'temp_s',
		target = 'target',
		stack = 'cali_vengeful_wrath',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		duration = 3,
		tags = ['cali_vengeful_wrath'],
		statchanges = {atk = 30, armorpenetration = 20},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				req_skill = true,
				conditions = [
					{type = 'target', value = [{code = 'trait', trait = 'hector_blood_of_mother', check = true}]},
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						conditions = [],
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.2},],
					},
					{
						type = 'oneshot',
						target = 'target',
						conditions = [],
						atomic = [{type = 'remove_all_effects', value = 'hector_vain_pride_s'}],
					},
				]
			},
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/skill_bloodboil.png",
			description = "EFFECT_CALI_VENGEFUL_WRATH",
		}]
	},
	hector_vain_pride = {
		type = 'simple',
		statchanges = {},
		buffs = [{
			icon = "res://assets/images/iconsskills/defaultattack.png",
			description = "TRAIT_HECTOR_VAIN_PRIDE",
		}]
	},
	hector_vain_pride_on_hit = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		buffs = [],
		duration = 1,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				conditions = [],
				atomic = [{type = 'effect', value = 'hector_vain_pride_s'},],
			},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			receiver = {obj = 'receiver', func = 'eq'},
		},
	},
	hector_on_miss = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'effect', value = 'hector_vain_pride_s'}],
			},
		]
	},
	hector_vain_pride_on_def = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'remove_effect', value = 'hector_vain_pride_s'}],
			},
		]
	},
	hector_vain_pride_s = {
		type = 'temp_s',
		target = 'target',
		stack = 'hector_vain_pride_s',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['hector_vain_pride_s'],
		duration = 1,
		statchanges = {atk = 10, hitrate = 10},
		sub_effects = [],
		buffs = ['b_hector_vain_pride_s']
	},
	bodyguard = {
		type = 'temp_s',
		target = 'target',
		stack = 'bodyguard',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_TURN_F],
		tags = ['bodyguard','defensive','remove_by_immoblizing'],
		duration = 'arg',
		statchanges = {},
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/Protect.png",
			description = "EFFECT_BODYGUARD",
		}]
	},
	vip = {
		type = 'temp_s',
		target = 'target',
		stack = 'vip',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		duration = 1,
		tags = ['vip'],
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				req_skill = true,
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['target_number', 'eq', 'single']},
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'target',
						conditions = [],
						atomic = [{type = 'remove_all_effects', value = 'vip'}],
					},
				]
			},
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/icon_mirror_image.png",
			description = "EFFECT_VIP",
		}]
	},
}
var atomic_effects = {}
var buffs = {
	b_hector_vain_pride_s = {
		icon = "res://assets/images/iconsskills/defaultattack.png",
		description = "TRAIT_HECTOR_VAIN_PRIDE_S",
		tags = ['show_amount']
	},
}
var stacks = {
	cali_vengeful_wrath = {
		type = 'stack_s',
		stack = 1,
	},
	hector_vain_pride_s = {
		type = 'stack_a',
		stack = 10,
		buff = 'b_hector_vain_pride_s',
	},
	bodyguard = {
		type = 'stack_s',
		stack = 1,
	},
	vip = {
		type = 'stack_s',
		stack = 1,
	},
}
