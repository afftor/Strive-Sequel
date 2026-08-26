shader_type canvas_item;
render_mode blend_mul, unshaded;
// Flat multiply. Used to soak the ground when it rains.

uniform vec4 mul_color : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float amount = 1.0;

void fragment() {
	COLOR = vec4(mix(vec3(1.0), mul_color.rgb, amount), 1.0);
}
