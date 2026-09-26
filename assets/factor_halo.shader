shader_type canvas_item;

uniform float period = 5.2;
uniform float turn = 18.0;

float ramp(float x, float lo, float hi) {
	return clamp((x - lo) / (hi - lo), 0.0, 1.0);
}

void fragment() {
	vec2 p = UV * 2.0 - vec2(1.0);
	float d = length(p);
	float pulse = 0.5 - 0.5 * cos(TIME * 6.2831853 / period);

	//0.93 keeps the grown halo inside the rect
	float r = d / (0.93 * mix(0.9, 1.06, pulse));
	float halo = (1.0 - 0.4 * ramp(r, 0.52, 0.66) - 0.4 * ramp(r, 0.66, 0.82) - 0.2 * ramp(r, 0.82, 1.0)) * mix(0.28, 0.95, pulse);

	float q = d / 0.976;
	float reach = 1.0 - 0.25 * ramp(q, 0.5, 0.64) - 0.5 * ramp(q, 0.64, 0.84) - 0.25 * ramp(q, 0.84, 1.0);
	float sector = fract((atan(p.y, p.x) / 6.2831853 - TIME / turn) * 12.0) * 30.0;
	float rays = max(1.0 - abs(sector - 6.0) / 6.0, 0.0) * reach;

	float body = 0.3 * (1.0 - ramp(d / 0.835, 0.6, 1.0));

	COLOR.a *= 1.0 - (1.0 - halo) * (1.0 - rays) * (1.0 - body);
}
