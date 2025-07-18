extends Reference
#temporal
#don't forget to make separate category in ch_skills
var skills = {
	flame_sphere = {
		code = 'flame_sphere',
		descript = '',
		icon = "res://assets/images/iconsskills/firestorm.png",
		type = 'exploration', 
		ability_type = 'spell',
		tags = ['support', 'exploration', 'fire'],
		reqs = [],
		targetreqs = [],
		effects =  [Effectdata.rebuild_template({effect = 'e_tr_flamesphere', trigger = variables.TR_EXPLORE_POSTDAMAGE})], 
		cost = {mp = 5},
		charges = 4,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	pas_flamesphere = { 
		code = 'pas_flamesphere',
		descript = '',
		icon = "res://assets/images/iconsskills/firestorm.png",
		type = 'auto', 
		ability_type = 'spell',
		tags = ['aoe', 'damage', 'fire', 'instant'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'nontarget_group',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'flame', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'absolute'},
		value = [['target.hpmax','*0.25']],
		not_final = true
	},
	invigorate = { #sure need to rework to proper scene report
		code = 'invigorate',
		descript = '',
		icon = load("res://assets/images/iconsskills/Heal.png"),
		type = 'exploration', 
		ability_type = 'spell',
		tags = ['support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 12},
		charges = 2,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['-1'],['-1'],['-1'],['-1']],
		damagestat = ['chg_strength','chg_dexterity','chg_wisdom','chg_persuasion'],
	},
	wind_whispers = { 
		code = 'wind_whispers',
		descript = '',
		icon = "res://assets/images/iconsskills/meditate.png",
		type = 'exploration', 
		ability_type = 'spell',
		tags = ['support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'setup_reveal', trigger = variables.TR_EXPLORE_POSTDAMAGE})], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	intimidating_presence = { 
		code = 'intimidating_presence',
		descript = '',
		icon = "res://assets/images/iconsskills/Fear.png",
		type = 'exploration', 
		ability_type = 'spell',
		tags = ['support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'setup_intimidate', trigger = variables.TR_EXPLORE_POSTDAMAGE})], 
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	natures_gift = { 
		code = 'natures_gift',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_natures_gift.png",
		type = 'exploration', 
		ability_type = 'spell',
		tags = ['support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'setup_gather', trigger = variables.TR_EXPLORE_POSTDAMAGE})], 
		cost = {mp = 10},
		charges = ['caster.mastery_earth', '0.66'],
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	teleport = { 
		code = 'teleport',
		descript = '',
		icon = load("res://assets/images/iconsskills/Heal.png"),
		type = 'exploration', 
		ability_type = 'spell',
		tags = ['support', 'exploration'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'setup_teleport', trigger = variables.TR_EXPLORE_POSTDAMAGE})], 
		cost = {mp = 15},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'mind',
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
}
var effects = {
	e_tr_flamesphere = {
		type = 'temp_s',
		target = 'caster',
		stack = 'flamesphere',
		rem_event = [variables.TR_TURN_GET, variables.TR_DEATH, variables.TR_TICK],
		sub_effects = [
			{
				type = 'trigger',
				conditions = [],
				trigger = [variables.TR_COMBAT_S],
				req_skill = false,
				sub_effects = [
					{
						type = 'oneshot',
						target = 'owner',
						atomic = [{type = 'use_combat_skill', skill = 'pas_flamesphere'}]
					}
				],
			},
		],
		atomic = [],
		buffs = ['b_flamesphere'],
	},
	setup_reveal = {
		type = 'oneshot',
		target = 'caster',
		atomic = [{type = 'dungeon_effect', value = 'reveal_map'}]
	},
	setup_gather = {
		type = 'oneshot',
		target = 'caster',
		atomic = [{type = 'location_effect', value = 'gather_res'}]
	},
	setup_intimidate = {
		type = 'oneshot',
		target = 'caster',
		atomic = [{type = 'dungeon_effect', value = 'set_intimidate'}]
	},
	setup_teleport = {
		type = 'oneshot',
		target = 'caster',
		atomic = [{type = 'location_effect', value = 'set_teleport'}]
	},
}
var atomic_effects = {}
var buffs = {
	b_flamesphere = {
		icon = "res://assets/images/iconsskills/firestorm.png",
		description = "BUFFDESCRIPTFLAMESPHERE",
		t_name = 'flamesphere'
	},
}

var stacks = {
	flamesphere = {}, #st1
}
