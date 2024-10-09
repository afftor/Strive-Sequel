extends Control


var task_options = ["resources", "upgrades"]
var task_index = 0

onready var TaskContainer = $TaskList/ScrollContainer/VBoxContainer
onready var WorkersContainer = $Tooltip/VBoxContainer


func _ready():
	$Button.connect("pressed", self, "change_button")
	globals.connect("hour_tick", self, "update_progresses")
	globals.connect("task_removed", self, "update_progresses")


func update_progresses():
	show_task_info()


func change_button():
	if task_index == task_options.size() - 1:
		task_index = 0
	else:
		task_index += 1
	$Button/Label.text = task_options[task_index].capitalize()
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

func show_upgrades_info():
	var first = true
	for upgrade in ResourceScripts.game_res.upgrades_queue:
		var upgrade_product = upgradedata.upgradelist[upgrade]
		var upgrade_name = upgrade_product.name
		if !ResourceScripts.game_res.upgrade_progresses.has(upgrade_product.code):
			continue
		else:
			var upgrade_progress = ResourceScripts.game_res.upgrade_progresses[upgrade]
			var newupgrade = input_handler.DuplicateContainerTemplate(TaskContainer)
			newupgrade.get_node("Task").text = upgrade_name
			newupgrade.get_node("Task/TaskIcon").texture = load("res://assets/Textures_v2/MANSION/icon_upgrade_64.png")
			var upgrade_reqs = upgrade_product.levels[int(upgrade_progress.level)].taskprogress
#			newupgrade.get_node("ProgressBar").value = upgrade_progress.progress / (upgrade_reqs * 0.01)
			var task
			var prog_units = 0
			for t in ResourceScripts.game_party.active_tasks:
				if t.code == "building":
					task = t
			if task != null:
				var text = "Workers:\n"
				for worker in task.workers:
					if !ResourceScripts.game_party.characters.has(worker):
						continue
					text += ResourceScripts.game_party.characters[worker].get_short_name() + '\n'
					prog_units += ResourceScripts.game_party.characters[worker].get_progress_task(task.code, task.product)
				globals.connecttexttooltip(newupgrade, text)
			
			if first:
				newupgrade.get_node('progress').text = "%d + (%d - %d) / %d" % [upgrade_progress.progress, prog_units, prog_units * 2, upgrade_reqs]
				first = false
			else:
				newupgrade.get_node('progress').text = "%d / %d" % [upgrade_progress.progress, upgrade_reqs]
			# newupgrade.connect("mouse_entered", self, "show_workers", [task, newupgrade])
			# newupgrade.connect("mouse_exited", $Tooltip, "hide")



func show_workers(task, button):
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
	for task in ResourceScripts.game_party.active_tasks:
		if task.code in ["building",'brothel']:
			continue
		var task_name = task.code
		var newtask = input_handler.DuplicateContainerTemplate(TaskContainer)
		if task.workers.empty():
			newtask.hide()
			continue
		
#		var progress = {base = 0, res = 0, gold = 0, farm = 0}
		
		var text = "Workers:\n"
		var cleararray = []
		for worker in task.workers:
			if ResourceScripts.game_party.characters.has(worker):
				var ch = ResourceScripts.game_party.characters[worker]
				text += ch.get_short_name() + '\n'
#				progress.base += ch.get_progress_task(task.code, task.product)
#				progress.res += ch.get_progress_resource(task.code)
#				progress.farm += ch.get_progress_farm(task.code)
			else:
				cleararray.append(worker)
		for i in cleararray:
			task.workers.erase(i)
		globals.connecttexttooltip(newtask, text)
		
		if task_name in ['alchemy','tailor','cooking','smith']:
			if ResourceScripts.game_res.craftinglists[task_name].size() <= 0:
				newtask.hide()
			else:
				newtask.show()
				newtask.get_node("NoResources").visible = task.messages.has('noresources')
				var progress = 0
				for worker in task.workers:
					var ch = ResourceScripts.game_party.characters[worker]
					progress += ch.get_progress_task(task.code, task.product)
				newtask.get_node("progress").text = "%d + (%d - %d) / %d" % [ResourceScripts.game_res.craftinglists[task_name][0].workunits, progress, progress * 2, ResourceScripts.game_res.craftinglists[task_name][0].workunits_needed]
#				newtask.get_node("ProgressBar").max_value = ResourceScripts.game_res.craftinglists[task_name][0].workunits_needed
#				newtask.get_node("ProgressBar").value = ResourceScripts.game_res.craftinglists[task_name][0].workunits
				var recipe = Items.recipes[ResourceScripts.game_res.craftinglists[task_name][0].code]
				var item
				if recipe.resultitemtype == 'item':
					item = Items.itemlist[recipe.resultitem]
				else:
					item = Items.materiallist[recipe.resultitem]
				if recipe.resultitemtype == 'material':
					newtask.get_node("Task/TaskIcon").texture = Items.materiallist[recipe.resultitem].icon
					newtask.get_node("Task/TaskIcon/Label").show()
					newtask.get_node("Task/TaskIcon/Label").text =  ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[recipe.resultitem])
					globals.connectmaterialtooltip(newtask.get_node("Task/TaskIcon"), Items.materiallist[recipe.resultitem])
					# newtask.get_node("icon/Label").show()
					# newtask.get_node("Task").text = str(ResourceScripts.game_res.materials[ResourceScripts.game_res.craftinglists[task_name][0].code])
				
				elif recipe.crafttype == 'modular':
					input_handler.itemshadeimage(newtask.get_node("Task/TaskIcon"), item)
				
				else:
					newtask.get_node("Task/TaskIcon").texture = Items.itemlist[recipe.resultitem].icon

		elif task.product in ['recruiting']:
			var progress = 0
			for worker in task.workers:
				var ch = ResourceScripts.game_party.characters[worker]
				var taskdata = tasks.tasklist[task.code]
				var val = 1
				if taskdata.has('function'):
					val = ch.xp_module.call(taskdata.function)
				progress += val
			newtask.get_node("progress").text = "%d + %d / %d" % [task.progress, progress, task.threshold]
			newtask.show()
			newtask.get_node("Task/TaskIcon").texture = tasks.tasklist[task_name].production_icon
#			newtask.get_node("ProgressBar").max_value = task.threshold
#			newtask.get_node("ProgressBar").value = task.progress
			task_name = "recruiting"
		elif task.product in ['special']:
			var progress = 0
			for worker in task.workers:
				var ch = ResourceScripts.game_party.characters[worker]
				var val = 1
				if task.has('function'):
					val = ch.xp_module.call(task.function)
				progress += val
			newtask.get_node("progress").text = "%d + %d / %d" % [task.progress, progress, task.threshold]
			newtask.show()
			newtask.get_node("Task/TaskIcon").texture = load(task.icon)
#			newtask.get_node("ProgressBar").max_value = task.threshold
#			newtask.get_node("ProgressBar").value = task.progress
			task_name = tr(task.name)
		elif task.product in ['gold']:
			var progress = 0
#			for worker in task.workers:
#				var ch = ResourceScripts.game_party.characters[worker]
#				progress += ch.get_progress_farm(task.product)
			newtask.get_node("progress").text = "" 
			newtask.get_node("Task/TaskIcon").texture = tasks.tasklist[task_name].production_icon
#			newtask.get_node("ProgressBar").max_value = task.threshold
#			newtask.get_node("ProgressBar").value = task.progress
		else:
			newtask.get_node("Task/TaskIcon/Label").show()
			if Items.materiallist.has(task.code):
				var progress = 0
				for worker in task.workers:
					var ch = ResourceScripts.game_party.characters[worker]
					progress += ch.xp_module.get_progress_resource(task.code)
				var value = task.threshold/task.progress+progress
				newtask.get_node("progress").text = "+ ~"+str(stepify(value,0.1))#"%.1f + (%.1f - %.1f) / %.1f" % [task.progress, progress, progress * 2, task.threshold]
				newtask.get_node("Task/TaskIcon").texture = Items.materiallist[task.code].icon
				newtask.get_node("Task/TaskIcon/Label").text =  ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[task.code])
				globals.connectmaterialtooltip(newtask.get_node("Task/TaskIcon"), Items.materiallist[task.code])
			elif task.code == 'produce':
				var progress = 0
				for worker in task.workers:
					var ch = ResourceScripts.game_party.characters[worker]
					progress += ch.get_progress_farm(task.product)
				newtask.get_node("progress").text = "%d + %d / %d" % [task.progress, progress, task.threshold]
				newtask.get_node("Task/TaskIcon").texture = Items.materiallist[task.product].icon
				newtask.get_node("Task/TaskIcon/Label").text =  ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[task.product])
				globals.connectmaterialtooltip(newtask.get_node("Task/TaskIcon"), Items.materiallist[task.product])
			else:
				var progress = 0
				for worker in task.workers:
					var ch = ResourceScripts.game_party.characters[worker]
					progress += ch.get_progress_task(task.code, task.product)
				var value = task.threshold/task.progress+progress
				newtask.get_node("progress").text = "+ ~"+str(stepify(value,0.1))
				#newtask.get_node("progress").text = "%.1f + (%.1f - %.1f) / %.1f" % [task.progress, progress, progress * 2, task.threshold]
				newtask.get_node("Task/TaskIcon").texture = Items.materiallist[tasks.tasklist[task_name].production_item].icon
				newtask.get_node("Task/TaskIcon/Label").text =  ResourceScripts.custom_text.transform_number(ResourceScripts.game_res.materials[tasks.tasklist[task_name].production_item])
				globals.connectmaterialtooltip(newtask.get_node("Task/TaskIcon"), Items.materiallist[tasks.tasklist[task_name].production_item])
#			newtask.get_node("ProgressBar").max_value = task.threshold
#			newtask.get_node("ProgressBar").value = task.progress
			newtask.get_node("Task").show()
			
		newtask.get_node("Task").text = task_name.capitalize()
		
	for ch in ResourceScripts.game_party.characters.values():
		if ch.is_on_quest():
			var work_time = ch.get_quest_time_remains()
			if work_time > 0:
				var work_time_init = ch.get_quest_time_init()
				var newtask = input_handler.DuplicateContainerTemplate(TaskContainer)
				newtask.show()
				newtask.get_node("Task/TaskIcon").texture = ch.get_icon_small()
				newtask.get_node("NoResources").hide()
				newtask.get_node("progress").text = "%d / %d" % [work_time_init - work_time, work_time_init]
#				newtask.get_node("ProgressBar").max_value = work_time_init
#				newtask.get_node("ProgressBar").value = work_time_init - work_time
				newtask.get_node("Task").text = ch.get_short_name() + " : " + ch.get_work()
#			else:
#				var newtask = input_handler.DuplicateContainerTemplate(TaskContainer)
#				newtask.show()
#				newtask.get_node("Task/TaskIcon").hide()
#				newtask.get_node("NoResources").hide()
#				newtask.get_node("ProgressBar").hide()
#				newtask.get_node("Task").text = tr("CHAR_UNAVALIABLE")
