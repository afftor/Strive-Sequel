extends Node
var effects = {
}

var effect_nolog = ['commander']
#to fix EFFECT TAGS TO TEMPLATE
#'positive'/'negative' - the widest classification (to most global cleaning like bard2 skill effect)
#'buff'/'debuff' - additional markings for common effect removal effects (like purge) (and maybe add two more for a state effects)
#any other - for additional customisation

var effect_table = {
	e_remove_fa = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]}],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_set', stat = 'follow_up', value = null}]
		}],
		buffs = []
	},
	#maxstat
	e_phy6 = {
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 6}],
		statchanges = {hp_reg_add_part = 1},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("PHYSICS_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	e_wit6 = {
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'wits_factor', operant = 'gte', value = 6}],
		statchanges = {exp_gain_mod = 0.2},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("WITS_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	e_charm6 = {
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 6}],
		statchanges = {mod_service = 0.25, chg_persuasion_max = 1},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("CHARM_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	e_sex6 = {
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 6}],
		statchanges = {speed = 10},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("SEXUALS_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	e_auth6 = {
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'authority_factor', operant = 'gte', value = 6}],
		statchanges = {damage_reduction = 15},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("TIMID_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	e_mag6 = {
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'magic_factor', operant = 'gte', value = 6}],
		statchanges = {matk_add_part = 0.1},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("MAGIC_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	e_tame6 = { #real effect is in trainings, for display only
		type = 'base',
		stack = 'max_stats',
		descript = '',
		conditions = [{code = 'stat', stat = 'tame_factor', operant = 'gte', value = 6}],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = tr("TAME_FACTORBONUSDESCRIPT"),
				tags = ['show_in_traits', 'mansion_only']
			},
		]
	},
	
	e_love = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'has_relationship',  value = 'lovers', check = true}],
		statchanges = {mp_reg_add_part = 0.1},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_lovers.png",
			description = "TRAITEFFECTLOVERS",
			tags = ['show_in_traits', 'mansion_only']
		}
		],
		sub_effects = [],
	},
	e_friend = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'has_relationship',  value = 'friends', check = true}],
		statchanges = {hp_reg_add_part = 0.1},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_friends.png",
			description = "TRAITEFFECTFRIENDS",
			tags = ['show_in_traits', 'mansion_only']
		}
		],
		sub_effects = [],
	},
	e_rival = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'has_relationship',  value = 'rivals', check = true}],
		statchanges = {productivity = 0.05},
		buffs = [ 
			{
			icon = "res://assets/images/iconstraits/trait_rivals.png",
			description = "TRAITEFFECTRIVAL",
			tags = ['show_in_traits', 'mansion_only']
		}
		],
		sub_effects = [],
	},
	
	e_virgin = {
		type = 'simple',
		descript = '',
		conditions = [
			{code = 'stat', stat = 'sex', operant = 'neq', value = 'male'},
			{code = 'stat', stat = 'vaginal_virgin', operant = 'eq', value = true},
			],
		tags = ['virgin'],
		buffs = [{
			icon = "res://assets/images/iconstraits/lotus.png",
			description = "TRAITEFFECTVIRGIN",
			tags = ['show_in_traits', 'mansion_only']
		},],
	},
	#personality
	e_person_bold = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'bold'}],
		statchanges = {productivity = 0.05},
	},
	e_person_shy = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'shy'}],
		statchanges = {manacost_mod_mul = 0.85}
	},
	e_person_kind = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'kind'}],
		statchanges = {mod_service = 0.1}

	},
	e_person_serious = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'stat', stat = 'personality', operant = 'eq', value = 'serious'}],
		statchanges = {base_task_crit_chance = 0.03},
	},
	#traits
	e_tr_resist = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'eq', 'spell'] },
			{type = 'random', value = 0.25}
		],
		req_skill = true,
		args = {skill = {obj = 'skill', func = 'eq'}},
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}]
		}],
		buffs = []
	},
	#curses and enchantments
	e_s_nostun = rebuild_stat_bonus('resist_stun_set', 200),
	# i think we need to display those statuses as buffs
	
	work_rule_luxury = {
		type = 'base',
		conditions = [{code = 'workrule', check = true, value = 'luxury'}],
		statchanges = {exp_gain_mod = 0.05, productivity = 0.05},
		sub_effects = [rebuild_simple_dot(['loyalty'], [0.5], variables.TR_DAY),],
	},
	work_rule_ration = {
		type = 'simple',
		conditions = [{code = 'workrule', check = true, value = 'ration'}],
		statchanges = {food_consumption = 3, productivity = 0.15},
	},
	work_rule_shifts = {
		type = 'simple',
		conditions = [{code = 'workrule', check = true, value = 'shifts'}],
		statchanges = {productivity = 0.25},
		tags = ['no_working_bonuses'],
	},
	work_rule_masturbation = {
		type = 'simple',
		conditions = [{code = 'workrule', check = true, value = 'masturbation'}],
		statchanges = {lusttick_add_part = 0.15},
	},
	
	e_tr_copy_25 = { 
		type = 'trigger',
		trigger = [variables.TR_CAST],
		reset = [variables.TR_TURN_GET], #mb not, idk how it can be wrong
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'random', value = 0.25}
			],
		args = {skill = {obj = 'skill', func = 'eq'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'clone'}],
			}
		]
	},
	
	e_s_dayoff = {
		type = 'temp_s',
		stack = 'dayoff',
		duration = 4,
		tick_event = [variables.TR_TICK],
		rem_event = [variables.TR_DEATH],
		tags = ['no_job', 'no_combat'],
		buffs = ['b_dayoff'],
	},
	e_food_like = {
		type = 'temp_s',
		stack = 'food',
		tick_event = variables.TR_TICK,
		duration = 4,
		statchanges = {productivity = 0.05, exp_gain_mod = 0.05},
		buffs = [
			{
				icon = "res://assets/images/gui/gui icons/food_love.png",
				description = "TRAITEFFECTFAVFOOD",
				tags = ['mansion_only'],#mb remove
			}
		],
	},
	e_food_dislike = {
		type = 'temp_s',
		stack = 'food',
		tick_event = variables.TR_TICK,
		duration = 4,
		statchanges = {productivity = -0.1},
		buffs = [
			{
				icon = "res://assets/images/gui/gui icons/food_hate.png",
				description = "TRAITEFFECTHATEDFOOD",
				tags = ['mansion_only'],#mb remove
			}
		],
	},
	e_starve = {
		type = 'temp_s',
		stack = 'food',
		tick_event = variables.TR_TICK,
		duration = 4,
		statchanges = {productivity = -0.5, damage_mod_all = -0.5},
		tags = ['starvation'],#['addition_rest_tick'], 
		buffs = [
			{
				icon = "res://assets/images/iconsitems/food_old.png",
				description = "TRAITEFFECTSTARVE", 
			}
		],
	},
	e_injury = { #seems to be not used
		type = 'temp_s',
		stack = 'injury',
		tick_event = variables.TR_TICK,
		duration = 4,
		tags = ['addition_rest_tick', 'injury'],
		statchanges = {hpmax_add_part = -0.2},
		buffs = [
			{#to fix
				icon = "res://assets/images/iconsitems/food_old.png",
				description = "No food has been eaten: Exhaustion does not restore while resting.",
			}
		],
	},
	e_g_injury_delay = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_F],
		req_skill = false,
		tags = ['on_dead'],
		conditions = [],
		args = {duration = {obj = 'duration', func = 'eq'}}, 
		sub_effects = ['e_grave_injury',
			{
				type = 'oneshot',
				target = 'self',
				execute = 'remove'
			}
		]
	},
	e_grave_injury = {
		type = 'temp_s',
		stack = 'injury',
		tick_event = variables.TR_TICK,
		target = 'owner',
		duration = 'arg',
		sub_effects = [],
		tags = ['addition_rest_tick', 'no_combat', 'on_dead', 'injury'],# need to implement person.has_status('no_combat') check in exploration interface
		statchanges = {productivity = -0.25, sexuals_bonus = -50},
		buffs = [
			{#to fix
				icon = "res://assets/images/iconsskills/icon_blood_explosion.png",
				description = "TRAITEFFECTGRAVEINJ", 
			}
		],
	},
	
	e_s_undead = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [],
		args = {target = {obj = 'target', func = 'eq'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'add_trait', trait = 'undead'}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	#skills
	e_target_kill = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = ['a_self_kill'],
				buffs = [],
				sub_effects = []
			}
		],
		buffs = []
	},
	e_s_regen = {
		type = 'temp_s',
		stack = 'regen',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['positive'],
		args = {value = {obj = 'value', func = 'eq'}},
		sub_effects = ['e_t_regen'],
		atomic = [],
		buffs = ['b_regen'], 
	},
	e_t_regen = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = {value = {obj = 'value', func = 'eq'}},
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = {value = {obj = 'parent', func = 'arg', arg = 'value'}},
				atomic = ['a_sanctuary_heal'],
			}
		]
	},
	e_s_fireburst = {
		type = 'temp_s',
		target = 'target',
		stack = 'fireburst',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative'],
		statchanges = {hitrate = -20},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Mindread.png",
				description = "TRAITEFFECTFIREBURST",
			}
		],
	},
	e_s_arrowrain = {
		type = 'temp_s',
		target = 'target',
		stack = 'arrowrain',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative'],
		statchanges = {mdef = -20},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/arrowshower.png",
				description = "TRAITEFFECTARROWRAIN",
			}
		],
	},
	e_s_sstrike = {
		type = 'temp_s',
		target = 'target',
		stack = 'sstrike',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative'],
		statchanges = {atk = -20, matk = -20},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Sedate.png",
				description = "TRAITEFFECTSSTRIKE",
			}
		],
	},
	e_t_holy = {
		type = 'temp_s',
		target = 'target',
		stack = 'holydebuff',
		duration = 'arg',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['debuff', 'negative'],
		statchanges = {mdef = -20},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/light_spell_aoe.png",
				description = "TRAITEFFECTHOLY",
			}
		],
	},
	#statuses 
	e_s_taunt = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TAUNT_FAIL], #optional remove event
		tick_event = [variables.TR_TURN_F],
		duration = 2,
		stack = 'taunt',
		tags = ['debuff', 'taunt', 'negative', 'taunt_hard'],
		buffs = ['b_taunt'],
		args = {value = {obj = 'caster', func = 'get', arg = 'id'}},
		statchanges = {taunt = ['arg', 'value']},
	},
	e_s_taunt_new = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH, variables.TR_TAUNT_FAIL], #optional remove event
		tick_event = [variables.TR_TURN_F],
		duration = 2,
		stack = 'taunt',
		tags = ['debuff', 'taunt', 'negative', 'taunt_soft'],
		buffs = ['b_taunt'],
		args = {value = {obj = 'caster', func = 'get', arg = 'id'}},
		statchanges = {taunt = ['arg', 'value']},
	},
	e_t_hide = {
		type = 'temp_s',
		target = 'owner',
		rem_event = [variables.TR_HIT, variables.TR_COMBAT_F, variables.TR_DMG],
		stack = 'hide',
		tags = ['buff', 'hide'],
		atomic = [],
		buffs = ['b_hide'],
	},
	e_s_stonewall = {
		type = 'temp_s',
		target = 'caster',
		stack = 'stonewall',
		tick_event = [variables.TR_TURN_GET],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['positive', 'stonewall'],
		statchanges = {damage_reduction = 25},
		buffs = ['b_stonewall'], 
	},
	e_s_lasstand = {
		type = 'temp_s',
		tags = ['buff', 'positive', 'last_stand'],
		target = 'caster',
		tick_event = [variables.TR_TURN_GET],
		rem_event = [variables.TR_COMBAT_F],
		duration = 'arg',
		stack = 'last_stand',
		buffs = ['b_laststand'],
	},
	e_s_burn_new = {
		type = 'temp_s',
		target = 'target',
		stack = 'burn',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'burn'],
		args = {
			mod = {obj = 'caster', func = 'stat', stat = 'burn_mod'},
			mod_2 = {obj = 'target', func = 'stat', stat = 'burn_damage'},
			src = {obj = 'self', func = 'src', src = 'fire'}
		},
		sub_effects = ['e_dot_new'],
		buffs = ['b_burn'],
	},
	e_s_poison_new = {
		type = 'temp_s',
		target = 'target',
		stack = 'poison',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'poison'],
		args = {
			mod = {obj = 'caster', func = 'stat', stat = 'poison_mod'},
			mod_2 = {obj = 'target', func = 'stat', stat = 'poison_damage'},
			src = {obj = 'self', func = 'src', src = 'true'}
		},
		sub_effects = ['e_dot_new'],
		buffs = ['b_poison'],
	},
	
	e_s_bleed_new = {
		type = 'temp_s',
		target = 'target',
		stack = 'bleed',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'bleed'],
		args = {
			mod = {obj = 'caster', func = 'stat', stat = 'bleed_mod'},
			mod_2 = {obj = 'target', func = 'stat', stat = 'bleed_damage'},
			src = {obj = 'self', func = 'src', src = 'true'}
		},
		sub_effects = ['e_dot_new'],
		buffs = ['b_bleed'],
	},
	
	e_s_darkflame = {
		type = 'temp_s',
		target = 'target',
		stack = 'darkflame',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'darkflame'],
		args = {
			mod = {obj = 'caster', func = 'stat', stat = 'burn_mod'},
			mod_2 = {obj = 'target', func = 'stat', stat = 'darkflame_damage'},
			src = {obj = 'self', func = 'src', src = 'true'}
		},
		sub_effects = [
			rebuild_remove_effect('burn', 'owner'),
			'e_dot_new'
			],
		buffs = ['b_darkflame'],
	},
	e_dot_new = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		args = {
			mod = {obj = 'parent', func = 'arg', arg = 'mod'},
			src = {obj = 'parent', func = 'arg', arg = 'src'},
		},
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = {
					mod = {obj = 'parent', func = 'arg', arg = 'mod'}, 
					src = {obj = 'parent', func = 'arg', arg = 'src'}, 
					mod_2 = {obj = 'parent', func = 'arg', arg = 'mod_2'}, 
					base = {obj = 'owner', func = 'stat', stat = 'hpmax'}, 
				},
				atomic = ['a_dot_new'],
			}
		]
	},
	
	e_s_shred = {
		type = 'temp_s',
		tags = ['affliction', 'shred'],
		target = 'target',
		stack = 'shred',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		statchanges = {armor_add_part = -0.5},
		buffs = ['b_shred'],
	},
	e_s_shatter = {
		type = 'temp_s',
		tags = ['affliction', 'shatter'],
		target = 'target',
		stack = 'shatter',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		statchanges = {mdef_add_part = -0.5},
		buffs = ['b_shatter'],
	},
	
	e_s_sleep = {#1turn duration, can't pass duration onto global temps, so clone it for different duartions. until remade properly
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'disable', 'sleep'],
		target = 'target',
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 1}, #1 turn duration
			{events = [variables.TR_DMG], objects = 'owner', timer = 1}, #damage removes
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		buffs = ['b_sleep'],
	},
	e_s_sleep_compartibility = {#1turn duration, can't pass duration onto global temps, so clone it for different duartions. until remade properly
		#THIS EFFECT IS STUB, DO NOT COPY, DO NOT EDIT - it uses reversed order of parent trigger args, so it is conterintuitive
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'disable', 'sleep'],
		target = 'target',
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'target', timer = 1}, #1 turn duration of CASTER
			{events = [variables.TR_DMG], objects = 'owner', timer = 1}, #damage removes
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'target', timer = 1}, #CASTER
		],
		buffs = ['b_sleep'],
	},
	e_s_blind = {
		type = 'temp_s',
		target = 'target',
		stack = 'blind',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'blind'],
		statchanges = {hitrate = -50},
		buffs = ['b_blind'],
	},
	e_s_fear = {
		type = 'temp_s',
		target = 'target',
		stack = 'fear',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'fear'],
		statchanges = {damage_mod_all = -0.25},
		buffs = ['b_fear'],
	},
	e_s_shock = {
		type = 'temp_s',
		target = 'target',
		stack = 'shock',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction', 'shock', 'negative'],
		statchanges = {damage_reduction = -15},
		buffs = ['b_shock'],
	},
	e_s_ensnare = { #1turn duration, can't pass duration onto global temps, so clone it for different duartions. until remade properly
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'ensnare'],
		target = 'target',
		name = 'ensnare',
		stack = 1,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 1}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		statchanges = {evasion = -75},
		buffs = ['b_ensnare'],
	},
	e_s_ensnare2 = { #2turn duration, can't pass duration onto global temps, so clone it for different duartions. until remade properly
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'ensnare'],
		target = 'target',
		name = 'ensnare',
		stack = 1,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 2}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		statchanges = {evasion = -75},
		buffs = ['b_ensnare'],
	},
	e_s_ensnare5 = { #5turn duration, can't pass duration onto global temps, so clone it for different duartions. until remade properly
		type = 'temp_global',
		tags = ['duration_turns', 'affliction', 'ensnare'],
		target = 'target',
		name = 'ensnare',
		stack = 1,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 5}, 
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		statchanges = {evasion = -75},
		buffs = ['b_ensnare'],
	},
	e_s_cursed = {
		type = 'temp_s',
		target = 'target',
		stack = 'cursed',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'cursed'],
		statchanges = {resist_fire = -40, resist_earth = -40, resist_water = -40, resist_air = -40, resist_light = -40, resist_dark = -40, resist_mind = -40,},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/icon_elementa_weakness.png",
				description = "TRAITEFFECTCURSE",
				tags = ['combat_only'],
			}
		],
	},
	e_s_stun = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'arg',
		stack = 'stun',
		tags = ['debuff', 'stun', 'disable', 'negative'],
		buffs = ['b_stun'],
	},
	e_s_charm = {#parent duration
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DMG],
		tick_event = [variables.TR_TURN_F],
		duration = 'arg',
		stack = 'charm',
		tags = ['debuff', 'charm', 'disable'],
		buffs = ['b_charm_c'],
	},
	e_s_wet = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
#		tick_event = [variables.TR_TURN_F],
		stack = 'wet',
		tags = ['debuff', 'wet', 'negative'],
		buffs = ['b_wet'],
		sub_effects = ['e_t_wet']
	},
	e_t_wet = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['damage_type', 'in', ['air', 'fire']] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'air']],
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.5},],
			},
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'fire']],
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.5},],
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'wet'}],
			},
		]
	},
	e_s_freeze = {#parent-duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_POSTDAMAGE, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'arg',
		stack = 'freeze',
		tags = ['debuff', 'freeze', 'disable', 'negative'],
		buffs = ['b_freeze'],
		sub_effects = ['e_t_freeze']
	},
	e_t_freeze = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'air']],
				atomic = [{type = 'stat_mul', stat = 'value', value = 2.0/1.25}],
			},
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [['damage_type', 'eq', 'fire']],
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.5/1.25}],
			},
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.25}],
			},
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'remove_all_effects', value = 'freeze'}],
			},
		]
	},
	e_s_disarm = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'arg',
		stack = 'disarm',
		tags = ['debuff', 'disarm'],
		buffs = ['b_disarm'],
	},
	e_s_silence = {#duration version
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'arg',
		stack = 'silence',
		tags = ['debuff', 'silence'],
		buffs = ['b_silence'],
	},
	e_s_growl = {
		type = 'temp_s',
		target = 'target',
		stack = 'growl',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['affliction'],
		statchanges = {speed = -20, evasion = -20},
		buffs = ['b_growl'],
	},
	e_s_rejuvenation = {
		type = 'temp_s',
		target = 'target',
		stack = 'rejuvenation',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['positive'],
		sub_effects = ['e_t_rejuvenation'],
		buffs = ['b_regen'],
	},
	e_t_rejuvenation = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {base = {obj = 'owner', func = 'stat', stat = 'hpmax'}},
				atomic = [{type = 'heal', value = [['parent_args', 'base'], '*', 0.15]},],
			},
		]
	},
	e_s_mward = {
		type = 'temp_s',
		target = 'target',
		stack = 'magicward',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 4,
		tags = ['positive', 'buff'],
		statchanges = {atk_add_part = 0.25, mdef = 40},
		buffs = ['b_magicward'],
	},
	e_s_mward2 = {
		type = 'temp_s',
		target = 'target',
		stack = 'magicward',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['positive', 'buff'],
		statchanges = {atk_add_part = 0.25, mdef = 40},
		buffs = ['b_magicward'],
	},
	e_s_slam = {
		type = 'temp_s',
		target = 'target',
		stack = 'slam',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['negative'],
		statchanges = {resist_damage_heal = -100},
		buffs = ['b_slam'],
	},
	e_s_takeposition = {
		type = 'temp_s',
		duration = 2,
		target = 'target',
		stack = 'takeposition',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		statchanges = {damage_mod_all = 0.2, armorpenetration = 50},
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/takeposition.png",
			description = "TRAITEFFECTPOSITIONTAKEN",
		}]
	},
	#items
	e_i_shackles = rebuild_simple_dot(['loyalty', 'spirit'], [1, -1], variables.TR_DAY),
	e_i_handcuffs = rebuild_simple_dot(['loyalty', 'spirit'], [0.5, -0.5], variables.TR_DAY),
	e_i_collar = rebuild_simple_dot(['loyalty', 'spirit'], [5, -5], variables.TR_DAY),
	e_i_pet_suit_bonus = {
		type = 'simple',
		conditions = [{code = 'has_profession', profession = 'pet', check = true}],
		descript = "TRAITEFFECTPETSUIT",
		statchanges = {charm_bonus = 10},
	},
	e_i_anal = {
		type = 'simple',
		conditions = [{code = 'trait', trait = 'anal', check = true}],
		descript = "TRAITEFFECTANAL",
		statchanges = {lusttick_add_part = 0.15},
	},
	e_handcuffs_effect = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DAY],
		descript = "TRAITEFFECTHANDCUFFS",
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {index = {obj = 'self', func = 'src', src = 1}, value = {obj = 'self', func = 'src', src = 10},},
				atomic = ['a_add_counter_args'],
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [
					{code = 'stat_index', stat = 'counters', index = 1, operant = 'gte', value = 100},
					{code = 'trait', trait = 'submissive', check = false},
				],
				atomic = [{type = 'add_sex_trait', trait = 'submissive'}],
			},
		],
		buffs = []
	},
	e_anal_trait_counter = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_DAY],
		descript = "TRAITEFFECTANALCOUNT",
		req_skill = false,
		args = {factor = {dynamic = true, obj = 'owner', func = 'stat', stat = 'sexuals_factor'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {factor = {obj = 'factor', func = 'eq'}, mod = {obj = 'self', func = 'src', src = 12}},
				atomic = [
					{type = 'add_counter', index = 2, value = [['parent_args', 'factor'],'*',['parent_args', 'mod']]}
				],
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [
					{code = 'stat_index', stat = 'counters', index = 2, operant = 'gte', value = 100},
					{code = 'trait', trait = 'anal', check = false},
				],
				atomic = [{type = 'add_sex_trait', trait = 'anal'}],
			},
		],
	},
	e_res = {
		type = 'oneshot',
		target = 'target',
		args = {mod = {obj = 'value', func = 'eq'}},
		atomic = ['a_res'],
	},
	#temp items
	e_tail_plug_bonus = {
		type = 'simple',
		tags = ['recheck_item'],
		conditions = [{code = 'gear_equiped', value = 'pet_suit', check = true}],
		statchanges = {charm_bonus = 10},
		descript = "TRAITEFFECTTAILPLUGBONUS",
	},
	#core
	satisfaction_1 = {
		type = 'temp_s',
		target = 'target',
		stack = "satisfaction",
		tick_event = variables.TR_TICK,
		duration = 6,
		statchanges = {productivity = 0.1},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
				description = "TRAITEFFECTSATISFIED",
				tags = ['mansion_only'],
			}
		],
	},
	satisfaction_2 = {
		type = 'temp_s',
		target = 'target',
		stack = "satisfaction",
		tick_event = variables.TR_TICK,
		duration = 6,
		statchanges = {productivity = 0.2},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Reward_with_sex 3.png",
				description = "TRAITEFFECTSATISFIED",
				tags = ['mansion_only'],
			}
		],
	},
	
	celena_bless = {
		type = 'temp_s',
		duration = 2,
		stack = 'celena_bless',
		tick_event = [variables.TR_TICK],
		statchanges = {damage_reduction = 30},
		sub_effects = [{
				type = 'oneshot',
				atomic = [{type = 'remove_all_effects', value = 'injury'}],
			},],
		buffs = [{
			icon = "res://assets/images/iconsskills/icon_protective_shell.png",
			description = "TRAITEFFECTCELENABLESS",
		}]
	},
	freya_bless = {
		type = 'temp_s',
		duration = 4,
		stack = 'freya_bless',
		tick_event = [variables.TR_TICK],
		statchanges = {armorpenetration = 30, hitrate = 25},
		buffs = [{
			icon = "res://assets/images/iconsskills/heavyshot.png",
			description = "TRAITEFFECTFREYABLESS",
		}]
	},
	celena_curse = {
		type = 'temp_s',
		duration = 4,
		stack = 'celena_curse',
		tick_event = [variables.TR_TICK],
		statchanges = {hpmax_mul = 0.5},
		buffs = [{
			icon = "res://assets/images/iconsskills/BloodMagic.png",
			description = "TRAITEFFECTCELENACURSE",
		}]
	},
	hybris_curse = {
		type = 'temp_s',
		duration = 4,
		stack = 'hybris_curse',
		tick_event = [variables.TR_TICK],
		statchanges = {armor_mul = 0.5},
		buffs = [{
			icon = "res://assets/images/iconsskills/Acid-spit.png",
			description = "TRAITEFFECTHYBRISCURSE",
		}]
	},
	freya_curse = {
		type = 'temp_s',
		duration = 8,
		stack = 'freya_curse',
		tick_event = [variables.TR_TICK],
		statchanges = {evasion = -50, hitrate = -50},
		buffs = [{
			icon = "res://assets/images/iconsskills/BloodMagic.png",
			description = "TRAITEFFECTFREYACURSE",
		}]
	},
	e_pregnancy = {
		type = 'simple',
		tags = ['pregnant'],
		statchanges = {speed = -10, physics_bonus = -20},
		conditions = [
			{code = 'stat', stat = 'pregnancy_duration', operant = 'lte', value = variables.pregduration * 2 / 3},
			{code = 'stat', stat = 'pregnancy_duration', operant = 'gt', value = variables.pregduration / 3},
			{code = 'trait', trait = 'breeder', check = false}
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/preg_icon1.png",
			description = "TRAITEFFECTISPREGNANT",
		}]
	},
	e_pregnancy1 = {
		type = 'simple',
		tags = ['pregnant', 'heavy_pregnant'],
		conditions = [
			{code = 'stat', stat = 'pregnancy_duration', operant = 'lte', value = variables.pregduration / 3},
			{code = 'stat', stat = 'pregnancy_duration', operant = 'gt', value = 0},
			{code = 'trait', trait = 'breeder', check = false}
		],
		statchanges = {speed = -20, physics_bonus = -40},
		buffs = [{
			icon = "res://assets/images/iconsskills/preg_icon2.png",
			description = "TRAITEFFECTISPREGNANT2",
		}]
	},
	e_pregnancy_breeder = {
		type = 'simple',
		tags = ['pregnant'],
		statchanges = {speed = -10, physics_bonus = -20},
		conditions = [
			{code = 'stat', stat = 'pregnancy_duration', operant = 'lte', value = variables.pregduration / 3},
			{code = 'stat', stat = 'pregnancy_duration', operant = 'gt', value = 0},
			{code = 'trait', trait = 'breeder', check = true}
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/preg_icon1.png",
			description = "TRAITEFFECTISPREGNANT",
		}]
	},
	e_brand = rebuild_simple_dot(['loyalty', 'spirit'], [0.5, -0.5], variables.TR_DAY),
	e_mkup = {
		type = 'simple',
		statchanges = {charm_bonus = 10},
	},
	e_tlust1 = {
		type = 'simple',
		statchanges = {lusttick_add_part = 0.1},
	},
	e_tlust2 = {
		type = 'simple',
		statchanges = {lusttick_add_part = 0.2},
	},
	e_thpr = {
		type = 'simple',
		statchanges = {hp_reg_add_part = 0.2},
	},
	e_tmpr = {
		type = 'simple',
		statchanges = {mp_reg_add_part = 0.1},
	},
	e_trib1 = {
		type = 'simple',
		statchanges = {physics_bonus = 3},
	},
	e_trib2 = {
		type = 'simple',
		statchanges = {hpmax_add = 5},
	},
	
	e_instant = {
		type = 'oneshot',
		target = 'skill',
		atomic = [{type = 'setup_instant'}],
	}
};

var atomic = {
	a_remove_buff = {type = 'remove_effect', value = 'buff'},
	a_self_kill = {type = 'kill'},
	a_add_counter_args = {type = 'add_counter', index = ['parent_args', 'index'], value = ['parent_args', 'value']},
	
	a_dot_new = {type = 'damage', source = ['parent_args', 'src'], value = [['parent_args', 'value'], '*', ['parent_args', 'mod'], '*', ['parent_args', 'mod_2'],]},
	a_damage_new = {type = 'damage', source = ['parent_args', 'src'], value = [['parent_args', 'value'], '*', ['parent_args', 'mod'],]},
	a_damage_simple = {type = 'damage', source = ['parent_args', 'src'], value = [['parent_args', 'value']]},
#	a_burn_new = {type = 'damage', source = 'fire', value = [['parent_args', 'value'], '*', ['parent_args', 'mod'], '*', ['parent_args', 'mod_2'],]},
#	a_darkflame = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', ['parent_args', 1], '*', ['parent_args', 2],]},
#	a_poison_new = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', ['parent_args', 1], '*', ['parent_args', 2],]},
#	a_bleed_new = {type = 'damage', source = 'true', value = [['parent_args', 0], '*', ['parent_args', 1], '*', ['parent_args', 2],]},
	a_sanctuary_heal = {type = 'heal', value = ['parent_args', 'value']},
};


var stacks = {
	default = {
		type = 'stack',
	}, #transparent buffs
	max_stats = {
		type = 'stack', 
		buff = 'b_factor_maxed'
	}, #unified buff
	dayoff = {}, #stack 1
	food = {
		type = 'stack',
	}, #transparent buffs
	injury = {}, #stack 1
	regen = {}, #stack 1
	fireburst = {}, #stack 1
	arrowrain = {}, #stack 1
	sstrike = {}, #stack 1
	blind = {}, #stack 1
	fear = {}, #stack 1
	shock = {}, #stack 1
	stun = {}, #stack 1
	charm = {}, #stack 1
	wet = {}, #stack 1
	freeze = {}, #stack 1
	disarm = {}, #stack 1
	silence = {}, #stack 1
	growl = {}, #stack 1
	slam = {}, #stack 1
	cursed = {
		type = 'stack_a',
		stack = 1,
	}, #stack 1 merge dur
	holydebuff = {}, #stack 1
	taunt = {}, #stack 1
	hide = {}, #stack 1
	satisfaction = {}, #stack 1
	celena_bless = {}, #stack 1
	celena_curse = {}, #stack 1
	freya_bless = {}, #stack 1
	freya_curse = {}, #stack 1
	hybris_curse = {}, #stack 1
	stonewall = {}, #stack 1
	last_stand = {}, #stack 1
	rejuvenation = {}, #stack 1
	magicward = {}, #stack 1
	takeposition = {}, #stack 1
	burn = {
		type = 'stack_s',
		stack = 1,
	}, #stack 1, add dur
	bleed = {
		type = 'stack_s',
		stack = 1,
	}, #stack 1, add dur
	poison = {
		type = 'stack_s',
		stack = 1,
	}, #stack 1, add dur
	darkflame = {
		type = 'stack_s',
		stack = 1,
	}, #stack 1, add dur
	shred = {
		type = 'stack_a',
		stack = 2,
	}, #stack 2, merge dur
	shatter = {
		type = 'stack_a',
		stack = 2,
	}, #stack 2, merge dur
}

#needs filling
var buffs = {
	#new part
	#icons are defined by path or by name in images.icons, do not load images here!
	b_stun = {
		icon = "res://assets/images/traits/experience.png", #?? mb to fix
		description = "BUFFDESCRIPTSTUN",
	},
	b_charm_c = {
		icon = "res://assets/images/iconsskills/Charm.png", #?? mb to fix
		description = "BUFFDESCRIPTCHARM2",
	},
	b_mirror = {
		icon = "res://assets/images/traits/hitrate.png",
		description = "BUFFDESCRIPTMIRROR",
	},
	b_taunt= {
		icon = "res://assets/images/traits/hitrate.png",
		description = "BUFFDESCRIPTTAUNT",
	},
	b_silence = {
		icon = "res://assets/images/iconsskills/Seduce.png",
		description = "BUFFDESCRIPTSILENCE",
	},
	b_wet = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "BUFFDESCRIPTWET", 
	},
	b_freeze = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "BUFFDESCRIPTFROZEN", 
	},
	b_disarm = {
		icon = "res://assets/images/iconsskills/Shackle.png",
		description = "BUFFDESCRIPTDISARM",
	},
	b_regen = {
		icon = "res://assets/images/iconsskills/lesserheal.png",
		description = "BUFFDESCRIPTREGEN",
	},
	b_stonewall = {
		icon = "res://assets/images/iconsskills/icon_endure.png",
		description = "BUFFDESCRIPTSTONEWALL",
		tags = ['combat_only']
	},
	b_laststand = {
		icon = "res://assets/images/iconsskills/skill_last_stand.png",
		description = "BUFFDESCRIPTLASTSTAND",
		tags = ['combat_only']
	},
	b_burn = {
		icon = "res://assets/images/iconsskills/firebolt.png",
		description = "BUFFDESCRIPTBURNING",
	},
	b_darkflame = {
		icon = "res://assets/images/iconsskills/dark flame.png",
		description = "BUFFDESCRIPTDARKFLAME",
	},
	b_poison = {
		icon = "res://assets/images/iconsskills/skill_dip_poison.png",
		description = "BUFFDESCRIPTPOISON",
	},
	b_bleed = {
		icon = "res://assets/images/iconsskills/icon_blood_explosion.png",
		description = "BUFFDESCRIPTBLEEDING",
	},
	b_confuse = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTCONFUSE",
	},
	b_command = {
		icon = "res://assets/images/iconsskills/Authority.png", 
		description = "BUFFDESCRIPTCOMMANDBONUS",
		tags = ['combat_only']
	},
	b_shred = {
		icon = "res://assets/images/iconsskills/Acid-spit.png",
		description = "BUFFDESCRIPTSHRED",
		tags = ['combat_only']
	},
	b_shatter = {
		icon = "res://assets/images/iconsskills/icon_elemental_protection.png",
		description = "BUFFDESCRIPTSHATTER",
		tags = ['combat_only']
	},
	
	b_sleep = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTSLEEP",
		tags = ['combat_only']
	},
	b_blind = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTBLIND",
		tags = ['combat_only']
	},
	b_fear = {
		icon = "res://assets/images/iconsskills/Fear.png",
		description = "BUFFDESCRIPTFEAR",
		tags = ['combat_only']
	},
	b_shock = {
		icon = "res://assets/images/iconsskills/Innervate.png",
		description = "BUFFDESCRIPTSHOCK",
		tags = ['combat_only']
	},
	b_ensnare = {
		icon = "res://assets/images/iconsskills/skill_ensnare.png",
		description = "BUFFDESCRIPTENSNARE",
		tags = ['combat_only']
	},
	b_growl = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTGROWL",
		tags = ['combat_only']
	},
	
	b_magicward = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTMAGICWARD",
		tags = ['combat_only']
	},
	b_slam = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTSLAM",
		tags = ['combat_only']
	},
	
	b_atkpass = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTATKPAS",
		tags = ['combat_only']
	},
	b_atkpass_src = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTATTACKPASSSRC",
		tags = ['combat_only']
	},
	b_factor_maxed = {
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "mfactor",
		tags = ['show_in_traits', 'mansion_only', 'unified_desc']
	},
	b_bold = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTBOLD",
	},
	b_kind = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTKIND",
	},
	b_shy = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTSHY",
	},
	b_serious = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "BUFFDESCRIPTSERIOUS",
	},
	b_dayoff = {
		icon = "res://assets/images/iconsenchants/curse_mono_100.png",#fix
		description = "",
	},
	b_hide = {
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		description = "TRAITEFFECTHIDE",
	},
};

func rebuild_template(args):
	var res = {
		type = 'trigger',
		req_skill = true,
		trigger = [],
		conditions = [],
		buffs = [],
		sub_effects = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			receiver = {obj = 'receiver', func = 'eq'},
		},
	}
	if args.has('trigger'): res.trigger.push_back(args.trigger) #for simplicity only one trigger type can be passed
	else: res.trigger.push_back(variables.TR_POSTDAMAGE)

	if args.has('res_condition'): res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', args.res_condition]})
	else: res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]})

	if args.has('checkres'):
		res.conditions.push_back({type = 'checkres', value = args.chance, resist = args.checkres})
	elif args.has('chance'):
		res.conditions.push_back({type = 'random', value = args.chance})

	if args.has('duration'): 
		res.args.duration = {obj = 'self', func = 'dur', dur = args.duration}
	if args.has('push_value'):
		res.args.process_value = {obj = 'parent', func = 'get', arg = 'process_value'}
	
	res.sub_effects.push_back(args.effect)

	return res


func rebuild_template_globals(args):
	var res = {
		type = 'trigger',
		req_skill = true,
		trigger = [],
		conditions = [],
		buffs = [],
		sub_effects = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
	}
	var targetcondition = {type = 'target', value = []}
	if args.has('trigger'): res.trigger.push_back(args.trigger) #for simplicity only one trigger type can be passed
	else: res.trigger.push_back(variables.TR_POSTDAMAGE)

	if args.has('res_condition'): res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', args.res_condition]})
	else: res.conditions.push_back({type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]})
	
	if args.has('target_status'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'has_status', check = true, status = args.target_status})
		res.conditions.push_back(tmp)
	
	if args.has('checkres'):
		res.conditions.push_back({type = 'checkres', value = args.chance, resist = args.checkres})
	elif args.has('chance'):
		res.conditions.push_back({type = 'random', value = args.chance})
	
	if args.has('push_value'):
		res.args.process_value = {obj = 'parent', func = 'get', arg = 'process_value'}
	
	res.sub_effects.push_back(args.effect)
	
	return res


func rebuild_skillvalue_template(args):
	var trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_HIT],
#		reset = [variables.TR_CAST],
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = []
	}
	var sub = {
		type = 'oneshot',
		target = 'skill',
		atomic = [],
	}
	var atomic = {type = 'stat_mul', stat = 'value', value = 1}
	var condition = {type = 'skill', value = []}
	var targetcondition = {type = 'target', value = []}
	if args.has('value'): #should be always true - for without it this makes no sence
		atomic.value = args.value
	
	sub.atomic.push_back(atomic)
	trigger.sub_effects.push_back(sub)
	
	if args.has('reset'):
		if args.reset is Array:
			trigger.reset = args.reset
		else:
			trigger.reset = [args.reset]
	
	if args.has('tag'):
		var tmp = condition.duplicate(true)
		tmp.value = ['tags', 'has', args.tag]
		trigger.conditions.push_back(tmp)
	
	if args.has('tags'):
		for tag in args.tags:
			var tmp = condition.duplicate(true)
			tmp.value = ['tags', 'has', tag]
			trigger.conditions.push_back(tmp)
	
	if args.has('skilltype'):
		var tmp = condition.duplicate(true)
		tmp.value = ['ability_type', 'eq', args.skilltype]
		trigger.conditions.push_back(tmp)
	
	if args.has('num_targets'):
		var tmp = condition.duplicate(true)
		tmp.value = ['target_number', 'eq', args.num_targets]
		trigger.conditions.push_back(tmp)
	
	if args.has('source'):
		var tmp = condition.duplicate(true)
		tmp.value = ['damage_type', 'eq', args.source]
		trigger.conditions.push_back(tmp)
	
	if args.has('target_race'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'stat', stat = 'racegroup', operant = 'eq', value = args.target_race})
		trigger.conditions.push_back(tmp)
	
	if args.has('target_tag'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'tags', operant = 'has', value = args.target_tag})
		trigger.conditions.push_back(tmp)
	
	if args.has('target_status'):
		var tmp = targetcondition.duplicate(true)
		tmp.value.push_back({code = 'has_status', check = true, status = args.target_status})
		trigger.conditions.push_back(tmp)
	
	return trigger


func rebuild_defvalue_template(args):
	var trigger = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_DEF],
#		reset = [variables.TR_CAST],
		conditions = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = []
	}
	var sub = {
		type = 'oneshot',
		target = 'skill',
		atomic = [],
	}
	var atomic = {type = 'stat_mul', stat = 'value', value = 1}
	var condition = {type = 'skill', value = []}
	var castercondition = {type = 'caster', value = []}
	if args.has('value'): #should be always true - for without it this makes no sence
		atomic.value = args.value
	
	sub.atomic.push_back(atomic)
	trigger.sub_effects.push_back(sub)
	
	if args.has('tag'):
		var tmp = condition.duplicate(true)
		tmp.value = ['tags', 'has', args.tag]
		trigger.conditions.push_back(tmp)
	
	if args.has('tags'):
		for tag in args.tags:
			var tmp = condition.duplicate(true)
			tmp.value = ['tags', 'has', tag]
			trigger.conditions.push_back(tmp)
	
	if args.has('skilltype'):
		var tmp = condition.duplicate(true)
		tmp.value = ['ability_type', 'eq', args.skilltype]
		trigger.conditions.push_back(tmp)
	
	if args.has('num_targets'):
		var tmp = condition.duplicate(true)
		tmp.value = ['target_number', 'eq', args.num_targets]
		trigger.conditions.push_back(tmp)
	
	if args.has('source'):
		var tmp = condition.duplicate(true)
		tmp.value = ['damage_type', 'eq', args.source]
		trigger.conditions.push_back(tmp)
	
	if args.has('caster_race'):
		var tmp = castercondition.duplicate(true)
		tmp.value.push_back({code = 'stat', stat = 'racegroup', operant = 'eq', value = args.caster_race})
		trigger.conditions.push_back(tmp)
	
	if args.has('caster_tag'):
		var tmp = castercondition.duplicate(true)
		tmp.value.push_back({code = 'tags', operant = 'has', value = args.caster_tag})
		trigger.conditions.push_back(tmp)
	
	return trigger


func rebuild_stat_bonus(bonus, value, buff = null):
	var template = {
		type = 'base',
		buffs = [],
		statchanges = {bonus : value}
	}
	if buff != null:
		template.buffs.push_back(buff)
	return template


func rebuild_simple_dot(stat, value, trigger = variables.TR_TURN_F): #for non-damage atomics
	var template = {
		type = 'trigger',
		trigger = [],
		req_skill = false,
		conditions = [],
		args = {},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [],
				atomic = [],
			}
		]
		}
	for i in range(stat.size()):
		var atomic_template = {type = 'stat_add', stat = '', value = ''}
		
		atomic_template.stat = stat[i]
		atomic_template.value = value[i]
		template.sub_effects[0].atomic.push_back(atomic_template)
	
	template.trigger.push_back(trigger)
	
	return template


func rebuild_remove_effect(eff, target = 'target'):
	var template = {
		type = 'oneshot',
		target = target,
		args = [],
		atomic = [{type = 'remove_all_effects', value = eff}],
	}
	
	return template


func rebuild_make_status(args):
	var atomic = {type = 'make_status_effect', parent = ['parent_id']}
	var template = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [],
	}
	atomic.effect = args.effect
	if args.has('duration'):
		atomic.duration = args.duration
	else:
		atomic.duration = 1
	if args.has('chance'):
		atomic.chance = args.chance
	else:
		atomic.chance = 1.0
	template.atomic.push_back(atomic)
	return template


func rebuild_autocast(args):
	var template = {
		type = 'trigger',
		trigger = [],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = []
		}
	var oneshot = {
		type = 'oneshot',
		target = 'owner',
		args = [{obj = 'app_obj'}],
		atomic = [],
		}
	var atomic = {type = 'use_combat_skill', skill = '', target = ['parent_args', 'skill']}
	atomic.skill = args.skill
	oneshot.atomic.push_back(atomic)
	template.trigger = args.trigger.duplicate()
	template.sub_effects.push_back(oneshot)
	return template


func get_effect_for_status(status):
	match status:
		'':
			return ''
		_:
			return status


func fix_eff_data():
	for eid in effect_table:
		var eff = effect_table[eid]
		if eff.type == 'simple':
			eff.name = eid
			if !eff.has('buffs'):
				eff.buffs = []
			if !eff.has('tags'):
				eff.tags = []
			if !eff.has('statchanges'):
				eff.statchanges = {}
		if eff.has('duration'):
			if eff.duration is String:
				if !eff.has('args'):
					eff.args = {}
				eff.args.duration = {obj = 'duration', func = 'eq'}
		if eff.has('req_skill'):
			if eff.req_skill:
				if !eff.has('args'):
					eff.args = {}
				eff.args.skill = {obj = 'skill', func = 'eq'}
				eff.args.caster = {obj = 'caster', func = 'eq'}
				eff.args.target = {obj = 'target', func = 'eq'}
		if eff.has('tick_event') and eff.tick_event is int:
			eff.tick_event = [eff.tick_event]
		if eff.has('rem_event') and eff.rem_event is int:
			eff.rem_event = [eff.rem_event]
	for st in stacks:
		if stacks[st].empty():
			stacks[st] = {
				type = 'stack_l',
				stack = 1
			}
