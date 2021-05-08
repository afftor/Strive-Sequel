extends Reference
#extends Node

#world
var areas = {}
var capitals = []
var area_order = []
var starting_area = 'plains'
var mansion_location
var location_links = {}
var factions = {}


var locationcounter = 0

var easter_egg_characters_generated = []
var easter_egg_characters_acquired = []

func _ready():
	input_handler.connect("EnemyKilled", self, "quest_kill_receiver")

func serialize():
	return inst2dict(self)


func fix_serialization():
	for area in areas.values():
		for guild in area.factions.values():
			if guild.questsetting.total > globals.get_nquest_for_rep(guild.totalreputation):
				guild.questsetting.total = globals.get_nquest_for_rep(guild.totalreputation)
				print("questnumber fixed for %s - set to %d" % [guild.name, guild.questsetting.total])
			if guild.questsetting.total < guild.questsetting.easy + guild.questsetting.medium + guild.questsetting.hard:
#                guild.questsetting.total = guild.questsetting.easy + guild.questsetting.medium + guild.questsetting.hard
				guild.questsetting.easy = 1
				guild.questsetting.medium = 0
				guild.questsetting.hard = 0
				print("wrong questnumber for %s - counters resetted" % [guild.name])
			elif guild.questsetting.total > guild.questsetting.easy + guild.questsetting.medium + guild.questsetting.hard:
				print("wrong questnumber for %s - unallocated quests" % [guild.name])


func fix_import(data):
	if !data.has('factions'): return
	for area in areas.values():
		for guild in area.factions.values():
			if !data.factions.has(guild.code): continue
			var guilddata = data.factions[guild.code]
			var fulldata = data.areas[guilddata.area].factions[guilddata.code]
			if fulldata.has('reputation') : guild.reputation = fulldata.reputation
			if fulldata.has('totalreputation') : guild.reputation = fulldata.totalreputation


func make_world():
	ResourceScripts.world_gen.build_world()
	areas.plains.unlocked = true
	areas.forests.unlocked = true
	mansion_location = areas[starting_area].capital_code

func get_area_name(area_id):
	return areas[area_id].name

func get_default_area_name():
	return get_area_name(starting_area)


func advance_day():
	for i in areas.values():
		update_guilds(i)
		if int(ResourceScripts.game_globals.date) % variables.shop_restock_days == 0:
			ResourceScripts.world_gen.update_area_shop(i)
			for k in i.locations.values():
				if k.has('shop'):
					ResourceScripts.world_gen.update_area_shop(k)
	update_locations()

func quest_kill_receiver(enemycode):
	var enemydata = Enemydata.enemies[enemycode]
	for i in areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.state == 'taken':
					for cond in quest.requirements:
						if cond.code == 'kill_monsters' && enemydata.tags.has(cond.type) && cond.value > cond.curvalue:
							cond.curvalue += 1
							if cond.value == cond.curvalue:
								input_handler.SystemMessage(quest.name + ":" + "QUESTREQSCOMPLETE")
								input_handler.PlaySound("book")
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				for cond in quest.requirements:
					if cond.code == 'kill_monsters' && enemydata.tags.has(cond.type) && cond.value > cond.curvalue:
						cond.curvalue += 1
						if cond.value == cond.curvalue:
							input_handler.SystemMessage(quest.name + ":" + "QUESTREQSCOMPLETE")
							input_handler.PlaySound("book")

func update_locations():
	for i in ResourceScripts.game_world.areas.values():
		for j in i.locations.values():
			for k in j.events:
				j.events[k] -= 1

func update_guilds_old(area):
	#rebuild quests and slaves in guild
	for i in area.factions.values():
		for k in i.slaves:
			if randf() >= 0.7:
				characters_pool.get_char_by_id(k).is_active = false
				i.slaves.erase(k)
		while i.slaves.size() < i.slavenumber:
			ResourceScripts.world_gen.make_slave_for_guild(i)
	for faction in area.quests.factions:
		for quest in area.quests.factions[faction].values():
			if quest.state == 'taken':
				quest.time_limit -= 1
				if quest.time_limit < 0:
					fail_quest(quest)
			else:
				if randf() >= 0.7 || quest.state == 'complete':
					area.quests.factions[faction].erase(quest.id)
				ResourceScripts.world_gen.fill_faction_quests(faction, area.code)

func update_guilds(area):
	for faction in area.quests.factions:
		var cleararray = []
		for quest in area.quests.factions[faction].values():
			if quest.state == 'taken':
				quest.time_limit -= 1
				if quest.time_limit < 0:
					fail_quest(quest)
			else:
				if quest.state == 'complete' || int(ResourceScripts.game_globals.date) % 7 == 0:
					cleararray.append(quest.id)
					#area.quests.factions[faction].erase(quest.id)
		for i in cleararray:
			area.quests.factions[faction].erase(i)
	if int(ResourceScripts.game_globals.date) % variables.guild_slave_update_time == 0:
		for i in area.factions.values():
			for k in i.slaves:
				characters_pool.get_char_by_id(k).is_active = false
			i.slaves.clear()
			while i.slaves.size() < i.slavenumber:
				ResourceScripts.world_gen.make_slave_for_guild(i)
	
	if int(ResourceScripts.game_globals.date) % variables.guild_quest_update_time == 0:
		for faction in area.quests.factions:
			ResourceScripts.world_gen.fill_faction_quests(faction, area.code)

func take_quest(quest, area):
	quest.state = 'taken'
	for i in quest.requirements:
		if i.code in ['complete_dungeon', 'complete_location']:
			var location = ResourceScripts.world_gen.make_repeatable_quest_location(quest, area, i)
			area.questlocations[location.id] = location
			location.questid = quest.id
			i.location = location.id
			i.area = area.code
			i.completed = false
			location_links[location.id] = {area = area.code, category = 'questlocations'}


func find_location_from_req(req):
	var location = null
	if areas[req.area].questlocation.has(req.location):
		location = req.location
	return location


func get_area_capital(area):
	if !area.has('capital'):return null
	if area.capital.empty():return null
	return area.capital.keys()[0]


func find_location_by_data(data):
	var location = null
	var area = null
	if data.has('area'): 
		if areas.has(data.area): area = areas[data.area]
		else: 
			print("error - no area %s" % data.area)
			return null
		if area.has('capital'):
			location = get_area_capital(area)
		else: 
			print("error - no capital in area %s" % data.area)
			return null
	elif data.has('id'):
		location = data.id
		area = ResourceScripts.world_gen.get_area_from_location_code(location)
	elif data.has('code'):
		for id in location_links:
			location = id
			area = location_links[id].area
			if !areas[area][location_links[id].category].has(location): continue
			var loc_data = areas[area][location_links[id].category][location]
			if loc_data.code == data.code: break
	return {location = location, area = area}



func fail_quest(quest):
	quest.state = 'failed'
	for i in quest.requirements:
		if i.code in ['complete_location','complete_dungeon']: globals.remove_location(i.location)

func get_quest_by_id(id):
	for i in ResourceScripts.game_world.areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.id == id:
					return quest
		for quest in i.quests.global.values():
			if quest.id == id:
				return quest
