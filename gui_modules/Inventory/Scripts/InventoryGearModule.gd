extends Panel


func _ready():
	for i in $InventorySlots.get_children():
		i.connect("pressed", self, 'unequip', [i.name])
		i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
		i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())
	for i in $TattooSlots.get_children():
		i.connect("pressed", self, 'add_remove_tattoo', [i.name])
		i.connect("mouse_entered", self, 'show_tattoo_tooltip', [i.name])
		i.set_meta("tattoo_slot", i.name)
		i.hint_tooltip = tr("TATTOO" + i.name.to_upper())



var selected_slot: String
var tattoo_action = "add_tattoo"
var avalible_slots = []
var selected_tattoo = ""

func add_remove_tattoo(slot: String):
	var selectedhero = input_handler.interacted_character
	selected_tattoo = get_parent().get_node("InventoryListModule").selected_tattoo
	selected_slot = slot
	if selectedhero.statlist.tattoo[slot] == null && selected_tattoo == "":
		for i in $TattooSlots.get_children():
			i.pressed = false
		return

	if selectedhero.statlist.tattoo[slot] == selected_tattoo:
		input_handler.SystemMessage(tr("SAMETATTOO"))
		$TattooSlots.get_node(slot).pressed = true
		return

	if !slot in avalible_slots:
		$TattooSlots.get_node(slot).pressed = false
		return

	update_tattoo_slots(slot)
	if selectedhero.statlist.tattoo[slot] != null:
		if selected_tattoo == "":
			tattoo_action = "remove_tattoo"
			input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_remove_tattoo_action', tr("REMOVETATTOO")])
		else:
			tattoo_action = "replace_tattoo"
			input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_remove_tattoo_action', tr("REPLACETATTOO")])
	else:
		tattoo_action = "add_tattoo"
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'add_remove_tattoo_action', tr("ADDTATTOO")])
	selected_tattoo = ""


func add_remove_tattoo_action():
	var selectedhero = input_handler.interacted_character
	var selected_tattoo = get_parent().get_node("InventoryListModule").selected_tattoo
	match tattoo_action:
		"add_tattoo":
			if selectedhero.add_tattoo(selected_slot, selected_tattoo):
				ResourceScripts.game_res.materials[selected_tattoo] -= 1
			else:
				input_handler.SystemMessage(tr("INVALIDREQS"))
		"remove_tattoo":
			selectedhero.remove_tattoo(selected_slot)
		"replace_tattoo":
			if !selectedhero.can_add_tattoo(selected_slot, selected_tattoo):
				input_handler.SystemMessage(tr("INVALIDREQS"))
			else:
				selectedhero.remove_tattoo(selected_slot)
				selectedhero.add_tattoo(selected_slot, selected_tattoo)
				ResourceScripts.game_res.materials[selected_tattoo] -= 1
	
	for i in $TattooSlots.get_children():
		if !i.get_global_rect().has_point(get_global_mouse_position()):
			i.pressed = false
	get_parent().get_node("InventoryListModule").selected_tattoo = ''
	get_parent().set_active_hero(selectedhero)



func show_tattoos():
	var selectedhero = input_handler.interacted_character
	for slot in selectedhero.statlist.tattoo:
		if selectedhero.statlist.tattoo[slot] == null:
			$TattooSlots.get_node(slot + "/icon").texture = null
		else:
			var t_icon
			for t in Traitdata.tattoodata:
				var tattoo = Traitdata.tattoodata[t]
				if t == selectedhero.statlist.tattoo[slot]:
					t_icon = Traitdata.tattoodata[t].icon
					break
			$TattooSlots.get_node(slot + "/icon").texture = t_icon


func update_tattoo_slots(slot: String = ''):
	for s in $TattooSlots.get_children():
		if !s.has_meta("tattoo_slot"):
			continue
		s.pressed = s.get_meta("tattoo_slot") == slot


func highlight_avalible_slots(slots: Array):
	avalible_slots = slots
	for s in $TattooSlots.get_children():
		if !s.has_meta("tattoo_slot"):
			continue
		s.pressed = slots.has(s.get_meta("tattoo_slot"))
		s.disabled = !slots.has(s.get_meta("tattoo_slot"))
		



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
	if selectedhero.equipment.gear[slot] != null:
		var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
		selectedhero.unequip(item)
		var itemtooltip = get_tree().get_root().get_node_or_null("itemtooltip_v2")
		if itemtooltip != null && itemtooltip.is_visible():
			itemtooltip.hide()
	get_parent().set_active_hero(selectedhero)


func show_equip_tooltip(slot):
	var selectedhero = input_handler.interacted_character
	if selectedhero.equipment.gear[slot] == null:
		return
	else:
		var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
		item.tooltip_v2($InventorySlots.get_node(slot))


func show_tattoo_tooltip(slot):
	var selectedhero = input_handler.interacted_character
	if selectedhero.statlist.tattoo[slot] == null:
		return
	else:
		var tattoo = Traitdata.tattoodata[selectedhero.statlist.tattoo[slot]]
		var desc
		for key in tattoo.descripts:
			if key.has(slot):
				desc = tattoo.descripts[key]
				break
		globals.showtexttooltip($TattooSlots.get_node(slot), tr(desc), false)


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

