shader_type canvas_item;
render_mode blend_mix;

uniform vec4 target1color : hint_color;
uniform vec4 target2color : hint_color;
uniform vec4 target3color : hint_color;

uniform vec4 part1color : hint_color;
uniform vec4 part2color : hint_color;
uniform vec4 part3color : hint_color;

uniform float dist =0.7;

vec3 rgb2hsl( in vec3 c )
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
    vec4 color = texture(TEXTURE, UV);
	float a = color.a;
	vec3 t1 = target1color.rgb;
	vec3 t2 = target2color.rgb;
	vec3 t3 = target3color.rgb;
	vec3 k = color.rgb;
	if (distance(t1, k) < dist){
		vec3 dcolor = part1color.rgb;
		vec3 f1 = rgb2hsl(t1);
		vec3 f2 = rgb2hsl(dcolor);
		vec3 f = rgb2hsl(k);
		//f = f * (f2 / f1);
		float rot = f2.x - f1.x;
		f.x = f.x + rot;
		f.y = f.y * f2.y / f1.y;
		f.y = min (1.0, f.y);
		f.z = f.z * f2.z / f1.z;
		f.z = min (1.0, f.z);
		f = hsl2rgb(f);
		color = vec4(f.xyz, a);
		}
	else if (distance(t2, k) < dist){
		vec3 dcolor = part2color.rgb;
		vec3 f1 = rgb2hsl(t2);
		vec3 f2 = rgb2hsl(dcolor);
		vec3 f = rgb2hsl(k);
		//f = f * (f2 / f1);
		float rot = f2.x - f1.x;
		f.x = f.x + rot;
		f.y = f.y * f2.y / f1.y;
		f.y = min (1.0, f.y);
		f.z = f.z * f2.z / f1.z;
		f.z = min (1.0, f.z);
		f = hsl2rgb(f);
		color = vec4(f.xyz, a);
		}
	else if (distance(t3, k) < dist){
		vec3 dcolor = part3color.rgb;
		vec3 f1 = rgb2hsl(t3);
		vec3 f2 = rgb2hsl(dcolor);
		vec3 f = rgb2hsl(k);
		//f = f * (f2 / f1);
		float rot = f2.x - f1.x;
		f.x = f.x + rot;
		f.y = f.y * f2.y / f1.y;
		f.y = min (1.0, f.y);
		f.z = f.z * f2.z / f1.z;
		f.z = min (1.0, f.z);
		f = hsl2rgb(f);
		color = vec4(f.xyz, a);
		}
	COLOR = color;
}