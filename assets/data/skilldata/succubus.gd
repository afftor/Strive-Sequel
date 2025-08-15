extends Reference

var skills = {
	corruptive_essence = {
		code = 'corruptive_essence',
		descript = '',
		icon = null,
		type = 'social', 
		ability_type = 'item',
		tags = ['positive'],
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
		cost = {mp = 10},
		charges = 1,
		cooldown = 3,
		icon = load("res://assets/images/iconsskills/Mindread.png"),
		tags = ['succubus', 'can_miss'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'praise',
		value = [['0']],
		damagestat = 'no_stat',
	},
	release_thrall = { 
		code = 'release_thrall',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}
			],
		effects = ['release_thrall'],
		cost = {},
		charges = 1,
		cooldown = 0,
		icon = load("res://assets/images/iconsskills/Mindread.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'praise',
		value = [['0']],
		damagestat = 'no_stat',
	},
	corrupt = { 
		code = 'corrupt',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [],
		chance = {
			condition = [{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}],
			value = 100,
			altvalue = ['caster.sexuals_factor', '*15'],
			},
		targetreqs = [
#			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}
			],
		effects = [],
		cost = {mp = 6},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/Mindread.png"),
		tags = ['succubus', 'can_miss', 'refine_chance'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'praise',
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
		reqs = [],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}
			],
		effects = [],
		cost = {mp = 10},
		charges = 1,
		cooldown = 3,
		icon = load("res://assets/images/iconsskills/Mindread.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'praise',
		value = [['caster.charm_factor', '+5'], ['50']],
		damagestat = ['+loyalty', '-resistance'],
	},
	turn_succubus = { 
		code = 'turn_succubus',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']},
			{code = 'stat', stat = 'consent', operant = 'gte', value = 5},
			],
		effects = ['release_thrall', 'make_succubus'],
		cost = {mp = 50},
		charges = 1,
		cooldown = 7,
		icon = load("res://assets/images/iconsskills/Mindread.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'praise',
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
			description = "THRALLDESCRIPT",
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
			description = "THRALLDESCRIPT",
			tags = ['show_in_traits']
		}
		],
		sub_effects = [],
	},
	magic_atunement = {
		type = 'simple',
		descript = '',
		conditions = [],
		tags = ['magic_atunement'],
		statchanges = {matk = 10, mpmax_add = 25},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLDESCRIPT",
			tags = ['show_in_traits']
		}
		],
		sub_effects = [],
	},
	combat_atunement_passive = {
		type = 'simple',
		descript = '',
		conditions = [],
		tags = ['combat_atunement'],
		statchanges = {hpmax_add_part = 0.2},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "THRALLDESCRIPT",
			tags = ['show_in_traits']
		}
		],
		sub_effects = [],
	},
	combat_atunement_trigger = {
		type = 'base',
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
}
var atomic_effects = {}
var buffs = {}
var stacks = {}
