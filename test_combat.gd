extends Control
var chardata = {
	template = {
		name = "test",
		masteries = [],
		1 : {
			stats = {},
			classes1 = [],
			classes2 = [],
			optional_classes_amount = 1,
			mastery_levels = [],
			items = []
		},
		2 : {
			stats = {},
			classes1 = [],
			classes2 = [],
			optional_classes_amount = 1,
			mastery_levels = [],
			items = []
		},
		3 : {
			stats = {},
			classes1 = [],
			classes2 = [],
			optional_classes_amount = 1,
			mastery_levels = [],
			items = []
		},
		4 : {
			stats = {},
			classes1 = [],
			classes2 = [],
			optional_classes_amount = 1,
			mastery_levels = [],
			items = []
		},
	},
	base_melee = {
		name = "melee",
		masteries = ['warfare', 'protection', 'leadership','fire'],
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['fighter'],
			classes2 = ['rogue', 'archer'],
			optional_classes_amount = 1,
			mastery_levels = [1,2],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		2 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['fighter', 'rogue', 'archer'],
			classes2 = ['knight', 'shieldbearer'],
			optional_classes_amount = 1,
			mastery_levels = [3, 4],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		3 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['fighter', 'rogue', 'archer'],
			classes2 = [['knight', 'deathknight'], ['paladin','shieldbearer']],
			optional_classes_amount = 1,
			mastery_levels = 6,
			items = [['chest_base_metal', 'chest_adv_metal'], ['legs_base_metal', 'legs_adv_metal'], 'shield', ['sword', 'mace', 'battleaxe', 'swordadv', 'spearadv', 'maceadv', 'battleaxeadv', 'club', 'spear']]
		},
		4 : {
			stats = {physics_factor = 6, wits_factor = 3, growth_factor = 5, physics = 120, wits = 100},
			classes1 = ['fighter', 'rogue', 'archer'],
			classes2 = [['knight', 'deathknight','spellsword','arcane_blade',], ['paladin','shieldbearer','templar','monk']],
			optional_classes_amount = 1,
			mastery_levels = 8,
			items = ['chest_adv_metal', 'legs_adv_metal', 'shield', ['swordadv', 'spearadv', 'maceadv', 'battleaxeadv']]
		},
	},
	bers_melee = {
		name = "melee",
		masteries = ['warfare', 'protection', 'leadership','fire'],
		race = 'Orc',
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['fighter', 'berserker'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = [1,2],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		2 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['fighter', 'berserker'],
			classes2 = ['knight', 'shieldbearer'],
			optional_classes_amount = 1,
			mastery_levels = [3, 4],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		3 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['fighter', 'berserker'],
			classes2 = [['knight', 'deathknight'], ['paladin','shieldbearer']],
			optional_classes_amount = 1,
			mastery_levels = 6,
			items = [['chest_base_metal', 'chest_adv_metal'], ['legs_base_metal', 'legs_adv_metal'], 'shield', ['sword', 'mace', 'battleaxe', 'swordadv', 'spearadv', 'maceadv', 'battleaxeadv', 'club', 'spear']]
		},
		4 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 5, physics = 120, wits = 100},
			classes1 = ['fighter', 'berserker', 'rogue', 'archer'],
			classes2 = [['knight', 'deathknight','spellsword','arcane_blade',], ['paladin','shieldbearer','templar','monk']],
			optional_classes_amount = 1,
			mastery_levels = 8,
			items = ['chest_adv_metal', 'legs_adv_metal', 'shield', ['swordadv', 'spearadv', 'maceadv', 'battleaxeadv']]
		},
	},
	dk_melee = {
		name = "melee",
		masteries = ['warfare', 'protection', 'leadership','fire'],
		race = 'Dragonkin',
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['fighter', 'dragonknight'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = [1,2],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		2 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['fighter', 'dragonknight'],
			classes2 = ['knight', 'shieldbearer'],
			optional_classes_amount = 1,
			mastery_levels = [3, 4],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		3 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['fighter', 'dragonknight'],
			classes2 = [['knight', 'deathknight'], ['paladin','shieldbearer']],
			optional_classes_amount = 1,
			mastery_levels = 6,
			items = [['chest_base_metal', 'chest_adv_metal'], ['legs_base_metal', 'legs_adv_metal'], 'shield', ['sword', 'mace', 'battleaxe', 'swordadv', 'spearadv', 'maceadv', 'battleaxeadv', 'club', 'spear']]
		},
		4 : {
			stats = {physics_factor = 6, wits_factor = 3, growth_factor = 5, physics = 120, wits = 100},
			classes1 = ['fighter', 'dragonknight', 'rogue', 'archer'],
			classes2 = [['knight', 'deathknight','spellsword','arcane_blade',], ['paladin','shieldbearer','templar','monk']],
			optional_classes_amount = 1,
			mastery_levels = 8,
			items = ['chest_adv_metal', 'legs_adv_metal', 'shield', ['swordadv', 'spearadv', 'maceadv', 'battleaxeadv']]
		},
	},
	val_melee = {
		name = "melee",
		masteries = ['warfare', 'protection', 'leadership','light'],
		race = 'Seraph',
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['fighter', 'valkyrie'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = [1,2],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		2 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['fighter', 'valkyrie'],
			classes2 = ['knight', 'shieldbearer'],
			optional_classes_amount = 1,
			mastery_levels = [3, 4],
			items = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
		},
		3 : {
			stats = {physics_factor = 5, wits_factor = 3, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['fighter', 'valkyrie'],
			classes2 = [['knight', 'deathknight'], ['paladin','shieldbearer']],
			optional_classes_amount = 1,
			mastery_levels = 6,
			items = [['chest_base_metal', 'chest_adv_metal'], ['legs_base_metal', 'legs_adv_metal'], 'shield', ['sword', 'mace', 'battleaxe', 'swordadv', 'spearadv', 'maceadv', 'battleaxeadv', 'club', 'spear']]
		},
		4 : {
			stats = {physics_factor = 6, wits_factor = 3, growth_factor = 5, physics = 120, wits = 100},
			classes1 = ['fighter', 'valkyrie', 'rogue', 'archer'],
			classes2 = [['knight', 'deathknight','spellsword','arcane_blade',], ['paladin','shieldbearer','templar','monk']],
			optional_classes_amount = 1,
			mastery_levels = 8,
			items = ['chest_adv_metal', 'legs_adv_metal', 'shield', ['swordadv', 'spearadv', 'maceadv', 'battleaxeadv']]
		},
	},
	base_rogue = {
		name = "rogue",
		masteries = ['warfare', 'stealth', 'marksmanship'],
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['rogue'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = [1,2],
			items = ['chest_base_leather', 'legs_base_leather', ['sword', 'dagger']]
		},
		2 : {
			stats = {physics_factor = 4, wits_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['rogue'],
			classes2 = ['assassin', 'ninja'],
			optional_classes_amount = 1,
			mastery_levels = [3, 4],
			items = ['chest_base_leather', 'legs_base_leather', ['sword', 'dagger']]
		},
		3 : {
			stats = {physics_factor = 4, wits_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['rogue', 'assassin', 'ninja'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = [['chest_base_leather', 'chest_adv_leather'], ['legs_base_leather', 'legs_adv_leather'], ['sword', 'dagger', 'swordadv']]
		},
		4 : {
			stats = {physics_factor = 5, wits_factor = 4, growth_factor = 5, physics = 120, wits = 100},
			classes1 = ['rogue', 'assassin', 'ninja','fighter'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = ['chest_adv_leather', 'legs_adv_leather', ['swordadv', 'dagger']]
		},
	},
	base_archer = {
		name = "archer",
		masteries = ['warfare', 'stealth', 'marksmanship'],
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['archer'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = [1,2],
			items = ['chest_base_leather', 'legs_base_leather', ['bow', 'crossbow']]
		},
		2 : {
			stats = {physics_factor = 4, wits_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['archer'],
			classes2 = ['sniper', 'ranger'],
			optional_classes_amount = 1,
			mastery_levels = [3, 4],
			items = ['chest_base_leather', 'legs_base_leather', ['bow', 'crossbow']]
		},
		3 : {
			stats = {physics_factor = 4, wits_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['archer', 'sniper', 'ranger'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = [['chest_base_leather', 'chest_adv_leather'], ['legs_base_leather', 'legs_adv_leather'], ['bow', 'bowadv', 'crossbow', 'crossbowadv']]
		},
		4 : {
			stats = {physics_factor = 5, wits_factor = 4, growth_factor = 5, physics = 120, wits = 100},
			classes1 = ['archer', 'sniper', 'ranger','rogue'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = ['chest_adv_leather', 'legs_adv_leather', ['bowadv', 'crossbowadv']]
		},
	},
	base_support = {
		name = "support",
		masteries = ['light', 'water', 'leadership'],
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['acolyte'],
			classes2 = ['priest', 'monk'],
			optional_classes_amount = 1,
			mastery_levels = [1, 2],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff' ]
		},
		2 : {
			stats = {physics_factor = 3, wits_factor = 4, charm_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['acolyte', 'priest'],
			classes2 = ['monk', 'bishop', 'shaman', 'bard'],
			optional_classes_amount = 2,
			mastery_levels = [2, 3],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff']
		},
		3 : {
			stats = {physics_factor = 3, wits_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['acolyte', 'priest','monk'],
			classes2 = ['shaman', 'bard', 'bishop'],
			optional_classes_amount = 2,
			mastery_levels = [3, 5],
			items = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff', 'staffadv']]
		},
		4 : {
			stats = {physics_factor = 3, wits_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['acolyte', 'priest', 'bishop', 'monk', 'shaman', 'bard'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		},
	},
	bloodmage_caster = { #2add all other top level classes configurations. this is template to adding 1 class, not 2 random as in default generation - for i think that maxed casters were too powerful
		name = "caster_bloodmage",
		masteries = ['fire', 'water', 'earth', 'air', 'dark', 'mind'], #adjust properly
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, magic_factor = 2, growth_factor = 3, physics = 20, wits = 20},
			classes1 = [],
			classes2 = ['apprentice', 'caster', 'scholar'], #i can't add all proper combinations for caster classes into data - so they are simplified A LOT. a proper data is about 10 times larger
			optional_classes_amount = 2,
			mastery_levels = [1, 2],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff' ]
		},
		2 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 3, charm_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['caster'],
			classes2 = [['apprentice', 'scholar', 'archmage'], ['apprentice', 'shaman'], ['scholar', 'shaman']],
			optional_classes_amount = 1,
			mastery_levels = [2, 3],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff']
		},
		3 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['caster','bloodmage'],
			classes2 = ['apprentice', 'scholar', 'archmage', 'shaman'],
			optional_classes_amount = 3,
			mastery_levels = [3, 5],
			items = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff', 'staffadv']]
		},
		4 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['caster','bloodmage', 'apprentice', 'scholar', 'archmage', 'shaman'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		},
	},
	witch_caster = { 
		name = "caster_witch",
		sex = 'female',
		masteries = ['fire', 'water', 'earth', 'air', 'dark', 'mind'], #adjust properly
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, magic_factor = 2, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['apprentice', 'witch'],
			classes2 = ['caster', 'scholar'], 
			optional_classes_amount = 1,
			mastery_levels = [1, 2],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff' ]
		},
		2 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 3, charm_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['apprentice', 'witch', 'caster'],
			classes2 = ['scholar', 'shaman'],
			optional_classes_amount = 1,
			mastery_levels = [2, 3],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff']
		},
		3 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['apprentice', 'witch', 'caster'],
			classes2 = [['scholar', 'archmage'], ['scholar', 'shaman']],
			optional_classes_amount = 1,
			mastery_levels = [3, 5],
			items = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff', 'staffadv']]
		},
		4 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['apprentice', 'witch', 'caster', 'scholar', 'archmage', 'shaman'],
			classes2 = ['bloodmage', 'necromancer'],
			optional_classes_amount = 1,
			mastery_levels = 6,
			items = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		},
	},
	druid_caster = { 
		name = "caster_druid",
		race = ['Elf', 'Dryad', 'Fairy', 'DarkElf', 'TribalElf'],
		masteries = ['fire', 'water', 'earth', 'air', 'dark', 'mind'], #adjust properly
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, magic_factor = 2, growth_factor = 3, physics = 20, wits = 20},
			classes1 = ['druid'],
			classes2 = ['scholar', 'apprentice'], 
			optional_classes_amount = 1,
			mastery_levels = [1, 2],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff' ]
		},
		2 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 3, charm_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['druid', 'caster'],
			classes2 = ['scholar', 'shaman', 'apprentice'],
			optional_classes_amount = 2,
			mastery_levels = [2, 3],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff']
		},
		3 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['druid', 'caster'],
			classes2 = [['scholar', 'archmage', 'apprentice'], ['scholar', 'shaman'], ['apprentice', 'shaman']],
			optional_classes_amount = 1,
			mastery_levels = [3, 5],
			items = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff', 'staffadv']]
		},
		4 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['apprentice', 'druid', 'caster', 'scholar', 'archmage', 'shaman'],
			classes2 = ['bloodmage', 'necromancer'],
			optional_classes_amount = 1,
			mastery_levels = 6,
			items = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		},
	},
	warlock_caster = { 
		name = "caster_warlock",
		sex = 'male',
		masteries = ['fire', 'water', 'earth', 'air', 'dark', 'mind'], #adjust properly
		1 : {
			stats = {physics_factor = 3, wits_factor = 3, magic_factor = 2, growth_factor = 3, physics = 20, wits = 20},
			classes1 = [],
			classes2 = ['apprentice', 'caster', 'scholar'], #i can't add all proper combinations for caster classes into data - so they are simplified A LOT. a proper data is about 10 times larger
			optional_classes_amount = 2,
			mastery_levels = [1, 2],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff' ]
		},
		2 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 3, charm_factor = 4, growth_factor = 4, physics = 60, wits = 60},
			classes1 = ['caster'],
			classes2 = [['apprentice', 'scholar', 'archmage'], ['apprentice', 'shaman'], ['scholar', 'shaman']],
			optional_classes_amount = 1,
			mastery_levels = [2, 3],
			items = ['chest_base_cloth', 'legs_base_cloth', 'staff']
		},
		3 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['caster','warlock'],
			classes2 = ['apprentice', 'scholar', 'archmage', 'shaman'],
			optional_classes_amount = 3,
			mastery_levels = [3, 5],
			items = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff', 'staffadv']]
		},
		4 : {
			stats = {physics_factor = 3, wits_factor = 4, magic_factor = 4, charm_factor = 4, growth_factor = 5, physics = 100, wits = 100},
			classes1 = ['caster','warlock', 'apprentice', 'scholar', 'archmage', 'shaman'],
			classes2 = [],
			optional_classes_amount = 0,
			mastery_levels = 6,
			items = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		},
	},
}

#Fixed parties, listed in selector2 after the levels. Nothing in them is rolled: race, sex, classes,
#masteries, gear parts and enchants are the same every run, so damage numbers compare between runs.
var party_presets = {
	#Endgame damage test: pure physical melee in front, dark casters behind.
	#Front: no magic class at all, so every weapon hit is (Physical, Normal). Knight is +15% melee
	#damage, sniper multiplies single target skills by 1.25, assassin adds crit damage. The master is also
	#the ruler (leadership 4: Inspire +20% damage for the whole party, Leader's Mark x1.15 damage taken)
	#and a dragonknight (Dragon's Might +25%); the orc is a berserker, whose kills grant another action;
	#the cat fights in medium armor because Hide, which Assassinate needs, is not allowed in heavy.
	#Back: two dark casters and a bishop. Malediction curses (-40 dark resist), Pacify puts Luminance on
	#the target (-50 dark resist), Radiance shatters (-25% mdef) - none of it touches physical damage.
	#What the front gives the back: Back Kick silences and Execution frightens, and a silenced or
	#frightened target takes x1.15 from every occultist.
	#unlock_class() checks no class conflicts (knight vs shieldbearer, bishop vs occultist and
	#necromancer), so keep the class lists legal by hand.
	dark_magic = {
		kits = {
			melee = {
				#serious personality is -1 combat cooldown on skills above 1; wits factor 4 is the assassin's requirement
				stats = {physics_factor = 6, wits_factor = 4, magic_factor = 3, charm_factor = 3, growth_factor = 6,
					physics = 100, wits = 100, personality_kind = -100, personality_bold = 0},
				#two starting traits, then the minor trainings a physical fighter gets anything from
				traits = ['belligerent', 'deadly', 'table_manners', 'penmanship', 'courtly_arms'],
				food = 'e_food_roasted_feast',
				#physics potion: +80 until the next world turn
				buffs = ['e_i_physbuf'],
				items = [
					#adamantine blade for atk; the fire ruby gem is armor penetration
					{base = 'swordadv', parts = {Blade = 'adamantine', WeaponHandle = 'bonedragon', WeaponEnc = 'fire_ruby'}, curse = 'decline_major',
						enchants = {sharpness = 4, reaper = 3, beasthunter = 3, undeadbane = 3, giantslayer = 3}},
					#fire ruby armor gems are +melee damage. No vampirism: a draining hit is logged as
					#"drained N health", without its damage type
					{base = 'chest_adv_metal', parts = {ArmorBaseHeavy = 'adamantine', ArmorTrim = 'bonedragon', ArmorEnc = 'fire_ruby'},
						enchants = {carapace = 5, nimble = 3, commander = 2}},
					{base = 'legs_adv_metal', parts = {ArmorBaseHeavy = 'adamantine', ArmorTrim = 'bonedragon', ArmorEnc = 'fire_ruby'},
						enchants = {carapace = 5, nimble = 3}},
					{base = 'earrings'},
					{base = 'gauntlets'},
				],
			},
			caster = {
				#magic factor 6 is +10% matk; serious personality is -1 combat cooldown on skills above 1
				stats = {physics_factor = 3, wits_factor = 5, magic_factor = 6, charm_factor = 3, growth_factor = 6,
					physics = 100, wits = 100, personality_kind = -100, personality_bold = 0},
				traits = ['hiddenpowers', 'deadly', 'etiquette', 'foreign_diplomacy', 'history'],
				food = 'e_food_fishcakes',
				buffs = ['e_i_witsbuf'],
				items = [
					#obsidian in the staff gem is the +dark damage part, ice crystal in the armor gems is crit
					{base = 'staffadv', parts = {Rod = 'bonedragon', WeaponHandle = 'obsidian', WeaponEnc = 'obsidian'}, curse = 'decline_major',
						enchants = {spell_mastery = 4, reaper = 3, beasthunter = 3, undeadbane = 3, giantslayer = 3}},
					{base = 'chest_adv_cloth', parts = {ArmorBaseCloth = 'clothethereal', ArmorTrim = 'clothmagic', ArmorEnc = 'ice_crystal'},
						enchants = {warlock = 4, carapace = 5, nimble = 3, commander = 2}},
					{base = 'legs_adv_cloth', parts = {ArmorBaseCloth = 'clothethereal', ArmorTrim = 'clothmagic', ArmorEnc = 'ice_crystal'},
						enchants = {carapace = 5, nimble = 3}},
					{base = 'circlet'},
				],
			},
		},
		heroes = [
			#a master point buys Master Fortune; the sacred scales are a one-off act 4 reward
			{name = 'ruler_dragonknight', kit = 'melee', race = 'Dragonkin', sex = 'male', masteries = {warfare = 8, stealth = 8},
				traits = ['master_fortune'], items = [{base = 'sacred_scales'}],
				classes = ['ruler', 'fighter', 'knight', 'dragonknight', 'archer', 'sniper', 'rogue', 'assassin']},
			#berserker disables the stealth and protection masteries, so marksmanship is the second school
			{name = 'orc_berserker', kit = 'melee', race = 'Orc', sex = 'male', masteries = {warfare = 8, marksmanship = 8},
				classes = ['fighter', 'knight', 'berserker', 'archer', 'sniper', 'rogue', 'assassin']},
			{name = 'cat_assassin', kit = 'melee', race = 'HalfkinCat', sex = 'female', masteries = {stealth = 8, warfare = 8},
				classes = ['fighter', 'knight', 'rogue', 'assassin', 'thief', 'ninja', 'archer', 'sniper'],
				#medium armor in place of the kit's heavy set, for Hide
				items = [
					{base = 'chest_adv_leather', parts = {ArmorBaseMed = 'leatherdragon', ArmorTrim = 'bonedragon', ArmorEnc = 'fire_ruby'},
						enchants = {carapace = 5, nimble = 3, commander = 2}},
					{base = 'legs_adv_leather', parts = {ArmorBaseMed = 'leatherdragon', ArmorTrim = 'bonedragon', ArmorEnc = 'fire_ruby'},
						enchants = {carapace = 5, nimble = 3}},
				]},
			{name = 'darkelf_warlock', kit = 'caster', race = 'DarkElf', sex = 'male', masteries = {dark = 8},
				classes = ['apprentice', 'scholar', 'caster', 'archmage', 'occultist', 'necromancer', 'warlock', 'shaman']},
			{name = 'darkelf_witch', kit = 'caster', race = 'DarkElf', sex = 'female', masteries = {dark = 8},
				classes = ['apprentice', 'scholar', 'caster', 'archmage', 'occultist', 'necromancer', 'witch', 'shaman']},
			{name = 'darkelf_bishop', kit = 'caster', race = 'DarkElf', sex = 'male', masteries = {dark = 8, light = 2},
				classes = ['acolyte', 'priest', 'caster', 'bishop', 'apprentice', 'scholar', 'archmage', 'warlock']},
		],
	},
}


#not an enemy group: a fight rolled the way the tower rolls one on this floor, elites only
const TOWER_ELITES = 'tower_100_elites'
#counted the way the dungeon screen shows it, from 1
const TOWER_FLOOR = 100

var combatlist = []

func _ready():
	variables.allow_remote_intereaction = true
	$test.connect("pressed", self, 'run_test')
	
	for id in ['weak', 'medium', 'strong', 'maxed']:
		$selector2.add_item(id)
	for id in party_presets:
		$selector2.add_item(id)
#	setup_player()
	for id in Enemydata.enemygroups:
		combatlist.push_back(id)
	
	combatlist.sort()
	combatlist.push_front(TOWER_ELITES)

	for i in combatlist:
		$selector.add_item(i)


func setup_player_test():
	var character = ResourceScripts.scriptdict.class_slave.new("test_main_real")
	character.create('Nereid', 'male', 'random')
	character.fill_boosters()
	character.unlock_class("master")
	characters_pool.move_to_state(character.id)
	#character.armor = 135
	#character.set_stat('wits', 20)
	character.set_stat('consent', 5)
	character.set_stat('charm_factor', 2)
	character.set_stat('physics_factor', 6)
	character.set_stat('sexuals_factor', 6)
	#character.set_stat('wits_factor', 5)
	character.set_stat('food_love', "meat")
	character.set_stat('charm', 100)
	character.set_stat('wits', 100)
#	character.add_stat('wits', 100)
	character.add_stat('hpmax', 100)
	
	character.set_stat('height', 'average')
	character.xp_module.base_exp = 1500
#	character.add_stat('abil_exp', 1500)
	character.add_stat('resist_normal', 50)
	character.add_stat('damage_reduction', 50)
	character.add_stat('mastery_point_universal', 90)
	character.set_stat('personality_kind', 100)
	character.set_stat('personality_bold', 50)
	var bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'poor', false)
	globals.AddItemToInventory(bow)
	bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'average', false)
	globals.AddItemToInventory(bow)
	bow = globals.CreateGearItemQuality("bow", {WeaponHandle = 'wood', BowBase = 'obsidian'}, 'legendary', false)
	globals.AddItemToInventory(bow)
	character.equip(bow)
	character.set_slave_category('master')
	character.get_random_traits()
	
#	character.unlock_class("worker")
	character.unlock_class("necromancer")
#	character.unlock_class("caster")
	character.unlock_class("worker")
	character.unlock_class("apprentice")
#	character.unlock_class("assassin")
	character.unlock_class("rogue")
	character.is_players_character = true
	
	globals.common_effects(
			[
				{code = 'make_story_character', value = 'Daisy'},
				{code = 'make_story_character', value = 'Cali'},
				{code = 'make_story_character', value = 'Aire'},
				{code = 'make_story_character', value = 'Jean'},
				{code = 'make_story_character', value = 'Zephyra'},
				{code = 'make_story_character', value = 'Anastasia'},
				{code = 'make_story_character', value = 'Kuro'},
				{code = 'make_story_character', value = 'Lilia'},
			]
		)


func run_test():
	variables.anim_sandbox = $sandbox.pressed
	variables.anim_trace = $trace.pressed
	ResourceScripts.game_res.materials.trap = 50
	ResourceScripts.game_res.materials.bandage = 50
	ResourceScripts.game_res.materials.unstable_concoction = 50
	input_handler.active_location = {
		group = {},
		id = 'aliron',
		}
	setup_player()
	globals.char_roll_data.no_roll = true
	if combatlist[$selector.selected] == TOWER_ELITES:
		#open() has just reset the confirm call; this sets ours
		input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS).open_defined(input_handler.active_location.group, self, 'start_tower_elites')
		return
	var enc_template = {unittype = 'randomgroup', unitcode = combatlist[$selector.selected], bg = 'default', bgm = 'default', win_effects = [], lose_effects = [], enemy_stats_mod = float($mod1.text)}
	Enemydata.encounters.combat_test = enc_template
	globals.current_enemy_group = 'combat_test'
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS)


func make_item(id, level):
	var q
	var t
	var item
	match level:
		1:
			q = input_handler.random_from_array(['poor', 'average'])
			t = input_handler.random_from_array(['t1', 't2'])
			item = globals.CreateGearItemQuality(id, t, q)
		2:
			q = input_handler.random_from_array(['average', 'good'])
			t = input_handler.random_from_array(['t3', 't4'])
			item = globals.CreateGearItemQuality(id, t, q , false)
		3:
			q = input_handler.random_from_array(['epic', 'legendary'])
			t = input_handler.random_from_array(['t5', 't6'])
			item = globals.CreateGearItemQuality(id, t, q , false)
		4:
			q = 'legendary'
			t = 't6'
			item = globals.CreateGearItemQualityEnchants(id, t, q)
	globals.AddItemToInventory(item, false)
	return item


func make_hero(type, level, position = 1, first = false):
	var character = ResourceScripts.scriptdict.class_slave.new("test_combat")
	character.create(input_handler.random_from_array(races.racelist.keys()), input_handler.random_from_array(['male', 'female']), 'random')
	character.fill_boosters()
	characters_pool.move_to_state(character.id)
#	character.set_stat('food_love', "meat")
#	character.set_stat('food_hate', ["grain"])
#	character.set_stat('consent', 5)
	character.add_stat('mastery_point_universal', 50)
	character.is_players_character = true
	character.set_stat('wits', 20)
	character.set_stat('physics', 20)
	if first:
		character.unlock_class("master")
		character.set_slave_category('master')
	else:
		character.set_slave_category('servant')
		character.add_trait('training_s_combat')
	var nm
	var e_list
	if level > 1:
		character.set_stat('wits', 60)
		character.set_stat('physics', 60)
	if level > 2:
		character.set_stat('wits', 100)
		character.set_stat('physics', 100)
	match type:
		'fighter':
			character.set_stat('physics_factor', 3)
			character.set_stat('wits_factor', 3)
			nm = 'melee'
			var pool1 := ['fighter']
			var pool2 := ['rogue', 'archer']
			var pool3 := {warfare = 0, protection = 0, leadership = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(1, 2)
			match character.get_stat('race'):
				'Orc':
					pool2.push_back('berserker')
				'Dragonkin':
					pool2.push_back('dragonknight')
				'Seraph':
					if character.get_stat('sex') == 'female':
						pool2.push_back('valkyrie')
			if level > 1:
				character.set_stat('physics_factor', 5)
				pool1.append_array(pool2)
				pool2 = ['knight', 'shieldbearer']
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(3, 4)
			if level > 2:
				pool2 = [['knight', 'deathknight'], ['paladin','shieldbearer']]
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
				if level < 3:
					nm += '_' + prof
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				if roll is Array:
					for prof in roll:
						character.unlock_class(prof, true) 
						if level < 3:
							nm += '_' + prof
				else:
					character.unlock_class(roll, true) 
					if level < 3:
						nm += '_' + roll
			if level > 2:
				nm += '_maxed'
			for mas in pool3:
				for i in range(pool3[mas]):
					character.upgrade_mastery(mas, true)
			match level:
				1:
					e_list = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
				2:
					e_list = ['chest_base_metal', 'legs_base_metal', 'shield', ['sword', 'mace', 'battleaxe', 'club', 'spear']]
				3:
					e_list = [['chest_base_metal', 'chest_adv_metal'], ['legs_base_metal', 'legs_adv_metal'], 'shield', ['sword', 'mace', 'battleaxe', 'swordadv', 'spearadv', 'maceadv', 'battleaxeadv', 'club', 'spear']]
				4:
					e_list = ['chest_adv_metal', 'legs_adv_metal', 'shield', ['swordadv', 'spearadv', 'maceadv', 'battleaxeadv']]
		'rogue':
			character.set_stat('physics_factor', 3)
			character.set_stat('wits_factor', 3)
			nm = 'rogue'
			var pool1 := ['rogue', 'archer']
			var pool2 := []
			var pool3 := {warfare = 0, stealth = 0, marksmanship = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(1, 2)
			if level > 1:
				character.set_stat('physics_factor', 4)
				character.set_stat('wits_factor', 4)
				pool2 = ['assassin', 'ninja', 'sniper', 'ranger']
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(3, 4)
			if level > 2:
				pool1.append_array(pool2)	
				pool2 = []
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				character.unlock_class(roll, true) 
				if level < 3:
					nm += '_' + roll
			if level > 2:
				nm += '_maxed'
			#, ['dagger', 'bow', 'bowadv', 'crossbow', 'crossbowadv']
			for mas in pool3:
				for i in range(pool3[mas]):
					character.upgrade_mastery(mas, true)
			match level:
				1:
					e_list = ['chest_base_leather', 'legs_base_leather']
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bow', 'crossbow'])
				2:
					e_list = ['chest_base_leather', 'legs_base_leather']
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bow', 'crossbow'])
				3:
					e_list = [['chest_base_leather', 'chest_adv_leather'], ['legs_base_leather', 'legs_adv_leather']]
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bow', 'bowadv', 'crossbow', 'crossbowadv'])
				4:
					e_list = ['chest_adv_leather', 'legs_adv_leather']
					if position < 4:
						e_list.push_back('dagger')
					else:
						e_list.push_back(['bowadv', 'crossbowadv'])
			
		'support':
			character.set_stat('physics_factor', 3)
			character.set_stat('wits_factor', 3)
			nm = 'support'
			var pool1 := ['acolyte']
			var pool2 := ['priest', 'monk']
			var pool3 := {light = 0, water = 0, leadership = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(1, 2)
			if level > 1:
				character.set_stat('charm_factor', 4)
				character.set_stat('wits_factor', 4)
				pool1 = ['acolyte', 'priest']
				pool2 = ['bishop', 'monk', 'shaman', 'bard']
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(3, 4)
			if level > 2:
				pool1 = ['acolyte', 'priest', 'bishop', 'monk', 'shaman', 'bard']
				pool2 = []
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				character.unlock_class(roll, true) 
				nm += '_' + roll
			if level > 2:
				nm += '_maxed'
			for mas in pool3:
				for i in range(pool3[mas]):
					character.upgrade_mastery(mas, true)
			match level:
				1:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				2:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				3:
					e_list = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff', 'staffadv']]
				4:
					e_list = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
		'caster':
			character.set_stat('magic_factor', 3)
			character.set_stat('wits_factor', 4)
			nm = 'caster'
			var pool1 := [['apprentice'], ['scholar']]
			var pool2 := []
			for arr in pool1:
				if !arr.has('apprentice'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('apprentice')
				if !arr.has('scholar'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('scholar')
				if !arr.has('caster'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('caster')
				if !arr.has('shaman'):
					pool2.push_back(arr.duplicate())
					pool2.back().push_back('shaman')
			var pool3 := {fire = 0, water = 0, earth = 0, air = 0, dark = 0, mind = 0}
			for mas in pool3:
				pool3[mas] = globals.rng.randi_range(1, 2)
			if character.get_stat('race') in ['Elf', 'Dryad', 'Fairy', 'DarkElf', 'TribalElf']:
				for arr in pool1:
					if !arr.has('druid'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('druid')
			if character.get_stat('sex') == 'female':
				pool2.append_array([['apprentice', 'witch']])
			pool1 = []
			if level > 1:
				character.set_stat('magic_factor', 4)
				var tmp = pool2.duplicate(true)
				pool2 = [['apprentice', 'scholar', 'archmage'],]
				for arr in tmp:
					if !arr.has('caster'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('caster')
					if !arr.has('shaman'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('shaman')
					if (arr.has('druid') or arr.has('witch')) and arr.has('apprentice'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('scholar')
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(2, 4)
			if level > 2:
				var tmp = pool2.duplicate(true)
				pool2 = []
				for arr in tmp:
					if arr.has('caster'):
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('bloodmage')
						pool2.back().push_back('necromancer')
						if character.get_stat('sex') == 'male':
							pool2.push_back(arr.duplicate())
							pool2.back().push_back('warlock')
							pool2.back().push_back('bloodmage')
							pool2.push_back(arr.duplicate())
							pool2.back().push_back('warlock')
							pool2.back().push_back('necromancer')
					else:
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('caster')
						pool2.back().push_back('engineer')
						pool2.back().push_back('bloodmage')
						pool2.back().push_back('technomancer')
						pool2.push_back(arr.duplicate())
						pool2.back().push_back('caster')
						pool2.back().push_back('engineer')
						pool2.back().push_back('necromancer')
						pool2.back().push_back('technomancer')
						if character.get_stat('sex') == 'male':
							pool2.push_back(arr.duplicate())
							pool2.back().push_back('caster')
							pool2.back().push_back('engineer')
							pool2.back().push_back('warlock')
							pool2.back().push_back('technomancer')
				for mas in pool3:
					pool3[mas] = globals.rng.randi_range(5, 6)
			if level == 4:
				pool1 = ['caster', 'archmage', 'shaman', 'apprentice', 'scholar', 'engineer', 'technomancer', 'necromancer', 'bloodmage']
				pool2 = []
				if character.get_stat('sex') == 'female':
					pool1.push_back('witch')
				if character.get_stat('race') in ['Elf', 'Dryad', 'Fairy', 'DarkElf', 'TribalElf']:
					pool1.push_back('druid')
				if character.get_stat('sex') == 'male':
					pool1.push_back('warlock')
				for mas in pool3:
					pool3[mas] = 6
			for prof in pool1:
				character.unlock_class(prof, true)
			if !pool2.empty():
				var roll = input_handler.random_from_array(pool2)
				if roll is Array:
					for prof in roll:
						character.unlock_class(prof, true) 
						if level < 3:
							nm += '_' + prof
						if level == 3 and (prof == roll[-1] or prof == roll[-2]):
							nm += '_' + prof
			if level == 4:
				nm += '_maxed'
			for mas in pool3:
				for i in range(pool3[mas]):
					character.upgrade_mastery(mas, true)
			match level:
				1:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				2:
					e_list = ['chest_base_cloth', 'legs_base_cloth', 'staff']
				3:
					e_list = [['chest_base_cloth', 'chest_adv_cloth'], ['legs_base_cloth', 'legs_adv_cloth'], ['staff']]
				4:
					e_list = ['chest_adv_cloth', 'legs_adv_cloth', 'staffadv']
	
	character.set_stat('name', nm)
	input_handler.active_location.group['pos' + str(position)] = character.id
	
	for id in e_list:
		var i_id = id
		if i_id is Array:
			i_id = input_handler.random_from_array(i_id)
		var item = make_item(i_id, level)
		character.equip(item)
	
	character.hp = character.get_stat("hpmax")
	character.mp = character.get_stat("mpmax")



func setup_player():
	ResourceScripts.game_party.clear_heroes()
	var preset_id = $selector2.get_item_text($selector2.selected)
	if party_presets.has(preset_id):
		make_preset_party(preset_id)
		return
	var level = $selector2.selected + 1
#	make_hero('fighter', level, 1, true)
	make_hero_from_data(input_handler.random_from_array(['base_melee', 'bers_melee', 'dk_melee', 'val_melee']), level, 1, true)
	match level:
		1:
			make_hero_from_data('base_rogue', level, 2)
			make_hero_from_data(input_handler.random_from_array(['base_support', 'bloodmage_caster', 'witch_caster', 'druid_caster']), level, 4)
#			make_hero('rogue', level, 2)
#			make_hero(input_handler.random_from_array(['support', 'caster']), level, 4)
		2:
			make_hero_from_data('base_rogue', level, 3)
			make_hero_from_data('base_support', level, 4)
			make_hero_from_data(input_handler.random_from_array(['base_archer', 'bloodmage_caster', 'witch_caster', 'druid_caster']), level, 5)
#			make_hero('rogue', level, 3)
#			make_hero('support', level, 4)
#			make_hero(input_handler.random_from_array(['rogue', 'caster']), level, 5)
		3, 4:
			make_hero_from_data(input_handler.random_from_array(['base_melee', 'bers_melee', 'dk_melee', 'val_melee']), level, 2)
			make_hero_from_data('base_rogue', level, 3)
			make_hero_from_data('base_support', level, 4)
			make_hero_from_data('base_archer', level, 5)
			make_hero_from_data(input_handler.random_from_array(['bloodmage_caster', 'witch_caster', 'druid_caster', 'warlock_caster']), level, 6)
#			make_hero('fighter', level, 2)
#			make_hero('rogue', level, 3)
#			make_hero('rogue', level, 4)
#			make_hero('support', level, 5)
#			make_hero('caster', level, 6)
	



func make_hero_from_data(type, level, position = 1, first = false):
	var data = chardata[type]
	var character = ResourceScripts.scriptdict.class_slave.new("test_combat")
	var race = races.racelist.keys()
	if data.has('race'):
		race = data.race
	if race is Array:
		race = input_handler.random_from_array(race)
	var sex = ['male', 'female']
	if data.has('sex'):
		sex = data.sex
	if sex is Array:
		sex = input_handler.random_from_array(sex)
	character.create(race, sex, 'random')
	character.fill_boosters()
	characters_pool.move_to_state(character.id)
#	character.set_stat('food_love', "meat")
#	character.set_stat('food_hate', ["grain"])
#	character.set_stat('consent', 5)
	character.add_stat('mastery_point_universal', 50)
	character.is_players_character = true
	if first:
		character.unlock_class("master")
		character.set_slave_category('master')
	else:
		character.set_slave_category('servant')
		character.add_trait('training_s_combat')
	
	var ldata = data[level]
	var nm = data.name
	
	var masteries = {}
	for mas in data.masteries:
		var lv = ldata.mastery_levels
		if lv is Array:
			lv = globals.rng.randi_range(lv[0], lv[1])
		masteries[mas] = lv
	# Temporary preview setup: every test-combat melee hero must meet Holy Lance's
	# mastery requirements at every selectable test level.
	if data.name == 'melee':
		masteries.warfare = max(masteries.get('warfare', 0), 4)
		masteries.light = max(masteries.get('light', 0), 3)
	
	for st in ldata.stats:
		character.set_stat(st, ldata.stats[st])
	
	for prof in ldata.classes1:
		character.unlock_class(prof, true)
	
	var tmp = ldata.classes2.duplicate(true)
	tmp.shuffle()
	for i in range(ldata.optional_classes_amount):
		if tmp[i] is Array:
			for prof in tmp[i]:
				character.unlock_class(prof, true)
				if level < 3:
					nm += '_' + prof 
		else:
			character.unlock_class(tmp[i], true)
			if level < 3:
				nm += '_' + tmp[i] 
	if level >= 3:
		nm += '_maxed'
	 
	for mas in masteries:
		for i in range(masteries[mas]):
			character.upgrade_mastery(mas, true)
	if data.name == 'melee':
		character.learn_c_skill('holy_lance')
	
	character.set_stat('name', nm)
	input_handler.active_location.group['pos' + str(position)] = character.id
	
	for id in ldata.items:
		var i_id = id
		if i_id is Array:
			i_id = input_handler.random_from_array(i_id)
		var item = make_item(i_id, level)
		character.equip(item)
	if data.name == 'melee':
		var spear_id = 'spearadv' if level >= 3 else 'spear'
		character.equip(make_item(spear_id, level))
	
	character.hp = character.get_stat("hpmax")
	character.mp = character.get_stat("mpmax")


func make_preset_party(preset_id):
	var preset = party_presets[preset_id]
	for i in range(preset.heroes.size()):
		make_hero_from_preset(preset, preset.heroes[i], i + 1, i == 0)


func make_hero_from_preset(preset, data, position, first = false):
	var kit = preset.kits[data.kit]
	var character = ResourceScripts.scriptdict.class_slave.new("test_combat")
	character.create(data.race, data.sex, 'random')
	character.fill_boosters()
	characters_pool.move_to_state(character.id)
	character.add_stat('mastery_point_universal', 50)
	character.is_players_character = true
	if first:
		character.unlock_class("master")
		character.set_slave_category('master')
	else:
		character.set_slave_category('servant')
		character.add_trait('training_s_combat')
	
	#the stats meet every class requirement on their own; unlock_class(prof, true) would instead set
	#wits and physics to each class's minimum (75 for a necromancer, warlock or witch)
	for prof in data.classes:
		character.unlock_class(prof)
	for st in kit.stats:
		character.set_stat(st, kit.stats[st])
	for mas in data.masteries:
		for i in range(data.masteries[mas]):
			character.upgrade_mastery(mas, true)
	for trait_code in kit.get('traits', []) + data.get('traits', []):
		character.add_trait(trait_code)
	#core_trait carries every meal buff; the last meal and a full stomach pick the one that is on
	if kit.has('food'):
		character.food.last_meal_type = kit.food
		character.food.fed = 10
	for eff_code in kit.get('buffs', []):
		character.apply_effect_code(eff_code)
	
	character.set_stat('name', data.name)
	input_handler.active_location.group['pos' + str(position)] = character.id
	
	#a hero's own item takes its slot away from the kit's
	var item_recs = data.get('items', []).duplicate()
	var hero_slots = []
	for rec in item_recs:
		hero_slots += Items.itemlist[rec.base].slots
	for rec in kit.items:
		var slot_free = true
		for slot in Items.itemlist[rec.base].slots:
			if hero_slots.has(slot):
				slot_free = false
		if slot_free:
			item_recs.push_back(rec)
	for rec in item_recs:
		var item
		if rec.has('parts'):
			item = globals.CreateGearItemQuality(rec.base, rec.parts, 'legendary')
		else:
			#accessories never roll a quality in game, so they keep their template stats
			item = globals.CreateGearItem(rec.base, {})
		#the enchanting screen trades a random curse for capacity (+50% for a major one); decline
		#only cuts experience, which costs a test fight nothing
		if rec.has('curse'):
			item.add_curse(rec.curse)
		for ench in rec.get('enchants', {}):
			item.add_enchant(ench, rec.enchants[ench], true)
		#add_enchant(..., true) skips the capacity check the enchanting screen makes
		if item.get_e_capacity() < 0:
			print('test_combat: %s of %s is %d over its enchant capacity' % [rec.base, data.name, -item.get_e_capacity()])
		globals.AddItemToInventory(item, false)
		character.equip(item)

	character.hp = character.get_stat("hpmax")
	character.mp = character.get_stat("mpmax")


#A room fight of the tower on TOWER_FLOOR, rolled the way world_gen.build_room, the dungeon's room entry
#and globals.StartFixedAreaCombat do it, except that every unit is an elite: the tower makes each one
#elite at variables.enemy_rarechance and keeps three at most. The Stat modifier multiplies the floor's own.
func start_tower_elites():
	if !globals.check_location_group():
		input_handler.SystemMessage(tr("SYSMESSAGEATLEAST1CHAR"))
		return
	input_handler.get_spec_node(input_handler.NODE_COMBATPOSITIONS).hide()
	var level = TOWER_FLOOR - 1
	#set_level_infinite drops a biome from the rotation past its max_floor
	var biomes = []
	for biome in DungeonData.dungeons.infinite_aliron.avaliable_biomes:
		var b_data = DungeonData.infinite_dungeon_biomes[biome]
		if b_data.has('max_floor') and level > b_data.max_floor:
			continue
		biomes.push_back(biome)
	var biome_data = DungeonData.infinite_dungeon_biomes[input_handler.random_from_array(biomes)]
	var group_code = input_handler.weightedrandom(biome_data.enemyarray)

	globals.reset_roll_data()
	globals.char_roll_data.no_roll = true
	globals.char_roll_data.diff = 'infinite'
	globals.char_roll_data.lvl = level
	#quest = true skips the random elite roll; every unit is made elite here instead
	var enemies = globals.makerandomgroup(Enemydata.enemygroups[group_code], true)
	for pos in enemies:
		if enemies[pos] != null:
			enemies[pos] += '_rare'
	globals.char_roll_data.rare = true

	input_handler.encounter_win_script = null
	input_handler.encounter_lose_script = null
	if input_handler.combat_node == null:
		input_handler.combat_node = input_handler.get_combat_node()
	input_handler.combat_node.encountercode = group_code
	input_handler.combat_node.set_norun_mode(false)
	var stats_mod = (1 + level * variables.difficulty_per_level_survival) * float($mod1.text)
	var background = input_handler.random_from_array(biome_data.background_pool)
	input_handler.combat_node.start_combat(input_handler.active_location.group, enemies, background, 'combattheme', {enemy_stats_mod = stats_mod})
