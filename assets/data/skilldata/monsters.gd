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
		statchanges = {hpmax_add_part = 2.0, atk_add_part = 0.25, hitrate = 20, evasion = 20},
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",
				description = "miniboss", #2fix
			}
		],
	},
	e_boss = {
		type = 'simple',
		statchanges = {bleed_damage = 0.33, poison_damage = 0.33, burn_damage = 0.33, darkflame_damage = 0.33},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Authority.png",#fix
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
		buffs = ['b_curseatk'],
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
		buffs = ['b_atkpass'],
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
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTFIRESHIELD",
		t_name = 'fireshield',
		combat_only = true
	},
}

var stacks = {
	curseatk = {
		type = 'stack',
	}, #st 0
	atkpass = {
		type = 'stack',
	}, #st 0
	atkpass_remove = {}, #st 1
}
