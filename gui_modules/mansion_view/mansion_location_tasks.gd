extends Reference
#Turns a location's available work into a flat list the mansion screen can draw as rooms.
#
#Nothing here is new mechanics. It calls the same idempotent task creators the old job
#screen calls (game_res.add_gathering_job_temp and friends) and reads the same progress
#records, so a character placed through this screen is a worker in exactly the sense the
#rest of the game means. The enumeration mirrors MansionJobModule.update_resources().
#
#This file may touch autoloads: unlike mansion_layout.gd it is preloaded only by the
#screen, never by game_res, so it is not part of the compile-time preload chain.

const MansionLayout = preload("res://src/core/mansion_layout.gd")

const MANSION_CODE = 'aliron'


#Every location the household is currently spread across, mansion first. Same source the
#navigation panel uses - the places people actually are.
static func accessible_locations():
	var res = [MANSION_CODE]
	for char_id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[char_id]
		var code = person.get_location()
		if code == 'mansion':
			code = MANSION_CODE
		if code == 'travel' or res.has(code):
			continue
		res.append(code)
	#A quest waiting somewhere is a reason to look at that place whether or not anybody has
	#ever stood in it - otherwise the work is only visible after somebody happens to walk past.
	for code in quest_locations():
		if !res.has(code):
			res.append(code)
	return res


#Places with story work pinned to them. Read off the task records rather than the world, so a
#quest that has been dealt with stops naming its place the moment its task is gone.
static func quest_locations():
	var res = []
	for task_id in ResourceScripts.game_res.active_tasks.special:
		if !ResourceScripts.game_res.tasks_progresses.has(task_id):
			continue
		var code = ResourceScripts.game_res.tasks_progresses[task_id].location
		if code != null and code != '' and !res.has(code):
			res.append(code)
	return res


static func location_name(code):
	var location = ResourceScripts.world_gen.get_location_from_code(code)
	if location == null:
		return code
	if location.has('name') and location.name != '':
		return location.name
	return code


static func location_background(code):
	var location = ResourceScripts.world_gen.get_location_from_code(code)
	if location == null or !location.has('background'):
		return null
	return images.get_background(location.background)


static func characters_at(code):
	var res = []
	for char_id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[char_id]
		var here = person.get_location()
		if here == 'mansion':
			here = MANSION_CODE
		if here == code:
			res.append(char_id)
	return res


#Rooms on the local-tasks screen that hold an upgrade rather than people. The upgrades
#themselves are a separate kind from the mansion's room upgrades and are not written yet, so
#this names the slots and nothing else - each draws as an empty room waiting for them.
const LOCAL_UPGRADE_SLOTS = ['local_upgrade_1', 'local_upgrade_2', 'local_upgrade_3']


#### the work itself ####

#One entry per thing that can be worked on here. Creating the progress records is the
#creators' own business and they are idempotent, so calling this repeatedly is safe.
static func tasks_for(code):
	var res = []
	var location = ResourceScripts.world_gen.get_location_from_code(code)
	if location == null:
		return res
	if location.has('locked') and location.locked:
		return res

	for r_task in ['recruit_easy', 'recruit_hard']:
		if location.has('tags') and location.tags.has(r_task):
			res.append(entry_for(ResourceScripts.game_res.add_recruiting_job_temp(r_task, code)))

	for task_id in ResourceScripts.game_res.active_tasks.special:
		var jobdata = ResourceScripts.game_res.tasks_progresses[task_id]
		if jobdata.location == code:
			res.append(entry_for(task_id))

	#Each kind of place gathers from exactly one source, never two. The estate works its own
	#land through the global task list, gated by what its upgrades have unlocked; everywhere
	#else offers only what that place itself has. Running both lists for a settlement listed
	#the estate's whole production on top of the settlement's own - the same resources twice,
	#and a shelf of them with nowhere to stand because their upgrades are the estate's.
	if code == MANSION_CODE:
		#Service is the estate's own trade, and the one piece of work here with a screen of
		#its own behind it rather than a row of places on the card.
		ResourceScripts.game_res._add_service_job()
		add_entry(res, 'service')
		#Gathering is not listed here. Each of those jobs is worked out of a building on the
		#grounds, and that building's own card carries its places - listing the job as well
		#drew the same work twice, once as a barn and once as "fishing". The records still
		#have to exist for anyone to be put on them, so they are still created.
		ensure_gather_jobs()
		return res

	if location.type == 'dungeon':
		#a dungeon's seams run out rather than filling up, and take as many hands as you
		#send: gather_limited carries no max_workers at all
		for resource in location.gather_limit_resources:
			if location.gather_limit_resources[resource] <= 0:
				continue
			var entry = entry_for(ResourceScripts.game_res.add_gathering_limited_job_temp(resource, code))
			entry.remaining = int(location.gather_limit_resources[resource])
			res.append(entry)
		return res

	#an encounter is a place something happened, not a place with work in it
	if location.type == 'encounter' or !location.has('gather_resources'):
		return res
	for resource in location.gather_resources:
		if !ResourceScripts.game_progress.can_gather_item(resource):
			continue
		add_entry(res, ResourceScripts.game_res.add_gathering_res_temp(resource, code))
	return res


#### the estate's gathering, which belongs to its buildings ####

#Every gathering job the estate can currently do, created if it does not exist yet. A job
#whose building has not been raised has nowhere to stand and is not the estate's to do -
#what used to be a separate job per metal is the mine's loot table widening instead.
#The work template a building of this kind is raised for, or null when it is not that sort of
#building or the estate cannot do that job yet.
static func gather_template_for_room(room_type):
	if room_type == null or room_type == '':
		return null
	for task in tasks.tasklist.values():
		if task.get('room_type', '') != room_type:
			continue
		return task if globals.checkreqs(task.reqs) else null
	return null


#Every building standing on the grounds, as [plot code, room]. Each is its own piece of work.
static func gather_buildings():
	var res = []
	var layout = ResourceScripts.game_res.mansion_layout
	var grounds = MansionLayout.grounds_floor(layout)
	if grounds < 0:
		return res
	var floor_data = MansionLayout.get_floor(layout, grounds)
	for slot_code in floor_data.slots:
		var room = MansionLayout.get_room(floor_data, slot_code)
		if room != null:
			res.append([slot_code, room])
	return res


static func ensure_gather_jobs():
	for pair in gather_buildings():
		gather_entry_for_room(pair[1].type, pair[0])


#The job THIS building is worked for. Two mines are two jobs: what a mine yields is what that
#mine has been dug out to yield, and its hands are its own. The plot code is what tells them
#apart - without it they would find each other's task and collapse into one.
static func gather_entry_for_room(room_type, slot = ''):
	var task = gather_template_for_room(room_type)
	if task == null:
		return null
	if ResourceScripts.game_res.gather_places(room_type, slot) <= 0:
		return null
	return entry_for(ResourceScripts.game_res.add_gathering_job_temp(
		task.code, MANSION_CODE, slot))


#Work with nowhere to stand is not work the player can do anything about, so it is not drawn.
#Seams are the exception: they take as many hands as you send and carry no places at all.
static func add_entry(res, task_id):
	var entry = entry_for(task_id)
	if entry.unlimited or entry.max_workers > 0 or entry.own_screen:
		res.append(entry)


static func entry_for(task_id):
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	return {
		id = task_id,
		#a task may carry icon = null as well as no icon at all; the card load()s this
		icon = data.icon if data.get('icon', null) != null else '',
		name = data.name if data.has('name') else task_id,
		descript = data.descript if data.has('descript') else '',
		#gather_limited is the one kind with no cap on hands
		unlimited = data.type == 'gather_limited',
		max_workers = int(data.max_workers) if data.has('max_workers') else 0,
		remaining = null,
		#service takes as many as you send and is arranged on a screen of its own, so it has
		#neither a cap to draw nor a row of places to draw it in
		own_screen = task_id == 'service',
		#a quest is worked at until it is done rather than producing anything, so what it has
		#to show is how far along it is
		quest = data.type == 'special',
		progress = float(data.get('progress', 0.0)),
		progress_limit = float(data.get('progress_limit', 0.0)),
	}


static func workers_of(task_id):
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return []
	return ResourceScripts.game_res.tasks_progresses[task_id].workers


#What this work can turn out, as [material code, chance] pairs. The table's branches carry
#their own reqs and are asked at roll time (loot.is_record_restricted), so the same question
#is asked here and a branch the estate has not unlocked is simply not listed - which is what
#makes this worth showing at all: it says what buying the next upgrade would add.
static func production_table(task_id):
	var res = []
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return res
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	if !data.has('job'):
		return res
	var loot = Items.get_loot()
	var table_name = tasks.find_production_loot(
		tasks.find_task_for_res(data.job) if data.type == 'gather' else null, data.job)
	if !loot.has_loot_table(table_name):
		#no table of its own: the job hands out its own material and nothing else
		return [[data.job, 1.0]]
	var table = loot.loot_tables[table_name]
	if !table.has('list'):
		return [[table.material, 1.0]] if table.has('material') else res
	for record in table.list:
		if record.has('reqs') and !globals.checkreqs(record.reqs):
			continue
		if !record.has('material'):
			continue
		res.append([record.material, float(record.get('chance', 1.0))])
	return res


#What a quest gains in a day from the people on it. Each worker adds one per tick by default
#(ch_leveling.special_tick) and a day is variables.HoursPerDay ticks. A task carrying its own
#'function' computes its own figure, and calling that to find out would hand out the
#experience it grants as a side effect - so those say nothing rather than guess.
#Named for the day rather than the turn on purpose: this is the one figure on the card that
#is not per turn, and it read as one for as long as it was called quest_per_turn.
static func quest_per_day(task_id):
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return -1.0
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	if data.has('function'):
		return -1.0
	return float(data.workers.size()) * float(variables.HoursPerDay)


#### production ####

#What this task yields per turn from the people actually on it. Same arithmetic the task
#info panel uses (Mansion/Scripts/MansionTaskInfoModule.gd), so the two never disagree.
#This counts finished batches of work, which is also what the task's production loot table
#is rolled for (loot.roll_production). While a table hands out one unit of one material -
#which is what all of them do to begin with - batches and units are the same number; give a
#task a table that yields several things and this becomes "rolls", not "items of job".
#What one person would make on this work in a turn, whether or not they are on it yet. The card
#asks this about somebody it is offering the place to, and production_per_turn sums it over the
#people already there, so the number the player is shown before choosing and the number they get
#after cannot drift apart.
static func production_of(task_id, person):
	if person == null or !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return 0.0
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	if !data.has('job'):
		return 0.0
	var value = 0.0
	if data.type in ['gather_limited', 'gather_simple']:
		value = person.get_progress_resource(data.job)
	else:
		#find_task_for_res answers null for anything no job produces, and the value of a task
		#nobody can be set to is nothing rather than an error
		var job_task = tasks.find_task_for_res(data.job)
		if job_task == null:
			return 0.0
		value = person.get_job_value(job_task)
	return value / max(1.0, float(data.get('progress_limit', 1)))


static func production_per_turn(task_id):
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return 0.0
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	if !data.has('workers') or data.workers.empty():
		return 0.0
	#Not every piece of work makes something every turn. A quest is worked at until it is done
	#and its record carries no job at all (game_res.add_special_job) - asking one what it yields
	#brought the screen down the moment somebody was put on it.
	if !data.has('job'):
		return 0.0
	var total = 0.0
	for char_id in data.workers:
		var person = ResourceScripts.game_party.characters.get(char_id, null)
		if person == null:
			continue
		total += production_of(task_id, person)
	return total


#What this farm is actually making, by material and per turn - the same shape as
#production_table(), so a plot draws both the same way. Several people each giving several
#different things is not one figure: milk and dragon scales do not add up to anything.
static func farm_yield_table(task_id):
	var rows = []
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return rows
	var seen = {}
	for char_id in ResourceScripts.game_res.tasks_progresses[task_id].workers:
		var person = ResourceScripts.game_party.characters.get(char_id, null)
		if person == null:
			continue
		for res in person.get_farming_rules():
			if seen.has(res):
				rows[seen[res]][1] += person.get_progress_farm(res)
				continue
			seen[res] = rows.size()
			rows.append([res, person.get_progress_farm(res)])
	return rows


static func production_text(task_id):
	var value = production_per_turn(task_id)
	if value <= 0:
		return ""
	return "+%.1f" % value
