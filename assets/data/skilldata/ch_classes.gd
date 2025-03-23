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
		cost = {},
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
		cost = {},
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
		cost = {},
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
		cost = {},
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
		cost = {},
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
		cost = {},
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
		effects = [Effectdata.rebuild_template({effect = Effectdata.rebuild_make_status({effect = 'e_s_stun1', duration = 2})})], 
		cost = {},
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
		cost = {},
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
		cost = {},
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
		cost = {},
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
		cost = {},
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
		conditions = [],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'setup_instant'}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	
	e_tr_druid = Effectdata.rebuild_skillvalue_template({source = 'earth', skilltype = 'spell', tag = 'damage', value = 1.2}),
	
	e_tr_sniper = Effectdata.rebuild_skillvalue_template({num_targets = 'single', skilltype = 'skill', tag = 'damage', value = 1.25}),
	
	e_tr_alios = {
		type = 'c_static',
		descript = '',
		conditions = [{code = 'lone_wolf', check = true}],
		tags = ['recheck_combat', 'recheck_death'],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = 50},
			{type = 'stat_add', stat = 'speed', value = 20},
			],
		buffs = ['b_alios'],
		sub_effects = [],
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
		atomic = [],
		buffs = [],#'b_power_pot'],
		args = [{obj = 'skill', param = 'caster', dynamic = true}, {obj = 'skill', param = 'target', dynamic = true}],
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
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_light', value = -50},
			{type = 'stat_add', stat = 'resist_dark', value = -50},
			],
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
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'setup_instant'}],
				buffs = [],
				sub_effects = []
			}
		]
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
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}, {obj = 'app_obj', param = 'mpmax'}],
				atomic = [
					{type = 'heal', value = [['parent_args', 0], '*', 0.03]},
					{type = 'mana', value = [['parent_args', 1], '*', 0.03]},
					],
				buffs = [],
				sub_effects = []
			},
			'e_s_bloodmage'
		],
		buffs = []
	},
	e_s_bloodmage = {
		type = 'temp_s',
		target = 'caster',
		name = 'bloodmage_bonus',
		stack = 0,
		tick_event = [],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tags = ['positive', 'buff', 'bloodrage'],
		args = [],
		sub_effects = [],
		atomic = [{type = 'stat_add_p', stat = 'matk', value = 0.05}],
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
		sub_effects = ['e_s_bleed_new'],
		args = [{obj = 'app_obj'}, {obj = 'app_obj'}]
	},
	
	e_tr_potion = {
		type = 'trigger',
		trigger = [variables.TR_HIT],
		reset = [variables.TR_TURN_GET],
		req_skill = true,
		conditions = [{type = 'skill', value = ['ability_type', 'eq', 'item']}, {type = 'skill', value = ['tags', 'has', 'heal']}],
		atomic = [],
		buffs = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [{type = 'stat_mul', stat = 'value', value = 1.25}],
				buffs = [],
				sub_effects = []
			}
		]
	},
	
	valkyrie_spear_bonus = {
		type = 'c_static',
		conditions = [{code = 'gear_equiped', param = 'geartype', value = 'spear', check = true}],
		tags = ['recheck_item'],
		atomic = [
			{type = 'stat_add', stat = 'speed', value = 10},
		],
		buffs = [],
		sub_effects = [],
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
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = ['e_s_deathknight'],
	},
	e_s_deathknight = {
		type = 'temp_inc',
		tags = ['buff'],
		target = 'owner',
		name = 'deathknighth_b',
		stack = 5,
		req_skill = false,
		duration = 3,
		tick_event = variables.TR_TICK,
		rem_event = [variables.TR_DEATH],
		args = [],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'atk', value = 4},
			{type = 'stat_add', stat = 'hitrate', value = 5},
			{type = 'stat_add', stat = 'resist_normal', value = 2},
		],
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
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [],
				atomic = [
					{type = 'stat_add', stat = 'chance', value = 30},
					{type = 'add_tag', value = 'nodef'},
					],
				buffs = [],
				sub_effects = []
			}
		]
	},
	
	e_tr_witch1 = {
		type = 'trigger',
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_CRIT]},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['tags', 'has', 'damage']},
		],
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		duration = 1,
		args = [{obj = 'skill', param = 'target', dynamic = true}, {obj = 'skill', param = 'caster', dynamic = true}],
		sub_effects = [],
		modal_sub_effects = ['e_s_burn_new', 'e_s_poison_new', 'e_s_bleed_new', 'e_s_blind', Effectdata.rebuild_make_status({effect = 'e_s_stun1', duration = 1}), 'e_s_confuse', 'e_s_sleep_compartibility'],
		buffs = []
	},
	e_tr_witch2 = {
		type = 'trigger',
		conditions = [
			{type = 'random', value = 0.5},
			{type = 'skill', value = ['ability_type', 'eq', 'spell']},
			{type = 'skill', value = ['tags', 'has', 'heal']},
		],
		trigger = [variables.TR_POSTDAMAGE],
		req_skill = true,
		duration = 2,
		args = [{obj = 'skill', param = 'target', dynamic = true}, {obj = 'skill', param = 'caster', dynamic = true}],
		sub_effects = [],
		modal_sub_effects = ['e_s_rejuvenation', 'e_s_mward2'],
		buffs = []
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
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [],
				atomic = [
					{type = 'stat_add', stat = 'critchance', value = 25},
					{type = 'stat_add', stat = 'critmod', value = 0.75},
					],
				buffs = [],
				sub_effects = []
			}
		]
	},
	
	succubus_passive = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = false,
		conditions = [],
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [],
				atomic = [
					{type = 'stat_add', stat = 'lust', value = ['random', 1, 3]},
					],
				buffs = [],
				sub_effects = []
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
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = ['e_s_templar']
	},
	e_s_templar = {
		type = 'temp_s',
		tags = ['buff'],
		target = 'owner',
		name = 'templar_prot',
		stack = 1,
		req_skill = false,
		duration = 3,
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		args = [{obj = 'app_obj', param = 'armor'}],
		sub_effects = ['e_tr_templar_heal'],
		atomic = [
			{type = 'stat_add', stat = 'mdef', value = [['parent_args', 0], '*', 0.5]},
			],
		buffs = ['b_templar'],
	},
	e_tr_templar_heal = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		req_skill = false,
		conditions = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [{obj = 'app_obj', param = 'hpmax'}],
				atomic = [
					{type = 'heal', value = [['parent_args', 0], '*', 0.1]},
					],
				buffs = [],
				sub_effects = []
			},
		]
	},
	#skill-based
	e_t_command = {
		type = 'temp_s',
		target = 'target',
		name = 'command',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 3,
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.5},
			{type = 'stat_add_p', stat = 'matk', value = 0.5}
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Trainer.png",
				description = "TRAITEFFECTCOMMANDED",
				limit = 1,
				t_name = 'command'
			}
		],
	},
	e_t_refine = {
		type = 'temp_s',
		target = 'target',
		name = 'refine',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.3},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/WeaponRefine.png",
				description = "TRAITEFFECTREFINE",
				limit = 1,
				t_name = 'refine'
			}
		],
	},
	succubus_combat_2 = {
		type = 'temp_toggle',
		name = 'euphoria',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		target = 'caster',
		tags = ['euphoria'],
		sub_effects = ['e_euphoria_bonus', 'euphoria_passive'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Fighter.png",
				description = "EUPHORIABUFF", #fix
				bonuseffect = 'lust',
				limit = 1,
				t_name = "Euphoria",
				combat_only = true,
			}
		],
	},
	e_euphoria_bonus = {
		type = 'dynamic',
		tags = ['recheck_stats'],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = [['parent_args', 0],'*',0.005]},
			{type = 'stat_add_p', stat = 'matk', value = [['parent_args', 0],'*',0.005]}
			],
		buffs = [],
		args = [{obj = 'app_obj', param = 'lust'}],
		sub_effects = []
	},
	euphoria_passive = {
		type = 'trigger',
		trigger = [variables.TR_TURN_F],
		req_skill = false,
		conditions = [],
		atomic = [],
		buffs = [],
		args = [],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = [],
				atomic = [
					{type = 'stat_add', stat = 'lust', value = ['random', -6, -4]},
					],
				buffs = [],
				sub_effects = []
			},
			{
				type = 'oneshot',
				target = 'owner',
				args = [],
				conditions = [{code = 'stat', stat = 'lust', operant = 'lte', value = 0}],
				atomic = [
					{type = 'remove_effect', value = 'euphoria'},
					],
				buffs = [],
				sub_effects = []
			}
		]
	},
	e_t_distract = {
		type = 'temp_s',
		target = 'target',
		name = 'distract',
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		duration = 2,
		tags = ['debuff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = -30},
			{type = 'stat_add', stat = 'hitrate', value = -30}
		],
		buffs = ['b_distract'],
		args = [],
	},
	e_t_dragonmight = {
		type = 'temp_s',
		target = 'target',
		name = 'dragonmight',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['buff'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'damage_mod_all', value = 0.25},
			{type = 'stat_mul', stat = 'armor', value = 1.25},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Dragon_Knight.png",
				description = "TRAITEFFECTDRAGONSMIGHT",
				limit = 1,
				t_name = 'dragonmight'
			}
		],
	},
	e_s_revenge = {
		type = 'trigger',
		conditions = [],
		trigger = [variables.TR_HIT],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster'}],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				args = [{obj = 'parent_arg_get', index = 0, param = 'hp'},{obj = 'parent_arg_get', index = 0, param = 'hpmax'}],
				atomic = [{type = 'stat_mul', stat = 'value', value = [['parent_args', 0],'/',['parent_args', 1],'*',-3,'+',4.0]}],
			},
		],
	},
	e_s_devour = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'caster'}],
		sub_effects = ['e_t_devour'],
		buffs = []
	},
	e_t_devour = {
		type = 'temp_s',
		tags = ['negative'],
		target = 'target',
		name = 'devour',
		stack = 1,
		rem_event = [variables.TR_COMBAT_F],
		buffs = [{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTDEVOUR",
				limit = 1,
				t_name = 'devour',
			}],
		args = [{obj = 'parent_args', param = 0, comment = 'caster'}, {obj = 'parent_arg_get', index = 0, param = 'mpmax', comment = 'casters mpmax' }],
		sub_effects = ['e_tr_devour']
	},
	e_tr_devour = {
		type = 'trigger',
		trigger = [variables.TR_DEATH],
		conditions = [],
		req_skill = false,
		args = [{obj = 'parent_args', param = 0, comment = 'caster'}, {obj = 'parent_args', param = 1, comment = 'casters mpmax'}],
		sub_effects = [{
			type = 'oneshot',
			target = 'arg',
			args = [{obj = 'parent_args', param = 0, comment = 'caster'}, {obj = 'parent_args', param = 1, comment = 'casters mpmax'}],
			atomic = [
				{type = 'mana', value = [['parent_args', 1], '*', 0.2]}
				]
		}],
		buffs = []
	},
	e_s_spirit1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_spirits','e_t_spirit1'],
		buffs = []
	},
	e_s_spirit2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_spirits','e_t_spirit2'],
		buffs = []
	},
	e_s_spirit3 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_spirits','e_t_spirit3'],
		buffs = []
	},
	e_t_spirit1 = {
		type = 'temp_s',
		target = 'target',
		name = 'spirit1',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['spirit'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'evasion', value = 25},
			{type = 'stat_add', stat = 'speed', value = 30},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTSPIRIT1",
				limit = 1,
				t_name = 'spirit',
				combat_only = true,
			}
		],
	},
	e_t_spirit3 = {
		type = 'temp_s',
		target = 'target',
		name = 'spirit3',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['spirit'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = 30},
			{type = 'stat_add', stat = 'damage_mod_skill', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTSPIRIT3",
				limit = 1,
				t_name = 'spirit',
				combat_only = true,
			}
		],
	},
	e_t_spirit2 = {
		type = 'temp_s',
		target = 'target',
		name = 'spirit2',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		stack = 1,
		tags = ['spirit'],
		sub_effects = ['e_t_turtle1', 'e_t_turtle2'],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/Discipline.png",
				description = "TRAITEFFECTSPIRIT2",
				limit = 1,
				t_name = 'spirit',
				combat_only = true,
			}
		],
	},
	e_t_turtle1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'eq', 'skill']}
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul', stat = 'value', value = 0.75}]
		}],
		buffs = []
	},
	e_t_turtle2 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
			{type = 'skill', value = ['ability_type', 'eq', 'spell']}
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul',  stat = 'value', value = 0.85}]
		}],
		buffs = []
	},
	e_clean_spirits = Effectdata.rebuild_remove_effect('spirit'),
	e_s_bard1 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_bards','e_t_bard1'],
		buffs = []
	},
	e_s_bard2 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_bards','e_t_bard2'],
		buffs = []
	},
	e_s_bard3 = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_bards','e_t_bard3'],
		buffs = []
	},
	e_t_bard1 = {
		type = 'temp_s',
		target = 'target',
		name = 'bard1',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add', stat = 'hitrate', value = 20},
			{type = 'stat_add', stat = 'evasion', value = 20},
			{type = 'stat_add', stat = 'speed', value = 20},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "TRAITEFFECTBARD1",
				limit = 1,
				t_name = 'bard',
				combat_only = true,
			}
		],
	},
	e_t_bard3 = {
		type = 'temp_s',
		target = 'target',
		name = 'bard3',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = [],
		atomic = [
			{type = 'stat_add_p', stat = 'atk', value = 0.2},
			{type = 'stat_add_p', stat = 'matk', value = 0.2},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "TRAITEFFECTBARD3",
				limit = 1,
				t_name = 'bard',
				combat_only = true,
			}
		],
	},
	e_t_bard2 = {
		type = 'temp_s',
		target = 'target',
		name = 'bard2',
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		tick_event = [variables.TR_TURN_F],
		stack = 1,
		duration = 4,
		tags = ['buff', 'positive', 'bard'],
		sub_effects = ['e_bards_clean'],
		atomic = [
			{type = 'stat_add', stat = 'armor', value = 15},
			{type = 'stat_add', stat = 'mdef', value = 15},
		],
		buffs = [
			{
				icon = "res://assets/images/iconsclasses/Bard.png",
				description = "TRAITEFFECTBARD2",
				limit = 1,
				t_name = 'bard',
				combat_only = true,
			}
		],
	},
	e_bards_clean = {
		type = 'trigger',
		trigger = [variables.TR_TURN_GET],
		conditions = [],
		req_skill = false,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'owner',
			args = [],
			atomic = [{type = 'remove_effect', value = 'negative'}]
		}],
		buffs = [],
	},
	e_clean_bards = Effectdata.rebuild_remove_effect('bard'),
	e_t_shell = {
		type = 'temp_s',
		tags = ['buff', 'positive'],
		target = 'target',
		duration = 4,
		name = 'protective_shell',
		stack = 1,
		tick_event = variables.TR_POST_TARG,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_shell'],
		args = [],
		sub_effects = ['e_t_shell1']
	},
	e_t_shell1 = {
		type = 'trigger',
		trigger = [variables.TR_DEF],
		conditions = [
			{type = 'skill', value = ['hit_res', 'mask', variables.RES_HITCRIT]},
			{type = 'skill', value = ['tags', 'has', 'damage'] },
		],
		req_skill = true,
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_mul', stat = 'value', value = 0.65}]
		}],
		buffs = []
	},
	e_s_mirror = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [],
		sub_effects = ['e_clean_reflections','e_t_mirror'],
		buffs = []
	},
	e_t_mirror = {
		type = 'temp_s',
		tags = ['reflection', 'buff'],
		target = 'target',
		duration = 2,
		name = 'mirror_image',
		stack = 1,
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
		args = [],
		sub_effects = [{
			type = 'oneshot',
			target = 'skill',
			atomic = [{type = 'stat_set', stat = 'hit_res', value = variables.RES_MISS}]
		}],
		buffs = []
	},
	e_s_field = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [{obj = 'parent', param = 'process_value' }],
		sub_effects = ['e_clean_reflections','e_t_field'],
		buffs = []
	},
	e_t_field = {
		type = 'temp_s',
		tags = ['reflection', 'buff'],
		target = 'target',
		duration = 2,
		name = 'energy_field',
		stack = 1,
		tick_event = variables.TR_TURN_GET,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		buffs = ['b_field'],
		args = [{obj = 'parent_args', param = 0}],
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
		args = [{obj = 'parent_args', param = 0}],
		sub_effects = [{
			type = 'oneshot',
			target = 'caster',
			args = [{obj = 'parent_args', param = 0}],
			atomic = [
				{type = 'sfx', value = 'targetattack'},
				{type = 'damage', value = ['parent_args', 0], source = 'air'}]
		}],
		buffs = []
	},
	e_clean_reflections = Effectdata.rebuild_remove_effect('reflection'),
	e_s_windwall = {
		type = 'temp_s',
		duration = 4,
		stack = 1,
		name = 'e_s_windwall',
		target = 'target',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		args = [],
		atomic = [
			{type = 'stat_add', stat = 'resist_damage_ranged', value = 0.5},
		],
		sub_effects = [],
		buffs = [{
			icon = "res://assets/images/iconsskills/windwall.png",
			description = "TRAITEFFECTWINDWALL",
			args = [],
			limit = 1,
			t_name = 'windwall',
		}]
	},
	
	e_we_dark_static = {
		type = 'static',
		args = [],
		atomic = [
			Effectdata.rebuild_we_atomic('dark')
		],
		sub_effects = [],
		tags = [],
		buffs = [{
			icon = "res://assets/images/iconsclasses/deathknight.png",
			description = "TRAITDARKWEAPON", #fix
			args = [],
			limit = 1,
			t_name = 'we_dark',
		}]
	},
	
	e_we_test = {
		type = 'temp_s',
		duration = 4,
		stack = 1,
		name = 'e_s_windwall',
		target = 'target',
		tick_event = [variables.TR_TURN_F],
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		args = [],
		atomic = [
			Effectdata.rebuild_we_atomic('water')
		],
		sub_effects = [],
		tags = ['e_damage_buff'],
		buffs = [{
			icon = "res://assets/images/iconsskills/windwall.png",
			description = "TRAITEFFECTWINDWALL",
			args = [],
			limit = 1,
			t_name = 'test',
		}]
	}
}
var atomic_effects = {}
var buffs = {
	b_alios = {
		icon = "res://assets/images/iconsskills/hitrate.png",
		description = "BUFFDESCRIPTALIOSACTIVE",
		t_name = 'alios',
		combat_only = true
	},
	b_bishop = {
		icon = "res://assets/images/iconsclasses/Bishop.png",
		description = "BUFFDESCRIPTBISHOP",
		t_name = 'bishop_debuff',
		combat_only = true
	},
	b_templar = {
		icon = "res://assets/images/iconsclasses/Templar.png",
		description = "BUFFDESCRIPTTEMPLAR",
		t_name = 'templar_buff',
		combat_only = true
	},
	b_deathknight = {
		icon = "res://assets/images/iconsclasses/deathknight.png",
		description = "BUFFDESCRIPTDEATHKNIGHT",
		t_name = 'deathknight_buff',
		limit = 1,
		tags = ['show_amount']
	},
	b_free_use = {
		icon = "res://assets/images/iconsclasses/Attendant.png",
		description = "BUFFDESCRIPTFREEUSE",
		t_name = 'freuse',
		combat_only = true
	},
	b_distract = {
		icon = "res://assets/images/iconsskills/distract.png",
		description = "BUFFDESCRIPTDISTRACT",
		limit = 1,
		t_name = 'distract'
	},
	b_bloodatk = {
		icon = "res://assets/images/iconsskills/hitrate.png",
		description = "BUFFDESCRIPTBLOODATTACK",
		t_name = 'bloodatk',
		combat_only = true
	},
	b_field= {
		icon = "res://assets/images/iconsskills/Barrier.png",
		description = "BUFFDESCRIPTFIELD", 
		limit = 1,
		t_name = 'field'
	},
	b_shell= {
		icon = "res://assets/images/traits/hitrate.png",
		description = "BUFFDESCRIPTSHELL",
		limit = 1,
		t_name = 'shell'
	},
}
