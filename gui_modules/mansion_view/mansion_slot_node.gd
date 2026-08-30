extends Button
#One slot of the level map, sized and positioned by the grid. A slot is always a node,
#whatever its state, because its position is fixed and the player interacts with all of
#them: derelict ones get cleared out, empty ones built into, built ones used.
#
#What the row of places shows depends on the screen mode - beds in sleep mode, workplaces
#in work mode - and scaffolding adds builder places on top of whatever else is there,
#in their own colour.

const MansionLayout = preload("res://src/core/mansion_layout.gd")
const RoomTypes = preload("res://assets/data/mansion_room_types.gd")

#What a slot looks like before anything is read off it. Every working room shares the one
#picture for now; a slot with nothing built and a slot left derelict have their own, so the
#three states are told apart at a glance rather than by their colour alone. The colours below
#stay under the art - they are what shows if a picture is ever missing.
const ART_ROOM = preload("res://gui_modules/mansion_view/rooms/master_bedrrom.png")
const ART_EMPTY = preload("res://gui_modules/mansion_view/rooms/empty.png")
const ART_BROKEN = preload("res://gui_modules/mansion_view/rooms/trashed.png")

const COLOR_EMPTY = '332f28'
const COLOR_BROKEN = '4a2f2f'
const COLOR_BUILDING = '4a4530'
const COLOR_VALID_TARGET = '6ba36b'
const COLOR_PICKED = 'f9e181'

#A slot with nothing in it is part of the house but not a room yet, and one full of wreckage
#is further from being one still. Said with a tint rather than by greying the slot out: grey
#is what a control wears when it has stopped working, and these are both perfectly usable.
#The bare slot is turned cold rather than merely dulled - the art and the floor under it are
#both warm browns, so blue is what tells it apart at a glance instead of only being darker.
const TINT_EMPTY = Color(0.58, 0.74, 1.0, 1)
const TINT_BROKEN = Color(0.82, 0.76, 0.72, 1)

var view = null
var slot_code = ''
#Set while drawing, read by the hover rule: the two way-buttons belong to the staircase and
#are shown by the same thing that shows a caption, so what is drawn and what is hovered stay
#one decision rather than two that can disagree.
var has_stairs = false


func setup(code, view_node):
	view = view_node
	slot_code = code
	set_meta('slot', code)
	connect("pressed", view, "slot_pressed", [code])
	show_caption(false)


#### the caption band ####

#The band across the bottom of a slot naming what stands there. Kept out of sight until the
#cursor is on the slot: every room wearing a black bar turned the plan into a list of labels
#with the house behind it.
#
#Asked of the cursor's position rather than driven by mouse_entered, because the places inside
#a slot are controls of their own - moving onto one of them takes the mouse off the slot, and
#the caption blinked out from under the very cursor that had called it up. A mended staircase
#ignores the mouse altogether (see update_pressability) and would never be named at all.
func _process(_delta):
	show_caption(Rect2(Vector2.ZERO, rect_size).has_point(get_local_mouse_position()))


func show_caption(shown):
	if $name.visible == shown:
		return
	$name.visible = shown
	$HeaderShade.visible = shown
	$icon.visible = shown
	$Stairs.visible = has_stairs and shown


func room_data():
	return MansionLayout.get_room(view.current_floor(), slot_code)


func build_data():
	return MansionLayout.get_build(view.current_floor(), slot_code)


func status():
	return MansionLayout.slot_status(view.current_floor(), slot_code)


func update_slot():
	update_pressability()
	match status():
		'broken':
			draw_broken()
		'empty':
			draw_empty()
		'building':
			draw_building()
		'built':
			draw_room(room_data())
	build_people()
	update_fill()
	update_craft()
	update_progress()
	apply_mode_highlight()


#A mended staircase is not a room, it is two buttons on a wall. Left as a button of its own it
#clamped under the cursor and lit up as though a room had been selected, and then had nothing to
#show for it - its card is deliberately not opened. Ignoring the mouse takes the press away
#while the Up and Down buttons on its face keep theirs.
#While it is still rotted it stays pressable: its card is the only place the repair is bought.
#While rooms are being carried it stays pressable too, so refusing to move it can be said out
#loud rather than by nothing happening.
func update_pressability():
	var quiet = is_stairs() and view.mode != 'rearrange' and view.stairs_repaired()
	mouse_filter = Control.MOUSE_FILTER_IGNORE if quiet else Control.MOUSE_FILTER_STOP


func draw_broken():
	has_stairs = false
	$bg.color = Color(COLOR_BROKEN)
	$art.texture = ART_BROKEN
	$icon.texture = null
	$name.text = tr("MANSIONVIEW_BROKEN")
	globals.connecttexttooltip(self, tr("MANSIONVIEW_BROKENHINT"), true)
	$Stairs.visible = false


func draw_empty():
	has_stairs = false
	$bg.color = Color(COLOR_EMPTY)
	$art.texture = ART_EMPTY
	$icon.texture = null
	$name.text = tr("MANSIONVIEW_EMPTYROOM")
	globals.connecttexttooltip(self, tr("MANSIONVIEW_BUILDHERE"), true)
	$Stairs.visible = false


func draw_building():
	has_stairs = false
	var build = build_data()
	$bg.color = Color(COLOR_BUILDING)
	#Scaffolding shows whatever is actually standing there meanwhile: a repair is still a
	#wrecked room until it finishes, a new build is still bare floor.
	$art.texture = ART_BROKEN if build != null and build.kind == 'repair' else ART_EMPTY
	$icon.texture = null
	if build != null and build.kind == 'construct':
		var data = RoomTypes.get_type(build.target)
		$icon.texture = images.upgrade_icons[data.icon] if images.upgrade_icons.has(data.icon) else null
	$name.text = view.build_label(build)
	globals.connecttexttooltip(self, "%s\n%s" % [view.build_label(build), view.build_eta_text(build)], true)
	$Stairs.visible = false


func draw_room(room):
	var data = RoomTypes.get_type(room.type)
	$bg.color = Color(data.color)
	$art.texture = ART_ROOM
	$icon.texture = images.upgrade_icons[data.icon] if images.upgrade_icons.has(data.icon) else null
	$name.text = tr(RoomTypes.get_name_key(room.type))
	draw_stairs(room)
	set_room_tooltip(room)


#The staircase is the one room whose whole use is a choice of two, so it carries them on its
#face rather than behind a card: there is nothing else a card would have had to say. Each way
#shows only when there is a floor that way - the grounds are not climbed to, so they are never
#one of them.
func draw_stairs(room):
	#Drawn while rooms are being rearranged too - that is when it matters most. A pick carries
	#the floor it was made on (view.set_pick), so a room can be taken upstairs and put down
	#there; with no way up, the only route between floors was the bar at the top, and nothing
	#on the plan said a room could leave its floor at all.
	has_stairs = RoomTypes.has_tag(room.type, 'stairs')
	$Stairs.visible = has_stairs and $name.visible
	if !has_stairs:
		return
	for way in [['Up', 1], ['Down', -1]]:
		var button = $Stairs.get_node(way[0])
		var target = view.stairs_target(way[1])
		button.visible = target != null
		button.text = tr("MANSIONVIEW_GOUP" if way[1] > 0 else "MANSIONVIEW_GODOWN")
		if button.is_connected("pressed", view, "go_to_floor"):
			button.disconnect("pressed", view, "go_to_floor")
		if target != null:
			button.connect("pressed", view, "go_to_floor", [target])


#The card says all of this the moment the room is clicked, and a tooltip nearly the size of
#the card, following the cursor across the plan, was covering the very rooms it described. It
#is kept only while rooms are being moved, where what sits in the target is the whole question.
func set_room_tooltip(room):
	if view.mode == 'rearrange':
		globals.connecttexttooltip(self, build_tooltip(room), true)
		return
	if is_connected("mouse_entered", globals, 'showtexttooltip'):
		disconnect("mouse_entered", globals, 'showtexttooltip')


func build_tooltip(room):
	var text = tr(RoomTypes.get_name_key(room.type))
	text += "\n" + tr(RoomTypes.get_descript_key(room.type))
	var beds = MansionLayout.sleep_capacity(room)
	if beds > 0:
		text += "\n%s %d/%d" % [tr("MANSIONVIEW_BEDS"), room.occupants.size(), beds]
	var places = MansionLayout.work_capacity(room)
	if places > 0:
		text += "\n%s %d/%d" % [tr("MANSIONVIEW_WORKPLACES"), view.room_workers(room).size(), places]
	for code in room.upgrades:
		text += "\n%s %d" % [tr(RoomTypes.get_upgrade_name_key(code)), int(room.upgrades[code])]
	var build = build_data()
	if build != null:
		text += "\n%s - %s" % [view.build_label(build), view.build_eta_text(build)]
	return text


#A room with beds and no work has nothing to draw in work mode, so it sat there blank with
#only its name on it - and how full it is, is exactly what somebody arranging the day wants
#to know about a bedroom. Beds mode draws the beds themselves and needs no count.
func update_fill():
	var room = room_data()
	$Fill.visible = false
	if room == null or view.mode != 'work' or build_data() != null:
		return
	var beds = MansionLayout.sleep_capacity(room)
	if beds <= 0 or MansionLayout.work_capacity(room) > 0:
		return
	$Fill.visible = true
	$Fill.text = "%d/%d" % [room.occupants.size(), beds]


#What a craft room is making this turn. A workshop with people in it looked exactly like a
#workshop standing idle, and what it was set to was only visible by opening its card - which
#is a poor place for the one thing that changes every turn.
func update_craft():
	var room = room_data()
	$Craft.visible = false
	$CraftIcon.visible = false
	#the bar sits in the same strip while something is being raised here
	if room == null or view.mode != 'work' or build_data() != null:
		return
	var making = ResourceScripts.game_res.room_current_craft(room)
	if making == null:
		return
	var text = ResourceScripts.game_res.craft_result_name(making)
	var icon = ResourceScripts.game_res.craft_result_icon(making)
	if icon != null:
		$CraftIcon.texture = icon
		$CraftIcon.visible = true
	elif text != "":
		$Craft.visible = true
		$Craft.text = text
	else:
		return
	#the row of workers stops short of the line rather than running under it
	$People.rect_size = Vector2($People.rect_size.x,
		max(0.0, $Craft.rect_position.y - $People.rect_position.y - 4.0))


#### progress ####

func update_progress():
	var build = build_data()
	$Progress.visible = build != null
	if build == null:
		return
	$Progress.max_value = build.limit
	$Progress.value = build.progress
	$Progress/Label.text = "%d%%" % int(build.progress * 100.0 / max(1.0, build.limit))


#### the row of places ####

#Beds or workplaces depending on the mode, with builder places appended whenever there is
#scaffolding - those belong to neither mode and always show.
func build_people():
	input_handler.ClearContainer($People)
	if view.mode == 'rearrange':
		$People.visible = false
		return
	var entries = places_for_mode()
	var build = build_data()
	#scaffolding is work, and beds mode is not about work - it would only be in the way
	if build != null and view.mode != 'sleep':
		var workers = view.build_workers(build)
		var capacity = MansionLayout.build_capacity(room_data(), ResourceScripts.game_res.extra_builder_slots())
		for char_id in workers:
			entries.append(['build', char_id])
		for _i in range(max(0, capacity - workers.size())):
			entries.append(['build', null])
	$People.visible = !entries.empty()
	for entry in entries:
		var cell = input_handler.DuplicateContainerTemplate($People)
		#before setup(), which is what paints the cell in its kind's colour
		cell.master_bed = entry.size() > 2 and entry[2]
		cell.setup(view, entry[0], slot_code, entry[1])


func places_for_mode():
	var res = []
	var room = room_data()
	if room == null:
		return res
	#filled places first, then the empty remainder - the same shape as the job screen's
	#worker list (Mansion/Scripts/MansionJobModule.gd show_faces)
	if view.mode == 'sleep':
		var capacity = MansionLayout.sleep_capacity(room)
		#The master's room is drawn with his own bed first and in its own colour; the beds
		#beside it follow as a group, the way the room's card lists them.
		if RoomTypes.get_type(room.type).master_only:
			var master = null
			var others = []
			for char_id in room.occupants:
				var character = view.get_character(char_id)
				if master == null and character != null and character.is_master():
					master = char_id
				else:
					others.append(char_id)
			res.append(['sleep', master, true])
			for char_id in others:
				res.append(['sleep', char_id, false])
			for _i in range(max(0, capacity - 1 - others.size())):
				res.append(['sleep', null, false])
			return res
		for char_id in room.occupants:
			res.append(['sleep', char_id])
		for _i in range(max(0, capacity - room.occupants.size())):
			res.append(['sleep', null])
		return res
	#Three kinds of place, drawn in three colours: what the room has for being what it is,
	#what its upgrades widened it by, and what stands for a different job in the same room.
	#A row of identical squares said nothing about which of them an upgrade had paid for.
	var places = MansionLayout.work_capacity(room)
	var base = MansionLayout.base_work_slots(room)
	var special = MansionLayout.special_work_slots(room)
	var ordinary = max(0, places - special)
	var apart = view.special_worker(room)
	var queue = []
	for char_id in view.room_workers(room):
		if char_id != apart:
			queue.append(char_id)
	var taken = 0
	for i in range(ordinary):
		var who = null
		if taken < queue.size():
			who = queue[taken]
			taken += 1
		res.append(['work' if i < base else 'work_upgrade', who])
	for i in range(special):
		var who = apart if i == 0 else null
		if who == null and taken < queue.size():
			who = queue[taken]
			taken += 1
		res.append(['work_special', who])
	return res


#### mode feedback ####

#Re-marks what is already on screen without rebuilding any of it. Called while a drag is in
#progress, and a rebuild would free the very cell the drag started from.
func refresh_marks():
	apply_mode_highlight()
	for cell in $People.get_children():
		#the hidden template DuplicateContainerTemplate copies from is a child too, and it
		#has no view to ask anything of
		if cell.visible and cell.has_method('refresh') and !cell.is_queued_for_deletion():
			cell.refresh()


func apply_mode_highlight():
	$Highlight.visible = false
	if view.mode != 'rearrange':
		#Work mode is the mansion as it stands, so nothing in it is greyed out - a room that
		#takes no workers is still a room, and dimming half the plan by default read as half
		#the house being out of order. Arranging beds is a question put to the rooms, and the
		#ones that cannot answer it say so.
		var dim = view.mode == 'sleep' and !takes_people_in_mode()
		modulate = Color(0.5, 0.5, 0.5, 1) if dim else state_tint()
		if view.carried_data() != null:
			apply_pick_highlight()
		return
	if view.picked_slot != null:
		if slot_code == view.picked_slot and view.picked_floor == view.floor_index():
			set_highlight(COLOR_PICKED)
			modulate = Color(1, 1, 1, 1)
			return
		var valid = MansionLayout.can_swap(view.layout(), view.picked_floor, view.picked_slot,
			view.floor_index(), slot_code).ok
		#The staircase never trades places with anything, so it fails that question - but it
		#is not a refused target, it is the way to the floor the room is being carried to.
		#Dimmed, the one control that still does something read as the one that had stopped.
		modulate = Color(1, 1, 1, 1) if valid or is_stairs() else Color(0.45, 0.45, 0.45, 1)
		if valid:
			set_highlight(COLOR_VALID_TARGET)
		return
	#nothing picked yet: dim whatever could not start a swap at all
	modulate = Color(1, 1, 1, 1) if view.has_any_swap_target(slot_code) else Color(0.5, 0.5, 0.5, 1)


func state_tint():
	match status():
		'empty':
			return TINT_EMPTY
		'broken':
			return TINT_BROKEN
	return Color(1, 1, 1, 1)


#The one room on the plan that is a button rather than somewhere to put anybody.
func is_stairs():
	var room = room_data()
	return room != null and RoomTypes.has_tag(room.type, 'stairs')


#Has this slot any place of the sort the current mode is arranging? Scaffolding counts as work,
#because builders are put on it in work mode.
func takes_people_in_mode():
	var room = room_data()
	#the staircase holds nobody in either mode, but dimming it would read as "not for you"
	#when it is the one room on the plan that is a button
	if room != null and RoomTypes.is_fixed(room.type):
		return true
	if view.mode == 'sleep':
		return MansionLayout.sleep_capacity(room) > 0
	if build_data() != null:
		return true
	return MansionLayout.work_capacity(room) > 0


#With somebody in hand the whole plan reads as a set of targets, exactly the way it does
#while rooms are being moved - and what counts as one is the question a drag would ask.
func apply_pick_highlight():
	var carried = view.carried_data()
	#the room they came out of is no target, but dimming it would hide the very cell that
	#is showing them held
	if carried.get('from_slot', null) == slot_code:
		return
	if can_drop_data(Vector2.ZERO, carried):
		set_highlight(COLOR_VALID_TARGET)
	elif !is_stairs():
		#somebody in hand rides the stairs to another floor, so it stays lit for them too
		modulate = Color(0.5, 0.5, 0.5, 1)


#The highlight sits on top of the slot contents, so it has to stay translucent.
func set_highlight(hex):
	var color = Color(hex)
	color.a = 0.35
	$Highlight.color = color
	$Highlight.visible = true


#### drag and drop ####

#Only rooms are dragged from here, and only while rearranging. People are dragged from
#the cells inside, which Godot offers the drag to first.
func get_drag_data(_position):
	if view.mode != 'rearrange':
		return null
	if !view.has_any_swap_target(slot_code):
		return null
	var label = tr("MANSIONVIEW_EMPTYROOM")
	var color = COLOR_EMPTY
	var room = room_data()
	if room != null:
		label = tr(RoomTypes.get_name_key(room.type))
		color = RoomTypes.get_type(room.type).color
	set_drag_preview(make_preview(label, color))
	view.set_pick(slot_code)
	return {kind = 'mansion_slot', floor = view.floor_index(), slot = slot_code}


#A person dropped on the room body rather than on a particular place goes into the first
#free one, which is what a player expects when they aim at the room and not at a cell.
func can_drop_data(_position, data):
	if !(data is Dictionary) or !data.has('kind'):
		return false
	match data.kind:
		'mansion_slot':
			if view.mode != 'rearrange':
				return false
			return MansionLayout.can_swap(view.layout(), int(data.floor), data.slot,
				view.floor_index(), slot_code).ok
		'mansion_char':
			return refusal_for(data) == ''
	return false


func take_carried(data):
	return view.place_character(first_free_kind(), slot_code, data.char_id, null)


#Why this slot will not take the person in hand, as a localization key, or an empty string
#when it will. A drag only needs the yes or no; a click deserves to be told which of the
#several quite different noes it got, and both come from here so they cannot disagree.
#
#"There is no free place here" used to answer for all of them - for an empty slot with
#nothing built on it, for a kitchen in beds mode, for the staircase. None of those are full.
func refusal_for(data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return 'MANSIONVIEW_ERR_VOID'
	if room_data() == null and build_data() == null:
		return 'MANSIONVIEW_ERR_VOID'
	#Dropping on the room itself goes to its first free place, so what it would refuse the
	#master for is that place being a bed. Work and scaffolding are open to him like anyone
	#else - he sleeps in his own room, he does not stay out of every other one.
	var free_kind = first_free_kind()
	if free_kind == 'sleep' and view.is_pinned(data.char_id):
		return 'MANSIONVIEW_ERR_MASTERPINNED'
	if free_kind != null:
		return ''
	if !takes_people_in_mode():
		return 'MANSIONVIEW_ERR_NOBEDS' if view.mode == 'sleep' else 'MANSIONVIEW_ERR_NOWORK'
	return 'MANSIONVIEW_ERR_FULL'


#Which sort of place a dropped person would land in. Scaffolding wins while it stands,
#because that is the thing waiting on hands.
func first_free_kind():
	if view.mode == 'rearrange':
		return null
	var build = build_data()
	#scaffolding is work, and beds mode does not draw builder places at all - offering one
	#would put somebody where the mode has just told the player nobody goes
	if build != null and view.mode != 'sleep' \
			and view.build_workers(build).size() < MansionLayout.build_capacity(room_data(), ResourceScripts.game_res.extra_builder_slots()):
		return 'build'
	var room = room_data()
	if room == null:
		return null
	if view.mode == 'sleep':
		return 'sleep' if room.occupants.size() < MansionLayout.sleep_capacity(room) else null
	return 'work' if view.room_workers(room).size() < MansionLayout.work_capacity(room) else null


func drop_data(_position, data):
	match data.kind:
		'mansion_slot':
			view.try_swap(int(data.floor), data.slot, view.floor_index(), slot_code)
			view.end_move()
		'mansion_char':
			take_carried(data)


func make_preview(text, color):
	var preview = ColorRect.new()
	preview.color = Color(color)
	preview.rect_size = Vector2(140, 60)
	var label = Label.new()
	label.text = text
	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.anchor_right = 1.0
	label.anchor_bottom = 1.0
	preview.add_child(label)
	return preview
