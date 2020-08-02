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
	for i in $work_rules.get_children():
		i.connect('pressed', self, 'set_work_rule', [i.name])
		i.hint_tooltip = "WORKRULE" + i.name.to_upper() + "DESCRIPT"


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

		### Temporary Patch
		if person.travel.location == "mansion": person.travel.location = "Aliron"

		var gatherable_resources
		var person_location = person.get_location()
		var location = ResourceScripts.world_gen.get_location_from_code(person_location)
		var location_type
		if person_location != 'Aliron':
			location_type = location.type
			if location_type == "dungeon":
				gatherable_resources = ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources
			else:
				gatherable_resources = ResourceScripts.world_gen.get_location_from_code(person_location).gather_resources
		else:
			gatherable_resources = ResourceScripts.game_world.areas[location.area].gatherable_resources
			for i in races.tasklist.values():
				if globals.checkreqs(i.reqs) == false:
					continue
				var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
				newbutton.get_child(0).text = i.name
				newbutton.connect('pressed', self, 'show_job_details', [i])
				if person.tags.has('no_sex') && i.tags.has("sex"):
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, person.translate(tr("INTERACTIONSNOSEXTAG")))
		
		for resource in gatherable_resources:
			var text = ""
			var max_workers_count = 0
			var current_workers_count = 0
			var item_dict = Items.materiallist[resource]
			var progress_formula = Items.materiallist[resource].progress_formula
			text = progress_formula.capitalize()
			var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
			newbutton.set_meta("resource", resource)
			if person_location != 'Aliron' && location_type != "dungeon":
				max_workers_count = gatherable_resources[resource]
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == resource) && (task.task_location == person_location):
						current_workers_count = task.workers_count
				text += " " + str(current_workers_count) + "/" + str(max_workers_count)
				newbutton.disabled = current_workers_count == max_workers_count
			elif location_type == "dungeon":
				if gatherable_resources[resource] == 0:
					for button in $job_panel/ScrollContainer/VBoxContainer.get_children():
						if button.name == "Button" || !button.has_meta('resource'): continue
						if button.get_meta("resource") == resource: button.queue_free()
					continue
				text += " " + str(gatherable_resources[resource])
			newbutton.get_child(0).text = text
			newbutton.connect('pressed', self, 'show_job_details', [item_dict, true])



func show_job_details(job, gatherable = false):
	$ConfirmButton.show()
	$ConfirmButton.disabled = !gatherable
	$CancelButton.show()
	currentjob = job
	$job_details.show()
	var job_name
	var job_descript = job.descript
	var work_stat = statdata.statdata[job.workstat].name
	var work_tools
	input_handler.ClearContainer($job_details/ResourceOptions)
	if gatherable:
		job_name = job.progress_formula.capitalize()
		if job.tool_type != "":
			work_tools = statdata.worktoolnames[job.tool_type]
	else:
		job_name = job.name
		if job.has("worktool"):
			work_tools = statdata.worktoolnames[job.worktool]
	$job_details/JobName.text = job_name
	var text = (job_descript
		+ "\n"
		+ tr("TASKMAINSTAT")
		+ ": [color=yellow]"
		+ work_stat
		+ "[/color]"
	)
	if (job.has("tool_type") || job.has("worktool")):# && job.tool_type != "":
		text += (
			"\n"
			+ tr("WORKTOOL")
			+ ": [color=aqua]"
			+ work_tools
			+ "[/color]. \n"
		)
		## Work tools checking
		if person.equipment.gear.tool != null:
			var worktool
			var item = ResourceScripts.game_res.items[person.equipment.gear.tool]
			if job.has("worktool"):
				worktool = "worktool"
			if job.has("tool_type"):
				worktool = "tool_type"
			if item.toolcategory.has(job[worktool]):
				text += "[color=green]" + tr("CORRECTTOOLEQUIPPED") + "[/color]"

	$job_details/RichTextLabel.bbcode_text = text
	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
		i.pressed = i.get_child(0).text == job_name

	# 	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
	# 		i.pressed = i.get_child(0).text == job.name
	# 	$job_details/JobName.text = job.name
	if !gatherable:
		for i in job.production.values():
			if globals.checkreqs(i.reqs) == false:
				continue
			var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
			# if Items.materiallist.has(i.item):
			# 	var number
			# 	number = person.get_progress_task(job.code, i.code)/i.progress_per_item
			# 	text = (
			# 		"\n[color=yellow]Expected gain per day: "
			# 		+ str(stepify(number * 24, 0.1))
			# 		+ "[/color]"
			# 	)
			# 	newbutton.get_node("icon").texture = Items.materiallist[i.item].icon
			# 	newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
			# 	globals.connectmaterialtooltip(newbutton, Items.materiallist[i.item], text)
			# else:
			var number
			number = person.get_progress_task(job.code, i.code)/i.progress_per_item
			newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
			newbutton.get_node("icon").texture = i.icon
			globals.connecttexttooltip(newbutton, tr(i.descript) + text)
			newbutton.connect('pressed', self, 'select_resource', [job, i.code, newbutton])
	else:
		var number
		number = person.xp_module.get_progress_resource(job.code)/job.progress_per_item
		var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
		newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
		newbutton.get_node("icon").texture = job.icon
		selected_job = job


func select_resource(job, resource, newbutton):
	for button in $job_details/ResourceOptions.get_children():
		button.pressed = button == newbutton
	selected_resource = resource
	selected_job = job
	$ConfirmButton.disabled = false


func select_job():
	var gatherable = Items.materiallist.has(selected_job.code)
	person = get_parent().active_person
	if !gatherable:
		person.assign_to_task(selected_job.code, selected_resource)
	else:
		person.assign_to_task(selected_job.code, selected_job.code)
	get_parent().SlaveListModule.update()
	if selected_job.code in ["building"]:
		get_parent().TaskModule.task_index = 0
	else:
		get_parent().TaskModule.task_index = 1
	if !get_parent().TaskModule.is_visible():
		get_parent().TaskModule.change_button()
	get_parent().rebuild_task_info()
	open_jobs_window()
	cancel_job_choice()


func set_rest():
	person.remove_from_task()
	get_parent().SlaveListModule.update()
	get_parent().rebuild_task_info()
	open_jobs_window()
