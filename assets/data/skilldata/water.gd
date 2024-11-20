extends Reference

var skills = {
	rejuvenation = {
		code = 'rejuvenation',
		descript = '',
		icon = "res://assets/images/iconsskills/Heal.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_regen', push_value = true, duration = 2})], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',#not sure but not matters
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.matk', '*0.6'], ['caster.matk']],
		damagestat = ['no_stat','-damage_hp'],
		variations = [
			{
				reqs = [{code = 'stat', stat = 'mastery_water', value = 4, operant = 'gte'}],
				set = {target_number = 'row'},
				add = {descript = '_2'}
			}
		]
	},
	water_edge = {
		code = 'water_edge',
		descript = '',
		icon = "res://assets/images/iconsskills/wateredge.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'debuf', 'water'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_wet'})], 
		cost = {mp = 3},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'water',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = 1.0,
	},
	water_shield = {
		code = 'water_shield',
		descript = '',
		icon = load("res://assets/images/iconsskills/Barrier.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_watershield', duration = 5})], 
		cost = {mp = 8},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'water',#not sure but not matters
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		variations = [
			{
				reqs = [{code = 'stat', stat = 'mastery_fire', value = 4, operant = 'eq'}],
				set = {target_number = 'line'},
				add = {descript = '_1'}
			},
			{
				reqs = [{code = 'stat', stat = 'mastery_fire', value = 5, operant = 'gte'}],
				set = {target_number = 'all'},
				add = {descript = '_2'}
			},
		]
	},
	frost_prison = {
		code = 'frost_prison',
		descript = '',
		icon = "res://assets/images/iconsskills/Barrier.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'debuf', 'water', 'kill_animation_ice'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = Effectdata.rebuild_make_status({effect = 'e_s_freeze1', chance = 0.5, duration = 1})})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'water',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = 1.3,
	},
	clarity = {
		code = 'clarity',
		descript = '',
		icon = "res://assets/images/iconsskills/Mindread.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_clarity'], 
		cost = {mp = 7},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',#not sure but not matters
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	blizzard = {
		code = 'blizzard',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_ice.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'debuf', 'water', 'aoe', 'kill_animation_ice'],
		reqs = [],
		targetreqs = [],
		effects = [
			'e_t_blizzard',
			Effectdata.rebuild_template({effect = Effectdata.rebuild_make_status({effect = 'e_s_freeze1', chance = 0.25, duration = 1})})
			], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 2,
		chance = 60,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'water',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = 0.9,
	},
	hailstorm = {
		code = 'hailstorm',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_hailstorm.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'debuf', 'water', 'aoe','kill_animation_ice'],
		reqs = [],
		targetreqs = [],
		effects = [
			Effectdata.rebuild_skillvalue_template({target_status = 'wet', value = 1.5}),
			Effectdata.rebuild_skillvalue_template({target_status = 'freeze', value = 2.0/1.25}),
			Effectdata.rebuild_template({effect = 'e_s_wet'})
			], 
		cost = {mp = 16},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'water',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = 1.5,
	},
}
var effects = {
	e_t_watershield = {
		type = 'temp_s',
		target = 'target',
		name = 'watershield',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		args = [],
		tags = ['buff'],
		sub_effects = [
			Effectdata.rebuild_stat_bonus('resist_fire', 40),
		],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png",
				description = "TRAITEFFECTWATERSHIELD",
				limit = 1,
				t_name = 'watershield'
			}
		],
	},
	e_s_clarity = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [], 
		sub_effects = [
			Effectdata.rebuild_remove_effect('blind'),
			Effectdata.rebuild_remove_effect('sleep'),
			Effectdata.rebuild_remove_effect('charm'),
			'e_t_clarity'
			],
		buffs = []
	},
	e_t_clarity = {
		type = 'temp_s',
		target = 'target',
		name = 'clarity',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 4,
		stack = 1,
		args = [],
		tags = ['buff'],
		sub_effects = [
			Effectdata.rebuild_stat_bonus('matk', 0.25, null, 'stat_add_p'),
			Effectdata.rebuild_stat_bonus('resist_blind', 200),
			Effectdata.rebuild_stat_bonus('resist_sleep', 200),
			Effectdata.rebuild_stat_bonus('resist_charm', 200),
		],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Mindread.png",
				description = "TRAITEFFECTCLARITY",
				limit = 1,
				t_name = 'clarity'
			}
		],
	},
	e_t_blizzard = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_PREHIT],
		conditions = [{type = 'target', value = [{code = 'has_status', check = true, status = 'wet'}, {orflag = true, code = 'has_status', check = true, status = 'freeze'}]}],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_set', stat = 'chance', value = 200}],
				buffs = [],
				sub_effects = []
			}
		]
	}
}
var atomic_effects = {}
var buffs = {}
