extends Reference
#Fight-time effects of the category traits in trait_catalogue.gd. Their conditions are live and
#leave summons out - see CharacterClass.count_combat_company.

var skills = {
	#a turn for traits that leave no attack, Pacifist; a trait grants it through combat_skills
	do_nothing = {
		code = 'do_nothing',
		descript = '',
		icon = "res://assets/images/iconsskills/meditate.png",
		type = 'combat',
		ability_type = 'skill',
		tags = ['disable_immunity', 'stealth_casting'],
		reqs = [],
		targetreqs = [],
		effects = [],
		cost = {},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'self',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'weapon',
		sfx = [],
		sounddata = {initiate = null, strike = null, hit = null},
		value = ['0'],
		damagestat = 'no_stat'
	},
}
var effects = {
	e_tr_loner = {
		type = 'simple',
		conditions = [{code = 'combat_company', check = true}],
		statchanges = {hitrate = -10, atk = -5},
		tags = [],
		buffs = [],
	},
	e_tr_lone_wolf = {
		type = 'simple',
		conditions = [{code = 'combat_company', check = true}],
		statchanges = {damage_mod_all = -0.2, hitrate = -10},
		tags = [],
		buffs = [],
	},
	#ch_dyn_stats.fix_stat_data reads the tag and adds a second turn slot
	e_tr_lone_wolf_alone = {
		type = 'simple',
		conditions = [{code = 'alone_in_combat', check = true}],
		statchanges = {},
		tags = ['lone_wolf_turn'],
		buffs = ['b_lone_wolf'],
	},
	e_tr_meek = {
		type = 'simple',
		conditions = [{code = 'is_in_ranged_zone', check = true}],
		statchanges = {evasion = 15},
		tags = [],
		buffs = [],
	},
	e_tr_insecure = {
		type = 'simple',
		conditions = [{code = 'fighting_without_master', check = true}],
		statchanges = {damage_mod_all = -0.2, evasion = -15},
		tags = [],
		buffs = ['b_insecure'],
	},
	e_tr_obsessed = {
		type = 'simple',
		conditions = [{code = 'fighting_with_master', check = true}],
		statchanges = {damage_mod_all = 0.15, speed = 10},
		tags = [],
		buffs = ['b_obsessed'],
	},
	#a shieldbearer with a shield already counters (e_tr_paladin_5): one more counter a round then
	e_tr_fire_forged_guard = {
		type = 'simple',
		conditions = [
			{code = 'trait', trait = 'shieldbearer', check = true},
			{code = 'shield_with_evasion_bonus', check = true},
		],
		statchanges = {counterattacks_max = 1},
		tags = [],
		buffs = [],
	},
	#everyone else gets the shieldbearer's counter without the shield
	e_tr_fire_forged_counter = {
		type = 'trigger',
		trigger = [variables.TR_POST_TARG],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['tags', 'has', 'damage']},
			{type = 'skill', value = ['can_target_counterattack_in_melee', 'eq', true]},
			{type = 'owner', value = [
				{code = 'trait', trait = 'shieldbearer', check = false},
				{orflag = true, code = 'shield_with_evasion_bonus', check = false},
				{code = 'stat', stat = 'counterattacks', operant = 'gte', value = 1.0}
			]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'owner',
				args = {caster = {obj = 'parent', func = 'arg', arg = 'caster'}},
				atomic = [
					{type = 'stat_add', stat = 'counterattacks', value = -1},
					{type = 'use_combat_skill', skill = 'attack', target = ['parent_args', 'caster']}
				],
			}
		],
	},
	#Blending with Shadows: a Skills.gd global variation puts it on the skill, whose TR_CAST runs before
	#the caster's - In the Shadows is gone once the caster's own TR_CAST has fired
	e_tr_blending_shadows = {
		type = 'trigger',
		trigger = [variables.TR_CAST],
		req_skill = true,
		conditions = [
			{type = 'skill', value = ['target_range', 'eq', 'any']},
			{type = 'caster', value = [{code = 'has_status', status = 'hide', check = true}]},
		],
		sub_effects = [
			{
				type = 'oneshot',
				target = 'skill',
				atomic = [
					{type = 'stat_add', stat = 'critchance', value = 25},
					{type = 'stat_add', stat = 'critmod', value = 0.25},
				],
			}
		],
	},
}
var atomic_effects = {}
var buffs = {
	b_lone_wolf = {
		icon = "res://assets/images/iconstraits/lone_wolf.png",
		description = "BUFFDESCRIPTLONEWOLF",
		tags = ['combat_only'],
	},
	b_insecure = {
		icon = "res://assets/images/iconstraits/insecure.png",
		description = "BUFFDESCRIPTINSECURE",
		tags = ['combat_only'],
	},
	b_obsessed = {
		icon = "res://assets/images/iconstraits/obsessed.png",
		description = "BUFFDESCRIPTOBSESSED",
		tags = ['combat_only'],
	},
}
var stacks = {}
