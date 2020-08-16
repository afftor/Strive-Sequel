extends Panel


var location_index = 0
var area_list = []
const SWIPE_OFFSET = 1

onready var Column1 = $LocationLists/Column1/ScrollContainer/VBoxContainer
onready var Column2 = $LocationLists/Column2/ScrollContainer/VBoxContainer
onready var Column3 = $LocationLists/Column3/ScrollContainer/VBoxContainer

func _ready():
	var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false, false)
	GUIWorld.add_close_button(self)
	$SwipeLeft.connect("pressed", self, "swipe", ["left"])
	$SwipeRight.connect("pressed", self, "swipe", ["right"])
	globals.connect("hour_tick", self, "open")


func swipe(side):
	if side == "left":
		if location_index == 0:
			location_index = lands_order.size() - 1
		else:
			location_index -= SWIPE_OFFSET
	if side == "right":
		if location_index == lands_order.size() - 1:
			location_index = 0
		else:
			location_index += SWIPE_OFFSET
	open()

func build_area_list():
	area_list.clear()
	for area in ResourceScripts.game_world.areas.values():
		if area.unlocked:
			area_list.append(area)
			area_list.sort_custom(self, 'sort_lands')


var lands_order = ['plains','forests','mountains','steppe','seas']		


func sort_lands(first, second):
	if lands_order.has(first.code):
		if lands_order.has(second.code):
			return  lands_order.find(first.code) < lands_order.find(second.code)
		else:
			return true


func open():
	build_area_list()
	$col1.text = lands_order[location_index].capitalize()
	$col2.text = lands_order[location_index + 1].capitalize()
	if area_list.size() >= 3:
		$col3.text = lands_order[location_index + 2].capitalize()
	var index = location_index
	for container in [Column1, Column2, Column3]:
		input_handler.ClearContainer(container)
		if !(area_list.size() >= 3):
			if area_list.size() == index:
				return
		build_location_list(area_list[index], container)
		if index == lands_order.size() - 1:
			index = 0
		else:
			index += 1
	$SwipeLeft.visible = area_list.size() > 3
	$SwipeRight.visible = area_list.size() > 3



func build_location_list(area, container):
	if area.code != 'plains' && ResourceScripts.game_world.areas[area.code].has("capital_name"):
		var capital =  ResourceScripts.game_world.areas[area.code].capital_name
		var newbutton = input_handler.DuplicateContainerTemplate(container)
		var text = tr(ResourceScripts.game_world.areas[area.code].capital_name)
		newbutton.text = text
		newbutton.get_node("Label").text = str(calculate_location_characters(capital, newbutton))
		newbutton.connect('pressed', self, 'select_location', [newbutton])
		newbutton.name = ResourceScripts.game_world.areas[area.code].capital_name
		newbutton.set_meta("code", ResourceScripts.game_world.areas[area.code].capital_name)
	if container == Column1:
		#if !get_parent().SlaveListModule.selected_location in ["show_all", "Aliron", "mansion"]:
		var newbutton = input_handler.DuplicateContainerTemplate(Column1)
		var text = tr("MANSION")
		newbutton.text = text
		newbutton.get_node("Label").text = str(calculate_location_characters("Aliron", newbutton))
		newbutton.set_meta("code", "Aliron")
		newbutton.connect('pressed', self, 'select_location', [newbutton])
	for location in ResourceScripts.game_world.areas[area.code].locations.values() + ResourceScripts.game_world.areas[area.code].questlocations.values():
		var newbutton = input_handler.DuplicateContainerTemplate(container)
		newbutton.set_meta("location", location)
		var text = ResourceScripts.world_gen.get_location_from_code(location.id).name
		if ResourceScripts.game_world.areas[area.code].questlocations.has(location.id):
			text = "Q:" + text
		newbutton.text = text
		newbutton.get_node("Label").text = str(calculate_location_characters(location.id, newbutton))
		newbutton.connect("pressed", self, "select_location", [newbutton])


func calculate_location_characters(location, button):
	var characters_count = 0
	for character in ResourceScripts.game_party.characters.values():
		if character.get_location() == "mansion":
			character.travel.location = "Aliron"
		if character.get_location() == location:
			characters_count += 1
	if characters_count == 0:
		characters_count = ""
	return characters_count


func select_location(button):
	var columns = Column1.get_children() + Column2.get_children() + Column3.get_children()
	for btn in columns:
		btn.pressed = (btn == button)

	var selected_location_label = get_parent().TravelsModule.get_node("SelectedLocation/Label")
	var button_meta
	var location_id
	if button.has_meta("location"):
		button_meta = button.get_meta("location")
		selected_location_label.text = button_meta.name
		location_id = button_meta.id
	elif button.has_meta("code"):
		button_meta = button.get_meta("code")
		selected_location_label.text = button_meta
		location_id = button_meta
	get_parent().TravelsModule.select_destination(location_id)
	# self.hide()
	# get_parent().TravelsModule.get_node("LocationListButton").pressed = false

