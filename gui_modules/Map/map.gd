extends CanvasItem

#map inputs
var map_zoom_max = 4.0
var map_zoom_min = 0.25
var map_zoom_step = 0.1

var drag_mode = false
var drag_offset = Vector2(0.0, 0.0)
var click_position

var hovered_area = null

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
			map_area_press(hovered_area)
	if drag_mode:
		set_map_position()
	#2add part with selecting areas with click on map


func animate_map_moves(zoom, pos, time = 0.5):
	var tween = input_handler.GetTweenNode(self)
	tween.interpolate_property($map, 'scale', $map.scale, Vector2(zoom, zoom), time)
	tween.interpolate_property($map, 'global_position', $map.global_position, pos, time)
	tween.start()


func set_map_zoom(value):
	value = clamp(value, map_zoom_min, map_zoom_max)
	var current_zoom = $map.scale.x
	var k = value / current_zoom
	if k == 1.0:
		return
	
	var point = get_global_mouse_position()
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


#map gui
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
		if from_loc != null:
			reset_from()
		elif to_loc != null:
			reset_to()
		elif selected_loc != null:
			selected_loc = null
			selected_chars.clear()
			update_selected_to_location()
			build_charpanel()
			build_info(selected_loc)
		elif selected_area != null:
			unselect_area()
			update_selected_area()
		else:
			close()
		get_tree().set_input_as_handled()



func _ready():#2add button connections
	$Back.connect('pressed', self, 'close')
	$InfoPanel/Sendbutton.connect('pressed', self, 'to_loc_set')
	$CharPanel/Send.connect('pressed', self, 'confirm_travel')
	$CharPanel/mode2.connect('pressed', self, 'reset_to')
	$CharPanel/mode1.connect('pressed', self, 'reset_from')
#	match_state()

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
	get_parent().match_state()
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
	build_to_locations()
	match_state()
	build_info(null)
	show()
	input_handler.node_children_visible(get_parent(), self, false)
	ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)
	set_focus_area()


func build_locations_list():
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
		
		var temp = {id = id, area = tdata.area, type = cdata[id].type, heroes = 0, quest = false}
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
	
	for character in ResourceScripts.game_party.characters.values():
		if !character.is_active: 
			continue
		var loc = character.get_location()
		if loc == "mansion":
			character.travel.location = ResourceScripts.game_world.mansion_location
		if loc == 'travel':
			continue
		elif !temp_locations.has(loc):
			print("warning - populated location %s not found or not avail" % loc)
			continue
		else:
			temp_locations[loc].heroes += 1
	
	sorted_locations = temp_locations.values().duplicate()
	sorted_locations.sort_custom(self, 'sort_locations')


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


func build_info(loc = to_loc):
	if loc == null:
		$InfoPanel.visible = false
		return
	
	var location = ResourceScripts.world_gen.get_location_from_code(loc)
	var tdata = ResourceScripts.game_world.location_links[loc]
	var adata = ResourceScripts.game_world.areas[tdata.area]
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
		dungeon = true
		if !location.completed:
			hidden = true
		gatherable_resources = location.gather_limit_resources
	else:
		if location.has('gather_resources'):
			gatherable_resources = location.gather_resources
	
	if gatherable_resources != null:
		for i in gatherable_resources:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(info_res_node)
			newbutton.get_node("Icon").texture = Items.materiallist[i].icon
			newbutton.set_meta("exploration", true)
			if dungeon:
				if !hidden:
					newbutton.get_node("amount").text = str(gatherable_resources[i])
					newbutton.set_meta("gather_mod", round(location.gather_mod*100))
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
	$InfoPanel/Sendbutton.visible = (to_loc == null)


func make_panel_for_location(panel, loc):
	if loc.id == 'travel': #not used
		panel.text = "Characters on the road"
	else:
		var text = ResourceScripts.world_gen.get_location_from_code(loc.id).name
#		if ResourceScripts.game_world.areas[loc.area].questlocations.has(loc.id):
		if loc.quest:
			text = "Q:" + text
		panel.get_node("Label").text = text
		if loc.has('captured'):
			if loc.captured:
				panel.get_node("Label").set("custom_colors/font_color", variables.hexcolordict.red)
				panel.disabled = true
#				globals.connecttexttooltip(panel, "Location Unavailable")
#				globals.return_characters_from_location(loc.id)
		if loc.has('locked'):
			if loc.locked:
				panel.get_node("Label").set("custom_colors/font_color", variables.hexcolordict.yellow)
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
		panel.get_node("icon").texture = icon


func build_from_locations():
	#filter locations
	var areas = {}
	for loc_data in sorted_locations:
		if loc_data.heroes <= 0:
			continue
		if areas.has(loc_data.area):
			areas[loc_data.area].push_back(loc_data)
		else:
			areas[loc_data.area] = [loc_data]
	#update list
	input_handler.ClearContainer($FromLocList/LocScroll/LocCatList, ['LocCat'])
	for area in areas:
		var category = input_handler.DuplicateContainerTemplate($FromLocList/LocScroll/LocCatList, 'LocCat')
		category.set_meta('area', area)
		category.get_node('Button/Label').text = tr('AREA' + area.to_upper()) #currently works, but not granted
		category.get_node('Button').connect('pressed', self, 'area_press', [area, 'from'])
		category.get_node('Button').connect('mouse_entered', $map.get_node(area), 'Light')
		category.get_node('Button').connect('mouse_exited', $map.get_node(area), 'UnLight')
		#no need to clear container
		for loc_data in areas[area]:
			var loc_button = input_handler.DuplicateContainerTemplate(category.get_node('offset/LocList'), 'Button')
			loc_button.set_meta('location', loc_data.id)
			loc_button.connect('pressed', self, 'location_press', [loc_data.id, 'from'])
			loc_button.connect('mouse_entered', self, 'build_info', [loc_data.id])
			loc_button.connect('mouse_exited', self, 'build_info')
			make_panel_for_location(loc_button, loc_data)
			loc_button.get_node('amount').text = str(loc_data.heroes)
	
	update_selected_area()
	update_selected_from_location()


func build_to_locations():
	#filter locations
	var areas = {}
	for loc_data in sorted_locations:
#		if loc_data.captured:
#			continue
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
			make_panel_for_location(loc_button, loc_data)
	
	update_selected_area()
	update_selected_to_location()


func update_selected_area():
	for cat in $FromLocList/LocScroll/LocCatList.get_children() + $ToLocList/LocScroll/LocCatList.get_children():
		if !cat.has_meta('area'):
			continue
		var tarea = cat.get_meta('area')
		if tarea == selected_area:
			cat.get_node('Button').pressed = true
			cat.get_node('offset/LocList').visible = true
		else:
			cat.get_node('Button').pressed = false
			cat.get_node('offset/LocList').visible = false


func update_selected_from_location():
	for cat in $FromLocList/LocScroll/LocCatList.get_children():
		for loc in cat.get_node('offset/LocList').get_children():
			if !loc.has_meta('location'):
				continue
			loc.pressed = (loc.get_meta('location') == from_loc)


func update_selected_to_location():
	for cat in $ToLocList/LocScroll/LocCatList.get_children():
		for loc in cat.get_node('offset/LocList').get_children():
			if !loc.has_meta('location'):
				continue
			loc.pressed = (loc.get_meta('location') == selected_loc)


func update_location_chars():
	for nd in $CharPanel/ScrollContainer/CharList.get_children():
		if !nd.has_meta('character'):
			continue
		var ch_id = nd.get_meta('character')
		nd.pressed = selected_chars.has(ch_id)


func update_travel_duration():
	if from_loc == null or to_loc == null:
		$CharPanel/time.visible = false
		return
#	var res = globals.calculate_travel_time(ResourceScripts.world_gen.get_location_from_code(from_loc), ResourceScripts.world_gen.get_location_from_code(to_loc))
	var res = globals.calculate_travel_time(from_loc, to_loc)
	$CharPanel/time.visible = true
	$CharPanel/time.text = "Travel duration: %d" % res.time


func update_confirm():
	var amount = selected_chars.size()
	if amount == 0:
		$CharPanel/Send.visible = false
		$CharPanel/selected.visible = false
	elif amount == 1:
		$CharPanel/Send.visible = true
		$CharPanel/selected.visible = true
		$CharPanel/selected.text = "1 character"
	else:
		$CharPanel/Send.visible = true
		$CharPanel/selected.visible = true
		$CharPanel/selected.text = "%d characters" % amount


func map_area_press(area):
	if selected_area == area:
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
	
	set_focus_area()


func location_press(location, mode):
	match mode:
		'from':
			if from_loc == location:
				from_loc = null
			else:
				from_loc = location
			update_selected_from_location()
			build_charpanel()
			match_state()
		'to':
			if selected_loc == location:
				selected_loc = null
			else:
				selected_loc = location
			selected_chars.clear()
			update_selected_to_location()
			build_charpanel()
			build_info(selected_loc)


func build_charpanel():
	if from_loc == null or to_loc == null:
		$CharPanel.visible = false
		return
#	$CharPanel.visible = true
	$CharPanel/mode1.pressed = false
	$CharPanel/mode2.pressed = true
	$CharPanel/mode1/Label.text = tr(ResourceScripts.world_gen.get_location_from_code(from_loc).name)
	$CharPanel/mode2/Label.text = tr(ResourceScripts.world_gen.get_location_from_code(to_loc).name)
	update_travel_duration()
	input_handler.ClearContainer($CharPanel/ScrollContainer/CharList)
	for ch_id in ResourceScripts.game_party.character_order:
		var ch = characters_pool.get_char_by_id(ch_id)
		if ch.get_location() != from_loc:
			continue
		if ch.get_work() == 'learning': 
			continue
		var panel = input_handler.DuplicateContainerTemplate($CharPanel/ScrollContainer/CharList)
		panel.set_meta('character', ch_id)
		panel.get_node('icon').texture = ch.get_icon_small()
		if (ch.predict_obed_time() <= 0) and !ch.is_controllable():
			panel.disabled = true
		panel.connect('pressed', self, 'character_press', [ch_id])
		globals.connectslavetooltip(panel, ch)
	update_location_chars()
	update_confirm()


func character_press(ch_id):
	if selected_chars.has(ch_id):
		selected_chars.erase(ch_id)
	else:
		selected_chars.push_back(ch_id)
	update_location_chars()
	update_confirm()


func match_state():
	if to_loc == null:
		$FromLocList.visible = false
		$ToLocList.visible = true
		$CharPanel.visible = false
	else:
		$FromLocList.visible = true
		$ToLocList.visible = false
		if from_loc == null:
			$CharPanel.visible = false
		else:
			$CharPanel.visible = true


func to_loc_set():
	if selected_loc == null: 
		return
	to_loc = selected_loc
	build_from_locations()
	match_state()


func reset_to():
	from_loc = null
	to_loc = null
	unselect_area()
	match_state()
	build_to_locations()
	build_info(null)


func reset_from():
	from_loc = null
	unselect_area()
	match_state()
	build_from_locations()
	build_info(to_loc)


func confirm_travel():
	if from_loc == to_loc:
		return
	var locdata = ResourceScripts.game_world.location_links[to_loc]
	var travel_cost = globals.calculate_travel_time(from_loc, to_loc)
	for chid in selected_chars:
		var person = characters_pool.get_char_by_id(chid)
		person.remove_from_task()
		person.process_event(variables.TR_MOVE)
#		if !person.is_controllable():
#			person.add_stat('obedience', -ceil((travel_cost.obed_cost/person.travel_per_tick())))
		if ResourceScripts.game_progress.instant_travel == false:
			person.previous_location = person.travel.location
			person.xp_module.work = 'travel'
			person.travel.location = 'travel'
			person.travel.travel_target = {area = locdata.area, location = to_loc}
			person.travel.travel_time = travel_cost.time
			person.travel.initial_travel_time = travel_cost.time
		else:
			person.xp_module.work = 'travel'
			person.travel.location = to_loc
			person.travel.area  = locdata.area
	input_handler.PlaySound("ding")
	globals.emit_signal("slave_departed")
	selected_chars.clear()
	from_loc = null
	to_loc = null
	selected_loc = null
	build_locations_list()
	match_state()
	build_info(selected_loc)
