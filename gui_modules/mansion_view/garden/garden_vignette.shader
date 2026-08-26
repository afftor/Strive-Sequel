shader_type canvas_item;
// Elliptical vignette; the 0.72 squashes it to follow a 16:9 frame.
uniform vec3 tint = vec3(0.012, 0.027, 0.020);
uniform float inner = 0.34;
uniform float span = 0.74;
uniform float strength = 0.58;
uniform float curve = 1.4;

void fragment() {
	vec2 n = (UV - vec2(0.5)) * 2.0;
	float t = sqrt(n.x * n.x * 0.72 + n.y * n.y);
	float v = pow(clamp((t - inner) / span, 0.0, 1.0), curve) * strength;
	COLOR = vec4(tint, v);
}
