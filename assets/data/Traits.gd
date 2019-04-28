extends Node


#NEW PART, not fully filled

var traitlist = {
	beastbonusdamage = {
		code = 'beastbonusdamage',
		name = '',
		description = tr('TRAITBEASTBONUSDAMAGE'),
		icon = load("res://assets/images/traits/beastdamage.png"),
		req_class = ['all'],
		cost = 1,
		price = 100,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_dmgbeast']
	},
	beastbonusresist = {
		code = 'beastbonusresist',
		name = '',
		description = tr('TRAITBEASTBONUSRESIST'),
		icon = load("res://assets/images/traits/beastresist.png"),
		req_class = ['all'],
		cost = 1,
		price = 100,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_nodmgbeast']
	},
	bonusexp = {
		code = 'bonusexp',
		name = '',
		description = tr('TRAITBEASTBONUSEXP'),
		icon = load("res://assets/images/traits/experience.png"),
		req_class = ['all'],
		cost = 1,
		price = 200,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_fastlearn']
	},
	bonushit = {
		code = 'bonushit',
		name = '',
		description = tr('TRAITBONUSHIT'),
		icon = load("res://assets/images/traits/hitrate.png"),
		req_class = ['all'],
		cost = 1,
		price = 150,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_hitrate']
	},
	bonusevasion = {
		code = 'bonusevasion',
		name = '',
		description = tr('TRAITBONUSEVASION'),
		icon = load("res://assets/images/traits/dodge.png"),
		req_class = ['all'],
		cost = 1,
		price = 200,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_ev10']
	},
	bonusevasionplus = {
		code = 'bonusevasionplus',
		name = '',
		description = tr('TRAITBONUSEVASIONPLUS'),
		icon = load("res://assets/images/traits/dodgeplus.png"),
		req_class = ['all'],
		cost = 1,
		price = 250,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_ev15']
	},
	bonuscrit = {
		code = 'bonuscrit',
		name = '',
		description = tr('TRAITBONUSCRIT'),
		icon = load("res://assets/images/traits/critrate.png"),
		req_class = ['all'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_crit']
	},
	bonusresist = {
		code = 'bonusresist',
		name = '',
		description = tr('TRAITBONUSRESIST'),
		icon = load("res://assets/images/traits/allresist.png"),
		req_class = ['all'],
		cost = 1,
		price = 250,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_resist']
	},
	bonusarmor = {
		code = 'bonusarmor',
		name = '',
		description = tr('TRAITBONUSARMOR'),
		icon = load("res://assets/images/traits/armor.png"),
		req_class = ['all'],
		cost = 1,
		price = 200,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_armor']
	},
	bonusspeed = {
		code = 'bonusspeed',
		name = '',
		description = tr('TRAITBONUSSPEED'),
		icon = load("res://assets/images/traits/speed.png"),
		req_class = ['all'],
		cost = 1,
		price = 200,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_speed']
	},
	bonushpmax = {
		code = 'bonushpmax',
		name = '',
		description = tr('TRAITBONUSHPMAX'),
		icon = load("res://assets/images/traits/health.png"),
		req_class = ['all'],
		cost = 1,
		price = 200,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_hpmax']
	},
	bonusregen = {
		code = 'bonusregen',
		name = '',
		description = tr('TRAITBONUSREGEN'),
		icon = load("res://assets/images/traits/hprecovery.png"),
		req_class = ['warrior'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_regen']
	},
	dodgedebuff = {
		code = 'dodgedebuff',
		name = '',
		description = tr('TRAITDODGEDEBUFF'),
		icon = load("res://assets/images/traits/dodgedebuff.png"),
		req_class = ['warrior'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_noevade']
	},
	grouparmor = {
		code = 'grouparmor',
		name = '',
		description = tr('TRAITGROUPARMOR'),
		icon = load("res://assets/images/traits/armorgroup.png"),
		req_class = ['warrior'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_areaprot', 'e_tr_prot']
	},
	doubleheal = {
		code = 'doubleheal',
		name = '',
		description = tr('TRAITDOUBLEHEAL'),
		icon = load("res://assets/images/traits/healthskillsdouble.png"),
		req_class = ['mage'],
		cost = 1,
		price = 200,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_healer']
	},
	speedondamage = {
		code = 'speedondamage',
		name = '',
		description = tr('TRAITSPEEDONDAMAGE'),
		icon = load("res://assets/images/traits/speedondamage.png"),
		req_class = ['mage'],
		cost = 1,
		price = 250,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_react']
	},
	spellcritbonus = {
		code = 'spellcritbonus',
		name = '',
		description = tr('TRAITSPELLCRITBONUS'),
		icon = load("res://assets/images/traits/spellcritbonus.png"),
		req_class = ['mage'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_magecrit']
	},
	speeddebuff = {
		code = 'speeddebuff',
		name = '',
		description = tr('TRAITSPEEDDEBUFF'),
		icon = load("res://assets/images/traits/speeddebuf.png"),
		req_class = ['archer'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_slowarrow']
	},
	bowextradamage = {
		code = 'bowextradamage',
		name = '',
		description = tr('TRAITBOWEXTRADAMAGE'),
		icon = load("res://assets/images/traits/bowextradamage.png"),
		req_class = ['archer'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_killer']
	},
	critarmorignore = {
		code = 'critarmorignore',
		name = '',
		description = tr('TRAITCRITARMORIGNORE'),
		icon = load("res://assets/images/traits/armorignore.png"),
		req_class = ['archer'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_rangecrit']
	},
	dodgegroup = {
		code = 'dodgegroup',
		name = '',
		description = tr('TRAITDODGEGROUP'),
		icon = load("res://assets/images/traits/dodgegroup.png"),
		req_class = ['brawler'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_areaspeed', 'e_tr_speed_icon']
	},
	resistdebuff = {
		code = 'resistdebuff',
		name = '',
		description = tr('TRAITRESISTDEBUFF'),
		icon = load("res://assets/images/traits/resistdebuf.png"),
		req_class = ['brawler'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_noresist']
	},
	firedamagebonus = {
		code = 'firedamagebonus',
		name = '',
		description = tr('TRAITFIREDAMAGEBONUS'),
		icon = load("res://assets/images/traits/firedamagebonus.png"),
		req_class = ['brawler'],
		cost = 1,
		price = 300,
		hidden = false, #is not displayed at all
		non_editable = false, #displayed but can not be deactivated
		effects = ['e_tr_firefist']
	},
	#class passives
	arch_trait = {
		code = 'arch_trait',
		name = '',
		description = '',
		icon = null,
		req_class = ['auto'],
		cost = 0,
		hidden = false, #is not displayed at all
		non_editable = true, #displayed but can not be deactivated
		effects = []
	},
	mage_trait = {
		code = 'mage_trait',
		name = '',
		description = '',
		icon = null,
		req_class = ['auto'],
		cost = 0,
		hidden = false, #is not displayed at all
		non_editable = true, #displayed but can not be deactivated
		effects = []
	},
	#monsters
	el_heal = {
		code = 'el_heal',
		name = '',
		description = '',
		icon = null,
		req_class = ['monster'],
		cost = 0,
		hidden = false, #is not displayed at all
		non_editable = true, #displayed but can not be deactivated
		effects = ['e_tr_elheal']
	},
	dw_fury = {
		code = 'dw_fury',
		name = '',
		description = '',
		icon = null,
		req_class = ['monster'],
		cost = 0,
		hidden = false, #is not displayed at all
		non_editable = true, #displayed but can not be deactivated
		effects = ['e_tr_dwarwenbuf', 'e_tr_dwarwenclear']
	},
	treant_barrier = {
		code = 'treant_barrier',
		name = '',
		description = '',
		icon = null,
		req_class = ['monster'],
		cost = 0,
		hidden = false, #is not displayed at all
		non_editable = true, #displayed but can not be deactivated
		effects = ['e_tr_treant_barrier']
	},
};