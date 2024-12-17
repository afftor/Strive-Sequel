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
}
var effects = {
	#universal
	e_rare_sturdy = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 1.5},
			{type = 'stat_add', stat = 'armorpenetration', value = 30},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",
				description = "TRAITEFFECTRARESTURDY",
				limit = 1,
				t_name = 'rare_sturdy'
			}
		],
		sub_effects = [],
	},
	e_rare_nimble = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'evasion', value = 0.15},
			{type = 'stat_add', stat = 'evasion', value = 30},
			{type = 'stat_add', stat = 'speed', value = 15},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speed.png",
				description = "TRAITEFFECTRARENIMBLE",
				limit = 1,
				t_name = 'rare_nimble'
			}
		],
		sub_effects = [],
	},
	e_rare_strong = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 0.5},
			{type = 'stat_add_p', stat = 'damage_mod_all', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/firedamagebonus.png",
				description = "TRAITEFFECTRARESTRONG",
				limit = 1,
				t_name = 'rare_strong'
			}
		],
		sub_effects = [],
	},
	e_rare_deadly = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'damage_mod_all', value = 0.35},
			{type = 'stat_add_p', stat = 'hitrate', value = 0.3},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/critrate.png",
				description = "TRAITEFFECTRAREDEADLY",
				limit = 1,
				t_name = 'rare_deadly'
			}
		],
		sub_effects = [],
	},
	e_rare_precise = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hitrate', value = 0.25},
			{type = 'stat_add', stat = 'evasion', value = 35},
			{type = 'stat_add', stat = 'mdef', value = 20},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png",
				description = "TRAITEFFECTRAREPRECISE",
				limit = 1,
				t_name = 'rare_precise'
			}
		],
		sub_effects = [],
	},
	e_rare_tough = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 0.35},
			{type = 'stat_add', stat = 'armor', value = 30},
			{type = 'stat_add', stat = 'mdef', value = 30},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/bowextradamage.png",
				description = "TRAITEFFECTRARETOUGH",
				limit = 1,
				t_name = 'rare_tough'
			}
		],
		sub_effects = [],
	},
	e_miniboss = {
		type = 'static',
		atomic = [
			{type = 'stat_add_p', stat = 'hpmax', value = 2.0},
			{type = 'stat_add_p', stat = 'atk', value = 0.25},
			{type = 'stat_add', stat = 'hitrate', value = 20},
			{type = 'stat_add', stat = 'evasion', value = 20},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",
				description = "miniboss", #2fix
				limit = 1,
				t_name = 'miniboss'
			}
		],
		sub_effects = [],
	},
	e_boss = {
		type = 'static',
		atomic = [
			{type = 'stat_mul', stat = 'bleed_damage', value = 0.33},
			{type = 'stat_mul', stat = 'poison_damage', value = 0.33},
			{type = 'stat_mul', stat = 'burn_damage', value = 0.33},
			{type = 'stat_mul', stat = 'darkflame_damage', value = 0.33},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/hitrate.png",#fix
				description = "boss", #2fix
				limit = 1,
				t_name = 'boss'
			}
		],
		sub_effects = [],
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
		name = 'curseatk',
		stack = 0,
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['affliction', 'negative', 'debuff'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'atk', value = -0.25}],
		buffs = ['b_curseatk'],
	},
	#ifrit
	e_tr_fireshield = {
		type = 'static',
		tags = [],
		args = [],
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
				buffs = []
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
						args = [{obj = 'app_obj'}],
						atomic = [{type = 'use_combat_skill', skill = 'pas_fireshield', target = ['parent_args', 0]}]
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
			args = [{obj = 'app_obj'}],
			atomic = [{type = 'use_combat_skill', skill = 'pas_atkpass_apply', target = ['parent_args', 0]}]
			}],
		buffs = ['b_atkpass_src']
	},
	e_s_atkpass = {
		type = 'temp_s',
		target = 'target',
		name = 'atkpass',
		stack = 0,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['positive', 'buff', 'atkpass'],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.1},
			{type = 'stat_add_p', stat = 'matk', value = 0.1},
			],
		buffs = ['b_atkpass'],
	},
	e_t_atkpass_remove = {
		type = 'temp_s',
		target = 'target',
		name = 'atkpass_remove',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F],
		tags = [],
		args = [],
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
			args = [{obj = 'app_obj'}],
			atomic = [{type = 'use_combat_skill', skill = 'pas_atkpass_remove', target = ['parent_args', 0]}]
					}]
	},
	e_s_atkpass_remove = {
		type = 'oneshot',
		target = 'target',
		args = [],
		atomic = [{type = 'remove_all_effects', value = 'atkpass'}],
	},
}
var atomic_effects = {}
var buffs = {
	b_curseatk = {
		icon = "res://assets/images/iconsskills/Sedate.png",
		description = "BUFFDESCRIPTCURSEATTACK",
		t_name = 'curseatk',
		combat_only = true
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
