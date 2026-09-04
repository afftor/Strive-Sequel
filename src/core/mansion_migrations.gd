extends Reference
#One-time repairs for saves written before the mansion had rooms of its own. Every one of
#these spends a retired key and erases it, so a save only ever passes through them once and
#a new game never touches them at all.
#
#They live apart from game_res.gd because that is where the estate is kept, not where its
#history is rewritten - and because this file only grows as more of the old tree retires.
#The state is passed in rather than reached for: game_res preloads this, so it must not go
#looking for autoloads of its own.

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")


static func run(res):
	#Order matters, and it is one-way: a room raised here takes a slot nothing gives back.
	#The named rooms come first - a bath is a bath and nothing else will do - and the old
	#'rooms' upgrade fills whatever is left with bedrooms, because "more beds" is the one
	#thing that can go anywhere. Filling first left a save with 34 bedrooms, no free slot,
	#and a bathhouse and forge it had paid for and could not be given.
	convert_room_tree_upgrades(res)
	convert_master_bedroom_upgrade(res)
	convert_gather_upgrades(res)
	convert_room_upgrade(res)
	attach_gather_jobs_to_buildings(res)
	seat_farm_workers(res)
	forget_spent_upgrades(res)


#What is left once every conversion has had its turn. A code the tree no longer sells and no
#room inherits bought something that does not exist any more - builder crews, farm slots, the
#trader - and keeping it only leaves rubbish in the save. A code that DOES have an heir is
#kept even when it could not be spent: a mansion with no free slot gets its bathhouse the day
#one is cleared, rather than losing what it paid for.
static func forget_spent_upgrades(res):
	var owed = ['rooms', 'master_bedroom']
	for code in ROOM_CONVERSION:
		owed.append(code)
	for code in GATHER_CONVERSION:
		owed.append(code)
	for code in res.upgrades.keys():
		if upgradedata.upgradelist.has(code) or owed.has(code):
			continue
		res.upgrades.erase(code)


#The rest of the retired tree. A craft upgrade's three levels were the workshop itself and
#two grades of what it could then make, so they come back as the room plus its Expansion -
#Expansion being what the recipes read, see game_res.craft_room_level(). Tools is a separate
#purchase now and buys speed only, so nothing here is owed it. The bath became a bathhouse, and
#somewhere to be taught became a practice room with a tutor's place in it. Everything else
#the tree sold - builder crews, their tools, farm slots, the exotic trader - had no room to
#become and is simply gone, which is why nothing reads those codes any more.
const ROOM_CONVERSION = {
	resting = {room = 'bathhouse'},
	academy = {room = 'practice_room', upgrade = 'tutoring_area'},
	tailor = {room = 'tailor_workshop', upgrade = 'craft_expansion', level_offset = -1},
	forge = {room = 'forge', upgrade = 'craft_expansion', level_offset = -1},
	alchemy = {room = 'alchemy_room', upgrade = 'craft_expansion', level_offset = -1},
}


#Which building each retired gathering upgrade became, and which of that building's res.upgrades
#its levels are worth. The seven that are not here bought a separate job for one more
#material; those res.materials come out of a building's loot table now, so their levels buy the
#table instead.
const GATHER_CONVERSION = {
	resource_gather_fish = {room = 'fishing_hut', upgrade = 'gather_hands'},
	resource_gather_meat = {room = 'hunting_cabin', upgrade = 'larger_cabin'},
	resource_gather_veges = {room = 'garden', upgrade = 'gather_hands'},
	resource_gather_grain = {room = 'wheat_field', upgrade = 'gather_hands'},
	resource_gather_wood = {room = 'forestry', upgrade = 'larger_cabin'},
	resource_gather_stone = {room = 'mine', upgrade = 'extended_shafts'},
	resource_gather_cloth = {room = 'garden', upgrade = 'rich_soil'},
	resource_gather_cloth_silk = {room = 'garden', upgrade = 'rich_soil'},
	resource_gather_wood_iron = {room = 'forestry', upgrade = 'rare_woods'},
	resource_gather_wood_magic = {room = 'forestry', upgrade = 'rare_woods'},
	resource_gather_iron = {room = 'mine', upgrade = 'deeper_veins'},
	resource_gather_mithril = {room = 'mine', upgrade = 'deeper_veins'},
	resource_gather_obsidian = {room = 'mine', upgrade = 'deeper_veins'},
}


#The old global upgrade said how many people fit in the master's bed; the room's own
#Furnishing says it now. A save carrying the old one keeps what it paid for, and the key
#erases itself once spent - the same shape as convert_room_upgrade(res) below.


#The old global upgrade said how many people fit in the master's bed; the room's own
#Furnishing says it now. A save carrying the old one keeps what it paid for, and the key
#erases itself once spent - the same shape as convert_room_upgrade(res) below.
static func convert_master_bedroom_upgrade(res):
	if !res.upgrades.has('master_bedroom'):
		return
	var levels = int(res.upgrades.master_bedroom)
	res.upgrades.erase('master_bedroom')
	if levels <= 0:
		return
	var entry = MansionLayout.master_room(res.mansion_layout)
	if entry == null:
		return
	var top = RoomTypes.max_level('furnishing', 'master_bedroom')
	entry.room.upgrades['furnishing'] = int(min(top,
		max(MansionLayout.upgrade_level(entry.room, 'furnishing'), levels)))


#The old 'rooms' upgrade was a stand-in for bedrooms: each level simply let the household hold
#six more people, with nothing on the floorplan to show for it. Now that beds are real, it
#would be the same fact told twice - and the two could disagree.
#
#So a save still carrying it gets the rooms it had already paid for, actually built, once. The
#player keeps every place they had; they can now see them, move them and knock them down.
#New games never have the key at all, because it is gone from the upgrade tree.
#The estate's gathering used to be thirteen entries in the global upgrade tree; it is six
#buildings on the grounds now. A save carrying the old levels gets the buildings raised, free
#and already standing, at the level it had paid for.
#
#Two losses are real and worth naming: a ladder that ran to seven or eight levels tops out at
#the building's four, and the seven res.upgrades that each bought one more material now buy a
#branch of a loot table instead, so several of them can land on the same upgrade. Both take
#the best claim rather than adding, so nothing is counted twice.
#Hands the house what the retired tree had been paid for. A room the save already has is
#improved rather than duplicated, and a room it lacks is put up free - the same one indulgence
#raise_grounds_building(res, ) makes out on the grounds, and only ever for a save being carried
#forward. Erases the keys as it goes, so it can only ever be spent once.


#The old 'rooms' upgrade was a stand-in for bedrooms: each level simply let the household hold
#six more people, with nothing on the floorplan to show for it. Now that beds are real, it
#would be the same fact told twice - and the two could disagree.
#
#So a save still carrying it gets the rooms it had already paid for, actually built, once. The
#player keeps every place they had; they can now see them, move them and knock them down.
#New games never have the key at all, because it is gone from the upgrade tree.
#The estate's gathering used to be thirteen entries in the global upgrade tree; it is six
#buildings on the grounds now. A save carrying the old levels gets the buildings raised, free
#and already standing, at the level it had paid for.
#
#Two losses are real and worth naming: a ladder that ran to seven or eight levels tops out at
#the building's four, and the seven res.upgrades that each bought one more material now buy a
#branch of a loot table instead, so several of them can land on the same upgrade. Both take
#the best claim rather than adding, so nothing is counted twice.
#Hands the house what the retired tree had been paid for. A room the save already has is
#improved rather than duplicated, and a room it lacks is put up free - the same one indulgence
#raise_grounds_building(res, ) makes out on the grounds, and only ever for a save being carried
#forward. Erases the keys as it goes, so it can only ever be spent once.
static func convert_room_tree_upgrades(res):
	for code in ROOM_CONVERSION:
		if !res.upgrades.has(code):
			continue
		var levels = int(res.upgrades[code])
		res.upgrades.erase(code)
		if levels <= 0:
			continue
		var target = ROOM_CONVERSION[code]
		var room = MansionLayout.first_room_of_type(res.mansion_layout, target.room)
		if room == null:
			room = raise_house_room(res, target.room)
		if room == null:
			continue
		if !target.has('upgrade'):
			continue
		var wanted = levels + int(target.get('level_offset', 0))
		if wanted <= 0:
			continue
		var top = RoomTypes.max_level(target.upgrade, room.type)
		room.upgrades[target.upgrade] = int(min(top,
			max(MansionLayout.upgrade_level(room, target.upgrade), wanted)))
	res.sync_room_tasks()


#The same free standing-up as raise_grounds_building(), for a room that belongs indoors. A
#room already paid for is owed whether or not the house has a clear slot left, so this clears
#a derelict one for it - the house is mostly rubble to begin with, and refusing a purchase
#because of that would be taking it away.
static func raise_house_room(res, type_code):
	var slot = MansionLayout.free_or_cleared_slot(res.mansion_layout, type_code)
	if slot == null:
		return null
	if !MansionLayout.build_room(res.mansion_layout, slot.floor, slot.slot, type_code):
		return null
	if slot.cleared:
		#quietly: this runs inside a load, where nothing can be shown to anybody yet
		res.claim_rubble_find(slot.floor, slot.slot, false)
	return MansionLayout.get_room(MansionLayout.get_floor(res.mansion_layout, slot.floor), slot.slot)


#A save written before buildings had jobs of their own carries one gathering task per material
#with no building named on it. Left alone it would sit beside the per-building jobs as a third
#thing nobody can see, still holding whoever was working it. Each is handed to the building
#that does that work - the first of its kind, which is the only one such a save can have.


#A save written before buildings had jobs of their own carries one gathering task per material
#with no building named on it. Left alone it would sit beside the per-building jobs as a third
#thing nobody can see, still holding whoever was working it. Each is handed to the building
#that does that work - the first of its kind, which is the only one such a save can have.
#The estate's own gathering used to be one job per material for the whole household. Each is
#handed to the building that does that work now; one with no building left to do it is work
#the estate can no longer perform, so it is called off and its people are freed rather than
#left standing on a job nothing draws.
#
#Only the estate's own. A settlement gathers wood through the same task template as a
#forestry does, so matching on the template alone would have taken a job being worked in
#some other town and pinned it to a shed on the grounds.
static func attach_gather_jobs_to_buildings(res):
	var grounds = MansionLayout.grounds_floor(res.mansion_layout)
	var floor_data = MansionLayout.get_floor(res.mansion_layout, grounds) if grounds >= 0 else null
	var home = ResourceScripts.game_world.mansion_location
	var moved = 0
	var called_off = []
	for task_id in res.active_tasks.gathering.duplicate():
		if !res.tasks_progresses.has(task_id):
			continue
		var tprogress = res.tasks_progresses[task_id]
		if str(tprogress.get('room_slot', '')) != '' or tprogress.location != home:
			continue
		var task_code = tasks.find_task_for_res(tprogress.job)
		if task_code == null or !tasks.tasklist[task_code].has('room_type'):
			continue
		var wanted = tasks.tasklist[task_code].room_type
		var found = null
		if floor_data != null:
			for slot_code in floor_data.slots:
				var room = MansionLayout.get_room(floor_data, slot_code)
				if room != null and room.type == wanted:
					found = slot_code
					break
		if found != null:
			tprogress.room_slot = found
			moved += 1
		else:
			called_off.append(task_id)
	for task_id in called_off:
		res.clean_task(task_id)
	if moved > 0 or !called_off.empty():
		print_debug("mansion: %d gathering jobs given to their building, %d called off"
			% [moved, called_off.size()])
	return moved


static func convert_gather_upgrades(res):
	var owed = {}
	for code in GATHER_CONVERSION:
		if !res.upgrades.has(code):
			continue
		var levels = int(res.upgrades[code])
		res.upgrades.erase(code)
		if levels <= 0:
			continue
		var target = GATHER_CONVERSION[code]
		var key = "%s/%s" % [target.room, target.upgrade]
		owed[key] = int(max(owed.get(key, 0), levels))
	if owed.empty():
		return
	var grounds = MansionLayout.grounds_floor(res.mansion_layout)
	if grounds < 0:
		return
	for key in owed:
		var parts = key.split("/")
		var room = MansionLayout.first_room_of_type(res.mansion_layout, parts[0])
		if room == null:
			room = raise_grounds_building(res, grounds, parts[0])
		if room == null:
			continue
		var top = RoomTypes.max_level(parts[1], room.type)
		room.upgrades[parts[1]] = int(min(top,
			max(MansionLayout.upgrade_level(room, parts[1]), owed[key])))
	res.sync_room_tasks()


#Puts a building on the first free plot of the grounds, no cost and no builders - the one way
#a building appears without being raised, and only ever for a save being brought forward.
static func raise_grounds_building(res, grounds, type_code):
	var floor_data = MansionLayout.get_floor(res.mansion_layout, grounds)
	if floor_data == null:
		return null
	for slot_code in floor_data.slots:
		if MansionLayout.build_room(res.mansion_layout, grounds, slot_code, type_code):
			return MansionLayout.get_room(floor_data, slot_code)
	return null



#The farm used to be one estate-wide job worked from a screen of two slots, with no building
#behind it. It is buildings now, each holding its own hands, so a save that has people farming
#needs farms raised for them and those people moved onto the farm they are standing in.
static func seat_farm_workers(res):
	if !res.tasks_progresses.has('farming'):
		return 0
	var workers = res.tasks_progresses.farming.workers
	if !(workers is Array) or workers.empty():
		return 0
	#Loading a save reaches here before the party does: globals.LoadGame runs
	#game_res.fix_serialization() first and game_party.fix_serialization() after it, so the
	#hands are still the dictionaries they were saved as, and a dictionary cannot be taken off
	#one task and put on another. Leave the old farming job standing and let the party run this
	#again from its own fix_serialization_postload(), once everybody is a character.
	for char_id in workers:
		var candidate = ResourceScripts.game_party.characters.get(char_id, null)
		if candidate != null and !(candidate is Object):
			return 0
	var grounds = MansionLayout.grounds_floor(res.mansion_layout)
	if grounds < 0:
		return 0
	var raised = 0
	#one plot per farm, and the grounds can run out - anyone left over keeps farming until
	#they are given work elsewhere, which is the honest answer to having nowhere to put them
	while res.farm_places() < workers.size():
		if raise_grounds_building(res, grounds, 'farm') == null:
			break
		raised += 1
	res.sync_room_tasks()
	var moved = 0
	for char_id in workers.duplicate():
		var room = first_farm_with_room(res)
		if room == null:
			break
		var person = ResourceScripts.game_party.characters.get(char_id, null)
		if person == null:
			workers.erase(char_id)
			continue
		person.remove_from_task()
		person.assign_to_task(room.task_id)
		#assign_to_task turns a full task down without a word, so the count is taken from
		#where they actually ended up rather than from having asked
		if person.get_work() == room.task_id:
			moved += 1
	if raised > 0 or moved > 0:
		print_debug("mansion: %d farm(s) raised, %d farm hands moved into them" % [raised, moved])
	return moved


#The first farm with a place going. Asked again for every person, because taking one on is
#what fills the place that decides where the next one goes.
static func first_farm_with_room(res):
	var grounds = MansionLayout.grounds_floor(res.mansion_layout)
	if grounds < 0:
		return null
	var floor_data = MansionLayout.get_floor(res.mansion_layout, grounds)
	for slot_code in floor_data.slots:
		var room = MansionLayout.get_room(floor_data, slot_code)
		if room == null or room.type != 'farm' or room.task_id == null:
			continue
		var task = res.tasks_progresses.get(room.task_id, null)
		if task == null:
			continue
		if task.workers.size() < int(task.max_workers):
			return room
	return null


static func convert_room_upgrade(res):
	if !res.upgrades.has('rooms'):
		return
	var levels = int(res.upgrades.rooms)
	res.upgrades.erase('rooms')
	if levels <= 0:
		return
	#The old upgrade sold a population cap, and a save that had cheated it to nine thousand
	#asks for more beds than the mansion has slots - which filled every last one with
	#bedrooms and left nothing to build in. Beds are owed to the household that exists, not
	#to a number: enough for everybody with a little room to grow, and never more than the
	#cap that was bought.
	var wanted = variables.base_population_cap 		+ variables.population_cap_per_room_upgrade * levels
	var household = ResourceScripts.game_party.characters.size()
	#quietly: a save is being loaded, and nothing can be shown to anybody yet
	res.house_at_least(int(min(wanted, max(variables.base_population_cap, household + 4))), false)


#Raises plain bedrooms, free and already standing, until the mansion sleeps at least this
#many. The one way rooms appear without a builder having put them up, so the three callers
#that are allowed to do it - the old-save conversion, the starting bonus, test mode - all
#come through here and are countable.
#
#New beds are seated straight away: the point of handing them out is that nobody is left
#standing, and the end of the turn asks that question of the layout rather than of the cap.
