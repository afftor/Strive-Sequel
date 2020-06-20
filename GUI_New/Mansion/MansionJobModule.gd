extends Control

var currentjob
var person


func _ready():
	for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:
		get_node("job_panel/job_details/WorkDetailsPanel/" + i).connect(
			"pressed", self, "change_hours", [i]
		)

	$job_panel/job_details/CloseButton.connect("pressed", self, "close_job_pannel")


func change_hours(i):
	pass


func close_job_pannel():
	get_parent().mansion_state = "default"


func open_jobs_window():
	person = get_parent().active_person
	if person != null:
		$job_panel/job_details.hide()
		input_handler.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
		currentjob = null
		var restbutton = input_handler.DuplicateContainerTemplate(
			$job_panel/ScrollContainer/VBoxContainer
		)
		restbutton.get_child(0).text = tr("TASKREST")
		restbutton.connect("pressed", self, 'set_rest')

		for i in races.tasklist.values():
			if globals.checkreqs(i.reqs) == false:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate(
				$job_panel/ScrollContainer/VBoxContainer
			)
			newbutton.get_child(0).text = i.name
			newbutton.connect('pressed', self, 'show_job_details', [i])
			if person.tags.has('no_sex') && i.tags.has("sex"):
				newbutton.disabled = true
				globals.connecttexttooltip(newbutton, person.translate(tr("INTERACTIONSNOSEXTAG")))

		for i in person.xp_module.work_rules:
			get_node("job_panel/work_rules/" + i).pressed = person.xp_module.work_rules[i]
		$job_panel/work_rules/constrain.visible = person != ResourceScripts.game_party.get_master()


func show_job_details(job):
	currentjob = job
	$job_panel/job_details.show()
	input_handler.ClearContainer($job_panel/job_details/ResourceOptions)
	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.get_child(0).text == job.name
	var text = (
		"[center]"
		+ job.name
		+ '[/center]\n'
		+ job.descript
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

	$job_panel/job_details/RichTextLabel.bbcode_text = text

	for i in job.production.values():
		if globals.checkreqs(i.reqs) == false:
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($job_panel/job_details/ResourceOptions)
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

		newbutton.connect('pressed', self, 'select_job', [job, i.code])


func select_job(job, production):
	person = get_parent().active_person
	person.assign_to_task(job.code, production)
	update()
	input_handler.slave_list_node.update()
	get_parent().rebuild_task_info()


func set_rest():
	person.remove_from_task()
	update()
	input_handler.slave_list_node.update()
