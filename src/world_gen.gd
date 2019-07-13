extends Node


func _ready():
	build_world()

func build_world():
	for i in lands:
		make_area(i)

var lands = {
	plains = {
		code = 'plains',
		name = "Plains",
		lead_race = 'Human', #lead race has 80% chance to be presented in all settlements
		secondary_races = ['Halfbreeds'], #secondary races have 30% chance to be presented in all settlements (or guaranteed if lead race is not) and 50% for another additional race. If secondary races are empty, all settlements will belong to lead race
		policies = [], #not used as of now
		travel_time = [0,0], #how long it gonna take to travel to region
		difficulty = 0, #growing number defining quests and individuals
		disposition = 100, #reputation, not currently used
		population = [100000, 200000], #population, not currently used, but planned to be possible to affect its numbers
		start_settlements_number = {settlement_large = [1,1], settlement_small = [1,1]}, #will generate said locations on first generation
		start_locations_number = 3, #will generate this number of smaller locations like dungeons
		locations = {}, #array to fill up with settlements and dungeons
		locationpool = ['dungeon_bandit_den', "dungeon_goblin_cave"], #array of allowed locations to generate
		guilds = ['workers','servants','fighters','mages'],
		capital_shop_resources = ['meat','fish','grains','vegetables','stone', 'wood','leather','bone','cloth','iron','fleawarts'],
		capital_shop_items = ['lifeshard'],
	},
	forests = {
		code = 'forests',
		name = "Forests",
		lead_race = 'Elf',
		secondary_races = ['DarkElf','Fairy','Dryad','Halfbreeds'],
		policies = [],
		travel_time = [12,28],
		difficulty = 1,
		disposition = 25,
		population = [20000, 50000],
		start_settlements_number = {settlement_large = [1,1], settlement_small = [1,1]},
		start_locations_number = 3, 
		locations = {},
		locationpool = ['dungeon_grove'],
		guilds = [],
		capital_shop_resources = ['grains','vegetables', 'wood','woodmagic','leather','cloth','fleawarts','salvia'],
		capital_shop_items = [],
	},
	mountains = {
		code = 'mountains',
		name = "Mountains",
		lead_race = 'Dwarf',
		secondary_races = [],
		policies = [],
		travel_time = [12,28],
		difficulty = 1,
		disposition = 15,
		population = [10000, 30000],
		start_settlements_number = {settlement_large = [1,1], settlement_small = [1,1]},
		start_locations_number = 1, 
		locations = {},
		locationpool = ['dungeon_goblin_cave'],
		guilds = [],
		capital_shop_resources = ['meat','vegetables','iron','steel','leather','bone','mithril','stone','obsidian'],
		capital_shop_items = [],
	},
	steppe = {
		code = 'steppe',
		name = "Steppe",
		lead_race = 'Orc',
		secondary_races = ['Goblin','Centaur'],
		policies = [],
		travel_time = [15,36],
		difficulty = 1,
		disposition = 15,
		population = [10000, 30000],
		start_settlements_number = {settlement_large = [1,1], settlement_small = [1,1]},
		start_locations_number = 2, 
		locations = {},
		locationpool = ['dungeon_goblin_cave'],
		guilds = [],
		capital_shop_resources = ['meat','fish','iron','leather','leatherthick','bone','boneancient','stone'],
		capital_shop_items = [],
	},
	seas = {
		code = 'seas',
		name = "Seas",
		lead_race = 'Nereid',
		secondary_races = ['Lamia','Scylla'],
		policies = [],
		travel_time = [15,36],
		difficulty = 1,
		disposition = 15,
		population = [10000, 30000],
		start_settlements_number = {},
		start_locations_number = 0, 
		locations = {},
		locationpool = ['dungeon_bandit_den'],
		guilds = [],
		capital_shop_resources = ['fish','leather','leatherthick','bone'],
		capital_shop_items = [],
	},
}


func make_area(code):
	var areadata = lands[code].duplicate()
	state.areas[areadata.code] = areadata
	areadata.population = round(rand_range(areadata.population[0],areadata.population[1]))
	areadata.quests = {global = {}}
	areadata.questlocations = {}
	areadata.travel_time = round(rand_range(areadata.travel_time[0], areadata.travel_time[1]))
	for i in areadata.start_settlements_number:
		var number = round(rand_range(areadata.start_settlements_number[i][0], areadata.start_settlements_number[i][1]))
		while number > 0:
			make_settlement(i, areadata)
			number -= 1
	while areadata.start_locations_number > 0:
		var location = make_location(areadata.locationpool[randi()%areadata.locationpool.size()], areadata)
		areadata.start_locations_number -= 1
		areadata.locations[location.id] = location
		state.location_links[location.id] = {area = code, category = 'locations'} 
	areadata.factions = {}
	areadata.quests.factions = {}
	for i in areadata.guilds:
		make_guild(i, areadata)
	areadata.erase('guilds')

var guild_upgrades = {
	slavenumberupgrade = {
		code = 'slavenumberupgrade',
		descript = 'Increases the number of available characters for hire at once by 1. ',
		name = 'Hirelings number',
		cost = [100,500,1000,2000],
		reqs = [],
		maxlevel = 4,
		effects = [{code = 'slavenumber', operant = '+', value = 1}],
	},
	slavequality = {
		code = 'slavequality',
		descript = 'Increases quality of characters available for hire. Stronger characters might have higher initial skills, attributes and more classes, but cost higher. ',
		name = 'Hirelings quality',
		cost = [100,500,1000,2000],
		reqs = [],
		maxlevel = 4,
		effects = [{code = 'slavelevel', operant = '+', value = 1}],
	},
	questnumberupgrade = {
		code = 'questnumberupgrade',
		descript = 'Increases the amount of available quests at once by 1.',
		name = 'Quest Number',
		cost = [100,500,1000,2000],
		reqs = [],
		maxlevel = 4,
		effects = [{code = 'questsetting:total', operant = '+', value = 1}],
	},
	
}

var guildsdata = {
	fighters = {
		code = 'fighters',
		name = 'Fighters',
		description = '',
		preference = ['combat'],
		quests_easy = ['warriors_dungeon_basic'],#'warriors_threat_basic','warriors_monster_hunt_basic','warriors_fighter_slave_basic'],
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
	area.quests.factions[factiondata.code] = {}
	var guilddatatemplate = {
		code = factiondata.code,
		name = factiondata.name,
		area = area.code,
		preferences = factiondata.preference,
		description = factiondata.description,
		questpool = {easy = factiondata.quests_easy, medium = factiondata.quests_medium, hard = factiondata.quests_hard},
		questsetting = {easy = 1, medium = 0, hard = 0, total = 1},
		slaves = [],
		reputation = 5000,
		totalreputation = 0,
		difficulty = area.difficulty,
		races = [area.lead_race] + area.secondary_races,
		upgrades = {},
		slavelevel = 0,
	}
	factiondata.slavenumber = round(rand_range(factiondata.slavenumber[0], factiondata.slavenumber[1]))
	factiondata.questnumber = round(rand_range(factiondata.questnumber[0], factiondata.questnumber[1]))
	guilddatatemplate.slavenumber = factiondata.slavenumber
	
	while factiondata.slavenumber > 0:
		make_slave_for_guild(guilddatatemplate)
		factiondata.slavenumber -= 1
	if factiondata.questnumber > 0:
		area.quests.factions[factiondata.code] = {}
	while factiondata.questnumber > 0:
		for i in ['easy','medium','hard']:
			while guilddatatemplate.questsetting[i] > area.quests.factions[factiondata.code].size():
				make_quest_for_guild(guilddatatemplate, i)
		factiondata.questnumber -= 1
	
	area.factions[guilddatatemplate.code] = guilddatatemplate

func make_slave_for_guild(guild):
	var newslave = Slave.new()
	newslave.generate_random_character_from_data(guild.races, guild.preferences[randi()%guild.preferences.size()], guild.difficulty + round(randf())-0.3)
	guild.slaves.append(newslave)

func make_quest_for_guild(guilddatatemplate, difficulty):
	var newquest = make_quest(guilddatatemplate.questpool[difficulty][randi()%guilddatatemplate.questpool[difficulty].size()])
	newquest.source = guilddatatemplate.code
	newquest.area = guilddatatemplate.area
	newquest.travel_time = state.areas[guilddatatemplate.area].travel_time + round(randf()*24)
	newquest.difficulty = difficulty
	state.areas[newquest.area].quests.factions[newquest.source][newquest.id] = newquest

func make_settlement(code, area):
	var settlement = locations[code].duplicate(true)
	settlement.population = round(rand_range(settlement.population[0],settlement.population[1]))
	settlement.travel_time = round(rand_range(6,24))
	var text = locationnames[settlement.name+"1"][randi()%locationnames[settlement.name + "1"].size()] + locationnames[settlement.name+"2"][randi()%locationnames[settlement.name + "2"].size()]
	settlement.name = text
	settlement.id = "L" + str(state.locationcounter)
	settlement.group = {}
	settlement.type = 'settlement'
	settlement.levels = {}
	state.locationcounter += 1
	if randf() <= 0.8 || area.secondary_races.size() == 0:
		settlement.races.append(area.lead_race)
	if (randf() >= 0.7 || settlement.races.size() == 0) && area.secondary_races.size() != 0:
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
	
	
	area.locations[settlement.id] = settlement
	state.location_links[settlement.id] = {area = area.code, category = 'locations'} 


func make_location(code, area, difficulty = 'easy'):
	var location = dungeons[code].duplicate(true)
	var text = "The " + locationnames[location.name+"_adjs"][randi()%locationnames[location.name + "_adjs"].size()] + " " + locationnames[location.name+"_nouns"][randi()%locationnames[location.name + "_nouns"].size()]
	location.name = text
	location.id = "L" + str(state.locationcounter)
	location.travel_time = round(rand_range(6,24))
	location.code = code
	var levelnumber = round(rand_range(location.difficulties[difficulty].levels[0], location.difficulties[difficulty].levels[1]))
	location.levels = {}
	while levelnumber > 0:
		location.levels[int(levelnumber)] = {stages = round(rand_range(location.difficulties[difficulty].stages_per_level[0], location.difficulties[difficulty].stages_per_level[1]))}
		levelnumber -= 1
	location.group = {}
	location.randomevents = []
	location.scriptedevents = []
	location.progress = {level = 1, stage = 0}
	location.stagedenemies = []
	location.difficulty = difficulty
	location.enemies = location.difficulties[difficulty].enemyarray.duplicate(true)
	if location.difficulties[difficulty].has("final_enemy"):
		var bossenemy = input_handler.weightedrandom(location.difficulties[difficulty].final_enemy)
		location.stagedenemies.append({enemy = bossenemy, level = location.difficulties[difficulty].levels.size(), stage = location.levels[location.levels.size()].stages})
		if location.difficulties[difficulty].final_enemy_type == 'character':
			location.scriptedevents.append({trigger = 'finish_combat', event = 'character_boss_defeat', reqs = [{code = 'level', value = location.levels.size(), operant = 'gte'}, {code = 'stage', value = location.levels[location.levels.size()].stages-1, operant = 'gte'}]})
	state.locationcounter += 1
	location.erase('difficulties')
	return location

func update_guilds(area):
	#rebuild quests and slaves in guild
	for i in area.factions.values():
		for k in i.slaves:
			if randf() >= 0.7:
				i.slaves.erase(k)
		while i.slaves.size() < i.slavenumber:
			make_slave_for_guild(i)
		for faction in area.quests.factions:
			for quest in area.quests.factions[faction].values():
				if quest.taken == true && quest.complete == false:
					quest.time_limit -= 1
					if quest.time_limit < 0:
						fail_quest(quest)
				else:
					if randf() >= 0.7 || quest.complete == true:
						area.quests.factions[faction].erase(quest)
					fill_faction_quests(faction, area.code)

func fill_faction_quests(faction, area):
	var areadata = state.areas[area]
	var factiondata = areadata.factions[faction]
	
	#get existing quests data
	var difficulty = {easy = 0, medium = 0, hard = 0}
	
	for i in areadata.quests.factions[faction].values():
		difficulty[i.difficulty] += 1
	for i in difficulty:
		while factiondata.questsetting[i] > difficulty[i]:
			make_quest_for_guild(factiondata, i)
			difficulty[i] += 1

func fail_quest(quest):
	pass



var locations = {
	settlement_small = {
		code = 'settlement_small',
		type = 'settlement',
		classname = 'settlement_small',
		name = 'town',
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
		type = 'settlement',
		classname = 'settlement_large',
		name = 'town',
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
}







var questdata = {
	workers_resources_basic = {
		code = 'workers_resources_basic',
		type = 'materialsquest',
		name = 'Resource gathering',
		descript = 'The guild requires additional resources for its needs. ',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'material', function = 'range', type = ['wood','stone','cloth'], range = [45,60]},{use_once = false, code = 'material', function = 'range', type = ['bone','leather'], range = [25,40]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	workers_food_basic = {
		code = 'workers_food_basic',
		type = 'materialsquest',
		name = 'Food supply',
		descript = 'The guild requires additional food supplies.',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'material', function = 'range', type = ['meat','fish','vegetables','grains'], range = [45,60]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	workers_craft_tools_basic = {
		code = 'workers_craft_tools_basic',
		type = 'itemsquest',
		name = 'Tool making',
		descript = 'The guild requires a specific instruments. ',
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'item', function = 'range', type = ['axe','pickaxe','sickle'], range = [2,2]}]},
		unlockreqs = [],
		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
		time_limit = [6,10],
	},
	workers_threat_basic = {
		code = 'workers_threat_basic',
		type = 'eventlocationquest',
		name = 'Trouble solving',
		descript = 'The guild requires a help with a certain issue',
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
		randomconditions = {number = [1,1], variances = [{use_once = false, code = 'dungeon', function = 'range', type = ['dungeon_bandit_den_easy', 'dungeon_goblin_cave_easy'], range = [1,1]}]},
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
		randomconditions = {number = [1,1], variances = [{use_once = true, code = 'stat', operant = 'gte', function = 'range', type = ['body_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range',operant = 'gte', type = ['physics'], range = [20,40]}]},
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
		randomconditions = {number = [1,1], variances = [{use_once = true, code = 'stat',operant = 'gte', function = 'range', type = ['magic_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range',operant = 'gte', type = ['wits'], range = [20,40]}]},
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
		randomconditions = {number = [2,2], variances = [{use_once = true, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range',operant = 'gte', type = ['charm','sexuals'], range = [20,40]}]},
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
	
	data.id = "Q" + str(state.questcounter)
	state.questcounter += 1
	data.code = template.code
	data.name = template.name
	data.descript = template.descript
	data.time_limit = round(rand_range(template.time_limit[0], template.time_limit[1]))
	data.type = template.type
	data.complete = false
	data.failed = false
	
	#location = location - add quest placement
	var requirements_number = round(rand_range(template.randomconditions.number[0], template.randomconditions.number[1]))
	var reqsarray = template.randomconditions.variances.duplicate()
	while requirements_number > 0:
		var tempdata = reqsarray[randi()%reqsarray.size()].duplicate()
		var reqsarrayposition = reqsarray.find(tempdata) #Bug - stat req can repeat itself
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

func take_quest(quest, area):
	quest.taken = true
	if quest.type in ['eventlocationquest','dungeonquest']:
		var location = make_quest_location(quest, area)
		area.questlocations[location.id] = location
		location.questid = quest.id
		state.location_links[location.id] = {area = area.code, category = 'questlocations'} 

func make_quest_location(quest,area):
	var locationdata = {}
	locationdata.id = "L" + str(state.locationcounter)
	state.locationcounter += 1
	for i in quest.requirements:
		match quest.type:
			'eventlocationquest':
				var data = event_locations_data[i.type].duplicate(true)
				locationdata.type = 'quest_event'
				locationdata.code = data.code
				locationdata.name = data.name
				locationdata.descript = data.descript
				locationdata.quest = quest.code
				locationdata.area = quest.area
				locationdata.travel_time = quest.travel_time
				locationdata.event = data.event_code
				locationdata.group = {}
				locationdata.progress = {level = 0, stage = 0}
			'dungeonquest':
				locationdata = make_location(i.type, area)
				i.value = locationdata.id
				locationdata.scriptedevents.append({trigger = 'complete_location', event = 'finish_quest_dungeon', reqs = [], args = {id = quest.id, source = quest.source, area = quest.area}})
#				var data = dungeons[i.type].duplicate(true)
#				locationdata.type = 'quest_dungeon'
#				locationdata.code = data.code
#				locationdata.name = data.name
#				locationdata.descript = data.descript
#				locationdata.quest = quest.code
#				locationdata.area = quest.area
#				locationdata.travel_time = quest.travel_time
#				locationdata.levels = round(rand_range(data.levels[0], data.levels[1]))
#				locationdata.stages = round(rand_range(data.stages[0], data.stages[1]))
#				locationdata.enemies = data.enemies
#				locationdata.difficulty = data.difficulty
#				locationdata.group = {}
#				locationdata.progress = {level = 0, stage = 0}
	return locationdata

func make_quest_descript(quest):
	var text = '[center]' + quest.name + '[/center]\n' + quest.descript
	
	text += "\n\nRequirements: "
	#reqs
	match quest.type:
		"materialsquest":
			text += "\nProvide resources: "
		"itemsquest":
			text += "\nProvide items: "
		"slavegetquest":
			text += "\nProvide slave: "
		"monsterhuntquest":
			text += "\nDefeat enemies: "
		"dungeonquest":
			text += "\nClear location: "
		"eventlocationquest":
			text += "\nComplete encounter: "
	for i in quest.requirements:
		match i.code:
			'material':
				text += "\n" + Items.materiallist[i.type].name + ": " + str(i.value)
			"item":
				text += "\n" + Items.itemlist[i.type].name + ": " + str(i.value)
			"monsters":
				text += "\n" + Enemydata.enemies[i.type].name + ": " + str(i.value)
			"stat":
				text += "\n" + i.type + ": " + str(i.value)
			"eventlocation":
				text += "\n" + i.type
			"dungeon":
				text += "\n" + i.type
	
	text += "\n\nRewards:"
	
	for i in quest.rewards:
		match i.code:
			'gold':
				text += "\nGold - " + str(i.value)
			'reputation':
				text += "\nReputation: " + str(quest.source) + " - " + str(i.value)
	
	return text

var locationnames = {
	town1 = ['Green','Black','Gold',"Stone","Great","Rain",'Storm','Red','River','Oaken','Ashen'],
	town2 = ['wood','ford','vale','burg','wind','ridge','minster','moor','meadow'],
	
	goblin_cave_nouns = ['Cave','Tunnel','Burrow','Cavern','Den'],
	goblin_cave_adjs = ['Dirty', 'Murky', 'Distant', 'Red', 'Blue', 'Black', 'Lower'],
	bandit_den_nouns = ['Hideout', 'Cave', 'Den', 'Pit'],
	bandit_den_adjs = ['Bandit', 'Dirty', 'Murky', 'Distant', 'Red', 'Blue', 'Black', 'Lower'],
	grove_nouns = ['Forest','Grove','Thicket','Woodland','Backwoods','Cover','Timberland','Wildwood','Orchard','Spinney','Hedge'],
	grove_adjs = ['Dark', 'Green', 'White', 'Gold', 'Silver', 'Dense', 'Thick', 'Overgrown', 'Shiny', 'Bushy', 'Living'],
	crypt_nouns = ['Crypt','Cemetery', 'Grave','Catacomb','Mausoleum','Tomb','Vault','Chamber'],
	crypt_adjs = ['Dark','Black','Blood', 'Bone', 'Rotten', 'Flesh', 'Evil', 'Blood', 'Red', 'Grim', 'Great', 'Demonic', 'Gloomy', 'Deadly'],
	mountains_nouns = ['Caves','Tunnels','Burrows','Caverns','Mine','Quarry','Chambers','Dungeon'],
	mountains_adjs = ['Dark','Black', 'Distant', 'Red', 'Blue','Lower','Deep', 'Heavy', 'Crystal', 'Rocking'],
	volcano_nouns = ['Caves','Dungeon','Scar', 'Chambers', 'Halls', 'Lair'],
	volcano_adjs = ['Burning','Fire','Scorching', 'Heating'],
	city_nouns = ['Ruins','Chambers','Halls','Quarters','Labyrinth'],
	city_adjs =  ['Dark','Distant', 'Red', 'Blue', 'Black', 'Lower','Deep', 'Heavy', 'Crystal', 'Rocking'],
}


var dungeonnoun = ['Tunnels','Quarters','Caves','Halls','Delves','Burrows','Vault','Labyrinth','Chambers','Crypt','Tombs','Catacombs','Lair','Dungeon','Caverns']
var dungeonadj = ['Dark','White','Red','Black','Molten','Distant','Eternal','Gloomy','Lower','Moaning','Demonic','Rocking','Living','Crystal','Deadly','Roaring']


var dungeons = {
#	skirmish_bandit_camp = {
#		code = 'skirmish_bandit_camp',
#		type = 'skirmish',
#		name = '',
#		classname = '',
#		descript = '',
#		background = '',
#		levels = [1,1],
#		stages_per_level = [1,1],
#		difficulty = 'easy',
#		enemies = [["rats_easy", 1]],
#		final_enemy = [['bandits_easy_boss',1]],
#		final_enemy_type = 'character',
#		final_enemy_class = ['combat'],
#		affiliation = 'local', #defines character races and events
#		events = [],
#	},
#	skirmish_forest_wolves = {
#		code = 'skirmish_forest_wolves',
#		type = 'skirmish',
#		name = '',
#		classname = '',
#		descript = '',
#		background = '',
#		levels = [1,1],
#		stages_per_level = [1,1],
#		difficulty = 'easy',
#		enemies = [["wolves_easy1", 1]],
#		final_enemy = [['bandits_easy_boss',1]],
#		final_enemy_type = 'monster',
#		affiliation = 'local', #defines character races and events
#		events = [],
#
#
#
#
#	},
	
	
	dungeon_bandit_den = {
		code = 'dungeon_bandit_den',
		type = 'dungeon',
		name = 'bandit_den',
		classname = '',
		descript = '',
		background = '',
		difficulties = {
			easy = {code = 'easy', 
			enemyarray =  [["rats_easy", 1],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]], 
			final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
			eventarray = [], 
			levels = [2,3], 
			stages_per_level = [3,5]
			},
			medium = {code = 'medium', 
			enemyarray =  [["rats_easy", 1],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]], 
			final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
			eventarray = [], 
			levels = [4,5], 
			stages_per_level = [4,6]
			},
			hard = {code = 'hard', 
			enemyarray =  [["rats_easy", 1],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]], 
			final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
			eventarray = [], 
			levels = [5,6], 
			stages_per_level = [5,6]
			},
		},
		
#		levels = [2,3],
#		stages_per_level = [3,5],
#		difficulty = 'easy',
#		enemies = [["rats_easy", 1],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
#		final_enemy = [['bandits_easy_boss',1]],
#		final_enemy_type = 'character',
#		final_enemy_class = ['combat'],
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_goblin_cave = {
		code = 'dungeon_goblin_cave',
		type = 'dungeon',
		name = 'goblin_cave',
		classname = '',
		descript = '',
		background = '',
		difficulties = {
			easy = {code = 'easy', 
			enemyarray =  [["rats_easy", 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
			final_enemy = [['goblins_easy_boss',1]], final_enemy_type = 'monster',
			eventarray = [], 
			levels = [2,4], 
			stages_per_level = [3,5]
			},
			medium = {code = 'medium', 
			enemyarray =  [["rats_easy", 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
			final_enemy = [['goblins_easy_boss',1]], final_enemy_type = 'monster',
			eventarray = [], 
			levels = [4,6], 
			stages_per_level = [3,5]
			},
		},
#		levels = [2,4],
#		stages_per_level = [3,5],
#		difficulty = 'easy',
#		enemies = [["rats_easy", 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
#		final_enemy = [['goblins_easy_boss',1]],
#		final_enemy_type = 'monster',
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_grove = {
		code = 'dungeon_grove',
		type = 'dungeon',
		name = 'grove',
		classname = '',
		descript = '',
		background = '',
		difficulties = {
			easy = {code = 'easy', 
			enemyarray = [["rats_easy", 1],['wolves_easy1', 1],['wolves_easy2', 1]],
			final_enemy = [['goblins_easy_boss',1]], final_enemy_type = 'monster',
			eventarray = [], 
			levels = [2,3],
			stages_per_level = [2,4],
			},
		},
#		levels = [2,3],
#		stages_per_level = [2,4],
#		difficulty = 'easy',
#		enemies = [["rats_easy", 1],['wolves_easy1', 1],['wolves_easy2', 1]],
#		final_enemy = [['goblins_easy_boss',1]],
#		final_enemy_type = 'monster',
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_crypt = {
		code = 'dungeon_crypt',
		type = 'dungeon',
		name = 'crypt',
		classname = '',
		descript = '',
		background = '',
		levels = [2,3],
		stages_per_level = [2,4],
		difficulty = 'easy',
		enemies = [["rats_easy", 1]],
		final_enemy = [['goblins_easy_boss',1]],
		final_enemy_type = 'monster',
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_mountains = {
		code = 'dungeon_mountains',
		type = 'dungeon',
		name = 'mountains',
		classname = '',
		descript = '',
		background = '',
		levels = [2,3],
		stages_per_level = [2,4],
		difficulty = 'medium',
		enemies = [["rats_easy", 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		final_enemy = [['goblins_easy_boss',1]],
		final_enemy_type = 'monster',
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_volcano = {
		code = 'dungeon_volcano',
		type = 'dungeon',
		name = 'volcano',
		classname = '',
		descript = '',
		background = '',
		levels = [2,3],
		stages_per_level = [2,4],
		difficulty = 'easy',
		enemies = [["rats_easy", 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		final_enemy = [['goblins_easy_boss',1]],
		final_enemy_type = 'monster',
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_city = {
		code = 'dungeon_city',
		type = 'dungeon',
		name = 'city',
		classname = '',
		descript = '',
		background = '',
		levels = [2,3],
		stages_per_level = [2,4],
		difficulty = 'easy',
		enemies = [["rats_easy", 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		final_enemy = [['goblins_easy_boss',1]],
		final_enemy_type = 'monster',
		affiliation = 'local', #defines character races and events
		events = [],
	},
}
var event_locations_data = {
	basic_threat_bandits = {code = 'basic_threat_bandits', type = 'event', event_code = 'bandits_threat_quest', name = 'Quest - Bandits', descript = '', icon = null},
	
}

var scripteventdata = {
	dungeon_entrance_tutorial = {
		code = 'dungeon_entrance_tutorial',
		trigger = 'enter',
		oneshot = true,
		action = 'startevent',
		arg = 'dungeon_enter_tutorial',
	},
	
}

var eventscrits = {
	dungeon_enter_tutorial = {
		reqs = [],
		event_start = [
			{
				effects = [],
				action = 'close_event',
				text = 'This is an event. ',
				reqs = [],
			},
			],
		
	},
	
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
				value = 'bandits_group',
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
