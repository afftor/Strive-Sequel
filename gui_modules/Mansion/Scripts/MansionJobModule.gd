extends Control

var person
var selected_job = null
var selected_location = "aliron"

var mode_farm = false

func _ready():
	$CloseButton.connect("pressed", self, 'close_job_pannel')
	$CraftRules2/Label2.text = tr("PREDICTEDTASKLABEL")
	$CraftRules2/filters/checks1/Label.text = tr("INVENTORYMATERIAL")
	$CraftRules2/filters/checks2/Label.text = tr("ITEMS_LABEL")
	$CraftRules2/filters/order1/Label.text = tr("MATERIALSORDERLABEL")
	$CraftRules2/filters/order2/Label.text = tr("ITEMSORDERLABEL")
	globals.connecttexttooltip($CraftRules2/crafttooltip2, tr("CRAFTRULES2TOOLTIP"))
	globals.connecttexttooltip($BrothelRules/rulestooltip, tr("BROTHELTOOLTIP"))
	gui_controller.add_close_button(self, "bigger_offset")#.connect("pressed", self, 'close_job_pannel')
	$mod_select/occupation.connect('pressed', self, 'build_occupation')
	$mod_select/farm.connect('pressed', self, 'build_farm')
	for i in $BrothelRules/sexes_container.get_children():
		var name = i.get_name()
		i.connect('pressed', self, 'switch_brothel_option',[i, name])
	
	$Frame_farm/char_panel/Remove.connect("pressed", self, 'remove_from_farm')
	$Frame_farm/char_panel/Choose.connect("pressed", self, 'set_to_farm')
	
	globals.connecttexttooltip($BrothelRules/boosters/boosterstip, tr("SERVICEBOOSTTOOLTIP"))
	input_handler.register_btn_source('building_work', self, 'tut_get_building')
	input_handler.register_btn_source('service_work', self, 'tut_get_servicebutton')
	input_handler.register_btn_source('craft_work', self, 'tut_get_craftbutton')
	input_handler.register_btn_source('daisy_work', self, 'tut_get_daisy_work')
	input_handler.register_btn_source('close_work', self, 'tut_get_CloseButton')
	input_handler.register_btn_source('mat_order_highlight', self, null, self, 'tut_get_mat_order_highlight')
	input_handler.register_btn_source('mat_order_cooking', self, 'tut_get_order_cooking_btn', null, null, 'dropped')
	input_handler.register_btn_source('mat_order_smith', self, 'tut_get_order_smith_btn', null, null, 'dropped')
	input_handler.register_btn_source('mat_order_tailor', self, 'tut_get_order_tailor_btn', null, null, 'dropped')
	input_handler.register_btn_source('mat_order_alchemy', self, 'tut_get_order_alchemy_btn', null, null, 'dropped')


func tut_get_building():
	for work in $Resourses/GridContainer.get_children():
		if work.get_meta('work', {code = ''}).code == 'building':
			return work
func tut_get_servicebutton():
	return servicebutton
func tut_get_craftbutton():
	return craftbutton
func tut_get_daisy_work():
	for line in $CharacterList/GridContainer.get_children():
		if line.get_meta('slave').get_stat('unique') == 'daisy':
			return line
func tut_get_CloseButton():
	return $CloseButton
func tut_get_mat_order_highlight():
	var rect = $CraftRules2/filters/order1.get_global_rect()
#	rect.end = tut_get_front3().get_global_rect().end
	return rect
func tut_get_mat_order_btn(type):
	for btn in $CraftRules2/filters/order1.get_children():
		var job = btn.get("arraydata")
		if job and job == type:
			return btn
func tut_get_order_cooking_btn():
	return tut_get_mat_order_btn("cooking")
func tut_get_order_smith_btn():
	return tut_get_mat_order_btn("smith")
func tut_get_order_tailor_btn():
	return tut_get_mat_order_btn("tailor")
func tut_get_order_alchemy_btn():
	return tut_get_mat_order_btn("alchemy")

#func raise_clock():
#	gui_controller.clock.raise()
#	ResourceScripts.core_animations.UnfadeAnimation(gui_controller.clock, 0.3)

func rebuild():
	selected_slot = null
	build_occupation()
	if restbutton != null:
		select_resource("rest", restbutton)


func build_occupation():
	mode_farm = false
	$Frame.visible = true
	$Frame_farm.visible = false
	$mod_select/occupation.pressed = true
	$mod_select/farm.pressed = false
	$Resourses.visible = true
	$Landscape.visible = true
	$LandscapeFrame.visible = true
	$DescriptionLabel.visible = true
	$gridcontainerpanel.visible = true
	$GridContainer2.visible = true
	$NavigationModule.visible = true
	
	$DescriptionLabel.bbcode_text = ""
	$ToolLabel.text = ""
	$WorkunitLabel.text = ""
	$Modlabel.text = ""
	$BrothelRules.hide()
	$CraftRules.hide()
	$CraftRules2.hide()
	$Workmod.hide()
	$Workstat.hide()
	$Worktool.hide()
	$Workunit.hide()
	input_handler.ClearContainer($GridContainer2)
	build_accessible_locations()
	#update_buttons()
	update_characters()
	update_resources()


func build_farm():
	mode_farm = true
	$Frame.visible = false
	$Frame_farm.visible = true
	$mod_select/occupation.pressed = false
	$mod_select/farm.pressed = true
	$Resourses.visible = false
	$Landscape.visible = false
	$LandscapeFrame.visible = false
	$DescriptionLabel.visible = false
	$gridcontainerpanel.visible = false
	$GridContainer2.visible = false
	$BrothelRules.visible = false
	$CraftRules.visible = false
	$CraftRules2.visible = false
	$NavigationModule.visible = false
	
	$DescriptionLabel.bbcode_text = ""
	$ToolLabel.text = ""
	$WorkunitLabel.text = ""
	$Modlabel.text = ""
	$Workmod.hide()
	$Workstat.hide()
	$Worktool.hide()
	$Workunit.hide()
	
	update_characters()
	build_accessible_locations()
	build_farm_slots()
	build_char_farm(null)


func update_characters():
	if selected_location == null:
		print("no location selected")
		return
	var loc = ResourceScripts.world_gen.get_location_from_code(selected_location)
	if loc == null:
		print("error - selected location invalid")
		return
	var job_data
	if selected_job != null and selected_job != 'rest':
		job_data = ResourceScripts.game_res.tasks_progresses[selected_job]
	input_handler.ClearContainer($CharacterList/GridContainer)
	for i in ResourceScripts.game_party.character_order: 
		var ch = ResourceScripts.game_party.characters[i]
		if ch.get_location() != loc.id or ch.is_on_quest():
			continue
		
		var newbutton = input_handler.DuplicateContainerTemplate($CharacterList/GridContainer)
		newbutton.get_node("Name").text = ch.get_stat("name")
		newbutton.get_node("Icon").texture = ch.get_icon_small()
		newbutton.disabled = false
		if selected_job == null and !mode_farm:
			newbutton.disabled = true 
			globals.connecttexttooltip(newbutton, tr("SELECT_RES_FIRST_LABEL"))
		if (selected_slot == null) and mode_farm:
			newbutton.disabled = true 
			globals.connecttexttooltip(newbutton, tr("SELECT_SLOT_FIRST_LABEL"))
		if !ch.is_worker() and !mode_farm:
			if !(selected_job != null and selected_job == ch.get_work()):
				newbutton.disabled = true
			globals.connecttexttooltip(newbutton, ch.translate("[name]" + " " + tr("LACKS_BASIC_SERV_LABEL"))) #change translation
		if selected_job != null:
			if selected_job == "service":
				if !ch.is_worker():
					newbutton.disabled = true
					globals.connecttexttooltip(newbutton, ch.get_short_name() + ": Refused to work")
#				if ch.has_status('no_sex'):
#					newbutton.disabled = true
#					globals.connecttexttooltip(newbutton, ch.translate("[name] " + " " + tr("REFUSE_TO_WHORE_LABEL")))
#				if ch.has_status('no_whoring'):
#					newbutton.disabled = true
#					globals.connecttexttooltip(newbutton, ch.translate("[name] " + " " + tr("REFUSE_THIS_TASK_LABEL")))
#				if !ch.has_status('sexservice'):  #or mb advanced
#					newbutton.disabled = true
#					globals.connecttexttooltip(newbutton, ch.translate("[name] " + " " + tr("LACKS_PROSTITUTUION_LABEL")))
			if selected_job == 'crafting':
				if ch.has_status('no_craft'): 
					newbutton.disabled = true
			if job_data != null and job_data.id == 'gathering':
				if ch.has_status('no_collect'): 
					newbutton.disabled = true
		if newbutton.disabled == true && selected_job != null:
			newbutton.get_node('Name').set("custom_colors/font_color", variables.hexcolordict['red'])
		newbutton.set_meta('slave', ch)
		newbutton.connect('pressed', self, 'character_selected', [newbutton, ch])
		newbutton.connect('mouse_entered', self, 'character_hovered', [newbutton, ch])
		newbutton.get_node("stats/hp").max_value = ch.get_stat('hpmax')
		newbutton.get_node("stats/hp").value = ch.hp
		newbutton.get_node("stats/mp").max_value = ch.get_stat('mpmax')
		newbutton.get_node("stats/mp").value = ch.mp
		newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(ch.hp)) + "/" + str(round(ch.get_stat('hpmax'))) + "\nMP: " + str(round(ch.mp)) + "/" + str(round(ch.get_stat('mpmax')))
		#speed update
		newbutton.get_node("Speed").text = ""
		if job_data != null and job_data.id == 'gathering':
			var val
			if job_data.type in ['gather_limited', 'gather_simple']:
				val = ch.get_progress_resource(job_data.job, false) / job_data.progress_limit
			else:
				val = ch.get_job_value(tasks.find_task_for_res(job_data.job), false) / job_data.progress_limit
			newbutton.get_node("Speed").text = str(stepify(val * 4, 0.1))
		#status update
		update_status(newbutton, ch)


func update_status(newbutton, ch):
	var gatherable = Items.materiallist.has(ch.get_work())
	if ch.get_work() == '' or !ch.is_avaliable():
		if !ch.is_on_quest():
			newbutton.get_node("Status").texture = load("res://assets/images/gui/icon_bed.png")
		if !ch.is_worker():
			newbutton.disabled = true
	else:
		var prdata = ResourceScripts.game_res.tasks_progresses[ch.get_work()]
		if prdata.id != 'farming':
			newbutton.get_node("Status").texture = load(prdata.icon)


func character_selected(button, ch):
	if mode_farm:
		select_farm_char(ch.id)
		return
	get_parent().active_person = ch
	select_job(button, ch)
	

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
		$Landscape.texture = images.get_background(l.background)
	if l.has("id"):
		if l.id == "aliron":
			$Landscape.texture = images.get_background("aliron")


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
		var ch = ResourceScripts.game_party.characters[i]
		var person_location = ch.get_location()
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
	selected_job = null
	selected_location = location
	rebuild()
	var l = ResourceScripts.world_gen.get_location_from_code(location)
	if l.has("background"):
		$Landscape.texture = images.get_background(l.background)
	if l.type == 'capital':
		var area = ResourceScripts.game_world.areas[l.area]
		if area.has('capital_background'):
			$Landscape.texture = images.get_background(area.capital_background)


func close_job_pannel():
	selected_job = null
	#the panel built a temporal task per selectable job; retire the ones nobody took
	ResourceScripts.game_res.drop_unused_temp_tasks()
	get_parent().SlaveListModule.update()
	get_parent().TaskModule.update_progresses()
#	ResourceScripts.core_animations.UnfadeAnimation(get_parent(), 0.3)
	if gui_controller.clock != null:
		ResourceScripts.core_animations.UnfadeAnimation(gui_controller.clock, 0.3)
		gui_controller.clock.raise()
#	ResourceScripts.core_animations.FadeAnimation(self, 0.3)
#	get_parent().mansion_state = "default"
	input_handler.get_spec_node(input_handler.NODE_TEXTTOOLTIP).hide()
	get_parent().mansion_state_set("default")


var restbutton
var servicebutton
var craftbutton

func update_resources():
	input_handler.ClearContainer($Resourses/GridContainer)
	
	restbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
	if selected_job != null and selected_job == "rest":
		restbutton.pressed = true
	restbutton.get_node("TextureRect").texture = load("res://assets/images/gui/icon_bed.png")
	restbutton.connect("pressed", self, "select_resource", ["rest", restbutton])
	globals.connecttexttooltip(restbutton, tr('TASKREST'))
	
	var person_location = selected_location
	var location = ResourceScripts.world_gen.get_location_from_code(person_location)
	
	if location.type == 'capital':
		ResourceScripts.game_res._add_service_job()
		servicebutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
		if selected_job != null and selected_job == 'service':
			servicebutton.pressed = true
		servicebutton.get_node("TextureRect").texture = load("res://assets/images/gui/service.png")
		servicebutton.connect("pressed", self, "select_resource", ["service", servicebutton])
		globals.connecttexttooltip(servicebutton, tr('TASKRESTSERVICE'))
	
	for r_task in ['recruit_easy', 'recruit_hard']:
		if location.has('tags') and location.tags.has(r_task):
			var newjob = ResourceScripts.game_res.add_recruiting_job_temp(r_task, person_location)
			var jobdata = ResourceScripts.game_res.tasks_progresses[newjob]
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			if selected_job != null and selected_job == newjob:
				newbutton.pressed = true
			newbutton.get_node("TextureRect").texture = load(jobdata.icon)
			var max_workers_count = jobdata.max_workers
			var text = ""
			var current_workers_count = jobdata.workers.size()
			text += str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.get_node("Label").text = text
			#newbutton.disabled = current_workers_count == max_workers_count
			if current_workers_count >= max_workers_count:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.9,0.48,0.48, 1))
			newbutton.connect("pressed", self, "select_resource", [newjob, newbutton])
			globals.connecttexttooltip(newbutton, tr(jobdata.descript))
	
	for task_id in ResourceScripts.game_res.active_tasks.special:
		var jobdata = ResourceScripts.game_res.tasks_progresses[task_id]
		if jobdata.location == selected_location:
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			var current_workers_count = jobdata.workers.size()
			var max_workers_count = jobdata.max_workers
			var text = ""
			text += str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.get_node("Label").text = text
			newbutton.get_node("TextureRect").texture = load(jobdata.icon)
			newbutton.set_meta('task', task_id)
			if selected_job != null and selected_job == task_id:
				newbutton.pressed = true
			newbutton.connect("pressed", self, "select_resource", [task_id, newbutton])
			globals.connecttexttooltip(newbutton, tr(jobdata.name))
	
	var gatherable_resources = []
	
	var location_type
	if location.has("locked"):
		if location.locked:
			return
	if person_location != 'aliron':
		location_type = location.type
		if location_type == "dungeon":
			gatherable_resources = location.gather_limit_resources
		elif location_type == 'encounter':
			pass
		else:
			if location.has("gather_resources"):
				gatherable_resources = location.gather_resources
	else:
		#for this moment no area has gatherable_resources, including plains (for aliron that is)
		#but I'll keep condition just in case
		var area_dict = ResourceScripts.game_world.areas[location.area]
		if area_dict.has('gatherable_resources') and !area_dict.gatherable_resources.empty():
			print("warning: area %s has gatherable_resources, while it should not" % location.area)
			gatherable_resources = area_dict.gatherable_resources
		#------------
		craftbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
		if selected_job != null and selected_job == 'crafting':
			craftbutton.pressed = true
		ResourceScripts.game_res._add_craft_job()
		ResourceScripts.game_res._add_farm_job()
		craftbutton.get_node("TextureRect").texture = load("res://assets/images/gui/icon_craft64x64.png")
		craftbutton.connect("pressed", self, "select_resource", ["crafting", craftbutton])
		globals.connecttexttooltip(craftbutton, tr('TASKCRAFT'))
		#------------
		for i in tasks.tasklist.values():
			if i.code in ["rest", "brothel", "recruit_easy", "recruit_hard"] or i.tags.has('special'):
				continue
			if i.tags.has('crafting'):
				continue
			if globals.checkreqs(i.reqs) == false:
				continue
			#don't show if res in not unlocked
			if i.has('upgrade_code') && i.has('workers_per_upgrade') && i.has('base_workers'):
				if i.base_workers + i.workers_per_upgrade * ResourceScripts.game_res.findupgradelevel(i.upgrade_code) <= 0:
					continue
			var newjob = ResourceScripts.game_res.add_gathering_job_temp(i.code, person_location)
			var jobdata = ResourceScripts.game_res.tasks_progresses[newjob]
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
			#newbutton.get_child(0).text = i.name
			if selected_job != null and selected_job == newjob:
				newbutton.pressed = true
			newbutton.set_meta("task", newjob)
			if Items.materiallist.has(i.production_item):
				globals.connectmaterialtooltip(newbutton, Items.materiallist[i.production_item])
			else:
				globals.connecttexttooltip(newbutton, tr(i.name))
			newbutton.get_node("TextureRect").texture = load(jobdata.icon)
			newbutton.connect("pressed", self, "select_resource", [newjob, newbutton])
			var current_workers_count = jobdata.workers.size()
			var max_workers_count = jobdata.max_workers
			var text = ""
			text += str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.get_node("Label").text = text
			if current_workers_count >= max_workers_count:
				newbutton.get_node("Label").set("custom_colors/font_color", Color(0.9,0.48,0.48, 1))
	for resource in gatherable_resources:
		if location_type == "dungeon":
			if gatherable_resources[resource] == 0:
				continue
			var newjob = ResourceScripts.game_res.add_gathering_limited_job_temp(resource, person_location)
			var jobdata = ResourceScripts.game_res.tasks_progresses[newjob]
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			newbutton.get_node("Label").set("custom_colors/font_color", Color(0.97,0.88,0.5, 1))
			var text = ""
			text += str(gatherable_resources[resource])
			newbutton.get_node("Label").text = text
			newbutton.set_meta("task", newjob)
			newbutton.get_node("TextureRect").texture = load(jobdata.icon)
			newbutton.connect("pressed", self, "select_resource", [newjob, newbutton])
		else:
			if !ResourceScripts.game_progress.can_gather_item(resource):
				continue
			var newjob = ResourceScripts.game_res.add_gathering_res_temp(resource, person_location)
			var jobdata = ResourceScripts.game_res.tasks_progresses[newjob]
			var newbutton = input_handler.DuplicateContainerTemplate($Resourses/GridContainer)
			var current_workers_count = jobdata.workers.size()
			var max_workers_count = jobdata.max_workers
			var text = ""
			text += str(current_workers_count) + "/" + str(max_workers_count)
			newbutton.get_node("Label").text = text
			newbutton.get_node("TextureRect").texture = load(jobdata.icon)
			newbutton.set_meta("task", newjob)
			newbutton.connect("pressed", self, "select_resource", [newjob, newbutton])


func select_resource(job_id, newbutton):
	$BrothelRules.hide()
	$CraftRules.hide()
	$CraftRules2.hide()
	# part 1
	$ToolLabel.text = ""
	# part 2
	for button in $Resourses/GridContainer.get_children():
		button.pressed = button == newbutton
	selected_job = job_id
	$Workunit.hide()
	$Worktool.hide()
	$Workstat.hide()
	$Workmod.hide()
	$WorkunitLabel.hide()
	$Modlabel.hide()
	$WorkunitLabel.text = ""
	if job_id == "rest":
		$DescriptionLabel.bbcode_text = tr("TASKRESTINFO")
	elif job_id == "service":
		$DescriptionLabel.bbcode_text = tr("TASKRESTDESCRIPT")
	elif job_id == "crafting":
		$DescriptionLabel.bbcode_text = tr("TASKCRAFTDESCRIPT")
	elif job_id == "farming":
		$DescriptionLabel.bbcode_text = tr("TASKTRAVELDESCRIPT")
	else:
		var job = ResourceScripts.game_res.tasks_progresses[job_id]
		var work_tools
		if job.has("worktool"):
			work_tools = statdata.worktoolnames[job.worktool]
			$ToolLabel.text = work_tools
		if job.has("descript"):
			var text = tr(job.descript)
			if job.id == 'special':
				text += "\n" + tr("TASKRONMISSIONCOMPLETE")
			elif job.has('worktool'):
				$Worktool.show()
				globals.connecttexttooltip($Worktool, tr("JOBWORKTOOLTOOLTIP"))
#			if !job.tags.has('hide_progress_ratio'):
			$Workunit.show()
			$WorkunitLabel.show()
			$WorkunitLabel.text = "%.1f" % job.progress_limit
			globals.connecttexttooltip($Workunit, tr("JOBWORKUNITTOOLTIP"))
			
			if job.has('workstat'):
				$Workstat.texture = stat_icons[job.workstat]
				$Workstat.show()
				if job_id != 'service':
					globals.connecttexttooltip($Workstat, tr("JOBSTATTOOLTIP") % tr("STAT"+job.workstat.to_upper()))
				else:
					globals.connecttexttooltip($Workstat, tr("JOBSTATBROTHELDESCRIPT"))
			if job.has('mod') and job.mod != "":
				$Modlabel.show()
				$Workmod.show()
				$Modlabel.text = tr("STAT" + job.mod.to_upper())
				globals.connecttexttooltip($Workmod, tr("JOBMODTOOLTIP"))
			
			$DescriptionLabel.bbcode_text = text
	update_characters() # change for Speed update (and tool check? idk)
	show_faces()


func show_faces():
	input_handler.ClearContainer($GridContainer2)
	if selected_job == "rest":
		$gridcontainerpanel.hide()
		return
	var jobdata = ResourceScripts.game_res.tasks_progresses[selected_job]
	var max_workers_count = 0
	var current_workers_count = jobdata.workers.size()
	if jobdata.has('max_workers'):
		max_workers_count = jobdata.max_workers
	var locdata = ResourceScripts.world_gen.get_location_from_code(selected_location)
	
	var any_workers = false
	for p in ResourceScripts.game_party.characters.values():
		var work = p.get_work()
		var ok = work == selected_job
		if ok:
			var b = input_handler.DuplicateContainerTemplate($GridContainer2)
			b.connect('pressed', self, 'set_rest', [null, p])
			b.get_node("TextureRect").texture = p.get_icon_small()
			if b.get_node('TextureRect').texture == null:
				b.get_node('TextureRect').texture = p.get_class_icon()
			b.get_node("Label").text = p.get_short_name()
			max_workers_count -= 1
			any_workers = true
	$gridcontainerpanel.visible = any_workers || max_workers_count > 0
	for i in max_workers_count:
		input_handler.DuplicateContainerTemplate($GridContainer2)


func focus_on_person_task(ch):
	if ch == null:
		return
	person = ch
	var target_location = person.get_location()
	if target_location == "mansion":
		target_location = "aliron"
	if selected_location != target_location:
		select_location(target_location)
	else:
		rebuild()
	var work_code = person.get_work()
	if work_code == null:
		return
	if work_code == '':
		if restbutton != null:
			select_resource("rest", restbutton)
		return
	if work_code == 'farming':
		build_farm()
		return
	if work_code == 'service':
		if servicebutton != null:
			select_resource("service", servicebutton)
			show_brothel_options()
			return
	if work_code == 'crafting':
		if craftbutton != null:
			select_resource("crafting", craftbutton)
			#open_my_craft()
			open_mavs_craft()
			return
	var spec_button = _find_task_button_for_char(work_code)
	select_resource(work_code, spec_button)


func _find_task_button_for_char(job):
	if job == null:
		return null
	for button in $Resourses/GridContainer.get_children():
		if !button.has_meta("task"):
			continue
		if button.get_meta("task") == job:
			return button
	return null


var stat_icons = {
	physics = load("res://assets/images/gui/gui icons/icon_physics64.png"),
	wits = load("res://assets/images/gui/gui icons/icon_wits64.png"),
	charm = load("res://assets/images/gui/gui icons/icon_charm64.png"),
	sex_skills = load("res://assets/images/gui/gui icons/icon_sex64.png"),
}


func select_job(button, newperson):
	person = newperson
	if selected_job == "rest":
		set_rest(button, person)
#		show_brothel_options()
		return
	if selected_job == "service":
		person.assign_to_task('service')
		show_brothel_options()
		update_status(button, person)
		update_resources()
		show_faces()
		return
	if selected_job == "crafting":
		person.assign_to_task('crafting')
		#open_my_craft()
		open_mavs_craft()
		update_status(button, person)
		update_resources()
		show_faces()
		return
	if selected_job == person.get_work():
		set_rest(button, person)
		return
	
	var jobdata = ResourceScripts.game_res.tasks_progresses[selected_job]
	
	if jobdata.has('max_workers'):
		if jobdata.workers.size() >= jobdata.max_workers:
			input_handler.SystemMessage(tr("NO_FREE_SLOTS"))
			return
	
	person.assign_to_task(selected_job)
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
	$BrothelRules/Label.text = tr("FARMSERVICERULES") % person.get_short_name()
	input_handler.ClearContainer($BrothelRules/GridContainer)
	
	var location = ResourceScripts.world_gen.get_location_from_code(person.get_location())
	
	for i in brothel_rules.non_sex:
		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/GridContainer)
		if person.get_stat('sex') == "male" && tasks.gold_tasks_data[i].tags.has('has_alt_name'):
			newbutton.text = tr("BROTHEL"+i.to_upper() + "ALT")
		else:
			newbutton.text = tr("BROTHEL"+i.to_upper())
		globals.connecttexttooltip(newbutton, person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT")))
		
		newbutton.pressed = person.check_brothel_rule(i)
		newbutton.connect('pressed', self, 'switch_brothel_option',[newbutton, i])
		newbutton.add_to_group('non_sex_option')
#		if person.get_work() == '':
#			newbutton.disabled = true
	for i in brothel_rules.sexual:
		if (i == 'pussy' && person.get_stat('has_womb') == false) || i == 'penetration' && person.get_stat('penis_size') == '':
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/GridContainer)
		var text = ''
#		text += "Minimum consent: {color=aqua|" + tr(variables.consent_dict[tasks.gold_tasks_data[i].min_consent]) + "},"
#		if person.is_master() == false:
#			text +=  "[name]'s consent: {color=aqua|" + tr(variables.consent_dict[int(person.get_stat('consent'))]) + "}\n"

		newbutton.text = tr("BROTHEL"+i.to_upper())
		text += person.translate(tr("BROTHEL"+i.to_upper() +"DESCRIPT"))
		if i in ['petting', 'oral', 'pussy', 'anal', 'penetration']:
			var skill_level = person.get_stat('sex_training_' + i)
			match skill_level:
				'skilled':
					newbutton.text += " ★"
				'mastered':
					newbutton.text += " ★★"
			text += "\n" + tr("BROTHELSKILLLEVEL") % ResourceScripts.descriptions._sex_training_level_label(skill_level)
		text += "\n" + tr("BROTHELMINCONSENT") % tr(variables.consent_dict[tasks.gold_tasks_data[i].min_consent])
		newbutton.pressed = person.check_brothel_rule(i)
		newbutton.connect('pressed', self, 'switch_brothel_option', [newbutton, i])
		newbutton.add_to_group('sex_option')
		#if person.get_work() == '':
		#	newbutton.disabled = true
		if person.has_status('no_sex'):
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, person.translate("[name] " + " " + tr("REFUSE_TO_WHORE_LABEL")))
		elif person.has_status('no_whoring'):
			newbutton.disabled = true
			globals.connecttexttooltip(newbutton, person.translate("[name] " + " " + tr("REFUSE_THIS_TASK_LABEL")))
		elif !person.has_status('sexservice'):
			newbutton.disabled = true
			text += tr("LACKSEXTRAINING")
		elif i == 'sextoy' and !person.has_profession('sextoy'):
			newbutton.hide()
			continue
		if person.get_stat('consent') < tasks.gold_tasks_data[i].min_consent:
			newbutton.set("custom_colors/font_color", variables.hexcolordict['red'])
			newbutton.set("custom_colors/font_color_pressed", variables.hexcolordict['red'])
			newbutton.set("custom_colors/font_color_hover", variables.hexcolordict['red'])
			newbutton.set("custom_colors/font_color_hover_pressed", variables.hexcolordict['red'])
			newbutton.set("custom_colors/font_color_disabled", variables.hexcolordict['red'])
		globals.connecttexttooltip(newbutton, person.translate(text))
#		if person.is_master() == false:
#			if !person.has_status(tasks.gold_tasks_data[i].req_training):
#				if person.get_stat('slave_class') != 'slave':
#					newbutton.disabled = true
#					text += tr("LACKSEXTRAINING")
#				else:
#					newbutton.set("custom_colors/font_color", variables.hexcolordict['red'])
#					newbutton.set("custom_colors/font_color_pressed", variables.hexcolordict['red'])
#					text += tr("LACKSEXTRAININGSLAVE")
#				globals.connecttexttooltip(newbutton, person.translate(text))
		text = ''
	
	for i in brothel_rules.sexes:
		globals.connecttexttooltip(get_node("BrothelRules/sexes_container/" + i), person.translate(tr("BROTHEL" + i.to_upper() + "DESCRIPT")))
		get_node("BrothelRules/sexes_container/" + i).pressed = person.check_brothel_rule(i)
	
	update_brothel_text()
	if true: #add condition for boosters
		$BrothelRules/boosters.visible = true
		build_boosters()
	else:
		$BrothelRules/boosters.visible = false


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
		text = "{color=yellow|"+tr("SERVICEREST") + "}"#
	elif can_do_sex && can_do_penetrative:
		text = "{color=pink|"+tr("SERVICESEXUALPENETRATIVE")+"}"
		if can_get_pregnant:
			text += "\n{color=pink|"+tr("SERVICEPREGNANT") + "}"
	elif can_do_sex:
		text = "{color=pink|"+tr("SERVICESEXUALNONPENETRATIVE")+ "}"
	else:
		text = "{color=green|"+tr("SERVICENOSEX") + "}"
	
	if can_do_sex:
		var has_clients = false
		for i in $BrothelRules/sexes_container.get_children():
			if i.pressed:
				has_clients = true
				break
		if !has_clients:
			text += "\n\n{color=red|" + tr("BROTHELWARNING") + "}"
		text += "\n\n{color=aqua|" + tr("SERVICEDESIRABILITY") % str(round(person.get_service_desirability())) + "}"
		text += "\n{color=aqua|" + tr("SERVICEESTVALUE") % str(stepify(person.get_estimated_service_value(), 0.1)) + "}"
	else:
		var any_non_sex_toggled = false
		for i in brothel_rules.non_sex:
			if person.check_brothel_rule(i):
				any_non_sex_toggled = true
				break
		if any_non_sex_toggled:
			text += "\n\n{color=aqua|" + tr("SERVICEDESIRABILITYVALUE") % str(round(person.get_stat('desirability'))) + "}"
			text += "\n{color=aqua|" + tr("SERVICEESTVALUE") % str(stepify(person.get_estimated_non_sex_service_value(), 0.1)) + "}"

	for btn in get_tree().get_nodes_in_group('non_sex_option'):
		btn.disabled = can_do_sex

	$BrothelRules/brothel_descript.bbcode_text = globals.TextEncoder(person.translate(text))

func switch_brothel_option(button, option):
	person.set_brothel_rule(option, button.pressed)
	update_brothel_text()


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
	if selected_job != null and selected_job != 'rest':
		var jobdata = ResourceScripts.game_res.tasks_progresses[selected_job]
		var req_tool = null
		if jobdata.has("worktool"):
			req_tool = jobdata.worktool
		if req_tool != null:
			if person.get_gear('tool_' + req_tool) != null:
				$ToolLabel.set("custom_colors/font_color", variables.hexcolordict['green'])


func build_farm_slots():
	input_handler.ClearContainer($Frame_farm/Farm_scroll/FarmSlots, ['Button'])
	var slots = ResourceScripts.game_party.get_farm()
	for slot in slots:
		var newbutton = input_handler.DuplicateContainerTemplate($Frame_farm/Farm_scroll/FarmSlots, 'Button')
		newbutton.pressed = (slot == selected_slot)
		newbutton.connect('pressed', self, 'select_slot', [slot]) 
		if slots[slot] == null:
			newbutton.texture_normal = load("res://assets/Textures_v2/JOB_MODULE/farm/button_hero_disabled.png")
			newbutton.get_node('icon').texture = null
		else:
			var person = ResourceScripts.game_party.characters[slots[slot]]
			newbutton.texture_normal = load("res://assets/Textures_v2/JOB_MODULE/farm/button_hero_disabled_1.png")
			newbutton.get_node('icon').texture = person.get_icon_small()


var farming_char
var selected_slot = null

func select_slot(slot):
	selected_slot = slot
	build_char_farm(ResourceScripts.game_party.farming_slots[selected_slot])
	build_farm_slots()
	update_characters()


func select_farm_char(char_id):
	if selected_slot == null:
		return
	if ResourceScripts.game_party.farming_slots[selected_slot] != null:
		var ch = characters_pool.get_char_by_id(ResourceScripts.game_party.farming_slots[selected_slot])
		ch.remove_from_task()
	build_char_farm(char_id)


func build_char_farm(char_id):
	if char_id == null:
		$Frame_farm/char_panel.visible = false
		return
	
	$Frame_farm/char_panel.visible = true
	var ch = characters_pool.get_char_by_id(char_id)
	farming_char = ch
	if ch.get_work() == 'farming':
		ResourceScripts.game_party.remove_char_from_farm(char_id)
	ch.assign_to_task('farming')
	ResourceScripts.game_party.farming_slots[selected_slot] = char_id
	build_farm_slots()
	$Frame_farm/char_panel/Choose.visible = false
	$Frame_farm/char_panel/Remove.visible = true
	input_handler.ClearContainer($Frame_farm/char_panel/ScrollContainer/farm_rules, ['Button'])
	var items_set = 0
	for res in variables.farming_rules:
		var task = tasks.farm_tasks[res]
		var rdata = Items.materiallist[res]
		if !ch.checkreqs(task.reqs):
			ch.set_farm_res(res, false)
			continue
		var newbutton = input_handler.DuplicateContainerTemplate($Frame_farm/char_panel/ScrollContainer/farm_rules, 'Button')
		globals.connectmaterialtooltip(newbutton, rdata)
		newbutton.get_node('icon').texture = rdata.icon
		newbutton.get_node('HBoxContainer/res_name').text = tr(rdata.name)
		newbutton.get_node('HBoxContainer/amount').text = tr("FARMPROGRESSTURN") % ch.get_progress_farm(res)
		if ch.get_farm_res(res):
			newbutton.pressed = true
			newbutton.connect('pressed', self, 'toggle_farm_res', [ch, res, false])
			items_set += 1
		else:
			newbutton.pressed = false
			newbutton.connect('pressed', self, 'toggle_farm_res', [ch, res, true])
			if ch.can_add_farming():
				newbutton.disabled = false
			else:
				newbutton.disabled = true
				globals.connecttexttooltip(newbutton, tr("FARMGROWTHFACTORLOW"))
	yield(get_tree(),"idle_frame")
	if $Frame_farm/char_panel/ScrollContainer/farm_rules.get_children().size() > 1:
		$Frame_farm/char_panel/Label.text = tr("FARMAVAILABLEPRDODUCTS") 
	else:
		$Frame_farm/char_panel/Label.text = tr("FARMAVAILABLEPRDODUCTSNO")
	
	var text = ""
	
	text = tr("FARMDETAILS") % [str(items_set), str(ch.get_farming_limit())]
	
	$Frame_farm/char_panel/desc.bbcode_text = text


func set_to_farm():
	farming_char.assign_to_task('farming')
	build_farm()


func remove_from_farm():
	farming_char.remove_from_task()
	if selected_slot != null:
		ResourceScripts.game_party.farming_slots[selected_slot] = null
	build_farm()


func toggle_farm_res (person, res, value):
	person.set_farm_res(res, value)
	build_char_farm(person.id)


func build_boosters():
	$DescriptionLabel.visible = false
	input_handler.ClearContainer($BrothelRules/boosters/VBoxContainer, ['Button'])
	var boosters = person.xp_module.service_boosters
#	var f = true
	for id in range(1, 4):
		var newbutton = input_handler.DuplicateContainerTemplate($BrothelRules/boosters/VBoxContainer, 'Button')
		var boost_data = boosters['boost%d' % id]
		var rdata = Items.materiallist[boost_data.res]
		newbutton.get_node('icon').texture = rdata.icon
		var text = ""#"Tier %d: " % id
		
		text += tr(rdata.name) + " "
		
		#if ResourceScripts.game_res.materials.has(boost_data.res) and ResourceScripts.game_res.materials[boost_data.res] > 1:
		text += "(" + str(ResourceScripts.game_res.materials[boost_data.res])  + ")"
		
		text += ": " + str(variables.booster_value[id-1]) + "00%"
		
		#free to add any more data
		newbutton.pressed = boost_data.value
		if boost_data.value:
			text += " - " + tr("FARMACTIVATED")
		
		newbutton.get_node('Label').text = text
		newbutton.connect('pressed', self, 'set_booster', [id, !boost_data.value])


func set_booster(id, value, rebuild = true):
	var boosters = person.xp_module.service_boosters
	var boost_data = boosters['boost%d' % id]
	boost_data.value = value
	if value and id > 1:
		set_booster(id - 1, true, false)
	if !value and id < 3:
		set_booster(id + 1, false, false)
	if rebuild:
		build_boosters()


#new crafting
var list1 = ['cooking', 'smith', 'tailor', 'alchemy']
var list2 = ['smith', 'tailor', 'alchemy', 'cooking', 'building']

func predict_active_task():
	if person == null:
		return null
	return person.predict_active_task()


func build_predicted(root):
	var task_id = predict_active_task()
	if task_id == null:
		root.get_node('icon').texture = load("res://assets/images/gui/icon_bed.png")
	else:
		var task = ResourceScripts.game_res.tasks_progresses[task_id]
		if task.job == 'building':
			var udata = upgradedata.upgradelist[task_id]
			root.get_node('icon').texture = images.upgrade_icons[udata.icon]
		else:
			var recipe_data = Items.recipes[task.id]
			var item_data
			if task.job.ends_with('_material'):
				item_data = Items.materiallist[recipe_data.resultitem]
			else:
				item_data = Items.itemlist[recipe_data.resultitem]
			root.get_node('icon').texture = item_data.icon
			if recipe_data.crafttype == 'modular':
				root.get_node('icon').material = load("res://assets/ItemShader.tres").duplicate()
			else:
				root.get_node('icon').material = null
	root.get_node('icon').visible = true


#mavs gui
var temporder1 = []
var temporder2 = []

func open_mavs_craft():
	if person != null:
		$CraftRules2/Label.text = tr("CRAFTRULES2TITLE") % person.get_short_name()
		gather_orders()
		rebuild_orders()
	else:
		$CraftRules2/icon.visible = false
	$CraftRules2.visible = true


func gather_orders():
	temporder1 = person.get_job_order(true)
	for id in list1:
		if !temporder1.has(id):
			temporder1.push_back(id)
	temporder2 = person.get_job_order(false)
	for id in list2:
		if !temporder2.has(id):
			temporder2.push_back(id)


func rebuild_orders():
	var enabled_list_1 = person.get_jobs_enabled(true)
	var enabled_list_2 = person.get_jobs_enabled(false)
	input_handler.ClearContainer($CraftRules2/filters/checks1, ['Label', 'Button'])
	input_handler.ClearContainer($CraftRules2/filters/checks2, ['Label', 'Button'])
	input_handler.ClearContainer($CraftRules2/filters/order1, ['Label', 'Button'])
	input_handler.ClearContainer($CraftRules2/filters/order2, ['Label', 'Button'])
	for job in list1:
		var newnode = input_handler.DuplicateContainerTemplate($CraftRules2/filters/checks1, 'Button')
		var taskdata = tasks.tasklist[job]
		if enabled_list_1.has(job):
			newnode.pressed = true
			newnode.text = tr(taskdata.name)
			newnode.connect('pressed', self, 'toggle_category_2', [job, false, true])
		else:
			newnode.pressed = false
			newnode.text = tr(taskdata.name)
			newnode.connect('pressed', self, 'toggle_category_2', [job, true, true])
	for job in list2:
		var newnode = input_handler.DuplicateContainerTemplate($CraftRules2/filters/checks2, 'Button')
		var taskdata = tasks.tasklist[job]
		if enabled_list_2.has(job):
			newnode.pressed = true
			newnode.text = tr(taskdata.name)
			newnode.connect('pressed', self, 'toggle_category_2', [job, false, false])
		else:
			newnode.pressed = false
			newnode.text = tr(taskdata.name)
			newnode.connect('pressed', self, 'toggle_category_2', [job, true, false])
	for job in temporder1:
		var newnode = input_handler.DuplicateContainerTemplate($CraftRules2/filters/order1, 'Button')
		var taskdata = tasks.tasklist[job]
		newnode.get_node('Label').text = tr("CRAFTCATEGORYWORKUNITS") % [tr(taskdata.name), person.get_job_value(job)]
		if enabled_list_1.has(job):
			newnode.get_node('Label').set("custom_colors/font_color", variables.hexcolordict['green'])
		else:
			newnode.get_node('Label').set("custom_colors/font_color", variables.hexcolordict['gray'])
		newnode.arraydata = job
		newnode.parentnodearray = temporder1
		newnode.target_node = self
		newnode.target_function = 'validate_orders'
	for job in temporder2:
		var newnode = input_handler.DuplicateContainerTemplate($CraftRules2/filters/order2, 'Button')
		var taskdata = tasks.tasklist[job]
		newnode.get_node('Label').text = tr("CRAFTCATEGORYWORKUNITS") % [tr(taskdata.name), person.get_job_value(job)]
		if enabled_list_2.has(job):
			newnode.get_node('Label').set("custom_colors/font_color", variables.hexcolordict['green'])
		else:
			newnode.get_node('Label').set("custom_colors/font_color", variables.hexcolordict['gray'])
		newnode.arraydata = job
		newnode.parentnodearray = temporder2
		newnode.target_node = self
		newnode.target_function = 'validate_orders'
	build_predicted($CraftRules2)


func toggle_category_2(cat, value, materials = true):
	person.set_job_enabled(cat, value, materials)
	validate_orders()
	rebuild_orders()


func validate_orders():
	person.set_job_orders(temporder1, true)
	person.set_job_orders(temporder2, false)
	rebuild_orders()

#ykocs gui
func open_my_craft():
	if person != null:
		build_priorities()
	else:
		$CraftRules/icon.visible = false
	$CraftRules.visible = true


func build_priorities():
	var enabled_list_1 = person.get_job_order(true)
	var enabled_list_2 = person.get_job_order(false)
	var disabled_list_1 = []
	var disabled_list_2 = []
	
	for job in list1:
		if !enabled_list_1.has(job):
			disabled_list_1.push_back(job)
	for job in list2:
		if !enabled_list_2.has(job):
			disabled_list_2.push_back(job)
	
	for i in range(0, 4):
		var nd = $CraftRules/Container/materials.get_node("pos_e_%d" % (i + 1))
		if enabled_list_1.size() > i:
			var job = enabled_list_1[i]
			var jobdata = tasks.tasklist[job]
			nd.get_node('icon').texture = load(jobdata.production_icon)
			nd.data = job
			nd.order = 4 - i
			nd.materials = true
			nd.target_function = 'set_job_order'
			nd.target_node = self
		else:
			nd.get_node('icon').texture = null
			nd.data = null
			nd.order = 4 - i
			nd.materials = true
			nd.target_function = 'set_job_order'
			nd.target_node = self
	for i in range(0, 4):
		var nd = $CraftRules/Container/materials.get_node("pos_d_%d" % (i + 1))
		if disabled_list_1.size() > i:
			var job = disabled_list_1[i]
			var jobdata = tasks.tasklist[job]
			nd.get_node('icon').texture = load(jobdata.production_icon)
			nd.data = job
			nd.order = 0
			nd.materials = true
			nd.target_function = 'set_job_order'
			nd.target_node = self
		else:
			nd.get_node('icon').texture = null
			nd.data = null
			nd.order = 0
			nd.materials = true
			nd.target_function = 'set_job_order'
			nd.target_node = self
	for i in range(0, 5):
		var nd = $CraftRules/Container/items.get_node("pos_e_%d" % (i + 1))
		if enabled_list_2.size() > i:
			var job = enabled_list_2[i]
			var jobdata = tasks.tasklist[job]
			nd.get_node('icon').texture = load(jobdata.production_icon)
			nd.data = job
			nd.order = 5 - i
			nd.materials = false
			nd.target_function = 'set_job_order'
			nd.target_node = self
		else:
			nd.get_node('icon').texture = null
			nd.data = null
			nd.order = 5 - i
			nd.materials = false
			nd.target_function = 'set_job_order'
			nd.target_node = self
	for i in range(0, 5):
		var nd = $CraftRules/Container/items.get_node("pos_d_%d" % (i + 1))
		if disabled_list_2.size() > i:
			var job = disabled_list_2[i]
			var jobdata = tasks.tasklist[job]
			nd.get_node('icon').texture = load(jobdata.production_icon)
			nd.data = job
			nd.order = 0
			nd.materials = false
			nd.target_function = 'set_job_order'
			nd.target_node = self
		else:
			nd.get_node('icon').texture = null
			nd.data = null
			nd.order = 0
			nd.materials = false
			nd.target_function = 'set_job_order'
			nd.target_node = self
	
	build_predicted($CraftRules)


func set_job_order(job, value, materials):
	person.set_job_order(job, value, materials)
	build_priorities()
