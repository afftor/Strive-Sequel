extends Panel


func _ready():
	input_handler.connect('update_ragdoll', self, 'build_gear_panel')
	for i in $InventorySlots.get_children():
		i.connect("pressed", self, 'unequip', [i.name])
		i.connect("mouse_entered", self, 'show_equip_tooltip', [i.name])
		i.hint_tooltip = tr("ITEMSLOT" + i.name.to_upper())


func build_gear_panel():
	var selectedhero = input_handler.interacted_character
	if selectedhero != null:
		var stored_image = selectedhero.get_stored_body_image()
		if stored_image != null:
			$BodyImage.texture = stored_image
			$BodyImage.visible = true
			$ragdoll.visible = false
		elif !input_handler.globalsettings.disable_paperdoll:
			$BodyImage.visible = false
			$ragdoll.visible = true
			$ragdoll.test_mode = false
			$ragdoll.rebuild(selectedhero)
			$ragdoll.rebuild_cloth(true)
		else:
			$BodyImage.texture = selectedhero.get_body_image()
			$BodyImage.visible = true
			$ragdoll.visible = false
#		$BodyImage.texture = selectedhero.get_body_image()
		for i in selectedhero.equipment.gear:
			$InventorySlots.get_node(i + "/qualitycolor").hide()
			$InventorySlots.get_node(i + "/icon2").visible = selectedhero.equipment.gear[i] == null
			if selectedhero.equipment.gear[i] == null:
				$InventorySlots.get_node(i + "/icon").texture = null
				$InventorySlots.get_node(i).material = null
			else:
				var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[i]]
				item.set_icon($InventorySlots.get_node(i + "/icon"))
				
				$InventorySlots.get_node(i + "/qualitycolor").visible = item.quality != ""
				
				if item.quality != "":
					$InventorySlots.get_node(i + "/qualitycolor").texture = variables.quality_colors[item.quality]

var tempslot

func unequip(slot):
	var selectedhero = input_handler.interacted_character
	tempslot = slot
	if selectedhero.equipment.gear[slot] != null:
		var item = ResourceScripts.game_res.items[selectedhero.equipment.gear[slot]]
		if item.curse != null:
			input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'unequip_confirm', tr("CURSEUNEQUIPCONFIRM")])
		else:
			unequip_confirm()

func unequip_confirm():
	var slot = tempslot
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


func show_buffs():
	var person = gui_controller.mansion.active_person
	globals.build_buffs_for_char(person, $buffscontainer, 'mansion')
