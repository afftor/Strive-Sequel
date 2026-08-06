extends Reference
#extends Node

var itemcounter = 0
var money = 0 setget set_money
var upgrades = {}
var selected_upgrade = {code = '', level = 0}#not sure
var items = {}
var materials = {} setget materials_set
var oldmaterials = {}
var tax = 0

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
	for i in upgrades.keys().duplicate():
		if !upgradedata.upgradelist.has(i):
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
#	fix_items_inventory(false)


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


func fix_tax():
	tax = 0
	for upgrade in upgrades:
		if upgrades[upgrade] <= 0:
			 continue
		var udata = upgradedata.upgradelist[upgrade]
		if udata.has('tax'): #not used but may be needed later
			tax += udata.tax
		if udata.has('levels'):
			for lv in range(upgrades[upgrade]):
				var ldata = udata.levels[lv + 1]
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


func _add_farm_job():
	if !tasks_progresses.has('farming'):
		tasks_progresses.farming = {id = 'farming', status = 'permanent', workers = [], messages = [], location = 'aliron', type = 'permanent', name = 'TASKPRODUCE', descript = 'TASKPRODUCEDESCRIPT'} 


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


func add_gathering_job_temp(task_template_id, location):
	var jobdata = tasks.tasklist[task_template_id]
	var id = check_location_job('gathering' , location, jobdata.production_item)
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
			job = jobdata.production_item
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
		if jobdata.has('upgrade_code') and jobdata.has('workers_per_upgrade') and jobdata.has('base_workers'):
			var upgrade_level = findupgradelevel(jobdata.upgrade_code)
			tprogress.max_workers = jobdata.base_workers + jobdata.workers_per_upgrade * upgrade_level


func check_location_job(type, location, job):
	for t_id in active_tasks[type]:
		if tasks_progresses.has(t_id):
			var pdata = tasks_progresses[t_id]
			if pdata.location == location and pdata.job == job:
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
		for ch_id in ResourceScripts.game_party.character_order:
			if !(ch_id in tprogress.workers):
				continue
			var character = characters_pool.get_char_by_id(ch_id)
			if tprogress.status == 'completed':
				character.rest_tick()
			else:
				var val = 0
				if tprogress.type in ['gather_limited', 'gather_simple']:
					val = character.get_progress_resource(tprogress.job, true)
				else:
					val = character.get_job_value(tasks.find_task_for_res(tprogress.job), true)
				_add_gather_value(tprogress, val, character)
				character.work_tick_values(tprogress.workstat)
				if tprogress.status == 'completed':
					globals.text_log_add('char', character.get_short_name() + ": " + "No more resources to gather.")


func process_farm():
	_add_farm_job()
	var currenttask = tasks_progresses.farming
	for ch_id in ResourceScripts.game_party.character_order:
		if !(ch_id in currenttask.workers):
			continue
		var character = characters_pool.get_char_by_id(ch_id)
		var reslist = character.get_farming_rules() 
		for res in reslist:
			var value = character.get_progress_farm(res) 
			_add_farming_value(res, value)


func process_service(managed = false):
	if managed: #always a coroutine when managed, so the caller can yield on it
		yield(globals.get_tree(), 'idle_frame')
	_add_service_job()
	var currenttask = tasks_progresses.service
	var slice = OS.get_ticks_msec()
	#iterate a copy: a character dying mid-turn erases itself from character_order, and with
	#the tick spread over frames a deferred cleanup can land in the middle of this loop
	for ch_id in ResourceScripts.game_party.character_order.duplicate():
		if !(ch_id in currenttask.workers):
			continue
		var character = characters_pool.get_char_by_id(ch_id)
		if character == null or !character.is_active:
			continue
		character.select_brothel_activity()
		if managed and OS.get_ticks_msec() - slice >= variables.turn_frame_budget_msec:
			yield(globals.get_tree(), 'idle_frame')
			slice = OS.get_ticks_msec()


func process_craft(firstpass = true):
	_add_craft_job()
	var currenttask = tasks_progresses.crafting
	for ch_id in ResourceScripts.game_party.character_order:
		if !(ch_id in currenttask.workers):
			continue
		var character = characters_pool.get_char_by_id(ch_id)
		var joborder = character.get_job_order(firstpass) 
		if firstpass:
			for job in joborder:
				var value = character.get_job_value(job, true) 
				var real_job = job + '_material'
				var curupgrade = _active_task_find(crafting_lists[real_job])
				var new_value = _add_craft_value(curupgrade, value, character)
				if new_value != value:
					var pdata = tasks_progresses[curupgrade]
					currenttask.workers_handled[ch_id] = {job = job, value = new_value}
					character.work_tick_values(pdata.workstat)
					break
		else:
			if currenttask.workers_handled.has(ch_id):
				var job = currenttask.workers_handled[ch_id].job
				var real_job = job + '_item'
				var value = currenttask.workers_handled[ch_id].value
				var curupgrade = _active_task_find(crafting_lists[real_job])
				var new_value = _add_craft_value(curupgrade, value, character)
			else:
				var applied = false
				for job in joborder:
					var value = character.get_job_value(job, true) 
					if job == 'building':
						var curupgrade = _active_task_find(crafting_lists[job])
						var new_value = _add_build_value(curupgrade, value, character)
						if new_value:
							var pdata = tasks_progresses[curupgrade]
							applied = true
							character.work_tick_values(pdata.workstat)
							break
					else:
						var real_job = job + '_item'
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
				globals.text_log_add('mansion', tr("SPECTASKCOMPLETED") + " - " + tr(tprogress.name))
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
			globals.roll_hirelings(tprogress.location, tchar)
			globals.text_log_add('mansion', tr("HIRELINGFOUND"))
			input_handler.PlaySound("ding")


func _add_build_value(curupgrade, value, character, tres = false):
	if curupgrade == null:
		return tres
	else:
		if !tasks_progresses.has(curupgrade):
			_add_upgrade_task(curupgrade)
		var tprogress = tasks_progresses[curupgrade]
		tprogress.progress += value
		var tdata = upgradedata.upgradelist[curupgrade]
		if tprogress.progress >= tprogress.progress_limit:
			var newval = tprogress.progress - tprogress.progress_limit
			level_up_upgrade(curupgrade)
			
			if tdata.levels[int(tprogress.level)].has('tax'):
				tax += tdata.levels[int(tprogress.level)].tax
			
			input_handler.emit_signal("UpgradeUnlocked", upgradedata.upgradelist[curupgrade])
			globals.text_log_add('work',"Upgrade finished: " + tdata.name)
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
		else: #permanent task
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


func _add_gather_value(tprogress, value, character):
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
		if tprogress.job == 'gold':
			money += limit
		else:
			materials[tprogress.job] += limit
		character.add_metric_for_outcome(tprogress.job, limit)
	
	if tprogress.type == 'gather_limited':
		var locdata = ResourceScripts.world_gen.get_location_from_code(tprogress.location)
		locdata.gather_limit_resources[tprogress.job] -= limit
	
	if limit == limit2:
		tprogress.status = 'completed'
	else:
		tprogress.progress = value
		value = 0
	
	return value


func _add_farming_value(res, value):
	if !tasks_progresses.has('farming_' + res):
		_add_farming_task(res)
	var tprogress = tasks_progresses['farming_' + res]
	tprogress.progress += value
	while tprogress.progress > tprogress.progress_limit:
		materials[res] += 1
		tprogress.progress -= tprogress.progress_limit


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
			materials[material] += value
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
func get_pop_cap():
	var res = variables.base_population_cap + variables.population_cap_per_room_upgrade * upgrades.rooms
	if ResourceScripts.game_globals.unlimited_popcap:
		res = 100
	return res


func get_pop_cap_limit():
	var res = variables.base_population_cap + variables.population_cap_per_room_upgrade * upgradedata.upgradelist.rooms.levels.size()
	return res


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
			materials[material] += value
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
	if recipe.resultitemtype == 'material':
		materials[recipe.resultitem] += recipe.resultamount
	else:
		var item = Items.itemlist[recipe.resultitem]
		globals.text_log_add("work", "Item created: " + item.name)
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
	return variables.farm_produce_slots + variables.farm_produce_slots_per_upgrade * upgrades['farm_slots']


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
