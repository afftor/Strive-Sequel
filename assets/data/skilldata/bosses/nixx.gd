extends Reference

var skills = {
	#Behind the scene skill zone
	nixx_setup = {
		code = 'nixx_setup',
		descript = '',
		icon = "res://assets/images/iconstraits/trait_rivals.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = ['kuro_nixx_apply','nixx_darkness_debuff_apply'],
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
	brazier_light_out = {
		code = 'brazier_light_out',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive','aoe','debuff','support','noreduce', 'noevade',],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'e_t_hide2', duration = 99}),
			'brazier_dark_ally',
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('light_on')}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [{code = 'shadow_veil', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat',
		random_target = true,
		not_final = true,
		follow_up = 'brazier_light_out_1',
		critchance = 0,
	},
	brazier_light_out_1 = {
		code = 'brazier_light_out',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive','aoe','debuff','support','noreduce', 'noevade', 'weather'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'e_t_hide2', duration = 99}),
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('light_on')}),
			Effectdata.rebuild_template({effect = 'lost_in_darkness', duration = 1}),
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
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		sfx = [{code = 'shadow_veil', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat',
		critchance = 0,
	},
	brazier_light_on = {
		code = 'brazier_light_on',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive','aoe','debuff','support','noreduce', 'noevade',],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('hide')}),
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('remove_by_light')}),
			'brazier_lit_ally',
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = 'light_on'}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'radiance', target = 'caster', period = 'windup'}],
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat',
		random_target = true,
		not_final = true,
		critchance = 0,
		follow_up = 'brazier_light_on_1'
	},
	brazier_light_on_1 = {
		code = '	brazier_light_on_1 = {',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_earthquake.png"),
		type = 'auto', 
		ability_type = 'spell',
		tags = ['instant', 'passive','aoe','debuff','support','noreduce', 'noevade',],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('hide')}),
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('lost_in_darkness')}),
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = 'light_on'}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		sfx = [],
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		critchance = 0,
		damagestat = 'no_stat',
	},
	#Actual skill zone.
	umbral_reign = {
		code = 'umbral_reign',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_veil.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff'],
		reqs = [{code = 'has_status', status = 'light_on', check = false}],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'blind', duration = 1,}),
			Effectdata.rebuild_template({effect = 'e_t_hide2', duration = 1}),
			Effectdata.rebuild_template({effect = 'lost_in_darkness', duration = 1}),
			],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'dark',#not sure but not matters
		sfx = [
			{code = 'dark_swril', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'spell_void', strike = null, hit = null},
		value = ['0'],
		damagestat = ['no_stat'],
		critchance = 0,
	},
	shadow_made_manifest = {
		code = 'shadow_made_manifest',
		new_syntax = true,
		descript = '',
		icon = load("res://assets/images/enemies/darkboss.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['summon'],
		reqs = [{code = 'has_status', status = 'light_on', check = false},{code = 'group_amount', alive = false, operant = 'lt', value = 5}],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'summon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = [['shadow_monstrosity',null], 3],
		random_factor_p = 0.1,
		sfx = [{code = 'dark_swril', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	stygian_wailing = {
		code = 'stygian_wailing',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_blood_explosion.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','dark', 'aoe', 'debuff'],
		reqs = [{code = 'has_status', status = 'height_beyond_mortal_reach', check = false}],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'fear', chance = 0.5, duration = 2}),
			Effectdata.rebuild_template({effect = 'silence', chance = 0.3, duration = 1})
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
		sfx = [{code = 'tauntwave', target = 'caster', period = 'windup'}],
		sounddata = {initiate = null, strike = 'spell2', hit = null},
		value = 0.5,
	},
	tenebrous_rake = {
		code = 'tenebrous_rake',
		descript = '',
		icon = "res://assets/images/iconsskills/swipe.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage', 'aoe','dark'],
		reqs = [{code = 'has_status', status = 'light_on', check = true}],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'bleed', duration = 2})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'line',
		target_range = 'melee',
		damage_type = 'weapon',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 1.1,
		random_factor_p = 0.1,
		sfx = [
			{code = 'cleave', target = 'target_line', period = 'windup'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	void_deluge = {
		code = 'void_deluge',
		descript = '',
		icon = load("res://assets/images/iconsskills/barrage.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','dark'],
		reqs = [{code = 'has_status', status = 'light_on', check = true}],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'blind', duration = 2, chance = 0.2}),], 
		cost = {},
		repeat = 6,
		keep_target = variables.TARGET_KEEPFIRST,
		next_target = variables.NT_ANY,
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',
		sfx = [
			{code = 'void_barrage', target = 'target', period = 'predamage', duration = 0.2, no_repeat_delays = true},
			{code = 'cast_dark', target = 'caster', period = 'windup', no_delays = true, is_cast = true}
			],
		sounddata = {initiate = null, strike = 'spell_dark', hit = null},
		value = 0.85,
	},
	caliginous_undulation = {
		code = 'caliginous_undulation',
		descript = '',
		icon = "res://assets/images/iconsskills/dark flame.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe','debuff','dark'],
		reqs = [{code = 'has_status', status = 'light_on', check = true}],
		targetreqs = [],
		effects = ['cali_undu_effect','cali_undu_effect_1'], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'wave',
		target_range = 'any',
		damage_type = 'dark',
		value = 1,
		random_factor_p = 0.1,
		sfx = [
			{code = 'dark_swril', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = null, strike = 'spell_void', hit = null},
	},
	nixx_ult = {
		code = 'nixx_ult',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_void.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'debuff', 'ads', 'dark', 'ultimate'],
		reqs = [{code = 'buff_number', operant = 'gte', status = 'nixx_wrath', value = 4}],
		targetreqs = [],
		effects = [
			'blind_damageboost_25', 
			Effectdata.rebuild_template({effect = 'e_healing_reduction', duration = 1}),
		], 
		cost = {mp = 16},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'dark',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 2,
		random_factor_p = 0.1,
		sfx = [
			{code = 'black_tendrils', target = 'target_group', period = 'windup'},
			{code = 'shadow_spike', target = 'target', period = 'predamage'},
			{code = 'cast_dark', target = 'caster', period = 'windup', is_cast = true}], 
		sounddata = {initiate = 'spell_break', strike = 'blade', hit = null},
		follow_up = 'nixx_ult_1',
	},
	nixx_ult_1 = {
		code = 'nixx_ult_1',
		descript = '',
		icon = "res://assets/images/iconstraits/trait_rivals.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['aoe', 'debuff','instant','noreduce', 'noevade','passive'],
		reqs = [],
		targetreqs = [],
		effects = ['snuff_brazier',],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null, hittype = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_CASTER,
	},
	#Minions skill zone.
	nothing = {#For brazier, literally does nothing
		code = 'nothing',
		descript = '',
		icon = "res://assets/images/iconsskills/meditate.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['nothing','disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'normal',
		sfx = [], 
		sound = [{initiate = null, strike = null, hit = null}],
		value = [['0']],
		damagestat = 'no_stat',
	},
	smother_the_flame = {
		code = 'smother_the_flame',
		descript = '',
		icon = "res://assets/images/iconsskills/Sedation.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support',],
		reqs = [],
		targetreqs = [{code = 'trait', trait = 'unlit_brazier', check = true}],
		effects = [
			Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('burn')})
		], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'dark',#not sure but not matters #It's matter now! -Garden
		sfx = [{code = 'devour_magic', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.atk']],
		damagestat = ['-damage_hp'],
	},
	bump_in_the_midnight = {
		code = 'bump_in_the_midnight',
		descript = '',
		icon = "res://assets/images/iconsskills/Debilitate.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','dark','ultimate'],
		reqs = [],
		targetreqs = [{code = 'has_status', status = 'hide', check = true},],
		effects = [
			Effectdata.rebuild_template({effect = 'bleed', duration = 2}),
			Effectdata.rebuild_template({effect = 'shred', duration = 2}),
			Effectdata.rebuild_template({effect = 'fear', duration = 2}),
		], 
		cost = {},
		charges = 0,
		combatcooldown = 2,
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
		value = 1.1,
	},
}
var effects = {
	nixx_trait = {
		type = 'simple',
		statchanges = {bleed_damage = 0.25, poison_damage = 0.25, burn_damage = 0.33, darkflame_damage = 0.10},
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/nixx_champion2.png",
				description = "EFFECT_NIXX_TRAIT_DESCRIPT",
			}
		],
	},
	nixx_trait_combat_s = {
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
				atomic = [{type = 'use_combat_skill', skill = 'nixx_setup'}]
			},
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'use_combat_skill', skill = 'umbral_reign'}]
			},
		],
	},
	nixx_darkness_debuff = {
		type = 'temp_s',
		target = 'target',
		duration = 1,
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F], 
		statchanges = {},
		tags = ['negate_hiding_positive'],
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
			'nixx_perma_hide',
			'negate_hide_pen',
			'nixx_dot'
		],
		buffs = []
	},
	hide_evade_pierce = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'has_status', status = 'hide', check = true},]}, 
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
	nixx_dot = {
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
					mod = {obj = 'self', func = 'src', src = 0.2},
				},
				atomic = ['a_damage_new'],
			}
		]
	},
	intangible_oppressive_darkness = {
		type = 'temp_s',
		target = 'target',
		stack = 'intangible_oppressive_darkness',
		#duration = 1,
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		sub_effects = [
			{
				type = 'trigger',
				conditions = [
					{type = 'skill', value = ['damage_type', 'neq', 'light']},
					{type = 'skill', value = ['damage_type', 'neq', 'fire']},
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				trigger = [variables.TR_DEF],
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
						atomic = [{type = 'stat_mul', stat = 'value', value = 0.5}],
					}
				],
			},
		],
		statchanges = {resist_burn_set = 200, resist_silence_set = 200},
		tags = ['intangible_oppressive_darkness','remove_by_light'],
		buffs = ['b_intangible_oppressive_darkness'],
	},
	nixx_wrath_trait = {
		type = 'temp_s',
		target = 'target',
		stack = 'nixx_wrath_trait',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		sub_effects = [
			{
				type = 'trigger',
				conditions = [],
				trigger = [variables.TR_TURN_F],
				req_skill = false,
				args = {
					owner = {obj = 'owner', func = 'eq'},
					target = {obj = 'owner', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						conditions = [{code = 'buff_number', operant = 'gte', status = 'nixx_wrath', value = 3},{code = 'has_status', status = 'nixx_silence_immunity', check = false}],
						atomic = [{type = 'remove_all_effects', value = 'silence'},{type = 'add_combat_log', text = 'NIXX_ULT_WARNING'},{type = 'sfx', value = 'provocation'},{type = 'effect', value = 'nixx_silence_immunity'}],
					},
					'nixx_wrath',
				],
			},
		],
		tags = ['nixx_wrath_trait'],
		buffs = ['b_nixx_wrath_trait'],
	},
	nixx_wrath = {
		type = 'temp_s',
		target = 'target',
		stack = 'nixx_wrath',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['nixx_wrath','positive'],
		duration = 1,
		statchanges = {atk_add_part = 0.075, matk_add_part = 0.075},
		sub_effects = [],
		buffs = ['b_nixx_wrath']
	},
	nixx_silence_immunity = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['nixx_silence_immunity','remove_by_light','positive'],
		duration = 1,
		statchanges = {resist_silence_set = 200},
		sub_effects = [],
		buffs = []
	},
	kuro_nixx_apply = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'stat', stat = 'unique', operant = 'eq', value = "kuro"},]},
		],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				tags = [],
				conditions = [{code = 'stat', stat = 'unique', operant = 'eq', value = "kuro"},],
				atomic = [{type = 'effect', value = 'kuro_nixx_standoff'},],
			},
		],
		buffs = []
	},
	nixx_darkness_debuff_apply = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'stat', stat = 'unique', operant = 'neq', value = "kuro"},]},
		],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				tags = [],
				conditions = [{code = 'stat', stat = 'unique', operant = 'neq', value = "kuro"},],
				atomic = [{type = 'effect', value = 'nixx_darkness_debuff'},],
			},
		],
		buffs = []
	},
	kuro_nixx_standoff = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['kuro_nixx_standoff'],
		duration = 1,
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_DEF],
				req_skill = true,
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'caster', value = [{code = 'trait', trait = 'nixx_trait', check = true}] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.1},],
					},
				]
			},
			{
				type = 'trigger',
				trigger = [variables.TR_PREHIT],
				req_skill = true,
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'target', value = [{code = 'trait', trait = 'nixx_trait', check = true}] },
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
				],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_mul', stat = 'value', value = 1.1},],
					},
				]
			},
		],
		buffs = ['b_kuro_nixx_standoff']
	},
	brazier_dark_ally = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'trait', trait = 'nixx_trait', check = true}] },
		],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				tags = [],
				conditions = [{code = 'trait', trait = 'nixx_trait', check = true}],
				atomic = [{type = 'remove_all_effects', value = 'nixx_wrath'},{type = 'remove_all_effects', value = 'nixx_wrath_trait'}],
			},
			'intangible_oppressive_darkness',
		],
		buffs = []
	},
	light_on = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['light_on'],
		duration = 1,
		statchanges = {},
		sub_effects = [],
		buffs = []
	},
	brazier_lit_ally = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'trait', trait = 'nixx_trait', check = true}] },
		],
		req_skill = true,
		sub_effects = ['nixx_wrath_trait',],
		buffs = []
	},
	lost_in_darkness = {
		target = 'target',
		type = 'temp_s',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		stack = 'lost_in_darkness',
		tags = ['lost_in_darkness'],
		args = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'damage'] },
				],
				atomic = [],
				buffs = [],
				req_skill = true,
				args = {owner = {obj = 'owner', func = 'eq'},},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						args = {
							value = {obj = 'self', func = 'src', src = 50},
							src = {obj = 'self', func = 'src', src = 'dark'},
							mod = {obj = 'self', func = 'src', src = 1},
						},
						atomic = ['a_damage_new'],
					}
				],
			}
		],
		atomic = [],
		buffs = ['b_lost_in_darkness'],
	},
	cali_undu_effect = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'blind', check = true}] },
		],
		atomic = [],
		buffs = [],
		req_skill = true,
		args = {target = {obj = 'target', func = 'eq'},duration = {obj = 'self', func = 'dr', dr = 1},},
		sub_effects = ['stun'],
	},
	cali_undu_effect_1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'blind', check = false}]}
		],
		atomic = [],
		buffs = [],
		req_skill = true,
		args = {target = {obj = 'target', func = 'eq'},duration = {obj = 'self', func = 'dr', dr = 2},},
		sub_effects = ['blind'],
	},
	blind_damageboost_25 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'has_status', status = 'blind', check = true},]},
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				conditions = [],
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.25},],
			},
		]
	},
	snuff_brazier = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [
			{type = 'target', value = [{code = 'trait', trait = 'light_brazier', check = true}] },
		],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				tags = [],
				conditions = [{code = 'trait', trait = 'light_brazier', check = true}],
				atomic = [{type = 'transform_into', unit = 'unlit_brazier'},],
			},
		],
		buffs = []
	},
	nixx_perma_hide = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['damage_type', 'neq', 'light']},
			{type = 'skill', value = ['damage_type', 'neq', 'fire']},
			{type = 'caster', value = [{code = 'has_status', status = 'light_on', check = false}]}
		],
		trigger = [variables.TR_CAST],
		req_skill = true,
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			duration = {obj = 'self', func = 'dr', dr = 99},
		},
		sub_effects = [{status = 'e_t_hide2', overload_target = 'caster', type = null} ], 
		#could probably use oneshot + atomic but this method seem more compact. the "type = null" is here cus fix_eff_data() demand type to exist.
	},
	#Summon effect zone
	spell_reflection = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'spell'] },
			{type = 'skill', value = ['tags', 'hasno', 'aoe']},
		],
		trigger = [variables.TR_DEF],
		req_skill = true,
		args = {caster = {obj = 'caster', func = 'eq'},},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'sfx', value = 'mind_shatter'}],
			},
			{
				type = 'oneshot',
				target = 'skill',
				args = {caster = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [{type = 'stat_set', stat = 'target', value = ['parent_args', 'caster']}, {type = 'stat_mul', stat = 'value', value = 0.5}],
			},
		],
		buffs = []
	},
	environmental_object = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['last_stand','environmental_object','non_win_con'],
		statchanges = {},
		sub_effects = [],
		stack = 'environmental_object',
		buffs = ['b_environmental_object']
	},
	unlit_brazier_display = {
		type = 'simple',
		statchanges = {},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/fire_arrows_off.png",
				description = "EFFECT_UNLIT_BRAZIER_DESCRIPT",
			}
		],
	},
	unlit_brazier_combat_s = {
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
				atomic = [{type = 'use_combat_skill', skill = 'brazier_light_out'}]
			},
		],
	},
	unlit_brazier_transform = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_DMG],
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['100']}]},
			{type = 'owner', value = [{code = 'is_dead', check = false}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['unlit_brazier','disable'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'transform_into', unit = 'lighted_brazier'}]
			},
		],
	},
	light_brazier_display = {
		type = 'simple',
		statchanges = {},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/fire_arrows.png",
				description = "EFFECT_LIGTHED_BRAZIER_DESCRIPT",
			}
		],
	},
	light_brazier_combat_s = {
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
				atomic = [{type = 'use_combat_skill', skill = 'brazier_light_on'}]
			},
		],
	},
	light_brazier_transform = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_DMG],
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['100']}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		tags = ['unlit_brazier','disable'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'transform_into', unit = 'unlit_brazier'}]
			},
		],
	},
	intangible_shadow_combat_s = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		args = {duration = {obj = 'self', func = 'dr', dr = 99}, target = {obj = 'owner', func = 'eq'}},
		sub_effects = ['e_t_hide2'],
	},
	intangible_shadow = {
		type = 'simple',
		conditions = [{code = 'has_status', status = 'light_on', check = false}],
		statchanges = {resist_burn_set = 200, resist_silence_set = 200},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/skill_veil.png",
				description = "EFFECT_INTANGIBLE_SHADOW_DESCRIPT",
			}
		],
	},
	intangible_shadow_evade = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'owner', value = [{code = 'has_status', status = 'light_on', check = false}]},
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
				atomic = [{type = 'stat_add', stat = 'chance', value = -50}],
			}
		],
	},
	intangible_shadow_terror = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S],
		conditions = [{type = 'owner', value = [{code = 'has_status', status = 'light_on', check = false}]},],
		atomic = [],
		buffs = [],
		req_skill = false,
		args = {target = {obj = 'owner', func = 'eq'},},
		sub_effects = ['festering_terror'],
	},
	intangible_shadow_degen = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'light_on', check = true}]},
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]},
		],
		atomic = [],
		buffs = [],
		req_skill = false,
		args = {owner = {obj = 'owner', func = 'eq'},},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {
					value = {obj = 'owner', func = 'stat', stat = 'hp'},
					src = {obj = 'self', func = 'src', src = 'true'},
					mod = {obj = 'self', func = 'src', src = 0.16},
				},
				atomic = ['a_damage_new'],
			}
		],
	},
	festering_terror = {
		type = 'temp_s',
		target = 'target',
		stack = 'festering_terror',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['festering_terror','remove_by_light'],
		duration = 1,
		statchanges = {damage_mod_all = 0.1, critchance = 10},
		sub_effects = [],
		buffs = ['b_festering_terror']
	},
	nixx_malleable_creation = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [],
		atomic = [],
		buffs = [],
		req_skill = false,
		args = {target = {obj = 'owner', func = 'eq'},},
		modal_sub_effects = ['black_mirror', 'black_thorn', 'black_bind','black_growth'],
	},
	black_mirror = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['black_mirror'],
		statchanges = {},
		sub_effects = ['spell_reflection'],
		stack = 'black_mirror',
		buffs = ['b_black_mirror']
	},
	black_thorn = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['black_thorn'],
		duration = 1,
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POST_TARG],
				conditions = [
					{type = 'skill', value = ['tags', 'has', 'damage'] },
					{type = 'skill', value = ['target_range', 'eq', 'melee']},
				],
				atomic = [],
				buffs = [],
				req_skill = true,
				args = {owner = {obj = 'caster', func = 'eq'},},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'caster',
						args = {
							value = {obj = 'self', func = 'src', src = 50},
							src = {obj = 'self', func = 'src', src = 'dark'},
							mod = {obj = 'self', func = 'src', src = 1},
						},
						atomic = ['a_damage_new'],
					}
				],
			}
		],
		stack = 'black_thorn',
		buffs = ['b_black_thorn']
	},
	black_bind = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['black_bind'],
		statchanges = {},
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_POSTDAMAGE],
				conditions = [
					{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
					{type = 'random', value = 0.5},
				],
				atomic = [],
				buffs = [],
				req_skill = true,
				args = {target = {obj = 'target', func = 'eq'},duration = {obj = 'self', func = 'dr', dr = 2},},
				sub_effects = ['e_s_ensnare'],
			}
		],
		stack = 'black_bind',
		buffs = ['b_black_bind']
	},
	black_growth = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_DEATH,variables.TR_COMBAT_F],
		tick_event = [variables.TR_NONE],
		tags = ['positive'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_GET],
				req_skill = false,
				conditions = [],
				args = {},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						args = {base = {obj = 'owner', func = 'stat', stat = 'hpmax'}},
						atomic = [{type = 'heal', value = [['parent_args', 'base'], '*', 0.16]},],
					},
				]
			}
		],
		stack = 'black_growth',
		buffs = ['b_black_growth'],
	},
}
var atomic_effects = {}
var buffs = {
	b_intangible_oppressive_darkness = {
		icon = "res://assets/images/iconsskills/skill_veil.png",
		description = "EFFECT_INTANGIBLE_OPPRESSIVE_DARKNESS_DESCRIPT",
	},
	b_nixx_wrath_trait = {
		icon = "res://assets/images/iconsclasses/kuro_mc_class.png",
		description = "EFFECT_NIXX_WRATH_TRAIT_DESCRIPT",
	},
	b_nixx_wrath = {
		icon = "res://assets/images/iconsskills/skill_bloodboil.png",
		description = "EFFECT_NIXX_WRATH_DESCRIPT",
		tags = ['show_amount']
	},
	b_kuro_nixx_standoff = {
		icon = "res://assets/images/iconstraits/trait_rivals.png",
		description = "EFFECT_KURO_NIXX_STANDOFF_DESCRIPT",
	},
	b_environmental_object = {
		icon = "res://assets/images/iconsskills/skill_natures_gift.png",
		description = "EFFECT_ENVIRONMENTAL_OBJECT_DESCRIPT",
	},
	b_festering_terror = {
		icon = "res://assets/images/iconsclasses/nixx_champion.png",
		description = "EFFECT_FESTERING_TERROR_DESCRIPT",
		tags = ['show_amount']
	},
	b_black_mirror = {
		icon = "res://assets/images/iconsskills/icon_mirror_image.png",
		description = "EFFECT_BLACK_MIRROR_DESCRIPT",
	},
	b_black_thorn = {
		icon = "res://assets/images/iconsskills/icon_turtle.png",
		description = "EFFECT_BLACK_THORN_DESCRIPT",
	},
	b_black_growth = {
		icon = "res://assets/images/iconsskills/lesserheal.png",
		description = "EFFECT_BLACK_GROWTH_DESCRIPT",
	},
	b_black_bind = {
		icon = "res://assets/images/iconsskills/skill_ensnare.png",
		description = "EFFECT_BLACK_BIND_DESCRIPT",
	},
	b_lost_in_darkness = {
		icon = "res://assets/images/iconsskills/Strong Magic Shackles.png",
		description = "EFFECT_LOST_IN_DARKNESS_DESCRIPT",
	},
}
var stacks = {
	intangible_oppressive_darkness = {},
	nixx_wrath_trait = {},
	environmental_object = {},
	nixx_wrath = {
		type = 'stack_a',
		stack = 4,
		buff = 'b_nixx_wrath',
	},
	festering_terror = {
		type = 'stack_a',
		stack = 5,
		buff = 'b_festering_terror',
	},
	black_bind = {},
	black_growth = {},
	black_thorn = {},
	black_mirror = {},
	lost_in_darkness = {},
}
