extends Reference

var skills = {
	corruptive_essence = {
		code = 'corruptive_essence',
		descript = '',
		icon = null,
		type = 'social', 
		ability_type = 'item',
		tags = ['positive', 'no_target'],
		reqs = [],
		targetreqs = [],
		effects = ['make_succubus'], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'potused',
		sfx = [], 
		sound = [],
		value = [['0']],
		damagestat = ['no_stat']
	},
	enthrall = { 
		code = 'enthrall',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		chance = [['caster.charm_factor', '*15'], '-', ['target.wits_factor', '*10'], '_10'],
		reqs = [{code = 'can_add_thrall', check = true}],
		targetreqs = [
			{code = 'trait', trait = 'succubus', check = false},
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = null}
			],
		effects = ['turn_thrall'],
		cost = {mp = 10, lust = 10},
		charges = 1,
		cooldown = 3,
		icon = load("res://assets/images/iconsskills/Great_Seduce.png"),
		tags = ['succubus', 'can_miss'],
		dialogue_report = '',
		dialogue_report_failed = '',
		dialogue_show_repeat = false,
		dialogue_image = 'mindcontrol',
		value = [['100']],
		damagestat = 'base_exp',
		receiver = 'caster'
	},
	release_thrall = { 
		code = 'release_thrall',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [
			{code = 'stat', stat = 'thralls_amount', operant = 'gte', value = 1}
		],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}
			],
		effects = ['release_thrall'],
		cost = {},
		charges = 1,
		cooldown = 0,
		icon = load("res://assets/images/iconsskills/Serve2.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'nightmare',
		value = [['0']],
		damagestat = 'no_stat',
	},
	corrupt = { 
		code = 'corrupt',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 1}
		],
		chance = {
			condition = [{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}],
			value = 100,
			altvalue = ['caster.sexuals_factor', '*15'],
			},
		targetreqs = [
#			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}
			],
		effects = [],
		cost = {mp = 6, lust = 15},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconstraits/corrupt.png"),
		tags = ['succubus', 'can_miss', 'refine_chance'],
		dialogue_report = '',
		dialogue_report_failed = '',
		dialogue_show_repeat = false,
		dialogue_image = 'succubuslust',
		value = [['1']],
		damagestat = '+consent',
		variations = [
			{
				reqs = [{code = 'stat', stat = 'sexuals_factor', value = 4, operant = 'gte'}],
				set = {value = [['2']]},
			}
		]
	},
	allure = { 
		code = 'allure',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 1}
		],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}
			],
		effects = [],
		cost = {mp = 10, lust = 25},
		charges = 1,
		cooldown = 3,
		icon = load("res://assets/images/iconsskills/Charm.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'charm',
		value = [['caster.charm_factor', '+5'], ['50']],
		damagestat = ['+loyalty', '-resistance'],
	},
	turn_succubus = { 
		code = 'turn_succubus',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 3}
		],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']},
			{code = 'stat', stat = 'consent', operant = 'gte', value = 5},
			],
		effects = ['release_thrall', 'make_succubus'],
		cost = {mp = 50, lust = 50},
		charges = 1,
		cooldown = 7,
		icon = load("res://assets/images/iconsskills/turnsuccubus.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'succubuslust',
		value = [['0']],
		damagestat = 'no_stat',
	},
	swap_form = { 
		code = 'swap_form',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 3}
		],
		targetreqs = [],
		effects = ['swap_form'],
		cost = {lust = 75},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/demonform.png"),
		tags = ['succubus', 'no_target'],
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		dialogue_report = '',
		dialogue_report_failed = '',
		dialogue_show_repeat = false,
		dialogue_image = 'seduce',
		value = [['0']],
		damagestat = 'no_stat',
	},
}
var effects = {
	turn_thrall = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {
			target = {obj = 'target', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = {value = {obj = 'caster', func = 'get', arg = 'id'}},
				atomic = [{type = 'stat_set', stat = 'thrall_master', value = ['parent_args', 'value']}],
			}
		]
	},
	release_thrall = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {
			target = {obj = 'target', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'stat_set', stat = 'thrall_master', value = null}],
			}
		]
	},
	make_succubus = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {target = {obj = 'target', func = 'eq'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'add_class', class = 'succubus'}],
			}
		]
	},
	demon_form = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'alt_form', value = true, operant = 'eq'},
			{code = 'stat', stat = 'race', value = 'Demon', operant = 'neq'},
			],
		tags = ['demon_form'],
		statchanges = {wits_bonus = 10, physics_bonus = 10, damage_mod_all = 0.15},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "DEMONFORMDESCRIPT",
			tags = ['show_in_traits']
		}
		],
		sub_effects = [],
	},
	human_form = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'alt_form', value = true, operant = 'eq'},
			{code = 'stat', stat = 'race', value = 'Demon', operant = 'eq'},
			],
		tags = ['human_form'],
		statchanges = {charm_bonus = 20, productivity = 0.25},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "HUMANFORMDESCRIPT",
			tags = ['show_in_traits']
		}
		],
		sub_effects = [],
	},
	swap_form = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {
			caster = {obj = 'caster', func = 'eq'},
			},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = {value = {obj = 'caster', func = 'stat', stat = 'alt_form'}},
				atomic = [{type = 'stat_set', stat = 'alt_form', value = ['not', ['parent_args', 'value']]}],
			}
		]
	},
	magic_atunement = {
		type = 'simple',
		descript = '',
		conditions = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 5}
		],
		tags = ['magic_atunement'],
		statchanges = {matk = 10, mpmax_add = 25, mp_reg_add_part = 0.5},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "MAGATTUNEMENTDESCRIPT",
		}
		],
		sub_effects = [],
	},
	combat_atunement_passive = {
		type = 'simple',
		descript = '',
		conditions = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 5}
		],
		tags = ['combat_atunement'],
		statchanges = {hpmax_add_part = 0.2, hp_reg_add_part = 1.0},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "COMBATATTUNEMENTDESCRIPT",
		}
		],
		sub_effects = [],
	},
	combat_atunement_trigger = {
		type = 'base',
		conditions = [
#			{code = 'stat', stat = 'thrall_points', operant = 'gte', value = 5}
		],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				req_skill = true,
				sub_effects = [{
					type = 'oneshot',
					target = 'target',
					atomic = [{type = 'stat_add', stat = 'lust', value = 3},],
				}]
			},
		]
	},
	succubus_thralls_0 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 0}
		],
		statchanges = {lustmax_add = 10, lusttick_add = 1, chg_persuasion_max = 1,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS0DESCRIPT",
		}
		],
	},
	succubus_thralls_1 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 1}
		],
		statchanges = {lustmax_add = 20, lusttick_add = 3, charm_bonus = 5, chg_persuasion_max = 1,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS1DESCRIPT",
		}
		],
	},
	succubus_thralls_2 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 2}
		],
		statchanges = {lustmax_add = 30, lusttick_add = 4.5, charm_bonus = 5, chg_persuasion_max = 2,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS2DESCRIPT",
		}
		],
	},
	succubus_thralls_3 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 3}
		],
		statchanges = {lustmax_add = 45, lusttick_add = 6, charm_bonus = 10, chg_persuasion_max = 2,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS3DESCRIPT",
		}
		],
	},
	succubus_thralls_4 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 4}
		],
		statchanges = {lustmax_add = 60, lusttick_add = 7.5, charm_bonus = 10, chg_persuasion_max = 2,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS4DESCRIPT",
		}
		],
	},
	succubus_thralls_5 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 5}
		],
		statchanges = {lustmax_add = 80, lusttick_add = 9, charm_bonus = 15, chg_persuasion_max = 3,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS5DESCRIPT",
		}
		],
	},
	succubus_thralls_6 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'thralls_amount', operant = 'eq', value = 6}
		],
		statchanges = {lustmax_add = 100, lusttick_add = 12, charm_bonus = 20, chg_persuasion_max = 3,},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLS6DESCRIPT",
		}
		],
	},
}
var atomic_effects = {}
var buffs = {}
var stacks = {}
