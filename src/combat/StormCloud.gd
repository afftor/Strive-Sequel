extends "res://src/combat/FxNode.gd"
#A storm cloud gathers over a group of cards, sheet lightning flickers in it, and one bolt comes down and splits into
#every card at once; then the cloud thins out. The «Туча над врагом» mockup, on its own clock.
#The cloud is drawn over the targets' panel and under their cards; the bolts over everything.

const TEX_SIZE = Vector2(384, 192)
const WOBBLE_SIZE = Vector2(640, 293)
#the wobble of the cloud's edge is laid over this much of the screen from its top, as in the mockup
const WOBBLE_VIEW = Vector2(1920, 880)
const RADII = Vector2(620, 250)
#far and near layer: seed, px per texel, wind px/s, y offset, phase, mask scale, colour ramp, and the noise's min and
#max, measured, which the mockup took from each texture itself
const LAYERS = [
	[11.0, 3.4, 16.0, 0.0, 0.3, 0.9, [Color(0.086, 0.11, 0.188), Color(0.176, 0.212, 0.325), Color(0.353, 0.408, 0.58)], 0.184, 0.812],
	[47.0, 4.2, 34.0, 180.0, 1.7, 1.04, [Color(0.043, 0.059, 0.11), Color(0.106, 0.137, 0.224), Color(0.243, 0.294, 0.455)], 0.169, 0.753],
]
const RAMP_LIT = [Color(0.227, 0.333, 0.659), Color(0.576, 0.675, 0.925), Color(0.945, 0.965, 1.0)]
const NIGHT = Color(0.016, 0.024, 0.051)
#the return stroke: colour, alpha, width
const BLOOM = [[Color(0.216, 0.333, 1.0), 0.05, 120.0], [Color(0.275, 0.451, 1.0), 0.08, 64.0], [Color(0.353, 0.608, 1.0), 0.16, 32.0],
	[Color(0.549, 0.784, 1.0), 0.32, 15.0], [Color(0.804, 0.925, 1.0), 0.62, 6.5]]

const NOISE_GLSL = """
float lat(vec2 p, float s) {
	return fract(sin(dot(p, vec2(127.1, 311.7)) + s * 0.731) * 43758.5453);
}
float vnoise(vec2 p, vec2 per, float s) {
	vec2 i = floor(p);
	vec2 f = p - i;
	vec2 u = f * f * (3.0 - 2.0 * f);
	vec2 i0 = mod(i, per);
	vec2 i1 = mod(i + 1.0, per);
	float a = lat(i0, s);
	float b = lat(vec2(i1.x, i0.y), s);
	float c = lat(vec2(i0.x, i1.y), s);
	float d = lat(i1, s);
	return a + (b - a) * u.x + (c - a) * u.y + (a - b - c + d) * u.x * u.y;
}
float fbm(vec2 p, vec2 per, float s, int oct) {
	float sum = 0.0;
	float amp = 0.5;
	float norm = 0.0;
	float f = 1.0;
	for (int i = 0; i < 5; i++) {
		if (i >= oct) break;
		sum += amp * vnoise(p * f, per * f, s + float(i) * 101.0);
		norm += amp;
		amp *= 0.5;
		f *= 2.0;
	}
	return sum / norm;
}
"""

#one tileable layer of cloud: coverage in red, how the surface faces the light in green, thickness shade in blue
const CLOUD_BAKE_SHADER = "shader_type canvas_item;\nuniform float seed = 11.0;\nuniform float lo = 0.3;\nuniform float hi = 0.7;\n" + NOISE_GLSL + """
float density(vec2 uv) {
	vec2 per = vec2(6.0, 3.0);
	vec2 p = uv * per;
	float q1 = fbm(p, per, seed, 4);
	float q2 = fbm(p + vec2(5.2, 1.3), per, seed + 31.0, 4);
	return (fbm(p + 0.75 * vec2(q1, q2), per, seed + 67.0, 5) - lo) / max(0.0001, hi - lo);
}
void fragment() {
	vec2 px = vec2(1.0 / 384.0, 1.0 / 192.0);
	float d = density(UV);
	float a = pow(smoothstep(0.3, 0.52, d), 1.1);
	float gx = (density(UV + vec2(px.x, 0.0)) - density(UV - vec2(px.x, 0.0))) * 11.0;
	float gy = (density(UV + vec2(0.0, px.y)) - density(UV - vec2(0.0, px.y))) * 11.0;
	vec3 L = vec3(0.2, 0.85, 0.5);
	float lam = max(0.0, (-gx * L.x - gy * L.y + L.z) / (length(vec3(gx, gy, 1.0)) * length(L)));
	COLOR = vec4(a, clamp((lam - 0.2) / 0.8, 0.0, 1.0), 1.0 - 0.32 * smoothstep(0.6, 0.95, d), 1.0);
}
"""

const WOBBLE_BAKE_SHADER = "shader_type canvas_item;\n" + NOISE_GLSL + """
void fragment() {
	COLOR = vec4(vec3(fbm(UV * vec2(10.0, 5.0), vec2(10.0, 5.0), 991.0, 4)), 1.0);
}
"""

#a layer of the cloud on screen: drifting texture, a ragged ellipse that grows as the cloud gathers; the lit copy
#shows only where the lightning lights it
const CLOUD_SHADER = """shader_type canvas_item;
render_mode blend_mix;
uniform sampler2D layer_tex : hint_black;
uniform sampler2D wobble_tex : hint_black;
uniform vec2 tile = vec2(1306.0, 653.0);
uniform vec2 offset = vec2(0.0);
uniform vec2 center = vec2(0.0);
uniform vec2 radii = vec2(620.0, 250.0);
uniform float grow = 1.0;
uniform vec2 wobble_pos = vec2(0.0);
uniform vec2 wobble_size = vec2(1920.0, 880.0);
uniform float alpha = 1.0;
uniform vec4 ramp0 : hint_color;
uniform vec4 ramp1 : hint_color;
uniform vec4 ramp2 : hint_color;
uniform float lit = 0.0;
uniform vec4 light0 = vec4(0.0);
uniform vec4 light1 = vec4(0.0);
uniform vec4 light2 = vec4(0.0);
uniform vec4 light3 = vec4(0.0);
varying vec2 pos;

void vertex() {
	pos = VERTEX;
}

float light_at(vec4 l) {
	float q = clamp(length(pos - l.xy) / max(1.0, l.z), 0.0, 1.0);
	return l.w * mix(mix(1.0, 0.5, q / 0.4), mix(0.5, 0.0, (q - 0.4) / 0.6), step(0.4, q));
}

void fragment() {
	vec4 c = texture(layer_tex, (pos - offset) / tile);
	vec2 m = (pos - center) / grow;
	float wob = texture(wobble_tex, (center + m - wobble_pos) / wobble_size).r;
	float mask = 1.0 - smoothstep(0.5, 1.0, length(m / radii) + (wob - 0.5) * 0.5);
	vec3 col = mix(mix(ramp0.rgb, ramp1.rgb, c.g * 2.0), mix(ramp1.rgb, ramp2.rgb, c.g * 2.0 - 1.0), step(0.5, c.g));
	float a = c.r * mask * alpha;
	if (lit > 0.5) {
		COLOR = vec4(col, a * min(1.0, light_at(light0) + light_at(light1) + light_at(light2) + light_at(light3)));
	} else {
		COLOR = vec4(col * c.b, a);
	}
}
"""

var anim = null
var root = null
var root_home = Vector2()
var shaking = false
var cards = []
var under = null
var vignette = null
var cloud_nodes = []
var bolts = null
var flash = null
var view = Rect2(0, 0, 1920, 1080)
var cloud = Vector2()
var group_c = Vector2()
var release = 0.5
var strike_t = 1.05
var end_t = 2.65
var strikes = []
var sheets = []
var shake_px = 14.0
var dark = 0.55
var rng = RandomNumberGenerator.new()
var drawn_tau = -1.0


#the storm's own part of the kit: the shaders of its textures and of its cloud
static func equip(kit):
	if kit.has('storm_cloud'): return
	for pair in [['storm_bake', CLOUD_BAKE_SHADER], ['storm_wobble', WOBBLE_BAKE_SHADER], ['storm_cloud', CLOUD_SHADER],
			['storm_cloud_lit', CLOUD_SHADER.replace('blend_mix', 'blend_add')]]:
		var shader = Shader.new()
		shader.code = pair[1]
		kit[pair[0]] = shader


#opts: `release` is when the cast lets go, `shake` the most the screen shakes, `root` the node shaken, `group` the
#targets' group node, which the cloud goes right under
func gather(new_anim, target_nodes, kit, opts = {}):
	anim = new_anim
	equip(kit)
	use_kit(kit)
	root = opts.get('root')
	if root is Control: root_home = root.rect_position
	release = float(opts.get('release', 0.5))
	shake_px = float(opts.get('shake', 14.0))
	strike_t = release + 0.55
	end_t = strike_t + 1.6
	view = screen_rect()
	rng.seed = 9394
	for node in target_nodes:
		add_card(node)
	if cards.empty():
		queue_free()
		return
	for tg in cards:
		group_c += tg.cc / cards.size()
	cloud = Vector2(group_c.x, view.position.y + 70.0)
	plan()
	build(opts.get('group'))
	for i in range(LAYERS.size()):
		var job = bake('storm_layer_%d' % i, TEX_SIZE, true, '_bake_rect', '', shared.storm_bake)
		if job != null: job.params = {seed = LAYERS[i][0], lo = LAYERS[i][7], hi = LAYERS[i][8]}
	bake('storm_wobble', WOBBLE_SIZE, false, '_bake_rect', '', shared.storm_wobble)
	set_process(true)


func add_card(node):
	if node == null or !is_instance_valid(node): return
	var r = local_rect(node)
	var icon = node.get_node_or_null('Icon')
	cards.append({node = node, cc = r.position + r.size / 2.0, hit = 0.0,
		portrait = Rect2(icon.rect_position, icon.rect_size) if icon != null else Rect2(Vector2(), node.rect_size)})


#the queue lets go a little early: the strike's sound takes a slot of its own before the damage, and the damage
#brings the game's own hit reaction to each card
func lock_time():
	return strike_t - 0.1 if !cards.empty() else 0.0


func plan():
	var split = Vector2(group_c.x + (rng.randf() - 0.5) * 60.0, group_c.y - 280.0)
	var top = Vector2(split.x + (rng.randf() - 0.5) * 140.0, view.position.y + 30.0)
	strikes.append({t0 = strike_t, leader = 0.18, from = top, to = split, w = 2.1, kind = 'trunk', geo = bolt(top, split, 2.1, 3)})
	for tg in cards:
		var to = tg.cc + Vector2((rng.randf() - 0.5) * 40.0, (rng.randf() - 0.5) * 30.0)
		strikes.append({t0 = strike_t + 0.02, leader = 0.07, from = split, to = to, w = 1.0, kind = 'hit', geo = bolt(split, to, 1.0, 1)})
		tg.hit = strike_t + 0.03
	#sheet lightning flickers inside the cloud while it gathers
	var st = release
	while st < strike_t - 0.22:
		var ang = TAU * rng.randf()
		var rr = 0.45 * sqrt(rng.randf())
		sheets.append({t = st, pos = cloud + Vector2(cos(ang) * RADII.x, sin(ang) * RADII.y) * rr, r = 220.0 + 160.0 * rng.randf(),
			a = 0.4 + 0.3 * rng.randf()})
		st += 0.16 + 0.2 * rng.randf()


#a fractal channel from `a` to `b`: every pass splits each stretch and pushes its middle aside
func fractal(a, b, rough, depth):
	var pts = [a, b]
	var disp = rough * a.distance_to(b)
	for _d in range(depth):
		var np = [pts[0]]
		for i in range(pts.size() - 1):
			var p = pts[i]
			var q = pts[i + 1]
			var dv = q - p
			var l = max(0.0001, dv.length())
			np.append((p + q) / 2.0 + Vector2(-dv.y, dv.x) / l * (rng.randf() * 2.0 - 1.0) * disp)
			np.append(q)
		pts = np
		disp *= 0.52
	return pts


func bolt(from, to, w, branches):
	var main = fractal(from, to, 0.2, 7)
	var out = []
	for _b in range(branches):
		var f = 0.1 + 0.62 * rng.randf()
		var idx = int(f * (main.size() - 1))
		var p = main[idx]
		var dir = (main[min(main.size() - 1, idx + 6)] - p).normalized()
		var ang = (-1.0 if rng.randf() < 0.5 else 1.0) * (0.35 + 0.55 * rng.randf())
		var bl = (90.0 + 230.0 * rng.randf()) * sqrt(w) * (1.0 - f * 0.45)
		var pts = fractal(p, p + dir.rotated(ang) * bl, 0.3, 5)
		out.append({pts = pts, f = f, width = 0.42})
		if rng.randf() < 0.75:
			var j = int((0.3 + 0.4 * rng.randf()) * (pts.size() - 1))
			var a2 = ang + (-1.0 if rng.randf() < 0.5 else 1.0) * (0.45 + 0.5 * rng.randf())
			var l2 = bl * (0.3 + 0.35 * rng.randf())
			out.append({pts = fractal(pts[j], pts[j] + dir.rotated(a2) * l2, 0.34, 4), f = f + (1.0 - f) * 0.3 * j / (pts.size() - 1), width = 0.24})
	var sparks = []
	for _i in range(16):
		var an = -PI * (0.05 + 0.9 * rng.randf())
		var sp = 320.0 + 520.0 * rng.randf()
		sparks.append({v = Vector2(cos(an), sin(an)) * sp, life = 0.25 + 0.3 * rng.randf()})
	return {main = main, branches = out, sparks = sparks}


func build(group):
	#the cloud goes over the targets' panel and under their cards, the way the mockup drew it over the field
	under = Node2D.new()
	var parent = group.get_parent() if group != null and is_instance_valid(group) else null
	if parent != null:
		parent.add_child(under)
		parent.move_child(under, group.get_index())
	elif root != null:
		root.add_child(under)
	else:
		add_child(under)
	under.transform = under.get_parent().get_global_transform().affine_inverse() * get_global_transform()
	vignette = Node2D.new()
	under.add_child(vignette)
	vignette.connect('draw', self, '_draw_vignette', [vignette])
	var box = Rect2(cloud - RADII * 1.45, RADII * 2.9).clip(view.grow(40.0))
	for i in range(LAYERS.size()):
		for lit in [false, true]:
			var node = Node2D.new()
			var material_ = ShaderMaterial.new()
			material_.shader = shared.storm_cloud_lit if lit else shared.storm_cloud
			var ramp = RAMP_LIT if lit else LAYERS[i][6]
			material_.set_shader_param('ramp0', ramp[0])
			material_.set_shader_param('ramp1', ramp[1])
			material_.set_shader_param('ramp2', ramp[2])
			material_.set_shader_param('lit', 1.0 if lit else 0.0)
			material_.set_shader_param('tile', TEX_SIZE * LAYERS[i][1])
			material_.set_shader_param('center', cloud)
			material_.set_shader_param('radii', RADII)
			material_.set_shader_param('wobble_pos', view.position)
			material_.set_shader_param('wobble_size', WOBBLE_VIEW)
			node.material = material_
			node.visible = false
			under.add_child(node)
			node.connect('draw', self, '_draw_cloud', [node, box])
			cloud_nodes.append({node = node, layer = i, lit = lit, ready = false})
	bolts = add_layer(80, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_bolts')
	flash = add_layer(94, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_flash')


func _bake_rect(painter, job):
	painter.draw_texture_rect(shared.white, Rect2(Vector2(), job.size), false)


func _process(delta):
	if vignette == null: return
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	t += delta * rate
	tau = t
	bake_step()
	apply_shake()
	place_clouds()
	if tau != drawn_tau:
		drawn_tau = tau
		vignette.update()
		bolts.update()
		flash.update()
	if t >= end_t: queue_free()


#--- the cloud ---------------------------------------------------------------------------------------------------

func cover():
	return smooth01((tau - 0.3 * release) / (strike_t - 0.3 * release)) * (1.0 - smooth01((tau - strike_t - 0.3) / 1.2))


static func smooth01(x):
	return 0.5 - 0.5 * cos(PI * clamp(x, 0.0, 1.0))


func place_clouds():
	var cov = cover()
	var wobble = shared.baked.get('storm_wobble')
	var lights = cloud_lights()
	for cn in cloud_nodes:
		var node = cn.node
		var tex = shared.baked.get('storm_layer_%d' % cn.layer)
		if !cn.ready and tex != null and wobble != null:
			cn.ready = true
			node.material.set_shader_param('layer_tex', tex)
			node.material.set_shader_param('wobble_tex', wobble)
		node.visible = cn.ready and cov > 0.002 and (!cn.lit or !lights.empty())
		if !node.visible: continue
		var L = LAYERS[cn.layer]
		var m = node.material
		m.set_shader_param('offset', Vector2(-tau * L[2], L[3] + 9.0 * sin(tau * 0.25 + L[4])))
		m.set_shader_param('grow', lerp(0.45, 1.0, cov) * L[5] * (1.0 + 0.02 * sin(tau * 0.45 + L[4])))
		m.set_shader_param('alpha', min(1.0, 1.5 * cov))
		if cn.lit:
			for k in range(4):
				m.set_shader_param('light%d' % k, lights[k] if k < lights.size() else Plane(0, 0, 1, 0))


#the strikes and the sheet lightning light the cloud; the hits all come out of one point, so they add up there
func cloud_lights():
	var found = {}
	for s in strikes:
		var a = tau - s.t0
		if a < -s.leader or a > 0.35: continue
		var lv = 0.3 * clamp((a + s.leader) / s.leader, 0.0, 1.0) if a < 0.0 else strike_light(a) * (0.75 + 0.35 * min(1.5, s.w))
		var pl = found.get(s.from, Plane(s.from.x, s.from.y, 480.0 * sqrt(s.w), 0.0))
		pl.d += lv
		found[s.from] = pl
	for sh in sheets:
		var lv = sh.a * max(bump(tau, sh.t, sh.t + 0.02, sh.t + 0.14), 0.6 * bump(tau, sh.t + 0.1, sh.t + 0.12, sh.t + 0.24))
		if lv > 0.01: found[sh.pos] = Plane(sh.pos.x, sh.pos.y, sh.r, lv)
	var res = found.values()
	res.sort_custom(self, 'by_strength')
	return res


func by_strength(a, b):
	return a.d > b.d


func _draw_cloud(node, box):
	node.draw_rect(box, WHITE)


#the one cloud shades only the targets' side
func _draw_vignette(node):
	var cov = cover()
	if cov <= 0.002: return
	var col = fade(NIGHT, 0.75 * dark * cov)
	b_begin(node)
	b_ring(cloud + Vector2(0.0, 160.0), [0.0, 60.0, 900.0], [col, col, fade(NIGHT, 0.0)], 64)
	b_flush()


#--- the lightning -----------------------------------------------------------------------------------------------

#the return stroke and its restrikes: bright, then two weaker flickers
static func strike_light(a):
	return max(bump(a, 0.0, 0.012, 0.1), max(0.72 * bump(a, 0.075, 0.085, 0.17), 0.5 * bump(a, 0.17, 0.18, 0.3)))


#wide glows follow the bolt's shape, not its every kink
func thinned(pts, width):
	var step = int(clamp(width / 8.0, 1.0, 16.0))
	if step <= 1: return pts
	var res = []
	for i in range(0, pts.size(), step):
		res.append(pts[i])
	if res.back() != pts.back(): res.append(pts.back())
	return res


func band(pts, width, col, a, n = -1):
	if a <= 0.004: return
	var part = pts if n < 0 or n >= pts.size() else pts.slice(0, n - 1)
	b_band(thinned(part, width), width, fade(col, a))


func _draw_bolts(layer):
	b_begin(layer)
	var rings = []
	for s in strikes:
		draw_strike(s, rings)
	b_flush()
	for rg in rings:
		layer.draw_set_transform(rg[0], 0.0, Vector2(1.0, rg[2] / rg[1]))
		layer.draw_arc(Vector2(), rg[1], 0.0, TAU, 48, rg[3], rg[4], true)
	layer.draw_set_transform(Vector2(), 0.0, Vector2(1, 1))
	for tg in cards:
		var age = tau - tg.hit
		var fl = 0.5 * bump(age, 0.0, 0.015, 0.22)
		if fl <= 0.004 or !card_ok(tg.node): continue
		card_space(layer, tg.node)
		layer.draw_rect(tg.portrait, c8(200, 225, 255, fl))
	screen_space(layer)


func draw_strike(s, rings):
	var a = tau - s.t0
	if a < -s.leader or a > 0.65: return
	var W = s.w
	var geo = s.geo
	if a < 0.0:
		#the stepped leader feels its way down
		var f = clamp((a + s.leader) / s.leader, 0.0, 1.0)
		var n = int(max(2.0, floor(f * (geo.main.size() - 1)) + 1))
		band(geo.main, 9.0 * W, c8(120, 160, 255), 0.2, n)
		band(geo.main, 1.8 * W, c8(200, 225, 255), 0.55, n)
		for b in geo.branches:
			if f <= b.f: continue
			var bn = int(floor(clamp((f - b.f) / max(0.05, 1.0 - b.f) * 1.4, 0.0, 1.0) * (b.pts.size() - 1))) + 1
			band(b.pts, 1.2 * W * b.width * 2.0, c8(190, 215, 255), 0.35, bn)
		var tip = geo.main[n - 1]
		blob(tip, 12.0 * W, c8(150, 190, 255), 0.35)
		blob(tip, 4.0 * W, WHITE, 0.8)
		return
	var I = strike_light(a)
	var after = (1.0 - seg(a, 0.2, 0.62)) * 0.4
	var lvl = max(I, after * 0.45)
	for L in BLOOM:
		band(geo.main, L[2] * W, L[0], L[1] * lvl)
	for b in geo.branches:
		for k in range(2, BLOOM.size()):
			band(b.pts, BLOOM[k][2] * W * b.width, BLOOM[k][0], BLOOM[k][1] * I * 0.85)
	if I < 0.25 and after > 0.02: band(geo.main, 5.0 * W, c8(150, 110, 255), after * 0.7)
	if s.kind != 'trunk':
		var fl = bump(a, 0.0, 0.015, 0.22)
		var k = seg(a, 0.0, 0.34)
		if fl > 0.004:
			var R = 110.0 * W
			b_ring(s.to, [0.0, 0.3 * R, R], [c8(230, 242, 255, 0.9 * fl), c8(120, 170, 255, 0.5 * fl), c8(60, 90, 255, 0.0)], 32)
		if k < 1.0:
			var ok = out_cubic(k)
			rings.append([s.to + Vector2(0.0, 20.0), (26.0 + 170.0 * ok) * W, (10.0 + 60.0 * ok) * W, c8(170, 210, 255, 0.75 * (1.0 - k)), 6.0 * W * (1.0 - k) + 1.0])
		for sp in geo.sparks:
			if a >= sp.life: continue
			var p = s.to + sp.v * a + Vector2(0.0, 900.0 * a * a)
			b_line(p, p - Vector2(sp.v.x, sp.v.y + 1800.0 * a) * 0.028, 2.2 * W, c8(220, 238, 255, 0.9 * (1.0 - a / sp.life)))
	band(geo.main, 3.0 * W, WHITE, max(0.96 * I, after * 0.6))
	for b in geo.branches:
		band(b.pts, 3.0 * W * b.width, c8(236, 246, 255), 0.9 * I)


func _draw_flash(layer):
	var f = 0.0
	for s in strikes:
		var a = tau - s.t0
		if a >= 0.0 and a < 0.35: f = max(f, strike_light(a) * min(1.0, 0.3 + 0.35 * s.w))
	if f > 0.004: layer.draw_rect(view.grow(120.0), c8(150, 185, 255, 0.2 * f))


#--- the screen ------------------------------------------------------------------------------------

func apply_shake():
	if !(root is Control) or !is_instance_valid(root): return
	var best = null
	var mag = 0.0
	for s in strikes:
		var a = tau - s.t0
		if a < 0.0 or a >= 0.34: continue
		var m = shake_px * min(1.8, s.w) * (1.0 - a / 0.34)
		if m > mag:
			mag = m
			best = s
	if best == null:
		if shaking: root.rect_position = root_home
		shaking = false
		return
	shaking = true
	var tick = floor(t * 60.0)
	root.rect_position = root_home + Vector2(noise(best.t0 * 1000.0, tick, 1), noise(best.t0 * 1000.0 + 9.0, tick, 2)) * mag


func _exit_tree():
	if shaking and root is Control and is_instance_valid(root): root.rect_position = root_home
	if under != null and is_instance_valid(under): under.queue_free()
	under = null
