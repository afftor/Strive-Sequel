extends Node
#do not remove obsolete data for the sake of saves compatibility

var traits = {
	core_trait = {#adds core effects
		code = 'core',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_phy6', 'e_wit6', 'e_charm6', 'e_sex6', 'e_timid6', 'e_tame6', 'e_mag6', 'e_virgin', 'e_person_bold', 'e_person_shy', 'e_person_kind', 'e_person_serious'],#'e_atkpass'],
	},
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

	'master' : {#150% effect from social skills
		code = 'master',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		tags = ['sex_basic', 'sex_oral', 'sex_group', 'sex_perv', 'sex_adv', 'sex_anal', 'combatant', 'keep_baby', 'body_mod', 'basic_servitude', 'prostitution', 'exhibit'],
		effects = ['e_tr_master']#,'test_recast'],
	},
	'spouse' : {#130% effect from social skills
		code = 'spouse',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_spouse'],#,'test_recast'],
		bonusstats = {loyalty_gain = 3}
	},
	'director' : {#150% effect from social skills
		code = 'director',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_master']#,'test_recast'],
	},
	'slave' : {#slave class trait, obsolete
		code = 'slave',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_slave'],
		bonusstats = {damage_mod_all = -0.1, mod_collect = 0.1, mod_pros = 0.1, mod_service = 0.1, mod_farm = 0.1, mod_smith = -0.15, mod_alchemy = -0.15, mod_tailor = -0.15,}
	},
	'heir' : {
		code = 'heir',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_heir'],
		bonusstats = {mod_collect = -0.2, mod_farm = -0.2, mod_fish = -0.2}
	},
	servant = {#servant class trait, taxing is hardcoded
		code = 'servant',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		traits = ['loyalty_basic_servitude'],
		bonusstats = {obedience_drain = -5, loyalty_gain = 0.25}
	},
	servant_notax = {#new class trait
		code = 'servant',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		traits = ['loyalty_basic_servitude'],
		bonusstats = {obedience_drain = -5, loyalty_gain = 0.25}
	},
	slave1 = {#slave class trait
		code = 'slave1',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		bonusstats = {}
	},
	worker = {
		code = 'worker',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],#'e_tr_worker'],
		show_in_parent_stats = true,
		bonusstats = {mod_collect = 0.5}
	},
	foreman = {
		code = 'foreman',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],#'e_tr_foreman'],
		show_in_parent_stats = true,
		bonusstats = {mod_collect = 0.33}
	},
	hunter= {#obsolete, not remove
		code = 'hunter',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],#'e_tr_hunter'],
		bonusstats = {mod_hunt = 0.5, mod_fish = 0.5}
	},
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
	berserker = {
		code = 'berserker',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_bers1', 'e_tr_bers2', 'e_tr_berserk'],
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
	smith = {
		code = 'smith',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],#'e_tr_smith'],
		show_in_parent_stats = true,
		bonusstats = {mod_smith = 1.0, mod_tailor = 1.0}
	},
	engineer = {
		code = 'engineer',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [],#'e_tr_engi'],
		bonusstats = {mod_build = 1.0}
	},
	chef = {
		code = 'chef',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [],#'e_tr_chef'],
		bonusstats = {mod_cook = 1.0}
	},
	attendant = {#item usage in combat takes no turn
		code = 'attendant',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_attendant'],
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
	alchemist = {#+100% alchemy production, potions restore 25% more
		code = 'alchemist',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [#'e_tr_alchemist',
			'e_tr_potion'],
		bonusstats = {}
	},
	healer1 = {#+25% heal spells efficiency
		code = 'healer1',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_healer'],
		bonusstats = {}
	},
	healer2 = {#+25% heal spells efficiency
		code = 'healer2',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = ['e_tr_healer'], #static effects and triggers are infinite stackable - so the same as in healer
		bonusstats = {}
	},
	witcrit = {#+crit
		code = 'witcrit',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_witcrit'],
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
	deathknight = {
		code = 'deathknight',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_deathknight'],
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
	farmer = {#+50% farm production
		code = 'farmer',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [],#'e_tr_cattle'],
		bonusstats = {mod_farm = 0.5}
	},
	breeder = {#+100% farm production, allows breeding with any race, -30% pregnancy duration
		code = 'breeder',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_breeder'],
		tags = ['breeder']
	}, #second and third effects need to be hardcoded
	harlot = {#+50% gold from prostitution
		code = 'harlot',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		show_in_parent_stats = true,
		effects = [],#'e_tr_harlot'],
		bonusstats = {mod_pros = 0.5}
	},
	broken_royalty = {#
		code = 'broken_royalty',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
		show_in_parent_stats = true,
		bonusstats = {mod_pros = 1.5}
	},
	succubus = {#+100% exp from prostitution
		code = 'succubus',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],
	}, #hardcoded
	true_succubus = {
		code = 'true_succubus',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['succubus_passive'],
	}, 
	pet = {#+25% gold from prostitution
		code = 'pet',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],#'e_tr_pet'],
		show_in_parent_stats = true,
		bonusstats = {mod_pros = 0.2} 
	}, #not used
	sextoy = {#+50% gold from prostitution
		code = 'sextoy',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = [],#'e_tr_harlot'],
		show_in_parent_stats = true,
		bonusstats = {mod_pros = 0.5}
	},
	renown = {
		code = 'renown',
		name = '',
		descript = '',
		visible = false,
		icon = null,
		effects = ['e_tr_renown']
	},
	
	#skill related traits
	
	basic_combat = {#allows learning basic combat skills
		code = 'basic_combat',
		name = '',
		descript = '',
		visible = true,
		icon = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_combat.png"),
		effects = [],
		tags = ['simple_icon']
	},
	advanced_combat = {#allows learning advanced (aoe) combat skills
		code = 'advanced_combat',
		name = '',
		descript = '',
		visible = true,
		icon = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_combat.png"),
		effects = [],
		tags = ['simple_icon']
	},
	basic_spells = {#allows learning basic combat spells
		code = 'basic_spells',
		name = '',
		descript = '',
		visible = true,
		icon = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_basic_spells.png"),
		effects = [],
		tags = ['simple_icon']
	},
	advanced_spells = {#allows learning advanced (aoe) combat spells
		code = 'advanced_spells',
		name = '',
		descript = '',
		visible = true,
		icon = load("res://assets/Textures_v2/CLASS_INFO/Skills Icons/icon_advanced_spells.png"),
		effects = [],
		tags = ['simple_icon']
	},
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
	undead = {
		code = 'undead',
		name = '',
		descript = '',
		icon = "res://assets/images/iconsskills/trait_undead.png",
		visible = true,
		effects = [],
		tags = ['neutral', 'permanent']
	},
	
	#new ones
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
		tags = ['positive', 'can_start']
	},
	passive = {
		code = 'passive',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/fist.png",
		effects = [],
		bonusstats = {obedience_drain = -5},
		weight = 100,
		conflicts = ['rebel'],
		reqs = [{code = 'is_master', check = false}],
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
	},
	bawdy = {
		code = 'bawdy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/bed.png",
		effects = [],
		weight = 100,
		tags = ['positive', 'can_start'],
		conflicts = ['chaste', 'frigid'],
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
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
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
		tags = ['positive', 'can_start']
	},
	gifted = {
		code = 'gifted',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = ['e_tr_gifted'],
		bonusstats = {},
		weight = 100,
		conflicts = ['magicmutt'],
		tags = ['positive', 'can_start']
	},
	belligerent = {
		code = 'belligerent',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/sword.png",
		effects = ['e_tr_bell'],
		bonusstats = {},
		weight = 100,
		tags = ['positive', 'can_start']
	},
	hiddenpowers = {
		code = 'hiddenpowers',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/scepter.png",
		effects = ['e_tr_hidpow'],
		bonusstats = {},
		weight = 100,
		conflicts = ['m_inept'],
		tags = ['positive', 'can_start']
	},
	healthy = {
		code = 'healthy',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/hand.png",
		effects = ['e_tr_healthy'],
		bonusstats = {},
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
		tags = ['negative']
	},
	rebel = {
		code = 'rebel',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/fist.png",
		effects = [],
		bonusstats = {obedience_drain = 5}, 
		weight = 100,
		conflicts = ['passive'],
		tags = ['negative']
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
		tags = ['negative']
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
		tags = ['negative']
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
		tags = ['negative']
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
		tags = ['negative']
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
		tags = ['negative']
	},
	magicmutt = {
		code = 'magicmutt',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/brain.png",
		effects = ['e_tr_mm'],
		bonusstats = {},
		weight = 100,
		conflicts = ['gifted'],
		tags = ['negative']
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
		tags = ['negative'],# 'no_collect']
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
		tags = ['negative'],# 'no_craft']
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
		tags = ['negative'],# 'no_whoring']
	},
	pacifist = {
		code = 'pacifist',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/pacific.png",
		effects = ['e_tr_pacifist'],
		bonusstats = {},
		weight = 100,
		tags = ['negative'],# 'no_combat']
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
		tags = ['negative', 'no_task_crit']
	},
	whimp = {
		code = 'whimp',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/sword.png",
		cross = true,
		effects = ['e_tr_whimp'],
		bonusstats = {},
		weight = 100,
		tags = ['negative'],# 'no_combat_skills']
	},
	m_inept = {
		code = 'm_inept',
		name = '',
		descript = '',
		visible = true,
		icon = "res://assets/images/iconstraits/scepter.png",
		cross = true,
		effects = ['e_tr_minept'],
		bonusstats = {},
		weight = 100,
		conflicts = ['mvortex', 'hiddenpowers'],
		tags = ['negative'],# 'no_combat_spells']
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
		tags = ['negative', 'no_combat_support']
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
		tags = ['negative'],# 'no_social_skills']
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
		weight = 100,
		conflicts = ['bawdy'],
		tags = ['negative', 'no_sex_traits']
	},
	#master
	master_mentor = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_mentorship.png",
		effects = [],
		bonusstats = {},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 1, y = 0.5}, #fix
		tags = ['loyalty_master', 'mentor'],
	},
	master_harlotry = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_harlotry.png",
		effects = [],
		bonusstats = {mod_pros = 1.2},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 4, y = 0.5}, #fix
		tags = ['loyalty_master', 'harlotry'],
	},
	master_progenecy = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_progenecy.png",
		effects = [],
		bonusstats = {},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 7, y = 0.5}, #fix
		tags = ['loyalty_master', 'breeder'],
	},
	master_communicative = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_communicative.png",
		effects = [],
		bonusstats = {},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 1, y = 3}, #fix
		tags = ['loyalty_master', 'communicative'],
	},
	master_resilence = {
		name = '',
		descript = '',
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
		tree_position = {tab = 3, x = 4, y = 3}, #fix
		tags = ['loyalty_master'],
	},
	master_fortune = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_fortune.png",
		effects = [],
		bonusstats = {critchance = 25, magic_find = 1},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 7, y = 3}, #fix
		tags = ['loyalty_master'],
	},
	master_int = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_intelligence.png",
		effects = [],
		bonusstats = {exp_gain_mod = 0.1},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 1, y = 6}, #fix
		tags = ['loyalty_master', 'intelligence'],
	},
	master_fortitude = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_fortitude.png",
		effects = [],
		bonusstats = {hp_reg_mod = 3},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 4, y = 6}, #fix
		tags = ['loyalty_master', 'fastheal'],
	},
	master_sorcery = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_sorcery.png",
		effects = ['e_tr_sorcerer'],
		bonusstats = {mp_reg_add = 1.5},
		reqs = [],
		l_cost = 1,
		tree_position = {tab = 3, x = 7, y = 6}, #fix
		tags = ['loyalty_master'],
	},
	#loyalty
	loyalty_basic_servitude = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_hand2.png",
		effects = [],
		bonusstats = {obedience_drain = -5},
		reqs = [],
		l_cost = 10,
		tree_position = {tab = 1, x = 4, y = 0.5},
		tags = ['loyalty', 'basic_servitude'],
		bind_trait = [] # test solution for price decreasing traits mechanic
	},
	loyalty_dating = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_date.png",
		effects = [],
		bonusstats = {obedience_drain = -1, loyalty_gain = 0.5},
		reqs = [],
		l_cost = 15,
		tree_position = {tab = 1, x = 1, y = 0.5},
		tags = ['loyalty', 'dating']
	},
	loyalty_combatant = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_sword.png",
		effects = [],
		bonusstats = {obedience_drain = -2, price = 20},
		reqs = [],
		l_cost = 20,
		tree_position = {tab = 1, x = 7, y = 0.5},
		tags = ['loyalty', 'combatant']
	},
	loyalty_dress_lewd = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_dress2.png",
		effects = [],
		bonusstats = {price = 20},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 30,
		tree_position = {tab = 1, x = 0.5, y = 3},
		tags = ['loyalty', 'dress_lewd']
	},
	loyalty_dress_work = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_dress.png",
		effects = [],
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 20,
		tree_position = {tab = 1, x = 2.5, y = 3},
		tags = ['loyalty', 'dress_work']
	},
	loyalty_bodmod = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_bodmod.png",
		effects = [],
		bonusstats = {price = 15},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 25,
		tree_position = {tab = 1, x = 7, y = 3},
		tags = ['loyalty', 'body_mod']
	},
	loyalty_exhibitionism = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_exhibit.png",
		effects = ['e_ltr_exhibit'],
		bonusstats = {mod_pros = 0.15, price = 25},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 35,
		tree_position = {tab = 2, x = 1, y = 0.5},
		tags = ['loyalty', 'exhibit']
	},
	loyalty_adv_servitude = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_hand.png",
		effects = [],
		bonusstats = {obedience_drain = -4, price = 15},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 30,
		tree_position = {tab = 1, x = 3, y = 5},
		tags = ['loyalty', 'adv_servitude']
	},
	loyalty_callmaster = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_crown.png",
		effects = [],
		bonusstats = {obedience_drain = -3, price = 25},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 50,
		tree_position = {tab = 1, x = 5, y = 5},
		tags = ['loyalty', 'callmaster']
	},
#	loyalty_swear = {
#		name = '',
#		descript = '',
#		icon = "res://assets/images/iconstraits/l_crown2.png",
#		effects = [],
#		bonusstats = {obedience_drain = -5, loyalty_gain = 1, pricemod = -0.3},
#		reqs = [{code = 'trait', trait = 'loyalty_adv_servitude', check = true}, {code = 'trait', trait = 'loyalty_callmaster', check = true}],
#		l_cost = 65,
#		tree_position = {tab = 1, x = 4, y = 7.5},
#		tags = ['loyalty', 'swear_loyalty']
#	},
#	loyalty_soulbind = {
#		name = '',
#		descript = '',
#		icon = "res://assets/images/iconstraits/l_collar.png",
#		effects = [], #hardcoded
#		reqs = [],
#		bonusstats = {pricemod = -0.9}, #hardcoded, due to be only one non-market pricemod bonus
#		#hide_reqs = [{code = 'has_profession', profession = 'dominator', check = false, master_check = true}],
#		l_cost = 50,
#		tree_position = {tab = 1, x = 7,y = 5},
#		tags = ['loyalty', 'soulbind']
#	},
	loyalty_sex_basic = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_sex.png",
		effects = [],
		bonusstats = {price = 30},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 30,
		tree_position = {tab = 2, x = 4, y = 0.5},
		tags = ['loyalty', 'sex_basic']
	},
	loyalty_sex_oral = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_oral.png",
		effects = [],
		bonusstats = {mod_pros = 0.1, price = 30},
		reqs = [{code = 'trait', trait = 'loyalty_sex_basic', check = true}],
		l_cost = 30,
		tree_position = {tab = 2, x = 3, y = 3},
		tags = ['loyalty', 'sex_oral']
	},
	loyalty_sex_anal = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_anal.png",
		effects = [],
		bonusstats = {mod_pros = 0.1, price = 35},
		reqs = [{code = 'trait', trait = 'loyalty_sex_basic', check = true}], 
		l_cost = 35,
		tree_position = {tab = 2, x = 5, y = 3},
		tags = ['loyalty', 'sex_anal']
	},
	loyalty_sex_adv = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_doggy.png",
		effects = [],
		bonusstats = {mod_pros = 0.15, price = 45},
		reqs = [{code = 'trait', trait = 'loyalty_sex_basic', check = true}],
		l_cost = 45,
		tree_position = {tab = 2, x = 4, y = 5},
		tags = ['loyalty', 'sex_adv']
	},
	loyalty_sex_perv = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_69.png",
		effects = [],
		bonusstats = {mod_pros = 0.25, price = 60},
		reqs = [{code = 'trait', trait = 'loyalty_sex_adv', check = true}],
		l_cost = 60,
		tree_position = {tab = 2, x = 3, y = 7},
		tags = ['loyalty', 'sex_perv']
	},
	loyalty_sex_group = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_group.png",
		effects = [],
		bonusstats = {mod_pros = 0.2, price = 60},
		reqs = [{code = 'trait', trait = 'loyalty_sex_basic', check = true}],
		l_cost = 60,
		tree_position = {tab = 2, x = 7, y = 7},
		tags = ['loyalty', 'sex_group']
	},
	loyalty_prostitution = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pros.png",
		effects = [],
		bonusstats = {mod_pros = 0.15, price = 15},
		reqs = [{code = 'trait', trait = 'loyalty_basic_servitude', check = true}],
		l_cost = 35,
		tree_position = {tab = 2, x = 1, y = 4},
		tags = ['loyalty', 'prostitution']
	},
	loyalty_pregnancy = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		bonusstats = {price = 25},
		reqs = [{code = 'trait', trait = 'loyalty_sex_basic', check = true}], 
		hide_reqs = [{code = 'sex', operant = 'eq', value = 'male'}],
		l_cost = 50,
		tree_position = {tab = 2, x = 7, y = 0.5},
		tags = ['loyalty', 'keep_baby']
	},
	loyalty_interbreed = {
		name = '',
		descript = '',
		icon = "res://assets/images/iconstraits/l_pregnancy.png",
		effects = [],
		bonusstats = {price = 37}, 
		reqs = [{code = 'trait', trait = 'loyalty_sex_adv', check = true}],  
		l_cost = 75,  
		tree_position = {tab = 2, x = 7, y = 4},
		tags = ['loyalty', 'breeder']
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
	for prof in slave_profs:
		slave_profs[prof].code = prof
		slave_profs[prof].name = 'SLAVEPROFNAME_' + prof.trim_prefix('slave_').to_upper()
		slave_profs[prof].descript = 'SLAVEPROFDESCRIPT_' + prof.trim_prefix('slave_').to_upper()


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

var slave_profs = {
	slave_combat = {
		name = '',
		desc = '',
		icon = "res://assets/images/iconstraits/l_warrior.png",
		icon_small = "res://assets/images/iconstraits/l_warrior_prt.png",
		tree_position = {tab = 1, x = 0.5, y = 7.5},
		effects = [],
		bonusstats = {atk = 1, hitrate = 2},
		tags = ['swear_loyalty'],
		reqs = [
			{code = 'stat_in_set', stat = 'personality', value = ['bold', 'serious']},
			{code = 'stat', stat = 'metrics_win', operant = 'gte', value = 3}
		]
	},
	slave_service = {
		name = '',
		desc = '',
		icon = "res://assets/images/iconstraits/l_maidu.png",
		icon_small = "res://assets/images/iconstraits/l_maidu_prt.png",
		tree_position = {tab = 1, x = 2.5, y = 7.5},
		effects = [],
		bonusstats = {productivity = 0.01, evasion = 2, speed = 1},
		tags = ['swear_loyalty'],
		reqs = [
			{code = 'stat_in_set', stat = 'personality', value = ['bold', 'kind']},
			{code = 'stat', stat = 'metrics_serviceperformed', operant = 'gte', value = 12}
		]
	},
	slave_prestige = {
		name = '',
		desc = '',
		icon = "res://assets/images/iconstraits/l_prestige.png",
		icon_small = "res://assets/images/iconstraits/l_prestige_prt.png",
		tree_position = {tab = 1, x = 4.5, y = 7.5},
		effects = [],
		bonusstats = {critchance = 0.33, critmod = 0.01, price_add = 10}, #not sure about critmod
		tags = ['swear_loyalty'],
		reqs = [
			{code = 'stat_in_set', stat = 'personality', value = ['serious', 'kind']},
			{code = 'stat', stat = 'price', operant = 'gte', value = 1000}
		]
	},
	slave_management = {
		name = '',
		desc = '',
		icon = "res://assets/images/iconstraits/l_protection.png",
		icon_small = "res://assets/images/iconstraits/l_protection_prt.png",
		tree_position = {tab = 1, x = 6.5, y = 7.5},
		effects = ['e_tr_manager'],
		bonusstats = {hpmax = 1, armor = 1},
		tags = ['swear_loyalty'],
		reqs = [
			{code = 'stat_in_set', stat = 'personality', value = ['bold', 'serious']},
			{code = 'stat', stat = 'metrics_socskillused', operant = 'gte', value = 4}
		]
	},
	slave_mage = {
		name = '',
		desc = '',
		icon = "res://assets/images/iconstraits/l_mage.png",
		icon_small = "res://assets/images/iconstraits/l_mage_prt.png",
		tree_position = {tab = 1, x = 2, y = 10},
		effects = [],
		bonusstats = {mpmax = 1, matk = 1},
		tags = ['swear_loyalty'],
		reqs = [
			{code = 'stat_in_set', stat = 'personality', value = ['shy', 'serious']},
			{code = 'stat', stat = 'metrics_spellused', operant = 'gte', value = 4}
		]
	},
	slave_healer = {
		name = '',
		desc = '',
		icon = "res://assets/images/iconstraits/l_healer.png",
		icon_small = "res://assets/images/iconstraits/l_healer_prt.png",
		tree_position = {tab = 1, x = 5, y = 10},
		effects = ['e_tr_healerslave'],
		bonusstats = {mdef = 1},
		tags = ['swear_loyalty'],
		reqs = [
			{code = 'stat_in_set', stat = 'personality', value = ['shy', 'kind']},
			{code = 'stat', stat = 'metrics_healused', operant = 'gte', value = 4}
		]
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
		limit = 1,
		mansion_only = true,
		t_name = 'trait_%s'
	}

func make_buff_for_trait(tr_id):
	var trdata = traits[tr_id]
	if trdata.has('visible') and !trdata.visible: return null
	if !trdata.has('icon'): return null
	if trdata.icon == null: return null
	var template = b_template.duplicate()
	template.icon = trdata.icon.get_path()
	template.description = trdata.descript
	template.t_name = template.t_name % trdata.code
	template.name = template.t_name
	var res = Buff.new(null)
	res.createfromtemplate(template)
	return res
