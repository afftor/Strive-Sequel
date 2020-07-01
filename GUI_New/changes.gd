### leveling.gd


func assign_to_task(taskcode, taskproduct, iterations = -1):
	#remove existing work
	remove_from_task()
	if taskcode == '':
		work = ''
		return
	var task = races.tasklist[taskcode]
	#check if task is existing and add slave to it if it does
	var taskexisted = false
	for i in ResourceScripts.game_party.active_tasks:
		if i.code == taskcode && i.product == taskproduct:
			taskexisted = true
			i.workers.append(parent.id)
			work = i.code
	
	workproduct = taskproduct
	if taskexisted == true:
		return
	#make new task if it didn't exist
	var dict
	dict = {code = taskcode, product = taskproduct, progress = 0, threshhold = task.production[taskproduct].progress_per_item, workers = [], iterations = iterations, messages = [], mod = task.mod}
	dict.workers.append(parent.id)
	work = taskcode
	ResourceScripts.game_party.active_tasks.append(dict)
	globals.emit_signal("task_added")

func work_tick():
	var currenttask
	for i in ResourceScripts.game_party.active_tasks:
		if i.workers.has(parent.id):
			currenttask = i
	
	if currenttask == null:
		work = ''
		parent.rest_tick()
		return
	
	if parent.statlist.is_uncontrollable() && !parent.has_profession('master'):
		if !messages.has("refusedwork"):
			globals.text_log_add('work', parent.get_short_name() + ": Refused to work")
			messages.append("refusedwork")
		return
	if parent.get_stat('obedience') > 0: #new work stat. If <= 0 and loyal/sub < 100, refuse to work
		parent.add_stat('obedience', -1)
		messages.erase("refusedwork")
	
	if parent.get_static_effect_by_code("work_rule_ration") != null:
		parent.food.food_consumption_rations = true

	if ['smith','alchemy','tailor','cooking'].has(currenttask.product) && currenttask.code != 'building':
		if ResourceScripts.game_res.craftinglists[currenttask.product].size() <= 0:
			if currenttask.messages.has('notask') == false:
				globals.text_log_add('crafting', parent.get_short_name() + ": No craft task for " + currenttask.product.capitalize() + ". ")
				currenttask.messages.append('notask')
			parent.rest_tick()
			return
		else:
			var craftingitem = ResourceScripts.game_res.craftinglists[currenttask.product][0]
			currenttask.messages.erase("notask")
			if craftingitem.resources_taken == false:
				if globals.check_recipe_resources(craftingitem) == false:
					if currenttask.messages.has('noresources') == false:
						globals.text_log_add('crafting', parent.get_short_name() + ": Not Enough Resources for craft. ")
						currenttask.messages.append("noresources")
					parent.rest_tick()
					return
				else:
					globals.spend_resources(craftingitem)
					currenttask.messages.erase("noresources")
			work_tick_values(currenttask)
			craftingitem.workunits += get_progress_task(currenttask.code, currenttask.product)#
			make_item_sequence(currenttask, craftingitem)
	
	elif currenttask.code == 'building':
		var upgrades_queue = ResourceScripts.game_res.upgrades_queue
		if upgrades_queue.size() == 0:
			self.assign_to_task('', '')
			parent.rest_tick()
			if messages.has("noupgrade") == false:
				globals.text_log_add('upgrades',parent.get_short_name() + ": No task or upgrade selected for building. ")
				messages.append("noupgrade")
			return
		else:
			messages.erase('noupgrade')
			work_tick_values(currenttask)
			if !ResourceScripts.game_res.upgrade_progresses.has(upgrades_queue[0]):
				var currentupgradelevel
				if ResourceScripts.game_res.upgrades.has(upgrades_queue[0]):
					currentupgradelevel = ResourceScripts.game_res.upgrades[upgrades_queue[0]] + 1
					ResourceScripts.game_res.upgrade_progresses[upgrades_queue[0]] = {level = currentupgradelevel, progress = 0}
			ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].progress += get_progress_task(currenttask.code, currenttask.product, true)#*(productivity/100)
			if ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].progress >= upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]].levels[ResourceScripts.game_res.upgrade_progresses[ResourceScripts.game_res.upgrades_queue[0]].level].taskprogress:
				if ResourceScripts.game_res.upgrades.has(ResourceScripts.game_res.upgrades_queue[0]):
					ResourceScripts.game_res.upgrades[ResourceScripts.game_res.upgrades_queue[0]] += 1
				else:
					ResourceScripts.game_res.upgrades[ResourceScripts.game_res.upgrades_queue[0]] = 1
				input_handler.emit_signal("UpgradeUnlocked", upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]])
				globals.text_log_add('upgrades',"Upgrade finished: " + upgradedata.upgradelist[ResourceScripts.game_res.upgrades_queue[0]].name)
				ResourceScripts.game_res.upgrade_progresses.erase(ResourceScripts.game_res.upgrades_queue[0])
				ResourceScripts.game_res.upgrades_queue.erase(ResourceScripts.game_res.upgrades_queue[0])
	else:
		work_tick_values(currenttask)
		currenttask.progress += get_progress_task(currenttask.code, currenttask.product, true)#*(get_stat('productivity')*get_stat(currenttask.mod)/100)
		while currenttask.threshhold <= currenttask.progress:
			currenttask.progress -= currenttask.threshhold
			if races.tasklist[currenttask.code].production[currenttask.product].item == 'gold':
				ResourceScripts.game_res.money += 1
			else:
				ResourceScripts.game_res.materials[races.tasklist[currenttask.code].production[currenttask.product].item] += 1