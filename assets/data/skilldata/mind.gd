extends Reference

var skills = {
	mindblast = {
		code = 'mindblast',
		descript = '',
		icon = "res://assets/images/iconsskills/slash.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'mind'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [], #Effectdata.rebuild_template({effect = 'e_s_confuse'})
		cost = {},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.2,
		random_factor_p = 0.1
	},
	mindshatter = {
		code = 'mindshatter',
		descript = '',
		icon = "res://assets/images/iconsskills/Mindblast.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'mind'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_stun1', duration = 4})],
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.6,
		random_factor_p = 0.1
	},
}
var effects = {}
var atomic_effects = {}
var buffs = {}
