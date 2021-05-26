extends Node

var upgradelist = {
	resource_gather_fish = {
		code = 'resource_gather_fish',
		name = '',
		positionorder = 3,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFISHBONUS"),
				taskprogress = 100,
				cost = {wood = 50, fish = 100},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFISHBONUS"),
				taskprogress = 200,
				cost = {wood = 100, fish = 250},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFISHBONUS"),
				taskprogress = 300,
				cost = {wood = 200, fish = 350},
			},
			4:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFISHBONUS"),
				taskprogress = 400,
				cost = {woodmagic = 100, fish = 500},
			},
			5:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFISHBONUS"),
				taskprogress = 500,
				cost = {woodiron = 200, fish = 500},
			}
		}
	},
	resource_gather_veges = {
		code = 'resource_gather_veges',
		name = '',
		positionorder = 3,
		descript = '',
		category = 'facilitiy',
		tree_position = {x = 4, y = 6},#for testing & example
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 100,
				cost = {wood = 50, vegetables = 100},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 200,
				cost = {wood = 100, vegetables = 250},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 300,
				cost = {wood = 200, vegetables = 350},
			},
			4:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 400,
				cost = {woodmagic = 100, vegetables = 500},
			},
			5:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 500,
				cost = {woodiron = 200, vegetables = 500},
			}
		}
	},
	resource_gather_grains = {
		code = 'resource_gather_grains',
		name = '',
		positionorder = 4,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFARMGRAINSBONUS"),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			}
		}
	},
	resource_gather_cloth = {
		code = 'resource_gather_cloth',
		name = '',
		positionorder = 5,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEGATHERCLOTHBONUS"),
				taskprogress = 250,
				cost = {wood = 100, iron = 30},
			},
		}
	},
	tailor = {
		code = 'tailor',
		name = '',
		positionorder = 1,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADETAILORBONUS1"),
				taskprogress = 200,
				cost = {wood = 30, stone = 25},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADETAILORBONUS2"),
				taskprogress = 300,
				cost = {woodiron = 50, stone = 50, clothsilk = 25},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADETAILORBONUS3"),
				taskprogress = 500,
				cost = {woodiron = 50, mithril = 25, clothmagic = 25},
			}
		}
	},
	forge = {
		code = 'forge',
		name = '',
		positionorder = 2,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFORGEBONUS1"),
				taskprogress = 200,
				cost = {wood = 10, stone = 25, iron = 10},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFORGEBONUS2"),
				taskprogress = 500,
				cost = {iron = 50, stone = 100, wood = 100},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFORGEBONUS3"),
				taskprogress = 750,
				cost = {mithril = 50, stone = 200, obsidian = 10, woodiron = 100},
			},
		}
	},
	alchemy = {
		code = 'alchemy',
		name = '',
		positionorder = 2,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEALCHEMYBONUS1"),
				taskprogress = 250,
				cost = {wood = 25, stone = 50, iron = 30},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEALCHEMYBONUS2"),
				taskprogress = 500,
				cost = {obsidian = 20, woodmagic = 30, clothmagic = 30},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEALCHEMYBONUS3"),
				taskprogress = 1000,
				cost = {leathermythic = 20, woodancient = 10, boneancient = 30},
			}
		}
	},
	master_bedroom = {
		code = 'master_bedroom',
		name = '',
		positionorder = 6,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS1"),
				taskprogress = 100,
				cost = {wood = 30, cloth = 20},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS2"),
				taskprogress = 200,
				cost = {wood = 50, clothsilk = 15},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS3"),
				taskprogress = 300,
				cost = {wood = 100, clothsilk = 35},
			}
		}
	},

	stables = {
		code = 'stables',
		name = '',
		positionorder = 5,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADESTABLESBONUS1"),
				taskprogress = 100,
				cost = {wood = 50, leather = 25},
			},
			2:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'),
				bonusdescript = tr("UPGRADESTABLESBONUS2"),
				taskprogress = 200,
				cost = {woodiron = 50, leatherthick = 50},
			},
			3:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'),
				bonusdescript = tr("UPGRADESTABLESBONUS3"),
				taskprogress = 300,
				cost = {woodiron = 100, wood = 200, leather = 100, leathermythic = 50},
			}
		}
	},

	forgeworkshop = {
		code = 'forgeworkshop',
		name = '',
		positionorder = 4,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFORGEWORKBONUS1"),
				taskprogress = 75,
				cost = {woodiron = 100, leatherthick = 100, steel = 50},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEFORGEWORKBONUS2"),
				taskprogress = 250,
				cost = {mithril = 50, leathermythic = 50, clothmagic = 25},
			},
		}
	},

	torture_room = {
		code = 'torture_room',
		name = '',
		positionorder = 5,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADETORTUREROOMBONUS"),
				taskprogress = 50,
				cost = {wood = 25, leather = 20, iron = 10},
			},
		}
	},

	rooms = {
		code = 'rooms',
		name = '',
		positionorder = 4,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEROOMSBONUS1"),
				taskprogress = 100,
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEROOMSBONUS2"),
				taskprogress = 200,
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEROOMSBONUS3"),
				taskprogress = 300,
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEROOMSBONUS4"),
				taskprogress = 400,
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
			5:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADEROOMSBONUS5"),
				taskprogress = 500,
				cost = {woodiron = 100, clothsilk = 50, steel = 50},
			},
		}
	},

	luxury_rooms = {
		code = 'luxury_rooms',
		name = '',
		positionorder = 3,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS1"),
				taskprogress = 100,
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS2"),
				taskprogress = 200,
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS3"),
				taskprogress = 300,
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS4"),
				taskprogress = 400,
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},\
		}
	},

	tattoo_set = {
		code = 'tattoo_set',
		name = '',
		positionorder = 8,
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm',
				bonusdescript = tr("UPGRADETATTOOBONUS"),
				taskprogress = 100,\
				cost = {woodiron = 25, woodmagic = 25, leatherthick = 20},
			},
		}
	},
}
