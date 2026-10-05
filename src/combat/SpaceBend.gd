extends "res://src/combat/FxNode.gd"
#Space bent by dark magic. The picture drawn before this pass - the field, the cards, whatever is below its z or before
#it in the tree at the same z - is read back from the screen and drawn again with every pixel taken from somewhere
#else: a point lens, a swirl, a pinch or a swell, a ripple, a rift, a wavy membrane, wedges of broken glass, and an
#optional colour split. The host lists its bends every frame in its own coordinates. The «Тьма» mockup's WebGL pass,
#the same functions.

const MAX_BENDS = 8
const TYPES = {lens = 1, swirl = 2, pinch = 3, ripple = 4, rift = 5, wavy = 6, shatter = 7}

#a.x the type, a.yz the centre, a.w its size; b the rest (see bends()). The displacement is worked out in the layer's
#own coordinates and turned into screen UV by the slope of the vertex transform (SCREEN_UV = clip.xy * 0.5 + 0.5), so a
#moved or scaled host bends the right way; dFdx would do it too, but GLES2 has no derivatives
const SHADER = """shader_type canvas_item;
render_mode unshaded;
uniform int n = 0;
uniform float ca = 0.0;
uniform float clock = 0.0;
uniform vec4 a0; uniform vec4 b0;
uniform vec4 a1; uniform vec4 b1;
uniform vec4 a2; uniform vec4 b2;
uniform vec4 a3; uniform vec4 b3;
uniform vec4 a4; uniform vec4 b4;
uniform vec4 a5; uniform vec4 b5;
uniform vec4 a6; uniform vec4 b6;
uniform vec4 a7; uniform vec4 b7;
varying vec2 px;
varying vec2 jx;
varying vec2 jy;

vec2 turn(vec2 v, float a) {
	float c = cos(a);
	float s = sin(a);
	return vec2(c * v.x - s * v.y, s * v.x + c * v.y);
}

vec2 bend(vec2 p, vec4 a, vec4 b) {
	vec2 q = p;
	vec2 c = a.yz;
	vec2 v = q - c;
	float r = length(v);
	if (a.x < 1.5) {
		if (r > 0.5) {
			vec2 dv = -a.w * a.w * b.x * v / (r * r);
			float m = length(dv);
			float cap = 3.0 * a.w + 1.0;
			if (m > cap) dv *= cap / m;
			q += turn(dv, b.y * clamp(a.w / r, 0.0, 1.0));
		}
	} else if (a.x < 2.5) {
		if (r < a.w) {
			float k = 1.0 - r / a.w;
			q = c + turn(v, b.x * k * k);
		}
	} else if (a.x < 3.5) {
		if (r < a.w) {
			float k = 1.0 - r / a.w;
			q = c + v * (1.0 + b.x * k * k);
		}
	} else if (a.x < 4.5) {
		if (r > 0.5) {
			float x = (r - a.w) / max(b.x, 1.0);
			q += v / r * b.y * x * exp(-x * x) * 2.33;
		}
	} else if (a.x < 5.5) {
		vec2 e = b.xy - c;
		float len = max(length(e), 1.0);
		vec2 t = e / len;
		vec2 nr = vec2(-t.y, t.x);
		float u = clamp(dot(v, t) / len, 0.0, 1.0);
		float dd = dot(v, nr);
		float op = pow(max(sin(3.14159 * u), 0.0), 0.7) * a.w * (1.0 + b.w * sin(u * 31.0 + clock * 9.0));
		q -= nr * sign(dd + 0.0001) * op * exp(-(dd * dd) / max(b.z * b.z, 1.0));
	} else if (a.x < 6.5) {
		if (r < a.w) {
			float k = 1.0 - smoothstep(0.55 * a.w, a.w, r);
			float wl = max(b.y, 1.0);
			q += (v / max(r, 1.0)) * b.x * k * sin(r / wl * 6.2832 - clock * b.z)
				+ vec2(sin(q.y / wl * 6.2832 + clock * 2.1), cos(q.x / wl * 6.2832 - clock * 1.7)) * b.x * 0.35 * k;
		}
	} else {
		if (r < a.w && r > 1.0) {
			float w = 6.2832 / max(b.y, 1.0);
			float idx = floor((atan(v.y, v.x) + 3.14159) / w);
			float h = fract(sin(idx * 12.9898 + b.z) * 43758.5453);
			float mid = (idx + 0.5) * w - 3.14159;
			vec2 dir = vec2(cos(mid), sin(mid));
			float k = 1.0 - smoothstep(0.75 * a.w, a.w, r);
			q += (dir * (h * 2.0 - 1.0) + vec2(-dir.y, dir.x) * (fract(h * 7.31) - 0.5) * 0.6) * b.x * k;
		}
	}
	return q;
}

void vertex() {
	px = VERTEX;
	mat4 m = PROJECTION_MATRIX * WORLD_MATRIX * EXTRA_MATRIX;
	jx = 0.5 * m[0].xy;
	jy = 0.5 * m[1].xy;
}

void fragment() {
	vec2 s = px;
	if (n > 0) s = bend(s, a0, b0);
	if (n > 1) s = bend(s, a1, b1);
	if (n > 2) s = bend(s, a2, b2);
	if (n > 3) s = bend(s, a3, b3);
	if (n > 4) s = bend(s, a4, b4);
	if (n > 5) s = bend(s, a5, b5);
	if (n > 6) s = bend(s, a6, b6);
	if (n > 7) s = bend(s, a7, b7);
	vec2 d = s - px;
	vec2 duv = jx * d.x + jy * d.y;
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV + duv);
	if (ca > 0.001) {
		col.r = texture(SCREEN_TEXTURE, SCREEN_UV + duv * (1.0 + ca)).r;
		col.b = texture(SCREEN_TEXTURE, SCREEN_UV + duv * (1.0 - ca)).b;
	}
	COLOR = vec4(col.rgb, 1.0);
}
"""

var layer = null
var copier = null
var material_ = null
#frames left of a warm-up
var warming = 0


static func equip(kit):
	if kit.has('space_bend'): return
	kit.space_bend = Shader.new()
	kit.space_bend.code = SHADER


#opts: `z` of the pass; what the host draws below it is bent, what it draws above stays crisp
func cover(host, kit, opts = {}):
	equip(kit)
	use_kit(kit)
	host.add_child(self)
	set_process(false)
	var z = int(opts.get('z', 81))
	#a fresh copy of the screen right before the pass, whatever read the screen earlier in the frame
	copier = BackBufferCopy.new()
	copier.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT
	copier.z_index = z
	add_child(copier)
	layer = add_layer(z, -1, '_draw_screen', shared.space_bend)
	material_ = layer.material
	show_pass(false)


#this frame's bends in the host's coordinates, the colour split and the host's clock:
#lens {pos, r, k = 1, spin = 0} - r the Einstein radius, spin a twist near the ring
#swirl {pos, r, ang}; pinch {pos, r, k} - k > 0 sucks the picture in, k < 0 swells it
#ripple {pos, r, w, amp} - r the front; rift {pos, end, open, fall, wob}
#wavy {pos, r, amp, wl, speed}; shatter {pos, r, push, n, seed}
func bends(list, ca = 0.0, clock = 0.0):
	var k = 0
	for w in list:
		if k >= MAX_BENDS: break
		var ty = TYPES.get(w.type, 0)
		if ty == 0: continue
		var b = Plane(0, 0, 0, 0)
		match w.type:
			'lens': b = Plane(w.get('k', 1.0), w.get('spin', 0.0), 0, 0)
			'swirl': b = Plane(w.ang, 0, 0, 0)
			'pinch': b = Plane(w.k, 0, 0, 0)
			'ripple': b = Plane(w.w, w.amp, 0, 0)
			'rift': b = Plane(w.end.x, w.end.y, w.fall, w.get('wob', 0.0))
			'wavy': b = Plane(w.amp, w.wl, w.get('speed', 3.0), 0)
			'shatter': b = Plane(w.push, w.get('n', 12), w.get('seed', 1.0), 0)
		var size = w.get('open', 0.0) if w.type == 'rift' else w.r
		material_.set_shader_param('a%d' % k, Plane(ty, w.pos.x, w.pos.y, size))
		material_.set_shader_param('b%d' % k, b)
		k += 1
	material_.set_shader_param('n', k)
	material_.set_shader_param('ca', ca)
	material_.set_shader_param('clock', clock)
	show_pass(k > 0 or ca > 0.001)


func show_pass(on):
	layer.visible = on
	copier.visible = on


#the shader compiles where it is first drawn: one pixel of the pass, bent by nothing, for a moment, then gone - a pass
#that stayed would copy the screen every frame
func warm_up(host, kit):
	cover(host, kit, {z = 0})
	warming = 3
	show_pass(true)
	set_process(true)


func _process(_delta):
	if warming <= 0:
		set_process(false)
		return
	warming -= 1
	if warming == 0: queue_free()


func _draw_screen(node):
	if warming > 0:
		node.draw_rect(Rect2(0, 0, 1, 1), Color(1, 1, 1))
		return
	var rect = get_viewport().get_visible_rect()
	var inverse = get_global_transform().affine_inverse()
	node.draw_rect(Rect2(inverse.xform(rect.position) - Vector2(80, 80), rect.size + Vector2(160, 160)), Color(1, 1, 1))
