extends Node

var traits = {
	core_trait = {#adds core effects
		code = 'core',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_core_ex', 'e_core_ex_rem', 'e_core_fat', 'e_core_fat_rem'],
	}, 
	
	master_effect = {#150% effect from social skills
		code = 'master_effect',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_master'],
	}, 
	
	worker_trait = {#+50% productivity on collection tasks except hunting
		code = 'worker_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_worker'],
	}, 
	foreman_trait = {#+100% productivity on collection tasks except hunting
		code = 'foreman_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_foreman'],
	}, 
	hunter_trait = {#+50% productivity on hunting tasks
		code = 'hunter_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_hunter'],
	}, 
	smith_trait = {#+100% productivity on smith crafting
		code = 'smith_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_smith'],
	}, 
	chef_trait = {#+100% productivity on cooking
		code = 'chef_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_chef'],
	}, 
	attendant_trait = {#item usage in combat takes no turn
		code = 'attendant_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	}, 
	alchemist_trait = {#+100% alchemy production, potions restore 25% more
		code = 'alchemist_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_alchemist','e_tr_potion'],
	}, 
	cattle_trait = {#+50% farm production
		code = 'cattle_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_cattle'],
	}, 
	breeder_trait = {#+100% farm production, allows breeding with any race, -30% pregnancy duration
		code = 'breeder_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_breeder'],
	}, #second and third effects need to be hardcoded
	harlot_trait = {#+50% gold from prostitution
		code = 'harlot_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_harlot'],
	}, 
	succubus_trait = {#-30% energy consumption on prostitution
		code = 'succubus_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	}, #hardcoded
	pet_trait = {#+25% gold from prostitution
		code = 'pet_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_pet'],
	},
	sextoy_trait = {#+50% gold from prostitution
		code = 'sextoy_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_harlot'],
	},
	
	#exploration related traits
	#needs to hardcode most of traits
	medium_armor = {#removes penalty from medium armor
		code = 'medium_armor',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	}, 
	heavy_armor = {#removes penalty from heavy armor
		code = 'heavy_armor',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	}, 
	lockpicking = { #allows to pick locks on random events
		code = 'lockpicking',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	},
	trap_detection = { #allows to detect traps on random events
		code = 'trap_detection',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	},
	magic_tools = {
		code = 'magic_tools',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	}, #allows to equip magic rods and staves
	weapon_mastery = {#allows to equip combat weapons
		code = 'weapon_mastery',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	}, 
	ranged_weapon_mastery = {#allows to equip ranged combat weapons
		code = 'ranged_weapon_mastery',
		name = '',
		descript = '',
		visible = true,
		icon = null,
		effects = [],
	}, 
	undead = {#trait - no fatigue, no energy drain from tasks, charm & wit = 0, lust never grows
		code = 'undead',
		name = '',
		descript = '',
		icon = null,
		visible = true,
		effects = [],
	},
}

var sex_traits = { #only for interaction tab
	skilled_petting = {
		code = "skilled_petting",
		name = "",
		descript = "",
		starting = false,
		acquire_reqs = [],
		trigger_side = 'partner',
		reqs = [{code = "action_tag", value = "petting"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.33},{effect = 'horny_bonus', operant = "+", value = 0.33}],
	},
	skilled_mouth = {
		code = "skilled_mouth",
		name = "",
		descript = "",
		starting = false,
		acquire_reqs = [],
		trigger_side = 'partner',
		reqs = [{code = "action_tag", value = "oral"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.33},{effect = 'horny_bonus', operant = "+", value = 0.33}],
	},
	skilled_tail = {
		code = "skilled_tail",
		name = "",
		descript = "",
		starting = false,
		acquire_reqs = [{code = 'long_tail'}],
		trigger_side = 'partner',
		reqs = [{code = "action_tag", value = "tail"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.4},{effect = 'horny_bonus', operant = "+", value = 0.4}],
	},
	oral = {
		code = "oral",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigget_side = 'self',
		reqs = [{code = "action_tag", value = "oral"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5},{effect = 'horny_bonus', operant = "+", value = 0.5}],
	},
	anal = {
		code = "anal",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigget_side = 'self',
		reqs = [{code = "action_tag", value = "anal"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5},{effect = 'horny_bonus', operant = "+", value = 0.5}],
	},
	masochist = {
		code = "masochist",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigger_side = 'self',
		reqs = [{code = "action_tag", value = "punish"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5},{effect = 'horny_bonus', operant = "+", value = 0.5}],
	},
	sadist = {
		code = "sadist",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigger_side = 'partner',
		reqs = [{code = "action_tag", value = "punish"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5},{effect = 'horny_bonus', operant = "+", value = 0.5}],
	},
	submissive = {
		code = "submissive",
		name = "",
		descript = "",
		acquire_reqs = [],
		starting = true,
		trigger_side = 'self',
		reqs = [{code = "effect_exists", value = "tied", orflag = true}, {code = "effect_exists", value = 'subdued', orflag = true}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.25},{effect = 'horny_bonus', operant = "+", value = 0.25}],
	},
	group = {
		code = "group",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigger_side = 'self',
		reqs = [{code = "action_tag", value = "group"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.33},{effect = 'horny_bonus', operant = "+", value = 0.33}],
	},
	likes_shortstacks = {
		code = "likes_shortstacks",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [{code = 'custom', value = 'height'}],
		trigger_side = 'self',
		reqs = [{code = 'partner_check', value = 'height', operant = 'lte', name = 'tiny'}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5},{effect = 'horny_bonus', operant = "+", value = 0.5}],
	},
	likes_beasts = {
		code = "likes_beasts",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [{code = 'race_is_beast', value = false}],
		trigger_side = 'self',
		reqs = [{code = 'partner_check', value = 'race', operant = 'findn', name = 'Beastkin', orflag = true},{code = 'partner_check', value = 'race', operant = 'findn', name = 'Halfkin', orflag = true}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5},{effect = 'horny_bonus', operant = "+", value = 0.5}],
	},
	lewdness_aura = {
		code = "lewdness_aura",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigger_side = 'everyone_turn',
		reqs = [],
		effects = [{effect = 'lewdness_aura'}],
	},
	bisexual = {
		code = "bisexual",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigger_side = 'self',
		reqs = [],
		effects = [],
	},
	deviant = {
		code = "deviant",
		name = "",
		descript = "",
		starting = true,
		acquire_reqs = [],
		trigger_side = 'self',
		reqs = [],
		effects = [],
	},
}

#var traitlist = {
#
#
#	beastbonusdamage = {
#		code = 'beastbonusdamage',
#		name = '',
#		description = tr('TRAITBEASTBONUSDAMAGE'),
#		icon = load("res://assets/images/traits/beastdamage.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 100,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_dmgbeast']
#	},
#	beastbonusresist = {
#		code = 'beastbonusresist',
#		name = '',
#		description = tr('TRAITBEASTBONUSRESIST'),
#		icon = load("res://assets/images/traits/beastresist.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 100,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_nodmgbeast']
#	},
#	bonusexp = {
#		code = 'bonusexp',
#		name = '',
#		description = tr('TRAITBEASTBONUSEXP'),
#		icon = load("res://assets/images/traits/experience.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 200,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_fastlearn']
#	},
#	bonushit = {
#		code = 'bonushit',
#		name = '',
#		description = tr('TRAITBONUSHIT'),
#		icon = load("res://assets/images/traits/hitrate.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 150,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_hitrate']
#	},
#	bonusevasion = {
#		code = 'bonusevasion',
#		name = '',
#		description = tr('TRAITBONUSEVASION'),
#		icon = load("res://assets/images/traits/dodge.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 200,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_ev10']
#	},
#	bonusevasionplus = {
#		code = 'bonusevasionplus',
#		name = '',
#		description = tr('TRAITBONUSEVASIONPLUS'),
#		icon = load("res://assets/images/traits/dodgeplus.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 250,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_ev15']
#	},
#	bonuscrit = {
#		code = 'bonuscrit',
#		name = '',
#		description = tr('TRAITBONUSCRIT'),
#		icon = load("res://assets/images/traits/critrate.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_crit']
#	},
#	bonusresist = {
#		code = 'bonusresist',
#		name = '',
#		description = tr('TRAITBONUSRESIST'),
#		icon = load("res://assets/images/traits/allresist.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 250,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_resist']
#	},
#	bonusarmor = {
#		code = 'bonusarmor',
#		name = '',
#		description = tr('TRAITBONUSARMOR'),
#		icon = load("res://assets/images/traits/armor.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 200,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_armor']
#	},
#	bonusspeed = {
#		code = 'bonusspeed',
#		name = '',
#		description = tr('TRAITBONUSSPEED'),
#		icon = load("res://assets/images/traits/speed.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 200,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_speed']
#	},
#	bonushpmax = {
#		code = 'bonushpmax',
#		name = '',
#		description = tr('TRAITBONUSHPMAX'),
#		icon = load("res://assets/images/traits/health.png"),
#		req_class = ['all'],
#		cost = 1,
#		price = 200,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_hpmax']
#	},
#	bonusregen = {
#		code = 'bonusregen',
#		name = '',
#		description = tr('TRAITBONUSREGEN'),
#		icon = load("res://assets/images/traits/hprecovery.png"),
#		req_class = ['warrior'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_regen']
#	},
#	dodgedebuff = {
#		code = 'dodgedebuff',
#		name = '',
#		description = tr('TRAITDODGEDEBUFF'),
#		icon = load("res://assets/images/traits/dodgedebuff.png"),
#		req_class = ['warrior'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_noevade']
#	},
#	grouparmor = {
#		code = 'grouparmor',
#		name = '',
#		description = tr('TRAITGROUPARMOR'),
#		icon = load("res://assets/images/traits/armorgroup.png"),
#		req_class = ['warrior'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_areaprot', 'e_tr_prot']
#	},
#	doubleheal = {
#		code = 'doubleheal',
#		name = '',
#		description = tr('TRAITDOUBLEHEAL'),
#		icon = load("res://assets/images/traits/healthskillsdouble.png"),
#		req_class = ['mage'],
#		cost = 1,
#		price = 200,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_healer']
#	},
#	speedondamage = {
#		code = 'speedondamage',
#		name = '',
#		description = tr('TRAITSPEEDONDAMAGE'),
#		icon = load("res://assets/images/traits/speedondamage.png"),
#		req_class = ['mage'],
#		cost = 1,
#		price = 250,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_react']
#	},
#	spellcritbonus = {
#		code = 'spellcritbonus',
#		name = '',
#		description = tr('TRAITSPELLCRITBONUS'),
#		icon = load("res://assets/images/traits/spellcritbonus.png"),
#		req_class = ['mage'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_magecrit']
#	},
#	speeddebuff = {
#		code = 'speeddebuff',
#		name = '',
#		description = tr('TRAITSPEEDDEBUFF'),
#		icon = load("res://assets/images/traits/speeddebuf.png"),
#		req_class = ['archer'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_slowarrow']
#	},
#	bowextradamage = {
#		code = 'bowextradamage',
#		name = '',
#		description = tr('TRAITBOWEXTRADAMAGE'),
#		icon = load("res://assets/images/traits/bowextradamage.png"),
#		req_class = ['archer'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_killer']
#	},
#	critarmorignore = {
#		code = 'critarmorignore',
#		name = '',
#		description = tr('TRAITCRITARMORIGNORE'),
#		icon = load("res://assets/images/traits/armorignore.png"),
#		req_class = ['archer'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_rangecrit']
#	},
#	dodgegroup = {
#		code = 'dodgegroup',
#		name = '',
#		description = tr('TRAITDODGEGROUP'),
#		icon = load("res://assets/images/traits/dodgegroup.png"),
#		req_class = ['brawler'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_areaspeed', 'e_tr_speed_icon']
#	},
#	resistdebuff = {
#		code = 'resistdebuff',
#		name = '',
#		description = tr('TRAITRESISTDEBUFF'),
#		icon = load("res://assets/images/traits/resistdebuf.png"),
#		req_class = ['brawler'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_noresist']
#	},
#	firedamagebonus = {
#		code = 'firedamagebonus',
#		name = '',
#		description = tr('TRAITFIREDAMAGEBONUS'),
#		icon = load("res://assets/images/traits/firedamagebonus.png"),
#		req_class = ['brawler'],
#		cost = 1,
#		price = 300,
#		hidden = false, #is not displayed at all
#		non_editable = false, #displayed but can not be deactivated
#		effects = ['e_tr_firefist']
#	},
#	#class passives
#	arch_trait = {
#		code = 'arch_trait',
#		name = '',
#		description = '',
#		icon = null,
#		req_class = ['auto'],
#		cost = 0,
#		hidden = false, #is not displayed at all
#		non_editable = true, #displayed but can not be deactivated
#		effects = []
#	},
#	mage_trait = {
#		code = 'mage_trait',
#		name = '',
#		description = '',
#		icon = null,
#		req_class = ['auto'],
#		cost = 0,
#		hidden = false, #is not displayed at all
#		non_editable = true, #displayed but can not be deactivated
#		effects = []
#	},
#	#monsters
#	el_heal = {
#		code = 'el_heal',
#		name = '',
#		description = '',
#		icon = null,
#		req_class = ['monster'],
#		cost = 0,
#		hidden = false, #is not displayed at all
#		non_editable = true, #displayed but can not be deactivated
#		effects = ['e_tr_elheal']
#	},
#	dw_fury = {
#		code = 'dw_fury',
#		name = '',
#		description = '',
#		icon = null,
#		req_class = ['monster'],
#		cost = 0,
#		hidden = false, #is not displayed at all
#		non_editable = true, #displayed but can not be deactivated
#		effects = ['e_tr_dwarwenbuf', 'e_tr_dwarwenclear']
#	},
#	treant_barrier = {
#		code = 'treant_barrier',
#		name = '',
#		description = '',
#		icon = null,
#		req_class = ['monster'],
#		cost = 0,
#		hidden = false, #is not displayed at all
#		non_editable = true, #displayed but can not be deactivated
#		effects = ['e_tr_treant_barrier']
#	},
#};