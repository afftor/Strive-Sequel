extends Reference
#extends Node

#world
var areas = {}
var capitals = []
var area_order = []
var starting_area = 'Plains'
var location_links = {}
var factions = {}


var locationcounter = 0

var easter_egg_characters_generated = []
var easter_egg_characters_acquired = []

func _ready():
	input_handler.connect("EnemyKilled", self, "quest_kill_receiver")

func serialize():
	return inst2dict(self)

func make_world():
	ResourceScripts.world_gen.build_world()
	areas.plains.unlocked = true
	areas.forests.unlocked = true

func advance_day():
	for i in areas.values():
		update_guilds(i)
		if int(ResourceScripts.game_globals.date) % variables.shop_restock_days == 0:
			ResourceScripts.world_gen.update_area_shop(i)
			for k in i.locations.values():
				if k.has('shop'):
					ResourceScripts.world_gen.update_area_shop(k)
	update_locations()

func quest_kill_receiver(monstercode):
	for i in areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.state == 'taken':
					for cond in quest.requirements:
						if cond.code == 'kill_monsters' && cond.type == monstercode && cond.value > cond.curvalue:
							cond.curvalue += 1
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				for cond in quest.requirements:
					if cond.code == 'kill_monsters' && cond.type == monstercode && cond.value > cond.curvalue:
						cond.curvalue += 1

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
	
	if int(ResourceScripts.game_globals.date) % 7 == 0:
		for i in area.factions.values():
			for k in i.slaves:
				characters_pool.get_char_by_id(k).is_active = false
			i.slaves.clear()
			while i.slaves.size() < i.slavenumber:
				ResourceScripts.world_gen.make_slave_for_guild(i)
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
			location_links[location.id] = {area = area.code, category = 'questlocations'}

func find_location_from_req(req):
	var location = null
	if areas[req.area].questlocation.has(req.location):
		location = req.location
	return location

func fail_quest(quest):
	quest.state = 'failed'
	for i in quest.requirements:
		if i.code in ['complete_location','complete_dungeon']:
			input_handler.return_characters_from_location(i.location)
			areas[i.area].locations.erase(i.location)
			areas[i.area].questlocations.erase(i.location)
