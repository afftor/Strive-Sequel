extends "res://src/scenes/ClosingPanel.gd"


onready var info_text_node = $MarginContainer/area/info_panel/MarginContainer/info_text
onready var info_res_panel = $MarginContainer/area/info_panel/resources
onready var info_res_node = $MarginContainer/area/info_panel/resources/CenterContainer/GridContainer
onready var from_list = $MarginContainer/area/from_panel/MarginContainer/ScrollContainer/VBoxContainer


var location_selected = null setget location_select
var characters = []
var sorted_locations = []
var lands_order = ['plains','forests','mountains','steppe','seas']
var locs_order = ['capital', 'settlement', 'quest_location', 'dungeon', 'encounter']

func _ready():
	pass # Replace with function body.


func location_select(value):
	if location_selected == value: return
	location_selected = value
	build_location_info()
	build_location_resources()


func build_locations_list():
	sorted_locations.clear()
	var temp_locations = {}
	for id in ResourceScripts.game_world.location_links:
		var tdata = ResourceScripts.game_world.location_links[id]
		var adata = ResourceScripts.game_world.areas[tdata.area]
		if !adata.unlocked: continue
		var cdata = adata[tdata.category]
		if !cdata.has(id): continue #should add here currently nonexisted marking location link to delete
		var temp = {id = id, area = tdata.area, type = cdata[id].type, heroes = 0}
		if cdata[id].has('captured'): temp.captured = cdata[id].captured
		temp_locations[id] = temp
	
	for character in ResourceScripts.game_party.characters.values():
		if !character.is_active: continue
		if character.get_location() == "mansion":
			character.travel.location = ResourceScripts.game_world.mansion_location
		if !temp_locations.has(character.get_location()):
			print("warning - populated location %s not found or not avail" % character.get_location())
			continue
		temp_locations[character.get_location()].heroes += 1
	
	sorted_locations = temp_locations.values().duplicate()
	sorted_locations.sort_custom(self, 'sort_locations')


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
	location_select(null)
	build_locations_list()


func update_from_list():
	input_handler.ClearContainer(from_list)
	for loc in sorted_locations:
		if loc.heroes <= 0: continue
		var panel = input_handler.DuplicateContainerTemplate(from_list)
		make_panel_for_location(panel, loc)
		panel.get_node("Label").text = str(loc.heroes)
		panel.connect("pressed", self, "select_from_location", [panel])


func make_panel_for_location(panel, loc):
	var text = ResourceScripts.world_gen.get_location_from_code(loc.id).name
	if ResourceScripts.game_world.areas[loc.area].questlocations.has(loc.id):
		text = "Q:" + text
	panel.text = text
	if loc.has('captured'):
		if loc.captured:
			panel.set("custom_colors/font_color_disabled", variables.hexcolordict.red)
			panel.disabled = true
			globals.connecttexttooltip(panel, "Location unavailable")
			globals.return_characters_from_location(loc.id)
	var icon
	match loc.type: #are there only icons 
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

func build_location_info():
	if location_selected == null: 
		info_text_node.text = ""
		return
	var text = ""
	#2make
	info_text_node.text = text


func build_location_resources():
	if location_selected == null: 
		info_res_panel.hide()
		return
	var dungeon = false
	info_res_panel.show()
	var location = ResourceScripts.world_gen.get_location_from_code(location_selected)
	var gatherable_resources
	if location.type in ["capital", "quest_location"]:
		info_res_panel.hide()
		return
	elif location.type == "dungeon":
		dungeon = true
		if location.completed:
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
			if dungeon:
				newbutton.get_node("Label").text = str(gatherable_resources[i])
				newbutton.set_meta("gather_mod", round(location.gather_mod*100))
			else:
				var max_workers_count = gatherable_resources[i]
				var current_workers_count = 0
				var active_tasks = ResourceScripts.game_party.active_tasks
				for task in active_tasks:
					if (task.code == i) && (task.task_location == location_selected):
						current_workers_count = task.workers_count
				newbutton.get_node("Label").text = str(max_workers_count - current_workers_count) + "/" + str(max_workers_count)
				newbutton.set_meta("max_workers", max_workers_count)
				newbutton.set_meta("current_workers", current_workers_count)
			globals.connectmaterialtooltip(newbutton, item)
	info_res_panel.get_node('Label').visible = gatherable_resources != null
