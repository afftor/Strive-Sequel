extends Reference

var skills = {
	healing = {
		code = 'healing',
		descript = '',
		icon = "res://assets/images/iconsskills/restoration.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = 1.3,
		damagestat = ['-damage_hp']
	},
	blessing = {
		code = 'blessing',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_light.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_blessing'], 
		cost = {mp = 6},
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
		value = [['0']],
		damagestat = ['no_stat'],
	},
	resurrect = {
		code = 'resurrect',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_reincarnation.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['resurrect', 'noevade','noreduce','support'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_res', push_value = true})], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'dead',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['40']],
		damagestat = 'no_stat'
	},
	elemental_protection = { 
		code = 'elemental_protection',
		descript = '',
		icon = "res://assets/images/iconsskills/icon_elemental_protection.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_elprotect', duration = 3})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',#'line'
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = [['0']],
	},
	pacify = {
		code = 'pacify',
		descript = '',
		icon = "res://assets/images/iconsskills/Serve2.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'ads', 'light'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_disarm3', duration = 2})], 
		cost = {mp = 7},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'water_attack', target = 'target', period = 'predamage'}],#? 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.3
	},
	sanctuary = {
		code = 'sanctuary',
		descript = '',
		icon = "res://assets/images/iconsskills/sanctuary.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_regen', push_value = true, duration = 3})], 
		cost = {mp = 15}, 
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',#not sure but not matters
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.matk', '*1.2'], ['caster.matk', '*0.8']],
		damagestat = ['no_stat','-damage_hp']
	},
	radiance = {
		code = 'radiance',
		descript = '',
		icon ="res://assets/images/iconsskills/light_spell.png" ,
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'aoe', 'light'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template_globals({effect = 'e_s_shatter3'})], 
		cost = {mp = 9},
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',
		aipatterns = ['attack'],
		allowedtargets = ['enemy'],
		value = 0.8,
		random_factor_p = 0.1,
		sfx = [{code = 'weapon', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
	},
	mass_resurrect = {
		code = 'mass_resurrect',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['heal', 'noreduce', 'noevade','support', 'aoe'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 25},
		charges = 0,
		combatcooldown = 0,
		cooldown = 6,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['target.hpmax','*0.80']],
		damagestat = ['-damage_hp'],
		follow_up = 'mass_resurrect_1' 
	},
	mass_resurrect_1 = {
		code = 'mass_resurrect_1',
		name = '',
		descript = '',
		icon = load("res://assets/images/iconsskills/firestorm.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['resurrect', 'noevade','noreduce','support', 'aoe', 'not_final'],
		reqs = [],
		targetreqs = [{code = 'trait', trait = 'undead', check = false}],
		effects = [Effectdata.rebuild_template({effect = 'e_res', push_value = true})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all_allowed',
		target_range = 'dead',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['80']],
		damagestat = 'no_stat',
		not_final = true
	},
}
var effects = {
	e_s_blessing = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [], 
		sub_effects = [
			Effectdata.rebuild_remove_effect('fear'),
			Effectdata.rebuild_remove_effect('ensnared'),
			Effectdata.rebuild_remove_effect('blind'),
			Effectdata.rebuild_remove_effect('cursed'),
			'e_t_blessing'
			],
		buffs = []
	},
	e_t_blessing = {
		type = 'temp_s',
		target = 'target',
		name = 'blessing',
		tick_event = variables.TR_TURN_S,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 5,
		stack = 1,
		args = [],
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = 35},
			{type = 'stat_add', stat = 'evasion', value = 35},
		],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png",
				description = "TRAITEFFECTBLESSING",
				limit = 1,
				t_name = 'blessing'
			}
		],
	},
	e_s_elprotect = {
		type = 'temp_s',
		target = 'target',
		name = 'elprotect',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_fire', value = 20},
			{type = 'stat_add', stat = 'resist_earth', value = 20},
			{type = 'stat_add', stat = 'resist_water', value = 20},
			{type = 'stat_add', stat = 'resist_air', value = 20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTELEMENTALPROTECT",
				limit = 1,
				t_name = 'elweak',
				combat_only = true,
			}
		],
	},
}
var atomic_effects = {
	a_sanctuary_heal = {type = 'heal', value = ['parent_args', 0]},
}
var buffs = {}