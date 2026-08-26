extends Camera2D
# Zoom-in-only camera for the garden.
#
# Zoom 1.0 shows the whole authored canvas and is the hard outer stop - there is
# no zooming out past the default frame. Zooming in is clamped by min_zoom, and
# panning is clamped so the view never leaves the canvas, which means at zoom
# 1.0 the camera is pinned dead centre and cannot be dragged at all.
#
#   wheel        zoom towards the cursor
#   drag         left or middle mouse button
#   0            back to the default frame
#
# Everything that should NOT move with the camera (screen-space weather, UI)
# belongs in a CanvasLayer - see garden_backdrop_test.tscn.

# The coordinate space the garden is authored in.
export var canvas_size = Vector2(1920, 1080)
# Smallest zoom value, i.e. the deepest zoom-in. 0.34 is roughly 3x.
export(float, 0.1, 1.0) var min_zoom = 0.34
export var zoom_step = 1.15
# Higher snaps to the target faster; 0 disables smoothing.
export var follow_speed = 14.0
export var allow_drag = true

var _zoom_target = 1.0
var _pos_target = Vector2()
var _dragging = false


func _ready():
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	current = true
	limit_left = 0
	limit_top = 0
	limit_right = int(canvas_size.x)
	limit_bottom = int(canvas_size.y)
	reset()


func reset():
	_zoom_target = 1.0
	_pos_target = canvas_size * 0.5
	zoom = Vector2(1, 1)
	position = _pos_target


# Half the world rectangle the camera can see at `z`.
func _half_extent(z):
	return get_viewport_rect().size * z * 0.5


func _clamp_pos(p, z):
	var half = _half_extent(z)
	# when the view is as wide as the canvas there is nothing to pan to
	var lo = Vector2(min(half.x, canvas_size.x * 0.5), min(half.y, canvas_size.y * 0.5))
	var hi = Vector2(max(canvas_size.x - half.x, canvas_size.x * 0.5),
			max(canvas_size.y - half.y, canvas_size.y * 0.5))
	return Vector2(clamp(p.x, lo.x, hi.x), clamp(p.y, lo.y, hi.y))


func set_zoom_level(z, anchor_screen = null):
	z = clamp(z, min_zoom, 1.0)
	if anchor_screen == null:
		_zoom_target = z
		_pos_target = _clamp_pos(_pos_target, z)
		return
	# keep the world point under the cursor pinned while the zoom changes
	var off = anchor_screen - get_viewport_rect().size * 0.5
	var world = _pos_target + off * _zoom_target
	_zoom_target = z
	_pos_target = _clamp_pos(world - off * z, z)


func zoom_by(factor, anchor_screen = null):
	set_zoom_level(_zoom_target * factor, anchor_screen)


# Centre on a point of the canvas, as far as the clamp allows.
func set_focus(world_pos):
	_pos_target = _clamp_pos(world_pos, _zoom_target)


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_WHEEL_UP:
				zoom_by(1.0 / zoom_step, event.position)
			BUTTON_WHEEL_DOWN:
				zoom_by(zoom_step, event.position)
	if event is InputEventMouseButton and allow_drag:
		if event.button_index in [BUTTON_LEFT, BUTTON_MIDDLE]:
			_dragging = event.pressed
	elif event is InputEventMouseMotion and _dragging:
		_pos_target = _clamp_pos(_pos_target - event.relative * _zoom_target, _zoom_target)
	elif event is InputEventKey and event.pressed and not event.echo:
		if event.scancode == KEY_0:
			reset()


func _process(delta):
	if follow_speed <= 0.0:
		zoom = Vector2(_zoom_target, _zoom_target)
		position = _pos_target
		return
	var t = min(1.0, delta * follow_speed)
	var z = lerp(zoom.x, _zoom_target, t)
	zoom = Vector2(z, z)
	# re-clamp against the zoom actually in effect this frame, so the edge of
	# the canvas never slides into view mid-animation
	position = _clamp_pos(position.linear_interpolate(_pos_target, t), z)
