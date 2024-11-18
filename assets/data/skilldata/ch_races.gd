extends Reference

var skills = {
	fairy_heal = {#heals target for 50%
		code = 'fairy_heal',
		descript = '',
		icon = load("res://assets/images/iconsskills/fairy_heal.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 8},
		charges = 1,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['target.hpmax','*0.5']],
		damagestat = ['-damage_hp']
	},
	entangle = {#dryad skill
		code = 'entangle',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_plant.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_stun'})], 
		cost = {mp = 5},
		charges = 2,
		combatcooldown = 3,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'earth',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.3
	},
}
var effects = {}
var atomic_effects = {}
var buffs = {}
