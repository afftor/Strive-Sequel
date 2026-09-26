shader_type canvas_item;
render_mode blend_mul, unshaded;
// Flat multiply. Used to soak the ground when it rains.

uniform vec4 mul_color : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float amount = 1.0;
// Where the rain must not soak the ground, as a share of the screen - see garden_rain_mask.shader.
uniform sampler2D indoors : hint_black;
uniform vec4 indoors_rect = vec4(0.0, 0.0, 0.0, 0.0);

void fragment() {
	if (indoors_rect.z > 0.0 && indoors_rect.w > 0.0) {
		//SCREEN_UV counts up from the bottom, the rect down from the top
		vec2 screen = vec2(SCREEN_UV.x, 1.0 - SCREEN_UV.y);
		vec2 uv = (screen - indoors_rect.xy) / indoors_rect.zw;
		if (uv.x >= 0.0 && uv.x <= 1.0 && uv.y >= 0.0 && uv.y <= 1.0
				&& texture(indoors, uv).r > 0.5) {
			discard;
		}
	}
	COLOR = vec4(mix(vec3(1.0), mul_color.rgb, amount), 1.0);
}
