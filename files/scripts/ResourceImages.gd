extends Node

var backgrounds = {
	#backgrounds
	Null = null,
	castle = load("res://assets/images/backgrounds/castle.png"),
	castleroom = load('res://assets/images/backgrounds/castleroom.png'),
	cave = load("res://assets/images/backgrounds/cave.png"),
	desert = load("res://assets/images/backgrounds/desert.png"),
	villageday = load("res://assets/images/backgrounds/villageday.png"),
	villagenight = load("res://assets/images/backgrounds/villagenight.png"),
	dungeon = load("res://assets/images/backgrounds/dungeon.png"),
	dungeon1 = load("res://assets/images/backgrounds/dungeoncircle.png"),
	forest = load("res://assets/images/backgrounds/forest.png"),
	forge = load("res://assets/images/backgrounds/forge.png"),
	market = load("res://assets/images/backgrounds/market.png"),
	hall = load("res://assets/images/backgrounds/townhall.png"),
	#scenes
	s_er_1_1 = load("res://assets/images/scenes/erikaCG1.png"),
	s_er_1_2 = load("res://assets/images/scenes/erikaCG2.png"),
	s_em_1_1 = load("res://assets/images/scenes/EmberCG1.png"),
	s_em_1_2 = load("res://assets/images/scenes/EmberCG2.png"),
	s_em_1_3 = load("res://assets/images/scenes/EmberCG3.png"),
	s_em_1_4 = load("res://assets/images/scenes/EmberCG4.png"),
	s_r_1_1 = load("res://assets/images/scenes/RoseBJ1.png"),
	s_r_1_2 = load("res://assets/images/scenes/RoseBJ2.png"),
	s_r_1_3 = load("res://assets/images/scenes/RoseBJ3.png"),
	s_r_1_4 = load("res://assets/images/scenes/RoseBJ4.png"),
	s_r_1_5 = load("res://assets/images/scenes/RoseBJ5.png"),
	s_r_1_6 = load("res://assets/images/scenes/RoseCG1.png"),
	s_r_1_7 = load("res://assets/images/scenes/RoseCG2.png"),
	s_r_1_8 = load("res://assets/images/scenes/RoseCG3.png"),
	}

var sprites = {
	empty = null,
	Arron = load("res://assets/images/sprites/Arron.png"),
	Rose = load("res://assets/images/sprites/rose.png"),
	goblin = load("res://assets/images/sprites/goblin.png"),
	goblincmerc = load("res://assets/images/sprites/goblinmerc.png"),
	emberhappy = load("res://assets/images/sprites/EmberHappy.png"),
	embershock = load("res://assets/images/sprites/EmberSurprise.png"),
	erika = load("res://assets/images/sprites/erika.png"),
	erika_n = load("res://assets/images/sprites/erikanaked.png"),
	demitrius = load("res://assets/images/sprites/Demitrius.png"),
	ent = load("res://assets/images/sprites/ent.png"),
	}

var portraits = {
	Null = null,
	ArronSmile = load("res://assets/images/portraits/ArronSmile.png"),
	ArronNeutral = load("res://assets/images/portraits/ArronNeutral.png"),
	ArronShock = load("res://assets/images/portraits/ArronShock.png"),
	EmberFriendly = load("res://assets/images/portraits/EmberFriendly.png"),
	EmberHappy = load("res://assets/images/portraits/EmberHappy.png"),
	EmberTired = load("res://assets/images/portraits/EmberTired.png"),
	RoseHappy = load("res://assets/images/portraits/RoseHappy.png"),
	RoseNormal = load("res://assets/images/portraits/RoseNormal.png"),
	RoseSad = load("res://assets/images/portraits/RoseSad.png"),
	RoseSarcastic = load("res://assets/images/portraits/RoseSarcastic.png"),
	RoseShock = load("res://assets/images/portraits/RoseShocked.png"),
	RoseTalk = load("res://assets/images/portraits/RoseTalk.png"),
	ErikaAnnoyed = load("res://assets/images/portraits/ErikaAnnoyed.png"),
	ErikaHappy = load("res://assets/images/portraits/ErikaHappy.png"),
	ErikaNormal = load("res://assets/images/portraits/ErikaNormal.png"),
	goblin = load("res://assets/images/portraits/GoblinPeasant.png"),
	Flak = load("res://assets/images/portraits/GoblinTrader.png"),
	Guard = load("res://assets/images/portraits/Guard.png"),
	Lyra = load("res://assets/images/portraits/Lyra.png"),
	NorbertNormal = load("res://assets/images/portraits/NorbertNormal.png"),
	NorbertRage = load("res://assets/images/portraits/NorbertRage.png"),
	Demitrius = load("res://assets/images/portraits/Demitrius.png"),
	DemitriusTalk = load("res://assets/images/portraits/DemitriusTalk.png"),
	Ent = load("res://assets/images/enemies/BigEntIcon.png"),
}

var combatportraits = {
	arron = load("res://assets/images/combatportraits/arronfull.png"),
	rose = load("res://assets/images/combatportraits/rosefull.png"),
	ember = load("res://assets/images/combatportraits/emberfull.png"),
	erika = load("res://assets/images/combatportraits/erikafull.png"),
	
	##enemies
	rat = load("res://assets/images/enemies/RatIcon2.png"),
	ent = load("res://assets/images/enemies/EntIcon.png"),
	bigent = load("res://assets/images/enemies/BigEntIcon.png"),
	golem = load("res://assets/images/enemies/GolemIcon.png"),
	golemalt = load("res://assets/images/enemies/GolemAltIcon.png"),
	spider = load("res://assets/images/enemies/SpiderIcon.png"),
	dwarf = load("res://assets/images/enemies/AngryDwarfIcon.png"),
	fairies = load("res://assets/images/enemies/FairiesIcon.png"),
	}

var combatfullpictures = {
	arron = sprites.Arron,
	rose = sprites.Rose,
	erika = sprites.erika,
	ember = sprites.emberhappy,
	rat = load("res://assets/images/enemies/RatFull.png"),
	ent = load("res://assets/images/enemies/EntFull.png"),
	bigent = load("res://assets/images/enemies/BigEntFull.png"),
	golem = load("res://assets/images/enemies/Golem.png"),
	golemalt = load("res://assets/images/enemies/GolemAlt.png"),
	spider = load("res://assets/images/enemies/Spider.png"),
	dwarf = load("res://assets/images/enemies/AngryDwarf.png"),
	fairies = load("res://assets/images/enemies/Fairies.png"),
}

var circleportraits = {
	arron = load("res://assets/images/combatportraits/arroncircle.png"),
	rose = load("res://assets/images/combatportraits/rosecircle.png"),
	ember = load("res://assets/images/combatportraits/embercircle.png"),
	erika = load("res://assets/images/combatportraits/erikacircle.png"),
	
	
}

var gui = {
	norm_back = load("res://assets/images/gui/text scene/textfieldpanel.png"),
	alt_back = load("res://assets/images/gui/text scene/textfieldpanel.png"), #stub
};

var GFX = {
	slash = load("res://assets/images/gfx/slash-effect.png"),
	fire = load("res://assets/sfx/fire_effect.png"),
}

