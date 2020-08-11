extends HBoxContainer


var mainnode
	

func update():
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false, false)
	var selected_location = GUIWorld.gui_data.EXPLORATION.main_module.selected_location
	var location = ResourceScripts.world_gen.get_location_from_code(selected_location)
	var gatherable_resources
	if location.type == "dungeon":
		# if location.completed == true:
		gatherable_resources = location.gather_limit_resources
	else:
		gatherable_resources = location.gather_resources
	input_handler.ClearContainer(self)
	for i in gatherable_resources:
		var item = Items.materiallist[i]
		var newbutton = input_handler.DuplicateContainerTemplate(self)
		newbutton.get_node("TextureRect").texture = Items.materiallist[i].icon
		newbutton.get_node("Label").text = str(gatherable_resources[i])
		globals.connectmaterialtooltip(newbutton, item)
