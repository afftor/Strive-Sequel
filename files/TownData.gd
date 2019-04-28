extends Node


var tasksdict = {
	woodcutting = {basetimer = 12, energycost = 5,
	code = 'woodcutting',
	baselimit = 2,
	upgradelimit = 'lumbermill',
	name = tr("HARVESTWOOD"),
	description = tr('WOODCUTTINGTASKDESCRIPTION'),
	unlockreqs = [],
	tasktool = {type = 'axe', required = false, durabilityfactor = 0, effects = [{code = 'speed', value = 5}]}, 
	workerproducts = {
		goblin = [{code = 'materials.wood', amount = 1, chance = 100, critamount = 2, critchance = 10},{code = 'usables.barricade', amount = 1, chance = 15, critamount = 2, critchance = 15}],
		elf = [{code = 'materials.elvenwood', amount = 1, chance = 100, critamount = 2, critchance = 10},{code = 'usables.protectivecharm', amount = 1, chance = 15, critamount = 2, critchance = 5}],
	},
},
	mining = {basetimer = 15, energycost = 5,
	code = 'mining',
	baselimit = 2,
	upgradelimit = 'mine',
	name = tr("HARVESTMETAL"),
	description = tr('HARVESTMETALDESCRIPTION'),
	unlockreqs = [{type = "has_upgrade", name = "mine", value = 1}],
	tasktool = {type = 'pickaxe', required = true, durabilityfactor = 0}, 
	workerproducts = {
		goblin = [{code = 'materials.goblinmetal', amount = 1, chance = 100, critamount = 2, critchance = 10}],
		elf = [{code = 'materials.elvenmetal', amount = 1, chance = 100, critamount = 2, critchance = 10}],
	},
},
	plantgathering = {basetimer = 10, energycost = 5,
	code = 'plantgathering',
	baselimit = 2, 
	upgradelimit = 'farm',
	name = tr("HARVESTPLANT"),
	description = tr('HARVESTPLANTDESCRIPTION'),
	unlockreqs = [{type = "has_upgrade", name = "farm", value = 1}],
	tasktool = {type = 'none', required = false, durabilityfactor = 0}, 
	workerproducts = {
		goblin = [{code = 'materials.cloth', amount = 1, chance = 100, critamount = 2, critchance = 15}],
		elf = [{code = 'materials.cloth', amount = 1, chance = 100, critamount = 2, critchance = 15},{code = 'usables.managrass', amount = 1, chance = 15, critamount = 2, critchance = 5}],
	},
},
	
}

var workersdict = {
	goblin = {name = tr('GOBLINWORKER'), 
	description = '',
	price = 50, 
	type = 'goblin', 
	maxenergy = 50, 
	icon = load("res://assets/images/gui/goblinicon.png"), 
	unlockreqs = []
	},
	elf = {name = tr("ELFWORKER"), 
	description = '',
	price = 75, 
	type = 'elf', 
	maxenergy = 100, 
	icon = load("res://assets/images/gui/elficon.png"), 
	unlockreqs = [{type = "quest_completed", name = "elves"}]
	},
#	dwarf = {name = tr('DWARFWORKER'), 
#	description = '',
#	price = 75, 
#	type = 'dwarf', 
#	maxenergy = 100, 
#	icon = null, 
#	unlockreqs = []
#	},
}

var questdict = {
	questeasy = {task = 'kill', tasktarget = 'elvenrat', tasknumber = [3,5], rewardmoney = 100},
	questmedium = {task = 'kill', tasktarget = 'spider', tasknumber = [3,6], rewardmoney = 200},
	questmedium2 = {task = 'kill', tasktarget = 'earthgolem', tasknumber = [4,6], rewardmoney = 250},
	
}
