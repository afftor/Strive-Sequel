extends Control


var tasks = ["resources", "upgrades"]
var task_index = 0

onready var TaskContainer = $TaskList/ScrollContainer/VBoxContainer
onready var WorkersContainer = $Tooltip/VBoxContainer


func _ready():
	$Button.connect("pressed", self, "change_button")
	globals.connect("hour_tick", self, "update_progresses")


func update_progresses():
	show_task_info()


func change_button():
	if task_index == tasks.size() - 1:
		task_index = 0
	else:
		task_index += 1
	$Button/Label.text = tasks[task_index].capitalize()
	# $Button.icon = icon # Should change Icon
	show_task_info()

func show_task_info():
	match tasks[task_index]:
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
	for upgrade in ResourceScripts.game_res.upgrade_progresses.keys():
		var upgrade_product = upgradedata.upgradelist[upgrade]
		var upgrade_name = upgrade_product.name
		if !ResourceScripts.game_res.upgrade_progresses.has(upgrade_product.code):
			continue
		else:
			var upgrade_progress = ResourceScripts.game_res.upgrade_progresses[upgrade]
			var newupgrade = input_handler.DuplicateContainerTemplate(TaskContainer)
			newupgrade.get_node("Task").text = upgrade_name
			var upgrade_reqs = upgrade_product.levels[upgrade_progress.level].taskprogress
			newupgrade.get_node("ProgressBar").value = upgrade_progress.progress / (upgrade_reqs * 0.01)
			var task
			for t in ResourceScripts.game_party.active_tasks:
				if t.code == "building":
					task = t
			newupgrade.connect("mouse_entered", self, "show_workers", [task, newupgrade])
			newupgrade.connect("mouse_exited", $Tooltip, "hide")
		


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
		if task.code == "building":
			continue
		var task_name = task.code
		var newtask = input_handler.DuplicateContainerTemplate(TaskContainer)
		if task.workers == []:
			newtask.hide()
			continue

		if task_name in ['alchemy','tailor','cooking','smith']:
			if ResourceScripts.game_res.craftinglists[task_name].size() <= 0:
				newtask.hide()
			else:
				newtask.show()
				newtask.get_node("ProgressBar").max_value = ResourceScripts.game_res.craftinglists[task_name][0].workunits_needed
				newtask.get_node("ProgressBar").value = ResourceScripts.game_res.craftinglists[task_name][0].workunits
				var recipe = Items.recipes[ResourceScripts.game_res.craftinglists[task_name][0].code]
				if recipe.resultitemtype == 'material':
					newtask.get_node("Task/TaskIcon").texture = Items.materiallist[ResourceScripts.game_res.craftinglists[task_name][0].code].icon
					# newtask.get_node("icon/Label").show()
					# newtask.get_node("Task").text = str(ResourceScripts.game_res.materials[ResourceScripts.game_res.craftinglists[task_name][0].code])
				else:
					newtask.get_node("Task/TaskIcon").texture = Items.itemlist[Items.recipes[ResourceScripts.game_res.craftinglists[task_name][0].code].resultitem].icon
				if ResourceScripts.game_res.craftinglists[task_name][0].has('partdict'):
					newtask.get_node("Task/TaskIcon").texture = load("res://assets/ItemShader.tres")
				else:
					newtask.get_node("Task/TaskIcon").texture = null
		elif task.product in ['prostitutegold']:
			newtask.get_node("Task/TaskIcon").texture = races.tasklist[task_name].production[task.product].icon
			newtask.get_node("ProgressBar").max_value = task.threshhold
			newtask.get_node("ProgressBar").value = task.progress
		else:
			# newtask.get_node("Task/TaskIcon").texture = Items.materiallist[races.tasklist[task_name].production[task.product].item].icon
			newtask.get_node("Task/TaskIcon").texture = Items.materiallist[task.code].icon
			newtask.get_node("ProgressBar").max_value = task.threshhold
			newtask.get_node("ProgressBar").value = task.progress
			newtask.get_node("Task").show()
		newtask.get_node("Task").text = task_name.capitalize()
		newtask.connect("mouse_entered", self, "show_workers", [task, newtask])
		newtask.connect("mouse_exited", $Tooltip, "hide")
		# newtask.get_node("Task").icon = Items.materiallist[races.tasklist[task_name].production[task.product].item].icon
		# newtask.get_node("Task").text = task_name.capitalize()
		# newtask.get_node("ProgressBar").max_value = task.threshhold
		# newtask.get_node("ProgressBar").value = task.progress
