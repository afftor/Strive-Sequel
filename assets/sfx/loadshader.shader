shader_type canvas_item;
render_mode blend_mix;

uniform float dist = 1.0;
uniform float width = 0.0;

float newa(float xpos){
    return clamp((dist + width*0.5 - xpos)/width, 0.0, 1.0);
    }

void fragment(){
    vec4 color = texture(TEXTURE, UV);
    color.a *= newa(UV.x);
    COLOR = color;
    }