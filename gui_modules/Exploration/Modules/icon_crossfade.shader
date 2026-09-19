shader_type canvas_item;
//A requirement icon that stands for a choice (one of several races or personalities) blends from its
//texture into next_texture as blend goes from 0 to 1. Both are sampled with the same UV, so the options
//must share an aspect ratio (race portraits and personality faces are square). SlaveQuestModule drives it.
uniform sampler2D next_texture;
uniform float blend : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	COLOR = mix(texture(TEXTURE, UV), texture(next_texture, UV), blend) * COLOR;
}
