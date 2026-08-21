extends Reference

# The half of a doll that is the same for every doll wearing the same rig: the
# parsed Spine export, its skins, its atlas regions and how long each animation
# runs.
#
# Reading it costs 3.1 MB of JSON (2.1 for the male rig) and about a tenth of a
# second, and it used to be paid once per doll on screen.  Eight scenes embed
# `Doll2View` and two more build one in code - the portrait booth and the option
# pictures - and none of those screens are ever freed, so the game ended up
# holding ten private copies of identical numbers, ~24 MB apiece.
#
# What is deliberately *not* here is everything a doll does with that data: the
# solved bones, the composed selections, the meshes, their materials, the colours
# and the pose.  Those differ from screen to screen - one shows a bust, another a
# naked body, a third a head for a portrait - and stay on the instance, which is
# what makes sharing the rest safe.  Nothing in here is written to after it is
# built: `_resolve_attachment` duplicates an attachment before it annotates it,
# `_draw_ordered_slots` builds its own array, and the pose is solved into `bones`,
# which the instance owns.
#
# A `const` dictionary is the GDScript 3 way of writing a static: it belongs to
# the script rather than to any instance, and it lives as long as the script is
# loaded - the whole session.

const DOLLS = preload("res://Character_generator/Doll2Spine/doll2_dolls.gd")

const LOADED = {}


# Everything the rig brings with it, parsed on first ask and handed out after
# that.  An export that cannot be read gives an empty dictionary rather than a
# half-built one, and is not remembered, so a fixed file is picked up on the
# next try.
static func of(doll_id):
	var key = str(doll_id)
	if LOADED.has(key):
		return LOADED[key]
	var source = DOLLS.doll(key)
	if source == null or source.empty():
		push_error("Doll2 source: `%s` is not a doll this project ships" % key)
		return {}
	var skeleton = _read_skeleton(source)
	if skeleton.empty():
		return {}
	var built = {
		"skeleton": skeleton,
		"slot_data": skeleton.get("slots", []),
		"skin_map": {},
		"atlas": {},
		"pages": {},
		"animation_durations": {},
	}
	for skin in skeleton.get("skins", []):
		built.skin_map[skin.get("name", "")] = skin
	_read_atlas(source, built)
	for animation_name in skeleton.get("animations", {}).keys():
		built.animation_durations[animation_name] = _animation_duration(skeleton, animation_name)
	LOADED[key] = built
	return built


# Whether a rig has been read already - the preview panel says so out loud when
# it reloads, and a test can tell a cache hit from a cache miss.
static func is_loaded(doll_id):
	return LOADED.has(str(doll_id))


# Drop what is held. Only a tool that rewrites an export needs this; a game
# session never does.
static func forget():
	LOADED.clear()


static func _read_skeleton(source):
	var file = File.new()
	if file.open(source.json, File.READ) != OK:
		push_error("Doll2 source: Spine JSON was not found")
		return {}
	var parsed = JSON.parse(file.get_as_text())
	file.close()
	if parsed.error != OK:
		push_error("Doll2 source: cannot parse Spine JSON: " + parsed.error_string)
		return {}
	return parsed.result


# The atlas is a flat text file: a page, then its regions, each with bounds,
# offsets and whether it was packed rotated.
static func _read_atlas(source, built):
	var file = File.new()
	if file.open(source.atlas, File.READ) != OK:
		push_error("Doll2 source: Spine atlas was not found")
		return
	var pages = built.pages
	var atlas = built.atlas
	var current_page = ""
	var current_region = ""
	for raw_line in file.get_as_text().split("\n"):
		var line = raw_line.strip_edges()
		if line.empty():
			current_region = ""
			continue
		if line.find(":") == -1:
			if line.ends_with(".png"):
				current_page = line
				pages[current_page] = {"texture": source.pages.get(current_page), "size": Vector2.ZERO}
			else:
				current_region = line
				atlas[current_region] = {"page": current_page, "bounds": Rect2(), "offset": Vector2.ZERO, "source_size": Vector2.ZERO, "rotate": false}
			continue
		var split = line.split(":", false, 1)
		if split.size() != 2:
			continue
		var key = split[0].strip_edges()
		var value = split[1].strip_edges()
		if current_region.empty():
			if key == "size" and pages.has(current_page):
				var page_data = pages[current_page]
				page_data["size"] = _atlas_vector(value)
				pages[current_page] = page_data
		elif atlas.has(current_region):
			if key == "bounds":
				var values = _atlas_floats(value)
				if values.size() == 4:
					var bounds_data = atlas[current_region]
					bounds_data["bounds"] = Rect2(values[0], values[1], values[2], values[3])
					atlas[current_region] = bounds_data
			elif key == "offsets":
				var offset_values = _atlas_floats(value)
				if offset_values.size() == 4:
					var offset_data = atlas[current_region]
					offset_data["offset"] = Vector2(offset_values[0], offset_values[1])
					offset_data["source_size"] = Vector2(offset_values[2], offset_values[3])
					atlas[current_region] = offset_data
			elif key == "rotate":
				var rotation_data = atlas[current_region]
				rotation_data["rotate"] = value == "90" or value == "true"
				atlas[current_region] = rotation_data
	file.close()


static func _atlas_floats(value):
	var result = []
	for part in value.split(","):
		result.append(float(part.strip_edges()))
	return result


static func _atlas_vector(value):
	var values = _atlas_floats(value)
	return Vector2(values[0], values[1]) if values.size() == 2 else Vector2.ZERO


# How long an animation runs: the last keyframe on any bone or attachment
# timeline it carries.
static func _animation_duration(skeleton, animation_name):
	var duration = 0.0
	var animation = skeleton.get("animations", {}).get(animation_name, {})
	for bone_channels in animation.get("bones", {}).values():
		for frames in bone_channels.values():
			for frame in frames:
				duration = max(duration, float(frame.get("time", 0.0)))
	for skin_timelines in animation.get("attachments", {}).values():
		for slot_timelines in skin_timelines.values():
			for attachment_timelines in slot_timelines.values():
				for frames in attachment_timelines.values():
					for frame in frames:
						duration = max(duration, float(frame.get("time", 0.0)))
	return duration
