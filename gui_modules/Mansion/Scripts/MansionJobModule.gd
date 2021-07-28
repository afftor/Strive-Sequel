extends Control

var currentjob
var person
var selected_resource
var selected_job = {}
var selected_location = "aliron"



func _ready():
	#for i in ['restup', 'workup', 'joyup', 'restdown', 'workdown', 'joydown']:
	#	get_node("job_details/WorkDetailsPanel/" + i).connect(
	#		"pressed", self, "change_hours", [i])
	#$ConfirmButton.connect('pressed', self, 'select_job')
	#$CancelButton.connect('pressed', self, 'cancel_job_choice')
	#for i in $work_rules.get_children():
	#	i.connect('pressed', self, 'set_work_rule', [i.name])
	#	i.hint_tooltip = "WORKRULE" + i.name.to_upper() + "DESCRIPT"
	$CloseButton.connect("pressed", self, 'close_job_pannel')
	gui_controller.add_close_button(self, "add_offset")

func rebuild():
	gui_controller.clock.hide()
	build_accessible_locations()
	#update_buttons()
	update_characters()
	update_resources()

func update_characters():
	input_handler.ClearContainer($CharacterList/GridContainer)
	for i in ResourceScripts.game_party.character_order: 
		var person = ResourceScripts.game_party.characters[i]
		if person.get_location() != ResourceScripts.world_gen.get_location_from_code(selected_location).id:
			continue
		
		var newbutton = input_handler.DuplicateContainerTemplate($CharacterList/GridContainer)
		newbutton.get_node("Name").text = person.get_stat("name")
		newbutton.get_node("Icon").texture = person.get_icon()
		newbutton.disabled = selected_job == null || selected_resource == null
		#newbutton.pressed = (get_parent().active_person == person)
		newbutton.set_meta('slave', person)
		# globals.connectslavetooltip(newbutton, person)
		newbutton.connect('pressed', get_parent(), 'set_active_person', [person])
		newbutton.connect('pressed', self, 'character_selected', [newbutton, person])
		newbutton.connect('gui_input', self, 'double_clicked', [newbutton])
		#speed update
		if selected_job != null and selected_resource != null:
			if selected_resource == "rest":
				newbutton.get_node("Speed").text = ""
			else:
				var number = ""
				number = person.get_progress_task(selected_job.code, selected_job.production_code)/selected_job.progress_per_item
				newbutton.get_node("Speed").text = str(stepify(number * 24, 0.1))
		#status update
		var gatherable = Items.materiallist.has(person.get_work())
		if person.get_work() == '' or person.get_work() == "Assignment" or person.get_work() == "disabled":
			if person.is_on_quest():
				newbutton.disabled = true
				var time_left = int(person.get_quest_time_remains())
				if time_left > 0:
					var time_left_string = ''
					if time_left == 1:
						time_left = 24 - ResourceScripts.game_globals.hour
						time_left_string = str(time_left) + " h."
					else:
						time_left_string = str(time_left) + " d."
					newbutton.get_node("Status").text = "On Quest: " + time_left_string
				else:
					newbutton.get_node("Status").text = tr("CHAR_UNAVALIABLE")
			else:
				newbutton.get_node("Status").text = tr("TASKREST")
		else:
			if !gatherable:
				newbutton.get_node("Status").text = races.tasklist[person.get_work()].name
			else:
				newbutton.get_node("Status").text = "Gathering " + Items.materiallist[person.get_work()].name

func character_selected(button, person):
	get_parent().active_person = person
	for i in $CharacterList/GridContainer.get_children():
		if i.pressed:
			i.pressed = false
	button.pressed = true
	select_job()
	

func update_buttons():
	var nav = $NavigationModule/NavigationContainer/AreaSelection
	for button in nav.get_children():
		if button.name == "Button" || button.get_class() != 'Button' || !button.has_meta("data"):
			continue
		var m = button.get_meta("data")
		button.pressed = selected_location == m
	var l = ResourceScripts.world_gen.get_location_from_code(selected_location)
	if l == null:
		return
	if l.has("background"):
		$Landscape.texture = images.backgrounds[l.background]
	elif l.has("id"):
		if l.id == "aliron":
			$Landscape.texture = images.backgrounds["aliron"]


func sort_locations(locations_array):
	var capitals = ["Mansion"]
	var settlements = []
	var dungeons = []
	var quest_locations = []
	for loca in locations_array:
		if loca == null:
			locations_array.erase(null)
			continue
		if loca == "mansion" || loca == "travel": continue
		match ResourceScripts.world_gen.get_location_from_code(loca).type:
			"capital":
				capitals.append(loca)
			"settlement":
				settlements.append(loca)
			"dungeon","encounter":
				dungeons.append(loca)
			"quest_location":
				quest_locations.append(loca)
	return capitals + settlements + dungeons + quest_locations


func build_accessible_locations():
	var nav = $NavigationModule/NavigationContainer/AreaSelection
	input_handler.ClearContainer(nav)
	var location_array = ["aliron"]
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var person_location = person.get_location()
		if person_location == "mansion":
			person_location = "aliron"
		if (!location_array.has(person_location)):
			location_array.append(person_location)
	var sorted_locations = sort_locations(location_array)
	
	for i in sorted_locations:
		if i == "Mansion":
			continue
		var newseparator = $NavigationModule/VSeparator.duplicate()
		var newbutton = input_handler.DuplicateContainerTemplate(nav)
		nav.add_child(newseparator)
		if i != sorted_locations[sorted_locations.size() - 1]:
			newseparator.visible = true
		else:
			newseparator.visible = false
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "select_location", [i])
		newbutton.set_meta("data", i)
		update_buttons()


func select_location(location):
	selected_location = location
	rebuild()
	var l = ResourceScripts.world_gen.get_location_from_code(location)
	if l.has("background"):
		$Landscape.texture = images.backgrounds[l.background]
	elif l.has("id"):
		if l.id == "aliron":
			$Landscape.texture = images.backgrounds["aliron"]
	#print_debug(ResourceScripts.world_gen.get_location_from_code(location).gatherable_resources)
	pass








#func set_work_rule(rule):
#	var setting = get_node("work_rules/"+rule).pressed
#	person.xp_module.work_rules[rule] = setting
#	if rule == "luxury":
#		update_resources()
#		return
#	match setting:
#		true:
#			var eff = effects_pool.e_createfromtemplate(Effectdata.effect_table["work_rule_" + rule])
#			person.apply_effect(effects_pool.add_effect(eff))
#		false:
#			person.remove_static_effect_by_code("work_rule_" + rule)
#
#	if currentjob != null:
#		var gatherable = Items.materiallist.has(currentjob.code)
#		show_job_details(currentjob, gatherable)



func cancel_job_choice():
	$ConfirmButton.hide()
	$CancelButton.hide()
	$job_details.hide()
	selected_resource = null
	selected_job = {}


func close_job_pannel():
	gui_controller.clock.raise()
	hide()
	get_parent().mansion_state = "default"


func update_resources():
	input_handler.ClearContainer($Resourses/GridContainer)
	var restbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
	restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/rest_icon.png")
	restbutton.connect("pressed", self, "select_resource", [{code = "rest"}, "rest", restbutton])
	
	person = get_parent().active_person
	var luxury_rooms_taken = 0
	for p in ResourceScripts.game_party.characters.values():
		if p.xp_module.work_rules["luxury"]:
			luxury_rooms_taken += 1
	#$work_rules/luxury.text = "Luxury Rooms: " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	#$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.xp_module.work_rules["luxury"]

	#$work_rules/luxury.visible = person != ResourceScripts.game_party.get_master()
	#if person != null: 
	currentjob = null
	### Temporary Patch
	#if person.travel.location == "mansion": person.travel.location = "aliron"
	var gatherable_resources = []
	var person_location = selected_location
	var location = ResourceScripts.world_gen.get_location_from_code(person_location)
	var location_type
	if location.has("locked"):
		if location.locked:
			return
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
			#don't show if res in not unlocked
			if i.has('upgrade_code') && i.has('workers_per_upgrade') && i.has('base_workers'):
				if i.base_workers + i.workers_per_upgrade * ResourceScripts.game_res.findupgradelevel(i.upgrade_code) <= 0:
					continue
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			#newbutton.get_child(0).text = i.name
			newbutton.pressed = selected_job == i
			newbutton.set_meta("work", i)
			var selected_job = i
			var selected_res
			if i.has("production_item"):
				selected_res = i.production_item
			newbutton.connect("pressed", self, "select_resource", [selected_job, selected_res, newbutton])
			if i.has("production_icon"):
				newbutton.get_node("TextureRect").texture = i.production_icon
			elif i.has("production_item"):
				newbutton.get_node("TextureRect").texture = Items.materiallist[i.production_item].icon
			newbutton.connect('pressed', self, 'show_job_details', [i])
			# start checking maximum persons per work in aliron
			if i.has('upgrade_code') && i.has('workers_per_upgrade') && i.has('base_workers'):
				var upgrade_level = ResourceScripts.game_res.findupgradelevel(i.upgrade_code)
				var max_workers_count = i.base_workers + i.workers_per_upgrade * upgrade_level
				var text = ""#i.name
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i.code) && (task.task_location == person_location):
						current_workers_count = task.workers_count
				text += str(current_workers_count) + "/" + str(max_workers_count)
				newbutton.get_node("Label").text = text
				newbutton.disabled = current_workers_count == max_workers_count
				if current_workers_count >= max_workers_count:
					newbutton.get_node("Label").set("custom_colors/font_color", Color(0.87,0.87,0.87, 1))
				else:
					newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
	for resource in gatherable_resources:
		var text = ""
		var max_workers_count = 0
		var current_workers_count = 0
		var item_dict = Items.materiallist[resource]
		var progress_formula = Items.materiallist[resource].progress_formula
		#text =  "Gather " + item_dict.name.capitalize()
		var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
		newbutton.pressed = selected_job == item_dict
		newbutton.set_meta("resource", resource)
		
		selected_job = item_dict
		var selected_res
		if item_dict.has("production_item"):
			selected_res = item_dict.production_item
		newbutton.connect("pressed", self, "select_resource", [selected_job, selected_res, newbutton])
		
		newbutton.get_node("TextureRect").texture = item_dict.icon
		newbutton.connect('pressed', self, 'show_job_details', [item_dict])
		
		if person_location != 'aliron' && location_type != "dungeon":
			max_workers_count = gatherable_resources[resource]
			var active_tasks = ResourceScripts.game_party.active_tasks
			for task in active_tasks:
				if (task.code == resource) && (task.task_location == person_location):
					current_workers_count = task.workers_count
			text +=  str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.disabled = current_workers_count == max_workers_count
			if current_workers_count == max_workers_count:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.87,0.87,0.87, 1))
			else:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
		elif location_type == "dungeon":
			if gatherable_resources[resource] == 0:
				for button in $Resourses/GridContainer.get_children():
					if button.name == "Button" || !button.has_meta('resource'): continue
					if button.get_meta("resource") == resource: button.queue_free()
				continue
			text += str(gatherable_resources[resource])
		#newbutton.get_node("Speed").text = text
		newbutton.set_meta("work", item_dict)


func show_job_details(job, gatherable = false):
	#$job_panel/ScrollContainer/VBoxContainer.get_child(0).pressed = false
	#$ConfirmButton.show()
	#$ConfirmButton.disabled = !gatherable
	#$CancelButton.show()
	currentjob = job
	$ToolLabel.text = ""
	var job_name
	var job_descript = job.descript
	var work_stat = statdata.statdata[job.workstat].name
	var work_tools
	#input_handler.ClearContainer($job_details/ResourceOptions)
	if gatherable:
		job_name = "Gather " + job.name.capitalize()
		job_descript = 'Gather availiable resources from location'
		if job.has("tool_type") && job.tool_type != "":
			work_tools = statdata.worktoolnames[job.tool_type]
	else:
		job_name = job.name
		if job.has("worktool"):
			work_tools = statdata.worktoolnames[job.worktool]
	#$job_details/JobName.text = job_name
	var text = (job_descript
		+ "\n"
		+ tr("TASKMAINSTAT")
		+ ": [color=yellow]"
		+ work_stat
		+ "[/color]"
		+ "\n"
	)
	if ((job.has("tool_type") && job.tool_type != '' ) || job.has("worktool")):# && work_tools != "":
		if job.has("worktool"):
			work_tools = statdata.worktoolnames[job.worktool]
		if job.has("tool_type"):
			work_tools = statdata.worktoolnames[job.tool_type]
		text += (
			tr("WORKTOOL")
			+ ": [color=aqua]"
			+ work_tools
			+ "[/color] \n"
		)
		$ToolLabel.text = work_tools
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
	
	# Maximum workers info
	if job.has("base_workers") && job.has("workers_per_upgrade"):
		var upgrade_level = ResourceScripts.game_res.findupgradelevel(job.upgrade_code)
		var upgrade_name = upgradedata.upgradelist[job.upgrade_code].name
		text += (
		tr("MAXIMUM_WORKERS") 
		+ ": [color=yellow]"
		+ String(job.base_workers + job.workers_per_upgrade * upgrade_level)
		+ "[/color] \n" )
		
		text += (
		tr("REQUIRED_UPGRADE_NAME")
		+ ": [color=green]"
		+ String(tr(upgrade_name))
		+ "[/color] \n" )
		
		text += (
		tr("WORKERS_PER_UPGRADE") 
		+ ": [color=yellow]"
		+ String(job.workers_per_upgrade)
		+ "[/color]. \n" )
	
#	$job_details/RichTextLabel.bbcode_text = text
	# for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
	# 	i.pressed = i.get_child(0).text == job_name
	for button in $Resourses/GridContainer.get_children():
		if !button.has_meta("work"): continue
		button.pressed = button.get_meta("work") == job

	# 	for i in $job_panel/ScrollContainer/VBoxContainer.get_children():
	# 		i.pressed = i.get_child(0).text == job.name
	# 	$job_details/JobName.text = job.name
	var selected_res
	var default_resource
	if !gatherable:
		pass
#		if job.has("production"):
#			for i in job.production.values():
#				if globals.checkreqs(i.reqs) == false:
#					continue
#				var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
#				var number
#				number = person.get_progress_task(job.code, i.code)/i.progress_per_item
#				newbutton.get_node("Speed").text = str(stepify(number * 24, 0.1))
#				if i.has("icon"):
#					newbutton.get_node("icon").texture = i.icon
#				else:
#					var item_icon
#					if Items.materiallist.has(i.item):
#						item_icon = Items.materiallist[i.item].icon
#						newbutton.get_node("icon").texture = item_icon
#				newbutton.set_meta("resource", i.code)
#				if i.has("descript"):
#					globals.connecttexttooltip(newbutton, tr(i.descript) + text)
#				else:
#					var item_descript
#					if Items.materiallist.has(i.item):
#						item_descript = Items.materiallist[i.item].descript
#						globals.connecttexttooltip(newbutton, tr(item_descript) + text)
#				newbutton.connect('pressed', self, 'select_resource', [job, i.code, newbutton])
#				selected_res = i.code
#				default_resource = newbutton
	else:
		var number
		number = person.xp_module.get_progress_resource(job.code)/job.progress_per_item
		text = ("\n[color=yellow]Expected gain per day: " + str(stepify(number * 24, 0.1)) + "[/color]")
		var newbutton = input_handler.DuplicateContainerTemplate($job_details/ResourceOptions)
		newbutton.get_node("Speed").text = str(stepify(number * 24, 0.1))
		newbutton.get_node("icon").texture = job.icon
		newbutton.set_meta("resource", job.code)
		globals.connectmaterialtooltip(newbutton, job, text)
		newbutton.connect('pressed', self, 'select_resource', [job, job.code, newbutton])
		selected_res = job.code
		default_resource = newbutton

func select_resource(job, resource, newbutton):
	for button in $Resourses/GridContainer.get_children():
		button.pressed = button == newbutton
	selected_resource = resource
	selected_job = job
	update_characters()


func select_job():
	person = get_parent().active_person
	if selected_job.code == "rest":
		set_rest()
		return
	var gatherable = Items.materiallist.has(selected_job.code)
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
	update_resources()
	update_characters()
	#cancel_job_choice()
	#get_parent().mansion_state_set("default")


func set_rest():
	person.remove_from_task()
	get_parent().SlaveListModule.update()
	get_parent().rebuild_task_info()
	update_resources()
	update_characters()
