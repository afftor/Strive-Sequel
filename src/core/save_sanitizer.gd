extends Reference
#Makes a save written with mods loaded readable again once those mods are gone.
#
#Two kinds of leftovers are fatal, and they fail in different ways:
#
#  scripts - a mod that extends a class through the CEScripts mechanism has its extension
#            compiled into res://tmp/modded_<key>.gd, and inst2dict() stamps that path into
#            every object of that class. With the mod gone the file is not there, dict2inst()
#            hands back null, and the load dies on the first character it reads - one bad
#            path takes the whole save with it. Every such path names a key of
#            ResourceScripts.scriptdict, so the slot is known even when the file is not: the
#            object is pointed at whatever script the game uses for that slot right now. That
#            is the base class with the mod gone, and the current extension with it still on.
#            Members the mod added are dropped for free - dict2inst() walks the script's own
#            members and ignores whatever else the dictionary carries.
#
#  data    - items, recipes and materials that came out of the mod's tables. These load fine
#            and blow up later, because every reader indexes those tables unguarded:
#            ItemClass.fix_gear() opens with Items.itemlist[itembase] and fails right there.
#            Nothing can describe them any more, so they are dropped along with the references
#            that would outlive them - equipment slots, craft orders, the shop's buyback list.
#
#Both passes run over the parsed save dictionary, before a single object is built from it.
#
#Pure data script: every table it needs arrives in the ctx argument built by
#globals._save_sanitizer_context(), so it stays out of the autoload preload chain. See the
#header of mansion_layout.gd for that rule.

#where modding_core.tmp_save_file() puts a mod's compiled script extension
const TMP_SCRIPT_DIR = "res://tmp/"
#modding_core.process_script_extensions_mods() renames the last extension for a slot to this
const MODDED_PREFIX = "modded_"
#items are the one serialized class the mod machinery cannot reach - no scriptdict key
const ITEM_CLASS_PATH = "res://src/classes/ItemClass.gd"

#character sub-objects, by the field CharacterClass.serialize() writes them to, to the
#ResourceScripts.scriptdict key that names the script behind them
const CHARACTER_MODULES = {
	statlist = 'ch_statlist',
	dyn_stats = 'ch_statlist_dynamic',
	xp_module = 'ch_leveling',
	equipment = 'ch_equipment',
	skills = 'ch_skills',
	travel = 'ch_travel',
	food = 'ch_food',
	training = 'ch_training',
	enthrall = 'ch_enthrall',
}


#Repairs savedict in place. Returns a report; empty_report(report) says whether anything was
#touched, describe(report) turns it into a line for the log.
static func sanitize(savedict, ctx):
	var report = {
		scripts = {},		#saved script path -> how many objects were repointed
		unresolved = {},	#saved script path -> how many objects still name it
		items = {},			#dropped item id -> what was missing about it
		orders = {},		#dropped craft order id -> the recipe it wanted
		buyback = {},		#dropped buyback record code -> how many
		stock = {},			#shop code taken off the shelves -> how many shops
		quests = {},		#dropped guild quest id -> what it asked for
		rewards = {},		#dropped quest reward item -> how many
		gear = 0,			#equipment slots emptied
		work = 0,			#workers taken off a dropped craft order
	}
	if !(savedict is Dictionary):
		return report
	_repair_scripts(savedict, ctx, report)
	_drop_unknown_items(savedict, ctx, report)
	_drop_unknown_orders(savedict, ctx, report)
	_drop_unknown_buyback(savedict, ctx, report)
	_clean_world(savedict, ctx, report)
	return report


static func is_clean(report):
	return (report.scripts.empty() and report.unresolved.empty() and report.items.empty()
		and report.orders.empty() and report.buyback.empty() and report.stock.empty()
		and report.quests.empty() and report.rewards.empty()
		and report.gear == 0 and report.work == 0)


static func describe(report):
	var parts = []
	if !report.scripts.empty():
		parts.push_back("%d modded classes repointed at base scripts %s" % [
			report.scripts.size(), str(report.scripts.keys())])
	if !report.items.empty():
		parts.push_back("%d items dropped %s" % [
			report.items.size(), str(_distinct(report.items.values()))])
	if report.gear > 0:
		parts.push_back("%d equipment slots emptied" % report.gear)
	if !report.orders.empty():
		parts.push_back("%d craft orders dropped %s" % [
			report.orders.size(), str(_distinct(report.orders.values()))])
	if report.work > 0:
		parts.push_back("%d workers released" % report.work)
	if !report.buyback.empty():
		parts.push_back("%d buyback records dropped" % report.buyback.size())
	if !report.stock.empty():
		parts.push_back("%d shop lines dropped %s" % [report.stock.size(), str(report.stock.keys())])
	if !report.quests.empty():
		parts.push_back("%d guild quests dropped %s" % [
			report.quests.size(), str(_distinct(report.quests.values()))])
	if !report.rewards.empty():
		parts.push_back("%d quest rewards dropped %s" % [
			report.rewards.size(), str(report.rewards.keys())])
	if !report.unresolved.empty():
		parts.push_back("STILL BROKEN: no script for %s" % str(report.unresolved.keys()))
	return PoolStringArray(parts).join("; ")


#The same tally without the id dumps, for the warning popup - the full lists go to the log.
#Plain English on purpose: this is a dev-build diagnostic, and nine new keys fed through % would
#each be a live defect in every locale that has not got them yet.
static func describe_short(report):
	var parts = []
	if !report.scripts.empty():
		parts.push_back("modded classes repointed at base scripts: %d" % report.scripts.size())
	if !report.items.empty():
		parts.push_back("items dropped: %d" % report.items.size())
	if report.gear > 0:
		parts.push_back("equipment slots emptied: %d" % report.gear)
	if !report.orders.empty():
		parts.push_back("craft orders dropped: %d" % report.orders.size())
	if report.work > 0:
		parts.push_back("workers released: %d" % report.work)
	if !report.buyback.empty():
		parts.push_back("buyback records dropped: %d" % report.buyback.size())
	if !report.stock.empty():
		parts.push_back("shop lines dropped: %d" % report.stock.size())
	if !report.quests.empty():
		parts.push_back("guild quests dropped: %d" % report.quests.size())
	if !report.rewards.empty():
		parts.push_back("quest rewards dropped: %d" % report.rewards.size())
	if !report.unresolved.empty():
		#no brackets - the popup is bbcode, and it would eat them as a tag
		parts.push_back("STILL BROKEN, no script for: " + PoolStringArray(report.unresolved.keys()).join(", "))
	return PoolStringArray(parts).join("\n")



#counts only what the player can see gone, for the message shown after the load
static func lost_count(report):
	return (report.items.size() + report.orders.size() + report.buyback.size()
		+ report.quests.size() + report.rewards.size())


static func _distinct(values):
	var seen = {}
	for value in values:
		seen[value] = true
	return seen.keys()


#--- scripts ---------------------------------------------------------------------------

static func _repair_scripts(savedict, ctx, report):
	#the general sweep catches instances wherever a mod stored them
	_walk(savedict, ctx, report, {})
	#and the slots the base game owns are then pinned by name, so a save that named its
	#character class something the sweep could not place still comes back
	for key in ctx.gamestate_keys:
		_pin(savedict.get(key), ctx.script_paths.get(key), report)
	_pin_characters(savedict.get('charpool'), ctx, report)
	var party = savedict.get('game_party')
	if party is Dictionary:
		_pin_characters(party.get('characters'), ctx, report)
		_pin_characters(party.get('babies'), ctx, report)
	var res = savedict.get('game_res')
	if res is Dictionary and res.get('items') is Dictionary:
		for item in res.items.values():
			_pin(item, ITEM_CLASS_PATH, report)


static func _pin_characters(holder, ctx, report):
	if !(holder is Dictionary):
		return
	for character in holder.values():
		_pin(character, ctx.script_paths.get('class_slave'), report)
		if !(character is Dictionary):
			continue
		for field in CHARACTER_MODULES:
			_pin(character.get(field), ctx.script_paths.get(CHARACTER_MODULES[field]), report)


static func _walk(node, ctx, report, cache):
	if node is Dictionary:
		if node.get('@path') is String:
			_repoint(node, ctx, report, cache)
		for value in node.values():
			_walk(value, ctx, report, cache)
	elif node is Array:
		for value in node:
			_walk(value, ctx, report, cache)


static func _repoint(node, ctx, report, cache):
	var saved = node['@path']
	if !cache.has(saved):
		cache[saved] = _resolve(saved, ctx)
	var fixed = cache[saved]
	if fixed == "":
		report.unresolved[saved] = report.unresolved.get(saved, 0) + 1
		return
	if fixed == saved:
		return
	node['@path'] = fixed
	node['@subpath'] = "" #whatever inner class the mod declared went with the file
	report.scripts[saved] = report.scripts.get(saved, 0) + 1


#"" when nothing in the game answers for this path, the path itself when it is already right
static func _resolve(path, ctx):
	#a res://tmp path is a mod extension by construction, and is retargeted whether or not the
	#file survived: a leftover compiled against an older build is worse than the base class
	if !path.begins_with(TMP_SCRIPT_DIR) and _script_exists(path):
		return path
	var key = _slot_for(path, ctx)
	if key == "":
		return ""
	return ctx.script_paths[key]


static func _slot_for(path, ctx):
	var name = path.get_file().get_basename()
	if name.begins_with(MODDED_PREFIX):
		name = name.substr(MODDED_PREFIX.length())
	if ctx.script_paths.has(name):
		return name
	#process_script_extend() also snapshots the class being extended under its own file name
	if ctx.script_files.has(name):
		return ctx.script_files[name]
	return ""


#last resort for a slot the base game owns: force the script the game uses for it
static func _pin(node, path, report):
	if !(node is Dictionary) or !(path is String) or path == "":
		return
	var saved = node.get('@path')
	if !(saved is String) or saved == path:
		return
	if !saved.begins_with(TMP_SCRIPT_DIR) and _script_exists(saved):
		return #a class the game can still read - a legitimate subclass is not ours to move
	node['@path'] = path
	node['@subpath'] = ""
	#the sweep counted this one as beyond help a moment ago; it no longer is
	if report.unresolved.has(saved):
		report.unresolved[saved] -= 1
		if report.unresolved[saved] <= 0:
			report.unresolved.erase(saved)
	report.scripts[saved] = report.scripts.get(saved, 0) + 1


static func _script_exists(path):
	if !(path is String) or path == "":
		return false
	#ResourceLoader, not File: an exported build ships .gdc and only the loader remaps to it
	return ResourceLoader.exists(path)


#--- data ------------------------------------------------------------------------------

static func _drop_unknown_items(savedict, ctx, report):
	var res = savedict.get('game_res')
	if !(res is Dictionary) or !(res.get('items') is Dictionary):
		return
	for id in res.items.keys():
		var missing = _item_defect(res.items[id], ctx)
		if missing == "":
			continue
		report.items[id] = missing
		res.items.erase(id)
	if report.items.empty():
		return
	for character in _characters(savedict):
		var equipment = character.get('equipment')
		if !(equipment is Dictionary):
			continue
		var gear = equipment.get('gear')
		if gear is Dictionary:
			for slot in gear:
				if report.items.has(gear[slot]):
					gear[slot] = null
					report.gear += 1
		if report.items.has(equipment.get('cast_weapon')):
			equipment['cast_weapon'] = null


#"" to keep the item, otherwise the name of whatever the game can no longer describe
static func _item_defect(item, ctx):
	if !(item is Dictionary):
		return ""
	var base = item.get('itembase')
	if !(base is String) or !ctx.itemlist.has(base):
		return str(base)
	#a material carries the stats, the price and the colour of everything made from it, and
	#every reader indexes materiallist directly, so gear made of one that is gone has to go
	for material in _materials_of(item):
		if !ctx.materiallist.has(material):
			return material
	#enchants and curses are decoration on an item that still stands, so only they are lost
	var enchants = item.get('enchants')
	if enchants is Dictionary:
		for enchant in enchants.keys():
			if !ctx.enchantments.has(enchant):
				enchants.erase(enchant)
	var curse = item.get('curse')
	if curse is String and !ctx.curses.has(curse):
		item['curse'] = null
		item['curse_known'] = false
	return ""


static func _materials_of(item):
	var res = []
	if item.get('materials') is Array:
		for material in item.materials:
			if material is String:
				res.push_back(material)
	if item.get('parts') is Dictionary:
		for material in item.parts.values():
			if material is String:
				res.push_back(material)
	return res


#Craft orders name a recipe, building orders an upgrade. game_res.fix_serialization() already
#sweeps the building queue; this is the other half of it, and it has to run before the items
#are built because add_recipe_task()'s readers index Items.recipes unguarded.
static func _drop_unknown_orders(savedict, ctx, report):
	var res = savedict.get('game_res')
	if !(res is Dictionary) or !(res.get('tasks_progresses') is Dictionary):
		return
	var progresses = res.tasks_progresses
	for id in progresses.keys():
		var task = progresses[id]
		if !(task is Dictionary) or task.get('type') != 'progress_item':
			continue
		if task.get('job') == 'building':
			continue #upgrades, and fix_serialization() has them
		var recipe = task.get('id')
		if recipe is String and ctx.recipes.has(recipe):
			continue
		report.orders[id] = str(recipe)
		progresses.erase(id)
		var job = task.get('job')
		if res.get('crafting_lists') is Dictionary and res.crafting_lists.get(job) is Array:
			res.crafting_lists[job].erase(id)
		if res.get('active_tasks') is Dictionary:
			for list in res.active_tasks.values():
				if list is Array:
					list.erase(id)
	if report.orders.empty():
		return
	for character in _characters(savedict):
		var xp_module = character.get('xp_module')
		if xp_module is Dictionary and report.orders.has(xp_module.get('work')):
			xp_module['work'] = ""
			report.work += 1


#What the shops will sell back this turn. Gear records carry a serialized item, usables and
#materials only a code - all three name a table the mod took with it.
static func _drop_unknown_buyback(savedict, ctx, report):
	var res = savedict.get('game_res')
	if !(res is Dictionary) or !(res.get('buyback') is Dictionary):
		return
	for shop in res.buyback.keys():
		var records = res.buyback[shop]
		if !(records is Array):
			continue
		for record in records.duplicate():
			if !(record is Dictionary):
				continue
			var code = record.get('code')
			var known = false
			if code is String:
				if record.get('kind') == 'material':
					known = ctx.materiallist.has(code)
				else:
					known = ctx.itemlist.has(code)
			if known:
				continue
			report.buyback[str(code)] = report.buyback.get(str(code), 0) + 1
			records.erase(record)
		if records.empty():
			res.buyback.erase(shop)


#The world keeps three lists that name items the player does not own yet: what the shops have
#in stock, what the guilds are asking for, and what they are paying with.
static func _clean_world(savedict, ctx, report):
	var world = savedict.get('game_world')
	if !(world is Dictionary):
		return
	_drop_unknown_rewards(world, ctx, report)
	if !(world.get('areas') is Dictionary):
		return
	for area in world.areas.values():
		if !(area is Dictionary):
			continue
		_sweep_shop(area.get('shop'), ctx, report)
		for field in ['locations', 'questlocations']:
			if !(area.get(field) is Dictionary):
				continue
			for location in area[field].values():
				if location is Dictionary:
					_sweep_shop(location.get('shop'), ctx, report)
		_drop_unknown_quests(area, ctx, report)


#stock is keyed by what is being sold - an item base for gear and usables, a material otherwise
static func _sweep_shop(shop, ctx, report):
	if !(shop is Dictionary):
		return
	for code in shop.keys():
		if !(code is String) or ctx.itemlist.has(code) or ctx.materiallist.has(code):
			continue
		report.stock[code] = report.stock.get(code, 0) + 1
		shop.erase(code)


#A guild quest that wants an item nobody can make any more can never be handed in, and the
#journal draws its requirement straight out of Items.itemlist, so it takes the panel with it.
static func _drop_unknown_quests(area, ctx, report):
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
		for quest_id in list.keys():
			var missing = _quest_defect(list[quest_id], ctx)
			if missing == "":
				continue
			report.quests[quest_id] = missing
			list.erase(quest_id)


static func _quest_defect(quest, ctx):
	if !(quest is Dictionary) or !(quest.get('requirements') is Array):
		return ""
	for requirement in quest.requirements:
		if !(requirement is Dictionary):
			continue
		#the generator resolves the template's list of candidates down to one name before it
		#writes the quest, so anything that is not a plain name is somebody else's business
		var wanted = requirement.get('type')
		if wanted is String:
			if requirement.get('code') == 'random_item' and !ctx.itemlist.has(wanted):
				return wanted
			if requirement.get('code') == 'random_material' and !ctx.materiallist.has(wanted):
				return wanted
		if requirement.get('parts') is Dictionary:
			for material in requirement.parts.values():
				if material is String and !ctx.materiallist.has(material):
					return material
	return ""


#Reward items ride beside the world in serial_quest_items, because game_world.serialize()
#cannot write them where they live. Dropping the entry is enough to take the quest with it:
#the quest's own rewards.items still holds the stringified object the serializer left behind,
#and game_world.fix_broken_item_links() removes any quest still carrying one of those.
static func _drop_unknown_rewards(world, ctx, report):
	if !(world.get('serial_quest_items') is Array):
		return
	for entry in world.serial_quest_items.duplicate():
		if !(entry is Dictionary) or !(entry.get('item') is Dictionary):
			continue
		var missing = _item_defect(entry.item, ctx)
		if missing == "":
			continue
		report.rewards[missing] = report.rewards.get(missing, 0) + 1
		world.serial_quest_items.erase(entry)


#every character dictionary in the save, wherever it is kept
static func _characters(savedict):
	var res = []
	for holder in [savedict.get('charpool')]:
		if holder is Dictionary:
			res += holder.values()
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
