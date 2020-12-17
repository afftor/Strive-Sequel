extends Node

var upgradelist = {
	
	resource_gather_veges = {
		code = 'resource_gather_veges',
		name = '',
		positionorder = 3,
		descript = '',
		category = 'facilitiy',
		levels = {
			1:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 200,
				#townnode = "farm",
				cost = {wood = 50, vegetables = 250},
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
				#townnode = "farm",
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
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {wood = 30, stone = 25},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADETAILORBONUS2"),
				taskprogress = 300,
				#townnode = "farm",
				cost = {woodiron = 50, stone = 50, clothsilk = 25},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADETAILORBONUS3"),
				taskprogress = 500,
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {wood = 10, stone = 25, iron = 10},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEFORGEBONUS2"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {iron = 50, stone = 100, wood = 100},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEFORGEBONUS3"),
				taskprogress = 750,
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {wood = 25, stone = 50, iron = 30},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEALCHEMYBONUS2"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {obsidian = 20, woodmagic = 30, clothmagic = 30},
			}
		}
	},
#	mine_resource = {
#		code = 'mine_resource',
#		name = '',
#		positionorder = 2,
#		descript = '',
#		category = 'facilitiy',
#		levels = {
#			1:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADEGATHERIRONBONUS"),
#				taskprogress = 100,
#				#townnode = "farm",
#				cost = {stone = 25, wood = 25},
#			},
#			2:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADEGATHERMITHRILBONUS"),
#				taskprogress = 300,
#				#townnode = "farm",
#				cost = {steel = 50, woodiron = 25, stone = 100},
#			},
#		}
#	},
#	resource_gather_woodmagic = {
#		code = 'resource_gather_woodmagic',
#		name = '',
#		positionorder = 1,
#		descript = '',
#		category = 'facilitiy',
#		levels = {
#			1:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADEGATHERWOODMAGICBONUS"),
#				taskprogress = 300,
#				#townnode = "farm",
#				cost = {wood = 50, iron = 20},
#			},
#		}
#	},
#	resource_gather_woodiron = {
#		code = 'resource_gather_woodiron',
#		name = '',
#		positionorder = 1,
#		descript = '',
#		category = 'facilitiy',
#		levels = {
#			1:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADEGATHERWOODIRONBONUS"),
#				taskprogress = 300,
#				#townnode = "farm",
#				cost = {steel = 30, clothsilk = 20},
#			},
#		}
#	},

#	resource_gather_leather = {
#		code = 'resource_gather_leather',
#		name = '',
#		positionorder = 1,
#		descript = '',
#		category = 'facilitiy',
#		levels = {
#			1:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADELEATHERBONUS1"),
#				taskprogress = 200,
#				#townnode = "farm",
#				cost = {wood = 30, leather = 20},
#			},
#			2:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADELEATHERBONUS2"),
#				taskprogress = 350,
#				#townnode = "farm",
#				cost = {wood = 30, leather = 20},
#			},
#		}
#	},
	
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
				#townnode = "farm",
				cost = {wood = 30, cloth = 20},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS2"),
				taskprogress = 200,
				#townnode = "farm",
				cost = {wood = 50, clothsilk = 15},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS3"),
				taskprogress = 300,
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {wood = 50, leather = 25},
			},
			2:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADESTABLESBONUS2"),
				taskprogress = 200,
				#townnode = "farm",
				cost = {woodiron = 50, leatherthick = 50},
			},
			3:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADESTABLESBONUS3"),
				taskprogress = 300,
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {woodiron = 100, leatherthick = 100, steel = 50},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEFORGEWORKBONUS2"),
				taskprogress = 250,
				#townnode = "farm",
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
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEROOMSBONUS2"),
				taskprogress = 200,
				#townnode = "farm",
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEROOMSBONUS3"),
				taskprogress = 300,
				#townnode = "farm",
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEROOMSBONUS4"),
				taskprogress = 400,
				#townnode = "farm",
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
			5:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADEROOMSBONUS5"),
				taskprogress = 500,
				#townnode = "farm",
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
				#townnode = "farm",
				cost = {wood = 50, cloth = 25},
			},
			2:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS2"),
				taskprogress = 200,
				#townnode = "farm",
				cost = {wood = 100, stone = 50, cloth = 25},
			},
			3:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS3"),
				taskprogress = 300,
				#townnode = "farm",
				cost = {woodiron = 50, stone = 100, clothsilk = 25},
			},
			4:{
				unlockreqs = [],
				icon = 'upgrade_farm', 
				bonusdescript = tr("UPGRADELUXURYROOMSBONUS4"),
				taskprogress = 400,
				#townnode = "farm",
				cost = {woodiron = 100,clothsilk = 50, leatherthick = 50},
			},
#			5:{
#				unlockreqs = [],
#				icon = 'upgrade_farm', 
#				bonusdescript = tr("UPGRADELUXURYROOMSBONUS5"),
#				taskprogress = 500,
#				#townnode = "farm",
#				cost = {woodiron = 100, clothsilk = 50, steel = 50},
#			},
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
				taskprogress = 50,
				#townnode = "farm",
				cost = {wood = 25, leather = 20, iron = 10},
			},
		}
	},
}
