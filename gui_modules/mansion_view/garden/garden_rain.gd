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

# The streak texture is 6x96, so these keep the drops hairline-thin on screen.
const FAR_SCALE = 0.45
const NEAR_SCALE = 0.85

export(int, 'Off', 'Drizzle', 'Rain', 'Storm') var intensity = 2 setget set_intensity
# Extra tilt on top of the level's own wind, for gusts.
export(float, -1.0, 1.0) var wind_bias = 0.0 setget set_wind_bias
export var drop_color = Color(0.74, 0.82, 0.96) setget set_drop_color


func _ready():
	apply()


func set_intensity(v):
	intensity = clamp(v, 0, LEVELS.size() - 1)
	apply()


func set_wind_bias(v):
	wind_bias = clamp(v, -1.0, 1.0)
	apply()


func set_drop_color(v):
	drop_color = v
	apply()


func level_name():
	return LEVEL_NAMES[intensity]


func apply():
	if not is_inside_tree():
		return
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


func _layer(node_name, amount, speed, dir, alpha, scale):
	var n = get_node_or_null(node_name)
	if n == null:
		return
	n.amount = max(1, amount)
	n.direction = dir
	n.initial_velocity = speed
	# lifetime just long enough to cross the screen plus the spawn margin
	n.lifetime = clamp(1400.0 / max(1.0, speed), 0.4, 3.0)
	n.preprocess = n.lifetime
	n.scale_amount = scale
	n.modulate = Color(drop_color.r, drop_color.g, drop_color.b, alpha)
	n.emitting = true
