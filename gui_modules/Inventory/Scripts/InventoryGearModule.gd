extends Panel


func _ready():
	for i in $InventorySlots.get_children():
		i.connect("pressed", self, 'unequip', [i.name])
		i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
		i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())
	for i in $TattooSlots.get_children():
		i.connect("pressed", self, 'select_tattoo', [i.name])
		# i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
		# i.hint_tooltip = tr(i.name.to_upper())
		i.set_meta("tattoo_slot", i.name)



#TODO Adopt confirmation panel
func select_tattoo(slot):
	update_tattoo_slots(slot)
	var selectedhero = input_handler.interacted_character
	if selectedhero.statlist.tattoo[slot] != null:
		selectedhero.remove_tattoo(slot)
	get_parent().set_active_hero(selectedhero)


#TODO REmove dummy data
var tattoo_dummy_data = {
	tattoo1 = {
		code = 'makeup',
		name = 'tattoo1',
		descript = '',
		icon = load("res://assets/images/iconsitems/item_bread.png"),
		price = 2,
		type = 'tattoo',
		tags = ['tattoo'],
	},
	tattoo2 = {
		code = 'tattoo2',
		ink = "ink2",
		name = "Super Tatto 2",
		icon = load("res://assets/images/iconsitems/item_bread.png"),
	},
	tattoo3 = {
		code = 'tattoo3',
		ink = "ink3",
		name = "Super Tatto 3",
		icon = load("res://assets/images/iconsitems/item_bread.png"),
	},
	tattoo4 = {
		code = 'tattoo4',
		ink = "ink4",
		name = "Super Tatto 4",
		icon = load("res://assets/images/iconsitems/item_bread.png"),
	},
}	


func show_tattoos():
	var selectedhero = input_handler.interacted_character
	for slot in selectedhero.statlist.tattoo:
		if selectedhero.statlist.tattoo[slot] == null:
			$TattooSlots.get_node(slot + "/icon").texture = null
		else:
			var t_icon
			for t in tattoo_dummy_data.values():
				if t.code == selectedhero.statlist.tattoo[slot]:
					t_icon = t.icon
					break
			var tattoo = selectedhero.statlist.tattoo[slot]
			$TattooSlots.get_node(slot + "/icon").texture = t_icon


func update_tattoo_slots(slot):
	for s in $TattooSlots.get_children():
		if !s.has_meta("tattoo_slot"):
			continue
		s.pressed = s.get_meta("tattoo_slot") == slot

	

func build_gear_panel():
	var selectedhero = input_handler.interacted_character
	if selectedhero != null:
		$BodyImage.texture = selectedhero.get_body_image()
		for i in selectedhero.equipment.gear:
			if selectedhero.equipment.gear[i] == null:
				$InventorySlots.get_node(i + "/icon").texture = null
			else:
				var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[i]]
				item.set_icon($InventorySlots.get_node(i + "/icon"))



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

