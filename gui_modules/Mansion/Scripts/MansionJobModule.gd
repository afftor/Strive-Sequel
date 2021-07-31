extends Control

var person
var selected_resource
var selected_job = {}
var selected_location = "aliron"



func _ready():
	$CloseButton.connect("pressed", self, 'close_job_pannel')
	gui_controller.add_close_button(self, "add_offset")#.connect("pressed", self, 'close_job_pannel')

#func raise_clock():
#	gui_controller.clock.raise()
#	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.clock, 0.3)

func rebuild():
	$DescriptionLabel.bbcode_text = ""
	$ToolLabel.text = ""
	$WorkunitLabel.text = ""
	$Modlabel.text = ""
	$Workmod.hide()
	$Workstat.hide()
	$Worktool.hide()
	$Workunit.hide()
	input_handler.ClearContainer($GridContainer2)
	build_accessible_locations()
	#update_buttons()
	update_characters()
	update_resources()

func update_characters():
	input_handler.ClearContainer($CharacterList/GridContainer)
	for i in ResourceScripts.game_party.character_order: 
		var person = ResourceScripts.game_party.characters[i]
		if person.get_location() != ResourceScripts.world_gen.get_location_from_code(selected_location).id or person.get_work() == "disabled":
			continue
		
		var newbutton = input_handler.DuplicateContainerTemplate($CharacterList/GridContainer)
		newbutton.get_node("Name").text = person.get_stat("name")
		newbutton.get_node("Icon").texture = person.get_icon()
		newbutton.disabled = selected_job == null || selected_resource == null
		newbutton.set_meta('slave', person)
		newbutton.connect('pressed', self, 'character_selected', [newbutton, person])
		newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
		newbutton.get_node("stats/hp").value = person.hp
		newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
		newbutton.get_node("stats/mp").value = person.mp
		newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
		#speed update
		if selected_job != null and selected_resource != null:
			if selected_resource == "rest":
				newbutton.get_node("Speed").text = ""
			else:
				var number = ""
				number = person.get_progress_task(selected_job.code, selected_job.production_code)/selected_job.progress_per_item
				newbutton.get_node("Speed").text = str(stepify(number * 24, 0.1))
		#status update
		update_status(newbutton, person)

func update_status(newbutton, person):
	var gatherable = Items.materiallist.has(person.get_work())
	if person.get_work() == '' or person.get_work() == "Assignment" or person.get_work() == "disabled":
		if !person.is_on_quest():
			newbutton.get_node("Status").texture = load("res://assets/images/gui/rest_icon.png")
	else:
		if !gatherable:
			var work = races.tasklist[person.get_work()]
			if work.has("production_icon"):
				newbutton.get_node("Status").texture = work.production_icon
			elif work.has("production_item"):
				newbutton.get_node("Status").texture = Items.materiallist[work.production_item].icon
		else:
			newbutton.get_node("Status").texture = Items.materiallist[person.get_work()].icon

func character_selected(button, person):
	get_parent().active_person = person
	select_job(button, person)
	

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
	selected_resource = null
	selected_job = null
	selected_location = location
	rebuild()
	var l = ResourceScripts.world_gen.get_location_from_code(location)
	if l.has("background"):
		$Landscape.texture = images.backgrounds[l.background]
	elif l.has("id"):
		if l.id == "aliron":
			$Landscape.texture = images.backgrounds["aliron"]


func close_job_pannel():
	selected_resource = null
	selected_job = null
	get_parent().SlaveListModule.update()
#	ResourceScripts.core_animations.UnfadeAnimation(get_parent(), 0.3)
	if gui_controller.clock != null:
		ResourceScripts.core_animations.UnfadeAnimation(gui_controller.clock, 0.3)
		gui_controller.clock.raise()
#	ResourceScripts.core_animations.FadeAnimation(self, 0.3)
#	get_parent().mansion_state = "default"
	get_parent().mansion_state_set("default")


func update_resources():
	input_handler.ClearContainer($Resourses/GridContainer)
	var restbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
	restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/rest_icon.png")
	restbutton.connect("pressed", self, "select_resource", [{code = "rest"}, "rest", restbutton])
	
	globals.connecttexttooltip(restbutton, "Rest")
	
	person = get_parent().active_person
#	var luxury_rooms_taken = 0
#	for p in ResourceScripts.game_party.characters.values():
#		if p.xp_module.work_rules["luxury"]:
#			luxury_rooms_taken += 1
	#$work_rules/luxury.text = "Luxury Rooms: " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	#$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.xp_module.work_rules["luxury"]
	#$work_rules/luxury.visible = person != ResourceScripts.game_party.get_master()

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
			newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
			#newbutton.get_child(0).text = i.name
			newbutton.pressed = selected_job == i
			newbutton.set_meta("work", i)
			
			if Items.materiallist.has(i.production_item):
				globals.connectmaterialtooltip(newbutton, Items.materiallist[i.production_item])
			else:
				globals.connecttexttooltip(newbutton, i.name)
			var selected_job = i
			var selected_res
			if i.has("production_item"):
				selected_res = i.production_item
			newbutton.connect("pressed", self, "select_resource", [selected_job, selected_res, newbutton])
			if i.has("production_icon"):
				newbutton.get_node("TextureRect").texture = i.production_icon
			elif i.has("production_item"):
				newbutton.get_node("TextureRect").texture = Items.materiallist[i.production_item].icon
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
				#newbutton.disabled = current_workers_count == max_workers_count
				if current_workers_count >= max_workers_count:
					newbutton.get_node("Label").set("custom_colors/font_color", Color(0.9,0.48,0.48, 1))
			elif i.code == "cooking" or i.code == "prostitution":
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i.code) && (task.task_location == person_location):
						current_workers_count = task.workers_count
				newbutton.get_node("Label").text = str(current_workers_count)
	for resource in gatherable_resources:
		var text = ""
		var max_workers_count = 0
		var current_workers_count = 0
		var item_dict = Items.materiallist[resource]
		var progress_formula = Items.materiallist[resource].progress_formula
		#text =  "Gather " + item_dict.name.capitalize()
		var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
		newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
		if selected_job != null and item_dict != null:
			if selected_job.has("production_item") and item_dict.has("code"):
				newbutton.pressed = selected_job.production_item == item_dict.code
		newbutton.set_meta("resource", resource)
		
		var selected_job = item_dict
		for i in races.tasklist.values():
			if i.has("production_item"):
				if i.production_item == selected_job.code:
					selected_job = i
		var selected_res
		if selected_job.has("production_item"):
			selected_res = selected_job.production_item
		newbutton.connect("pressed", self, "select_resource", [selected_job, selected_res, newbutton])
		
		newbutton.get_node("TextureRect").texture = item_dict.icon
		
		if person_location != 'aliron' && location_type != "dungeon":
			max_workers_count = gatherable_resources[resource]
			var active_tasks = ResourceScripts.game_party.active_tasks
			for task in active_tasks:
				if ((task.code == resource) || (task.product == resource)) && (task.task_location == person_location):
					current_workers_count = task.workers_count
			text +=  str(current_workers_count) + "/" + str(max_workers_count)
			#newbutton.disabled = current_workers_count == max_workers_count
			if current_workers_count >= max_workers_count:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.87,0.87,0.87, 1))
		elif location_type == "dungeon":
			if gatherable_resources[resource] == 0:
				for button in $Resourses/GridContainer.get_children():
					if button.name == "Button" || !button.has_meta('resource'): continue
					if button.get_meta("resource") == resource: button.queue_free()
				continue
			text += str(gatherable_resources[resource])
		newbutton.get_node("Label").text = text
		newbutton.set_meta("work", item_dict)


func select_resource(job, resource, newbutton):
	# part 1
	$ToolLabel.text = ""
	var work_tools
	if job.has("worktool"):
		work_tools = statdata.worktoolnames[job.worktool]
	if ((job.has("tool_type") && job.tool_type != '' ) || job.has("worktool")):# && work_tools != "":
		if job.has("worktool"):
			work_tools = statdata.worktoolnames[job.worktool]
		if job.has("tool_type"):
			work_tools = statdata.worktoolnames[job.tool_type]
		$ToolLabel.text = work_tools
		## Work tools checking
		if person.equipment.gear.tool != null:
			var worktool
			var item = ResourceScripts.game_res.items[person.equipment.gear.tool]
			if job.has("worktool"):
				worktool = "worktool"
			if job.has("tool_type"):
				worktool = "tool_type"
	for button in $Resourses/GridContainer.get_children():
		if !button.has_meta("work"): 
			continue
		button.pressed = button.get_meta("work") == job
	
	# part 2
	for button in $Resourses/GridContainer.get_children():
		button.pressed = button == newbutton
	selected_resource = resource
	selected_job = job
	$Workunit.hide()
	$Worktool.hide()
	$Workstat.hide()
	$Workmod.hide()
	$WorkunitLabel.hide()
	$Modlabel.hide()
	$WorkunitLabel.text = ""
	if job.code == "rest":
		$DescriptionLabel.bbcode_text = tr("TASKRESTDESCRIPT")
	elif job.has("descript"):
		if job.has('worktool'):
			$Worktool.show()
			globals.connecttexttooltip($Worktool, "Effective Tool: Will increase work speed when equipped")
		if job.progress_per_item != 1:
			$Workunit.show()
			$WorkunitLabel.show()
			$WorkunitLabel.text = str(job.progress_per_item)
			globals.connecttexttooltip($Workunit, "Progress required per item")
		var text = job.descript
		if job.has('workstat'):
			$Workstat.texture = stat_icons[job.workstat]
			$Workstat.show()
			globals.connecttexttooltip($Workstat, "Job Stat: " + tr("STAT"+job.workstat.to_upper()) + "\nThis stat will grow by attending to this job.")
		if job.has('mod'):
			$Modlabel.show()
			$Workmod.show()
			$Modlabel.text = tr("STAT" + job.mod.to_upper())
			globals.connecttexttooltip($Workmod, "Task effciency modificator")
		
		$DescriptionLabel.bbcode_text = text
	update_characters() # change for Speed update (and tool check? idk)
	show_faces()

func show_faces():
	input_handler.ClearContainer($GridContainer2)
	var max_workers_count = 0
	if selected_job.has('upgrade_code') && selected_job.has('workers_per_upgrade') && selected_job.has('base_workers'):
		var upgrade_level = ResourceScripts.game_res.findupgradelevel(selected_job.upgrade_code)
		max_workers_count = selected_job.base_workers + selected_job.workers_per_upgrade * upgrade_level
	if ResourceScripts.world_gen.get_location_from_code(selected_location).type == "dungeon":
		max_workers_count = 0
	for p in ResourceScripts.game_party.characters.values():
		var work = p.get_work()
		if selected_job.has('code') and selected_job.has('production_item'):
			if (selected_job.code == work || selected_job.production_item == work) and p.get_location() == selected_location:
				var b = input_handler.DuplicateContainerTemplate($GridContainer2)
				b.connect('pressed', self, 'set_rest', [null, p])
				b.get_node("TextureRect").texture = p.get_icon()
				if b.get_node('TextureRect').texture == null:
					if p.has_profession('master'):
						b.get_node('TextureRect').texture = images.icons.class_master
					elif p.get_stat('slave_class') == 'servant':
						b.get_node('TextureRect').texture = images.icons.class_servant
					else:
						b.get_node('TextureRect').texture = images.icons.class_slave
#				b.get_node("Label").text = p.get_stat("name")
				b.get_node("Label").text = p.get_short_name()
				max_workers_count -= 1
	for i in max_workers_count:
			input_handler.DuplicateContainerTemplate($GridContainer2)
	

var stat_icons = {
	physics = load("res://assets/images/gui/gui icons/icon_physics64.png"),
	wits = load("res://assets/images/gui/gui icons/icon_wits64.png"),
	charm = load("res://assets/images/gui/gui icons/icon_charm64.png"),
	sexuals = load("res://assets/images/gui/gui icons/icon_sex64.png"),
	
}

func select_job(button, person):
	person = get_parent().active_person
	
	if selected_job.code == "rest" || selected_job.code == person.get_work():
		set_rest(button, person)
		return
	# disable 
	var location = ResourceScripts.world_gen.get_location_from_code(person.get_location())
	if  person.get_location() != 'aliron' && location.type != "dungeon":
		pass
	elif location.type == "dungeon":
		pass
	elif selected_job.has('upgrade_code') && selected_job.has('workers_per_upgrade') && selected_job.has('base_workers'):
		var upgrade_level = ResourceScripts.game_res.findupgradelevel(selected_job.upgrade_code)
		var max_workers_count = selected_job.base_workers + selected_job.workers_per_upgrade * upgrade_level
		var current_workers_count = 0
		var active_tasks = ResourceScripts.game_party.active_tasks
		for task in active_tasks:
			if (task.code == selected_job.code) && (task.task_location == person.get_location()):
				current_workers_count = task.workers_count
		if current_workers_count >= max_workers_count:
			input_handler.SystemMessage(tr("NO_FREE_SLOTS"))
			return
	
	var gatherable = Items.materiallist.has(selected_job.code)
	if location.type == "dungeon":
		person.assign_to_task(selected_job.production_item, selected_job.production_item)
	else:
		if !gatherable:
			person.assign_to_task(selected_job.code, selected_resource)
		else:
			person.assign_to_task(selected_job.code, selected_job.code)
	if selected_job.code in ["building"]:
		get_parent().TaskModule.task_index = 0
	else:
		get_parent().TaskModule.task_index = 1
	get_parent().TaskModule.change_button()
	update_resources()
	#update_characters() # change for status update
	update_status(button, person)
	show_faces()
	#get_parent().mansion_state_set("default")


func set_rest(button, person):
	person.remove_from_task()
	get_parent().rebuild_task_info()
	update_resources()
	if button == null:
		update_characters() 
	else:
		update_status(button, person)
	show_faces()
