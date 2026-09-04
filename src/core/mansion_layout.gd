extends Reference
#Pure model for the mansion floorplan shown by gui_modules/mansion_view.
#No nodes, no state of its own - every function is static and operates on the plain
#dictionary stored in ResourceScripts.game_res.mansion_layout.
#
#The level map owns geometry. Slots sit at fixed coordinates defined by the designer in
#mansion_floor_plans.gd, and the player never moves anything: they choose what to build
#into a slot and which two slots trade contents. So a room carries no position and no
#size at all - it is a type, its upgrades and its people, and the slot supplies the rest.
#
#A slot has three states, derived from two persisted facts:
#	broken - the slot itself is damaged. Clearing it out into an empty slot is done
#	         through the same builder mechanic as construction.
#	empty  - usable, nothing built
#	built  - holds a room
#
#A room holds two different kinds of people, and they are kept apart on purpose:
#	occupants - who SLEEPS here. Stored in the layout, because nothing in the game binds
#	            a character to a bed. Everyone needs one, wherever they are on the map.
#	workers   - who WORKS here. NOT stored here: the room owns a task in
#	            game_res.tasks_progresses and the existing assign_to_task() puts people in
#	            it, so a room worker is a worker as far as the rest of the game is
#	            concerned. The room only keeps the task's id.
#
#task_id lives on the room rather than on the slot so that swapping two slots carries the
#workers along with the room. Keying it by slot would silently detach character.work from
#wherever the room ended up.
#
#Everything stays JSON-safe because the layout rides along in game_res.serialize(), and
#JSON turns ints into floats on load, which is why validate() re-int()s the numbers - the
#same repair game_world.fix_serialization() does for dungeon room.col / room.row.

const RoomTypes = preload("res://assets/data/mansion_room_types.gd")
const FloorPlans = preload("res://assets/data/mansion_floor_plans.gd")

const VERSION = 5


#### construction ####

static func build_default(plan_code = 'default_manor'):
	var plan = FloorPlans.get_plan(plan_code)
	var res = {
		version = VERSION,
		plan = plan.code,
		current_floor = 0,
		next_room_id = 1,
		floors = [],
	}
	for floor_plan in plan.floors:
		res.floors.append(build_floor(floor_plan))
	for floor_index in range(plan.floors.size()):
		for slot_code in plan.floors[floor_index].prebuilt:
			var room = get_room(res.floors[floor_index], slot_code)
			if room != null:
				assign_room_id(res, room)
	hide_finds_in_rubble(res)
	return res


#What the rubble is hiding, floor by floor. Put in different rooms every game, so clearing
#one out is worth doing rather than a chore whose answer is already known. The codes mean
#nothing here - game_res.claim_rubble_find() is what knows they hand over.
#The upper floor is reached late and its rubble is cleared long after the ground floor's, so
#it hides one thing rather than three, and that one is gear rather than a purse of gold: by
#the time anyone gets up there, fifty gold is not a reason to pick up a shovel.
const RUBBLE_FINDS = ['gold', 'materials', 'sword']
const RUBBLE_FINDS_UPPER = ['goggles']


static func hide_finds_in_rubble(layout):
	hide_finds_on_floor(get_floor(layout, 0), RUBBLE_FINDS)
	hide_finds_on_floor(get_floor(layout, 1), RUBBLE_FINDS_UPPER)


static func hide_finds_on_floor(floor_data, finds):
	if floor_data == null:
		return
	var rubble = []
	for slot_code in floor_data.slots:
		if floor_data.slots[slot_code].broken:
			rubble.append(slot_code)
	rubble.shuffle()
	for index in range(min(finds.size(), rubble.size())):
		floor_data.slots[rubble[index]].find = finds[index]


static func build_floor(floor_plan):
	var floor_data = {
		code = floor_plan.code,
		#kept so validate() can tell when the designer reshaped the level map
		shape = FloorPlans.shape_signature(floor_plan),
		slots = {},
	}
	for slot_plan in floor_plan.slots:
		floor_data.slots[slot_plan.code] = make_slot(FloorPlans.slot_starts_broken(slot_plan))
	for slot_code in floor_plan.prebuilt:
		if !floor_data.slots.has(slot_code):
			print_debug("mansion_layout: prebuilt slot %s does not exist on floor %s" % [slot_code, floor_plan.code])
			continue
		floor_data.slots[slot_code].broken = false
		floor_data.slots[slot_code].room = make_room(floor_plan.prebuilt[slot_code])
	return floor_data


#The build record lives on the SLOT, not on the room, because two of the three things it
#drives happen when there is no room to hang it off: raising one from an empty slot and
#clearing out a derelict one. The third, upgrading, then falls out for free.
static func make_slot(broken = false):
	#'find' is what the rubble in this slot is hiding, if anything - see hide_finds_in_rubble()
	return {broken = broken, room = null, build = null, find = null}


static func make_room(type_code):
	return {
		type = type_code,
		task_id = null,     #key into game_res.tasks_progresses, set by assign_room_id
		occupants = [],     #who sleeps here
		upgrades = {},      #{upgrade_code: level}
		#The order this room works its discipline's queue in, as task ids. Empty means the
		#estate's own order, which is what every room did before Ledgers existed.
		craft_rules = [],
		#what a practice room is set to work on. 'stat' is the basic stat being drilled;
		#'trainer' is who is tutoring, if anybody; 'target' is a negative trait being worked
		#out instead, with 'progress' counting towards being rid of it
		practice = make_practice(),
	}


static func make_practice():
	return {stat = 'physics', trainer = null, target = null, progress = 0}


#Ids come from a counter on the layout rather than from game_res, because this file must
#not touch autoloads - see the note at the top of mansion_room_types.gd.
static func assign_room_id(layout, room):
	if room.task_id != null:
		return room.task_id
	var next_id = int(layout.get('next_room_id', 1))
	room.task_id = 'mansion_room_%d' % next_id
	layout.next_room_id = next_id + 1
	return room.task_id


#### lookups ####

static func get_floor(layout, floor_index):
	if !(layout is Dictionary) or !layout.has('floors') or !(layout.floors is Array):
		return null
	floor_index = int(floor_index)
	if floor_index < 0 or floor_index >= layout.floors.size():
		return null
	return layout.floors[floor_index]


static func get_current_floor(layout):
	return get_floor(layout, layout.current_floor)


static func get_floor_plan(layout, floor_index):
	return FloorPlans.get_floor_plan(layout.plan, floor_index)


static func get_slot(floor_data, slot_code):
	if floor_data == null or !floor_data.slots.has(slot_code):
		return null
	return floor_data.slots[slot_code]


static func get_room(floor_data, slot_code):
	var slot = get_slot(floor_data, slot_code)
	if slot == null:
		return null
	return slot.room


#'broken' | 'empty' | 'built' | 'building'
#An upgrade does not make a slot 'building': the room keeps working throughout, which is
#the whole point of upgrades being separate from construction.
static func slot_status(floor_data, slot_code):
	var slot = get_slot(floor_data, slot_code)
	if slot == null:
		return 'broken'
	if slot.build != null and slot.build.kind in ['construct', 'repair']:
		return 'building'
	if slot.broken:
		return 'broken'
	return 'built' if slot.room != null else 'empty'


static func get_build(floor_data, slot_code):
	var slot = get_slot(floor_data, slot_code)
	if slot == null:
		return null
	return slot.build


static func each_build(layout):
	var res = []
	for floor_index in range(layout.floors.size() if (layout is Dictionary and layout.has('floors')) else 0):
		var floor_data = layout.floors[floor_index]
		for slot_code in floor_data.slots:
			var slot = floor_data.slots[slot_code]
			if slot.build != null:
				res.append({floor = floor_index, slot = slot_code, build = slot.build, room = slot.room})
	return res


#Guarded because character effects ask about housing (the private-room bonus) during stat
#rebuilds, which happen while a character is being created - before the layout exists.
static func each_room(layout):
	var res = []
	if !(layout is Dictionary) or !layout.has('floors') or !(layout.floors is Array):
		return res
	for floor_index in range(layout.floors.size()):
		var floor_data = layout.floors[floor_index]
		for slot_code in floor_data.slots:
			var room = floor_data.slots[slot_code].room
			if room != null:
				res.append({floor = floor_index, slot = slot_code, room = room})
	return res


static func count_rooms_of_type(layout, type_code):
	var res = 0
	for entry in each_room(layout):
		if entry.room.type == type_code:
			res += 1
	return res


#Uniqueness has to count the ones already going up too, or two could be started at once
#and the second would have nowhere legal to land.
static func count_planned_of_type(layout, type_code):
	var res = count_rooms_of_type(layout, type_code)
	for entry in each_build(layout):
		if entry.build.kind == 'construct' and entry.build.target == type_code:
			res += 1
	return res


#What a practice room can be set to drill. Anything outside this is reset by validate() -
#the stat is written by the player through the room's card and has to be one the game grows.
const PRACTICE_STATS = ['physics', 'wits', 'charm']

#Work units a tutored character must put in before a negative trait is worked out of them.
const PRACTICE_TRAIT_PROGRESS = 60.0


#What a store room can hold of each material. The room's own base, or what its shelves have
#been raised to - each level of Shelves states the whole figure rather than an addition, so
#the effect replaces the base rather than piling onto it.
const BASE_STORAGE = 200


static func storage_capacity(room):
	if room == null or !RoomTypes.has_tag(room.type, 'storage'):
		return 0
	return int(max(BASE_STORAGE, room_effect(room).get('storage', 0)))


#Everything the estate can hold of one material: every store room it has, added together.
#Zero rooms means zero, which is what makes a delivery spill.
static func total_storage(layout):
	var res = 0
	for entry in each_room(layout):
		res += storage_capacity(entry.room)
	return res


#### upgrades and capacity ####

#Every upgrade level states its own totals, so a room's effect is just the union of its
#current levels. Two upgrades touching the same key ADD - the comment here used to promise
#the opposite, and nothing in the registry pairs such upgrades, so the promise had never
#been tested. Summing is the useful rule: two things that both widen a room widen it twice.
static func room_effect(room):
	var res = {}
	if room == null or !(room.upgrades is Dictionary):
		return res
	for code in room.upgrades:
		var effect = RoomTypes.get_effect(code, room.upgrades[code], room.type)
		for key in effect:
			res[key] = res.get(key, 0) + effect[key]
	return res


static func slot_capacity(room, kind):
	if room == null:
		return 0
	var res = RoomTypes.base_slots(room.type, kind)
	var effect = room_effect(room)
	var bonus_key = kind + '_slots'
	if effect.has(bonus_key):
		res += int(effect[bonus_key])
	return int(res)


static func sleep_capacity(room):
	return slot_capacity(room, 'sleep')


#The room's work places split three ways, so the screen can tell them apart: the ones the room
#has for being what it is, the ones its upgrades widened it by, and the ones that stand for
#somebody doing a different job in the same room - the tutor in a practice room.
static func base_work_slots(room):
	if room == null or RoomTypes.get_work_job(room.type) == null:
		return 0
	return int(RoomTypes.base_slots(room.type, 'work'))


static func special_work_slots(room):
	if room == null:
		return 0
	var res = 0
	for code in room.upgrades:
		if !RoomTypes.is_special_slot(code, room.type):
			continue
		var effect = RoomTypes.get_effect(code, room.upgrades[code], room.type)
		res += int(effect.get('work_slots', 0))
	return res


static func work_capacity(room):
	if room == null or RoomTypes.get_work_job(room.type) == null:
		return 0
	return slot_capacity(room, 'work')


#Builder places exist only while something is being built here. A slot with no room yet -
#raising a room, clearing out a derelict one - always gets exactly one; a room being
#upgraded can have widened its own scaffolding first.
#One place always, plus whatever the household's builders upgrade has added. The extra comes
#in as an argument because it is a global upgrade and this file may not read autoloads - see
#the note at the top of mansion_room_types.gd.
static func build_capacity(room, extra_builders = 0):
	return 1 + int(extra_builders) + int(room_effect(room).get('build_slots', 0))


#Sums one effect key across every room of a type - how the mansion as a whole answers
#for things like "how much company fits in the master bedroom".
static func effect_of_type(layout, type_code, key):
	var res = 0
	for entry in each_room(layout):
		if entry.room.type == type_code:
			res += int(room_effect(entry.room).get(key, 0))
	return res


static func craft_modifier(room):
	var effect = room_effect(room)
	return 1.0 + float(effect.get('craft_mod', 0))


static func upgrade_level(room, upgrade_code):
	if room == null or !(room.upgrades is Dictionary):
		return 0
	return int(room.upgrades.get(upgrade_code, 0))


#Whether the stairs have been made good. The house is inherited with them rotted through and
#one repair opens the whole staircase, so this is asked of the ground floor's set and answers
#for every floor - the way up and the way back down are the same stairs.
static func stairs_repaired(layout):
	var floor_data = get_floor(layout, 0)
	if floor_data == null:
		return false
	for slot_code in floor_data.slots:
		var room = floor_data.slots[slot_code].room
		if room != null and RoomTypes.has_tag(room.type, 'stairs'):
			return upgrade_level(room, 'stairs_repair') > 0
	return false


#Mends the stairs without them being paid for. Test mode wants both floors to look at rather
#than a repair to buy first, the same reasoning as max_out_upgrades() on the master's room.
static func open_stairs(layout):
	var floor_data = get_floor(layout, 0)
	if floor_data == null:
		return false
	for slot_code in floor_data.slots:
		var room = floor_data.slots[slot_code].room
		if room != null and RoomTypes.has_tag(room.type, 'stairs'):
			room.upgrades['stairs_repair'] = RoomTypes.max_level('stairs_repair', 'stairs')
			return true
	return false


#### room work tasks ####

#Idempotently mirrors a work room into game_res.tasks_progresses so the ordinary
#assign_to_task() path can be used against it. "tasks" is that dictionary, passed in
#rather than read, to keep this file free of autoloads.
static func ensure_room_task(layout, room, tasks):
	var job = RoomTypes.get_work_job(room.type)
	if job == null:
		return null
	assign_room_id(layout, room)
	if !tasks.has(room.task_id):
		tasks[room.task_id] = {
			id = room.task_id,
			type = 'room_work',
			job = job,
			room_type = room.type,
			#'permanent' survives tasks_cleanup(), which only drops 'completed'/'temporal'
			status = 'permanent',
			workstat = 'physics',
			worktool = 'hammer',
			workers = [],
			progress = 0,
			progress_limit = 1,
			max_workers = 0,
		}
	var task = tasks[room.task_id]
	task.job = job
	task.room_type = room.type
	task.max_workers = work_capacity(room)
	if !(task.workers is Array):
		task.workers = []
	return room.task_id


#Refreshes every room task on the layout and reports the ids that are still live, so the
#caller can drop the stale ones.
static func ensure_all_room_tasks(layout, tasks):
	var live = {}
	for entry in each_room(layout):
		var task_id = ensure_room_task(layout, entry.room, tasks)
		if task_id != null:
			live[task_id] = true
	return live


static func get_room_workers(room, tasks):
	if room == null or room.task_id == null or !tasks.has(room.task_id):
		return []
	return tasks[room.task_id].workers


#### construction, repair and upgrades ####

#Work units needed to clear a derelict slot back to empty. Free, but not instant.
#Clearing a cluttered room is a fixed piece of work rather than a race: the wreckage has to be
#carried out, and carrying it down a staircase is what makes the upper floor the longer job.
#Two turns on the ground floor, three above it, whoever is holding the shovel - a strong back
#does not make rubble smaller. 'limit' counts turns for these rather than work units, which is
#what the 'fixed' flag on the build record says (see game_res.process_room_builds).
const REPAIR_TURNS_GROUND = 2
const REPAIR_TURNS_UPPER = 3


static func repair_turns(floor_index):
	return REPAIR_TURNS_GROUND if int(floor_index) == 0 else REPAIR_TURNS_UPPER


#Clearing upstairs is its own piece of work, not the same one done slower, so it is named
#apart in every list a worker can be seen in.
static func repair_task_name(floor_index):
	if int(floor_index) == 0:
		return 'MANSIONVIEW_TASK_CLEARGROUND'
	return 'MANSIONVIEW_TASK_CLEARUPPER'


static func can_start_construct(layout, floor_index, slot_code, type_code):
	var check = can_build(layout, floor_index, slot_code, type_code)
	if !check.ok:
		return check
	return {ok = true, reason = ''}


static func can_start_repair(layout, floor_index, slot_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or !slot.broken:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if slot.build != null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BUILDING'}
	return {ok = true, reason = ''}


#One at a time, and only upgrades this room's type actually offers.
static func can_start_upgrade(layout, floor_index, slot_code, upgrade_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or slot.room == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if slot.build != null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BUILDING'}
	if !RoomTypes.get_type(slot.room.type).upgrades.has(upgrade_code):
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	var next_level = upgrade_level(slot.room, upgrade_code) + 1
	if RoomTypes.get_level_data(upgrade_code, next_level, slot.room.type) == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_MAXLEVEL'}
	return {ok = true, reason = ''}


static func next_upgrade_level(room, upgrade_code):
	return upgrade_level(room, upgrade_code) + 1


#"paid" is what the caller deducted, kept so cancelling can hand it straight back.
static func start_build(layout, floor_index, slot_code, kind, target, limit, paid = {},
		fixed = false, task_name = null):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or slot.build != null:
		return false
	var next_id = int(layout.get('next_room_id', 1))
	layout.next_room_id = next_id + 1
	slot.build = {
		kind = kind,          #'construct' | 'repair' | 'upgrade'
		target = target,      #room type code, upgrade code, or null for a repair
		level = 1,
		progress = 0.0,
		#work units, or turns when 'fixed' - see REPAIR_TURNS_GROUND
		limit = float(max(1, limit)),
		fixed = fixed,
		#what the job is called in a worker's task list; null takes the building job's own name
		task_name = task_name,
		task_id = 'mansion_build_%d' % next_id,
		refund = paid.duplicate(),
	}
	if kind == 'upgrade' and slot.room != null:
		slot.build.level = next_upgrade_level(slot.room, target)
	return true


#Returns what to give back and which task to release; the caller owns both systems.
static func cancel_build(layout, floor_index, slot_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or slot.build == null:
		return null
	var res = {refund = slot.build.refund.duplicate(), task_id = slot.build.task_id}
	slot.build = null
	return res


static func advance_build(build, amount):
	build.progress += float(amount)
	return build.progress >= build.limit


#Turns a finished build into the thing it was building. Returns the task id to release.
static func complete_build(layout, floor_index, slot_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or slot.build == null:
		return null
	var build = slot.build
	match build.kind:
		'construct':
			slot.broken = false
			slot.room = make_room(build.target)
			assign_room_id(layout, slot.room)
		'repair':
			slot.broken = false
		'upgrade':
			if slot.room != null:
				slot.room.upgrades[build.target] = int(build.level)
	slot.build = null
	return build.task_id


#Idempotently mirrors a build into tasks_progresses, the same way work rooms are mirrored,
#so builders are assigned through the ordinary assign_to_task().
static func ensure_build_task(slot, tasks, extra_builders = 0):
	if slot.build == null:
		return null
	var task_id = slot.build.task_id
	if !tasks.has(task_id):
		tasks[task_id] = {
			id = task_id,
			type = 'room_build',
			job = 'building',
			status = 'permanent',
			workstat = 'physics',
			worktool = 'hammer',
			workers = [],
			progress = 0,
			progress_limit = 1,
			max_workers = 0,
		}
	var task = tasks[task_id]
	task.max_workers = build_capacity(slot.room, extra_builders)
	if !(task.workers is Array):
		task.workers = []
	#A build that names itself keeps that name: every build is the 'building' job, so left to
	#the job list they would all read alike and clearing a room upstairs could not be told from
	#clearing one below. 'name_locked' is what stops game_res.fill_room_task_details() from
	#putting the job's own name back over it.
	var named = slot.build.get('task_name', null)
	if named != null:
		task.name = named
		task.name_locked = true
	return task_id


static func get_build_workers(build, tasks):
	if build == null or !tasks.has(build.task_id):
		return []
	return tasks[build.task_id].workers


static func can_build(layout, floor_index, slot_code, type_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if !RoomTypes.has_type(type_code):
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if slot.build != null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BUILDING'}
	if slot.broken:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BROKEN'}
	if slot.room != null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_OCCUPIED'}
	#'unique' is this same rule said for one, so both go through max_count()
	var cap = RoomTypes.max_count(type_code)
	if cap > 0 and count_planned_of_type(layout, type_code) >= cap:
		return {ok = false, reason = 'MANSIONVIEW_ERR_UNIQUE' if cap == 1 else 'MANSIONVIEW_ERR_ENOUGH'}
	return {ok = true, reason = ''}


static func build_room(layout, floor_index, slot_code, type_code):
	if !can_build(layout, floor_index, slot_code, type_code).ok:
		return false
	var room = make_room(type_code)
	assign_room_id(layout, room)
	get_slot(get_floor(layout, floor_index), slot_code).room = room
	return true


static func can_demolish(layout, floor_index, slot_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or slot.room == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	#the master's own room is not the player's to tear down
	if RoomTypes.get_type(slot.room.type).master_only:
		return {ok = false, reason = 'MANSIONVIEW_ERR_MASTERROOM'}
	#neither is the staircase - it is how the floors are reached at all
	if RoomTypes.is_fixed(slot.room.type):
		return {ok = false, reason = 'MANSIONVIEW_ERR_FIXEDROOM'}
	if slot.build != null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BUILDING'}
	return {ok = true, reason = ''}


#Returns the task id that has to be cleaned up by the caller (game_res.clean_task), which
#is what releases the workers - this file cannot reach the task system itself.
static func demolish_room(layout, floor_index, slot_code):
	if !can_demolish(layout, floor_index, slot_code).ok:
		return null
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	var task_id = slot.room.task_id
	for char_id in slot.room.occupants.duplicate():
		unassign_character(layout, char_id)
	slot.room = null
	return task_id


#### swapping ####

#Two slots trade contents, on one floor or across two. Neither may be broken, and at least
#one has to hold something. Every slot is the same size, so nothing about shape has to be
#checked. The whole room dictionary moves, so its task id, upgrades, residents and workers
#all come along - which is what makes carrying a room upstairs safe.
static func can_swap(layout, floor_a, code_a, floor_b, code_b):
	if int(floor_a) == int(floor_b) and code_a == code_b:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	var slot_a = get_slot(get_floor(layout, floor_a), code_a)
	var slot_b = get_slot(get_floor(layout, floor_b), code_b)
	if slot_a == null or slot_b == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if slot_a.broken or slot_b.broken:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BROKEN'}
	#scaffolding does not travel: a room in the middle of something stays where it is
	if slot_a.build != null or slot_b.build != null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_BUILDING'}
	if slot_a.room == null and slot_b.room == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	#the staircase is part of the building, not something standing in it
	for slot in [slot_a, slot_b]:
		if slot.room != null and RoomTypes.is_fixed(slot.room.type):
			return {ok = false, reason = 'MANSIONVIEW_ERR_FIXEDROOM'}
	return {ok = true, reason = ''}


static func swap_slots(layout, floor_a, code_a, floor_b, code_b):
	if !can_swap(layout, floor_a, code_a, floor_b, code_b).ok:
		return false
	var slot_a = get_slot(get_floor(layout, floor_a), code_a)
	var slot_b = get_slot(get_floor(layout, floor_b), code_b)
	var carried = slot_a.room
	slot_a.room = slot_b.room
	slot_b.room = carried
	return true


#### repair ####

static func can_repair(layout, floor_index, slot_code):
	var slot = get_slot(get_floor(layout, floor_index), slot_code)
	if slot == null or !slot.broken:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	return {ok = true, reason = ''}


static func repair_slot(layout, floor_index, slot_code):
	if !can_repair(layout, floor_index, slot_code).ok:
		return false
	get_slot(get_floor(layout, floor_index), slot_code).broken = false
	return true


#### sleeping residents ####

static func get_slot_of_character(layout, char_id):
	for entry in each_room(layout):
		if entry.room.occupants.has(char_id):
			return {floor = entry.floor, slot = entry.slot, room = entry.room}
	return null


static func lives_in_room_with_tag(layout, char_id, tag):
	var placed = get_slot_of_character(layout, char_id)
	if placed == null:
		return false
	return RoomTypes.has_tag(placed.room.type, tag)


#The master never leaves his own room, so nothing may take him out of it.
static func is_pinned(layout, char_id, is_master):
	if !is_master:
		return false
	var placed = get_slot_of_character(layout, char_id)
	return placed != null and RoomTypes.get_type(placed.room.type).master_only


#Gives somebody a bed without being asked, which is what happens when they join the
#household. The master goes to his own room and nowhere else; everyone else takes the
#first free bed that will have them. Returns true once they have somewhere to sleep.
static func autohouse(layout, char_id, is_master = false, master_id = null, consents = true):
	if get_slot_of_character(layout, char_id) != null:
		return true
	if is_master:
		for entry in each_room(layout):
			if !RoomTypes.get_type(entry.room.type).master_only:
				continue
			if assign_character(layout, entry.floor, entry.slot, char_id, true, master_id).ok:
				return true
		return false
	for entry in each_room(layout):
		#Who shares the master's bed is the player's choice, never a fallback. His room sits
		#early in this walk, so without this buying Bed size quietly filled it with whoever
		#happened to need a bed that turn - and handed them the affection that goes with it.
		if RoomTypes.get_type(entry.room.type).master_only:
			continue
		if assign_character(layout, entry.floor, entry.slot, char_id, false, master_id, consents).ok:
			return true
	return false


#Everyone in the party who has nowhere to sleep, seated wherever there is room. "masters"
#is the set of ids that are the master, passed in because this file cannot look one up.
static func autohouse_all(layout, party, masters = {}, consenting = {}):
	var master_id = masters.keys()[0] if !masters.empty() else null
	var seated = 0
	#the master goes first, so his room stops being held against everybody else
	for char_id in masters:
		if autohouse(layout, char_id, true, master_id):
			seated += 1
	for char_id in party:
		if masters.has(char_id):
			continue
		if autohouse(layout, char_id, false, master_id, consenting.has(char_id)):
			seated += 1
	return seated


static func unassign_character(layout, char_id):
	var removed = false
	for entry in each_room(layout):
		while entry.room.occupants.has(char_id):
			entry.room.occupants.erase(char_id)
			removed = true
	return removed


#The binding lives in the layout only - the character object is never touched, which
#keeps housing independent of the job system. "is_master" is passed in because this file
#cannot look a character up.
#"consents" answers whether this character may be put in the master's bed. It comes in as an
#argument because the answer is about slave class and negotiated permissions, and this file
#may not read a character - see game_res.shares_master_bed() for who says yes.
static func assign_character(layout, floor_index, slot_code, char_id, is_master = false, master_id = null, consents = true):
	var room = get_room(get_floor(layout, floor_index), slot_code)
	if room == null:
		return {ok = false, reason = 'MANSIONVIEW_ERR_VOID'}
	if room.occupants.has(char_id):
		return {ok = true, reason = ''}
	#Putting somebody into a bed takes them out of the one they were in - see the
	#unassign_character() below - so moving the master into any other room is one of the ways
	#of getting him out of his own. Taking him out was already refused; this is the same
	#refusal at the other door, and it is the door every way of moving anybody goes through.
	if is_pinned(layout, char_id, is_master):
		return {ok = false, reason = 'MANSIONVIEW_ERR_MASTERPINNED'}
	#nobody shares that bed who has not agreed to
	if RoomTypes.get_type(room.type).master_only and !is_master and !consents:
		return {ok = false, reason = 'MANSIONVIEW_ERR_NOCONSENT'}
	#exactly one bed in the master's room is his, whatever Bed size has widened it to. It
	#only stops being held once he is actually in it.
	if RoomTypes.get_type(room.type).master_only and !is_master:
		var reserved = 0 if (master_id != null and room.occupants.has(master_id)) else 1
		if room.occupants.size() + reserved >= sleep_capacity(room):
			return {ok = false, reason = 'MANSIONVIEW_ERR_MASTERBED'}
	if room.occupants.size() >= sleep_capacity(room):
		return {ok = false, reason = 'MANSIONVIEW_ERR_FULL'}
	unassign_character(layout, char_id)
	room.occupants.append(char_id)
	return {ok = true, reason = ''}


#Which floor is the estate grounds, or -1. The grounds are a floor of the layout so that
#raising a barn uses the same builders and the same save as raising a bedroom - but they are
#not part of the house: no staircase leads there, and the local tasks screen draws them.
static func grounds_floor(layout):
	return FloorPlans.grounds_index(layout.get('plan', 'default_manor'))


static func is_grounds(layout, floor_index):
	return int(floor_index) == grounds_floor(layout)


#Floors of the house proper, in order - everything the staircase walks between.
static func house_floors(layout):
	var res = []
	var grounds = grounds_floor(layout)
	for index in range(layout.floors.size()):
		if index != grounds:
			res.append(index)
	return res


#The first room of this type anywhere on the plan, or null. Every type that uses this is
#unique, so "the first" is "the one".
#The best any room of this kind has reached, across the whole estate. Asking the first one
#found is not the same question: craft rooms may be built more than once, so a plain forge
#raised before a well-equipped one would answer for both and refuse recipes already earned.
static func best_upgrade_level(layout, type_code, upgrade_code):
	var res = -1
	for entry in each_room(layout):
		if entry.room.type != type_code:
			continue
		res = max(res, upgrade_level(entry.room, upgrade_code))
	return res


static func first_room_of_type(layout, type_code):
	for entry in each_room(layout):
		if entry.room.type == type_code:
			return entry.room
	return null


#The master's own room, wherever on the plan it stands, as an each_room entry - or null when
#the mansion has not got one.
static func master_room(layout):
	for entry in each_room(layout):
		if RoomTypes.get_type(entry.room.type).master_only:
			return entry
	return null


#Every upgrade this sort of room has, at its top level.
static func max_out_upgrades(room):
	if room == null:
		return false
	for code in RoomTypes.get_type(room.type).upgrades:
		room.upgrades[code] = RoomTypes.max_level(code, room.type)
	return true


#Whether this room has nothing left to buy - the state max_out_upgrades() writes. Every row
#the type offers is asked, not only the one that opens recipes: a workshop is finished when
#its bench, its tools and everything else in it are at their top level. Asked of a room
#instance rather than of the estate, because upgrades belong to the room - a plain forge
#standing beside a finished one is not half of anything.
#A type with nothing to buy answers true, having bought all nothing of it.
static func all_upgrades_maxed(room):
	if room == null:
		return false
	for code in RoomTypes.get_type(room.type).upgrades:
		if upgrade_level(room, code) < RoomTypes.max_level(code, room.type):
			return false
	return true


#Everyone in the party who has no bed. This is what blocks the end of the turn, so it
#counts characters wherever they are on the world map.
static func unhoused_characters(layout, party):
	var res = []
	if party == null or !(party is Dictionary):
		return res
	if !(layout is Dictionary) or !layout.has('floors'):
		return res
	var housed = {}
	for entry in each_room(layout):
		for char_id in entry.room.occupants:
			housed[char_id] = true
	for char_id in party:
		if !housed.has(char_id):
			res.append(char_id)
	return res


static func total_sleep_capacity(layout):
	var res = 0
	for entry in each_room(layout):
		res += sleep_capacity(entry.room)
	return res


#The most people this mansion could ever sleep: every slot it has filled with the roomiest
#bedroom that may be built more than once, upgraded as far as that goes. Broken slots count,
#because repairing one is a thing the player can go and do.
#
#This is the ceiling "you need more rooms" is measured against, so it must be reachable in
#principle and can never read as lower than what is already standing.
static func max_sleep_capacity(layout):
	var per_slot = best_repeatable_beds()
	var slots = 0
	for floor_data in layout.floors:
		slots += floor_data.slots.size()
	return int(max(per_slot * slots, total_sleep_capacity(layout)))


#Beds in the best bedroom a player may build over and over. Unique rooms and the master's own
#are left out: neither can be the answer to "build another one".
static func best_repeatable_beds():
	var res = 0
	for type_code in RoomTypes.LIST:
		var type_data = RoomTypes.LIST[type_code]
		if RoomTypes.max_count(type_code) == 1 or type_data.master_only:
			continue
		var beds = RoomTypes.base_slots(type_code, 'sleep')
		if beds <= 0:
			continue
		#room_effect() sums the upgrades a room carries, so the best case is every one of
		#them at its top level at once
		for upgrade_code in type_data.upgrades:
			var top = RoomTypes.max_level(upgrade_code, type_code)
			if top > 0:
				beds += int(RoomTypes.get_effect(upgrade_code, top, type_code).get('sleep_slots', 0))
		res = max(res, beds)
	return int(res)


#Fills empty slots with plain bedrooms until the mansion sleeps at least this many, or until
#it runs out of slots. Only the one-time conversion of the old 'rooms' upgrade uses this -
#nothing else builds rooms without a builder standing in them.
#Beds first from the rooms already standing. A bedroom widened to its full eight sleeps twice
#what a bare one does without costing a slot, and a slot spent on a fifth bedroom is a slot
#that can never be a bathhouse. Only once every bedroom is full does this raise another.
#Returns the derelict slots it had to clear to find the room, so the caller can hand over what
#the rubble was hiding.
static func build_bedrooms_up_to(layout, wanted, spare_finds = false):
	var cleared = []
	for entry in each_room(layout):
		if total_sleep_capacity(layout) >= wanted:
			return cleared
		if entry.room.type != 'bedrooms':
			continue
		var top = RoomTypes.max_level('bedrooms_expansion', 'bedrooms')
		if upgrade_level(entry.room, 'bedrooms_expansion') < top:
			entry.room.upgrades['bedrooms_expansion'] = top
	#Beds are handed out rather than built, so they take a room the same way any other gift
	#does - and through the same call, which is what keeps them out of the estate grounds. The
	#derelict rooms opened on the way go back to the caller, which claims what was under them.
	while total_sleep_capacity(layout) < wanted:
		var slot = free_or_cleared_slot(layout, 'bedrooms', spare_finds)
		if slot == null:
			return cleared
		if !build_room(layout, slot.floor, slot.slot, 'bedrooms'):
			return cleared
		if slot.cleared:
			cleared.append(slot)
		var room = get_room(get_floor(layout, slot.floor), slot.slot)
		if room != null:
			room.upgrades['bedrooms_expansion'] = RoomTypes.max_level('bedrooms_expansion', 'bedrooms')
	return cleared


#### reporting ####

static func summary(layout, floor_index, tasks = null):
	var res = {built = 0, empty = 0, broken = 0, beds = 0, residents = 0,
		workplaces = 0, workers = 0, upkeep = 0}
	var floor_data = get_floor(layout, floor_index)
	if floor_data == null:
		return res
	for slot_code in floor_data.slots:
		var slot = floor_data.slots[slot_code]
		if slot.broken:
			res.broken += 1
			continue
		if slot.room == null:
			res.empty += 1
			continue
		res.built += 1
		res.beds += sleep_capacity(slot.room)
		res.residents += slot.room.occupants.size()
		res.workplaces += work_capacity(slot.room)
		if tasks != null:
			res.workers += get_room_workers(slot.room, tasks).size()
		res.upkeep += RoomTypes.get_type(slot.room.type).upkeep
	return res


#### migration ####

#Repairs a layout loaded from a save: drops rooms whose type no longer exists, adds slots
#the designer introduced, and rebuilds a floor outright when the level map was reshaped.
#Safe to call repeatedly.
static func validate(layout, party = null):
	if !(layout is Dictionary) or !layout.has('floors') or !(layout.floors is Array):
		return false
	layout.version = VERSION
	if !layout.has('plan'):
		layout.plan = 'default_manor'
	layout.next_room_id = int(layout.get('next_room_id', 1))
	var plan = FloorPlans.get_plan(layout.plan)
	realign_floors(layout, plan)

	for floor_index in range(layout.floors.size()):
		if floor_index >= plan.floors.size():
			continue
		var floor_plan = plan.floors[floor_index]
		var floor_data = layout.floors[floor_index]
		#the designer moved or resized the slots - rebuild rather than guess
		if !floor_data.has('shape') or floor_data.shape != FloorPlans.shape_signature(floor_plan):
			print_debug("mansion_layout: floor %d level map changed, rebuilding" % floor_index)
			layout.floors[floor_index] = build_floor(floor_plan)
			continue
		validate_floor(floor_plan, floor_data)

	#the plan gained floors since this layout was created
	for floor_index in range(layout.floors.size(), plan.floors.size()):
		layout.floors.append(build_floor(plan.floors[floor_index]))

	#give ids to rooms that predate them, and make sure the counter clears every id in use
	for entry in each_room(layout):
		if entry.room.task_id == null:
			assign_room_id(layout, entry.room)
		else:
			var parts = str(entry.room.task_id).split("_")
			var used = int(parts[parts.size() - 1])
			layout.next_room_id = max(layout.next_room_id, used + 1)

	layout.current_floor = int(clamp(int(layout.get('current_floor', 0)), 0, max(0, layout.floors.size() - 1)))
	ensure_mandatory_rooms(layout)
	prune_occupants(layout, party)
	return true


#A room with min_count above zero is one the mansion may not be without: the staircase is how
#the floors are reached at all, and the master has to sleep somewhere. They come with the plan
#as prebuilt rooms, so this only ever fires for a save that lost one - a plan reshaped under
#it, or a room pulled down by something that should not have been able to. Put up free, since
#the player never chose to be without it.
static func ensure_mandatory_rooms(layout):
	var raised = 0
	for type_code in RoomTypes.LIST:
		var wanted = RoomTypes.min_count(type_code)
		if wanted <= 0:
			continue
		var standing = count_rooms_of_type(layout, type_code)
		while standing < wanted:
			var slot = first_free_slot(layout)
			if slot == null:
				break
			if !build_room(layout, slot.floor, slot.slot, type_code):
				break
			standing += 1
			raised += 1
	return raised


#The first slot with nothing on it, skipping the grounds - a room the house must have belongs
#in the house.
static func first_free_slot(layout):
	for floor_index in house_floors(layout):
		var floor_data = get_floor(layout, floor_index)
		for slot_code in floor_data.slots:
			var slot = floor_data.slots[slot_code]
			if slot.room == null and slot.build == null and !slot.broken:
				return {floor = floor_index, slot = slot_code}
	return null


#Somewhere to put a room the estate is given rather than builds: quests, the console and test
#mode all hand rooms over. An empty slot first; failing that a derelict one is cleared on the
#spot, which is the only way rubble ever goes without builders and materials - so the answer to
#a gift arriving at a house full of rubble is the room, not a refusal.
#'cleared' tells the caller a slot was opened, since whatever the rubble was hiding is theirs.
#'spare_finds' asks it to leave the derelict rooms that are hiding something for last. Rooms
#handed out at the start of a test game would otherwise pull down whichever room came first
#and pocket what was under it, spending the finds before anybody could turn one up.
static func free_or_cleared_slot(layout, type_code = null, spare_finds = false):
	#Clearing rubble is not undone, so what is going in has to be allowed in before a derelict
	#room is opened for it. The only thing that can still refuse an empty, unbroken slot is the
	#cap on how many of that type the mansion may have.
	if type_code != null:
		if !RoomTypes.has_type(type_code):
			return null
		var cap = RoomTypes.max_count(type_code)
		if cap > 0 and count_planned_of_type(layout, type_code) >= cap:
			return null
	#A floor is finished before the next one is started: its bare rooms first, then its
	#rubble. Filling every bare room in the house before touching any rubble would put a gift
	#upstairs while the ground floor still had derelict rooms to open - and the upper floor is
	#behind a staircase that may not have been mended yet.
	for floor_index in house_floors(layout):
		var slot = first_free_slot_on(layout, floor_index)
		if slot != null:
			slot.cleared = false
			return slot
		slot = clear_first_rubble_on(layout, floor_index, spare_finds)
		if slot != null:
			slot.cleared = true
			return slot
	#nothing empty and nothing bare left under the rubble: the finds have to give way
	if spare_finds:
		return free_or_cleared_slot(layout, type_code, false)
	return null


static func first_free_slot_on(layout, floor_index):
	var floor_data = get_floor(layout, floor_index)
	if floor_data == null:
		return null
	for slot_code in floor_data.slots:
		var slot = floor_data.slots[slot_code]
		if slot.room == null and slot.build == null and !slot.broken:
			return {floor = floor_index, slot = slot_code}
	return null


static func clear_first_rubble_on(layout, floor_index, spare_finds = false):
	var floor_data = get_floor(layout, floor_index)
	if floor_data == null:
		return null
	for slot_code in floor_data.slots:
		var slot = floor_data.slots[slot_code]
		if !slot.broken or slot.room != null or slot.build != null:
			continue
		if spare_finds and slot.get('find', null) != null:
			continue
		slot.broken = false
		return {floor = floor_index, slot = slot_code}
	return null



#Floors are matched to the plan by their code rather than by their position. A floor taken out
#of the middle of the plan would otherwise slide every floor below it up by one - the estate
#grounds would be read as the top storey, and every building on them lost. Anything the plan no
#longer has is dropped, which is the one thing that cannot be saved when a floor goes.
static func realign_floors(layout, plan):
	var by_code = {}
	for floor_data in layout.floors:
		var code = str(floor_data.get('code', ''))
		#a layout old enough to have no codes cannot be matched; the pass below rebuilds it
		#floor by floor from its shape instead
		if code == '' or by_code.has(code):
			return
		by_code[code] = floor_data
	var aligned = []
	var moved = false
	for index in range(plan.floors.size()):
		var code = plan.floors[index].code
		if !by_code.has(code):
			continue
		if layout.floors.find(by_code[code]) != index:
			moved = true
		aligned.append(by_code[code])
		by_code.erase(code)
	if !moved and by_code.empty():
		return
	print_debug("mansion_layout: plan floors changed, %d kept, %d dropped"
		% [aligned.size(), by_code.size()])
	layout.floors = aligned


static func validate_floor(floor_plan, floor_data):
	if !(floor_data.slots is Dictionary):
		floor_data.slots = {}
	ensure_fixed_rooms(floor_plan, floor_data)
	for slot_plan in floor_plan.slots:
		if !floor_data.slots.has(slot_plan.code):
			floor_data.slots[slot_plan.code] = make_slot(FloorPlans.slot_starts_broken(slot_plan))
			continue
		var slot = floor_data.slots[slot_plan.code]
		slot.broken = bool(slot.broken)
		if !slot.has('build'):
			slot.build = null
		validate_build(slot)
		if slot.room == null:
			continue
		if !RoomTypes.has_type(slot.room.type):
			print_debug("mansion_layout: dropping room in slot %s, unknown type" % slot_plan.code)
			slot.room = null
			continue
		var room = slot.room
		if !(room.occupants is Array):
			room.occupants = []
		if !room.has('upgrades') or !(room.upgrades is Dictionary):
			room.upgrades = {}
		if !room.has('build'):
			room.build = null
		if !room.has('task_id'):
			room.task_id = null
		#a save made before Ledgers existed has no such key
		if !room.has('craft_rules') or !(room.craft_rules is Array):
			room.craft_rules = []
		else:
			#recipes finished or cancelled since the save was made are simply gone
			for task_id in room.craft_rules.duplicate():
				if !(task_id is String):
					room.craft_rules.erase(task_id)
		#a save made before practice rooms existed has no such key, and JSON floats the
		#progress on one that does
		if !room.has('practice') or !(room.practice is Dictionary):
			room.practice = make_practice()
		else:
			var blank = make_practice()
			for key in blank:
				if !room.practice.has(key):
					room.practice[key] = blank[key]
			room.practice.progress = float(room.practice.progress)
			if !(room.practice.stat in PRACTICE_STATS):
				room.practice.stat = blank.stat
		#drop upgrades this type no longer offers, and re-int() the levels JSON floated
		var allowed = RoomTypes.get_type(room.type).upgrades
		for code in room.upgrades.keys():
			if !allowed.has(code) or !RoomTypes.has_upgrade(code):
				room.upgrades.erase(code)
				continue
			room.upgrades[code] = int(clamp(int(room.upgrades[code]), 0,
				RoomTypes.max_level(code, room.type)))
			if room.upgrades[code] <= 0:
				room.upgrades.erase(code)
		#a broken slot can never hold a room; the flag wins
		if slot.broken and slot.build == null:
			slot.room = null


#JSON floats every number, and a build whose target has since vanished has to go.
#The staircase is how a floor is reached at all, so a floor without one is a floor the player
#cannot get to. Saves made before it existed have none, and it cannot be built - so the plan's
#own prebuilt list is read again and any fixed room it names is put back where it belongs. A
#room already standing in that slot is moved aside to the first free one rather than lost.
static func ensure_fixed_rooms(floor_plan, floor_data):
	if !floor_plan.has('prebuilt'):
		return
	for slot_code in floor_plan.prebuilt:
		var type_code = floor_plan.prebuilt[slot_code]
		if !RoomTypes.is_fixed(type_code):
			continue
		var already = false
		for code in floor_data.slots:
			var room = floor_data.slots[code].room
			if room != null and room.type == type_code:
				already = true
				break
		if already or !floor_data.slots.has(slot_code):
			continue
		var slot = floor_data.slots[slot_code]
		if slot.room != null:
			move_room_aside(floor_data, slot_code)
		slot.broken = false
		slot.build = null
		slot.room = make_room(type_code)


static func move_room_aside(floor_data, slot_code):
	for code in floor_data.slots:
		var other = floor_data.slots[code]
		if code == slot_code or other.broken or other.room != null or other.build != null:
			continue
		other.room = floor_data.slots[slot_code].room
		floor_data.slots[slot_code].room = null
		return
	#nowhere to put it: the staircase wins, since without it the floor is unreachable
	floor_data.slots[slot_code].room = null


static func validate_build(slot):
	var build = slot.build
	if build == null:
		return
	if !(build is Dictionary) or !build.has('kind') or !build.has('task_id'):
		slot.build = null
		return
	build.progress = float(build.progress)
	build.limit = float(max(1, build.limit))
	build.level = int(build.level)
	if !(build.refund is Dictionary):
		build.refund = {}
	for res in build.refund:
		build.refund[res] = int(build.refund[res])
	match build.kind:
		'construct':
			if !RoomTypes.has_type(build.target):
				slot.build = null
		'upgrade':
			if slot.room == null or !RoomTypes.has_upgrade(build.target) \
					or RoomTypes.get_level_data(build.target, build.level, slot.room.type) == null:
				slot.build = null
		'repair':
			if !slot.broken:
				slot.build = null
		_:
			slot.build = null


#Drops residents that no longer exist and any duplicate that slipped into two rooms, then
#trims anyone over a bed count that shrank. "party" is game_party.characters; skipped when
#null or empty so a standalone test run does not wipe its dummy characters.
static func prune_occupants(layout, party):
	if party == null or !(party is Dictionary) or party.empty():
		return
	var seen = []
	for entry in each_room(layout):
		var keep = []
		for char_id in entry.room.occupants:
			if !party.has(char_id) or seen.has(char_id):
				continue
			if keep.size() >= sleep_capacity(entry.room):
				continue
			seen.append(char_id)
			keep.append(char_id)
		entry.room.occupants = keep
