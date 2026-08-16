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

const ZOOM_MIN = 0.6
const ZOOM_MAX = 2.2
const ZOOM_STEP = 0.15

const COLOR_FLOOR = Color('2e2a24')
const COLOR_BLOCKED = Color('4a4038')

var view = null


func setup(view_node):
	view = view_node
	rect_pivot_offset = Vector2.ZERO
	rect_min_size = Vector2(FloorPlans.FIELD_TILES, FloorPlans.FIELD_TILES) * TILE_PX
	rect_size = rect_min_size


func rebuild():
	input_handler.ClearContainer(self)
	var floor_plan = view.floor_plan()
	if floor_plan == null:
		return
	for slot_plan in floor_plan.slots:
		var node = input_handler.DuplicateContainerTemplate(self)
		node.setup(slot_plan.code, view)
		node.rect_position = Vector2(slot_plan.rect[0], slot_plan.rect[1]) * TILE_PX
		node.rect_size = Vector2(slot_plan.rect[2], slot_plan.rect[3]) * TILE_PX
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


#### painting ####

func _draw():
	if view == null:
		return
	var floor_plan = view.floor_plan()
	if floor_plan == null:
		return
	#areas are painted in the order the designer wrote them, so a later 'outside'
	#rectangle cuts a hole back out of an earlier 'floor' one
	for area in floor_plan.areas:
		var rect = Rect2(Vector2(area.rect[0], area.rect[1]) * TILE_PX,
			Vector2(area.rect[2], area.rect[3]) * TILE_PX)
		match area.state:
			'floor':
				draw_rect(rect, COLOR_FLOOR)
			'blocked':
				draw_rect(rect, COLOR_BLOCKED)


#### zoom and panning ####

#The wheel and the middle button are handled by the view in _input(), not here. Slot
#nodes are Buttons, so their mouse_filter is STOP, and in Godot 3 a STOP control ends
#gui_input propagation whether or not it handled the event - which means anything routed
#through the GUI only ever reaches this control in the gaps between slots.


func apply_transform(zoom, pan):
	rect_scale = Vector2(zoom, zoom)
	rect_position = pan
