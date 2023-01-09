extends Control

var person
var selected_resource
var selected_job = {}
var stored_spec_job = {}
var selected_location = "aliron"



func _ready():
	$CloseButton.connect("pressed", self, 'close_job_pannel')
	globals.connecttexttooltip($BrothelRules/rulestooltip, tr("BROTHELTOOLTIP"))
	gui_controller.add_close_button(self, "bigger_offset")#.connect("pressed", self, 'close_job_pannel')
	for i in $BrothelRules/sexes_container.get_children():
		var name = i.get_name()
		i.connect('pressed', self, 'switch_brothel_option',[i, name])

#func raise_clock():
#	gui_controller.clock.raise()
#	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.clock, 0.3)

func rebuild():
	$DescriptionLabel.bbcode_text = ""
	$ToolLabel.text = ""
	$WorkunitLabel.text = ""
	$Modlabel.text = ""
	$BrothelRules.hide()
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
		if person.get_location() != ResourceScripts.world_gen.get_location_from_code(selected_location).id or person.is_on_quest():
			continue
		
		var newbutton = input_handler.DuplicateContainerTemplate($CharacterList/GridContainer)
		newbutton.get_node("Name").text = person.get_stat("name")
		newbutton.get_node("Icon").texture = person.get_icon_small()
		newbutton.disabled = false
		if selected_job == null or selected_resource == null:
			newbutton.disabled = true 
			globals.connecttexttooltip(newbutton, "Select Resource first")
		if !person.has_status('basic_servitude') and !person.is_master():
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, person.translate("[name] lacks Training: Basic Servitude"))
		if selected_job != null and selected_job.has("code"):
			if selected_job.code == "prostitution":
				if person.has_status('no_sex'):
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, person.translate("[name] refuses to perfrorm sexual tasks"))
				if person.has_status('no_whoring'):
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, person.translate("[name] refuses to perfrorm this task"))
				if !person.has_status('prostitution'): 
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, person.translate("[name] lacks Training: Prostitution"))
			if selected_job.code in ['smith','alchemy','tailor','cooking']:
				if person.has_status('no_craft'): newbutton.disabled = true
			if selected_job.code == "building":
				if person.has_status('no_upgrade'): newbutton.disabled = true
		if !(selected_resource in [null, 'rest', 'gold', 'smith','alchemy','tailor','cooking', 'building']):
			if person.has_status('no_collect'): newbutton.disabled = true
		if newbutton.disabled == true && selected_job != null:
			newbutton.get_node('Name').set("custom_colors/font_color", variables.hexcolordict['red'])
		newbutton.set_meta('slave', person)
		newbutton.connect('pressed', self, 'character_selected', [newbutton, person])
		newbutton.connect('mouse_entered', self, 'character_hovered', [newbutton, person])
		newbutton.get_node("stats/hp").max_value = person.get_stat('hpmax')
		newbutton.get_node("stats/hp").value = person.hp
		newbutton.get_node("stats/mp").max_value = person.get_stat('mpmax')
		newbutton.get_node("stats/mp").value = person.mp
		newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(person.hp)) + "/" + str(round(person.get_stat('hpmax'))) + "\nMP: " + str(round(person.mp)) + "/" + str(round(person.get_stat('mpmax')))
		#speed update
		if selected_job != null and selected_resource != null:
			if selected_resource == "rest":
				newbutton.get_node("Speed").text = ""
			elif selected_resource in ['special', 'recruiting']:
				newbutton.get_node("Speed").text = ""
			else:
				var number = ""
				if selected_job.has("production_code"):
					number = person.get_progress_task(selected_job.code, selected_job.production_code)/selected_job.progress_per_item
				else:
					number = person.xp_module.get_progress_resource(selected_job.code)/selected_job.progress_per_item
				newbutton.get_node("Speed").text = str(stepify(number * 4, 0.1))
		#status update
		update_status(newbutton, person)

func update_status(newbutton, person):
	var gatherable = Items.materiallist.has(person.get_work())
	if person.get_work() == '' or person.get_work() == "Assignment" or person.get_work() == "disabled":
		if !person.is_on_quest():
			newbutton.get_node("Status").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
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
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	get_parent().mansion_state_set("default")

var restbutton
func update_resources():
	input_handler.ClearContainer($Resourses/GridContainer)
#	if selected_location != 'aliron':
#		var restbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
#		if selected_job != null:
#			if selected_job.has("code"):
#				if selected_job.code == "rest":
#					restbutton.pressed = true
#		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/rest_icon.png")
#		restbutton.connect("pressed", self, "select_resource", [{code = "rest"}, "rest", restbutton])
#
#		globals.connecttexttooltip(restbutton, "Rest")
	
	restbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
	if selected_job != null:
		if selected_job.has("code"):
			if selected_job.code == "rest" or selected_job.code == "brothel":
				restbutton.pressed = true
	restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
	restbutton.connect("pressed", self, "select_resource", [{code = "rest"}, "rest", restbutton])

	globals.connecttexttooltip(restbutton, tr('TASKRESTSERVICE'))
	
	var person_location = selected_location
	var location = ResourceScripts.world_gen.get_location_from_code(person_location)
	
	for r_task in ['recruit_easy', 'recruit_hard']:
		if location.has('tags') and location.tags.has(r_task):
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			var jobdata = races.tasklist[r_task]
			if selected_job != null:
				if selected_job.has("code"):
					if selected_job.code == "recruiting":
						newbutton.pressed = true
			newbutton.get_node("TextureRect").texture = jobdata.production_icon
			var max_workers_count = jobdata.base_workers
			var text = ""
			var current_workers_count = 0
			var active_tasks = ResourceScripts.game_party.active_tasks
			for task in active_tasks:
				if (task.code == r_task) && (task.task_location == selected_location):
					current_workers_count = task.workers.size()
			text += str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.get_node("Label").text = text
			#newbutton.disabled = current_workers_count == max_workers_count
			if current_workers_count >= max_workers_count:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.9,0.48,0.48, 1))
			
			newbutton.connect("pressed", self, "select_resource", [jobdata, "recruiting", newbutton])

			globals.connecttexttooltip(newbutton, jobdata.descript)
	
	for task in ResourceScripts.game_party.active_tasks:
		if (task.code == 'special') && (task.task_location == selected_location):
			var current_workers_count = task.workers.size()
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			var jobdata = races.tasklist.special
			var max_workers_count = task.max_workers
			var text = ""
			text += str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.get_node("Label").text = text
			newbutton.get_node("TextureRect").texture = load(task.icon)
			newbutton.set_meta('spec_job', task)
			
			if selected_job != null:
				if selected_job.has("code"):
					if selected_job.code == "special" and stored_spec_job == task:
						newbutton.pressed = true
			
			newbutton.connect("pressed", self, "select_resource", [jobdata, "special", newbutton])
			globals.connecttexttooltip(newbutton, tr(task.desc))
			
	
	person = get_parent().active_person
#	var luxury_rooms_taken = 0
#	for p in ResourceScripts.game_party.characters.values():
#		if p.xp_module.work_rules["luxury"]:
#			luxury_rooms_taken += 1
	#$work_rules/luxury.text = "Luxury Rooms: " + str(luxury_rooms_taken) + "/" + str(ResourceScripts.game_res.upgrades.luxury_rooms + 1)
	#$work_rules/luxury.disabled = (luxury_rooms_taken >= ResourceScripts.game_res.upgrades.luxury_rooms + 1) && person != null && !person.xp_module.work_rules["luxury"]
	#$work_rules/luxury.visible = person != ResourceScripts.game_party.get_master()

	var gatherable_resources = []
	
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
			if i.code in ["rest", "brothel", "special", "recruit_easy", "recruit_hard"]:
				continue
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
			selected_job = i
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
						current_workers_count = task.workers.size()
				text += str(current_workers_count) + "/" + str(max_workers_count)
				newbutton.get_node("Label").text = text
				#newbutton.disabled = current_workers_count == max_workers_count
				if current_workers_count >= max_workers_count:
					newbutton.get_node("Label").set("custom_colors/font_color", Color(0.9,0.48,0.48, 1))
			elif i.code == "cooking" or i.code == "brothel":
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i.code) && (task.task_location == person_location):
						current_workers_count = task.workers.size()
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
		
		var t_job = item_dict
		for i in races.tasklist.values():
			if i.has("production_item"):
				if i.production_item == t_job.code:
					t_job = i.duplicate(true)
		var t_res
		if t_job.has("production_item"):
			t_res = t_job.production_item
		elif selected_job.has("code"):
			t_res = t_job.code
		
		if person_location != 'aliron' && location_type != "dungeon":
			t_job.erase('base_workers')
			max_workers_count = gatherable_resources[resource]
			var active_tasks = ResourceScripts.game_party.active_tasks
			for task in active_tasks:
				if ((task.code == resource) || (task.product == resource)) && (task.task_location == person_location):
					current_workers_count = task.workers.size()
			text +=  str(current_workers_count) + "/" + str(max_workers_count)
			#newbutton.disabled = current_workers_count == max_workers_count
			if current_workers_count >= max_workers_count:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
		elif location_type == "dungeon":
			t_job.erase('base_workers')
			if gatherable_resources[resource] == 0:
				for button in $Resourses/GridContainer.get_children():
					if button.name == "Button" || !button.has_meta('resource'): continue
					if button.get_meta("resource") == resource: button.queue_free()
				continue
			text += str(gatherable_resources[resource])
		newbutton.get_node("Label").text = text
		newbutton.set_meta("work", item_dict)
		newbutton.get_node("TextureRect").texture = item_dict.icon
		
		newbutton.connect("pressed", self, "select_resource", [t_job, t_res, newbutton])


func select_resource(job, resource, newbutton):
	$BrothelRules.hide()
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
	if job.code == 'special':
		stored_spec_job = newbutton.get_meta('spec_job')
	else:
		stored_spec_job = {}
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
		if job.has('worktool') || job.has('tool_type'):
			$Worktool.show()
			globals.connecttexttooltip($Worktool, "Effective Tool: Will increase work speed when equipped")
		if !job.tags.has('hide_progress_ratio'):
			$Workunit.show()
			$WorkunitLabel.show()
			$WorkunitLabel.text = "%.1f" % job.progress_per_item
			globals.connecttexttooltip($Workunit, "Progress required per item")
		var text = job.descript
		if job.has('workstat'):
			$Workstat.texture = stat_icons[job.workstat]
			$Workstat.show()
			if job.code != 'brothel':
				globals.connecttexttooltip($Workstat, "Job Stat: " + tr("STAT"+job.workstat.to_upper()) + "\nThis stat will grow by attending to this job.")
			else:
				globals.connecttexttooltip($Workstat, "Growing stat will depend on what task will be performed by character when servicing customers.")
		if job.has('mod'):
			$Modlabel.show()
			$Workmod.show()
			$Modlabel.text = tr("STAT" + job.mod.to_upper())
			globals.connecttexttooltip($Workmod, "Task Efficiency Modifier")
		elif job.has('workmod'):
			$Modlabel.show()
			$Workmod.show()
			$Modlabel.text = tr("STAT" + job.workmod.to_upper())
			globals.connecttexttooltip($Workmod, "Task Efficiency Modifier")
			
		
		$DescriptionLabel.bbcode_text = text
	update_characters() # change for Speed update (and tool check? idk)
	show_faces()

func show_faces():
	input_handler.ClearContainer($GridContainer2)
	if selected_job.has("code"):
		if selected_job.code == "rest":
			$gridcontainerpanel.hide()
			return
	var max_workers_count = 0
	if selected_job.has('upgrade_code') && selected_job.has('workers_per_upgrade') && selected_job.has('base_workers'):
		var upgrade_level = ResourceScripts.game_res.findupgradelevel(selected_job.upgrade_code)
		max_workers_count = selected_job.base_workers + selected_job.workers_per_upgrade * upgrade_level
	elif selected_job.has('base_workers'):
		max_workers_count = selected_job.base_workers
		if selected_job.code == "special" and stored_spec_job.has('max_workers'):
			max_workers_count = stored_spec_job.max_workers
	elif selected_location != 'aliron' && ResourceScripts.world_gen.get_location_from_code(selected_location).type != "dungeon":
		if selected_job.has("production_item"):
			max_workers_count = ResourceScripts.world_gen.get_location_from_code(selected_location).gather_resources[selected_job.production_item]
		else:
			var gatherable_resources = ResourceScripts.world_gen.get_location_from_code(selected_location).gather_resources
			max_workers_count = gatherable_resources[selected_job.code]
		#selected_job.type != "dungeon" &&
	elif ResourceScripts.world_gen.get_location_from_code(selected_location).type == "dungeon":
		max_workers_count = 0
	var any_workers = false
	for p in ResourceScripts.game_party.characters.values():
		var work = p.get_work()
		var ok = false
		if selected_job.has('code') || selected_job.has('production_item'):
			if selected_job.has("production_item"):
				if (selected_job.code == work || selected_job.production_item == work) and p.get_location() == selected_location:
					ok = true
			else:
				if selected_job.code == work and p.get_location() == selected_location:
					ok = true
			if ok:
				var b = input_handler.DuplicateContainerTemplate($GridContainer2)
				b.connect('pressed', self, 'set_rest', [null, p])
				b.get_node("TextureRect").texture = p.get_icon_small()
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
				any_workers = true
	$gridcontainerpanel.visible = any_workers || max_workers_count > 0
	for i in max_workers_count:
			input_handler.DuplicateContainerTemplate($GridContainer2)
	

var stat_icons = {
	physics = load("res://assets/images/gui/gui icons/icon_physics64.png"),
	wits = load("res://assets/images/gui/gui icons/icon_wits64.png"),
	charm = load("res://assets/images/gui/gui icons/icon_charm64.png"),
	sex_skills = load("res://assets/images/gui/gui icons/icon_sex64.png"),
	
}

func select_job(button, person):
	self.person = person
	if selected_job.code == person.get_work() && selected_job.code != 'brothel':
		set_rest(button, person)
		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
		return
	if selected_job.has('production_item') and selected_job.production_item == person.get_work():
		set_rest(button, person)
		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
		return
	if selected_job.code == "rest":
		set_rest(button, person)
		show_brothel_options()
		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
		return
	if selected_job.code == 'brothel':
		person.assign_to_task('brothel', 'brothel')
		show_brothel_options()
		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
		update_status(button, person)
		update_resources()
		show_faces()
		return
	if selected_job.code == 'special':
		person.assign_to_special_task(stored_spec_job)
		update_status(button, person)
		update_resources()
		show_faces()
		return
	# disable 
	var location = ResourceScripts.world_gen.get_location_from_code(person.get_location())
	
	if selected_job.has('upgrade_code') && selected_job.has('workers_per_upgrade') && selected_job.has('base_workers'):
		var upgrade_level = ResourceScripts.game_res.findupgradelevel(selected_job.upgrade_code)
		var max_workers_count = selected_job.base_workers + selected_job.workers_per_upgrade * upgrade_level
		var current_workers_count = 0
		var active_tasks = ResourceScripts.game_party.active_tasks
		for task in active_tasks:
			if (task.code == selected_job.code) && (task.task_location == person.get_location()):
				current_workers_count = task.workers.size()
		if current_workers_count >= max_workers_count:
			input_handler.SystemMessage(tr("NO_FREE_SLOTS"))
			return
	elif selected_job.has('base_workers'):
		var max_workers_count = selected_job.base_workers
		var current_workers_count = 0
		var active_tasks = ResourceScripts.game_party.active_tasks
		for task in active_tasks:
			if (task.code == selected_job.code) && (task.task_location == person.get_location()):
				current_workers_count = task.workers.size()
				if task.has("max_workers"):
					max_workers_count = task.max_workers
		if current_workers_count >= max_workers_count:
			input_handler.SystemMessage(tr("NO_FREE_SLOTS"))
			return
	elif  person.get_location() != 'aliron' && location.type != "dungeon":
		var gatherable_resources = ResourceScripts.world_gen.get_location_from_code(selected_location).gather_resources
		var max_workers_count = gatherable_resources[selected_resource]
		var current_workers_count = 0
		var active_tasks = ResourceScripts.game_party.active_tasks
		for task in active_tasks:
			if (task.code == selected_job.code) && (task.task_location == person.get_location()):
				current_workers_count = task.workers.size()
		#newbutton.disabled = current_workers_count == max_workers_count
		if current_workers_count >= max_workers_count:
			input_handler.SystemMessage(tr("NO_FREE_SLOTS"))
			return
			
	elif location.type == "dungeon":
		pass
	
	var gatherable = Items.materiallist.has(selected_job.code)
	if location.type == "dungeon":
		if selected_job.has("production_item"):
			person.assign_to_task(selected_job.production_item, selected_job.production_item)
		elif selected_job.has("code"):
			person.assign_to_task(selected_job.code, selected_job.code)
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


var brothel_rules = {
	non_sex = ['waitress', 'hostess', 'dancer', 'stripper'],
	sexual = ['petting', 'oral', 'anal', 'pussy', 'penetration', 'group', 'sextoy'],
	sexes = ['males','females','futa'],
	
}

func show_brothel_options():
	
	$BrothelRules.show()
	$BrothelRules/Label.text = "Service Rules: " + person.get_short_name()
	input_handler.ClearContainer($BrothelRules/GridContainer)
	
	for i in ['rest']:
		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/GridContainer)
		newbutton.text = tr("TASKREST")
		globals.connecttexttooltip(newbutton, person.translate(tr("TASKRESTDESCRIPT")))
		newbutton.pressed = person.get_work() == ''
		if newbutton.pressed:
			switch_rest(newbutton)
		newbutton.connect('pressed', self, 'switch_rest', [newbutton])
	
	for i in brothel_rules.non_sex:
		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/GridContainer)
		if person.get_stat('sex') == "male" && races.gold_tasks_data[i].tags.has('has_alt_name'):
			newbutton.text = tr("BROTHEL"+i.to_upper() + "ALT")
		else:
			newbutton.text = tr("BROTHEL"+i.to_upper())
		globals.connecttexttooltip(newbutton, person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT")))
		newbutton.pressed = person.check_brothel_rule(i)
		newbutton.connect('pressed', self, 'switch_brothel_option',[newbutton, i])
		newbutton.add_to_group('sex_option')
		if person.get_work() == '':
			newbutton.disabled = true
	for i in brothel_rules.sexual:
		if (i == 'pussy' && person.get_stat('has_womb') == false) || i == 'penetration' && person.get_stat('penis_size') == '':
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/GridContainer)
		newbutton.text = tr("BROTHEL"+i.to_upper())
		globals.connecttexttooltip(newbutton, person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT")))
		newbutton.pressed = person.check_brothel_rule(i)
		newbutton.connect('pressed', self, 'switch_brothel_option',[newbutton, i])
		newbutton.add_to_group('sex_option')
		if person.get_work() == '':
			newbutton.disabled = true
		if person.is_master() == false:
			if person.checkreqs([{code = 'trait', trait = races.gold_tasks_data[i].req_training, check = false}]):
				if person.get_stat('slave_class') != 'slave':
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT") + "\n{color=red|[name] lacks training to be assigned to this task}"))
				else:
					newbutton.set("custom_colors/font_color", variables.hexcolordict['red'])
					newbutton.set("custom_colors/font_color_pressed", variables.hexcolordict['red'])
					globals.connecttexttooltip(newbutton, person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT") + "\n{color=red|[name] lacks a proper training and will only earn 2/3 of the potential gold from it.}"))
	
	
	for i in brothel_rules.sexes:
		globals.connecttexttooltip(get_node("BrothelRules/sexes_container/"+i), person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT")))
		get_node("BrothelRules/sexes_container/"+i).pressed = person.check_brothel_rule(i)
		
#		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/GridContainer)
#		newbutton.text = tr("BROTHEL"+i.to_upper())
#		globals.connecttexttooltip(newbutton, person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT")))
#		newbutton.pressed = person.check_brothel_rule(i)
#		newbutton.connect('pressed', self, 'switch_brothel_option',[newbutton, i])
	
	update_brothel_text()

func update_brothel_text():
	var text = ''
	var can_do_sex = false
	var can_do_penetrative = false
	var can_get_pregnant = false
	
	for i in brothel_rules.sexual:
		if person.check_brothel_rule(i) == true:
			can_do_sex = true
			if i in ['anal','pussy','group','sextoy']:
				can_do_penetrative = true
				if i != 'anal' && person.get_stat('has_womb') == true:
					can_get_pregnant = true
	
	if person.get_work() == '':
		text = "{color=yellow|[name] will rest.}"
	elif can_do_sex && can_do_penetrative:
		text = "{color=yellow|[name] will entertain clients by serving and sleeping with them if they find [him] appealing.}"
		if can_get_pregnant:
			text += "{color=yellow|[He] can lose virginity and get pregnant from penetration.}"
	elif can_do_sex:
		text = "{color=yellow|[name] will entertain clients by serving them and provide them with light sexual services not involving penetration.}"
	else:
		text = "{color=green|[name] will serve and entertain clients but will refuse any sexual services.}"
	
	$BrothelRules/brothel_descript.bbcode_text = globals.TextEncoder(person.translate(text))

func switch_brothel_option(button, option):
	person.set_brothel_rule(option, button.pressed)
	update_brothel_text()

func switch_rest(button):
	if button.pressed:
		set_rest(null, person)
		update_brothel_text()
		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")
		for nd in get_tree().get_nodes_in_group('sex_option'):
			nd.disabled = true
	else:
		person.assign_to_task('brothel', 'brothel')
		update_characters()
		show_faces()
		show_brothel_options()
		update_resources()
		restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/gui icons/icon_rest_brothel.png")

func set_rest(button, person):
	person.remove_from_task()
	get_parent().rebuild_task_info()
	update_resources()
	if button == null:
		update_characters() 
	else:
		update_status(button, person)
	show_faces()

func character_hovered(button, person): 
	# k_yellow = base color
	if $ToolLabel.text == "":
		return
	$ToolLabel.set("custom_colors/font_color", variables.hexcolordict['red'])
	if person.equipment.gear.tool != null:
		var worktool
		var item = ResourceScripts.game_res.items[person.equipment.gear.tool]
		var item_base = item.itembase
		var req_tool
		if selected_job.has("worktool"):
			req_tool = selected_job.worktool
		if selected_job.has("tool_type"):
			req_tool = selected_job.tool_type
		if req_tool == item_base:
			$ToolLabel.set("custom_colors/font_color", variables.hexcolordict['green'])
