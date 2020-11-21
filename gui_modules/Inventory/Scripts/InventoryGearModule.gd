extends Panel


func _ready():
	for i in $InventorySlots.get_children():
		i.connect("pressed", self, 'unequip', [i.name])
		i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
		i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())
	for i in $TattooSlots.get_children():
		i.connect("pressed", self, 'add_remove_tattoo', [i.name])
		# i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
		# i.hint_tooltip = tr(i.name.to_upper())
		i.set_meta("tattoo_slot", i.name)



var selected_slot: String
var tattoo_action = "add_tattoo"

func add_remove_tattoo(slot: String):
	update_tattoo_slots(slot)
	selected_slot = slot
	var selectedhero = input_handler.interacted_character
	if selectedhero.statlist.tattoo[slot] != null:
		tattoo_action = "remove_tattoo"
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_remove_tattoo_action', tr("REMOVETATTOO")])
	else:
		tattoo_action = "add_tattoo"
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_remove_tattoo_action', tr("ADDTATTOO")])


func add_remove_tattoo_action():
	var selectedhero = input_handler.interacted_character
	var selected_tattoo = get_parent().get_node("InventoryListModule").selected_tattoo
	match tattoo_action:
		"add_tattoo":
			selectedhero.add_tattoo(selected_slot, selected_tattoo)
			ResourceScripts.game_res.materials[selected_tattoo] -= 1
		"remove_tattoo":
			selectedhero.remove_tattoo(selected_slot)
	update_tattoo_slots("deselect_all")
	get_parent().set_active_hero(selectedhero)



func show_tattoos():
	var selectedhero = input_handler.interacted_character
	for slot in selectedhero.statlist.tattoo:
		if selectedhero.statlist.tattoo[slot] == null:
			$TattooSlots.get_node(slot + "/icon").texture = null
		else:
			var t_icon
			for t in ResourceScripts.game_res.materials:
				var tattoo = Items.materiallist[t]
				if tattoo.code == selectedhero.statlist.tattoo[slot]:
					t_icon = tattoo.icon
					break
			# var tattoo = selectedhero.statlist.tattoo[slot]
			$TattooSlots.get_node(slot + "/icon").texture = t_icon


func update_tattoo_slots(slot: String):
	for s in $TattooSlots.get_children():
		if !s.has_meta("tattoo_slot"):
			continue
		s.pressed = s.get_meta("tattoo_slot") == slot


func highlight_avalible_slots(slots: Array):
	for s in $TattooSlots.get_children():
		s.pressed = false
		if !s.has_meta("tattoo_slot"):
			continue
		s.pressed = s.get_meta("tattoo_slot") in slots



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

