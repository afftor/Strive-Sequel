shader_type canvas_item;
render_mode blend_mix;

uniform float percent = 1.0;
uniform float amount = 5.0;
uniform float rotate = 0.25;

const float PI = 3.1415;

void fragment(){
	vec2 uv1 = UV - vec2(0.5, 0.5);
	float len = length(uv1); 
	float angle = rotate * sin(len * 2.0 * PI * amount) * sin(TIME) * percent;
	mat2 transf = mat2(vec2(cos(angle), -sin(angle)), vec2(-sin(angle), cos(angle)));
	uv1 = uv1 * transf;
	uv1 = uv1 * len / length(uv1);
	
	vec2 ps = TEXTURE_PIXEL_SIZE * 3.0;
	
	vec4 color = texture(TEXTURE, uv1 + vec2(0.5, 0.5));
//	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(0.0, 0.0) * ps);
//	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(0.0, 0.0) * ps);
//	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(0.0, 0.0) * ps);
//	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(0.0, 0.0) * ps);
	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(0.0, -percent) * ps);
	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(0.0, percent) * ps);
	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2( -percent, 0.0) * ps);
	color += texture(TEXTURE, uv1 + vec2(0.5, 0.5) + vec2(percent, 0.0) * ps);
	color = color / 5.0;
	vec3 buf = color.rgb;
	vec3 mask = vec3(0.3, 0.59, 0.11);
	float l = dot(buf, mask);
	vec3 grey = vec3(l);
	color.rgb = mix (color.rgb, grey, percent);
	COLOR = color;
}