extends Reference

var skills = {
	mass_ward = {
		code = 'mass_ward',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support', 'aoe', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'ward'}), Effectdata.rebuild_template_globals({effect = 'warded'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all_allowed',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
	mass_ward_d = {
		code = 'mass_ward_d',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support', 'aoe', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'd_ward'}), Effectdata.rebuild_template_globals({effect = 'd_warded'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all_allowed',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
	single_ward = {
		code = 'single_ward',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'ward'}), Effectdata.rebuild_template_globals({effect = 'warded'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
	single_ward_d = {
		code = 'single_ward_d',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'd_ward'}), Effectdata.rebuild_template_globals({effect = 'd_warded'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
	#anchored
	ward_anchored = {
		code = 'ward_anchored',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/light_spell_aoe.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = [ 'noevade','noreduce','support', 'aoe', 'passive'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'ward'}), Effectdata.rebuild_template_globals({effect = 'warded', target_status = 'ward_anchor'})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all_allowed',
		target_range = 'not_caster',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['0']],
		damagestat = 'no_stat'
	},
}
var effects = {
	warded = {
		type = 'temp_global',
		tags = ['duration_none', 'warded'],
		target = 'target',
		name = 'warded',
		stack = 0,
		timers = [
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		buffs = ['b_warded'],
	},
	ward = {
		type = 'temp_s',
		target = 'caster',
		stack = 'ward',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['ward'],
		buffs = ['b_ward'],
	},
	d_warded = {
		type = 'temp_global',
		tags = ['duration_none', 'd_warded'],
		target = 'target',
		name = 'd_warded',
		stack = 0,
		timers = [
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		buffs = ['b_warded_d'],
	},
	d_ward = {
		type = 'temp_s',
		target = 'caster',
		stack = 'ward_d',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['ward_d'],
		buffs = ['b_ward'],
	},
	
	#anchoring template
	ward_anchor = {
		type = 'static',
		tags = ['ward_anchor'],
	},
	
	
	setup_ward_test = Effectdata.rebuild_autocast({skill = 'mass_ward', trigger = [variables.TR_COMBAT_S]}),
}
var atomic_effects = {}
var buffs = {
	b_warded = {
		icon = "res://assets/images/traits/hitrate.png",#2fix
		description = "BUFFDESCRIPTWARDED",
		limit = 1,
		t_name = 'warded'
	},
	b_ward = {
		icon = "res://assets/images/traits/hitrate.png",#2fix
		description = "BUFFDESCRIPTWARD",
		limit = 1,
		t_name = 'ward'
	},
	b_warded_d = {
		icon = "res://assets/images/traits/hitrate.png",#2fix
		description = "BUFFDESCRIPTDWARDED",
		limit = 1,
		t_name = 'd_warded'
	},
}

var stacks = {
	ward = {}, #st 1
	ward_d = {}, #st 1
}
