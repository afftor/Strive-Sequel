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


	


func set_work_rule(rule):
	var setting = get_node("work_rules/"+rule).pressed
	person.xp_module.work_rules[rule] = setting
	if rule == "luxury":
		open_jobs_window()
		return
	match setting:
		true:
			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table["work_rule_" + rule])
			person.apply_effect(effects_pool.add_effect(eff))
		false:
			person.remove_static_effect_by_code("work_rule_" + rule)

	if currentjob != null:
		var gatherable = Items.materiallist.has(currentjob.code)
		show_job_details(currentjob, gatherable)

	

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
	var luxury_rooms_taken = 0
	for p in ResourceScripts.game_party.characters.values():
		if p.xp_module.work_rules["luxury"]:
			luxury_rooms_taken += 1
	$work_rules/luxury.text = "Luxury Rooms: " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.xp_module.work_rules["luxury"]
	
	$work_rules/luxury.visible = person != ResourceScripts.game_party.get_master()
	if person != null:
		for i in $work_rules.get_children():
			i.pressed = person.xp_module.work_rules[i.name]
		$work_rules/constrain.visible = !person.has_profession("master")
		$job_details.hide()
		input_handler.ClearContainer($job_panel/ScrollContainer/VBoxContainer)
		currentjob = null
		var restbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
		restbutton.get_child(0).text = tr("TASKREST")
		restbutton.toggle_mode = true
		restbutton.connect("pressed", self, 'set_rest')
		restbutton.pressed = person.get_work() == ''

		### Temporary Patch
		if person.travel.location == "mansion": person.travel.location = "aliron"

		var gatherable_resources = []
		var person_location = person.get_location()
		var location = ResourceScripts.world_gen.get_location_from_code(person_location)
		var location_type
		if person_location != 'aliron':
			location_type = location.type
			if location_type == "dungeon":
				if location.completed == true:
					gatherable_resources = ResourceScripts.world_gen.get_location_from_code(person_location).gather_limit_resources
			else:
				if ResourceScripts.world_gen.get_location_from_code(person_location).has("gather_resources"):
					gatherable_resources = ResourceScripts.world_gen.get_location_from_code(person_location).gather_resources
					
		else:
			gatherable_resources = ResourceScripts.game_world.areas[location.area].gatherable_resources
			for i in races.tasklist.values():
				if globals.checkreqs(i.reqs) == false:
					continue
				var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
				newbutton.get_child(0).text = i.name
				newbutton.set_meta("work", i)
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
			text =  "Gather " + item_dict.name.capitalize()
			var newbutton = input_handler.DuplicateContainerTemplate($job_panel/ScrollContainer/VBoxContainer)
			newbutton.set_meta("resource", resource)
			if person_location != 'aliron' && location_type != "dungeon":
				max_workers_count = gatherable_resources[resource]
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == resource) && (task.task_location == person_location):
						current_workers_count = task.workers_count
				text += " " + str(current_workers_count) + "/" + str(max_workers_count)
				newbutton.disabled = current_workers_count == max_workers_count
				if current_workers_count == max_workers_count:
					newbutton.get_node("Label").set("custom_colors/font_color", Color(0.87,0.87,0.87, 1))
				else:
					newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
			elif location_type == "dungeon":
				if gatherable_resources[resource] == 0:
					for button in $job_panel/ScrollContainer/VBoxContainer.get_children():
						if button.name == "Button" || !button.has_meta('resource'): continue
						if button.get_meta("resource") == resource: button.queue_free()
					continue
				text += " " + str(gatherable_resources[resource])
			newbutton.get_child(0).text = text
			newbutton.set_meta("work", item_dict)
			newbutton.connect('pressed', self, 'show_job_details', [item_dict, true])



func show_job_details(job, gatherable = false):
	$job_panel/ScrollContainer/VBoxContainer.get_child(0).pressed = false
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
		job_name = "Gather " + job.name.capitalize()
		job_descript = 'Gather availiable resources from location'
		if job.has("tool_type") && job.tool_type != "":
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
	if ((job.has("tool_type") && job.tool_type != '' ) || job.has("worktool")):# && work_tools != "":
		if job.has("worktool"):
			work_tools = statdata.worktoolnames[job.worktool]
		if job.has("tool_type"):
			work_tools = statdata.worktoolnames[job.tool_type]
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
	# for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
	# 	i.pressed = i.get_child(0).text == job_name
	for button in $job_panel/ScrollContainer/VBoxContainer.get_children():
		if !button.has_meta("work"): continue
		button.pressed = button.get_meta("work") == job

	# 	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
	# 		i.pressed = i.get_child(0).text == job.name
	# 	$job_details/JobName.text = job.name
	var selected_res
	var default_resource
	if !gatherable:
		if job.has("production"):
			for i in job.production.values():
				if globals.checkreqs(i.reqs) == false:
					continue
				var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
				var number
				number = person.get_progress_task(job.code, i.code)/i.progress_per_item
				newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
				if i.has("icon"):
					newbutton.get_node("icon").texture = i.icon
				else:
					var item_icon
					if Items.materiallist.has(i.item):
						item_icon = Items.materiallist[i.item].icon
						newbutton.get_node("icon").texture = item_icon
				newbutton.set_meta("resource", i.code)
				if i.has("descript"):
					globals.connecttexttooltip(newbutton, tr(i.descript) + text)
				else:
					var item_descript
					if Items.materiallist.has(i.item):
						item_descript = Items.materiallist[i.item].descript
						globals.connecttexttooltip(newbutton, tr(item_descript) + text)
				newbutton.connect('pressed', self, 'select_resource', [job, i.code, newbutton])
				selected_res = i.code
				default_resource = newbutton
	else:
		var number
		number = person.xp_module.get_progress_resource(job.code)/job.progress_per_item
		text = ("\n[color=yellow]Expected gain per day: " + str(stepify(number * 24, 0.1)) + "[/color]")
		var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
		newbutton.get_node("number").text = str(stepify(number * 24, 0.1))
		newbutton.get_node("icon").texture = job.icon
		newbutton.set_meta("resource", job.code)
		globals.connectmaterialtooltip(newbutton, job, text)
		newbutton.connect('pressed', self, 'select_resource', [job, job.code, newbutton])
		selected_res = job.code
		default_resource = newbutton
	select_resource(job, selected_res, default_resource)

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
	get_parent().TaskModule.change_button()
	get_parent().rebuild_task_info()
	cancel_job_choice()
	get_parent().mansion_state_set("default")


func set_rest():
	person.remove_from_task()
	get_parent().SlaveListModule.update()
	get_parent().rebuild_task_info()
	open_jobs_window()
