extends "res://src/scenes/ClosingPanel.gd"


onready var info_text_node = $area/info_panel/VBoxContainer/info_text
onready var info_text_icon = $area/info_panel/VBoxContainer/TextureRect
onready var info_res_panel = $area/info_panel/resources
onready var info_res_node = $area/info_panel/resources/CenterContainer/GridContainer
onready var from_list = $area/from_panel/ScrollContainer/VBoxContainer
onready var to_list = $area/to_panel/ScrollContainer/VBoxContainer
onready var char_list = $area/from_panel/ScrollContainer2/VBoxContainer
onready var selector = $area/to_panel/HBoxContainer2/HBoxContainer
onready var selector_list = $area/to_panel/HBoxContainer2/HBoxContainer/SelectorMain/SelectorPanel/VBoxContainer
onready var forget_button = $area/info_panel/VBoxContainer/CenterContainer/forgetButton


var from_location_selected = null 
var location_selected = null
var characters = []
var sorted_locations = []
var lands_order = ['plains','forests','mountains','steppe','seas']
var lands_count = {}
var locs_order = ['capital', 'settlement', 'quest_location', 'dungeon', 'encounter']
var locs_count = {}
var loc_filter = 'all'

func _ready():
	add_to_group("pauseprocess")
	gui_controller.travel = self
	selector.get_node("SelectorLeft").connect('pressed', self, 'change_filter', [-1])
	selector.get_node("SelectorRight").connect('pressed', self, 'change_filter', [1])
	selector.get_node("SelectorMain").connect('pressed', self, 'toggle_selector', [false])
	selector.get_node("SelectorMain/SelectorPanel/Screen").connect('pressed', self, 'toggle_selector', [true])
	$area/to_panel/HBoxContainer/CenterContainer2/ConfirmButton.connect("pressed",self,'confirm_travel')
	$area/to_panel/HBoxContainer/CenterContainer/CancelButton.connect("pressed",self,'hide')
	update_lists()
	build_sel_panel(false)
	forget_button.connect("pressed", self, "forget_location")


func show():
#	gui_controller.clock.changespeed(0)
	gui_controller.clock.visible = false
	gui_controller.current_screen = self
	update_lists()
	selector.get_node("SelectorMain").pressed = false
	build_sel_panel(false)
	.show()


func change_filter(value):
	var filters = ['all'] + lands_order# + locs_order
	if !(loc_filter in filters):
		print ("wrong filter - %s" % loc_filter)
		return
	var cpos = filters.find(loc_filter)
	while cpos < filters.size(): # effectively while true
		cpos += value
		if cpos == -1: cpos += filters.size()
		if cpos == filters.size(): cpos = 0
		var next_filter = filters[cpos]
		if next_filter in locs_order:
			if !locs_count.has(next_filter) or locs_count[next_filter] <= 0: continue
		if next_filter in lands_order:
			if !ResourceScripts.game_world.areas.has(next_filter): continue
			if !ResourceScripts.game_world.areas[next_filter].unlocked: continue
			if !lands_count.has(next_filter) or lands_count[next_filter] <= 0: continue
		loc_filter = next_filter
		build_sel_panel(selector.get_node("SelectorMain").pressed)
		update_to_list()
		break


func toggle_selector(outside = false):
	if outside:
		selector.get_node("SelectorMain").pressed = false
	build_sel_panel(selector.get_node("SelectorMain").pressed)


var selector_meta_bindings = {
	all = "All",
	'plains':"Plains",
	'forests':"Forests",
	'mountains':"Mountains",
	'steppe':"Steppe",
	'seas':"Seas",
	'capital':"Capitals",
	'settlement':"Villages", 
	'quest_location':"Quests", 
	'dungeon':"Dungeons", 
	'encounter':"Encounters"
}

func build_sel_panel(is_open):
	selector.get_node("SelectorMain/SelectorPanel/Screen").visible = is_open
	input_handler.ClearContainer(selector_list)
	
	if is_open:
		var button = input_handler.DuplicateContainerTemplate(selector_list)
		button.text = selector_meta_bindings[loc_filter]
		button.connect('pressed', self, 'toggle_selector', [true])
		if loc_filter != 'all':
			var tbutton = input_handler.DuplicateContainerTemplate(selector_list)
			tbutton.text = selector_meta_bindings['all']
			tbutton.set_meta('value', 'all')
			tbutton.connect('pressed', self, 'select_filter', ['all'])
		
		var separator = TextureRect.new()
		separator.texture = load("res://assets/Textures_v2/Travel new 2021/divider_travel_tooltip.png")
		separator.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
		selector_list.add_child(separator)
		
		for loc in lands_order:
#			if loc_filter == loc: continue
			if !ResourceScripts.game_world.areas.has(loc): continue
			if !ResourceScripts.game_world.areas[loc].unlocked: continue
			var tbutton = input_handler.DuplicateContainerTemplate(selector_list)
			tbutton.text = selector_meta_bindings[loc]
			tbutton.set_meta('value', loc)
			tbutton.connect('pressed', self, 'select_filter', [loc])
			if !lands_count.has(loc) or lands_count[loc] <= 0 or loc_filter == loc: 
				tbutton.disabled = true
		
#		var separator2 = TextureRect.new()
#		separator2.texture = load("res://assets/Textures_v2/Travel new 2021/divider_travel_tooltip.png")
#		separator2.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
#		selector_list.add_child(separator2)
#
#		for loc in locs_order:
#			if loc_filter == loc: continue
#			var tbutton = input_handler.DuplicateContainerTemplate(selector_list)
#			tbutton.text = selector_meta_bindings[loc]
#			tbutton.set_meta('value', loc)
#			tbutton.connect('pressed', self, 'select_filter', [loc])
#			if !locs_count.has(loc) or locs_count[loc] <= 0: 
#				tbutton.disabled = true
	else:
		var button = input_handler.DuplicateContainerTemplate(selector_list)
		button.text = selector_meta_bindings[loc_filter]
		button.mouse_filter = MOUSE_FILTER_IGNORE
	selector_list.update()
	selector.get_node("SelectorMain/SelectorPanel").rect_size.y = input_handler.get_actual_size_for_container(selector_list).y + 10


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
		if !cdata.has(id): continue #should add here currently nonexisted marking location link to delete
		var temp = {id = id, area = tdata.area, type = cdata[id].type, heroes = 0}
		if lands_count.has(temp.area): lands_count[temp.area] += 1
		else:  lands_count[temp.area] = 1
		if locs_count.has(temp.type): locs_count[temp.type] += 1
		else:  locs_count[temp.type] = 1
		if cdata[id].has('captured'): temp.captured = cdata[id].captured
		if cdata[id].has('background'): 
			temp.icon = cdata[id].background
		elif temp.type == 'capital' and adata.has('capital_background'): 
			temp.icon = adata.capital_background
		else:
			temp.icon = null
		temp_locations[id] = temp
	var temp = {id = 'travel', heroes = 0}
	
	for character in ResourceScripts.game_party.characters.values():
		if !character.is_active: continue
		var loc = character.get_location()
		if loc == "mansion":
			character.travel.location = ResourceScripts.game_world.mansion_location
		if loc == 'travel':
#			loc = character.travel.travel_target.location
			temp.heroes += 1
		elif !temp_locations.has(loc):
			print("warning - populated location %s not found or not avail" % loc)
			continue
		else:
			temp_locations[loc].heroes += 1
	
	sorted_locations = temp_locations.values().duplicate()
	sorted_locations.sort_custom(self, 'sort_locations')
	sorted_locations.push_back(temp)


func sort_locations(first, second):
	if lands_order.has(first.area):
		if lands_order.has(second.area):
			if lands_order.find(first.area) == lands_order.find(second.area):
				if locs_order.has(first.type):
					if locs_order.has(second.type):
						return locs_order.find(first.type) < locs_order.find(second.type)
			else: 
				return lands_order.find(first.area) < lands_order.find(second.area)
	return true


func update_lists():
	location_selected = null
	from_location_selected = null
	build_locations_list()
	update_from_list()
	update_to_list()
#	update_heroes_list()
	build_location_info()
	build_location_resources()
	update_confirm_button()

func update_confirm_button():
	if (location_selected != null):
		$area/to_panel/HBoxContainer/CenterContainer2/ConfirmButton.disabled = characters.size() == 0 || ((location_selected.has('captured') && location_selected.captured == true)) || location_selected.id == from_location_selected.id


func update_from_list():
	input_handler.ClearContainer(from_list)
#	from_location_selected = null
	var first_location = null
	for loc in sorted_locations:
		if loc.heroes <= 0:
			if from_location_selected != null and from_location_selected.id == loc.id: 
				from_location_selected = null 
			continue
		var panel = input_handler.DuplicateContainerTemplate(from_list)
		if first_location == null: 
			first_location = panel
		if from_location_selected != null and from_location_selected.id == loc.id:
			first_location = panel
		make_panel_for_location(panel, loc)
		panel.get_node("Label").text = str(loc.heroes)
		panel.connect("pressed", self, "select_from_location", [panel])
	if first_location != null:
		select_from_location(first_location)

func update_to_list():
	input_handler.ClearContainer(to_list)
	location_selected = null
	for loc in sorted_locations:
		if loc.id == 'travel': continue
		if loc_filter in lands_order and loc.area != loc_filter: continue
		if loc_filter in locs_order and loc.type != loc_filter : continue
		var panel = input_handler.DuplicateContainerTemplate(to_list)
		make_panel_for_location(panel, loc)
		
		#i'm not sure that heroes' number should be displayed here and not travel distance
		#upd. in reference picture there is neither heroes' number nor distance in this label so i'm confused
		if loc.heroes > 0:
			panel.get_node("Label").text = str(loc.heroes)
		else:
			panel.get_node("Label").text = ""
		
		panel.connect("pressed", self, "select_to_location", [panel])


func update_heroes_list():
	characters.clear()
	#there can be a bug if character_order and characters are handled separatedly during character adding or removal
	input_handler.ClearContainer(char_list)
	if from_location_selected == null: return
	#first pass
	for ch_id in ResourceScripts.game_party.character_order:
		var ch = characters_pool.get_char_by_id(ch_id)
		if ch.get_location() != from_location_selected.id: continue
#		if ch.get_location() != from_location_selected.id and ch.get_location() != 'travel': continue
#		if ch.get_location() == 'travel' and ch.travel.travel_target.location != from_location_selected.id: continue
		if (ch.xp_module.predict_obed_time() <= 0) && !ch.is_controllable():
			continue
		var panel = input_handler.DuplicateContainerTemplate(char_list)
		make_panel_for_character(panel, ch)
		panel.connect("pressed", self, "select_char", [panel])
	#second pass - disabled
	for ch_id in ResourceScripts.game_party.character_order:
		var ch = characters_pool.get_char_by_id(ch_id)
		if ch.get_location() != from_location_selected.id: continue
#		if ch.get_location() != from_location_selected.id and ch.get_location() != 'travel': continue
#		if ch.get_location() == 'travel' and ch.travel.travel_target.location != from_location_selected.id: continue
		if (ch.xp_module.predict_obed_time() <= 0) && !ch.is_controllable():
			var panel = input_handler.DuplicateContainerTemplate(char_list)
			make_panel_for_character(panel, ch)
			panel.connect("pressed", self, "select_char", [panel])


func update_heroes_list_travel():
	characters.clear()
	#there can be a bug if character_order and characters are handled separatedly during character adding or removal
	input_handler.ClearContainer(char_list)
	for ch_id in ResourceScripts.game_party.character_order:
		var ch = characters_pool.get_char_by_id(ch_id)
		if ch.get_location() != 'travel': continue
		var panel = input_handler.DuplicateContainerTemplate(char_list)
		make_panel_for_character(panel, ch)
		panel.toggle_mode = false
		panel.connect("pressed", self, "return_char", [panel])


func make_panel_for_location(panel, loc):
	if loc.id == 'travel':
		panel.text = "Characters on the road"
	else:
		var text = ResourceScripts.world_gen.get_location_from_code(loc.id).name
		if ResourceScripts.game_world.areas[loc.area].questlocations.has(loc.id):
			text = "Q:" + text
		panel.text = text
		if loc.has('captured'):
			if loc.captured:
				panel.set("custom_colors/font_color", variables.hexcolordict.red)
#				panel.disabled = true
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
		panel.get_node("Icon").texture = icon
	panel.set_meta('location', loc)


func make_panel_for_character(panel, ch):
	var newbutton = panel.get_node('HBoxContainer')
	newbutton.get_node("icon").texture = ch.get_icon()
	newbutton.get_node("name").text = ch.get_short_name()
	newbutton.get_node("stats/hp").max_value = ch.get_stat('hpmax')
	newbutton.get_node("stats/hp").value = ch.hp
	newbutton.get_node("stats/mp").max_value = ch.get_stat('mpmax')
	newbutton.get_node("stats/mp").value = ch.mp
	newbutton.get_node("stats").hint_tooltip = "HP: " + str(round(ch.hp)) + "/" + str(round(ch.get_stat('hpmax'))) + "\nMP: " + str(round(ch.mp)) + "/" + str(round(ch.get_stat('mpmax')))
	
	if !ch.xp_module.check_infinite_obedience():
		newbutton.get_node("obed").text = str(ceil(ch.xp_module.predict_obed_time()))
		if ch.xp_module.predict_obed_time() <= 0:
			newbutton.get_node("obed").set("custom_colors/font_color", Color(variables.hexcolordict.red))
		elif ch.xp_module.predict_obed_time() <= 24:
			newbutton.get_node("obed").set("custom_colors/font_color", Color(variables.hexcolordict.yellow))
		else:
			newbutton.get_node("obed").set("custom_colors/font_color", Color(variables.hexcolordict.green))
	else:
		newbutton.get_node("obed").text = "∞"
	
	var gatherable = Items.materiallist.has(ch.get_work())
	if ch.get_work() == '' || ch.get_work() == "Assignment":
		if ch.is_on_quest():
			var time_left = int(ch.get_quest_days_left())
			var time_left_string = ''
			if time_left == 1:
				time_left = 24 - ResourceScripts.game_globals.hour
				time_left_string = str(time_left) + " h."
			else:
				time_left_string = str(time_left) + " d."
			newbutton.get_node("job").text = "On quest - %s" % time_left_string
		else:
			newbutton.get_node("job").text = tr("TASKREST")
	elif ch.get_work() == 'travel':
		newbutton.get_node("job").text = "Travel - %s h." % ceil(ch.travel.travel_time/ch.travel_per_tick())
	else:
		if !gatherable:
			newbutton.get_node("job").text = races.tasklist[ch.get_work()].name
		else:
			newbutton.get_node("job").text = "Gathering " + Items.materiallist[ch.get_work()].name
	
	
#	if ch.travel.location == "travel":
#		panel.disabled = true
#	el
	if (ch.xp_module.predict_obed_time() <= 0) && !ch.is_controllable():
		panel.disabled = true
	
	panel.set_meta('slave', ch)


func select_from_location(button):
	for btn in from_list.get_children():
		btn.pressed = (btn == button)
	from_location_selected = button.get_meta("location")
	if from_location_selected.id == 'travel':
		update_heroes_list_travel()
	else:
		update_heroes_list()
#	update_to_list()
#	build_location_resources()
	build_location_info()
	if location_selected == null or location_selected.id == from_location_selected.id:
		$area/to_panel/HBoxContainer/CenterContainer2/ConfirmButton.disabled = true
	else:
		$area/to_panel/HBoxContainer/CenterContainer2/ConfirmButton.disabled = false
	update_confirm_button()


func select_to_location(button):
	for btn in to_list.get_children():
		btn.pressed = (btn == button)
	location_selected = button.get_meta("location")
	build_location_info()
	build_location_resources()
	if from_location_selected == null or location_selected.id == from_location_selected.id:
		$area/to_panel/HBoxContainer/CenterContainer2/ConfirmButton.disabled = true
	else:
		$area/to_panel/HBoxContainer/CenterContainer2/ConfirmButton.disabled = false
	update_confirm_button()


func select_char(button):
	var character = button.get_meta("slave")
	if button.pressed: 
		characters.push_back(character.id)
	else:
		characters.erase(character.id)
	build_location_info()
	update_confirm_button()

var returnperson

func return_char(button):
	var person = button.get_meta('slave')
	if person.travel.travel_target.location != 'mansion':
		return_confirm(person)
	else:
		input_handler.SystemMessage(person.translate("[name] is already heading back to Mansion."))


func return_confirm(person):
	returnperson = person
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'return_character', person.translate(tr('SENDCHARBACKTOMANSIONQUESTION'))])


func return_character():
	returnperson.return_to_mansion()
	update_lists()



func select_filter(value):
	loc_filter = value
	update_to_list()
	selector.get_node("SelectorMain").pressed = false
	build_sel_panel(false)


func build_location_info():
	var text = ""
	if from_location_selected != null:
		text += "Characters selected: %d\n\n" % characters.size()
	if location_selected != null: 
		text += "Target location: %s\n" % ResourceScripts.world_gen.get_location_from_code(location_selected.id).name
		text += "Type: %s\n" % selector_meta_bindings[location_selected.type].trim_suffix("s")
		info_text_icon.texture = images.backgrounds[location_selected.icon]
		if from_location_selected != null and from_location_selected.id != 'travel':
			var travel_time = globals.calculate_travel_time(from_location_selected.id, location_selected.id)
			if characters.size() > 0: 
				var tmp = characters_pool.get_char_by_id(characters[0]).travel_per_tick()
				text += "Travel time: %d\n" % ceil(travel_time.time / tmp)
				text += "Obedience cost: %d\n" % ceil(travel_time.obed_cost / tmp)
			else:
				text += "Estimated travel time: %d\n" % ceil(travel_time.time)
				text += "Estimated obedience cost: %d\n" % ceil(travel_time.obed_cost)
		if location_selected.has('captured') && location_selected.captured == true:
			text += globals.TextEncoder("{color=red|Location unaccessible}")
	else:
		info_text_icon.texture = null
	info_text_node.bbcode_text = text
	if location_selected!= null:
		forget_button.visible = (location_selected.type == 'dungeon') #cant find any other conditions in earlier version
	else:
		forget_button.visible = false


func build_location_resources():
	#can't find where placer_travel_question.png should be used
	#can't find if this should be built upon from_location or selected to_location
	if location_selected == null: 
		info_res_panel.hide()
		return
	var dungeon = false
	var hidden = false
	info_res_panel.show()
	var location = ResourceScripts.world_gen.get_location_from_code(location_selected.id)
	var gatherable_resources
	if location.type in ["capital", "quest_location"]:
		info_res_panel.hide()
		return
	elif location.type == "dungeon":
		dungeon = true
		if !location.completed:
			hidden = true
		gatherable_resources = location.gather_limit_resources
	else:
		if location.has('gather_resources'):
			gatherable_resources = location.gather_resources
	input_handler.ClearContainer(info_res_node)
	if gatherable_resources != null:
		for i in gatherable_resources:
			var item = Items.materiallist[i]
			var newbutton = input_handler.DuplicateContainerTemplate(info_res_node)
			newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
			newbutton.set_meta("exploration", true)
			if dungeon:
				if !hidden:
					newbutton.get_node("Label").text = str(gatherable_resources[i])
					newbutton.set_meta("gather_mod", round(location.gather_mod*100))
					globals.connectmaterialtooltip(newbutton, item)
				else:
					newbutton.get_node("TextureRect").texture = load("res://assets/Textures_v2/Travel new 2021/placer_travel_question.png")
			else:
				var max_workers_count = gatherable_resources[i]
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i) && (task.task_location == location_selected.id):
						current_workers_count = task.workers_count
				newbutton.get_node("Label").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
				newbutton.set_meta("max_workers", max_workers_count)
				newbutton.set_meta("current_workers", current_workers_count)
				globals.connectmaterialtooltip(newbutton, item)
	info_res_panel.get_node('Label').visible = gatherable_resources != null


func hide():
	gui_controller.current_screen = gui_controller.mansion
	if gui_controller.clock != null:
		gui_controller.clock.visible = true
#		gui_controller.clock.restoreoldspeed()
	if get_parent().mansion_state == 'travels':
		get_parent().mansion_state = 'default'
	.hide()


func confirm_travel():
	if location_selected.id == from_location_selected.id: return 
	var travel_cost = globals.calculate_travel_time(from_location_selected.id, location_selected.id)
	for chid in characters:
		var person = characters_pool.get_char_by_id(chid)
		person.remove_from_task()
		person.process_event(variables.TR_MOVE)
		if !person.is_controllable():
			person.add_stat('obedience', -ceil((travel_cost.obed_cost/person.travel_per_tick())))
		if ResourceScripts.game_progress.instant_travel == false:
			person.previous_location = person.travel.location
			person.xp_module.work = 'travel'
			person.travel.location = 'travel'
			person.travel.travel_target = {area = location_selected.area, location = location_selected.id}
			person.travel.travel_time = travel_cost.time
			person.travel.initial_travel_time = travel_cost.time
		else:
			person.xp_module.work = 'travel'
			person.travel.location = location_selected.id
			person.travel.area  = location_selected.area
	input_handler.PlaySound("ding")
	characters.clear()
	update_lists()


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
	globals.remove_location(location_selected.id)
	update_lists()
