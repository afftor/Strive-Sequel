tool
extends Node2D
# Time-of-day grade for the garden backdrop.
#
# Two full-screen rects do the work: Tint regrades everything drawn beneath it,
# Wash adds the low sun (or the moon) coming in from one side. Pick a phase in
# the inspector and it updates live in the editor.
#
# Because Tint reads the frame back, it must sit directly above the backdrop
# and below anything that should not be graded (UI, tooltips).
#
# The lamp pools live inside the backdrop and are drawn *before* this grade.
# Two things keep them alive after dark: the shader spares bright pixels
# (highlight_keep), and lamp_gain scales the Glow node's own modulate - which
# is why the lamps come up as the sun goes down.

const PHASE_NAMES = ['Day', 'Dawn', 'Sunset', 'Night']

const PRESETS = [
	{   # Day - almost neutral, lamps nearly out
		'tint_sun': Color(1.00, 0.99, 0.95),
		'tint_shade': Color(0.92, 0.95, 1.00),
		'wash': Color(1.00, 0.92, 0.72),
		'wash_strength': 0.05,
		'sun_dir': Vector2(0.30, -1.00),
		'edge_darken': 0.00,
		'highlight_keep': 0.00,
		'lamp_gain': 0.10,
	},
	{   # Dawn - cold blue shadows, warm rose light low in the east
		'tint_sun': Color(1.00, 0.82, 0.80),
		'tint_shade': Color(0.42, 0.52, 0.88),
		'wash': Color(1.00, 0.52, 0.52),
		'wash_strength': 0.34,
		'sun_dir': Vector2(1.00, -0.10),
		'edge_darken': 0.22,
		'highlight_keep': 0.55,
		'lamp_gain': 0.75,
	},
	{   # Sunset - deep orange from the west, violet shade
		'tint_sun': Color(1.00, 0.72, 0.48),
		'tint_shade': Color(0.46, 0.44, 0.70),
		'wash': Color(1.00, 0.38, 0.16),
		'wash_strength': 0.34,
		'sun_dir': Vector2(-1.00, -0.18),
		'edge_darken': 0.26,
		'highlight_keep': 0.65,
		'lamp_gain': 1.10,
	},
	{   # Night - moonlight only, lamps carry the scene
		'tint_sun': Color(0.34, 0.42, 0.72),
		'tint_shade': Color(0.18, 0.23, 0.46),
		'wash': Color(0.40, 0.56, 0.95),
		'wash_strength': 0.10,
		'sun_dir': Vector2(-0.40, -1.00),
		'edge_darken': 0.42,
		'highlight_keep': 0.85,
		'lamp_gain': 1.70,
	},
]

export(int, 'Day', 'Dawn', 'Sunset', 'Night') var phase = 0 setget set_phase
# 0 leaves the backdrop exactly as authored, 1 is the full effect.
export(float, 0.0, 1.0) var amount = 1.0 setget set_amount
export var drive_lamps = true setget set_drive_lamps
export(NodePath) var lamp_glow_path = NodePath('../Backdrop/Glow')


func _ready():
	apply()


func set_phase(v):
	phase = clamp(v, 0, PRESETS.size() - 1)
	apply()


func set_amount(v):
	amount = clamp(v, 0.0, 1.0)
	apply()


func set_drive_lamps(v):
	drive_lamps = v
	apply()


func phase_name():
	return PHASE_NAMES[phase]


func apply():
	if not is_inside_tree():
		return
	var p = PRESETS[phase]

	var tint = get_node_or_null('Tint')
	if tint != null and tint.material != null:
		tint.material.set_shader_param('tint_sun', p['tint_sun'])
		tint.material.set_shader_param('tint_shade', p['tint_shade'])
		tint.material.set_shader_param('sun_dir', p['sun_dir'])
		tint.material.set_shader_param('edge_darken', p['edge_darken'])
		tint.material.set_shader_param('highlight_keep', p['highlight_keep'] * amount)
		tint.material.set_shader_param('amount', amount)

	var wash = get_node_or_null('Wash')
	if wash != null and wash.material != null:
		wash.material.set_shader_param('wash', p['wash'])
		wash.material.set_shader_param('sun_dir', p['sun_dir'])
		wash.material.set_shader_param('strength', p['wash_strength'] * amount)

	if drive_lamps:
		_drive_lamps(p)


func _drive_lamps(p):
	if lamp_glow_path.is_empty():
		return
	var glow = get_node_or_null(lamp_glow_path)
	if glow == null:
		return
	# Straight gain, no 1/tint compensation: overshooting here clips the pool
	# core to white, and a clipped core loses the warm lamp colour entirely.
	var gain = lerp(1.0, p['lamp_gain'], amount)
	glow.modulate = Color(gain, gain, gain, 1.0)


func next_phase():
	set_phase((phase + 1) % PRESETS.size())
