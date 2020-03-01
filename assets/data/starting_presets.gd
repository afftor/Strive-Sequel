extends Node


var preset_data = {
	
	default = {
		code = 'default',
		name = 'default',
		mc = 'custom',
		story = true,
		free_slave_number = 1,
		descript = "Default start with a master and a character recruited later.",
		gold = 500,
		materials = {meat = 25,fish = 25,bread = 25,vegetables = 25},
		items = {},
		upgrades = {},
	},
	solo = {
		code = 'solo',
		name = 'solo',
		mc = 'custom',
		story = false,
		free_slave_number = 0,
		descript = "Start with only a Master. ",
		gold = 500,
		materials = {meat = 25,fish = 25,bread = 25,vegetables = 25},
		items = {},
		upgrades = {},
	},
	sandbox = {
		code = 'sandbox',
		name = 'sandbox',
		mc = 'custom',
		story = false,
		free_slave_number = 3,
		descript = "Start with a great sum of gold and food.",
		gold = 10000,
		materials = {meat = 250,fish = 250,bread = 250,vegetables = 250},
		items = {},
		upgrades = {},
	},
	
}
