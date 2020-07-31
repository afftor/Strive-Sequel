extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Navigation = $NavigationContainer/AreaSelection
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

func _ready():
	highlight()


func sort_locations(locations_array):
	var capitals = []
	var settlements = []
	var dungeons = []
	for loca in locations_array:
		if loca == "mansion": continue
		match ResourceScripts.world_gen.get_location_from_code(loca).type:
			"capital":
				capitals.append(loca)			
			"settlement":
				settlements.append(loca)	
			"dungeon":
				dungeons.append(loca)
	return capitals + settlements + dungeons	


func build_accessible_locations():
	# var locations = []
	# for loca in worlddata.lands:
	# 	if worlddata.lands[loca].keys().has("capital_name"):
	# 		locations.append(loca)
	input_handler.ClearContainer(Navigation)

	var location_array = []
	var travelers = []
	### !!!Has to be different reqs for showing locations!!! ###
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if (!person.travel.location in ['Aliron', 'travel'] && !location_array.has(person.travel.location)):
			location_array.append(person.travel.location)

	var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
	newbutton.text = "Mansion"
	newbutton.connect("pressed", self, "highlight")
	newbutton = input_handler.DuplicateContainerTemplate(Navigation)
	newbutton.text = ResourceScripts.game_world.mansion_location
	newbutton.connect("pressed", self, "go_outside", ['Aliron'])
	newbutton.set_meta("data", 'Aliron')
	newbutton.pressed = false
	var sorted_locations = sort_locations(location_array)
	for i in sorted_locations:
		if i == "mansion": continue
		newbutton = input_handler.DuplicateContainerTemplate(Navigation)
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "go_outside", [i])
		newbutton.set_meta("data", i)
		newbutton.pressed = false


func go_outside(location):
	GUIWorld.PreviousScene = get_parent()
	get_parent().selected_location = location
	input_handler.PlaySound("door_open")
	ResourceScripts.core_animations.BlackScreenTransition(1)
	yield(get_tree().create_timer(1), 'timeout')
	GUIWorld.set_current_scene(GUIWorld.gui_data["EXPLORATION"].main_module)
	GUIWorld.gui_data["EXPLORATION"].main_module.open()


func highlight():
	for i in Navigation.get_children():
		i.pressed = false

	Navigation.get_child(0).pressed = true
