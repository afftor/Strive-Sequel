extends Reference

#Grotus, act 4 finale. Both phases share this kit - grotus_ascended (phase 1) and
#grotus_king_boss (phase 2) differ only in their traits, see Traits.gd:
#grotus_divine_barrier vs grotus_tyrant_insecurity.
#
#Damage is keyed off matk on purpose. Grotus wields no weapon and both statblocks are
#built as casters (atk 40/125 and 50/155), so every value here is a flat value3 term
#scaled from matk - that also makes phase 2 hit harder for free.
#
#Two engine details this file leans on:
#- Defensive Gap stuns via the custom status 'grotus_overwhelmed', not 'stun'.
#  ch_effects.check_status_immunity() keys off the raw status string, so an unknown
#  name has no resist stat and lands despite status_resists.stun = 100. The status
#  still carries the 'stun' and 'disable' tags, so can_act() and every cleanse see it
#  as an ordinary stun.
#- "gain a random Defensive Gap" is triggered_effect.modal_sub_effects, which picks one
#  entry of the list per firing.

var skills = {
	#===== basic attack =====
	grotus_haymaker = {
		code = 'grotus_haymaker',
		descript = '',
		icon = "res://assets/images/iconsskills/strongattack.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'basic', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'stun', duration = 1, chance = 0.3}),
			'grotus_gap_roll_on_cast',
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_MELEE,
		sfx = [{code = 'strike', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'punch', hit = null, hittype = 'bodyarmor'},
		value = [['caster.matk', '*1.4']],
		variations = [
			{
				reqs = [{code = 'has_status', status = 'grotus_contempt', check = true}],
				#'row' is the front unit plus the one directly behind it
				set = {target_number = 'row'},
			}
		],
	},
	#===== tank buster =====
	grotus_stomping = {
		code = 'grotus_stomping',
		descript = '',
		icon = "res://assets/images/iconsskills/tackle.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'damage_spot', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'shred', duration = 3, chance = 0.2}),
			'grotus_stomping_guard_break',
		],
		cost = {},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		repeat = 3,
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		keep_target = variables.TARGET_KEEP,
		next_target = variables.NT_STRONG_MELEE,
		sfx = [{code = 'shake_target', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'punch', hit = null, hittype = 'bodyarmor'},
		value = [['caster.matk', '*0.6']],
		variations = [
			{
				reqs = [{code = 'has_status', status = 'grotus_contempt', check = true}],
				set = {effects = [
					Effectdata.rebuild_template({effect = 'shred', duration = 3, chance = 0.5}),
					'grotus_stomping_guard_break',
				]},
			}
		],
	},
	#===== frontline sweep =====
	grotus_thunderous_slam = {
		code = 'grotus_thunderous_slam',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_earthquake.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'aoe', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'stun', duration = 1, chance = 0.35}),
			Effectdata.rebuild_template({effect = 'grotus_window_of_opportunity', res_condition = variables.RES_MISS}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'line',
		target_range = 'melee',
		damage_type = 'weapon',
		sfx = [
			{code = 'earthquake', target = 'target_line', period = 'predamage'},
			{code = 'tauntwave', target = 'caster', period = 'windup'}],
		sounddata = {initiate = null, strike = 'explosion', hit = null, hittype = 'bodyarmor'},
		value = [['caster.matk', '*0.85']],
		variations = [
			{
				reqs = [{code = 'has_status', status = 'grotus_contempt', check = true}],
				set = {target_number = 'all', target_range = 'any'},
			}
		],
	},
	#===== light barrage =====
	grotus_power_surge = {
		code = 'grotus_power_surge',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_lightning_orb.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'ads', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'shock', duration = 2}),
			Effectdata.rebuild_template({effect = 'stun', duration = 1, chance = 0.2}),
			'grotus_gap_roll_per_iteration',
		],
		cost = {},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		repeat = 3,
		target = 'enemy',
		target_number = 'x_random',
		number_rnd_targets = 3,
		target_range = 'any',
		damage_type = 'light',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		sfx = [
			{code = 'chain_lightning', target = 'target', period = 'predamage'},
			{code = 'cast_light', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'spell_lightning', strike = null, hit = null},
		value = [['caster.matk', '*0.5']],
		variations = [
			{
				reqs = [{code = 'has_status', status = 'grotus_contempt', check = true}],
				set = {
					repeat = 5,
					effects = [
						Effectdata.rebuild_template({effect = 'shock', duration = 2}),
						Effectdata.rebuild_template({effect = 'stun', duration = 1, chance = 0.2}),
						'grotus_gap_roll_per_iteration',
						'grotus_power_surge_overload',
					]},
			}
		],
	},
	#===== execute =====
	grotus_energy_discharge = {
		code = 'grotus_energy_discharge',
		descript = '',
		icon = "res://assets/images/iconsskills/holylance.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'damage_spot', 'ads', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = [
			#"if the target survives" - damage is already applied by TR_POSTDAMAGE, and
			#the is_dead req code tracks world availability rather than combat death
			Effectdata.rebuild_template({
				effect = 'grotus_window_of_opportunity',
				target_reqs = [{code = 'stat', stat = 'hp', operant = 'gte', value = 1}],
			}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'light',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_STRONG_MELEE,
		sfx = [
			{code = 'radiance', target = 'target', period = 'predamage'},
			{code = 'cast_light', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'spell_explosion', strike = 'explosion', hit = null},
		value = [['caster.matk', '*2.4']],
		variations = [
			{
				reqs = [{code = 'has_status', status = 'grotus_contempt', check = true}],
				set = {next_target = variables.NT_WEAK_MELEE},
			}
		],
	},
	#===== telegraph =====
	grotus_present_thyself = {
		code = 'grotus_present_thyself',
		descript = '',
		icon = "res://assets/images/iconsskills/Authority.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['debuff', 'ultimate', 'noevade', 'noreduce', 'disable_immunity', 'ignore_taunt'],
		reqs = [{code = 'has_status', status = 'grotus_king_decree', check = false}],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'grotus_object_of_resentment'}),
			Effectdata.rebuild_template({effect = 'fear', duration = 2}),
			Effectdata.rebuild_template({effect = 'grotus_king_decree', target = 'caster'}),
			Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('fear', 'caster')}),
			Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('ensnared', 'caster')}),
			Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('blind', 'caster')}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_STRONG,
		follow_up = 'grotus_royal_summons',
		sfx = [
			{code = 'command', target = 'caster', period = 'windup'},
			{code = 'leader_mark', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
		chance = 999,
		variations = [
			{
				reqs = [{code = 'has_status', status = 'grotus_contempt', check = true}],
				set = {
					follow_up = null,
					effects = [
						Effectdata.rebuild_template({effect = 'grotus_object_of_resentment'}),
						Effectdata.rebuild_template({effect = 'fear', duration = 2}),
						Effectdata.rebuild_template({effect = 'grotus_king_decree', target = 'caster'}),
						Effectdata.rebuild_template({effect = 'grotus_taunt_immunity', target = 'caster'}),
						Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('fear', 'caster')}),
						Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('ensnared', 'caster')}),
						Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('blind', 'caster')}),
					]},
			}
		],
	},
	#follow-up of grotus_present_thyself - the "3 random enemies gain an opening" half.
	#Not in any unit's skill list: follow_up resolves through Skilldata directly.
	grotus_royal_summons = {
		code = 'grotus_royal_summons',
		descript = '',
		icon = "res://assets/images/iconsskills/Authority.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['debuff', 'noevade', 'noreduce', 'descript_hidden'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'grotus_window_of_opportunity'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'x_random',
		number_rnd_targets = 3,
		target_range = 'any',
		damage_type = 'light',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		sfx = [{code = 'leader_mark', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
		chance = 999,
	},
	#===== the payoff =====
	grotus_obliteration = {
		code = 'grotus_obliteration',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_disintegrate.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'ultimate', 'disable_immunity', 'ignore_taunt'],
		reqs = [{code = 'has_status', status = 'grotus_king_decree', check = true}],
		targetreqs = [{code = 'has_status', status = 'grotus_object_of_resentment', check = true}],
		effects = [
			#both clear on hit OR miss (an explicit trigger drops rebuild_template's hit_res
			#gate), so a whiff fully resets the telegraph instead of stranding the mark
			Effectdata.rebuild_template({trigger = variables.TR_POSTDAMAGE, effect = Effectdata.rebuild_remove_effect('grotus_king_decree', 'caster')}),
			Effectdata.rebuild_template({trigger = variables.TR_POSTDAMAGE, effect = Effectdata.rebuild_remove_effect('grotus_object_of_resentment')}),
			#"On hit, cause a follow-up shockwave" - cancel it when the blow misses
			'grotus_obliteration_cancel_wave',
			#"up to 5 random Defensive Gap" on a whiff - five independent rolls over the
			#same six gaps, so duplicates collapse into one stack and 5 is the ceiling.
			'grotus_gap_roll_on_miss',
			'grotus_gap_roll_on_miss',
			'grotus_gap_roll_on_miss',
			'grotus_gap_roll_on_miss',
			'grotus_gap_roll_on_miss',
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		follow_up = 'grotus_obliteration_wave',
		sfx = [
			{code = 'execution', target = 'target', period = 'predamage'},
			{code = 'cast_light', target = 'caster', period = 'windup', is_cast = true}],
		sounddata = {initiate = 'spell_explosion', strike = 'explosion', hit = null, hittype = 'absolute'},
		value = [['caster.matk', '*4.0']],
	},
	#follow-up of grotus_obliteration - the shockwave half.
	grotus_obliteration_wave = {
		code = 'grotus_obliteration_wave',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'descript_hidden'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'shred', duration = 3}),
			Effectdata.rebuild_template({effect = 'stun', duration = 1, chance = 0.4}),
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
		sfx = [{code = 'radiance', target = 'target_group', period = 'predamage'}],
		sounddata = {initiate = 'spell_explosion', strike = 'explosion', hit = null},
		value = [['caster.matk', '*0.9']],
	},
}

var effects = {
	#=========================================================================
	# Defensive Gap
	#=========================================================================
	#The stun the gaps pay out in. Deliberately NOT 'stun': status_resists.stun = 100
	#on both Grotus units, and check_status_immunity() looks up resist_<raw string>.
	#'grotus_overwhelmed' has no resist stat, so it always lands - while the 'stun' and
	#'disable' tags keep it behaving like a stun everywhere else.
	grotus_overwhelmed = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_overwhelmed',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['stun', 'disable', 'negative', 'grotus_overwhelmed'],
		statchanges = {},
		buffs = ['b_grotus_overwhelmed'],
	},
	grotus_gap_dragged_feet = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_gap_dragged_feet',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['defensive_gap', 'negative', 'grotus_gap_dragged_feet'],
		statchanges = {},
		buffs = ['b_grotus_gap_dragged_feet'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_S, variables.TR_TURN_GET, variables.TR_POST_TARG, variables.TR_DMG],
				req_skill = false,
				conditions = [{type = 'owner', value = [{code = 'has_status', status = 'wet', check = true}]}],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'effect', value = 'grotus_overwhelmed'},
							{type = 'remove_all_effects', value = 'grotus_gap_dragged_feet'},
						],
					},
				],
			},
		],
	},
	grotus_gap_unbalanced_posture = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_gap_unbalanced_posture',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['defensive_gap', 'negative', 'grotus_gap_unbalanced_posture'],
		statchanges = {},
		buffs = ['b_grotus_gap_unbalanced_posture'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_DEF],
				req_skill = true,
				conditions = [{type = 'skill', value = ['damage_type', 'eq', 'earth']}],
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'effect', value = 'grotus_overwhelmed'},
							{type = 'remove_all_effects', value = 'grotus_gap_unbalanced_posture'},
						],
					},
				],
			},
		],
	},
	grotus_gap_disorientation = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_gap_disorientation',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['defensive_gap', 'negative', 'grotus_gap_disorientation'],
		statchanges = {},
		buffs = ['b_grotus_gap_disorientation'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_S, variables.TR_TURN_GET, variables.TR_POST_TARG, variables.TR_DMG],
				req_skill = false,
				conditions = [{type = 'owner', value = [{code = 'has_status', status = 'blind', check = true}]}],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'effect', value = 'grotus_overwhelmed'},
							{type = 'remove_all_effects', value = 'grotus_gap_disorientation'},
						],
					},
				],
			},
		],
	},
	grotus_gap_dulled_dexterity = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_gap_dulled_dexterity',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['defensive_gap', 'negative', 'grotus_gap_dulled_dexterity'],
		statchanges = {},
		buffs = ['b_grotus_gap_dulled_dexterity'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_S, variables.TR_TURN_GET, variables.TR_POST_TARG, variables.TR_DMG],
				req_skill = false,
				#the ensnare effect tags itself 'ensnared', not 'ensnare'
				conditions = [{type = 'owner', value = [{code = 'has_status', status = 'ensnared', check = true}]}],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'effect', value = 'grotus_overwhelmed'},
							{type = 'remove_all_effects', value = 'grotus_gap_dulled_dexterity'},
						],
					},
				],
			},
		],
	},
	grotus_gap_tunnel_vision = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_gap_tunnel_vision',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['defensive_gap', 'negative', 'grotus_gap_tunnel_vision'],
		statchanges = {},
		buffs = ['b_grotus_gap_tunnel_vision'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_DEF],
				req_skill = true,
				#'hide' is the tag behind In the Shadow / stealth
				conditions = [{type = 'caster', value = [{code = 'has_status', status = 'hide', check = true}]}],
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'effect', value = 'grotus_overwhelmed'},
							{type = 'remove_all_effects', value = 'grotus_gap_tunnel_vision'},
						],
					},
				],
			},
		],
	},
	grotus_gap_restrictive_position = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_gap_restrictive_position',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['defensive_gap', 'negative', 'grotus_gap_restrictive_position'],
		statchanges = {},
		buffs = ['b_grotus_gap_restrictive_position'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_DEF],
				req_skill = true,
				conditions = [{type = 'skill', value = ['target_number', 'eq', 'all']}],
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'effect', value = 'grotus_overwhelmed'},
							{type = 'remove_all_effects', value = 'grotus_gap_restrictive_position'},
						],
					},
				],
			},
		],
	},
	#"gain a random Defensive Gap", three flavours. modal_sub_effects picks one entry
	#per firing. The _on_cast / _on_miss pair live on the skill, so the receiver is
	#'caster' (each gap template already targets 'caster'); _on_owner lives on Grotus
	#himself, where 'caster' would resolve to whoever just hit him.
	grotus_gap_roll_on_cast = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		sub_effects = [],
		modal_sub_effects = [
			'grotus_gap_dragged_feet',
			'grotus_gap_unbalanced_posture',
			'grotus_gap_disorientation',
			'grotus_gap_dulled_dexterity',
			'grotus_gap_tunnel_vision',
			'grotus_gap_restrictive_position',
		],
	},
	#same roll, but hung on TR_CAST_TARGET so it fires once per repeat rather than once
	#per skill use - Rampaging Power Surge opens a new gap on every pass
	grotus_gap_roll_per_iteration = {
		type = 'trigger',
		trigger = [variables.TR_CAST_TARGET],
		req_skill = true,
		conditions = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [],
		modal_sub_effects = [
			'grotus_gap_dragged_feet',
			'grotus_gap_unbalanced_posture',
			'grotus_gap_disorientation',
			'grotus_gap_dulled_dexterity',
			'grotus_gap_tunnel_vision',
			'grotus_gap_restrictive_position',
		],
	},
	grotus_gap_roll_on_miss = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]}],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [],
		modal_sub_effects = [
			'grotus_gap_dragged_feet',
			'grotus_gap_unbalanced_posture',
			'grotus_gap_disorientation',
			'grotus_gap_dulled_dexterity',
			'grotus_gap_tunnel_vision',
			'grotus_gap_restrictive_position',
		],
	},
	#follow_up is read once at invoke_skillfinish, after every instance has resolved, so
	#clearing it here still cancels the shockwave
	grotus_obliteration_cancel_wave = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]}],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'follow_up', value = null}],
			},
		],
	},
	#the target of grotus_stomping is turtling up - punish the boss for slamming a wall
	grotus_stomping_guard_break = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'earthshield', check = true},
				{code = 'has_status', status = 'stonewall', check = true},
			]}]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = ['grotus_gap_unbalanced_posture'],
	},
	#the empowered Rampaging Power Surge burns Grotus' own health
	grotus_power_surge_overload = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'damage_percent', value = 8}],
			},
		],
	},

	#=========================================================================
	# Statuses Grotus hands out
	#=========================================================================
	grotus_window_of_opportunity = {
		type = 'temp_s',
		target = 'target',
		stack = 'grotus_window_of_opportunity',
		tick_event = [variables.TR_NONE],
		#"remove on hit and on turn end" - TR_HIT fires on the holder when they attack
		rem_event = [variables.TR_HIT, variables.TR_TURN_F, variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['buff', 'grotus_window_of_opportunity'],
		statchanges = {critchance = 80, critmod = -0.25},
		buffs = ['b_grotus_window_of_opportunity'],
	},
	grotus_object_of_resentment = {
		type = 'temp_s',
		target = 'target',
		stack = 'grotus_object_of_resentment',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['debuff', 'negative', 'grotus_object_of_resentment'],
		#speed has no percent channel anywhere in the codebase, so -100% is a flat
		#value below any reachable base
		statchanges = {speed = -200},
		buffs = ['b_grotus_object_of_resentment'],
	},

	#=========================================================================
	# Grotus' own states
	#=========================================================================
	#internal flag: a mark is out, do not re-cast Present Thyself. Cleared by C&TO.
	grotus_king_decree = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_king_decree',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['grotus_king_decree'],
		statchanges = {},
		buffs = [],
	},
	grotus_contempt = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_contempt',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff', 'grotus_contempt'],
		statchanges = {atk = 20, speed = 10, damage_reduction = 30},
		buffs = ['b_grotus_contempt'],
		sub_effects = [
			#the second half of "reduce damage taken from critical attack by 30%"
			{
				type = 'trigger',
				trigger = [variables.TR_DEF],
				req_skill = true,
				conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_CRIT]}],
				args = {
					skill = {obj = 'skill', func = 'eq'},
					caster = {obj = 'caster', func = 'eq'},
					target = {obj = 'target', func = 'eq'},
				},
				sub_effects = [
					{
						type = 'oneshot',
						target = 'skill',
						atomic = [{type = 'stat_mul', stat = 'value', value = 0.7}],
					},
				],
			},
		],
	},
	#there is no resist_taunt stat, so immunity is "shrug it off before acting"
	grotus_taunt_immunity = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_taunt_immunity',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff', 'grotus_taunt_immunity'],
		statchanges = {},
		buffs = ['b_grotus_taunt_immunity'],
		sub_effects = [
			{
				type = 'trigger',
				trigger = [variables.TR_TURN_S, variables.TR_TURN_GET, variables.TR_POST_TARG, variables.TR_DEF_HIT],
				req_skill = false,
				conditions = [],
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [
							{type = 'remove_all_effects', value = 'taunt_soft'},
							{type = 'remove_all_effects', value = 'taunt_hard'},
						],
					},
				],
			},
		],
	},
	#one mark per landed hit; get_buff_number() sums them for the Contempt threshold
	grotus_hit_mark = {
		type = 'temp_s',
		target = 'caster',
		stack = 'grotus_hit_mark',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['grotus_hit_mark'],
		statchanges = {},
		buffs = ['b_grotus_hit_mark'],
	},

	#=========================================================================
	# Trait: Protection of the Divine Barrier (phase 1)
	#=========================================================================
	grotus_barrier_dot_immunity = {
		type = 'simple',
		statchanges = {
			resist_bleed_set = 200, resist_poison_set = 200, resist_burn_set = 200,
			bleed_damage = 0, poison_damage = 0, burn_damage = 0, darkflame_damage = 0,
		},
		buffs = ['b_grotus_divine_barrier'],
	},
	#RES_HIT alone is exactly "landed and did not crit"
	grotus_barrier_noncrit = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.55}],
			},
		],
	},
	#the 'disable' tag covers stun, sleep and charm at once - including the custom
	#grotus_overwhelmed the Defensive Gaps pay out in, which is the whole point
	grotus_barrier_mobile = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'disable', check = false}]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.55}],
			},
		],
	},

	#=========================================================================
	# Trait: Insecurity of the Tyrant (phase 2)
	#=========================================================================
	#phase 2 trades the immunity for a plain 85% cut, on top of boss_resists
	grotus_dot_shrug = {
		type = 'simple',
		statchanges = {bleed_damage = 0.15, poison_damage = 0.15, burn_damage = 0.15, darkflame_damage = 0.15},
		buffs = ['b_grotus_tyrant_insecurity'],
	},
	grotus_hit_counter_watch = {
		type = 'trigger',
		trigger = [variables.TR_DEF_HIT],
		req_skill = true,
		#TR_DEF_HIT fires per instance regardless of the roll, so gate on a landed hit
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
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
				atomic = [{type = 'effect', value = 'grotus_hit_mark'}],
			},
		],
	},
	#TR_TURN_S is fired on every fighter at round start - that is the round boundary
	grotus_hit_counter_reset = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'remove_all_effects', value = 'grotus_hit_mark'}],
			},
		],
	},
	grotus_contempt_from_hits = {
		type = 'trigger',
		trigger = [variables.TR_DEF_HIT, variables.TR_POST_TARG, variables.TR_DMG],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'buff_number', status = 'grotus_hit_mark', operant = 'gte', value = 5}]},
			{type = 'owner', value = [{code = 'has_status', status = 'grotus_contempt', check = false}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'effect', value = 'grotus_contempt'}],
			},
		],
	},
	grotus_contempt_lowhp = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S, variables.TR_TURN_GET, variables.TR_POST_TARG, variables.TR_DMG],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.5']}]},
			{type = 'owner', value = [{code = 'has_status', status = 'grotus_contempt', check = false}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'effect', value = 'grotus_contempt'}],
			},
		],
	},

	#=========================================================================
	# Trait: No More Humiliation and Scorn
	#=========================================================================
	#"20% more damage against a target on a higher HP% than this unit" cannot be written
	#directly: reqs are evaluated against one character, and calculate_number_from_string_array
	#returns "" for a 'target.' prefix. Bucketed instead - Grotus' own quarter picks which
	#threshold the victim has to clear, so the bonus fires more and more often as he drops.
	grotus_scorn_q1 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.25']}]},
			{type = 'target', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.25']}]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2}],
			},
		],
	},
	grotus_scorn_q2 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.25']}]},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.5']}]},
			{type = 'target', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.5']}]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2}],
			},
		],
	},
	grotus_scorn_q3 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.5']}]},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.75']}]},
			{type = 'target', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.75']}]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2}],
			},
		],
	},
	grotus_scorn_q4 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.75']}]},
			{type = 'target', value = [{code = 'stat', stat = 'hp', operant = 'gte', value = ['self.hpmax', '*0.95']}]},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2}],
			},
		],
	},
	#Grotus does not take insults - simple effects re-check their conditions on every
	#stat rebuild, so this comes and goes with the taunt
	grotus_taunted_fury = {
		type = 'simple',
		conditions = [{code = 'or_list', or_list = [
			{code = 'has_status', status = 'taunt_soft', check = true},
			{code = 'has_status', status = 'taunt_hard', check = true},
		]}],
		statchanges = {atk = 50, armorpenetration = 50},
		buffs = ['b_grotus_taunted_fury'],
	},

	#=========================================================================
	# Trait: Unnatural Apotheosis
	#=========================================================================
	grotus_disarm_immunity = {
		type = 'simple',
		statchanges = {resist_disarm_set = 200},
		buffs = ['b_grotus_apotheosis'],
	},
	#There is no "a status is about to be applied" hook, so Shred/Shatter are converted
	#one tick later instead of intercepted. The pair is ordered: the gap branch strips
	#shred/shatter, which makes the shock branch's own condition fail in the same pass.
	grotus_apotheosis_convert = {
		type = 'trigger',
		trigger = [variables.TR_DEF_HIT, variables.TR_POST_TARG, variables.TR_DMG, variables.TR_TURN_S, variables.TR_TURN_GET],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'shred', check = true},
				{code = 'has_status', status = 'shatter', check = true},
			]}]},
			{type = 'owner', value = [{code = 'has_status', status = 'defensive_gap', check = false}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'remove_all_effects', value = 'shred'},
					{type = 'remove_all_effects', value = 'shatter'},
				],
			},
		],
		modal_sub_effects = [
			{status = 'grotus_gap_dragged_feet', overload_target = 'owner'},
			{status = 'grotus_gap_unbalanced_posture', overload_target = 'owner'},
			{status = 'grotus_gap_disorientation', overload_target = 'owner'},
			{status = 'grotus_gap_dulled_dexterity', overload_target = 'owner'},
			{status = 'grotus_gap_tunnel_vision', overload_target = 'owner'},
			{status = 'grotus_gap_restrictive_position', overload_target = 'owner'},
		],
	},
	grotus_apotheosis_convert_shock = {
		type = 'trigger',
		trigger = [variables.TR_DEF_HIT, variables.TR_POST_TARG, variables.TR_DMG, variables.TR_TURN_S, variables.TR_TURN_GET],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'shred', check = true},
				{code = 'has_status', status = 'shatter', check = true},
			]}]},
			{type = 'owner', value = [{code = 'has_status', status = 'defensive_gap', check = true}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'remove_all_effects', value = 'shred'},
					{type = 'remove_all_effects', value = 'shatter'},
					#e_s_shock takes its duration from args, so hand it one via override
					{type = 'effect', value = 'e_s_shock', override = {duration = 2}},
				],
			},
		],
	},
	#no weapon, all artifact - every physical blow spills holy light
	grotus_holy_overflow = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
		],
		args = {
			skill = {obj = 'skill', func = 'eq'},
			caster = {obj = 'caster', func = 'eq'},
			target = {obj = 'target', func = 'eq'},
			value = {obj = 'caster', func = 'stat', stat = 'matk'},
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				args = {value = {obj = 'parent', func = 'arg', arg = 'value'}},
				atomic = [{type = 'damage', source = 'light', value = [['parent_args', 'value'], '*', 0.25]}],
			},
		],
	},
}

var atomic_effects = {}

var buffs = {
	b_grotus_overwhelmed = {
		icon = "res://assets/images/iconsskills/Strong Magic Shackles.png",
		description = "EFFECT_GROTUS_OVERWHELMED_DESCRIPT",
	},
	b_grotus_gap_dragged_feet = {
		icon = "res://assets/images/iconsskills/wateredge.png",
		description = "EFFECT_GROTUS_GAP_DRAGGED_FEET_DESCRIPT",
	},
	b_grotus_gap_unbalanced_posture = {
		icon = "res://assets/images/iconsskills/icon_earth.png",
		description = "EFFECT_GROTUS_GAP_UNBALANCED_POSTURE_DESCRIPT",
	},
	b_grotus_gap_disorientation = {
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		description = "EFFECT_GROTUS_GAP_DISORIENTATION_DESCRIPT",
	},
	b_grotus_gap_dulled_dexterity = {
		icon = "res://assets/images/iconsskills/skill_ensnare.png",
		description = "EFFECT_GROTUS_GAP_DULLED_DEXTERITY_DESCRIPT",
	},
	b_grotus_gap_tunnel_vision = {
		icon = "res://assets/images/iconsskills/skill_veil.png",
		description = "EFFECT_GROTUS_GAP_TUNNEL_VISION_DESCRIPT",
	},
	b_grotus_gap_restrictive_position = {
		icon = "res://assets/images/iconsskills/icon_energy_field.png",
		description = "EFFECT_GROTUS_GAP_RESTRICTIVE_POSITION_DESCRIPT",
	},
	b_grotus_window_of_opportunity = {
		icon = "res://assets/images/iconsskills/Aimed-strike.png",
		description = "EFFECT_GROTUS_WINDOW_OF_OPPORTUNITY_DESCRIPT",
	},
	b_grotus_object_of_resentment = {
		icon = "res://assets/images/iconsskills/PublicPunish.png",
		description = "EFFECT_GROTUS_OBJECT_OF_RESENTMENT_DESCRIPT",
	},
	b_grotus_contempt = {
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "EFFECT_GROTUS_CONTEMPT_DESCRIPT",
	},
	b_grotus_taunt_immunity = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "EFFECT_GROTUS_TAUNT_IMMUNITY_DESCRIPT",
	},
	b_grotus_hit_mark = {
		icon = "res://assets/images/iconsskills/icon_hunters_mark.png",
		description = "EFFECT_GROTUS_HIT_MARK_DESCRIPT",
		tags = ['show_amount'],
	},
	b_grotus_divine_barrier = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "EFFECT_GROTUS_DIVINE_BARRIER_DESCRIPT",
	},
	b_grotus_tyrant_insecurity = {
		icon = "res://assets/images/iconsskills/Debilitate.png",
		description = "EFFECT_GROTUS_TYRANT_INSECURITY_DESCRIPT",
	},
	b_grotus_taunted_fury = {
		icon = "res://assets/images/iconsskills/warcry.png",
		description = "EFFECT_GROTUS_TAUNTED_FURY_DESCRIPT",
	},
	b_grotus_apotheosis = {
		icon = "res://assets/images/iconsskills/icon_light.png",
		description = "EFFECT_GROTUS_APOTHEOSIS_DESCRIPT",
	},
}

var stacks = {
	grotus_overwhelmed = {},
	grotus_gap_dragged_feet = {},
	grotus_gap_unbalanced_posture = {},
	grotus_gap_disorientation = {},
	grotus_gap_dulled_dexterity = {},
	grotus_gap_tunnel_vision = {},
	grotus_gap_restrictive_position = {},
	grotus_window_of_opportunity = {},
	grotus_object_of_resentment = {},
	grotus_king_decree = {},
	grotus_contempt = {},
	grotus_taunt_immunity = {},
	grotus_hit_mark = {
		type = 'stack_c',
		stack = 12,
		buff = 'b_grotus_hit_mark',
	},
}
