extends Node

var music = {
	mansion1 = load("res://assets/sounds/music/mansion1.ogg"),
	mansion2 = load("res://assets/sounds/music/mansion2.ogg"),
	mansion3 = load("res://assets/sounds/music/mansion3.ogg"),
	mansion4 = load("res://assets/sounds/music/mansion4.ogg"),
	
	battle1 = load("res://assets/sounds/music/battle1.ogg"),
	battle2 = load("res://assets/sounds/music/battle2.ogg"),
	battle3 = load("res://assets/sounds/music/battle3.ogg"),
	
	
	combattheme = load("res://assets/sounds/music/battle1.ogg"),
	
	dungeon = load("res://assets/sounds/music/dungeon.ogg"),
	ending = load("res://assets/sounds/music/ending.ogg"),
	exploration = load("res://assets/sounds/music/exploration.ogg"),
	
	wimborn = load("res://assets/sounds/music/wimborn.ogg"),
	gorn = load("res://assets/sounds/music/gorn.ogg"),
	frostford = load("res://assets/sounds/music/frostford.ogg"),
	
	intro = load("res://assets/sounds/music/ending.ogg"),
	intimate = load("res://assets/sounds/music/intimate.ogg"),
	
	
}

var music_categories = {
	mansion = ['mansion1','mansion2','mansion3','mansion4']
}

var background_noise = {
	aliron_noise = load("res://assets/sounds/sounds/aliron_background.ogg"),
	elf_noise = null,
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
	
	door_open = load("res://assets/sounds/sounds/door.wav"),
	ding = load("res://assets/sounds/sounds/ding.wav"),
	
	morning = load("res://assets/sounds/sounds/morning_rooster.wav"),
	
	gameover = load("res://assets/sounds/sounds/GameOver.wav"),
	
	blade = load("res://assets/sounds/sounds/dodge.wav"),#load("res://assets/sounds/sounds/fx knife hit solo.wav"),
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
	levelup = load("res://assets/sounds/sounds/levelup.wav"),
	chat_click = load("res://assets/sounds/sounds/click.wav"),
	
	questcomplete = load("res://assets/sounds/sounds/win.wav"),
	
	page = load('res://assets/sounds/sounds/page.wav'),
	book = load('res://assets/sounds/sounds/book.wav'),
	
	magic = load("res://assets/sounds/sounds/magic.wav"),
	
	error = load("res://assets/sounds/sounds/magiceffect.wav"),
	
	#skills
	arrowshower = load("res://assets/sounds/sounds/arrowshower.wav"),
	firebolt = load("res://assets/sounds/sounds/firebolt.wav"),
	firehit = load("res://assets/sounds/sounds/firedamage.wav"),
	avalanche = load("res://assets/sounds/sounds/avalanche.wav"),
	
	transition_sound = load("res://assets/sounds/sounds/magic1.wav"),
}
