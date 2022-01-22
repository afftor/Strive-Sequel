extends Node

var upgradelist = {
	resource_gather_fish = {
		code = 'resource_gather_fish',
		name = '',
		descript = '',
		category = 'facilitiy',
		tree_position = {tab = 2, x = 1, y = 1},
		icon = "fishing",
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 15,
				cost = {wood = 50, fish = 100},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {wood = 100, fish = 250},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 45,
				cost = {wood = 200, stone = 100, fish = 350},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {woodmagic = 100, stone = 100, fish = 500},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 75,
				cost = {woodmagic = 100, stone = 100, fish = 500},
			},
			6:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 90,
				cost = {woodiron = 100, stone = 100, fish = 500},
			},
			7:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 105,
				cost = {woodiron = 100, stone = 100, fish = 500},
			}
		}
	},
	resource_gather_meat = {
		code = 'resource_gather_meat',
		name = '',
		descript = '',
		category = 'facilitiy',
		tree_position = {tab = 2, x = 6, y = 1},
		icon = "hunting",
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 15,
				cost = {wood = 50, grain = 20},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {wood = 100, grain = 100},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 45,
				cost = {wood = 200, stone = 100, grain = 250},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {woodmagic = 100, stone = 100, grain = 350},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 75,
				cost = {woodmagic = 100, stone = 100, grain = 400},
			},
			6:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 90,
				cost = {woodiron = 100, stone = 100, grain = 500},
			},
			7:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 105,
				cost = {woodiron = 100, stone = 100, grain = 500},
			},
			8:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 120,
				cost = {woodiron = 100, stone = 100, grain = 500},
			}
		}
	},
	resource_gather_veges = {
		code = 'resource_gather_veges',
		name = '',
		descript = '',
		category = 'facilitiy',
		tree_position = {tab = 2, x = 11, y = 1},
		icon = "veges",
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 15,
				cost = {wood = 50, vegetables = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {wood = 100, vegetables = 150},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 45,
				cost = {wood = 200, stone = 100, vegetables = 250},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {woodmagic = 100, stone = 100, vegetables = 350},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 75,
				cost = {woodmagic = 100, stone = 100, vegetables = 500},
			},
			6:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 90,
				cost = {woodiron = 100, stone = 100, vegetables = 500},
			},
			7:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 105,
				cost = {woodiron = 100, stone = 100, vegetables = 500},
			},
		}
	},
	
	resource_gather_grain = {
		code = 'resource_gather_grain',
		name = '',
		tree_position = {tab = 2, x = 16, y = 1},
		descript = '',
		icon = "wheat",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 15,
				cost = {wood = 50, grain = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {wood = 100, grain = 150},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 45,
				cost = {wood = 200, stone = 100, grain = 250},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {woodmagic = 100, stone = 100, grain = 350},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 75,
				cost = {woodmagic = 100, stone = 100, grain = 500},
			},
			6:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 90,
				cost = {woodiron = 100, stone = 100, grain = 500},
			},
			7:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 105,
				cost = {woodiron = 100, stone = 100, grain = 500},
			},
			8:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 120,
				cost = {woodiron = 100, stone = 100, grain = 500},
			}
		}
	},
	resource_gather_wood = {
		code = 'resource_gather_wood',
		name = '',
		tree_position = {tab = 2, x = 1, y = 5},
		descript = '',
		icon = "woodcutting",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 25,
				cost = {wood = 100, stone = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 40,
				cost = {wood = 200, stone = 100},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 65,
				cost = {wood = 400, stone = 150},
			}
		}
	},
	
	resource_gather_wood_magic = {
		code = 'resource_gather_wood_magic',
		name = '',
		tree_position = {tab = 2, x = 6, y = 5},
		descript = '',
		icon = "woodcutting",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 25,
				cost = {wood = 100, woodmagic = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 40,
				cost = {wood = 200, woodmagic = 50},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 65,
				cost = {wood = 400, woodmagic = 100},
			}
		}
	},
	resource_gather_wood_iron = {
		code = 'resource_gather_wood_iron',
		name = '',
		tree_position = {tab = 2, x = 11, y = 5},
		descript = '',
		icon = "woodcutting",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {wood = 200, woodiron = 100},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {wood = 400, woodiron = 200},
			},
		}
	},
	resource_gather_stone = {
		code = 'resource_gather_stone',
		name = '',
		tree_position = {tab = 2, x = 1, y = 9},
		descript = '',
		icon = "mining",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 25,
				cost = {wood = 100, stone = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 40,
				cost = {wood = 200, stone = 100},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 65,
				cost = {wood = 400, stone = 200},
			}
		}
	},
	resource_gather_obsidian = {
		code = 'resource_gather_obsidian',
		name = '',
		tree_position = {tab = 2, x = 6, y = 9},
		descript = '',
		icon = "mining",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {stone = 500, mithril = 25, obsidian = 10},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {stone = 500, mithril = 50, obsidian = 25},
			},
		}
	},
	resource_gather_cloth = {
		code = 'resource_gather_cloth',
		name = '',
		descript = '',
		tree_position = {tab = 2, x = 16, y = 5},
		icon = "cotton",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 25,
				cost = {wood = 50, stone = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 40,
				cost = {wood = 100, woodiron = 50, stone = 200},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 65,
				cost = {wood = 250, woodiron = 100, stone = 250},
			},
		}
	},
	resource_gather_cloth_silk = {
		code = 'resource_gather_cloth_silk',
		name = '',
		descript = '',
		tree_position = {tab = 2, x = 16, y = 9},
		icon = "cotton",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 25,
				cost = {wood = 50, stone = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 40,
				cost = {wood = 100, clothsilk = 50, stone = 100},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 65,
				cost = {wood = 250, clothsilk = 100, stone = 250},
			},
		}
	},
	resource_gather_iron = {
		code = 'resource_gather_iron',
		name = '',
		descript = '',
		tree_position = {tab = 2, x = 1, y = 13},
		icon = "mining",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 25,
				cost = {stone = 100, iron = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 40,
				cost = {stone = 250, steel = 50},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM2"),
				taskprogress = 65,
				cost = {stone = 500, iron = 250},
			},
		}
	},
	resource_gather_mithril = {
		code = 'resource_gather_mithril',
		name = '',
		descript = '',
		tree_position = {tab = 2, x = 6, y = 13},
		icon = "mining",
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 30,
				cost = {mithril = 50, obsidian = 50, clothmagic = 100},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADERESOURCE_MAXIMUM1"),
				taskprogress = 60,
				cost = {mithril = 100, obsidian = 50, clothmagic = 100},
			},
		}
	},
	
	tailor = {
		code = 'tailor',
		name = '',
		descript = '',
		icon = "tailor",
		category = 'facilitiy',
		tree_position = {tab = 1, x = 1, y = 1},
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETAILORBONUS1"),
				taskprogress = 25,
				cost = {wood = 30, stone = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETAILORBONUS2"),
				taskprogress = 50,
				cost = {woodiron = 50, stone = 50, clothsilk = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETAILORBONUS3"),
				taskprogress = 75,
				cost = {woodiron = 50, mithril = 25, clothmagic = 25},
			}
		}
	},
	
	forge = {
		code = 'forge',
		name = '',
		tree_position = {tab = 1, x = 6, y = 1},
		icon = "forge",
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEBONUS1"),
				taskprogress = 25,
				cost = {wood = 10, stone = 25, iron = 10},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEBONUS2"),
				taskprogress = 50,
				cost = {iron = 50, stone = 100, wood = 100},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEBONUS3"),
				taskprogress = 75,
				cost = {mithril = 50, stone = 200, obsidian = 10, woodiron = 100},
			},
		}
	},
	
	alchemy = {
		code = 'alchemy',
		name = '',
		tree_position = {tab = 1, x = 11, y = 1},
		icon = "alchemy",
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEALCHEMYBONUS1"),
				taskprogress = 25,
				cost = {wood = 25, stone = 50, iron = 30},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEALCHEMYBONUS2"),
				taskprogress = 50,
				cost = {obsidian = 20, woodmagic = 30, clothmagic = 30},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEALCHEMYBONUS3"),
				taskprogress = 75,
				cost = {leathermythic = 20, woodancient = 10, boneancient = 30},
			}
		}
	},
	
	forgeworkshop = {
		code = 'forgeworkshop',
		name = '',
		descript = '',
		icon = "forge",
		tree_position = {tab = 1, x = 6, y = 5},
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEWORKBONUS1"),
				taskprogress = 30,
				cost = {woodiron = 100, leatherthick = 100, steel = 50},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEFORGEWORKBONUS2"),
				taskprogress = 60,
				cost = {mithril = 50, leathermythic = 50, clothmagic = 25},
			},
		}
	},
	
	buildertools = {
		code = 'buildertools',
		name = '',
		descript = '',
		icon = "forge",
		tree_position = {tab = 1, x = 1, y = 5},
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEBUILDERTOOLSBONUS1"),
				taskprogress = 15,
				cost = {wood = 50, leather = 50, iron = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEBUILDERTOOLSBONUS2"),
				taskprogress = 30,
				cost = {woodiron = 50, leatherthick = 50, steel = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEBUILDERTOOLSBONUS3"),
				taskprogress = 50,
				cost = {mithril = 25, leathermythic = 25, clothmagic = 15},
			},
		}
	},



	rooms = {
		code = 'rooms',
		name = '',
		icon = "rooms",
		tree_position = {tab = 1, x = 17, y = 1},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS1"),
				taskprogress = 15,
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS2"),
				taskprogress = 25,
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS3"),
				taskprogress = 35,
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS4"),
				taskprogress = 45,
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEROOMSBONUS5"),
				taskprogress = 60,
				cost = {woodiron = 100, clothsilk = 50, steel = 50},
			},
		}
	},

	luxury_rooms = {
		code = 'luxury_rooms',
		name = '',
		tree_position = {tab = 1, x = 17, y = 5},
		icon = "rooms_lux",
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS1"),
				taskprogress = 15,
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS2"),
				taskprogress = 25,
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS3"),
				taskprogress = 35,
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS4"),
				taskprogress = 45,
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
			5:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS5"),
				taskprogress = 55,
				cost = {woodiron = 100, clothsilk = 50, leatherthick = 50},
			},
			6:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS6"),
				taskprogress = 65,
				cost = {woodiron = 100, clothsilk = 50, leatherthick = 50},
			},
			7:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS7"),
				taskprogress = 75,
				cost = {woodiron = 100, clothsilk = 50, leatherthick = 50},
			},
		}
	},


	master_bedroom = {
		code = 'master_bedroom',
		name = '',
		tree_position = {tab = 1, x = 17, y = 9},
		icon = "bedroom",
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS1"),
				taskprogress = 20,
				cost = {wood = 30, cloth = 20},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS2"),
				taskprogress = 40,
				cost = {wood = 50, clothsilk = 15},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS3"),
				taskprogress = 60,
				cost = {wood = 100, clothsilk = 35},
			}
		}
	},


	stables = {
		code = 'stables',
		name = '',
		tree_position = {tab = 1, x = 2, y = 14},
		descript = '',
		icon = "stables",
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESTABLESBONUS1"),
				taskprogress = 15,
				cost = {wood = 50, leather = 25},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESTABLESBONUS2"),
				taskprogress = 30,
				cost = {woodiron = 50, leatherthick = 50},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESTABLESBONUS3"),
				taskprogress = 50,
				cost = {woodiron = 100, wood = 200, leather = 100, leathermythic = 50},
			}
		}
	},


	torture_room = {
		code = 'torture_room',
		name = '',
		descript = '',
		tree_position = {tab = 1, x = 6, y = 14},
		icon = "tortureroom",
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETORTUREROOMBONUS"),
				taskprogress = 20,
				cost = {wood = 25, leather = 20, iron = 10},
			},
		}
	},
	tattoo_set = {
		code = 'tattoo_set',
		name = '',
		icon = "tattoo",
		tree_position = {tab = 1, x = 10, y = 14},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADETATTOOBONUS"),
				taskprogress = 25,
				cost = {woodiron = 25, woodmagic = 25, leatherthick = 20},
			},
		}
	},

	exotic_trader = {
		code = 'exotic_trader',
		name = '',
		icon = "exotic_trader",
		tree_position = {tab = 1, x = 14, y = 14},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEEXOTICBONUS"),
				taskprogress = 20,
				cost = {woodmagic = 10, leatherthick = 10, steel = 10},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEEXOTICBONUS"),
				taskprogress = 35,
				cost = {woodiron = 10, leathermythic = 10, mithril = 10},
			},
			3:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADEEXOTICBONUS"),
				taskprogress = 50,
				cost = {woodancient = 10, adamantine = 10, leatherdragon = 10},
			},
		}
	},

	sex_times = {
		code = 'sex_times',
		name = '',
		icon = "bedroom",
		tree_position = {tab = 1, x = 18, y = 14},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESEX_TIMEBONUS1"),
				taskprogress = 25,
				cost = {woodmagic = 100, leatherthick = 100, steel = 100},
			},
			2:{
				unlockreqs = [],
				bonusdescript = tr("UPGRADESEX_TIMEBONUS2"),
				taskprogress = 50,
				cost = {woodiron = 100, leathermythic = 100, mithril = 100},
			},
		}
	},
	
	resting = {
		code = 'resting',
		name = '',
		icon = "rooms",
		tree_position = {tab = 1, x = 13, y = 9},
		descript = '',
		category = 'upgrade',
		levels = {
			1:{
				unlockreqs = [],
				bonusdescript = tr(""),
				taskprogress = 15,
				cost = {wood = 50, leather = 20, cloth = 20},
			},
		}
	},

}
