extends Reference

# Stable read API over the generated Doll 2 catalogue.
#
# Everything that renders or edits the doll talks to this file, never to
# doll2_catalogue_gen.gd directly: the generated file's shape may change with the
# next export, these functions may not.
#
# A selection is {group id: part id} plus {axis id: value}.  `compose` turns that
# into {slot name: attachment name}, which is all a renderer needs.

const GEN = preload("res://Character_generator/Doll2Spine/doll2_catalogue_gen.gd")


static func source():
	return GEN.SOURCE


static func slot_order():
	return GEN.SLOT_ORDER


# Slot order with the catalogue's draw-order corrections applied.  Renderers walk
# this, not SLOT_ORDER, or tattoos end up painted over the armour.
static func draw_order():
	return GEN.DRAW_ORDER


static func group_order():
	return GEN.GROUP_ORDER


static func group(group_id):
	return GEN.GROUPS.get(group_id, {})


static func parts(group_id):
	return GEN.GROUPS.get(group_id, {}).get("parts", [])


static func part(part_id):
	return GEN.PARTS.get(part_id, {})


static func display(part_id):
	return GEN.PARTS.get(part_id, {}).get("display", part_id)


static func axes():
	return GEN.AXES


static func presets():
	return GEN.PRESETS


static func color_channels():
	return GEN.COLOR_CHANNELS


# Hue bands the gear art is coded in, in degrees, and the half-width of a band.
static func zone_hues():
	return GEN.ZONE_HUES


static func zone_distance():
	return GEN.ZONE_DISTANCE


static func zone_defaults():
	return GEN.ZONE_DEFAULTS


# Which colour channel paints a slot, "" when the slot is never recoloured.
static func slot_channel(slot_name):
	return str(GEN.SLOT_COLORS.get(slot_name, ""))


# The channel whose picker belongs next to this group's control, "" when the
# group has none of its own (several groups share the skin channel).
static func channel_for_group(group_id):
	for channel_id in GEN.COLOR_CHANNELS.keys():
		if GEN.COLOR_CHANNELS[channel_id].anchor == group_id:
			return channel_id
	return ""


static func default_selections():
	var result = {}
	for group_id in GEN.GROUP_ORDER:
		result[group_id] = GEN.GROUPS[group_id].get("default", "")
	return result


static func default_axes():
	var result = {}
	for axis in GEN.AXES.keys():
		result[axis] = GEN.AXES[axis].default
	return result


# First part of a group carrying a tag, "" when the group has none.  Used to keep
# a beastkin body and a beastkin head together without hardcoding either name.
static func first_part_with_tag(group_id, tag):
	for part_id in parts(group_id):
		if tag in GEN.PARTS[part_id].get("tags", []):
			return part_id
	return ""


static func has_tag(part_id, tag):
	return tag in GEN.PARTS.get(part_id, {}).get("tags", [])


# Selections plus axis values -> {slot name: attachment name}.
# Groups are applied in GROUP_ORDER, so a later group (an outfit) may replace a
# slot an earlier one (the body) filled.  A part that declares a slot but has no
# attachment for the current axis value clears it: an outfit with no maternity
# piece must show nothing there, not the previous selection's mesh.
static func compose(selections, axis_values):
	var result = {}
	for slot_name in GEN.FIXED_SLOTS.keys():
		result[slot_name] = GEN.FIXED_SLOTS[slot_name]
	for group_id in GEN.GROUP_ORDER:
		var part_id = str(selections.get(group_id, ""))
		if part_id.empty() or !GEN.PARTS.has(part_id):
			continue
		var slots = GEN.PARTS[part_id].slots
		for slot_name in slots.keys():
			var value = slots[slot_name]
			if typeof(value) != TYPE_DICTIONARY:
				result[slot_name] = value
				continue
			var axis_value = str(axis_values.get(value.axis, ""))
			if value.options.has(axis_value):
				result[slot_name] = value.options[axis_value]
			else:
				result.erase(slot_name)
	return result


# Applies a preset over a copy of the given selections and returns it.
static func apply_preset(selections, preset_id):
	var result = selections.duplicate()
	for group_id in GEN.PRESETS.get(preset_id, {}).keys():
		result[group_id] = GEN.PRESETS[preset_id][group_id]
	return result
