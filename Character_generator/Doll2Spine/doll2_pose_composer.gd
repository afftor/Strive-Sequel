extends Reference

# Builds one animation out of several authored sex takes, body region by body
# region: the legs from one take, the arms from another, the mouth from a third.
#
# Every take is drawn on the same standing pose - none keys `bone4`, the torso and
# the pelvis only bob - which is what makes the regions interchangeable.  A
# region is a set of root bones (REGION_ROOTS); a slot belongs to the region its
# meshes are weighted to, measured from the export, so a re-export needs no list
# kept in step here.
#
# The partner penises are bones hung off `root` and placed in world space for
# their take's own torso bob, so a penis that comes with a part follows it by the
# difference between the two bobs.  The three front slots are the same canvas art
# set side by side, so a penis with no deform of its own can move between them;
# a deformed one keeps its slot, because a deform belongs to one mesh.

const PENIS_CHAINS = {
	"penis": ["penis1", "penis2", "penis3"],
	"penis2": ["bone5", "bone6", "bone7"],
	"penis3": ["bone13", "bone14", "bone15"],
	"penis_minet": ["bone8", "bone9", "bone10", "bone11"],
	"penis_minet2": ["bone16", "bone17", "bone18", "bone19"],
}
const FRONT_SLOTS = ["penis", "penis2", "penis3"]

# The penis each take shows, what it stands for, and the region it comes with.
const TAKE_PENISES = {
	"sex_standing": {"penis": ["vaginal", "lower"]},
	"sex_missionary": {"penis": ["vaginal", "lower"]},
	"anal_missionary": {"penis": ["anal", "lower"]},
	"double_pen": {"penis": ["vaginal", "lower"], "penis2": ["anal", "lower"]},
	"blowjob": {"penis3": ["mouth", "head"]},
	"titjob": {"penis": ["tits", "chest"]},
	"handjob1": {"penis": ["hand", "arms"]},
	"handjob2": {"penis": ["hand", "arms"]},
	"simult_handjob": {"penis_minet": ["hand_left", "arms"], "penis_minet2": ["hand_right", "arms"]},
	"handjobside1": {"penis_minet": ["hand_left", "arms"]},
	"handjobside2": {"penis_minet2": ["hand_right", "arms"]},
}

# A penis drawn where another take draws its counterpart: sex_missionary layers its
# penis over the belly and hides the inserted part under the front of the vulva
# alone, so anything longer than the authored one - a big partner, the animal art -
# shows through the belly.  double_pen draws the same penis behind the torso.
const PENIS_LAYERING = {"sex_missionary": {"penis": ["double_pen", "penis"]}}

const REGION_ROOTS = {
	"lower": ["spine1"],
	"head": ["neck"],
	"arms": ["collarbone_l", "collarbone_r"],
	"chest": ["nipple2_l", "nipple2_r", "nipple3_l", "nipple3_r",
		"nipple4_l", "nipple4_r", "nipple5_l", "nipple5_r"],
}
# Parts are laid over the base in this order; it only decides ties in draw order.
const REGION_ORDER = ["lower", "chest", "head", "arms"]
const BOB_BONE = "spine2"
const BAKE_FPS = 60.0

var skeleton = {}
var animations = {}
var bone_region = {}
var slot_region = {}
var penis_bones = {}
var setup_slots = []
var setup_index = {}


func _init(skeleton_data):
	skeleton = skeleton_data
	animations = skeleton.get("animations", {})
	var parents = {}
	for definition in skeleton.get("bones", []):
		parents[str(definition.get("name", ""))] = str(definition.get("parent", ""))
	var roots = {}
	for region in REGION_ROOTS.keys():
		for bone_name in REGION_ROOTS[region]:
			roots[bone_name] = region
	for bone_name in parents.keys():
		var region = "torso"
		var walk = bone_name
		while walk != "":
			if roots.has(walk):
				region = roots[walk]
				break
			walk = parents.get(walk, "")
		bone_region[bone_name] = region
	for slot_name in PENIS_CHAINS.keys():
		for bone_name in PENIS_CHAINS[slot_name]:
			penis_bones[bone_name] = slot_name
	for definition in skeleton.get("slots", []):
		var slot_name = str(definition.get("name", ""))
		setup_index[slot_name] = setup_slots.size()
		setup_slots.append(slot_name)
	_classify_slots()


# A slot goes with the region holding most of its meshes' weight.  A slot whose
# meshes carry no weights hangs off `root` here, and goes with the torso.
func _classify_slots():
	var bone_names = []
	for definition in skeleton.get("bones", []):
		bone_names.append(str(definition.get("name", "")))
	var skins = skeleton.get("skins", [])
	var attachments = {}
	if typeof(skins) == TYPE_ARRAY:
		for skin in skins:
			for slot_name in skin.get("attachments", {}).keys():
				if !attachments.has(slot_name):
					attachments[slot_name] = []
				attachments[slot_name] += skin.attachments[slot_name].values()
	for slot_name in setup_slots:
		if PENIS_CHAINS.has(slot_name):
			slot_region[slot_name] = "penis"
			continue
		var tally = {}
		for attachment in attachments.get(slot_name, []):
			var vertices = attachment.get("vertices", [])
			if str(attachment.get("type", "")) != "mesh" or vertices.size() <= attachment.get("uvs", []).size():
				continue
			var index = 0
			while index < vertices.size():
				var count = int(vertices[index])
				index += 1
				for _influence in range(count):
					var bone_index = int(vertices[index])
					var region = bone_region.get(bone_names[bone_index] if bone_index < bone_names.size() else "", "torso")
					tally[region] = float(tally.get(region, 0.0)) + float(vertices[index + 3])
					index += 4
		var best = "torso"
		var best_weight = 0.0
		for region in tally.keys():
			if tally[region] > best_weight:
				best = region
				best_weight = tally[region]
		slot_region[slot_name] = best


# recipe: {base = take, parts = {region: take}, scales = {role: factor}}
# Returns {animation, duration, slots = {slot: role}} or null when the base is missing.
func compose(recipe):
	var base = str(recipe.get("base", ""))
	if !animations.has(base):
		return null
	var duration = _duration(animations[base])
	if duration <= 0.0:
		return null
	var owners = {"torso": base}
	for region in REGION_ROOTS.keys():
		owners[region] = base
	var parts = recipe.get("parts", {})
	for region in parts.keys():
		if owners.has(region) and animations.has(str(parts[region])):
			owners[region] = str(parts[region])
	var takes = [base]
	for region in REGION_ORDER:
		if !(owners[region] in takes):
			takes.append(owners[region])
	var stretch = {}
	for take in takes:
		var length = _duration(animations[take])
		stretch[take] = duration / length if length > 0.0 else 1.0

	var result = {"slots": {}, "bones": {}, "attachments": {"default": {}}}
	for take in takes:
		var animation = animations[take]
		var factor = stretch[take]
		var bones = animation.get("bones", {})
		for bone_name in bones.keys():
			if penis_bones.has(bone_name):
				continue
			if owners.get(bone_region.get(bone_name, "torso"), base) == take:
				result.bones[bone_name] = _stretch(bones[bone_name], factor)
		var slots = animation.get("slots", {})
		for slot_name in slots.keys():
			if _slot_owner(slot_name, owners, base) == take:
				result.slots[slot_name] = _stretch(slots[slot_name], factor)
		var deforms = animation.get("attachments", {}).get("default", {})
		for slot_name in deforms.keys():
			if _slot_owner(slot_name, owners, base) == take:
				result.attachments.default[slot_name] = _stretch(deforms[slot_name], factor)

	var placed = _place_penises(takes, owners, base, stretch, duration, result, recipe.get("scales", {}))
	var draw = _merge_draw_order(takes, owners, base, stretch, placed)
	if !draw.empty():
		result["drawOrder"] = draw
	var roles = {}
	for slot_name in placed.keys():
		roles[slot_name] = placed[slot_name][2]
	return {"animation": result, "duration": duration, "slots": roles, "takes": takes, "owners": owners}


func _slot_owner(slot_name, owners, base):
	var region = slot_region.get(slot_name, "torso")
	if region == "penis":
		return ""
	return owners.get(region, base)


# --- penises ------------------------------------------------------------------

func _place_penises(takes, owners, base, stretch, duration, result, scales):
	var claims = []
	for take in takes:
		var listed = TAKE_PENISES.get(take, {})
		for slot_name in listed.keys():
			if owners.get(listed[slot_name][1], base) != take:
				continue
			var deformed = animations[take].get("attachments", {}).get("default", {}).has(slot_name)
			claims.append({"take": take, "slot": slot_name, "role": listed[slot_name][0],
				"fixed": deformed or !(slot_name in FRONT_SLOTS)})
	var taken = {}
	# deformed ones first, then the movable ones that can stay where they are,
	# then the rest into whatever front slot is left
	for claim in claims:
		if claim.fixed and !taken.has(claim.slot):
			taken[claim.slot] = claim
	for claim in claims:
		if !claim.fixed and !taken.has(claim.slot):
			taken[claim.slot] = claim
	for claim in claims:
		if claim in taken.values():
			continue
		var target = ""
		if !claim.fixed:
			for slot_name in FRONT_SLOTS:
				if !taken.has(slot_name):
					target = slot_name
					break
		if target == "":
			push_warning("Doll2PoseComposer: no free slot for the %s penis of %s" % [claim.role, claim.take])
			continue
		taken[target] = claim
	var placed = {}
	for target in taken.keys():
		var claim = taken[target]
		_copy_penis(claim, target, base, stretch, duration, result, float(scales.get(claim.role, 1.0)))
		placed[target] = [claim.take, claim.slot, claim.role]
	return placed


func _copy_penis(claim, target, base, stretch, duration, result, size_factor):
	var take = claim.take
	var source = claim.slot
	var animation = animations[take]
	var factor = stretch[take]
	var slots = animation.get("slots", {})
	if slots.has(source):
		var timeline = _stretch(slots[source], factor)
		for frame in timeline.get("attachment", []):
			var name = frame.get("name", null)
			if name != null and str(name).ends_with("/" + source):
				frame["name"] = str(name).substr(0, str(name).length() - source.length()) + target
		result.slots[target] = timeline
	var deforms = animation.get("attachments", {}).get("default", {})
	if source == target and deforms.has(source):
		result.attachments.default[target] = _stretch(deforms[source], factor)
	var from_chain = PENIS_CHAINS[source]
	var to_chain = PENIS_CHAINS[target]
	var bones = animation.get("bones", {})
	# The front slots' setup roots stand exactly the art's offset apart, so a key
	# carries over with only its translate moved by that offset.
	var offset = _setup_position(from_chain[0]) - _setup_position(to_chain[0])
	var drifts = take != base and !_same_bob(take, base, factor, duration)
	for index in range(min(from_chain.size(), to_chain.size())):
		var keyed = bones.get(from_chain[index], {})
		var copy = _stretch(keyed, factor)
		if index == 0:
			if drifts:
				copy["translate"] = _bake_root_translate(animation, from_chain[0], factor, offset, take, base, duration)
			elif offset != Vector2.ZERO:
				if !copy.has("translate"):
					copy["translate"] = [{}]
				_offset_translate(copy.translate, offset)
			if size_factor != 1.0:
				_scale_timeline(copy, size_factor)
		if !copy.empty():
			result.bones[to_chain[index]] = copy


func _offset_translate(frames, offset):
	for frame in frames:
		frame["x"] = float(frame.get("x", 0.0)) + offset.x
		frame["y"] = float(frame.get("y", 0.0)) + offset.y
		var curve = frame.get("curve", null)
		if typeof(curve) == TYPE_ARRAY and curve.size() >= 8:
			curve[1] += offset.x
			curve[3] += offset.x
			curve[5] += offset.y
			curve[7] += offset.y


func _scale_timeline(timelines, size_factor):
	if !timelines.has("scale"):
		timelines["scale"] = [{"x": size_factor, "y": size_factor}]
		return
	for frame in timelines.scale:
		frame["x"] = float(frame.get("x", 1.0)) * size_factor
		frame["y"] = float(frame.get("y", 1.0)) * size_factor
		var curve = frame.get("curve", null)
		if typeof(curve) == TYPE_ARRAY:
			for index in range(1, curve.size(), 2):
				curve[index] *= size_factor


# A part's torso bobs on its own rhythm and depth; here it bobs on the base's, so
# everything it holds moves by the difference.  Sampled densely because the two
# curves share neither keys nor easing.
func _bake_root_translate(animation, root_bone, factor, offset, take, base, duration):
	var frames = []
	var count = int(max(1.0, round(duration * BAKE_FPS)))
	var keyed = animation.get("bones", {}).get(root_bone, {}).get("translate", [])
	for index in range(count + 1):
		var time = duration * float(index) / float(count)
		var value = _sample(keyed, time / factor, ["x", "y"], 0.0)
		var shift = _bob_shift(take, base, factor, time)
		frames.append({"time": time,
			"x": float(value.x) + offset.x + shift.x,
			"y": float(value.y) + offset.y + shift.y})
	return frames


func _bob_shift(take, base, factor, time):
	var here = _sample(animations[base].get("bones", {}).get(BOB_BONE, {}).get("translate", []), time, ["x", "y"], 0.0)
	var there = _sample(animations[take].get("bones", {}).get(BOB_BONE, {}).get("translate", []), time / factor, ["x", "y"], 0.0)
	var local = Vector2(float(here.x) - float(there.x), float(here.y) - float(there.y))
	var basis = _setup_basis(_parent_of(BOB_BONE))
	return Vector2(basis[0] * local.x + basis[1] * local.y, basis[2] * local.x + basis[3] * local.y)


func _same_bob(take, base, factor, duration):
	for index in range(31):
		var time = duration * float(index) / 30.0
		if _bob_shift(take, base, factor, time).length() > 0.01:
			return false
	return true


func _parent_of(bone_name):
	for definition in skeleton.get("bones", []):
		if str(definition.get("name", "")) == bone_name:
			return str(definition.get("parent", ""))
	return ""


func _definition(bone_name):
	for definition in skeleton.get("bones", []):
		if str(definition.get("name", "")) == bone_name:
			return definition
	return {}


func _setup_position(bone_name):
	var definition = _definition(bone_name)
	return Vector2(float(definition.get("x", 0.0)), float(definition.get("y", 0.0)))


# The world 2x2 of a bone at the setup pose, as [a, b, c, d].
func _setup_basis(bone_name):
	var chain = []
	var walk = bone_name
	while walk != "":
		chain.push_front(walk)
		walk = _parent_of(walk)
	var a = 1.0
	var b = 0.0
	var c = 0.0
	var d = 1.0
	for name in chain:
		var definition = _definition(name)
		var rotation = float(definition.get("rotation", 0.0))
		var rx = deg2rad(rotation + float(definition.get("shearX", 0.0)))
		var ry = deg2rad(rotation + 90.0 + float(definition.get("shearY", 0.0)))
		var sx = float(definition.get("scaleX", 1.0))
		var sy = float(definition.get("scaleY", 1.0))
		var la = cos(rx) * sx
		var lb = cos(ry) * sy
		var lc = sin(rx) * sx
		var ld = sin(ry) * sy
		var na = a * la + b * lc
		var nb = a * lb + b * ld
		var nc = c * la + d * lc
		var nd = c * lb + d * ld
		a = na
		b = nb
		c = nc
		d = nd
	return [a, b, c, d]


# --- draw order ---------------------------------------------------------------

# Each take moves the slots of its own regions; a moved slot lands between the
# same neighbours it had in its take, and a penis that changed slot lands where
# its take had drawn the slot it came from.
func _merge_draw_order(takes, owners, base, stretch, placed):
	var times = []
	for take in takes:
		for frame in animations[take].get("drawOrder", []):
			var time = stepify(float(frame.get("time", 0.0)) * stretch[take], 0.0001)
			if !(time in times):
				times.append(time)
	if times.empty():
		return []
	times.sort()
	var renames = {}
	var penis_sources = {}
	var borrowed = []
	for take in takes:
		renames[take] = {}
		penis_sources[take] = []
	for target in placed.keys():
		var take = placed[target][0]
		var source = placed[target][1]
		var layering = PENIS_LAYERING.get(take, {}).get(source, [])
		if layering.size() == 2 and animations.has(layering[0]):
			borrowed.append([layering[0], layering[1], target])
			continue
		renames[take][source] = target
		penis_sources[take].append(source)
	var keys = []
	for time in times:
		var plans = []
		var all_moved = {}
		# A borrowed placement anchors on a neighbour the other take left where it
		# was; the slots that take moved are somewhere else in this pose.
		for entry in borrowed:
			var offsets = _offsets_at(animations[entry[0]].get("drawOrder", []), time)
			var skip = {}
			for offset in offsets:
				skip[str(offset.get("slot", ""))] = true
			skip.erase(entry[1])
			all_moved[entry[2]] = true
			plans.append([_apply_offsets(offsets), {entry[1]: true}, {entry[1]: entry[2]}, skip])
		for take in takes:
			var offsets = _offsets_at(animations[take].get("drawOrder", []), time / stretch[take])
			var full = _apply_offsets(offsets)
			var moved = {}
			for entry in offsets:
				var slot_name = str(entry.get("slot", ""))
				if _slot_owner(slot_name, owners, base) == take:
					moved[slot_name] = true
			for slot_name in penis_sources[take]:
				moved[slot_name] = true
			for slot_name in moved.keys():
				all_moved[renames[take].get(slot_name, slot_name)] = true
			plans.append([full, moved, renames[take], {}])
		var order = []
		for slot_name in setup_slots:
			if !all_moved.has(slot_name):
				order.append(slot_name)
		for plan in plans:
			var full = plan[0]
			var own = plan[1]
			var rename = plan[2]
			var skip = plan[3]
			var inserted = {}
			for index in range(full.size()):
				var slot_name = full[index]
				if !own.has(slot_name):
					continue
				var anchor = ""
				for back in range(index - 1, -1, -1):
					var neighbour = full[back]
					if own.has(neighbour):
						if inserted.has(neighbour):
							anchor = rename.get(neighbour, neighbour)
							break
						continue
					if !all_moved.has(neighbour) and !skip.has(neighbour) and neighbour in order:
						anchor = neighbour
						break
				var placed_name = rename.get(slot_name, slot_name)
				order.erase(placed_name)
				order.insert(order.find(anchor) + 1 if anchor != "" else 0, placed_name)
				inserted[slot_name] = true
		var key = {"offsets": _encode(order, all_moved)}
		if time > 0.0:
			key["time"] = time
		keys.append(key)
	return keys


func _offsets_at(timeline, time):
	var current = []
	for frame in timeline:
		if float(frame.get("time", 0.0)) <= time + 0.000001:
			current = frame.get("offsets", [])
	return current


# Spine's own reading of a draw-order key.
func _apply_offsets(offsets):
	var count = setup_slots.size()
	var order = []
	order.resize(count)
	for index in range(count):
		order[index] = -1
	var unchanged = []
	var original = 0
	for entry in offsets:
		var slot_index = int(setup_index.get(str(entry.get("slot", "")), -1))
		if slot_index < 0:
			continue
		while original != slot_index:
			unchanged.append(original)
			original += 1
		order[original + int(entry.get("offset", 0))] = original
		original += 1
	while original < count:
		unchanged.append(original)
		original += 1
	for index in range(count - 1, -1, -1):
		if order[index] == -1:
			order[index] = unchanged.pop_back()
	var names = []
	for index in order:
		names.append(setup_slots[index])
	return names


func _encode(order, moved):
	var position = {}
	for index in range(order.size()):
		position[order[index]] = index
	var offsets = []
	for slot_name in setup_slots:
		if moved.has(slot_name) and position[slot_name] != setup_index[slot_name]:
			offsets.append({"slot": slot_name, "offset": position[slot_name] - setup_index[slot_name]})
	if _apply_offsets(offsets) == order:
		return offsets
	# every slot that is out of place, which always reads back
	offsets = []
	for slot_name in setup_slots:
		if position[slot_name] != setup_index[slot_name]:
			offsets.append({"slot": slot_name, "offset": position[slot_name] - setup_index[slot_name]})
	return offsets


# --- timelines ----------------------------------------------------------------

func _duration(value):
	var longest = 0.0
	if typeof(value) == TYPE_DICTIONARY:
		if value.has("time"):
			longest = float(value.time)
		for item in value.values():
			if typeof(item) in [TYPE_DICTIONARY, TYPE_ARRAY]:
				longest = max(longest, _duration(item))
	elif typeof(value) == TYPE_ARRAY:
		for item in value:
			if typeof(item) in [TYPE_DICTIONARY, TYPE_ARRAY]:
				longest = max(longest, _duration(item))
	return longest


# A copy with every time - keys and curve control points - scaled by `factor`.
func _stretch(value, factor):
	if factor == 1.0:
		return value.duplicate(true) if typeof(value) in [TYPE_DICTIONARY, TYPE_ARRAY] else value
	if typeof(value) == TYPE_DICTIONARY:
		var copy = {}
		for key in value.keys():
			var item = value[key]
			if key == "time":
				copy[key] = float(item) * factor
			elif key == "curve" and typeof(item) == TYPE_ARRAY:
				var curve = []
				for index in range(item.size()):
					curve.append(float(item[index]) * factor if index % 2 == 0 else item[index])
				copy[key] = curve
			else:
				copy[key] = _stretch(item, factor)
		return copy
	if typeof(value) == TYPE_ARRAY:
		var copy = []
		for item in value:
			copy.append(_stretch(item, factor))
		return copy
	return value


# The preview's sampler, for timelines that are not loaded into a doll.
func _sample(frames, time, fields, default_value):
	var result = {}
	for field in fields:
		result[field] = default_value
	if frames.empty():
		return result
	var current = frames[0]
	var next = null
	for index in range(frames.size()):
		if float(frames[index].get("time", 0.0)) <= time:
			current = frames[index]
			next = frames[index + 1] if index + 1 < frames.size() else null
		else:
			next = frames[index]
			break
	for field_index in range(fields.size()):
		var field = fields[field_index]
		var first = float(current.get(field, default_value))
		if next == null:
			result[field] = first
			continue
		var second = float(next.get(field, default_value))
		var start = float(current.get("time", 0.0))
		var finish = float(next.get("time", start))
		var curve = current.get("curve", null)
		if (typeof(curve) == TYPE_STRING and curve == "stepped") or finish <= start:
			result[field] = first
			continue
		var offset = field_index * 4
		if typeof(curve) == TYPE_ARRAY and curve.size() >= offset + 4:
			var low = 0.0
			var high = 1.0
			for _step in range(20):
				var middle = (low + high) * 0.5
				var inverse = 1.0 - middle
				var sampled = inverse * inverse * inverse * start + 3.0 * inverse * inverse * middle * float(curve[offset]) \
					+ 3.0 * inverse * middle * middle * float(curve[offset + 2]) + middle * middle * middle * finish
				if sampled < time:
					low = middle
				else:
					high = middle
			var p = (low + high) * 0.5
			var q = 1.0 - p
			result[field] = q * q * q * first + 3.0 * q * q * p * float(curve[offset + 1]) \
				+ 3.0 * q * p * p * float(curve[offset + 3]) + p * p * p * second
		else:
			result[field] = lerp(first, second, clamp((time - start) / (finish - start), 0.0, 1.0))
	return result
