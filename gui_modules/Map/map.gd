extends CanvasItem

#map inputs
var map_zoom_max = 1.5
var map_zoom_min = 0.9
var map_zoom_step = 0.1

var drag_mode = false
var drag_offset = Vector2(0.0, 0.0)
var click_position

var hovered_area = null
var _hovered_area = null
var hovered_location = null
var loc_locked = false

var area_zoom_data = {
	null:{position = Vector2(920, 1190), zoom = 1.0},
	plains = {position = Vector2(700, 1700), zoom = 1.5},
	forests = {position = Vector2(1310, 1890), zoom = 1.5},
	mountains = {position = Vector2(1000, 1000), zoom = 1.5},
}

func _unhandled_input(event):
#func _input(event):
	if event.is_action_pressed('MouseUp'):
		set_map_zoom($map.scale.x + map_zoom_step)
	if event.is_action_pressed('MouseDown'):
		set_map_zoom($map.scale.x - map_zoom_step)
	
	if event.is_action_pressed("LMB") and !drag_mode:
		click_position = get_global_mouse_position()
		drag_offset = $map.global_position - click_position
		drag_mode = true
	if event.is_action_released("LMB") and drag_mode:
		drag_mode = false
		if (get_global_mouse_position() - click_position).length() < 5:
			if selected_area != null and hovered_location != null:
				map_location_press(hovered_location)
			else:
				map_area_press(hovered_area)
	if drag_mode:
		set_map_position()
	#2add part with selecting areas with click on map


func animate_map_moves(zoom, pos, time = 0.5):
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_property($map, 'scale', $map.scale, Vector2(zoom, zoom), time)
	tween.interpolate_property($map, 'global_position', $map.global_position, pos, time)
	tween.interpolate_property($zoom, 'value', $zoom.value, zoom, time)
	tween.start()


func zoom_change(value):
	var tween = input_handler.GetTweenNode(self)
	if tween.is_active():
		return
	set_map_zoom(value, true)


func zoom_change_step(delta = 0):
	var value = $zoom.value
	value += delta * map_zoom_step
	set_map_zoom(value, true)


func set_map_zoom(value, centered = false):
	value = clamp(value, map_zoom_min, map_zoom_max)
	var current_zoom = $map.scale.x
	var k = value / current_zoom
	if k == 1.0:
		return
	
	var point
	if !centered:
		point = get_global_mouse_position()
	else:
		point = get_viewport().get_visible_rect().size * 0.5
	var map_pos = $map.global_position
	var point_offset = map_pos - point
	
	var new_point_offset = point_offset * k
	var new_map_pos = new_point_offset + point
	animate_map_moves(value, trim_map_pos(new_map_pos, value), 0.1)
#	$map.scale.x = value
#	$map.scale.y = value
#	$map.global_position = new_map_pos


func set_map_position():
	var new_map_pos = get_global_mouse_position() + drag_offset
	$map.global_position = trim_map_pos(new_map_pos)


func trim_map_pos(pos, scale = null):
	if scale == null:
		scale = $map.scale.x
	var screen = get_viewport().get_visible_rect().size
	var msize = $map.get_rect().size * scale
	var max_x = msize.x * 0.5
	var max_y = msize.y * 0.5
	var min_x =  screen.x - msize.x * 0.5
	var min_y =  screen.y - msize.y * 0.5
	var res = pos
	if screen.x < msize.x:
		res.x = clamp(res.x, min_x, max_x)
	else:
		res.x = screen.x * 0.5
	if screen.y < msize.y:
		res.y = clamp(res.y, min_y, max_y)
	else:
		res.y = screen.y * 0.5
	return res


func set_focus_area():
	var data = area_zoom_data[selected_area]
	animate_map_moves(data.zoom, data.position)
#	$map.scale.x = data.zoom
#	$map.scale.y = data.zoom
#	$map.global_position = data.position
	
	for area in $map.get_children():
		if area.name == selected_area:
			area.highlight(area.HighlightColor)
		else:
			area.highlight(Color(0,0,0,0))


func set_focus_location(loc):
	loc_locked = true
	for area in $map.get_children():
		if area.name == loc or area.name == selected_area:
			area.highlight(area.HighlightColor)
		else:
			area.highlight(Color(0,0,0,0))


func unselect_location():
	loc_locked = false
	hovered_location = null
	if selected_area == null:
		unselect_area()
		return
	for area in $map.get_children():
		if area.name == selected_area:
			area.highlight(area.HighlightColor)
		else:
			area.highlight(Color(0,0,0,0))


func area_locked():
	if hovered_area != null and hovered_area != _hovered_area:
		return true
	return false


#map gui
var locs_chosen = []
var selected_loc
var from_loc
var to_loc
var selected_chars = []
var selected_area

var sorted_locations = []
var lands_order = ['plains','forests','mountains','steppe','seas']
var lands_count = {}
var locs_order = ['capital', 'settlement', 'quest_location', 'dungeon', 'encounter']
var locs_count = {}


func _input(event):
	if !visible:
		return
	if (event.is_action_pressed("ESC") || event.is_action_released("RMB")):
		if to_loc != null:
			reset_to()
		elif selected_area != null:
			unselect_area()
			update_selected_area()
			build_info(null)
		elif from_loc != null:
			reset_from()
		elif selected_loc != null:
			selected_loc = null
			selected_chars.clear()
			unselect_location()
			build_info()
			update_location_chars()
			match_state()
		else:
			close()
		get_tree().set_input_as_handled()


func _ready():#2add button connections
	$Back.connect('pressed', self, 'close')
	$mode.connect('pressed', self, 'from_loc_set')
	$FromLocList/Sendbutton.connect('pressed', self, 'from_loc_set')
	$InfoPanel/Sendbutton.connect('pressed', self, 'confirm_travel')
	$zoom.min_value = map_zoom_min
	$zoom.max_value = map_zoom_max
	$zoom.connect("value_changed", self, 'zoom_change')
	$zoom/minus.connect("pressed", self, 'zoom_change_step', [ -1])
	$zoom/plus.connect("pressed", self, 'zoom_change_step', [ 1])
	$InfoPanel/Forget.connect("pressed", self, "forget_location")
#	match_state()


func forget_location():
	input_handler.get_spec_node(
		input_handler.NODE_YESNOPANEL,
		[
			self,
			'clear_dungeon_confirm',
			tr("FORGETLOCATIONQUESTION")
		]
	)


func clear_dungeon_confirm():
	if to_loc == null:
		return
	globals.remove_location(to_loc)
	input_handler.SystemMessage(tr("LOC_BEEN_REMOVED_LABEL"))
	selected_loc = null
	selected_chars.clear()
	build_locations_list()
	reset_from()
	reset_to()
	unselect_location()
	build_from_locations()
	build_to_locations()
	match_state()
	build_info()


func close():
#	get_parent().set_process_input(true)
#	set_process_input(true)
	if !visible: return
	gui_controller.current_screen = gui_controller.mansion
	if gui_controller.clock != null:
		gui_controller.clock.visible = true
#		gui_controller.clock.restoreoldspeed()
	input_handler.node_children_visible(get_parent(), null, true)
	get_parent().mansion_state = 'default'
#	get_parent().match_state()
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()
#	if get_parent().mansion_state == 'travels':
#		get_parent().mansion_state = 'default'
#
#	else:
#		.hide()

func open():
	hovered_area = null
#	get_parent().set_process_input(false)
#	set_process_input(true)
	gui_controller.current_screen = self
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)
	if gui_controller.clock != null:
		gui_controller.clock.visible = false
#	get_parent().SlaveListModule.hide()
	
	selected_chars.clear()
	from_loc = null
	to_loc = null
	selected_loc = null
	selected_area = null
	build_locations_list()
	build_from_locations()
	update_location_chars()
	build_to_locations()
	selected_area = 'plains'
	update_selected_area()
	match_state()
	build_info(null)
	show()
	input_handler.node_children_visible(get_parent(), self, false)
	ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)
	set_focus_area()
	input_handler.ActivateTutorial("TUTORIALLIST3")


func build_locations_list():
	locs_chosen.clear()
	sorted_locations.clear()
	locs_count.clear()
	lands_count.clear()
	var temp_locations = {}
	for id in ResourceScripts.game_world.location_links:
		var tdata = ResourceScripts.game_world.location_links[id]
		var adata = ResourceScripts.game_world.areas[tdata.area]
		if !adata.unlocked: continue
		var cdata = adata[tdata.category]
		if !cdata.has(id): 
			continue #should add here currently nonexisted marking location link to delete
		
		var temp = {id = id, area = tdata.area, type = cdata[id].type, heroes = [], quest = false}
		if temp.type == "capital":
			if adata.has("capital_code"):
				if adata.capital_code == "elf_capital":
					var closed = true
					if ResourceScripts.game_progress.completed_quests.has("princess_search"):
						closed = false
					for k in ResourceScripts.game_progress.active_quests:
						if k.code == "princess_search" and (k.stage == "stage3" or k.stage == "stage4" or k.stage == "stage5"): 
							closed = false
					if closed:
						continue
				if adata.capital_code == "beastkin_capital":
					var closed = true
					if ResourceScripts.game_progress.completed_quests.has("sword_artifact_quest"):
						closed = false
					for k in ResourceScripts.game_progress.active_quests: 
						if k.code == "sword_artifact_quest" and k.stage.lstrip("stage").to_int() > 2:
							closed = false
					if closed:
						continue
				if adata.capital_code == "dwarf_capital":
					if !(globals.valuecheck({type = "quest_completed", name = "visit_dwarfs_quest", check = true})
						or globals.valuecheck({type = 'active_quest_stage', value = 'visit_dwarfs_quest', stage = 'search', state = false})
						):#closed that is
						continue
		if cdata[id].has("tags") and cdata[id].tags.has('quest'):
			temp.quest = true
		if tdata.category == "questlocations":
			if cdata[id].has("questid") and ResourceScripts.game_progress.if_quest_active(cdata[id].questid):
				temp.quest = true
			if adata.questlocations.has(id):
				if adata.questlocations[id].has("quest"):
					temp.quest = adata.questlocations[id].quest
		if cdata[id].has('background'):
			temp.icon = cdata[id].background
		elif temp.type == 'capital' and adata.has('capital_background'):
			temp.icon = adata.capital_background
		else:
			temp.icon = null
		if cdata[id].has('captured'): temp.captured = cdata[id].captured
		if cdata[id].has('locked'): temp.locked = cdata[id].locked
		if temp.area == 'beastkin_tribe':
			temp.area = 'forests'
		if lands_count.has(temp.area): lands_count[temp.area] += 1
		else:  lands_count[temp.area] = 1
		if locs_count.has(temp.type): locs_count[temp.type] += 1
		else:  locs_count[temp.type] = 1
		temp_locations[id] = temp
	
	var temp = {id = 'travel', heroes = []}
	for ch_id in ResourceScripts.game_party.character_order:
		var character = characters_pool.get_char_by_id(ch_id)
		if !character.is_active: 
			continue
		var loc = character.get_location()
		if loc == "mansion":
			character.travel.location = ResourceScripts.game_world.mansion_location
		if loc == 'travel':
			temp.heroes.push_back(ch_id)
		elif character.is_on_quest(): 
			continue
		elif !temp_locations.has(loc):
			print("warning - populated location %s not found or not avail" % loc)
			continue
		else:
			temp_locations[loc].heroes.push_back(character.id)
			if !locs_chosen.has(loc):
				locs_chosen.push_back(loc)
	
	sorted_locations = temp_locations.values().duplicate()
	sorted_locations.sort_custom(self, 'sort_locations')
	sorted_locations.push_back(temp)


func sort_locations(first, second):
	if lands_order.has(first.area):
		if lands_order.has(second.area):
			if lands_order.find(first.area) == lands_order.find(second.area):
				if locs_order.has(first.type):
					if locs_order.has(second.type):
						if locs_order.find(first.type) != locs_order.find(second.type):
							return locs_order.find(first.type) < locs_order.find(second.type)
						else:
							return first.id > second.id
			else:
				return lands_order.find(first.area) < lands_order.find(second.area)
		return false
	return true


func if_location_in_list(loc):
	for loc_d in sorted_locations:
		if loc_d.id == loc:
			return true
	return false


func get_location_data(loc):
	for loc_d in sorted_locations:
		if loc_d.id == loc:
			return loc_d
	return false


func build_info(loc = null):
	if loc == null:
		loc = to_loc
#	if loc == null:
#		loc = from_loc
#	if loc == null:
#		loc = selected_loc
	if loc == null:
		$InfoPanel.visible = false
		return
	
	var location = ResourceScripts.world_gen.get_location_from_code(loc)
	var tdata = ResourceScripts.game_world.location_links[loc]
	var adata = ResourceScripts.game_world.areas[tdata.area]
	
	var location_selected = get_location_data(loc)
	$InfoPanel/Forget.visible = (!location.tags.has('quest') and location_selected.type in ['dungeon', 'encounter'])
#	if to_loc != null:
#		$InfoPanel/Forget.visible = false
	
	#build info
	$InfoPanel/Label.text = tr(location.name)
	var icon = null
	if location.has('background'):
		icon = location.background
	elif location.type == 'capital' and adata.has('capital_background'):
		icon = adata.capital_background
	if icon != null:
		icon = images.backgrounds[icon]
	$InfoPanel/InfoFrame/icon.texture = icon
	$InfoPanel/InfoFrame/name.text = tr(location.name)
	#build res
	var dungeon = false
	var hidden = false
	var info_res_node = $InfoPanel/VBoxContainer/ResScroll/Resources
	input_handler.ClearContainer(info_res_node)
	info_res_node.show()
	$InfoPanel/VBoxContainer/Label3.show()
	$InfoPanel/InfoFrame/enemies.visible = false
	for r_task in ['recruit_easy', 'recruit_hard']:
		if location.has('tags') and location.tags.has(r_task):
			var newbutton = input_handler.DuplicateContainerTemplate(info_res_node)
			var jobdata = tasks.tasklist[r_task]
			newbutton.get_node("Icon").texture = jobdata.production_icon
			var max_workers_count = jobdata.base_workers
			var current_workers_count = 0
			for task in ResourceScripts.game_party.active_tasks:
				if (task.code == r_task) && (task.task_location == loc):
					current_workers_count = task.workers.size()
			newbutton.get_node("amount").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
			globals.connecttexttooltip(newbutton, jobdata.descript)
	var gatherable_resources
	if (location.type in ["capital", "quest_location"]) or (location.has('locked') and location.locked):
		info_res_node.hide()
		$InfoPanel/VBoxContainer/Label3.hide()
	elif location.type == "dungeon":
		$InfoPanel/InfoFrame/enemies.visible = true
		if location.tags.has('quest'):
			$InfoPanel/InfoFrame/enemies.text = tr("QUESTLOCATION")
			
		else:
			$InfoPanel/InfoFrame/enemies.text = tr(location.classname)
		dungeon = true
#		if !location.completed:
#			hidden = true
		gatherable_resources = location.gather_limit_resources
	else:
		if location.has('gather_resources'):
			gatherable_resources = location.gather_resources
	
	if gatherable_resources != null:
		if gatherable_resources.empty():
			info_res_node.hide()
			$InfoPanel/VBoxContainer/Label3.hide()
		for i in gatherable_resources:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(info_res_node)
			newbutton.get_node("Icon").texture = Items.materiallist[i].icon
			newbutton.set_meta("exploration", true)
			if dungeon:
				if !hidden:
					newbutton.get_node("amount").text = str(gatherable_resources[i])
					newbutton.set_meta("gather_mod", round(location.gatherable_resources[i].gather_mod * 100))
					globals.connectmaterialtooltip(newbutton, item)
				else:
					newbutton.get_node("Icon").texture = load("res://assets/Textures_v2/Travel/placer_travel_question.png")
			else:
				var max_workers_count = gatherable_resources[i]
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i) && (task.task_location == loc):
						current_workers_count = task.workers.size()
				newbutton.get_node("amount").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
				newbutton.set_meta("max_workers", max_workers_count)
				newbutton.set_meta("current_workers", current_workers_count)
				globals.connectmaterialtooltip(newbutton, item)
	#build chars
	input_handler.ClearContainer($InfoPanel/VBoxContainer/CharScroll/Characters)
	var f = false
	for ch_id in ResourceScripts.game_party.character_order:
		var ch = characters_pool.get_char_by_id(ch_id)
		if ch.get_location() != loc:
			continue
		f = true
		var panel = input_handler.DuplicateContainerTemplate($InfoPanel/VBoxContainer/CharScroll/Characters)
		panel.get_node('Icon').texture = ch.get_icon_small()
		globals.connectslavetooltip(panel, ch)
	$InfoPanel/VBoxContainer/CharScroll.visible = f
	$InfoPanel/VBoxContainer/Label2.visible = f
	
	$InfoPanel.visible = true
	if from_loc != 'adv_mode' and to_loc != null and loc == to_loc:
		$InfoPanel/Sendbutton.visible = true
		$InfoPanel/time.visible = true
		$InfoPanel/time.text = "Travel time - %d t" % globals.calculate_travel_time(from_loc, to_loc).time
	else:
		$InfoPanel/Sendbutton.visible = false
		$InfoPanel/time.visible = false


func make_panel_for_location(panel, loc):
	if loc.id == 'travel':
		set_loc_text(panel, "Characters on the road")
	else:
		var data = ResourceScripts.world_gen.get_location_from_code(loc.id)
		var text = data.name
#		if ResourceScripts.game_world.areas[loc.area].questlocations.has(loc.id):
		if loc.quest:
			text = "Q:" + text
			panel.get_node("Label").set("custom_colors/font_color", variables.hexcolordict.yellow)
		if  data.has('active') and data.active == false:
			text += "(!)"
		set_loc_text(panel, text)
#		panel.get_node("Label").text = text
		if loc.has('captured'):
			if loc.captured:
				panel.get_node("Label").set("custom_colors/font_color", variables.hexcolordict.red)
				panel.disabled = true
#				globals.connecttexttooltip(panel, "Location Unavailable")
#				globals.return_characters_from_location(loc.id)
		if loc.has('locked'):
			if loc.locked:
				panel.get_node("Label").set("custom_colors/font_color", variables.hexcolordict.red)
#				globals.connecttexttooltip(panel, "Location Unavailable")
#				globals.return_characters_from_location(loc.id)
		var icon
		match loc.type:
			'settlement':
				icon = images.icons.travel_village
			'dungeon':
				icon = images.icons.travel_dungeon
			'capital':
				icon = images.icons.travel_city
			'quest_location', 'encounter':
				icon = images.icons.travel_event
		if panel.has_node('icon'):
			panel.get_node("icon").texture = icon


func make_panel_for_character(panel, ch_id):
	var tchar = characters_pool.get_char_by_id(ch_id)
	set_loc_text(panel, tchar.get_full_name())
	panel.get_node("icon").texture = tchar.get_icon_small()
	if !tchar.is_controllable(): 
		panel.disabled = true
	if tchar.get_location() == 'travel':
		panel.disabled = true


func build_from_locations():
	#filter locations
	var areas = {}
	var travel_data = null
	for loc_data in sorted_locations:
		if loc_data.heroes.empty():
			continue
		if loc_data.id == 'travel':
			travel_data = loc_data
			continue
#		if loc_data.id == to_loc:
#			continue
		if areas.has(loc_data.area):
			areas[loc_data.area].push_back(loc_data)
		else:
			areas[loc_data.area] = [loc_data]
	#update list
	input_handler.ClearContainer($FromLocList/LocScroll/LocCatList, ['LocCat'])
	for area in areas:
		#no need to clear container
		for loc_data in areas[area]:
			var category = input_handler.DuplicateContainerTemplate($FromLocList/LocScroll/LocCatList, 'LocCat')
			category.set_meta('location', loc_data.id)
			category.get_node('Button').connect('pressed', self, 'toggle_from_location', [loc_data.id])
			category.get_node('Button').connect('mouse_entered', $map.get_node(area), 'Light')
			category.get_node('Button').connect('mouse_exited', $map.get_node(area), 'UnLight')
#			category.get_node('Button').connect('mouse_entered', self, 'build_info', [loc_data.id])
#			category.get_node('Button').connect('mouse_exited', self, 'build_info')
			make_panel_for_location(category.get_node('Button'), loc_data)
			for ch_id in loc_data.heroes:
				var loc_button = input_handler.DuplicateContainerTemplate(category.get_node('offset/LocList'), 'Button')
				loc_button.set_meta('location', loc_data.id)
				loc_button.set_meta('character', ch_id)
				loc_button.connect('pressed', self, 'char_loc_press', [ch_id, loc_data.id])
#				loc_button.connect('pressed', self, 'location_press', [loc_data.id, 'from'])
#				loc_button.connect('mouse_entered', self, 'build_info', [loc_data.id])
#				loc_button.connect('mouse_exited', self, 'build_info')
				loc_button.visible = true
				make_panel_for_character(loc_button, ch_id)
	if travel_data != null:
		var category = input_handler.DuplicateContainerTemplate($FromLocList/LocScroll/LocCatList, 'LocCat')
		category.set_meta('location', travel_data.id)
		category.get_node('Button').connect('pressed', self, 'toggle_from_location', [travel_data.id])
		make_panel_for_location(category.get_node('Button'), travel_data)
		for ch_id in travel_data.heroes:
			var loc_button = input_handler.DuplicateContainerTemplate(category.get_node('offset/LocList'), 'Button')
			loc_button.set_meta('location', travel_data.id)
			loc_button.set_meta('character', ch_id)
			loc_button.connect('pressed', self, 'char_loc_press', [ch_id, travel_data.id])
			loc_button.visible = true
			make_panel_for_character(loc_button, ch_id)



func build_to_locations():
	#filter locations
	var areas = {}
	for loc_data in sorted_locations:
		if loc_data.id == 'travel':
			continue
#		if loc_data.captured:
#			continue
		if loc_data.id == from_loc:
			continue
		if areas.has(loc_data.area):
			areas[loc_data.area].push_back(loc_data)
		else:
			areas[loc_data.area] = [loc_data]
	#update list
	input_handler.ClearContainer($ToLocList/LocScroll/LocCatList, ['LocCat'])
	for area in areas:
		var category = input_handler.DuplicateContainerTemplate($ToLocList/LocScroll/LocCatList, 'LocCat')
		category.set_meta('area', area)
		category.get_node('Button/Label').text = tr('AREA' + area.to_upper()) #currently works, but not granted
		category.get_node('Button').connect('pressed', self, 'area_press', [area, 'to'])
		category.get_node('Button').connect('mouse_entered', $map.get_node(area), 'Light')
		category.get_node('Button').connect('mouse_exited', $map.get_node(area), 'UnLight')
		#no need to clear container
		for loc_data in areas[area]:
			var loc_button = input_handler.DuplicateContainerTemplate(category.get_node('offset/LocList'), 'Button')
			loc_button.set_meta('location', loc_data.id)
			loc_button.connect('pressed', self, 'location_press', [loc_data.id, 'to'])
			loc_button.connect('mouse_entered', self, 'build_info', [loc_data.id])
			loc_button.connect('mouse_exited', self, 'build_info')
			make_panel_for_location(loc_button, loc_data)
			if !loc_data.heroes.empty():
				loc_button.get_node('amount').text = str(loc_data.heroes.size())
			else:
				loc_button.get_node('amount').text = ""
	
	update_selected_area()
	update_selected_to_location()


func update_selected_area():
	for cat in $ToLocList/LocScroll/LocCatList.get_children():
		if !cat.has_meta('area'):
			continue
		var tarea = cat.get_meta('area')
		if tarea == selected_area:
			cat.get_node('Button').pressed = true
			cat.get_node('offset/LocList').visible = true
		else:
			cat.get_node('Button').pressed = false
			cat.get_node('offset/LocList').visible = false


func toggle_from_location(loc_toggled):
	if locs_chosen.has(loc_toggled):
		locs_chosen.erase(loc_toggled)
	else:
		locs_chosen.push_back(loc_toggled)
	update_location_chars()


func update_selected_to_location():
	for cat in $ToLocList/LocScroll/LocCatList.get_children():
		for loc in cat.get_node('offset/LocList').get_children():
			if !loc.has_meta('location'):
				continue
			loc.pressed = (loc.get_meta('location') == to_loc)


func update_confirm():
	var amount = selected_chars.size()
	if amount == 0:
		$InfoPanel/Sendbutton.visible = false
#	else:
#		$InfoPanel/Sendbutton.visible = true


func map_area_press(area):
	if !ResourceScripts.game_world.is_area_unlocked(area):
		return
	if selected_area == area:
		return
	if from_loc == null:
		return
	else:
		selected_area = area
	if selected_area == null:
		unselect_area()
	
	selected_loc = null
	update_selected_area()
	set_focus_area()
	match_state()
	build_info()


func map_location_press(loc):
	if !if_location_in_list(loc):
		return
	if selected_area == null:
		return
	
	var mode = 'from'
	if from_loc != null:
		mode = 'to'
	
	location_press(loc, mode)


func area_press(area, mode):
	if selected_area == area:
		unselect_area()
	else:
		selected_area = area
	
	selected_loc = null
	update_selected_area()
	set_focus_area()
	match_state()
	build_info()


func unselect_area():
	selected_area = null
	hovered_area = _hovered_area
	set_focus_area()


func char_loc_press(ch_id, loc_id):
	if !selected_chars.has(ch_id):
		if selected_chars.empty():
			selected_loc = loc_id
			match_state()
		selected_chars.push_back(ch_id)
	else:
		selected_chars.erase(ch_id)
		if selected_chars.empty():
			selected_loc = null
			match_state()
#	build_info()
	update_confirm()
	update_location_chars()


func update_location_chars():
	for loc in $FromLocList/LocScroll/LocCatList.get_children():
#		for loc in cat.get_node('offset/LocList').get_children():
		if !loc.has_meta('location'):
			continue
		var cloc = loc.get_meta('location')
		var show_chars = true
		if locs_chosen.has(cloc):
			loc.get_node('Button').pressed = true
		else:
			loc.get_node('Button').pressed = false
			show_chars = false
		for ch in loc.get_node('offset/LocList').get_children():
			if !ch.has_meta('character'):
				continue
			var person_id = ch.get_meta('character')
			var person = characters_pool.get_char_by_id(person_id)
			ch.visible = show_chars
			ch.pressed = (selected_chars.has(person_id))
			ch.disabled = (selected_loc != null and ch.get_meta('location') != selected_loc)
			if !person.is_controllable(): 
				ch.disabled = true
			if person.get_location() == 'travel':
				ch.disabled = true


func location_press(location, mode):
	match mode:
		'from':
			if selected_loc == location and selected_chars.empty():
				selected_loc = null
				unselect_location()
			else:
				selected_loc = location
				set_focus_location(location)
			build_info(selected_loc)
			match_state()
		'to':
			if to_loc == location:
				to_loc = null
				unselect_location()
				build_info()
			else:
				to_loc = location
				set_focus_location(location)
				build_info(to_loc)
#			selected_chars.clear()
			update_selected_to_location()
			match_state()


func match_state():
	if from_loc == null:
		$FromLocList.visible = true
		$ToLocList.visible = false
		if selected_loc == null:
#			$FromLocList/Sendbutton/Label.text = 'Adv.Mode'
			$FromLocList/Sendbutton.visible = false
			$mode/Label.text = 'Adv. Mode'
			$mode.visible = true
		else:
			$FromLocList/Sendbutton.visible = true
			$mode.visible = false
#			$FromLocList/Sendbutton/Label.text = 'Send'
#		$FromLocList/Sendbutton.visible = true
		$InfoPanel/Sendbutton.visible = false
	else:
		$ToLocList.visible = true
		if from_loc == 'adv_mode':
			$FromLocList.visible = false
			$mode/Label.text = 'Smpl.Mode'
			$mode.visible = true
		else:
			$FromLocList.visible = true
			$FromLocList/Sendbutton.visible = false
			$mode.visible = false


func from_loc_set():
	if from_loc == 'adv_mode':
		selected_loc = null
		reset_from()
		return
	if selected_loc == null:
		selected_loc = 'adv_mode'
		update_location_chars()
	from_loc = selected_loc
	loc_locked = false
#	selected_area = null
	set_focus_area()
	build_to_locations()
	build_info()
	match_state()


func to_loc_set():
	if selected_loc == null: 
		return
	to_loc = selected_loc
	loc_locked = false
#	build_from_locations()
	build_info()
	match_state()


func reset_to():
#	from_loc = null
	to_loc = null
	unselect_area()
	unselect_location()
	match_state()
	build_to_locations()
	build_info(null)


func reset_from():
	from_loc = null
	to_loc = null
	selected_loc = null
	selected_chars.clear()
	unselect_area()
	unselect_location()
	build_from_locations()
	update_location_chars()
	match_state()
	build_info(null)


func confirm_travel():
	if from_loc == to_loc:
		return
	var locdata = ResourceScripts.game_world.location_links[to_loc]
	var travel_cost = globals.calculate_travel_time(from_loc, to_loc)
	for chid in selected_chars:
		var person = characters_pool.get_char_by_id(chid)
		person.remove_from_task()
		person.process_event(variables.TR_MOVE)
		if ResourceScripts.game_progress.instant_travel == false:
			person.previous_location = person.travel.location
			person.set_work('travel')
			person.travel.location = 'travel'
			person.travel.travel_target = {area = locdata.area, location = to_loc}
			person.travel.travel_time = travel_cost.time
			person.travel.initial_travel_time = travel_cost.time
		else:
#			person.set_work('') #not needed after remove from task
			person.travel.location = to_loc
			person.travel.area  = locdata.area
	input_handler.PlaySound("ding")
	globals.emit_signal("slave_departed")
	selected_chars.clear()
	reset_from()
	reset_to()
	selected_loc = null
	build_locations_list()
	build_from_locations()
	match_state()
	build_info(selected_loc)


func set_loc_text (btn, text):
	btn.get_node("Label").text = text
	var font = input_handler.font_size_calculator(btn.get_node("Label"))
	btn.get_node("Label").set("custom_fonts/font", font)
