extends Reference

var skills = {
	command = {# single target buff: +25% damage for 3 turns
		code = 'command',
		descript = '',
		icon = load("res://assets/images/iconsskills/Command.png"),
		type = 'combat',
		ability_type = 'spell', 
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_command'})], 
		cost = {},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}],
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	weapon_refine = {#buffs ally: all skill damage increased by 30% until the end of combat. Only 3 times per day
		code = 'weapon_refine',
		descript = '',
		icon = load("res://assets/images/iconsskills/WeaponRefine.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_refine'})], 
		cost = {},
		charges = 3,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	firebomb = {
		code = 'firebomb',
		descript = '',
		icon = load("res://assets/images/iconsskills/FireBomb.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'fire'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_burn_new', push_characters = true, duration = 2})],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {unstable_concoction = 1},
		target = 'enemy',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = [['caster.matk','*0.5'],2],
		damagestat = ['no_stat', '+damage_hp']
	},
	euphoria_apply = {
		code = 'euphoria_apply',
		descript = '',
		icon = load("res://assets/images/iconsskills/Attract.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff', 'instant'],
		reqs = [
			{code = 'stat', stat = 'lust', operant = 'gte', value = 1},
#			{code = 'has_status', status = 'euphoria', check = false},
		],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'succubus_combat_2'})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	distract = {
		code = 'distract',
		descript = '',
		icon = load("res://assets/images/iconsskills/distract.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['debuff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_distract'})], 
		cost = {},
		chance = 100,
		evade = 0,
		charges = 0,
		combatcooldown = 2,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'debuff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	dragonmight = {#increases damage and armor by 25% until end of battle. Once in 2 days
		code = 'dragonmight',
		descript = '',
		icon = load("res://assets/images/iconsskills/Drain.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff','support'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_dragonmight'})], 
		cost = {},
		charges = 1,
		combatcooldown = 0,
		cooldown = 2,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',
		value = ['0'],
		damagestat = 'no_stat',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
	},
	revenge = {
		code = 'revenge',
		descript = '',
		icon = load("res://assets/images/iconsskills/revenge.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_revenge'], 
		cost = {mp = 5},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'weapon',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 1.7
	},
	blood_magic = {#sacrifice 10% health to get 3x mana from it, 3 charges per day 
		code = 'blood_magic',
		descript = '',
		icon = load("res://assets/images/iconsclasses/Blood_Mage.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support'],#no log for skill result - until combat reworking to different log tags for hp and mana values
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {},
		charges = 3,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'light',
		sfx = [], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = [['caster.hp','*0.1'],['caster.hp','*0.3']],
		damagestat = ['-hp', '+mp']
	},
	blood_explosion = {
		code = 'blood_explosion',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_blood_explosion.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'aoe'],
		reqs = [],
		targetreqs = [{code = 'stat', stat = 'racegroup', operant = 'neq', value = 'undead'},{code = 'stat', stat = 'racegroup', operant = 'neq', value = 'mech'}],
		effects = ['e_remove_fa'],
		cost = {mp = 25},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'normal',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 3,
		follow_up = 'blood_ex1' 
	},
	blood_ex1 = {
		code = 'blood_ex1',
		name = '',
		descript = '',
		icon = load("res://assets/images/iconsskills/firestorm.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads', 'aoe', 'not_final'],
		reqs = [],
		targetreqs = [],
		effects = [],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'nontarget',
		target_range = 'any',
		damage_type = 'normal',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.5,
		not_final = true
	},
	devour = {
		code = 'devour',
		descript = '',
		icon = load("res://assets/images/iconsclasses/soul eater.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['debuf','ads'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_devour'], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'normal',
		sfx = [{code = 'earth_spike', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = [['0']],
		damagestat = 'no_stat'
	},
	righteous_fire = { 
		code = 'righteous_fire',
		descript = '',
		icon = load("res://assets/images/iconsskills/Attack.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage', 'debuff', 'fire'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_silence1', duration = 2})], 
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 2,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'flame', target = 'target', period = 'postdamage'},
			{code = 'debuff', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.75,
	},
	spirit1 = {
		code = 'spirit1',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_hare.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_spirit1'], 
		cost = {mp = 7},
		charges = 2,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	spirit2 = {
		code = 'spirit2',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_turtle.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_spirit2'], 
		cost = {mp = 5},
		charges = 3,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	spirit3 = {
		code = 'spirit3',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_eagle.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_spirit3'], 
		cost = {mp = 5},
		charges = 2,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	bard1 = {
		code = 'bard1',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_bard1.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_bard1'], 
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	bard2 = {
		code = 'bard2',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_bard3.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_bard2'], 
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	bard3 = {
		code = 'bard3',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_bard2.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_bard3'], 
		cost = {mp = 6},
		charges = 0,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	protective_shell = {
		code = 'protective_shell',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_protective_shell.png"),
		type = 'combat',
		ability_type = 'skill', 
		tags = ['buff'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_shell'})], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 5,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}],
		sound = [],
		value = [['0']],
		damagestat = 'no_stat'
	},
	hammerfall = {
		code = 'hammerfall',
		descript = '',
		icon = load("res://assets/images/iconsskills/Heavy-Strike.png"),
		type = 'combat', 
		ability_type = 'skill',
		tags = ['damage','ads'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = Effectdata.rebuild_make_status({effect = 'e_s_stun', duration = 2})})], 
		cost = {mp = 8},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'melee',
		damage_type = 'earth',
		sfx = [{code = 'earth_spike', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'avalanche', strike = null, hit = null, hittype = 'bodyarmor'},
		value = 1.5
	},
	mirror_image = {
		code = 'mirror_image',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_mirror_image.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['noevade','support','buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_mirror'], 
		cost = {mp = 12},
		charges = 0,
		combatcooldown = 4,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'light',#not sure but not matters
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat']
	},
	energy_field = {
		code = 'energy_field',
		descript = '',
		icon = load("res://assets/images/iconsskills/icon_energy_field.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['noevade','support','buff'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_field'], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 4,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'neutral',
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['caster.matk', '*0.4']],
		damagestat = ['no_stat']
	},
	windwall = {
		code = 'windwall',
		descript = '',
		icon = load("res://assets/images/iconsskills/windwall.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['buff','support'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_windwall'})], 
		cost = {mp = 14},
		charges = 2,
		combatcooldown = 0,
		cooldown = 1,
		catalysts = {},
		target = 'ally',
		target_number = 'line',
		target_range = 'any',
		damage_type = 'weapon',
		damage = 0,
		sfx = [{code = 'buff', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = null, hit = null},
		value = ['0'],
		damagestat = 'no_stat'
	},
	void_barrage = {
		code = 'void_barrage',
		
		descript = '',
		icon = load("res://assets/images/iconsskills/barrage.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads'],
#		new_syntax = true,
		reqs = [],
		targetreqs = [],
		effects = [], 
		cost = {mp = 7},
		repeat = 5,
		keep_target = variables.TARGET_KEEPFIRST,
		next_target = variables.NT_ANY, #possibly non-implemented nt_weapon
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'weapon',
		damage_type = 'dark',
		sfx = [{code = 'targetattack', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = null, strike = 'blade', hit = null},
		value = 0.8,
	},
}
var effects = {
	#trait-based
	e_tr_hunter1 = Effectdata.rebuild_skillvalue_template({target_race = 'beast', tag = 'damage',  value = 1.15}),
	e_tr_bers1 = Effectdata.rebuild_skillvalue_template({source = 'fire', skilltype = 'skill', tag = 'damage', value = 1.2}),
	e_tr_bers2 = Effectdata.rebuild_skillvalue_template({source = 'earth', skilltype = 'skill', tag = 'damage', value = 1.2}),
	e_tr_berserk = {
		type = 'trigger',
		trigger = [variables.TR_KILL],
		reset = [variables.TR_COMBAT_F],
		req_skill = true,
		sub_effects = ['e_instant']
	},
	
	e_tr_druid = Effectdata.rebuild_skillvalue_template({source = 'earth', skilltype = 'spell', tag = 'damage', value = 1.2}),
	e_tr_sniper = Effectdata.rebuild_skillvalue_template({num_targets = 'single', skilltype = 'skill', tag = 'damage', value = 1.25}),
	
	e_tr_alios = {
		type = 'simple',
		descript = '',
		conditions = [{code = 'lone_wolf', check = true}],
		statchanges = {evasion = 50, speed = 20},
		buffs = ['b_alios'],
	},
	
	e_tr_bishop = Effectdata.rebuild_skillvalue_template({source = 'light', skilltype = 'spell', tag = 'damage', value = 1.25}),
	e_tr_bishop2 = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		reset = [],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['ability_type', 'neq', 'item']}, 
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['tags', 'hasno', 'aoe']},
			{type = 'skill', value = ['damage_type', 'eq', 'light']},
			],
		sub_effects = ['e_s_bishop']
	},
	e_s_bishop = {
		type = 'temp_global',
		tags = ['duration_turns', 'affliction'],
		target = 'target',
		name = 'Luminance',
		stack = 1,
		timers = [
			{events = [variables.TR_TURN_GET], objects = 'caster', timer = 3}, #3 turn duration
			{events = variables.TR_COMBAT_F, objects = [], timer = 1},
			{events = variables.TR_DEATH, objects = 'caster', timer = 1},
		],
		statchanges = {resist_light = -50, resist_dark = -50},
		buffs = ['b_bishop'],
	},
	
	e_tr_attendant = { 
		type = 'trigger',
		trigger = [variables.TR_CAST],
		reset = [variables.TR_TURN_GET],
		req_skill = true,
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'item']}],
		atomic = [],
		buffs = ['b_free_use'],#buff for indicating free item use, obviosly not b_stun
		sub_effects = ['e_instant']
	},
	
	e_tr_paladin_1 = Effectdata.rebuild_skillvalue_template({target_race = 'undead', tag = 'damage',  value = 1.25}),
	e_tr_paladin_2 = Effectdata.rebuild_skillvalue_template({target_race = 'demon', tag = 'damage',  value = 1.25}),
	e_tr_paladin_3 = Effectdata.rebuild_defvalue_template({target_race = 'undead', tag = 'damage',  value = 0.85}),
	e_tr_paladin_4 = Effectdata.rebuild_defvalue_template({target_race = 'demon', tag = 'damage',  value = 0.85}),
	
	e_tr_bloodmage = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'target', value = [{code = 'has_status', status = 'bleed', check = true}]}
		],
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {
					hp = {obj = 'owner', func = 'stat', stat = 'hpmax'},
					mp = {obj = 'owner', func = 'stat', stat = 'mpmax'}},
				atomic = [
					{type = 'heal', value = [['parent_args', 'hp'], '*', 0.03]},
					{type = 'mana', value = [['parent_args', 'mp'], '*', 0.03]},
					],
			},
			'e_s_bloodmage'
		],
		buffs = []
	},
	e_s_bloodmage = {
		type = 'temp_s',
		target = 'caster',
		stack = 'bloodmage_bonus',
		tick_event = [],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['positive', 'buff', 'bloodrage'],
		statchanges = {matk_add_part = 0.05},
		buffs = ['b_bloodatk'],
	},
	
	e_tr_sadist = {
		type = 'trigger',
		req_skill = true,
		trigger = [variables.TR_POSTDAMAGE],
		duration = 2,
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'skill']},
			{type = 'skill', value = ['target_range', 'eq', 'melee']},
			{type = 'random', value = 0.25}
			],
		buffs = [],
		sub_effects = ['e_s_bleed_new'], #2remake to apply status
		args = {
			duration = {obj = 'self', func = 'dr', dr = 2},
		}
	},
	
	e_tr_potion = Effectdata.rebuild_skillvalue_template({reset = [variables.TR_TURN_GET], skilltype = 'item', tag = 'heal', value = 1.25}),
	
	valkyrie_spear_bonus = {
		type = 'simple',
		conditions = [{code = 'gear_equiped', param = 'geartype', value = 'spear', check = true}],
		statchanges = {speed = 10},
	},
	
	e_tr_hide = {
		type = 'trigger',
		trigger = [variables.TR_COMBAT_S],
		conditions = [{type = 'owner', value = [
			{code = 'gear_equiped', param = 'geartype', value = 'medium', check = false},
			{orflag = true, code = 'has_status', status = 'assassin_hide', check = true},
			{code = 'gear_equiped', param = 'geartype', value = 'heavy', check = false},
		]}],
		atomic = [],
		buffs = [],
		req_skill = false,
		sub_effects = ['e_t_hide']
	},
	
	e_tr_deathknight = {
		type = 'trigger',
		trigger = [variables.TR_VICTORY],
		req_skill = false,
		conditions = [],
		sub_effects = ['e_s_deathknight'],
	},
	e_s_deathknight = {
		type = 'temp_s',
		tags = ['buff'],
		target = 'owner',
		stack = 'deathknighth',
#		stack = 5,
		req_skill = false,
		duration = 3,
		tick_event = variables.TR_TICK,
		rem_event = [variables.TR_DEATH],
		statchanges = {atk = 4, hitrate = 5, resist_normal = 2},
		buffs = ['b_deathknight'],
	},
	
	e_tr_nixx = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['damage_type', 'eq', 'dark']}
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [
					{type = 'stat_add', stat = 'chance', value = 30},
					{type = 'add_tag', value = 'nodef'},
					],
			}
		]
	},
	
	e_tr_witch1 = { #2remake properly
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_CRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
		],
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		args = {
			duration = {obj = 'self', func = 'dr', dr = 1},
		},
		sub_effects = [],
		modal_sub_effects = ['e_s_burn_new', 'e_s_poison_new', 'e_s_bleed_new', 'e_s_blind', 'e_s_stun', 'e_s_confuse', 'e_s_sleep_compartibility'],
	},
	e_tr_witch2 = { #2remake properly
		type = 'trigger',
		conditions = [
			{type = 'random', value = 0.5},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['tags', 'has', 'heal']},
		],
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		args = {
			duration = {obj = 'self', func = 'dr', dr = 2},
		},
		sub_effects = [],
		modal_sub_effects = ['e_s_rejuvenation', 'e_s_mward2'],
	},
	
	e_tr_warlock = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['tags', 'hasno', 'aoe']},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [
					{type = 'stat_add', stat = 'critchance', value = 25},
					{type = 'stat_add', stat = 'critmod', value = 0.75},
					],
			}
		]
	},
	
	succubus_passive = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'stat_add', stat = 'lust', value = ['random', 1, 3]},],
			}
		]
	},
	
	e_tr_templar = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'taunt']},
		],
		sub_effects = ['e_s_templar']
	},
	e_s_templar = {
		type = 'temp_s',
		tags = ['buff'],
		target = 'owner',
		stack = 'templar_prot',
		req_skill = false,
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		args = {
			armor = {obj = 'owner', func = 'stat', stat = 'armor'},
			duration = {obj = 'self', dunc = 'dur', dur = 3}
			},
		sub_effects = ['e_tr_templar_heal'],
		statchange = {mdef = [['arg', 'armor'], '*', 0.5]},
		buffs = ['b_templar'],
	},
	e_tr_templar_heal = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {value = {obj = 'owner', func = 'stat', stat = 'hpmax'}},
				atomic = [
					{type = 'heal', value = [['parent_args', 'value'], '*', 0.1]},
					],
			},
		]
	},
	#skill-based
	e_t_command = {
		type = 'temp_s',
		target = 'target',
		stack = 'command',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		tags = ['buff'],
		statchanges = {atk_add_part = 0.5, matk_add_part = 0.5},
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Trainer.png",
				description = "TRAITEFFECTCOMMANDED",
			}
		],
	},
	e_t_refine = {
		type = 'temp_s',
		target = 'target',
		stack = 'refine',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff'],
		statchanges = {atk_add_part = 0.3},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/WeaponRefine.png",
				description = "TRAITEFFECTREFINE",
			}
		],
	},
	succubus_combat_2 = {
		type = 'temp_s',
		stack = 'euphoria',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		target = 'caster',
		tags = ['euphoria'],
		sub_effects = ['euphoria_passive'],
		args = {lust = {obj = 'owner', dynamic = true, func = 'stat', stat = 'lust'}},
		statchanges = {
			atk_add_part = [['arg', 'lust'],'*',0.005],
			matk_add_part = [['arg', 'lust'],'*',0.005]
			},
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Fighter.png",
				description = "EUPHORIABUFF", #fix
				bonuseffect = 'lust',
				tags = ['combat_only'],
			}
		],
	},
	euphoria_passive = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				atomic = [{type = 'stat_add', stat = 'lust', value = ['random', -6, -4]},],
			},
			{
				type = 'oneshot',
				target = 'owner',
				conditions = [{code = 'stat', stat = 'lust', operant = 'lte', value = 0}],
				atomic = [{type = 'remove_effect', value = 'euphoria'},],
			}
		]
	},
	e_t_distract = {
		type = 'temp_s',
		target = 'target',
		stack = 'distract',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 2,
		tags = ['debuff'],
		statchanges = {evasion = -30, hitrate = -30},
		buffs = ['b_distract'],
	},
	e_t_dragonmight = {
		type = 'temp_s',
		target = 'target',
		stack = 'dragonmight',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['buff'],
		statchanges = {damage_mod_all = 0.25, armor_mul = 1.25},
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Dragon_Knight.png",
				description = "TRAITEFFECTDRAGONSMIGHT",
			}
		],
	},
	e_s_revenge = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_HIT],
		req_skill = true,
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = {
					hp = {obj = 'caster', func = 'stat', stat = 'hp'},
					hpmax = {obj = 'caster', func = 'stat', stat = 'hpmax'}
					},
				atomic = [{type = 'stat_mul', stat = 'value', value = [['parent_args', 'hp'], '/', ['parent_args', 'hpmax'], '*', -3, '+', 4.0]}],
			},
		],
	},
	e_s_devour = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_devour'],
	},
	e_t_devour = {
		type = 'temp_s',
		tags = ['negative'],
		target = 'target',
		stack = 'devour',
		rem_event = [variables.TR_COMBAT_F],
		buffs = [{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTDEVOUR",
				limit = 1,
				t_name = 'devour',
			}],
		args = {
			caster = {obj = 'caster', func = 'eq'},
			caster_mpmax = {obj = 'caster', func = 'stat', stat = 'mpmax'}
		},
		sub_effects = ['e_tr_devour']
	},
	e_tr_devour = {
		type = 'trigger',
		trigger = [variables.TR_DEATH],
		conditions = [],
		req_skill = false,
		args = {
			caster = {obj = 'parent', func = 'arg', arg = 'caster'},
			caster_mpmax = {obj = 'parent', func = 'arg', arg = 'caster_mpmax'}
		},
		sub_effects = [
			{
				type = 'oneshot',
				target = 'arg_caster',
				args = {
					arg_caster = {obj = 'parent', func = 'arg', arg = 'caster'},
					caster_mpmax = {obj = 'parent', func = 'arg', arg = 'caster_mpmax'}
				},
				atomic = [
					{type = 'mana', value = [['parent_args', 'caster_mpmax'], '*', 0.2]}
					]
			}
		],
	},
	e_s_spirit1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_spirit1'],
	},
	e_s_spirit2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_spirit2'],
	},
	e_s_spirit3 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_spirit3'],
	},
	e_t_spirit1 = {
		type = 'temp_s',
		target = 'target',
		stack = 'spirit',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['spirit'],
		statchanges = {evasion = 25, speed = 30}, 
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTSPIRIT1",
				tags = ['combat_only'],
			}
		],
	},
	e_t_spirit3 = {
		type = 'temp_s',
		target = 'target',
		stack = 'spirit',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['spirit'],
		sub_effects = [],
		statchanges = {damage_mod_skill = 0.2, hitrate = 30}, 
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTSPIRIT3",
				tags = ['combat_only'],
			}
		],
	},
	e_t_spirit2 = {
		type = 'temp_s',
		target = 'target',
		stack = 'spirit',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['spirit'],
		sub_effects = ['e_t_turtle1', 'e_t_turtle2'],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTSPIRIT2",
				tags = ['combat_only'],
			}
		],
	},
	e_t_turtle1 = Effectdata.rebuild_defvalue_template({tag = 'damage', skilltype = 'skill', value = 0.85}),
	e_t_turtle2 = Effectdata.rebuild_defvalue_template({tag = 'damage', skilltype = 'spell', value = 0.85}),
	e_s_bard1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_bard1'],
	},
	e_s_bard2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_bard2'],
	},
	e_s_bard3 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_bard3'],
	},
	e_t_bard1 = {
		type = 'temp_s',
		target = 'target',
		stack = 'bard',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		statchanges = {speed = 20, hitrate = 20, evasion = 20}, 
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "TRAITEFFECTBARD1",
				tags = ['combat_only'],
			}
		],
	},
	e_t_bard3 = {
		type = 'temp_s',
		target = 'target',
		stack = 'bard',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		statchanges = {atk_add_part = 0.2, matk_add_part = 0.2}, 
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "TRAITEFFECTBARD3",
				tags = ['combat_only'],
			}
		],
	},
	e_t_bard2 = {
		type = 'temp_s',
		target = 'target',
		stack = 'bard',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = ['e_bards_clean'],
		statchanges = {armor = 15, mdef = 15}, 
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "TRAITEFFECTBARD2",
				tags = ['combat_only'],
			}
		],
	},
	e_bards_clean = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		conditions = [],
		req_skill = false,
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			atomic = [{type = 'remove_effect', value = 'negative'}]
		}],
	},
	e_t_shell = {
		type = 'temp_s',
		tags = ['buff', 'positive'],
		target = 'target',
		duration = 4,
		stack = 'protective_shell',
		tick_event = variables.TR_POST_TARG,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_shell'],
		sub_effects = ['e_t_shell1']
	},
	e_t_shell1 = Effectdata.rebuild_defvalue_template({tag = 'damage', value = 0.65}),
	e_s_mirror = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_mirror'],
	},
	e_t_mirror = {
		type = 'temp_s',
		tags = ['reflection', 'buff'],
		target = 'target',
		duration = 2,
		stack = 'reflection',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_mirror'],
		sub_effects = ['e_t_mirror1']
	},
	e_t_mirror1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['damage_type', 'neq', 'mind'] },
			{type = 'random', value = 0.25}
		],
		req_skill = true,
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}]
		}],
	},
	e_s_field = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		sub_effects = ['e_t_field'],
	},
	e_t_field = {
		type = 'temp_s',
		tags = ['reflection', 'buff'],
		target = 'target',
		duration = 2,
		stack = 'reflection',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_field'],
		args = {value = {obj = 'skill', func = 'get', arg = 'process_value'}},
		sub_effects = ['e_t_field1']
	},
	e_t_field1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'random', value = 0.5}
		],
		req_skill = true,
		args = {value = {obj = 'parent', func = 'arg', arg = 'value'}},
		sub_effects = [{
			type = 'oneshot',
			target = 'caster',
			args = {
				damage = {obj = 'parent', func = 'arg', arg = 'value'},
				src = {obj = 'self', func = 'src', src = 'air'}
				},
			atomic = [
				{type = 'sfx', value = 'targetattack'},
				'a_damage_simple']
		}],
	},
	e_s_windwall = {
		type = 'temp_s',
		duration = 4,
		stack = 'windwall',
		target = 'target',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		statchanges = {resist_damage_ranged = 0.5},
		buffs = [{
			icon = "res://assets/images/iconsskills/windwall.png",
			description = "TRAITEFFECTWINDWALL",
		}]
	},
	
	e_we_dark_static = {
		type = 'simple',
		statchanges = {damagetype = 'dark'},
		buffs = [{
			icon = "res://assets/images/iconsclasses/deathknight.png",
			description = "TRAITDARKWEAPON",
		}]
	},
}
var atomic_effects = {}
var buffs = {
	b_alios = {
		icon = "res://assets/images/iconsskills/hitrate.png",
		description = "BUFFDESCRIPTALIOSACTIVE",
		tags = ['combat_only'],
	},
	b_bishop = {
		icon = "res://assets/images/iconsclasses/Bishop.png",
		description = "BUFFDESCRIPTBISHOP",
		tags = ['combat_only'],
	},
	b_templar = {
		icon = "res://assets/images/iconsclasses/Templar.png",
		description = "BUFFDESCRIPTTEMPLAR",
		tags = ['combat_only'],
	},
	b_deathknight = {
		icon = "res://assets/images/iconsclasses/deathknight.png",
		description = "BUFFDESCRIPTDEATHKNIGHT",
		tags = ['show_amount']
	},
	b_free_use = {
		icon = "res://assets/images/iconsclasses/Attendant.png",
		description = "BUFFDESCRIPTFREEUSE",
		tags = ['combat_only'],
	},
	b_distract = {
		icon = "res://assets/images/iconsskills/distract.png",
		description = "BUFFDESCRIPTDISTRACT",
	},
	b_bloodatk = {
		icon = "res://assets/images/iconsskills/hitrate.png",
		description = "BUFFDESCRIPTBLOODATTACK",
		tags = ['combat_only'],
	},
	b_field = {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "BUFFDESCRIPTFIELD", 
	},
	b_shell = {
		icon = "res://assets/images/traits/hitrate.png",
		description = "BUFFDESCRIPTSHELL",
	},
}

var stacks = {
	bloodmage_bonus = {
		type = 'stack',
	},#st unlim
	templar_prot = {},#st 1
	command = {},#st 1
	refine = {},#st 1
	distract = {},#st 1
	dragonmight = {},#st 1
	windwall = {},#st 1
	devour = {},#st 1
	spirit = {},#st 1
	bard = {},#st 1
	reflection = {},#st 1
	protective_shell = {},#st 1
	deathknight = {
		type = 'stack_c',
		stack = 5
	},#st increment lim 5
	euphoria = {
		type = 'stack_t',
		stack = 1
	},#toggle
}
