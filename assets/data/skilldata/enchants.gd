extends Reference

var skills = {
}
var effects = {
	curse_decline_1 = Effectdata.rebuild_stat_bonus('exp_gain_mod', -0.25),
	curse_decline_2 = Effectdata.rebuild_stat_bonus('exp_gain_mod', -0.5),
	curse_fragility_1 = Effectdata.rebuild_stat_bonus('hpmax_add_part', -0.2),
	curse_fragility_2 = Effectdata.rebuild_stat_bonus('hpmax_add_part', -0.4),
	
	enchant_spellmas_1 = {
		type = 'base',
		stack = 'spell_mastery',
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.1}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.1}),
		],
	},
	enchant_spellmas_2 = {
		type = 'base',
		stack = 'spell_mastery',
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.15}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.15}),
		],
	},
	enchant_spellmas_3 = {
		type = 'base',
		stack = 'spell_mastery',
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.2}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.2}),
		],
	},
	enchant_spellmas_4 = {
		type = 'base',
		stack = 'spell_mastery',
		sub_effects = [
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'damage', value = 1.25}),
			Effectdata.rebuild_skillvalue_template({skilltype = 'spell', tag = 'heal', value = 1.25}),
		],
	},
	enchant_thorns_1 = {
		type = 'base',
		stack = 'thorns',
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
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = {
						damage = {obj = 'skill', func = 'get', arg = 'process_value'},
						src = {obj = 'self', func = 'src', src = 'true'},
						mod = {obj = 'self', func = 'src', src = 0.1},
					},
					atomic = [{type = 'sfx', value = 'targetattack'}, 'a_damage_new'],
				}]
			},
		]
	},
	enchant_thorns_2 = {
		type = 'base',
		stack = 'thorns',
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
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = {
						damage = {obj = 'skill', func = 'get', arg = 'process_value'},
						src = {obj = 'self', func = 'src', src = 'true'},
						mod = {obj = 'self', func = 'src', src = 0.15},
					},
					atomic = [{type = 'sfx', value = 'targetattack'}, 'a_damage_new'],
				}]
			},
		]
	},
	enchant_thorns_3 = {
		type = 'base',
		stack = 'thorns',
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
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = {
						damage = {obj = 'skill', func = 'get', arg = 'process_value'},
						src = {obj = 'self', func = 'src', src = 'true'},
						mod = {obj = 'self', func = 'src', src = 0.2},
					},
					atomic = [{type = 'sfx', value = 'targetattack'}, 'a_damage_new'],
				}]
			},
		]
	},
	enchant_thorns_4 = {
		type = 'base',
		stack = 'thorns',
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
				sub_effects = [{
					type = 'oneshot',
					target = 'caster',
					args = {
						damage = {obj = 'skill', func = 'get', arg = 'process_value'},
						src = {obj = 'self', func = 'src', src = 'true'},
						mod = {obj = 'self', func = 'src', src = 0.25},
					},
					atomic = [{type = 'sfx', value = 'targetattack'}, 'a_damage_new'],
				}]
			},
		]
	},
	enchant_vampirism_1 = {
		type = 'base',
		stack = 'vampirism',
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
		type = 'base',
		stack = 'vampirism',
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
		type = 'base',
		stack = 'vampirism',
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
		type = 'base',
		stack = 'vampirism',
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
		type = 'base',
		stack = 'vampirism',
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
		type = 'base',
		stack = 'ench_commander',
		tags = ['area', 'area_allied'],
		args = {mod = {obj = 'self', func = 'src', src = 0.03}},
		sub_effects = ['e_s_commander'] 
	},
	enchant_commander_2 = {
		type = 'base',
		stack = 'ench_commander',
		tags = ['area', 'area_allied'],
		args = {mod = {obj = 'self', func = 'src', src = 0.05}},
		sub_effects = ['e_s_commander']
	},
	e_s_commander = {
		type = 'base',
		tags = [],
		stack = 'commander',
		args = {
			mod = {obj = 'parent', func = 'arg', arg = 'mod'}
		},
		statchanges = {atk_add_part = ['arg', 'mod'], matk_add_part = ['arg', 'mod'], damage_reduction = [['arg', 'mod'], '*', 100]},
		buffs = ['b_command'],
	},
	
	enchant_warlock_1 = {
		type = 'temp_global',
		tags = ['duration_none'],
		stack = 'warlock',
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		statchanges = {manacost_mod = -0.1},
	},
	enchant_warlock_2 = {
		type = 'temp_global',
		tags = ['duration_none'],
		stack = 'warlock',
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		statchanges = {manacost_mod = -0.15},
	},
	enchant_warlock_3 = {
		type = 'temp_global',
		tags = ['duration_none'],
		stack = 'warlock',
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		statchanges = {manacost_mod = -0.2},
	},
	enchant_warlock_4 = {
		type = 'temp_global',
		tags = ['duration_none'],
		stack = 'warlock',
		timers = [
			{events = [variables.TR_NONE], objects = 'owner', timer = 2}, #effectively infinite
		],
		statchanges = {manacost_mod = -0.25},
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
		stack = 'manasiphon',
		trigger = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'skill']}],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = {amount = {obj = 'self', func = 'amount', amount = 1}},
			atomic = ['a_manasiphon']
		}],
		buffs = []
	},
	
	enchant_manasiphon_2 = {
		type = 'trigger',
		stack = 'manasiphon',
		trigger = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'skill']}],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = {amount = {obj = 'self', func = 'amount', amount = 2}},
			atomic = ['a_manasiphon']
		}],
		buffs = []
	},
	
	enchant_manasiphon_3 = {
		type = 'trigger',
		stack = 'manasyphon',
		trigger = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'skill']}],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = {amount = {obj = 'self', func = 'amount', amount = 3}},
			atomic = ['a_manasiphon']
		}],
		buffs = []
	},
}
var atomic_effects = {
	a_manasiphon = {type = 'mana', value = ['parent_args', 'amount']},
}
var buffs = {}

var stacks = {
	spell_mastery = {}, #st1
	thorns = {
		type = 'stack',
	},
	vampirism = {
		type = 'stack',
	},
	ench_commander = {},
	commander = {},
	warlock = {}, #st 1
	manasiphon = {}, #st 1
}
