extends Node

var upgradelist = {
	
	farm_vegetables = {
		code = 'farm_vegetables',
		name = '',
		positionorder = 3,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEFARMVEGEBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 10},
			}
		}
	},
	farm_grains = {
		code = 'farm_grains',
		name = '',
		positionorder = 4,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEFARMGRAINSBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 10},
			}
		}
	},
	tailor = {
		code = 'tailor',
		name = '',
		positionorder = 1,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEFARMFRUITBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 50, stone = 10},
			}
		}
	},
	forge = {
		code = 'forge',
		name = '',
		positionorder = 1,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEFORGEBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 50, stone = 50},
			}
		}
	},
	alchemy = {
		code = 'alchemy',
		name = '',
		positionorder = 1,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEALCHEMYBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 25, steel = 10},
			}
		}
	},
	mine_resource = {
		code = 'mine_resource',
		name = '',
		positionorder = 2,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEMINERESOURCEBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {stone = 25, wood = 25},
			},
			2:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEMINERESOURCEBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 10},
			}
		}
	},
	wood_resource = {
		code = 'wood_resource',
		name = '',
		positionorder = 1,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEWOODRESOURCEBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {iron = 25},
			},
			2:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEWOODRESOURCEBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 10},
			}
		}
	},
	master_bedroom = {
		code = 'master_bedroom',
		name = '',
		positionorder = 3,
		descript = '',
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS"),
				taskprogress = 200,
				#townnode = "farm",
				cost = {wood = 30, cloth = 20},
			},
			2:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS"),
				taskprogress = 350,
				#townnode = "farm",
				cost = {wood = 50, clothsilk = 15},
			},
			3:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEMASTERBEDROOMBONUS"),
				taskprogress = 500,
				#townnode = "farm",
				cost = {wood = 100, clothsilk = 35},
			}
		}
	},
}
