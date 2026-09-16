extends Control
#The floor surface. It paints the shell of the building in _draw() - one rect per
#designer area, which is why the shape is stored as coordinates rather than as a picture -
#and hosts one node per slot on top of it.
#
#Slots come from the level map and never move, so unlike the old free-form floor there is
#nothing to hit-test against bare ground: every click lands on a slot node.
#
#Zoom scales this whole control, children included, and the view keeps it centred.

const FloorPlans = preload("res://assets/data/mansion_floor_plans.gd")

#pixels per field tile; the whole 100x100 field is 900x900 at zoom 1
const TILE_PX = 9

#A floor is drawn at its own size or larger, never smaller: shrinking it to fit the band left
#by the panels made the rooms too small to read and the places inside them too small to aim
#at. It does not all fit at 100%, which is what panning is for.
const ZOOM_MIN = 1.0
const ZOOM_MAX = 2.2
const ZOOM_STEP = 0.15

#The shell is painted through rather than over: on the mansion screen the plan lies on the
#room art instead of in a panel, and a solid slab of floor would put the window back that the
#frame was taken off to remove. Rooms keep their own opaque colours on top of it.
const COLOR_FLOOR = Color(0.18, 0.165, 0.141, 0.78)
const COLOR_BLOCKED = Color(0.29, 0.251, 0.22, 0.85)

var view = null


func setup(view_node):
	view = view_node
	rect_pivot_offset = Vector2.ZERO
	rect_min_size = Vector2(FloorPlans.FIELD_TILES, FloorPlans.FIELD_TILES) * TILE_PX
	rect_size = rect_min_size
	#the clock only sets the hour on a turn or a reset, so a mansion just built starts at the right one
	var backdrop = backdrop_scene()
	if backdrop != null:
		backdrop.set_hour(ResourceScripts.game_globals.hour)


func rebuild():
	#the picture under the rooms is a scene of its own hung here, not a slot to sweep away
	input_handler.ClearContainer(self, ['Button', 'Backdrops'])
	var floor_plan = view.floor_plan()
	show_backdrop(floor_plan)
	if floor_plan == null:
		return
	for slot_plan in floor_plan.slots:
		var node = input_handler.DuplicateContainerTemplate(self)
		node.setup(slot_plan.code, view)
		var rect = slot_rect(floor_plan, slot_plan)
		node.rect_position = rect.position
		#The template carries a minimum of its own and a Control never goes under one, so a slot
		#the plan draws shorter than that kept the template's height and hung over the wall of the
		#room beneath it. The slot's rect is what says how big it is.
		node.rect_min_size = rect.size
		node.rect_size = node.rect_min_size
		node.update_slot()
	update()


#ClearContainer frees the old nodes with queue_free(), so within the same frame they are
#still children. Anything walking them has to skip the ones about to disappear.
func slot_nodes():
	var res = []
	for node in get_children():
		if node.has_meta('slot') and !node.is_queued_for_deletion():
			res.append(node)
	return res


func get_slot_node(slot_code):
	for node in slot_nodes():
		if node.get_meta('slot') == slot_code:
			return node
	return null


func update_all():
	for node in slot_nodes():
		node.update_slot()


#Colours and dimming only, leaving every node where it is - see mansion_slot_node.refresh_marks
func refresh_marks():
	for node in slot_nodes():
		node.refresh_marks()


#### painting ####

func _draw():
	if view == null:
		return
	var floor_plan = view.floor_plan()
	if floor_plan == null:
		return
	#the picture itself is a node drawn over this, see show_backdrop()
	var standing_on_art = backdrop_rect(floor_plan).size.x > 0
	#areas are painted in the order the designer wrote them, so a later 'outside'
	#rectangle cuts a hole back out of an earlier 'floor' one
	for area in floor_plan.areas:
		var rect = Rect2(Vector2(area.rect[0], area.rect[1]) * TILE_PX,
			Vector2(area.rect[2], area.rect[3]) * TILE_PX)
		match area.state:
			'floor':
				#where there is a picture it is the floor; the slab over it would only
				#mute the thing it was put there to replace
				if !standing_on_art:
					draw_rect(rect, COLOR_FLOOR)
			'blocked':
				draw_rect(rect, COLOR_BLOCKED)


#### the ground under the rooms ####

#A floor can stand on a picture instead of on the painted slab. The picture is a scene of its own
#- backdrop/mansion_backdrop.tscn, instanced here as Backdrops - in which the house and whatever is
#set about it by hand are laid out in the picture's own pixels, a layer to each floor code, and
#where the colours of the hours and the lanterns are set. It hangs under this control before every
#slot, so it takes the zoom and the pan of the rooms without being told and is drawn under all of
#them, and the viewport above clips whatever hangs over its edges. What stays in the plan is where
#the picture goes - its 'yard' and 'over' - because the slots are measured against the same numbers.
func backdrop_scene():
	var node = get_node_or_null("Backdrops")
	return node if node != null and node.has_method('show_floor') else null


#Which layer of that scene a floor stands on: the one named by its code, unless the plan stands it
#on another floor's picture - the storeys over the second are drawn on the second's, rooms and all.
func backdrop_layer(floor_plan):
	return str(floor_plan.backdrop.get('layer', floor_plan.code))


#The size of the picture a floor stands on, or nothing for a floor that stands on none.
func backdrop_size(floor_plan):
	var backdrop = backdrop_scene()
	if backdrop == null or floor_plan == null or !floor_plan.has('backdrop'):
		return Vector2.ZERO
	if !backdrop.has_floor(backdrop_layer(floor_plan)):
		return Vector2.ZERO
	return backdrop.canvas_size()


#The picture at the floor on screen, laid where the plan puts it - scaled rather than sized, so all
#that is set out on it in its pixels comes along - or put away for a floor that has none.
func show_backdrop(floor_plan):
	var backdrop = backdrop_scene()
	if backdrop == null:
		return
	var rect = backdrop_rect(floor_plan)
	backdrop.visible = rect.size.x > 0
	if !backdrop.visible:
		return
	backdrop.show_floor(backdrop_layer(floor_plan))
	backdrop.rect_position = rect.position
	backdrop.rect_scale = rect.size / backdrop.canvas_size()


#Where that picture goes, in the field's own pixels, or an empty rect for a floor with none.
#Its walled yard is laid on the tiles the plan gives it and the picture blown up until the yard
#covers them: the yard is the wider shape of the two, so what covers their height overhangs
#their width, and that overhang is the gardens to either side.
func backdrop_rect(floor_plan):
	var whole = backdrop_size(floor_plan)
	if whole.x <= 0 or whole.y <= 0:
		return Rect2()
	var on = floor_plan.backdrop.over
	var over = Rect2(Vector2(on[0], on[1]) * TILE_PX, Vector2(on[2], on[3]) * TILE_PX)
	if over.size.x <= 0 or over.size.y <= 0:
		return Rect2()
	var yard = floor_plan.backdrop.yard
	var share_at = Vector2(yard[0], yard[1])
	var share_size = Vector2(yard[2], yard[3])
	var scale = max(over.size.x / (share_size.x * whole.x), over.size.y / (share_size.y * whole.y))
	var size = whole * scale
	return Rect2(over.position + over.size / 2 - (share_at + share_size / 2) * size, size)


#What the view may pan about within, when that is the picture rather than the rooms.
func ground_rect():
	if view == null:
		return Rect2()
	var floor_plan = view.floor_plan()
	return Rect2() if floor_plan == null else backdrop_rect(floor_plan)


#Where a slot is drawn, in the field's own pixels. On a floor that stands on a picture it is the
#slot's mark in the backdrop scene - rooms are moved about on the picture there, in the editor -
#carried out of the picture's pixels by the numbers that lay the picture; a slot with no mark, or
#a floor with no picture, is drawn where the plan's tiles put it.
func slot_rect(floor_plan, slot_plan):
	var backdrop = backdrop_scene()
	var whole = backdrop_size(floor_plan)
	if backdrop != null and whole.x > 0:
		var mark = backdrop.room_rect(backdrop_layer(floor_plan), slot_plan.code)
		if mark != null:
			var place = backdrop_rect(floor_plan)
			var scale = place.size / whole
			return Rect2(place.position + mark.position * scale, mark.size * scale)
	return Rect2(Vector2(slot_plan.rect[0], slot_plan.rect[1]) * TILE_PX,
		Vector2(slot_plan.rect[2], slot_plan.rect[3]) * TILE_PX)


#### zoom and panning ####

#The wheel and the middle button are handled by the view in _input(), not here. Slot
#nodes are Buttons, so their mouse_filter is STOP, and in Godot 3 a STOP control ends
#gui_input propagation whether or not it handled the event - which means anything routed
#through the GUI only ever reaches this control in the gaps between slots.


#The painted field is larger than the rooms standing on it, and not evenly so. Centring the
#field itself put that margin on screen and pushed the rooms down out of the middle, so both
#the opening view and the panning limits are measured from the box the slots actually occupy.
#Read from where the slots are drawn rather than from their nodes, which do not exist yet when the
#view is first centred.
func content_rect():
	var floor_plan = view.floor_plan()
	if floor_plan == null or floor_plan.slots.empty():
		return Rect2(Vector2.ZERO, rect_size)
	var box = slot_rect(floor_plan, floor_plan.slots[0])
	for slot_plan in floor_plan.slots:
		box = box.merge(slot_rect(floor_plan, slot_plan))
	return box


func apply_transform(zoom, pan):
	rect_scale = Vector2(zoom, zoom)
	rect_position = pan
