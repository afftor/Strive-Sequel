extends Node2D
#The supernova: the caster charges a fireball and throws it up over the field, where it blinks faster
#while its light builds until its glare burns the screen out (ScreenGlare). The damage lands at that
#peak, and each target's number runs up as a counter while it burns (start_counter, called from
#CombatAnimations.hp_update).
#One clock drives it all; the knobs are the SUPERNOVA_* vars in CombatAnimations.gd.

const ScreenGlare = preload("res://src/combat/ScreenGlare.gd")
const DamageCounter = preload("res://src/combat/DamageCounter.gd")
const FxNode = preload("res://src/combat/FxNode.gd")

const HANG = Vector2(960, 250)
const RISE = 36.0
const BLINK0 = 3.0
const FADE = 0.9
const MAX_TICKS = 60
const SMOKE = Color(0.165, 0.122, 0.106)

const BALL_SHADER = """shader_type canvas_item;
render_mode unshaded;
uniform sampler2D noise_tex;
uniform float spin = 0.0;
uniform float heat = 1.0;
uniform float alpha = 1.0;
uniform float lo = 0.76;
uniform float hi = 1.0;

vec3 ramp(float v) {
	if (v < 0.3) return mix(vec3(0.639, 0.149, 0.039), vec3(0.925, 0.353, 0.071), v / 0.3);
	if (v < 0.58) return mix(vec3(0.925, 0.353, 0.071), vec3(1.0, 0.635, 0.2), (v - 0.3) / 0.28);
	if (v < 0.82) return mix(vec3(1.0, 0.635, 0.2), vec3(1.0, 0.863, 0.51), (v - 0.58) / 0.24);
	return mix(vec3(1.0, 0.863, 0.51), vec3(1.0, 0.973, 0.894), (v - 0.82) / 0.18);
}

float fire(vec2 uv) {
	vec2 w = vec2(texture(noise_tex, uv + vec2(0.37, 0.11)).r, texture(noise_tex, uv + vec2(0.71, 0.53)).r) - 0.5;
	vec2 q = uv + 0.35 * w;
	float t = 0.5 * abs(texture(noise_tex, q).r * 2.0 - 1.0);
	t += 0.25 * abs(texture(noise_tex, q * 2.0).r * 2.0 - 1.0);
	t += 0.125 * abs(texture(noise_tex, q * 4.0).r * 2.0 - 1.0);
	float d = 1.0 - t / 0.875;
	return pow(clamp((d - lo) / (hi - lo), 0.0, 1.0), 1.7);
}

vec2 turn(vec2 p, float a) {
	float c = cos(a);
	float s = sin(a);
	return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

void fragment() {
	vec2 p = UV * 2.0 - 1.0;
	float d = length(p);
	vec3 col = ramp(fire(turn(p, spin * 0.55) / 2.8 + 0.5));
	col += 0.45 * ramp(fire(turn(p, -spin * 0.9 + 1.3) / 3.64 + 0.5));
	vec3 core = mix(vec3(0.75, 0.735, 0.691), vec3(0.35, 0.294, 0.192), clamp(d / 0.45, 0.0, 1.0));
	if (d > 0.45) core = mix(vec3(0.35, 0.294, 0.192), vec3(0.0), clamp((d - 0.45) / 0.55, 0.0, 1.0));
	col += core * heat;
	float mask = 1.0 - clamp((d - 0.8) / 0.2, 0.0, 1.0);
	COLOR = vec4(min(col, vec3(1.0)), mask * alpha);
}
"""

var t = 0.0
var time_rate = 1.0
var caster = null
var targets = []
var root = null
var root_home = Vector2()
var under = null
var shade = null
var shared = {}
var layers = {}
var ball_material = null
var glare = null

var R = 1.2
var flight = 0.55
var build = 1.4
var blink_hz = 16.0
var life = 0.4
var every = 0.05
var burn = 1.0
var glare_amount = 0.85
var gain = 1.3
var soft = 10.0
var tint = 0.85
var field_dim = 0.35
var screen_dim = 0.2
var white_hold = 1.5
var shake_px = 16.0
var size = 1.0
var rays_on = true

var dir = 1.0
var arrive = 0.0
var peak = 0.0
var gone = 0.0
var fade0 = 0.0
var ticks = 20
var r_charge = 42.0
var r_hang = 84.0
var hold = Vector2()
var p0 = null
var ctrl = Vector2()
#each target card's damage counter
var counter = DamageCounter.new()
var rng = RandomNumberGenerator.new()

var mesh_points = PoolVector2Array()
var mesh_colors = PoolColorArray()
var mesh_indices = PoolIntArray()


#Built once per combat node and handed to every cast: the noise the ball's fire is made of, a soft
#disc for glows and smoke, the two shaders and the number fonts.
static func make_shared():
	var noise = OpenSimplexNoise.new()
	noise.seed = 7
	noise.octaves = 2
	noise.period = 64.0
	var fire = ImageTexture.new()
	fire.create_from_image(noise.get_seamless_image(256), Texture.FLAG_FILTER | Texture.FLAG_REPEAT)
	var data = PoolByteArray()
	for y in range(64):
		for x in range(64):
			var d = Vector2(x - 31.5, y - 31.5).length() / 32.0
			data.append(255)
			data.append(int(255.0 * clamp(1.0 - d, 0.0, 1.0)))
	var image = Image.new()
	image.create_from_data(64, 64, false, Image.FORMAT_LA8, data)
	var soft = ImageTexture.new()
	soft.create_from_image(image, Texture.FLAG_FILTER)
	var ball_shader = Shader.new()
	ball_shader.code = BALL_SHADER
	var fonts = DamageCounter.make_fonts()
	return {fire = fire, soft = soft, ball_shader = ball_shader,
		font = fonts.font, shadow_font = fonts.shadow}


func setup(caster_node, hit_nodes, settings, combat_root, new_shared):
	caster = caster_node
	for node in hit_nodes:
		if node != null and is_instance_valid(node) and !targets.has(node): targets.append(node)
	root = combat_root
	shared = new_shared
	counter.font = shared.font
	counter.shadow_font = shared.shadow_font
	R = max(0.2, float(settings.charge))
	flight = max(0.05, float(settings.flight))
	build = max(0.05, float(settings.build))
	blink_hz = max(BLINK0, float(settings.blink))
	life = max(0.0, float(settings.life))
	every = max(0.01, float(settings.every))
	burn = max(0.0, float(settings.burn))
	glare_amount = float(settings.glare)
	white_hold = max(0.0, float(settings.white))
	shake_px = float(settings.shake)
	size = max(0.1, float(settings.size))
	rays_on = int(settings.rays) != 0
	gain = float(settings.get('gain', gain))
	soft = float(settings.get('soft', soft))
	tint = float(settings.get('tint', tint))
	field_dim = float(settings.get('field_dim', field_dim))
	screen_dim = float(settings.get('screen_dim', screen_dim))
	if caster.has_method('get_attack_vector') and caster.get_attack_vector().x < 0.0: dir = -1.0
	arrive = R + flight
	peak = arrive + build
	gone = peak + life
	fade0 = gone - min(FADE, life)
	ticks = int(clamp(round(burn / every), 1, MAX_TICKS))
	r_charge = 42.0 * size
	r_hang = 84.0 * size
	rng.seed = 7001
	if root is Control: root_home = FxNode.shake_home(root)
	hold = hold_point()
	build_layers()
	set_process(true)


func build_layers():
	layers.veil = add_layer(78, -1, '_draw_veil')
	layers.charred = add_layer(80, CanvasItemMaterial.BLEND_MODE_MUL, '_draw_charred')
	layers.fire = add_layer(81, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_fire')
	layers.smoke = add_layer(82, -1, '_draw_smoke')
	layers.glow = add_layer(83, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_glow')
	layers.ball = add_layer(84, -1, '_draw_ball')
	ball_material = ShaderMaterial.new()
	ball_material.shader = shared.ball_shader
	ball_material.set_shader_param('noise_tex', shared.fire)
	layers.ball.material = ball_material
	layers.sparks = add_layer(85, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_sparks')
	glare = ScreenGlare.new()
	glare.cover(self, shared, {z = 95, gain = gain, soft = soft, tint = tint})
	layers.numbers = add_layer(96, -1, '_draw_numbers')
	#the warm light on the floor goes over the backdrop, darkened first, and under every card
	var backdrop = root.get_node_or_null('Background') if root != null else null
	if backdrop != null:
		shade = Node2D.new()
		root.add_child_below_node(backdrop, shade)
		shade.connect('draw', self, '_draw_shade', [shade])
		under = Node2D.new()
		under.material = additive()
		root.add_child_below_node(shade, under)
		under.connect('draw', self, '_draw_under', [under])


func add_layer(z, blend, method):
	var layer = Node2D.new()
	layer.z_index = z
	if blend >= 0:
		var material = CanvasItemMaterial.new()
		material.blend_mode = blend
		layer.material = material
	add_child(layer)
	layer.connect('draw', self, method, [layer])
	return layer


func additive():
	var material = CanvasItemMaterial.new()
	material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return material


#--- the damage ------------------------------------------------------------------------

#The target's hp_update, handed over: its number runs up tick by tick and the HP bar follows it.
#Returns how long the queue should wait - until the counter is done and the white is gone.
func start_counter(node, args, crit):
	var list = []
	for k in range(ticks):
		var at = t + k * every
		if k > 0: at += (rng.randf() - 0.5) * every * 0.5
		list.append(at)
	list.sort()
	var c = counter.start(node, args, crit, list, [], t)
	if node.has_node('Icon'):
		ResourceScripts.core_animations.ShakeAnimation(node.get_node('Icon'), (list.back() - t + 0.6) / time_rate, 3.0)
	return max(c.done, peak + white_hold + 1.0) - t


func burn_level(c):
	var last = c.ticks.back()
	return seg(t, c.start - 0.04, c.start + 0.2) * (1.0 - seg(t, last + 0.15, last + 1.4))


#--- the plan: everything as a function of time ------------------------------------------

func hold_point():
	if caster == null or !is_instance_valid(caster): return hold
	var rect = local_rect(caster)
	return Vector2(rect.position.x + rect.size.x / 2.0 + dir * 12.0, rect.position.y - 30.0)


func build_k(time):
	return seg(time, arrive, peak)


func out_k(time):
	return in_cubic(seg(time, fade0, gone))


func phase(time):
	if time <= arrive: return 0.0
	var a = min(time, peak) - arrive
	var h = max(0.01, peak - arrive)
	var res = BLINK0 * a + (blink_hz - BLINK0) * a * a / (2.0 * h)
	if time > peak: res += blink_hz * (time - peak)
	return res


func depth(time):
	if time <= peak: return 0.25 + 0.75 * build_k(time)
	return lerp(1.0, 0.3, seg(time, peak, peak + 0.25))


func blink(time):
	if time <= arrive: return 0.0
	return depth(time) * pow(0.5 + 0.5 * cos(TAU * phase(time)), 3)


func bezier(u):
	var start = p0 if p0 != null else hold
	return (1.0 - u) * (1.0 - u) * start + 2.0 * (1.0 - u) * u * ctrl + u * u * HANG


func ball(time):
	if time < 0.1 or time >= gone: return null
	if time <= R:
		var k = out_cubic(seg(time, 0.1, R))
		return {pos = hold, r = r_charge * (0.12 + 0.88 * k) * (1.0 + 0.04 * sin(time * 29.0)),
			heat = 0.55 + 0.45 * k, phase = 'charge'}
	if time <= arrive:
		var k = seg(time, R, arrive)
		return {pos = bezier(out_cubic(k)), r = lerp(r_charge, r_hang, inout_quad(k)), heat = 1.0, phase = 'flight'}
	var k = build_k(time)
	var bl = blink(time)
	var o = out_k(time)
	return {pos = HANG - Vector2(0.0, RISE * inout_sine(k)),
		r = r_hang * (1.0 + 0.22 * k * k) * (1.0 + 0.06 * bl) * (1.0 - 0.75 * o),
		heat = (1.0 + 1.1 * pow(k, 1.5)) * (0.75 + 0.5 * bl) * (1.0 - o), phase = 'build' if time <= peak else 'peak'}


func ball_at(time):
	return ball(clamp(time, 0.1, gone - 0.0001))


func last_tick():
	var res = peak + (ticks - 1) * every
	for node in counter.counters: res = max(res, counter.counters[node].ticks.back())
	return res


func done_time():
	var res = peak + (ticks - 1) * every + DamageCounter.COUNT
	for node in counter.counters: res = max(res, counter.counters[node].done)
	return res


func glare(time):
	if time < arrive: return 0.0
	var lt = last_tick()
	var up = pow(build_k(time), 2.2)
	var held = 1.0 - 0.3 * inout_quad(seg(time, peak, lt + 0.05))
	var down = 1.0 - inout_quad(seg(time, max(peak, fade0 - 0.2), gone + 0.3))
	#only the ball strobes hard; the whole scene dips a little with it
	var flicker = 1.0 - 0.16 * (depth(time) - blink(time)) * (1.0 - seg(time, lt, lt + 0.3))
	return clamp(up * held * down * flicker, 0.0, 1.0)


func whiteness(time):
	return clamp(pow(seg(time, peak - 0.35, peak), 2) * (1.0 - inout_quad(seg(time, peak + white_hold, peak + white_hold + 1.0))), 0.0, 1.0)


func dim(time):
	return 0.24 * seg(time, 0.1, 0.7 * R) * (1.0 - seg(time, R, R + 0.35))


#The mockup's field is darker than the combat screen and has no UI over it, so while the nova plays the backdrop
#darkens by field_dim and everything else under the nova by screen_dim; they come back once the glare is gone
func shade_k(time):
	var back = peak + white_hold + 0.9
	return inout_quad(seg(time, 0.1, arrive)) * (1.0 - inout_quad(seg(time, back, back + 0.6)))


func shake_magnitude(time):
	var m = 0.0
	var lt = last_tick()
	var done = done_time()
	if time < R: m = 0.1 * shake_px * seg(time, 0.55 * R, R)
	if time >= arrive: m = max(m, shake_px * (0.06 + 0.55 * pow(build_k(time), 2)) * (1.0 - seg(time, lt, lt + 0.9)))
	if time >= peak: m = max(m, 0.9 * shake_px * (1.0 - seg(time, peak, peak + 0.45)))
	if time >= done: m = max(m, 0.3 * shake_px * (1.0 - seg(time, done, done + 0.25)))
	return m


func rays(time):
	if time < arrive or time >= gone: return null
	var k = build_k(time)
	return {level = seg(time, arrive, arrive + 0.3) * (0.3 + 1.3 * pow(k, 1.5)) * (0.75 + 0.45 * blink(time)) * (1.0 - out_k(time)),
		length = 1.0 + 0.45 * k}


func light(time):
	var b = ball(time)
	if b == null: return null
	var a = 0.42
	if b.phase == 'charge': a = 0.3 * seg(time, 0.1, R)
	elif b.phase != 'flight': a = (0.42 + 0.58 * pow(build_k(time), 1.5)) * (0.8 + 0.2 * blink(time)) * (1.0 - out_k(time))
	return {pos = b.pos, r = 1100.0, a = a}


func finish_time():
	var done = done_time()
	return max(max(done + 0.95 + 0.75, gone + 0.6), peak + white_hold + 1.2) + 0.35


#--- the clock ---------------------------------------------------------------------------

func _process(delta):
	t += delta * time_rate
	if caster != null and !is_instance_valid(caster): caster = null
	if t <= R:
		hold = hold_point()
	elif p0 == null:
		p0 = hold
		ctrl = Vector2(lerp(p0.x, HANG.x, 0.45), min(p0.y, HANG.y) - 160.0)
	counter.update(t)
	apply_shake()
	update_screen()
	for key in layers:
		layers[key].update()
	if under != null and is_instance_valid(under): under.update()
	if shade != null and is_instance_valid(shade): shade.update()
	if t >= finish_time(): queue_free()


func apply_shake():
	if !(root is Control) or !is_instance_valid(root): return
	var m = shake_magnitude(t)
	var offset = Vector2()
	if m > 0.01:
		var tick = floor(t * 60.0)
		offset = Vector2(noise(31, tick, 1), noise(31, tick, 2)) * m
	root.rect_position = root_home + offset


#how much longer a card's number runs; its death waits for it
func counter_left(node):
	return counter.left(node, t)


func update_screen():
	var b = ball(t)
	var gl = glare(t) * glare_amount
	var bl = 0.0
	for node in counter.counters: bl = max(bl, burn_level(counter.counters[node]))
	var bloom = min(0.9, 0.3 * (min(2.0, b.heat) if b != null else 0.0) + 0.45 * gl + 0.25 * bl)
	var wh = whiteness(t)
	glare.levels(bloom, gl, wh)


func _exit_tree():
	counter.finish_all()
	if root is Control and is_instance_valid(root): root.rect_position = root_home
	if under != null and is_instance_valid(under): under.queue_free()
	under = null
	if shade != null and is_instance_valid(shade): shade.queue_free()
	shade = null


#--- layers ------------------------------------------------------------------------------

func _draw_shade(node):
	cover(node, Color(0, 0, 0, field_dim * shade_k(t)))


func _draw_veil(layer):
	cover(layer, Color(0, 0, 0, screen_dim * shade_k(t)))


func _draw_under(layer):
	var L = light(t)
	if L != null and L.a > 0.005: warm_light(layer, L, 0.55)


func _draw_charred(layer):
	for node in counter.counters:
		var bl = burn_level(counter.counters[node])
		if bl <= 0.001 or !is_instance_valid(node) or !node.has_node('Icon'): continue
		var k = 0.5 * bl
		layer.draw_rect(local_rect(node.get_node('Icon')), Color(1.0 - k * 0.529, 1.0 - k * 0.796, 1.0 - k * 0.906))


func _draw_fire(layer):
	var charged = 0.32 * seg(t, 0.15, R) * (1.0 - seg(t, R, R + 0.2))
	if charged > 0.004 and caster != null and caster.has_node('Icon'):
		layer.draw_rect(local_rect(caster.get_node('Icon')), Color(1.0, 0.769, 0.471, charged))
	for node in counter.counters:
		var c = counter.counters[node]
		var bl = burn_level(c)
		if bl <= 0.001 or !is_instance_valid(node): continue
		var flash = 0.16 * bl
		if c.last >= 0.0: flash += 0.3 * bump(t - c.last, 0.0, 0.008, 0.06)
		if node.has_node('Icon'): layer.draw_rect(local_rect(node.get_node('Icon')), Color(1.0, 0.667, 0.353, flash))
		card_fire(layer, local_rect(node), bl, c.seed)
	var L = light(t)
	if L != null and L.a > 0.005: warm_light(layer, L, 0.3)


func _draw_smoke(layer):
	var dm = dim(t)
	if dm > 0.005:
		var b = ball(t)
		var center = b.pos if b != null else HANG
		var r0 = (b.r if b != null else 60.0) * 1.4
		radial(layer, center, [r0, 900.0, 2600.0], [Color(0, 0, 0, 0), Color(0, 0, 0, dm), Color(0, 0, 0, dm)])
	for j in range(26):
		var s = R + flight * (j + 0.5) / 26.0
		var age = t - s
		if age < 0.0 or age > 1.8: continue
		var p = ball_at(s)
		if p == null: continue
		var k = age / 1.8
		puff(layer, p.pos + Vector2((hash01(j + 40) - 0.5) * 50.0 * age, -34.0 * age), p.r * 0.5 + 70.0 * out_cubic(k),
			0.3 * (1.0 - k) * seg(age, 0.0, 0.12))
	for node in counter.counters:
		var c = counter.counters[node]
		if !is_instance_valid(node): continue
		var rect = local_rect(node)
		for j in range(5):
			var age = t - (c.start + 0.25 + 0.22 * j + 0.1 * hash01(c.seed * 11 + j))
			if age < 0.0 or age > 2.2: continue
			var k = age / 2.2
			puff(layer, Vector2(rect.position.x + rect.size.x / 2.0 + (hash01(c.seed * 13 + j) - 0.5) * 120.0,
				rect.position.y + rect.size.y * 0.74 - 90.0 * age), 30.0 + 60.0 * k, 0.26 * (1.0 - k) * seg(age, 0.0, 0.15))


func _draw_glow(layer):
	var b = ball(t)
	if b != null and b.phase == 'charge': draw_charge(layer, b)
	draw_trail(layer)
	if b == null: return
	if rays_on: draw_rays(layer, rays(t), b.pos)
	begin_mesh()
	var heat = b.heat
	var r = b.r
	var cr = r * (3.2 + 0.9 * clamp(heat - 1.0, 0.0, 1.5))
	var r0 = r * 0.5
	radial(layer, b.pos, [0.0, r0, r0 + (cr - r0) * 0.3, r0 + (cr - r0) * 0.65, cr],
		[c8(255, 196, 110, 0.5 * heat), c8(255, 196, 110, 0.5 * heat), c8(255, 120, 40, 0.24 * heat), c8(220, 60, 12, 0.07 * heat), c8(160, 30, 0, 0.0)])
	for L in range(3):
		tongue(b.pos, r, heat, L)
	flush_mesh(layer)


func _draw_ball(layer):
	var b = ball(t)
	if b == null or b.r < 1.0: return
	ball_material.set_shader_param('spin', t)
	ball_material.set_shader_param('heat', b.heat)
	ball_material.set_shader_param('alpha', 1.0)
	var half = b.r * 1.02
	layer.draw_texture_rect(shared.fire, Rect2(b.pos - Vector2(half, half), Vector2(half, half) * 2.0), false)


func _draw_sparks(layer):
	var b = ball(t)
	if b != null:
		var heat = b.heat
		var r = b.r
		layer.draw_arc(b.pos, r * 0.97, 0.0, TAU, 64, c8(255, 200, 120, 0.35 * heat), r * 0.08, true)
		for i in range(4):
			var u = fposmod(t * (0.7 + 0.3 * hash01(i + 900)) + hash01(i + 901), 1.0)
			var th = TAU * hash01(i + 902) + t * 0.2
			var span = 0.35 + 0.25 * hash01(i + 903)
			var h = r * (0.25 + 0.45 * sin(PI * u))
			var al = sin(PI * u) * heat
			var a0 = th - span / 2.0
			var a1 = th + span / 2.0
			var points = PoolVector2Array()
			var from = b.pos + Vector2(cos(a0), sin(a0)) * r
			var mid = b.pos + Vector2(cos(th), sin(th)) * (r + h * 2.0)
			var to = b.pos + Vector2(cos(a1), sin(a1)) * r
			for q in range(13):
				var k = q / 12.0
				points.append((1.0 - k) * (1.0 - k) * from + 2.0 * (1.0 - k) * k * mid + k * k * to)
			layer.draw_polyline(points, c8(255, 130, 40, 0.3 * al), r * 0.12, true)
			layer.draw_polyline(points, c8(255, 226, 150, 0.6 * al), r * 0.035, true)
	for i in range(70):
		var rate = 0.9 + 0.9 * hash01(i + 500)
		var u = fposmod(t * rate + hash01(i + 501), 1.0)
		var src = ball(t - u / rate)
		if src == null: continue
		var an = TAU * hash01(i + 502)
		var d = src.r * 0.9 + (60.0 + 160.0 * hash01(i + 503)) * u
		var p = src.pos + Vector2(cos(an), sin(an)) * d - Vector2(0.0, 90.0 * u * u)
		var al = (1.0 - u) * seg(u, 0.0, 0.08)
		if al <= 0.01: continue
		var col = c8(255, 240, 190).linear_interpolate(c8(255, 90, 20), u)
		col.a = 0.9 * al
		layer.draw_line(p, p - Vector2(cos(an), sin(an)) * 6.0 + Vector2(0.0, 5.0 * u), col, 2.6 * (1.0 - u) + 0.6, true)
	draw_ash(layer)


func _draw_numbers(layer):
	counter.draw(layer, t, self)


#--- pieces ------------------------------------------------------------------------------

func draw_charge(layer, b):
	var lv = seg(t, 0.12, 0.45 * R) * (1.0 - seg(t, R - 0.06, R))
	if lv > 0.01:
		for i in range(44):
			var period = 0.5 + 0.35 * hash01(300 + i)
			var u = fposmod(t / period + hash01(300 + i + 50), 1.0)
			var d0 = 130.0 + 190.0 * hash01(300 + i + 100)
			var th = TAU * hash01(300 + i + 150)
			var al = lv * seg(u, 0.0, 0.35) * (1.0 - seg(u, 0.9, 1.0))
			if al <= 0.01: continue
			var a = inflow_point(b.pos, b.r, d0, th, max(0.0, u - 0.07))
			var z = inflow_point(b.pos, b.r, d0, th, u)
			layer.draw_line(a, z, c8(255, 150, 60, 0.35 * al), 5.0, true)
			layer.draw_line(a, z, c8(255, 226, 160, 0.9 * al), 1.8, true)
	var k = 0
	while 0.15 + k * 0.3 + 0.3 <= R + 0.05:
		var age = t - (0.15 + k * 0.3)
		k += 1
		if age < 0.0 or age > 0.3: continue
		var q = age / 0.3
		layer.draw_arc(b.pos, lerp(170.0, b.r * 1.1, q * q), 0.0, TAU, 64, c8(255, 170, 80, 0.5 * q * q * lv), 2.0 + 3.0 * q, true)


func inflow_point(center, rmin, d0, th, u):
	var d = rmin + (d0 - rmin) * (1.0 - u * u)
	var a = th + 1.5 * (1.0 - u)
	return center + Vector2(cos(a) * d, sin(a) * d * 0.9)


func draw_trail(layer):
	if t < R or t > arrive + 0.6: return
	for j in range(90):
		var s = R + flight * j / 89.0
		var age = t - s
		var span = 0.28 + 0.2 * hash01(j + 5)
		if age < 0.0 or age > span: continue
		var p = ball_at(s)
		if p == null: continue
		var k = age / span
		var col = c8(255, 236, 180).linear_interpolate(c8(255, 150, 50), k / 0.35) if k < 0.35 \
			else c8(255, 150, 50).linear_interpolate(c8(190, 40, 10), (k - 0.35) / 0.65)
		col.a = 0.55 * (1.0 - k)
		blob(layer, p.pos + Vector2((hash01(j + 1) - 0.5) * p.r * 0.8, (hash01(j + 2) - 0.5) * p.r * 0.8 - 40.0 * age),
			p.r * (0.75 - 0.5 * k) * (0.7 + 0.5 * hash01(j + 9)), col)


func draw_rays(layer, ray, center):
	if ray == null or ray.level <= 0.01: return
	begin_mesh()
	for i in range(18):
		var th = TAU * hash01(i + 800) + t * 0.06 * (1.0 if i % 2 == 1 else -1.0)
		var half = 0.01 + 0.022 * hash01(i + 801)
		var length = (620.0 + 520.0 * hash01(i + 802)) * ray.length
		var fl = 0.65 + 0.35 * sin(t * (2.5 + 4.0 * hash01(i + 803)) + i)
		var near = c8(255, 236, 190, 0.2 * ray.level * fl)
		var middle = c8(255, 170, 80, 0.09 * ray.level * fl)
		var far = c8(255, 110, 40, 0.0)
		var a = Vector2(cos(th - half), sin(th - half))
		var z = Vector2(cos(th + half), sin(th + half))
		var base = mesh_points.size()
		for p in [center, center + a * length * 0.35, center + z * length * 0.35, center + a * length, center + z * length]:
			mesh_points.append(p)
		for col in [near, middle, middle, far, far]:
			mesh_colors.append(col)
		for index in [0, 1, 2, 1, 3, 4, 1, 4, 2]:
			mesh_indices.append(base + index)
	flush_mesh(layer)


#one ring of flame tongues around the ball, taller on top
func tongue(center, r, heat, level):
	var amp = r * (0.3 + 0.16 * level)
	var outer = (r * 1.05 + amp) * 1.1
	var inner = r * 0.8
	var c0 = c8(255, 214, 130, 0.55 * heat)
	var c1 = c8(255, 120, 36, 0.4 * heat)
	var c2 = c8(200, 40, 6, 0.0)
	var base = mesh_points.size()
	mesh_points.append(center)
	mesh_colors.append(c0)
	var count = 72
	for i in range(count):
		var th = TAU * i / count
		var up = max(0.0, -sin(th)) * 0.35
		var rr = r * (0.94 + 0.02 * level) + amp * (flame_r(th, t * (1.0 + 0.3 * level), level) + up * (0.6 + 0.4 * sin(t * 5.0 + level)))
		var along = Vector2(cos(th), sin(th))
		mesh_points.append(center + along * inner)
		mesh_colors.append(c0)
		mesh_points.append(center + along * rr)
		var f = clamp((rr - inner) / max(1.0, outer - inner), 0.0, 1.0)
		mesh_colors.append(c0.linear_interpolate(c1, f / 0.45) if f < 0.45 else c1.linear_interpolate(c2, (f - 0.45) / 0.55))
	for i in range(count):
		var j = (i + 1) % count
		var a_in = base + 1 + i * 2
		var a_out = a_in + 1
		var b_in = base + 1 + j * 2
		var b_out = b_in + 1
		for index in [base, a_in, b_in, a_in, a_out, b_out, a_in, b_out, b_in]:
			mesh_indices.append(index)


func flame_r(th, time, level):
	var s = 0.0
	for j in range(5):
		var f = 5 + j * 2 + level * 3
		var ph = hash01(level * 17 + j) * TAU
		var w = (1.3 + hash01(level * 7 + j) * 2.4) * (1.0 if j % 2 == 1 else -1.0)
		s += sin(th * f + ph + time * w) / (1.0 + j * 0.45)
	return pow(max(0.0, s / 2.2), 1.3)


func card_fire(layer, rect, lv, key):
	begin_mesh()
	var x = rect.position.x
	var y = rect.position.y
	var w = rect.size.x
	var h = rect.size.y
	for i in range(11):
		var fx = x + 10.0 + (w - 20.0) * (i + 0.5) / 11.0 + 4.0 * sin(t * 5.0 + i)
		var fh = (46.0 + 74.0 * hash01(key + i)) * lv * (0.72 + 0.28 * sin(t * (9.0 + 6.0 * hash01(key + i + 7)) + i * 1.7))
		flame(fx, y + h - 6.0, 18.0 + 12.0 * hash01(key + i + 3), fh, 9.0 * sin(t * 6.3 + i * 2.3), lv)
	for side in range(2):
		for i in range(3):
			var fh = (34.0 + 30.0 * hash01(key + 40 + side * 3 + i)) * lv * (0.7 + 0.3 * sin(t * 8.0 + i * 2 + side))
			flame(x + w - 6.0 if side == 1 else x + 6.0, y + h - 30.0 - i * 52.0, 16.0, fh, 6.0 * sin(t * 7.0 + i + side), lv * 0.8)
	flush_mesh(layer)


func flame(x, y, w, h, sway, a):
	if h < 2.0 or a <= 0.004: return
	var tip = Vector2(x + sway, y - h)
	var outline = []
	for i in range(9):
		outline.append(quad_point(Vector2(x - w / 2.0, y), Vector2(x - w * 0.62, y - h * 0.5), tip, i / 8.0))
	for i in range(1, 9):
		outline.append(quad_point(tip, Vector2(x + w * 0.62, y - h * 0.5), Vector2(x + w / 2.0, y), i / 8.0))
	var base = mesh_points.size()
	mesh_points.append(Vector2(x, y))
	mesh_colors.append(flame_color(0.0, a))
	for p in outline:
		mesh_points.append(p)
		mesh_colors.append(flame_color((y - p.y) / h, a))
	for i in range(1, outline.size()):
		mesh_indices.append(base)
		mesh_indices.append(base + i)
		mesh_indices.append(base + i + 1)


func flame_color(f, a):
	if f < 0.25: return c8(255, 244, 200, 0.8 * a).linear_interpolate(c8(255, 176, 70, 0.6 * a), f / 0.25)
	if f < 0.6: return c8(255, 176, 70, 0.6 * a).linear_interpolate(c8(240, 80, 20, 0.3 * a), (f - 0.25) / 0.35)
	return c8(240, 80, 20, 0.3 * a).linear_interpolate(c8(170, 30, 0, 0.0), clamp((f - 0.6) / 0.4, 0.0, 1.0))


func draw_ash(layer):
	if counter.counters.empty(): return
	var start = INF
	var x0 = INF
	var x1 = -INF
	for node in counter.counters:
		start = min(start, counter.counters[node].start)
		if !is_instance_valid(node): continue
		var rect = local_rect(node)
		x0 = min(x0, rect.position.x - 40.0)
		x1 = max(x1, rect.end.x + 40.0)
	if x0 > x1: return
	var lv = seg(t, start, start + 0.3) * (1.0 - seg(t, last_tick() + 0.8, finish_time() - 0.2))
	if lv <= 0.01: return
	for i in range(60):
		var u = fposmod(t * (0.35 + 0.4 * hash01(i + 700)) + hash01(i + 701), 1.0)
		var col = c8(255, 220, 150).linear_interpolate(c8(255, 90, 30), u)
		col.a = 0.8 * lv * (1.0 - u) * seg(u, 0.0, 0.1)
		if col.a <= 0.004: continue
		layer.draw_circle(Vector2(lerp(x0, x1, hash01(i + 702)) + 30.0 * sin(t * 2.0 + i), 880.0 - 700.0 * u), 2.2 * (1.0 - u) + 0.6, col)


func warm_light(layer, L, strength):
	var a = L.a * strength
	radial(layer, L.pos, [0.0, L.r * 0.35, L.r], [c8(255, 170, 80, 0.55 * a), c8(255, 110, 40, 0.22 * a), c8(200, 60, 20, 0.0)], 48)


#--- drawing helpers ---------------------------------------------------------------------

func local_rect(control):
	var rect = control.get_global_rect()
	return Rect2(get_global_transform().affine_inverse().xform(rect.position), rect.size)


#the whole screen with a margin, so the shake never shows an edge
func cover(node, color):
	if color.a <= 0.002: return
	var rect = get_viewport().get_visible_rect()
	var inverse = node.get_global_transform().affine_inverse()
	node.draw_rect(Rect2(inverse.xform(rect.position) - Vector2(80, 80), rect.size + Vector2(160, 160)), color)


func blob(layer, center, r, color):
	if color.a <= 0.004 or r <= 0.5: return
	layer.draw_texture_rect(shared.soft, Rect2(center - Vector2(r, r), Vector2(r, r) * 2.0), false, color)


func puff(layer, center, r, a):
	blob(layer, center, r, Color(SMOKE.r, SMOKE.g, SMOKE.b, a))


#concentric bands: radii[i] to radii[i + 1] blending colors[i] into colors[i + 1]
func radial(layer, center, radii, colors, segments = 40):
	var own = mesh_points.size() == 0
	var base = mesh_points.size()
	for ring in range(radii.size()):
		for s in range(segments):
			var a = TAU * s / segments
			mesh_points.append(center + Vector2(cos(a), sin(a)) * radii[ring])
			mesh_colors.append(colors[ring])
	for ring in range(radii.size() - 1):
		var r0 = base + ring * segments
		var r1 = r0 + segments
		for s in range(segments):
			var n = (s + 1) % segments
			for index in [r0 + s, r1 + s, r1 + n, r0 + s, r1 + n, r0 + n]:
				mesh_indices.append(index)
	if own: flush_mesh(layer)


func begin_mesh():
	mesh_points = PoolVector2Array()
	mesh_colors = PoolColorArray()
	mesh_indices = PoolIntArray()


func flush_mesh(layer):
	if mesh_indices.size() > 0:
		VisualServer.canvas_item_add_triangle_array(layer.get_canvas_item(), mesh_indices, mesh_points, mesh_colors)
	begin_mesh()


static func c8(r, g, b, a = 1.0):
	return Color(r / 255.0, g / 255.0, b / 255.0, clamp(a, 0.0, 1.0))


static func quad_point(a, b, c, k):
	return (1.0 - k) * (1.0 - k) * a + 2.0 * (1.0 - k) * k * b + k * k * c


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


static func noise(key, i, tick):
	var v = sin(key * 0.0137 + i * 17.171 + tick * 7.913) * 43758.5453
	return (v - floor(v)) * 2.0 - 1.0
