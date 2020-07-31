extends Panel

onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)


func _ready():
	for i in get_children():
		if !i.name in ['BodyImage', 'buffscontainer']:
			i.connect("pressed", self, 'unequip', [i.name])
			i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
			i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())


func build_gear_panel():
	var selectedhero = get_parent().selectedhero
	if selectedhero != null:
		$BodyImage.texture = selectedhero.get_body_image()
		for i in selectedhero.equipment.gear:
			if selectedhero.equipment.gear[i] == null:
				get_node(i + "/icon").texture = null
			else:
				var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[i]]
				item.set_icon(get_node(i + "/icon"))



func unequip(slot):
	var selectedhero = GUIWorld.gui_data["MANSION"].main_module.active_person
	# if !selectedhero.check_location('Aliron', true):
	# 	input_handler.SystemMessage("Can't use or equip items while away from Mansion.")
	# 	return
	if selectedhero.equipment.gear[slot] != null:
		selectedhero.unequip(ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]])
	get_parent().set_active_hero(selectedhero)


func show_equip_tooltip(slot):
	var selectedhero = GUIWorld.gui_data["MANSION"].main_module.active_person
	if selectedhero.equipment.gear[slot] == null:
		return
	else:
		var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
		item.tooltip(get_node(slot))


func show_buffs():
	var person = GUIWorld.gui_data["MANSION"].main_module.active_person
	input_handler.ClearContainer($buffscontainer)
	for i in person.get_mansion_buffs():
		var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
		newnode.texture = i.icon
		if i.get_duration() != null and i.get_duration() >= 0:
			newnode.get_node("Label").text = str(i.get_duration())
		else:
			newnode.get_node("Label").hide()
		newnode.hint_tooltip = person.translate(i.description)

