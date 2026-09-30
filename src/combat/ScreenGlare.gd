extends "res://src/combat/FxNode.gd"
#A blinding light over the whole screen: the bright parts bloom, the picture is overexposed, and at the peak it burns
#out like Royal Flare - the dark goes a pale colour, everything brighter turns into soft white silhouettes. The host
#sets its levels every frame.

#what the glare adds on top of the burnt picture: the dark of the scene ends up this colour
const FLARE_WHITE = Color(0.839, 0.831, 0.8)
const FLARE_YELLOW = Color(0.839, 0.784, 0.424)

#The frame is read back: colour-dodge blows the bright parts out first; at the peak the picture, blurred through the
#screen texture's mipmaps, is burnt by `gain` and lifted by `lift`
const SCREEN_SHADER = """shader_type canvas_item;
render_mode unshaded;
uniform float bloom = 0.0;
uniform float expose = 0.0;
uniform float peak = 0.0;
uniform vec4 lift : hint_color = vec4(0.839, 0.791, 0.48, 1.0);
uniform float gain = 1.3;
uniform float soft = 5.0;

vec3 exposed(vec3 col, float e) {
	float d = 0.72 * e;
	return col / max(vec3(0.02), vec3(1.0) - d * vec3(1.0, 0.97, 0.9)) + vec3(1.0, 0.933, 0.863) * 0.3 * e;
}

void fragment() {
	vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	if (bloom > 0.001) {
		vec3 acc = vec3(0.0);
		for (int i = 0; i < 12; i++) {
			float a = float(i) * 0.5236;
			vec2 o = vec2(cos(a), sin(a)) * SCREEN_PIXEL_SIZE;
			vec3 near = texture(SCREEN_TEXTURE, SCREEN_UV + o * 16.0).rgb;
			vec3 far = texture(SCREEN_TEXTURE, SCREEN_UV + o * 36.0).rgb;
			acc += near * near * near + far * far * far;
		}
		col += acc / 12.0 * bloom;
	}
	col = min(exposed(col, expose), vec3(1.0));
	if (peak > 0.001) {
		vec2 o = SCREEN_PIXEL_SIZE * exp2(soft) * 0.5;
		vec3 blurred = (textureLod(SCREEN_TEXTURE, SCREEN_UV, soft).rgb * 2.0
			+ textureLod(SCREEN_TEXTURE, SCREEN_UV + vec2(o.x, o.y), soft).rgb + textureLod(SCREEN_TEXTURE, SCREEN_UV + vec2(-o.x, o.y), soft).rgb
			+ textureLod(SCREEN_TEXTURE, SCREEN_UV + vec2(o.x, -o.y), soft).rgb + textureLod(SCREEN_TEXTURE, SCREEN_UV - o, soft).rgb) / 6.0;
		vec3 burnt = clamp(min(exposed(blurred, expose), vec3(1.0)) * gain + lift.rgb, 0.0, 1.0);
		col = mix(col, burnt, min(peak, 1.0));
	}
	COLOR = vec4(col, 1.0);
}
"""

var layer = null
var material_ = null


static func equip(kit):
	if kit.has('glare_screen'): return
	var shader = Shader.new()
	shader.code = SCREEN_SHADER
	kit.glare_screen = shader


#opts: `z` of the layer; `gain` how fast the bright parts burn out, `soft` how soft the silhouettes are (the px of the
#mockup's «Мягкость»), `tint` the lift from white to yellow
func cover(host, kit, opts = {}):
	equip(kit)
	use_kit(kit)
	host.add_child(self)
	set_process(false)
	layer = add_layer(int(opts.get('z', 95)), -1, '_draw_screen')
	material_ = ShaderMaterial.new()
	material_.shader = shared.glare_screen
	material_.set_shader_param('gain', float(opts.get('gain', 1.3)))
	#the mockup blurred a half-size copy on a canvas 0.63 of the screen: its px are about 3.2 of ours, and a mipmap
	#level doubles the blur
	material_.set_shader_param('soft', log(max(1.0, float(opts.get('soft', 10.0)) * 3.2)) / log(2.0))
	material_.set_shader_param('lift', FLARE_WHITE.linear_interpolate(FLARE_YELLOW, float(opts.get('tint', 0.85))))
	layer.material = material_
	layer.visible = false


func levels(bloom, expose, peak):
	layer.visible = bloom > 0.01 or expose > 0.002 or peak > 0.002
	material_.set_shader_param('bloom', bloom)
	material_.set_shader_param('expose', expose)
	material_.set_shader_param('peak', peak)


func _draw_screen(node):
	var rect = get_viewport().get_visible_rect()
	var inverse = get_global_transform().affine_inverse()
	node.draw_rect(Rect2(inverse.xform(rect.position) - Vector2(80, 80), rect.size + Vector2(160, 160)), Color(1, 1, 1))
