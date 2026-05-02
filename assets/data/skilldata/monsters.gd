extends Reference
#specials, not core skills
var skills = {
	#ifrit
	pas_fireshield = {
		code = 'pas_fireshield',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'damage', 'fire', 'instant'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'earth_spike', target = 'target', period = 'postdamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 0.3,
		not_final = true
	},
	#erebus_stone
	pas_atkpass_remove = {
		code = 'pas_atkpass_remove',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_atkpass_remove'})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'earth_spike', target = 'target', period = 'postdamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 0,
		damagestat = 'no_stat',
		not_final = true
	},
	pas_atkpass_apply = {
		code = 'pas_atkpass_apply',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_atkpass'}), Effectdata.rebuild_template({effect = 'e_t_atkpass_remove'})], 
		cost = {},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'earth_spike', target = 'target', period = 'postdamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 0,
		damagestat = 'no_stat',
		not_final = true
	},
	#test
	test_summon = {
		code = 'test_summon',
		new_syntax = true,
		descript = '',
		icon = load("res://assets/images/iconsskills/defaultattack.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['summon'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'summon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = ['test_summon', 1],
		random_factor_p = 0.1,
		sfx = [{code = 'weapon', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
}
var effects = {
	#universal
	e_rare_sturdy = {
		type = 'simple',
		statchanges = {hpmax_add_part = 1.5, armorpenetration = 30},
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",
				description = "TRAITEFFECTRARESTURDY",
			}
		],
	},
	e_rare_nimble = {
		type = 'simple',
		statchanges = {evasion_add_part = 0.15, evasion = 30, speed = 15},
		buffs = [
			{
				icon = "res://assets/images/traits/speed.png",
				description = "TRAITEFFECTRARENIMBLE",
			}
		],
	},
	e_rare_strong = {
		type = 'simple',
		statchanges = {hpmax_add_part = 0.5, damage_mod_all = 0.2},
		buffs = [
			{
				icon = "res://assets/images/traits/firedamagebonus.png",
				description = "TRAITEFFECTRARESTRONG",
			}
		],
	},
	e_rare_deadly = {
		type = 'simple',
		statchanges = {hitrate_add_part = 0.3, damage_mod_all = 0.35},
		buffs = [
			{
				icon = "res://assets/images/traits/critrate.png",
				description = "TRAITEFFECTRAREDEADLY",
			}
		],
	},
	e_rare_precise = {
		type = 'simple',
		statchanges = {hitrate = 0.25, evasion = 35, mdef = 20},
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png",
				description = "TRAITEFFECTRAREPRECISE",
			}
		],
	},
	e_rare_tough = {
		type = 'simple',
		statchanges = {hpmax_add_part = 0.35, armor = 30, mdef = 30},
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png",
				description = "TRAITEFFECTRARETOUGH",
			}
		],
	},
	e_miniboss = {
		type = 'simple',
		statchanges = {hpmax_add_part = 1.75, atk_add_part = 0.25, hitrate = 20, evasion = 20},
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",
				description = "miniboss", 
			}
		],
	},
	e_boss = {
		type = 'simple',
		statchanges = {bleed_damage = 0.33, poison_damage = 0.33, burn_damage = 0.33, darkflame_damage = 0.33},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",
				description = "More resistant to Damage over time and Control effects",
			}
		],
	},
	e_s_lasstand_passive = {
		type = 'simple',
		tags = ['last_stand'],
	},
	e_transform_test = {
		type = 'base',
		sub_effects = [
			{
				type = 'trigger',
				conditions = [{type = 'owner', value = [{code = 'stat', stat = 'hp', value = 20, operant = 'lte'}] }],
				trigger = [variables.TR_POST_TARG],
				req_skill = false,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [{type = 'end_turn'}, {type = 'transform_into', unit = 'trained_dog'}]
					}
				],
			},
		],
		buffs = ['b_fireshield'],
	},
	#centipede
	e_tr_curseatk = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		reset = [],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			],
		atomic = [],
		buffs = ['tr_curseatk'],
		sub_effects = ['e_s_curseatk']
	},
	e_s_curseatk = {
		type = 'temp_s',
		target = 'caster',
		stack = 'curseatk',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['affliction', 'negative', 'debuff'],
		statchanges = {atk_add_part = -0.25},
		buffs = [],
	},
	#ifrit
	e_tr_fireshield = {
		type = 'base',
		sub_effects = [
			{
				type = 'trigger',
				conditions = [{type = 'skill', value = ['damage_type', 'eq', 'water'] }],
				trigger = [variables.TR_POST_TARG],
				req_skill = true,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'self',
						execute = 'remove_parent'
					}
				],
			},
			{
				type = 'trigger',
				conditions = [],
				trigger = [variables.TR_TURN_GET],
				req_skill = false,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [{type = 'use_combat_skill', skill = 'pas_fireshield'}]
					}
				],
				buffs = []
			},
		],
		atomic = [],
		buffs = ['b_fireshield'],
	},
	#erebus_stone
	e_atkpass = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'use_combat_skill', skill = 'pas_atkpass_apply'}]
			}],
		buffs = ['b_atkpass_src']
	},
	e_s_atkpass = {
		type = 'temp_s',
		target = 'target',
		stack = 'atkpass',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['positive', 'buff', 'atkpass'],
		statchanges = {atk_add_part = 0.1, matk_add_part = 0.1},
	},
	e_t_atkpass_remove = {
		type = 'temp_s',
		target = 'target',
		stack = 'atkpass_remove',
		rem_event = [variables.TR_COMBAT_F],
		sub_effects = ['e_tr_atkpass_remove'],
	},
	e_tr_atkpass_remove = {
		type = 'trigger',
		trigger = [variables.TR_DEATH],
		req_skill = false,
		conditions = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'use_combat_skill', skill = 'pas_atkpass_remove'}]
					}]
	},
	e_s_atkpass_remove = {
		type = 'oneshot',
		target = 'target',
		atomic = [{type = 'remove_all_effects', value = 'atkpass'}],
	},
	#Ramont
	ramont_parry_n_riposte_stance = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S],
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'ramont_parry_n_riposte', check = false}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['ramont_riposte_stance'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'ramont_riposte_stance_skill'}]
			},
		],
	},
	ramont_parry_n_riposte = {
		type = 'temp_s',
		target = 'target',
		stack = 'ramont_parry_n_riposte',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['stance', 'ramont_parry_n_riposte', 'defensive', 'counterattack'],
		duration = 1,
		statchanges = {},
		sub_effects = ['ramont_parry','ramont_riposte','ramont_parry_remove'],
		buffs = ['b_ramont_parry_n_riposte'],
	},
	ramont_parry = {
		type = 'trigger',
		target = 'target',
		trigger = [variables.TR_DEF],
		req_skill = false,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'neq', 'spell']},
		],
		atomic = [],
		buffs = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			receiver = {obj = 'receiver', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS},],
			},
		]
	},
	ramont_riposte = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [{type = 'use_combat_skill', skill = 'attack', target = ['parent_args', 'targetValue']}],
			},
		]
	},
	ramont_parry_remove = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'ramont_parry_n_riposte'}],
			},
		]
	},
	eviction_notice = {
		type = 'temp_s',
		duration = 2,
		stack = 'eviction_notice',
		tick_event = [variables.TR_TURN_S],
		remove_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tags = ['eviction_notice',],
		statchanges = {},
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			'ramont_eviction_bonus','ramont_remove_notice',
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/abuse.png",
			description = "EFFECT_EVICTION_NOTICE",
		}]
	},
	ramont_eviction_bonus = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'piercing_obsidian'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
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
	ramont_remove_notice = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [{type = 'skill', value = ['tags', 'has', 'piercing_obsidian'] },],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'eviction_notice'}],
			},
		]
	},
	ramont_embargo_order = {
		type = 'oneshot',
		target = 'target',
		tags = [],
		atomic = [{type = 'use_combat_skill', skill = 'ramont_embrago'},]
	},
	#Hector
	hector_blood_of_mother = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['hector_blood_of_mother'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'hector_blood_of_mother'}]
			},
		],
	},
	cali_vengeful_wrath_apply = {
		type = 'oneshot',
		target = 'target',
		tags = [],
		conditions = [
			{code = 'stat', stat = 'unique', operant = 'eq', value = "cali"},
		],
		atomic = [{type = 'sfx', value = 'provocation'},{type = 'effect', value = 'cali_vengeful_wrath'},],
	},
	cali_vengeful_wrath = {
		type = 'temp_s',
		target = 'target',
		stack = 'cali_vengeful_wrath',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		duration = 3,
		tags = ['cali_vengeful_wrath'],
		statchanges = {atk = 30, armorpenetration = 20},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				req_skill = true,
				conditions = [
					{type = 'target', value = [{code = 'trait', trait = 'hector_blood_of_mother', check = true}]},
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						conditions = [],
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.2},],
					},
					{
						type = 'oneshot',
						target = 'target',
						conditions = [],
						atomic = [{type = 'remove_all_effects', value = 'hector_vain_pride_s'}],
					},
				]
			},
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/skill_bloodboil.png",
			description = "EFFECT_CALI_VENGEFUL_WRATH",
		}]
	},
	hector_vain_pride = {
		type = 'simple',
		statchanges = {},
		buffs = [{
			icon = "res://assets/images/iconsskills/defaultattack.png",
			description = "TRAIT_HECTOR_VAIN_PRIDE",
		}]
	},
	hector_vain_pride_on_hit = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		buffs = [],
		duration = 1,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				conditions = [],
				atomic = [{type = 'effect', value = 'hector_vain_pride_s'},],
			},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			receiver = {obj = 'receiver', func = 'eq'},
		},
	},
	hector_on_miss = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'effect', value = 'hector_vain_pride_s'}],
			},
		]
	},
	hector_vain_pride_on_def = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				atomic = [{type = 'remove_effect', value = 'hector_vain_pride_s'}],
			},
		]
	},
	hector_vain_pride_s = {
		type = 'temp_s',
		target = 'target',
		stack = 'hector_vain_pride_s',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['hector_vain_pride_s'],
		duration = 1,
		statchanges = {atk = 10, hitrate = 10},
		sub_effects = [],
		buffs = ['b_hector_vain_pride_s']
	},
	bodyguard = {
		type = 'temp_s',
		target = 'target',
		stack = 'bodyguard',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_TURN_F],
		tags = ['bodyguard','defensive','remove_by_immoblizing'],
		duration = 'arg',
		statchanges = {},
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/Protect.png",
			description = "EFFECT_BODYGUARD",
		}]
	},
	vip = {
		type = 'temp_s',
		target = 'target',
		stack = 'vip',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		duration = 1,
		tags = ['vip'],
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				req_skill = true,
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['target_number', 'eq', 'single']},
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'target',
						conditions = [],
						atomic = [{type = 'remove_all_effects', value = 'vip'}],
					},
				]
			},
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/icon_mirror_image.png",
			description = "EFFECT_VIP",
		}]
	},
}
var atomic_effects = {}
var buffs = {
	b_curseatk = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTCURSEATTACK",
		t_name = 'curseatk',
		combat_only = true,
		limit = 1,
		tags = ['show_amount']
	},
	tr_curseatk = {
		icon = "res://assets/images/iconsskills/icon_turtle.png",
		description = "BUFFDESRIPTCURSEATTACKTR",
		t_name = 'curseatk_src',
	},
	b_fireshield = {
		icon = "res://assets/images/iconsskills/shield_fire.png",
		description = "BUFFDESCRIPTFIRESHIELD",
		t_name = 'fireshield',
		combat_only = true
	},
	b_atkpass = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTATKPAS",
		tags = ['combat_only', 'show_amount']
	},
	b_atkpass_src = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTATTACKPASSSRC",
		tags = ['combat_only']
	},
	b_ramont_parry_n_riposte = {
		icon = "res://assets/images/iconsskills/strongattack.png",
		description = "EFFECT_RAMONTPARRY",
	},
	b_hector_vain_pride_s = {
		icon = "res://assets/images/iconsskills/defaultattack.png",
		description = "TRAIT_HECTOR_VAIN_PRIDE_S",
		tags = ['show_amount']
	},
}

var stacks = {
	curseatk = {
		type = 'stack',
		buff = 'b_curseatk'
	}, #st 0
	atkpass = {
		type = 'stack',
		buff = 'b_atkpass'
	}, #st 0
	atkpass_remove = {}, #st 1
	ramont_parry_n_riposte = {
		type = 'stack_s',
		stack = 1,
	},
	eviction_notice = {
		type = 'stack_s',
		stack = 2,
	},
	cali_vengeful_wrath = {
		type = 'stack_s',
		stack = 1,
	},
	hector_vain_pride_s = {
		type = 'stack_a',
		stack = 10,
		buff = 'b_hector_vain_pride_s',
	},
	bodyguard = {
		type = 'stack_s',
		stack = 1,
	},
	vip = {
		type = 'stack_s',
		stack = 1,
	},
}
