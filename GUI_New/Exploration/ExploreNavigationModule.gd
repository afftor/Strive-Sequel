extends Panel

onready var Navigation = $NavigationContainer/AreaSelection
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MansionButton.connect("pressed", self, "return_to_mansion")


func build_accessible_locations():
	input_handler.ClearContainer(Navigation)

	var location_array = []
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if (!person.travel.location in ['mansion', 'travel'] && !location_array.has(person.travel.location)):
			location_array.append(person.travel.location)

	var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
	newbutton.text = "Aliron"
	newbutton.connect("pressed", self, "select_location", ['Aliron'])
	newbutton.set_meta("data", 'Aliron')

	for i in location_array:
		newbutton = input_handler.DuplicateContainerTemplate(Navigation)
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "select_location", [i])
		newbutton.set_meta("data", i)

	if get_parent().selected_location != null:
		for i in Navigation.get_children():
			if i.has_meta("data"):
				i.pressed = i.get_meta('data') == get_parent().selected_location


func select_location(location):
	get_parent().selected_location = location
	# for i in $NavigationPanel/NavigationContainer/AreaSelection.get_children():
	# 	if i.has_meta("data"):
	# 		i.pressed = i.get_meta('data') == location
	if location in ResourceScripts.game_world.capitals:
		get_parent().City.open_city(location)
	else:
		var data = ResourceScripts.world_gen.get_location_from_code(location)
		var presented_characters = []
		for id in ResourceScripts.game_party.character_order:
			var i = ResourceScripts.game_party.characters[id]
			if i.check_location(data.id, true):
				presented_characters.append(i)
		if presented_characters.size() == 0:
			select_location('Aliron')
		else:
			get_parent().open_location(data)

func return_to_mansion():
	GUIWorld.set_current_scene(GUIWorld.gui_data["MANSION"].main_module)
	GUIWorld.gui_data["MANSION"].main_module.mansion_state_set("default")
