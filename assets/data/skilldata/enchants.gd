extends Reference

var skills = {
	pas_commander_1 = {
		code = 'pas_commander_1',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template_globals({effect = 'e_s_commander', push_value = true})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null, hittype = 'bodyarmor'},
		value = ['0.03'],
		damagestat = 'no_stat',
		not_final = true
	},
	pas_commander_2 = {
		code = 'pas_commander_2',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template_globals({effect = 'e_s_commander', push_value = true})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null, hittype = 'bodyarmor'},
		value = ['0.05'],
		damagestat = 'no_stat',
		not_final = true
	},
}
var effects = {
	curse_decline_1 = Effectdata.rebuild_stat_bonus('exp_gain_mod', -0.25),
	curse_decline_2 = Effectdata.rebuild_stat_bonus('exp_gain_mod', -0.5),
	curse_fragility_1 = Effectdata.rebuild_stat_bonus('hpmax', -0.2, null, 'stat_add_p'),
	curse_fragility_2 = Effectdata.rebuild_stat_bonus('hpmax', -0.4, null, 'stat_add_p'),
	
	enchant_spellmas_1 = {
		type = 'static',
		atomic = [],
		buffs = [],
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.1}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.1}),
		],
		args = []
	},
	enchant_spellmas_2 = {
		type = 'static',
		atomic = [],
		buffs = [],
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.15}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.15}),
		],
		args = []
	},
	enchant_spellmas_3 = {
		type = 'static',
		atomic = [],
		buffs = [],
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.2}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.2}),
		],
		args = []
	},
	enchant_spellmas_4 = {
		type = 'static',
		atomic = [],
		buffs = [],
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.25}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.25}),
		],
		args = []
	},
	enchant_thorns_1 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = [{obj = 'parent_arg_get', param = 'process_value', index = 0}],
					atomic = [
						{type = 'sfx', value = 'targetattack'}, 
						{type = 'damage', value = [['parent_args', 0], '*', 0.1], source = 'true'}]
				}],
				buffs = []
			},
		]
	},
	enchant_thorns_2 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = [{obj = 'parent_arg_get', param = 'process_value', index = 0}],
					atomic = [
						{type = 'sfx', value = 'targetattack'},
						{type = 'damage', value = [['parent_args', 0], '*', 0.15], source = 'true'}]
				}],
				buffs = []
			},
		]
	},
	enchant_thorns_3 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = [{obj = 'parent_arg_get', param = 'process_value', index = 0}],
					atomic = [
						{type = 'sfx', value = 'targetattack'},
						{type = 'damage', value = [['parent_args', 0], '*', 0.2], source = 'true'}]
				}],
				buffs = []
			},
		]
	},
	enchant_thorns_4 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = [{obj = 'parent_arg_get', param = 'process_value', index = 0}],
					atomic = [
						{type = 'sfx', value = 'targetattack'},
						{type = 'damage', value = [['parent_args', 0], '*', 0.25], source = 'true'}]
				}],
				buffs = []
			},
		]
	},
	enchant_vampirism_1 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				conditions = [
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'skill',
					atomic = [{type = 'stat_add', stat = 'is_drain', value = 0.02}]
				}],
				buffs = []
			},
		]
	},
	enchant_vampirism_2 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				conditions = [
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'skill',
					atomic = [{type = 'stat_add', stat = 'is_drain', value = 0.04}]
				}],
				buffs = []
			},
		]
	},
	enchant_vampirism_3 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				conditions = [
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'skill',
					atomic = [{type = 'stat_add', stat = 'is_drain', value = 0.06}]
				}],
				buffs = []
			},
		]
	},
	enchant_vampirism_4 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				conditions = [
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'skill',
					atomic = [{type = 'stat_add', stat = 'is_drain', value = 0.08}]
				}],
				buffs = []
			},
		]
	},
	enchant_vampirism_5 = {
		type = 'static',
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				conditions = [
					{type = 'skill', value = ['damage_type', 'eq', 'normal'] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				req_skill = true,
				args = [{obj = 'self', param = 'skill' }],
				sub_effects = [{
					type = 'oneshot',
					target = 'skill',
					atomic = [{type = 'stat_add', stat = 'is_drain', value = 0.1}]
				}],
				buffs = []
			},
		]
	},
	
	enchant_commander_1 = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET, variables.TR_COMBAT_S],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj'}],
				atomic = [{type = 'use_combat_skill', skill = 'pas_commander_1', target = ['parent_args', 0]}],
			}
		]
	},
	enchant_commander_2 = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET, variables.TR_COMBAT_S],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj'}],
				atomic = [{type = 'use_combat_skill', skill = 'pas_commander_2', target = ['parent_args', 0]}],
			}
		]
	},
	e_s_commander = {
		type = 'temp_global',
		tags = ['duration_none'],
		target = 'target',
		name = 'commander',
		stack = 1,
		args = [{obj = 'parent_args', param = 2}],
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 2}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = ['parent_args', 0]},
			{type = 'stat_add_p', stat = 'matk', value = ['parent_args', 0]},
			{type = 'stat_add', stat = 'damage_reduction', value = [['parent_args', 0], '*', 100]}
		],
		buffs = ['b_command'],
		sub_effects = [],
	},
	
	enchant_warlock_1 = {
		type = 'temp_global',
		tags = ['duration_none'],
		name = 'enchant_warlock',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		atomic = [
			{type = 'stat_add', stat = 'manacost_mod', value = -0.1}
		],
		buffs = [],
		sub_effects = [],
	},
	enchant_warlock_2 = {
		type = 'temp_global',
		tags = ['duration_none'],
		name = 'enchant_warlock',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		atomic = [
			{type = 'stat_add', stat = 'manacost_mod', value = -0.15}
		],
		buffs = [],
		sub_effects = [],
	},
	enchant_warlock_3 = {
		type = 'temp_global',
		tags = ['duration_none'],
		name = 'enchant_warlock',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		atomic = [
			{type = 'stat_add', stat = 'manacost_mod', value = -0.2}
		],
		buffs = [],
		sub_effects = [],
	},
	enchant_warlock_4 = {
		type = 'temp_global',
		tags = ['duration_none'],
		name = 'enchant_warlock',
		stack = 1,
		args = [],
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		atomic = [
			{type = 'stat_add', stat = 'manacost_mod', value = -0.25}
		],
		buffs = [],
		sub_effects = [],
	},
	
	enchant_reaper_1 = Effectdata.rebuild_skillvalue_template({target_race = 'humanoid', tag = 'damage',  value = 1.2}),
	enchant_beasthunter_1 = Effectdata.rebuild_skillvalue_template({target_race = 'beast', tag = 'damage',  value = 1.2}),
	enchant_undeadbane_1 = Effectdata.rebuild_skillvalue_template({target_race = 'undead', tag = 'damage',  value = 1.2}),
	enchant_giantslayer_1 = Effectdata.rebuild_skillvalue_template({target_race = 'giant', tag = 'damage',  value = 1.2}),
	enchant_dragonslayer_1 = Effectdata.rebuild_skillvalue_template({target_race = 'dragon', tag = 'damage',  value = 1.2}),
	enchant_reaper_2 = Effectdata.rebuild_skillvalue_template({target_race = 'humanoid', tag = 'damage',  value = 1.3}),
	enchant_beasthunter_2 = Effectdata.rebuild_skillvalue_template({target_race = 'beast', tag = 'damage',  value = 1.3}),
	enchant_undeadbane_2 = Effectdata.rebuild_skillvalue_template({target_race = 'undead', tag = 'damage',  value = 1.3}),
	enchant_giantslayer_2 = Effectdata.rebuild_skillvalue_template({target_race = 'giant', tag = 'damage',  value = 1.3}),
	enchant_dragonslayer_2 = Effectdata.rebuild_skillvalue_template({target_race = 'dragon', tag = 'damage',  value = 1.3}),
	enchant_reaper_3 = Effectdata.rebuild_skillvalue_template({target_race = 'humanoid', tag = 'damage',  value = 1.4}),
	enchant_beasthunter_3 = Effectdata.rebuild_skillvalue_template({target_race = 'beast', tag = 'damage',  value = 1.4}),
	enchant_undeadbane_3 = Effectdata.rebuild_skillvalue_template({target_race = 'undead', tag = 'damage',  value = 1.4}),
	enchant_giantslayer_3 = Effectdata.rebuild_skillvalue_template({target_race = 'giant', tag = 'damage',  value = 1.4}),
	enchant_dragonslayer_3 = Effectdata.rebuild_skillvalue_template({target_race = 'dragon', tag = 'damage',  value = 1.4}),
	
	enchant_manasiphon_1 = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'skill']}],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [{obj = 'template', param = 'amount'}],
			amount = 1,
			atomic = ['a_manasiphon']
		}],
		buffs = []
	},
	
	enchant_manasiphon_2 = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'skill']}],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [{obj = 'template', param = 'amount'}],
			amount = 2,
			atomic = ['a_manasiphon']
		}],
		buffs = []
	},
	
	enchant_manasiphon_3 = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'skill']}],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [{obj = 'template', param = 'amount'}],
			amount = 3,
			atomic = ['a_manasiphon']
		}],
		buffs = []
	},
}
var atomic_effects = {
	a_manasiphon = {type = 'mana', value = ['parent_args', 0]},
}
var buffs = {}
