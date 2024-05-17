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



func build_world():
	for i in worlddata.lands:
		if worlddata.lands[i].enabled == true:
			make_area(i)
			ResourceScripts.game_world.area_order.append(worlddata.lands[i].code)

func make_area(code):
	var areadata = worlddata.lands[code].duplicate(true)
	ResourceScripts.game_world.areas[areadata.code] = areadata
	areadata.quests = {global = {}}
	areadata.questlocations = {}
	areadata.travel_time = globals.rng.randi_range(areadata.travel_time[0], areadata.travel_time[1])#round(rand_range(areadata.travel_time[0], areadata.travel_time[1]))
	areadata.unlocked = true
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
		ResourceScripts.game_world.capitals.append(areadata.capital_code)
		areadata.capital = {}
		ResourceScripts.game_world.location_links[areadata.capital_code] = {name = areadata.capital_name, area = areadata.code, type = 'capital', travel_time = 0, category = 'capital', id = areadata.capital_code}
		areadata.capital[areadata.capital_code] = {name = areadata.capital_name, area = areadata.code, type = 'capital', travel_time = 0, category = 'capital', id = areadata.capital_code, group = {}}
	for i in areadata.guilds:
		make_guild(i, areadata)
	areadata.erase('guilds')
	#update_guilds(areadata)

#changes in next two methods handle only situation with adressing already removed location - they do not handle situation with generally broken location links data
func get_area_from_location_code(code):
	if !ResourceScripts.game_world.location_links.has(code): return null
	var data = ResourceScripts.game_world.location_links[code]
	return ResourceScripts.game_world.areas[data.area]

func get_location_from_code(code):
	if !ResourceScripts.game_world.location_links.has(code): return null
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
						for part in item.parts:
							var tiers = []
							for tier in area.material_tiers:
								tiers.append([tier, area.material_tiers[tier]])
							var materialtier = input_handler.weightedrandom(tiers)
							var materialarray = []
							for k in Items.materials_by_tiers[materialtier]:
								if Items.materiallist[k].has('parts') && Items.materiallist[k].parts.has(i):
									materialarray.append(k)
							if materialarray.size() == 0:
								for k in Items.materiallist.values():
									if k.has('parts') && k.parts.has(part):
										materialarray.append([k.code, 1.0/k.price])
								materialarray = [input_handler.weightedrandom(materialarray)]
							parts[part] = materialarray[randi()%materialarray.size()]
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
		bonus_actions = data.bonus_actions,
		conditions = data.conditions,
#		chartype = data.character_types,
#		charbonus = data.character_bonuses,
#		preferences = data.preference,
		description = data.description,
		questpool = {easy = data.quests_easy, medium = data.quests_medium, hard = data.quests_hard},
#		questsetting = {easy = 1, medium = 0, hard = 0, total = 1},
		slaves = [],
		hireable_characters = [],
		events = [],
		reputation = 0,
		totalreputation = 0,
		difficulty = 1,
#		races = [],
		upgrades = {},
#		slavelevel = 0,
	}
	for tdata in data.hireable_characters:
		var typedata = tdata.duplicate(true)
		if !tdata.tags.has("unique_slave_races"):
			typedata.slave_races = area.races.duplicate(true)
		for i in tdata.slave_races:
			typedata.slave_races.push_back(i)
		guilddatatemplate.hireable_characters.push_back(typedata)
	if data.has("events"):
		guilddatatemplate.events = data.events.duplicate(true)
	if data.has("reputation_shop"):
		guilddatatemplate.reputation_shop = data.reputation_shop.duplicate(true)
	if data.slavenumber.size() > 0:
		data.slavenumber = round(rand_range(data.slavenumber[0], data.slavenumber[1]))
#	if data.questnumber.size() > 0:
#		data.questnumber = round(rand_range(data.questnumber[0], data.questnumber[1]))
#		area.quests.factions[data.code] = {}
#		while data.questnumber > 0:
#			for i in ['easy','medium','hard']:
#				while guilddatatemplate.questsetting[i] > area.quests.factions[data.code].size():
#					make_quest_for_guild(guilddatatemplate, i)
#			data.questnumber -= 1
	if data.has('background'): guilddatatemplate.background = data.background
	guilddatatemplate.slavenumber = data.slavenumber
	rebuild_guild_slaves(guilddatatemplate)
#	while data.slavenumber > 0:
#		make_slave_for_guild(guilddatatemplate)
#		data.slavenumber -= 1

	ResourceScripts.game_world.factions[guilddatatemplate.code] = {code = guilddatatemplate.code, name = guilddatatemplate.name, area = guilddatatemplate.area}

	area.factions[guilddatatemplate.code] = guilddatatemplate
	fill_faction_quests(guilddatatemplate.code, area.code)


func make_slave_for_guild_old(guild):#obsolete
	var newslave = ResourceScripts.scriptdict.class_slave.new("guild_slave")
	var race = input_handler.weightedrandom(guild.races)
#    if globals.globalsettings.guilds_any_race:
#        race = 'random'
	var slaveclass = null
	if guild.preferences.size() > 0:
		slaveclass = guild.preferences[randi()%guild.preferences.size()]
	newslave.generate_random_character_from_data(race, slaveclass, guild.slavelevel + round(randf()-0.3))
	var char_class = input_handler.weightedrandom(guild.chartype)
	newslave.set_slave_category(char_class)
	var bonus_resolved = {}
	for i in guild.charbonus:
#        newslave.add_stat(i, round(rand_range(guild.charbonus[i][0], guild.charbonus[i][1])))
		if typeof(guild.charbonus[i]) == TYPE_ARRAY: bonus_resolved[i] = round(rand_range(guild.charbonus[i][0], guild.charbonus[i][1]))
		else: bonus_resolved[i] = guild.charbonus[i]
	newslave.add_stat_bonuses(bonus_resolved)
	guild.slaves.append(newslave.id)
	newslave.set_stat('is_hirable', true)
	newslave.set_stat('hire_scene', 'hire')
	newslave.is_known_to_player = true


func make_slave_for_guild(slavetype, rare_races_upgrade = 0):
	var newslave = ResourceScripts.scriptdict.class_slave.new("guild_slave")
	var race_arr = slavetype.slave_races
	match int(rare_races_upgrade):
		1:
			race_arr = [['common', 10], ['uncommon', 2]]
		2:
			race_arr = [['common', 10], ['uncommon', 4]]
		3:
			race_arr = [['common', 10], ['uncommon', 4], ['rare', 2]]
	var race = input_handler.weightedrandom(race_arr)
	var slaveclass = null
	if slavetype.preference.size() > 0:
		slaveclass = input_handler.random_from_array(slavetype.preference)
	var tr_bll = []
	if slavetype.has('no_traits'):
		tr_bll = slavetype.no_traits
	newslave.generate_random_character_from_data(race, slaveclass, slavetype.slavelevel + round(randf()-0.3), tr_bll)
	var char_class = input_handler.weightedrandom(slavetype.character_types)
	newslave.set_slave_category(char_class)
	var bonus_resolved = {}
	for i in slavetype.character_bonuses:
#        newslave.add_stat(i, round(rand_range(guild.charbonus[i][0], guild.charbonus[i][1])))
		if typeof(slavetype.character_bonuses[i]) == TYPE_ARRAY: bonus_resolved[i] = round(rand_range(slavetype.character_bonuses[i][0], slavetype.character_bonuses[i][1]))
		else: bonus_resolved[i] = slavetype.character_bonuses[i]
	newslave.add_stat_bonuses(bonus_resolved)
	if slavetype.has('traits'):
		for i in slavetype.traits:
			var tr
			if i is Array:
				if randf() > i[1]: 
					continue
				tr = i[0]
			else:
				tr = i
			var tdata = Traitdata.traits[tr]
			if tdata.has('reqs') and !newslave.checkreqs(tdata.reqs): 
				continue
			newslave.add_trait(tr)
	
	newslave.set_stat('is_hirable', true)
	newslave.set_stat('hire_scene', 'hire')
	newslave.is_known_to_player = true
	return newslave


func rebuild_guild_slaves(guilddata):
	var num = guilddata.slavenumber
	var race_upgrade = 0
	if guilddata.upgrades.has('slaveraces'):
		race_upgrade = guilddata.upgrades.slaveraces
	for type in guilddata.hireable_characters:
		for i in range(type.slavenumber[0]):
			if num <= 0: return
			num -= 1
			guilddata.slaves.push_back(make_slave_for_guild(type, race_upgrade).id)
	
	var rand_types_array = []
	for t in range(guilddata.hireable_characters.size()):
		var type = guilddata.hireable_characters[t]
		for i in range(type.slavenumber[0], type.slavenumber[1]):
			rand_types_array.push_back(t)
	
	while num > 0 and !rand_types_array.empty():
		var rtype = input_handler.random_from_array(rand_types_array)
		num -= 1
		rand_types_array.erase(rtype)
		guilddata.slaves.push_back(make_slave_for_guild(guilddata.hireable_characters[rtype], race_upgrade).id)



func make_quest_for_guild(guilddatatemplate, difficulty):
	
	var array = []
	for i in guilddatatemplate.questpool[difficulty]:
		if globals.checkreqs(worlddata.questdata[i].unlockreqs) == true:
			array.append(i)
	var newquest = make_quest(array[randi()%array.size()])
	newquest.source = guilddatatemplate.code
	newquest.area = guilddatatemplate.area
	newquest.travel_time = min(1, ResourceScripts.game_world.areas[guilddatatemplate.area].travel_time + round(randf()))#*6)
	newquest.difficulty = difficulty
	ResourceScripts.game_world.areas[newquest.area].quests.factions[newquest.source][newquest.id] = newquest

func make_settlement(code, area):
	var settlement = worlddata.locations[code].duplicate(true)
	settlement.travel_time = globals.rng.randi_range(settlement.travel_time[0],settlement.travel_time[1])
	var text = ''
	#print(settlement.code, settlement.name)
	if worlddata.locationnames.has(settlement.code) && settlement.name == null:
		text = worlddata.locationnames[settlement.code+"1"][randi() % worlddata.locationnames[settlement.code + "1"].size()] + worlddata.locationnames[settlement.code+"2"][randi() % worlddata.locationnames[settlement.code + "2"].size()]
	else:
		text = settlement.name
#	else:
#		text = worlddata.locationnames[settlement.code][randi() % worlddata.locationnames[settlement.code].size()]
	settlement.name = tr(text)
	settlement.id = "L" + str(ResourceScripts.game_world.locationcounter)
	settlement.group = {}
	settlement.type = 'settlement'
	settlement.levels = {}
	settlement.shop = {}
	ResourceScripts.game_world.locationcounter += 1
	if settlement.has('background_pool'):
		settlement.background = settlement.background_pool[randi()%settlement.background_pool.size()]
		settlement.erase("background_pool")
	settlement.events = {}
	update_area_shop(settlement)

	if settlement.has('gather_resources'):
		for i in settlement.gather_resources.keys():
			settlement.gather_resources[i] = round(rand_range(settlement.gather_resources[i][0],settlement.gather_resources[i][1]))

	area.locations[settlement.id] = settlement
	ResourceScripts.game_world.location_links[settlement.id] = {area = area.code, category = 'locations'}


func make_location(code, area):
	var location = DungeonData.dungeons[code].duplicate(true)
#	var location = DungeonData.dungeons['quest_final_operation_location'].duplicate(true)
	location.stamina = 100
	var text = tr(location.name)
	if worlddata.locationnames.has(location.name+'_adjs'):
		text = tr("LOCATIONTHE") + tr(worlddata.locationnames[location.name+"_adjs"][randi() % worlddata.locationnames[location.name + "_adjs"].size()]) + " " + tr(worlddata.locationnames[location.name+"_nouns"][randi() % worlddata.locationnames[location.name + "_nouns"].size()])
	if location.has('singlename'):
		text = location.singlename
	location.name = text
	location.id = "L" + str(ResourceScripts.game_world.locationcounter)
	location.travel_time = max(1,globals.rng.randi_range(0,0))
	location.code = code
	var levelnumber = round(rand_range(location.levels[0], location.levels[1]))
	location.levels = levelnumber
#	location.levels = {}
#	while levelnumber > 0:
#		location.levels["L"+str(levelnumber)] = {stages = round(rand_range(location.stages_per_level[0], location.stages_per_level[1]))}
#		levelnumber -= 1
	location.group = {}
	location.resources = location.resources
#	location.randomevents = location.eventarray
	location.scriptedevents = []
	location.progress = {main = 0, full = 0} #in rooms
	location.completed = false
	location.stagedenemies = [] #obsolete
	location.enemies = location.enemyarray.duplicate(true)
	location.tasks = []
	if location.has('gatherable_resources'):
		location.gather_limit_resources = {}
		location.tasks.append("gather")
		for res in location.gatherable_resources:
			if location.gatherable_resources[res].gather_mod is Array:
				location.gatherable_resources[res].gather_mod = globals.rng.randf_range(location.gatherable_resources[res].gather_mod[0], location.gatherable_resources[res].gather_mod[1])
#		location.gather_mod = rand_range(location.gather_mod[0],location.gather_mod[1])
#	location.erase('gatherable_resources')
	if location.has('background_pool'):
		location.background = location.background_pool[randi()%location.background_pool.size()]
		location.erase("background_pool")
		#temp out
#		location.scriptedevents.append({trigger = 'dungeon_complete', event = 'custom_event', args = 'event_dungeon_complete_loot_' + location.difficulty, reqs = []}) 
#	if location.has('gather_limit_resources'):
#		location.scriptedevents.append({trigger = 'dungeon_complete', event = 'custom_event', args = 'event_dungeon_unlock_resources', reqs = []})

	#location.scriptedevents.append({trigger = 'complete_location', event = 'finish_quest_dungeon', reqs = [], args = {}})
	ResourceScripts.game_world.locationcounter += 1
	location.erase('difficulties')
	if location.type == 'dungeon':
		dungeon_full = 0
		dungeon_mainline = 0
		location.dungeon = []
		for i in range(levelnumber):
			build_floor_first_pass(location, i)
		location.current_level = 0
		var ev_pool = build_subrooms_pool(location)
		for i in range(levelnumber):
			finalize_subrooms(location, ev_pool, i)
		location.stagedevents = {
			main = {},
			full = {},
			room = {}
		}
		if location.has("final_enemy"):
#			var bossenemy = input_handler.weightedrandom(location.final_enemy)
			if location.final_enemy_type == 'character':
				location.stagedevents.main[dungeon_mainline] = {event = 'character_boss_defeat'}
		if location.has('scripteventdata'):
			for scr in location.scripteventdata:
				match scr.trigger:
					'enter':
						location.stagedevents.main[1] = {event = scr.args}
						if scr.has('reqs'):
							location.stagedevents.main[1].reqs = scr.reqs
					'dungeon_complete':
						location.stagedevents.main[dungeon_mainline] = {event = scr.args}
						if scr.has('reqs'):
							location.stagedevents.main[dungeon_mainline].reqs = scr.reqs
					'stage':
						match scr.stage:
							'half':
								location.stagedevents.main[dungeon_mainline / 2] = {event = scr.args}
								if scr.has('reqs'):
									location.stagedevents.main[dungeon_mainline / 2].reqs = scr.reqs
							'-1':
								location.stagedevents.main[dungeon_mainline - 1] = {event = scr.args}
								if scr.has('reqs'):
									location.stagedevents.main[dungeon_mainline - 1].reqs = scr.reqs
	return location

func fill_faction_quests(faction, area):
	var areadata = ResourceScripts.game_world.areas[area]
	var factiondata = areadata.factions[faction]

	#get existing quests data
	var difficulty = {easy = 0, medium = 0, hard = 0}
	for quest in areadata.quests.factions[faction].values():
		difficulty[quest.difficulty] += 1
	var diff_limits = {easy = 1, medium = 0, hard = 0}
	if factiondata.totalreputation >= 300:
		diff_limits.easy = 2
	if factiondata.totalreputation >= 500:
		diff_limits.easy = 2
		diff_limits.medium = 1
	if factiondata.totalreputation >= 1000:
		diff_limits.easy = 2
		diff_limits.medium = 1
		diff_limits.hard = 1
	if factiondata.totalreputation >= 1500:
		diff_limits.easy = 2
		diff_limits.medium = globals.rng.randi_range(1, 2)
		diff_limits.hard = 1

#	for i in areadata.quests.factions[faction].values():
#		difficulty[i.difficulty] += 1
	for i in difficulty:
		while diff_limits[i] > difficulty[i] && factiondata.questpool[i].size() > 0:
			make_quest_for_guild(factiondata, i)
			difficulty[i] += 1

func make_quest(questcode):
	var template = worlddata.questdata[questcode].duplicate(true)#array[randi()%array.size()]
	var data = quest_template.duplicate(true)

	data.id = "Q" + str(ResourceScripts.game_progress.questcounter)
	ResourceScripts.game_progress.questcounter += 1
	data.code = template.code
	data.name = tr(template.name)
	data.descript = tr(template.descript)
	data.time_limit = round(rand_range(template.time_limit[0], template.time_limit[1]))
	data.state = 'free'
	
	var requirements_number = 1
	var reqsarray = template.randomconditions.duplicate()
	
	while requirements_number > 0:
		var tempdata = reqsarray[randi()%reqsarray.size()].duplicate(true)
		var reqsarrayposition = reqsarray.find(tempdata)
		data.requirements.append(tempdata)
		if tempdata.code in ['random_item']:
			tempdata.completed = false
		if tempdata.has('range'):
			tempdata.value = round(rand_range(tempdata.range[0], tempdata.range[1]))
		if tempdata.code == 'kill_monsters':
			tempdata.curvalue = 0
		if tempdata.has('parts'):
			for i in tempdata.parts:
				tempdata.parts[i] = tempdata.parts[i][randi()%tempdata.parts[i].size()]
		if tempdata.code in ['slave_delivery','slave_work']: #slavework is disabled on 0.7.2+
			tempdata.statreqs = []
			tempdata.delivered_slaves = 0
			for i in tempdata.mandatory_conditions:
				if i.code == 'sex':
					if i.value.has('male') && input_handler.globalsettings.malechance <= 10:
						i.value.erase("male")
					if i.value.has("female") && input_handler.globalsettings.malechance + input_handler.globalsettings.futachance >= 90:
						i.value.erase("female")
				if typeof(i.value) == TYPE_ARRAY:
					i.value = i.value[randi()%i.value.size()]
				tempdata.statreqs.append(i)
			var statreq = round(rand_range(tempdata.condition_number[0],tempdata.condition_number[1]))
			while statreq > 0:
				var statdata = tempdata.conditions[randi()%tempdata.conditions.size()]
				statreq -= 1
				if statdata.code == 'stat':
					var req = {code = statdata.code, operant = statdata.operant, stat = statdata.type[randi()%statdata.type.size()], value = round(rand_range(statdata.range[0], statdata.range[1]))}
					statdata.type.erase(req.stat)
					if statdata.type.empty():
						statdata.use_once = true
					tempdata.statreqs.append(req)
				elif statdata.code == 'class':
					var number = round(rand_range(statdata.range[0],statdata.range[1]))
					var classarray = []
					while number > 0:
						var newclass = statdata.type[randi()%statdata.type.size()]
						statdata.type.erase(newclass)
						var has_conflicts = false
						for i in classarray:
							var classdata = classesdata.professions[i]
							if classdata.conflict_classes.has(newclass):
								has_conflicts = true
								break
						if has_conflicts == false:
							classarray.append(newclass)
							number -= 1
					for i in classarray:
						tempdata.statreqs.append({code = 'has_profession', profession = i, check = true})
				elif statdata.code == 'race':
					var number = round(rand_range(statdata.range[0],statdata.range[1]))
					var racearray = []
					while number > 0:
						var newrace = statdata.type[randi()%statdata.type.size()]
						racearray.append(newrace)
						statdata.type.erase(newrace)
						number -= 1
					tempdata.statreqs.append({code = 'one_of_races', value = racearray, check = true})
				
				
				if statdata.use_once == true:
					tempdata.conditions.erase(statdata)
			tempdata.erase('condition_number')
			tempdata.erase('conditions')
			tempdata.erase('mandatory_conditions')
			if tempdata.has('work_time'):
				tempdata.work_time = round(rand_range(tempdata.work_time[0], tempdata.work_time[1]))
			tempdata.statreqs.append({code = 'is_master', check = false})
			tempdata.statreqs.append({code = 'slave_type', value = 'servant', operant = 'neq'})
			#tempdata.statreqs.append({code = 'is_free', check = true})
		elif tempdata.code == 'special_task':
			var task_reward = [{code = 'finish_worktask', value = data.id}]
			var task_dict = {code = 'add_special_task_for_location', location = tempdata.location, args = task_reward}
			for key in ['template', 'descript', 'name', 'icon', 'function']:
				if tempdata.has(key):
					if tempdata[key] is Array:
						tempdata[key] = input_handler.random_from_array(tempdata[key])
					task_dict[key] = tempdata[key]
					if !(key in ['name', 'icon']):
						tempdata.erase(key)
			for key in ['max_workers', 'amount']:
				if tempdata.has(key):
					if tempdata[key] is Array:
						tempdata[key] = globals.rng.randi_range(tempdata[key][0], tempdata[key][1])
					task_dict[key] = tempdata[key]
					tempdata.erase(key)
			tempdata.starteffect = [task_dict]
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
									reward.value = [rand_range(i.range[0], i.range[1])]
								else:
									item_price += Items.itemlist[k.type].price * k.value
									reward.value = round(item_price * rand_range(i.range[0], i.range[1]))
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
	locationdata.travel_time = max(1, globals.rng.randi_range(data.travel_time[0], data.travel_time[1]))#round(rand_range(data.travel_time[0], data.travel_time[1]))
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
		data = Enemydata.loot_variants_data[chest]
	var dict = {materials = {}, items = [], gold = 0, lock = {difficulty = 0, type = 'none'}}
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
				if amount <= 0 : continue
				if Items.materiallist.has(tempitem):
					input_handler.AddOrIncrementDict(dict.materials, {tempitem : amount})
				if Items.itemlist.has(tempitem):
					var item = Items.itemlist[tempitem]
					match item.type:
						'usable':
							dict.items.append(globals.CreateUsableItem(tempitem, amount))
						'gear':
							if i.has('parts'):
								if i.has('quality'):
									dict.items.append(globals.CreateGearItemQuality(tempitem, i.parts, i.quality))
								else:
									dict.items.append(globals.CreateGearItemQuality(tempitem, i.parts, 'poor'))
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
			'material_selected':
				var tempdict
				var mat = input_handler.weightedrandom(i.options)
				var value = rand_range(i.value[0], i.value[1])
				var number = ceil(value/Items.materiallist[mat].price)
				tempdict = {mat : number}
				input_handler.AddOrIncrementDict(dict.materials, tempdict)
			'usable':
				var array = []
				var amount = round(rand_range(i.min, i.max))
				if amount <= 0:
					continue
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.type == 'usable' && !k.tags.has('no_random'):
						array.append(k.code)
				dict.items.append(globals.CreateUsableItem(array[randi()%array.size()], amount))
			'static_gear':
				var number = round(rand_range(i.min, i.max))
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.has('geartype') && k.geartype == 'costume' && !k.tags.has('no_random'):
						array.append(k.code)
				while number > 0:
					dict.items.append(globals.CreateGearItem(array[randi()%array.size()],{}))
					number -= 1
			'gear':
				var number = round(rand_range(i.min, i.max))
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.type == 'gear' && k.itemtype in ['weapon', 'armor'] && k.geartype != 'costume' && !k.tags.has('no_random'):
						array.append(k.code)
				while number > 0:
					var itemdict = {}
					itemdict.item = array[randi()%array.size()]
					itemdict.grade = i.grade[randi()%i.grade.size()]
					if i.has('material_grade'):
						itemdict.locationmaterials = location.resources
						itemdict.material_grade = i.material_grade
					var item = generate_random_gear(itemdict)
					item = globals.CreateGearItemLoot(item.code, item.itemparts)

					dict.items.append(item)
					number -= 1
			'weapon':
				var number = round(rand_range(i.min, i.max))
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.type == 'gear' && k.itemtype in ['weapon'] && k.geartype != 'costume' && !k.tags.has('no_random'):
						array.append(k.code)
				while number > 0:
					var itemdict = {}
					itemdict.item = array[randi()%array.size()]
					itemdict.grade = i.grade[randi()%i.grade.size()]
					if i.has('material_grade'):
						itemdict.locationmaterials = location.resources
						itemdict.material_grade = i.material_grade
					var item = generate_random_gear(itemdict)
					item = globals.CreateGearItemLoot(item.code, item.itemparts)

					dict.items.append(item)
					number -= 1
			'armor':
				var number = round(rand_range(i.min, i.max))
				var array = []
				for k in Items.itemlist.values():
					if i.grade.has(k.tier) && k.type == 'gear' && k.itemtype in ['armor'] && k.geartype != 'costume' && !k.tags.has('no_random'):
						array.append(k.code)
				while number > 0:
					var itemdict = {}
					itemdict.item = array[randi()%array.size()]
					itemdict.grade = i.grade[randi()%i.grade.size()]
					if i.has('material_grade'):
						itemdict.locationmaterials = location.resources
						itemdict.material_grade = i.material_grade
					var item = generate_random_gear(itemdict)
					item = globals.CreateGearItemLoot(item.code, item.itemparts)

					dict.items.append(item)
					number -= 1
			'gold':
				var number = round(rand_range(i.min, i.max))
				dict.gold += number
	return dict

func generate_random_gear(dict):#
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

	return {code = itemtemplate.code, itemparts = itemparts}


#dungeons
var dungeon_template = { #sample dungeon data
		code = 'dungeon_bandit_den',
		type = 'dungeon',
		name = 'bandit_den',
		classname = '',
		descript = tr("DUNGEON_BANDIT_DEN_DESC"),
		character_data = {
			chance_mod = 1.5,#increases base chance to get slave after combat by this if its not guaranteed
			races = [['local', 3], ['common',1]]
		},
		difficulty = 'easy',
		background_pool = ['cave_1', 'cave_2', 'cave_3','cave_4','cave_5'],
		enemyarray = [["rats_easy", 0.5],['bandits_easy', 1],['bandits_easy2', 1],['bandits_easy3', 0.5]],
		final_enemy = [['bandits_easy_boss',1], ['bandits_easy_boss2',1],['bandits_easy_boss',3]], final_enemy_type = 'character', final_enemy_class = ['combat'],
		
		event_data = {
			dungeon_find_chest_easy = {
				limit = 0,
				weight = 10,
				floor_range = [0,0],
				icon = 'chest',
				events = ['dungeon_find_chest_easy'],
				possible_challenges = [], #list of future challenges to get to this room
			},
#			event_trap_easy = { #pointless with all other rooms being bonuses
#				limit = 0,
#				weight = 1,
#				floor_range = [0,0],
#				icon = 'chest',
#				events = ['event_trap_easy'],
#			},
			dungeon_find_armory_easy = {
				limit = 1,
				weight = 2,
				floor_range = [2,0],
				icon = 'chest',
				events = ['dungeon_find_armory_easy'],
				possible_challenges = [],
			},
			event_dungeon_prisoner = {
				limit = 1,
				weight = 5,
				floor_range = [0,0],
				icon = 'man',
				events = ['event_dungeon_prisoner'],
				possible_challenges = [],
			},
			celena_shrine_find = {
				limit = 1,
				weight = 8,
				floor_range = [0,0],
				icon = 'shrine',
				events = ['celena_shrine_find','erebus_shrine_find','freya_shrine_find'],
				possible_challenges = [],
			}
		},
		
		event_room_number = [3,4],
		material_room_number = [5,6],
		
		main_route_length = [6,7], #remember that first and last rooms in route are effectively empty 
		bonus_rooms = [2,3],
		levels = [3,3], 
		base_room_stamina_cost = [7,10], #random roll for every main/bonus rooms rounded
		
		
		#do not remove next ones - for they a used in generation
		resources = ['cloth','leather','iron','wood','clothsilk'],
		gatherable_resources = {
			wood = {
				amount = [25,40],
				weight = 10,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			stone = {
				amount = [25,40],
				weight = 6,
				gather_mod = [2,2.5],
				stamina = [5,10],
				},  
			iron = {
				amount = [15,25],
				weight = 2,
				gather_mod = [2,2.5],
				stamina = [5,10],
				}, 
			},
		bgm = "dungeon",
		purchase_price = 100,
		affiliation = 'local', #defines character races and events
		events = [],
	}

var level_template = {
	rooms = [],
	first_room = "",
	last_room = "",
	mainline = 0
}

var room_template = {
	status = 'hidden',
	col = 0,
	row = 0,
	type = 'empty',
	stamina_cost = 0,
	mainline = true,
	first_time = true,
	neighbours = {up = null, down = null, left = null, right = null},
	subrooms = [null, null, null, null]
}
var subroom_template = {
	stamina_cost = 0,
	type = 'empty',
	challenge = null
}
var dungeon_mainline = 0
var dungeon_full = 0


func build_room(packed_vertex, locdata = dungeon_template):
	var res = room_template.duplicate(true)
	var vertex = DungeonGen.unpack_vertex(packed_vertex)
	res.col = vertex[1]
	res.row = vertex[0]
	res.type = 'combat' #2add roll for enemy after making fixed enemy combats call 
	res.stamina_cost = locdata.base_room_stamina_cost
	if res.stamina_cost is Array:
		res.stamina_cost = globals.rng.randi_range(res.stamina_cost[0], res.stamina_cost[1])
	if DungeonGen.tuning[packed_vertex] > 0:
		res.mainline = false
	if packed_vertex == DungeonGen.pack_vertex(DungeonGen.diameter.front()):
		res.type = 'ladder_up'
		res.status = 'obscured'
		res.stamina_cost = 0
	elif packed_vertex == DungeonGen.pack_vertex(DungeonGen.diameter.back()):
		res.type = 'ladder_down'
		res.stamina_cost = 0
	else:
		globals.reset_roll_data()
		var enemygroup = input_handler.weightedrandom(locdata.enemies)
		res.enemy_code = enemygroup
		res.enemies = globals.makerandomgroup(Enemydata.enemygroups[enemygroup])
		res.rare = globals.char_roll_data.rare
#	#subrooms:
#		if globals.rng.randf() < variables.subroom_chance:
#			for i in range(4):
#				var tmp = subroom_template.duplicate()
#				tmp.stamina_cost = 15 #stub - should be set up differently for subroom types
#
#				#2add all variants
#				if false: #globals.rng.randf() < variables.dungeon_encounter_chance:
#					#onetime events are temporal solution and should be replaced with events and unique events when those events would be properly updated
#					tmp.type = 'onetime_event'
#					tmp.event = input_handler.weightedrandom(locdata.eventarray)
#				else:
#					tmp.type = 'resource'
#					#test version, not final
#					tmp.resource = input_handler.random_from_array(locdata.gatherable_resources.keys())
#					var data = locdata.gatherable_resources[tmp.resource]
#					tmp.amount = data.amount
#					if tmp.amount is Array:
#						tmp.amount = globals.rng.randi_range(tmp.amount[0], tmp.amount[1])
#					tmp.stamina_cost = data.stamina
#					if tmp.stamina_cost is Array:
#						tmp.stamina_cost = globals.rng.randi_range(tmp.stamina_cost[0], tmp.stamina_cost[1])
#				res.subrooms[i] = tmp
#				if globals.rng.randf() >= variables.additional_subroom_chance:
#					break
#				i += 1
#			res.subrooms.shuffle ()
	return res


func build_floor_first_pass(locdata, level):
	var generate_data = locdata.duplicate()
#	var generate_data = dungeon_template #temporal
	var res = level_template.duplicate(true)
	var nm = locdata.id + "L" + str(level)
	if !DungeonGen.generate(generate_data.duplicate(true)):
		print ('generation error')
		return
	
	res.mainline = DungeonGen.diameter.size()
	dungeon_mainline += DungeonGen.diameter.size()
	for room in range(DungeonGen.tuning.size()):
		if DungeonGen.tuning[room] > 50:
			continue
		var r_nm = nm + ("%4d" % room)
		var tmp = build_room(room, generate_data)
		if room == DungeonGen.pack_vertex(DungeonGen.diameter.front()):
			res.first_room = r_nm
			if level == 0:
				tmp.type = 'empty'
		if room == DungeonGen.pack_vertex(DungeonGen.diameter.back()):
			res.last_room = r_nm
			if level == (locdata.levels - 1):
				tmp.stamina_cost = locdata.base_room_stamina_cost
				if tmp.stamina_cost is Array:
					tmp.stamina_cost = globals.rng.randi_range(tmp.stamina_cost[0], tmp.stamina_cost[1])
				if locdata.has("final_enemy"):
					var bossenemy = input_handler.weightedrandom(locdata.final_enemy)
					if locdata.final_enemy_type == 'event':
						tmp.type = 'event'
						tmp.event = bossenemy
					else:
						tmp.type = 'combat_boss'
						globals.reset_roll_data()
						tmp.enemy_code = bossenemy
						tmp.enemies = globals.makerandomgroup(Enemydata.enemygroups[bossenemy])
						tmp.rare = globals.char_roll_data.rare
				else:
					tmp.type = 'combat'
					globals.reset_roll_data()
					var enemygroup = input_handler.weightedrandom(locdata.enemies)
					tmp.enemy_code = enemygroup
					tmp.enemies = globals.makerandomgroup(Enemydata.enemygroups[enemygroup])
					tmp.rare = globals.char_roll_data.rare
				
		if room == DungeonGen.pack_vertex(DungeonGen.diameter[-2]):
#			res.last_room = r_nm
			if level == (locdata.levels - 1):
				pass
			else:
				tmp.rare = false
				tmp.miniboss = true
		ResourceScripts.game_world.rooms[r_nm] = tmp
		res.rooms.push_back(r_nm)
	
	dungeon_full += res.rooms.size()
	
	for edge in DungeonGen.final_edges:
		var un_edge = DungeonGen.unpack_edge(edge)
		var tmp = DungeonGen.get_vertex(un_edge)
		var v1 = nm + ("%4d" % DungeonGen.pack_vertex(tmp[0]) )
		var v1_ = ResourceScripts.game_world.rooms[v1]
		var v2 = nm + ("%4d" % DungeonGen.pack_vertex(tmp[1]) )
		var v2_ = ResourceScripts.game_world.rooms[v2]
		match un_edge[0]:
			'h':
				v1_.neighbours.right = v2
				v2_.neighbours.left = v1
			'v':
				v1_.neighbours.down = v2
				v2_.neighbours.up = v1
	
	ResourceScripts.game_world.dungeons[nm] = res
	locdata.dungeon.push_back(nm)


func build_subrooms_pool(locdata):
	var pool = []
	var res = []
	for i in range(locdata.levels):
		res.push_back([])
	if locdata.event_room_number is Array:
		locdata.event_room_number = globals.rng.randi_range(locdata.event_room_number[0], locdata.event_room_number[1])
	for i in range(locdata.event_room_number):
		pool.push_back('event')
	if locdata.material_room_number is Array:
		locdata.material_room_number = globals.rng.randi_range(locdata.material_room_number[0], locdata.material_room_number[1])
	for i in range(locdata.material_room_number):
		pool.push_back('material')
	
	pool.shuffle()
	while pool.size() > locdata.levels:
		for i in range(locdata.levels):
			res[i].push_back(pool.back())
			pool.pop_back()
	while pool.size() <= locdata.levels:
		pool.push_back("")
	pool.shuffle()
	for i in range(locdata.levels):
		if pool.back() != "":
			res[i].push_back(pool.back())
		pool.pop_back()
	
	return res


func finalize_subrooms(locdata, subrooms, level):
	var d_data = ResourceScripts.game_world.dungeons[locdata.dungeon[level]]
	var s_data = subrooms[level]
	#assign_values
	while !s_data.empty():
		var tmp = input_handler.random_from_array(d_data.rooms)
		if tmp in [d_data.first_room, d_data.last_room]:
			continue
		var r_data = ResourceScripts.game_world.rooms[tmp]
		if r_data.subrooms.back() != null:
			continue
		for i in range(4):
			if r_data.subrooms[i] == null:
				r_data.subrooms[i] = s_data.back()
				s_data.pop_back()
				break
	
	#setup parameters
	for id in d_data.rooms:
		if id in [d_data.first_room, d_data.last_room]:
			continue
		var r_data = ResourceScripts.game_world.rooms[id]
		for i in range(4):
			if r_data.subrooms[i] == null:
				break
			var tmp = subroom_template.duplicate(true)
			match r_data.subrooms[i]:
				'event':
					tmp.type = 'event'
					var pool = []
					for event in locdata.event_data:
						var e_data = locdata.event_data[event]
						if e_data.floor_range[1] == 0:
							e_data.floor_range[1] = locdata.levels - 1
						if level < e_data.floor_range[0]:
							continue
						if level > e_data.floor_range[1]:
							continue
						pool.push_back([event, locdata.event_data[event].weight])
					var roll = input_handler.weightedrandom(pool)
					var e_data = locdata.event_data[roll]
					if e_data.events[0] is Array:
						tmp.event = input_handler.weightedrandom(e_data.events)
					else:
						tmp.event = input_handler.random_from_array(e_data.events)
					tmp.possible_challenges = e_data.possible_challenges.duplicate() #or roll 
					tmp.icon = e_data.icon
					e_data.limit -= 1
					if e_data.limit == 0:
						locdata.event_data.erase(roll)
#					e_data.possible_challenges = [{code = 'event_locked_door', weight = 1}]
					if !e_data.possible_challenges.empty():
						pool.clear()
						for ch in e_data.possible_challenges:
							pool.push_back([ch.code, ch.weight])
						tmp.challenge = input_handler.weightedrandom(pool)
						
				'material':
					tmp.type = 'resource'
					var pool = []
					for res in locdata.gatherable_resources:
						pool.push_back([res, locdata.gatherable_resources[res].weight])
					var roll = input_handler.weightedrandom(pool)
					var resdata = locdata.gatherable_resources[roll]
					tmp.resource = roll
					for arg in ['amount', 'stamina']:
						tmp[arg] = resdata[arg]
						if tmp[arg] is Array:
							tmp[arg] = globals.rng.randi_range(tmp[arg][0], tmp[arg][1])
					tmp.stamina_cost = tmp.stamina
			r_data.subrooms[i] = tmp
		r_data.subrooms.shuffle()
