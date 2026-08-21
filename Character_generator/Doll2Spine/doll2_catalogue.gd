extends Reference

# Stable read API over the generated Doll 2 catalogue.
#
# Everything that renders or edits the doll talks to this file, never to
# doll2_catalogue_gen.gd directly: the generated file's shape may change with the
# next export, these functions may not.
#
# A selection is {group id: part id} plus {axis id: value}.  `compose` turns that
# into {slot name: attachment name}, which is all a renderer needs.

const DOLLS = preload("res://Character_generator/Doll2Spine/doll2_dolls.gd")
const MODS = preload("res://Character_generator/Doll2Spine/doll2_mods.gd")

# Which doll every call below reads.  There is one generated catalogue per
# skeleton and they are not interchangeable, so switching doll drops the merged
# view and rebuilds it from the new one.
const _ACTIVE = {"id": DOLLS.DEFAULT_DOLL}


static func use(doll_id):
	if !DOLLS.DOLLS.has(doll_id) or _ACTIVE.id == doll_id:
		return
	_ACTIVE.id = doll_id
	_MERGED.ready = false


static func doll_order():
	return DOLLS.ORDER


static func doll_label(doll_id):
	return str(DOLLS.doll(doll_id).label)


# The generated catalogue of the active doll.
static func _gen():
	return DOLLS.DOLLS[_ACTIVE.id].catalogue

# Modder-added parts are merged in on first use, so every reader below sees them
# without knowing they exist.  GDScript 3.5 has no static variables; a const
# container is the usual stand-in, because `const` freezes the reference rather
# than the contents.
const _MERGED = {"ready": false, "parts": {}, "group_parts": {}, "textures": {}, "problems": [], "sources": []}


static func _merge():
	if _MERGED.ready:
		return
	_MERGED.ready = true
	_MERGED.parts = _gen().PARTS.duplicate()
	_MERGED.group_parts = {}
	for group_id in _gen().GROUPS.keys():
		_MERGED.group_parts[group_id] = _gen().GROUPS[group_id].parts.duplicate()

	var collected = MODS.collect()
	_MERGED.problems = collected.problems
	_MERGED.sources = collected.sources
	if collected.parts.empty():
		return
	var resolved = MODS.resolve(_gen().PARTS, collected.parts)
	_MERGED.problems += resolved.problems
	MODS.validate(resolved.parts, resolved.textures, _gen().SLOT_ORDER, _MERGED.problems, _gen().GROUP_ORDER, _gen().PARTS.keys())
	_MERGED.textures = resolved.textures

	var ids = resolved.parts.keys()
	ids.sort()
	for part_id in ids:
		var part = resolved.parts[part_id]
		var group_id = str(part.get("group", ""))
		if !_MERGED.group_parts.has(group_id):
			_MERGED.problems.append("`%s`: group `%s` does not exist" % [part_id, group_id])
			continue
		var replaced = _MERGED.parts.has(part_id)
		_MERGED.parts[part_id] = part
		if !replaced:
			_MERGED.group_parts[group_id].append(part_id)
	for group_id in _MERGED.group_parts.keys():
		_MERGED.group_parts[group_id].sort()
	for problem in _MERGED.problems:
		push_warning("Doll2 mods: " + problem)


# Re-reads mod definitions, so a mod can be edited and picked up without
# restarting.  Also the way to reload after switching doll by hand.
static func reload_mods():
	_MERGED.ready = false
	_merge()


static func mod_problems():
	_merge()
	return _MERGED.problems


static func mod_sources():
	_merge()
	return _MERGED.sources


static func source():
	return _gen().SOURCE


static func slot_order():
	return _gen().SLOT_ORDER


# Slot order with the catalogue's draw-order corrections applied.  Renderers walk
# this, not SLOT_ORDER, or tattoos end up painted over the armour.
static func draw_order():
	return _gen().DRAW_ORDER


# The draw order corrections as rules - `{"slot": x, "before": y}`.  A renderer
# needs these when an animation reorders the slots itself: the baked DRAW_ORDER
# no longer applies, but the rule behind it still does.
static func draw_order_fixes():
	return _gen().DRAW_ORDER_FIXES


static func group_order():
	return _gen().GROUP_ORDER


static func group(group_id):
	return _gen().GROUPS.get(group_id, {})


static func parts(group_id):
	_merge()
	return _MERGED.group_parts.get(group_id, [])


static func part(part_id):
	_merge()
	return _MERGED.parts.get(part_id, {})


static func display(part_id):
	return part(part_id).get("display", part_id)


# Images a modded part paints over the base meshes: {slot name: image path}.
# Empty for everything that ships with the game.
static func part_textures(part_id):
	_merge()
	return _MERGED.textures.get(part_id, {})


static func axes():
	return _gen().AXES


static func presets():
	return _gen().PRESETS


static func color_channels():
	return _gen().COLOR_CHANNELS


# Hue bands the gear art is coded in, in degrees, and the half-width of a band.
static func zone_hues():
	return _gen().ZONE_HUES


static func zone_distance():
	return _gen().ZONE_DISTANCE


static func zone_defaults():
	return _gen().ZONE_DEFAULTS


# Which colour channel paints a slot, "" when the slot is never recoloured.
static func slot_channel(slot_name):
	return str(_gen().SLOT_COLORS.get(slot_name, ""))


# The channel whose picker belongs next to this group's control, "" when the
# group has none of its own (several groups share the skin channel).
static func channels_for_group(group_id):
	var result = []
	for channel_id in _gen().COLOR_CHANNELS.keys():
		if _gen().COLOR_CHANNELS[channel_id].anchor == group_id:
			result.append(channel_id)
	return result


static func default_selections():
	var result = {}
	for group_id in _gen().GROUP_ORDER:
		result[group_id] = _gen().GROUPS[group_id].get("default", "")
	return result


static func default_axes():
	var result = {}
	for axis in _gen().AXES.keys():
		result[axis] = _gen().AXES[axis].default
	return result


# First part of a group carrying a tag, "" when the group has none.  Used to keep
# a beastkin body and a beastkin head together without hardcoding either name.
static func first_part_with_tag(group_id, tag):
	for part_id in parts(group_id):
		if has_tag(part_id, tag):
			return part_id
	return ""


static func has_tag(part_id, tag):
	return tag in part(part_id).get("tags", [])


# Selections plus axis values -> {slot name: attachment name}.
# Groups are applied in GROUP_ORDER, so a later group (an outfit) may replace a
# slot an earlier one (the body) filled.  A part that declares a slot but has no
# attachment for the current axis value clears it: an outfit with no maternity
# piece must show nothing there, not the previous selection's mesh.
static func compose(selections, axis_values):
	var result = {}
	for slot_name in _gen().FIXED_SLOTS.keys():
		result[slot_name] = _gen().FIXED_SLOTS[slot_name]
	for group_id in _gen().GROUP_ORDER:
		var part_id = str(selections.get(group_id, ""))
		var chosen = part(part_id)
		if part_id.empty() or chosen.empty():
			continue
		if !bindings_met(part_id, selections):
			continue
		var slots = chosen.slots
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
	# A part can replace another one rather than sit on top of it: an animal lower
	# body takes the place of the legs, so those slots are cleared after everything
	# has been composed - the old doll hid its `l_body` node group for exactly this.
	for group_id in _gen().GROUP_ORDER:
		var part_id = str(selections.get(group_id, ""))
		if part_id.empty():
			continue
		for slot_name in part(part_id).get("hides", []):
			result.erase(slot_name)
	return result


# Which slots a selection paints with a modder's own image, in the same layering
# order as `compose`, so a later part's image wins exactly where its mesh does.
# Always empty until a mod is installed.
static func compose_textures(selections):
	var result = {}
	for group_id in _gen().GROUP_ORDER:
		var part_id = str(selections.get(group_id, ""))
		if part_id.empty():
			continue
		var chosen = part(part_id)
		if chosen.empty() or !bindings_met(part_id, selections):
			continue
		var textures = part_textures(part_id)
		for slot_name in chosen.slots.keys():
			result.erase(slot_name)
		for slot_name in textures.keys():
			result[slot_name] = textures[slot_name]
	return result


# Which hue-coded colour zones a part's art actually uses, as indices into
# ZONE_HUES.  Measured from the art by the build, so the UI can offer exactly the
# colours a part can take instead of a picker per zone on every row.
static func part_zones(part_id):
	return part(part_id).get("zones", [])


# The zones the whole selection can paint for one channel, so a channel's pickers
# match whatever is worn right now.
static func channel_zones(channel_id, selections):
	var channel = _gen().COLOR_CHANNELS.get(channel_id, {})
	if !channel.get("zones", false):
		return []
	var used = {}
	for group_id in _gen().GROUP_ORDER:
		var part_id = str(selections.get(group_id, ""))
		if part_id.empty():
			continue
		var touches = false
		for slot_name in part(part_id).get("slots", {}).keys():
			if slot_channel(slot_name) == channel_id:
				touches = true
				break
		if !touches:
			continue
		for index in part_zones(part_id):
			used[index] = true
	var result = used.keys()
	result.sort()
	return result


# What a part needs alongside it: group ids ("any hair") or exact part ids.
static func part_bindings(part_id):
	return part(part_id).get("binds", [])


# Whether a part can be worn with the rest of the selection.  A hair ornament
# with no hair, or a codpiece with no outfit, would otherwise hang in the air.
static func bindings_met(part_id, selections):
	for anchor in part_bindings(part_id):
		if selections.has(anchor):
			# A group: satisfied by any part chosen in it.
			if str(selections[anchor]).empty():
				return false
			continue
		# A specific part: it has to be the one selected in its own group.
		var anchor_group = str(part(anchor).get("group", ""))
		if anchor_group.empty() or str(selections.get(anchor_group, "")) != anchor:
			return false
	return true


# Bone tweaks the selected parts ask for, multiplied together: {bone: Vector2}.
# These compose with the height tier rather than replacing it, so a part that
# enlarges a bone still gets shorter on a small character.  Empty until a part
# declares any - nothing in the base catalogue does.
static func compose_bones(selections):
	var result = {}
	for group_id in _gen().GROUP_ORDER:
		var part_id = str(selections.get(group_id, ""))
		if !bindings_met(part_id, selections):
			continue
		var chosen = part(part_id)
		for bone_name in chosen.get("bones", {}).keys():
			var factor = chosen.bones[bone_name]
			var current = result.get(bone_name, Vector2.ONE)
			result[bone_name] = Vector2(current.x * factor.x, current.y * factor.y)
	return result


# Applies a preset over a copy of the given selections and returns it.
static func apply_preset(selections, preset_id):
	var result = selections.duplicate()
	for group_id in _gen().PRESETS.get(preset_id, {}).keys():
		result[group_id] = _gen().PRESETS[preset_id][group_id]
	return result
