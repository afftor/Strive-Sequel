extends Reference
#extends Node

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const Migrations = preload("res://src/core/mansion_migrations.gd")
#for naming a finished room in the activity log - plain data scripts, no autoloads, so they
#are safe to sit in this file's preload chain
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const RoomUpgrades = preload("res://assets/data/mansion_room_upgrades.gd")

var itemcounter = 0
var money = 0 setget set_money
var upgrades = {}
#spatial mansion floorplan used by gui_modules/mansion_view, built lazily by
#ensure_mansion_layout(). Plain dictionary, so serialize() carries it for free.
var mansion_layout = {}
var selected_upgrade = {code = '', level = 0}#not sure
var items = {}
var materials = {} setget materials_set
var oldmaterials = {}
var tax = 0
#goods sold to shops, kept until the next turn so the player can undo a sale
#{shop_key: [{kind, code, amount, price, data}]} - kind is material/usable/gear
var buyback = {}

#new tasks system
var crafting_lists = {alchemy_material = [], alchemy_item = [], smith_material = [], smith_item = [], cooking_material = [], cooking_item = [], tailor_material = [], tailor_item = [], building = []}
var tasks_progresses = {}
var active_tasks = {
	gathering = [],
	farming = ['farming'],
	craft_materials = ['crafting'],
	craft_items = ['crafting'],
	recruiting = [],
	special = [],
	service = ['service'],
}
#progress statuses:
#temporal - for task with currently no workers
#init - await payment
#active - self-explainong
#stopped - cap reached, after recheck should be changed to init
#no_resources - cost unpayable
#completed - self-explained
#permanent - for unlimited tasks with unconditional lificircle, can't be used in craft


func _init():
	for i in upgradedata.upgradelist.keys():
		upgrades[i] = 0
	for i in Items.materiallist:
		materials[i] = 0


func fix_serialization():
	if !(buyback is Dictionary): #older saves have no buyback data at all
		buyback = {}
	var clear_array = []
	for i in items:
		if items[i].itembase == 'sensetivity_pot':
			clear_array.append(i)
			continue
		if items[i].amount <= 0:
			clear_array.append(i)
			continue
		items[i] = dict2inst(items[i])
		if items[i].type == 'gear':
			items[i].fix_gear()
	for i in clear_array:
		items.erase(i)
	clear_array.clear()
	for i in materials:
		if !Items.materiallist.has(i):
			clear_array.push_back(i)
	for i in clear_array:
		materials.erase(i)
	oldmaterials = materials.duplicate()
	#A save from before the tree was retired can have one of its upgrades queued for building.
	#Nothing can describe it any more - the readers index upgradelist to draw its icon and
	#name - so the queue is swept before anybody asks.
	if crafting_lists.has('building'):
		for i in crafting_lists.building.duplicate():
			if !upgradedata.upgradelist.has(i):
				crafting_lists.building.erase(i)
				if tasks_progresses.has(i):
					tasks_progresses.erase(i)
	for i in upgrades.keys().duplicate():
		#LEGACY_UPGRADES are gone from the tree but still owed to the player; they are handed
		#to the rooms that replaced them further down, by ensure_mansion_layout()
		if !upgradedata.upgradelist.has(i) and !LEGACY_UPGRADES.has(i):
			upgrades.erase(i)
	for i in upgradedata.upgradelist.keys():
		if !upgrades.has(i):
			upgrades[i] = 0
	fix_tax()
	
	for item in Items.materiallist:
		if !ResourceScripts.game_res.materials.keys().has(item):
			ResourceScripts.game_res.materials[item] = 0
			print_debug("Added res on load: " + item)
	fix_food_task_limits()
	ensure_mansion_layout()
#	fix_items_inventory(false)


#Creates the mansion floorplan on first use and repairs one loaded from a save.
#Idempotent - the mansion view calls it on open, fix_serialization() calls it on load.
func ensure_mansion_layout(force = false):
	if force or !(mansion_layout is Dictionary) or mansion_layout.empty():
		mansion_layout = MansionLayout.build_default()
	else:
		MansionLayout.validate(mansion_layout, ResourceScripts.game_party.characters)
	Migrations.run(self)
	autohouse_household()
	sync_room_tasks()


#Upgrade codes retired from the tree whose saved levels are still owed to the player. They
#have to survive the unknown-key sweep in fix_serialization(), which runs long before the
#converters below - without this the key was erased first and the conversion found nothing,
#which is exactly what had been happening to 'rooms' since it was retired.
const LEGACY_UPGRADES = ['rooms', 'master_bedroom',
	'resting', 'tailor', 'forge', 'alchemy', 'academy',
	'resource_gather_fish', 'resource_gather_meat', 'resource_gather_veges',
	'resource_gather_grain', 'resource_gather_wood', 'resource_gather_stone',
	'resource_gather_cloth', 'resource_gather_cloth_silk', 'resource_gather_wood_magic',
	'resource_gather_wood_iron', 'resource_gather_iron', 'resource_gather_mithril',
	'resource_gather_obsidian']


#Three buildings on the grounds so test mode has something to look at out there.
#Raises plain bedrooms, free and already standing, until the mansion sleeps at least this
#many. The one way rooms appear without a builder having put them up, so the three callers
#that are allowed to do it - the old-save conversion, the starting bonus, test mode - all
#come through here and are countable.
#
#New beds are seated straight away: the point of handing them out is that nobody is left
#standing, and the end of the turn asks that question of the layout rather than of the cap.
func house_at_least(people):
	MansionLayout.build_bedrooms_up_to(mansion_layout, people)
	autohouse_household()


#The same thing counted in rooms rather than in beds, which is what test mode wants: a mansion
#with a few bedrooms standing in it, not one filled to a population number.


#The same thing counted in rooms rather than in beds, which is what test mode wants: a mansion
#with a few bedrooms standing in it, not one filled to a population number.
func bedrooms_at_least(count):
	while MansionLayout.count_rooms_of_type(mansion_layout, 'bedrooms') < count:
		var before = MansionLayout.total_sleep_capacity(mansion_layout)
		MansionLayout.build_bedrooms_up_to(mansion_layout, before + 1)
		if MansionLayout.total_sleep_capacity(mansion_layout) <= before:
			break #nowhere left to put one
	autohouse_household()


#The master's room with everything it can have already built. Test mode wants rooms with
#something in them to look at rather than rooms to pay for first - the same reason
#bedrooms_at_least() is here. Both test modes call it: the mansion's own and the standalone
#plan screen, which is why it lives here rather than in either of them.
#A couple of buildings standing on the grounds, so test mode has estate work to look at at
#all - without one the gathering jobs have nowhere to stand and are not offered. The same
#reasoning as max_out_master_room(): test mode is for looking at rooms, not paying for them.

func build_test_grounds():
	var grounds = MansionLayout.grounds_floor(mansion_layout)
	if grounds < 0:
		return []
	var built = []
	var floor_data = MansionLayout.get_floor(mansion_layout, grounds)
	#Two farms rather than one: every farm feeds the same job and what it makes is chosen per
	#person, so a second one is the only way to see that they share a roster and their places
	#are counted together.
	var wanted = ['fishing_hut', 'forestry', 'mine', 'farm', 'farm']
	for slot_code in floor_data.slots:
		if built.size() >= wanted.size():
			break
		if MansionLayout.build_room(mansion_layout, grounds, slot_code, wanted[built.size()]):
			built.append(wanted[built.size()])
	#one farm at its best and one as raised, so the places on offer are not all the same number
	var farm = MansionLayout.first_room_of_type(mansion_layout, 'farm')
	if farm != null:
		MansionLayout.max_out_upgrades(farm)
	sync_room_tasks()
	return built


func max_out_master_room():
	var entry = MansionLayout.master_room(mansion_layout)
	if entry == null:
		return false
	return MansionLayout.max_out_upgrades(entry.room)


#One more bed than the mansion has. The starting bonus that used to hand out a level of the
#'rooms' upgrade hands out the room it was standing in for instead.
func build_starting_bedroom():
	house_at_least(MansionLayout.total_sleep_capacity(mansion_layout) + 1)


#Seats anyone who has no bed but could have one. Called on load and whenever somebody
#joins, so the player is never made to place an arrival by hand before the turn will end.
func autohouse_household():
	var masters = {}
	var consenting = {}
	for char_id in ResourceScripts.game_party.characters:
		var person = ResourceScripts.game_party.characters[char_id]
		#Loading a save reaches here before the household exists. globals.LoadGame runs
		#game_res.fix_serialization() first and game_party.fix_serialization() after it, so at
		#this point the party is still the dictionaries it was saved as - and a dictionary has
		#no bed to be given, nor an is_master() to be asked. The party runs this again from its
		#own fix_serialization_postload(), once everybody is a character.
		if !(person is Object) or !person.has_method('is_master'):
			return 0
		if person.is_master():
			masters[char_id] = true
		if shares_master_bed(person):
			consenting[char_id] = true
	var seated = MansionLayout.autohouse_all(mansion_layout,
		ResourceScripts.game_party.characters, masters, consenting)
	if seated > 0:
		rooms_changed()
	return seated


func autohouse_character(person):
	if person == null:
		return false
	return MansionLayout.autohouse(mansion_layout, person.id, person.is_master(),
		null, shares_master_bed(person))


#A bathhouse does what the old Bath upgrade did. Both answers funnel through here so a
#reader never has to know which of the two the household actually has.
func has_bath():
	#The old 'resting' upgrade is retired; a save that had bought it is handed a bathhouse by
	#convert_room_tree_upgrades(), so there is one answer to this question again.
	return MansionLayout.count_rooms_of_type(mansion_layout, 'bathhouse') > 0


#How many people fit into one scene: two, plus whatever the master bedroom has been
#furnished up to. The global 'master_bedroom' upgrade used to add a second, independent term
#here, which put the ceiling at eight and made Furnishing's own levels unreadable - it is
#gone, and convert_master_bedroom_upgrade() hands its levels to Furnishing instead.
func get_sex_limit():
	return 2 + MansionLayout.effect_of_type(mansion_layout, 'master_bedroom', 'sex_slots')


#Who has no bed. Blocks the end of the turn, and drives the warning on the mansion
#screen. Counts characters wherever they are in the world - being away is not an excuse
#for not having a room.
func unhoused_characters():
	return MansionLayout.unhoused_characters(mansion_layout, ResourceScripts.game_party.characters)


#What a room grants is read through effect conditions, and those are answered off a cached
#rebuild of the character's dynamic stats. Nothing in the mansion screen invalidated that
#cache, so a room raised this turn only started counting whenever something else happened to
#dirty the cache - which could be never. Every change to what stands on the plan goes through
#here afterwards.
func rooms_changed():
	for char_id in ResourceScripts.game_party.characters:
		var person = ResourceScripts.game_party.characters[char_id]
		if person is Object and person.has_method('reset_rebuild'):
			person.reset_rebuild()


#May this character be put in the master's bed? Slaves are not asked - the same distinction
#is_worker() draws (CharacterClass.gd:1277). Anyone else has to have agreed to that sort of
#thing, which is the 'sexservice' permission the negotiation minigame grants.
func shares_master_bed(person):
	if person == null or !(person is Object):
		return false
	if person.is_master():
		return true
	if person.training.is_slave():
		return true
	return person.has_status('sexservice')


#How far a given room type has been improved along a given upgrade, or 0 when the estate has
#no such room. Every type that uses this is unique, so there is one answer.
#What THIS building has been improved to. Gathering is local: a mine yields what that mine has
#been dug out to yield, and the loot table asks about the building the job is worked out of.
#
#That building is found by type because every one of them is unique - one mine, one forestry,
#one garden. It has to stay that way while the loot tables ask this question: a job belongs to
#the estate rather than to a building (its identity is location + material, see
#game_res.check_location_job), so with two mines a roll would have no way of knowing which one
#it came out of. run_grounds_checks() holds that requirement.
func room_upgrade_level(room_type, upgrade_code):
	var room = gather_room(room_type, rolling_room_slot)
	if room == null:
		return 0
	return MansionLayout.upgrade_level(room, upgrade_code)


#Which building's batch is being rolled right now, as a plot code, or '' outside a roll.
#Only roll_gathering() writes it.
var rolling_room_slot = ''


#One batch out of one building. A loot table's branches ask what that building has been dug
#out or planted up to - "the mine also yields iron" is a fact about the mine that produced
#this ore, not about mines - and the roll is the only moment that knows which building the
#batch came from. The table is read through globals.checkreqs(), which takes no arguments, so
#the answer is left where the condition can find it and taken away again immediately.
#
#Every roll of a gathering table goes through here, so what the game does and what a check
#can do are the same call rather than two arrangements that have to be kept in step.
func roll_gathering(tprogress, record, batches):
	rolling_room_slot = str(tprogress.get('room_slot', ''))
	var produced = Items.get_loot().roll_production(record, batches)
	rolling_room_slot = ''
	return produced


#### what the estate can keep ####

#Every delivery of a material comes through here. What the store rooms cannot hold does not
#arrive: it is sold if there is a clerk at a desk to sell it, and tipped away if there is not.
#
#Equipment, gold and everything that is not a material are untouched - only game_res.materials
#is capped, which is what the store room is for.
#
#Returns how much actually landed, so a caller that reports a haul reports the truth.
func gain_material(res, amount):
	if amount <= 0:
		return 0
	if !materials.has(res):
		#materials is seeded from Items.materiallist, so this is a caller with a bad key -
		#worth saying out loud rather than swallowing the delivery
		print_debug("gain_material: no such material '%s'" % str(res))
		return 0
	var limit = MansionLayout.total_storage(mansion_layout)
	var room_for = max(0, limit - materials[res])
	var kept = min(amount, room_for)
	materials[res] += kept
	var spilled = amount - kept
	if spilled <= 0:
		return kept
	if has_accountant():
		money += int(round(spilled * material_price(res)))
	return kept


#Is somebody actually sitting at a store room's desk? The upgrade alone is a desk with nobody
#at it, and an empty desk sells nothing.
func has_accountant():
	for entry in MansionLayout.each_room(mansion_layout):
		if !RoomTypes.has_tag(entry.room.type, 'storage'):
			continue
		if entry.room.task_id == null or !tasks_progresses.has(entry.room.task_id):
			continue
		if !tasks_progresses[entry.room.task_id].workers.empty():
			return true
	return false


func material_price(res):
	if !Items.materiallist.has(res):
		return 0
	return Items.materiallist[res].get('price', 0)


#Places this building offers, or 0 when the estate has not raised it. Reads the work slots
#directly rather than through work_capacity(), which answers 0 for anything without a craft
#discipline - and these buildings deliberately have none: their people go on the gathering job
#the estate already had, not on a task of the room's own.
#Places at one building. Named by its plot when there is one - two mines have their own hands
#- and falling back to whichever is found when no plot is named, which is what a save written
#before buildings had jobs of their own says.
func gather_places(room_type, slot = ''):
	var room = gather_room(room_type, slot)
	if room == null:
		return 0
	return MansionLayout.slot_capacity(room, 'work')


func gather_room(room_type, slot = ''):
	if slot != '':
		var grounds = MansionLayout.grounds_floor(mansion_layout)
		if grounds >= 0:
			var room = MansionLayout.get_room(
				MansionLayout.get_floor(mansion_layout, grounds), slot)
			if room != null and room.type == room_type:
				return room
	return MansionLayout.first_room_of_type(mansion_layout, room_type)


#How many people share the master's bed besides the master. Nobody's own effect conditions
#can answer this - "how many others are in the room I am in" is a question about the room,
#not about the character - so the master's regen bonus is built from here instead, the way
#the bathhouse's is. Zero when there is no such room or nobody in it but him.
func master_bed_partners():
	var entry = MansionLayout.master_room(mansion_layout)
	if entry == null:
		return 0
	var res = 0
	for char_id in entry.room.occupants:
		var person = ResourceScripts.game_party.characters.get(char_id, null)
		if person is Object and person.has_method('is_master') and !person.is_master():
			res += 1
	return res


#True while the estate has a room carrying this tag standing anywhere on the plan. The
#counterpart to character_room_has_tag(): that one asks where somebody sleeps, this one asks
#whether the building has the thing at all - which is what a room like the office grants by
#simply existing. has_bath() is the same question asked about one particular room.
func has_room_with_tag(tag):
	for entry in MansionLayout.each_room(mansion_layout):
		if RoomTypes.has_tag(entry.room.type, tag):
			return true
	return false


#Does where this character sleeps match what they have come to expect? What they expect of a
#bed is exactly what they expect of a meal - the same fame and the same value decide both, so
#there is no second roll and no second stat to keep. Only 'refined' and above ask for
#anything, and what they ask for is a private room or the master's own bed.
#
#Slaves are not asked, the same exemption ch_food.ignores_demand() makes: they sleep where
#they are put.
#
#Reads the stored tier rather than get_demand(), deliberately. get_demand() recomputes from
#'price', which ch_food's own comment calls far too expensive to do for every character every
#turn - and this is asked on every rebuild of every character's stats. Worse, 'price' is
#itself a stat, so refreshing here would re-enter the rebuild that asked. The food system
#keeps the stored tier current at every meal.
func sleep_demand_met(char_id):
	var person = ResourceScripts.game_party.characters.get(char_id, null)
	if !(person is Object) or person.food == null:
		return true
	if person.food.ignores_demand():
		return true
	var wanted = variables.food_demand_order.find('refined')
	if wanted < 0 or variables.food_demand_order.find(person.food.food_demand) < wanted:
		return true
	return character_room_has_tag(char_id, 'luxury') or character_room_has_tag(char_id, 'master_bed')


#True while the character sleeps in a room carrying the given tag - what drives the
#private-room bonus that used to be the 'luxury' work rule.
func character_room_has_tag(char_id, tag):
	return MansionLayout.lives_in_room_with_tag(mansion_layout, char_id, tag)


#Mirrors every work room into tasks_progresses and drops the records of rooms that are
#gone, so a room worker is an ordinary worker to the rest of the game and assign_to_task()
#can be used against a room without any special case.
func sync_room_tasks():
	#a farm raised or pulled down changes how many hands the farming job may take, and the
	#screen asks about that as soon as it redraws rather than waiting for the next day
	_add_farm_job()
	var live = MansionLayout.ensure_all_room_tasks(mansion_layout, tasks_progresses)
	#scaffolding gets a task of its own for exactly as long as it stands
	for entry in MansionLayout.each_build(mansion_layout):
		var build_id = MansionLayout.ensure_build_task(
			MansionLayout.get_slot(MansionLayout.get_floor(mansion_layout, entry.floor), entry.slot),
			tasks_progresses, extra_builder_slots())
		if build_id != null:
			live[build_id] = true
	for id in live:
		fill_room_task_details(id)
	for id in tasks_progresses.keys().duplicate():
		if !(tasks_progresses[id].get('type', '') in ['room_work', 'room_build']):
			continue
		if !live.has(id):
			clean_task(id) #releases its workers before the record goes


#What the activity log says about a scaffolding coming down. Turns pass with the mansion
#screen showing something else half the time, so the one moment a room is actually finished
#has to leave a mark the player can find afterwards.
func finished_build_text(build):
	match build.kind:
		'construct':
			return tr("MANSIONVIEW_LOGBUILT") % tr(RoomTypes.get_name_key(build.target))
		'repair':
			return tr("MANSIONVIEW_LOGCLEARED")
	return tr("MANSIONVIEW_LOGUPGRADED") % [tr(RoomUpgrades.get_name_key(build.target)),
		int(build.level)]


#Places on a scaffolding beyond the first. A crew belongs to the household rather than to the
#room it happens to be raising, so this is one upgrade bought once - not one bought again for
#every room, which is what it used to be.
func extra_builder_slots():
	return findupgradelevel('builders')


#A room mirror is created knowing only which job the room does. Everything else a task is
#asked for - what to call it, what it trains, which tool helps, which colour the work list
#draws it in - lives in the registry beside that job, and is copied over here.
#
#It cannot be done where the record is built: mansion_layout.gd is preloaded by this file, so
#it must never reach for an autoload, and the task registry is one. And it has to be done at
#all, because "a room worker is an ordinary worker to the rest of the game" is only true of a
#record the rest of the game can read - one without a name crashed the character list the
#moment somebody was actually put in a room.
func fill_room_task_details(task_id):
	if !tasks_progresses.has(task_id):
		return
	var task = tasks_progresses[task_id]
	if !tasks.tasklist.has(task.job):
		#Nothing to copy from - the practice room's "job" names the room rather than a recipe
		#queue. The room's own name is the honest thing to show, and unlike the bare job code
		#it is a real localization key.
		task.name = RoomTypes.get_name_key(task.get('room_type', ''))
		task.workstat = task.get('workstat', 'physics')
		#nothing to draw is an absent icon, never a null one - see below
		task.erase('icon')
		return
	var jobdata = tasks.tasklist[task.job]
	task.name = jobdata.name
	task.descript = jobdata.descript if jobdata.has('descript') else ''
	for key in ['mod', 'workstat', 'worktool', 'icon']:
		if jobdata.has(key) and jobdata[key] != null:
			task[key] = jobdata[key]
	#Every crafting job in tasks.gd carries icon = null and keeps the real picture under
	#production_icon, which is what the gathering tasks read (add_gathering_res_temp).
	#Copying 'icon' as it stands left a null in the record, and every screen that draws a
	#worker's task calls load() on it - the inventory list came down the moment somebody
	#was put in a workshop.
	if task.get('icon', null) == null:
		if jobdata.get('production_icon', null) != null:
			task.icon = jobdata.production_icon
		else:
			task.erase('icon')


#Task progress limits are serialized. Refresh food tasks so existing saves adopt economy
#changes while keeping the same completion percentage for work already performed.
func fix_food_task_limits():
	for task_id in tasks_progresses:
		var task_progress = tasks_progresses[task_id]
		var new_limit = null
		match task_progress.type:
			'gather':
				if Items.materiallist.has(task_progress.job) and Items.materiallist[task_progress.job].type == 'food':
					var template_id = tasks.find_task_for_res(task_progress.job)
					if template_id != null:
						new_limit = tasks.tasklist[template_id].progress_per_item
			'gather_simple', 'gather_limited':
				if Items.materiallist.has(task_progress.job) and Items.materiallist[task_progress.job].type == 'food':
					new_limit = Items.materiallist[task_progress.job].progress_per_item
			'progress_item':
				if Items.recipes.has(task_progress.id):
					var recipe = Items.recipes[task_progress.id]
					if recipe.resultitemtype == 'material' and Items.materiallist.has(recipe.resultitem) and Items.materiallist[recipe.resultitem].type == 'food':
						new_limit = recipe.workunits
		if new_limit == null or !task_progress.has('progress_limit'):
			continue
		var old_limit = float(task_progress.progress_limit)
		if is_equal_approx(old_limit, float(new_limit)):
			continue
		if old_limit > 0.0 and task_progress.has('progress'):
			task_progress.progress = float(task_progress.progress) * float(new_limit) / old_limit
		task_progress.progress_limit = new_limit

func serialize():
#	fix_items_inventory(true)
	var res = inst2dict(self).duplicate(true)
	res.items = {}
	for i in items:
		res.items[i] = inst2dict(items[i])
#	fix_items_inventory(false)
	return res


#buyback lives for one turn only - everything sold is gone once time passes
func clear_buyback():
	buyback.clear()


func get_buyback_list(shop_key):
	if !buyback.has(shop_key):
		return []
	return buyback[shop_key]


func add_buyback_record(shop_key, record):
	if !buyback.has(shop_key):
		buyback[shop_key] = []
	if record.kind != 'gear': #gear pieces keep their own rolled stats, so they never merge
		for i in buyback[shop_key]:
			if i.kind == record.kind and i.code == record.code and i.price == record.price:
				i.amount += record.amount
				return
	buyback[shop_key].append(record)


func remove_buyback_record(shop_key, record):
	if !buyback.has(shop_key):
		return
	buyback[shop_key].erase(record)
	if buyback[shop_key].empty():
		buyback.erase(shop_key)


func fix_tax():
	tax = 0
	for upgrade in upgrades:
		if upgrades[upgrade] <= 0:
			 continue
		#A saved level for something the tree no longer offers pays no tax - it is on its way
		#to whatever replaced it, see LEGACY_UPGRADES. Indexing the tree blind used to bring
		#the load down on any retired code.
		if !upgradedata.upgradelist.has(upgrade):
			continue
		var udata = upgradedata.upgradelist[upgrade]
		if udata.has('tax'): #not used but may be needed later
			tax += udata.tax
		if udata.has('levels'):
			for level_key in udata.levels:
				if int(level_key) > upgrades[upgrade]:
					continue
				var ldata = udata.levels[level_key]
				if ldata.has('tax'):
					tax += ldata.tax


func subtract_taxes():
	ResourceScripts.game_party.subtract_taxes()
	money -= tax
	if money < 0:
		input_handler.interactive_message('money_lose_scene', '', {})


#tasks handlers
func _get_new_task_id():
	var i = globals.rng.randi()
	while tasks_progresses.has('task_%d' % i):
		i = globals.rng.randi()
	return 'task_%d' % i


func _add_upgrade_task(upgrade_id):
	if !tasks_progresses.has(upgrade_id):
		var upgrade_lv = findupgradelevel(upgrade_id)
		var tdata = upgradedata.upgradelist[upgrade_id]
		tasks_progresses[upgrade_id] = {
			id = upgrade_id, 
			level = upgrade_lv + 1, 
			progress = 0, 
			progress_limit = tdata.levels[int(upgrade_lv + 1)].taskprogress, 
			type = 'progress_item', 
			status = 'init', 
			job = 'building',
			workstat = 'physics',
			worktool = 'hammer',
		}


func add_recipe_task(recipe_id, parts = {}, amount = {fixed = 1}):
	var id = _get_new_task_id()
	var rdata = Items.recipes[recipe_id]
	var tdata = tasks.tasklist[rdata.worktype]
	var template = {
		id = recipe_id, 
		progress = 0, 
		progress_limit = rdata.workunits, 
		type = 'progress_item', 
		status = 'init', 
		resultamount = rdata.resultamount,
		crafttype = rdata.crafttype,
		partdict = parts.duplicate(),
		workstat = tdata.workstat,
		mod = tdata.mod,
	}
	if tdata.has('worktool'):
		template.worktool = tdata.worktool
	template.job = rdata.worktype + '_' + rdata.resultitemtype
	
	if amount.has('fixed'):
		template.repeat = amount.fixed
	elif amount.has('continuous'):
		template.continuous = true
	else:
		template.cap_up = amount.max
		template.cap_low = amount.min
	tasks_progresses[id] = template
	crafting_lists[template.job].push_back(id)
	return id


func if_has_crafting_recipe(recipe_id):
	var rdata = Items.recipes[recipe_id]
	var list = rdata.worktype + '_' + rdata.resultitemtype
	for id in crafting_lists[list]:
		var pdata = tasks_progresses[id]
		if pdata.id == recipe_id:
			return true
	return false


func _add_farming_task(res):
	if !tasks_progresses.has('farming_' + res):
		var tdata = tasks.farm_tasks[res]
		tasks_progresses['farming_' + res] = {id = res, progress = 0, progress_limit = 1, type = 'farming', status = 'permanent', job = 'farming'}


func _add_craft_job():
	if !tasks_progresses.has('crafting'):
		tasks_progresses.crafting = {id = 'crafting', status = 'permanent', workers = [], workers_handled = {}, messages = [], location = 'aliron', name = 'TASKCRAFTNAME', descript = 'TASKCRAFTDESCRIPT', icon = "res://assets/images/gui/icon_craft64x64.png", type = 'permanent'}


#Every farm standing on the grounds, counted together. The estate has one farming job and the
#farms are what say how many hands it may take: what comes out of it is decided per person by
#their own produce rules, so there is nothing to tell one farm's output from another's.
func farm_places():
	var grounds = MansionLayout.grounds_floor(mansion_layout)
	if grounds < 0:
		return 0
	var res = 0
	var floor_data = MansionLayout.get_floor(mansion_layout, grounds)
	for slot_code in floor_data.slots:
		var room = MansionLayout.get_room(floor_data, slot_code)
		if room != null and room.type == 'farm':
			res += MansionLayout.slot_capacity(room, 'work')
	return res


#Farming used to be one record called 'farming'; every farm has a room task of its own now,
#and the job code is what they have in common. Screens that used to compare the task id ask
#this instead, so somebody farming still reads as farming wherever they stand.
func is_farming_work(task_id):
	if task_id == 'farming':
		return true
	var task = tasks_progresses.get(task_id, null)
	return task != null and task.get('job', '') == 'farming'


#The farm a new hand should be sent to: the first with a place going, or nothing if the
#estate has no room for another farmer.
func first_free_farm_task():
	var grounds = MansionLayout.grounds_floor(mansion_layout)
	if grounds < 0:
		return null
	var floor_data = MansionLayout.get_floor(mansion_layout, grounds)
	for slot_code in floor_data.slots:
		var room = MansionLayout.get_room(floor_data, slot_code)
		if room == null or room.type != 'farm' or room.task_id == null:
			continue
		var task = tasks_progresses.get(room.task_id, null)
		if task != null and task.workers.size() < int(task.max_workers):
			return room.task_id
	return null


func _add_farm_job():
	if !tasks_progresses.has('farming'):
		tasks_progresses.farming = {id = 'farming', status = 'permanent', workers = [], messages = [], location = 'aliron', type = 'permanent', name = 'TASKPRODUCE', descript = 'TASKPRODUCEDESCRIPT'} 
	#Farming is done in a farm, and each farm holds its own hands in its own room task. This
	#record is what the estate used before there were buildings; it is kept so a save part-way
	#through the change still has somewhere to read its farmers from. No places, so nothing
	#can be put on it again - assign_to_task() refuses a task with none.
	tasks_progresses.farming.max_workers = 0


func _add_service_job():
	if !tasks_progresses.has('service'):
		var jobdata = tasks.tasklist.brothel
		var template = {
			id = 'service', 
			status = 'permanent', 
			workers = [], 
			messages = [], 
			location = 'aliron', 
			type = 'permanent',
			icon = jobdata.production_icon,
		} 
		for st in ['descript', 'name']:
			template[st] = jobdata[st]
		tasks_progresses.service = template


func add_recruiting_job_temp(task_template_id, location):
	var id =  check_location_job('recruiting' , location, task_template_id)
	if id == null:
		id = _get_new_task_id()
		var jobdata = tasks.tasklist[task_template_id]
		var template = {
			id = 'recruiting',
			progress = 0,
			progress_limit = jobdata.progress_per_item,
			workers = [],
			max_workers = jobdata.base_workers,
			location = location,
			messages = [],
			icon = jobdata.production_icon,
			status = 'temporal',
			type = 'recruiting',
			job = task_template_id
		}
		for st in ['descript', 'name', 'workstat']:
			template[st] = jobdata[st]
		tasks_progresses[id] = template
		active_tasks.recruiting.push_back(id)
	return id


#"slot" names the building on the estate grounds this job is worked out of. Two mines are two
#jobs, each with its own places and its own loot, because what a mine yields is what that mine
#has been dug out to yield. Everywhere else - a settlement, a dungeon - there is no building
#behind the work and the slot is empty, which is the old one-job-per-material behaviour.
func add_gathering_job_temp(task_template_id, location, slot = ''):
	var jobdata = tasks.tasklist[task_template_id]
	var id = check_location_job('gathering' , location, jobdata.production_item, slot)
	var template
	if id == null:
		id = _get_new_task_id()
		template = {
			id = 'gathering',
			progress = 0,
			progress_limit = jobdata.progress_per_item,
			workers = [],
			max_workers = jobdata.base_workers,
			location = location,
			messages = [],
			icon = Items.materiallist[jobdata.production_item].icon.resource_path,
			status = 'temporal',
			type = 'gather',
			job = jobdata.production_item,
			room_slot = slot
		}
		for st in ['descript', 'name', 'workstat', 'worktool', 'mod']:
			template[st] = jobdata[st]
		tasks_progresses[id] = template
		active_tasks.gathering.push_back(id)
	else:
		template = tasks_progresses[id]
	var locdata = ResourceScripts.world_gen.get_location_from_code(location)
	if locdata.has("category") and locdata.category == 'capital':
		_fix_max_workers(id)
	return id


func add_gathering_res_temp(res, location):
	var id = check_location_job('gathering' , location, res)
	var template
	if id == null:
		id = _get_new_task_id()
		var resdata = Items.materiallist[res]
		template = {
			id = 'gathering',
			progress = 0,
			progress_limit = resdata.progress_per_item,
			workers = [],
			location = location,
			messages = [],
			icon = resdata.icon.resource_path,
			status = 'temporal',
			type = 'gather_simple',
			job = res,
			mod = resdata.workmod
		}
		if resdata.has('tool_type'):
			template.worktool = resdata.tool_type
		for st in ['descript', 'name', 'workstat']:
			template[st] = resdata[st]
		tasks_progresses[id] = template
		active_tasks.gathering.push_back(id)
	else:
		template = tasks_progresses[id]
	var locdata = ResourceScripts.world_gen.get_location_from_code(location)
	template.max_workers = locdata.gather_resources[res]
	return id


func add_gathering_limited_job_temp(res, location):
	var id = check_location_job('gathering' , location, res) 
	if id == null:
		id = _get_new_task_id()
		var resdata = Items.materiallist[res]
		var template = {
			id = 'gathering',
			progress = 0,
			progress_limit = resdata.progress_per_item,
			workers = [],
			location = location,
			messages = [],
			icon = resdata.icon.resource_path,
			status = 'temporal',
			type = 'gather_limited',
			job = res,
			mod = resdata.workmod
		}
		if resdata.has('tool_type'):
			template.worktool = resdata.tool_type
		for st in ['descript', 'name', 'workstat']:
			template[st] = resdata[st]
		tasks_progresses[id] = template
		active_tasks.gathering.push_back(id)
	return id


func add_special_job(effect):
	var id = _get_new_task_id()
	var template = {
		id = 'special',
		progress = 0,
		workers = [],
		location = effect.location,
		messages = [],
		args = [],
		status = 'active',
		type = 'special',
	}
	var template2 = tasks.tasklist.special
	var template3 = {}
	if effect.has('template'):
		template3 = tasks.tasklist[effect.template]
	#threshold
	template.progress_limit = template2.progress_per_item
	if template3.has('progress_per_item'):
		template.progress_limit = template3.progress_per_item
	if effect.has('amount'):
		template.progress_limit = effect.amount
	#args
	if effect.has('args'):
		template.args = effect.args.duplicate(true)
	elif template3.has('args'):
		template.args = template3.args.duplicate(true)
	elif template2.has('args'):
		template.args = template2.args.duplicate(true)
	#desc name icon
	for st in ['descript', 'name', 'icon']:
		template[st] = ""
		if template2.has(st):
			template[st] = template2[st]
		if template3.has(st):
			template[st] = template3[st]
		if effect.has(st):
			template[st] = effect[st]
	#max_workers
	template.max_workers = template2.base_workers
	if template3.has('base_workers'):
		template.max_workers = template3.base_workers
	if effect.has('max_workers'):
		template.max_workers = effect.max_workers
	#function workstat
	for st in ['function', 'workstat']:
		if template2.has(st):
			template[st] = template2[st]
		if template3.has(st):
			template[st] = template3[st]
		if effect.has(st):
			template[st] = effect[st]
	tasks_progresses[id] = template
	active_tasks.special.push_back(id)


#tasks main
func tick(managed = false):
	if managed: #always a coroutine when managed, so the caller can yield on it
		yield(globals.get_tree(), 'idle_frame')
	tasks_cleanup()
	process_gathering()
	process_farm()
	process_craft(true)
	process_craft(false)
	process_rooms()
	for t_id in active_tasks.recruiting.duplicate():
		_process_recruit_task(t_id)
	for t_id in active_tasks.special.duplicate():
		_process_spec_task(t_id)

	if managed:
		yield(process_service(true), 'completed')
	else:
		process_service()
	tasks_cleanup()


func _fix_max_workers(t_id):
	if !tasks_progresses.has(t_id):
		print("ERROR - no progress for task %s" % t_id)
		return
	var tprogress = tasks_progresses[t_id]
	if tprogress.type == 'gather':
		var jobdata = tasks.tasklist[tasks.find_task_for_res(tprogress.job)]
		#The estate's own gathering is worked out of a building on the grounds now: the
		#building's places are the job's places, and with no building there is no job at all.
		#The 'resource_gather_*' upgrades that used to say this are retired, their levels
		#handed to the buildings by convert_gather_upgrades().
		if jobdata.has('room_type'):
			tprogress.max_workers = gather_places(jobdata.room_type,
				str(tprogress.get('room_slot', '')))
		elif jobdata.has('upgrade_code') and jobdata.has('workers_per_upgrade') and jobdata.has('base_workers'):
			var upgrade_level = findupgradelevel(jobdata.upgrade_code)
			tprogress.max_workers = jobdata.base_workers + jobdata.workers_per_upgrade * upgrade_level


#A piece of work is known by where it is and what it makes - and, when a building on the estate
#grounds is what makes it, by which building. Without that last part two mines would find each
#other's job and collapse into one.
#Every place with a quest standing on it that nobody has been put on. Two screens ask this -
#the Local tasks button and the navigation strip - so it is answered here, where the tasks
#live, rather than counted twice from two different ideas of what a quest is.
func unstaffed_quest_locations():
	var res = {}
	for task_id in active_tasks.special:
		if !tasks_progresses.has(task_id):
			continue
		var task = tasks_progresses[task_id]
		if !task.has('workers') or !task.workers.empty():
			continue
		var where = str(task.get('location', ''))
		if where != '':
			res[where] = true
	return res


func check_location_job(type, location, job, slot = ''):
	for t_id in active_tasks[type]:
		if tasks_progresses.has(t_id):
			var pdata = tasks_progresses[t_id]
			if pdata.location == location and pdata.job == job 					and str(pdata.get('room_slot', '')) == str(slot):
				return t_id
		else:
			print("ERROR - no progress for %s task %s" % [type, t_id])
	return null


func _active_task_find(list):
	for id in list:
		if tasks_progresses.has(id):
			var pdata = tasks_progresses[id]
			if pdata.status == 'active' and pdata.has('cap_up'):
				var amount
				if pdata.job.ends_with('material'):
					amount = materials[pdata.id]
				else: #item case, currently itembase check only
					amount = get_item_amount(pdata.id)
				if amount >= pdata.cap_up:
					pdata.status = 'stopped'
			if pdata.status == 'stopped':
				var amount
				if pdata.job.ends_with('material'):
					amount = materials[pdata.id]
				else: #item case, currently itembase check only
					amount = get_item_amount(pdata.id)
				if amount < pdata.cap_low:
					pdata.status = 'init'
			if pdata.status in ['init', 'no_resources']:
				if check_recipe_amount(pdata) > 0:
					spend_resources(id)
					pdata.status = 'active'
				else:
					pdata.status = 'no_resources'
			if pdata.status == 'active':
				return id
		else:
			print("ERROR: task_id %s not found" % id)
	return null


func clean_task(id):
	var val = tasks_progresses[id]
	var was_on_screen = false
	if val.has('workers'):
		was_on_screen = !val.workers.empty()
		for ch_id in val.workers.duplicate():
			var tchar = characters_pool.get_char_by_id(ch_id)
			tchar.remove_from_task()
	match val.type:
		'progress_item':
			crafting_lists[val.job].erase(id)
			was_on_screen = true #craft orders are listed whether or not anyone is on them
	if active_tasks.has(val.id):
		active_tasks[val.id].erase(id)
	tasks_progresses.erase(id)
	#An unstaffed task changed nobody's work and was never drawn - every section of the task
	#info panel skips tasks with an empty worker list. Staying quiet for those is what keeps
	#opening a job panel from costing a full slave list rebuild per scaffolding task.
	if was_on_screen:
		globals.emit_signal("task_removed")


func tasks_cleanup():
	for id in tasks_progresses.keys().duplicate():
		var val = tasks_progresses[id]
		if val.status == 'temporal':
			if val.has('workers') and !val.workers.empty():
				val.status = 'active'
		if val.status in ['completed', 'temporal']:
			clean_task(id)


#Temporal tasks are scaffolding: the job and location panels create one per selectable job
#so their buttons have something to bind to. Whatever the player staffed becomes a real
#task, the rest are dead weight. Dropping them when the panel closes keeps a dozen throwaway
#tasks from riding along to the next turn and being culled in the middle of the tick.
#Same rules as the temporal half of tasks_cleanup, without touching completed tasks.
func drop_unused_temp_tasks():
	for id in tasks_progresses.keys().duplicate():
		var val = tasks_progresses[id]
		if val.status != 'temporal':
			continue
		if val.has('workers') and !val.workers.empty():
			val.status = 'active'
			continue
		clean_task(id)


func remove_tasks_for_location(location):
	for id in tasks_progresses.keys().duplicate():
		var val = tasks_progresses[id]
		if val.has("location") and val.location == location:
			clean_task(id)


func find_task_for_quest(q_id):
	for task_id in active_tasks.special:
		var task = tasks_progresses[task_id]
		for dir in task.args: #all special tasks have args
			if dir.code != 'finish_worktask':
				continue
			#ids of slave's quests are floats for now
			if typeof(dir.value) == typeof(q_id) and dir.value == q_id:
				return task_id
	return null


func remove_quest_task(q_id):
	var task = find_task_for_quest(q_id)
	if task != null:
		clean_task(task)
		globals.emit_signal("task_removed")


func process_gathering():
	for t_id in active_tasks.gathering:
		if !tasks_progresses.has(t_id):
			print("ERROR - no progress for recruiting task %s" % t_id)
			active_tasks.gathering.erase(t_id)
			continue
		
		var tprogress = tasks_progresses[t_id]
		var worker_lookup = {}
		for worker_id in tprogress.workers:
			worker_lookup[worker_id] = true
		var task_code = null
		if !tprogress.type in ['gather_limited', 'gather_simple']:
			task_code = tasks.find_task_for_res(tprogress.job)
		for ch_id in ResourceScripts.game_party.character_order:
			if !worker_lookup.has(ch_id):
				continue
			var character = characters_pool.get_char_by_id(ch_id)
			if tprogress.status == 'completed':
				character.rest_tick()
			else:
				var val = 0
				if tprogress.type in ['gather_limited', 'gather_simple']:
					val = character.get_progress_resource(tprogress.job, true)
				else:
					val = character.get_job_value(task_code, true)
				_add_gather_value(t_id, tprogress, val, character)
				character.work_tick_values(tprogress.workstat)
				if tprogress.status == 'completed':
					globals.text_log_add('char', character.get_short_name() + ": " + "No more resources to gather.")


#Anyone left on the estate-wide record from before the farms were buildings. process_rooms()
#is what works the farms themselves.
func process_farm():
	_add_farm_job()
	_farm_tick(tasks_progresses.farming.workers)


#What a turn on a farm is worth. The building decides nothing here: what somebody gives is
#decided by their own body and the rules set on them.
func _farm_tick(workers):
	for ch_id in ResourceScripts.game_party.character_order:
		if !(ch_id in workers):
			continue
		var character = characters_pool.get_char_by_id(ch_id)
		if character == null:
			continue
		for res in character.get_farming_rules():
			_add_farming_value(res, character.get_progress_farm(res), character)


func process_service(managed = false):
	if managed: #always a coroutine when managed, so the caller can yield on it
		yield(globals.get_tree(), 'idle_frame')
	_add_service_job()
	var currenttask = tasks_progresses.service
	var slice = OS.get_ticks_msec()
	var worker_lookup = {}
	for worker_id in currenttask.workers:
		worker_lookup[worker_id] = true
	#iterate a copy: a character dying mid-turn erases itself from character_order, and with
	#the tick spread over frames a deferred cleanup can land in the middle of this loop
	for ch_id in ResourceScripts.game_party.character_order.duplicate():
		if !worker_lookup.has(ch_id):
			continue
		var character = characters_pool.get_char_by_id(ch_id)
		if character == null or !character.is_active:
			continue
		character.select_brothel_activity()
		if managed and OS.get_ticks_msec() - slice >= variables.turn_frame_budget_msec:
			yield(globals.get_tree(), 'idle_frame')
			slice = OS.get_ticks_msec()


func _apply_craft_overflow(character, value, preferred_job, joborder):
	#Item work keeps its matching material category first, but any unused work units must
	#fall through to the character's other enabled categories instead of disappearing.
	var jobs = joborder.duplicate()
	jobs.erase(preferred_job)
	jobs.push_front(preferred_job)
	for job in jobs:
		if value <= 0:
			break
		if job == 'building':
			continue
		var real_job = job + '_material'
		if !crafting_lists.has(real_job):
			continue
		var curupgrade = _active_task_find(crafting_lists[real_job])
		value = _add_craft_value(curupgrade, value, character)
	return value


func process_craft(firstpass = true):
	_add_craft_job()
	var currenttask = tasks_progresses.crafting
	for ch_id in ResourceScripts.game_party.character_order:
		if !(ch_id in currenttask.workers):
			continue
		var character = characters_pool.get_char_by_id(ch_id)
		#Items are made first and materials take what is left over. The two passes are the
		#same shape either way - one picks a piece of work and records what it cost, the
		#other spreads the remainder - so the swap is which queue each pass reaches for.
		var joborder = character.get_job_order(!firstpass)
		if firstpass:
			for job in joborder:
				var value = character.get_job_value(job, true) 
				#Raising a room rides in the item order but is not made from a recipe queue -
				#it has one list of its own and its own way of being worked at. It travelled
				#with the items when they were the second pass, and it travels with them now
				#that they are the first: 'building_item' is not a queue and never was.
				if job == 'building':
					var built = _active_task_find(crafting_lists[job])
					if _add_build_value(built, value, character):
						#marked as dealt with, with nothing left over: a builder's spare work
						#does not spill into the recipe queues, which is how this always ran
						currenttask.workers_handled[ch_id] = {job = job, value = 0}
						character.work_tick_values(tasks_progresses[built].workstat)
						break
					continue
				var real_job = job + '_item'
				var curupgrade = _active_task_find(crafting_lists[real_job])
				var new_value = _add_craft_value(curupgrade, value, character)
				if new_value != value:
					var pdata = tasks_progresses[curupgrade]
					currenttask.workers_handled[ch_id] = {job = job, value = new_value}
					character.work_tick_values(pdata.workstat)
					break
		else:
			if currenttask.workers_handled.has(ch_id):
				var handled = currenttask.workers_handled[ch_id]
				_apply_craft_overflow(character, handled.value, handled.job, joborder)
			else:
				var applied = false
				#nothing in the item order took them, so the materials are what is left to do
				for job in joborder:
					var value = character.get_job_value(job, true) 
					var real_job = job + '_material'
					var curupgrade = _active_task_find(crafting_lists[real_job])
					var new_value = _add_craft_value(curupgrade, value, character)
					if new_value < value:
						var pdata = tasks_progresses[curupgrade]
						character.work_tick_values(pdata.workstat)
						applied = true
						break
				if !applied:
					globals.text_log_add('work', character.get_short_name() + ": No available craft task.")
					character.rest_tick()
	if !firstpass:
		currenttask.workers_handled.clear()


#Work rooms own a task each, so neither process_craft (which walks only
#tasks_progresses.crafting.workers) nor process_gathering (which walks only
#active_tasks.gathering) would ever see their workers - without this pass a character
#placed in a forge would simply stand idle all turn. The room decides who works and which
#discipline they practise; the shared recipe queues still decide which recipe, exactly as
#they do for the crafting task.
func process_rooms():
	sync_room_tasks()
	for entry in MansionLayout.each_room(mansion_layout):
		var room = entry.room
		if room.task_id == null or !tasks_progresses.has(room.task_id):
			continue
		var tprogress = tasks_progresses[room.task_id]
		if tprogress.workers.empty():
			continue
		#Rooms that train rather than make: their "job" is not a discipline and there is no
		#recipe queue behind it, so _spend_room_work would index crafting_lists on a key that
		#does not exist. See process_practice_room().
		if RoomTypes.has_tag(room.type, 'practice'):
			process_practice_room(room, tprogress)
			continue
		#A farm makes nothing of its own either: it is somewhere for people to be worked for
		#what their bodies give, and there is no recipe queue behind that.
		if RoomTypes.has_tag(room.type, 'farm'):
			_farm_tick(tprogress.workers)
			for ch_id in tprogress.workers.duplicate():
				var farmhand = characters_pool.get_char_by_id(ch_id)
				if farmhand != null:
					farmhand.work_tick_values(tprogress.workstat)
			continue
		#the clerk keeps the books rather than making anything; what their sitting there is
		#worth is decided at the moment a delivery arrives, in gain_material()
		if RoomTypes.has_tag(room.type, 'storage'):
			for ch_id in tprogress.workers.duplicate():
				var clerk = characters_pool.get_char_by_id(ch_id)
				if clerk != null:
					clerk.work_tick_values('wits')
			continue
		#per-room modifier, so "better tools" really does apply to this room only
		var modifier = MansionLayout.craft_modifier(room)
		for ch_id in tprogress.workers.duplicate():
			var character = characters_pool.get_char_by_id(ch_id)
			if character == null:
				continue
			var value = character.get_job_value(tprogress.job, true) * modifier
			if _spend_room_work(tprogress.job, value, character, room):
				character.work_tick_values(tprogress.workstat)
			else:
				globals.text_log_add('work', character.get_short_name() + ": No available craft task.")
				character.rest_tick()


	process_room_builds()


#A turn in the practice room. Whoever stands here either drills the stat the room is set to,
#or - with a tutor present and a trait picked - works that trait out of themselves instead.
#
#The prize is deliberately not scaled by the character: CharacterClass.add_stat() already
#thins basic-stat gains as they climb (ch_stats.get_stat_gain_rate), so a flat 3..5 here
#lands as a real difference low down and a small one near the cap, which is the point.
func process_practice_room(room, tprogress):
	var trainer = practice_trainer(room)
	#a tutor is worth half again, and is the only way a trait is worked out at all
	var tutored = trainer != null
	for ch_id in tprogress.workers.duplicate():
		var character = characters_pool.get_char_by_id(ch_id)
		if character == null:
			continue
		if character.id == room.practice.trainer:
			#the tutor is not their own pupil
			continue
		if tutored and room.practice.target != null:
			advance_practice_trait(room, character)
			continue
		var value = globals.rng.randi_range(3, 5)
		if tutored:
			value = round(value * 1.5)
		character.add_stat(room.practice.stat, value)
		character.work_tick_values(room.practice.stat)


#Who is tutoring in this room, or null. A trainer who has left the household, lost the knack
#or simply is not standing in the room any more tutors nobody.
func practice_trainer(room):
	if room.practice.trainer == null:
		return null
	if MansionLayout.upgrade_level(room, 'tutoring_area') <= 0:
		return null
	var person = characters_pool.get_char_by_id(room.practice.trainer)
	if person == null or !person.check_trait('trainer'):
		return null
	if room.task_id == null or !tasks_progresses.has(room.task_id):
		return null
	if !tasks_progresses[room.task_id].workers.has(room.practice.trainer):
		return null
	return person


#A turn spent unlearning something rather than learning something. The work is shared, so two
#pupils in a widened room get there twice as fast, and finishing clears the room's target so
#the player picks the next one deliberately.
func advance_practice_trait(room, character):
	character.work_tick_values('wits')
	room.practice.progress += character.get_stat('wits') / 20.0 + 1.0
	if room.practice.progress < MansionLayout.PRACTICE_TRAIT_PROGRESS:
		return
	var code = room.practice.target
	room.practice.progress = 0
	room.practice.target = null
	if character.check_trait(code):
		character.remove_trait(code)
		#remove_trait only marks the rebuild as needed; check_trait reads the rebuilt list,
		#which still holds the trait until something forces it. Without this the habit is
		#gone from storage but still shown on the character until the cache happens to be
		#dirtied by something else - reading a stat is what forces it.
		character.get_stat('physics')
		globals.mansion_activity_log_add('work',
			tr("MANSIONVIEW_TRAITREMOVED") % [character.get_short_name(),
				tr(Traitdata.traits[code].name) if Traitdata.traits.has(code) else code])


#Raising a room, clearing out a derelict one and upgrading one all run through here. The
#existing building queue only ever advances its own head, so per-room scaffolding needs
#its own accounting - which is also what lets several rooms go up at once.
func process_room_builds():
	for entry in MansionLayout.each_build(mansion_layout):
		var build = entry.build
		if !tasks_progresses.has(build.task_id):
			continue
		var tprogress = tasks_progresses[build.task_id]
		var finished = false
		for ch_id in tprogress.workers.duplicate():
			var character = characters_pool.get_char_by_id(ch_id)
			if character == null:
				continue
			var value = character.get_job_value('building', true)
			if value <= 0:
				character.rest_tick()
				continue
			character.work_tick_values(tprogress.workstat)
			if MansionLayout.advance_build(build, value):
				finished = true
				break
		if !finished:
			continue
		#read before completing: finishing is what clears the build record away
		var done_text = finished_build_text(build)
		var task_id = MansionLayout.complete_build(mansion_layout, entry.floor, entry.slot)
		globals.mansion_activity_log_add('work', done_text)
		if task_id != null and tasks_progresses.has(task_id):
			clean_task(task_id)
		rooms_changed()
		#a finished room needs its work task before anyone can be put in it, and the sync
		#at the top of process_rooms() has already been and gone by now
		sync_room_tasks()
		globals.emit_signal("task_removed")


#Materials first, then items - the same order and the same helpers process_craft uses.
#_add_craft_value returns the work it could not spend, so nothing was done when it hands
#the whole value back.
func _spend_room_work(job, value, character, room = null):
	#items first, materials with what is left - the same order the estate's own crafting takes
	var left = _add_craft_value(_active_task_find(room_queue(room, crafting_lists[job + '_item'])), value, character)
	if left == value:
		left = _add_craft_value(_active_task_find(room_queue(room, crafting_lists[job + '_material'])), left, character)
	return left < value


#Has the estate's books been put in order? Ledgers is bought once, on the master's office,
#and what it buys is the right to tell every craft room what to work on - so it is asked of
#the estate, not of the room being asked to obey it.
#What a craft room counts as, on the scale recipes are written against. The old global
#'forge'/'tailor'/'alchemy' upgrades had three levels; a room has itself and two levels of
#Better Tools, so they line up one for one: built is 1, and each level of tools is another.
#What this room is actually working on this turn: the head of the queue it will reach for,
#which is its own list when Ledgers has given it one, and the estate's otherwise. Asked in the
#same order the work itself takes, so the room cannot say one thing and make another.
func room_current_craft(room):
	if room == null:
		return null
	var job = RoomTypes.get_work_job(room.type)
	if job == null or !crafting_lists.has(job + '_item'):
		return null
	for suffix in ['_item', '_material']:
		var task_id = _active_task_find(room_queue(room, crafting_lists[job + suffix]))
		if task_id != null:
			return task_id
	return null


#The name of what a queued recipe makes, for the screens that show it.
func craft_result_name(task_id):
	if task_id == null or !tasks_progresses.has(task_id):
		return ""
	var recipe = Items.recipes.get(tasks_progresses[task_id].id, null)
	if recipe == null:
		return ""
	if Items.materiallist.has(recipe.resultitem):
		return tr(Items.materiallist[recipe.resultitem].name)
	if Items.itemlist.has(recipe.resultitem):
		return tr(Items.itemlist[recipe.resultitem].name)
	return ""


#How many rooms of this kind the estate has. What the old 'resting' upgrade asked about is a
#bathhouse now, and questlines ask it through this.
func count_rooms(room_type):
	return MansionLayout.count_rooms_of_type(mansion_layout, room_type)


#How good a workshop of this kind the estate has - the best one, not the first one built.
#Crafting is global: a recipe asks whether the household can make the thing at all, and one
#well-equipped forge is enough however many plain ones stand beside it. Reading the first room
#found meant a forge raised early answered for every forge after it, so improving the second
#one bought nothing. Craft rooms are not unique, unlike the gathering buildings above.
func craft_room_level(room_type):
	var best = MansionLayout.best_upgrade_level(mansion_layout, room_type, 'craft_tools')
	if best < 0:
		return 0
	return 1 + best


func has_ledgers():
	var office = MansionLayout.first_room_of_type(mansion_layout, 'masters_office')
	if office == null:
		return false
	return MansionLayout.upgrade_level(office, 'ledgers') > 0


#The order this room works its discipline's queue in. Without Ledgers, or with nothing chosen,
#that is the estate's own order - which is what every room did before the upgrade existed.
#With a list, only what is on it, in the order it is on it: a room told to make nails and
#given nothing else to make sits idle rather than quietly falling back on the estate's queue,
#because falling back is precisely what the player bought the upgrade to stop.
func room_queue(room, queue):
	if room == null or !has_ledgers():
		return queue
	if !(room.craft_rules is Array) or room.craft_rules.empty():
		return queue
	var res = []
	for task_id in room.craft_rules:
		if queue.has(task_id):
			res.append(task_id)
	return res


func _process_spec_task(id):
	if !tasks_progresses.has(id):
		print("ERROR - no progress for special task %s" % id)
		active_tasks.special.erase(id)
		return
	var tprogress = tasks_progresses[id]
	for ch_id in tprogress.workers:
		var tchar = characters_pool.get_char_by_id(ch_id)
		if tprogress.status == 'active':
			tprogress.progress += tchar.special_tick(tprogress)
			if tprogress.progress >= tprogress.progress_limit:
				tprogress.status = 'completed'
				globals.common_effects(tprogress.args)
				globals.emit_signal("work_produced", tchar.id, id, tprogress.icon)
				globals.mansion_activity_log_add("quest_task", tr("MANSION_ACTIVITY_QUEST_TASK_COMPLETE") % [tchar.get_short_name(), tr(tprogress.name)])
				input_handler.PlaySound("ding")
		else:
			tchar.rest_tick()


func _process_recruit_task(id):
	if !tasks_progresses.has(id):
		print("ERROR - no progress for recruiting task %s" % id)
		active_tasks.recruiting.erase(id)
		return
	var tprogress = tasks_progresses[id]
	for ch_id in tprogress.workers:
		var tchar = characters_pool.get_char_by_id(ch_id)
		tprogress.progress += tchar.recruit_tick(tprogress)
		while tprogress.progress >= tprogress.progress_limit:
			tprogress.progress -= tprogress.progress_limit
			var found_character = globals.roll_hirelings(tprogress.location, tchar)
			globals.emit_signal("work_produced", tchar.id, id, tprogress.icon)
			var location_data = ResourceScripts.world_gen.get_location_from_code(tprogress.location)
			globals.mansion_activity_log_add("character_found", tr("MANSION_ACTIVITY_CHARACTER_FOUND") % [
				tchar.get_short_name(),
				found_character.get_short_name(),
				tr(location_data.name),
			])
			input_handler.PlaySound("ding")


func _add_build_value(curupgrade, value, character, tres = false):
	if curupgrade == null:
		return tres
	else:
		if !tasks_progresses.has(curupgrade):
			_add_upgrade_task(curupgrade)
		var tprogress = tasks_progresses[curupgrade]
		tprogress.progress += value
		#a retired upgrade cannot be finished, and the sweep on load takes it out of the queue -
		#this is the belt to that braces, since nothing here could describe it either
		if !upgradedata.upgradelist.has(curupgrade):
			crafting_lists.building.erase(curupgrade)
			return false
		var tdata = upgradedata.upgradelist[curupgrade]
		if tprogress.progress >= tprogress.progress_limit:
			var newval = tprogress.progress - tprogress.progress_limit
			level_up_upgrade(curupgrade)
			globals.emit_signal("work_produced", character.id, curupgrade, "res://assets/Textures_v2/MANSION/icon_upgrade_64.png")
			
			if tdata.levels[int(tprogress.level)].has('tax'):
				tax += tdata.levels[int(tprogress.level)].tax
			
			input_handler.emit_signal("UpgradeUnlocked", upgradedata.upgradelist[curupgrade])
			globals.mansion_activity_log_add("upgrade", tr("MANSION_ACTIVITY_UPGRADE_COMPLETE") % [character.get_short_name(), tr(tdata.name)])
			if curupgrade == "tattoo_set":
				input_handler.ActivateTutorial("TUTORIALLIST8")
			tprogress.status = 'completed'
			curupgrade = _active_task_find(crafting_lists.building)
			return _add_build_value(curupgrade, newval, character, true)
		return true


func _add_craft_value(curupgrade, value, character): 
	if curupgrade == null:
		return value
	elif !tasks_progresses.has(curupgrade):
		print ("ERROR: no progress record for crafting task %s" % curupgrade)
		return value
	else:
		var tprogress = tasks_progresses[curupgrade]
		#batch limits, as we can't use recursion for crafting items (proved before)
		var limit1 = 0 #how much can be crafted
		if value >= tprogress.progress_limit - tprogress.progress:
			limit1 = int(floor((value + tprogress.progress) / tprogress.progress_limit))
		var limit2 = 1 + check_recipe_amount(tprogress) #how much can be paid for, current crafting item is always paid for
		var limit3 = 9999 #upper limit
		if tprogress.has('repeat'):
			limit3 = tprogress.repeat
		elif tprogress.has('cap_up'):
			var amount
			if tprogress.job.ends_with('material'):
				amount = materials[tprogress.id]
			else: #item case, currently itembase check only
				amount = get_item_amount(tprogress.id)
			limit3 = int(tprogress.cap_up - amount - 1) / int(tprogress.resultamount) + 1
			if limit3 < 0:
				limit3 = 0
		
		var limit = limit1 #actual crafted number
		if limit > limit2:
			limit = limit2
		if limit > limit3:
			limit = limit3
		
		if limit > 0:
			for i in range(limit):
				make_item(curupgrade, character) #fix
			spend_resources(curupgrade, limit - 1)
			if tprogress.has('repeat'):
				tprogress.repeat -= limit
			value -= limit * tprogress.progress_limit - tprogress.progress
			tprogress.progress = 0
		else:
			tprogress.progress += value
		
		#hard limits
		if limit == limit3: #hard state -> stopped/complteted
			if tprogress.has('repeat'):
				tprogress.status = 'completed'
			else:
				tprogress.status = 'stopped'
			if value > 0:
				curupgrade = _active_task_find(crafting_lists[tprogress.job])
				return _add_craft_value(curupgrade, value, character)
			else:
				return 0
		elif limit == limit2: #hard state -> init
			tprogress.status = 'init'
			if value > 0:
				curupgrade = _active_task_find(crafting_lists[tprogress.job])
				return _add_craft_value(curupgrade, value, character)
			else:
				return 0
		else: #soft limit = limit1
			if limit > 0:
				if value > 0:
					spend_resources(curupgrade) #possible, as limit2 > limit
					tprogress.progress = value
				else:
					tprogress.status = 'init' #next item not started and not paid for
			return 0


func _add_gather_value(task_id, tprogress, value, character):
#	var tprogress = tasks_progresses[curupgrade]
	#batch limits
	var limit1 = 0
	if value >= tprogress.progress_limit - tprogress.progress:
		limit1 = floor((value + tprogress.progress) / tprogress.progress_limit)
	var limit2 = 9999
	if tprogress.type == 'gather_limited':
		var locdata = ResourceScripts.world_gen.get_location_from_code(tprogress.location)
		limit2 = locdata.gather_limit_resources[tprogress.job]
	var limit = limit1
	if limit2 < limit:
		limit = limit2
	
	value -= limit * tprogress.progress_limit - tprogress.progress

	if limit > 0:
		#A dungeon seam pays out of a stock the location keeps count of, so what it hands over
		#has to be the same thing it subtracts below - it stays on fixed output. Everything the
		#estate and the settlements work rolls its table once per finished batch instead.
		if tprogress.type == 'gather_limited':
			_grant_production_res(tprogress.job, limit, task_id, character)
		else:
			#same split process_gathering() makes when it asks what a worker is worth: an
			#estate job has a task template and its own table, raw gathering has neither and
			#is known only by the material
			var task_code = tasks.find_task_for_res(tprogress.job) if tprogress.type == 'gather' else null
			var loot_processor = Items.get_loot()
			var record = loot_processor.get_production_record(
				tasks.find_production_loot(task_code, tprogress.job), tprogress.job)
			_grant_production(roll_gathering(tprogress, record, limit), task_id, character)

	if tprogress.type == 'gather_limited':
		var locdata = ResourceScripts.world_gen.get_location_from_code(tprogress.location)
		locdata.gather_limit_resources[tprogress.job] -= limit
	
	if limit == limit2:
		tprogress.status = 'completed'
	else:
		tprogress.progress = value
		value = 0
	
	return value


func _add_farming_value(res, value, character):
	if !tasks_progresses.has('farming_' + res):
		_add_farming_task(res)
	var tprogress = tasks_progresses['farming_' + res]
	tprogress.progress += value
	var produced = 0
	while tprogress.progress > tprogress.progress_limit:
		produced += 1
		tprogress.progress -= tprogress.progress_limit
	if produced > 0:
		var loot_processor = Items.get_loot()
		var record = loot_processor.get_production_record(tasks.find_farm_production_loot(res), res)
		#the farm has never counted towards a worker's earning metrics, and a table does not
		#change that - only what comes out of the batches it already produced
		_grant_production(loot_processor.roll_production(record, produced), "farming", character, false)


#Hands out what a batch of work rolled. Materials go into the household's stock exactly where
#fixed production always put them; items are unusual in a production table but the loot
#pipeline can make them, so they are not quietly dropped on the floor.
#One work_produced per distinct product, so a table yielding three things flies three icons.
#Gold is not production: work that earns coin earns it through service, which keeps its own
#books (ch_leveling.select_brothel_activity). A gold record in a production table is a
#mistake in the data rather than a payout, and says so instead of paying out.
func _grant_production(reward, task_id, character, count_metrics = true):
	if reward.gold > 0:
		push_error("production loot table paid gold for task %s - production tables make resources, not coin" % str(task_id))
	for mat in reward.materials:
		if reward.materials[mat] <= 0:
			continue
		_grant_production_res(mat, reward.materials[mat], task_id, character, count_metrics)
	for item in reward.items:
		globals.AddItemToInventory(item)
		globals.emit_signal("work_produced", character.id, task_id, Items.itemlist[item.itembase].icon)


func _grant_production_res(res, amount, task_id, character, count_metrics = true):
	#the gold branch is the dungeon seams' own, carried over from when every gathering task
	#paid out this way - a seam yields whatever the location holds in stock, gold included
	if res == 'gold':
		money += amount
	else:
		gain_material(res, amount)
	if count_metrics:
		character.add_metric_for_outcome(res, amount)
	var product_icon = "res://assets/images/iconsitems/gold.png" if res == 'gold' else Items.materiallist[res].icon
	globals.emit_signal("work_produced", character.id, task_id, product_icon)


#tasks helpers
func add_upgrade_to_queue(upgrade_id):
	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_lv = findupgradelevel(upgrade_id)
	var upgrade_next_state = null
	if upgrade_data.levels.has(upgrade_lv + 1):
		upgrade_next_state = upgrade_data.levels[upgrade_lv + 1]

	if crafting_lists.building.has(upgrade_id):
		input_handler.SystemMessage("Upgrade already in the queue.")
		#something goes wrong for confirm button shoul be disabled in this case
		return
	_add_upgrade_task(upgrade_id)
	var u_task = tasks_progresses[upgrade_id]
	if ResourceScripts.game_globals.free_upgrades == false and u_task.status == 'init':
		#assume cost acceptance check is made in gui. in case of reworking without this assumption this part should be removed and proper cost part should be added to handler function for on demand cost checking
		for i in upgrade_next_state.cost:
			if i == 'gold':
				money -= int(upgrade_next_state.cost[i])
			else:
				materials[i] -= int(upgrade_next_state.cost[i])
		u_task.status = 'active'
	
	if ResourceScripts.game_globals.instant_upgrades:
		level_up_upgrade(upgrade_id)
		u_task.status = 'completed'
	else:
		crafting_lists.building.append(upgrade_id)

#inventory
func set_money(value):
	money = value
	globals.emit_signal("update_clock")


func materials_set(value):
	var text = ''
	for i in value:
		if oldmaterials.has(i) == false || oldmaterials[i] != value[i]:
			if oldmaterials.has(i) == false:
				oldmaterials[i] = 0
			else:
				if oldmaterials[i] - value[i] < 0:
					text += 'Gained '
					input_handler.emit_signal("MaterialObtained", i)
				else:
					text += "Lost "
				text += str(value[i] - oldmaterials[i]) + ' {color=yellow|' + Items.materiallist[i].name + '}'
				#logupdate(text)
	materials = value
	oldmaterials = materials.duplicate()


func remove_item(itemcode, number):
	while number > 0:
		var item
		for i in items.values():
			if i.code == itemcode or i.itembase == itemcode:
				item = i
				if item.owner == null:
					break
		if item != null:
			if item.owner != null:
				characters_pool.get_char_by_id(item.owner).unequip(item, false)
			item.amount -= 1
		else:
			break
		number -= 1
#


func remove_item_id(id):
	items.erase(id)


func set_material(material, operant, value):
	match operant:
		'+':
			gain_material(material, value)
		'-':
			materials[material] -= value
		'*':
			materials[material] *= value
		"/":
			materials[material] /= value
		'=':
			materials[material] = value


func get_food():
	var counter = 0
	for i in materials:
		if Items.materiallist[i].type == 'food':
			counter += materials[i]
	return counter


func get_item_amount(item_id, free = true):
	var res = 0
	for i in items.values():
		if i.code == item_id or i.itembase == item_id:
			if free and i.owner != null:
				res += 0
			else:
				res += i.amount
	return res


#mansion

#How many people the household can hold: the beds it actually has. This used to be an
#abstract number off the 'rooms' upgrade, which said the same thing a second time and could
#disagree with the floorplan the player was looking at. Beds are the one answer now.
func get_pop_cap():
	if ResourceScripts.game_globals.unlimited_popcap:
		return 100
	return MansionLayout.total_sleep_capacity(mansion_layout)


#The ceiling, used only to tell "go build another bedroom" apart from "there is nowhere left
#to put one" - so it is what the mansion could hold if every slot were a full bedroom.
func get_pop_cap_limit():
	return MansionLayout.max_sleep_capacity(mansion_layout)


#checks
func if_has_money(value):
	return (money >= value)


func if_has_material(mat, operant, val):
	if !materials.has(mat): return false
	return input_handler.operate(operant, materials[mat], val)


func if_has_items(name, operant, value, free = false):
	var counter = 0
	for i in items.values():
		if i.itembase == name:
			if free and i.owner != null:
				counter += 0
			else:
				counter += i.amount
	return input_handler.operate(operant, counter, value)


func if_has_item_with_tag(value):
	for i in items.values():
		if i.tags.has(value):
			return true
	return false


func unlock_upgrade(upgrade, level):
	level_up_upgrade(upgrade, level)


func if_has_upgrade(upgrade, level):
	if !upgrades.has(upgrade): return false
	else: return upgrades[upgrade] >= level


func update_money(operant, value):
	match operant:
		'+':
			money += value
			globals.text_log_add('money',"Gold get: " + str(value))
		'-':
			if money < value:
				value = money
			money -= value
			globals.text_log_add('money',"Gold used: " + str(value))
		'=':
			money = value
	globals.emit_signal("update_clock")


func update_materials(operant, material, value):
	match operant:
		'+':
			gain_material(material, value)
		'-':
			materials[material] -= value
		'=':
			materials[material] = value
	globals.emit_signal("update_clock")


func get_item_id_by_code(itembase):
	for item in items.values():
		if item.itembase == itembase:
			return item.id
	return null


func findupgradelevel(upgrade_code):
	var rval = 0
	if upgrades.has(upgrade_code):
		rval = upgrades[upgrade_code]
	return int(rval)


func make_item(temp, character):
	var temprecipe = tasks_progresses[temp]
	var recipe = Items.recipes[temprecipe.id]
	temprecipe.resources_taken = false
	var product_name
	if recipe.resultitemtype == 'material':
		gain_material(recipe.resultitem, recipe.resultamount)
		product_name = tr(Items.materiallist[recipe.resultitem].name)
	else:
		var item = Items.itemlist[recipe.resultitem]
		product_name = tr(item.name)
		if randf() < 0.25:
			input_handler.get_person_for_chat([character.id], 'item_created')
		if item.type == 'usable':
			globals.AddItemToInventory(globals.CreateUsableItem(item.code))
		elif item.type == 'gear':
			var true_item
			if recipe.crafttype == 'modular':
				true_item = globals.CreateGearItemCraft(item.code, temprecipe.partdict, character)
			else:
				true_item = globals.CreateGearItem(item.code, {})
			if true_item.quality == 'legendary':
				character.try_rise_fame('craft_legend')
			elif true_item.quality == 'epic':
				character.try_rise_fame('craft_epic')
			globals.AddItemToInventory(true_item)
	globals.mansion_activity_log_add("craft", tr("MANSION_ACTIVITY_CRAFT_COMPLETE") % [character.get_short_name(), product_name])
	var product_icon = Items.materiallist[recipe.resultitem].icon if recipe.resultitemtype == 'material' else Items.itemlist[recipe.resultitem].icon
	globals.emit_signal("work_produced", character.id, temp, product_icon)


#func make_item_sequence(currenttask, craftingitem, character):
#	if craftingitem.workunits >= craftingitem.workunits_needed:
#		make_item(craftingitem, character)
#		if craftingitem.repeats > 0:
#			craftingitem.repeats -= 1
#		craftingitem.workunits -= craftingitem.workunits_needed
#		return craftingitem.workunits
#	else:
#		return 0


func get_farm_slots():
	#asked politely: the upgrade that widened this is retired, and a save from after that has
	#no such key at all
	#The farms on the grounds say how many hands the estate can put to this. The old answer
	#was a base number plus a level of the retired 'farm_slots' upgrade, which has been zero
	#since the tree went - so the job screen and the farm's own card would have disagreed
	#about how many people fit.
	return farm_places()


func level_up_upgrade(upgrade_id, level = null):
	if level != null:
		upgrades[upgrade_id] = level
	elif upgrades.has(upgrade_id):
		upgrades[upgrade_id] += 1
	else:
		upgrades[upgrade_id] = 1
	input_handler.achievements.try_add_upgrade_achimnt(upgrade_id)


#2rework
func check_recipe_resources(temp):
	var temprecipe = tasks_progresses[temp]
	var recipe = Items.recipes[temprecipe.id]
	if recipe.crafttype == 'basic':
		var check = true
		for i in recipe.materials:
			if materials[i] < recipe.materials[i]:
				check = false
		for i in recipe.items:
			if if_has_items(i, 'gte', recipe.items[i], true) == false:
				check = false
		if check == false:
			return false
	else:
		var item = Items.itemlist[recipe.resultitem]
		var check = true
		var sum_cost = {}
		for i in temprecipe.partdict:
			if sum_cost.has(temprecipe.partdict[i]):
				 sum_cost[temprecipe.partdict[i]] += item.parts[i]
			else:
				sum_cost[temprecipe.partdict[i]] = item.parts[i]
		for i in sum_cost:
			if materials[i] < sum_cost[i]:
				check = false
		if check == false:
			return false
	return true


func check_recipe_amount(temprecipe):
#	var temprecipe = tasks_progresses[temp]
	var recipe = Items.recipes[temprecipe.id]
	var res = 9999
	if recipe.crafttype == 'basic':
		for i in recipe.materials:
			if materials[i] < recipe.materials[i] * res:
				res = int(materials[i]) / int(recipe.materials[i])
		for i in recipe.items:
			var amount = get_item_amount(i, true)
			if amount < recipe.items[i] * res:
				res = int(amount) / int(recipe.items[i])
	else:
		var item = Items.itemlist[recipe.resultitem]
		var sum_cost = {}
		for i in temprecipe.partdict:
			if sum_cost.has(temprecipe.partdict[i]):
				 sum_cost[temprecipe.partdict[i]] += item.parts[i]
			else:
				sum_cost[temprecipe.partdict[i]] = item.parts[i]
		for i in sum_cost:
			if materials[i] < sum_cost[i] * res:
				res = int(materials[i]) / int(sum_cost[i])
	return res


func spend_resources(temp, amount = 1):
	if amount <= 0:
		return
	var temprecipe = tasks_progresses[temp]
	var recipe = Items.recipes[temprecipe.id]
	if recipe.crafttype == 'basic':
		for i in recipe.materials:
			materials[i] -= recipe.materials[i] * amount
		for i in recipe.items:
			remove_item(i, recipe.items[i] * amount)
	else:
		var item = Items.itemlist[recipe.resultitem]
		for i in temprecipe.partdict:
			materials[temprecipe.partdict[i]] -= item.parts[i] * amount
