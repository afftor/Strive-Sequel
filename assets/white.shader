shader_type canvas_item;

render_mode blend_mix;
uniform vec4 modulate : hint_color;
uniform float percent = 0.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb = mix(color.rgb, modulate.rgb, percent);
    COLOR = color;
} 