shader_type canvas_item;

uniform vec4 target1color : hint_color;

uniform vec4 part1color : hint_color;
uniform vec4 origin : hint_color;

uniform float overlay = 0.7;


vec3 rgb2hsl(vec3 c )
{
    float epsilon = 0.00000001;
    float cmin = min( c.r, min( c.g, c.b ) );
    float cmax = max( c.r, max( c.g, c.b ) );
    float cd   = cmax - cmin;
    vec3 hsl = vec3(0.0);
    hsl.z = (cmax + cmin) / 2.0;
    hsl.y = mix(cd / (cmax + cmin + epsilon), cd / (epsilon + 2.0 - (cmax + cmin)), step(0.5, hsl.z));

    vec3 a = vec3(1.0 - step(epsilon, abs(cmax - c)));
    a = mix(vec3(a.x, 0.0, a.z), a, step(0.5, 2.0 - a.x - a.y));
    a = mix(vec3(a.x, a.y, 0.0), a, step(0.5, 2.0 - a.x - a.z));
    a = mix(vec3(a.x, a.y, 0.0), a, step(0.5, 2.0 - a.y - a.z));
    
    hsl.x = dot( vec3(0.0, 2.0, 4.0) + ((c.gbr - c.brg) / (epsilon + cd)), a );
    hsl.x = (hsl.x + (1.0 - step(0.0, hsl.x) ) * 6.0 ) / 6.0;
	hsl.y = clamp (hsl.y, 0.0, 1.0);
    return hsl;
}

vec3 hsl2rgb(vec3 HSL)
{
  float R = abs(HSL.x * 6.0 - 3.0) - 1.0;
  float G = 2.0 - abs(HSL.x * 6.0 - 2.0);
  float B = 2.0 - abs(HSL.x * 6.0 - 4.0);
  vec3 RGB = clamp(vec3(R,G,B), 0.0, 1.0);
  float C = (1.0 - abs(2.0 * HSL.z - 1.0)) * HSL.y;
  return (RGB - 0.5) * C + HSL.z;
}


void fragment(){
    vec4 color = origin;
	float a = color.a;
	vec3 t1 = rgb2hsl(target1color.rgb);
	vec3 k = rgb2hsl(color.rgb);
	vec3 k_temp = color.rgb;
	vec3 dcolor = rgb2hsl(part1color.rgb);
	float rot = dcolor.x - t1.x;
	vec3 tres = k;
	tres.x = k.x + rot;
	tres.y = dcolor.y;
	tres.z *= dcolor.z/t1.z;
	tres.z = clamp(tres.z, 0.0, 1.0);
	if (tres.x > 1.0) tres.x -= 1.0;
	if (tres.x < 0.0) tres.x += 1.0;
	k_temp = hsl2rgb(tres);
	color = vec4(k_temp, a);
	COLOR = color;
}
