extends Reference

var skills = {
	strafe = {
		code = 'strafe',
		descript = '',
		icon = "res://assets/images/iconsskills/heavyshot.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'damage_spot'],
		reqs = [{code = 'gear_equiped', param = 'geartype', value = 'bow', check = true}],
		targetreqs = [],
		effects = [], 
		cost = {mp = 3},
		repeat = 3,
		keep_target = variables.TARGET_KEEP,
		next_target = variables.NT_ANY,
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'weapon',
		random_target = true,
		not_final = true,
		sfx = [{code = 'strafe', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'bow', hit = null},
		value = 0.45,
		random_factor_p = 0.1,
	},
	ensnare = {
		code = 'ensnare',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_ensnare.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads', 'aoe'],
		reqs = [{code = 'gear_equiped', param = 'geartype', value = 'bow', check = true}],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_ensnare', duration = 1})],
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'ensnare', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'bow', hit = null},
		value = 0.5,
	},
	
	arrow_hail = {
		code = 'arrow_hail',
		descript = '',
		icon = "res://assets/images/iconsskills/arrowshower.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'aoe', 'ultimate'],
		reqs = [{code = 'gear_equiped', param = 'geartype', value = 'bow', check = true}],
		targetreqs = [],
		effects = [], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'weapon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 1.2,
		random_factor_p = 0.1,
		sfx = [{code = 'arrowhail', target = 'target_group', period = 'windup'}], 
		sounddata = {initiate = null, strike = 'bow', hit = null},
		variations = [
			{
				reqs = [{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'}],
				set = {combatcooldown = 4} #to prevent spaming
			}
		]
	},
	firearrows_apply = { #fix
		code = 'firearrows_apply',
		descript = '',
		icon = load("res://assets/images/iconsskills/fire_arrows.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff', 'instant', 'selfbuf'],
		reqs = [
			{code = 'gear_equiped', param = 'geartype', value = 'bow', check = true}
		],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'firearrows'})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat',
		variations = [
			{
				reqs = [{code = 'has_status', status = 'firearrows', check = true}],
				set = {
					name = tr('SKILLFIREARROWS_REMOVE'),
#					icon = load("res://assets/images/iconsskills/fire_arrows_off.png")
				}, 
				append = {tags = 'aura_active'}
			},
			{
				reqs = [
					{code = 'has_status', status = 'firearrows', check = true},
					{orflag = true, code = 'has_status', status = 'poisonarrows', check = true},
					{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'},
					],
				set = {targetreqs = [{code = 'false'}],} #disable after first use
			}
		]
	},
	poisonarrows_apply = { #fix
		code = 'poisonarrows_apply',
		descript = '',
		icon = load("res://assets/images/iconsskills/skill_dip_poison.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff', 'instant', 'selfbuf'],
		reqs = [
			{code = 'gear_equiped', param = 'geartype', value = 'bow', check = true}
		],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'poisonarrows'})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat',
		variations = [
			{
				reqs = [{code = 'has_status', status = 'poisonarrows', check = true}],
				set = {
					name = tr('SKILLPOISONARROWS_REMOVE'),
#					icon = load("res://assets/images/iconsskills/fire_arrows_off.png") #2add proper icon change
					}, 
				append = {tags = 'aura_active'}
			},
			{
				reqs = [
					{code = 'has_status', status = 'firearrows', check = true},
					{orflag = true, code = 'has_status', status = 'poisonarrows', check = true},
					{code = 'stat', stat = 'combatgroup', value = 'enemy', operant = 'eq'},
					],
				set = {targetreqs = [{code = 'false'}],} #disable after first use
			}
		]
	},
}
var effects = {
	
	firearrows = {
		type = 'temp_s',
		stack = 'firearrows',
		rem_event = [variables.TR_WEAPON, variables.TR_DEATH],
		target = 'caster',
		tags = ['firearrows', 'e_damage_buff'],
		sub_effects = ['firearrows_passive', 'firearrows_trigger', 'aura_cost'],
		statchanges = {damagetype = 'fire'},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/fire_arrows.png",
				description = "FIREARROWBUFF", 
				tags = ['combat_only'],
			}
		],
	},
	firearrows_passive = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F, variables.TR_COMBAT_F],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [{code = 'stat', stat = 'mp', operant = 'lte', value = 0}],
				atomic = [{type = 'remove_effect', value = 'firearrows'},],
			}
		]
	},
	firearrows_trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['target_range', 'eq', 'any']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		buffs = [],
		sub_effects = ['burn'],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			duration = {obj = 'self', func = 'dur', dur = 2},
			chance = {obj = 'self', func = 'chance', chance = 0.2}
		},
	},
	poisonarrows = {
		type = 'temp_s',
		stack = 'firearrows',
		rem_event = [variables.TR_WEAPON, variables.TR_DEATH],
		target = 'caster',
		tags = ['poisonarrows'],
		sub_effects = ['poisonarrows_passive', 'poisonarrows_trigger', 'poisonarrows_trigger_2', 'aura_cost'],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/skill_dip_poison.png",
				description = "POISONARROWBUFF", 
				tags = ['combat_only'],
			}
		],
	},
	poisonarrows_passive = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F, variables.TR_COMBAT_F],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [{code = 'stat', stat = 'mp', operant = 'lte', value = 0}],
				atomic = [{type = 'remove_effect', value = 'poisonarrows'},],
			}
		]
	},
	poisonarrows_trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['target_range', 'eq', 'any']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		buffs = [],
		sub_effects = ['poison'],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			duration = {obj = 'self', func = 'dur', dur = 3},
			chance = {obj = 'self', func = 'chance', chance = 0.65}
		},
	},
	poisonarrows_trigger_2 = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'caster', value = [{code = 'stat', stat = 'mastery_marksmanship', value = 4, operant = 'gte'}]}, 
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['target_range', 'eq', 'any']},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		buffs = [],
		sub_effects = ['e_s_shred'],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			duration = {obj = 'self', func = 'dur', dur = 2},
			chance = {obj = 'self', func = 'chance', chance = 0.25}
		},
	},
	aura_cost = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S, variables.TR_COMBAT_F],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'stat_add', stat = 'mp', value = -1},],
			},
		]
	},
}
var atomic_effects = {}
var buffs = {
	b_trap = {
		icon = "res://assets/images/iconsskills/Trap.png",
		description = "BUFFDESCRIPTTRAP",
		limit = 1,
		t_name = 'trap'
	},
	b_bolttrap = {
		icon = "res://assets/images/iconsskills/skill_bolt_trap.png",
		description = "BUFFDESCRIPTBOLTTRAP",
		limit = 1,
		t_name = 'bolt_trap'
	},
}

var stacks = {
	trap_debuff = {}, #st 1
	bolttrap_debuff = {}, #st 1
}
