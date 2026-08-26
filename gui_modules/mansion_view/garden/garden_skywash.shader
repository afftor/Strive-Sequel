shader_type canvas_item;
render_mode blend_add, unshaded;
// Warm sunrise / sunset light washing in from one side, or cool moonlight.
// Additive, so it sits above the ambient grade.

uniform vec4 wash : hint_color = vec4(1.0, 0.6, 0.35, 1.0);
uniform float strength = 0.0;
uniform vec2 sun_dir = vec2(1.0, -0.35);
uniform float falloff = 1.6;

void fragment() {
	vec2 n = (UV - vec2(0.5)) * 2.0;
	float g = clamp(dot(normalize(sun_dir), n) * 0.5 + 0.5, 0.0, 1.0);
	COLOR = vec4(wash.rgb, pow(g, falloff) * strength);
}
