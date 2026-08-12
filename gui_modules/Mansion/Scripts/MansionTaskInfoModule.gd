extends Control


var task_options = ["resources", "upgrades"]
var task_index = 0

onready var TaskContainer = $TaskList/ScrollContainer/VBoxContainer
onready var WorkersContainer = $Tooltip/VBoxContainer


func _ready():
	$Button.connect("pressed", self, "change_button")
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


func change_button():
	if task_index == task_options.size() - 1:
		task_index = 0
	else:
		task_index += 1
	$Button/Label.text = tr("TASKINFO" + task_options[task_index].to_upper())
	# $Button.icon = icon # Should change Icon
	show_task_info()

func show_task_info():
	match task_options[task_index]:
		"upgrades":
			ClearContainerCustom(TaskContainer)
			show_upgrades_info()
		"resources":
			ClearContainerCustom(TaskContainer)
			show_resources_info()

func ClearContainerCustom(container):
	for i in container.get_children():
		if i.name == "Button" || i.name == "VBoxContainer":
			continue
		i.hide()
		i.queue_free()


func _create_task_node(task_id):
	var node = input_handler.DuplicateContainerTemplate(TaskContainer)
	node.set_meta("task_id", str(task_id))
	return node


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

func show_upgrades_info():
	var first = true
	for upgrade in ResourceScripts.game_res.crafting_lists.building:
		var progress_data = ResourceScripts.game_res.tasks_progresses[upgrade]
		var upgrade_product = upgradedata.upgradelist[upgrade]
		
		var upgrade_name = upgrade_product.name
		var newupgrade = _create_task_node(upgrade)
		newupgrade.get_node("Task").text = tr(upgrade_name)
		newupgrade.get_node("Task/TaskIcon").texture = load("res://assets/Textures_v2/MANSION/icon_upgrade_64.png")
		newupgrade.get_node("ProgressBar").visible = false #or swap with next one for new crafting system
		newupgrade.get_node("progress").visible = true
		
		newupgrade.get_node('progress').text = "%d / %d" % [progress_data.progress, progress_data.progress_limit]
		newupgrade.get_node("ProgressBar").value = progress_data.progress / (progress_data.progress_limit  * 0.01)

#		globals.connecttexttooltip(newupgrade, text)




func show_workers(task, button): #obsolete
	input_handler.ClearContainer(WorkersContainer)
	var text
	for worker in task.workers:
		var newworker = input_handler.DuplicateContainerTemplate(WorkersContainer)
		newworker.text = ResourceScripts.game_party.characters[worker].get_short_name()
	$Tooltip.rect_position.y = button.rect_position.y + button.rect_size.y * 2
	yield(get_tree(), 'idle_frame')
	$Tooltip.rect_size.y = int(WorkersContainer.get_child(WorkersContainer.get_child_count() - 1).rect_size.y) * WorkersContainer.get_child_count() + 20
	$Tooltip.show()


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
			newtask.get_node("progress").text = "+ ~" + str(stepify(value, 0.1))
			newtask.get_node("ProgressBar").visible = false
			newtask.get_node("progress").visible = true
			newtask.get_node("Task/TaskIcon").texture = load("res://assets/images/iconsitems/gold.png")
			newtask.get_node("Task").text = tr("QUESTGOLD")
			newtask.get_node("Task").show()
			globals.connecttexttooltip(newtask.get_node("Task/TaskIcon"), tr("TOOLTIPGOLD"))
			globals.connecttexttooltip(newtask, text)
	#special
	for task_id in ResourceScripts.game_res.active_tasks.special:
		var progress_data = ResourceScripts.game_res.tasks_progresses[task_id]
		for worker in progress_data.workers.duplicate():
			if !ResourceScripts.game_party.characters.has(worker):
				progress_data.workers.erase(worker)
		if progress_data.workers.empty():
			continue
		var newtask = _create_task_node(task_id)
		var text = tr("TASKINFOWORKERS") + "\n"
		for worker in progress_data.workers:
			var ch = ResourceScripts.game_party.characters[worker]
			text += ch.get_short_name() + '\n'
		newtask.get_node("Task/TaskIcon").texture = load(progress_data.icon)
		newtask.get_node("ProgressBar").visible = true
		newtask.get_node("progress").visible = false
		newtask.get_node("ProgressBar").max_value = progress_data.progress_limit
		newtask.get_node("ProgressBar").value = progress_data.progress
		newtask.get_node("Task").text = tr(progress_data.name)
		globals.connecttexttooltip(newtask, text)
	#recruiting
	for task_id in ResourceScripts.game_res.active_tasks.recruiting:
		var progress_data = ResourceScripts.game_res.tasks_progresses[task_id]
		for worker in progress_data.workers.duplicate():
			if !ResourceScripts.game_party.characters.has(worker):
				progress_data.workers.erase(worker)
		if progress_data.workers.empty():
			continue
		var newtask = _create_task_node(task_id)
		var text = tr("TASKINFOWORKERS") + "\n"
		for worker in progress_data.workers:
			var ch = ResourceScripts.game_party.characters[worker]
			text += ch.get_short_name() + '\n'
		newtask.get_node("Task/TaskIcon").texture = load(progress_data.icon)
		newtask.get_node("ProgressBar").visible = true
		newtask.get_node("progress").visible = false
		newtask.get_node("ProgressBar").max_value = progress_data.progress_limit
		newtask.get_node("ProgressBar").value = progress_data.progress
		newtask.get_node("Task").text = tr(progress_data.name)
		globals.connecttexttooltip(newtask, text)
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
		newtask.get_node("progress").text = "+ ~"+str(stepify(value,0.1))
		newtask.get_node("ProgressBar").visible = false
		newtask.get_node("progress").visible = true
		newtask.get_node("Task/TaskIcon").texture = Items.materiallist[progress_data.job].icon
		globals.connectmaterialtooltip(newtask.get_node("Task/TaskIcon"), Items.materiallist[progress_data.job])
		newtask.get_node("Task").text = tr(progress_data.name)
		newtask.get_node("Task").show()
		globals.connecttexttooltip(newtask, text)
	#farming is assigned through one shared task while each worker chooses their own
	#products. Keep one stable destination row; the flying icon itself shows the product.
	if ResourceScripts.game_res.tasks_progresses.has("farming"):
		var farm_task = ResourceScripts.game_res.tasks_progresses.farming
		if !farm_task.workers.empty():
			var newtask = _create_task_node("farming")
			var text = tr("TASKINFOWORKERS") + "\n"
			var product_names = []
			for worker in farm_task.workers:
				if !ResourceScripts.game_party.characters.has(worker):
					continue
				var ch = ResourceScripts.game_party.characters[worker]
				text += ch.get_short_name() + "\n"
				for product in ch.get_farming_rules():
					if Items.materiallist.has(product) and !product_names.has(product):
						product_names.append(product)
			if !product_names.empty():
				text += "\n"
				for product in product_names:
					text += tr(Items.materiallist[product].name) + "\n"
			newtask.get_node("Task/TaskIcon").texture = load("res://assets/images/iconsclasses/farmer.png")
			newtask.get_node("Task").text = tr("TASKPRODUCE")
			newtask.get_node("Task").show()
			newtask.get_node("ProgressBar").hide()
			newtask.get_node("progress").hide()
			globals.connecttexttooltip(newtask, text)
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
				newtask.get_node("progress").visible = false
				newtask.get_node("ProgressBar").max_value = progress_data.progress_limit
				newtask.get_node("ProgressBar").value = progress_data.progress
			else:
				newtask.get_node("ProgressBar").visible = false
				newtask.get_node("progress").visible = true
				newtask.get_node("progress").text = "%d / %d" % [progress_data.progress, progress_data.progress_limit]
			var recipe_data = Items.recipes[progress_data.id]
			var item_data
			if category.ends_with('_material'):
				item_data = Items.materiallist[recipe_data.resultitem]
				newtask.get_node("Task/TaskIcon/Label").show()
				newtask.get_node("Task/TaskIcon/Label").text =  ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[recipe_data.resultitem])
				globals.connectmaterialtooltip(newtask.get_node("Task/TaskIcon"), item_data)
			else:
				item_data = Items.itemlist[recipe_data.resultitem]
			
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
#				newtask.get_node("progress").text = "%d / %d" % [work_time_init - work_time, work_time_init]
				newtask.get_node("ProgressBar").visible = true
				newtask.get_node("progress").visible = false
				newtask.get_node("ProgressBar").max_value = work_time_init
				newtask.get_node("ProgressBar").value = work_time_init - work_time
				newtask.get_node("Task").text = ch.get_short_name() + " : " + tr(ch.get_work())
#			else:
#				var newtask = input_handler.DuplicateContainerTemplate(TaskContainer)
#				newtask.show()
#				newtask.get_node("Task/TaskIcon").hide()
#				newtask.get_node("NoResources").hide()
#				newtask.get_node("ProgressBar").hide()
#				newtask.get_node("Task").text = tr("CHAR_UNAVALIABLE")
