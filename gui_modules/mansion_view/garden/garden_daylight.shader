shader_type canvas_item;
render_mode unshaded;
// Ambient grade for the whole garden. It reads the frame back instead of
// multiplying over it, because a plain multiply also crushes the lamp pools:
// those are additive, they clip to white in the 8-bit target, and the multiply
// then repaints the clipped core in the ambient colour - warm lamps turned
// blue-green at night. Sampling lets bright pixels keep their own colour.
//
// Must sit directly above the backdrop and below anything that should not be
// graded (UI, tooltips).

uniform vec4 tint_sun : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 tint_shade : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
// Direction the light comes from, in screen space.
uniform vec2 sun_dir = vec2(1.0, -0.35);
uniform float edge_darken = 0.0;
uniform float amount = 1.0;
// How far a lit pixel resists the grade. 0 grades everything flat.
uniform float highlight_keep = 0.0;

void fragment() {
	vec3 src = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	vec2 n = (UV - vec2(0.5)) * 2.0;
	float g = clamp(dot(normalize(sun_dir), n) * 0.5 + 0.5, 0.0, 1.0);
	vec3 t = mix(tint_shade.rgb, tint_sun.rgb, g);
	float r = sqrt(n.x * n.x * 0.72 + n.y * n.y);
	t *= 1.0 - edge_darken * clamp((r - 0.30) / 0.80, 0.0, 1.0);
	t = mix(vec3(1.0), t, amount);
	float lum = dot(src, vec3(0.299, 0.587, 0.114));
	float keep = smoothstep(0.38, 0.90, lum) * highlight_keep;
	COLOR = vec4(mix(src * t, src, keep), 1.0);
}
