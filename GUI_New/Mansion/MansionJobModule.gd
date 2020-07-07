extends Control

var currentjob
var person
var selected_resource
var selected_job = {}


func _ready():
	for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:
		get_node("job_details/WorkDetailsPanel/" + i).connect(
			"pressed", self, "change_hours", [i]
		)
	$ConfirmButton.connect('pressed', self, 'select_job')
	$CancelButton.connect('pressed', self, 'cancel_job_choice')


func change_hours(i):
	pass

func cancel_job_choice():
	$ConfirmButton.hide()
	$CancelButton.hide()
	$job_details.hide()
	selected_resource = null
	selected_job = {}


func close_job_pannel():
	get_parent().mansion_state = "default"


func open_jobs_window():
	person = get_parent().active_person
	if person != null:
		$job_details.hide()
		input_handler.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
		currentjob = null
		var restbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
		restbutton.get_child(0).text = tr("TASKREST")
		restbutton.toggle_mode = false
		restbutton.connect("pressed", self, 'set_rest')
		if person.get_location() != 'Aliron':
			var location = ResourceScripts.world_gen.get_location_from_code(person.get_location())
#			for i in location.tasks:
#				if i == 'gather':
#					var check = false
#					for k in location.gather_limit_resources.keys():
#						if location.gather_limit_resources[k] > 0:
#							check = true
#							break
#					if check == true:
#						var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
#						newbutton.get_child(0).text = "Collect Materials"
#						newbutton.connect('pressed', self, 'show_collect_details', [location])
		else:
			for i in races.tasklist.values():
				if globals.checkreqs(i.reqs) == false:
					continue
				var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
				newbutton.get_child(0).text = i.name
				newbutton.connect('pressed', self, 'show_job_details', [i])
				if person.tags.has('no_sex') && i.tags.has("sex"):
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, person.translate(tr("INTERACTIONSNOSEXTAG")))

		for i in person.xp_module.work_rules:
			get_node("work_rules/" + i).pressed = person.xp_module.work_rules[i]
		$work_rules/constrain.visible = person != ResourceScripts.game_party.get_master()

#func show_collect_details(location):
#	$ConfirmButton.show()
#	$ConfirmButton.disabled = true
#	$CancelButton.show()
#	$job_details.show()
#	input_handler.ClearContainer($job_details/ResourceOptions)
#	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
#		i.pressed = i.get_child(0).text == "Collect Materials"
#
#	$job_details/JobName.text = "Collect Materials"
#	var text = ('')
#
#	$job_details/RichTextLabel.bbcode_text = text
#	for i in location.gather_limit_resources:
#		if location.gather_limit_resources[i] > 0:
#			var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
#			var item = Items.materiallist[i]
#			var number
#			var numberleft = location.gather_limit_resources[i]
#			var progress_speed = person.get_progress_task
##			number = person.get_progress_task(job.code, i.code)/i.progress_per_item
#			text = (
#				"\n[color=yellow]Expected gain per day: "
#				+ str(stepify(number * 24, 0.1))
#				+ "[/color]"
#			)
#
#			newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
#			newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
#			globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], text)

func show_job_details(job):
	$ConfirmButton.show()
	$ConfirmButton.disabled = true
	$CancelButton.show()
	currentjob = job
	$job_details.show()
	input_handler.ClearContainer($job_details/ResourceOptions)
	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.get_child(0).text == job.name
	$job_details/JobName.text = job.name
	var text = (
		job.descript
		+ "\n\n"
		+ tr("TASKMAINSTAT")
		+ ": [color=yellow]"
		+ statdata.statdata[job.workstat].name
		+ "[/color]"
	)
	if job.has("worktool"):
		text += (
			"\n"
			+ tr("WORKTOOL")
			+ ": [color=aqua]"
			+ statdata.worktoolnames[job.worktool]
			+ "[/color]. \n"
		)
		if person.equipment.gear.tool != null:
			var item = ResourceScripts.game_res.items[person.equipment.gear.tool]
			if item.toolcategory.has(job.worktool):
				text += "[color=green]" + tr("CORRECTTOOLEQUIPPED") + "[/color]"

	$job_details/RichTextLabel.bbcode_text = text

	for i in job.production.values():
		if globals.checkreqs(i.reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
		if Items.materiallist.has(i.item):
			var number
			number = person.get_progress_task(job.code, i.code)/i.progress_per_item
			text = (
				"\n[color=yellow]Expected gain per day: "
				+ str(stepify(number * 24, 0.1))
				+ "[/color]"
			)
#			else:
#				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item*(person.productivity*person.get_stat(job.mod)/100),0.1)
#				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
			newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
			globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], text)
		else:
			var number
			number = person.get_progress_task(job.code, i.code)/i.progress_per_item
			text = (
				"\n[color=yellow]Expected gain per day: "
				+ str(stepify(number * 24, 0.1))
				+ "[/color]"
			)
#			else:
#				number = stepify(person.workhours*races.get_progress_task(person, job.code, i.code)/i.progress_per_item*(person.productivity*person.get_stat(job.mod)/100),0.1)
#				text = "\n[color=yellow]Expected gain per work day: " + str(number) + "[/color]"
			newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
			newbutton.get_node("icon").texture = i.icon
			globals.connecttexttooltip(newbutton, i.descript + text)
		newbutton.connect('pressed', self, 'select_resource', [job, i.code, newbutton])

func select_resource(job, resource, newbutton):
	for button in $job_details/ResourceOptions.get_children():
		button.pressed = button == newbutton
	selected_resource = resource
	selected_job = job
	$ConfirmButton.disabled = false


func select_job():
	person = get_parent().active_person
	person.assign_to_task(selected_job.code, selected_resource)
	get_parent().SlaveListModule.update()
	get_parent().TaskModule.task_index = 1
	get_parent().TaskModule.change_button()
	get_parent().rebuild_task_info()
	open_jobs_window()
	cancel_job_choice()


func set_rest():
	person.remove_from_task()
	get_parent().SlaveListModule.update()
	get_parent().rebuild_task_info()
