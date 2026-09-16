shader_type canvas_item;
render_mode blend_mix, unshaded;
// Mist drifting over the mansion's grounds - see fog.gd, the node under mansion_backdrop.tscn's Sky that carries it.
// Soft patches of value noise in two layers, the second finer and slower, so the patches change shape as they
// move. Positions are the rect's own pixels, which are the picture's, so the mist stays on the grounds while the
// plan is moved or zoomed. The noise repeats every 64 patches: fog.gd wraps the drift offsets there,
// which keeps the numbers small without a visible seam.

uniform vec4 fog_color : hint_color = vec4(0.85, 0.88, 0.92, 1.0);
// How thick the mist is where it is thickest.
uniform float density : hint_range(0.0, 1.0) = 0.2;
// How much of the picture the patches cover, and how softly they fade out at their edges.
uniform float coverage : hint_range(0.0, 1.0) = 0.55;
uniform float softness : hint_range(0.01, 1.0) = 0.48;
// The size of a patch, in picture pixels.
uniform float patch_size = 900.0;
// Set every frame by fog.gd.
uniform vec2 offset_a = vec2(0.0, 0.0);
uniform vec2 offset_b = vec2(0.0, 0.0);

varying vec2 picture;

void vertex() {
	picture = VERTEX;
}

// A value for a noise cell, the same for cells 64 apart.
float hash(vec2 cell) {
	cell = mod(cell, 64.0);
	vec3 p = fract(vec3(cell.x, cell.y, cell.x) * 0.1031);
	p += dot(p, p.yzx + 33.33);
	return fract((p.x + p.y) * p.z);
}

float noise(vec2 p) {
	vec2 cell = floor(p);
	vec2 f = fract(p);
	vec2 u = f * f * (3.0 - 2.0 * f);
	float a = hash(cell);
	float b = hash(cell + vec2(1.0, 0.0));
	float c = hash(cell + vec2(0.0, 1.0));
	float d = hash(cell + vec2(1.0, 1.0));
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// Five octaves, each twice as fine and shifted by whole cells, so the 64-cell repeat holds for all of them.
float fbm(vec2 p) {
	float value = 0.0;
	float amplitude = 0.5;
	for (int i = 0; i < 5; i++) {
		value += amplitude * noise(p);
		p = p * 2.0 + vec2(7.0, 13.0);
		amplitude *= 0.5;
	}
	return value;
}

void fragment() {
	float slow = fbm((picture + offset_a) / patch_size);
	float fine = fbm((picture + offset_b) * 2.0 / patch_size + vec2(5.0, 11.0));
	float mist = slow * 0.7 + fine * 0.3;
	float edge = 1.0 - coverage;
	float thick = smoothstep(edge - softness * 0.5, edge + softness * 0.5, mist);
	COLOR = vec4(fog_color.rgb, fog_color.a * density * thick);
}
