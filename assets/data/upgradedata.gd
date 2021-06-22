extends Node

var upgradelist = {
#	resource_gather_fish = {
#		code = 'resource_gather_fish',
#		name = '',
#		descript = '',
#		category = 'facilitiy',
#		levels = {
#			1:{
#				unlockreqs = [],
#				icon = 'upgrade_farm',
#				bonusdescript = tr("UPGRADEFISHBONUS"),
#				taskprogress = 100,
#				cost = {wood = 50, fish = 100},
#			},
#			2:{
#				unlockreqs = [],
#				icon = 'upgrade_farm',
#				bonusdescript = tr("UPGRADEFISHBONUS"),
#				taskprogress = 200,
#				cost = {wood = 100, fish = 250},
#			},
#			3:{
#				unlockreqs = [],
#				icon = 'upgrade_farm',
#				bonusdescript = tr("UPGRADEFISHBONUS"),
#				taskprogress = 300,
#				cost = {wood = 200, fish = 350},
#			},
#			4:{
#				unlockreqs = [],
#				icon = 'upgrade_farm',
#				bonusdescript = tr("UPGRADEFISHBONUS"),
#				taskprogress = 400,
#				cost = {woodmagic = 100, fish = 500},
#			},
#			5:{
#				unlockreqs = [],
#				icon = 'upgrade_farm',
#				bonusdescript = tr("UPGRADEFISHBONUS"),
#				taskprogress = 500,
#				cost = {woodiron = 200, fish = 500},
#			}
#		}
#	},
	resource_gather_veges = {
		code = 'resource_gather_veges',
		name = '',
		descript = '',
		category = 'facilitiy',
		tree_position = {x = 18, y = 1},
		icon = "veges",
		#tree_position = {x = 1, y = 5},
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 100,
				cost = {wood = 50, vegetables = 100},
			},
#			2:{
#				unlockreqs = [],
#				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
#				taskprogress = 200,
#				cost = {wood = 100, vegetables = 250},
#			},
#			3:{
#				unlockreqs = [],
#				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
#				taskprogress = 300,
#				cost = {wood = 200, vegetables = 350},
#			},
#			4:{
#				unlockreqs = [],
#				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
#				taskprogress = 400,
#				cost = {woodmagic = 100, vegetables = 500},
#			},
#			5:{
#				unlockreqs = [],
#				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
#				taskprogress = 500,
#				cost = {woodiron = 200, vegetables = 500},
#			}
		}
	},
	farming_max_workers = {
		code = 'farming_max_workers',
		name = '',
		tree_position = {x = 13, y = 6},
		descript = '',
		icon = "wheat",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			}
		}
	},
	fishing_max_workers = {
		code = 'fishing_max_workers',
		name = '',
		tree_position = {x = 13, y = 10},
		descript = '',
		icon = "wheat",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			}
		}
	},

	resource_gather_grains = {
		code = 'resource_gather_grains',
		name = '',
		tree_position = {x = 18, y = 5},
		descript = '',
		icon = "wheat",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFARMGRAINSBONUS"),
				taskprogress = 200,
				cost = {stone = 100, grain = 250},
			}
		}
	},
	
	resource_gather_cloth = {
		code = 'resource_gather_cloth',
		name = '',
		descript = '',
		tree_position = {x = 18, y = 9},
		icon = "cotton",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEGATHERCLOTHBONUS"),
				taskprogress = 250,
				cost = {wood = 100, iron = 30},
			},
		}
	},
	
	tailor = {
		code = 'tailor',
		name = '',
		descript = '',
		icon = "tailor",
		category = 'facilitiy',
		tree_position = {x = 1, y = 1},
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETAILORBONUS1"),
				taskprogress = 200,
				cost = {wood = 30, stone = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETAILORBONUS2"),
				taskprogress = 300,
				cost = {woodiron = 50, stone = 50, clothsilk = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETAILORBONUS3"),
				taskprogress = 500,
				cost = {woodiron = 50, mithril = 25, clothmagic = 25},
			}
		}
	},
	
	alchemy = {
		code = 'alchemy',
		name = '',
		tree_position = {x = 1, y = 5},
		icon = "alchemy",
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEALCHEMYBONUS1"),
				taskprogress = 250,
				cost = {wood = 25, stone = 50, iron = 30},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEALCHEMYBONUS2"),
				taskprogress = 500,
				cost = {obsidian = 20, woodmagic = 30, clothmagic = 30},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEALCHEMYBONUS3"),
				taskprogress = 1000,
				cost = {leathermythic = 20, woodancient = 10, boneancient = 30},
			}
		}
	},

	forgeworkshop = {
		code = 'forgeworkshop',
		name = '',
		descript = '',
		icon = "forge",
		tree_position = {x = 4, y = 9},
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEWORKBONUS1"),
				taskprogress = 75,
				cost = {woodiron = 100, leatherthick = 100, steel = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEWORKBONUS2"),
				taskprogress = 250,
				cost = {mithril = 50, leathermythic = 50, clothmagic = 25},
			},
		}
	},


	forge = {
		code = 'forge',
		name = '',
		tree_position = {x = 1, y = 9},
		icon = "forge",
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEBONUS1"),
				taskprogress = 200,
				cost = {wood = 10, stone = 25, iron = 10},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEBONUS2"),
				taskprogress = 500,
				cost = {iron = 50, stone = 100, wood = 100},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEBONUS3"),
				taskprogress = 750,
				cost = {mithril = 50, stone = 200, obsidian = 10, woodiron = 100},
			},
		}
	},

	rooms = {
		code = 'rooms',
		name = '',
		icon = "rooms",
		tree_position = {x = 5, y = 2},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS1"),
				taskprogress = 100,
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS2"),
				taskprogress = 200,
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS3"),
				taskprogress = 300,
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS4"),
				taskprogress = 400,
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS5"),
				taskprogress = 500,
				cost = {woodiron = 100, clothsilk = 50, steel = 50},
			},
		}
	},

	luxury_rooms = {
		code = 'luxury_rooms',
		name = '',
		tree_position = {x = 9.5, y = 2},
		icon = "rooms_lux",
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS1"),
				taskprogress = 100,
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS2"),
				taskprogress = 200,
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS3"),
				taskprogress = 300,
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS4"),
				taskprogress = 400,
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS5"),
				taskprogress = 500,
				cost = {woodiron = 100, clothsilk = 50, leatherthick = 50},
			},
			6:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS6"),
				taskprogress = 600,
				cost = {woodiron = 100, clothsilk = 50, leatherthick = 50},
			},
			7:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS7"),
				taskprogress = 700,
				cost = {woodiron = 100, clothsilk = 50, leatherthick = 50},
			},
		}
	},


	master_bedroom = {
		code = 'master_bedroom',
		name = '',
		tree_position = {x = 14, y = 2},
		icon = "bedroom",
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS1"),
				taskprogress = 100,
				cost = {wood = 30, cloth = 20},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS2"),
				taskprogress = 200,
				cost = {wood = 50, clothsilk = 15},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS3"),
				taskprogress = 300,
				cost = {wood = 100, clothsilk = 35},
			}
		}
	},


	stables = {
		code = 'stables',
		name = '',
		tree_position = {x = 2, y = 14},
		descript = '',
		icon = "stables",
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESTABLESBONUS1"),
				taskprogress = 100,
				cost = {wood = 50, leather = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESTABLESBONUS2"),
				taskprogress = 200,
				cost = {woodiron = 50, leatherthick = 50},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESTABLESBONUS3"),
				taskprogress = 300,
				cost = {woodiron = 100, wood = 200, leather = 100, leathermythic = 50},
			}
		}
	},


	torture_room = {
		code = 'torture_room',
		name = '',
		descript = '',
		tree_position = {x = 6, y = 14},
		icon = "tortureroom",
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETORTUREROOMBONUS"),
				taskprogress = 50,
				cost = {wood = 25, leather = 20, iron = 10},
			},
		}
	},
	tattoo_set = {
		code = 'tattoo_set',
		name = '',
		icon = "tattoo",
		tree_position = {x = 10, y = 14},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETATTOOBONUS"),
				taskprogress = 100,
				cost = {woodiron = 25, woodmagic = 25, leatherthick = 20},
			},
		}
	},

	exotic_trader = {
		code = 'exotic_trader',
		name = '',
		icon = "exotic_trader",
		tree_position = {x = 14, y = 14},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEEXOTICBONUS"),
				taskprogress = 250,
				cost = {woodmagic = 10, leatherthick = 10, steel = 10},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEEXOTICBONUS"),
				taskprogress = 500,
				cost = {woodiron = 10, leathermythic = 10, mithril = 10},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEEXOTICBONUS"),
				taskprogress = 750,
				cost = {woodancient = 10, adamantine = 10, leatherdragon = 10},
			},
		}
	},

	sex_times = {
		code = 'sex_times',
		name = '',
		icon = "bedroom",
		tree_position = {x = 18, y = 14},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESEX_TIMEBONUS1"),
				taskprogress = 250,
				cost = {woodmagic = 100, leatherthick = 100, steel = 100},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESEX_TIMEBONUS2"),
				taskprogress = 500,
				cost = {woodiron = 100, leathermythic = 100, mithril = 100},
			},
		}
	},

}
