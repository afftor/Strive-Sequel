extends "res://src/combat/FxNode.gd"
#The picture drawn before this pass, read back from the screen: drained of colour and tinted cold - time stopped -
#and/or broken along up to four straight cuts. Every piece slides along the cuts, the two sides of each cut drawn
#apart, with dark between them and light seeping out of the seams. The «Меч» mockup's desaturate and splitPass; the
#host sets it every frame in its own coordinates.

const MAX_LINES = 4

#l0..l3: a point of the cut and its direction. A destination pixel belongs to the piece whose slide brings a point of
#that very piece onto it; none does in a seam. The offset is turned into screen UV by the slope of the vertex
#transform, as in SpaceBend (GLES2 has no derivatives)
const SHADER = """shader_type canvas_item;
render_mode unshaded;
uniform int n = 0;
uniform float desat = 0.0;
uniform float slide = 0.0;
uniform float gap = 0.0;
uniform float glow = 0.0;
uniform vec4 glow_col : hint_color = vec4(0.588, 0.804, 1.0, 1.0);
uniform vec4 l0;
uniform vec4 l1;
uniform vec4 l2;
uniform vec4 l3;
varying vec2 px;
varying vec2 jx;
varying vec2 jy;

float side(vec4 l, vec2 p) {
	return dot(vec2(-l.w, l.z), p - l.xy) >= 0.0 ? 1.0 : -1.0;
}

vec2 shove(vec4 l, float s) {
	return s * (l.zw * slide * 0.5 + vec2(-l.w, l.z) * gap * 0.5);
}

float seam(vec4 l, float w) {
	return 1.0 - smoothstep(w - 1.0, w + 1.0, abs(dot(vec2(-l.w, l.z), px - l.xy)));
}

void vertex() {
	px = VERTEX;
	mat4 m = PROJECTION_MATRIX * WORLD_MATRIX * EXTRA_MATRIX;
	jx = 0.5 * m[0].xy;
	jy = 0.5 * m[1].xy;
}

void fragment() {
	vec2 src = px;
	bool hole = n > 0;
	float count = exp2(float(n));
	for (int m = 0; m < 16; m++) {
		float fm = float(m);
		if (hole && fm < count) {
			float s0 = mod(fm, 2.0) * 2.0 - 1.0;
			float s1 = mod(floor(fm / 2.0), 2.0) * 2.0 - 1.0;
			float s2 = mod(floor(fm / 4.0), 2.0) * 2.0 - 1.0;
			float s3 = mod(floor(fm / 8.0), 2.0) * 2.0 - 1.0;
			vec2 o = shove(l0, s0);
			if (n > 1) o += shove(l1, s1);
			if (n > 2) o += shove(l2, s2);
			if (n > 3) o += shove(l3, s3);
			vec2 q = px - o;
			bool ok = side(l0, q) == s0;
			if (n > 1) ok = ok && side(l1, q) == s1;
			if (n > 2) ok = ok && side(l2, q) == s2;
			if (n > 3) ok = ok && side(l3, q) == s3;
			if (ok) {
				src = q;
				hole = false;
			}
		}
	}
	vec2 d = src - px;
	vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV + jx * d.x + jy * d.y).rgb;
	if (hole) col = vec3(0.012, 0.012, 0.024);
	float l = dot(col, vec3(0.3, 0.59, 0.11));
	col = mix(col, vec3(l), desat);
	col = mix(col, vec3(0.039, 0.063, 0.133), 0.28 * desat);
	if (n > 0 && glow > 0.001) {
		float w = max(1.0, gap * 0.6) * 0.5;
		float g = seam(l0, w);
		if (n > 1) g = max(g, seam(l1, w));
		if (n > 2) g = max(g, seam(l2, w));
		if (n > 3) g = max(g, seam(l3, w));
		col += glow_col.rgb * 0.45 * glow * g;
	}
	COLOR = vec4(col, 1.0);
}
"""

var layer = null
var copier = null
var material_ = null
#frames left of a warm-up
var warming = 0


static func equip(kit):
	if kit.has('screen_slice'): return
	kit.screen_slice = Shader.new()
	kit.screen_slice.code = SHADER


#opts: `z` of the pass; what the host draws below it is read back, what it draws above stays as it is
func cover(host, kit, opts = {}):
	equip(kit)
	use_kit(kit)
	host.add_child(self)
	set_process(false)
	var z = int(opts.get('z', 81))
	copier = BackBufferCopy.new()
	copier.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT
	copier.z_index = z
	add_child(copier)
	layer = add_layer(z, -1, '_draw_screen', shared.screen_slice)
	material_ = layer.material
	show_pass(false)


#this frame's colour drain (0..1) and cuts: `cuts` [{a, b}] in the host's coordinates (each the whole line through
#a and b), `slide` how far the pieces have moved along them, `gap` how far apart the two sides stand, `glow` the light
#in the seams
func levels(drain, cuts = [], slide = 0.0, gap = 0.0, glow = 0.0, glow_col = Color(0.588, 0.804, 1.0)):
	var k = 0
	for cut in cuts:
		if k >= MAX_LINES: break
		var d = cut.b - cut.a
		if d.length() < 0.5: continue
		d = d.normalized()
		material_.set_shader_param('l%d' % k, Plane(cut.a.x, cut.a.y, d.x, d.y))
		k += 1
	var broken = k > 0 and (slide > 0.05 or gap > 0.05)
	material_.set_shader_param('n', k if broken else 0)
	material_.set_shader_param('desat', drain)
	material_.set_shader_param('slide', slide)
	material_.set_shader_param('gap', gap)
	material_.set_shader_param('glow', glow)
	material_.set_shader_param('glow_col', glow_col)
	show_pass(broken or drain > 0.004)


func show_pass(on):
	layer.visible = on
	copier.visible = on


#the shader compiles where it is first drawn: one pixel of the pass for a moment, then gone
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
