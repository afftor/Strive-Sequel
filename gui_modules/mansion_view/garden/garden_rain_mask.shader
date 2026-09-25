shader_type canvas_item;
// Keeps the rain off whatever the mask calls indoors. indoors_rect is where the mask lies on the
// screen as a share of it - x, y, width, height, all 0..1; a width of zero leaves the rain whole.

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
}
