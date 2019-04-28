extends Node

var upgradelist = {
	bridge = {
		code = 'bridge',
		name = tr("BRIDGEUPGRADE"),
		positionorder = 1,
		descript = tr("UPGRADEBRIDGEDESCRIPT"),
		levels = {
			1:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_bridge.png'),
				bonusdescript = tr("UPGRADEBRIDGEBONUS"),
				townnode = "bridge",
				cost = {wood = 5},
			}
		}
	},
	lumbermill = {
		code = 'lumbermill',
		name = tr("LUMBERMILLUPGRADE"),
		positionorder = 2,
		descript = tr("UPGRADELUMBERMILLDESCRIPT"),
		levels = {
			1:{
				unlockreqs = [], 
				icon = load("res://assets/images/buildings/upgrade_lumbermill.png"),
				bonusdescript = tr("UPGRADELUMBERMILLBONUS"),
				townnode = "lumbermill",
				cost = {goblinmetal = 5, cloth = 5},
				limitchange = 4
			}
		}
	},
	mine = {
		code = 'mine',
		name = tr("MINEUPGRADE"),
		positionorder = 2,
		descript = tr("UPGRADEMINEDESCRIPT"),
		levels = {
			1:{
				unlockreqs = [{type = "has_upgrade", name = "bridge", value = 1}], 
				icon = load("res://assets/images/buildings/upgrade_mine.png"),
				bonusdescript = tr("UPGRADEMINEBONUS"),
				townnode = "mine",
				cost = {wood = 5, elvenwood = 5},
				limitchange = 2
			}
		}
	},
	farm = {
		code = 'farm',
		name = tr("FARMUPGRADE"),
		positionorder = 3,
		descript = tr("UPGRADEFARMDESCRIPT"),
		levels = {
			1:{
				unlockreqs = [{type = "has_upgrade", name = "bridge", value = 1}],
				icon = load('res://assets/images/buildings/upgrade_farm.png'), 
				bonusdescript = tr("UPGRADEFARMBONUS"),
				townnode = "farm",
				cost = {wood = 10},
				limitchange = 2
			}
		}
	},
	houses = {
		code = 'houses',
		name = tr("HOUSESUPGRADE"),
		positionorder = 4,
		descript = tr("UPGRADEHOUSESDESCRIPT"),
		levels = {
			1:{
				unlockreqs = [],
				icon = load("res://assets/images/buildings/upgrade_house.png"),
				bonusdescript = tr("UPGRADHOUSEBONUS1"),
				cost = {wood = 10},
				townnode = "house",
				limitchange = 4,
			},
			2:{
				unlockreqs = [], 
				icon = load("res://assets/images/buildings/upgrade_house.png"),
				bonusdescript = tr("UPGRADHOUSEBONUS2"),
				cost = {wood = 10, elvenwood = 5},
				limitchange = 6
			}
		}
	},
	blacksmith = {
		code = 'blacksmith',
		name = tr("BLACKSMITHUPGRADE"),
		positionorder = 5,
		descript = tr("UPGRADEBLACKSMITHDESCRIPT"),
		levels = {
			1:{
				unlockreqs = [{type = "has_hero", name = "Ember"}], 
				icon = load('res://assets/images/buildings/upgrade_forge.png'),
				bonusdescript = tr("UPGRADEBLACKSMITHBONUS1"),
				townnode = "BlacksmithNode",
				cost = {goblinmetal = 10},
			},
			2:{
				unlockreqs = [],
				icon = load('res://assets/images/buildings/upgrade_forge2.png'),
				bonusdescript = tr("UPGRADEBLACKSMITHBONUS1"),
				townnode = "BlacksmithNode",
				cost = {goblinmetal = 10, elvenmetal = 10},
			},
		}
	},
	
}
