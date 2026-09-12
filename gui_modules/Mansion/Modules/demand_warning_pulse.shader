shader_type canvas_item;

// The blink on the food/bed warning badge that sits beside a character's portrait: something
// the estate is about to fail to give them when the turn ends. Kept in its own file for the
// same reason as quest_attention_shimmer.shader - an open scene in the editor is written back
// from memory on save, which silently undoes a material edited inside the .tscn on disk.
// MansionSlaveListModule.gd assigns this at runtime, so tuning it here always takes.

// How far the icon fades at the bottom of the breath, and how long one breath lasts. It never
// goes fully out: a badge that disappears reads as a redraw glitch rather than as a warning.
uniform float dim = 0.34;
uniform float period = 1.1;

// The tint the badge is pulled towards at the top of the breath. Warning red, mixed in rather
// than replacing the icon so the picture on it stays readable.
uniform vec4 flash_color : hint_color = vec4(1.0, 0.42, 0.32, 1.0);
uniform float flash_strength = 0.45;

// Driven off TIME rather than nudged from a script each frame, so any number of cards can wear
// it for the cost of setting them visible, and it also moves in the editor viewport.
uniform float phase = 0.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	// a sine breath rather than a square blink - the badge is small, and a hard on/off at this
	// size reads as flicker
	float breath = 0.5 + 0.5 * sin((TIME + phase) * 6.2831853 / max(period, 0.01));
	tex.rgb = mix(tex.rgb, flash_color.rgb, flash_strength * breath);
	tex.a *= mix(dim, 1.0, breath);
	COLOR = tex * COLOR;
}
