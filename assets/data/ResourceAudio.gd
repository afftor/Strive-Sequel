extends Node

func get_music(id):
	if music[id] is String:
		music[id] = load(music[id])
	return music[id]

var music = {
	opening = "res://assets/sounds/music/MainTheme.ogg",
	
	mansion1 = "res://assets/sounds/music/mansion1.ogg",
	mansion2 = "res://assets/sounds/music/mansion2.ogg",
	mansion3 = "res://assets/sounds/music/mansion3.ogg",
	mansion4 = "res://assets/sounds/music/mansion4.ogg",

#	battle1 = load("res://assets/sounds/music/battle1.ogg"),
#	battle2 = load("res://assets/sounds/music/battle2.ogg"),
#	battle3 = load("res://assets/sounds/music/battle3.ogg"),
	battle1 = "res://assets/sounds/music/battle dance.ogg",
	battle2 = "res://assets/sounds/music/oriental.ogg",
	battle3 = "res://assets/sounds/music/saltation.ogg",
	battle4 = "res://assets/sounds/music/take what you can.ogg",

	
	daisy_theme = "res://assets/sounds/music/Daisy Theme.ogg",
	cali_theme = "res://assets/sounds/music/Cali Theme.ogg",
	zephyra_theme = "res://assets/sounds/music/Zephyra Theme.ogg",
	kuro_theme = "res://assets/sounds/music/Kuro Theme.ogg",
	rouge_theme = "res://assets/sounds/music/Rouge Theme.ogg",
	lilia_theme = "res://assets/sounds/music/Lilia Theme.ogg",
	lilith_theme = "res://assets/sounds/music/Lilith Theme.ogg",
	erdyna_theme = "res://assets/sounds/music/Erdyna theme.ogg",
	hara_theme = "res://assets/sounds/music/Hara Theme.ogg",
	jean_theme = "res://assets/sounds/music/Jean Theme.ogg",
	amelia_theme = "res://assets/sounds/music/Amelia theme.ogg",
	mae_theme = "res://assets/sounds/music/Mae Theme.ogg",
	
	
	combattheme = "res://assets/sounds/music/battle1.ogg",

	dungeon = "res://assets/sounds/music/dungeon.ogg",
	ending = "res://assets/sounds/music/ending.ogg",
	exploration = "res://assets/sounds/music/exploration.ogg",

	wimborn = "res://assets/sounds/music/wimborn.ogg",
	gorn = "res://assets/sounds/music/gorn.ogg",
	frostford = "res://assets/sounds/music/frostford.ogg",
	empire_capital = "res://assets/sounds/music/capital_ost.ogg",

	#intro = load("res://assets/sounds/music/ending.ogg"),
	intimate = "res://assets/sounds/music/closeness.ogg",
	intimate_dark = "res://assets/sounds/music/dark temptation.ogg",
	intimate_funny = "res://assets/sounds/music/intimate_mischevious.ogg",
	
	
	tragic = "res://assets/sounds/music/Tragic.ogg", 
	lira_theme = "res://assets/sounds/music/Lira theme.ogg", 
	heleviel_theme = "res://assets/sounds/music/Heleviel Theme.ogg",
	
	dwarf_cap = "res://assets/sounds/music/dwarf_capital.ogg",
	tower = "res://assets/sounds/music/tower_of_dreams.ogg",
	beastkin_village = "res://assets/sounds/music/tribal_village.ogg",
	
	arena_combat = "res://assets/sounds/music/Arena Combat Theme.ogg",
	threat = "res://assets/sounds/music/Threat.ogg",

}

var music_categories = {
	mansion = ['mansion1','mansion2','mansion3','mansion4']
}

var background_noise = {
	aliron_noise = load("res://assets/sounds/sounds/aliron_background.ogg"),
	elf_noise = null,
	battle_noise = load("res://assets/sounds/sounds/ambient-battle-noise-swords-and-shouting.ogg"),
	
}

var sounds = {
	time_start = load("res://assets/sounds/sounds/fx start time.wav"),
	time_stop = load("res://assets/sounds/sounds/fx stop time.wav"),
	time_up = load("res://assets/sounds/sounds/fx time up.wav"),
	menu_open = load("res://assets/sounds/sounds/menu open.wav"),
	menu_close = load("res://assets/sounds/sounds/menu close.wav"),
	button_click = load("res://assets/sounds/sounds/menu button.wav"),
	knocking = load("res://assets/sounds/sounds/knocking.wav"),
	doorlocked = load("res://assets/sounds/sounds/lockeddoor.wav"),
	doorsmash = load("res://assets/sounds/sounds/doorsmash.wav"),
	teleport = load("res://assets/sounds/sounds/teleport.wav"),
	classlearn = load("res://assets/sounds/sounds/classlearn.wav"),
	crash = load("res://assets/sounds/sounds/crash.wav"),
	punch = load("res://assets/sounds/sounds/punch.wav"),
	slap = load("res://assets/sounds/sounds/slap.wav"),
	fall = load("res://assets/sounds/sounds/fall.wav"),

	door_open = load("res://assets/sounds/sounds/door.wav"),
	ding = load("res://assets/sounds/sounds/ding.wav"),

	morning = load("res://assets/sounds/sounds/morning_rooster.wav"),

	gameover = load("res://assets/sounds/sounds/GameOver.wav"),

	blade = load("res://assets/sounds/sounds/fx knife body hit.wav"),
	blunt_hit = load("res://assets/sounds/sounds/blunt_hit.wav"),
	fleshhit = load("res://assets/sounds/sounds/fx knife body hit.wav"),
	bow = load("res://assets/sounds/sounds/ArrowShot.wav"),
	skill_scene = load("res://assets/sounds/sounds/healeffect.wav"),
	itemget = load("res://assets/sounds/sounds/itemget.wav"),
	itemcreate = load("res://assets/sounds/sounds/itemcraft.wav"),
	building = load("res://assets/sounds/sounds/building.wav"),
	money_spend = load("res://assets/sounds/sounds/money_spend.wav"),

	#combat
	victory = load("res://assets/sounds/sounds/victory.wav"),
	defeat = load('res://assets/sounds/sounds/defeat.wav'),
	combatmiss = load('res://assets/sounds/sounds/dodge.wav'),
	dodge = load("res://assets/sounds/sounds/dodge.wav"),
	chat_click = load("res://assets/sounds/sounds/click.wav"),

	questcomplete = load("res://assets/sounds/sounds/win.wav"),

	page = load('res://assets/sounds/sounds/page.wav'),
	book = load('res://assets/sounds/sounds/book.wav'),

	magic = load("res://assets/sounds/sounds/magic1.wav"),

	error = load("res://assets/sounds/sounds/magiceffect.wav"),

	explosion = load("res://assets/sounds/sounds/explosion.wav"),
	
	
	spell_break = load("res://assets/sounds/sounds/spell_break.wav"),
	spell_explosion = load("res://assets/sounds/sounds/spell_explosion.wav"),
	spell_dark = load("res://assets/sounds/sounds/spell_explosion.wav"),
	spell_lightning = load("res://assets/sounds/sounds/spell_explosion.wav"),
	spell2 = load("res://assets/sounds/sounds/spell2.wav"),
	spell_void = load("res://assets/sounds/sounds/spell_void.wav"),

	#skills
	arrowshower = load("res://assets/sounds/sounds/arrowshower.wav"),
	firebolt = load("res://assets/sounds/sounds/firebolt.wav"),
	firehit = load("res://assets/sounds/sounds/firedamage.wav"),
	avalanche = load("res://assets/sounds/sounds/avalanche.wav"),

	transition_sound = load("res://assets/sounds/sounds/magic1.wav"),

	combat_defeat = load("res://assets/sounds/sounds/defeated.wav"),
	class_aquired = load("res://assets/sounds/sounds/class_aquired.wav"),
	quest_completed = load("res://assets/sounds/sounds/task_completed.wav"),
	quest_aquired = load("res://assets/sounds/sounds/task_aquired.wav"),
	battle_start = load("res://assets/sounds/sounds/battle_start.wav"),
	battle_victory = load("res://assets/sounds/sounds/victory_new.wav"),
	speech = load("res://assets/sounds/sounds/speech_screen.wav"),
	
	crunch = load("res://assets/sounds/sounds/crunch.wav"),
	groan = load("res://assets/sounds/sounds/groan.wav"),
}
