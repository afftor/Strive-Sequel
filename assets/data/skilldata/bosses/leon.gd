extends Reference

var skills = {
	#passive-induced move
	sanguine_instinct_apply = {
		code = 'sanguine_instinct_apply',
		descript = '',
		icon =  "res://assets/images/iconsskills/icon_blood_explosion.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'sanguine_instinct_listener', duration = 1})], 
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
	},
	cornered_beast = {
		code = 'cornered_beast',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_bloodboil.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support','passive'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'bloodthrist'}),
			Effectdata.rebuild_template({effect = 'bloodthrist'}),
			Effectdata.rebuild_template({effect = 'bloodthrist'}),
			Effectdata.rebuild_template({effect = 'bleed', duration = 5}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [{code = 'provocation', target = 'caster', period = 'windup'},{code = 'tauntwave', target = 'target_group', period = 'windup'},], 
		sounddata = {initiate = null, strike = 'spell2', hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
	scent_of_blood = {
		code = 'scent_of_blood',
		descript = '',
		icon =  "res://assets/images/iconsskills/icon_blood_explosion.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'bloodthrist'})], 
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
	},
	#actual move
	lion_swipe = {
		code = 'lion_swipe',
		descript = '',
		icon = "res://assets/images/iconsskills/swipe.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'aoe'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'bleed', duration = 2})], 
		cost = {mp = 3},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'line',
		target_range = 'melee',
		damage_type = 'weapon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_MELEE,
		value = 0.85,
		random_factor_p = 0.1,
		sfx = [{code = 'blood_magic', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	bramble_trap = {
		code = 'bramble_trap',
		descript = '',
		icon = load("res://assets/images/iconsskills/Trap.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['debuff', 'trap', 'stealth_casting'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'bramble_trap', push_value = true}) ],  
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		target = 'enemy',
		target_number = 'x_random',
		number_rnd_targets = 3,
		target_range = 'melee',
		damage_type = 'weapon',
		sfx = [{code = 'overgrowth', target = 'target_group', period = 'windup'}],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = [['caster.matk', '*0.8']],
		damagestat = 'no_stat'
	},
	jaw_of_life = {
		code = 'jaw_of_life',
		descript = '',
		icon = "res://assets/images/iconsclasses/soul eater.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads','default'],
		reqs = [],
		targetreqs = [],
		effects = ['jaw_of_life_drain','jaw_of_life_bleed'],
		cost = {mp = 2},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'weapon',
		sfx = [{code = 'bite', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'fleshhit', hit = null},
		value = 1,
	},
	primal_roar = {
		code = 'primal_roar',
		descript = '',
		icon = "res://assets/images/iconsskills/FireBomb.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','mind', 'aoe', 'debuff'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'fear', chance = 0.35, duration = 1}),
			Effectdata.rebuild_template({effect = 'silence', chance = 0.35, duration = 1})
		], 
		cost = {mp = 8},
		charges = 0,
		combatcooldown = 5,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [
			{code = 'tauntwave', target = 'target_group', period = 'windup'},
		],
		sounddata = {initiate = null, strike = 'spell2', hit = null},
		value = 0.4,
		follow_up = 'primal_roar_1',
		not_final = true
	},
	primal_roar_1 = {
		code = 'primal_roar_1',
		descript = '',
		icon = "res://assets/images/iconsskills/HealBandage.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['heal', 'noreduce', 'noevade','support', ],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_CASTER,
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.atk','*2.35']],
		damagestat = ['-damage_hp']
	},
	mad_dash = {
		code = 'mad_dash',
		descript = '',
		icon = "res://assets/images/iconsskills/Aimed-strike.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'aoe'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'bleed', chance = 0.5, duration = 2}),
		], 
		cost = {mp = 3},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'row',
		target_range = 'melee',
		damage_type = 'weapon',
		value = 1.1,
		random_factor_p = 0.1,
		sfx = [{code = 'strike_through', target = 'target_row', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		variations = [
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'bloodthrist', value = 3}],
				set = {follow_up = 'mad_dash_1'},
			}
		]
	},
	mad_dash_1 = {
		code = 'mad_dash',
		descript = '',
		icon = "res://assets/images/iconsskills/Aimed-strike.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'aoe'],
		reqs = [],
		targetreqs = [],
		effects = [
			'consume_bloodthrist',
			Effectdata.rebuild_template({effect = 'bleed', chance = 0.5, duration = 2}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 3,
		catalysts = {},
		target = 'enemy',
		target_number = 'row',
		target_range = 'melee',
		damage_type = 'weapon',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		value = 1.1,
		random_factor_p = 0.1,
		sfx = [{code = 'strike_through', target = 'target_row', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	regression_curse_run_amok = {
		code = 'regression_curse_run_amok',
		descript = '',
		icon = "res://assets/images/iconsskills/comboattack.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads','ultimate'],
		reqs = [],
		targetreqs = [],
		effects = ['run_amok_bleed_dmg', 'run_amok_fragile', 'consume_bloodthrist',],
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'weapon',
		sfx = [{code = 'provocation', target = 'caster', period = 'windup'},{code = 'devastation_4', target = 'target', period = 'predamage'},{code = 'draw_blood', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'fleshhit', hit = null},
		value = 1.1,
		variations = [
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'bloodthrist', value = 1}],
				set = {follow_up = 'regression_curse_run_amok_1'},
			}
		]
	},
	regression_curse_run_amok_1 = {
		code = 'regression_curse_run_amok_1',
		descript = '',
		icon = "res://assets/images/iconsskills/comboattack.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads','ultimate'],
		reqs = [],
		targetreqs = [],
		effects = ['run_amok_bleed_dmg', 'run_amok_fragile', 'consume_bloodthrist',],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'weapon',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		sfx = [{code = 'devastation_4', target = 'target', period = 'predamage'},{code = 'draw_blood', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'fleshhit', hit = null},
		value = 1.1,
		variations = [
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'bloodthrist', value = 1}],
				set = {follow_up = 'regression_curse_run_amok_1'},
			}
		]
	}
}
var effects = {
	leon_ambush_predator = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'lion_swipe'}]
			},
		],
	},
	sanguine_instinct = {
		type = 'simple',
		statchanges = {},
		tags = ['sanguine_instinct_desc'],
		buffs = [{
			icon = "res://assets/images/iconsclasses/soul eater.png",
			description = "TRAIT_SANGUINE_INSTINCT_DESC",
		}]
	},
	sanguine_instinct_apply = {
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
				atomic = [{type = 'use_combat_skill', skill = 'sanguine_instinct_apply'}]
			},
		],
	},
	sanguine_instinct_listener = {
		type = 'temp_s',
		target = 'target',
		duration = 1,
		tick_event = [variables.TR_TURN_S,],
		rem_event = [variables.TR_COMBAT_F],
		conditions = [],
		buffs = [],
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_F],
				req_skill = false,
				conditions = [
					{type = 'owner', value = [{code = 'has_status', status = 'bleed', check = true}]},
				],
				args = {skill = {obj = 'owner', func = 'eq'},},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [{type = 'use_combat_skill', skill = 'scent_of_blood'}],
					},
				]
			},
		],
		tags = ['sanguine_instinct_listener'],
	},
	sanguine_instinct_self = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'bleed', check = true}]},
		],
		args = {skill = {obj = 'owner', func = 'eq'},target = {obj = 'owner', func = 'eq'}},
		sub_effects = ['bloodthrist']
	},
	bloodthrist = {
		type = 'temp_s',
		target = 'target',
		stack = 'bloodthrist',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['bloodthrist'],
		duration = 1,
		statchanges = { atk = 5, speed = 5 },
		sub_effects = [],
		buffs = ['b_bloodthrist']
	},
	bloodthrist_t3 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'owner', value = [{code = 'buff_number', operant = 'gte', status = 'bloodthrist', value = 3}] },
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'bleed', check = true}]},
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
	bloodthrist_t5 = {
		type = 'simple',
		conditions = [{code = 'buff_number', operant = 'gte', status = 'bloodthrist', value = 5}],
		statchanges = {resist_heal = -50},
	},
	cornered_beast_trait = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'effect', value = 'cornered_beast'}]
			},
		],
	},
	cornered_beast = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_DMG],
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax','*0.5']}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['cornered_beast'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'cornered_beast'}, {type = 'remove_all_effects', value = 'cornered_beast'}]
			},
		],
	},
	fragile = {
		type = 'temp_s',
		target = 'target',
		stack = 'fragile',
		tick_event = [variables.TR_TURN_S],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['negative'],
		statchanges = {damage_reduction = -10},
		buffs = ['b_fragile'],
	},
	bramble_trap = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_SKILL_FINISH],
		atomic = [],
		args = {damage = {obj = 'skill', func = 'get', arg = 'process_value'},},
		stack = 'bramble_trap',
		tags = ['bramble_trap', 'trap'],
		buffs = ['b_bramble_trap'],
		sub_effects = ['e_tr_bramble_trap']
	},
	e_tr_bramble_trap = {
		type = 'trigger',
		target = 'target',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'skill'] },
		],
		args = {damage = {obj = 'parent', func = 'arg', arg = 'damage'},duration  = {obj = 'self', func = 'dr', dr = 2},},
		atomic = [],
		buffs = [],
		duration = 2,
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = {
				value = {obj = 'parent', func = 'arg', arg = 'damage'},
				src = {obj = 'self', func = 'src', src = 'normal'},
				
				},
			atomic = [
				{type = 'sfx', value = 'dip_poison'}, 
				'a_damage_simple', 
				{type = 'effect', value = 'e_s_ensnare', override = {duration = 2}}
			]},
			'bleed'
		],
	},
	jaw_of_life_drain = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'bleed', check = true}]},
		],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_add', stat = 'is_drain', value = 0.85}]
		}],
		buffs = []
	},
	jaw_of_life_bleed = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'bleed', check = false}]},
		],
		duration = 2,
		args = {target = {obj = 'target', func = 'eq'},duration  = {obj = 'self', func = 'dr', dr = 2},},
		sub_effects = ['bleed']
	},
	consume_bloodthrist = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		args = {},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'remove_effect', value = 'bloodthrist'}],
			},
		]
	},
	run_amok_bleed_dmg = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'bleed', check = true}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [],
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.3},],
			},
			{
				type = 'oneshot',
				target = 'target',
				conditions = [],
				atomic = [{type = 'sfx', value = 'blood_boil'},]
			},
		]
	},
	run_amok_fragile = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'has_status', status = 'bleed', check = false}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				conditions = [],
				atomic = [{type = 'effect', value = 'fragile'}]
			},
		]
	},
}
var atomic_effects = {}
var buffs = {
	b_bloodthrist = {
		icon = "res://assets/images/iconsclasses/Blood_Mage.png",
		description = "EFFECT_BLOODTHRIST",
		tags = ['show_amount']
	},
	b_fragile = {
		icon = "res://assets/images/iconsskills/cripple.png",
		description = "EFFECT_FRAGILE",
		tags = ['show_amount']
	},
	b_bramble_trap = {
		icon = "res://assets/images/iconsskills/icon_plant.png",
		description = "EFFECT_BRAMBLETRAP",
		limit = 1,
	},
}
var stacks = {
	fragile = {
		type = 'stack_a',
		stack = 10,
		buff = 'b_fragile',
	},
	bloodthrist = {
		type = 'stack_a',
		stack = 10,
		buff = 'b_bloodthrist',
	},
	bramble_trap = {}, #st 1
}
