tool
extends Node2D
# Rain overlay for the garden backdrop. Independent of the time of day - drop
# it on top of the backdrop (and above the daylight grade, so the streaks keep
# catching the light after dark) and pick an intensity.
#
#   Wet     multiplies the ground darker and cooler, so it reads as soaked
#   Splash  short-lived rings where drops land
#   Far     the main curtain of thin streaks
#   Near    a sparser, faster, larger layer that sells the depth
#   Haze    a flat lift of grey over everything
#
# Every particle layer preprocesses a full lifetime, so the rain is already
# falling on the first frame instead of starting from an empty sky.

const LEVEL_NAMES = ['Off', 'Drizzle', 'Rain', 'Storm']

const LEVELS = [
	{'far': 0, 'near': 0, 'splash': 0, 'speed': 1200.0, 'drop_alpha': 0.0,
		'wet': 1.00, 'haze': 0.00, 'wind': 0.10},
	{'far': 220, 'near': 55, 'splash': 55, 'speed': 1150.0, 'drop_alpha': 0.24,
		'wet': 0.94, 'haze': 0.030, 'wind': 0.14},
	{'far': 520, 'near': 130, 'splash': 120, 'speed': 1500.0, 'drop_alpha': 0.32,
		'wet': 0.86, 'haze': 0.055, 'wind': 0.22},
	{'far': 900, 'near': 240, 'splash': 200, 'speed': 1950.0, 'drop_alpha': 0.40,
		'wet': 0.78, 'haze': 0.090, 'wind': 0.38},
]

# Where the curtains are born, above the overlay's top edge, and how deep that band is.
const SPAWN_Y = -140.0
const SPAWN_BAND = 70.0
# How far a drop falls past the overlay before it is spent.
const SPAWN_MARGIN = 320.0
# The curtains are spread wider than the overlay, so the wind's tilt leaves no dry edge.
const SPAN_WIDTH = 1.56
# The shape of one strike: seconds from its start against how bright the sky is then, as a share
# of storm_flash. Two blinks and a fall, the way a real one reads.
const STRIKE = [[0.0, 0.0], [0.04, 1.0], [0.11, 0.12], [0.17, 0.8], [0.55, 0.0]]


# The streak texture is 6x96, so these keep the drops hairline-thin on screen.
const FAR_SCALE = 0.45
const NEAR_SCALE = 0.85

export(int, 'Off', 'Drizzle', 'Rain', 'Storm') var intensity = 2 setget set_intensity
# Extra tilt on top of the level's own wind, for gusts.
export(float, -1.0, 1.0) var wind_bias = 0.0 setget set_wind_bias
export var drop_color = Color(0.74, 0.82, 0.96) setget set_drop_color
# Whether the overlay lays itself over the Control it hangs under instead of keeping the sizes
# set in the scene - for a UI whose rect is only settled at runtime, such as mansion_view's
# GridViewport, rather than a CanvasLayer over a screen of known size.
export var fit_to_parent = false setget set_fit_to_parent
# Where the rain must not fall, handed over by a node that knows the ground under it: one with
# an indoors_mask() of its own, laid out in the pixels its canvas_size() gives. mansion_view
# points this at the mansion's backdrop; left empty, the rain falls on everything.
export(NodePath) var mask_source
# A storm on top of the rain: the sky lights up and the thunder rolls in after it, over and over
# at uneven gaps. The rain alone leaves the sky quiet.
export var storm = false setget set_storm
export var storm_gap_min = 15.0
export var storm_gap_max = 25.0
# How far the sky is lifted at the peak of a strike - the Flash is added on top, not blended in.
export(float, 0.0, 1.0) var storm_flash = 0.12


# seconds until the next strike and how far into the strike on screen -
# a negative one means there is no strike on screen
var strike_in = 0.0
var strike_at = -1.0


func _ready():
	var holder = get_parent()
	if fit_to_parent and holder is Control and !holder.is_connected('resized', self, 'apply'):
		holder.connect('resized', self, 'apply')
	set_process(!Engine.editor_hint)
	strike_in = rand_range(storm_gap_min, storm_gap_max)
	var bed = get_node_or_null('Ambience')
	if bed != null and !bed.is_connected('finished', self, 'step_sound'):
		#the wav is imported as a loop and then never finishes; an import that is not one
		#would leave a hole in the rain, so start it over
		bed.connect('finished', self, 'step_sound')
	apply()


func _process(delta):
	push_mask()
	step_storm(delta)
	step_sound()


# The mask reaches the layers as a share of the screen, which is all a fragment knows of itself:
# where the source's picture lands, over the screen it lands on. Pixels would not do - the
# project stretches its 1920x1080 onto whatever the window is, and a fragment counts the
# window's own pixels.
func push_mask():
	var src = null
	if mask_source != null and !mask_source.is_empty():
		src = get_node_or_null(mask_source)
	var tex = null
	var rect = Color(0, 0, 0, 0)
	if src is CanvasItem and src.has_method('indoors_mask') and src.is_visible_in_tree():
		tex = src.indoors_mask()
		if tex != null:
			var at = src.get_global_transform_with_canvas()
			var span = src.canvas_size() if src.has_method('canvas_size') else src.rect_size
			span *= at.get_scale()
			var screen = get_viewport().get_visible_rect().size
			if screen.x > 0.0 and screen.y > 0.0:
				rect = Color(at.origin.x / screen.x, at.origin.y / screen.y,
					span.x / screen.x, span.y / screen.y)
	for part in ['Wet', 'Splash', 'Far', 'Near', 'Haze']:
		var n = get_node_or_null(part)
		if n == null or !(n.material is ShaderMaterial):
			continue
		n.material.set_shader_param('indoors', tex)
		n.material.set_shader_param('indoors_rect', rect)


func set_intensity(v):
	intensity = clamp(v, 0, LEVELS.size() - 1)
	apply()


func set_wind_bias(v):
	wind_bias = clamp(v, -1.0, 1.0)
	apply()


func set_drop_color(v):
	drop_color = v
	apply()


func set_fit_to_parent(v):
	fit_to_parent = v
	apply()


func set_storm(v):
	storm = v
	if !v:
		strike_at = -1.0
		var flash = get_node_or_null('Flash')
		if flash != null:
			flash.modulate.a = 0.0


func level_name():
	return LEVEL_NAMES[intensity]


func apply():
	if not is_inside_tree():
		return
	if fit_to_parent:
		fit_to(get_parent())
	var l = LEVELS[intensity]
	var off = intensity == 0
	visible = not off
	if off:
		return

	var wind = l['wind'] + wind_bias
	var dir = Vector2(wind, 1.0).normalized()

	_layer('Far', l['far'], l['speed'], dir, l['drop_alpha'], FAR_SCALE)
	_layer('Near', l['near'], l['speed'] * 1.35, dir, l['drop_alpha'] * 0.62, NEAR_SCALE)

	var splash = get_node_or_null('Splash')
	if splash != null:
		splash.amount = max(1, l['splash'])
		splash.modulate = Color(drop_color.r, drop_color.g, drop_color.b,
				l['drop_alpha'] * 1.35)
		splash.emitting = true

	var wet = get_node_or_null('Wet')
	if wet != null and wet.material != null:
		var w = l['wet']
		wet.material.set_shader_param('mul_color',
				Color(min(1.0, w * 0.94), min(1.0, w * 0.97), min(1.0, w * 1.05)))

	var haze = get_node_or_null('Haze')
	if haze != null:
		haze.color = Color(0.62, 0.70, 0.80, l['haze'])


# Spread over a Control's rect: the flat layers cover it, the curtains span it wide enough for
# the wind's tilt, and the splashes land anywhere in it.
func fit_to(holder):
	if !(holder is Control):
		return
	var size = holder.rect_size
	if size.x <= 0.0 or size.y <= 0.0:
		return
	for part in ['Wet', 'Haze', 'Flash']:
		var n = get_node_or_null(part)
		if n != null:
			n.rect_position = Vector2.ZERO
			n.rect_size = size
	var splash = get_node_or_null('Splash')
	if splash != null:
		splash.position = size / 2.0
		splash.emission_rect_extents = size / 2.0
	for part in ['Far', 'Near']:
		var n = get_node_or_null(part)
		if n != null:
			n.position = Vector2(size.x / 2.0, SPAWN_Y)
			n.emission_rect_extents = Vector2(size.x * SPAN_WIDTH / 2.0, SPAWN_BAND)


# The rain is heard while it is on screen and goes quiet the moment the screen leaves: the overlay
# stays in the tree behind whatever the player opened next.
func step_sound():
	var player = get_node_or_null('Ambience')
	if player == null:
		return
	var heard = intensity > 0 and is_visible_in_tree()
	if heard and !player.playing:
		player.play()
	elif !heard and player.playing:
		player.stop()
	var thunder = get_node_or_null('Thunder')
	if !heard and thunder != null and thunder.playing:
		thunder.stop()


func step_storm(delta):
	var flash = get_node_or_null('Flash')
	if flash == null:
		return
	if !storm or intensity == 0 or !is_visible_in_tree():
		if strike_at >= 0.0 or flash.modulate.a > 0.0:
			set_storm(storm)
		return
	if strike_at >= 0.0:
		strike_at += delta
		flash.modulate.a = storm_flash * strike_level(strike_at)
		if strike_at >= STRIKE[STRIKE.size() - 1][0]:
			strike_at = -1.0
			flash.modulate.a = 0.0
		return
	strike_in -= delta
	if strike_in > 0.0:
		return
	strike_in = rand_range(storm_gap_min, storm_gap_max)
	#the strike takes this frame with it, so the sky is already lit on the frame it is heard
	strike_at = delta
	flash.modulate.a = storm_flash * strike_level(strike_at)
	var player = get_node_or_null('Thunder')
	if player != null:
		player.pitch_scale = rand_range(0.7, 0.9)
		player.play()


func strike_level(at):
	for i in range(1, STRIKE.size()):
		if at > STRIKE[i][0]:
			continue
		var was = STRIKE[i - 1]
		var span = max(0.0001, STRIKE[i][0] - was[0])
		return lerp(was[1], STRIKE[i][1], (at - was[0]) / span)
	return 0.0


func fall_span():
	var wet = get_node_or_null('Wet')
	if wet == null:
		return 1080.0 + SPAWN_MARGIN
	return wet.rect_size.y + SPAWN_MARGIN


func _layer(node_name, amount, speed, dir, alpha, scale):
	var n = get_node_or_null(node_name)
	if n == null:
		return
	n.amount = max(1, amount)
	n.direction = dir
	n.initial_velocity = speed
	# lifetime just long enough to cross the screen plus the spawn margin
	n.lifetime = clamp(fall_span() / max(1.0, speed), 0.4, 3.0)
	n.preprocess = n.lifetime
	n.scale_amount = scale
	n.modulate = Color(drop_color.r, drop_color.g, drop_color.b, alpha)
	n.emitting = true
