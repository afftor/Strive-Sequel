extends Reference

var skills = {
	fairy_heal = {#heals target for 50%
		code = 'fairy_heal',
		descript = '',
		icon = load("res://assets/images/iconsskills/fairy_heal.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support', 'exploration', 'no_caster_bonuses'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 8},
		charges = 1,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'fairy_grace', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['target.hpmax','*0.5']],
		damagestat = ['-damage_hp']
	},
	flight = {
		code = 'flight',
		descript = '',
		icon = load("res://assets/images/iconsskills/wing.png"),
		type = 'combat',
		ability_type = 'spell',
		tags = ['buff', 'support', 'instant', 'selfbuf'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'ensnared', check = false}],
		effects = [
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('trap')}),
			Effectdata.rebuild_template({effect = 'e_fa_flight'}),
			Effectdata.rebuild_template({effect = 'e_fa_flight_upkeep'}),
		],
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',
		sfx = [{code = 'air_shield', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		variations = [
			{
				reqs = [{code = 'has_status', status = 'flight', check = true}],
				set = {name = tr('SKILLFLIGHT_REMOVE'), cost = {}},
				append = {tags = 'aura_active'}
			},
		]
	},
	entangle = {#dryad skill
		code = 'entangle',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_plant.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'earth'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'stun', duration = 1})], 
		cost = {mp = 5},
		charges = 2,
		combatcooldown = 3,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'earth',
		sfx = [{code = 'entangle', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.3
	},
	fly_evasion = {
		code = 'fly_evasion',
		descript = '',
		icon = load('res://assets/images/iconsskills/wing.png'),
		learn_reqs = [{code = 'stat', stat = 'wings', operant = 'neq', value = ''}],
		learn_cost = 500,
		type = 'combat', 
		ability_type = 'spell',
		tags = ['buff','support'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('trap')}),
			Effectdata.rebuild_template({effect = 'e_t_fly', duration = 1})
		],
		cost = {},
		charges = 0,
		combatcooldown = 4, #i think this is right
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = ['0'],
		damagestat = 'no_stat'
	},
	
	boar_heal = { #mae trait auto skill
		code = 'boar_heal',
		descript = '',
		icon = load("res://assets/images/iconsskills/takeposition.png"),
		type = 'auto', 
		ability_type = 'skill',
		tags = ['instant'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		damage = 0,
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = ['10'],
		damagestat = ['-damage_hp']
	},
}
var effects = {
	e_fa_flight = {
		type = 'temp_s',
		stack = 'flight',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		target = 'caster',
		tags = ['flight'],
		statchanges = {hitrate = 25, resist_earth = 50},
		sub_effects = ['e_tr_flight_dodge'],
		buffs = [{
			icon = "res://assets/images/iconsskills/wing.png",
			description = "TRAITEFFECTFLIGHT",
			tags = ['combat_only'],
		}],
	},
	e_fa_flight_upkeep = {
		type = 'temp_s',
		stack = 'flight_upkeep',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		target = 'caster',
		tags = ['flight'],
		statchanges = {},
		sub_effects = ['flight_upkeep'],
		buffs = [],
	},
	e_tr_flight_dodge = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			{type = 'random', value = 0.8}
		],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}]
		}],
	},
	flight_upkeep = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'stat_add', stat = 'mp', value = -3}]
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [{code = 'stat', stat = 'mp', operant = 'lte', value = 0}],
				atomic = [
					{type = 'remove_effect', value = 'flight'},
					{type = 'remove_effect', value = 'flight_upkeep'}
				]
			}
		]
	},
	e_t_fly = {
		type = 'temp_s',
		target = 'target',
		stack = 'fly',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['buff','fly'],
		statchanges = {evasion = 90},
		buffs = [
			{
				icon = "res://assets/images/iconsraces/angel.png",
				description = "TRAITEFFECTFLY",
				tags = ['combat_only'],
			}
		],
	},
	e_boar_autoheal = Effectdata.rebuild_autocast({skill = 'boar_heal', trigger = [variables.TR_TURN_S]}),
	e_satyr_mpreg = { 
		type = 'trigger',
		trigger = [variables.TR_CAST],
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['tags', 'has', 'targets_ally']},
			],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {amount = {obj = 'self', func = 'amount', amount = 4}},
				atomic = [{type = 'sfx', value = 'mind_shatter'}, 'a_manasiphon'] #fix sfx
			}
		],
		buffs = []
	},
}
var atomic_effects = {}
var buffs = {}

var stacks = {
	flight = {
		type = 'stack_t',
		stack = 1
	},#toggle
	flight_upkeep = {
		type = 'stack_t',
		stack = 1
	},
	fly = {}, #stack 1
}
