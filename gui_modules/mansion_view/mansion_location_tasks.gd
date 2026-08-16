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

	if location.has('gather_resources'):
		for resource in location.gather_resources:
			if !ResourceScripts.game_progress.can_gather_item(resource):
				continue
			res.append(entry_for(ResourceScripts.game_res.add_gathering_res_temp(resource, code)))

	for task in tasks.tasklist.values():
		if task.code in ['rest', 'brothel', 'recruit_easy', 'recruit_hard']:
			continue
		if task.tags.has('special') or task.tags.has('crafting'):
			continue
		if !globals.checkreqs(task.reqs):
			continue
		#a gathering job with no places at the current upgrade level is not offered at all
		if task.has('upgrade_code') and task.has('workers_per_upgrade') and task.has('base_workers'):
			if task.base_workers + task.workers_per_upgrade * ResourceScripts.game_res.findupgradelevel(task.upgrade_code) <= 0:
				continue
		res.append(entry_for(ResourceScripts.game_res.add_gathering_job_temp(task.code, code)))
	return res


static func entry_for(task_id):
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	return {
		id = task_id,
		icon = data.icon if data.has('icon') else '',
		name = data.name if data.has('name') else task_id,
		descript = data.descript if data.has('descript') else '',
		#gather_limited is the one kind with no cap on hands
		unlimited = data.type == 'gather_limited',
		max_workers = int(data.max_workers) if data.has('max_workers') else 0,
		remaining = null,
	}


static func workers_of(task_id):
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return []
	return ResourceScripts.game_res.tasks_progresses[task_id].workers


#### production ####

#What this task yields per turn from the people actually on it. Same arithmetic the task
#info panel uses (Mansion/Scripts/MansionTaskInfoModule.gd), so the two never disagree.
static func production_per_turn(task_id):
	if !ResourceScripts.game_res.tasks_progresses.has(task_id):
		return 0.0
	var data = ResourceScripts.game_res.tasks_progresses[task_id]
	if !data.has('workers') or data.workers.empty():
		return 0.0
	var total = 0.0
	for char_id in data.workers:
		var person = ResourceScripts.game_party.characters.get(char_id, null)
		if person == null:
			continue
		if data.type in ['gather_limited', 'gather_simple']:
			total += person.get_progress_resource(data.job)
		else:
			total += person.get_job_value(tasks.find_task_for_res(data.job))
	return total / max(1.0, float(data.progress_limit))


static func production_text(task_id):
	var value = production_per_turn(task_id)
	if value <= 0:
		return ""
	return "+%.1f" % value
