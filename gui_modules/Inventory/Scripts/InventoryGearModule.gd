extends Panel

#onready var GUIWorld = input_handler.get_spec_node(input_handler.NODE_GUI_WORLD, null, false)


func _ready():
	for i in get_children():
		if i.get_class() == "Light2D":
			continue
		if !i.name in ['BodyImage', 'buffscontainer']:
			i.connect("pressed", self, 'unequip', [i.name])
			i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
			i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())


func build_gear_panel():
	var selectedhero = input_handler.interacted_character
	if selectedhero != null:
		$BodyImage.texture = selectedhero.get_body_image()
		for i in selectedhero.equipment.gear:
			if selectedhero.equipment.gear[i] == null:
				get_node(i + "/icon").texture = null
			else:
				var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[i]]
				item.set_icon(get_node(i + "/icon"))



func unequip(slot):
	var selectedhero = input_handler.interacted_character
	# if !selectedhero.check_location('Aliron', true):
	# 	input_handler.SystemMessage("Can't use or equip items while away from Mansion.")
	# 	return
	if selectedhero.equipment.gear[slot] != null:
		selectedhero.unequip(ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]])
	get_parent().set_active_hero(selectedhero)


func show_equip_tooltip(slot):
	var selectedhero = input_handler.interacted_character
	if selectedhero.equipment.gear[slot] == null:
		return
	else:
		var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
		item.tooltip(get_node(slot))


func show_buffs():
	var person = gui_controller.mansion.active_person
	input_handler.ClearContainer($buffscontainer)
	for i in person.get_mansion_buffs():
		var newnode = input_handler.DuplicateContainerTemplate($buffscontainer)
		newnode.texture = i.icon
		var tmp = i.get_duration()
		if tmp != null:
			newnode.get_node("Label").text = str(tmp.count)
			match tmp.event:
				'hours':
					newnode.get_node("Label").set("custom_colors/font_color",Color(0,0,1))
				'turns':
					newnode.get_node("Label").set("custom_colors/font_color",Color(0,1,0))
				'hits':
					newnode.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
				'attacks':
					newnode.get_node("Label").set("custom_colors/font_color",Color(1,0,0))
		else:
			newnode.get_node("Label").hide()
		newnode.hint_tooltip = person.translate(i.description)

