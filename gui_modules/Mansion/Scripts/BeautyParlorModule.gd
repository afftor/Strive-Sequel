extends Panel
#The beauty parlor's tattoo bench, opened from the room's card. Remaking a body is a different
#job behind a different button, and it has a window of its own - see BodyModModule.
#
#Registered as an open window the way SexSelectMenu is: ESC and the close button both end at
#hide(), and _custom_gui_controller_close keeps gui_controller.close_scene() from putting the
#mansion back to its default state underneath.

#the eight places on a body, bare; the character keeps them prefixed 'tattoo_'
const SLOT_ORDER = ['face', 'neck', 'arms', 'legs', 'chest', 'crotch', 'waist', 'ass']

#What an empty place looks like: the same silhouettes the inventory puts in an empty gear
#slot, so a frame says which part of the body it is before anything is inked on it. Every
#one of the eight is reachable - branding takes neck, crotch and ass, makeup and tribal the
#face, lust chest, ass and crotch, the regen inks arms, legs and waist.
const SLOT_ICONS = {
	face = preload("res://assets/images/iconsitems/cell/head.png"),
	neck = preload("res://assets/images/iconsitems/cell/neck.png"),
	arms = preload("res://assets/images/iconsitems/cell/gloves.png"),
	legs = preload("res://assets/images/iconsitems/cell/legs.png"),
	chest = preload("res://assets/images/iconsitems/cell/body.png"),
	crotch = preload("res://assets/images/iconsitems/cell/underwear.png"),
	waist = preload("res://assets/images/iconsitems/cell/pelvis.png"),
	ass = preload("res://assets/images/iconsitems/cell/booty.png"),
}
#an empty place is a hint rather than a picture, so its silhouette is dimmed
const EMPTY_SLOT_TINT = Color(0.45, 0.45, 0.45, 1)
#With a pot in hand the places it may go on are what the player is looking for, so they are
#lit warm while everything else is pushed back. The frames come in one plain texture and one
#greyed one, and those two alone read as almost the same square.
const SLOT_READY_TINT = Color(1.4, 1.25, 0.85, 1)
const SLOT_BLOCKED_TINT = Color(0.5, 0.5, 0.5, 1)
const SLOT_IDLE_TINT = Color(1, 1, 1, 1)

var selected_person = null
#an Items.materiallist code, which is also the Traitdata.tattoodata key; '' when no pot is picked
var selected_ink = ''
#{slot = 'tattoo_x', action = 'add' | 'replace' | 'remove'} while the yes/no question is up
var pending = {}

onready var character_list = $Characters/Scroll/List
onready var ink_grid = $Tattoo/Inks/Grid
onready var preview = $Preview


func _ready():
	gui_controller.add_close_button(self)
	$Title.text = tr("BEAUTYPARLOR_TITLE")
	$Characters/Header.text = tr("BEAUTYPARLOR_CHARACTERS")
	$Tattoo/InksHeader.text = tr("BEAUTYPARLOR_INKS")
	$Tattoo/Hint.text = tr("BEAUTYPARLOR_HINT")
	for slot in SLOT_ORDER:
		var button = $Tattoo/Slots.get_node(slot)
		button.connect("pressed", self, "_on_slot_pressed", [slot])
		button.get_node('Name').text = tr("TATTOO" + slot.to_upper())
	#the booth lands a portrait a couple of frames after it is asked for
	input_handler.connect("PortraitUpdate", self, "_refresh_row_icons")


#### the window ####

func open():
	pending = {}
	#whoever sat here last may have left on a quest, or the party, since
	if selected_person != null and (!ResourceScripts.game_party.characters.has(selected_person.id) \
			or _block_reason(selected_person) != ''):
		selected_person = null
	if selected_ink != '' and int(ResourceScripts.game_res.materials.get(selected_ink, 0)) <= 0:
		selected_ink = ''
	#shown before it is filled: the doll only stands itself up once it has a rect to stand in
	show()
	raise()
	rebuild_all()
	input_handler.append_not_duplicate(gui_controller.windows_opened, self)
	_hide_clock()
	input_handler.ActivateTutorial("TUTORIALLIST8")


#the estate's clock is drawn over everything on this screen, this window included, so it steps
#aside while the room is open and comes back with it - the same thing the progression and
#training popups do
var clock_was_visible = false


func _hide_clock():
	clock_was_visible = gui_controller.clock != null and gui_controller.clock.visible
	if gui_controller.clock != null:
		gui_controller.clock.hide()
	set_process(true)


func _restore_clock():
	if clock_was_visible and gui_controller.clock != null:
		gui_controller.clock.show()
	clock_was_visible = false


#gui_controller.clock_visibility() puts the clock back whenever the screen underneath is judged
#again, so keeping it away is a standing job, not a one-off
func _process(_delta):
	if visible and gui_controller.clock != null and gui_controller.clock.visible:
		gui_controller.clock.hide()


func hide():
	gui_controller.windows_opened.erase(self)
	_restore_clock()
	.hide()


#gui_controller.close_scene() ends by raising the mansion and putting it back to its default
#state, which is wrong for a window that merely sits over it - see SexSelectMenu
func _custom_gui_controller_close():
	hide()


func rebuild_all():
	rebuild_characters()
	rebuild_inks()
	refresh_slots()
	refresh_preview(true)
	$Tattoo.visible = selected_person != null
	$Empty.visible = selected_person == null
	if $Empty.visible:
		$Empty.text = tr("BEAUTYPARLOR_PICKCHAR")


#### the people ####

#Why this character cannot sit down, or '' when they can. Listed but greyed rather than left
#out, so the roster stays recognisable.
func _block_reason(person):
	if person.is_on_quest():
		return tr("BEAUTYPARLOR_AWAY")
	if !person.is_free():
		return tr("BEAUTYPARLOR_NOTHERE")
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
		#no caption under the pot: "Ink: Permanent Makeup" is wider than the cell, and the
		#tooltip below names it - the inventory's own icon grid does the same
		#greyed rather than left out: the inventory hid an empty pot, the bench shows what
		#could be brewed
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


#### the places on the body ####

#With a pot picked, the places this ink may go on this person light up: can_add_tattoo asks
#the ink's own slot list, its conditions, whether it may be repeated and whether a pot is left.
#With none picked, the filled places light, for taking one off.
func refresh_slots():
	var tattoos = selected_person.get_tattoos() if selected_person != null else {}
	for slot in SLOT_ORDER:
		var button = $Tattoo/Slots.get_node(slot)
		var key = 'tattoo_' + slot
		var code = tattoos.get(key, null)
		var icon = button.get_node('icon')
		if code != null and Traitdata.tattoodata.has(code):
			icon.texture = Traitdata.tattoodata[code].icon
			icon.modulate = Color(1, 1, 1, 1)
		else:
			icon.texture = SLOT_ICONS[slot]
			icon.modulate = EMPTY_SLOT_TINT
		if selected_person == null:
			button.disabled = true
		elif selected_ink == '':
			button.disabled = code == null
		else:
			button.disabled = !selected_person.can_add_tattoo(key, selected_ink)
		if button.disabled:
			button.self_modulate = SLOT_BLOCKED_TINT
		elif selected_ink != '':
			#this pot may go here: that is the whole question being asked right now
			button.self_modulate = SLOT_READY_TINT
			icon.modulate = Color(1, 1, 1, 1)
		else:
			button.self_modulate = SLOT_IDLE_TINT
		globals.disconnect_text_tooltip(button)
		globals.connecttexttooltip(button, _slot_text(slot, code))
	if selected_person == null:
		$Tattoo/SlotsHeader.text = ''
	else:
		$Tattoo/SlotsHeader.text = Items.materiallist[selected_ink].name if selected_ink != '' \
			else tr("CHOOSETATTOO")


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
		input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
			[self, '_confirm_pending', _ask_text('remove', slot, current)])
		return
	if current == selected_ink:
		input_handler.SystemMessage(tr("SAMETATTOO"))
		return
	if !selected_person.can_add_tattoo(key, selected_ink):
		input_handler.SystemMessage(tr("INVALIDREQS"))
		return
	var action = 'replace' if current != null else 'add'
	pending = {slot = key, action = action}
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL,
		[self, '_confirm_pending', _ask_text(action, slot, current)])


#The question names all three: which ink, where on the body, and whose body it is - the
#panel has a character list and eight identical frames, and "Add tattoo?" answered none of it.
func _ask_text(action, slot, current):
	var place = tr("TATTOO" + slot.to_upper())
	var who = selected_person.get_short_name()
	match action:
		'add':
			return tr("BEAUTYPARLOR_ASK_ADD") % [Items.materiallist[selected_ink].name, place, who]
		'replace':
			return tr("BEAUTYPARLOR_ASK_REPLACE") % [Items.materiallist[current].name, place, who,
				Items.materiallist[selected_ink].name]
		'remove':
			return tr("BEAUTYPARLOR_ASK_REMOVE") % [Items.materiallist[current].name, place, who]
	return ''


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
		#the band skips the rebuild while nothing it knows of has changed
		preview.cached_person_id = ''
	preview.show_for(selected_person)
