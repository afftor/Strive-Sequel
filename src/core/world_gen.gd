extends Node

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


func _ready():
	for i in worlddata.easter_egg_characters.values():
		i.code = i.name.to_lower()

func build_world():
	for i in worlddata.lands:
		make_area(i)
		ResourceScripts.game_world.area_order.append(worlddata.lands[i].code)

func make_area(code):
	var areadata = worlddata.lands[code].duplicate(true)
	ResourceScripts.game_world.areas[areadata.code] = areadata
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
		ResourceScripts.game_world.location_links[location.id] = {area = code, category = 'locations'} 
		input_handler.active_location = location
	areadata.factions = {}
	areadata.quests.factions = {}
	areadata.shop = {}
	update_area_shop(areadata)
	if areadata.has('capital_name'):
		ResourceScripts.game_world.capitals.append(areadata.capital_name)
		areadata.capital = {}
		ResourceScripts.game_world.location_links[areadata.capital_name] = {name = areadata.capital_name, area = areadata.code, type = 'capital', travel_time = 0, category = 'capital'}
		areadata.capital[areadata.capital_name] = {name = areadata.capital_name, area = areadata.code, type = 'capital', travel_time = 0, category = 'capital'}
	for i in areadata.guilds:
		make_guild(i, areadata)
	areadata.erase('guilds')
	#update_guilds(areadata)

func get_area_from_location_code(code):
	var data = ResourceScripts.game_world.location_links[code]
	return ResourceScripts.game_world.areas[data.area]

func get_location_from_code(code):
	var data = ResourceScripts.game_world.location_links[code]
	return ResourceScripts.game_world.areas[data.area][data.category][code]

func get_faction_from_code(code):
	return ResourceScripts.game_world.factions[code]

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


func make_guild(code, area):
	var data = worlddata.factiondata[code].duplicate(true)
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
	
	ResourceScripts.game_world.factions[guilddatatemplate.code] = {code = guilddatatemplate.code, name = guilddatatemplate.name, area = guilddatatemplate.area}
	
	area.factions[guilddatatemplate.code] = guilddatatemplate

func make_slave_for_guild(guild):
	var newslave = ResourceScripts.scriptdict.class_slave.new()
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
	newslave.set_stat('is_hirable', true)
	newslave.set_stat('hire_scene', 'hire')
	newslave.is_known_to_player = true


func make_quest_for_guild(guilddatatemplate, difficulty):
	
	var newquest = make_quest(guilddatatemplate.questpool[difficulty][randi()%guilddatatemplate.questpool[difficulty].size()])
	newquest.source = guilddatatemplate.code
	newquest.area = guilddatatemplate.area
	newquest.travel_time = ResourceScripts.game_world.areas[guilddatatemplate.area].travel_time + round(randf()*6)
	newquest.difficulty = difficulty
	ResourceScripts.game_world.areas[newquest.area].quests.factions[newquest.source][newquest.id] = newquest

func make_settlement(code, area):
	var settlement = worlddata.locations[code].duplicate(true)
	settlement.population = round(rand_range(settlement.population[0],settlement.population[1]))
	settlement.travel_time = round(rand_range(3,8))
	var text = worlddata.locationnames[settlement.name+"1"][randi() % worlddata.locationnames[settlement.name + "1"].size()] + worlddata.locationnames[settlement.name+"2"][randi() % worlddata.locationnames[settlement.name + "2"].size()]
	settlement.name = text
	settlement.id = "L" + str(ResourceScripts.game_world.locationcounter)
	settlement.group = {}
	settlement.type = 'settlement'
	settlement.levels = {}
	settlement.shop = {}
	ResourceScripts.game_world.locationcounter += 1
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
	ResourceScripts.game_world.location_links[settlement.id] = {area = area.code, category = 'locations'} 

func make_location(code, area):
	var location = worlddata.dungeons[code].duplicate(true)
	var text = location.name
	if worlddata.locationnames.has(location.name+'_adjs'):
		text = "The " + worlddata.locationnames[location.name+"_adjs"][randi() % worlddata.locationnames[location.name + "_adjs"].size()] + " " + worlddata.locationnames[location.name+"_nouns"][randi() % worlddata.locationnames[location.name + "_nouns"].size()]
	if location.has('singlename'):
		text = location.singlename
	location.name = text
	location.id = "L" + str(ResourceScripts.game_world.locationcounter)
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
	ResourceScripts.game_world.locationcounter += 1
	location.erase('difficulties')
	return location

func fill_faction_quests(faction, area):
	var areadata = ResourceScripts.game_world.areas[area]
	var factiondata = areadata.factions[faction]
	
	#get existing quests data
	var difficulty = {easy = 0, medium = 0, hard = 0}
	
	for i in areadata.quests.factions[faction].values():
		difficulty[i.difficulty] += 1
	for i in difficulty:
		while factiondata.questsetting[i] > difficulty[i] && factiondata.questpool[i].size() > 0:
			make_quest_for_guild(factiondata, i)
			difficulty[i] += 1

func make_quest(questcode):
	var template = worlddata.questdata[questcode].duplicate(true)#array[randi()%array.size()]
	var data = quest_template.duplicate(true)
	
	data.id = "Q" + str(ResourceScripts.game_progress.questcounter)
	ResourceScripts.game_progress.questcounter += 1
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
				if i.code == 'sex':
					if i.value.has('male') && input_handler.globalsettings.malechance <= 10:
						i.value.erase("male")
					if i.value.has("female") && input_handler.globalsettings.malechance + input_handler.globalsettings.futachance >= 90:
						i.value.rase("female")
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
			tempdata.statreqs.append({code = 'is_free', check = true})
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
					reward.item = Items.get_materials_by_grade(reward.item)
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


func make_quest_location(code):
	var data = worlddata.dungeons[code]
	var locationdata = make_location(code, data.area)
	locationdata.id = code
	locationdata.travel_time = round(rand_range(data.travel_time[0], data.travel_time[1]))
	var area = ResourceScripts.game_world.areas[data.area]
	area.questlocations[locationdata.id] = locationdata
	ResourceScripts.game_world.location_links[locationdata.id] = {area = data.area, category = 'questlocations'} 
	input_handler.active_location = locationdata

func make_repeatable_quest_location(quest,area,req):
	var locationdata = {}
	locationdata.id = "L" + str(ResourceScripts.game_world.locationcounter)
	ResourceScripts.game_world.locationcounter += 1
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
					input_handler.AddOrIncrementDict(dict.materials, {tempitem : amount})
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
				input_handler.AddOrIncrementDict(dict.materials, tempdict)
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

