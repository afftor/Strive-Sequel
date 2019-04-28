extends Node

var areas = {
	forestexplore = {
		code = 'forestexplore',
		name = 'Roam at Forest', 
		category = 'forest',
		image = '',
		stages = 0, 
		enemygroups = ['foresteasy', 'foresteasymed', 'forestmedium', 'forestmedium2', 'foresthard','foresthard2','foresthard3','forestextraboss'], 
		requirements = [], 
		stagedenemies = {}
		},
	forestelves = {
		code = 'forestelves',
		name = 'Search for Elves',
		category = 'forest',
		image = '',
		stages = 8, 
		enemygroups = ['foresteasy', 'foresteasymed', 'forestmedium', 'forestmedium2', 'foresthard'], 
		requirements = [{type = "quest_stage", name = 'elves', operant = "eq", value = 1}], 
		stagedenemies = {8 : "forestboss"}
		},
	caveexplore = {
		code = 'caveexplore',
		name = 'Roam at Caves', 
		category = 'cave',
		image = '',
		stages = 0, 
		enemygroups = ['caveeasy','cavemedium','cavemedium2','cavemedium3'], 
		requirements = [{type = "quest_completed", name = 'elves'}], 
		stagedenemies = {}
		},
	cavedemitrius = {
		code = 'cavedemitrius',
		name = 'Escort Demitrius', 
		category = 'cave',
		image = '',
		stages = 10, 
		enemygroups = ['caveeasy','cavemedium','cavemedium2','cavemedium3'], 
		requirements = [{type = "quest_stage", name = 'demitrus', operant = 'eq', value = 1}], 
		stagedenemies = {10 : "caveboss"}
		},
}