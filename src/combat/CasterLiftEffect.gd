extends Node2D
#The charged cast: the card rises over a magic circle lying on the ground in perspective, a pillar
#of light flares on the release and the circle collapses into sparks. The back half is a child of
#the card drawn behind it, so the opaque portrait hides what lies behind the card.

const PALETTES = {
	arcane = ['8f7cff', 'e6e0ff'],
	fire = ['ff7a26', 'ffe2a8'],
	frost = ['4cc3ff', 'dcf6ff'],
	abyss = ['a263ff', 'f0ddff'],
	storm = ['6fdcff', 'f4fdff'],
	light = ['ffcf4d', 'fff6d2'],
	hyperborea = ['78cdff', 'ffe6a0'],
}
const RINGS = [[0.2, 1.3], [0.55, 1.6], [0.8, 1.2], [0.93, 1.1], [1.0, 2.2]]
#rune strokes as x, y pairs in a unit box, y down
const GLYPHS = [
	[[0.0, 0.5, 0.0, -0.5], [0.0, -0.5, 0.32, -0.22], [0.0, -0.16, 0.32, 0.12]],
	[[-0.24, 0.5, -0.24, -0.5, 0.24, -0.18, 0.24, 0.5]],
	[[-0.14, -0.5, -0.14, 0.5], [-0.14, -0.26, 0.24, 0.0, -0.14, 0.26]],
	[[-0.2, 0.5, -0.2, -0.5, 0.2, -0.3, -0.2, -0.06, 0.24, 0.5]],
	[[0.22, -0.42, -0.2, 0.0, 0.22, 0.42]],
	[[-0.3, -0.42, 0.3, 0.42], [0.3, -0.42, -0.3, 0.42]],
	[[-0.12, 0.5, -0.12, -0.5, 0.24, -0.3, -0.12, -0.08]],
	[[0.0, 0.5, 0.0, -0.5], [-0.28, -0.5, 0.0, -0.2, 0.28, -0.5]],
	[[0.0, -0.5, 0.28, -0.16, 0.0, 0.18, -0.28, -0.16, 0.0, -0.5], [-0.12, 0.1, -0.3, 0.5], [0.12, 0.1, 0.3, 0.5]],
	[[0.0, 0.5, 0.0, -0.5], [0.0, -0.5, 0.24, -0.3], [0.0, 0.5, -0.24, 0.3]],
	[[-0.26, -0.5, -0.26, 0.5], [0.26, -0.5, 0.26, 0.5], [-0.26, -0.5, 0.26, 0.0, -0.26, 0.5]],
	[[0.0, 0.5, 0.0, -0.5], [-0.26, -0.2, 0.26, 0.2]],
]
const PILLAR_HEIGHT = 340.0
const WHITE = Color(1, 1, 1)

var back_half = false
var twin = null
var card = null
var origin = null
var direction = 1.0
var release = 0.4
var rise = 20.0
var radius = 112.0
var tilt_sin = 0.342
var tilt_cos = 0.94
var perspective = 0.09
var core = Color(1, 1, 1)
var light = Color(1, 1, 1)
var t = 0.0
#real seconds since the card's tween last moved this node; it frees itself when the card is gone
var idle = 0.0


func setup(settings):
	release = max(0.05, float(settings.release))
	rise = float(settings.rise)
	radius = max(1.0, float(settings.radius))
	tilt_sin = sin(deg2rad(float(settings.tilt)))
	tilt_cos = cos(deg2rad(float(settings.tilt)))
	perspective = float(settings.perspective)
	var palette = PALETTES.get(str(settings.palette), PALETTES.arcane)
	core = Color(palette[0])
	light = Color(palette[1])
	var additive = CanvasItemMaterial.new()
	additive.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	material = additive
	set_process(true)


func drive(new_card, new_origin, new_twin):
	card = new_card
	origin = new_origin
	twin = new_twin
	if card.has_method('get_attack_vector') and card.get_attack_vector().x < 0.0: direction = -1.0
	play_at(0.0)


func duration():
	return release + 0.76


#driven by the card's tween, so the float of the active card waits while it plays
func play_at(time):
	t = time
	idle = 0.0
	update()
	if card == null or !is_instance_valid(card): return
	pose_card()
	if twin != null and is_instance_valid(twin):
		twin.t = time
		twin.idle = 0.0
		twin.transform = card.get_transform().affine_inverse() * Transform2D(0.0, origin.ground)
		twin.update()


func pose_card():
	var R = release
	var up = max(0.3, 0.72 * R)
	var lift = inout_sine(seg(t, 0.04, up))
	var land = inout_sine(seg(t, R + 0.18, R + 0.64))
	var hover = seg(t, up - 0.1, up + 0.1) * (1.0 - land)
	var bob = 3.0 * sin((t - up) * TAU / 1.1) * hover
	var sway = 1.2 * sin(t * TAU / 1.3) * seg(t, 0.08, 0.3) * (1.0 - seg(t, R, R + 0.25))
	var push = bump(t, R, R + 0.07, R + 0.26)
	var touch = bump(t, R + 0.62, R + 0.66, R + 0.76)
	var flash = 1.0 + 0.4 * bump(t, R, R + 0.04, R + 0.28)
	card.rect_position = origin.position + Vector2(direction * 8.0 * push, -rise * lift * (1.0 - land) + bob + 1.5 * touch)
	card.rect_rotation = origin.rotation + sway + direction * 2.0 * push
	card.rect_scale = Vector2(origin.scale.x * (1.0 + 0.02 * touch), origin.scale.y * (1.0 - 0.025 * touch))
	card.modulate = Color(origin.modulate.r * flash, origin.modulate.g * flash, origin.modulate.b * flash, origin.modulate.a)


func _process(delta):
	idle += delta
	if idle > 1.0:
		queue_free()


func _draw():
	var R = release
	var grow = out_cubic(seg(t, 0.06, max(0.2, 0.66 * R)))
	var collapse = in_cubic(seg(t, R + 0.04, R + 0.28))
	var shown = 1.0 - seg(t, R + 0.25, R + 0.31)
	var flare = bump(t, R, R + 0.04, R + 0.3)
	var hot = max(flare * 0.8, collapse)
	var r = radius * (1.0 - 0.85 * collapse)
	if !back_half and flare > 0.0: draw_pillar(flare)
	if flare > 0.0: fill_half_disc(radius * 0.74, Color(core.r, core.g, core.b, 0.34 * flare))
	if shown > 0.0 and grow > 0.0:
		var a = shown * (0.85 + 0.15 * flare)
		var spin = 0.3 * t
		for ring in RINGS:
			var ring_alpha = seg(grow, ring[0] - 0.12, ring[0])
			if ring_alpha > 0.0: stroke(arc(r * ring[0], 0.0, TAU), ring[1], a * ring_alpha, hot)
		var square_alpha = seg(grow, 0.7, 0.86)
		if square_alpha > 0.0:
			for q in range(2): stroke(polygon(r * 0.8, 4, spin + q * PI / 4.0), 1.2, a * square_alpha, hot)
		var star_alpha = seg(grow, 0.42, 0.58)
		if star_alpha > 0.0:
			for q in range(2): stroke(polygon(r * 0.55, 3, -0.4 * t + q * PI / 3.0 - PI / 2.0), 1.2, a * star_alpha, hot)
		for i in range(8):
			var rune_alpha = seg(grow, 0.84 + 0.02 * i, 0.9 + 0.02 * i)
			if rune_alpha > 0.0: glyph(i + 3, r * 0.865, spin + TAU * i / 8.0 + PI / 8.0, r * 0.1, 1.3, a * rune_alpha, hot)
	var streaks = seg(t, 0.2 * R, 0.45 * R) * (1.0 - seg(t, R + 0.02, R + 0.14))
	if streaks > 0.0:
		var height = seg(t, 0.2 * R, 0.62 * R)
		for i in range(16):
			var angle = TAU * i / 16.0 + 0.3 * t
			var v = r * sin(angle)
			if !in_half(v): continue
			var top = (50.0 + 70.0 * hash01(i)) * height
			var middle = fposmod(t * 1.3 + hash01(i + 3), 1.0) * top
			var z0 = max(0.0, middle - 20.0)
			var z1 = min(top, middle + 20.0)
			if z1 > z0: stroke([Vector3(r * cos(angle), v, z0), Vector3(r * cos(angle), v, z1)], 1.6, streaks, hot * 0.5, false)
	if collapse > 0.0 and shown > 0.0 and !back_half:
		dot(Vector2(), 10.0 + 14.0 * collapse, core, 0.3 * collapse * shown)
		dot(Vector2(), 3.0 + 3.0 * collapse, light.linear_interpolate(WHITE, 0.6), collapse * shown)
	var sparks = seg(t, R + 0.27, R + 0.72)
	if sparks > 0.0 and sparks < 1.0:
		for i in range(18):
			var angle = TAU * i / 18.0 + hash01(i)
			var reach = radius * (0.08 + 0.95 * (0.35 + 0.65 * hash01(i + 11)) * out_cubic(sparks))
			var v = reach * sin(angle)
			if !in_half(v): continue
			var p = project(Vector3(reach * cos(angle), v, 8.0 + (40.0 + 90.0 * hash01(i + 5)) * out_quad(sparks)))
			var alpha = (1.0 - sparks) * (0.6 + 0.4 * hash01(i + 2))
			dot(p, 7.0, core, 0.25 * alpha)
			diamond(p, 2.8, light.linear_interpolate(WHITE, 0.4), alpha)


#a point on the ground (x right, y away from the viewer, z up) to this node's space
func project(p):
	var s = 1.0 / (1.0 + perspective * p.y / radius)
	return Vector2(p.x * s, -(p.y * tilt_sin + p.z * tilt_cos) * s)


func in_half(v):
	return v > 0.0001 if back_half else v <= 0.0001


func stroke(points, width, alpha, hot, split = true):
	if alpha <= 0.004 or points.size() < 2: return
	var runs = []
	var run = PoolVector2Array()
	for i in range(points.size() - 1):
		var a = points[i]
		var b = points[i + 1]
		if split and !in_half((a.y + b.y) * 0.5):
			if run.size() > 1: runs.append(run)
			run = PoolVector2Array()
			continue
		if run.empty(): run.append(project(a))
		run.append(project(b))
	if run.size() > 1: runs.append(run)
	if runs.empty(): return
	var halo = Color(core.r, core.g, core.b, 0.09 * alpha * (1.0 + hot))
	var glow = core.linear_interpolate(WHITE, hot * 0.5)
	glow.a = 0.26 * alpha
	var line = light.linear_interpolate(WHITE, hot)
	line.a = alpha
	for points_2d in runs:
		draw_polyline(points_2d, halo, width * 6.5, true)
		draw_polyline(points_2d, glow, width * 2.6, true)
		draw_polyline(points_2d, line, width, true)


func arc(r, from, to, turn = 0.0):
	var points = []
	var count = int(max(2.0, ceil(abs(to - from) * max(r, 8.0) / 5.0)))
	for i in range(count + 1):
		var angle = from + (to - from) * float(i) / count + turn
		points.append(Vector3(r * cos(angle), r * sin(angle), 0.0))
	return points


func polygon(r, sides, turn):
	var points = []
	for m in range(sides):
		var a0 = turn + TAU * m / sides
		var a1 = turn + TAU * (m + 1) / sides
		var p0 = Vector3(r * cos(a0), r * sin(a0), 0.0)
		var p1 = Vector3(r * cos(a1), r * sin(a1), 0.0)
		for i in range(0 if m == 0 else 1, 15):
			points.append(p0.linear_interpolate(p1, i / 14.0))
	return points


#a rune lying on the ground, its top turned away from the centre; the whole rune goes to one half
func glyph(index, r, angle, size, width, alpha, hot):
	if alpha <= 0.004 or !in_half(r * sin(angle)): return
	var c = cos(angle)
	var s = sin(angle)
	for flat in GLYPHS[index % GLYPHS.size()]:
		var points = []
		for i in range(0, flat.size(), 2):
			var along = r - flat[i + 1] * size
			var across = flat[i] * size
			points.append(Vector3(along * c - across * s, along * s + across * c, 0.0))
		stroke(points, width, alpha, hot, false)


func fill_half_disc(r, color):
	var start = 0.0 if back_half else PI
	var points = PoolVector2Array()
	for i in range(33):
		var angle = start + PI * i / 32.0
		points.append(project(Vector3(r * cos(angle), r * sin(angle), 0.0)))
	draw_colored_polygon(points, color)


func draw_pillar(flare):
	for band in [[0.72, 0.1, core], [0.46, 0.14, core], [0.2, 0.3, light.linear_interpolate(WHITE, 0.4)]]:
		var half_width = radius * band[0]
		var bottom = band[2]
		bottom.a = band[1] * flare
		var top = Color(bottom.r, bottom.g, bottom.b, 0.0)
		draw_polygon(PoolVector2Array([Vector2(-half_width, 0.0), Vector2(half_width, 0.0),
			Vector2(half_width, -PILLAR_HEIGHT), Vector2(-half_width, -PILLAR_HEIGHT)]),
			PoolColorArray([bottom, bottom, top, top]))


func dot(center, r, color, alpha):
	if alpha > 0.004: draw_circle(center, r, Color(color.r, color.g, color.b, alpha))


func diamond(center, r, color, alpha):
	if alpha <= 0.004: return
	draw_colored_polygon(PoolVector2Array([center + Vector2(0.0, -r * 1.5), center + Vector2(r, 0.0),
		center + Vector2(0.0, r * 1.5), center + Vector2(-r, 0.0)]), Color(color.r, color.g, color.b, alpha))


static func seg(x, a, b):
	if b <= a: return 1.0 if x >= b else 0.0
	return clamp((x - a) / (b - a), 0.0, 1.0)


static func bump(x, a, b, c):
	if x <= a or x >= c: return 0.0
	if x < b: return out_quad((x - a) / (b - a))
	return 1.0 - inout_quad((x - b) / (c - b))


static func out_quad(k):
	return 1.0 - (1.0 - k) * (1.0 - k)


static func inout_quad(k):
	return 2.0 * k * k if k < 0.5 else 1.0 - pow(-2.0 * k + 2.0, 2) / 2.0


static func out_cubic(k):
	return 1.0 - pow(1.0 - k, 3)


static func in_cubic(k):
	return k * k * k


static func inout_sine(k):
	return 0.5 - 0.5 * cos(PI * k)


static func hash01(i):
	var x = sin(float(i) * 127.1 + 311.7) * 43758.5453
	return x - floor(x)
