extends Reference
#Erdyna, leader of the Red Rooks ("Strive:Conquest - Erdyna rework proposal v2").
#The gimmick: Let's See What You Got marks an enemy as the Subject of Observation and gives her
#Observing. A physical hit or Blind breaks the observation and frees every subject. If it holds
#until How Predictable~, every subject is Evaluated for the rest of the fight and she gains a
#stack of Battle Precognition. King of Bandits opens the fight with Equalizer and answers her
#first drop below half HP with another one.
#The duel (enemydata 'erdyna') and the betrayal fight ('erdyna_betrayal') share everything but
#two traits: the constitution trait is only renamed, and How could you... is betrayal-only.

var skills = {
	#Behind the scene skill zone
	#cast by the observation breaking: frees every subject at once
	erdyna_observation_lost = {
		code = 'erdyna_observation_lost',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		type = 'auto',
		ability_type = 'spell',
		tags = ['debuff', 'passive', 'noreduce'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('erdyna_subject_of_observation')}),
		],
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
	#King of Bandits only - never part of the rotation. A miss still lands at half damage.
	#Used through use_combat_skill with no target, so NOKEEP picks a random enemy.
	erdyna_equalizer = {
		code = 'erdyna_equalizer',
		descript = '',
		icon = "res://assets/images/iconsskills/revenge.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads'],
		reqs = [],
		targetreqs = [],
		#the old focus goes first, or it would resurface when the new one ends
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('erdyna_equalizer_focus', 'caster')}),
			'erdyna_equalizer_no_miss',
			Effectdata.rebuild_template({effect = 'erdyna_equalizer_focus', target = 'caster', duration = 4}),
			'erdyna_equalizer_splash',
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		damage_type = 'weapon',
		sfx = [
			{code = 'provocation', target = 'caster', period = 'windup'},
			{code = 'strike', target = 'target', period = 'predamage'},
		],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.0,
		random_factor_p = 0.1,
	},
	#Equalizer's splash, cast at the main target: everyone else in its group takes a hit and is Subdued
	erdyna_equalizer_1 = {
		code = 'erdyna_equalizer',
		descript = '',
		icon = "res://assets/images/iconsskills/revenge.png",
		type = 'auto',
		ability_type = 'skill',
		tags = ['damage', 'aoe', 'debuff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'erdyna_subdued', duration = 2})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'nontarget',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'tauntwave', target = 'target', period = 'windup'}],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.5,
		random_factor_p = 0.1,
		chance = 999,
		evade = 0,
	},
	#How Predictable~'s second half: every Subject of Observation becomes Evaluated
	erdyna_how_predictable_1 = {
		code = 'erdyna_how_predictable',
		descript = '',
		icon = "res://assets/images/iconsskills/Mindread.png",
		type = 'auto',
		ability_type = 'spell',
		tags = ['debuff', 'aoe', 'passive', 'noreduce'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = 'erdyna_evaluated',
				target_reqs = [{code = 'has_status', status = 'erdyna_subject_of_observation', check = true}]}),
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('erdyna_subject_of_observation')}),
		],
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
	#Nail it!'s melee follow-up: cannot miss, Impales a bleeding target
	erdyna_nail_it_1 = {
		code = 'erdyna_nail_it',
		descript = '',
		icon = "res://assets/images/iconsskills/Aimed-strike.png",
		type = 'auto',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'damage_spot'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'e_impale', duration = 3,
				target_reqs = [{code = 'has_status', status = 'bleed', check = true}]}),
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
		sfx = [
			{code = 'assassinate_step', target = 'caster', period = 'windup', is_cast = true},
			{code = 'assassinate', target = 'target', period = 'predamage'},
		],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.2,
		random_factor_p = 0.1,
		chance = 999,
		evade = 0,
	},
	#Actual skill zone.
	erdyna_lets_see_what_you_got = {
		code = 'erdyna_lets_see_what_you_got',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'debuff', 'damage_spot'],
		reqs = [],
		targetreqs = [
			{code = 'has_status', status = 'erdyna_subject_of_observation', check = false},
			{code = 'has_status', status = 'erdyna_evaluated', check = false},
		],
		#hit or miss: an explicit trigger drops rebuild_template's hit_res gate
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('hide')}),
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('blind', 'caster')}),
			Effectdata.rebuild_template({trigger = variables.TR_POSTDAMAGE, effect = 'erdyna_subject_of_observation',
				target_reqs = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]}),
			Effectdata.rebuild_template({trigger = variables.TR_POSTDAMAGE, target = 'caster', effect = 'erdyna_observing',
				target_reqs = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]}),
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
		sfx = [{code = 'projectile_arrow', target = 'target', period = 'predamage', duration = 0.25, arc = 45.0, boom_size = 150.0, size = 1.1},],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.8,
		random_factor_p = 0.1,
	},
	#the second row comes from KEEPFIRST + NT_ANY, the way crazed_spirit_possession picks its rows
	erdyna_slice_and_dive = {
		code = 'erdyna_slice_and_dive',
		descript = '',
		icon = "res://assets/images/iconsskills/slash.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'aoe'],
		reqs = [],
		targetreqs = [],
		effects = [],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'row',
		target_range = 'melee',
		repeat = 2,
		keep_target = variables.TARGET_KEEPFIRST,
		next_target = variables.NT_ANY,
		damage_type = 'weapon',
		sfx = [
			{code = 'strike', target = 'target', period = 'predamage'},
			{code = 'cast_weapon', target = 'caster', period = 'windup', is_cast = true},
		],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.9,
		random_factor_p = 0.1,
		variations = [
			{
				reqs = [{code = 'has_status', status = 'ensnared', check = true}],
				set = {repeat = 1},
			},
		],
	},
	erdyna_assault_and_battery = {
		code = 'erdyna_assault_and_battery',
		descript = '',
		icon = "res://assets/images/iconsskills/comboattack.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'damage_spot'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({effect = 'shred', duration = 2,
				target_reqs = [{code = 'stat', stat = 'hp', operant = 'gt', value = ['self.hpmax', '*0.5']}]}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		repeat = 2,
		keep_target = variables.TARGET_KEEP,
		next_target = variables.NT_MELEE,
		damage_type = 'weapon',
		sfx = [
			{code = 'strike', target = 'target', period = 'predamage'},
			{code = 'cast_weapon', target = 'caster', period = 'windup', is_cast = true},
		],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.75,
		random_factor_p = 0.1,
	},
	#dagger toss; the melee follow-up only comes if it hits
	erdyna_nail_it = {
		code = 'erdyna_nail_it',
		descript = '',
		icon = "res://assets/images/iconsskills/Aimed-strike.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'damage_spot'],
		reqs = [],
		targetreqs = [],
		effects = ['e_remove_fa', 'erdyna_nail_it_aim'],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'projectile_arrow', target = 'target', period = 'predamage', duration = 0.25, arc = 45.0, boom_size = 150.0, size = 1.1},],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.5,
		random_factor_p = 0.1,
		follow_up = 'erdyna_nail_it_1',
	},
	erdyna_deceptive_ruse = {
		code = 'erdyna_deceptive_ruse',
		descript = '',
		icon = "res://assets/images/iconsskills/distract.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['debuff', 'aoe', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		#no single tag covers every negative status: stun is 'negative', disarm 'debuff', bleed 'affliction'
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('negative', 'caster')}),
			Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('debuff', 'caster')}),
			Effectdata.rebuild_template({trigger = variables.TR_CAST, effect = Effectdata.rebuild_remove_effect('affliction', 'caster')}),
			Effectdata.rebuild_template({effect = 'stun', duration = 1,
				target_reqs = [{code = 'is_immune', status = 'stun', check = false}]}),
			Effectdata.rebuild_template({effect = 'disarm', duration = 1,
				target_reqs = [{code = 'is_immune', status = 'stun', check = true}]}),
			Effectdata.rebuild_template({effect = 'silence', duration = 1,
				target_reqs = [{code = 'is_immune', status = 'stun', check = true}]}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'x_random',
		number_rnd_targets = [1, 3],
		keep_target = variables.TARGET_NOKEEP,
		next_target = variables.NT_ANY,
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'smokescreen', target = 'target_group', period = 'windup'}],
		sounddata = {initiate = null, strike = null, hit = null, hittype = null},
		value = [['0']],
		damagestat = ['no_stat'],
		critchance = 0,
	},
	erdyna_rules_of_the_backstreet = {
		code = 'erdyna_rules_of_the_backstreet',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_execute.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['damage', 'ads', 'damage_spot', 'disable_immunity'],
		reqs = [],
		targetreqs = [],
		effects = ['erdyna_backstreet_fragile', 'erdyna_backstreet_trophy'],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		keep_target = variables.TARGET_KEEP,
		next_target = variables.NT_MELEE,
		damage_type = 'weapon',
		sfx = [
			{code = 'execution', target = 'target', period = 'predamage'},
			{code = 'cast_weapon', target = 'caster', period = 'windup', is_cast = true},
		],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.5,
		random_factor_p = 0.1,
		#one more hit per Battle Precognition stack; later lines win
		variations = [
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 1}],
				set = {repeat = 2},
			},
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 2}],
				set = {repeat = 3},
			},
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 3}],
				set = {repeat = 4},
			},
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 4}],
				set = {repeat = 5},
			},
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 5}],
				set = {repeat = 6},
			},
			{
				reqs = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 6}],
				set = {repeat = 7},
			},
		],
	},
	#Observing is consumed here, but without breaking: the subjects are turned into Evaluated by the follow-up
	erdyna_how_predictable = {
		code = 'erdyna_how_predictable',
		descript = '',
		icon = "res://assets/images/iconsskills/Mindread.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['heal', 'support', 'buff', 'noreduce', 'disable_immunity', 'ignore_taunt'],
		reqs = [{code = 'has_status', status = 'erdyna_observing', check = true}],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_template({trigger = variables.TR_PREHIT, effect = Effectdata.rebuild_remove_effect('erdyna_observing')}),
			Effectdata.rebuild_template({effect = 'erdyna_battle_precognition'}),
		],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.hpmax', '*0.1']],
		damagestat = ['-damage_hp'],
		follow_up = 'erdyna_how_predictable_1',
	},
}
var effects = {
	#trait effects
	erdyna_hardy_constitution_display = {
		type = 'simple',
		statchanges = {},
		buffs = ['b_erdyna_hardy_constitution_display'],
	},
	erdyna_draconic_constitution_display = {
		type = 'simple',
		statchanges = {},
		buffs = ['b_erdyna_draconic_constitution_display'],
	},
	#greg_final_stand's DoT numbers, on top of boss_resists
	erdyna_constitution = {
		type = 'simple',
		statchanges = {bleed_damage = 0.20, poison_damage = 0.33, burn_damage = 0.33, darkflame_damage = 0.33, resist_burn_set = 200, resist_fire = 50},
	},
	erdyna_constitution_guard = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'random', value = 0.3},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.5}],
			},
		],
	},
	#armed at combat start, fires once and removes itself - the cornered_beast pattern
	erdyna_constitution_arm = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'effect', value = 'erdyna_unstoppable_reserve'}],
			},
		],
	},
	erdyna_unstoppable_reserve = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_DMG],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.5']}]},
		],
		tags = ['erdyna_unstoppable_reserve'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'sfx', value = 'rally'},
					{type = 'effect', value = 'unstoppable_til_death'},
					{type = 'remove_all_effects', value = 'erdyna_unstoppable_reserve'},
				],
			},
		],
	},
	erdyna_king_of_bandits_display = {
		type = 'simple',
		statchanges = {resist_provoke_set = 200},
		buffs = ['b_erdyna_king_of_bandits_display'],
	},
	#melee attacker while she is disarmed: 50% to hand the disarm back to them
	erdyna_disarm_reversal = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'owner', value = [{code = 'has_status', status = 'disarm', check = true}]},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'caster', value = [{code = 'stat', stat = 'hp', operant = 'gt', value = 0}]},
			{type = 'random', value = 0.5},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'add_combat_log', text = 'ERDYNA_DISARM_REVERSAL'},
					{type = 'remove_all_effects', value = 'disarm'},
				],
			},
			{
				type = 'oneshot',
				target = 'caster',
				conditions = [{code = 'is_immune', status = 'disarm', check = false}],
				atomic = [{type = 'sfx', value = 'disarm'}, {type = 'effect', value = 'e_s_disarm', override = {duration = 2}}],
			},
		],
	},
	erdyna_king_of_bandits_opening = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'add_combat_log', text = 'ERDYNA_EQUALIZER_OPENING'},
					{type = 'use_combat_skill', skill = 'erdyna_equalizer'},
					{type = 'effect', value = 'erdyna_equalizer_reserve'},
				],
			},
		],
	},
	erdyna_equalizer_reserve = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG, variables.TR_TURN_S, variables.TR_DMG],
		req_skill = false,
		conditions = [
			{type = 'owner', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = ['self.hpmax', '*0.5']}]},
		],
		tags = ['erdyna_equalizer_reserve'],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [
					{type = 'add_combat_log', text = 'ERDYNA_EQUALIZER_HALF_HP'},
					{type = 'use_combat_skill', skill = 'erdyna_equalizer'},
					{type = 'remove_all_effects', value = 'erdyna_equalizer_reserve'},
				],
			},
		],
	},
	#Battle Precognition at 3+ stacks - the bloodthrist_t5 pattern
	erdyna_precognition_grip = {
		type = 'simple',
		conditions = [{code = 'buff_number', operant = 'gte', status = 'erdyna_battle_precognition', value = 3}],
		statchanges = {resist_disarm_set = 200},
	},
	erdyna_hoarder_incisor_display = {
		type = 'simple',
		statchanges = {},
		buffs = ['b_erdyna_hoarder_incisor_display'],
	},
	erdyna_hoarder_incisor_bleed = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'owner', value = [{code = 'has_status', status = 'disarm', check = false}]},
		],
		args = {
			duration = {obj = 'self', func = 'dr', dr = 2},
			chance = {obj = 'self', func = 'chance', chance = 0.25},
		},
		sub_effects = ['bleed'],
	},
	#Hardened Grip is resist_disarm 200 - a target immune to disarm keeps hold of its buffs.
	#Most buffs are tagged 'buff', a few only 'positive': take a 'buff' when there is one.
	erdyna_hoarder_incisor_steal = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'owner', value = [{code = 'has_status', status = 'disarm', check = false}]},
			{type = 'target', value = [{code = 'is_immune', status = 'disarm', check = false}]},
			{type = 'random', value = 0.3},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'target',
				conditions = [{code = 'has_status', status = 'buff', check = true}],
				atomic = [{type = 'remove_effect', value = 'buff'}],
			},
			{
				type = 'oneshot',
				target = 'target',
				conditions = [{code = 'has_status', status = 'buff', check = false}],
				atomic = [{type = 'remove_effect', value = 'positive'}],
			},
		],
	},
	erdyna_how_could_you_display = {
		type = 'simple',
		statchanges = {},
		buffs = ['b_erdyna_how_could_you_display'],
	},
	erdyna_how_could_you = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'target', value = [{code = 'is_master', check = true}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.2}],
			},
		],
	},
	#observation
	#no 'buff'/'positive' tag: dispels must not end it without freeing the subjects
	erdyna_observing = {
		type = 'temp_s',
		target = 'target',
		stack = 'erdyna_observing',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['erdyna_observing'],
		statchanges = {evasion = 150},
		sub_effects = ['erdyna_observing_blinded', 'erdyna_observing_struck'],
		buffs = ['b_erdyna_observing'],
	},
	erdyna_observing_blinded = {
		type = 'trigger',
		trigger = [variables.TR_TURN_S, variables.TR_TURN_F, variables.TR_POST_TARG],
		req_skill = false,
		conditions = [{type = 'owner', value = [{code = 'has_status', status = 'blind', check = true}]}],
		sub_effects = ['erdyna_observation_broken'],
	},
	#a hit that also blinds is left to erdyna_observing_blinded, so the break happens once
	erdyna_observing_struck = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'owner', value = [{code = 'has_status', status = 'blind', check = false}]},
		],
		sub_effects = ['erdyna_observation_broken'],
	},
	erdyna_observation_broken = {
		type = 'oneshot',
		target = 'owner',
		atomic = [
			{type = 'add_combat_log', text = 'ERDYNA_OBSERVATION_BROKEN'},
			{type = 'remove_all_effects', value = 'erdyna_observing'},
			{type = 'use_combat_skill', skill = 'erdyna_observation_lost'},
		],
	},
	#neither debuff is tagged 'negative'/'debuff': only breaking the observation clears them
	erdyna_subject_of_observation = {
		type = 'temp_s',
		target = 'target',
		stack = 'erdyna_subject_of_observation',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['erdyna_subject_of_observation'],
		statchanges = {atk_add_part = -0.25, matk_add_part = -0.25, hitrate = -25, evasion = -25},
		buffs = ['b_erdyna_subject_of_observation'],
	},
	erdyna_evaluated = {
		type = 'temp_s',
		target = 'target',
		stack = 'erdyna_evaluated',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F],
		tags = ['erdyna_evaluated'],
		statchanges = {atk_add_part = -0.5, matk_add_part = -0.5, hitrate = -50, evasion = -50, damage_reduction = -20},
		buffs = ['b_erdyna_evaluated'],
	},
	#one instance per stack, like jd_empowerment; duration 1 that never ticks is what buff_number counts
	erdyna_battle_precognition = {
		type = 'temp_s',
		target = 'target',
		stack = 'erdyna_battle_precognition',
		tick_event = [variables.TR_NONE],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 1,
		tags = ['erdyna_battle_precognition'],
		statchanges = {atk = 20, critchance = 10, hitrate = 20, damage_reduction = 10},
		buffs = ['b_erdyna_battle_precognition'],
	},
	#skill effects
	erdyna_nail_it_aim = {
		type = 'trigger',
		trigger = [variables.TR_PREHIT],
		req_skill = true,
		conditions = [
			{type = 'target', value = [{code = 'or_list', or_list = [
				{code = 'has_status', status = 'erdyna_subject_of_observation', check = true},
				{code = 'has_status', status = 'erdyna_evaluated', check = true},
			]}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_add', stat = 'chance', value = 100}],
			},
		],
	},
	erdyna_backstreet_fragile = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'caster', value = [{code = 'has_status', status = 'disarm', check = false}]},
		],
		sub_effects = ['fragile'],
	},
	erdyna_backstreet_trophy = {
		type = 'trigger',
		trigger = [variables.TR_KILL],
		req_skill = true,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				atomic = [{type = 'effect', value = 'erdyna_battle_precognition'}],
			},
		],
	},
	erdyna_equalizer_no_miss = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_MISS]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_HIT}, {type = 'stat_mul', stat = 'value', value = 0.5}],
			},
		],
	},
	#the splash is cast at the main target: a plain follow_up would inherit the skill's own
	#target, which is Erdyna herself when King of Bandits casts it with no target
	erdyna_equalizer_splash = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		conditions = [{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'caster',
				args = {target = {obj = 'parent', func = 'arg', arg = 'target'}},
				atomic = [{type = 'use_combat_skill', skill = 'erdyna_equalizer_1', target = ['parent_args', 'target']}],
			},
		],
	},
	#e_s_taunt_new turned around: put on Erdyna, pointing at the enemy she hit. Not 'negative',
	#so her own Deceptive Ruse does not wash it off.
	erdyna_equalizer_focus = {
		type = 'temp_s',
		target = 'target',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 'arg',
		stack = 'taunt',
		tags = ['taunt', 'taunt_soft', 'erdyna_equalizer_focus'],
		buffs = ['b_erdyna_equalizer_focus'],
		args = {value = {obj = 'target', func = 'get', arg = 'id'}, focus = {obj = 'target', func = 'eq'}},
		statchanges = {taunt = ['arg', 'value']},
		sub_effects = ['erdyna_equalizer_focus_lost'],
	},
	#a soft taunt aimed at the dead leaves her AI no target at all, so the focus ends with its target
	erdyna_equalizer_focus_lost = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [{type = 'focus', value = [{code = 'stat', stat = 'hp', operant = 'lte', value = 0}]}],
		args = {focus = {obj = 'parent', func = 'arg', arg = 'focus'}},
		sub_effects = [{type = 'oneshot', target = 'self', execute = 'remove_parent'}],
	},
	#TR_CUSTOM1 is the Blood Boil tick: one more turn off at the end of a turn spent under it
	erdyna_subdued = {
		type = 'temp_s',
		target = 'target',
		stack = 'erdyna_subdued',
		tick_event = [variables.TR_TURN_F, variables.TR_CUSTOM1],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff', 'negative', 'erdyna_subdued'],
		statchanges = {hitrate = -50, damage_mod_heal = -0.75},
		sub_effects = ['erdyna_subdued_melee', 'erdyna_subdued_spell', 'erdyna_subdued_support', 'erdyna_subdued_blood_boil'],
		buffs = ['b_erdyna_subdued'],
	},
	erdyna_subdued_melee = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.0}, {type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}],
			},
		],
	},
	erdyna_subdued_spell = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'random', value = 0.25},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 0.0}, {type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}],
			},
		],
	},
	#mainly against taunts: nothing without damage lands on an enemy
	erdyna_subdued_support = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'hasno', 'damage']},
			{type = 'target', value = [{code = 'stat', stat = 'combatgroup', operant = 'eq', value = 'enemy'}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}],
			},
		],
	},
	erdyna_subdued_blood_boil = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [{type = 'owner', value = [{code = 'has_status', status = 'bloodboil', check = true}]}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'event', value = variables.TR_CUSTOM1}],
			},
		],
	},
}
var atomic_effects = {}
var buffs = {
	b_erdyna_hardy_constitution_display = {
		icon = "res://assets/images/iconsskills/shield_fire.png",
		description = "EFFECT_ERDYNA_HARDY_CONSTITUTION_DESCRIPT",
	},
	b_erdyna_draconic_constitution_display = {
		icon = "res://assets/images/iconsskills/shield_fire.png",
		description = "EFFECT_ERDYNA_DRACONIC_CONSTITUTION_DESCRIPT",
	},
	b_erdyna_king_of_bandits_display = {
		icon = "res://assets/images/iconsskills/Authority.png",
		description = "EFFECT_ERDYNA_KING_OF_BANDITS_DESCRIPT",
	},
	b_erdyna_hoarder_incisor_display = {
		icon = "res://assets/images/iconsskills/swipe.png",
		description = "EFFECT_ERDYNA_HOARDER_INCISOR_DESCRIPT",
	},
	b_erdyna_how_could_you_display = {
		icon = "res://assets/images/iconsskills/BloodMagic.png",
		description = "EFFECT_ERDYNA_HOW_COULD_YOU_DESCRIPT",
	},
	b_erdyna_observing = {
		icon = "res://assets/images/iconsskills/icon_eyes.png",
		description = "EFFECT_ERDYNA_OBSERVING",
	},
	b_erdyna_subject_of_observation = {
		icon = "res://assets/images/iconsskills/icon_hunters_mark.png",
		description = "EFFECT_ERDYNA_SUBJECT_OF_OBSERVATION",
	},
	b_erdyna_evaluated = {
		icon = "res://assets/images/iconsskills/Debilitate.png",
		description = "EFFECT_ERDYNA_EVALUATED",
	},
	b_erdyna_battle_precognition = {
		icon = "res://assets/images/iconsskills/meditate.png",
		description = "EFFECT_ERDYNA_BATTLE_PRECOGNITION",
		tags = ['show_amount'],
	},
	b_erdyna_equalizer_focus = {
		icon = "res://assets/images/iconsskills/taunt.png",
		description = "EFFECT_ERDYNA_EQUALIZER_FOCUS",
	},
	b_erdyna_subdued = {
		icon = "res://assets/images/iconsskills/Magic Shackles.png",
		description = "EFFECT_ERDYNA_SUBDUED",
	},
}
var stacks = {
	erdyna_observing = {},
	erdyna_subject_of_observation = {},
	erdyna_evaluated = {},
	#stack_c: a hard cap of 6, a seventh stack pushes the oldest out instead of waiting behind it
	erdyna_battle_precognition = {
		type = 'stack_c',
		stack = 6,
		buff = 'b_erdyna_battle_precognition',
	},
	erdyna_subdued = {},
}
