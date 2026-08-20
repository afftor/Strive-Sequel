shader_type canvas_item;

// Recolours one colour channel of the Doll 2 paperdoll.  Two modes:
//
// PLAIN - the Spine slot is the zone.  A tail mesh only ever holds tail art, so
// no mask is needed: hue and saturation come from the picked colour and the
// texel keeps its own lightness.  Hair adds a second colour blended down the
// mesh, which is how the old paperdoll's two hair colours are carried over.
//
// ZONES - on top of that, art can be coded by hue: magenta for the first
// material, chartreuse for the second, spring green for the third.  Clothing and
// weapons are painted entirely that way, but so are wing membranes, tail tips
// and claws, which is why zones are not limited to gear.  Each band gets its own
// colour, exactly as the old item shader did with `abs(hue - target) < dist`
// instead of masks.
//
// The two work together: a zone colour wins on the pixels of its band, and the
// plain colour takes everything else.  A zone left white is off, so its pixels
// fall through to the plain colour - a claw follows the skin until it is given a
// colour of its own.

uniform vec4 recolor : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float strength : hint_range(0.0, 1.0) = 0.0;

uniform vec4 recolor2 : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float gradient_top = 0.0;
uniform float gradient_span = 0.0;

uniform vec3 zone_hues = vec3(0.83, 0.25, 0.43);
uniform vec3 zone_distance = vec3(0.042, 0.042, 0.072);
uniform vec4 zone1_color : hint_color = vec4(1.0);
uniform vec4 zone2_color : hint_color = vec4(1.0);
uniform vec4 zone3_color : hint_color = vec4(1.0);
uniform float zone1_on = 0.0;
uniform float zone2_on = 0.0;
uniform float zone3_on = 0.0;

// COVERAGE - fur and scale patterns, painted through the masks the old paperdoll
// already ships.  A mask is the full 872x1514 art canvas, while UV here points
// into the packed atlas, so `canvas_row0/1` carry the affine map back from one
// to the other.  It is per mesh, which is why coverage meshes get their own
// material instead of sharing the channel's.
uniform sampler2D coverage_mask1 : hint_black_albedo;
uniform sampler2D coverage_mask2 : hint_black_albedo;
uniform sampler2D coverage_mask3 : hint_black_albedo;
uniform vec4 coverage_color1 : hint_color = vec4(1.0);
uniform vec4 coverage_color2 : hint_color = vec4(1.0);
uniform vec4 coverage_color3 : hint_color = vec4(1.0);
uniform int coverage_count = 0;
uniform vec4 coverage_base : hint_color = vec4(1.0);
uniform float coverage_base_on = 0.0;
uniform vec4 canvas_row0 = vec4(1.0, 0.0, 0.0, 0.0);
uniform vec4 canvas_row1 = vec4(0.0, 1.0, 0.0, 0.0);

// Neutral lightness: a pick at 0.5 keeps the art's own brightness.
const float NEUTRAL_LIGHTNESS = 0.5;

varying vec4 modulate;
varying float gradient_mix;


vec3 rgb_to_hsl(vec3 color) {
	float high = max(max(color.r, color.g), color.b);
	float low = min(min(color.r, color.g), color.b);
	float lightness = (high + low) * 0.5;
	float delta = high - low;
	if (delta < 0.00001) {
		return vec3(0.0, 0.0, lightness);
	}
	float saturation = lightness > 0.5 ? delta / (2.0 - high - low) : delta / (high + low);
	float hue = 0.0;
	if (high == color.r) {
		hue = (color.g - color.b) / delta + (color.g < color.b ? 6.0 : 0.0);
	} else if (high == color.g) {
		hue = (color.b - color.r) / delta + 2.0;
	} else {
		hue = (color.r - color.g) / delta + 4.0;
	}
	return vec3(hue / 6.0, saturation, lightness);
}


float hue_channel(float p, float q, float t) {
	if (t < 0.0) {
		t += 1.0;
	}
	if (t > 1.0) {
		t -= 1.0;
	}
	if (t < 1.0 / 6.0) {
		return p + (q - p) * 6.0 * t;
	}
	if (t < 0.5) {
		return q;
	}
	if (t < 2.0 / 3.0) {
		return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
	}
	return p;
}


vec3 hsl_to_rgb(vec3 hsl) {
	if (hsl.y < 0.00001) {
		return vec3(hsl.z);
	}
	float q = hsl.z < 0.5 ? hsl.z * (1.0 + hsl.y) : hsl.z + hsl.y - hsl.z * hsl.y;
	float p = 2.0 * hsl.z - q;
	return vec3(
		hue_channel(p, q, hsl.x + 1.0 / 3.0),
		hue_channel(p, q, hsl.x),
		hue_channel(p, q, hsl.x - 1.0 / 3.0)
	);
}


// Darker picks multiply, lighter picks screen.  Both meet exactly at the neutral
// lightness, and neither crushes the art's shading the way a plain multiply does
// at the ends of the range.
float shift_lightness(float source, float target) {
	float value = target < NEUTRAL_LIGHTNESS
		? source * (target / NEUTRAL_LIGHTNESS)
		: 1.0 - (1.0 - source) * ((1.0 - target) / NEUTRAL_LIGHTNESS);
	return clamp(value, 0.0, 1.0);
}


float hue_gap(float first, float second) {
	float gap = abs(first - second);
	return min(gap, 1.0 - gap);
}


void vertex() {
	modulate = COLOR;
	gradient_mix = gradient_span > 0.0 ? clamp((VERTEX.y - gradient_top) / gradient_span, 0.0, 1.0) : 0.0;
}


void fragment() {
	vec4 texel = texture(TEXTURE, UV);
	vec3 rgb = texel.rgb;
	float applied = 0.0;
	vec3 source = rgb_to_hsl(rgb);
	vec3 target = vec3(0.0);

	bool coded = source.y > 0.15;
	if (coded && zone1_on > 0.0 && hue_gap(source.x, zone_hues.x) < zone_distance.x) {
		target = rgb_to_hsl(zone1_color.rgb);
		applied = 1.0;
	} else if (coded && zone2_on > 0.0 && hue_gap(source.x, zone_hues.y) < zone_distance.y) {
		target = rgb_to_hsl(zone2_color.rgb);
		applied = 1.0;
	} else if (coded && zone3_on > 0.0 && hue_gap(source.x, zone_hues.z) < zone_distance.z) {
		target = rgb_to_hsl(zone3_color.rgb);
		applied = 1.0;
	} else if (strength > 0.0) {
		target = rgb_to_hsl(mix(recolor.rgb, recolor2.rgb, gradient_mix));
		applied = strength;
	}

	if (applied > 0.0) {
		vec3 tinted = hsl_to_rgb(vec3(target.x, target.y, shift_lightness(source.z, target.z)));
		rgb = mix(rgb, tinted, applied);
	}

	// Fur goes on last, over whatever colour the body ended up with, so a pattern
	// reads the same on any skin.  The mask's alpha is the blend weight, curved
	// the way the old shader curved it so soft edges fade instead of cutting.
	if (coverage_count > 0) {
		vec2 canvas_uv = vec2(
			dot(canvas_row0.xy, UV) + canvas_row0.z,
			dot(canvas_row1.xy, UV) + canvas_row1.z
		);
		if (canvas_uv.x >= 0.0 && canvas_uv.x <= 1.0 && canvas_uv.y >= 0.0 && canvas_uv.y <= 1.0) {
			// The base goes down first, over the whole mesh.  Without it anything
			// reaching past the masks' torso silhouette - large breasts above all
			// - stays bare skin while the rest of the body is furred.
			if (coverage_base_on > 0.0) {
				vec3 base_hsl = rgb_to_hsl(coverage_base.rgb);
				vec3 base_lit = rgb_to_hsl(rgb);
				rgb = hsl_to_rgb(vec3(base_hsl.x, base_hsl.y, shift_lightness(base_lit.z, base_hsl.z)));
			}
			vec3 lit = rgb_to_hsl(rgb);
			for (int i = 0; i < 3; i++) {
				if (i >= coverage_count) {
					break;
				}
				float weight = texture(coverage_mask1, canvas_uv).a;
				vec4 fur = coverage_color1;
				if (i == 1) {
					weight = texture(coverage_mask2, canvas_uv).a;
					fur = coverage_color2;
				} else if (i == 2) {
					weight = texture(coverage_mask3, canvas_uv).a;
					fur = coverage_color3;
				}
				weight = clamp((2.0 - weight) * weight, 0.0, 1.0);
				if (weight > 0.0) {
					vec3 fur_hsl = rgb_to_hsl(fur.rgb);
					vec3 painted = hsl_to_rgb(vec3(fur_hsl.x, fur_hsl.y, shift_lightness(lit.z, fur_hsl.z)));
					rgb = mix(rgb, painted, weight);
					lit = rgb_to_hsl(rgb);
				}
			}
		}
	}
	// Some beastkin meshes carry an authored tint that was meant to match the
	// purple body art.  Fade it out as the channel takes over, otherwise a
	// recoloured part would keep a second colour multiplied on top of the pick.
	COLOR = vec4(rgb, texel.a) * vec4(mix(modulate.rgb, vec3(1.0), applied), modulate.a);
}
