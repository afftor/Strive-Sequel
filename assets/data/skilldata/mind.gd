extends Reference

var skills = {
	mindblast = {
		code = 'mindblast',
		descript = '',
		icon = "res://assets/images/iconsskills/Mindread.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'mind'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [], #Effectdata.rebuild_template({effect = 'e_s_confuse'})
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'mind_blast', target = 'target', period = 'predamage'}], 
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
		effects = [Effectdata.rebuild_template({effect = 'stun', duration = 4})],
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'mind_shatter', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.6,
		random_factor_p = 0.1
	},
	
	abyss_gaze = {
		code = 'abyss_gaze',
		descript = '',
		icon = "res://assets/images/iconsclasses/nixx_champion.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'ads', 'mind'],
#		new_syntax = true,
		reqs = [
			{code = 'stat', stat = 'mastery_mind', value = 6, operant = 'gte'},
			{code = 'stat', stat = 'mastery_dark', value = 4, operant = 'gte'},],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'stun', duration = 2})],
		cost = {mp = 12},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.25,
		random_factor_p = 0.1
	},
}
var effects = {}
var atomic_effects = {}
var buffs = {}

var stacks = {}
