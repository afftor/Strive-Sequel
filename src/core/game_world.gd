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
	update_guilds_data()
	for i in areas.values():
		for j in i.locations.values():
			if j.type == 'dungeon' and !j.has('stamina'):
				j.stamina = 100
#	for area in areas.values():
#		for guild in area.factions.values():
#			if guild.questsetting.total > globals.get_nquest_for_rep(guild.totalreputation):
#				guild.questsetting.total = globals.get_nquest_for_rep(guild.totalreputation)
#				print("questnumber fixed for %s - set to %d" % [guild.name, guild.questsetting.total])
#			if guild.questsetting.total < guild.questsetting.easy + guild.questsetting.medium + guild.questsetting.hard:
##                guild.questsetting.total = guild.questsetting.easy + guild.questsetting.medium + guild.questsetting.hard
#				guild.questsetting.easy = 1
#				guild.questsetting.medium = 0
#				guild.questsetting.hard = 0
#				print("wrong questnumber for %s - counters resetted" % [guild.name])
#			elif guild.questsetting.total > guild.questsetting.easy + guild.questsetting.medium + guild.questsetting.hard:
#				print("wrong questnumber for %s - unallocated quests" % [guild.name])
	var tmp = ResourceScripts.world_gen.get_location_from_code('quest_cali_bandits_location')
	if tmp != null and tmp.type != 'dungeon': 
		tmp.type = 'dungeon'


func fix_import(data):
	if !data.has('factions'): return
	for area in areas.values():
		for guild in area.factions.values():
			if !data.factions.has(guild.code): continue
			var guilddata = data.factions[guild.code]
			var fulldata = data.areas[guilddata.area].factions[guilddata.code]
			if fulldata.has('reputation') : guild.reputation = fulldata.reputation
			if fulldata.has('totalreputation') : guild.reputation = fulldata.totalreputation


func update_guilds_data():
	for area in areas.values():
		if !area.has('factions') or area.factions.empty(): continue
		for guild in area.factions.values():
			if guild.has('slaves'):
				for id in guild.slaves.duplicate():
					var ch = characters_pool.get_char_by_id(id)
					if ch == null:
						guild.slaves.erase(id)
						continue
					if ch.is_players_character:
						guild.slaves.erase(id)
			if !guild.has('conditions'):
				guild.conditions = []
			if guild.has('hireable_characters'): continue
			guild.hireable_characters = []
			var tempcat = {code = 'type1'}
#			tempcat.tags = guild.tags.duplicate()
			tempcat.slavenumber = [guild.slavenumber, guild.slavenumber]
			tempcat.character_types = guild.chartype.duplicate()
			tempcat.character_bonuses = guild.charbonus.duplicate()
			tempcat.slave_races = guild.races.duplicate()
			tempcat.preference = guild.preferences.duplicate()
			tempcat.slavelevel = guild.slavelevel
			guild.hireable_characters.push_back(tempcat)


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
		if int(ResourceScripts.game_globals.date) % variables.shop_restock_days == 1 or variables.shop_restock_days == 1:
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
								input_handler.SystemMessage(quest.name + ":" + tr("QUESTREQSCOMPLETE"))
								input_handler.PlaySound("book")
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				for cond in quest.requirements:
					if cond.code == 'kill_monsters' && enemydata.tags.has(cond.type) && cond.value > cond.curvalue:
						cond.curvalue += 1
						if cond.value == cond.curvalue:
							input_handler.SystemMessage(quest.name + ":" + tr("QUESTREQSCOMPLETE"))
							input_handler.PlaySound("book")

func update_locations():
	for i in areas.values():
		for j in i.locations.values():
			for k in j.events:
				j.events[k] -= 1
			if j.type == 'dungeon':
				j.stamina = 100

func update_guilds_old(area):
	#rebuild quests and slaves in guild
	for i in area.factions.values():
		for k in i.slaves:
			if randf() >= 0.7:
				characters_pool.get_char_by_id(k).is_active = false
				i.slaves.erase(k)
		while i.slaves.size() < i.slavenumber:
			ResourceScripts.world_gen.make_slave_for_guild_old(i)
	for faction in area.quests.factions:
		for quest in area.quests.factions[faction].values():
			if quest.state == 'taken':
				quest.time_limit -= 1
				if quest.time_limit < 0:
					complete_quest(quest, "failed")
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
					complete_quest(quest, "failed")
					cleararray.append(quest.id)
			else:
				if quest.state == 'complete' or int(ResourceScripts.game_globals.date) % variables.guild_quest_update_time == 1 or variables.guild_quest_update_time == 1:
					cleararray.append(quest.id)
					#area.quests.factions[faction].erase(quest.id)
		for i in cleararray:
			area.quests.factions[faction].erase(i)
		ResourceScripts.world_gen.fill_faction_quests(faction, area.code)
	if int(ResourceScripts.game_globals.date) % variables.guild_slave_update_time == 1 or variables.guild_slave_update_time == 1:
		for i in area.factions.values():
			for k in i.slaves:
				characters_pool.get_char_by_id(k).is_active = false
			i.slaves.clear()
			ResourceScripts.world_gen.rebuild_guild_slaves(i)
#			while i.slaves.size() < i.slavenumber:
#				ResourceScripts.world_gen.make_slave_for_guild(i)
	
#	if int(ResourceScripts.game_globals.date) % variables.guild_quest_update_time == 1 or variables.guild_quest_update_time == 1:
#		for faction in area.quests.factions:
#			ResourceScripts.world_gen.fill_faction_quests(faction, area.code)


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
		if i.code == 'special_task':
			globals.common_effects(i.starteffect)


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
			area = area.code
		else:
			print("error - no capital in area %s" % data.area)
			return null
	elif data.has('id'):
		location = data.id
		area = ResourceScripts.world_gen.get_area_from_location_code(location).code
	elif data.has('code'):
		for id in location_links:
			var link_data = location_links[id]
			location = id
			area = link_data.area
			if !areas[area][link_data.category].has(location):
				continue
			var loc_data = areas[area][link_data.category][location]
			if link_data.category == 'capital' and data.code == id:
				break
			if !loc_data.has('code'): 
				continue
			if loc_data.code == data.code: 
				break
	return {location = location, area = area}


func get_worker_count_for_task(worktask):
	var loc = ResourceScripts.world_gen.get_location_from_code(worktask.task_location)
	if loc == null: return 0
	if worktask.product == 'recruiting':
		var task = tasks.tasklist[worktask.code]
		if task.has('base_workers'):
			return task.base_workers
		else:
			return -1
	if loc.type in ["dungeon",'encounter']:
		return -1 #loc.gather_limit_resources[worktask.code] 
	if loc.has("category") and loc.category == 'capital':
		var task = tasks.tasklist[worktask.code]
		if task.has('upgrade_code') && task.has('workers_per_upgrade') && task.has('base_workers'):
			var upgrade_level = ResourceScripts.game_res.findupgradelevel(task.upgrade_code)
			return task.base_workers + task.workers_per_upgrade * upgrade_level
		else:
			return -1
	return loc.gather_resources[worktask.product]


func complete_quest(quest, state = 'failed'):
	quest.state = state
	ResourceScripts.game_party.remove_quest_task(quest.id)
	for i in quest.requirements:
		if i.code in ['complete_location','complete_dungeon']:
			#maybe here should be difference (remove or unquest) between quest dungeons and encounters or complete_location and complete_dungeon - its up to you
			globals.unquest_location(i.location)

func get_quest_by_id(id):
	for i in areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.id == id:
					return quest
		for quest in i.quests.global.values():
			if quest.id == id:
				return quest
#	if scenedata.quests.has(id):
#		return scenedata.quests[id]
	return null


func is_area_unlocked(area):
	if !areas.has(area):
		return false
	var data = areas[area]
	return data.unlocked
