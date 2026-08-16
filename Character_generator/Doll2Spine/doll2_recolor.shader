shader_type canvas_item;

// Recolours one colour channel of the Doll 2 paperdoll.  Two modes:
//
// PLAIN - the Spine slot is the zone.  A tail mesh only ever holds tail art, so
// no mask is needed: hue and saturation come from the picked colour and the
// texel keeps its own lightness.  Hair adds a second colour blended down the
// mesh, which is how the old paperdoll's two hair colours are carried over.
//
// ZONED - clothing and weapons.  That art is not painted in its final colours:
// it is coded by hue, magenta for the main material, green for the second, cyan
// for the third, and the shader maps each band to a picked colour.  This is the
// same idea as the old item shader, which selected zones with `abs(hue - target)
// < dist` rather than with masks.  Pixels outside every band - outlines,
// highlights, leather straps painted in their final colour - are left alone.

uniform vec4 recolor : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float strength : hint_range(0.0, 1.0) = 0.0;

uniform vec4 recolor2 : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float gradient_top = 0.0;
uniform float gradient_span = 0.0;

uniform int zone_count = 0;
uniform vec3 zone_hues = vec3(0.0);
uniform float zone_distance = 0.083;
uniform vec4 zone1_color : hint_color = vec4(1.0);
uniform vec4 zone2_color : hint_color = vec4(1.0);
uniform vec4 zone3_color : hint_color = vec4(1.0);

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

	if (zone_count > 0) {
		if (source.y > 0.15 && hue_gap(source.x, zone_hues.x) < zone_distance) {
			target = rgb_to_hsl(zone1_color.rgb);
			applied = 1.0;
		} else if (zone_count > 1 && source.y > 0.15 && hue_gap(source.x, zone_hues.y) < zone_distance) {
			target = rgb_to_hsl(zone2_color.rgb);
			applied = 1.0;
		} else if (zone_count > 2 && source.y > 0.15 && hue_gap(source.x, zone_hues.z) < zone_distance) {
			target = rgb_to_hsl(zone3_color.rgb);
			applied = 1.0;
		}
	} else if (strength > 0.0) {
		target = rgb_to_hsl(mix(recolor.rgb, recolor2.rgb, gradient_mix));
		applied = strength;
	}

	if (applied > 0.0) {
		vec3 tinted = hsl_to_rgb(vec3(target.x, target.y, shift_lightness(source.z, target.z)));
		rgb = mix(rgb, tinted, applied);
	}
	// Some beastkin meshes carry an authored tint that was meant to match the
	// purple body art.  Fade it out as the channel takes over, otherwise a
	// recoloured part would keep a second colour multiplied on top of the pick.
	COLOR = vec4(rgb, texel.a) * vec4(mix(modulate.rgb, vec3(1.0), applied), modulate.a);
}
