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

var dungeons = {}
var rooms = {}

var locationcounter = 0

var easter_egg_characters_generated = []
var easter_egg_characters_acquired = []

var dungeon_events_assigned = {}

var serial_quest_items#only for serialize

func _ready():
	input_handler.connect("EnemyKilled", self, "quest_kill_receiver")

func serialize():
	var res = inst2dict(self)
	for area_k in areas:
		var area_v = areas[area_k]
		for fac_k in area_v.quests.factions:
			var fac_v = area_v.quests.factions[fac_k]
			for quest_id in fac_v:
				var quest_v = fac_v[quest_id]
				if quest_v.rewards.has("items"):
					for item in quest_v.rewards.items:
						if !res.has("serial_quest_items") or res.serial_quest_items == null:
							res.serial_quest_items = []
						res.serial_quest_items.append({
							k_area = area_k,
							k_faction = fac_k,
							k_quest = quest_id,
							item = inst2dict(item)
						})
	return res


func fix_serialization():
	update_guilds_data()
	
	for dn in dungeons.values():
		dn.mainline = int(dn.mainline)
	
	for room in rooms.values():
		room.col = int(room.col)
		room.row = int(room.row)
		room.stamina_cost = int(room.stamina_cost)
		if room.has('enemies'):
			var tmp = {}
			for en in room.enemies:
				tmp[int(en)] = room.enemies[en]
			room.enemies = tmp
	
	for i in areas.values():
		for j in i.locations.values() + i.questlocations.values():
			if j.type == 'dungeon' and !j.has('stamina'):
				j.stamina = 100
			if j.has('stagedevents'):
				for cat in j.stagedevents:
					var tmp = {}
					for ev in j.stagedevents[cat]:
						tmp[int(ev)] = j.stagedevents[cat][ev]
					j.stagedevents[cat] = tmp
			if j.has('progress'):
				for cat in j.progress:
					j.progress[cat]  = int(j.progress[cat])
		#temporal patch. Probably need to check capital_options here for all areas
		if i.code == 'plains':
			for option in worlddata.lands.plains.capital_options:
				if !(option in i.capital_options):
					i.capital_options.append(option)
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
	fix_old_rep_quests_rewords()
	if serial_quest_items != null:
		for item_s in serial_quest_items:
			var items_list = areas[item_s.k_area].quests.factions[item_s.k_faction][item_s.k_quest].rewards.items
			if items_list[0] is String:
				items_list.clear()
			items_list.append(dict2inst(item_s.item))
	serial_quest_items = null
	
	var tmp = ResourceScripts.world_gen.get_location_from_code('quest_cali_bandits_location')
	if tmp != null and tmp.type != 'dungeon': 
		tmp.type = 'dungeon'
	if ResourceScripts.game_progress.get_active_quest("kuro_quest_3") != null && ResourceScripts.game_progress.get_active_quest("kuro_quest_3").stage == 'dungeon':
		tmp = ResourceScripts.world_gen.get_location_from_code('quest_dungeon_kuro3')
		if tmp.completed and !dungeon_events_assigned.has('kuro3_dungeon_1'):
			globals.common_effects([
				{code = "remove_quest_location", value = "quest_dungeon_kuro3"},
				{code = "make_quest_location", value = "quest_dungeon_kuro3"},
			])
	elif ResourceScripts.game_progress.completed_quests.has('kuro_quest_3'):
		tmp = ResourceScripts.world_gen.get_location_from_code('quest_dungeon_kuro3')
		if tmp != null:
			globals.common_effects([
				{code = "remove_quest_location", value = "quest_dungeon_kuro3"},
			])

#only for migration to new loot system's rewords in quests
#delete with time (22 oct 2025)
func fix_old_rep_quests_rewords():
	for area in areas.values():
		for fac in area.quests.factions.values():
			for quest in fac.values():
				fix_old_quests_rewords(quest)
func fix_old_quests_rewords(quest):
	if !quest.has('rewards') or (quest.rewards is Dictionary):#new loot system
		return
	var new_rewards = Items.get_loot().get_rewards_template()
	if !new_rewards.has('spec_rules'):
		new_rewards.spec_rules = []
	for i in quest.rewards:
		match i.code:
			'gold':
				if i.value is Array:
					new_rewards.spec_rules.append({
						rule = 'item_based_gold',
						mul = i.value[0]
					})
				else:
					new_rewards.gold = i.value
			'reputation':
				new_rewards.spec_rules.append({
					rule = 'reputation',
					value = i.value
				})
			'gear':
				new_rewards.items.append(globals.CreateGearItemQuest(i.item, i.itemparts, quest))
			'gear_static':
				new_rewards.items.append(globals.CreateGearItem(i.item, {}))
			'material':
				new_rewards.materials[i.item] = i.value
			'usable':
				new_rewards.items.append(globals.CreateUsableItem(i.item, i.value))
	quest.rewards = new_rewards
#----------------------------

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
		var tmp = []
		for k in i.locations.values() + i.questlocations.values():
			if k.has('active') and k.active == false:
				var f = true
				for ch in ResourceScripts.game_party.characters.values():
					if ch.check_location(k.id):
						f = false
						break
				if f:
					tmp.push_back(k.id)
		for id in tmp:
			remove_location(id)
		if int(ResourceScripts.game_globals.date) % variables.shop_restock_days == 1 or variables.shop_restock_days == 1:
			ResourceScripts.world_gen.update_area_shop(i)
			for k in i.locations.values():
				if k.has('shop'):
					ResourceScripts.world_gen.update_area_shop(k)
	update_locations()


func advance_hour():
	for i in areas.values():
		for j in i.locations.values() + i.questlocations.values() + i.capital.values():
			if j.has('stamina'):
				j.stamina += 25
				if j.stamina > 100:
					j.stamina = 100
			j.intimidate = false
			j.teleporter = false


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
		for j in i.locations.values() + i.questlocations.values():
			if j.has('events'):
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
			if !areas[link_data.area][link_data.category].has(id):
				continue
			var loc_data = areas[link_data.area][link_data.category][id]
			if link_data.category == 'capital' and data.code == id:
				location = id
				area = link_data.area
				break
			if !loc_data.has('code'): 
				continue
			if loc_data.code == data.code: 
				location = id
				area = link_data.area
				break
	if location == null || area == null:
		return null
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


func remove_dungeon(d_id):
	if !dungeons.has(d_id):
		return
	var data = dungeons[d_id]
	for r_id in data.rooms:
		rooms.erase(r_id)
	dungeons.erase(d_id)


func remove_location(loc_id):
	if !location_links.has(loc_id): 
		return
	if location_links[loc_id].category == 'capital':
		return
	var area_id = location_links[loc_id].area
	var area = areas[area_id]
	var location = area[location_links[loc_id].category][loc_id]
	if location.has('dungeon'):
		if dungeon_events_assigned.values().has(loc_id):
			for ev in dungeon_events_assigned.keys().duplicate():
				if dungeon_events_assigned[ev] == loc_id:
					dungeon_events_assigned.erase(ev)
		for d_id in location.dungeon:
			remove_dungeon(d_id)
	area[location_links[loc_id].category].erase(loc_id)
	location_links.erase(loc_id)


func can_enter_room(room_id):
	var data = rooms[room_id]
	if data.status == 'cleared' :
		 return true
	if data.type in ['ladder_up']:
		return true
#	if data.status == 'scouted' and data.type in ['ladder_down', 'ladder_down_survival']:
#		return true
	for i in data.neighbours.values():
		if i == null:
			continue
		var t_data = ResourceScripts.game_world.rooms[i]
		if t_data.status == 'cleared' :
		 return true
		if t_data.type in ['ladder_up']:
			return true
		if t_data.status == 'scouted' and t_data.type in ['ladder_down', 'ladder_down_survival'] and can_enter_room(i):
			return true
	return false


func setup_teleporter(loc_id):
	globals.start_fixed_event('dungeon_teleporter')
	var location = ResourceScripts.world_gen.get_location_from_code(loc_id)
	location.teleporter = true


func gather_res(loc_id, amount):
	var location = ResourceScripts.world_gen.get_location_from_code(loc_id)
	var data = {
		text = tr('RESOURCEGATHERED' + '\n'), 
		image = 'chest',
		tags = ['skill_report_event'], 
		options = []
	}
	match location.type:
		'settlement':
			var pool = []
			for id in location.gather_resources.keys():
				if ResourceScripts.game_progress.can_gather_item(id):
					pool.push_back(id)
			var res = input_handler.random_from_array(pool)
			var resdata = Items.materiallist[res]
			var gather_amount = int(amount / resdata.price)
			ResourceScripts.game_res.materials[res] += gather_amount
			data.text += "%s - %d" % [tr(resdata.name), gather_amount]
		'dungeon':
			var pool = []
			for id in location.gather_limit_resources.keys():
#				if ResourceScripts.game_progress.can_gather_item(id):
				pool.push_back(id)
			while amount > 0:
				if pool.empty():
					break
				var res = input_handler.random_from_array(pool)
				var resdata = Items.materiallist[res]
				var gather_amount = int(amount / resdata.price)
				if gather_amount >= location.gather_limit_resources[res]:
					gather_amount = location.gather_limit_resources[res]
					pool.erase(res)
				if gather_amount <= 0:
					pool.erase(res)
				else:
					data.text += "%s - %d\n" % [tr(resdata.name), gather_amount]
				location.gather_limit_resources[res] -= gather_amount
				ResourceScripts.game_res.materials[res] += gather_amount
				amount -= resdata.price * gather_amount
			gui_controller.exploration_dungeon.res_container.update()
	
	data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})
	input_handler.interactive_message_custom(data)
