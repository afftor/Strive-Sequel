extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Navigation = $NavigationContainer/AreaSelection
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

func _ready():
	pass # Replace with function body.


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
		if (!person.travel.location in ['mansion', 'travel'] && !location_array.has(person.travel.location)):
			location_array.append(person.travel.location)

	# var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
	# newbutton.text = "Aliron"
	# newbutton.connect("pressed", self, "go_outside", ['Aliron'])
	# newbutton.set_meta("data", 'Aliron')
	var newbutton
	for i in location_array:
		newbutton = input_handler.DuplicateContainerTemplate(Navigation)
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "go_outside", [i])
		newbutton.set_meta("data", i)


func go_outside(location):
	GUIWorld.set_current_scene(GUIWorld.gui_data["EXPLORATION"].main_module)
	GUIWorld.gui_data["EXPLORATION"].main_module.open()
