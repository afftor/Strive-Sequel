extends Reference

var skills = {
	mass_defend = {
		code = 'mass_defend',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support', 'aoe', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = ['e_protect'],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all_allowed',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
}
var effects = {
	e_protect = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		req_skill = true,
		sub_effects = ['defend_temp', 'defend_mark'],
		buffs = []
	},
	defend_mark = {
		type = 'temp_s',
		target = 'caster',
		stack = 'defender',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['defender'],
		buffs = ['b_defender'],
	},
	defend_temp = {
		type = 'temp_global',
		tags = ['duration_none', 'defended'],
		target = 'target',
		req_skill = true,
		name = 'defended',
		timers = [
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		sub_effects = ['defend_retarget', 'defend_reduce'],
	},
	defend_retarget = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['tags', 'hasno', 'aoe']},
			{type = 'owner', value = [{code = 'has_status', status = 'defender', check = false}]},
			{type = 'defender', value = [{code = 'has_status', status = 'disable', check = false}]},
			],
		trigger = [variables.TR_DEF],
		req_skill = true,
		args = {defender = {obj = 'parent', func = 'arg', arg = 'caster'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'defender',
				atomic = [{type = 'sfx', value = 'targetattack'}],
			},
			{
				type = 'oneshot',
				target = 'skill',
				args = {defender = {obj = 'parent', func = 'arg', arg = 'defender'}},
				atomic = [{type = 'stat_set', stat = 'target', value = ['parent_args', 'defender']}],
			},
		],
		buffs = []
	},
	defend_reduce = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['tags', 'has', 'aoe']},
			{type = 'owner', value = [{code = 'has_status', status = 'defender', check = false}]},
			{type = 'defender', value = [{code = 'has_status', status = 'disable', check = false}]},
			],
		trigger = [variables.TR_DEF],
		req_skill = true,
		args = {defender = {obj = 'parent', func = 'arg', arg = 'caster'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.25}],
			},
		],
		buffs = []
	},
	
	setup_retarget_default = Effectdata.rebuild_autocast({skill = 'mass_defend', trigger = [variables.TR_COMBAT_S]}),
}
var atomic_effects = {}
var buffs = {
	b_defender = {
		icon = "res://assets/images/traits/hitrate.png",#2fix
		description = "BUFFDESCRIPTDEFENDER",
		limit = 1,
		t_name = 'defender'
	},
	b_defended = {
		icon = "res://assets/images/traits/hitrate.png",#2fix
		description = "BUFFDESCRIPTDEFENDED",
		limit = 1,
		t_name = 'defended'
	},
}

var stacks = {
	defender = {} #st 1
}
