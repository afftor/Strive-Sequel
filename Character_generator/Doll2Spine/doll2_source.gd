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

const PLAYBOY_COLLAR = "collar_playboy"
const COLLAR_SLOT = "equip_collar"
const FRECKLES_REGION = "11_freckles/f2"

const LOADED = {}
const LOADED_SIGNATURES = {}


# Everything the rig brings with it, parsed on first ask and handed out after
# that.  An export that cannot be read gives an empty dictionary rather than a
# half-built one, and is not remembered, so a fixed file is picked up on the
# next try.
static func of(doll_id):
	var key = str(doll_id)
	var source = DOLLS.doll(key)
	var signature = _source_signature(source)
	if key == "male":
		signature = [signature, _source_signature(DOLLS.doll("female"))].hash()
	if LOADED.has(key) and LOADED_SIGNATURES.get(key, -1) == signature:
		return LOADED[key]
	# Spine exports are replaced while the editor stays open. Drop the parsed
	# source when any JSON, atlas or page changed, otherwise a reloaded preview
	# keeps displaying the old imported texture for the rest of the session.
	LOADED.erase(key)
	LOADED_SIGNATURES.erase(key)
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
	if key == "male":
		_share_female_accessories(built)
	for animation_name in skeleton.get("animations", {}).keys():
		built.animation_durations[animation_name] = _animation_duration(skeleton, animation_name)
	LOADED[key] = built
	LOADED_SIGNATURES[key] = signature
	return built


static func _share_female_accessories(built):
	var donor = of("female")
	if donor.empty():
		return
	# An older male export may carry stale bounds for the shared PNG. Keep
	# the head-weighted male mesh, but read the region from the owning atlas.
	if str(built.atlas.get(FRECKLES_REGION, {}).get("page", "")).begins_with("Doll2_spine4.2_female"):
		_share_region(donor, built, FRECKLES_REGION)

	var collars = built.skin_map.get("default", {}).get("attachments", {}).get(COLLAR_SLOT, {})
	if collars.empty() or collars.has(PLAYBOY_COLLAR):
		return
	var target_bones = built.skeleton.get("bones", [])
	var neck_index = -1
	for index in range(target_bones.size()):
		if target_bones[index].get("name", "") == "neck":
			neck_index = index
			break
	if neck_index == -1:
		return
	var bow = donor.skin_map.get("default", {}).get("attachments", {}).get(COLLAR_SLOT, {}).get(PLAYBOY_COLLAR, {})
	if bow.get("type", "") != "mesh":
		return
	var rebound = _bind_bow_to_neck(donor.skeleton.get("bones", []), bow, neck_index)
	if !rebound.empty() and _share_region(donor, built, str(bow.get("path", PLAYBOY_COLLAR))):
		collars[PLAYBOY_COLLAR] = rebound


static func _share_region(donor, built, path):
	if !donor.atlas.has(path):
		return false
	var region = donor.atlas[path]
	var page = donor.pages.get(region.page, {})
	if page.get("texture") == null:
		return false
	built.atlas[path] = region
	built.pages[region.page] = page
	return true


static func _bind_bow_to_neck(donor_bones, bow, neck_index):
	# The rigs share the neck's setup frame, not the collarbone layout.
	# Bake the shape in that frame rather than copying female weight indices.
	var definitions = {}
	for definition in donor_bones:
		definitions[definition.name] = definition
	if !definitions.has("neck"):
		return {}
	var transforms = {}
	var neck_inverse = _setup_transform("neck", definitions, transforms).affine_inverse()
	var original = bow.get("vertices", [])
	var uv_count = bow.get("uvs", []).size()
	if uv_count == 0 or original.size() <= uv_count:
		return {}
	var vertices = []
	var cursor = 0
	while cursor < original.size():
		var influences = int(original[cursor])
		cursor += 1
		if influences <= 0 or cursor + influences * 4 > original.size():
			return {}
		var point = Vector2.ZERO
		for _index in range(influences):
			var bone_index = int(original[cursor])
			if bone_index < 0 or bone_index >= donor_bones.size():
				return {}
			var transform = _setup_transform(donor_bones[bone_index].name, definitions, transforms)
			var local = Vector2(original[cursor + 1], original[cursor + 2])
			point += transform.xform(local) * float(original[cursor + 3])
			cursor += 4
		point = neck_inverse.xform(point)
		vertices.append_array([1, neck_index, point.x, point.y, 1.0])
	if vertices.size() != (uv_count / 2) * 5:
		return {}
	var attachment = bow.duplicate()
	attachment["vertices"] = vertices
	return attachment


static func _setup_transform(name, definitions, transforms):
	if !transforms.has(name):
		var bone = definitions[name]
		var rotation = float(bone.get("rotation", 0.0))
		var x_axis = Vector2.RIGHT.rotated(deg2rad(rotation + float(bone.get("shearX", 0.0)))) * float(bone.get("scaleX", 1.0))
		var y_axis = Vector2.DOWN.rotated(deg2rad(rotation + float(bone.get("shearY", 0.0)))) * float(bone.get("scaleY", 1.0))
		var transform = Transform2D(x_axis, y_axis, Vector2(bone.get("x", 0.0), bone.get("y", 0.0)))
		var parent = str(bone.get("parent", ""))
		if !parent.empty():
			transform = _setup_transform(parent, definitions, transforms) * transform
		transforms[name] = transform
	return transforms[name]


# Whether a rig has been read already - the preview panel says so out loud when
# it reloads, and a test can tell a cache hit from a cache miss.
static func is_loaded(doll_id):
	return LOADED.has(str(doll_id))


# Drop what is held. Only a tool that rewrites an export needs this; a game
# session never does.
static func forget():
	LOADED.clear()
	LOADED_SIGNATURES.clear()


static func _source_signature(source):
	if source == null or source.empty():
		return -1
	var paths = [str(source.get("json", "")), str(source.get("atlas", ""))]
	for texture in source.get("pages", {}).values():
		if texture is Resource and !texture.resource_path.empty():
			paths.append(texture.resource_path)
	var stamps = []
	var file = File.new()
	for path in paths:
		stamps.append([path, file.get_modified_time(path)])
	return stamps.hash()


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
				var texture = source.pages.get(current_page)
				# `pages` contains preloads so exported builds retain these resources,
				# but a preload already held by the editor may point at the old .stex.
				# Reload the same path without the ResourceLoader cache after a source
				# signature change.
				if texture is Resource and !texture.resource_path.empty():
					texture = ResourceLoader.load(texture.resource_path, "Texture", true)
				pages[current_page] = {"texture": texture, "size": Vector2.ZERO}
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


# How long an animation runs: the last keyframe on any timeline it carries.
# Some short facial animations (notably `say`) only animate slot colours, so
# ignoring slot timelines leaves them permanently stuck on their first frame.
static func _animation_duration(skeleton, animation_name):
	var duration = 0.0
	var animation = skeleton.get("animations", {}).get(animation_name, {})
	for bone_channels in animation.get("bones", {}).values():
		for frames in bone_channels.values():
			for frame in frames:
				duration = max(duration, float(frame.get("time", 0.0)))
	for slot_channels in animation.get("slots", {}).values():
		for frames in slot_channels.values():
			for frame in frames:
				duration = max(duration, float(frame.get("time", 0.0)))
	for skin_timelines in animation.get("attachments", {}).values():
		for slot_timelines in skin_timelines.values():
			for attachment_timelines in slot_timelines.values():
				for frames in attachment_timelines.values():
					for frame in frames:
						duration = max(duration, float(frame.get("time", 0.0)))
	for frame in animation.get("drawOrder", []):
		duration = max(duration, float(frame.get("time", 0.0)))
	for frame in animation.get("events", []):
		duration = max(duration, float(frame.get("time", 0.0)))
	return duration
