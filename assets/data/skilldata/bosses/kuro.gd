extends Reference

var skills = {
	#Behind the scene skill zone
	sibling_banter_setup = {
		code = 'sibling_banter_setup',
		descript = '',
		icon = "res://assets/images/iconstraits/trait_rivals.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = ['sibling_banter_apply', Effectdata.rebuild_template({effect = 'nyctophobia'}),],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null, hittype = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
	},
	zephyra_pranking_oppotunity = {
		code = 'sibling_banter_setup',
		descript = '',
		icon =  "res://assets/images/iconstraits/trait_rivals.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = [ 'zephyra_pranking',],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null, hittype = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
	},
	zephyra_prank = {
		code = 'zephyra_prank',
		descript = '',
		icon = "res://assets/images/iconsskills/windblade.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'air','passive'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'prank_success'}),
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('fading_light')}),
			'kuro_fight_back',
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'air',
		sfx = [
			{code = 'wind_blade', target = 'target', period = 'predamage'},
			{code = 'cast_air', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = ['target.hpmax','*0.15'],
	},
	kuro_angy = {
		code = 'darkness',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_dark.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','dark'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'darkness', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_dark', hit = null},
		value = ['target.hpmax','*0.2'],
	},
	snuff_out = {
		code = 'darkness',
		descript = '',
		icon = "res://assets/images/iconsskills/fire_arrows_off.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','dark'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'blind', duration = 2}),
			Effectdata.rebuild_template({effect = 'e_t_hide2', duration = 2}),
			Effectdata.rebuild_template({effect = 'silence', duration = 2}),
		], 
		cost = {mp = 3},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'devour_magic', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_dark', hit = null},
		value = 0.75,
	},
	#Actual skill zone.
	encroaching_dusk = {
		code = 'encroaching_dusk',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_void.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['buff',],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'fading_light'})], 
		cost = {},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'dark_swril', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
		value = [['0']],
		damagestat = 'no_stat',
		variations = [
			{
				reqs = [{code = 'has_status', status = 'dont_talk_to_me', check = true}, {code = 'has_status', status = 'prank_success', check = false}],
				set = { follow_up = 'zephyra_pranking_oppotunity',},
			}
		]
	},
	night_night = {
		code = 'night_night',
		descript = '',
		icon = load("res://assets/images/iconsskills/Shackle.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'dark'],
		reqs = [{code = 'has_status', status = 'fading_light', check = true}],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'binding_shadow', duration = 3}),
			Effectdata.rebuild_template({effect = 'e_t_hide2', duration = 3}),
			Effectdata.rebuild_template({effect = 'blind', duration = 3}),
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('fading_light', 'caster')})
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'dark',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 0.1,
		random_factor_p = 0.1,
		sfx = [
			{code = 'black_tendrils', target = 'target_group', period = 'windup'},
			{code = 'dark_swril', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_break', hit = null},
	},
	silent_night = {
		code = 'silent_night',
		descript = '',
		icon = "res://assets/images/iconsskills/meditate.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff','cleanse'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'silence', check = true}],
		effects = [
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('silence')}),
			Effectdata.rebuild_template({effect = 'unholy_night'})
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'last_stand', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sound = [{initiate = null, strike = 'skill_scene', hit = null}],
		value = [['0']],
		damagestat = 'no_stat',
	},
	raze_the_light = {
		code = 'raze_the_light',
		descript = '',
		icon = "res://assets/images/iconsskills/dark flame.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe','debuff'],
		reqs = [],
		targetreqs = [],
		effects = ['raze_the_light'], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'dark',
		value = 0.9,
		random_factor_p = 0.1,
		sfx = [
			{code = 'dark_swril', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_void', hit = null},
	},
	bump_in_the_night = {
		code = 'bump_in_the_night',
		descript = '',
		icon = "res://assets/images/iconsskills/Debilitate.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','dark'],
		reqs = [],
		targetreqs = [
			{code = 'has_status', status = 'binding_shadow', check = true,},
			{code = 'has_status', status = 'hide', check = true, orflag = true},
		],
		effects = [
			Effectdata.rebuild_template({effect = 'bleed', duration = 2}),
			Effectdata.rebuild_template({effect = 'shred', duration = 2}),
			Effectdata.rebuild_template({effect = 'stun', duration = 1}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'shadow_spike', target = 'target', period = 'predamage'},
			{code = 'assassinate', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_dark', hit = null},
		value = 1.3,
	},
	skewing_shadow = {
		code = 'skewing_shadow',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_void.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'dark', 'ultimate'],
		reqs = [],
		targetreqs = [],
		effects = ['skewing_shadow', Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('binding_shadow')}),], 
		cost = {mp = 16},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'dark',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 0.7,
		random_factor_p = 0.1,
		sfx = [
			{code = 'black_tendrils', target = 'target_group', period = 'windup'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = 'spell_break', strike = 'blade', hit = null},
	},
}
var effects = {
	kuro_boss_combat_start_effects = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'veil'}]
			},
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'sibling_banter_setup'}]
			},
		],
	},
	sibling_banter_apply = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'stat', stat = 'unique', operant = 'eq', value = "zephyra"},]},
		],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				tags = [],
				conditions = [
					{code = 'stat', stat = 'unique', operant = 'eq', value = "zephyra"},
				],
				atomic = [{type = 'effect', value = 'hello_sis'},],
			},
			{
				type = 'oneshot',
				target = 'caster',
				tags = [],
				conditions = [],
				atomic = [{type = 'effect', value = 'dont_talk_to_me'},],
			},
		],
		buffs = []
	},
	hello_sis = {
		type = 'temp_s',
		target = 'target',
		stack = 'hello_sis',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_DEATH, variables.TR_COMBAT_F],
		duration = 1,
		tags = ['hello_sis','duration_none'],
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				req_skill = true,
				conditions = [
					{type = 'target', value = [{code = 'has_status', status = 'dont_talk_to_me', check = false}]},
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						conditions = [],
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.1},],
					},
				]
			},
		],
		buffs = ['b_hello_sis'],
	},
	dont_talk_to_me = {
		type = 'temp_s',
		target = 'target',
		stack = 'dont_talk_to_me',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_DEATH, variables.TR_COMBAT_F],
		duration = 1,
		tags = ['dont_talk_to_me','duration_none'],
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_HIT],
				req_skill = true,
				conditions = [
					{type = 'target', value = [{code = 'has_status', status = 'hello_sis', check = false}]},
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						conditions = [],
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.1},],
					},
				]
			},
		],
		buffs = ['b_dont_talk_to_me'],
	},
	zephyra_pranking = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'stat', stat = 'unique', operant = 'eq', value = "zephyra"},]},
		],
		req_skill = true,
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [{type = 'add_combat_log', text = 'KURO_BOSSFIGHT_BANTER_1'}, {type = 'use_combat_skill', skill = 'zephyra_prank', target = ['parent_args', 'targetValue']},],
			},
		],
		buffs = []
	},
	kuro_fight_back = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [{type = 'use_combat_skill', skill = 'kuro_angy', target = ['parent_args', 'targetValue']},{type = 'add_combat_log', text = 'KURO_BOSSFIGHT_BANTER_3'},],
			},
		],
		buffs = []
	},
	prank_success = {
		type = 'temp_s',
		target = 'target',
		duration = 1,
		tick_event = [variables.TR_NONE,],
		rem_event = [variables.TR_COMBAT_F],
		conditions = [],
		buffs = [],
		statchanges = {},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'add_combat_log', text = 'KURO_BOSSFIGHT_BANTER_2'},],
			},
		],
		tags = ['prank_success'],
	},
#------------------------------------------------------------------------------------
	
	trait_snuff_candle = {
		type = 'simple',
		statchanges = {},
		tags = ['trait_snuff_candle_desc'],
		buffs = [{
			icon = "res://assets/images/iconsskills/fire_arrows_off.png",
			description = "TRAIT_SNUFF_CANDLE_DESC",
		}]
	},
	trigger_snuff_candle_light = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['damage_type', 'in', ['light', 'fire']]},
			{type = 'owner', value = [{code = 'has_status', status = 'disable', check = false},]},
			{type = 'owner', value = [{code = 'has_status', status = 'silence', check = false},]},
		],
		args = {owner = {obj = 'owner', func = 'eq'},caster = {obj = 'caster', func = 'eq'},},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {targetValue = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [{type = 'use_combat_skill', skill = 'snuff_out', target = ['parent_args', 'targetValue']},],
			},
		]
	},

#------------------------------------------------------------------------------------
	nyctophobia = {
		type = 'temp_global',
		tags = ['duration_none', 'affliction', 'nyctophobia'],
		target = 'target',
		req_skill = true,
		name = 'Nyctophobia',
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		timers = [
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		sub_effects = ['nyctophobia_dot','nyctophobia_evade_pierce'],
		buffs = ['b_nyctophobia'],
	},
	nyctophobia_dot = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [ 
			{type = 'owner', value = [{code = 'has_status', status = 'hide', check = true},]}, 
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]},
		],
		args = {
			owner = {obj = 'owner', func = 'eq'},
		},
		sub_effects = [{
				type = 'oneshot',
				target = 'owner',
				args = {
					value = {obj = 'owner', func = 'stat', stat = 'hp'},
					src = {obj = 'self', func = 'src', src = 'dark'},
					mod = {obj = 'self', func = 'src', src = 0.15},
				},
				atomic = ['a_damage_new'],
			}
		]
	},
	nyctophobia_evade_pierce = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'has_status', status = 'hide', check = true},]}, 
			{type = 'caster', value = [{code = 'trait', trait = 'nixx_blessing_nyctophobia', check = true}]},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]}
		],
		args = {
			skill = {obj = 'skill', func = 'eq'}, 
			target = {obj = 'target', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_HIT}],
			},
		]
	},
	fading_light = {
		type = 'temp_s',
		target = 'caster',
		stack = 'fading_light',
		duration = 1,
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		sub_effects = ['fading_light_removal_elemental', 'fading_light_removal_status_effect'],
		tags = ['fading_light'],
		buffs = ['b_fading_light'],
	},
	fading_light_removal_elemental = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['damage_type', 'in', ['light', 'fire']]},
		],
		args = {owner = {obj = 'owner', func = 'eq'},},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'fading_light'}],
			},
		]
	},
	fading_light_removal_status_effect = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'owner', value = [
				{code = 'has_status', status = 'disable', check = true,},
				{code = 'has_status', status = 'silence', check = true, orflag = true},
			]},
		],
		args = {owner = {obj = 'owner', func = 'eq'},},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'fading_light'}],
			},
		]
	},
	binding_shadow = {
		type = 'temp_s',
		target = 'target',
		duration = 'arg',
		stack = 'binding_shadow',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_DEATH, variables.TR_COMBAT_F], 
		statchanges = {speed_mul = 0.6},
		tags = ['binding_shadow'],
		sub_effects = [
			{
				type = 'trigger',
				conditions = [
					{type = 'skill', value = ['tags', 'hasno', 'aoe'] },
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'owner', value = [{code = 'has_status', status = 'hide', check = true}]},
				],
				trigger = [variables.TR_PREDEF],
				req_skill = true,
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_add', stat = 'chance', value = 50}],
					}
				],
			},
			{
				type = 'trigger',
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'aoe'] },
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'owner', value = [{code = 'has_status', status = 'hide', check = true}]},
				],
				trigger = [variables.TR_PREDEF],
				req_skill = true,
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_add', stat = 'chance', value = 20}],
					}
				],
			},
			'negate_hide_pen',
			'binding_shadow_disarm',
			'binding_shadow_removal'
		],
		buffs = [{
			icon = "res://assets/images/iconsskills/Shackle.png",
			description = "EFFECT_BINDING_SHADOW",
		}]
	},
	negate_hide_pen = {
		type = 'trigger',
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'hide', check = true}]},
		],
		trigger = [variables.TR_HIT],
		req_skill = true,
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_add', stat = 'armor_p', value = -20}],
			}
		],
	},
	binding_shadow_disarm = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['damage_type', 'eq', 'dark']},
		],
		args = {skill = {obj = 'skill', func = 'eq'}},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [{code = 'random', value = 50},],
				atomic = [{type = 'effect', value = 'e_s_disarm', override = {duration = 1}}],
			},
		]
	},
	binding_shadow_removal = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE, variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['damage_type', 'in', ['light', 'fire']]},
		],
		args = {owner = {obj = 'owner', func = 'eq'},},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [],
				atomic = [{type = 'remove_all_effects', value = 'binding_shadow'}],
			},
		]
	},
	tr_unholy_night = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = [
			Effectdata.rebuild_remove_effect('silence'),
			'unholy_night'
			],
		buffs = []
	},
	unholy_night = {
		type = 'temp_s',
		target = 'target',
		stack = 'unholy_night',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		tags = ['buff'],
		statchanges = {matk = 30, resist_silence = 200,},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/meditate.png",
				description = "EFFECT_UNHOLY_NIGHT",
			}
		],
	},
	raze_the_light = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				conditions = [{code = 'has_status', status = 'hide', check = true},],
				atomic = [{type = 'effect', value = 'binding_shadow', override = {duration = 2}}],
			},
			{
				type = 'oneshot',
				target = 'target',
				conditions = [{code = 'has_status', status = 'hide', check = false},],
				atomic = [{type = 'effect', value = 'e_t_hide2', override = {duration = 3}}],
			},
		],
		buffs = []
	},
	skewing_shadow = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'has_status', status = 'binding_shadow', check = true},]},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [],
				atomic = [{type = 'stat_mul', stat = 'value', value = 2.5},],
			},
			{
				type = 'oneshot',
				target = 'target',
				conditions = [],
				atomic = [{type = 'sfx', value = 'shadow_spike'}],
			},
		]
	},
}
var atomic_effects = {}
var buffs = {
	b_hello_sis  = {
		icon = "res://assets/images/iconstraits/trait_rivals.png",
		description = "EFFECT_HELLO_SIS",
		limit = 1,
	},
	b_dont_talk_to_me = {
		icon = "res://assets/images/iconstraits/trait_rivals.png",
		description = "EFFECT_DONT_TALK_TO_ME",
		limit = 1,
	},
	b_nyctophobia = {
		icon = "res://assets/images/iconsclasses/nixx_champion.png",
		description = "EFFECT_NYCTOPHOBIA",
		limit = 1,
	},
	b_fading_light = {
		icon = "res://assets/images/iconsskills/skill_void.png",
		description = "EFFECT_FADING_LIGHT",
		limit = 1,
	},
}
var stacks = {
	hello_sis = {
		type = 'stack_s',
		stack = 1,
		buff = 'b_hello_sis'
	},
	dont_talk_to_me = {
		type = 'stack_s',
		stack = 1,
		buff = 'b_dont_talk_to_me'
	},
	fading_light = {
		type = 'stack_s',
		stack = 1,
		buff = 'b_fading_light'
	},
	binding_shadow = {
		type = 'stack_s',
		stack = 1,
	},
	unholy_night = {
		type = 'stack_s',
		stack = 1,
	},
}
