extends "res://src/combat/FxNode.gd"
#Poison, bleeding, burning, sleep, stun and stealth shown on a fighter's card while it has them, and the tick of poison,
#bleeding and burning: the status icon flares, a wave of its colour runs up the portrait and the damage number flies
#out of the icon. What stays on the card is drawn once and moves in shaders; only a tick and stealth's way in and out
#are drawn frame by frame. CombatAnimations keeps one per card (status_aura, status_tick).

const DamageCounter = preload("res://src/combat/DamageCounter.gd")
const KINDS = ['poison', 'bleed', 'burn', 'sleep', 'stun', 'hide']
#the more statuses a card carries, the quieter each of them is
const DENS = [1.0, 1.0, 0.88, 0.8, 0.72, 0.66, 0.62]
#stealth («In the Shadows»): smoke bursts out round the card on the way in; a cold flash and rising wisps on the way out
const HIDE_IN = 1.0
const HIDE_OUT = 1.05
const PUFF = Color(0.227, 0.251, 0.345)
const MAIN = {poison = Color(0.463, 0.871, 0.361), bleed = Color(0.839, 0.125, 0.173), burn = Color(1.0, 0.518, 0.157)}
const LIGHT = {poison = Color(0.839, 1.0, 0.706), bleed = Color(1.0, 0.588, 0.549), burn = Color(1.0, 0.933, 0.659)}
const NUMBER = {poison = Color(0.471, 0.871, 0.361), bleed = Color(0.941, 0.251, 0.251), burn = Color(1.0, 0.588, 0.22)}
const GAME_RED = Color(0.8, 0.2, 0.2)
const BLEED_DEEP = Color(0.549, 0.0, 0.071)
const BLEED_LINE = Color(1.0, 0.353, 0.353)
const TICK_LIFE = 1.4
const FONT_SIZE = 30

#The portrait drawn again over itself, as the statuses change it. Stealth sinks it to a dark blue silhouette, rimmed by
#moonlight from above, with a cold sheen crossing it every 4 s; the other statuses tint that silhouette, not the bare
#portrait. Sleep darkens, cools and greys it with a slow breath; poison tints it green with murk rising from below and
#bubbles; bleeding reddens it a little; burning («Тление») is a dim red breath from the buff row and ash. A tick's wave
#runs up it (tick_*). Sizes are the portrait's px.
const PORTRAIT_SHADER = """shader_type canvas_item;
render_mode blend_mix;
uniform float dens = 1.0;
uniform float seed = 0.0;
uniform float floor_y = 116.0;
uniform float hide = 0.0;
uniform float hide_flash = 0.0;
uniform float sleep = 0.0;
uniform float poison = 0.0;
uniform float bleed = 0.0;
uniform float burn = 0.0;
uniform float icon_desat = 0.0;
uniform float tick_y = 0.0;
uniform float tick_a = 0.0;
uniform vec4 tick_col : hint_color = vec4(1.0);
varying vec2 px;

float hash1(float p) {
	p = fract(p * 0.1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

float lum(vec3 c) {
	return dot(c, vec3(0.3, 0.59, 0.11));
}

vec3 set_lum(vec3 c, float l) {
	c += l - lum(c);
	float m = lum(c);
	float n = min(min(c.r, c.g), c.b);
	float x = max(max(c.r, c.g), c.b);
	if (n < 0.0) c = m + (c - m) * m / (m - n);
	if (x > 1.0) c = m + (c - m) * (1.0 - m) / (x - m);
	return c;
}

float soft(float d, float r) {
	return max(0.0, 1.0 - d / r);
}

float disc(float d, float r) {
	return clamp(r - d + 0.5, 0.0, 1.0);
}

float ring(float d, float r, float w) {
	return clamp(w * 0.5 - abs(d - r) + 0.5, 0.0, 1.0);
}

float edge(vec2 l, vec2 a, vec2 b) {
	vec2 e = b - a;
	return dot(l - a, normalize(vec2(e.y, -e.x)));
}

float flake(vec2 l) {
	return max(max(edge(l, vec2(-1.0, -0.4), vec2(0.3, -0.8)), edge(l, vec2(0.3, -0.8), vec2(1.0, 0.3))),
		max(edge(l, vec2(1.0, 0.3), vec2(-0.2, 0.7)), edge(l, vec2(-0.2, 0.7), vec2(-1.0, -0.4))));
}

void vertex() {
	px = VERTEX;
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec3 col = mix(tex.rgb, vec3(lum(tex.rgb)), icon_desat);
	float t = TIME;
	float a = min(dens, 1.0);
	float W = 168.0;
	float H = 143.0;
	vec3 moon = vec3(0.69, 0.784, 1.0);
	if (hide > 0.001) {
		col = mix(col, vec3(lum(col)), 0.6 * hide);
		col *= mix(vec3(1.0), vec3(0.251, 0.298, 0.455), hide);
		col += moon * 0.3 * hide * max(0.0, 1.0 - px.y / 54.0);
		float u = fract(t / 4.0);
		float e = mix(2.0 * u * u, 1.0 - pow(2.0 - 2.0 * u, 2.0) / 2.0, step(0.5, u));
		float s = (px.x + px.y - mix(-80.0, 250.0, e) + 30.0) / 120.0;
		col += moon * 0.18 * hide * sin(3.1416 * u) * max(0.0, 1.0 - abs(2.0 * s - 1.0));
	}
	if (sleep > 0.5) {
		float br = 0.8 + 0.2 * sin(6.2832 * t / 4.0);
		col = mix(col, col * vec3(0.408, 0.486, 0.745), clamp(0.62 * dens * br, 0.0, 1.0));
		col = mix(col, vec3(lum(col)), clamp(0.5 * dens, 0.0, 1.0));
	}
	if (poison > 0.5) {
		col = mix(col, set_lum(vec3(0.314, 0.824, 0.275), lum(col)), clamp(0.26 * dens, 0.0, 1.0));
		for (int i = 0; i < 5; i++) {
			float fi = float(i);
			float u = fract(t / 4.0 + fi / 5.0);
			vec2 c = vec2(W * (0.12 + 0.76 * hash1(seed * 3.0 + fi)) + 12.0 * sin(6.2832 * u + fi), H + 30.0 - (H + 30.0) * u);
			float r = 48.0 + 20.0 * hash1(seed * 5.0 + fi);
			col = mix(col, vec3(0.29, 0.667, 0.235), clamp(0.42 * dens * sin(3.1416 * u), 0.0, 1.0) * soft(length(px - c), r));
		}
	}
	if (bleed > 0.5) {
		col = mix(col, col * vec3(1.0, 0.659, 0.659), clamp(0.17 * dens, 0.0, 1.0));
	}
	if (burn > 0.5) {
		float br = 0.6 + 0.4 * (0.5 + 0.5 * sin(6.2832 * t / 4.0));
		float y0 = floor_y + 6.0;
		float g = clamp((y0 - px.y) / max(y0, 1.0), 0.0, 1.0);
		float hl = mix(mix(0.4, 0.12, g * 2.0), mix(0.12, 0.0, g * 2.0 - 1.0), step(0.5, g));
		col += vec3(0.839, 0.227, 0.055) * hl * br * a;
		col = mix(col, col * vec3(1.0, 0.745, 0.549), mix(0.3, 0.06, g) * a);
	}
	if (tick_a > 0.001) {
		col += tick_col.rgb * tick_a * max(0.0, 1.0 - abs(px.y - tick_y) / 28.0);
	}
	if (poison > 0.5) {
		vec3 c_main = vec3(0.463, 0.871, 0.361);
		vec3 c_light = vec3(0.839, 1.0, 0.706);
		for (int i = 0; i < 5; i++) {
			float fi = float(i);
			float u = fract(t / 2.0 + hash1(seed * 83.0 + fi));
			float oq = 1.0 - (1.0 - u) * (1.0 - u);
			vec2 b = vec2(13.0 + 140.0 * hash1(seed * 89.0 + fi) + 4.0 * sin(12.5664 * u + fi), 141.0 - 100.0 * oq);
			float r = 3.0 + 5.0 * u;
			float d = length(px - b);
			if (u < 0.86) {
				float af = clamp(u / 0.1, 0.0, 1.0) * a;
				col += c_main * 0.25 * af * soft(d, 2.0 * r);
				col = mix(col, c_main, 0.42 * af * disc(d, r));
				col = mix(col, c_light, 0.95 * af * ring(d, r, max(1.0, 0.24 * r)));
				col = mix(col, vec3(1.0), 0.9 * af * disc(length(px - b + vec2(0.36 * r)), max(0.7, 0.26 * r)));
			} else {
				float q = (u - 0.86) / 0.14;
				col = mix(col, c_light, (1.0 - q) * 0.9 * a * ring(d, r * (1.0 + 0.8 * q), 1.4));
				for (int j = 0; j < 5; j++) {
					float an = float(j) * 1.2566 + 0.7;
					col = mix(col, c_light, (1.0 - q) * a * disc(length(px - b - vec2(cos(an), sin(an)) * r * (1.3 + 1.7 * q)), 1.2));
				}
			}
		}
	}
	if (burn > 0.5) {
		float fy = floor_y + 4.0;
		for (int i = 0; i < 7; i++) {
			float fi = float(i);
			float u = fract(t / 4.0 + hash1(seed * 61.0 + fi));
			vec2 p = vec2(7.0 + 154.0 * hash1(seed * 67.0 + fi) + 14.0 * sin(6.2832 * u + fi), fy - (fy + 3.0) * u);
			float s = 2.2 + 1.4 * hash1(seed * 71.0 + fi);
			float rot = 6.2832 * u * sign(hash1(seed * 73.0 + fi) - 0.5) + fi;
			vec2 q = px - p;
			vec2 l = vec2(cos(rot) * q.x + sin(rot) * q.y, -sin(rot) * q.x + cos(rot) * q.y) / s;
			col = mix(col, vec3(0.588, 0.557, 0.533), 0.8 * sin(3.1416 * u) * a * clamp(0.5 - flake(l) * s, 0.0, 1.0));
		}
		for (int i = 0; i < 3; i++) {
			float fi = float(i);
			float u = fract(t * 0.375 + hash1(seed * 71.0 + fi + 9.0));
			vec2 p = vec2(5.0 + 158.0 * hash1(seed * 73.0 + fi + 3.0) + 10.0 * sin(6.2832 * u + fi), floor_y + 6.0 - (floor_y + 13.0) * 0.6 * u);
			float sz = 1.6 * (0.8 + 0.6 * hash1(seed * 79.0 + fi));
			float ae = sin(3.1416 * u) * 0.7 * a;
			float d = length(px - p);
			col += vec3(1.0, 0.518, 0.157) * 0.4 * ae * soft(d, 3.2 * sz);
			col += vec3(1.0, 0.933, 0.659) * ae * disc(d, 0.65 * sz);
		}
	}
	col += moon * 0.3 * hide_flash;
	COLOR = vec4(min(col, vec3(1.0)), tex.a);
}
"""

#Over the card, in its coordinates: three stars circling its top edge for stun, and «Z» floating up from the top right
#corner for sleep. Premultiplied, so the glows add while the shapes cover.
const SIGNS_SHADER = """shader_type canvas_item;
render_mode blend_premul_alpha;
uniform float dens = 1.0;
uniform float sleep = 0.0;
uniform float stun = 0.0;
varying vec2 px;

float soft(float d, float r) {
	return max(0.0, 1.0 - d / r);
}

float seg_d(vec2 p, vec2 a, vec2 b) {
	vec2 ab = b - a;
	float h = clamp(dot(p - a, ab) / dot(ab, ab), 0.0, 1.0);
	return length(p - a - ab * h);
}

float star_d(vec2 p, float r, float rot) {
	float s5 = 0.6283185;
	float an = mod(atan(p.y, p.x) - rot + 1.5707963, 2.0 * s5);
	an = min(an, 2.0 * s5 - an);
	vec2 p1 = vec2(r, 0.0);
	vec2 p2 = 0.48 * r * vec2(cos(s5), sin(s5));
	vec2 e = p2 - p1;
	vec2 dir = vec2(cos(an), sin(an));
	return length(p) - (p1.x * p2.y - p1.y * p2.x) / (dir.x * e.y - dir.y * e.x);
}

vec4 over(vec4 acc, vec3 c, float a) {
	return vec4(c * a, a) + acc * (1.0 - a);
}

void vertex() {
	px = VERTEX;
}

void fragment() {
	vec4 acc = vec4(0.0);
	float a1 = min(dens, 1.0);
	if (stun > 0.5) {
		vec3 c_main = vec3(1.0, 0.824, 0.275);
		vec3 c_light = vec3(1.0, 0.98, 0.839);
		vec3 c_deep = vec3(0.549, 0.329, 0.039);
		vec2 c = vec2(91.0, 6.0);
		vec2 q = px - c;
		float e = length(q / vec2(58.0, 11.0));
		vec2 grad = q / vec2(3364.0, 121.0) / max(e, 0.001);
		float de = (e - 1.0) / max(length(grad), 0.0001);
		acc = over(acc, c_light, 0.16 * dens * clamp(1.1 - abs(de), 0.0, 1.0));
		for (int i = 0; i < 3; i++) {
			float fi = float(i);
			float an = 6.2832 * (TIME / 1.6 + fi / 3.0);
			float dp = (sin(an) + 1.0) / 2.0;
			float sc = 0.72 + 0.28 * dp;
			float aa = (0.55 + 0.45 * dp) * a1;
			float r = 11.0 * sc;
			for (int j = 1; j <= 2; j++) {
				float b = an - 0.28 * float(j);
				vec2 sp = px - c - vec2(58.0 * cos(b), 11.0 * sin(b));
				float ss = 3.96 * sc;
				float sa = aa * (0.55 - 0.2 * float(j));
				acc.rgb += c_main * 0.38 * sa * soft(length(sp), ss * 1.8);
				vec2 l = abs(sp) / vec2(0.72 * ss, ss);
				acc.rgb += c_light * sa * clamp((1.0 - sqrt(l.x) - sqrt(l.y)) * ss * 0.5 + 0.5, 0.0, 1.0);
			}
			vec2 p = px - c - vec2(58.0 * cos(an), 11.0 * sin(an));
			float rot = 6.2832 * TIME * 0.75 + fi * 2.1;
			acc.rgb += c_main * 0.34 * aa * soft(length(p), r * 2.4);
			float d = star_d(p, r, rot);
			acc = over(acc, c_main, aa * clamp(0.5 - d, 0.0, 1.0));
			acc = over(acc, c_deep, 0.85 * aa * clamp(max(1.0, 0.15 * r) * 0.5 - abs(d) + 0.5, 0.0, 1.0));
			acc = over(acc, c_light, 0.95 * aa * clamp(0.5 - star_d(p + vec2(0.05, 0.07) * r, r * 0.5, rot), 0.0, 1.0));
		}
	}
	if (sleep > 0.5) {
		vec3 c_main = vec3(0.588, 0.722, 1.0);
		vec3 c_light = vec3(0.91, 0.941, 1.0);
		vec3 c_deep = vec3(0.094, 0.133, 0.329);
		for (int i = 0; i < 2; i++) {
			float fi = float(i);
			float u = fract(TIME / 4.0 + fi / 2.0);
			float k = 1.0 - (1.0 - u) * (1.0 - u);
			vec2 zp = vec2(148.0 + 16.0 * k + 3.0 * sin(6.2832 * u + fi), 62.0 - 62.0 * k);
			float s = 18.0 + 16.0 * u;
			float za = clamp(u / 0.2, 0.0, 1.0) * (1.0 - clamp((u - 0.6) / 0.4, 0.0, 1.0)) * 0.9 * a1;
			vec2 p = px - zp;
			vec2 l = vec2(cos(0.2) * p.x - sin(0.2) * p.y, sin(0.2) * p.x + cos(0.2) * p.y);
			float d = min(min(seg_d(l, vec2(-0.26, -0.33) * s, vec2(0.26, -0.33) * s), seg_d(l, vec2(0.24, -0.31) * s, vec2(-0.24, 0.31) * s)),
				seg_d(l, vec2(-0.26, 0.33) * s, vec2(0.26, 0.33) * s));
			float hw = 0.075 * s;
			acc.rgb += c_main * 0.22 * za * soft(length(l), s * 0.9);
			acc = over(acc, c_deep, 0.85 * za * clamp(hw + max(1.25, 0.1 * s) - d + 0.5, 0.0, 1.0));
			acc = over(acc, c_light, za * clamp(hw - d + 0.5, 0.0, 1.0));
		}
	}
	COLOR = acc;
}
"""

var card = null
var icon = null
var anim = null
var art_seed = 0
var portrait = null
var signs = null
var frame_mix = null
var frame_add = null
var tick_add = null
var tick_mix = null
var puff = null
var kinds = []
#stealth: whether the card is in the shadows, how deep (0..1), and where its way in or out began (-1 while settled)
var hide_on = false
var hide_k = 0.0
var hide_from = 0.0
var hide_t0 = -1.0
var dens = 1.0
var floor_y = 170.0
var ticks = []
var clock = 0.0


static func equip(kit):
	if kit.has('aura_portrait'): return
	var shader = Shader.new()
	shader.code = PORTRAIT_SHADER
	kit.aura_portrait = shader
	shader = Shader.new()
	shader.code = SIGNS_SHADER
	kit.aura_signs = shader
	var fonts = DamageCounter.make_fonts(FONT_SIZE)
	kit.aura_font = fonts.font
	kit.aura_shadow = fonts.shadow


#compiles the two shaders at once: this project compiles a shader where it is first drawn, mid-fight otherwise
func warm_up(kit):
	equip(kit)
	use_kit(kit)
	set_process(false)
	add_layer(0, -1, '_draw_warm_up', kit.aura_portrait)
	add_layer(0, -1, '_draw_warm_up', kit.aura_signs)


#opts: `seed` for this card's own pattern, `anim` whose rate the tick runs at
func attach(node, kit, opts = {}):
	card = node
	anim = opts.get('anim')
	art_seed = int(opts.get('seed', 0))
	equip(kit)
	use_kit(kit)
	icon = node.get_node('Icon')
	#the bleeding frame goes over the card frame and under the status icons, as FrozenCard's ice does
	node.add_child(self)
	set_process(false)
	var buffs = node.get_node_or_null('Buffs')
	if buffs != null: node.move_child(self, buffs.get_index())
	frame_mix = add_layer(0, -1, '_draw_frame_mix')
	frame_add = add_layer(0, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_frame_add')
	puff = add_layer(0, -1, '_draw_puff')
	#a child of the portrait: it moves when the portrait shakes and stays behind the card frame
	portrait = add_layer(0, -1, '_draw_portrait', shared.aura_portrait, icon)
	portrait.material.set_shader_param('seed', float(art_seed))
	signs = add_layer(0, -1, '_draw_signs', shared.aura_signs, node)
	tick_add = add_layer(0, CanvasItemMaterial.BLEND_MODE_ADD, '_draw_tick_glow', null, signs)
	tick_mix = add_layer(0, -1, '_draw_tick', null, signs)


#the statuses the card has now, and where the buff row's dark strip begins (card px); `instant` skips stealth's way in
#or out, for a fighter that has just died
func refresh(new_kinds, strip_y, instant = false):
	kinds = new_kinds
	dens = DENS[min(kinds.size(), DENS.size() - 1)]
	floor_y = strip_y - icon.rect_position.y
	var desat = 0.0
	if icon.material is ShaderMaterial and icon.material.shader != null and icon.material.shader.resource_path.ends_with('desaturate.shader'):
		desat = float(icon.material.get_shader_param('percent'))
	var m = portrait.material
	m.set_shader_param('dens', dens)
	m.set_shader_param('floor_y', floor_y)
	m.set_shader_param('icon_desat', desat)
	for kind in ['sleep', 'poison', 'bleed', 'burn']:
		m.set_shader_param(kind, 1.0 if kinds.has(kind) else 0.0)
	if kinds.has('hide') != hide_on:
		hide_on = !hide_on
		hide_from = hide_k
		hide_t0 = clock
		set_process(true)
	if instant and hide_t0 >= 0.0:
		hide_t0 = -1.0
		hide_k = 1.0 if hide_on else 0.0
	m.set_shader_param('hide', hide_k)
	if hide_t0 < 0.0: m.set_shader_param('hide_flash', 0.0)
	portrait.update()
	signs.material.set_shader_param('dens', dens)
	signs.material.set_shader_param('sleep', 1.0 if kinds.has('sleep') else 0.0)
	signs.material.set_shader_param('stun', 1.0 if kinds.has('stun') else 0.0)
	frame_mix.update()
	frame_add.update()
	show_layers()
	if kinds.empty() and ticks.empty() and hide_t0 < 0.0: queue_free()


func show_layers():
	var shaded = hide_k > 0.0 or hide_t0 >= 0.0
	portrait.visible = kinds.has('sleep') or kinds.has('poison') or kinds.has('bleed') or kinds.has('burn') or !ticks.empty() or shaded
	signs.visible = kinds.has('sleep') or kinds.has('stun') or !ticks.empty()
	frame_mix.visible = kinds.has('bleed')
	frame_add.visible = kinds.has('bleed')
	puff.visible = hide_t0 >= 0.0


#`slot`: the status icon in the row, {rect, texture} in card px, or null when the card shows none
func begin_tick(status, slot, coloured):
	ticks.append({status = status, t0 = clock, slot = slot, text = null, coloured = coloured})
	show_layers()
	set_process(true)


#the damage of the tick begun last, which hp_update hands over
func tick_number(text):
	for i in range(ticks.size() - 1, -1, -1):
		if ticks[i].text == null:
			ticks[i].text = text
			return


func _process(delta):
	if portrait == null:
		set_process(false)
		return
	var rate = 1.0
	if anim != null and is_instance_valid(anim) and anim.get('rate') != null: rate = anim.rate
	clock += delta * rate
	var shifting = hide_step()
	var live = []
	for tk in ticks:
		if clock - tk.t0 < TICK_LIFE: live.append(tk)
	ticks = live
	var m = portrait.material
	if ticks.empty():
		m.set_shader_param('tick_a', 0.0)
		tick_add.update()
		tick_mix.update()
		if shifting: return
		set_process(false)
		show_layers()
		if kinds.empty(): queue_free()
		return
	#the newest tick's wave runs from the row up past the portrait's top
	var tk = ticks.back()
	var q = clock - tk.t0
	m.set_shader_param('tick_y', lerp(floor_y + 4.0, -20.0, out_quad(seg(q, 0.0, 0.42))))
	m.set_shader_param('tick_a', 0.62 * (1.0 - seg(q, 0.22, 0.5)))
	m.set_shader_param('tick_col', MAIN.get(tk.status, WHITE))
	tick_add.update()
	tick_mix.update()


#one frame of stealth's way in or out; false once it has settled
func hide_step():
	if hide_t0 < 0.0: return false
	var q = clock - hide_t0
	hide_k = lerp(hide_from, 1.0 if hide_on else 0.0, 0.5 - 0.5 * cos(PI * seg(q, 0.0, 0.6)))
	var m = portrait.material
	m.set_shader_param('hide', hide_k)
	m.set_shader_param('hide_flash', 0.0 if hide_on else bump(q, 0.0, 0.07, 0.4))
	puff.update()
	if q < (HIDE_IN if hide_on else HIDE_OUT): return true
	hide_t0 = -1.0
	m.set_shader_param('hide_flash', 0.0)
	show_layers()
	return false


func _exit_tree():
	for node in [portrait, signs]:
		if node != null and is_instance_valid(node): node.queue_free()
	portrait = null
	signs = null
	if anim != null and is_instance_valid(anim) and anim.get('status_auras') != null and anim.status_auras.get(card) == self:
		anim.status_auras.erase(card)


#--- layers -------------------------------------------------------------------------------------------------------------

func _draw_portrait(layer):
	if icon.texture == null: return
	#exactly where the Icon puts it, or the redrawn portrait comes out zoomed in
	var shown = texture_placement(icon)
	layer.draw_texture_rect_region(icon.texture, shown.rect, shown.region)


func _draw_signs(layer):
	layer.draw_rect(Rect2(-30, -50, 250, 145), WHITE)


#bleeding: a steady crimson glow along the inside of the portrait and a thin red line
func _draw_frame_mix(layer):
	var r = Rect2(icon.rect_position, icon.rect_size)
	inner_glow(layer, r, 34.0, BLEED_DEEP, 0.62 * dens)
	layer.draw_rect(Rect2(r.position + Vector2(1, 1), r.size - Vector2(2, 2)), fade(BLEED_LINE, 0.6 * dens), false, 2.0)


func _draw_frame_add(layer):
	inner_glow(layer, Rect2(icon.rect_position, icon.rect_size), 16.0, MAIN.bleed, 0.46 * dens)


#stealth: going in, dark smoke bursts out round the card; coming out, a few wisps rise off it (the flash is the shader's)
func _draw_puff(layer):
	if hide_t0 < 0.0: return
	var q = clock - hide_t0
	if hide_on:
		var a = seg(q, 0.0, 0.12) * (1.0 - seg(q, 0.25, 1.0))
		if a <= 0.01: return
		var s = out_cubic(seg(q, 0.0, 1.0))
		var c = card.rect_size / 2.0
		for i in range(10):
			var an = TAU * (i + 0.5 * hash01(art_seed * 7 + i)) / 10.0
			var dd = 40.0 + 70.0 * s
			d_blob(layer, c + Vector2(cos(an) * dd * 1.1, sin(an) * dd * 0.9), 34.0 + 30.0 * s, PUFF, 0.6 * a)
		return
	for i in range(4):
		var u = seg(q, 0.05 + i * 0.05, 0.9 + i * 0.05)
		if u <= 0.0 or u >= 1.0: continue
		d_blob(layer, Vector2(30.0 + 122.0 * hash01(art_seed * 13 + i), 150.0 - 110.0 * out_quad(u)), 18.0 + 16.0 * u, PUFF, 0.45 * sin(PI * u))


func inner_glow(layer, r, depth, col, a):
	var on = fade(col, a)
	var off = fade(col, 0.0)
	var x0 = r.position.x
	var y0 = r.position.y
	var x1 = r.end.x
	var y1 = r.end.y
	layer.draw_polygon(PoolVector2Array([Vector2(x0, y0), Vector2(x1, y0), Vector2(x1, y0 + depth), Vector2(x0, y0 + depth)]), PoolColorArray([on, on, off, off]))
	layer.draw_polygon(PoolVector2Array([Vector2(x0, y1 - depth), Vector2(x1, y1 - depth), Vector2(x1, y1), Vector2(x0, y1)]), PoolColorArray([off, off, on, on]))
	layer.draw_polygon(PoolVector2Array([Vector2(x0, y0), Vector2(x0 + depth, y0), Vector2(x0 + depth, y1), Vector2(x0, y1)]), PoolColorArray([on, off, off, on]))
	layer.draw_polygon(PoolVector2Array([Vector2(x1 - depth, y0), Vector2(x1, y0), Vector2(x1, y1), Vector2(x1 - depth, y1)]), PoolColorArray([off, on, on, off]))


func _draw_tick_glow(layer):
	for tk in ticks:
		if tk.slot == null: continue
		d_blob(layer, tk.slot.rect.position + tk.slot.rect.size / 2.0, tk.slot.rect.size.x * 1.35, MAIN.get(tk.status, WHITE), 0.85 * exp(-(clock - tk.t0) / 0.22))


func _draw_tick(layer):
	for tk in ticks:
		var q = clock - tk.t0
		var light = LIGHT.get(tk.status, WHITE)
		if tk.slot != null:
			var s = tk.slot.rect.size.x
			var c = tk.slot.rect.position + tk.slot.rect.size / 2.0
			var rq = seg(q, 0.0, 0.45)
			if rq < 1.0:
				var k = s * (1.0 + 0.9 * out_cubic(rq))
				layer.draw_rect(Rect2(c - Vector2(k, k) / 2.0, Vector2(k, k)), fade(light, 0.9 * (1.0 - rq)), false, 2.0)
			var grow = 1.0 + 0.28 * bump(q, 0.0, 0.06, 0.3)
			if grow > 1.001 and tk.slot.texture != null:
				var g = s * grow
				var box = Rect2(c - Vector2(g, g) / 2.0, Vector2(g, g))
				var shown = placement(tk.slot.texture.get_size(), box.size, TextureRect.STRETCH_KEEP_ASPECT_CENTERED)
				layer.draw_texture_rect_region(tk.slot.texture, Rect2(box.position + shown.rect.position, shown.rect.size), shown.region)
				layer.draw_rect(box, fade(light, 0.9), false, 1.5)
		if tk.text == null: continue
		var alpha = 1.0 - seg(q, 0.65, 1.05)
		var at = Vector2(91, 110)
		var rise = 32.0
		if tk.slot != null:
			at = Vector2(tk.slot.rect.position.x + tk.slot.rect.size.x / 2.0, tk.slot.rect.position.y - 6.0)
			rise = 62.0
		var pop = 0.4 + 0.6 * out_back(q / 0.1) if q < 0.1 else 1.0
		number(layer, tk.text, at - Vector2(0, rise * out_cubic(seg(q, 0.0, 1.2))), FONT_SIZE * pop, NUMBER.get(tk.status, GAME_RED) if tk.coloured else GAME_RED, alpha)


func number(layer, text, pos, size_px, color, alpha):
	DamageCounter.draw_number(layer, shared.aura_font, shared.aura_shadow, text, pos, size_px, color, alpha)
