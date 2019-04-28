extends Node

func _ready():
	for i in racelist.values():
		i.name = tr("RACE" + i.code.to_upper())
		i.descript = tr("RACE" + i.code.to_upper() + 'DESCRIPT')
		i.adjective = tr("RACE" + i.code.to_upper() + "ADJ")
	
	for i in tasklist.values():
		i.name = tr("TASK" + i.code.to_upper())
		i.descript = tr("TASK" + i.code.to_upper() + "DESCRIPT")

class state:
	var craft_list_forget = []
	var craft_list_smith = []
	var craft_list_alchemy = []
	var craft_list_carpenter = []
	var craft_list_tailor = []
	var craft_list_cook = []




func hunt_meat(character):
	return 8 + (8*(character.physics/50))

func fishing(character):
	return 8 + (8*(character.physics/200+character.wits/75))

func hunt_leather(character):
	return 16 + character.physics/3

func woodcutting_lumber(character):
	return 16 + character.physics/3

func mining_stone(character):
	return 16 + character.physics/3

func whoring_gold(character):
	return 3 + character.sexuals/10 + character.charm/20

func forge_progress(character):
	return 3 + character.physics

func alchemy_progress(character):
	return 3 + character.wits


var tasklist = {
	hunting = {
		code = 'hunting',
		reqs = [],
		name = '',
		descript = '',
		workstat = 'physics',
		production = {
			huntmeat = {code = 'huntmeat', item = 'meat', progress_per_item = 10, reqs = [], progress_function = 'hunt_meat'},
			huntleather = {code = 'huntleather', item = 'leather', progress_per_item = 100, reqs = [], progress_function = 'hunt_leather'}}, #later change function to array
		icon = null,
		tags = [],
	},
	fishing = {
		code = 'fishing',
		reqs = [],
		name = '',
		descript = '',
		workstat = 'physics',
		production = {fishing = {code = 'fishing',item = 'fish', progress_per_item = 9, reqs = [], progress_function = 'fishing'}},
		icon = null,
		tags = [],
	},
	woodcutting = {
		code = 'woodcutting',
		reqs = [],
		name = '',
		descript = '',
		workstat = 'physics',
		production = {woodcutlumber = {code = 'woodcutlumber', item = 'wood', progress_per_item = 100, reqs = [], progress_function = 'woodcutting_lumber'}},
		icon = null,
		tags = [],
	},
	mining = {
		code = 'mining',
		reqs = [],
		name = '',
		descript = '',
		workstat = 'physics',
		production = {minestone = {code = 'minestone', item = 'stone', progress_per_item = 100, reqs = [], progress_function = 'mining_stone'}},
		icon = null,
		tags = [],
	},
	prostitution = {
		code = 'prostitution',
		reqs = [],
		name = '',
		descript = '',
		workstat = 'sexuals',
		production = {prostitutegold = {code = 'prostitutegold',item = 'gold', progress_per_item = 1, reqs = [], progress_function = 'whoring_gold'}},
		icon = null,
		tags = ['sex'],
	},
#	market = {
#		code = 'market',
#		reqs = [],
#		name = '',
#		descript = '',
#		workstat = 'wits',
#		production = {gold = [5,10]},
#		icon = null,
#		tags = [],
#	},
	forge = {
		code = 'forge',
		reqs = [],
		name = '',
		descript = '',
		workstat = 'physics',
		production = {smith = {code = 'smith',item = 'smith', progress_per_item = 0, reqs = [], progress_function = 'forge_progress'}},
		icon = null,
		tags = ['forge'],
	},
	alchemy = {
		code = 'alchemy',
		reqs = [],
		name = '',
		descript = tr("TASKALCHEMYDESCRIPT"),
		workstat = 'wits',
		production = {alchemy = {code = 'alchemy',item = 'alchemy', progress_per_item = 0, reqs = [], progress_function = 'alchemy_progress'}},
		icon = null,
		tags = ['alchemy'],
	},
}

#slime lamia arachna scylla nereid
#warning-ignore:unused_class_variable
var racelist = {
	Human = {
		code = "Human",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [2,4],
			magic_factor = [1,1],
			tame_factor = [3,5],
			brave_factor = [2,4],
			growth_factor = [1,2],
			sexuals_factor = [2,4],
			charm_factor = [1,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 50},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 1}, #weight for 1 random prefered food type
		diet_hate = {vege = 10, meat = 10, fish = 10, grain = 10},#%chance for each food type to be refused
		tags = [],
		bodyparts = {},
		global_weight = 100,
	},
	Elf = {
		code = "Elf",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,3],
			dirtiness = [2,2],
			physics_factor = [1,2],
			magic_factor = [2,4],
			tame_factor = [2,4],
			brave_factor = [1,3],
			growth_factor = [2,4],
			sexuals_factor = [1,2],
			charm_factor = [2,3],
			wit_factor = [3,4],
		},
		racetrait = {hpmax = 20, mpmax = 35, hitrate = 10},
		diet_love = {vege = 1, meat = 0.2, fish = 0.3, grain = 1},
		diet_hate = {vege = 0, meat = 75, fish = 25, grain = 10},
		tags = [],
		bodyparts = {
			ears = ['elven'],
			hair = ['blonde','green','brown','white'],
			},
		global_weight = 40,
	},
	DarkElf = {
		code = "DarkElf",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,3],
			dirtiness = [2,3],
			physics_factor = [2,3],
			magic_factor = [1,3],
			tame_factor = [2,3],
			brave_factor = [2,4],
			growth_factor = [2,4],
			sexuals_factor = [2,3],
			charm_factor = [1,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 30, mpmax = 15, hitrate = 10},
		diet_love = {vege = 1, meat = 0.2, fish = 0.5, grain = 1},
		diet_hate = {vege = 5, meat = 45, fish = 15, grain = 5},
		tags = [],
		bodyparts = {
			ears = ['elven'],
			skin = ['dark','brown','olive'],
			hairadd = ['white'],
			},
		global_weight = 30,
	},
	Drow = {
		code = "Drow",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [3,4],
			dirtiness = [2,4],
			physics_factor = [3,4],
			magic_factor = [3,4],
			tame_factor = [1,2],
			brave_factor = [3,5],
			growth_factor = [3,5],
			sexuals_factor = [2,4],
			charm_factor = [1,3],
			wit_factor = [3,5],
		},
		racetrait = {hpmax = 50, mpmax = 50, hitrate = 20},
		diet_love = {vege = 1, meat = 0.5, fish = 0.5, grain = 1},
		diet_hate = {vege = 10, meat = 20, fish = 20, grain = 10},
		tags = [],
		bodyparts = {
			ears = ['elven'],
			skin = ['grey','purple','teal'],
			hair = ['purple','green','white'],
			},
		global_weight = 10,
	},
	Orc = {
		code = "Orc",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [3,5],
			dirtiness = [3,4],
			physics_factor = [3,5],
			magic_factor = [1,1],
			tame_factor = [1,3],
			brave_factor = [4,5],
			growth_factor = [1,2],
			sexuals_factor = [2,4],
			charm_factor = [1,2],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 75},
		diet_love = {vege = 0.1, meat = 2, fish = 0.5, grain = 0.4},
		diet_hate = {vege = 45, meat = 0, fish = 15, grain = 25},
		tags = [],
		bodyparts = {
			ears = ['orcish'],
			skin = ['green','grey','brown'],
			size = ['average','big','huge'],
			},
		global_weight = 45,
	},
	Goblin = {
		code = "Goblin",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [1,3],
			dirtiness = [1,3],
			physics_factor = [1,2],
			magic_factor = [1,1],
			tame_factor = [2,4],
			brave_factor = [1,2],
			growth_factor = [1,2],
			sexuals_factor = [3,5],
			charm_factor = [1,3],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 35, evasion = 10},
		diet_love = {vege = 0.4, meat = 2, fish = 1, grain = 0.7},
		diet_hate = {vege = 55, meat = 1, fish = 10, grain = 25},
		tags = [],
		bodyparts = {
			ears = ['orcish'],
			skin = ['green','grey','brown'],
			size = ['petite', 'small'],
			body_shape = ['shortstack'],
			},
		global_weight = 20,
	},
	Gnome = {
		code = "Gnome",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [1,2],
			dirtiness = [1,2],
			physics_factor = [1,1],
			magic_factor = [2,4],
			tame_factor = [3,5],
			brave_factor = [1,3],
			growth_factor = [2,3],
			sexuals_factor = [2,4],
			charm_factor = [3,5],
			wit_factor = [2,5],
		},
		racetrait = {hpmax = 25, evasion = 20},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 1},
		diet_hate = {vege = 10, meat = 25, fish = 10, grain = 15},
		tags = [],
		bodyparts = {
			size = ['petite', 'small'],
			body_shape = ['shortstack'],
			},
		global_weight = 15,
	},
	Dwarf = {
		code = "Dwarf",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [3,5],
			magic_factor = [1,1],
			tame_factor = [1,3],
			brave_factor = [3,5],
			growth_factor = [2,3],
			sexuals_factor = [1,3],
			charm_factor = [1,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 55},
		diet_love = {vege = 0.3, meat = 1, fish = 1, grain = 1},
		diet_hate = {vege = 35, meat = 10, fish = 15, grain = 15},
		tags = [],
		bodyparts = {
			size = ['petite', 'small'],
			body_shape = ['shortstack'],
			},
		global_weight = 60,
	},
	Fairy = {
		code = "Fairy",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [1,2],
			dirtiness = [1,2],
			physics_factor = [1,1],
			magic_factor = [4,5],
			tame_factor = [2,4],
			brave_factor = [1,2],
			growth_factor = [2,4],
			sexuals_factor = [3,5],
			charm_factor = [4,5],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 10, mpmax = 75},
		diet_love = {vege = 1, meat = 0.1, fish = 1, grain = 1.5},
		diet_hate = {vege = 10, meat = 80, fish = 30, grain = 10},
		tags = [],
		bodyparts = {
			ears = ['elven'],
			hair = ['green','blonde','purple','white','gradient'],
			size = ['petite'],
			wings = ['fairy'],
			body_shape = ['shortstack'],
			},
		global_weight = 10,
	},
	Dryad = {
		code = "Dryad",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [1,3],
			dirtiness = [3,4],
			physics_factor = [2,4],
			magic_factor = [1,3],
			tame_factor = [1,3],
			brave_factor = [2,4],
			growth_factor = [1,3],
			sexuals_factor = [1,3],
			charm_factor = [1,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 50, mpmax = 15},
		diet_love = {vege = 2, meat = 0.1, fish = 1, grain = 1.5},
		diet_hate = {vege = 10, meat = 80, fish = 45, grain = 10},
		tags = [],
		bodyparts = {
			ears = ['elven'],
			skin = ['green','purple','brown'],
			skin_coverage = ['plant'],
			hair = ['green','purple'],
			},
		global_weight = 12,
	},
	Demon = {
		code = "Demon",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [2,5],
			magic_factor = [2,5],
			tame_factor = [1,2],
			brave_factor = [3,5],
			growth_factor = [2,5],
			sexuals_factor = [4,5],
			charm_factor = [1,4],
			wit_factor = [2,5],
		},
		racetrait = {hpmax = 45, mpmax = 35},
		diet_love = {vege = 0.5, meat = 2, fish = 1, grain = 1},
		diet_hate = {vege = 20, meat = 5, fish = 10, grain = 15},
		tags = [],
		bodyparts = {
			eye_shape = ['slit'],
			eye_color = ['yellow','red','black', 'green'],
			ears = ['demon'],
			horns = ['curved','straight'],
			wings = ["demon"],
			},
		global_weight = 5,
	},
	Seraph = {
		code = "Seraph",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [1,3],
			dirtiness = [1,3],
			physics_factor = [1,3],
			magic_factor = [3,4],
			tame_factor = [2,3],
			brave_factor = [2,4],
			growth_factor = [3,5],
			sexuals_factor = [1,2],
			charm_factor = [3,5],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 30, mpmax = 45},
		diet_love = {vege = 1, meat = 0.3, fish = 0.7, grain = 1},
		diet_hate = {vege = 5, meat = 15, fish = 10, grain = 5},
		tags = [],
		bodyparts = {
			wings = ["seraph"],
			},
		global_weight = 5,
	},
	Dragonkin = {
		code = "Dragonkin",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [4,6],
			dirtiness = [3,4],
			physics_factor = [4,6],
			magic_factor = [3,5],
			tame_factor = [1,2],
			brave_factor = [4,5],
			growth_factor = [4,6],
			sexuals_factor = [2,4],
			charm_factor = [1,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 75, mpmax = 35},
		diet_love = {vege = 1, meat = 3, fish = 1, grain = 1},
		diet_hate = {vege = 35, meat = 5, fish = 10, grain = 30},
		tags = [],
		bodyparts = {
			eye_shape = ['slit'],
			eye_color = ['red','amber'],
			ears = ['elven'],
			skin_coverage = ['scale'],
			tail = ['dragon'],
			horns = ['curved','straight'],
			wings = ['dragon'],
			},
		global_weight = 5,
	},
	Centaur = {
		code = "Centaur",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [4,5],
			dirtiness = [4,5],
			physics_factor = [3,5],
			magic_factor = [1,2],
			tame_factor = [3,4],
			brave_factor = [3,4],
			growth_factor = [2,3],
			sexuals_factor = [2,3],
			charm_factor = [1,3],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 70},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 2},
		diet_hate = {vege = 5, meat = 15, fish = 10, grain = 5},
		tags = [],
		bodyparts = {
			body_lower = ['horse'],
			body_shape = ['halfhorse'],
			tail = ['horse'],
			size = ['big', 'huge'],
			penis_type = ['equine'],
			},
		global_weight = 20,
	},
	Taurus = {
		code = "Taurus",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [3,5],
			dirtiness = [3,4],
			physics_factor = [3,5],
			magic_factor = [1,2],
			tame_factor = [4,5],
			brave_factor = [2,3],
			growth_factor = [1,3],
			sexuals_factor = [2,4],
			charm_factor = [1,3],
			wit_factor = [1,2],
		},
		racetrait = {hpmax = 65},
		diet_love = {vege = 2, meat = 0.1, fish = 0.5, grain = 3},
		diet_hate = {vege = 5, meat = 75, fish = 50, grain = 5},
		tags = ['large_tits'],
		bodyparts = {
			tail = ['cow'],
			ears = ['cow'],
			},
		global_weight = 25,
	},
	
	Harpy = {
		code = "Harpy",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,3],
			dirtiness = [3,4],
			physics_factor = [2,3],
			magic_factor = [2,3],
			tame_factor = [2,3],
			brave_factor = [1,3],
			growth_factor = [1,4],
			sexuals_factor = [3,4],
			charm_factor = [2,4],
			wit_factor = [1,2],
		},
		racetrait = {hpmax = 40, mpmax = 20},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 1},
		diet_hate = {vege = 15, meat = 10, fish = 5, grain = 5},
		tags = [],
		bodyparts = {
			body_lower = ['avian'],
			body_shape = ['halfbird'],
			tail = ['avian'],
			ears = ['feathered'],
			arms = ['wings'],
			},
		global_weight = 25,
	},
	Slime = {
		code = "Slime",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [3,4],
			dirtiness = [4,5],
			physics_factor = [1,2],
			magic_factor = [3,5],
			tame_factor = [1,2],
			brave_factor = [2,3],
			growth_factor = [2,4],
			sexuals_factor = [3,5],
			charm_factor = [1,2],
			wit_factor = [1,2],
		},
		racetrait = {hpmax = 35, mpmax = 40},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 1},
		diet_hate = {vege = 15, meat = 15, fish = 15, grain = 15},
		tags = [],
		bodyparts = {
			skin = ['slime'],
			body_shape = ['jelly'],
			},
		global_weight = 15,
	},
	Lamia = {
		code = "Lamia",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [3,5],
			dirtiness = [4,5],
			physics_factor = [4,5],
			magic_factor = [2,4],
			tame_factor = [1,1],
			brave_factor = [3,4],
			growth_factor = [2,4],
			sexuals_factor = [3,4],
			charm_factor = [1,3],
			wit_factor = [1,4],
		},
		racetrait = {hpmax = 55, mpmax = 30},
		diet_love = {vege = 0.1, meat = 2, fish = 1, grain = 0.2},
		diet_hate = {vege = 75, meat = 5, fish = 5, grain = 50},
		tags = [],
		bodyparts = {
			eye_shape = ['slit'],
			body_shape = ['halfsnake'],
			body_lower = ['snake'],
			tail = ['snake'],
			ears = ['elven'],
			},
		global_weight = 5,
	},
	Arachna = {
		code = "Arachna",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [3,5],
			dirtiness = [4,5],
			physics_factor = [3,4],
			magic_factor = [3,4],
			tame_factor = [1,1],
			brave_factor = [1,2],
			growth_factor = [2,4],
			sexuals_factor = [1,3],
			charm_factor = [1,2],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 35, mpmax = 50},
		diet_love = {vege = 0.1, meat = 2, fish = 1, grain = 0.2},
		diet_hate = {vege = 75, meat = 5, fish = 5, grain = 50},
		tags = [],
		bodyparts = {
			eye_shape = ['slit'],
			body_shape = ['halfspider'],
			body_lower = ['spider'],
			ears = ['elven'],
			},
		global_weight = 5,
	},
	Scylla = {
		code = "Scylla",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [4,5],
			physics_factor = [3,5],
			magic_factor = [3,4],
			tame_factor = [1,2],
			brave_factor = [1,3],
			growth_factor = [3,4],
			sexuals_factor = [2,4],
			charm_factor = [1,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 45, mpmax = 40},
		diet_love = {vege = 1, meat = 1, fish = 3, grain = 0.5},
		diet_hate = {vege = 10, meat = 15, fish = 5, grain = 10},
		tags = [],
		bodyparts = {
			eye_shape = ['slit'],
			body_shape = ['halfsquid'],
			body_lower = ['tentacle'],
			},
		global_weight = 5,
	},
	Nereid = {
		code = "Nereid",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [3,5],
			physics_factor = [2,4],
			magic_factor = [3,5],
			tame_factor = [2,4],
			brave_factor = [1,3],
			growth_factor = [2,4],
			sexuals_factor = [2,4],
			charm_factor = [2,4],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 45, mpmax = 40},
		diet_love = {vege = 0.5, meat = 1, fish = 3, grain = 1.5},
		diet_hate = {vege = 15, meat = 15, fish = 0, grain = 5},
		tags = [],
		bodyparts = {
			eye_shape = ['slit'],
			skin = ['teal','green'],
			tail = ['fish'],
			ears = ['fish'],
			arms = ['webbed']
			},
		global_weight = 5,
	},
	
	BeastkinCat = {
		code = "BeastkinCat",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [2,5],
			magic_factor = [1,2],
			tame_factor = [3,5],
			brave_factor = [1,3],
			growth_factor = [2,4],
			sexuals_factor = [3,5],
			charm_factor = [2,5],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 50, evasion = 10},
		diet_love = {vege = 0.5, meat = 2, fish = 2, grain = 1.5},
		diet_hate = {vege = 80, meat = 5, fish = 5, grain = 40},
		tags = ['has_halfkin_counterpart','multibreasts','beast'],
		bodyparts = {
			eye_shape = ['slit'],
			skin_coverage = ['fur_white','fur_grey','fur_brown','fur_striped','fur_black','fur_orange_white'],
			tail = ['cat'],
			ears = ['cat'],
			arms = ['fur'],
			legs = ['fur'],
			penis_type = ['feline'],
			},
		global_weight = 10,
	},
	BeastkinWolf = {
		code = "BeastkinWolf",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [2,5],
			magic_factor = [1,1],
			tame_factor = [2,4],
			brave_factor = [3,5],
			growth_factor = [2,4],
			sexuals_factor = [1,3],
			charm_factor = [2,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 60},
		diet_love = {vege = 0.5, meat = 4, fish = 1, grain = 1},
		diet_hate = {vege = 50, meat = 5, fish = 15, grain = 20},
		tags = ['has_halfkin_counterpart','multibreasts','beast'],
		bodyparts = {
			eye_shape = ['slit'],
			skin_coverage = ['fur_white','fur_grey','fur_brown','fur_black'],
			tail = ['wolf'],
			ears = ['wolf'],
			arms = ['fur'],
			legs = ['fur'],
			penis_type = ['canine'],
			},
		global_weight = 10,
	},
	BeastkinFox = {
		code = "BeastkinFox",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [1,3],
			magic_factor = [2,5],
			tame_factor = [2,4],
			brave_factor = [1,2],
			growth_factor = [2,4],
			sexuals_factor = [3,5],
			charm_factor = [3,5],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 30, mpmax = 30},
		diet_love = {vege = 0.5, meat = 2, fish = 1, grain = 1},
		diet_hate = {vege = 70, meat = 5, fish = 15, grain = 35},
		tags = ['has_halfkin_counterpart','multibreasts','beast'],
		bodyparts = {
			eye_shape = ['slit'],
			skin_coverage = ['fur_white','fur_grey','fur_black','fur_orange'],
			tail = ['fox'],
			ears = ['fox'],
			arms = ['fur'],
			legs = ['fur'],
			penis_type = ['canine'],
			},
		global_weight = 10,
	},
	BeastkinBunny = {
		code = "BeastkinBunny",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [1,3],
			magic_factor = [1,3],
			tame_factor = [4,5],
			brave_factor = [1,1],
			growth_factor = [2,4],
			sexuals_factor = [4,6],
			charm_factor = [2,5],
			wit_factor = [1,2],
		},
		racetrait = {hpmax = 30, mpmax = 20},
		diet_love = {vege = 3, meat = 0.3, fish = 0.5, grain = 2},
		diet_hate = {vege = 5, meat = 40, fish = 30, grain = 5},
		tags = ['has_halfkin_counterpart','multibreasts','beast'],
		bodyparts = {
			skin_coverage = ['fur_white','fur_grey'],
			tail = ['bunny'],
			ears = ['bunny_standing','bunny_drooping'],
			arms = ['fur'],
			legs = ['fur'],
			},
		global_weight = 10,
	},
	BeastkinTanuki = {
		code = "BeastkinTanuki",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,4],
			physics_factor = [2,4],
			magic_factor = [2,4],
			tame_factor = [2,4],
			brave_factor = [2,4],
			growth_factor = [2,4],
			sexuals_factor = [2,4],
			charm_factor = [2,4],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 45, mpmax = 15},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 1},
		diet_hate = {vege = 10, meat = 15, fish = 5, grain = 10},
		tags = ['has_halfkin_counterpart','multibreasts','beast'],
		bodyparts = {
			skin_coverage = ['fur_brown','fur_striped'],
			tail = ['tanuki'],
			ears = ['tanuki'],
			arms = ['fur'],
			legs = ['fur'],
			},
		global_weight = 10,
	},
	HalfkinCat = {
		code = "HalfkinCat",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,3],
			physics_factor = [2,5],
			magic_factor = [1,2],
			tame_factor = [3,5],
			brave_factor = [1,3],
			growth_factor = [2,4],
			sexuals_factor = [3,5],
			charm_factor = [2,5],
			wit_factor = [1,3],
		},
		racetrait = {hpmax = 50, evasion = 10},
		diet_love = {vege = 0.5, meat = 2, fish = 2, grain = 1.5},
		diet_hate = {vege = 80, meat = 5, fish = 5, grain = 40},
		tags = ['beast'],
		bodyparts = {
			eye_shape = ['slit'],
			tail = ['cat'],
			ears = ['cat'],
			},
		global_weight = 10,
	},
	HalfkinWolf = {
		code = "HalfkinWolf",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,3],
			physics_factor = [2,5],
			magic_factor = [1,1],
			tame_factor = [2,4],
			brave_factor = [3,5],
			growth_factor = [2,4],
			sexuals_factor = [1,3],
			charm_factor = [2,3],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 60},
		diet_love = {vege = 0.5, meat = 4, fish = 1, grain = 1},
		diet_hate = {vege = 50, meat = 5, fish = 15, grain = 20},
		tags = ['beast'],
		bodyparts = {
			eye_shape = ['slit'],
			tail = ['wolf'],
			ears = ['wolf'],
			},
		global_weight = 10,
	},
	HalfkinFox = {
		code = "HalfkinFox",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,3],
			physics_factor = [1,3],
			magic_factor = [2,5],
			tame_factor = [2,4],
			brave_factor = [1,2],
			growth_factor = [2,4],
			sexuals_factor = [3,5],
			charm_factor = [3,5],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 30, mpmax = 30},
		diet_love = {vege = 0.5, meat = 2, fish = 1, grain = 1},
		diet_hate = {vege = 70, meat = 5, fish = 15, grain = 35},
		tags = ['beast'],
		bodyparts = {
			eye_shape = ['slit'],
			tail = ['fox'],
			ears = ['fox'],
			},
		global_weight = 10,
	},
	HalfkinBunny = {
		code = "HalfkinBunny",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,3],
			physics_factor = [1,3],
			magic_factor = [1,3],
			tame_factor = [4,5],
			brave_factor = [1,1],
			growth_factor = [2,4],
			sexuals_factor = [4,6],
			charm_factor = [2,5],
			wit_factor = [1,2],
		},
		racetrait = {hpmax = 30, mpmax = 20},
		diet_love = {vege = 3, meat = 0.3, fish = 0.5, grain = 2},
		diet_hate = {vege = 5, meat = 40, fish = 30, grain = 5},
		tags = ['beast'],
		bodyparts = {
			tail = ['bunny'],
			ears = ['bunny_standing','bunny_drooping'],
			},
		global_weight = 10,
	},
	HalfkinTanuki = {
		code = "HalfkinTanuki",
		name = '',
		descript = '',
		adjective = '',
		icon = null,
		body = null,
		basestats = {
			food_consumption = [2,4],
			dirtiness = [2,3],
			physics_factor = [2,4],
			magic_factor = [2,4],
			tame_factor = [2,4],
			brave_factor = [2,4],
			charm_factor = [2,4],
			wit_factor = [2,4],
		},
		racetrait = {hpmax = 45, mpmax = 15},
		diet_love = {vege = 1, meat = 1, fish = 1, grain = 1},
		diet_hate = {vege = 10, meat = 15, fish = 5, grain = 10},
		tags = ['beast'],
		bodyparts = {
			tail = ['tanuki'],
			ears = ['tanuki'],
			},
		global_weight = 10,
	},
}

var points_of_interest = {
	settlement = {},
	banditcamp = {},
	cave = {},
	dungeon = {},
	
	
}


var lands = {
	plains = {
		code = 'plains',
		lead_race = 'Human', #lead race has 80% chance to be presented in all settlements
		secondary_races = ['Halfbreeds'], #secondary races have 30% chance to be presented in all settlements (or guaranteed if lead race is not) and 50% for another additional race 
		policies = [], #not used as of now
		travel_time = 0, #how long it gonna take to travel to region
		difficulty = 0, #growing number defining quests and individuals
		disposition = 100, #reputation, not currently used
		population = [100000, 200000], #population, not currently used, but planned to be possible to affect its numbers
		start_settlements_number = {settlement_large = [1,1], settlement_small = [1,1]}, #will generate said locations on first generation
		start_locations_number = 3, #will generate this number of smaller locations like dungeons
		locations = [], #array to fill up with settlements and dungeons
		locationpool = ['caves', 'bandit_camp'], #array of allowed locations to generate
		guilds = ['fighters','mages','workers','servants'],
	},
	forests = {
		code = 'forests',
		lead_race = 'Elf',
		secondary_races = ['DarkElf','Fairy','Dryad','Halfbreeds'],
		policies = [],
		travel_time = 1,
		difficulty = 1,
		disposition = 25,
		population = [20000, 50000],
		start_settlements_number = {settlement_large = [1,1], settlement_small = [1,1]},
		start_locations_number = 3, 
		locations = [],
		locationpool = ['caves'],
		guilds = [],
	},
}


func make_area(code):
	var areadata = lands[code].duplicate()
	areadata.population = round(rand_range(areadata.population[0],areadata.population[1]))
	for i in areadata.start_settlements_number:
		var number = round(rand_range(areadata.start_settlements_number[i][0], areadata.start_settlements_number[i][1]))
		while number > 0:
			make_settlement(i, areadata)
			number -= 1
	while areadata.start_locations_number > 0:
		make_location(areadata.locationpool[randi()%areadata.locationpool.size()], areadata)
		areadata.start_locations_number -= 1
	areadata.existing_guilds = []
	for i in areadata.guilds:
		make_guild(i, areadata)
	areadata.guilds = areadata.existing_guilds
	areadata.erase("existing_guilds")
	return areadata

var guildsdata = {
	fighters = {
		code = 'fighters',
		name = 'Fighters',
		description = '',
		preference = ['combat'],
		quests_easy = ['warriors_threat_basic','warriors_dungeon_basic','warriors_monster_hunt_basic','warriors_fighter_slave_basic'],
		quests_medium = [],
		quests_hard = [],
		slavenumber = [1,1],
		questnumber = [1,1],
	},
	mages = {
		code = 'mages',
		name = 'Mages',
		description = '',
		preference = ['magic'],
		quests_easy = ['mages_materials_basic','mages_craft_potions_basic','mages_threat_basic','mages_slave_basic'],
		quests_medium = [],
		quests_hard = [],
		slavenumber = [1,1],
		questnumber = [1,1],
	},
	workers = {
		code = 'workers',
		name = 'Workers',
		description = '',
		preference = ['labor'],
		quests_easy = ['workers_resources_basic','workers_food_basic','workers_craft_tools_basic','workers_threat_basic'],
		quests_medium = [],
		quests_hard = [],
		slavenumber = [1,1],
		questnumber = [1,1],
	},
	servants = {
		code = 'servants',
		name = 'Servants',
		description = '',
		preference = ['sexual','social'],
		quests_easy = ['servants_craft_items_basic','servants_slave_basic'],
		quests_medium = [],
		quests_hard = [],
		slavenumber = [2,2],
		questnumber = [1,1],
	},
}

func make_guild(code, area):
	var factiondata = guildsdata[code].duplicate(true)
	var guilddatatemplate = {
		base = factiondata.code,
		name = factiondata.name,
		preferences = factiondata.preference,
		description = factiondata.description,
		questpool = {easy = factiondata.quests_easy, medium = factiondata.quests_medium, hard = factiondata.quests_hard},
		quests = {easy = [], medium = [], hard = []},
		questsetting = {easy = 1, medium = 0, hard = 0, total = 1},
		slaves = [],
		reputation = 0,
	}
	factiondata.slavenumber = round(rand_range(factiondata.slavenumber[0], factiondata.slavenumber[1]))
	factiondata.questnumber = round(rand_range(factiondata.questnumber[0], factiondata.questnumber[1]))
	
	while factiondata.slavenumber > 0:
#warning-ignore:unassigned_variable
		var newslave
		guilddatatemplate.slaves.append(newslave)
		factiondata.slavenumber -= 1
	
	while factiondata.questnumber > 0:
		for i in ['easy','medium','hard']:
			while guilddatatemplate.questsetting[i] > guilddatatemplate.quests[i].size():
				var newquest = make_quest(guilddatatemplate.questpool[i][randi()%guilddatatemplate.questpool[i].size()])
				newquest.source = code
				newquest.area = area.code
				newquest.travel_time = area.travel_time + round(randf()+1)
				guilddatatemplate.quests[i].append(newquest)
		factiondata.questnumber -= 1
	
	area.existing_guilds.append(guilddatatemplate)

func make_settlement(code, area):
	var settlement = locations[code].duplicate(true)
	settlement.population = round(rand_range(settlement.population[0],settlement.population[1]))
	settlement.name = 'Settlement'#add random names based on races/areas
	if randf() <= 0.8:
		settlement.races.append(area.lead_race)
	if randf() >= 0.7 || settlement.races.size() == 0:
		var added_races = area.secondary_races.duplicate()
		var another_race = added_races[randi()%added_races.size()]
		settlement.races.append(another_race)
		added_races.erase(another_race)
		if randf() >= 0.5 && added_races.size() > 0:
			settlement.races.append(added_races[randi()%added_races.size()])
	
	
	#adding resource types the settlement is going to have
	var food_types = round(rand_range(settlement.food_type_number[0], settlement.food_type_number[1]))
	var resource_array = []
	for i in Items.materiallist.values():
		if i.type == 'food':
			resource_array.append(i.code)
	while food_types > 0:
		var resource = resource_array[randi()%resource_array.size()]
		settlement.resources.append(resource)
		resource_array.erase(resource)
		food_types -= 1
	var resource_types = round(rand_range(settlement.resources_type_number[0], settlement.resources_type_number[1]))
	resource_array = []
	for i in Items.materiallist.values():
		if i.code in ['wood', 'stone', 'cloth']:
			resource_array.append(i.code)
	while resource_types > 0:
		var resource = resource_array[randi()%resource_array.size()]
		settlement.resources.append(resource)
		resource_array.erase(resource)
		resource_types -= 1
	
	
	area.locations.append(settlement)


func make_location(code, area):
	var location = locations[code].duplicate(true)
	location.name = code #add name generation
	location.strength = round(rand_range(location.strength[0],location.strength[1]))
	
	area.locations.append(location)

var locations = {
	settlement_small = {
		code = 'settlement_small',
		races = [],
		population = [100,500],
		resources = [],
		fear = 0,
		approval = 0,
		leader = '',
		actions = [],
		strength = [1,10],
		food_type_number = [1,2],
		resources_type_number = [1,2],
	},
	settlement_large = {
		code = 'settlement_large',
		races = [],
		population = [1000,10000],
		resources = [],
		fear = 0,
		approval = 0,
		leader = '',
		actions = [],
		strength = [20,50],
		food_type_number = [2,4],
		resources_type_number = [2,3],
	},
	caves = {
		code = 'caves',
		actions = [],
		strength = [1,10],
		levels = [5,10],
		enemies = [],
		events = [],
	},
	bandit_camp = {
		code = 'bandit_camp',
		actions = [],
		strength = [5,10],
		levels = [3,5],
		enemies = ['bandit_easy']
	},
}







var questdata = {
	workers_resources_basic = {
		code = 'workers_resources_basic',
		type = 'materialsquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'material', function = 'range', type = ['wood','stone','cloth'], range = [45,60]},{use_once = false, code = 'material', function = 'range', type = ['bone','leather'], range = [25,40]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	workers_food_basic = {
		code = 'workers_food_basic',
		type = 'materialsquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'material', function = 'range', type = ['meat','fish','vegetables','grain'], range = [45,60]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	workers_craft_tools_basic = {
		code = 'workers_craft_tools_basic',
		type = 'itemsquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'item', function = 'range', type = ['axe','pickaxe','sickle'], range = [2,2]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	workers_threat_basic = {
		code = 'workers_threat_basic',
		type = 'eventlocationquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'eventlocation', function = 'range', type = ['basic_threat_bandits'], range = [1,1]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [100,150]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	warriors_threat_basic = {
		code = 'warriors_threat_basic',
		type = 'eventlocationquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'eventlocation', function = 'range', type = ['basic_threat_bandits'], range = [1,1]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [100,150]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	warriors_dungeon_basic = {
		code = 'warriors_dungeon_basic',
		type = 'dungeonquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'dungeon', function = 'range', type = ['dungeon_easy'], range = [1,1]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	warriors_monster_hunt_basic = {
		code = 'warriors_monster_hunt_basic',
		type = 'monsterhuntquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'monsters', function = 'range', type = ['rat'], range = [6,9]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	warriors_fighter_slave_basic = {
		code = 'warriors_fighter_slave_basic',
		type = 'slavegetquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = true, code = 'stat', function = 'range', type = ['body_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range', type = ['physics'], range = [20,40]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	mages_materials_basic = {
		code = 'mages_materials_basic',
		type = 'materialsquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'material', function = 'range', type = ['salvia','fleawarts','cloth'], range = [15,25]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	mages_craft_potions_basic = {
		code = 'mages_craft_potions_basic',
		type = 'itemsquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'item', function = 'range', type = ['aphrodisiac', 'alcohol'], range = [2,4]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [100,150]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	mages_threat_basic = {
		code = 'mages_threat_basic',
		type = 'eventlocationquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'eventlocation', function = 'range', type = ['basic_threat_bandits'], range = [1,1]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [100,150]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	mages_slave_basic = {
		code = 'mages_slave_basic',
		type = 'slavegetquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = true, code = 'stat', function = 'range', type = ['magic_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range', type = ['wits'], range = [20,40]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	servants_craft_items_basic = {
		code = 'servants_craft_items_basic',
		type = 'itemsquest',
		name = '',
		descript = '',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'item', function = 'range', type = ['leather_collar'], range = [2,2]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	servants_slave_basic = {
		code = 'servants_slave_basic',
		type = 'slavegetquest',
		name = '',
		descript = '',
		randomconditions = {number = [2,2], variances = [{use_once = true, code = 'stat', function = 'range', type = ['tame_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range', type = ['charm','sexuals'], range = [20,40]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
}

var quest_template = {
	name = '',
	descript = '',
	type = '',
	source = '',
	location = '',
	requirements = [],
	rewards = [],
	time_limit = 0,
	taken = false,
}

func make_quest(questcode):
	var template = questdata[questcode].duplicate(true)#array[randi()%array.size()]
	var data = quest_template.duplicate(true)
	
	data.code = template.code
	data.name = template.code#change to name later
	data.descript = template.descript
	data.time_limit = round(rand_range(template.time_limit[0], template.time_limit[1]))
	data.type = template.type
	
	#location = location - add quest placement
	var requirements_number = round(rand_range(template.randomconditions.number[0], template.randomconditions.number[1]))
	var reqsarray = template.randomconditions.variances.duplicate()
	while requirements_number > 0:
		var tempdata = reqsarray[randi()%reqsarray.size()].duplicate()
		var reqsarrayposition = reqsarray.find(tempdata) #save position to clear same types if to be used multiple times
		match tempdata.function:
			'range':
				tempdata.value = round(rand_range(tempdata.range[0], tempdata.range[1]))
				tempdata.erase('range')
			'array':
				tempdata.value = tempdata.array[randi()%tempdata.array.size()]
				tempdata.erase('array')
		data.requirements.append(tempdata)
		if tempdata.use_once == true:
			reqsarray.erase(tempdata)
		else:
			reqsarray[reqsarrayposition].type.erase(tempdata.type)
		tempdata.type = tempdata.type[randi()%tempdata.type.size()]
		tempdata.erase('function')
		tempdata.erase('use_once')
		requirements_number -= 1
	for i in template.rewards.duplicate():
		i.value = round(rand_range(i.range[0],i.range[1]))
		i.erase('range')
		data.rewards.append(i)
	
	return data

func take_quest(quest):
	quest.taken = true
	if quest.type in ['eventlocationquest','dungeonquest']:
		make_quest_location(quest)

func make_quest_location(quest):
	var locationdata = {}
	for i in quest.requirements:
		match quest.type:
			'eventlocationquest':
				var data = event_locations_data[i.type].duplicate(true)
				locationdata.type = 'event'
				locationdata.code = data.code
				locationdata.name = data.name
				locationdata.descript = data.descript
				locationdata.quest = quest.code
				locationdata.area = quest.area
				locationdata.travel_time = quest.travel_time
				locationdata.event = data.event_code
			'dungeonquest':
				var data = dungeons[i.type].duplicate(true)
				locationdata.type = 'dungeon'
				locationdata.code = data.code
				locationdata.name = data.name
				locationdata.descript = data.descript
				locationdata.quest = quest.code
				locationdata.area = quest.area
				locationdata.travel_time = quest.travel_time
				locationdata.stages = round(rand_range(data.stages[0], data.stages[1]))
				locationdata.enemies = data.enemies
				locationdata.difficulty = round(rand_range(data.difficulty[0], data.difficulty[1]))
				
	

var dungeons = {
	dungeon_easy = {
		code = 'dungeon_easy',
		name = '',
		descript = '',
		background = '',
		stages = [3,5],
		difficulty = [1,2],
		enemies = [['bandits_easy', 1]],
		affiliation = ['local'], #defines character races and events
		events = [],
	},
}

var enemies = {
	bandit_easy = {
		code = 'bandit_easy',
		name = '',
		hp = 100,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		damage = 10,
		speed = 50,
		resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = true,
		gear = [],
		ai = ['ranged','melee'],
	},
	cave_goblin = {
		code = 'cave_goblin',
		name = '',
		hp = 75,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 25,
		armorpenetration = 0,
		damage = 10,
		speed = 50,
		resists = {},
		race = 'humanoid',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = true,
		gear = [],
		ai = ['ranged','melee'],
	},
	skeleton = {
		code = 'skeleton',
		name = '',
		hp = 90,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		damage = 15,
		speed = 30,
		resists = {},
		race = 'undead',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = false,
		gear = [],
		ai = ['ranged','melee'],
	},
	wolf = {
		code = 'wolf',
		name = '',
		hp = 90,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		damage = 15,
		speed = 30,
		resists = {},
		race = 'beast',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = false,
		gear = [],
		ai = ['melee'],
	},
	spider = {
		code = 'spider',
		name = '',
		hp = 90,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		damage = 15,
		speed = 30,
		resists = {},
		race = 'beast',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = false,
		gear = [],
		ai = ['melee'],
	},
	rat = {
		code = 'rat',
		name = '',
		hp = 40,
		armor = 0,
		mdef = 0,
		hitrate = 85,
		evasion = 0,
		armorpenetration = 0,
		damage = 15,
		speed = 30,
		resists = {},
		race = 'beast',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = false,
		gear = [],
		ai = ['melee'],
	},
	gryphon = {
		code = 'gryphon',
		name = '',
		hp = 300,
		armor = 25,
		mdef = 50,
		hitrate = 120,
		evasion = 40,
		armorpenetration = 0,
		damage = 90,
		speed = 50,
		resists = {},
		race = 'beast',
		loot = 'bandit_loot',
		icon = null,
		skills = [],
		tags = [],
		is_character = false,
		gear = [],
		ai = ['melee'],
	},
}
var enemygroups = {
	bandits_group_easy = {bandit_easy = [2,4]},
}

var event_locations_data = {
	basic_threat_bandits = {code = 'basic_threat_bandits', type = 'event', event_code = 'bandits_threat_quest', name = 'Quest - Bandits', descript = '', icon = null},
	
}

var eventscrits = {
	bandits_threat_quest = {
		reqs = [],
		event_start = [
			{
				effects = [],
				action = 'choice_event',
				text = 'You come to the place finding tracks of the bandits. ',
				reqs = [],
				options = [
					{text = 'Fight', reqs = [], follow_up = 'event_fight'},
				],
			},
			],
		event_fight = [
			{
				action = 'start_fight',
				value = 'bandits_group_easy',
				wineffects = [{code = 'quest_complete'}],
			}
			]
	},
	meet_adventurer_at_dungeon_event = {
		reqs = [],
		event_start = [
			{
				effects = [{code = 'generate_event_stranger'}],
				action = 'choice_event',
				text = 'You meet a lone adventurer: [name]. ',
				reqs = [],
				options = [
					{text = 'Attack', reqs = [], follow_up = 'event_fight'},
				],
			}
		
		],
		
		
	}
	
}


var upgrades = {}

var events = {
	
}

var easter_egg_characters = {
	Chloe = {
		race = 'Gnome',
		name = 'Chloe',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'petite',
		hair_color = 'red',
		eye_color = 'blue',
		tits_size = 'average',
		ass_size = 'big',
		skin = 'fair',
		hair_style = 'pigtails',
		hair_length = 'shoulder',
		icon = null,
		body = null,
		wit_factor = 4,
		wits = 70,
		professions = ['alchemist','apprentice'],
	},
	Cali = {
		race = 'Halfkin Wolf',
		name = 'Cali',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'short',
		hair_color = 'gray',
		eye_color = 'blue',
		eye_shape = 'slit',
		tits_size = 'flat',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'shoulder',
		icon = null,
		body = null,
		brave_factor = 4,
		class_category = 'combat',
	},
	Ember = {
		race = 'Dragonkin',
		name = 'Ember',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'tall',
		hair_color = 'dark red',
		eye_color = 'green',
		tits_size = 'big',
		ass_size = 'big',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'shoulder',
		icon = null,
		body = null,
		class_category = 'labor',
		professions = ['smith']
	},
	Maple = {
		race = 'Fairy',
		name = 'Maple',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'tiny',
		hair_color = 'red',
		eye_color = 'red',
		tits_size = 'average',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'shoulder',
		icon = null,
		body = null,
		class_category = 'social',
		professions = []
	},
	Raphtalia = {
		race = 'Halfkin Tanuki',
		name = 'Raphtalia',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'average',
		hair_color = 'brown',
		eye_color = 'red',
		tits_size = 'average',
		ass_size = 'average',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'combat',
		professions = []
	},
	Fran = {
		race = 'Halfkin Cat',
		name = 'Fran',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'petite',
		hair_color = 'black',
		eye_color = 'black',
		tits_size = 'small',
		ass_size = 'flat',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'neck',
		icon = null,
		body = null,
		class_category = 'combat',
		professions = []
	},
	Evangelyne = {
		race = 'Elf',
		name = 'Evangelyne',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'average',
		hair_color = 'blond',
		eye_color = 'green',
		tits_size = 'average',
		ass_size = 'average',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'neck',
		icon = null,
		body = null,
		class_category = 'combat',
		professions = ['archer', 'sniper']
	},
	Tamamo = {
		race = 'Halfkin Fox',
		name = 'Tamamo',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'petite',
		hair_color = 'blond',
		eye_color = 'green',
		tits_size = 'flat',
		ass_size = 'flat',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Horo = {
		race = 'Halfkin Wolf',
		name = 'Horo',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'short',
		hair_color = 'brown',
		eye_color = 'red',
		tits_size = 'small',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'shoulder',
		icon = null,
		body = null,
		class_category = 'combat',
	},
	Lulu = {
		race = 'Fairy',
		name = 'Lulu',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'tiny',
		hair_color = 'purple',
		eye_color = 'green',
		tits_size = 'flat',
		ass_size = 'flat',
		skin = 'purple',
		hair_style = 'straight',
		hair_length = 'hips',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Mir = {
		race = 'Human',
		name = 'Mir',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'short',
		hair_color = 'black',
		eye_color = 'red',
		tits_size = 'flat',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Ahri = {
		race = 'Halfkin Fox',
		name = 'Ahri',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'average',
		hair_color = 'black',
		eye_color = 'yellow',
		tits_size = 'big',
		ass_size = 'average',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Momiji = {
		race = 'Halfkin Wolf',
		name = 'Momiji',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'average',
		hair_color = 'white',
		eye_color = 'red',
		tits_size = 'average',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'neck',
		icon = null,
		body = null,
		class_category = 'combat',
	},
	Youseiyunde = {
		race = 'Elf',
		name = 'Youseiyunde',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'short',
		hair_color = 'green',
		eye_color = 'green',
		tits_size = 'flat',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'neck',
		icon = null,
		body = null,
		class_category = 'combat',
	},
	Marcille = {
		race = 'Elf',
		name = 'Marcille',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'average',
		hair_color = 'blonde',
		eye_color = 'green',
		tits_size = 'small',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Schierke = {
		race = 'Human',
		name = 'Schierke',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'petite',
		hair_color = 'green',
		eye_color = 'blue',
		tits_size = 'flat',
		ass_size = 'flat',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'neck',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Feliss = {
		race = 'Demon',
		name = 'Feliss',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'average',
		hair_color = 'green',
		eye_color = 'blue',
		tits_size = 'average',
		ass_size = 'average',
		ears = 'elven',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'hips',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Jehy = {
		race = 'Demon',
		name = 'Jehy',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'short',
		hair_color = 'black',
		eye_color = 'yellow',
		tits_size = 'average',
		ass_size = 'average',
		ears = 'elven',
		horns = '',
		skin = 'brown',
		hair_style = 'braid',
		hair_length = 'hips',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Albedo = {
		race = 'Demon',
		name = 'Albedo',
		descript = '',
		sex = 'female',
		age = 'adult',
		height = 'tall',
		hair_color = 'black',
		eye_color = 'yellow',
		tits_size = 'big',
		ass_size = 'big',
		skin = 'pale',
		hair_style = 'straight',
		hair_length = 'hips',
		icon = null,
		body = null,
		class_category = 'combat',
	},
	Aura = {
		race = 'DarkElf',
		name = 'Aura',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'petite',
		hair_color = 'blond',
		eye_color = 'green',
		tits_size = 'flat',
		ass_size = 'flat',
		skin = 'brown',
		hair_style = 'straight',
		hair_length = 'ear',
		icon = null,
		body = null,
		class_category = 'combat',
	},
	Senko = {
		race = 'Halfkin Fox',
		name = 'Senko',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'petite',
		hair_color = 'blond',
		eye_color = 'yellow',
		tits_size = 'flat',
		ass_size = 'flat',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'neck',
		icon = null,
		body = null,
		class_category = 'social',
	},
	Hanyuu = {
		race = 'Demon',
		name = 'Hanyuu',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'short',
		hair_color = 'purple',
		eye_color = 'purple',
		tits_size = 'average',
		ass_size = 'small',
		skin = 'fair',
		hair_style = 'straight',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'magic',
	},
	Nanachi = {
		race = 'Beastkin Bunny',
		name = 'Nanachi',
		descript = '',
		sex = 'female',
		age = 'teen',
		height = 'petite',
		hair_color = 'white',
		eye_color = 'yellow',
		tits_size = 'flat',
		ass_size = 'flat',
		skin = 'fair',
		hair_style = 'neck',
		hair_length = 'waist',
		icon = null,
		body = null,
		class_category = 'combat',
	},
}
