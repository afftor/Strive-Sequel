shader_type canvas_item;
render_mode blend_mix;

uniform float percent = 1.0;

void fragment(){
    vec4 color = texture(TEXTURE, UV);
    vec3 buf = color.rgb;
    vec3 mask = vec3(0.3, 0.59, 0.11);
    float l = dot(buf, mask);
    vec3 grey = vec3(l);
    color.rgb = mix (color.rgb, grey, percent);
    COLOR = color;
}