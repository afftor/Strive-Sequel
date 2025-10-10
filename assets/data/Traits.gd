extends Node
#do not remove obsolete data for the sake of saves compatibility

var traits = {
	core_trait = {#adds core effects
		code = 'core',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_phy6', 'e_wit6', 'e_charm6', 'e_sex6', 'e_auth6', 'e_tame6', 'e_mag6', 'e_virgin', 'e_person_bold', 'e_person_shy', 'e_person_kind', 'e_person_serious', 'e_love', 'e_friend', 'e_rival', 'work_rule_luxury', 'work_rule_ration', 'work_rule_shifts', 'work_rule_masturbation', 'e_pregnancy', 'e_pregnancy1', 'e_pregnancy_breeder', 'e_thrall'],#'e_atkpass'],
#		tags = ['bleed']
	},
	trainer = {#allows training
		code = 'trainer',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_combat.png",
		effects = [],
		tags = ['simple_icon', 'trainer']
	},
	undead = {
		code = 'undead',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/trait_undead.png",
		visible = true,
		effects = [],
		tags = ['neutral', 'permanent'],
		bonusstats = {food_consumption_set = 0, resist_light = -50, resist_dark = 50}
	},
	stag_buff = {
		code = 'stag_buff',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconsskills/icon_eyes.png", #fix
		effects = [],
		tags = [],
		bonusstats = {mod_hunt = 0.25, physics = 15, chg_dexterity_max = 1, mastery_stealth = 1}
	},
	#body upgrades
	upgrade_thick_skin = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		bonusstats = {mdef = 10}, 
		reqs = [],  
		visible = false,
		tags = ['body_upgrade']
	},
	upgrade_thick_coverage = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		bonusstats = {armor = 10}, 
		reqs = [],  
		visible = false,
		tags = ['body_upgrade']
	},
	upgrade_nipples = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		bonusstats = {mod_pros = 0.1}, 
		reqs = [],  
		visible = false,
		tags = ['body_upgrade']
	},
	upgrade_tongue = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		bonusstats = {mod_pros = 0.1}, 
		reqs = [],  
		visible = false,
		tags = ['body_upgrade']
	},
	upgrade_eggs = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		reqs = [], 
		visible = false, 
		tags = ['body_upgrade', 'oviposition']
	},
	upgrade_silk = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		reqs = [],  
		visible = false,
		tags = ['body_upgrade', 'silksecretion']
	},
	upgrade_strongarm = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/hand.png",
		effects = [],
		reqs = [],  
		visible = false,
		tags = ['body_upgrade', 'strongarm']
	},
	upgrade_resist = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = ['e_tr_resist'], #25% miss spells with damage, but all enemy spells have damage
		reqs = [],  
		visible = false,
		tags = ['body_upgrade']
	},
	upgrade_thickblood = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [], 
		bonusstats = {resist_bleed = 200, resist_poison = 200}, 
		reqs = [],  
		visible = false,
		tags = ['body_upgrade']
	},
	upgrade_breeder = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [], 
		bonusstats = {}, 
		reqs = [],  
		visible = false,
		tags = ['body_upgrade', 'breeder']
	},
	
	#racial
	racial_oviposition = {
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = [],
		reqs = [],  
		tags = ['oviposition']
	},
	racial_silksecretion = {
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = [],
		reqs = [],  
		tags = ['silksecretion']
	},
	#main characters
	#slave class
	'master' : {
		code = 'master',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		tags = ['exhibit', 'tr_obedience', 'relation', 'sexservice', 'sexservice_adv', 'trained', 'worker', 'combatant'],
		effects = []
	},
	'spouse' : {
		code = 'spouse',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['tr_obedience', 'relation', 'sexservice', 'sexservice_adv', 'trained', 'worker', 'combatant'],
		bonusstats = {}
	},
	'heir' : {
		code = 'heir',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['tr_obedience', 'trained'],
		bonusstats = {mod_collect = -0.2, mod_farm = -0.2, mod_fish = -0.2}
	},
	servant = {#servant class trait, taxing is hardcoded
		code = 'servant',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['tr_obedience', 'trained'],
		bonusstats = {}
	},
	servant_notax = {#new class trait
		code = 'servant',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['tr_obedience', 'trained'],
		bonusstats = {}
	},
	'slave' : {#slave class trait
		code = 'slave1',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		bonusstats = {},
		tags = ['slave']
	},
	slave_trained = {
		code = 'slave_trained',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		bonusstats = {},
		tags = ['trained', 'worker', 'combatant', 'slave']
	},
	#classes
	hunter_damage = {
		code = 'hunter_damage',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_hunter1'],
		bonusstats = {}
	},
	berserker = { #descript only
		code = 'berserker',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [],
		bonusstats = {}
	},
	attendant = {#descript only
		code = 'attendant',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	},
	alchemist = {#descript only
		code = 'alchemist',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [],
		bonusstats = {}
	},
	druid = {
		code = 'druid',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_druid'],
		bonusstats = {}
	},
	templar_trait = {
		code = 'templar_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_templar'],
		bonusstats = {}
	},
	sniper = {
		code = 'sniper',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_sniper'],
		bonusstats = {}
	},
	alios = {
		code = 'alios',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_alios'],
		bonusstats = {}
	},
	bishop = {
		code = 'bishop',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_bishop', 'e_tr_bishop2'],
		bonusstats = {}
	},
	paladin = {
		code = 'paladin',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_paladin_1', 'e_tr_paladin_2','e_tr_paladin_3','e_tr_paladin_4'],
	},
	bloodmage = {
		code = 'bloodmage',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_bloodmage'],
	},
	sadist = {
		code = 'sadist',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_sadist'],
	},
	valkyrie_spear = {
		code = 'valkyrie_spear',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['valkyrie_spear_bonus'],
	},
	autohide = {
		code = 'autohide',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_hide'],
	},
	assassin = {
		code = 'assassin',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['assassin_hide']
	},
	ninja = {
		code = 'ninja',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['ninja']
	},
	deathknight_trait = {
		code = 'deathknight_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_deathknight', 'e_we_dark_static'],
		tags = []
	},
	nixx_champion = {
		code = 'nixx_champion',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_nixx'],
		tags = []
	},
	nixx_champion2 = {
		code = 'nixx_champion2',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_nixx2'],
		tags = []
	},
	witch = {
		code = 'witch',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_witch1','e_tr_witch2'],
		tags = []
	},
	warlock = {
		code = 'warlock',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_warlock'],
		tags = []
	},
	necromancer = {
		code = 'necromancer',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['summon_skeletons']
	},
	ranger = {
		code = 'ranger',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		tags = ['summon_dog']
	},
	succubus = {#+100% exp from prostitution
		code = 'succubus',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['human_form', 'demon_form', 'succubus_thralls_0', 'succubus_thralls_1', 'succubus_thralls_2', 'succubus_thralls_3', 'succubus_thralls_4', 'succubus_thralls_5', 'succubus_thralls_6', ],
	}, #hardcoded
	succubus_magic = {
		code = 'succubus_magic',
		name = '',
		descript = '',
		visible = false,
		icon = null, #2change
		effects = ['magic_atunement'],
	}, 
	succubus_combat = {
		code = 'succubus_combat',
		name = '',
		descript = '',
		visible = false,
		icon = null, #2change
		effects = ['combat_atunement_passive', 'combat_atunement_trigger'],
	}, 
	true_succubus = {
		code = 'true_succubus',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['succubus_passive'],
	}, 
	#masteries
	stun_immunity = {
		code = 'stun_immunity',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconsskills/Authority.png",
		show_in_parent_stats = true,
		effects = [],
		tags = ['simple_icon', 'positive'],
		bonusstats = {resist_stun = 200}
	},
	vigor = {
		code = 'vigor',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconsskills/Authority.png",#fix
		show_in_parent_stats = true,
		effects = [],
		tags = ['simple_icon', 'positive'],
		bonusstats = {hp_reg_add_part = 0.33}
	},
	meditation = {
		code = 'meditation',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconsskills/Authority.png",#fix
		show_in_parent_stats = true,
		effects = [],
		tags = ['simple_icon', 'positive'],
		bonusstats = {mp_reg_add_part = 0.33}
	},
	#positive
	prodigy = {
		code = 'prodigy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = [],
		bonusstats = {exp_gain_mod = 0.25},
		weight = 100,
		conflicts = ['dim'],
		tags = ['positive', 'can_start', 'disposition_change'],
		disposition_change = {
			positive = [['resist', 75],['neutral', 25]]
		}
	},
	passive = {
		code = 'passive',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/fist.png",
		effects = [],
		bonusstats = {training_loyalty = 2},
		weight = 100,
		conflicts = ['rebel'],
		reqs = [{code = 'is_master', check = false}],
		disposition_change = {
			positive = [['weak', 50],['kink', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	nimble = {
		code = 'nimble',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/leg.png",
		effects = [],
		bonusstats = {speed = 10},
		weight = 100,
		conflicts = ['slow'],
		disposition_change = {
			sexual = [['weak', 75],['kink', 25]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	quick = {
		code = 'quick',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/bag.png",
		effects = [],
		bonusstats = {mod_collect = 0.2},
		weight = 100,
		conflicts = ['blundering', 'clumsy'],
		disposition_change = {
			physical = [['weak', 50],['kink', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	handy = {
		code = 'handy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/hammer.png",
		effects = [],
		bonusstats = {mod_tailor = 0.2, mod_smith = 0.2, mod_alchemy = 0.2, mod_cook = 0.2},
		weight = 100,
		conflicts = ['crude', 'inept'],
		disposition_change = {
			humiliation = [['weak', 50],['kink', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	deadly = {
		code = 'deadly',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/wound.png",
		effects = [],
		bonusstats = {critchance = 9},
		weight = 100,
		disposition_change = {
			physical = [['weak', 50],['kink', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	lively = {
		code = 'lively',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		effects = [],
		bonusstats = {hp_reg_add = 3},
		weight = 100,
		conflicts = ['sicky'],
		tags = ['positive', 'can_start']
	},
	mvortex = {
		code = 'mvortex',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/swirl.png",
		effects = [],
		bonusstats = {mp_reg_add = 1},
		weight = 100,
		conflicts = ['m_inept'],
		disposition_change = {
			magic = [['weak', 50],['kink', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change', 'mansion_only']
	},
	bawdy = {
		code = 'bawdy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/bed.png",
		effects = [],
		weight = 100,
		tags = ['positive', 'can_start', 'disposition_change'],
		conflicts = ['chaste', 'frigid'],
		disposition_change = {
			sexual = [['weak', 25],['kink', 75]]
		},
		bonusstats = {mod_pros = 0.25}
	},
	sturdy = {
		code = 'sturdy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		effects = [],
		bonusstats = {armor = 10},
		weight = 100,
		conflicts = ['frail'],
		disposition_change = {
			physical = [['resist', 50],['neutral', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	talented = {
		code = 'talented',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = [],
		bonusstats = {base_task_crit_chance = 0.15}, 
		weight = 100,
		conflicts = ['menial'],
		disposition_change = {
			humiliation = [['weak', 75],['neutral', 25]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	forager = {
		code = 'forager',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = [],
		bonusstats = {}, #hardcoded
		weight = 100,
		disposition_change = {
			positive = [['weak', 75],['neutral', 25]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	gifted = {
		code = 'gifted',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = [],
		bonusstats = {mpmax_mul = 1.5},
		weight = 100,
		conflicts = ['magicmutt'],
		disposition_change = {
			magic = [['kink', 75],['weak', 25]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	belligerent = {
		code = 'belligerent',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/sword.png",
		effects = [],
		bonusstats = {atk_add_part = 0.15},
		weight = 100,
		disposition_change = {
			physical = [['resist', 50],['neutral', 50]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	hiddenpowers = {
		code = 'hiddenpowers',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/scepter.png",
		effects = [],
		bonusstats = {matk_add_part = 0.15},
		weight = 100,
		conflicts = ['m_inept'],
		disposition_change = {
			magic = [['resist', 75],['neutral', 25]]
		},
		tags = ['positive', 'can_start', 'disposition_change']
	},
	healthy = {
		code = 'healthy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/hand.png",
		effects = [],
		bonusstats = {hpmax = 10},
		weight = 100,
		conflicts = ['sicky'],
		tags = ['positive', 'can_start']
	},
	#negative
	dim = {
		code = 'dim',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = [],
		bonusstats = {exp_gain_mod = -0.25},
		weight = 100,
		conflicts = ['prodigy'],
		disposition_change = {
			magic = [['weak', 75],['neutral', 25]]
		},
		tags = ['negative', 'disposition_change']
	},
	rebel = {
		code = 'rebel',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/fist.png",
		effects = [],
		bonusstats = {training_loyalty = -2}, 
		weight = 100,
		conflicts = ['passive'],
		disposition_change = {
			sexual = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change']
	},
	slow = {
		code = 'slow',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/leg.png",
		effects = [],
		bonusstats = {speed = -10},
		weight = 100,
		conflicts = ['nimble'],
		disposition_change = {
			social = [['kink', 75],['weak', 25]]
		},
		tags = ['negative', 'disposition_change']
	},
	clumsy = {
		code = 'clumsy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/bag.png",
		effects = [],
		bonusstats = {mod_collect = -0.8},
		weight = 100,
		conflicts = ['quick', 'blundering'],
		disposition_change = {
			positive = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change']
	},
	inept = {
		code = 'inept',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/hammer.png",
		effects = [],
		bonusstats = {mod_tailor = -0.8, mod_smith = -0.8, mod_alchemy = -0.8, mod_cook = -0.8},
		weight = 100,
		conflicts = ['handy', 'crude'],
		disposition_change = {
			magic = [['resist', 75],['neutral', 25]]
		},
		tags = ['negative', 'disposition_change']
	},
	sicky = {
		code = 'sicky',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		effects = [],
		bonusstats = {hp_reg_add = -3},
		weight = 100,
		conflicts = ['lively', 'healthy'],
		disposition_change = {
			physical = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change']
	},
	frail = {
		code = 'frail',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		effects = [],
		bonusstats = {armor = -10},
		weight = 100,
		conflicts = ['sturdy'],
		disposition_change = {
			physical = [['kink', 75],['weak', 25]]
		},
		tags = ['negative', 'disposition_change']
	},
	magicmutt = {
		code = 'magicmutt',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = [],
		bonusstats = {mpmax_mul = 0.5},
		weight = 100,
		conflicts = ['gifted'],
		disposition_change = {
			magic = [['resist', 50],['neutral', 50]]
		},
		tags = ['negative', 'disposition_change']
	},
	blundering = {
		code = 'blundering',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/bag.png",
		cross = true,
		effects = [],
		bonusstats = {mod_collect = -0.8, mod_farm = -0.8, mod_fish = -0.8},
		weight = 100,
		conflicts = ['quick', 'clumsy'],
		disposition_change = {
			humiliation = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change'],# 'no_collect']
	},
	crude = {
		code = 'crude',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/hammer.png",
		cross = true,
		effects = [],
		bonusstats = {mod_smith = -0.8, mod_tailor = -0.8, mod_alchemy = -0.8},
		weight = 100,
		conflicts = ['handy', 'inept'],
		disposition_change = {
			humiliation = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change'],# 'no_craft']
	},
	chaste = {
		code = 'chaste',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/bed.png",
		cross = true,
		effects = [],
		bonusstats = {mod_pros = -0.8},
		weight = 100,
		conflicts = ['bawdy'],
		disposition_change = {
			sexual = [['resist', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change'],# 'no_whoring']
	},
	pacifist = {
		code = 'pacifist',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/pacific.png",
		effects = [],
		bonusstats = {atk_add_part = -0.5},
		weight = 100,
		disposition_change = {
			physical = [['weak', 75],['neutral', 25]]
		},
		tags = ['negative', 'disposition_change'],# 'no_combat']
	},
	menial = {
		code = 'menial',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/hammer.png",
		effects = [],
		bonusstats = {},
		weight = 100,
		conflicts = ['talented'],
		disposition_change = {
			humiliation = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'no_task_crit', 'disposition_change']
	},
	whimp = {
		code = 'whimp',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/sword.png",
		cross = true,
		effects = [],
		bonusstats = {hpmax_add_part = -0.4},
		weight = 100,
		disposition_change = {
			social = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'disposition_change'],# 'no_combat_skills']
	},
	m_inept = {
		code = 'm_inept',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/scepter.png",
		cross = true,
		effects = [],
		bonusstats = {matk_add_part = -0.5},
		weight = 100,
		disposition_change = {
			magic = [['resist', 75],['neutral', 25]]
		},
		conflicts = ['mvortex', 'hiddenpowers'],
		tags = ['negative', 'disposition_change'],# 'no_combat_spells']
	},
	selfish = {
		code = 'selfish',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/pray.png",
		cross = true,
		effects = [],
		bonusstats = {},
		weight = 100,
		disposition_change = {
			positive = [['weak', 50],['kink', 50]]
		},
		tags = ['negative', 'no_combat_support', 'disposition_change']
	},
	coward = {
		code = 'coward',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/cat.png",
		effects = [],
		bonusstats = {hitrate = -50},
		weight = 100,
		disposition_change = {
			positive = [['kink', 75],['weak', 25]],
			humiliation = [['weak', 75],['kink', 25]],
		},
		tags = ['negative', 'disposition_change'],# 'no_social_skills']
	},
	frigid = {
		code = 'frigid',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		cross = true,
		effects = [],
		bonusstats = {},
#		bonusstats = {lustmax_mul = 0.5},
		weight = 100,
		conflicts = ['bawdy'],
		disposition_change = {
			sexual = [['resist', 75],['neutral', 25]]
		},
		tags = ['negative', 'no_sex_traits', 'disposition_change']
	},
	breakdown_test_trait = {
		code = 'breakdown_test_trait',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		effects = [],
		bonusstats = {breakdown_chance_mod = 0.5},
		weight = 100,
		tags = []
	},
	breakdown_block_test_trait = {
		code = 'breakdown_block_test_trait',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/heart.png",
		effects = [],
		bonusstats = {breakdown_disabled = ['brk_dislike_food', 'brk_oblivion']},
		weight = 100,
		tags = []
	},
	#master
	master_mentor = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_mentorship.png",
		effects = [],
		bonusstats = {trainee_amount = 2},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 1, y = 0.5},
		tags = ['loyalty_master', 'mentor'],
	},
	master_harlotry = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_harlotry.png",
		effects = [],
		bonusstats = {mod_pros = 1.2},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 4, y = 0.5},
		tags = ['loyalty_master', 'harlotry'],
	},
	master_progenecy = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_progenecy.png",
		effects = [],
		bonusstats = {},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 7, y = 0.5},
		tags = ['loyalty_master', 'breeder'],
	},
	master_communicative = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_communicative.png",
		effects = [],
		bonusstats = {},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 1, y = 3},
		tags = ['loyalty_master', 'communicative'],
	},
	master_resilence = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_resilence.png",
		effects = [],
		bonusstats = {resist_fire = 20,
			resist_earth = 20,
			resist_water = 20,
			resist_air = 20,
			resist_light = 20,
			resist_dark = 20,
			resist_mind = 20},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 4, y = 3},
		tags = ['loyalty_master'],
	},
	master_fortune = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_fortune.png",
		effects = [],
		bonusstats = {critchance = 25, magic_find = 1},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 7, y = 3},
		tags = ['loyalty_master'],
	},
	master_int = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_intelligence.png",
		effects = [],
		bonusstats = {exp_gain_mod = 0.15, mastery_point_universal = 3},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 1, y = 6},
		tags = ['loyalty_master', 'intelligence'],
	},
	master_fortitude = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_fortitude.png",
		effects = [],
		bonusstats = {hp_reg_add_part = 3},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 4, y = 6},
		tags = ['loyalty_master', 'fastheal'],
	},
	master_sorcery = {
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_sorcery.png",
		effects = [],
		bonusstats = {mp_reg_add = 1.5, matk_add_part = 0.35},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 7, y = 6},
		tags = ['loyalty_master'],
	},
	#trainings etc
	#icons are for testing, need fixing
	
	untrained = {
		code = 'untrained',
		visible = true,
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/Serve2.png",
		effects = [],
		bonusstats = {productivity = -0.5, damage_mod_all = -0.3}, 
		tags = ['training', 'simple_icon']
	},
	training_broke_in = {
		code = 'training_broke_in',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/broke_in.png",
		effects = [],
		bonusstats = {}, 
		reqs = [],
		tags = ['training', 'simple_icon', 'remove_untrained']
	},
	training_obedience = {
		code = 'training_obedience',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_crown.png",
		effects = [],
		reqs = [{code = 'trait', trait = 'training_broke_in', check = true}],
		bonusstats = {}, 
		tags = ['training', 'tr_obedience', 'simple_icon', 'tr_obed_donate']
	},
	training_callmaster = {
		code = 'training_callmaster',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_crown2.png",
		effects = [],
		reqs = [{code = 'trait', trait = 'training_broke_in', check = true}],
		bonusstats = {}, 
		tags = ['training', 'callmaster', 'simple_icon']
	},
	training_relation = {
		code = 'training_relation',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_date.png",
		effects = [],
		reqs = [{code = 'trait', trait = 'training_broke_in', check = true}],
		bonusstats = {}, 
		tags = ['training', 'relation', 'simple_icon']
	},
	training_sexservice = {
		code = 'training_sexservice',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_harlotry.png",
		effects = [],
		reqs = [{code = 'trait', trait = 'training_broke_in', check = true}, {code = 'stat', stat = 'consent', operant = 'gte', value = 1 }],
		bonusstats = {}, 
		tags = ['training', 'sexservice', 'simple_icon']
	},
	training_sexservice_adv = {
		code = 'training_sexservice_adv',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_group.png", 
		effects = [],
		reqs = [{code = 'trait', trait = 'training_sexservice', check = true}, {code = 'stat', stat = 'consent', operant = 'gte', value = 3 }],
		bonusstats = {}, 
		tags = ['training', 'sexservice', 'sexservice_adv', 'simple_icon']
	},
	training_s_combat = {
		code = 'training_s_combat',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_sword.png",
		effects = [],
		bonusstats = {}, 
		reqs = [],
		tags = ['servant_training', 'simple_icon', 'combatant']
	},
	training_s_working = {
		code = 'training_s_working',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/work.png",
		effects = [],
		bonusstats = {}, 
		reqs = [],
		tags = ['servant_training', 'simple_icon', 'worker']
	},
	training_s_relation = {
		code = 'training_s_relation',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_date.png",
		effects = [],
		reqs = [],
		bonusstats = {}, 
		tags = ['relation', 'simple_icon', 'servant_training']
	},
	training_s_sexservice = {
		code = 'training_s_sexservice',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_harlotry.png",
		effects = [],
		reqs = [{code = 'stat', stat = 'consent', operant = 'gte', value = 1 }],
		bonusstats = {}, 
		tags = ['sexservice', 'simple_icon', 'servant_training']
	},
	training_s_sexservice_adv = {
		code = 'training_s_sexservice_adv',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_group.png", 
		effects = [],
		reqs = [{code = 'trait', trait = 'training_s_sexservice', check = true}, {code = 'stat', stat = 'consent', operant = 'gte', value = 3 }], #should be status - for mixing servant & slave trainings
		bonusstats = {}, 
		tags = ['sexservice', 'sexservice_adv', 'simple_icon', 'servant_training']
	},
	training_workforce = {
		code = 'training_workforce',
		visible = true,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_worker.png", 
		icon_small = "res://assets/images/iconstraits/l_worker_prt.png", 
		effects = [],
		bonusstats = {productivity = 0.4}, 
		custom_reqs = {humiliation = 3, random = 2},
		tags = ['training_final', 'training_success', 'simple_icon']
	},
	training_service = {
		code = 'training_service',
		visible = true,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_maidu.png",
		icon_small = "res://assets/images/iconstraits/l_maidu_prt.png",
		effects = [],
		bonusstats = {price_add_part = 0.5}, 
		custom_reqs = {humiliation = 1, sexual = 1, social = 1, random = 2},
		tags = ['training_final', 'training_success', 'simple_icon']
	},
	training_warrior = {
		code = 'training_warrior',
		visible = true,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_warrior.png",
		icon_small = "res://assets/images/iconstraits/l_warrior_prt.png", #2fix
		effects = [],
		bonusstats = {damage_mod_all = 0.15, hpmax = 20}, 
		custom_reqs = {positive = 1, physical = 2, random = 2},
		tags = ['training_final', 'training_success', 'simple_icon']
	},
	training_damaged = {
		code = 'training_damaged',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_sorcery.png", #2fix
		effects = [],
		bonusstats = {price_add_part = -0.15, exp_gain_mod = -0.1}, 
		tags = ['training_final', 'training_fail']
	},
	training_broken = {
		code = 'training_broken',
		visible = false,
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_sorcery.png", #2fix
		effects = [],
		bonusstats = {price_add_part = -0.25, exp_gain_mod = -0.2, chg_wisdom_max_set = 0, chg_persuasion_max_set = 0}, 
		tags = ['training_final', 'training_fail']
	},
	
	#monsters
	absorb_atk_trait = {
		code = 'absorb_atk_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_curseatk'],
	},
	fireshield_trait = {
		code = 'fireshield_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_fireshield'],
	},
	atkpass_trait = {
		code = 'atkpass_trait',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_atkpass'],
	},
	#rare opps
	rare_sturdy = {
		code = 'rare_sturdy',
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = ['e_rare_sturdy'],
	},
	rare_nimble = {
		code = 'rare_nimble',
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = ['e_rare_nimble'],
	},
	rare_strong = {
		code = 'rare_strong',
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = ['e_rare_strong'],
	},
	rare_deadly = {
		code = 'rare_deadly',
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = ['e_rare_deadly'],
	},
	rare_precise = {
		code = 'rare_precise',
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = ['e_rare_precise'],
	},
	miniboss = {
		code = 'miniboss',
		name = '',
		descript = '',
		icon = null,
		visible = false,
		effects = ['e_miniboss'],
	},
	boss_resists = {
		code = 'boss_resists',
		name = '',
		descript = '',
		icon = null, 
		visible = false,
		effects = ['e_boss'],
		tags = ['boss_resists'],
	},
	enemy_defender = {
		code = 'enemy_defender',
		name = '',
		descript = '',
		icon = null, 
		visible = false,
		effects = ['setup_retarget_default'],
		tags = ['defender'],
	},
	ward_anchor = {
		code = 'ward_anchor',
		name = '',
		descript = '',
		icon = null, 
		visible = false,
		effects = [],
		tags = ['ward_anchor'],
	},
	ward_etb = {
		code = 'ward_etb',
		name = '',
		descript = '',
		icon = null, 
		visible = false,
		effects = ['setup_ward_test'],
		tags = [],
	},
	
	
	#exploration related traits
	#needs to hardcode most of traits
	medium_armor = {#removes penalty from medium armor
		code = 'medium_armor',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	},
	heavy_armor = {#removes penalty from heavy armor
		code = 'heavy_armor',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	},
	lockpicking = { #allows to pick locks on random events
		code = 'lockpicking',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	},
	trap_detection = { #allows to detect traps on random events
		code = 'trap_detection',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	},
	trap_analyze = { #allows to detect traps on random events
		code = 'trap_analyze',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	},
#	magic_tools = {
#		code = 'magic_tools',
#		name = '',
#		descript = '',
#		visible = false,
#		icon = null,
#		effects = [],
#	}, #allows to equip magic rods and staves
#	weapon_mastery = {#allows to equip combat weapons
#		code = 'weapon_mastery',
#		name = '',
#		descript = '',
#		visible = false,
#		icon = null,
#		effects = [],
#	},
#	ranged_weapon_mastery = {#allows to equip ranged combat weapons
#		code = 'ranged_weapon_mastery',
#		name = '',
#		descript = '',
#		visible = false,
#		icon = null,
#		effects = [],
#	},
	
	#minor_training
		etiquette = {
		code = 'etiquette',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_communicative.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {wits_bonus = 5},
		l_cost = 500,
		tree_position = {tab = 3, x = 0.5, y = 0},
	},
	table_manners = {
		code = 'table_manners',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/table_manners.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {physics_bonus = 5},
		l_cost = 500,
		tree_position = {tab = 3, x = 2.8, y = 0},
	},
	foreign_diplomacy = {
		code = 'foreign_diplomacy',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/foreign_diplomacy.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {wits_bonus = 5},
		l_cost = 500,
		tree_position = {tab = 3, x = 5.1, y = 0},
	},
	literacy = {
		code = 'literacy',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/literacy.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		l_cost = 500,
		tree_position = {tab = 3, x = 1, y = 2.5},
	},
	penmanship = {
		code = 'penmanship',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/penmanship.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {physics_bonus = 5},
		l_cost = 500,
		tree_position = {tab = 3, x = 4, y = 2.5},
	},
	history = {
		code = 'history',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/history.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {wits_bonus = 5},
		l_cost = 500,
		tree_position = {tab = 3, x = 7, y = 2.5},
	},
	mentorship = {
		code = 'mentorship',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_mentorship.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {trainer_loyalty_bonus = 0.25},
		l_cost = 500,
		tree_position = {tab = 3, x = 1, y = 5},
	},
	animal_handling = {
		code = 'animal_handling',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/animal_handling.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {mod_hunt = 0.1},
		l_cost = 500,
		tree_position = {tab = 3, x = 4, y = 5},
	},
	gardening = {
		code = 'gardening',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/iconstraits/l_date.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {mod_farm = 0.1},
		l_cost = 500,
		tree_position = {tab = 3, x = 7, y = 5},
	},
	courtly_arms = {
		code = 'courtly_arms',
		name = '',
		descript = '',
		visible = false,
		icon = "res://assets/images/minor_training/courtly_arms.png",
		effects = [],
		reqs = [],
		tags = ['minor_training'],
		bonusstats = {hitrate = 10},
		l_cost = 500,
		tree_position = {tab = 3, x = 7.5, y = 0},
	},
	
	#examples
	#example of catalysts ignoring
	test_cat_ignore = {
		code = 'test_cat_ignore',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		tags = ['ignore_catalysts_for_firebomb'],
		effects = [],
	},
	
	#unused or obsolete
	
}


var body_upgrades = {
	upgrade_thick_skin = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'has_coverage', coverage = 'fur', check = false}, {code = 'has_coverage', coverage = 'scales', check = false}],
		cost = 40,
		goldcost = 10000,
		traits = ['upgrade_thick_skin']
	},
	upgrade_thick_coverage = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'has_coverage', coverage = 'fur', check = true}, {orflag = true, code = 'has_coverage', coverage = 'scales', check = true}],
		cost = 30,
		goldcost = 10000,
		traits = ['upgrade_thick_coverage']
	},
	upgrade_nipples = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'stat_in_set', stat = 'tits_size', value = ['average', 'big', 'huge', 'average_high', 'big_high', 'huge_high', 'average_narrow', 'big_narrow', 'huge_narrow', 'average_wide', 'big_wide', 'huge_wide']}],
		cost = 20,
		goldcost = 5000,
		traits = ['upgrade_nipples']
	},
	upgrade_tongue = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [],
		cost = 20,
		goldcost = 5000,
		traits = ['upgrade_tongue']
	},
	upgrade_eggs = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'stat', stat = 'has_womb', operant = 'eq', value = true}],
		cost = 30,
		goldcost = 8000,
		traits = ['upgrade_eggs']
	},
	upgrade_silk = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [],
		cost = 40,
		goldcost = 12500,
		traits = ['upgrade_silk']
	},
	upgrade_strongarm = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 5}],
		cost = 40,
		goldcost = 10000,
		traits = ['upgrade_strongarm']
	},
	upgrade_resist = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'stat', stat = 'magic_factor', operant = 'gte', value = 4}],
		cost = 60,
		goldcost = 15000,
		traits = ['upgrade_resist']
	},
	upgrade_thickblood = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [{code = 'stat', stat = 'physics_factor', operant = 'gte', value = 3}],
		cost = 50,
		goldcost = 15000,
		traits = ['upgrade_thickblood']
	},
	upgrade_breeder = { #2fix parameters
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		reqs = [],
		cost = 40,
		goldcost = 10000,
		traits = ['upgrade_breeder']
	},
}


var sex_traits = { #only for interaction tab
	dislike_petting = {
		code = "dislike_petting",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["caress","fondletits","kiss"]}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}],
	},
	dislike_fingering = {
		code = "dislike_fingering",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["fingering","assfingering","vibrator",'analvibrator']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_tits = {
		code = "dislike_tits",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["titjob","fondletits","sucknipples",'nipplefuck']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_oral = {
		code = "dislike_oral",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["blowjob","cunnilingus","rimjob",'deepthroat']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_missionary = {
		code = "dislike_missionary",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["missionary","missionaryanal","kiss",'fondletits']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_doggy = {
		code = "dislike_doggy",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["doggy","doggyanal","doubledildo",'doubledildoass','grovel']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_sitting = {
		code = "dislike_sitting",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["lotus",'lotusanal','revlotus','revlotusanal','facesit','afacesit','tribadism','frottage']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_riding = {
		code = "dislike_riding",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["ontop",'ontopanal']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_group = {
		code = "dislike_group",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["doublepen",'spitroast','spitroastass','insertinturns','insertinturnsass']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_bdsm = {
		code = "dislike_bdsm",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["spanking",'whipping','nippleclamp','clitclamp','ringgag','blindfold','nosehook','facesit','afacesit']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},
	dislike_tail = {
		code = "dislike_tail",
		name = "",
		descript = "",
		starting = false,
		random_generation = true,
		acquire_reqs = [],
		negative = true,
		reqs = [{code = "action_type", value = ["tailjob",'earjob','inserttailv','inserttaila']}],
		effects = [{effect = 'consent', operant = '*', value = 1, trigger = 'consent_check'},{effect = 'horny_bonus', operant = "-", value = 0.33, trigger = 'action_self'}]
	},


	bisexual = {
		code = "bisexual",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "same_sex_orgasms", operant = "gte", value = 2}],
		reqs = [],
		effects = [],
	},
	monogamous = {
		code = "monogamous",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "satisfied_partners", operant = "eq", value = 1},{code = "stat", type = "orgasm_partners", operant = "eq", value = 1}]}],
		reqs = [],
		effects = [],
	},
	family_first = {
		code = "family_first",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "satisfied_partners", operant = "eq", value = 1}]}],
		reqs = [],
		effects = [],
	},
	open_minded = {
		code = "open_minded",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "diff_body_orgasm", operant = "gte", value = 2}]}],
		reqs = [],
		effects = [],
	},
	deviant = {
		code = "deviant",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "deviant_orgasms", operant = "gte", value = 2}]}],
		reqs = [],
		effects = [],
	},
	group = {
		code = "group",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "orgasm_partners", operant = "gte", value = 2}]}],
		reqs = [],
		effects = [],
	},
	shameless = {
		code = "shameless",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "orgasm_with_watcher", operant = "gte", value = 3}]}],
		reqs = [],
		effects = [],
	},
	anal = {
		code = "anal",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "orgasm_tags", flag = "only", value = "anal"}]}],
		reqs = [],
		effects = [],
	},
	breasts = {
		code = "breasts",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "orgasm_tags", flag = "only", value = "tits"}]}],
		reqs = [{code = "action_tag", value = "tits"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5, trigger = 'action_self'},{effect = 'horny_bonus', operant = "+", value = 0.5, trigger = 'action_self'}],
	},
	masochist = {
		code = "masochist",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "mazo_actions", operant = "gte", value = 10}]}],
		reqs = [{code = "action_tag", value = "punish"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5, trigger = 'action_self'}],
		tags = ['likes_training']
	},
	sadist = {
		code = "sadist",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "punish_actions", operant = "gte", value = 10}]}],
		reqs = [{code = "action_partner_tag", value = "punish"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.5, trigger = 'action_self'}],
	},
	dominant = {
		code = "dominant",
		name = "",
		descript = "",
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "dominant", operant = "gte", value = 3}]}],
		starting = true,
		random_generation = true,
		negative = false,
		reqs = [{code = "action_tag", value = "dom"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.2, trigger = 'action_self'}],
	},
	submissive = {
		code = "submissive",
		name = "",
		descript = "",
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "orgasm_effects", flag = "any", value = ["subdued", "tied"]}]}],
		starting = true,
		random_generation = true,
		negative = false,
		reqs = [{code = "action_tag", value = "sub"}],
		effects = [{effect = 'sens_bonus', operant = "+", value = 0.2, trigger = 'action_self'}],
		tags = ['likes_training']
	},
	nymphomania = {
		code = "nymphomania",
		name = "",
		descript = "",
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "orgasms", operant = "gte", value = 5}]}],
		starting = true,
		random_generation = true,
		negative = false,
		reqs = [],
		effects = [{effect = 'maximize_hornyness', trigger = 'start'}],
	},
	hypersensitive = {
		code = "hypersensitive",
		name = "",
		descript = "",
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "aphrodisiac_orgasms", operant = "gte", value = 2}]}],
		starting = true,
		random_generation = true,
		negative = false,
		reqs = [],
		effects = [{effect = 'can_orgasm_regardless', trigger = 'orgasm'}],
	},
	lewdness_aura = {
		code = "lewdness_aura",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [],
		reqs = [],
		effects = [{effect = 'lewdness_aura', trigger = 'end_turn'}],
	},
	bottle_fairy = {
		code = "bottle_fairy",
		name = "",
		descript = "",
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "drunk_orgasm", operant = "gte", value = 2}]}],
		starting = true,
		random_generation = true,
		negative = false,
		reqs = [{code = 'effect_exists', value = 'tipsy'},{code = 'effect_exists', value = 'drunk', orflag = true}],
		effects = [{effect = 'sens_bonus', operant = '+', value = 0.3, trigger = 'action_self'}],
	},
	irresistible = {
		code = "irresistible",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "new_consented_partners", operant = "gte", value = 3}]}],
		reqs = [],
		effects = [{effect = 'consent', operant = "+", value = 1, trigger = 'consent_check_partner'}],
	},
	bedroom_prodidgy = {
		code = "bedroom_prodidgy",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "bedroom_prodigy", operant = "gte", value = 3}]}],
		reqs = [],
		effects = [{effect = 'skill_exp', operant = '+', value = 0.5, trigger = 'skill_exp_gain'}],
	},
	pushover = {
		code = "pushover",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "unconsented_orgasm", operant = "gte", value = 2}]}],
		reqs = [],
		effects = [],#{effect = 'consent_gain', operant = '*', value = 1.5, trigger = 'encounter_end'}],
		tags = ['likes_training']
	},
	
	teacher = {
		code = "teacher",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "single_partner_consents", operant = "gte", value = 5}]}],
		reqs = [],
		effects = [{effect = 'skill_exp', operant = '+', value = 0.5, trigger = 'skill_exp_gain_partner'}],
	},
	desired = {
		code = "desired",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "satisfied_partners", operant = "gte", value = 2}]}],
		reqs = [],
		effects = [{effect = 'sens_bonus', operant = '+', value = 0.25, trigger = 'action_partner'}],
	},
	curious = {
		code = "curious",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "seen_orgasms", operant = "gte", value = 2}]}],
		reqs = [],
		effects = [{effect = 'exp_bonus', operant = '+', value = 0.25, trigger = 'encounter_end'}],
	},
	life_power = {
		code = "life_power",
		name = "",
		descript = "",
		starting = true,
		random_generation = true,
		negative = false,
		acquire_reqs = [{code = "actor_check", value = [{code = "stat", type = "max_ongoing_actions", operant = "gte", value = 5}]}],
		reqs = [],
		effects = [{effect = 'life_power', trigger = 'encounter_end'}],
	},

}
func _ready():
	for tr in traits:
		if !traits[tr].has('code'): traits[tr].code = tr
		if !traits[tr].has('tags'): traits[tr].tags = []
		if !traits[tr].has('bonusstats'): traits[tr].bonusstats = {}
	for upg in body_upgrades:
		body_upgrades[upg].name = 'BODYUPGRADENAME_' + upg.to_upper()
		body_upgrades[upg].descript = 'BODYUPGRADEDESCRIPT_' + upg.to_upper()
#	for prof in slave_profs:
#		slave_profs[prof].code = prof
#		slave_profs[prof].name = 'SLAVEPROFNAME_' + prof.trim_prefix('slave_').to_upper()
#		slave_profs[prof].descript = 'SLAVEPROFDESCRIPT_' + prof.trim_prefix('slave_').to_upper()


var tattoodata = {
	ink_branding = {
		name = 'Brand',
		can_repeat = false,
		icon = load("res://assets/images/iconsitems/TattooBrand.png"),
		conditions = [{code = 'is_master', check = false}],
		item = 'ink_branding',
		slots = ['neck','crotch','ass'],
		effects = {
			['neck','crotch','ass']: ['e_brand']
		},
		descripts = {
			['neck','crotch','ass']: "TATTOOBRANDDESCRIPT",
		},
	},
	ink_makeup = {
		name = 'Makeup',
		can_repeat = true,
		icon = load("res://assets/images/iconsitems/TattooMakeup.png"),
		item = 'ink_makeup',
		slots = ['face'],
		effects = {
			['face']: ['e_mkup']
		},
		descripts = {
			['face']: "TATTOOMAKEUPDESCRIPT",
		},
	},
	ink_lust = {
		name = 'Lust',
		can_repeat = true,
		icon = load("res://assets/images/iconsitems/TattooLust.png"),
		item = 'ink_lust',
		slots = ['chest','ass','crotch'],
		effects = {
			['chest','ass']: ['e_tlust1'],
			['crotch']: ['e_tlust2']
		},
		descripts = {
			['chest','ass']: "TATTOOLUSTDESCRIPT",
			['crotch']: "TATTOOLUST2DESCRIPT",
		},
	},
	# ink_hp_r = {
	# 	name = 'HP regen',
	# 	can_repeat = true,
	# 	item = 'ink1',
	# 	slots = ['arms','legs','waist'],
	# 	effects = {
	# 		['arms', 'legs', 'waist']: ['e_thpr']
	# 	}
	# },
	ink_hp = {
		name = 'HP regen',
		can_repeat = true,
		icon = load("res://assets/images/iconsitems/TattooHp.png"),
		item = 'ink_hp',
		slots = ['arms','legs','waist'],
		effects = {
			['arms', 'legs', 'waist']: ['e_thpr']
		},
		descripts = {
			['arms', 'legs', 'waist']: "TATTOOHPDESCRIPT",
		},
	},
	# ink_mp_r = {
	# 	name = 'MP regen',
	# 	can_repeat = true,
	# 	slots = ['arms','legs','waist'],
	# 	item = 'ink1',
	# 	effects = {
	# 		['arms', 'legs', 'waist']: ['e_tmpr']
	# 	}
	# },
	ink_mp = {
		name = 'MP regen',
		can_repeat = true,
		icon = load("res://assets/images/iconsitems/TattooEnergy.png"),
		slots = ['arms','legs','waist'],
		item = 'ink_mp',
		effects = {
			['arms', 'legs', 'waist']: ['e_tmpr']
		},
		descripts = {
			['arms', 'legs', 'waist']: "TATTOOMPDESCRIPT",
		},
	},
	ink_tribal = {
		name = 'Tribal',
		can_repeat = true,
		icon = load("res://assets/images/iconsitems/TattooTribal.png"),
		item = 'ink_tribal',
		slots = ['arms','legs','chest','face'],
		effects = {
			['arms', 'legs', 'chest']: ['e_trib1'],
			['face']: ['e_trib2']
		},
		descripts = {
			['arms', 'legs', 'chest']: "TATTOOTRIBALDESCRIPT",
			['face']: "TATTOOTRIBAL2DESCRIPT",
		},
	},
}
#
#var slave_profs = {
#	slave_combat = {
#		name = '',
#		desc = '',
#		icon = "res://assets/images/iconstraits/l_warrior.png",
#		icon_small = "res://assets/images/iconstraits/l_warrior_prt.png",
#		tree_position = {tab = 1, x = 0.5, y = 7.5},
#		effects = [],
#		bonusstats = {atk = 1, hitrate = 2},
#		tags = ['swear_loyalty'],
#		reqs = [
#			{code = 'stat_in_set', stat = 'personality', value = ['bold', 'serious']},
#			{code = 'stat', stat = 'metrics_win', operant = 'gte', value = 3}
#		]
#	},
#	slave_service = {
#		name = '',
#		desc = '',
#		icon = "res://assets/images/iconstraits/l_maidu.png",
#		icon_small = "res://assets/images/iconstraits/l_maidu_prt.png",
#		tree_position = {tab = 1, x = 2.5, y = 7.5},
#		effects = [],
#		bonusstats = {productivity = 0.01, evasion = 2, speed = 1},
#		tags = ['swear_loyalty'],
#		reqs = [
#			{code = 'stat_in_set', stat = 'personality', value = ['bold', 'kind']},
#			{code = 'stat', stat = 'metrics_serviceperformed', operant = 'gte', value = 12}
#		]
#	},
#	slave_prestige = {
#		name = '',
#		desc = '',
#		icon = "res://assets/images/iconstraits/l_prestige.png",
#		icon_small = "res://assets/images/iconstraits/l_prestige_prt.png",
#		tree_position = {tab = 1, x = 4.5, y = 7.5},
#		effects = [],
#		bonusstats = {critchance = 0.33, critmod = 0.01, price_add = 10}, #not sure about critmod
#		tags = ['swear_loyalty'],
#		reqs = [
#			{code = 'stat_in_set', stat = 'personality', value = ['serious', 'kind']},
#			{code = 'stat', stat = 'price', operant = 'gte', value = 1000}
#		]
#	},
#	slave_management = {
#		name = '',
#		desc = '',
#		icon = "res://assets/images/iconstraits/l_protection.png",
#		icon_small = "res://assets/images/iconstraits/l_protection_prt.png",
#		tree_position = {tab = 1, x = 6.5, y = 7.5},
#		effects = ['e_tr_manager'],
#		bonusstats = {hpmax = 1, armor = 1},
#		tags = ['swear_loyalty'],
#		reqs = [
#			{code = 'stat_in_set', stat = 'personality', value = ['bold', 'serious']},
#			{code = 'stat', stat = 'metrics_socskillused', operant = 'gte', value = 4}
#		]
#	},
#	slave_mage = {
#		name = '',
#		desc = '',
#		icon = "res://assets/images/iconstraits/l_mage.png",
#		icon_small = "res://assets/images/iconstraits/l_mage_prt.png",
#		tree_position = {tab = 1, x = 2, y = 10},
#		effects = [],
#		bonusstats = {mpmax = 1, matk = 1},
#		tags = ['swear_loyalty'],
#		reqs = [
#			{code = 'stat_in_set', stat = 'personality', value = ['shy', 'serious']},
#			{code = 'stat', stat = 'metrics_spellused', operant = 'gte', value = 4}
#		]
#	},
#	slave_healer = {
#		name = '',
#		desc = '',
#		icon = "res://assets/images/iconstraits/l_healer.png",
#		icon_small = "res://assets/images/iconstraits/l_healer_prt.png",
#		tree_position = {tab = 1, x = 5, y = 10},
#		effects = ['e_tr_healerslave'],
#		bonusstats = {mdef = 1},
#		tags = ['swear_loyalty'],
#		reqs = [
#			{code = 'stat_in_set', stat = 'personality', value = ['shy', 'kind']},
#			{code = 'stat', stat = 'metrics_healused', operant = 'gte', value = 4}
#		]
#	},
#}
var succubus_trainings = {
#	enthrall = {
#		cost = {thrall_points = 0},
#		mode = 'skill',
#		skill = 'enthrall',
#		trait = null,
#	},
#	release_thrall = {
#		cost = {thrall_points = 0},
#		mode = 'skill',
#		skill = 'release_thrall',
#		trait = null,
#	},
	corrupt = {
		cost = {thrall_points = 1},
		reqs = [],
		mode = 'skill',
		skill = 'corrupt',
		trait = null,
		position = [0, 0],
		icon = load("res://assets/images/iconstraits/corrupt.png"),
	},
	allure = {
		cost = {thrall_points = 1},
		reqs = [],
		mode = 'skill',
		skill = 'allure',
		trait = null,
		position = [0, 1],
		icon = load("res://assets/images/iconstraits/allure.png"),
	},
	turn_succubus = {
		cost = {thrall_points = 3},
		reqs = [],
		mode = 'skill',
		skill = 'turn_succubus',
		trait = null,
		position = [0, 2],
		icon = load("res://assets/images/iconstraits/turn_succubus.png"),
	},
	swap_form = {
		cost = {thrall_points = 3},
		reqs = [],
		mode = 'skill',
		skill = 'swap_form',
		trait = null,
		position = [1, 0],
		icon = load("res://assets/images/iconstraits/change_form.png"),
	},
	succubus_magic = {
		cost = {thrall_points = 5},
		reqs = [{code = 'trait', trait = 'succubus_combat', check = false},],
		mode = 'trait',
		skill = null,
		trait = 'succubus_magic',
		position = [1, 1],
		icon = load("res://assets/images/iconstraits/l_sorcery.png"),
	},
	succubus_combat = {
		cost = {thrall_points = 5},
		reqs = [{code = 'trait', trait = 'succubus_magic', check = false},],
		mode = 'trait',
		skill = null,
		trait = 'succubus_combat',
		position = [1, 2],
		icon = load("res://assets/images/iconstraits/l_sword.png"),
	},
}



func get_tat_list_for_slot(slot):
	var res = []
	for t in tattoodata:
		for slots in tattoodata[t].effects:
			if res.has(t): continue
			if slots.has(slot): res.push_back(t)
	return res

func get_slot_list_for_tat(code):
	var res = []
	for slots in tattoodata[code].effects:
		for s in slots:
			if !res.has(s): res.push_back(s)
	return res


var b_template = {
		icon = "",
		description = "",
		mansion_only = true,
		t_name = 'trait_%s'
	}

func make_buff_for_trait(tr_id):
	var trdata = traits[tr_id]
	if trdata.has('visible') and !trdata.visible: 
		return null
	if !trdata.has('icon'): 
		return null
	if trdata.icon == null: 
		return null
	if !trdata.tags.has('simple_icon'):
		return null
	var template = b_template.duplicate()
	template.icon = trdata.icon.get_path()
	template.description = trdata.descript
	template.t_name = template.t_name % trdata.code
	template.name = template.t_name
	template.tags = trdata.tags.duplicate()
	var res = Buff.new(null)
	res.createfromtemplate(template)
	return res
