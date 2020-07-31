extends Panel

onready var Navigation = $NavigationContainer/AreaSelection
onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MansionButton.connect("pressed", self, "return_to_mansion")


func update_buttons():
	for button in Navigation.get_children():
		if button.name == "Button":
			continue
		button.pressed = get_parent().selected_location == button.get_meta("data")

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
	input_handler.ClearContainer(Navigation)
	var location_array = ["Aliron"]
	var travelers = []
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		var person_location = person.get_location()
		if person_location == "mansion":
			person_location = "Aliron"
		if (!location_array.has(person_location)):
			location_array.append(person_location)

	# var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
	# newbutton.text = "Aliron"
	# newbutton.connect("pressed", self, "select_location", ['Aliron'])
	# newbutton.set_meta("data", 'Aliron')
	var sorted_locations = sort_locations(location_array)
	for i in sorted_locations:
		var newbutton = input_handler.DuplicateContainerTemplate(Navigation)
		newbutton.text = ResourceScripts.world_gen.get_location_from_code(i).name
		newbutton.connect("pressed", self, "select_location", [i])
		newbutton.set_meta("data", i)

	if get_parent().selected_location != null:
		for i in Navigation.get_children():
			if i.has_meta("data"):
				i.pressed = i.get_meta('data') == get_parent().selected_location
	update_buttons()

func select_location(location):
	# get_parent().selected_location = location
	# for i in $NavigationPanel/NavigationContainer/AreaSelection.get_children():
	# 	if i.has_meta("data"):
	# 		i.pressed = i.get_meta('data') == location
	if GUIWorld.BaseScene == get_parent():
		ResourceScripts.core_animations.BlackScreenTransition(0.7)
		yield(get_tree().create_timer(0.7), "timeout")
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
			# if GUIWorld.BaseScene == get_parent():
			# 	ResourceScripts.core_animations.BlackScreenTransition(0.7)
			# 	yield(get_tree().create_timer(0.7), "timeout")
			select_location('Aliron')
		else:
			get_parent().open_location(data)
	update_buttons()
	GUIWorld.BaseScene = get_parent()
	get_parent().show()

func return_to_mansion():
	GUIWorld.PreviousScene = null
	get_parent().selected_location = null
	input_handler.PlaySound("door_open")
	input_handler.StopBackgroundSound()
	input_handler.SetMusicRandom("mansion")
	ResourceScripts.core_animations.BlackScreenTransition()
	get_parent().get_node("GuildBG").hide()
#	get_parent().City.enter_guild(get_parent().active_faction)
	# get_parent().City.get_node("GuildMenuBG").hide()
	get_parent().active_faction = null
	get_parent().active_location = null
	yield(get_tree().create_timer(0.5), 'timeout')
	GUIWorld.set_current_scene(GUIWorld.gui_data["MANSION"].main_module)
	GUIWorld.BaseScene = GUIWorld.gui_data["MANSION"].main_module
	GUIWorld.gui_data["MANSION"].main_module.mansion_state_set("default")
