extends Panel
#The beauty parlor's chair, opened from the room's card: the tattoo bench, and - once the room
#has its Body modifications improvement - the door to the creation screen with its filters
#lifted. Registered as an open window the way SexSelectMenu is: ESC and the close button both
#end at hide(), and _custom_gui_controller_close keeps gui_controller.close_scene() from putting
#the mansion back to its default state underneath. What the old inventory tab spread over three
#sibling nodes and input_handler.interacted_character is kept here, in one place.

const MansionLayout = preload("res://src/core/mansion_layout.gd")

#the eight places on a body, bare; the character keeps them prefixed 'tattoo_'
const SLOT_ORDER = ['face', 'neck', 'arms', 'legs', 'chest', 'crotch', 'waist', 'ass']

var mode = 'tattoo' #'tattoo' | 'bodymod'
var selected_person = null
#an Items.materiallist code, which is also the Traitdata.tattoodata key; '' when no pot is picked
var selected_ink = ''
#{slot = 'tattoo_x', action = 'add' | 'replace' | 'remove'} while the yes/no question is up
var pending = {}
#the creation panel while it is open for us
var editor = null

onready var character_list = $Characters/Scroll/List
onready var ink_grid = $Inks/Scroll/Grid
onready var preview = $Preview


func _ready():
	gui_controller.add_close_button(self)
	$Title.text = tr("BEAUTYPARLOR_TITLE")
	$Characters/Header.text = tr("BEAUTYPARLOR_CHARACTERS")
	$Inks/Header.text = tr("BEAUTYPARLOR_INKS")
	$Inks/Hint.text = tr("BEAUTYPARLOR_HINT")
	$ModifyButton.text = tr("BEAUTYPARLOR_MODIFY")
	$ModifyButton.connect("pressed", self, "_on_modify_pressed")
	for slot in SLOT_ORDER:
		$Slots.get_node(slot).connect("pressed", self, "_on_slot_pressed", [slot])
	#the booth lands a portrait a couple of frames after it is asked for
	input_handler.connect("PortraitUpdate", self, "_refresh_row_icons")


#### the window ####

func open(new_mode = 'tattoo'):
	if new_mode == 'bodymod' and !body_mod_available():
		new_mode = 'tattoo'
	mode = new_mode
	pending = {}
	#whoever sat here last may have left on a quest, or the party, since
	if selected_person != null and (!ResourceScripts.game_party.characters.has(selected_person.id) \
			or _block_reason(selected_person) != ''):
		selected_person = null
	if selected_ink != '' and int(ResourceScripts.game_res.materials.get(selected_ink, 0)) <= 0:
		selected_ink = ''
	#shown before it is filled: the doll in the preview only draws itself once it is on screen
	show()
	raise()
	rebuild_all()
	input_handler.append_not_duplicate(gui_controller.windows_opened, self)
	if mode == 'tattoo':
		input_handler.ActivateTutorial("TUTORIALLIST8")


func hide():
	gui_controller.windows_opened.erase(self)
	.hide()


#gui_controller.close_scene() ends by raising the mansion and putting it back to its default
#state, which is wrong for a window that merely sits over it - see SexSelectMenu
func _custom_gui_controller_close():
	hide()


func body_mod_available():
	return MansionLayout.best_upgrade_level(ResourceScripts.game_res.mansion_layout,
		'beauty_parlor', 'body_modifications') >= 1


func rebuild_all():
	rebuild_characters()
	rebuild_inks()
	refresh_slots()
	refresh_preview(true)
	$Inks.visible = mode == 'tattoo'
	$Slots.visible = mode == 'tattoo' and selected_person != null
	$ModifyButton.visible = mode == 'bodymod'
	$ModifyButton.disabled = selected_person == null
	$Empty.visible = selected_person == null
	$Empty.text = tr("BEAUTYPARLOR_BODYMODHINT") if mode == 'bodymod' else tr("BEAUTYPARLOR_PICKCHAR")


#### the people ####

#Why this character cannot sit down, or '' when they can. Listed but greyed rather than left
#out, so the roster stays recognisable.
func _block_reason(person):
	if person.is_on_quest():
		return tr("BEAUTYPARLOR_AWAY")
	if !person.is_free():
		return tr("BEAUTYPARLOR_NOTHERE")
	#a story character drawn by hand has no doll to reshape; the editor would come up empty
	if mode == 'bodymod' and person.is_unique() and !person.uses_paperdoll():
		return tr("BEAUTYPARLOR_UNIQUE")
	return ''


func rebuild_characters():
	input_handler.ClearContainer(character_list)
	for id in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[id]
		var row = input_handler.DuplicateContainerTemplate(character_list)
		row.set_meta('slave', person)
		row.get_node('Label').text = person.get_short_name()
		row.get_node('Icon').texture = person.get_icon()
		input_handler.queue_portrait(person)
		var reason = _block_reason(person)
		row.disabled = reason != ''
		row.pressed = person == selected_person
		if reason != '':
			globals.connecttexttooltip(row, reason)
		else:
			globals.connectslavetooltip(row, person)
		row.connect("pressed", self, "_on_person_pressed", [person])


func _refresh_row_icons(_who = null):
	if !visible:
		return
	for row in character_list.get_children():
		if row.has_meta('slave') and !row.is_queued_for_deletion():
			row.get_node('Icon').texture = row.get_meta('slave').get_icon()


func _on_person_pressed(person):
	selected_person = person
	pending = {}
	rebuild_all()


#### the inks ####

func rebuild_inks():
	input_handler.ClearContainer(ink_grid)
	var codes = []
	for code in Items.materiallist:
		if Items.materiallist[code].type == 'tattoo':
			codes.append(code)
	codes.sort_custom(self, '_sort_inks')
	for code in codes:
		var material = Items.materiallist[code]
		var owned = int(ResourceScripts.game_res.materials.get(code, 0))
		var button = input_handler.DuplicateContainerTemplate(ink_grid)
		button.set_meta('code', code)
		button.get_node('Icon').texture = material.icon
		button.get_node('Amount').text = ResourceScripts.custom_text.transform_number(owned)
		#the material's name is the localized one; tattoodata's is not
		button.get_node('Name').text = material.name
		#greyed rather than left out: the inventory hid an empty pot, the bench shows what could
		#be brewed
		button.disabled = owned <= 0
		button.pressed = code == selected_ink
		globals.connectmaterialtooltip(button, material)
		button.connect("pressed", self, "_on_ink_pressed", [code])


func _sort_inks(a, b):
	return Items.materiallist[a].name < Items.materiallist[b].name


#pressing the picked pot again puts it down, which is how a tattoo is taken off
func _on_ink_pressed(code):
	selected_ink = '' if selected_ink == code else code
	pending = {}
	for button in ink_grid.get_children():
		if button.has_meta('code'):
			button.pressed = button.get_meta('code') == selected_ink
	refresh_slots()


#### the body ####

#With a pot picked, the places this ink may go on this person light up: can_add_tattoo asks
#the ink's own slot list, its conditions, whether it may be repeated and whether a pot is left.
#With none picked, the filled places light, for taking one off.
func refresh_slots():
	var tattoos = selected_person.get_tattoos() if selected_person != null else {}
	for slot in SLOT_ORDER:
		var button = $Slots.get_node(slot)
		var key = 'tattoo_' + slot
		var code = tattoos.get(key, null)
		var icon = null
		if code != null and Traitdata.tattoodata.has(code):
			icon = Traitdata.tattoodata[code].icon
		button.get_node('icon').texture = icon
		#never pre-pressed: a lit frame reads as 'already chosen'
		button.pressed = false
		if selected_person == null:
			button.disabled = true
		elif selected_ink == '':
			button.disabled = code == null
		else:
			button.disabled = !selected_person.can_add_tattoo(key, selected_ink)
		globals.disconnect_text_tooltip(button)
		globals.connecttexttooltip(button, _slot_text(slot, code))
	if selected_person == null:
		$Slots/Header.text = ''
		$Slots/Hint.text = ''
	else:
		$Slots/Header.text = selected_person.get_full_name()
		$Slots/Hint.text = Items.materiallist[selected_ink].name if selected_ink != '' else tr("CHOOSETATTOO")


#the place, and what is inked there
func _slot_text(slot, code):
	var text = tr("TATTOO" + slot.to_upper())
	if code == null or !Traitdata.tattoodata.has(code):
		return text
	var data = Traitdata.tattoodata[code]
	text += "\n" + Items.materiallist[code].name
	for key in data.descripts:
		if key.has(slot):
			text += "\n" + tr(data.descripts[key])
			break
	return text


func _on_slot_pressed(slot):
	$Slots.get_node(slot).pressed = false
	if selected_person == null:
		input_handler.SystemMessage(tr("BEAUTYPARLOR_PICKCHAR"))
		return
	var key = 'tattoo_' + slot
	var current = selected_person.get_tattoo(key)
	if selected_ink == '':
		if current == null:
			input_handler.SystemMessage(tr("CHOOSETATTOO"))
			return
		pending = {slot = key, action = 'remove'}
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, '_confirm_pending', tr("REMOVETATTOO")])
		return
	if current == selected_ink:
		input_handler.SystemMessage(tr("SAMETATTOO"))
		return
	if !selected_person.can_add_tattoo(key, selected_ink):
		input_handler.SystemMessage(tr("INVALIDREQS"))
		return
	pending = {slot = key, action = 'replace' if current != null else 'add'}
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
		[self, '_confirm_pending', tr("REPLACETATTOO" if current != null else "ADDTATTOO")])


#The question is asked and answered across frames, and the pot may have been spent or the
#person sent away meanwhile: everything is checked again, and a pot is paid only for an ink
#that really went on. add_tattoo takes the old ink off itself when the place is filled; the
#old ink is not returned.
func _confirm_pending():
	var question = pending
	pending = {}
	if question.empty() or selected_person == null or _block_reason(selected_person) != '':
		return
	match question.action:
		'remove':
			selected_person.remove_tattoo(question.slot)
		'add', 'replace':
			if selected_ink == '' or !selected_person.can_add_tattoo(question.slot, selected_ink):
				input_handler.SystemMessage(tr("INVALIDREQS"))
			elif selected_person.add_tattoo(question.slot, selected_ink):
				ResourceScripts.game_res.materials[selected_ink] -= 1
	if selected_ink != '' and int(ResourceScripts.game_res.materials.get(selected_ink, 0)) <= 0:
		selected_ink = ''
	#the counts and the icons; no doll work, the doll does not draw tattoos
	rebuild_inks()
	refresh_slots()


func refresh_preview(force):
	if selected_person == null:
		preview.hide_band()
		return
	if force:
		#the band skips the rebuild when nothing it knows of has changed, and a body just
		#reshaped in the chair is exactly such a change
		preview.cached_person_id = ''
	preview.show_for(selected_person)


#### body modifications ####

func _on_modify_pressed():
	if selected_person == null:
		input_handler.SystemMessage(tr("BEAUTYPARLOR_PICKCHAR"))
		return
	if input_handler.globalsettings.disable_paperdoll:
		input_handler.SystemMessage(tr("BEAUTYPARLOR_NODOLLS"))
		return
	var reason = _block_reason(selected_person)
	if reason != '':
		input_handler.SystemMessage(reason)
		return
	var person = selected_person
	#hidden first: that takes this window off the ESC stack, so ESC under the creation screen
	#(which refuses ESC itself) does nothing rather than popping this out from under it
	hide()
	editor = input_handler.get_spec_node(input_handler.NODE_CHAREDIT, [person, false, true])
	if editor != null and !editor.is_connected("visibility_changed", self, "_on_editor_visibility_changed"):
		editor.connect("visibility_changed", self, "_on_editor_visibility_changed")


#Every way out of the creation screen - Confirm, or a close button that hid it - lands here,
#so the portrait on file and every open doll follow the new look, and the chair opens again.
func _on_editor_visibility_changed():
	if editor == null or !is_instance_valid(editor) or editor.visible:
		return
	if editor.is_connected("visibility_changed", self, "_on_editor_visibility_changed"):
		editor.disconnect("visibility_changed", self, "_on_editor_visibility_changed")
	editor = null
	if selected_person != null:
		input_handler.reshoot_portrait(selected_person)
		input_handler.emit_signal('update_ragdoll')
	var mansion = get_parent()
	if mansion == null:
		return
	if mansion.get('SlaveListModule') != null:
		mansion.SlaveListModule.rebuild()
	#not while the player has gone elsewhere in the meantime - a load, the town, a scene
	if mansion.has_method('open_beauty_parlor') and gui_controller.current_screen == mansion:
		mansion.open_beauty_parlor('bodymod')
