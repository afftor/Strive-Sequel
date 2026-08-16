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
const RoomUpgrades = preload("res://assets/data/mansion_room_upgrades.gd")

const COLOR_EMPTY = '332f28'
const COLOR_BROKEN = '4a2f2f'
const COLOR_BUILDING = '4a4530'
const COLOR_VALID_TARGET = '6ba36b'
const COLOR_PICKED = 'f9e181'

var view = null
var slot_code = ''


func setup(code, view_node):
	view = view_node
	slot_code = code
	set_meta('slot', code)
	connect("pressed", view, "slot_pressed", [code])


func room_data():
	return MansionLayout.get_room(view.current_floor(), slot_code)


func build_data():
	return MansionLayout.get_build(view.current_floor(), slot_code)


func status():
	return MansionLayout.slot_status(view.current_floor(), slot_code)


func update_slot():
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
	update_progress()
	apply_mode_highlight()


func draw_broken():
	$bg.color = Color(COLOR_BROKEN)
	$icon.texture = null
	$name.text = tr("MANSIONVIEW_BROKEN")
	globals.connecttexttooltip(self, tr("MANSIONVIEW_BROKENHINT"), true)


func draw_empty():
	$bg.color = Color(COLOR_EMPTY)
	$icon.texture = null
	$name.text = tr("MANSIONVIEW_EMPTYROOM")
	globals.connecttexttooltip(self, tr("MANSIONVIEW_BUILDHERE"), true)


func draw_building():
	var build = build_data()
	$bg.color = Color(COLOR_BUILDING)
	$icon.texture = null
	if build != null and build.kind == 'construct':
		var data = RoomTypes.get_type(build.target)
		$icon.texture = images.upgrade_icons[data.icon] if images.upgrade_icons.has(data.icon) else null
	$name.text = view.build_label(build)
	globals.connecttexttooltip(self, "%s\n%s" % [view.build_label(build), view.build_eta_text(build)], true)


func draw_room(room):
	var data = RoomTypes.get_type(room.type)
	$bg.color = Color(data.color)
	$icon.texture = images.upgrade_icons[data.icon] if images.upgrade_icons.has(data.icon) else null
	$name.text = tr(RoomTypes.get_name_key(room.type))
	globals.connecttexttooltip(self, build_tooltip(room), true)


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
		text += "\n%s %d" % [tr(RoomUpgrades.get_name_key(code)), int(room.upgrades[code])]
	var build = build_data()
	if build != null:
		text += "\n%s - %s" % [view.build_label(build), view.build_eta_text(build)]
	return text


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
		var capacity = MansionLayout.build_capacity(room_data())
		for char_id in workers:
			entries.append(['build', char_id])
		for _i in range(max(0, capacity - workers.size())):
			entries.append(['build', null])
	$People.visible = !entries.empty()
	for entry in entries:
		var cell = input_handler.DuplicateContainerTemplate($People)
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
		for char_id in room.occupants:
			res.append(['sleep', char_id])
		for _i in range(max(0, capacity - room.occupants.size())):
			res.append(['sleep', null])
		return res
	var places = MansionLayout.work_capacity(room)
	var workers = view.room_workers(room)
	for char_id in workers:
		res.append(['work', char_id])
	for _i in range(max(0, places - workers.size())):
		res.append(['work', null])
	return res


#### mode feedback ####

func apply_mode_highlight():
	$Highlight.visible = false
	if view.mode != 'rearrange':
		modulate = Color(1, 1, 1, 1)
		if view.picked_char != null:
			apply_pick_highlight()
		return
	if view.picked_slot != null:
		if slot_code == view.picked_slot and view.picked_floor == view.floor_index():
			set_highlight(COLOR_PICKED)
			modulate = Color(1, 1, 1, 1)
			return
		var valid = MansionLayout.can_swap(view.layout(), view.picked_floor, view.picked_slot,
			view.floor_index(), slot_code).ok
		modulate = Color(1, 1, 1, 1) if valid else Color(0.45, 0.45, 0.45, 1)
		if valid:
			set_highlight(COLOR_VALID_TARGET)
		return
	#nothing picked yet: dim whatever could not start a swap at all
	modulate = Color(1, 1, 1, 1) if view.has_any_swap_target(slot_code) else Color(0.5, 0.5, 0.5, 1)


#With somebody in hand the whole plan reads as a set of targets, exactly the way it does
#while rooms are being moved - and what counts as one is the question a drag would ask.
func apply_pick_highlight():
	#the room they came out of is no target, but dimming it would hide the very cell that
	#is showing them held
	if view.picked_char_from == slot_code:
		return
	if can_drop_data(Vector2.ZERO, view.pick_data()):
		set_highlight(COLOR_VALID_TARGET)
	else:
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
			return first_free_kind() != null
	return false


#Which sort of place a dropped person would land in. Scaffolding wins while it stands,
#because that is the thing waiting on hands.
func first_free_kind():
	if view.mode == 'rearrange':
		return null
	var build = build_data()
	if build != null and view.build_workers(build).size() < MansionLayout.build_capacity(room_data()):
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
			view.clear_pick()
		'mansion_char':
			view.place_character(first_free_kind(), slot_code, data.char_id, null)


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
