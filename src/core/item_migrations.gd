extends Reference
#Rewrites a parsed save for item bases the game has folded into others (Items.retired_itembases):
#the axe and the pickaxe became the Axe&Pick, and the pickaxe's gear slot went to dishware.
#
#It runs over the dictionary before a single object is built from it, and in every build - unlike
#save_sanitizer.gd, which only clears out what a missing mod left behind. A retired base is a real
#item the player owns, and every reader indexes Items.itemlist with it unguarded: fix_gear() is the
#first, and the sanitizer would drop the item as unknown before that. The items keep their own
#stats here; ItemClass.sync_tool_template() fits them to their new template once they are built.
#
#Pure data script, like the sanitizer: the rename table arrives as an argument, so it stays out of
#the autoload preload chain.

#a retired gear slot -> the slot that took over its tool
const RETIRED_GEAR_SLOTS = {tool_pickaxe = 'tool_axe'}


static func run(savedict, retired):
	if !(savedict is Dictionary) or !(retired is Dictionary) or retired.empty():
		return
	var res = savedict.get('game_res')
	if res is Dictionary:
		for field in ['items', 'workshop_items']:
			if res.get(field) is Dictionary:
				for item in res[field].values():
					_rename_item(item, retired)
		_fold_gear_slots(savedict, res)
		_rename_orders(res, retired)
		_rename_buyback(res, retired)
	var world = savedict.get('game_world')
	if world is Dictionary:
		if world.get('serial_quest_items') is Array:
			for entry in world.serial_quest_items:
				if entry is Dictionary:
					_rename_item(entry.get('item'), retired)
		if world.get('areas') is Dictionary:
			for area in world.areas.values():
				_rename_area(area, retired)
	var progress = savedict.get('game_progress')
	if progress is Dictionary and progress.get('arena') is Dictionary:
		var reward = progress.arena.get('next_reward')
		if reward is Dictionary and reward.get('items') is Array:
			for item in reward.items:
				_rename_item(item, retired)


static func _rename_item(item, retired):
	if !(item is Dictionary):
		return
	var base = item.get('itembase')
	if base is String and retired.has(base):
		item['itembase'] = retired[base]


#Two tools can fold into one slot - a worker carrying both an axe and a pickaxe. The one already in
#the surviving slot stays; the other goes back to the inventory, which on a save means only that it
#is nobody's any more. CharacterClass.fix_serialization() then finds the retired slot empty.
static func _fold_gear_slots(savedict, res):
	var items = res.get('items')
	for character in _characters(savedict):
		var equipment = character.get('equipment')
		if !(equipment is Dictionary) or !(equipment.get('gear') is Dictionary):
			continue
		var gear = equipment.gear
		for old_slot in RETIRED_GEAR_SLOTS:
			if !gear.has(old_slot):
				continue
			var item_id = gear[old_slot]
			gear.erase(old_slot)
			if item_id == null:
				continue
			var new_slot = RETIRED_GEAR_SLOTS[old_slot]
			if gear.get(new_slot) == null:
				gear[new_slot] = item_id
			elif items is Dictionary and items.get(item_id) is Dictionary:
				items[item_id]['owner'] = null


#A craft order is keyed by the recipe it makes; the recipes went with the items.
static func _rename_orders(res, retired):
	if !(res.get('tasks_progresses') is Dictionary):
		return
	for task in res.tasks_progresses.values():
		if !(task is Dictionary) or task.get('type') != 'progress_item':
			continue
		var recipe = task.get('id')
		if recipe is String and retired.has(recipe):
			task['id'] = retired[recipe]


#Gear records carry the serialized piece as well as its code.
static func _rename_buyback(res, retired):
	if !(res.get('buyback') is Dictionary):
		return
	for records in res.buyback.values():
		if !(records is Array):
			continue
		for record in records:
			if !(record is Dictionary):
				continue
			var code = record.get('code')
			if code is String and retired.has(code):
				record['code'] = retired[code]
			_rename_item(record.get('data'), retired)


static func _rename_area(area, retired):
	if !(area is Dictionary):
		return
	_rename_shop(area.get('shop'), retired)
	for field in ['locations', 'questlocations']:
		if !(area.get(field) is Dictionary):
			continue
		for location in area[field].values():
			if location is Dictionary:
				_rename_shop(location.get('shop'), retired)
	var quests = area.get('quests')
	if !(quests is Dictionary):
		return
	var lists = []
	if quests.get('factions') is Dictionary:
		lists += quests.factions.values()
	if quests.get('global') is Dictionary:
		lists.push_back(quests.global)
	for list in lists:
		if !(list is Dictionary):
			continue
		for quest in list.values():
			if !(quest is Dictionary) or !(quest.get('requirements') is Array):
				continue
			for requirement in quest.requirements:
				if !(requirement is Dictionary) or requirement.get('code') != 'random_item':
					continue
				var wanted = requirement.get('type')
				if wanted is String and retired.has(wanted):
					requirement['type'] = retired[wanted]


#Stock is keyed by what is sold: a count for usables, a list of part sets for modular gear. Two
#retired bases can land on the same new one, so they merge the way loot.merge_shop_dict() does.
static func _rename_shop(shop, retired):
	if !(shop is Dictionary):
		return
	for code in shop.keys():
		if !(code is String) or !retired.has(code):
			continue
		var stock = shop[code]
		shop.erase(code)
		var new_code = retired[code]
		if !shop.has(new_code):
			shop[new_code] = stock
		elif shop[new_code] is Array and stock is Array:
			shop[new_code].append_array(stock)
		elif !(shop[new_code] is Array) and !(stock is Array):
			shop[new_code] += stock


#every character dictionary in the save, wherever it is kept
static func _characters(savedict):
	var res = []
	if savedict.get('charpool') is Dictionary:
		res += savedict.charpool.values()
	var party = savedict.get('game_party')
	if party is Dictionary:
		for field in ['characters', 'babies']:
			if party.get(field) is Dictionary:
				res += party[field].values()
	var clean = []
	for character in res:
		if character is Dictionary:
			clean.push_back(character)
	return clean
