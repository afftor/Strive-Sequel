extends Reference

const CUM_SLOT_RULES = {
	"handjob2": {"remove": ["semen_ahole", "semen_vhole", "semen_face"], "add": ["semen_body"]},
	"anal_missionary": {"only": ["semen_ahole"]},
	"blowjob": {"only": ["semen_lips"]},
	"deepthroat": {"only": ["semen_lips"]},
	"double_pen": {"only": ["semen_ahole", "semen_vhole"]},
	"handjob1": {"remove": ["semen_ahole", "semen_vhole"]},
	"titjob": {"remove": ["semen_ahole", "semen_vhole"]},
	"handjobside1": {"only": ["semen_face", "semen_pm2"]},
	"handjobside2": {"only": ["semen_face", "semen_pm1"]},
	"sex_missionary": {"only": ["semen_vhole"]},
	"sex_standing": {"only": ["semen_vhole"]},
	"simult_handjob": {"only": ["semen_face", "semen_body", "semen_pm2", "semen_pm1"]},
	"test_combo": {"add": ["semen_pm2", "semen_pm1", "semen_lips", "semen_body"]},
}


# Explicit art direction wins over the automatic motion-based fallback. Add
# and remove keep the rest of that fallback; only replaces it completely.
static func cum_slots(skeleton, animation_name):
	var name = str(animation_name)
	if name == "missionary":
		name = "sex_missionary"
	elif name == "test combo":
		name = "test_combo"
	var result = moving_slots(skeleton, name, "semen_")
	var rule = CUM_SLOT_RULES.get(name, {})
	if rule.has("only"):
		result = {}
		for slot_name in rule.only:
			result[slot_name] = true
	for slot_name in rule.get("remove", []):
		result.erase(slot_name)
	for slot_name in rule.get("add", []):
		result[slot_name] = true
	return result


# The Cum face owns eyes (including their pupils) and blush, never the mouth,
# jaw, or any body pose. Copy only those timelines, leaving the source intact.
static func cum_face(animation):
	var result = {"bones": {}, "slots": {}, "attachments": {}}
	for bone_name in animation.get("bones", {}).keys():
		if str(bone_name).begins_with("eyes") or str(bone_name).begins_with("pupil"):
			result.bones[bone_name] = animation.bones[bone_name].duplicate(true)
	if animation.get("slots", {}).has("blush"):
		result.slots["blush"] = animation.slots.blush.duplicate(true)
	for skin_name in animation.get("attachments", {}).keys():
		var slots = animation.attachments[skin_name]
		if slots.has("blush"):
			result.attachments[skin_name] = {"blush": slots.blush.duplicate(true)}
	return result


# Visibility of an authored effect belongs to the pose it accompanies, not to
# the effect's own timelines or to a moving common skeleton root. Weighted
# meshes name their real drivers in the packed Spine vertex stream.
static func moving_slots(skeleton, animation_name, slot_prefix):
	var moving = {}
	var animation = skeleton.get("animations", {}).get(animation_name, {})
	for bone_name in animation.get("bones", {}).keys():
		for channel in animation.bones[bone_name].keys():
			if _timeline_moves(animation.bones[bone_name][channel], channel):
				moving[bone_name] = true
				break
	var result = {}
	var definitions = skeleton.get("bones", [])
	for skin in skeleton.get("skins", []):
		for slot in skeleton.get("slots", []):
			var slot_name = str(slot.get("name", ""))
			if !slot_name.begins_with(slot_prefix):
				continue
			for attachment in skin.get("attachments", {}).get(slot_name, {}).values():
				if _attachment_moves(attachment, slot, definitions, moving):
					result[slot_name] = true
					break
	return result


static func _attachment_moves(attachment, slot, definitions, moving):
	var vertices = attachment.get("vertices", [])
	var weighted = str(attachment.get("type", "")) == "mesh" and vertices.size() != attachment.get("uvs", []).size()
	if !weighted:
		return moving.has(str(slot.get("bone", "")))
	var cursor = 0
	while cursor < vertices.size():
		var count = int(vertices[cursor])
		cursor += 1
		for _influence in range(count):
			if cursor + 3 >= vertices.size():
				return false
			var index = int(vertices[cursor])
			var weight = float(vertices[cursor + 3])
			if weight > 0.00001 and index >= 0 and index < definitions.size() and moving.has(str(definitions[index].get("name", ""))):
				return true
			cursor += 4
	return false


static func _timeline_moves(frames, channel):
	if frames.size() < 2:
		return false
	var fields = ["value"] if channel == "rotate" else ["x", "y"]
	var default_value = 1.0 if str(channel).begins_with("scale") else 0.0
	for field_index in range(fields.size()):
		var field = fields[field_index]
		var first = float(frames[0].get(field, default_value))
		for index in range(frames.size()):
			var frame = frames[index]
			if abs(float(frame.get(field, default_value)) - first) > 0.0001:
				return true
			# Spine curves store absolute control values per channel. Equal
			# endpoints can still describe an authored excursion between keys.
			var curve = frame.get("curve", null)
			var offset = field_index * 4
			if index + 1 < frames.size() and curve is Array and curve.size() >= offset + 4:
				if abs(float(curve[offset + 1]) - first) > 0.0001 or abs(float(curve[offset + 3]) - first) > 0.0001:
					return true
	return false
