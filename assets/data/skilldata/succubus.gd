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
		#a full magic slot is put to the player before the essence is spent (ch_skills.ask_offered_trait_first)
		offers_trait = 'succubus',
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
		reqs = [{code = 'can_add_thrall', check = true}],
		targetreqs = [
			{code = 'is_master', check = false},
			{code = 'has_status', status = 'no_trainings', check = false},
			{code = 'trait', trait = 'succubus', check = false},
			{code = 'trait', trait = 'lesser_succubus', check = false},
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = null}
			],
		effects = ['turn_thrall'],
		#no lust: without thralls a succubus gains none, and Enthrall is how she gets the first one
		cost = {mp = 10},
		charges = 1,
		cooldown = 3,
		icon = load("res://assets/images/iconsskills/Great_Seduce.png"),
		tags = ['succubus'],
		dialogue_report = '',
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
		reqs = [],
		chance = {
			condition = [{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']}],
			value = 100,
			altvalue = ['caster.sexuals_factor', '*15'],
			},
		targetreqs = [
			{code = 'is_master', check = false},
			],
		effects = [],
		cost = {mp = 6, lust = 15},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/distract.png"),
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
	#training points for anybody; on the caster's own thrall it also opens one training action to them
	#for good. The points, the menu and the payment live in custom_effects.allure
	allure = {
		new_syntax = true,
		code = 'allure',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [],
		targetreqs = [
			{code = 'is_master', check = false},
			{code = 'is_id', operant = 'neq', value = ['caster.id']},
			],
		effects = [],
		cost = {mp = 10, lust = 25},
		charges = 1,
		cooldown = 3,
		icon = load("res://assets/images/iconsskills/Charm.png"),
		tags = ['succubus', 'refine_targetreqs', 'special_with_target'],
		target_number = 'single',
		target_range = 'any',
		special = 'allure',
	},
	#teaches the target a sex skill the caster has; the menu and the payment live in
	#custom_effects.perverted_mind. turn_cooldown: usable again next turn, not next day
	perverted_mind = {
		new_syntax = true,
		code = 'perverted_mind',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [],
		targetreqs = [
			{code = 'is_id', operant = 'neq', value = ['caster.id']},
			],
		effects = [],
		cost = {mp = 5, lust = 20},
		charges = 1,
		cooldown = 0,
		turn_cooldown = 1,
		icon = load("res://assets/images/iconsskills/Mindblast.png"),
		tags = ['succubus', 'refine_targetreqs', 'special_with_target'],
		target_number = 'single',
		target_range = 'any',
		special = 'perverted_mind',
	},
	#Thrall statuses: a succubus raises a thrall attached enough to her (Traitdata.succubus_levels.status_bond)
	#to one of them. They are traits tagged 'thrall_status' and end with the bond - ch_enthrall.remove_thrall_statuses.
	#Every one of them needs the Thrall Specialization power (Traitdata.succubus_trainings).
	grant_ascended_thrall = {
		code = 'grant_ascended_thrall',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [{code = 'trait', trait = 'thrall_specialization', check = true}],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']},
			{code = 'thrall_status_ready', check = true},
			{code = 'thrall_status_offer', trait = 'ascended_thrall', check = true},
			],
		effects = ['grant_ascended_thrall'],
		#a full magic slot is put to the player before the cooldown is spent
		offers_trait = 'ascended_thrall',
		cost = {mp = 20, lust = 30},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/Attract.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'charm',
		value = [['0']],
		damagestat = 'no_stat',
	},
	grant_lesser_succubus = {
		code = 'grant_lesser_succubus',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [{code = 'trait', trait = 'thrall_specialization', check = true}, {code = 'thrall_status_free', trait = 'lesser_succubus', check = true}],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']},
			{code = 'thrall_status_ready', check = true},
			{code = 'thrall_status_offer', trait = 'lesser_succubus', check = true},
			],
		effects = ['grant_lesser_succubus'],
		cost = {mp = 50, lust = 60},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/demonform.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'succubuslust',
		value = [['0']],
		damagestat = 'no_stat',
	},
	grant_lust_doll = {
		code = 'grant_lust_doll',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [{code = 'trait', trait = 'thrall_specialization', check = true}],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']},
			{code = 'thrall_status_ready', check = true},
			{code = 'thrall_status_offer', trait = 'lust_doll', check = true},
			],
		effects = ['grant_lust_doll'],
		#a mental slot full of something other than a bondage status is put to the player first
		offers_trait = 'lust_doll',
		cost = {mp = 10, lust = 40},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/Seduce.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'succubuslust',
		value = [['0']],
		damagestat = 'no_stat',
	},
	grant_chosen_consort = {
		code = 'grant_chosen_consort',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [{code = 'trait', trait = 'thrall_specialization', check = true}, {code = 'thrall_status_free', trait = 'chosen_consort', check = true}],
		targetreqs = [
			{code = 'stat', stat = 'thrall_master', operant = 'eq', value = ['caster.id']},
			{code = 'thrall_status_ready', check = true},
			{code = 'thrall_status_offer', trait = 'chosen_consort', check = true},
			],
		effects = ['grant_chosen_consort'],
		cost = {mp = 30, lust = 20},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/iconsskills/Inspire.png"),
		tags = ['succubus', 'refine_targetreqs'],
		dialogue_report = '',
		dialogue_show_repeat = false,
		dialogue_image = 'charm',
		value = [['0']],
		damagestat = 'no_stat',
	},
	swap_form = {
		code = 'swap_form',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [],
		targetreqs = [],
		effects = ['swap_form'],
		cost = {lust = 50},
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
	#the menu, the body change and the payment live in custom_effects.genitalia_manipulation
	genitalia_manipulation = {
		new_syntax = true,
		code = 'genitalia_manipulation',
		descript = '',
		type = 'social',
		ability_type = 'skill',
		social_skill_stats = [],
		reqs = [{code = 'sex', operant = 'neq', value = 'male'}],
		targetreqs = [],
		effects = [],
		cost = {lust = 20},
		charges = 1,
		cooldown = 1,
		icon = load("res://assets/images/sexicons/futa.png"),
		tags = ['succubus', 'no_target'],
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		special = 'genitalia_manipulation',
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
	grant_ascended_thrall = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {target = {obj = 'target', func = 'eq'}},
		sub_effects = [{type = 'oneshot', target = 'target', atomic = [{type = 'thrall_status', trait = 'ascended_thrall'}]}]
	},
	grant_lesser_succubus = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {target = {obj = 'target', func = 'eq'}},
		sub_effects = [{type = 'oneshot', target = 'target', atomic = [{type = 'thrall_status', trait = 'lesser_succubus'}]}]
	},
	grant_lust_doll = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {target = {obj = 'target', func = 'eq'}},
		sub_effects = [{type = 'oneshot', target = 'target', atomic = [{type = 'thrall_status', trait = 'lust_doll'}]}]
	},
	grant_chosen_consort = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {target = {obj = 'target', func = 'eq'}},
		sub_effects = [{type = 'oneshot', target = 'target', atomic = [{type = 'thrall_status', trait = 'chosen_consort'}]}]
	},
	#the succubus magic trait: a free magic slot takes it, a full one asks the player what it replaces
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
				atomic = [{type = 'add_trait', trait = 'succubus', mode = 'ask'}],
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
			tags = ['show_in_traits', 'mansion_only']
		}
		],
		sub_effects = [],
	},
	demon_form_default = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'alt_form', value = false, operant = 'eq'},
			{code = 'stat', stat = 'race', value = 'Demon', operant = 'eq'},
			#a lesser succubus has Change Form from her trait, which a learned-skill check does not see
			{code = 'or_list', or_list = [
				{code = 'has_skill', check = true, value = 'swap_form', learned = true},
				{code = 'trait', trait = 'lesser_succubus', check = true},
				]},
			],
		tags = ['demon_form'],
		statchanges = {wits_bonus = 10, physics_bonus = 10, damage_mod_all = 0.15},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "DEMONFORMDESCRIPT",
			tags = ['show_in_traits', 'mansion_only']
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
			tags = ['show_in_traits', 'mansion_only']
		}
		],
		sub_effects = [],
	},
	human_form_default = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'alt_form', value = false, operant = 'eq'},
			{code = 'stat', stat = 'race', value = 'Demon', operant = 'neq'},
			{code = 'or_list', or_list = [
				{code = 'has_skill', check = true, value = 'swap_form', learned = true},
				{code = 'trait', trait = 'lesser_succubus', check = true},
				]},
			],
		tags = ['human_form'],
		statchanges = {charm_bonus = 20, productivity = 0.25},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "HUMANFORMDESCRIPT",
			tags = ['show_in_traits', 'mansion_only']
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
		conditions = [],
		tags = ['magic_atunement'],
		statchanges = {matk = 10, mpmax_add = 25, mp_reg_add_part = 0.5},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "MAGATTUNEMENTDESCRIPT",
			tags = ['mansion_only']
		}
		],
		sub_effects = [],
	},
	combat_atunement_passive = {
		type = 'simple',
		descript = '',
		conditions = [],
		tags = ['combat_atunement'],
		statchanges = {hpmax_add_part = 0.2, hp_reg_add_part = 1.0},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png", #fix
			description = "COMBATATTUNEMENTDESCRIPT",
			tags = ['mansion_only']
		}
		],
		sub_effects = [],
	},
	combat_atunement_trigger = {
		type = 'base',
		conditions = [],
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
	#the elder succubus's level passives (Traitdata.succubus_levels); her lust growth comes from the
	#thralls themselves - ch_dyn_stats.fix_stat_data 'lusttick'
	succubus_level_1 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'succubus_level', operant = 'eq', value = 1}
		],
		statchanges = {lustmax_add = 10, charm_bonus = 5, chg_persuasion_max = 1,},
		buffs = [
			{
				icon = "res://assets/images/iconstraits/trait_lovers.png",
				description = "SUCCUBUSLEVEL1DESCRIPT",
				tags = ['mansion_only']
			}
		],
	},
	succubus_level_2 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'succubus_level', operant = 'eq', value = 2}
		],
		statchanges = {lustmax_add = 25, charm_bonus = 5, chg_persuasion_max = 2,},
		buffs = [
			{
				icon = "res://assets/images/iconstraits/trait_lovers.png",
				description = "SUCCUBUSLEVEL2DESCRIPT",
				tags = ['mansion_only']
			}
		],
	},
	succubus_level_3 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'succubus_level', operant = 'eq', value = 3}
		],
		statchanges = {lustmax_add = 40, charm_bonus = 10, chg_persuasion_max = 2,},
		buffs = [
			{
				icon = "res://assets/images/iconstraits/trait_lovers.png",
				description = "SUCCUBUSLEVEL3DESCRIPT",
				tags = ['mansion_only']
			}
		],
	},
	succubus_level_4 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'succubus_level', operant = 'eq', value = 4}
		],
		statchanges = {lustmax_add = 55, charm_bonus = 10, chg_persuasion_max = 2,},
		buffs = [
			{
				icon = "res://assets/images/iconstraits/trait_lovers.png",
				description = "SUCCUBUSLEVEL4DESCRIPT",
				tags = ['mansion_only']
			}
		],
	},
	succubus_level_5 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'succubus_level', operant = 'eq', value = 5}
		],
		statchanges = {lustmax_add = 70, charm_bonus = 15, chg_persuasion_max = 3,},
		buffs = [
			{
				icon = "res://assets/images/iconstraits/trait_lovers.png",
				description = "SUCCUBUSLEVEL5DESCRIPT",
				tags = ['mansion_only']
			}
		],
	},
	succubus_level_6 = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'succubus_level', operant = 'eq', value = 6}
		],
		statchanges = {lustmax_add = 90, charm_bonus = 20, chg_persuasion_max = 3,},
		buffs = [
			{
				icon = "res://assets/images/iconstraits/trait_lovers.png",
				description = "SUCCUBUSLEVEL6DESCRIPT",
				tags = ['mansion_only']
			}
		],
	},
}
var atomic_effects = {}
var buffs = {}
var stacks = {}
