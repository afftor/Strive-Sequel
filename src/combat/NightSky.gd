extends "res://src/combat/FxNode.gd"
#Night falls over the combat screen: it darkens, and stars twinkle in its upper part. Made for «Дождь стрел» and taken
#out of it on request; nothing uses it now. Both pieces are drawn once, so a frame of it costs two shader uniforms.
#The owner adds it as a child and drives it: fall() once, then dusk() every frame with its own clock.

#every star's twinkle speed and phase ride in red and green, its brightness in alpha
const STARS_SHADER = """shader_type canvas_item;
render_mode blend_add;
uniform float level = 0.0;
uniform float clock = 0.0;
void fragment() {
	float tw = 0.5 + 0.5 * sin(clock * (2.0 + 5.0 * COLOR.r) + COLOR.g * 6.28318);
	COLOR = vec4(0.863, 0.922, 1.0, texture(TEXTURE, UV).a * COLOR.a * level * (0.35 + 0.65 * tw));
}
"""

var view = Rect2(0, 0, 1920, 1080)
var dark = 0.42
var count = 110
var veil = null
var stars = null


static func equip(kit):
	if kit.has('night_stars'): return
	kit.night_stars = Shader.new()
	kit.night_stars.code = STARS_SHADER


#opts: `z` of the dark veil (the stars go one above it), `dark` how black full night is, `stars` how many.
#The veil covers the owner's screen with a margin, so a shaken screen never shows its edge.
func fall(kit, opts = {}):
	equip(kit)
	use_kit(kit)
	view = screen_rect()
	dark = float(opts.get('dark', 0.42))
	count = int(opts.get('stars', 110))
	var z = int(opts.get('z', 78))
	veil = Node2D.new()
	veil.z_index = z
	veil.modulate.a = 0.0
	add_child(veil)
	veil.connect('draw', self, '_draw_veil', [veil])
	stars = Node2D.new()
	stars.z_index = z + 1
	stars.material = ShaderMaterial.new()
	stars.material.shader = shared.night_stars
	add_child(stars)
	stars.connect('draw', self, '_draw_stars', [stars])


#how deep the night is, 0 to 1, and the owner's clock, which the stars twinkle by
func dusk(level, clock):
	if veil == null: return
	veil.modulate.a = dark * clamp(level, 0.0, 1.0)
	stars.material.set_shader_param('level', 0.85 * clamp(level, 0.0, 1.0))
	stars.material.set_shader_param('clock', clock)


func _draw_veil(node):
	node.draw_rect(view.grow(160.0), Color(0, 0, 0, 1))


func _draw_stars(node):
	for i in range(count):
		var p = Vector2(view.position.x + view.size.x * hash01(i + 2000), view.position.y + 10.0 + 420.0 * pow(hash01(i + 2001), 1.3))
		var r = 2.0 * (0.8 + 2.2 * hash01(i + 2002))
		node.draw_texture_rect_region(shared.atlas, Rect2(p - Vector2(r, r), Vector2(r, r) * 2.0), SOFT_PX,
			Color(hash01(i + 2003), fposmod(float(i), TAU) / TAU, 0.0, 0.4 + 0.6 * hash01(i + 2004)))
