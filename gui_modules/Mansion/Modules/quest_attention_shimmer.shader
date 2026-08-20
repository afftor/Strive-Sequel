shader_type canvas_item;
render_mode blend_add;

// The sheen that runs across the Local tasks button while a quest at the estate has nobody
// on it. Kept in its own file rather than inside MansionMainModule.tscn: an open scene in the
// editor is written back from memory on save, which silently undoes edits made to the .tscn
// on disk. MansionMainModule.gd assigns this at runtime, so tuning it here always takes.
// How far either side of the middle the band reaches, and the bright thread inside it.
uniform float halo_width = 0.105;
uniform float core_width = 0.032;

// How far the band leans. 0 is a straight vertical edge; the larger this is the more it
// slants across the button.
uniform float lean = 0.12;
uniform float halo_strength = 0.42;
uniform float core_strength = 0.72;

uniform vec4 halo_color : hint_color = vec4(1.0, 0.74, 0.30, 1.0);
uniform vec4 core_color : hint_color = vec4(1.0, 0.96, 0.52, 1.0);

// The sweep runs itself off TIME rather than being nudged from a script each frame. That way
// any number of buttons can wear it for the cost of setting them visible, and it also moves
// in the editor viewport without the game running.
uniform float sweep_time = 1.0;   // how long one pass across the button takes
uniform float cooldown = 2.0;     // quiet time before the next pass
uniform float sweep_start = -0.2; // just off the near edge
uniform float sweep_end = 1.35;   // and just past the far one

// Buttons that all start at once look like a single flashing row, so each is given a shove
// along the cycle; MansionMainModule and NavigationModule set it per button.
uniform float phase = 0.0;

void fragment() {
	// a slight lean reads as a sweep rather than a flat wipe
	float diagonal = UV.x + UV.y * lean;
	// parked off the near edge through the cooldown - there is nothing to see out there
	float span = sweep_time + max(cooldown, 0.0);
	float elapsed = fract((TIME + phase) / span) * span;
	float position = sweep_start;
	if (elapsed < sweep_time) {
		position = mix(sweep_start, sweep_end, elapsed / sweep_time);
	}
	// measured from the middle, so the halo and the core are two settings instead of four
	// edges that have to be kept in step with one another
	float dist = abs(diagonal - position);
	float halo = 1.0 - smoothstep(core_width, halo_width, dist);
	float core = 1.0 - smoothstep(0.0, core_width, dist);
	COLOR = vec4(mix(halo_color.rgb, core_color.rgb, core),
		halo * halo_strength + core * core_strength);
}
