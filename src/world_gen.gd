extends Node


func _ready():
	for i in easter_egg_characters.values():
		i.code = i.name.to_lower()

func build_world():
	for i in lands:
		make_area(i)
		state.area_order.append(lands[i].code)

var backgrounds = {
	aliron = load("res://assets/images/backgrounds/Aliron.png"),
	elf_capital = load("res://assets/images/backgrounds/elf_capital.png"),
	
	cave1 = load("res://assets/images/backgrounds/cave1.png"),
	cave2 = load("res://assets/images/backgrounds/cave2.png"),
	cave3 = load("res://assets/images/backgrounds/cave3.png"),
}


var lands = {
	plains = {
		code = 'plains',
		name = "Plains",
		races = [['Human', 50], ['halfbreeds', 15], ['Elf', 3]], #races define chance of the race appearing in location, when selected randomly from local racces
		policies = [], #not used yet
		travel_time = [0,0], #how long it gonna take to travel to region
		difficulty = 0, #growing number defining quests and individuals
		disposition = 100, #reputation, not currently used
		population = [100000, 200000], #population, not currently used, but planned to be possible to affect its numbers
		start_settlements_number = {settlement_small = [2,2]}, #will generate said locations on first generation
		start_locations_number = 2, #will generate this number of smaller locations like dungeons
		locations = {}, #array to fill up with settlements and dungeons
		locationpool = ['dungeon_bandit_den','dungeon_goblin_cave'], #array of allowed locations to generate
		starting_locations = ['dungeon_bandit_den','dungeon_goblin_cave'],
		guilds = ['workers','servants','fighters','mages','slavemarket'],
		events = [
			{code = 'daisy_meet', text = "Check the streets", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start', state = false}, {type = "date", operant = 'gte', value = 2}], args = {}},
			{code = 'reim_encounter', text = "Search for Reim", reqs = [{type = 'active_quest_stage', value = 'workers_election_quest', stage = 'stage1'}], args = {}},
			],
		capital_options = ['quest_board','location_purchase'],
		material_tiers = {easy = 1, medium = 0.2, hard = 0.05},
		area_shop_items = {
			meat = {min = 40, max = 80, chance = 1},
			fish = {min = 40, max = 80, chance = 0.9},
			vegetables = {min = 40, max = 80, chance = 0.9},
			grain = {min = 60, max = 150, chance = 1},
			bread = {min = 30, max = 60, chance = 1},
			wood = {min = 40, max = 50, chance = 1},
			stone = {min = 40, max = 50, chance = 1},
			leather = {min = 3, max = 15, chance = 0.7},
			iron = {min = 10, max = 20, chance = 0.8},
			steel = {min = 5, max = 15, chance = 0.3},
			cloth = {min = 5, max = 20, chance = 0.9},
			clothsilk = {min = 5, max = 10, chance = 0.8},
			fleawarts = {min = 10, max = 20, chance = 0.8},
			bone = {min = 5, max = 20, chance = 0.7},
			lifeshard = {min = 4, max = 8, chance = 1},
			energyshard = {min = 2, max = 5, chance = 1},
			writ_of_exemption = {min = 1, max = 1, chance = 1},
			trap = {min = 5, max = 10, chance = 1},
			itempool0 = {items = ['dagger','club'], min = 1, max = 2, chance = 1},
			#itempool00 = {items = ['worker_outfit'], min = 3, max = 3, chance = 1},
			itempool1 = {items = ['sword','axe','spear','pickaxe','hammer','fishingtools','sickle','bow','staff','hunt_knife'], min = 3, max = 6, chance = 0.8},
			itempool2 = {items = ['chest_base_cloth','chest_base_leather','chest_base_metal','legs_base_cloth','legs_base_leather','legs_base_metal'], min = 1, max = 3, chance = 0.8},
			itempool3 = {items = ['leather_collar','animal_ears','animal_gloves','maid_dress','worker_outfit','lacy_underwear','handcuffs','strapon','anal_beads'], min = 3, max = 6, chance = 0.8},
			itempool4 = {items = ['beer','alcohol','aphrodisiac','hairdye'], min = 4, max = 8, chance = 0.8},
			
			},
		capital_background = 'aliron',
		capital_dynamic_background = 'aliron',
		capital_background_noise = 'aliron_noise',
		capital_background_music = 'wimborn',
		capital_name = "Aliron",
	},
	forests = {
		code = 'forests',
		name = "Forests",
		races = [['Elf', 100], ['DarkElf',10],['halfbreeds', 10], ['Fairy', 15], ['Dryad',5]],
		policies = [],
		travel_time = [6,6],
		difficulty = 1,
		disposition = 25,
		population = [20000, 50000],
		start_settlements_number = {settlement_small = [1,1]},
		locations = {},
		locationpool = ['dungeon_bandit_den','dungeon_goblin_cave'],
		starting_locations = [],
		guilds = [],
		events = [],
		capital_options = [],
		material_tiers = {easy = 1, medium = 0.7, hard = 0.1},
		area_shop_items = {
			vegetables = {min = 40, max = 80, chance = 1},
			grain = {min = 60, max = 150, chance = 1},
			bread = {min = 30, max = 60, chance = 1},
			cloth = {min = 10, max = 25, chance = 0.9},
			clothsilk = {min = 10, max = 15, chance = 0.9},
			salvia = {min = 10, max = 20, chance = 0.7},
			bone = {min = 5, max = 20, chance = 0.7},
			lifeshard = {min = 4, max = 8, chance = 1},
			energyshard = {min = 3, max = 5, chance = 1},
			obsidian = {min = 3, max = 5, chance = 0.7},
			itempool1 = {items = ['sword','bow','dagger','spear','staff'], min = 2, max = 4, chance = 0.8},
			itempool2 = {items = ['chest_base_cloth','chest_base_leather','legs_base_cloth','legs_base_leather'], min = 1, max = 2, chance = 0.8},
			},
		capital_background = 'elf_capital',
		capital_name = "Elven Capital",
		capital_dynamic_background = 'elf_capital',
		capital_background_noise = 'elf_noise',
		capital_background_music = 'frostford',
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
		start_settlements_number = {settlement_small = [1,1]},
		starting_locations = [],
		locations = {},
		locationpool = ['dungeon_goblin_cave'],
		guilds = [],
		material_tiers = {easy = 1, medium = 0.7, hard = 0.1},
		area_shop_items = {},
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
		start_settlements_number = {settlement_small = [1,1]},
		starting_locations = [],
		locations = {},
		locationpool = ['dungeon_goblin_cave'],
		guilds = [],
		material_tiers = {easy = 1, medium = 0.7, hard = 0.1},
		area_shop_items = {},
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
		starting_locations = [],
		locations = {},
		locationpool = ['dungeon_bandit_den'],
		guilds = [],
		material_tiers = {easy = 1, medium = 0.7, hard = 0.1},
		area_shop_items = {
			},
	},
}


func make_area(code):
	var areadata = lands[code].duplicate(true)
	state.areas[areadata.code] = areadata
	areadata.population = round(rand_range(areadata.population[0],areadata.population[1]))
	areadata.quests = {global = {}}
	areadata.questlocations = {}
	areadata.travel_time = round(rand_range(areadata.travel_time[0], areadata.travel_time[1]))
	areadata.unlocked = false
	for i in areadata.start_settlements_number:
		var number = round(rand_range(areadata.start_settlements_number[i][0], areadata.start_settlements_number[i][1]))
		while number > 0:
			make_settlement(i, areadata)
			number -= 1
	#while areadata.start_locations_number > 0:
	for i in areadata.starting_locations:
		var location = make_location(i, areadata)
		areadata.locations[location.id] = location
		state.location_links[location.id] = {area = code, category = 'locations'} 
		input_handler.active_location = location
	areadata.factions = {}
	areadata.quests.factions = {}
	areadata.shop = {}
	update_area_shop(areadata)
	if areadata.has('capital_name'):
		state.capitals.append(areadata.capital_name)
		areadata.capital = {}
		state.location_links[areadata.capital_name] = {name = areadata.capital_name, area = areadata.code, type = 'capital', travel_time = 0, category = 'capital'}
		areadata.capital[areadata.capital_name] = {name = areadata.capital_name, area = areadata.code, type = 'capital', travel_time = 0, category = 'capital'}
	for i in areadata.guilds:
		make_guild(i, areadata)
	areadata.erase('guilds')
	#update_guilds(areadata)

func get_area_from_location_code(code):
	var data = state.location_links[code]
	return state.areas[data.area]

func get_location_from_code(code):
	var data = state.location_links[code]
	return state.areas[data.area][data.category][code]

func get_faction_from_code(code):
	return state.factions[code]

func update_area_shop(area):
	area.shop.clear()
	var resource_array = []
	for i in area.area_shop_items:
		if randf() >= area.area_shop_items[i].chance:
			continue
		if Items.materiallist.has(i):
			resource_array.append(i)
			var amount = round(rand_range(area.area_shop_items[i].min, area.area_shop_items[i].max))
			area.shop[i] = amount
		elif Items.itemlist.has(i):
			var itemtemplate = Items.itemlist[i]
			match itemtemplate.type:
				'gear':
					if !itemtemplate.tags.has('recipe'): #either shouldn't happen yet
						area.shop[i] = round(rand_range(area.area_shop_items[i].min, area.area_shop_items[i].max))
				'usable':
					area.shop[i] = round(rand_range(area.area_shop_items[i].min, area.area_shop_items[i].max))
		else:
			if area.area_shop_items[i].has('items'):
				var data = area.area_shop_items[i]
				var amount = round(rand_range(data.min, data.max))
				while amount > 0:
					amount -= 1
					var item = Items.itemlist[data.items[randi()%data.items.size()]]
					if item.has('parts'):
						var parts = {}
						for i in item.parts:
							var tiers = []
							for i in area.material_tiers:
								tiers.append([i, area.material_tiers[i]])
							var materialtier = input_handler.weightedrandom(tiers)
							var materialarray = []
							for k in Items.materials_by_tiers[materialtier]:
								if Items.materiallist[k].has('parts') && Items.materiallist[k].parts.has(i):
									materialarray.append(k)
							if materialarray.size() == 0:
								for k in Items.materiallist.values():
									if k.has('parts') && k.parts.has(i):
										materialarray.append([k.code, 1.0/k.price])
								materialarray = [input_handler.weightedrandom(materialarray)]
							parts[i] = materialarray[randi()%materialarray.size()]
						area.shop[item.code] = parts
					else:
						if area.shop.has(item.code):
							area.shop[item.code] += 1
						else:
							area.shop[item.code] = 1



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

var factiondata = {
	fighters = {
		code = 'fighters',
		name = 'Fighters Guild',
		description = '',
		actions = ['hire','upgrade'],
		preference = ['combat'],
		character_types = [['servant',1]],
		character_bonuses = {authority = [75,100], obedience = [48,48]},
		events = [
			'fighters_init',
			],
		quests_easy = ['warriors_threat_easy','warriors_dungeon_easy','warriors_monster_hunt_easy'],
		quests_medium = ['warriors_threat_medium', 'warriors_dungeon_medium','warriors_monster_hunt_medium'],
		quests_hard = [],
		slavenumber = [2,2],
		questnumber = [1,1],
	},
	mages = {
		code = 'mages',
		name = 'Mages Guild',
		description = '',
		actions = ['hire','upgrade'],
		preference = ['magic'],
		character_types = [['servant',1]],
		character_bonuses = {submission = [5,10], authority = [45,65], obedience = [48,48]},
		events = [
			'mages_init',
			],
		quests_easy = ['mages_materials_easy','mages_craft_potions_easy','mages_threat_easy'],#,'mages_slave_easy'
		quests_medium = ['mages_materials_medium','mages_craft_potions_medium'],
		quests_hard = [],
		slavenumber = [2,2],
		questnumber = [1,1],
	},
	workers = {
		code = 'workers',
		name = 'Workers Guild',
		description = '',
		actions = ['hire','upgrade'],
		preference = ['labor'],
		character_types = [['servant',1]],
		character_bonuses = {submission = [5,15], authority = [70,90], obedience = [48,48]},
		events = [
			'workers_init',
			],
		quests_easy = ['workers_resources_easy','workers_craft_tools_easy','workers_threat_easy','workers_food_easy'],
		quests_medium = ['workers_resources_medium','workers_food_medium','workers_craft_tools_medium'],
		quests_hard = ['workers_resources_hard','workers_food_hard'],
		slavenumber = [2,2],
		questnumber = [1,1],
	},
	servants = {
		code = 'servants',
		name = 'Servants Guild',
		description = '',
		actions = ['hire','upgrade'],
		preference = ['sexual','social'],
		character_types = [['servant',1]],
		character_bonuses = {submission = [10,20], authority = [75,110], obedience = [48,48]},
		events = [
			'servants_init',
			],
		quests_easy = ['servants_craft_items_easy','servants_slave_easy'],
		quests_medium = ['servants_craft_items_medium','servants_slave_medium'],
		quests_hard = [],
		slavenumber = [2,3],
		questnumber = [2,2],
	},
	slavemarket = {
		code = 'slavemarket',
		name = 'Slave Market',
		description = '',
		actions = ['hire','sellslaves','services'],
		preference = [],
		character_types = [['slave',1]],
		character_bonuses = {submission = [20,35], authority = [50,100], obedience = [36,36]},
		
		slave_races = [['rare',3]],
		quests_easy = [],
		quests_medium = [],
		quests_hard = [],
		slavenumber = [3,5],
		questnumber = [],
	},
}

func make_guild(code, area):
	var data = factiondata[code].duplicate(true)
	area.quests.factions[data.code] = {}
	var guilddatatemplate = {
		code = data.code,
		name = data.name,
		area = area.code,
		actions = data.actions,
		chartype = data.character_types,
		charbonus = data.character_bonuses,
		preferences = data.preference,
		description = data.description,
		questpool = {easy = data.quests_easy, medium = data.quests_medium, hard = data.quests_hard},
		questsetting = {easy = 1, medium = 0, hard = 0, total = 1},
		slaves = [],
		events = [],
		reputation = 0,
		totalreputation = 0,
		difficulty = area.difficulty,
		races = area.races.duplicate(true),
		upgrades = {},
		slavelevel = 0,
	}
	if data.has('slave_races'):
		for i in data.slave_races:
			guilddatatemplate.races.append(i)
	if data.has("events"):
		guilddatatemplate.events = data.events.duplicate(true)
	if data.slavenumber.size() > 0:
		data.slavenumber = round(rand_range(data.slavenumber[0], data.slavenumber[1]))
	if data.questnumber.size() > 0:
		data.questnumber = round(rand_range(data.questnumber[0], data.questnumber[1]))
		area.quests.factions[data.code] = {}
		while data.questnumber > 0:
			for i in ['easy','medium']:#'medium','hard']:
				while guilddatatemplate.questsetting[i] > area.quests.factions[data.code].size():
					make_quest_for_guild(guilddatatemplate, i)
			data.questnumber -= 1
	guilddatatemplate.slavenumber = data.slavenumber
	while data.slavenumber > 0:
		make_slave_for_guild(guilddatatemplate)
		data.slavenumber -= 1
	
	state.factions[guilddatatemplate.code] = {code = guilddatatemplate.code, name = guilddatatemplate.name, area = guilddatatemplate.area}
	
	area.factions[guilddatatemplate.code] = guilddatatemplate

func make_slave_for_guild(guild):
	var newslave = Slave.new()
	var race = input_handler.weightedrandom(guild.races)
#	if globals.globalsettings.guilds_any_race:
#		race = 'random'
	var slaveclass = null
	if guild.preferences.size() > 0:
		slaveclass = guild.preferences[randi()%guild.preferences.size()]
	newslave.generate_random_character_from_data(race, slaveclass, guild.difficulty + round(randf())-0.3)
	var char_class = input_handler.weightedrandom(guild.chartype)
	newslave.set_slave_category(char_class)
	for i in guild.charbonus:
		newslave.add_stat(i, round(rand_range(guild.charbonus[i][0], guild.charbonus[i][1])))
	guild.slaves.append(newslave.id)
	newslave.is_hirable = true
	newslave.hire_scene = 'hire'
	newslave.is_known_to_player = true


func make_quest_for_guild(guilddatatemplate, difficulty):
	
	var newquest = make_quest(guilddatatemplate.questpool[difficulty][randi()%guilddatatemplate.questpool[difficulty].size()])
	newquest.source = guilddatatemplate.code
	newquest.area = guilddatatemplate.area
	newquest.travel_time = state.areas[guilddatatemplate.area].travel_time + round(randf()*6)
	newquest.difficulty = difficulty
	state.areas[newquest.area].quests.factions[newquest.source][newquest.id] = newquest

func make_settlement(code, area):
	var settlement = locations[code].duplicate(true)
	settlement.population = round(rand_range(settlement.population[0],settlement.population[1]))
	settlement.travel_time = round(rand_range(3,8))
	var text = locationnames[settlement.name+"1"][randi()%locationnames[settlement.name + "1"].size()] + locationnames[settlement.name+"2"][randi()%locationnames[settlement.name + "2"].size()]
	settlement.name = text
	settlement.id = "L" + str(state.locationcounter)
	settlement.group = {}
	settlement.type = 'settlement'
	settlement.levels = {}
	settlement.shop = {}
	state.locationcounter += 1
	if settlement.has('background_pool'):
		settlement.background = settlement.background_pool[randi()%settlement.background_pool.size()]
		settlement.erase("background_pool")
#	if randf() <= 0.8 || area.secondary_races.size() == 0:
#		settlement.races.append(area.lead_race)
#	if (randf() >= 0.7 || settlement.races.size() == 0) && area.secondary_races.size() != 0:
#		var added_races = area.secondary_races.duplicate()
#		var another_race = added_races[randi()%added_races.size()]
#		settlement.races.append(another_race)
#		added_races.erase(another_race)
#		if randf() >= 0.5 && added_races.size() > 0:
#			settlement.races.append(added_races[randi()%added_races.size()])
	settlement.events = {}
	
	update_area_shop(settlement)
	
	#adding resource types the settlement is going to have ========== Unused
#	var resourcedata = settlement.resources.duplicate()
#	settlement.resources.clear()
#	var food_types = round(rand_range(settlement.food_type_number[0], settlement.food_type_number[1]))
#	var resource_array = []
#	for i in resourcedata:
#		if Items.materiallist[i].type == 'food':
#			resource_array.append(i)
#	while food_types > 0:
#		var resource = resource_array[randi()%resource_array.size()]
#		settlement.resources.append(resource)
#		settlement.shop_resources[resource] = round(rand_range(settlement.food_type_amount[0], settlement.food_type_amount[1]))
#		resource_array.erase(resource)
#		food_types -= 1
#	var resource_types = round(rand_range(settlement.resources_type_number[0], settlement.resources_type_number[1]))
#	resource_array.clear()
#	for i in resourcedata:
#		if Items.materiallist[i].type != 'food':
#			resource_array.append(i)
#	while resource_types > 0:
#		var resource = resource_array[randi()%resource_array.size()]
#		settlement.resources.append(resource)
#		settlement.shop_resources[resource] = round(rand_range(settlement.resource_type_amount[0], settlement.resource_type_amount[1]))
#		resource_array.erase(resource)
#		resource_types -= 1
#	var item_types = round(rand_range(settlement.item_type_number[0], settlement.item_type_number[1]))
#	while item_types > 0:
#		var itemdata = settlement.items[randi()%settlement.items.size()]
#		if Items.itemlist[itemdata[0]].has("parts"):
#			var parts = {}
#			for i in Items.itemlist[itemdata[0]].parts:
#				var materialarray = []
#				for k in settlement.resources:
#					if Items.materiallist[k].has('parts') && Items.materiallist[k].parts.has(i):
#						materialarray.append(k)
#				if materialarray.size() == 0:
#					for k in Items.materiallist.values():
#						if k.has('parts') && k.parts.has(i):
#							materialarray.append([k.code, 1.0/k.price])
#					materialarray = [input_handler.weightedrandom(materialarray)]
#				parts[i] = materialarray[randi()%materialarray.size()]
#			settlement.shop_items[itemdata[0]] = parts
#		else:
#			settlement.shop_items[itemdata[0]] = round(rand_range(itemdata[1], itemdata[2]))
#			item_types -= 1
	
	
	area.locations[settlement.id] = settlement
	state.location_links[settlement.id] = {area = area.code, category = 'locations'} 

var locations = {
	settlement_small = {
		code = 'settlement_small',
		type = 'settlement',
		classname = 'settlement_small',
		name = 'village_human',
		races = [],
		population = [100,500],
		fear = 0,
		approval = 0,
		leader = '',
		actions = ['local_shop','local_events_search'],
		event_pool = [['event_good_recruit', 0.5], ['event_good_loot_small', 1], ['event_nothing_found', 2],['exotic_slave_trader',0.5], ['event_good_slavers_woods',100], ['event_good_rebels_beastkin',1]],
		strength = [1,10],
		material_tiers = {easy = 1, medium = 0.3, hard = 0.1},
		background_pool = ['village'],
		bgm = 'exploration',
		area_shop_items = {
			meat = {min = 20, max = 50, chance = 0.8},
			fish = {min = 15, max = 45, chance = 0.6},
			vegetables = {min = 20, max = 40, chance = 0.9},
			grain = {min = 40, max = 60, chance = 0.9},
			wood = {min = 10, max = 30, chance = 0.75},
			stone = {min = 10, max = 20, chance = 0.5},
			leather = {min = 5, max = 10, chance = 0.3},
			iron = {min = 10, max = 20, chance = 0.8},
			cloth = {min = 5, max = 15, chance = 0.5},
			fleawarts = {min = 5, max = 10, chance = 0.8},
			salvia = {min = 2, max = 6, chance = 0.6},
			lifeshard = {min = 3, max = 6, chance = 0.9},
			itempool1 = {items = ['axe','pickaxe','hammer','fishingtools','sickle','hunt_knife','dagger','club'], min = 1, max = 3, chance = 0.8},
			itempool2 = {items = ['worker_outfit','craftsman_suit','steel_collar'], min = 1, max = 4, chance = 0.5},
			itempool3 = {items = ['chest_base_leather','chest_base_cloth','legs_base_leather'], min = 1, max = 2, chance = 0.8},
			itempool4 = {items = ['beer','lifegem'], min = 2, max = 6, chance = 0.6},
			},
#		food_type_number = [1,2],
#		food_type_amount = [100,200],
#		resources_type_number = [2,3],
#		resource_type_amount = [30,50],
#		item_type_number = [3,5],
#		resources = ['stone', 'wood', 'iron', 'leather', 'cloth', 'fish','meat','grain', 'vegetables'],
#		items = [['lifeshard', 3, 7],['energyshard', 3,7],['alcohol',4,10], ['pickaxe',1,2], ['axe',2,3], ['sickle',1,2]],
	},
}

func make_location(code, area):
	var location = dungeons[code].duplicate(true)
	var text = location.name
	if locationnames.has(location.name+'_adjs'):
		text = "The " + locationnames[location.name+"_adjs"][randi()%locationnames[location.name + "_adjs"].size()] + " " + locationnames[location.name+"_nouns"][randi()%locationnames[location.name + "_nouns"].size()]
	if location.has('singlename'):
		text = location.singlename
	location.name = text
	location.id = "L" + str(state.locationcounter)
	location.travel_time = round(rand_range(1,4))
	location.code = code
	var levelnumber = round(rand_range(location.levels[0], location.levels[1]))
	location.levels = {}
	while levelnumber > 0:
		location.levels["L"+str(levelnumber)] = {stages = round(rand_range(location.stages_per_level[0], location.stages_per_level[1]))}
		levelnumber -= 1
	location.group = {}
	location.resources = location.resources
	location.randomevents = location.eventarray
	location.scriptedevents = []
	location.progress = {level = 1, stage = 0}
	location.stagedenemies = []
	location.enemies = location.enemyarray.duplicate(true)
	if location.has('background_pool'):
		location.background = location.background_pool[randi()%location.background_pool.size()]
		location.erase("background_pool")
	if location.has("final_enemy"):
		var bossenemy = input_handler.weightedrandom(location.final_enemy)
		location.stagedenemies.append({enemy = bossenemy, type = 'normal', level = location.levels.size(), stage = location.levels["L"+str(location.levels.size())].stages-1})
		if location.final_enemy_type == 'character':
			location.scriptedevents.append({trigger = 'finish_combat', event = 'character_boss_defeat', reqs = [{code = 'level', value = location.levels.size(), operant = 'gte'}, {code = 'stage', value = location.levels["L"+str(location.levels.size())].stages-1, operant = 'gte'}]})
		location.scriptedevents.append({trigger = 'finish_combat', event = 'custom_event', args = 'event_dungeon_complete_loot_easy', reqs = [{code = 'level', value = location.levels.size(), operant = 'gte'}, {code = 'stage', value = location.levels["L"+str(location.levels.size())].stages-1, operant = 'gte'}]})
	
	#location.scriptedevents.append({trigger = 'complete_location', event = 'finish_quest_dungeon', reqs = [], args = {}})
	state.locationcounter += 1
	location.erase('difficulties')
	return location

func update_guilds_old(area):
	#rebuild quests and slaves in guild
	for i in area.factions.values():
		for k in i.slaves:
			if randf() >= 0.7:
				characters_pool.get_char_by_id(k).is_active = false
				i.slaves.erase(k)
		while i.slaves.size() < i.slavenumber:
			make_slave_for_guild(i)
	for faction in area.quests.factions:
		for quest in area.quests.factions[faction].values():
			if quest.state == 'taken':
				quest.time_limit -= 1
				if quest.time_limit < 0:
					fail_quest(quest)
			else:
				if randf() >= 0.7 || quest.state == 'complete':
					area.quests.factions[faction].erase(quest.id)
				fill_faction_quests(faction, area.code)

func update_guilds(area):
	for faction in area.quests.factions:
		var cleararray = []
		for quest in area.quests.factions[faction].values():
			if quest.state == 'taken':
				quest.time_limit -= 1
				if quest.time_limit < 0:
					fail_quest(quest)
			else:
				if quest.state == 'complete' || int(state.date) % 7 == 0:
					cleararray.append(quest.id)
					#area.quests.factions[faction].erase(quest.id)
		for i in cleararray:
			area.quests.factions[faction].erase(i)
	
	if int(state.date) % 7 == 0:
		for i in area.factions.values():
			for k in i.slaves:
				characters_pool.get_char_by_id(k).is_active = false
			i.slaves.clear()
			while i.slaves.size() < i.slavenumber:
				make_slave_for_guild(i)
		for faction in area.quests.factions:
			fill_faction_quests(faction, area.code)

func update_locations():
	for i in state.areas.values():
		for j in i.locations.values():
			for k in j.events:
				j.events[k] -= 1

func fill_faction_quests(faction, area):
	var areadata = state.areas[area]
	var factiondata = areadata.factions[faction]
	
	#get existing quests data
	var difficulty = {easy = 0, medium = 0, hard = 0}
	
	for i in areadata.quests.factions[faction].values():
		difficulty[i.difficulty] += 1
	for i in difficulty:
		while factiondata.questsetting[i] > difficulty[i] && factiondata.questpool[i].size() > 0:
			make_quest_for_guild(factiondata, i)
			difficulty[i] += 1

func fail_quest(quest):
	quest.state = 'failed'
	for i in quest.requirements:
		if i.code in ['complete_location','complete_dungeon']:
			input_handler.return_characters_from_location(i.location)
			state.areas[i.area].locations.erase(i.location)
			state.areas[i.area].questlocations.erase(i.location)


var questdata = {
	workers_resources_easy = {
		code = 'workers_resources_easy',
		name = 'Resource gathering',
		descript = 'The guild requires additional resources for its needs. ',
		randomconditions = [{code = 'random_material', function = 'range', type = ['wood','cloth','bone','leather'], range = [8,15]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1,{code = 'gold',  item_based = true, range = [1.4,1.5]}], #first value is a weight of reward
		[0.3,{code = 'gear', material_grade = [['easy', 5], ['medium',1]], name = ['axe','pickaxe','sickle']}],
		],
		time_limit = [8,12],
	},
	workers_resources_medium = {
		code = 'workers_resources_medium',
		name = 'Resource gathering',
		descript = 'The guild requires additional resources for its needs. ',
		randomconditions = [{code = 'random_material', function = 'range', type = ['woodiron','iron','steel','clothmagic'], range = [8,15]}],
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.5,1.8]}],
		[0.3,{code = 'gear', material_grade = [['easy', 1], ['medium',4],['hard',1]], name = ['axe','pickaxe','sickle','hammer','fishingtools']}],
		],
		time_limit = [8,12],
	},
	workers_resources_hard = {
		code = 'workers_resources_hard',
		name = 'Resource gathering',
		descript = 'The guild requires additional resources for its needs. ',
		randomconditions = [{code = 'random_material', function = 'range', type = ['woodmagic','boneancinet','leathermythic','mithril'], range = [8,15]}],
		unlockreqs = [],
		reputation = [250,400],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.7,1.95]}], 
		[0.3,{code = 'gear', material_grade = [['easy', 1], ['medium',3],['hard',3]], name = ['axe','pickaxe','sickle','hammer','fishingtools']}],
		],
		time_limit = [8,12],
	},
	workers_food_easy = {
		code = 'workers_food_easy',
		name = 'Food supply',
		descript = 'The guild requires additional food supplies.',
		randomconditions = [{code = 'random_material', function = 'range', type =  ['meat','fish','vegetables','bread'], range = [35,55]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.5,1.7]}],
		[1,{code = 'material', name = ['wood', 'stone','leather','cloth', 'iron'], value = [15,20]}],
		[0.5,{code = 'gold', item_based = true, range = [0.5,0.6]},{code = 'metarial', type = ['steel', 'woodmagic','woodiron','clothsilk'], range = [5,10]}],
		],
		time_limit = [8,12],
	},
	workers_food_medium = {
		code = 'workers_food_medium',
		name = 'Food supply',
		descript = 'The guild requires additional food supplies.',
		randomconditions = [{code = 'random_material', function = 'range', type =  ['meat','fish','vegetables','bread'], range = [75,120]}],
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.7,1.9]}],
		#[1,{code = 'material', name = ['wood', 'stone','leather','cloth', 'iron'], value = [15,20]}],
		[0.5,{code = 'gold', item_based = true, range = [0.6,0.7]},{code = 'metarial', type = ['steel', 'obsidian','woodiron','clothmagic'], range = [10,15]}],
		],
		time_limit = [8,12],
	},
	workers_food_hard = {
		code = 'workers_food_hard',
		name = 'Food supply',
		descript = 'The guild requires additional food supplies.',
		randomconditions = [{code = 'random_material', function = 'range', type =  ['bread','fishcakes','meatsoup'], range = [75,120]}],
		unlockreqs = [],
		reputation = [250,450],
		rewards = [
		[1,{code = 'gold', item_based = true, range = [1.8,2.1]}],
		#[1,{code = 'material', name = ['wood', 'stone','leather','cloth', 'iron'], value = [15,20]}],
		[0.5,{code = 'gold', item_based = true, range = [0.7,0.8]},{code = 'metarial', type = ['mithril', 'obsidian','woodancient','clothmagic'], range = [3,5]}],
		],
		time_limit = [8,12],
	},
	workers_craft_tools_easy = {
		code = 'workers_craft_tools_easy',
		name = 'Tool making',
		descript = 'The guild requires some instruments crafted in a specific way ',
		randomconditions = [{code = 'random_item', function = 'range', type = ['axe','pickaxe','sickle'], range = [1,1], parts = {ToolBlade = ['iron','bone']}}],
		unlockreqs = [],
		reputation = [150,200],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.7,2]}],
		],
		time_limit = [8,12],
	},
	workers_craft_tools_medium = {
		code = 'workers_craft_tools_medium',
		name = 'Tool making',
		descript = 'The guild requires some instruments crafted in a specific way ',
		randomconditions = [
			{code = 'random_item', function = 'range', type = ['axe','pickaxe','sickle','hammer','hunt_knife'], range = [1,1], parts = {ToolBlade = ['steel','obsidian']}},
			{code = 'random_item', function = 'range', type = ['axe','pickaxe','sickle','hammer','fishingtools','hunt_knife'], range = [1,1], parts = {ToolHandle = ['steel','woodmagic']}},
			],
		unlockreqs = [],
		reputation = [250,400],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2,2.2]}],
		],
		time_limit = [8,12],
	},
	workers_threat_easy = {
		code = 'workers_threat_easy',
		name = 'Trouble Solving',
		descript = 'The guild requires a help with a certain issue.',
		randomconditions = [{code = 'complete_location', type = ['basic_threat_wolves'], difficulty = 'easy'}],
		unlockreqs = [],
		reputation = [150,200],
		rewards = [
		[1, {code = 'gold', range = [100,150]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['axe','pickaxe','sickle']}],
		[0.5, {code = 'gear_static', name = ['worker_outfit'], value = [1,1]}],
		],
		time_limit = [8,12],
	},
	workers_threat_medium = {
		code = 'workers_threat_medium',
		name = 'Trouble Solving',
		descript = 'The guild requires a help with a certain issue.',
		randomconditions = [{code = 'complete_location', type = ['basic_threat_troll'], difficulty = 'medium'}],
		unlockreqs = [],
		reputation = [200,300],
		rewards = [
		[1, {code = 'gold', range = [250,400]}],
		[1, {code = 'gear', material_grade = [['easy', 1], ['medium',3]], name = ['axe','pickaxe','sickle','hunt_knife']}],
		],
		time_limit = [8,12],
	},
	warriors_threat_easy = {
		code = 'warriors_threat_easy',
		name = 'Trouble Solving',
		descript = 'The guild requires a help with a certain issue.',
		randomconditions = [{code = 'complete_location', type = ['basic_threat_goblins','basic_threat_rebels']}],#,
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [125,175]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',1]], name = ['sword','spear','club','bow']}],
		],
		time_limit = [8,12],
	},
	warriors_threat_medium = {
		code = 'warriors_threat_medium',
		name = 'Trouble Solving',
		descript = 'The guild requires a help with a certain issue.',
		randomconditions = [{code = 'complete_location', type = ['basic_threat_ogre']}],#,
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1, {code = 'gold', range = [200,300]}],
		[1, {code = 'gear', material_grade = [['easy',1], ['medium',4], ['hard',1]], name = ['sword','spear','club','bow']}],
		],
		time_limit = [8,12],
	},
	warriors_dungeon_easy = {
		code = 'warriors_dungeon_easy',
		name = 'Dungeon clear',
		descript = 'The guild requires a local dungeon to be cleared.',
		randomconditions = [{code = 'complete_dungeon', type = ['dungeon_bandit_den', 'dungeon_goblin_cave']}],
		unlockreqs = [],
		reputation = [150,250],
		rewards = [
		[1, {code = 'gold', range = [200,300]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',3]], name = ['sword','spear','club','bow']}, {code = 'gold', range = [25,50]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['chest_base_metal','legs_base_metal']}],
		],
		time_limit = [12,16],
	},
	warriors_dungeon_medium = {
		code = 'warriors_dungeon_medium',
		name = 'Dungeon clear',
		descript = 'The guild requires a local dungeon to be cleared.',
		randomconditions = [{code = 'complete_dungeon', type = ['dungeon_bandit_fort','dungeon_undead_crypt']}],
		unlockreqs = [],
		reputation = [200,350],
		rewards = [
		[1, {code = 'gold', range = [350,500]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',3]], name = ['sword','spear','club','bow']}, {code = 'gold', range = [25,50]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['chest_base_metal','legs_base_metal']}],
		],
		time_limit = [16,20],
	},
	warriors_monster_hunt_easy = {
		code = 'warriors_monster_hunt_easy',
		name = 'Monster Hunt',
		descript = 'The guild has a task for hunting certain amount of enemies.',
		randomconditions = [{code = 'kill_monsters', type = ['rat','wolf'], range = [6,9]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [125,150]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',1]], name = ['sword','spear','club','bow']}, {code = 'gold', range = [10,30]}],
		],
		time_limit = [8,12],
	},
	warriors_monster_hunt_medium = {
		code = 'warriors_monster_hunt_medium',
		name = 'Monster Hunt',
		descript = 'The guild has a task for hunting certain amount of enemies.',
		randomconditions = [{code = 'kill_monsters', type = ['rat','wolf'], range = [6,9]}],
		unlockreqs = [],
		reputation = [200,250],
		rewards = [
		[1, {code = 'gold', range = [200,300]}],
		[1, {code = 'gear', material_grade = [['easy', 1], ['medium',4], ['hard',1]], name = ['sword','spear','club','bow']}, {code = 'gold', range = [50,100]}],
		],
		time_limit = [8,16],
	},
	mages_materials_easy = {
		code = 'mages_materials_easy',
		name = 'Resource Supply',
		descript = 'The guild requires additional resources for its needs. ',
		randomconditions = [{code = 'random_material', type = ['wood','fleawarts','cloth'], range = [7,12]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.6,1.8]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['staff']},  {code = 'gold', item_based = true, range = [0.5,0.7]}],
		],
		time_limit = [8,12],
	},
	mages_materials_medium = {
		code = 'mages_materials_medium',
		name = 'Resource Supply',
		descript = 'The guild requires additional resources for its needs. ',
		randomconditions = [{code = 'random_material', type = ['woodmagic','clothmagic'], range = [5,15]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.9,2.1]}],
		[1, {code = 'gear', material_grade = [['easy', 2], ['medium',4], ['hard',0.5]], name = ['staff']}, {code = 'gold', item_based = true, range = [0.5,0.7]}],
		],
		time_limit = [8,12],
	},
	mages_craft_potions_easy = {
		code = 'mages_craft_potions_easy',
		name = 'Potion Making',
		descript = 'The guild needs to resupply their store room.',
		randomconditions = [{code = 'random_item', type = ['aphrodisiac', 'alcohol'], range = [2,3]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.9,2.1]}],
		],
		time_limit = [8,12],
	},
	mages_craft_potions_medium = {
		code = 'mages_craft_potions_medium',
		name = 'Magic Catalysts',
		descript = 'The guild needs to resupply their store room.',
		randomconditions = [{code = 'random_item', type = ['aphrodisiac', 'alcohol'], range = [5,8]},{code = 'random_item', type = ['energyshard','energygem'], range = [2,4]}],
		unlockreqs = [],
		reputation = [200,300],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [2.1,2.4]}],
		],
		time_limit = [8,12],
	},
	mages_threat_easy = {
		code = 'mages_threat_easy',
		name = 'Trouble Solving',
		descript = 'The guild requires a help with a certain issue.',
		randomconditions = [{code = 'complete_location', type = ['basic_threat_wolves'], difficulty = 'easy'}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [100,150]}],
		[1, {code = 'gear', material_grade = [['easy', 5], ['medium',2]], name = ['staff','chest_base_cloth','legs_base_cloth']}],
		
		],
		time_limit = [8,12],
	},
	servants_craft_items_easy = {
		code = 'servants_craft_items_easy',
		name = 'Items Request',
		descript = 'The guild needs a specific crafted items',
		randomconditions = [{code = 'random_item', type = ['leather_collar','tail_plug','anal_plug','anal_beads','animal_gloves','strapon','handcuffs'], range = [1,2]}],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.5,1.8]}],
		],
		time_limit = [8,12],
	},
	servants_craft_items_medium = {
		code = 'servants_craft_items_medium',
		name = 'Items Request',
		descript = 'The guild needs a specific crafted items',
		randomconditions = [{code = 'random_item', type = ['pet_suit','elegant_chocker','chastity_belt','stimulative_underwear'], range = [1,2]}],
		unlockreqs = [],
		reputation = [250,350],
		rewards = [
		[1, {code = 'gold', item_based = true, range = [1.8,2]}],
		],
		time_limit = [8,12],
	},
	servants_slave_easy = {
		code = 'servants_slave_easy',
		name = 'Slave Request',
		descript = 'The guild is in need of specific trained individual.',
		 
		randomconditions = [
			{code = 'slave_delivery', 
			mandatory_conditions = [{code = 'sex', operant = 'eq', value = ['male','female']}],
			condition_number = [1,1],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','timid_factor'], range = [3,4]},
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['charm','sexuals'], range = [25,35]}
			],},
		],
		unlockreqs = [],
		reputation = [100,150],
		rewards = [
		[1, {code = 'gold', range = [150,300]}],
		],
		time_limit = [8,12],
	},
	servants_slave_medium = {
		code = 'servants_slave_medium',
		name = 'Slave Request',
		descript = 'The guild is in need of specific trained individual.',
		 
		randomconditions = [
			{code = 'slave_delivery', 
			mandatory_conditions = [{code = 'sex', operant = 'eq', value = ['male','female']}],
			condition_number = [2,2],
			conditions = [
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['tame_factor','timid_factor'], range = [3,4]},
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['wits_factor','charm_factor','sexuals_factor'], range = [3,4]},
			{use_once = false, code = 'stat', function = 'range',operant = 'gte', type = ['charm','sexuals'], range = [50,60]}
			],},
		],
		unlockreqs = [],
		reputation = [250,350],
		rewards = [
		[1, {code = 'gold', range = [350,500]}],
		],
		time_limit = [8,12],
	},
#	warriors_fighter_slave_easy = {
#		code = 'warriors_fighter_slave_easy',
#		type = 'slavegetquest',
#		name = 'Slave Request',
#		descript = 'The guild is in need of specific trained individual.',
#		randomconditions = [{code = 'stat', operant = 'gte', function = 'range', type = ['body_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range',operant = 'gte', type = ['physics'], range = [20,40]}]
#		unlockreqs = [],
#		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
#		time_limit = [8,12],
#	},
#	mages_slave_easy = {
#		code = 'mages_slave_easy',
#		type = 'slavegetquest',
#		name = 'Slave Request',
#		descript = 'The guild is in need of specific trained individual.',
#		randomconditions =  [{code = 'stat',operant = 'gte', function = 'range', type = ['magic_factor'], range = [2,3]},{use_once = true, code = 'stat', function = 'range',operant = 'gte', type = ['wits'], range = [20,40]}]},
#		unlockreqs = [],
#		rewards = [{code = 'gold', range = [150,200]}, {code = 'reputation', range = [100,200]}],
#		time_limit = [8,12],
#	},
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
	data.state = 'free'
	
	var requirements_number = 1
	var reqsarray = template.randomconditions.duplicate()
	
	
	while requirements_number > 0:
		var tempdata = reqsarray[randi()%reqsarray.size()].duplicate(true)
		var reqsarrayposition = reqsarray.find(tempdata)
		data.requirements.append(tempdata)
		if tempdata.code in ['random_item','slave_delivery']:
			tempdata.completed = false
		if tempdata.has('range'):
			tempdata.value = round(rand_range(tempdata.range[0], tempdata.range[1]))
		if tempdata.code == 'kill_monsters':
			tempdata.curvalue = 0
		if tempdata.has('parts'):
			for i in tempdata.parts:
				tempdata.parts[i] = tempdata.parts[i][randi()%tempdata.parts[i].size()]
		if tempdata.code == 'slave_delivery':
			tempdata.statreqs = []
			for i in tempdata.mandatory_conditions:
				if typeof(i.value) == TYPE_ARRAY:
					i.value = i.value[randi()%i.value.size()] 
				tempdata.statreqs.append(i)
			var statreq = round(rand_range(tempdata.condition_number[0],tempdata.condition_number[1]))
			while statreq > 0:
				var statdata = tempdata.conditions[randi()%tempdata.conditions.size()]
				var req = {operant = statdata.operant, code = statdata.code, type = statdata.type[randi()%statdata.type.size()], value = round(rand_range(statdata.range[0], statdata.range[1]))}
				
				statdata.type.erase(req.code)
				tempdata.statreqs.append(req)
				statreq -= 1
				if statdata.use_once == true:
					tempdata.conditions.erase(statdata)
			tempdata.erase('condition_number')
			tempdata.erase('conditions')
			tempdata.erase('mandatory_conditions')
			tempdata.statreqs.append({code = 'is_master', check = false})
			tempdata.statreqs.append({code = 'is_free'})
		else:
			tempdata.type = tempdata.type[randi()%tempdata.type.size()] 
		requirements_number -= 1
	var rewardarray = []
	for i in template.rewards.duplicate():
		rewardarray.append([i, i[0]])
	rewardarray = input_handler.weightedrandom(rewardarray)
	
	for i in rewardarray:
		var reward = {}
		if typeof(i) != TYPE_DICTIONARY: continue #ignoring weight value
		match i.code:
			'gold':
				reward.code = 'gold'
				if i.has('item_based') == true:
					var item_price = 0
					for k in data.requirements:
						match k.code:
							'random_item':
								if Items.itemlist[k.type].has('parts'):
									for j in k.parts:
										item_price += Items.materiallist[k.parts[j]].price * Items.itemlist[k.type].parts[j] * k.value
								else:
									item_price += Items.itemlist[k.type].price * k.value
							'random_material':
								item_price = Items.materiallist[k.type].price * k.value
					reward.value = round(item_price*rand_range(i.range[0], i.range[1]))
				else:
					reward.value = round(rand_range(i.range[0], i.range[1]))
			'gear':
				var dict = {item = i.name[randi()%i.name.size()], material_grade = i.material_grade}
				reward = generate_random_gear(dict)
				reward.item = reward.code
				reward.code = 'gear'
			'gear_static':
				reward.item = i.name[randi()%i.name.size()]
				reward.code = 'gear_static'
				reward.value = round(rand_range(i.value[0], i.value[1]))
			'material':
				reward.code = 'material'
				reward.item = i.name[randi()%i.name.size()]
				if reward.item in ['low','medium','high']:
					reward.item = get_materials_by_grade(reward.item)
					reward.item = reward.item[randi()%reward.item.size()]
				reward.value = round(rand_range(i.value[0], i.value[1]))
			'usable':
				reward.code = 'usable'
				reward.item = i.name[randi()%i.name.size()]
				reward.value = round(rand_range(i.value[0], i.value[1]))
		if reward.empty() == false:
			data.rewards.append(reward)
	
	if variables.exp_scroll_quest_reward: data.rewards.append({code = 'usable', item = 'exp_scroll', value = 1})
	data.rewards.append({code = 'reputation', value = round(rand_range(template.reputation[0],template.reputation[1]))})
	return data

func take_quest(quest, area):
	quest.state = 'taken'
	for i in quest.requirements:
		if i.code in ['complete_dungeon', 'complete_location']:
			var location = make_repeatable_quest_location(quest, area, i)
			area.questlocations[location.id] = location
			location.questid = quest.id
			i.location = location.id
			i.area = area.code
			state.location_links[location.id] = {area = area.code, category = 'questlocations'}

func find_location_from_req(req):
	var location = null
	if state.areas[req.area].questlocation.has(req.location):
		location = req.location
	return location

func make_quest_location(code):
	var data = dungeons[code]
	var locationdata = make_location(code, data.area)
	locationdata.id = code
	locationdata.travel_time = round(rand_range(data.travel_time[0], data.travel_time[1]))
	var area = state.areas[data.area]
	area.questlocations[locationdata.id] = locationdata
	state.location_links[locationdata.id] = {area = data.area, category = 'questlocations'} 
	input_handler.active_location = locationdata

func make_repeatable_quest_location(quest,area,req):
	var locationdata = {}
	locationdata.id = "L" + str(state.locationcounter)
	state.locationcounter += 1
	locationdata = make_location(req.type, area)
	req.locationname = locationdata.name
	match req.code:
		'complete_dungeon':
			locationdata.scriptedevents.append({trigger = 'complete_location', event = 'finish_quest_dungeon', reqs = [], args = {id = quest.id, source = quest.source, area = quest.area}})
		'complete_location':
			for i in locationdata.events:
				locationdata.scriptedevents.append(i.duplicate(true))
			locationdata.events.clear()
			locationdata.scriptedevents.append({trigger = 'finish_combat', event = 'finish_quest_location', reqs = [], args = {id = quest.id, source = quest.source, area = quest.area}})
		#match i.code:
			#'eventlocationquest':
#				var data = event_locations_data[i.type].duplicate(true)
#				locationdata.type = 'quest_event'
#				locationdata.code = data.code
#				locationdata.name = data.name
#				locationdata.descript = data.descript
#				locationdata.quest = quest.code
#				locationdata.area = quest.area
#				locationdata.travel_time = quest.travel_time
#				locationdata.event = data.event_code
#				locationdata.group = {}
#				locationdata.progress = {level = 0, stage = 0}
			#'dungeon':
	return locationdata

func get_materials_by_grade(grade):
	var array = []
	for i in Items.materiallist.values():
		array.append(i.code)
	return array

func make_chest_loot(chest):
	var data
	if typeof(chest) == TYPE_STRING:
		data = Enemydata.loot_chests_data[chest]
	var dict = {materials = {}, items = [], lock = {difficulty = 0, type = 'none'}}
	var location = input_handler.active_location
	
	if Enemydata.locks_data.has(chest):
		dict.lock.type = input_handler.weightedrandom(Enemydata.locks_data[chest].locks)
		if dict.lock.type != 'none':
			dict.lock.difficulty = rand_range(Enemydata.locks_data[chest].difficulty[0], Enemydata.locks_data[chest].difficulty[1])
	
	for i in data:
		match i.code:
			'defined':
				var tempitem = i.name
				var amount = round(rand_range(i.min, i.max))
				if Items.materiallist.has(tempitem):
					globals.AddOrIncrementDict(dict.materials, {tempitem : amount})
				if Items.itemlist.has(tempitem):
					var item = Items.itemlist[tempitem]
					match item.type:
						'usable':
							dict.items.append(globals.CreateUsableItem(tempitem, amount))
						'gear':
							if i.has('parts'):
								dict.items.append(globals.CreateGearItem(tempitem, i.parts))
							else:
								dict.items.append(globals.CreateGearItem(tempitem, {}))
			'material':
				var tempdict 
				if i.grade[0] == 'location':
					tempdict = {location.resources[randi()%location.resources.size()] : round(rand_range(i.min,i.max))}
				else:
					var array = []
					for k in Items.materiallist.values():
						if k.type != 'food' && i.grade.has(k.tier) && !k.tags.has('no_random'):
							array.append(k.code)
					tempdict = {array[randi()%array.size()] : round(rand_range(i.min, i.max))}
				globals.AddOrIncrementDict(dict.materials, tempdict)
			'usable':
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.type == 'usable':
						array.append(k.code)
				dict.items.append(globals.CreateUsableItem(array[randi()%array.size()], round(rand_range(i.min, i.max))))
			'static_gear':
				var number = round(rand_range(i.min, i.max))
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.has('geartype') && k.geartype == 'costume':
						array.append(k.code)
				while number > 0:
					dict.items.append(globals.CreateGearItem(array[randi()%array.size()],{}))
					number -= 1
			'gear':
				var number = round(rand_range(i.min, i.max))
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.type == 'gear' && k.itemtype in ['weapon', 'armor'] && k.geartype != 'costume':
						array.append(k.code)
				while number > 0:
					var itemdict = {}
					itemdict.item = array[randi()%array.size()]
					itemdict.grade = i.grade[randi()%i.grade.size()]
					if i.has('material_grade'):
						itemdict.locationmaterials = location.resources
						itemdict.material_grade = i.material_grade
					var item = generate_random_gear(itemdict)
					item = globals.CreateGearItem(item.code, item.itemparts, item.bonus)
					
					dict.items.append(item)
					number -= 1
	return dict

func generate_random_gear(dict):#dict = {item = code, material_grade = 'location', locationmaterials = []/optional/}
	var itemtemplate = Items.itemlist[dict.item]
	var itemparts = {}
	for i_part in itemtemplate.parts:
		var matgrade = input_handler.weightedrandom(dict.material_grade)
		var material_array = []
		if matgrade == 'location':
			for material in dict.locationmaterials:
				if Items.materiallist[material].parts.has(i_part):
					material_array.append(material)
		else:
			for i in Items.materiallist.values():
				if i.has('parts') && i.parts.has(i_part) && i.tier == matgrade:
					material_array.append(i.code)
		itemparts[i_part] = material_array[randi()%material_array.size()]
	
	return {code = itemtemplate.code, itemparts = itemparts, bonus = {}}



var locationnames = {
	village_human1 = ['Green','Black','Gold',"Stone","Great","Rain",'Storm','Red','River','Oaken','Ashen'],
	village_human2 = ['wood','ford','vale','burg','wind','ridge','minster','moor','meadow'],
	bandit_fort_nouns = ['Fort'],
	bandit_fort_adjs = ['Bandit'],
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
	quest_fighters_lich = {
		code = 'quest_fighters_lich',
		type = 'quest_location',
		name = "Lich's Hideout",
		area = 'plains',
		classname = '',
		descript = "By following Duncan's instructions, you find a small hideout which has a traces of undead monsters.",
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		events = [],
		travel_time = [2,2],
		options = [
			{text = 'Proceed', reqs = [], args = [{code = 'start_event', data = 'lich_enc_initiate', args = []}]}
		],
	},
	quest_mages_xari = {
		code = 'quest_mages_xari',
		type = 'encounter',
		name = "Xari's Location",
		area = 'plains',
		classname = '',
		descript = '',
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		travel_time = [3,3],
		events = [],
		options = [
			{text = 'Search for Xari', reqs = [
				{type = 'active_quest_stage', value = 'mages_election_quest', stage = 'start'}], 
				args = [{code = 'start_event', data = 'xari_encounter1', args = []}]},
			{text = 'See Xari', reqs = [
				{type = 'active_quest_stage', value = 'mages_election_quest', stage = 'stage1'}], 
				args = [{code = 'start_event', data = 'xari_encounter9', args = []}]},
		],
	},
	
	basic_threat_wolves = {
		code = 'basic_threat_wolves',
		type = 'encounter',
		name = 'Threat - Wild wolves',
		classname = '',
		descript = 'Farmers report a pack of wild wolves attacking their flock.',
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		options = [
			{text = 'Proceed', reqs = [], args = [{code = 'start_event', data = 'wolves_skirmish_start', args = []}]}
		],
		events = [],
	},
	basic_threat_rebels = {
		code = 'basic_threat_rebels',
		type = 'encounter',
		name = 'Threat - Rebels',
		classname = '',
		descript = "A group of rebels terrorize local villagers.",
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		options = [
			{text = 'Proceed', reqs = [], args = [{code = 'start_event', data = 'rebels_skirmish_start', args = []}]}
		],
		events = [],
	},
	basic_threat_goblins = {
		code = 'basic_threat_goblins',
		type = 'encounter',
		name = 'Threat - Goblins',
		classname = '',
		descript = "A group of wild goblins attacking passing travelers.",
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		events = [],
		options = [
			{text = 'Proceed', reqs = [], args = [{code = 'start_event', data = 'goblins_skirmish_start', args = []}]}
		]
	},
	basic_threat_ogre = {
		code = 'basic_threat_ogre',
		type = 'encounter',
		name = 'Threat - Ogre',
		classname = '',
		descript = "An angry ogre attacking passing travelers.",
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		events = [],
		options = [
			{text = 'Proceed', reqs = [], args = [{code = 'start_event', data = 'ogre_skirmish_start', args = []}]}
		],
	},
	basic_threat_troll = {
		code = 'basic_threat_troll',
		type = 'encounter',
		name = 'Threat - Troll',
		classname = '',
		descript = "An angry troll attacking passing travelers.",
		difficulty = 'easy',
		background = 'cave_1',
		enemyarray =  [], 
		eventarray = [], 
		levels = [1,1], 
		resources = [],
		stages_per_level = [1,1],
		events = [],
		options = [
			{text = 'Proceed', reqs = [], args = [{code = 'start_event', data = 'troll_skirmish_start', args = []}]}
		],
	},
	
	
	dungeon_bandit_den = {
		code = 'dungeon_bandit_den',
		type = 'dungeon',
		name = 'bandit_den',
		classname = '',
		descript = '',
		difficulty = 'easy',
		background_pool = ['cave_1', 'cave_2', 'cave_3'],
		enemyarray =  [["rats_easy", 0.5],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]], 
		final_enemy = [['bandits_easy_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		eventarray = [['dungeon_find_chest_easy', 1],['event_trap_easy', 1],['event_dungeon_prisoner',1]], 
		levels = [2,3], 
		resources = ['cloth','leather','iron','wood','clothsilk'],
		stages_per_level = [2,3],
		bgm = "dungeon",
		puchase_price = 100,
		affiliation = 'local', #defines character races and events
		events = [],
	},
	dungeon_bandit_fort = {
		code = 'dungeon_bandit_fort',
		type = 'dungeon',
		name = 'bandit_fort',
		classname = '',
		descript = '',
		difficulty = 'medium',
		background_pool = ['cave_1', 'cave_2', 'cave_3'],
		enemyarray =  [["bandits_assassin", 1],['bandits_medium', 1],['bandits_medium2', 1],['bandits_golem', 0.5],['bandits_ballista', 0.5]], 
		final_enemy = [['bandits_medium_boss',1]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		eventarray = [['dungeon_find_chest_easy', 1],['event_trap_easy', 1],['event_dungeon_prisoner',1]], 
		levels = [3,5], 
		resources = ['woodiron','leatherthick','iron','steel','clothsilk','mithril'],
		stages_per_level = [3,5],
		bgm = "dungeon",
		puchase_price = 200,
		affiliation = 'local',
		events = [],
		travel_time = [4,6],
	},
	dungeon_undead_crypt = {
		code = 'dungeon_undead_crypt',
		type = 'dungeon',
		name = 'crypt',
		classname = '',
		difficulty = 'medium',
		descript = '',
		background_pool = ['cave_1', 'cave_2', 'cave_3'],
		enemyarray =  [["skeletons_easy", 1],['skeletons_easy2', 1],['skeletons_zombies', 1],['skeletons_zombies2', 1],['skeletons_lich', 0.5]], 
		final_enemy = [['skeletons_lich_boss',1]], final_enemy_type = 'monster',
		eventarray = [['dungeon_find_chest_easy', 1],['event_trap_easy', 1]], 
		levels = [2,3], 
		resources = ['bone','leather','boneancient','woodmagic','clothsilk','iron','mithril','bonedragon'],
		stages_per_level = [2,3],
		bgm = "dungeon",
		puchase_price = 200,
		affiliation = 'local',
		events = [],
	},
	dungeon_goblin_cave = {
		code = 'dungeon_goblin_cave',
		type = 'dungeon',
		name = 'goblin_cave',
		classname = '',
		descript = '',
		background_pool = ['cave_1', 'cave_2', 'cave_3'],
		bgm = "dungeon",
		enemyarray =  [["rats_easy", 0.5],['spiders', 1],['goblins_easy', 1],['goblins_easy2', 1],['goblins_easy3', 0.5]],
		final_enemy = [['goblins_easy_boss',1]], final_enemy_type = 'monster',
		eventarray = [['dungeon_find_chest_easy', 1],['event_trap_easy', 1]], 
		levels = [2,3], 
		resources = ['bone','leather','stone','wood'],
		stages_per_level = [2,3],
		difficulty = 'easy',
		puchase_price = 100,
		affiliation = 'local',
		events = [],
	},
	dungeon_grove = {
		code = 'dungeon_grove',
		type = 'dungeon',
		name = 'grove',
		classname = '',
		descript = '',
		purchase_area = 'forests',
		background_pool = ['cave_1', 'cave_2', 'cave_3'],
		bgm = "dungeon",
		enemyarray = [["rats_easy", 0.5],['wolves_easy1', 1],['wolves_easy2', 1],['spiders', 1]],
		final_enemy = [['grove_easy_boss',1]], final_enemy_type = 'monster',
		eventarray = [['dungeon_find_chest_easy', 1]],
		levels = [2,4],
		resources = ['cloth','leather','woodmagic','wood'],
		stages_per_level = [2,4],
		difficulty = 'easy',
		puchase_price = 100,
		affiliation = 'local',
		events = [],
	},
	
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

var pregen_characters = {
	Daisy = {
		code = 'daisy',
		name = 'Daisy',
		surname = '',
		race = 'HalfkinBunny',
		sex = 'female',
		age = 'teen',
		slave_class = 'slave',
		height = 'short',
		hair_color = 'blond',
		hair_length = 'waist',
		hair_style = 'straight',
		eye_color = 'blue',
		ears = 'bunny_drooping',
		skin = 'pale',
		physics_factor = 1,
		wits_factor = 2,
		charm_factor = 4,
		sexuals_factor = 4,
		magic_factor = 2,
		growth_factor = 3,
		tame_factor = 4,
		timid_factor = 5,
		food_consumption = 2,
		icon_image = 'res://assets/images/portraits/daisy.png',
		body_image = "",
		physics = 11.0,
		wits = 2.0,
		charm = 0.0,
		sexuals = 0.0,
		obedience = 48,
		authority = 20,
		submission = 10,
		vaginal_virgin = true,
		anal_virgin = true,
		mouth_virgin = true,
		ass_size = 'small',
		tits_size = 'average',
		tags = ['no_sex'],
		personality = 'shy'
	},
}


var easter_egg_characters = {
	Chloe = {
		race = 'Gnome',
		name = 'Chloe',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		wit_factor = 4,
		wits = 70,
		professions = ['alchemist','apprentice'],
	},
	Cali = {
		race = 'HalfkinWolf',
		name = 'Cali',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		timid_factor = 2,
		class_category = 'combat',
	},
	Ember = {
		race = 'Dragonkin',
		name = 'Ember',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'labor',
		professions = ['smith']
	},
	Maple = {
		race = 'Fairy',
		name = 'Maple',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'social',
		professions = []
	},
	Raphtalia = {
		race = 'HalfkinTanuki',
		name = 'Raphtalia',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
		professions = []
	},
	Fran = {
		race = 'HalfkinCat',
		name = 'Fran',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
		professions = []
	},
	Evangelyne = {
		race = 'Elf',
		name = 'Evangelyne',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
		professions = ['archer', 'sniper']
	},
	Tamamo = {
		race = 'HalfkinFox',
		name = 'Tamamo',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Horo = {
		race = 'HalfkinWolf',
		name = 'Horo',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
	},
	Lulu = {
		race = 'Fairy',
		name = 'Lulu',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Mir = {
		race = 'Human',
		name = 'Mir',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Ahri = {
		race = 'Halfkin Fox',
		name = 'Ahri',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Momiji = {
		race = 'HalfkinWolf',
		name = 'Momiji',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
	},
	Youseiyunde = {
		race = 'Elf',
		name = 'Youseiyunde',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
	},
	Marcille = {
		race = 'Elf',
		name = 'Marcille',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Schierke = {
		race = 'Human',
		name = 'Schierke',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Feliss = {
		race = 'Demon',
		name = 'Feliss',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Jehy = {
		race = 'Demon',
		name = 'Jehy',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Albedo = {
		race = 'Demon',
		name = 'Albedo',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
	},
	Aura = {
		race = 'DarkElf',
		name = 'Aura',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
	},
	Senko = {
		race = 'HalfkinFox',
		name = 'Senko',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'social',
	},
	Hanyuu = {
		race = 'Demon',
		name = 'Hanyuu',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'magic',
	},
	Nanachi = {
		race = 'BeastkinBunny',
		name = 'Nanachi',
		bonus_description = '',
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
		icon_image = "",
		body_image = "",
		class_category = 'combat',
	},
}
