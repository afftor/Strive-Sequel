extends Control


onready var TaskContainer = $TaskList/ScrollContainer/GridContainer


func _ready():
	$Button/Label.text = tr("TASKINFORESOURCES")
	globals.connect("hour_tick", self, "update_progresses")
	globals.connect("task_removed", self, "update_progresses")


var refresh_queued = false


#same burst as the slave list: task_removed fires once per deleted task, and each one
#used to clear and refill the whole task container. Coalesce to one refresh per frame via
#the deferred message queue, which still flushes before the frame is drawn.
func update_progresses():
	if _turn_production_layout_locked():
		return
	if refresh_queued:
		return
	refresh_queued = true
	call_deferred("flush_queued_refresh")


func flush_queued_refresh():
	refresh_queued = false
	if _turn_production_layout_locked():
		return
	show_task_info()


func _turn_production_layout_locked():
	var clock = get_parent().get_node_or_null("MansionClockModule")
	return clock != null and clock.turn_production_layout_locked


func show_task_info():
	input_handler.ClearContainer(TaskContainer)
	show_resources_info()


func _create_task_node(task_id):
	var node = input_handler.DuplicateContainerTemplate(TaskContainer)
	node.set_meta("task_id", str(task_id))
	return node


func _set_worker_display(node, worker_ids, tooltip_text = ""):
	var valid_workers = []
	for worker_id in worker_ids:
		if ResourceScripts.game_party.characters.has(worker_id):
			valid_workers.append(worker_id)
	var worker_stat = node.get_node("Stats/WorkerStat")
	worker_stat.get_node("Workers").text = str(valid_workers.size())
	if valid_workers.empty():
		worker_stat.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return
	if tooltip_text == "":
		tooltip_text = tr("TASKINFOWORKERS")
		for worker_id in valid_workers:
			tooltip_text += "\n" + ResourceScripts.game_party.characters[worker_id].get_short_name()
	globals.connecttexttooltip(worker_stat, tooltip_text)


func _set_output(node, text):
	node.get_node("Stats/Production").text = text


func _format_production(value):
	return "+~" + ResourceScripts.custom_text.transform_number(stepify(value, 0.1))


func _set_inventory_amount(node, amount):
	var amount_label = node.get_node("Task/TaskIcon/Label")
	amount_label.text = ResourceScripts.custom_text.transform_number(amount)
	amount_label.show()


func _connect_task_tooltip(node, name, description = ""):
	var text = "[center]" + tr(name) + "[/center]"
	if description != "":
		text += "\n" + tr(description)
	globals.connecttexttooltip(node.get_node("Task/TaskIcon"), text)


func get_turn_animation_target(task_id):
	return get_turn_animation_targets().get(str(task_id), null)


func get_turn_animation_targets():
	var targets = {}
	for node in TaskContainer.get_children():
		if !node.visible or node.get_meta("task_id", "") == "":
			continue
		if node.has_node("Task/TaskIcon"):
			var icon = node.get_node("Task/TaskIcon")
			if $TaskList/ScrollContainer.get_global_rect().intersects(icon.get_global_rect()):
				targets[node.get_meta("task_id")] = icon.get_global_rect().get_center()
	return targets

func show_resources_info():
	#service
	if ResourceScripts.game_res.tasks_progresses.has('service'):
		var progress_data = ResourceScripts.game_res.tasks_progresses.service
		for worker in progress_data.workers.duplicate():
			if !ResourceScripts.game_party.characters.has(worker):
				progress_data.workers.erase(worker)
		if !progress_data.workers.empty():
			var newtask = _create_task_node("service")
			var text = tr("TASKINFOWORKERS") + "\n"
			var value = 0.0
			for worker in progress_data.workers:
				var ch = ResourceScripts.game_party.characters[worker]
				var worker_value = ch.get_estimated_current_service_value()
				text += "%s: + ~%.1f\n" % [ch.get_short_name(), worker_value]
				value += worker_value
			text += tr("TASKINFOINVENTORY") + " " + ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.money)
			newtask.get_node("Task/TaskIcon").texture = load("res://assets/images/iconsitems/gold.png")
			_set_inventory_amount(newtask, ResourceScripts.game_res.money)
			_set_worker_display(newtask, progress_data.workers, text)
			_set_output(newtask, _format_production(value))
	#special
	for task_id in ResourceScripts.game_res.active_tasks.special:
		var progress_data = ResourceScripts.game_res.tasks_progresses[task_id]
		for worker in progress_data.workers.duplicate():
			if !ResourceScripts.game_party.characters.has(worker):
				progress_data.workers.erase(worker)
		if progress_data.workers.empty():
			continue
		var newtask = _create_task_node(task_id)
		newtask.get_node("Task/TaskIcon").texture = load(progress_data.icon)
		newtask.get_node("ProgressBar").visible = true
		newtask.get_node("ProgressBar").max_value = progress_data.progress_limit
		newtask.get_node("ProgressBar").value = progress_data.progress
		_set_worker_display(newtask, progress_data.workers)
		_set_output(newtask, "%d/%d" % [progress_data.progress, progress_data.progress_limit])
		_connect_task_tooltip(newtask, progress_data.name, progress_data.get("descript", ""))
	#recruiting
	for task_id in ResourceScripts.game_res.active_tasks.recruiting:
		var progress_data = ResourceScripts.game_res.tasks_progresses[task_id]
		for worker in progress_data.workers.duplicate():
			if !ResourceScripts.game_party.characters.has(worker):
				progress_data.workers.erase(worker)
		if progress_data.workers.empty():
			continue
		var newtask = _create_task_node(task_id)
		newtask.get_node("Task/TaskIcon").texture = load(progress_data.icon)
		newtask.get_node("ProgressBar").visible = true
		newtask.get_node("ProgressBar").max_value = progress_data.progress_limit
		newtask.get_node("ProgressBar").value = progress_data.progress
		_set_worker_display(newtask, progress_data.workers)
		_set_output(newtask, "%d/%d" % [progress_data.progress, progress_data.progress_limit])
		_connect_task_tooltip(newtask, progress_data.name, progress_data.get("descript", ""))
	#gathering
	for task_id in ResourceScripts.game_res.active_tasks.gathering:
		var progress_data = ResourceScripts.game_res.tasks_progresses[task_id]
		for worker in progress_data.workers.duplicate():
			if !ResourceScripts.game_party.characters.has(worker):
				progress_data.workers.erase(worker)
		if progress_data.workers.empty():
			continue
		var newtask = _create_task_node(task_id)
		var text = tr("TASKINFOWORKERS") + "\n"
		var progress = 0
		for worker in progress_data.workers:
			var ch = ResourceScripts.game_party.characters[worker]
			var val = 0
			if progress_data.type in ['gather_limited', 'gather_simple']:
				val = ch.get_progress_resource(progress_data.job)
			else:
				val = ch.get_job_value(tasks.find_task_for_res(progress_data.job))
			text += "%s: +%.1f-%.1f \n" % [ch.get_short_name(), val / progress_data.progress_limit, val * 2.0 / progress_data.progress_limit]
			progress += val
		text += tr("TASKINFOINVENTORY") + " " + ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[progress_data.job])
		var value = (progress_data.progress + progress) / progress_data.progress_limit
		newtask.get_node("Task/TaskIcon").texture = Items.materiallist[progress_data.job].icon
		_set_inventory_amount(newtask, ResourceScripts.game_res.materials[progress_data.job])
		_set_worker_display(newtask, progress_data.workers, text)
		_set_output(newtask, _format_production(value))
	#farming is assigned through one shared task while each worker chooses their own
	#products. Keep one stable destination cell; the flying icon itself shows the product.
	if ResourceScripts.game_res.tasks_progresses.has("farming"):
		var farm_task = ResourceScripts.game_res.tasks_progresses.farming
		if !farm_task.workers.empty():
			var newtask = _create_task_node("farming")
			var farm_output = 0.0
			var product_names = []
			for worker in farm_task.workers:
				if !ResourceScripts.game_party.characters.has(worker):
					continue
				var ch = ResourceScripts.game_party.characters[worker]
				for product in ch.get_farming_rules():
					if Items.materiallist.has(product) and !product_names.has(product):
						product_names.append(product)
					farm_output += ch.get_progress_farm(product)
			newtask.get_node("Task/TaskIcon").texture = load("res://assets/images/iconsclasses/farmer.png")
			_set_worker_display(newtask, farm_task.workers)
			_set_output(newtask, _format_production(farm_output))
			var product_text = "[center]" + tr("TASKPRODUCE") + "[/center]"
			for product in product_names:
				product_text += "\n" + tr(Items.materiallist[product].name)
			globals.connecttexttooltip(newtask.get_node("Task/TaskIcon"), product_text)
	#crafting
	for category in ['cooking_material', 'smith_material', 'alchemy_material', 'tailor_material', 'smith_item', 'alchemy_item', 'tailor_item', 'cooking_item',]:
		for task_id in ResourceScripts.game_res.crafting_lists[category]:
			var progress_data = ResourceScripts.game_res.tasks_progresses[task_id]
			if progress_data.status in ['completed', 'stopped', 'init']:
				continue
			var newtask = _create_task_node(task_id)
			if progress_data.status == 'no_resources':
				newtask.get_node("NoResources").visible = true
			if category == 'cooking_material':
				newtask.get_node("ProgressBar").visible = true
				newtask.get_node("ProgressBar").max_value = progress_data.progress_limit
				newtask.get_node("ProgressBar").value = progress_data.progress
			_set_output(newtask, "%d/%d" % [progress_data.progress, progress_data.progress_limit])
			var craft_workers = []
			if ResourceScripts.game_res.tasks_progresses.has("crafting"):
				for worker in ResourceScripts.game_res.tasks_progresses.crafting.workers:
					if ResourceScripts.game_party.characters.has(worker):
						var worker_ch = ResourceScripts.game_party.characters[worker]
						if str(worker_ch.predict_active_task()) == str(task_id):
							craft_workers.append(worker)
			_set_worker_display(newtask, craft_workers)
			var recipe_data = Items.recipes[progress_data.id]
			var item_data
			if category.ends_with('_material'):
				item_data = Items.materiallist[recipe_data.resultitem]
				_set_inventory_amount(newtask, ResourceScripts.game_res.materials[recipe_data.resultitem])
			else:
				item_data = Items.itemlist[recipe_data.resultitem]
				_set_inventory_amount(newtask, ResourceScripts.game_res.get_item_amount(recipe_data.resultitem))
			newtask.get_node("Task/TaskIcon").texture = item_data.icon
			if recipe_data.crafttype == 'modular':
				newtask.get_node("Task/TaskIcon").material = load("res://assets/ItemShader.tres").duplicate()
	#quests
	for ch in ResourceScripts.game_party.characters.values():
		if ch.is_on_quest():
			var work_time = ch.get_quest_time_remains()
			if work_time > 0:
				var work_time_init = ch.get_quest_time_init()
				var newtask = _create_task_node("quest_" + str(ch.id))
				newtask.show()
				newtask.get_node("Task/TaskIcon").texture = ch.get_icon_small()
				newtask.get_node("NoResources").hide()
				newtask.get_node("ProgressBar").visible = true
				newtask.get_node("ProgressBar").max_value = work_time_init
				newtask.get_node("ProgressBar").value = work_time_init - work_time
				_set_worker_display(newtask, [ch.id])
				_set_output(newtask, "%d/%d" % [work_time_init - work_time, work_time_init])
				globals.connecttexttooltip(newtask.get_node("Task/TaskIcon"), ch.get_short_name() + "\n" + tr(ch.get_work()))
