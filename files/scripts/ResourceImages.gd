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
	}

var sprites = {
	empty = null,
	}

var portraits = {
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
	
}

var gui = {
	norm_back = load("res://assets/images/gui/text scene/textfieldpanel.png"),
	alt_back = load("res://assets/images/gui/text scene/textfieldpanel.png"), #stub
};

var GFX = {
	slash = load("res://assets/images/gfx/slash-effect.png"),
	fire = load("res://assets/sfx/fire_effect.png"),
}

var shades = {
	arachna_m = load("res://assets/images/raceshades/Arachna_M.png"),
	arachna_f = load("res://assets/images/raceshades/Arachna_F.png"),
	beastkinbunny_m = load("res://assets/images/raceshades/Beastkin-Bunny_M.png"),
	beastkinbunny_f = load("res://assets/images/raceshades/Beastkin-Bunny_F.png"),
	beastkincat_m = load("res://assets/images/raceshades/Beastkin-Cat_M.png"),
	beastkincat_f = load("res://assets/images/raceshades/Beastkin-Cat_F.png"),
	beastkinfox_m = load("res://assets/images/raceshades/Beastkin-Fox_M.png"),
	beastkinfox_f = load("res://assets/images/raceshades/Beastkin-Fox_F.png"),
	beastkintanuki_m = load("res://assets/images/raceshades/Beastkin-Tanuki_M.png"),
	beastkintanuki_f = load("res://assets/images/raceshades/Beastkin-Tanuki_F.png"),
	beastkinwolf_m = load("res://assets/images/raceshades/Beastkin-Wolf_M.png"),
	beastkinwolf_f = load("res://assets/images/raceshades/Beastkin-Wolf_F.png"),
	centaur_m = load("res://assets/images/raceshades/Centaur_M.png"),
	centaur_f = load("res://assets/images/raceshades/Centaur_F.png"),
	demon_m = load("res://assets/images/raceshades/Demon_M.png"),
	demon_f = load("res://assets/images/raceshades/Demon_F.png"),
	dragonkin_m = load("res://assets/images/raceshades/Dragonkin_M.png"),
	dragonkin_f = load("res://assets/images/raceshades/Dragonkin_F.png"),
	dryad_m = load("res://assets/images/raceshades/Dryad_M.png"),
	dryad_f = load("res://assets/images/raceshades/Dryad_F.png"),
	elf_m = load("res://assets/images/raceshades/Elf_M.png"),
	elf_f = load("res://assets/images/raceshades/Elf_F.png"),
	darkelf_m = load("res://assets/images/raceshades/Elf_M.png"),
	darkelf_f = load("res://assets/images/raceshades/Elf_F.png"),
	drow_m = load("res://assets/images/raceshades/Elf_M.png"),
	drow_f = load("res://assets/images/raceshades/Elf_F.png"),
	fairy_m = load("res://assets/images/raceshades/Fairy_M.png"),
	fairy_f = load("res://assets/images/raceshades/Fairy_F.png"),
	gnome_m = load("res://assets/images/raceshades/Gnome_M.png"),
	gnome_f = load("res://assets/images/raceshades/Gnome_F.png"),
	dwarf_m = load("res://assets/images/raceshades/Gnome_M.png"),
	dwarf_f = load("res://assets/images/raceshades/Gnome_F.png"),
	goblin_m = load("res://assets/images/raceshades/Goblin_M.png"),
	goblin_f = load("res://assets/images/raceshades/Goblin_F.png"),
	harpy_m = load("res://assets/images/raceshades/Harpy_M.png"),
	harpy_f = load("res://assets/images/raceshades/Harpy_F.png"),
	human_m = load("res://assets/images/raceshades/Human_M.png"),
	human_f = load("res://assets/images/raceshades/Human_F.png"),
	lamia_m = load("res://assets/images/raceshades/Lamia_M.png"),
	lamia_f = load("res://assets/images/raceshades/Lamia_F.png"),
	nereid_m = load("res://assets/images/raceshades/Nereid_M.png"),
	nereid_f = load("res://assets/images/raceshades/Nereid_F.png"),
	orc_m = load("res://assets/images/raceshades/Orc_M.png"),
	orc_f = load("res://assets/images/raceshades/Orc_F.png"),
	scylla_m = load("res://assets/images/raceshades/Scylla_M.png"),
	scylla_f = load("res://assets/images/raceshades/Scylla_F.png"),
	seraph_m = load("res://assets/images/raceshades/Seraph_M.png"),
	seraph_f = load("res://assets/images/raceshades/Seraph_F.png"),
	slime_m = load("res://assets/images/raceshades/Slime_M.png"),
	slime_f = load("res://assets/images/raceshades/Slime_F.png"),
	taurus_m = load("res://assets/images/raceshades/Taurus_M.png"),
	taurus_f = load("res://assets/images/raceshades/Taurus_F.png"),
	
}
