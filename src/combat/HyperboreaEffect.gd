extends "res://src/combat/FxNode.gd"
#Winds of Hyperborea

const FrozenCard = preload("res://src/combat/FrozenCard.gd")
const ClarityGlow = preload("res://src/combat/ClarityGlow.gd")
const DamageCounter = preload("res://src/combat/DamageCounter.gd")

const FONT_SIZE = 84
const VIEW_Y = 30.0
const SNOW_STEP = 0.005
const RAY_GAIN = 2.5
const STEEL = Color(0.588, 0.804, 1.0)
const AIR = Color(0.863, 0.933, 1.0)
const FLAKE = Color(0.925, 0.965, 1.0)
const COLD = Color(0.588, 0.753, 0.961)
const NAVY = Color(0.055, 0.11, 0.204)
const GREEN_RAYS = [Color(0.824, 1.0, 0.882), Color(0.314, 1.0, 0.627), Color(0.196, 0.804, 0.784), Color(0.51, 0.353, 0.863)]
const GOLD_RAYS = [Color(1.0, 0.98, 0.882), Color(1.0, 0.839, 0.471), Color(1.0, 0.667, 0.314), Color(0.784, 0.431, 0.235)]
#y, height, two waves (amplitude, frequency, speed), phase, texture scale, drift, strength, gold
const CURTAINS = [
	[215.0, 270.0, 34.0, 0.0042, 0.35, 14.0, 0.011, 0.6, 0.3, 0.55, 16.0, 0.85, false],
	[175.0, 220.0, 26.0, 0.0035, 0.28, 12.0, 0.009, 0.5, 2.1, 0.7, -11.0, 0.5, false],
	[235.0, 150.0, 30.0, 0.005, 0.4, 10.0, 0.013, 0.7, 4.2, 0.5, 22.0, 0.4, true],
]

const MIST_SHADER = """shader_type canvas_item;
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
void fragment() {
	vec2 p = vec2(UV.x * 6.0, UV.y * 2.2);
	float sum = 0.0;
	float amp = 0.5;
	float norm = 0.0;
	float f = 1.0;
	for (int k = 0; k < 4; k++) {
		sum += amp * vnoise(p * f, vec2(6.0, 64.0) * f, 311.0 + float(k) * 101.0);
		norm += amp;
		amp *= 0.5;
		f *= 2.0;
	}
	float z = (UV.y - 0.62) / 0.24;
	vec3 col = mix(vec3(0.549, 0.431, 1.0), vec3(0.275, 1.0, 0.667), clamp(UV.y * 1.25, 0.0, 1.0));
	COLOR = vec4(col * 0.85 * clamp((sum / norm - 0.34) * 2.4, 0.0, 1.0) * exp(-z * z), 1.0);
}
"""

const AURORA_SHADER = """shader_type canvas_item;
render_mode blend_add;
uniform sampler2D mist;
uniform sampler2D rays_green;
uniform sampler2D rays_gold;
uniform float tau = 0.0;
uniform float level = 0.0;
uniform float view_y = 30.0;
varying vec2 pos;

void vertex() {
	pos = VERTEX;
}

//the textures repeat, so v stays half a texel off the top and bottom rows
vec3 band(float x, float y, float base, float hgt, float u, float a) {
	float v = (y - (base - hgt)) / hgt;
	return vec3(u, clamp(v, 0.004, 0.996), (v >= 0.0 && v <= 1.0) ? clamp(a, 0.0, 1.0) : 0.0);
}

vec3 mist_pass(float x, float y, float p) {
	float base = view_y + 250.0 + 30.0 * sin(x * 0.003 + tau * 0.25 + p * 2.0) + 14.0 * sin(x * 0.008 - tau * 0.4 + p);
	float hgt = 300.0 + 60.0 * sin(x * 0.0025 + tau * 0.2 + p * 3.0);
	float drift = p > 0.5 ? -9.0 : 8.0;
	float a = level * (p > 0.5 ? 0.7 : 1.0) * (0.75 + 0.25 * sin(x * 0.002 - tau * 0.6 + p));
	return band(x, y, base, hgt, (x * 0.25 + tau * drift + p * 211.0) / 512.0, a);
}

vec3 curtain(float x, float y, float cy, float h, float a1, float k1, float w1, float a2, float k2, float w2, float ph, float sc, float drift, float al) {
	float base = view_y + cy + a1 * sin(x * k1 + tau * w1 + ph) + a2 * sin(x * k2 - tau * w2 + ph * 2.0);
	float hgt = h * (0.75 + 0.25 * sin(x * 0.004 + tau * 0.3 + ph));
	float glow = 0.55 + 0.45 * sin(x * 0.0031 - tau * 0.9 + ph) * sin(x * 0.0017 + tau * 0.5);
	return band(x, y, base, hgt, (x * sc + tau * drift) / 1024.0, level * al * glow);
}

void fragment() {
	vec3 m0 = mist_pass(pos.x, pos.y, 0.0);
	vec3 m1 = mist_pass(pos.x, pos.y, 1.0);
	vec3 c0 = curtain(pos.x, pos.y, 215.0, 270.0, 34.0, 0.0042, 0.35, 14.0, 0.011, 0.6, 0.3, 0.55, 16.0, 0.85);
	vec3 c1 = curtain(pos.x, pos.y, 175.0, 220.0, 26.0, 0.0035, 0.28, 12.0, 0.009, 0.5, 2.1, 0.7, -11.0, 0.5);
	vec3 c2 = curtain(pos.x, pos.y, 235.0, 150.0, 30.0, 0.005, 0.4, 10.0, 0.013, 0.7, 4.2, 0.5, 22.0, 0.4);
	vec3 col = texture(mist, m0.xy).rgb * m0.z + texture(mist, m1.xy).rgb * m1.z;
	col += texture(rays_green, c0.xy).rgb * c0.z + texture(rays_green, c1.xy).rgb * c1.z + texture(rays_gold, c2.xy).rgb * c2.z;
	COLOR = vec4(col, 1.0);
}
"""

const SNOW_SHADER = """shader_type canvas_item;
render_mode blend_mix;
uniform float tau = 0.0;
uniform float travel = 0.0;
uniform float wind = 0.0;
uniform float count = 0.0;
uniform float away = 1.0;
uniform vec2 view_pos = vec2(0.0, 0.0);
uniform vec2 view_size = vec2(1920.0, 1080.0);
uniform vec2 uv_white = vec2(0.95, 0.5);
uniform vec4 uv_soft = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 uv_puff = vec4(0.0, 0.0, 1.0, 1.0);
uniform float gold = 0.0;

void vertex() {
	float h1 = UV.x;
	float h2 = UV.y;
	float h3 = COLOR.r;
	float corner = floor(COLOR.g * 4.0 + 0.5);
	float q = COLOR.b;
	float i = floor(COLOR.a * 512.0 + 0.5);
	bool near = mod(i, 9.0) < 0.5;
	float W = 2240.0;
	float H = view_size.y + 20.0;
	float f = near ? 1.5 + 0.4 * h2 : 0.45 + 0.75 * h2;
	float dep = near ? 1.0 : (f - 0.45) / 0.75;
	float fall = (30.0 + 50.0 * h3) * f;
	float bl = min(near ? 130.0 : 90.0, wind * f * 0.024);
	vec2 p = vec2(-160.0 + mod(h1 * W + away * f * travel, W), view_pos.y - 10.0 + mod(h3 * H + fall * tau + 22.0 * sin(tau * (1.3 + 2.0 * h1) + i), H));
	vec2 d = vec2(away * bl, fall * 0.024);
	float s = near ? 2.0 + 2.0 * h1 : 0.7 + 1.5 * dep * (0.6 + 0.4 * h1);
	float a = near ? 0.7 : 0.22 + 0.6 * dep;
	float L = abs(d.x) + abs(d.y);
	vec2 k = vec2((corner > 0.5 && corner < 2.5) ? 1.0 : 0.0, corner > 1.5 ? 1.0 : 0.0);
	vec3 rgb = vec3(0.925, 0.965, 1.0);
	float alpha = 0.0;
	vec2 at = p;
	vec2 uv = uv_white;
	if (i < count) {
		if (gold > 0.5) {
			float r = q < 0.5 ? 6.0 + 4.0 * s : 1.0 + 0.5 * s;
			vec4 region = q < 0.5 ? uv_soft : uv_puff;
			rgb = q < 0.5 ? vec3(1.0, 0.8, 0.361) : vec3(1.0, 0.98, 0.886);
			alpha = q < 0.5 ? 0.4 * a : a;
			at = p + (k * 2.0 - 1.0) * r;
			uv = region.xy + k * region.zw;
		} else if (L > 3.0) {
			vec2 a0 = p;
			vec2 a1 = p - d;
			float w = s * 2.4;
			alpha = 0.14 * a;
			if (near && q > 0.5) {
				a1 = p - d * 0.8;
				w = s;
				alpha = 0.4 * a;
			} else if (!near) {
				a1 = q < 0.5 ? p - d * 0.4 : p - d;
				a0 = q < 0.5 ? p : p - d * 0.4;
				w = q < 0.5 ? s : s * 0.7;
				alpha = q < 0.5 ? a : 0.3 * a;
			}
			vec2 dir = normalize(a1 - a0);
			at = mix(a0, a1, k.x) + vec2(-dir.y, dir.x) * w * (0.5 - k.y);
		} else if (q < 0.5) {
			float r = near ? s * 1.8 : s * 0.92;
			vec4 region = near ? uv_soft : uv_puff;
			alpha = near ? 0.55 * a : a;
			at = p + (k * 2.0 - 1.0) * r;
			uv = region.xy + k * region.zw;
		}
	}
	VERTEX = at;
	UV = uv;
	COLOR = vec4(rgb, alpha);
}

//writing COLOR in vertex() turns off the texture the fragment would apply by itself
void fragment() {
	COLOR = texture(TEXTURE, UV) * COLOR;
}
"""

var time_rate = 1.0
var anim = null
var caster = null
var root = null
var root_home = Vector2()
var shaking = false
var targets = []
var allies = []
var under = null
var tints = []
var layers = {}
var view = Rect2(0, 0, 1920, 1080)
var away = 1.0
var home = Vector2()
var hand = Vector2()
var center = Vector2()
var portrait = Rect2(7, 27, 168, 143)
var card_size = Vector2(182, 202)

var rel = 1.15
var speed = 2000.0
var shake_px = 18.0
var hold = 0.45
var first = 0.0
var frozen = 0.0
var implode = 0.0
var burst = 0.0
var buff = 0.0
var calm = 0.0
var end_time = 0.0
var stops = []
var kicks = []
var lights = []
var waves = []
var flares = []
var sparks = []
var debris = []
var winds = []
var glints = []
var spikes = []
var snow_x = PoolRealArray()
var rng = RandomNumberGenerator.new()

var sheen = null
var crystal_nodes = []
var gleam = null
var haze = null
var snow_nodes = []
var drawn_tau = -1.0
var aurora_ready = false


#Winds of Hyperborea's part of the kit: the shaders of its mist, aurora and snow, and the fonts of its numbers
static func equip(kit):
	if kit.has('aurora'): return
	var mist = Shader.new()
	mist.code = MIST_SHADER
	var aurora = Shader.new()
	aurora.code = AURORA_SHADER
	var snow = Shader.new()
	snow.code = SNOW_SHADER
	var snow_gold = Shader.new()
	snow_gold.code = SNOW_SHADER.replace('blend_mix', 'blend_add')
	kit.mist = mist
	kit.aurora = aurora
	kit.snow = snow
	kit.snow_gold = snow_gold
	var fonts = DamageCounter.make_fonts(FONT_SIZE)
	kit.font = fonts.font
	kit.shadow_font = fonts.shadow


func setup(new_anim, caster_node, hit_nodes, ally_nodes, settings, combat_root, new_shared):
	anim = new_anim
	caster = caster_node
	root = combat_root
	use_kit(new_shared)
	rel = max(0.3, float(settings.release))
	speed = max(200.0, float(settings.wind))
	shake_px = float(settings.shake)
	hold = max(0.0, float(settings.hold))
	if root is Control: root_home = shake_home(root)
	view = screen_rect()
	if caster.has_method('get_attack_vector') and caster.get_attack_vector().x < 0.0: away = -1.0
	var r = local_rect(caster)
	card_size = r.size
	home = r.position + r.size / 2.0
	hand = home + Vector2(away * 70.0, -120.0)
	var icon = caster.get_node_or_null('Icon')
	if icon != null: portrait = Rect2(icon.rect_position, icon.rect_size)
	for node in hit_nodes:
		if node != null and is_instance_valid(node) and find_target(node) == null: add_target(node)
	for node in ally_nodes:
		if node != null and is_instance_valid(node): allies.append({node = node, index = allies.size(), at = 0.0})
	rng.seed = 7401
	plan(max(0.0, float(settings.stop)))
	queue_bakes()
	#the ice on each target freezes as the gale reaches the card and bursts off it with the damage
	for tg in targets:
		if tg.icon == null: continue
		tg.ice = FrozenCard.new()
		tg.ice.seal(tg.node, shared, {seed = 7300 + tg.index * 29, windward = away, host = self, z = 81, driven = true, fx = false,
			at = tg.ga, fling = tg.out})
		tg.ice.burst_at(tg.hit)
	for ally in allies:
		ally.glow = ClarityGlow.new()
		ally.glow.land(ally.node, shared, {at = ally.at, seed = ally.index, host = self, z = 86, driven = true})
	build_layers()
	set_process(true)


func add_target(node):
	var r = local_rect(node)
	var icon = node.get_node_or_null('Icon')
	var tg = {node = node, index = targets.size(), rect = r, cc = r.position + r.size / 2.0, icon = icon,
		icon_home = icon.rect_position if icon != null else Vector2(), pivot = node.rect_pivot_offset,
		rest = Vector2() if node.has_method('get_attack_vector') else node.rect_position,
		posed = false, ga = 0.0, hit = 0.0, out = Vector2(away, 0.0), flash = 0.0, flash_col = WHITE, ice = null, taken = null}
	targets.append(tg)


func find_target(node):
	for tg in targets:
		if tg.node == node: return tg
	return null


#the queue moves on to the damage at the burst
func lock_time():
	return to_real(burst)


#--- the plan: the mockup's planWindBurst, in its own numbers ----------------------------------------------

func plan(stop):
	var x0 = home.x + away * 100.0
	var lo = Vector2(INF, INF)
	var hi = Vector2(-INF, -INF)
	first = INF
	var last = -INF
	for tg in targets:
		var edge = tg.rect.position.x if away > 0.0 else tg.rect.end.x
		tg.ga = rel + abs(edge - x0) / speed
		first = min(first, tg.ga)
		last = max(last, tg.ga)
		lo = Vector2(min(lo.x, tg.rect.position.x), min(lo.y, tg.rect.position.y))
		hi = Vector2(max(hi.x, tg.rect.end.x), max(hi.y, tg.rect.end.y))
	if targets.empty():
		first = rel + 0.5
		last = first
		lo = home + Vector2(away * 1000.0, 0.0)
		hi = lo
	center = (lo + hi) / 2.0
	frozen = last + 0.2
	implode = frozen + 0.25
	burst = implode + 0.28
	buff = burst + 0.35
	calm = burst + 0.7
	end_time = burst + 2.35
	stops = [[rel + 0.02, stop * 0.6], [first + 0.06, stop * 0.5], [burst + 0.02, stop * 1.3]]
	stops.sort_custom(self, 'by_first')
	var gust = 0.0 if away > 0.0 else PI
	for tg in targets:
		var off = tg.cc - center
		tg.hit = burst + off.length() / 2800.0
		tg.out = off.normalized() if off.length() > 1.0 else Vector2(away, 0.0)
		var ang = tg.out.angle()
		flares.append(new_flare(tg.cc, gust, tg.ga, 34.0, 0.16, 7420 + tg.index * 13, 10, ICE, false, true))
		sparks.append({at = tg.ga, pos = tg.cc, n = 14, ang = gust, spread = 2.6, power = 0.8, pal = ICE})
		flares.append(new_flare(tg.cc, ang, tg.hit, 46.0, 0.2, 7400 + tg.index * 13, 10, ICE, false, true))
		sparks.append({at = tg.hit, pos = tg.cc, n = 22, ang = ang, spread = 2.2, power = 1.3, pal = ICE})
		sparks.append({at = tg.hit, pos = tg.cc, n = 8, ang = ang, spread = 1.4, power = 0.9, pal = GOLD})
		debris.append({pos = tg.cc, t0 = tg.hit, n = 16, ang = ang, spread = 1.6, power = 1.4, size = 8.0})
	for i in range(16):
		var th = TAU * (i + rng.randf()) / 16.0
		var r0 = 520.0 + 200.0 * rng.randf()
		var pts = []
		for s in range(13):
			var r = r0 * (1.0 - s / 12.0) + 20.0
			pts.append(center + Vector2(r * cos(th), 0.7 * r * sin(th)))
		winds.append({pts = pts, t0 = implode + 0.08 * rng.randf(), dur = burst - implode, len = 0.45, w = 1.6 + 2.0 * rng.randf(), al = 0.55})
	waves.append({pos = center, t0 = implode, dur = burst - implode, r0 = 760.0, r1 = 40.0, w = 110.0, al = 0.35, col = c8(200, 235, 255)})
	glints.append({pos = center, t0 = implode, t1 = burst + 0.06, s = 70.0, pal = ICE})
	waves.append({pos = center, t0 = burst, dur = 0.6, r0 = 40.0, r1 = 1100.0, w = 140.0, al = 0.5, col = c8(210, 238, 255)})
	waves.append({pos = center, t0 = burst + 0.08, dur = 0.7, r0 = 30.0, r1 = 800.0, w = 90.0, al = 0.35, col = GOLD[1]})
	flares.append(new_flare(center, 0.0, burst, 90.0, 0.3, 7060, 12, ICE, true, false))
	for i in range(14):
		spikes.append(new_spike(TAU * (i + 0.5 * rng.randf()) / 14.0, 190.0 + 190.0 * rng.randf(), 13.0 + 10.0 * rng.randf()))
	debris.append({pos = center, t0 = burst + 0.9, n = 30, ang = -PI / 2.0, spread = TAU, power = 0.9, size = 8.0})
	sparks.append({at = burst, pos = center, n = 40, ang = 0.0, spread = TAU, power = 2.0, pal = ICE})
	kicks.append({at = burst, mag = 2.4, dur = 0.8, dir = null})
	waves.append({pos = home, t0 = buff, dur = 0.5, r0 = 30.0, r1 = 620.0, w = 90.0, al = 0.45, col = GOLD[1]})
	flares.append(new_flare(home - Vector2(0.0, 30.0), 0.0, buff, 46.0, 0.22, 7080, 8, GOLD, true, false))
	for ally in allies:
		var ar = local_rect(ally.node)
		ally.at = buff + (ar.position + ar.size / 2.0 - home).length() / 2600.0
	lights.append({pos = hand, t0 = 0.3, dur = rel - 0.3, r = 300.0, col = GOLD[1], al = 0.28})
	glints.append({pos = hand, t0 = rel - 0.7, t1 = rel + 0.12, s = 44.0, pal = GOLD})
	waves.append({pos = home, t0 = rel, dur = 0.7, r0 = 40.0, r1 = 1400.0, w = 130.0, al = 0.35, col = c8(200, 235, 255)})
	flares.append(new_flare(hand, 0.0, rel, 60.0, 0.24, 7050, 8, GOLD, true, false))
	kicks.append({at = rel, mag = 1.6, dur = 0.7, dir = Vector2(away, 0.0)})
	gust_streaks(30, rel, frozen - 0.1)
	build_snow_track()


func by_first(a, b):
	return a[0] < b[0]


func new_spike(ang, length, width):
	var cracks = []
	for k in range(1 + int(rng.randf() * 2.0)):
		cracks.append([Vector2(rng.randf() * 2.0 - 1.0, 0.1 + 0.5 * rng.randf()), Vector2(rng.randf() * 2.0 - 1.0, 0.35 + 0.45 * rng.randf())])
	var bubbles = []
	for k in range(4):
		bubbles.append(Vector3(rng.randf() * 1.4 - 0.7, 0.1 + 0.6 * rng.randf(), 0.6 + 1.2 * rng.randf()))
	return {ang = ang, len = length, w = width, tip = (rng.randf() - 0.5) * 0.5, lit = rng.randf(), tw = TAU * rng.randf(),
		cracks = cracks, bubbles = bubbles}


func gust_streaks(n, t0, t1):
	for i in range(n):
		var lane = view.position.y + 60.0 + (view.size.y - 100.0) * rng.randf()
		var amp = 12.0 + 30.0 * rng.randf()
		var wl = 500.0 + 500.0 * rng.randf()
		var ph = TAU * rng.randf()
		var pts = []
		for k in range(31):
			var x = lerp(-300.0, 2220.0, k / 30.0) if away > 0.0 else lerp(2220.0, -300.0, k / 30.0)
			pts.append(Vector2(x, lane + amp * sin(TAU * x / wl + ph)))
		winds.append({pts = pts, t0 = lerp(t0, t1, (i + 0.8 * rng.randf()) / n), dur = 0.7 * (0.8 + 0.5 * rng.randf()),
			len = 0.18 + 0.2 * rng.randf(), w = 1.2 + 2.4 * rng.randf(), al = 0.25 + 0.35 * rng.randf()})


func snow_speed(time):
	return 50.0 + 1950.0 * out_cubic(seg(time, rel, rel + 0.15)) * (1.0 - inout_quad(seg(time, frozen - 0.2, implode)))


func build_snow_track():
	var track = [0.0]
	var n = int(ceil((end_time + 1.0) / SNOW_STEP)) + 1
	var x = 0.0
	for i in range(1, n + 1):
		x += snow_speed((i - 0.5) * SNOW_STEP) * SNOW_STEP
		track.append(x)
	snow_x = PoolRealArray(track)


func snow_at(time):
	var f = clamp(time / SNOW_STEP, 0.0, snow_x.size() - 2)
	var i = int(f)
	return lerp(snow_x[i], snow_x[i + 1], f - i)


func front(time):
	return home.x + away * 100.0 + away * speed * max(0.0, time - rel)


#--- levels over time ----------------------------------------------------------------------------------------

func calm_k(time):
	return 1.0 - seg(time, calm, calm + 0.9)


func cold(time):
	return (0.35 * inout_quad(seg(time, 0.1, rel)) + 0.25 * seg(time, rel, rel + 0.3)) * calm_k(time)


func dim(time):
	return 0.3 * seg(time, 0.1, rel) * calm_k(time)


func frost_level(time):
	return (0.3 * seg(time, 0.15, rel) + 0.5 * out_cubic(seg(time, rel, rel + 0.9))) * calm_k(time)


func aurora_level(time):
	return inout_quad(seg(time, 0.2, rel + 0.2)) * calm_k(time)


func snow_density(time):
	return (0.3 * seg(time, 0.1, 0.5) + 0.7 * seg(time, rel, rel + 0.1) - 0.4 * seg(time, implode, burst + 0.6)) * calm_k(time)


func speed_level(time):
	return 0.7 * bump(time, rel, rel + 0.05, frozen - 0.2)


func flash_level(time):
	return max(0.4 * bump(time, rel, rel + 0.02, rel + 0.25), 0.6 * bump(time, burst, burst + 0.02, burst + 0.3))


#hit-stops: the clock stands still at each stop for its length
func to_anim(time):
	var acc = 0.0
	for s in stops:
		var at = s[0] + acc
		if time <= at: break
		if time < at + s[1]: return s[0]
		acc += s[1]
	return time - acc


func to_real(time):
	var acc = 0.0
	for s in stops:
		if time <= s[0]: break
		acc += s[1]
	return time + acc


#--- the damage ----------------------------------------------------------------------------------------------

#the target's hp_update, handed over: the number, bar and label wait for the ice to burst; returns the lock
func take_hit(node, args, crit):
	var tg = find_target(node)
	if tg == null: return 0.0
	var at = max(t, to_real(tg.hit))
	var hpnode = node.get_node_or_null('bars/HP')
	tg.taken = {at = at, text = str(ceil(args.damage)) + ('!' if crit else ''), crit = crit,
		color = Color(1, 0.8, 0) if crit else args.get('color', Color(0.8, 0.2, 0.2)),
		newhp = args.newhp, newhpp = args.newhpp, hpnode = hpnode, old = hpnode.value if hpnode != null else 0.0,
		applied = false, done = false}
	if anim != null and is_instance_valid(anim) and anim.has_method('damage_flash'): anim.damage_flash(node, at - t)
	return at - t + hold


func update_numbers():
	for tg in targets:
		var tk = tg.taken
		if tk == null or tk.done or t < tk.at: continue
		if !is_instance_valid(tg.node) or tg.node.get('fighter') == null:
			tk.done = true
			continue
		if !tk.applied:
			tk.applied = true
			tg.node.update_hp_label(tk.newhp, tk.newhpp)
		var k = seg(t, tk.at, tk.at + 0.3)
		if tk.hpnode != null and is_instance_valid(tk.hpnode): tk.hpnode.value = lerp(tk.old, tk.newhpp, k)
		if k >= 1.0: tk.done = true


#--- the clock -------------------------------------------------------------------------------------------------

func _process(delta):
	var rate = time_rate
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	t += delta * rate
	tau = to_anim(t)
	bake_step()
	if caster != null and !is_instance_valid(caster): caster = null
	for tg in targets:
		pose_card(tg)
		if is_instance_valid(tg.ice): tg.ice.advance(tau)
	for ally in allies:
		if is_instance_valid(ally.glow): ally.glow.advance(tau)
	update_numbers()
	apply_shake()
	place_statics()
	redraw()
	if t >= to_real(end_time): queue_free()


func pose_card(tg):
	var node = tg.node
	if !is_instance_valid(node): return
	var px = 0.0
	var py = 0.0
	var sq = 0.0
	var fl = 0.0
	var hot = 0.0
	var jit = 0.0
	var a = tau - tg.hit
	if a >= 0.0 and a <= 0.9:
		var k = out_quad(a / 0.035) if a < 0.035 else exp(-(a - 0.035) * 7.0) * cos((a - 0.035) * 13.0)
		px = tg.out.x * 45.0 * k
		py = tg.out.y * 45.0 * k
		sq = 0.12 * bump(a, 0.0, 0.02, 0.22)
		fl = 0.72 * bump(a, 0.0, 0.012, 0.28)
		if a < 0.04: hot = 1.0
		jit = 7.0 * (1.0 - seg(a, 0.0, 0.3))
	var f = tau - tg.ga
	if f >= 0.0 and f < 0.14:
		fl = max(fl, 0.25 * (1.0 - f / 0.14))
		jit = max(jit, 3.0)
	var tick = floor(tau * 60.0)
	var mx = 0.0
	var my = 0.0
	if tau > tg.ga - 0.04 and tau < tg.ga + 0.2:
		var q = 4.0 * (1.0 - seg(tau, tg.ga, tg.ga + 0.2))
		mx = noise(tg.index * 11, tick, 1) * q
		my = noise(tg.index * 11 + 5, tick, 2) * q
	tg.flash = fl
	tg.flash_col = STEEL.linear_interpolate(WHITE, hot)
	var mag = Vector2(px, py).length()
	if mag > 70.0:
		px *= 70.0 / mag
		py *= 70.0 / mag
	if abs(px) + abs(py) + abs(mx) + abs(my) + sq <= 0.05 and jit <= 0.0:
		if tg.posed: rest_card(tg)
		return
	if !tg.posed:
		tg.posed = true
		node.rect_pivot_offset = node.rect_size / 2.0
	var sqx = abs(tg.out.x)
	var sqy = abs(tg.out.y)
	node.rect_position = tg.rest + Vector2(px + mx, py + my)
	node.rect_rotation = 2.2 * px / 30.0
	node.rect_scale = Vector2(1.0 - sq * sqx + 0.5 * sq * sqy, 1.0 - sq * sqy + 0.5 * sq * sqx)
	if tg.icon != null and is_instance_valid(tg.icon):
		tg.icon.rect_position = tg.icon_home + Vector2(noise(tg.index * 7, tick, 0), noise(tg.index * 7 + 3, tick, 0)) * jit


func rest_card(tg):
	tg.posed = false
	var node = tg.node
	if !is_instance_valid(node): return
	node.rect_position = tg.rest
	node.rect_rotation = 0.0
	node.rect_scale = Vector2(1, 1)
	node.rect_pivot_offset = tg.pivot
	if tg.icon != null and is_instance_valid(tg.icon): tg.icon.rect_position = tg.icon_home


func apply_shake():
	if !(root is Control) or !is_instance_valid(root): return
	var best = 0.0
	var dir = null
	for k in kicks:
		var a = t - to_real(k.at)
		if a < 0.0 or a >= k.dur: continue
		var m = shake_px * k.mag * pow(1.0 - a / k.dur, 1.5)
		if m > best:
			best = m
			dir = k.dir
	if best <= 0.01:
		if shaking: root.rect_position = root_home
		shaking = false
		return
	shaking = true
	var tick = floor(t * 60.0)
	var n1 = noise(57, tick, 1)
	var n2 = noise(57, tick, 2)
	var offset = Vector2(n1, n2) * best
	if dir != null: offset = Vector2(n1 * dir.x - 0.35 * n2 * dir.y, n1 * dir.y + 0.35 * n2 * dir.x) * best
	root.rect_position = root_home + offset


func _exit_tree():
	for tg in targets:
		if tg.posed: rest_card(tg)
		var tk = tg.taken
		if tk != null and !tk.done and is_instance_valid(tg.node) and tg.node.get('fighter') != null:
			if tk.hpnode != null and is_instance_valid(tk.hpnode): tk.hpnode.value = tk.newhpp
			tg.node.update_hp_label(tk.newhp, tk.newhpp)
			tk.done = true
	if root is Control and is_instance_valid(root): root.rect_position = root_home
	if under != null and is_instance_valid(under): under.queue_free()
	under = null
	for node in tints:
		if is_instance_valid(node): node.queue_free()
	tints = []


#--- layers ----------------------------------------------------------------------------------------------------
#GDScript drawing was the cost of a frame: what does not change is drawn once into its own node and only moved
#and faded, the aurora and the snow are shaders

func build_layers():
	var add = CanvasItemMaterial.BLEND_MODE_ADD
	layers.sky = add_layer(80, add, '_draw_sky')
	layers.glow = add_layer(86, add, '_draw_nothing')
	layers.crystals = add_layer(87, -1, '_draw_nothing')
	layers.crystal_light = add_layer(88, add, '_draw_crystal_light')
	layers.air = add_layer(89, -1, '_draw_air')
	layers.air_light = add_layer(90, add, '_draw_air_light')
	layers.haze = add_layer(91, add, '_draw_nothing')
	layers.frost = add_layer(92, -1, '_draw_frost', shared.cover)
	layers.flash = add_layer(94, add, '_draw_flash')
	layers.numbers = add_layer(96, -1, '_draw_numbers')
	sheen = static_node(layers.glow, '_draw_sheen', null)
	crystal_nodes = [static_node(layers.crystals, '_draw_crystal_body', null), static_node(layers.crystal_light, '_draw_crystal_shine', null)]
	gleam = static_node(layers.crystal_light, '_draw_crystal_gleam', null)
	haze = static_node(layers.haze, '_draw_haze_ring', null)
	snow_nodes = [static_node(layers.air, '_draw_snow_mesh', false, shared.snow), static_node(layers.air_light, '_draw_snow_mesh', true, shared.snow_gold)]
	snow_nodes[1].material.set_shader_param('gold', 1.0)
	for node in snow_nodes:
		var m = node.material
		m.set_shader_param('away', away)
		m.set_shader_param('view_pos', view.position)
		m.set_shader_param('view_size', view.size)
		m.set_shader_param('uv_white', UV_WHITE)
		m.set_shader_param('uv_soft', Plane(UV_SOFT.position.x, UV_SOFT.position.y, UV_SOFT.size.x, UV_SOFT.size.y))
		m.set_shader_param('uv_puff', Plane(UV_PUFF.position.x, UV_PUFF.position.y, UV_PUFF.size.x, UV_PUFF.size.y))
	if root == null: return
	#the aurora goes under the panels; the flashes of the blows and the cold over the cards, under the rest of the UI
	var backdrop = root.get_node_or_null('Background')
	if backdrop != null:
		under = Node2D.new()
		var aurora = ShaderMaterial.new()
		aurora.shader = shared.aurora
		aurora.set_shader_param('view_y', VIEW_Y)
		under.material = aurora
		under.visible = false
		root.add_child_below_node(backdrop, under)
		under.connect('draw', self, '_draw_aurora', [under])
	var prev = root.get_node_or_null('Panel2')
	if prev == null: return
	for spec in [[add, '_draw_card_flash'], [-1, '_draw_dim'], [CanvasItemMaterial.BLEND_MODE_MUL, '_draw_cold_mul'], [add, '_draw_cold_add']]:
		var node = Node2D.new()
		if spec[0] >= 0: node.material = blend(spec[0])
		root.add_child_below_node(prev, node)
		node.connect('draw', self, spec[1], [node])
		tints.append(node)
		prev = node


#a hit-stop holds the clock, and the layers drawn every frame keep their last drawing through it
func place_statics():
	var g = seg(tau, 0.4 * rel, rel) * calm_k(tau)
	sheen.visible = g > 0.01 and caster != null and card_ok(caster)
	if sheen.visible:
		sheen.transform = card_xform(caster)
		sheen.modulate.a = g
	var up = crystal_up()
	for node in crystal_nodes + [gleam]:
		node.visible = up > 0.0
		node.transform = Transform2D(Vector2(up, 0.0), Vector2(0.0, up), center * (1.0 - up))
	gleam.modulate.a = bump(tau, burst + 0.15, burst + 0.3, burst + 0.6)
	gleam.visible = up > 0.0 and gleam.modulate.a > 0.01
	var L = frost_level(tau)
	haze.visible = L > 0.01
	haze.modulate.a = L
	if under != null and is_instance_valid(under):
		var aurora = under.material
		if !aurora_ready and shared.baked.has('mist') and shared.baked.has('rays_green') and shared.baked.has('rays_gold'):
			aurora_ready = true
			for key in ['mist', 'rays_green', 'rays_gold']:
				aurora.set_shader_param(key, shared.baked[key])
		var level = aurora_level(tau)
		under.visible = aurora_ready and level > 0.01
		aurora.set_shader_param('tau', tau)
		aurora.set_shader_param('level', level)
	var count = round(300.0 * clamp(snow_density(tau), 0.0, 1.0))
	for node in snow_nodes:
		node.visible = count > 0.0
		var m = node.material
		m.set_shader_param('tau', tau)
		m.set_shader_param('travel', snow_at(tau))
		m.set_shader_param('wind', snow_speed(tau))
		m.set_shader_param('count', count)


func redraw():
	var moving = tau != drawn_tau
	drawn_tau = tau
	for key in layers:
		if moving or key == 'numbers' or key == 'sky': layers[key].update()
	for node in tints:
		if is_instance_valid(node): node.update()


func _draw_aurora(node):
	node.draw_rect(Rect2(-40.0, -140.0, 2000.0, 480.0), WHITE)


#under the cold, like the cards themselves
func _draw_card_flash(node):
	for tg in targets:
		if tg.flash <= 0.004 or !card_ok(tg.node): continue
		card_space(node, tg.node)
		node.draw_rect(portrait, fade(tg.flash_col, tg.flash))
	screen_space(node)


func _draw_dim(node):
	var dm = dim(tau)
	if dm > 0.005: tint_frame(node, Color(0, 0, 0, dm))


func _draw_cold_mul(node):
	var c = cold(tau)
	if c > 0.005: tint_frame(node, WHITE.linear_interpolate(COLD, 0.6 * c))


func _draw_cold_add(node):
	var c = cold(tau)
	if c > 0.005: tint_frame(node, fade(NAVY, 0.4 * c))


func tint_frame(node, col):
	var outer = view.grow(120.0)
	if caster == null or !card_ok(caster):
		node.draw_rect(outer, col)
		return
	var xf = node.get_global_transform().affine_inverse() * caster.get_global_transform()
	var s = caster.rect_size
	var q = [xf.xform(Vector2()), xf.xform(Vector2(s.x, 0.0)), xf.xform(s), xf.xform(Vector2(0.0, s.y))]
	var o = [outer.position, Vector2(outer.end.x, outer.position.y), outer.end, Vector2(outer.position.x, outer.end.y)]
	for i in range(4):
		var j = (i + 1) % 4
		node.draw_primitive(PoolVector2Array([o[i], o[j], q[j], q[i]]), PoolColorArray([col]), PoolVector2Array())


func _draw_sky(layer):
	for lt in lights:
		var a = tau - lt.t0
		if a < 0.0 or a > lt.dur: continue
		var k = seg(a, 0.0, 0.08) * (1.0 - seg(a, lt.dur - 0.12, lt.dur)) * (0.85 + 0.15 * sin(tau * 29.0))
		d_blob(layer, lt.pos, lt.r, lt.col, lt.al * k)
	b_begin(layer)
	for wv in waves:
		draw_wave(wv)
	b_flush()
	var level = speed_level(tau)
	if level > 0.01:
		for i in range(28):
			var y = view.position.y + 20.0 + (view.size.y - 40.0) * hash01(i + 1200)
			var length = 220.0 + 420.0 * hash01(i + 1201)
			var run = fposmod(hash01(i + 1203) + t * (2600.0 + 1800.0 * hash01(i + 1202)) / 2600.0, 1.0) * 2600.0
			var x = run - 340.0 if away > 0.0 else 2260.0 - run
			layer.draw_line(Vector2(x, y), Vector2(x - away * length, y), fade(WHITE, 0.16 * level * (0.5 + 0.5 * hash01(i + 1204))), 1.0 + 2.0 * hash01(i + 1205))


func draw_wave(wv):
	var a = tau - wv.t0
	if a < 0.0 or a > wv.dur: return
	var q = a / wv.dur
	var r = lerp(wv.r0, wv.r1, q)
	var w = wv.w * (0.6 + 0.8 * q)
	var al = wv.al * (1.0 - q) * seg(a, 0.0, 0.02)
	var R = r + w * 0.3
	if R < 1.0 or al <= 0.004: return
	var r0 = max(0.0, r - w)
	b_ring(wv.pos, [r0, r0 + 0.75 * (R - r0), R], [fade(wv.col, 0.0), fade(wv.col, al), fade(wv.col, 0.0)], 40)


func _draw_sheen(node, _arg):
	b_begin(node)
	b_stripe(Rect2(4.0, 4.0, card_size.x - 8.0, card_size.y - 8.0), card_size / 2.0, Vector2(cos(-0.6), sin(-0.6)),
		[52.0, 76.0, 100.0], [fade(STEEL, 0.0), fade(WHITE, 0.85), fade(STEEL, 0.0)])
	b_flush()


#--- the star of ice: drawn once at full length, grown from the middle of the burst ----------------------------

func crystal_up():
	var a = tau - burst
	if a < 0.0 or tau >= burst + 0.9: return -1.0
	return out_back(clamp(a / 0.14, 0.0, 1.0))


#a point of a crystal: `across` in half widths from its axis, `along` as a share of its length
func spike_at(c, across, along):
	var cs = Vector2(cos(c.ang), sin(c.ang))
	return center + cs * c.len * along + Vector2(-cs.y, cs.x) * c.w * across


func spike_side(c, k):
	return center + Vector2(cos(c.ang), sin(c.ang)) * c.len * 0.8 + Vector2(-sin(c.ang), cos(c.ang)) * c.w * k * 0.92


func spike_tip(c):
	return spike_at(c, c.tip, 1.0)


func lit_side(c):
	return 1.0 if -sin(c.ang) * -0.6 + cos(c.ang) * -0.8 > 0.0 else -1.0


func ridge(c, k, col, width):
	b_polyline([spike_at(c, k, 0.0), spike_side(c, k), spike_tip(c)], width, col)


func _draw_crystal_body(node, _arg):
	b_begin(node)
	for c in spikes:
		var T = spike_tip(c)
		var B0 = spike_at(c, -1.0, 0.0)
		var B1 = spike_at(c, 1.0, 0.0)
		var S0 = spike_side(c, -1.0)
		var S1 = spike_side(c, 1.0)
		var c1 = c8(140, 205, 240, 0.28)
		var cs = c1.linear_interpolate(c8(225, 245, 255, 0.42), 0.35 / 0.55)
		b_mesh([B0, B1, B0.linear_interpolate(S0, 0.45 / 0.8), B1.linear_interpolate(S1, 0.45 / 0.8), S0, S1, T],
			[c8(40, 110, 165, 0.6), c8(40, 110, 165, 0.6), c1, c1, cs, cs, c8(225, 245, 255, 0.42)],
			[0, 1, 3, 0, 3, 2, 2, 3, 5, 2, 5, 4, 4, 5, 6])
		var lit = lit_side(c)
		var face_lit = PoolVector2Array([B0, spike_at(c, -0.35, 0.0), spike_side(c, -0.35), T, S0])
		var face_dark = PoolVector2Array([spike_at(c, 0.35, 0.0), B1, S1, T, spike_side(c, 0.35)])
		if lit > 0.0:
			var swap = face_lit
			face_lit = face_dark
			face_dark = swap
		b_poly(face_lit, fade(WHITE, 0.1 + 0.08 * c.lit))
		b_poly(face_dark, c8(10, 40, 80, 0.2))
		b_line(spike_at(c, 0.0, 0.0), spike_at(c, 0.0, 0.7), c.w * 0.5, fade(WHITE, 0.12))
		for cr in c.cracks:
			b_line(spike_at(c, cr[0].x, cr[0].y), spike_at(c, cr[1].x, cr[1].y), 0.8, fade(WHITE, 0.35))
		for bu in c.bubbles:
			b_circle(spike_at(c, bu.x, bu.y), bu.z, 0.5, fade(WHITE, 0.4))
		var e = 1.25 / c.w
		b_polyline([spike_at(c, -1.0 + e, 0.0), spike_side(c, -1.0 + e / 0.92), T - Vector2(cos(c.ang), sin(c.ang)) * 1.5,
			spike_side(c, 1.0 - e / 0.92), spike_at(c, 1.0 - e, 0.0)], 2.5, c8(230, 248, 255, 0.28), true)
		ridge(c, -0.35, fade(WHITE, 0.4), 0.8)
		ridge(c, 0.35, fade(WHITE, 0.4), 0.8)
		ridge(c, lit, c8(245, 252, 255, 0.9), 1.3)
		ridge(c, -lit, c8(20, 55, 100, 0.5), 1.0)
	b_flush()


func _draw_crystal_shine(node, _arg):
	b_begin(node)
	for c in spikes:
		var lit = lit_side(c)
		b_line(spike_at(c, lit * 0.65, 0.5), spike_at(c, lit * 0.6, 0.72), 1.6, fade(WHITE, 0.75))
	b_flush()


func _draw_crystal_gleam(node, _arg):
	b_begin(node)
	for c in spikes:
		var lit = lit_side(c)
		var T = spike_tip(c)
		ridge(c, lit, fade(GOLD[1], 0.9), 2.6)
		ridge(c, 0.35 * lit, fade(GOLD[0], 0.7), 1.0)
		blob(T, 20.0, GOLD[1], 0.55)
		star4(T, 12.0, 0.2, GOLD[0], 0.95)
	b_flush()


func _draw_crystal_light(layer):
	var up = crystal_up()
	if up <= 0.0: return
	for c in spikes:
		var tw = 0.5 + 0.5 * sin(tau * 3.0 + c.tw)
		if tw > 0.75: d_star4(layer, center + (spike_tip(c) - center) * up, 7.0 * (tw - 0.75) * 4.0, 0.4, WHITE, 0.9 * (tw - 0.75) * 4.0)


#--- the air -------------------------------------------------------------------------------------------------

func _draw_air(layer):
	spray(layer)
	var a = tau - burst
	if a >= 0.0 and a <= 0.5:
		var q = a / 0.5
		var r = lerp(60.0, 320.0, out_cubic(q))
		var al = (1.0 - q) * (1.0 - q) * seg(a, 0.0, 0.03)
		var col = c8(235, 240, 245)
		b_begin(layer)
		b_ring(center, [r * 0.2, r * 0.76, r * 0.92, r], [fade(col, 0.0), fade(col, 0.5 * al), c8(250, 252, 255, 0.8 * al), fade(col, 0.0)], 40)
		b_flush()
	for di in range(debris.size()):
		slivers(layer, debris[di], di)


func _draw_air_light(layer):
	for wd in winds:
		wind(layer, wd)
	for gt in glints:
		glint(layer, gt)
	for i in range(sparks.size()):
		burst_sparks(layer, sparks[i], i)
	for f in flares:
		flare(layer, f)


func spray(layer):
	var t1 = rel + 1.1
	if tau < rel or tau > t1 + 0.8: return
	var xf = front(tau)
	var f = 1.0 - seg(tau, t1, t1 + 0.8)
	for i in range(22):
		var h1 = hash01(9500 + i)
		var y = view.position.y - 20.0 + (view.size.y + 40.0) * (i + h1) / 22.0
		d_puff(layer, Vector2(xf - away * (30.0 + 90.0 * h1) + 24.0 * sin(tau * 6.0 + i), y), 70.0 + 70.0 * hash01(9530 + i), c8(240, 247, 255), 0.2 * f)
	for i in range(30):
		var lag = 0.08 + 0.5 * hash01(9600 + i)
		if tau - lag < rel: continue
		var p = Vector2(front(tau - lag) - away * 40.0 * hash01(9630 + i), view.position.y + (view.size.y + 20.0) * hash01(9660 + i) + 20.0 * sin(tau * 3.0 + i))
		d_puff(layer, p, 30.0 + 40.0 * hash01(9690 + i), c8(235, 244, 255), 0.12 * (1.0 - lag / 0.6) * f)


#each flake carries its random numbers, corner and index for the shader
func _draw_snow_mesh(node, gold):
	var points = PoolVector2Array()
	var colors = PoolColorArray()
	var uvs = PoolVector2Array()
	var indices = PoolIntArray()
	for i in range(300):
		var near = i % 9 == 0
		if (!near and i % 13 == 0) != gold: continue
		var h1 = hash01(i * 3 + 7001)
		var h2 = hash01(i * 3 + 7002)
		var h3 = hash01(i * 3 + 7003)
		var rest = view.position + view.size * Vector2(h1, h3)
		for q in range(2):
			var n = points.size()
			for corner in range(4):
				points.append(rest)
				colors.append(Color(h3, corner / 4.0, q, i / 512.0))
				uvs.append(Vector2(h1, h2))
			indices.append_array(PoolIntArray([n, n + 1, n + 2, n, n + 2, n + 3]))
	VisualServer.canvas_item_add_triangle_array(node.get_canvas_item(), indices, points, colors, uvs, PoolIntArray(), PoolRealArray(), shared.atlas.get_rid())


func wind(layer, wd):
	var a = tau - wd.t0
	if a < 0.0 or a > wd.dur: return
	var head = a / wd.dur * (1.0 + wd.len)
	var tail = head - wd.len
	var u0 = max(0.0, tail)
	var u1 = min(1.0, head)
	if u1 <= u0: return
	var n = wd.pts.size() - 1
	var pts = PoolVector2Array()
	var haze_cols = PoolColorArray()
	var line_cols = PoolColorArray()
	for j in range(13):
		var u = lerp(u0, u1, j / 12.0)
		var f = u * n
		var i = int(min(n - 1, floor(f)))
		pts.append(wd.pts[i].linear_interpolate(wd.pts[i + 1], f - i))
		var k = sin(PI * clamp((u - tail) / wd.len, 0.0, 1.0))
		haze_cols.append(fade(AIR, 0.1 * wd.al * k))
		line_cols.append(fade(AIR, 0.9 * wd.al * k))
	layer.draw_polyline_colors(pts, haze_cols, 2.0 + 3.5 * wd.w)
	layer.draw_polyline_colors(pts, line_cols, 0.4 + 0.5 * wd.w, true)


func glint(layer, gt):
	if tau < gt.t0 or tau > gt.t1: return
	var k = seg(tau, gt.t0, gt.t1 - 0.12)
	var o = 1.0 - seg(tau, gt.t1 - 0.12, gt.t1)
	var sz = gt.s * k
	d_blob(layer, gt.pos, 24.0 + sz * 1.6, gt.pal[1], 0.5 * k * o)
	d_star4(layer, gt.pos, 10.0 + sz * 0.8, tau * 1.4, gt.pal[0], 0.9 * k * o)
	d_star4(layer, gt.pos, 6.0 + sz * 0.45, 0.4 - tau * 0.9, WHITE, 0.7 * k * o)


#--- frost on the screen's edges, a cold haze hugging them; the frost shows in feathered bands that move inward
func _draw_haze_ring(node, _arg):
	b_begin(node)
	var col = c8(190, 225, 255)
	b_ring(view.position + view.size / 2.0, [560.0, 1150.0, 2600.0], [fade(col, 0.0), fade(col, 0.3), fade(col, 0.3)], 64)
	b_flush()


func _draw_frost(layer):
	var L = frost_level(tau)
	var tex = shared.baked.get('frost_edge')
	if L <= 0.01 or tex == null: return
	var d0 = 30.0 + 230.0 * L
	var a = clamp(1.4 * L, 0.0, 1.0)
	for band in [[-20.0, d0, 1.0], [d0, d0 + 24.0, 0.55], [d0 + 24.0, d0 + 48.0, 0.25]]:
		frost_ring(layer, tex, band[0], band[1], fade(FLAKE, a * band[2]))


func frost_ring(layer, tex, a, b, col):
	var o0 = view.position + Vector2(a, 0.7 * a)
	var o1 = view.end - Vector2(a, 0.7 * a)
	var i0 = view.position + Vector2(b, 0.7 * b)
	var i1 = view.end - Vector2(b, 0.7 * b)
	var parts = [Rect2(o0, Vector2(o1.x - o0.x, i0.y - o0.y)), Rect2(Vector2(o0.x, i1.y), Vector2(o1.x - o0.x, o1.y - i1.y)),
		Rect2(Vector2(o0.x, i0.y), Vector2(i0.x - o0.x, i1.y - i0.y)), Rect2(Vector2(i1.x, i0.y), Vector2(o1.x - i1.x, i1.y - i0.y))]
	var k = tex.get_size() / view.size
	for r in parts:
		if r.size.x <= 0.0 or r.size.y <= 0.0: continue
		layer.draw_texture_rect_region(tex, r, Rect2((r.position - view.position) * k, r.size * k), col)


func _draw_flash(layer):
	var fl = flash_level(tau)
	if fl > 0.005: layer.draw_rect(view.grow(120.0), c8(219, 235, 255, 0.35 * fl))


func _draw_numbers(layer):
	for tg in targets:
		var tk = tg.taken
		if tk == null or t < tk.at: continue
		var a = t - tk.at
		if a > 1.25: continue
		var pop = 0.4 + 0.6 * out_back(a / 0.08) if a < 0.08 else 1.0
		number(layer, tk.text, tg.cc + Vector2(away * 12.0, -6.0 - 70.0 * out_cubic(clamp(a, 0.0, 1.0))),
			FONT_SIZE * pop * (1.4 if tk.crit else 1.0), tk.color, 1.0 - seg(a, 0.8, 1.25))


func number(layer, text, pos, size_px, color, alpha):
	DamageCounter.draw_number(layer, shared.font, shared.shadow_font, text, pos, size_px, color, alpha)


#--- the textures it bakes: the aurora's rays and mist, the frost on the screen's edges ------------------------------

func queue_bakes():
	var job = bake('rays_green', Vector2(1024, 320), true, '_bake_rays', 'grow_rays')
	if job != null:
		job.cols = GREEN_RAYS
		job.count = 540
	bake('mist', Vector2(512, 160), true, '_bake_mist', '', shared.mist)
	job = bake('rays_gold', Vector2(1024, 320), true, '_bake_rays', 'grow_rays')
	if job != null:
		job.cols = GOLD_RAYS
		job.count = 260
	bake('frost_edge', view.size, false, 'bake_frost_edge', 'grow_frost_edge')


func _bake_mist(painter, _job):
	painter.draw_texture_rect(shared.white, Rect2(0, 0, 512, 160), false)


func _bake_rays(painter, job):
	for chunk in job.chunks:
		VisualServer.canvas_item_add_triangle_array(painter.get_canvas_item(), chunk[0], chunk[1], chunk[2])


#the mockup blurred the rays 12 px and stacked the blur; each ray is drawn already soft instead, RAY_GAIN for the stacking
func grow_rays(job):
	if !job.has('chunks'):
		job.chunks = []
		job.mesh = [[], [], []]
		job.next = 0
	var stop = min(job.count, job.next + 180)
	for i in range(job.next, stop):
		add_ray(job.mesh, i, job.cols)
		if job.mesh[2].size() > 4000: keep_chunk(job)
	job.next = stop
	if job.next < job.count: return false
	keep_chunk(job)
	return true


func keep_chunk(job):
	if !job.mesh[2].empty():
		job.chunks.append([PoolIntArray(job.mesh[2]), PoolVector2Array(job.mesh[0]), PoolColorArray(job.mesh[1])])
	job.mesh = [[], [], []]


func add_ray(mesh, i, cols):
	var W = 1024.0
	var H = 320.0
	var hw = 29.0
	var x = W * hash01(9000 + i)
	var h2 = hash01(9100 + i)
	var h3 = hash01(9200 + i)
	var a = 0.04 + 0.16 * hash01(9300 + i)
	var hgt = H * (0.25 + 0.7 * h2 * h2)
	var k = (1.0 + 5.0 * h3 * h3) / hw * RAY_GAIN
	var foot = H - 4.0 - 22.0 * hash01(9400 + i)
	var rows = [[foot + 24.0, cols[0], 0.0], [foot, cols[0], min(1.0, 1.5 * a)], [foot - 0.06 * hgt, cols[1], a],
		[foot - 0.45 * hgt, cols[2], 0.55 * a], [foot - 0.8 * hgt, cols[3], 0.25 * a], [foot - hgt, cols[3], 0.0]]
	var copies = [x]
	if x < hw: copies.append(x + W)
	if x > W - hw: copies.append(x - W)
	for cx in copies:
		var base = mesh[0].size()
		for row in rows:
			for col_i in range(3):
				mesh[0].append(Vector2(cx + (col_i - 1) * hw, row[0]))
				mesh[1].append(fade(row[1], row[2] * k if col_i == 1 else 0.0))
		for r in range(5):
			for c in range(2):
				var v = base + r * 3 + c
				for index in [v, v + 1, v + 4, v, v + 4, v + 3]:
					mesh[2].append(index)


#the frost of the edges grows a few dozen feathers a frame, so no single frame carries all of it
func grow_frost_edge(job):
	if !job.has('lines'):
		var W = job.size.x
		var H = job.size.y
		var r = RandomNumberGenerator.new()
		r.seed = 7777
		var seeds = []
		for i in range(70):
			var x = W * r.randf()
			var k = 1.7 if x < 170.0 or x > W - 170.0 else 1.0
			seeds.append([Vector2(x, 0.0), PI / 2.0 + (r.randf() - 0.5) * 1.6, (22.0 + 58.0 * r.randf()) * k])
			seeds.append([Vector2(x, H), -PI / 2.0 + (r.randf() - 0.5) * 1.6, (18.0 + 46.0 * r.randf()) * k])
		for i in range(int(34.0 * H / 880.0)):
			var y = H * r.randf()
			var k = 1.5 if y < 150.0 or y > H - 150.0 else 1.0
			seeds.append([Vector2(0.0, y), (r.randf() - 0.5) * 1.6, (24.0 + 56.0 * r.randf()) * k])
			seeds.append([Vector2(W, y), PI + (r.randf() - 0.5) * 1.6, (24.0 + 56.0 * r.randf()) * k])
		job.r = r
		job.seeds = seeds
		job.lines = [[], [], []]
		job.next = 0
	var stop = min(job.seeds.size(), job.next + 60)
	for i in range(job.next, stop):
		var sd = job.seeds[i]
		grow_branch(job.lines, sd[0], sd[1], sd[2], 0, job.r, 2)
	job.next = stop
	return job.next >= job.seeds.size()


func bake_frost_edge(painter, job):
	var W = job.size.x
	var H = job.size.y
	frost_lines(painter, job.lines, [[1.3, 0.55], [0.8, 0.45], [0.5, 0.4]], 4.0, 0.9, 0.8)
	edge_fade(painter, Rect2(0.0, 0.0, W, 46.0), Vector2(0, 1), 0.4)
	edge_fade(painter, Rect2(0.0, H - 40.0, W, 40.0), Vector2(0, -1), 0.4)
	edge_fade(painter, Rect2(0.0, 0.0, 46.0, H), Vector2(1, 0), 0.4)
	edge_fade(painter, Rect2(W - 46.0, 0.0, 46.0, H), Vector2(-1, 0), 0.4)
	for q in [Vector2(0, 0), Vector2(W, 0), Vector2(0, H), Vector2(W, H)]:
		radial(painter, q, [0.0, 190.0], [Color(1, 1, 1, 0.45), Color(1, 1, 1, 0.0)], 32)
	#the mockup kept random grains with chance exp(-d / 38); these come straight from that distribution
	begin_mesh()
	var r = job.r
	for i in range(int(2.0 * (W + H) * 38.0 * 9000.0 / (1920.0 * 880.0))):
		var along = r.randf() * 2.0 * (W + H)
		var d = -38.0 * log(max(0.000001, r.randf()))
		var p = Vector2(along, d)
		if along >= 2.0 * W + H: p = Vector2(W - d, along - 2.0 * W - H)
		elif along >= 2.0 * W: p = Vector2(d, along - 2.0 * W)
		elif along >= W: p = Vector2(along - W, H - d)
		grain(p, 0.12 + 0.3 * r.randf(), 0.4 + 0.8 * r.randf())
		if mesh_indices.size() > 4000: flush_mesh(painter)
	flush_mesh(painter)
