extends Reference

var skills = {
	first_aid = {#heals target for 30%
		code = 'first_aid',
		descript = '',
		icon = "res://assets/images/iconsskills/HealBandage.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['heal', 'noreduce', 'noevade','support', 'exploration'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('bleed')}),Effectdata.rebuild_template({effect = Effectdata.rebuild_remove_effect('poison_new')})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {bandage = 1},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['target.hpmax','*0.30']],
		damagestat = ['-damage_hp']
	},
	inspire = {
		code = 'inspire',
		descript = '',
		icon = "res://assets/images/iconsskills/Inspire.png",
		type = 'combat',
		ability_type = 'spell',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_inspire'})], 
		cost = {},
		charges = 1,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}],
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	leadersmark = { 
		code = 'leadersmark',
		descript = '',
		icon = "res://assets/images/iconsskills/Command.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['debuff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_hmark', duration = 3})], 
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.7,
	},
	rally = {
		code = 'rally',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_rally.png",
		type = 'combat', 
		ability_type = 'skill',
		tags = ['heal', 'noreduce', 'noevade','support'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_rally'})], 
		cost = {mp = 15},
		charges = 0,
		combatcooldown = 5,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['target.hpmax','*0.30']],
		damagestat = ['restore_mana']
	},
}
var effects = {
	e_t_inspire = {
		type = 'temp_s',
		target = 'target',
		stack = 'inspire',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff'],
		statchanges = {damage_mod_all = 0.2, armor_add_part = 0.2, mdef_add_part = 0.2},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Inspire.png",
				description = "TRAITEFFECTINSPIRED",
			}
		],
	},
	e_s_hmark = { #has troubles with protect effect
		type = 'temp_s',
		target = 'target',
		stack = 'huntersmark',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['debuff'],
		sub_effects = ['e_t_hmark'],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Command.png",
				description = "TRAITEFFECTHMARK",
			}
		],
	},
	e_t_hmark = Effectdata.rebuild_defvalue_template({tag = 'damage', value = 1.15}),
	e_t_rally = {
		type = 'oneshot',
		target = 'target',
		atomic = [{type = 'reset_cooldowns'}],
	}
}
var atomic_effects = {}
var buffs = {}

var stacks = {
	inspire = {},#st 1
	huntersmark = {},#st 1
}
