tool
extends Node2D

# Standalone viewer for the Spine 4.2 export.  It intentionally does not depend
# on the game character generator or on a third-party Spine runtime.

const DATA_FILE = "Doll2_spine4.2_female.json"
const ATLAS_FILE = "Doll2_spine4.2_female.atlas"
const DISPLAY_SCALE = 0.52
const DISPLAY_ORIGIN = Vector2(500, 785)
const PAGE_TEXTURES = {
	"Doll2_spine4.2_female.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_female.png"),
	"Doll2_spine4.2_female_2.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_female_2.png"),
	"Doll2_spine4.2_female_3.png": preload("res://Character_generator/Doll2Spine/Doll2_spine4.2_female_3.png"),
}
const ENGLISH_TRANSLATION = preload("res://localization/en/main.gd")
const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")
const CONTRACT = preload("res://Character_generator/Doll2Spine/universal/doll_contract.gd")
const MODIFIERS = preload("res://Character_generator/Doll2Spine/universal/doll_modifiers.gd")
const RECOLOR_SHADER = preload("res://Character_generator/Doll2Spine/doll2_recolor.shader")
const SKIN_NAME = "default"
const ZOOM_MIN = 0.4
const ZOOM_MAX = 4.0
const ZOOM_STEP = 1.12
const PAN_LIMIT = Vector2(900, 900)

var skeleton = {}
var atlas = {}
var pages = {}
var bones = {}
var slot_data = []
var skin_map = {}
# What the doll is made of: a part per catalogue group, plus the shared axis
# values (breast size, pregnancy stage) those parts select variants with.
var selections = CATALOGUE.default_selections()
var axis_values = CATALOGUE.default_axes()
var composed = {}
# Values of the free per-bone modifiers.  There are none right now: head size
# belongs to height, and MODIFIERS is where a future one (ass size, and so on)
# plugs in.
var proportions = MODIFIERS.defaults()
# Height is one of six authored steps rather than a free scale: each step carries
# its own body proportions, the way the old paperdoll did.
var height_tier = MODIFIERS.HEIGHT_DEFAULT
# One picked colour and one shared ShaderMaterial per catalogue colour channel.
# Sharing the material per channel means a colour change is a single uniform
# write that repaints every mesh of that channel, with no model rebuild.
var color_values = {}
# Second colour of a two-tone channel: hair keeps the two colours it had in the
# old paperdoll, blended from roots to tips.
var color_values_secondary = {}
# Per-zone colours of a hue-coded channel: gear carries three materials in one
# mesh and each gets its own picker.
var zone_values = {}
var channel_materials = {}
# Vertical extent of each two-tone channel's meshes, so the shader knows where
# the roots end and the tips begin.
var gradient_bounds = {}
# View transform for the model, kept out of the mesh maths: zooming moves the
# model node instead of re-solving every vertex, so it costs nothing per frame.
var view_zoom = 1.0
var view_offset = Vector2.ZERO
var panning = false
var ui = {}
var model_root
var bone_root
var bone_nodes = {}
var asset_dir = ""
var editor_strings = {}
var rendered_meshes = 0
var mesh_records = []
var animation_states = {"idle": true, "eyesmove": false}
var animation_times = {"idle": 0.0, "eyesmove": 0.0}
var animation_durations = {}
var handle_buttons = {}
var handles_visible = true
var handle_targets = {}
var handle_custom = {}
var handle_target_offsets = {}
var handle_definitions = CONTRACT.HANDLES.duplicate(true)

func _ready():
	_load_source()
	_build_channel_materials()
	_build_interface()
	_rebuild_model()
	set_process(true)


func _process(delta):
	if skeleton.empty():
		return
	var pose_changed = false
	for animation_name in animation_states.keys():
		if animation_states[animation_name]:
			var duration = float(animation_durations.get(animation_name, 0.0))
			animation_times[animation_name] = fmod(float(animation_times.get(animation_name, 0.0)) + delta, duration) if duration > 0.0 else 0.0
			pose_changed = true
	if pose_changed:
		_update_animated_pose()


func _load_source():
	asset_dir = get_script().resource_path.get_base_dir() + "/"
	var file = File.new()
	if file.open(asset_dir + DATA_FILE, File.READ) != OK:
		push_error("Doll2 preview: Spine JSON was not found")
		return
	var parsed = JSON.parse(file.get_as_text())
	file.close()
	if parsed.error != OK:
		push_error("Doll2 preview: cannot parse Spine JSON: " + parsed.error_string)
		return
	skeleton = parsed.result
	slot_data = skeleton.get("slots", [])
	for skin in skeleton.get("skins", []):
		skin_map[skin.get("name", "")] = skin
	_parse_atlas()
	for animation_name in skeleton.get("animations", {}).keys():
		animation_durations[animation_name] = _animation_duration(animation_name)
	_build_bone_transforms()
	_initialize_handles()


func _parse_atlas():
	var file = File.new()
	if file.open(asset_dir + ATLAS_FILE, File.READ) != OK:
		push_error("Doll2 preview: Spine atlas was not found")
		return
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
				pages[current_page] = {"texture": PAGE_TEXTURES.get(current_page), "size": Vector2.ZERO}
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


func _atlas_floats(value):
	var result = []
	for part in value.split(","):
		result.append(float(part.strip_edges()))
	return result


func _atlas_vector(value):
	var values = _atlas_floats(value)
	return Vector2(values[0], values[1]) if values.size() == 2 else Vector2.ZERO


func _build_bone_transforms():
	bones.clear()
	var index = 0
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "bone_%d" % index)
		bones[name] = {"definition": definition, "index": index}
		_set_bone_world(
			name,
			float(definition.get("x", 0.0)),
			float(definition.get("y", 0.0)),
			float(definition.get("rotation", 0.0)),
			float(definition.get("scaleX", 1.0)),
			float(definition.get("scaleY", 1.0)),
			float(definition.get("shearX", 0.0)),
			float(definition.get("shearY", 0.0))
		)
		index += 1
	_apply_active_bone_timelines()
	_apply_bone_modifiers()
	_apply_native_handle_targets()
	var constraints = skeleton.get("ik", []).duplicate()
	constraints.sort_custom(self, "_sort_ik_constraints")
	for constraint in constraints:
		_apply_ik_constraint(constraint)
	_apply_hand_handles()


func _apply_bone_modifiers():
	# Every active modifier contributes a multiplier and they compose, so no
	# modifier can silently discard another one acting on the same bone.
	var factors = MODIFIERS.bone_factors(proportions, height_tier)
	var touched = []
	for bone_name in factors.keys():
		if !bones.has(bone_name):
			continue
		var bone = bones[bone_name]
		var factor = factors[bone_name]
		_set_bone_world(
			bone_name,
			float(bone.local_x), float(bone.local_y),
			float(bone.local_rotation),
			float(bone.local_scale_x) * factor.x,
			float(bone.local_scale_y) * factor.y,
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
		touched.append(bone_name)
	if !touched.empty():
		_update_ik_descendants(touched)


func _display_scale():
	return DISPLAY_SCALE * float(MODIFIERS.display_scale(height_tier))


func _apply_active_bone_timelines():
	for animation_name in animation_states.keys():
		if !animation_states[animation_name]:
			continue
		var animation = skeleton.get("animations", {}).get(animation_name, {})
		var bone_timelines = animation.get("bones", {})
		var time = float(animation_times.get(animation_name, 0.0))
		for definition in skeleton.get("bones", []):
			var name = definition.get("name", "")
			if !bone_timelines.has(name):
				continue
			var bone = bones[name]
			var x = float(definition.get("x", 0.0))
			var y = float(definition.get("y", 0.0))
			var rotation = float(definition.get("rotation", 0.0))
			var channels = bone_timelines[name]
			if channels.has("translate"):
				var translation = _sample_timeline(channels.translate, time, ["x", "y"])
				x += float(translation.get("x", 0.0))
				y += float(translation.get("y", 0.0))
			if channels.has("rotate"):
				var turn = _sample_timeline(channels.rotate, time, ["value"])
				rotation += float(turn.get("value", 0.0))
			_set_bone_world(
				name, x, y, rotation,
				float(bone.local_scale_x), float(bone.local_scale_y),
				float(bone.local_shear_x), float(bone.local_shear_y)
			)


func _sample_timeline(frames, time, fields):
	var result = {}
	for field in fields:
		result[field] = 0.0
	if frames.empty():
		return result
	var current = frames[0]
	var next = null
	for i in range(frames.size()):
		if float(frames[i].get("time", 0.0)) <= time:
			current = frames[i]
			next = frames[i + 1] if i + 1 < frames.size() else null
		else:
			next = frames[i]
			break
	var percent = 0.0
	if next != null:
		var start_time = float(current.get("time", 0.0))
		var end_time = float(next.get("time", start_time))
		var curve = current.get("curve", "")
		var stepped = typeof(curve) == TYPE_STRING and curve == "stepped"
		if end_time > start_time and !stepped:
			percent = clamp((time - start_time) / (end_time - start_time), 0.0, 1.0)
	for field in fields:
		var first_value = float(current.get(field, 0.0))
		var second_value = first_value if next == null else float(next.get(field, 0.0))
		result[field] = lerp(first_value, second_value, percent)
	return result


func _animation_duration(animation_name):
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


func _sort_ik_constraints(first, second):
	return int(first.get("order", 0)) < int(second.get("order", 0))


func _set_bone_world(name, x, y, rotation, scale_x, scale_y, shear_x, shear_y):
	var bone = bones[name]
	var rotation_x = deg2rad(rotation + shear_x)
	var rotation_y = deg2rad(rotation + 90.0 + shear_y)
	var local_a = cos(rotation_x) * scale_x
	var local_b = cos(rotation_y) * scale_y
	var local_c = sin(rotation_x) * scale_x
	var local_d = sin(rotation_y) * scale_y
	var parent_name = bone.definition.get("parent", "")
	if parent_name.empty():
		bone["x"] = x
		bone["y"] = y
		bone["a"] = local_a
		bone["b"] = local_b
		bone["c"] = local_c
		bone["d"] = local_d
	else:
		var parent = bones[parent_name]
		bone["x"] = parent.a * x + parent.b * y + parent.x
		bone["y"] = parent.c * x + parent.d * y + parent.y
		bone["a"] = parent.a * local_a + parent.b * local_c
		bone["b"] = parent.a * local_b + parent.b * local_d
		bone["c"] = parent.c * local_a + parent.d * local_c
		bone["d"] = parent.c * local_b + parent.d * local_d
	bone["local_x"] = x
	bone["local_y"] = y
	bone["local_rotation"] = rotation
	bone["local_scale_x"] = scale_x
	bone["local_scale_y"] = scale_y
	bone["local_shear_x"] = shear_x
	bone["local_shear_y"] = shear_y
	bones[name] = bone


func _restore_bone_world(name):
	var bone = bones[name]
	_set_bone_world(
		name,
		float(bone.local_x), float(bone.local_y), float(bone.local_rotation),
		float(bone.local_scale_x), float(bone.local_scale_y),
		float(bone.local_shear_x), float(bone.local_shear_y)
	)


func _apply_ik_constraint(constraint):
	var constrained = constraint.get("bones", [])
	var target_name = constraint.get("target", "")
	if constrained.empty() or !bones.has(target_name):
		return
	var mix = float(constraint.get("mix", 1.0))
	if mix == 0.0:
		return
	var target = bones[target_name]
	if constrained.size() == 1 and bones.has(constrained[0]):
		_apply_one_bone_ik(
			constrained[0], target.x, target.y,
			bool(constraint.get("compress", false)),
			bool(constraint.get("stretch", false)),
			bool(constraint.get("uniform", false)), mix
		)
		_update_ik_descendants([constrained[0]])
	elif constrained.size() == 2 and bones.has(constrained[0]) and bones.has(constrained[1]):
		var bend_direction = 1 if bool(constraint.get("bendPositive", true)) else -1
		_apply_two_bone_ik(
			constrained[0], constrained[1], target.x, target.y, bend_direction,
			bool(constraint.get("stretch", false)),
			bool(constraint.get("uniform", false)),
			float(constraint.get("softness", 0.0)), mix
		)
		_update_ik_descendants([constrained[0], constrained[1]])


func _apply_one_bone_ik(bone_name, target_x, target_y, compress, stretch, uniform, alpha):
	var bone = bones[bone_name]
	var definition = bone.definition
	var parent_name = definition.get("parent", "")
	if parent_name.empty():
		return
	var parent = bones[parent_name]
	var pa = parent.a
	var pb = parent.b
	var pc = parent.c
	var pd = parent.d
	var bone_x = float(bone.local_x)
	var bone_y = float(bone.local_y)
	var bone_rotation = float(bone.local_rotation)
	var shear_x = float(bone.local_shear_x)
	var rotation_ik = -shear_x - bone_rotation
	var x = target_x - parent.x
	var y = target_y - parent.y
	var determinant = pa * pd - pb * pc
	var tx = 0.0
	var ty = 0.0
	if abs(determinant) > 0.0001:
		tx = (x * pd - y * pb) / determinant - bone_x
		ty = (y * pa - x * pc) / determinant - bone_y
	rotation_ik += rad2deg(atan2(ty, tx))
	var scale_x = float(bone.local_scale_x)
	var scale_y = float(bone.local_scale_y)
	if scale_x < 0.0:
		rotation_ik += 180.0
	rotation_ik = _normalize_degrees(rotation_ik)
	if compress or stretch:
		var length = float(definition.get("length", 0.0)) * scale_x
		if length > 0.0001:
			var distance_squared = tx * tx + ty * ty
			if (compress and distance_squared < length * length) or (stretch and distance_squared > length * length):
				var scale_factor = (sqrt(distance_squared) / length - 1.0) * alpha + 1.0
				scale_x *= scale_factor
				if uniform:
					scale_y *= scale_factor
	_set_bone_world(bone_name, bone_x, bone_y, bone_rotation + rotation_ik * alpha, scale_x, scale_y, shear_x, float(bone.local_shear_y))


func _apply_two_bone_ik(parent_name, child_name, target_x, target_y, bend_direction, stretch, uniform, softness, alpha):
	var parent = bones[parent_name]
	var child = bones[child_name]
	var parent_definition = parent.definition
	var child_definition = child.definition
	var grandparent_name = parent_definition.get("parent", "")
	if grandparent_name.empty():
		return
	var px = float(parent.local_x)
	var py = float(parent.local_y)
	var original_parent_scale_x = float(parent.local_scale_x)
	var original_parent_scale_y = float(parent.local_scale_y)
	var parent_scale_x = original_parent_scale_x
	var parent_scale_y = original_parent_scale_y
	var solved_parent_scale_x = original_parent_scale_x
	var solved_parent_scale_y = original_parent_scale_y
	var child_scale_x = float(child.local_scale_x)
	var offset_parent = 0.0
	var offset_child = 0.0
	var scale_sign = 1.0
	if parent_scale_x < 0.0:
		parent_scale_x = -parent_scale_x
		offset_parent = 180.0
		scale_sign = -1.0
	if parent_scale_y < 0.0:
		parent_scale_y = -parent_scale_y
		scale_sign = -scale_sign
	if child_scale_x < 0.0:
		child_scale_x = -child_scale_x
		offset_child = 180.0
	var child_x = float(child.local_x)
	var child_y = 0.0
	var child_world_x = 0.0
	var child_world_y = 0.0
	var uniform_parent_scale = abs(parent_scale_x - parent_scale_y) <= 0.0001
	if !uniform_parent_scale or stretch:
		child_world_x = parent.a * child_x + parent.x
		child_world_y = parent.c * child_x + parent.y
	else:
		child_y = float(child.local_y)
		child_world_x = parent.a * child_x + parent.b * child_y + parent.x
		child_world_y = parent.c * child_x + parent.d * child_y + parent.y
	var grandparent = bones[grandparent_name]
	var determinant = grandparent.a * grandparent.d - grandparent.b * grandparent.c
	var inverse_determinant = 0.0 if abs(determinant) <= 0.0001 else 1.0 / determinant
	var local_x = child_world_x - grandparent.x
	var local_y = child_world_y - grandparent.y
	var dx = (local_x * grandparent.d - local_y * grandparent.b) * inverse_determinant - px
	var dy = (local_y * grandparent.a - local_x * grandparent.c) * inverse_determinant - py
	var first_length = sqrt(dx * dx + dy * dy)
	var second_length = float(child_definition.get("length", 0.0)) * child_scale_x
	if first_length < 0.0001:
		_apply_one_bone_ik(parent_name, target_x, target_y, false, stretch, false, alpha)
		_set_bone_world(child_name, child_x, child_y, 0.0, float(child.local_scale_x), float(child.local_scale_y), float(child.local_shear_x), float(child.local_shear_y))
		return
	local_x = target_x - grandparent.x
	local_y = target_y - grandparent.y
	var target_local_x = (local_x * grandparent.d - local_y * grandparent.b) * inverse_determinant - px
	var target_local_y = (local_y * grandparent.a - local_x * grandparent.c) * inverse_determinant - py
	var target_distance_squared = target_local_x * target_local_x + target_local_y * target_local_y
	if softness != 0.0:
		softness *= parent_scale_x * (child_scale_x + 1.0) * 0.5
		var target_distance = sqrt(target_distance_squared)
		var soft_distance = target_distance - first_length - second_length * parent_scale_x + softness
		if soft_distance > 0.0 and target_distance > 0.0001:
			var soft_percent = min(1.0, soft_distance / (softness * 2.0)) - 1.0
			soft_percent = (soft_distance - softness * (1.0 - soft_percent * soft_percent)) / target_distance
			target_local_x -= soft_percent * target_local_x
			target_local_y -= soft_percent * target_local_y
			target_distance_squared = target_local_x * target_local_x + target_local_y * target_local_y
	var angle_parent = 0.0
	var angle_child = 0.0
	if uniform_parent_scale:
		second_length *= parent_scale_x
		var cosine = (target_distance_squared - first_length * first_length - second_length * second_length) / (2.0 * first_length * second_length)
		if cosine < -1.0:
			cosine = -1.0
			angle_child = PI * bend_direction
		elif cosine > 1.0:
			cosine = 1.0
			angle_child = 0.0
			if stretch:
				var stretch_scale = (sqrt(target_distance_squared) / (first_length + second_length) - 1.0) * alpha + 1.0
				solved_parent_scale_x *= stretch_scale
				if uniform:
					solved_parent_scale_y *= stretch_scale
		else:
			angle_child = acos(cosine) * bend_direction
		var adjacent = first_length + second_length * cosine
		var opposite = second_length * sin(angle_child)
		angle_parent = atan2(target_local_y * adjacent - target_local_x * opposite, target_local_x * adjacent + target_local_y * opposite)
	else:
		var ellipse_x = parent_scale_x * second_length
		var ellipse_y = parent_scale_y * second_length
		var ellipse_x_squared = ellipse_x * ellipse_x
		var ellipse_y_squared = ellipse_y * ellipse_y
		var target_angle = atan2(target_local_y, target_local_x)
		var quadratic_c = ellipse_y_squared * first_length * first_length + ellipse_x_squared * target_distance_squared - ellipse_x_squared * ellipse_y_squared
		var quadratic_c1 = -2.0 * ellipse_y_squared * first_length
		var quadratic_c2 = ellipse_y_squared - ellipse_x_squared
		var discriminant = quadratic_c1 * quadratic_c1 - 4.0 * quadratic_c2 * quadratic_c
		var exact_solution = false
		if discriminant >= 0.0 and abs(quadratic_c2) > 0.000001:
			var root = sqrt(discriminant)
			if quadratic_c1 < 0.0:
				root = -root
			var q = -(quadratic_c1 + root) * 0.5
			if abs(q) > 0.000001:
				var radius_0 = q / quadratic_c2
				var radius_1 = quadratic_c / q
				var radius = radius_0 if abs(radius_0) < abs(radius_1) else radius_1
				var height_squared = target_distance_squared - radius * radius
				if height_squared >= 0.0:
					var height = sqrt(height_squared) * bend_direction
					angle_parent = target_angle - atan2(height, radius)
					angle_child = atan2(height / parent_scale_y, (radius - first_length) / parent_scale_x)
					exact_solution = true
		if !exact_solution:
			var min_angle = PI
			var min_x = first_length - ellipse_x
			var min_distance = min_x * min_x
			var min_y = 0.0
			var max_angle = 0.0
			var max_x = first_length + ellipse_x
			var max_distance = max_x * max_x
			var max_y = 0.0
			var cosine = -ellipse_x * first_length / (ellipse_x_squared - ellipse_y_squared)
			if cosine >= -1.0 and cosine <= 1.0:
				var candidate_angle = acos(cosine)
				var candidate_x = ellipse_x * cos(candidate_angle) + first_length
				var candidate_y = ellipse_y * sin(candidate_angle)
				var candidate_distance = candidate_x * candidate_x + candidate_y * candidate_y
				if candidate_distance < min_distance:
					min_angle = candidate_angle
					min_distance = candidate_distance
					min_x = candidate_x
					min_y = candidate_y
				if candidate_distance > max_distance:
					max_angle = candidate_angle
					max_distance = candidate_distance
					max_x = candidate_x
					max_y = candidate_y
			if target_distance_squared <= (min_distance + max_distance) * 0.5:
				angle_parent = target_angle - atan2(min_y * bend_direction, min_x)
				angle_child = min_angle * bend_direction
			else:
				angle_parent = target_angle - atan2(max_y * bend_direction, max_x)
				angle_child = max_angle * bend_direction
	var child_offset_angle = atan2(child_y, child_x) * scale_sign
	var parent_rotation = float(parent.local_rotation)
	var parent_rotation_delta = rad2deg(angle_parent - child_offset_angle) + offset_parent - parent_rotation
	parent_rotation_delta = _normalize_degrees(parent_rotation_delta)
	_set_bone_world(parent_name, px, py, parent_rotation + parent_rotation_delta * alpha, solved_parent_scale_x, solved_parent_scale_y, 0.0, 0.0)
	var child_rotation = float(child.local_rotation)
	var child_rotation_delta = (rad2deg(angle_child + child_offset_angle) - float(child.local_shear_x)) * scale_sign + offset_child - child_rotation
	child_rotation_delta = _normalize_degrees(child_rotation_delta)
	_set_bone_world(child_name, child_x, child_y, child_rotation + child_rotation_delta * alpha, float(child.local_scale_x), float(child.local_scale_y), float(child.local_shear_x), float(child.local_shear_y))


func _normalize_degrees(angle):
	if angle > 180.0:
		return angle - 360.0
	if angle < -180.0:
		return angle + 360.0
	return angle


func _update_ik_descendants(constrained_names):
	var changed = {}
	for name in constrained_names:
		changed[name] = true
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "")
		if changed.has(name):
			continue
		var parent_name = definition.get("parent", "")
		if changed.has(parent_name):
			_restore_bone_world(name)
			changed[name] = true


func _initialize_handles():
	for handle_name in handle_definitions.keys():
		var definition = handle_definitions[handle_name]
		var target_bones = definition.get("target_bones", [])
		var bone_name = target_bones[0] if !target_bones.empty() else definition.get("end_bone", "")
		if bones.has(bone_name):
			var primary_position = Vector2(float(bones[bone_name].x), float(bones[bone_name].y))
			handle_targets[handle_name] = primary_position
			handle_custom[handle_name] = false
			handle_target_offsets[handle_name] = {}
			for target_bone in target_bones:
				if bones.has(target_bone):
					handle_target_offsets[handle_name][target_bone] = Vector2(float(bones[target_bone].x), float(bones[target_bone].y)) - primary_position
func _apply_native_handle_targets():
	for handle_name in handle_definitions.keys():
		var handle_definition = handle_definitions[handle_name]
		var target_bones = handle_definition.get("target_bones", [])
		if target_bones.empty() or !bool(handle_custom.get(handle_name, false)):
			continue
		for target_bone in target_bones:
			if !bones.has(target_bone):
				continue
			var target_offset = handle_target_offsets.get(handle_name, {}).get(target_bone, Vector2.ZERO)
			var local_position = _world_to_bone_parent(target_bone, handle_targets[handle_name] + target_offset)
			var target = bones[target_bone]
			_set_bone_world(
				target_bone, local_position.x, local_position.y,
				float(target.local_rotation), float(target.local_scale_x), float(target.local_scale_y),
				float(target.local_shear_x), float(target.local_shear_y)
			)


func _world_to_bone_parent(bone_name, world_position):
	var parent_name = bones[bone_name].definition.get("parent", "")
	if parent_name.empty():
		return world_position
	var parent = bones[parent_name]
	var determinant = parent.a * parent.d - parent.b * parent.c
	if abs(determinant) <= 0.0001:
		return Vector2.ZERO
	var x = world_position.x - parent.x
	var y = world_position.y - parent.y
	return Vector2((x * parent.d - y * parent.b) / determinant, (y * parent.a - x * parent.c) / determinant)


func _apply_hand_handles():
	for handle_name in ["left_hand", "right_hand"]:
		if !bool(handle_custom.get(handle_name, false)):
			continue
		var definition = handle_definitions[handle_name]
		var ik_bones = definition.ik_bones
		var target = handle_targets[handle_name]
		_apply_two_bone_ik(ik_bones[0], ik_bones[1], target.x, target.y, int(definition.bend), false, false, 0.0, 1.0)
		_update_ik_descendants(ik_bones)


func _update_animated_pose():
	_build_bone_transforms()
	_update_mesh_geometry()
	_update_bone_nodes()
	_update_handle_buttons()


# Wheel zooms at the cursor, holding the left button drags the doll around, right
# click puts the view back.  Unhandled input only: the control panel scrolls with
# the same wheel and the IK handles take their own drags, and both are ordinary
# Controls, so they consume those events before they ever reach the doll.
func _unhandled_input(event):
	if Engine.editor_hint:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			_zoom_at(event.position, ZOOM_STEP)
		elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			_zoom_at(event.position, 1.0 / ZOOM_STEP)
		elif event.button_index == BUTTON_LEFT:
			panning = event.pressed
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			view_zoom = 1.0
			view_offset = Vector2.ZERO
			_apply_view()
	elif event is InputEventMouseMotion and panning:
		view_offset += event.relative
		_clamp_view()
		_apply_view()


# Keeps whatever sits under the cursor pinned there while the scale changes.
func _zoom_at(screen_point, factor):
	var zoom = clamp(view_zoom * factor, ZOOM_MIN, ZOOM_MAX)
	if zoom == view_zoom:
		return
	var anchor = (screen_point - view_offset) / view_zoom
	view_zoom = zoom
	view_offset = screen_point - anchor * view_zoom
	_clamp_view()
	_apply_view()


func _clamp_view():
	view_offset.x = clamp(view_offset.x, -PAN_LIMIT.x, PAN_LIMIT.x)
	view_offset.y = clamp(view_offset.y, -PAN_LIMIT.y, PAN_LIMIT.y)


func _apply_view():
	if is_instance_valid(model_root):
		model_root.position = view_offset
		model_root.scale = Vector2.ONE * view_zoom
	# The handles live on a CanvasLayer, which the model's transform does not
	# reach, so they have to be projected through the same view by hand.
	_update_handle_buttons()


func _model_to_screen(local_point):
	return view_offset + local_point * view_zoom


func _build_interface():
	var canvas = CanvasLayer.new()
	add_child(canvas)
	for handle_name in handle_definitions.keys():
		var handle = Button.new()
		handle.text = _text(handle_definitions[handle_name].label)
		handle.rect_size = Vector2(84, 26)
		handle.hint_tooltip = _text("DOLL2_PREVIEW_HANDLE_HINT")
		handle.connect("gui_input", self, "_on_handle_input", [handle_name])
		canvas.add_child(handle)
		handle_buttons[handle_name] = handle
	var panel = PanelContainer.new()
	panel.rect_position = Vector2(920, 30)
	panel.rect_size = Vector2(346, 940)
	canvas.add_child(panel)
	# The catalogue drives roughly twenty-five dropdowns, well past the height of
	# the panel, so the controls scroll instead of overflowing it.
	var scroll = ScrollContainer.new()
	panel.add_child(scroll)
	var box = VBoxContainer.new()
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.rect_min_size.x = 310
	scroll.add_child(box)
	var title = Label.new()
	title.text = _text("DOLL2_PREVIEW_TITLE")
	box.add_child(title)
	_add_animation_toggle(box, "DOLL2_PREVIEW_ANIMATION_IDLE", "idle")
	_add_animation_toggle(box, "DOLL2_PREVIEW_ANIMATION_EYES", "eyesmove")
	var handles_toggle = CheckButton.new()
	handles_toggle.text = _text("DOLL2_PREVIEW_SHOW_HANDLES")
	handles_toggle.pressed = handles_visible
	handles_toggle.connect("toggled", self, "_on_handles_toggled")
	box.add_child(handles_toggle)
	_add_preset_select(box)
	for group_id in CATALOGUE.group_order():
		var group = CATALOGUE.group(group_id)
		if group.parts.empty():
			continue
		_add_select(box, group.label, group_id, group.parts, group.optional, CATALOGUE.channel_for_group(group_id))
	for axis in _sorted_axes():
		var definition = CATALOGUE.axes()[axis]
		_add_axis_select(box, definition.label, axis, definition.values)
	_add_height_slider(box)
	var note = Label.new()
	note.autowrap = true
	note.text = _text("DOLL2_PREVIEW_NOTE")
	box.add_child(note)
	_update_handle_buttons()


func _sorted_axes():
	var result = CATALOGUE.axes().keys()
	result.sort()
	return result


func _add_animation_toggle(parent, label_text, animation_name):
	if !skeleton.get("animations", {}).has(animation_name):
		return
	var toggle = CheckButton.new()
	toggle.text = _text(label_text)
	toggle.pressed = bool(animation_states.get(animation_name, false))
	toggle.connect("toggled", self, "_on_animation_toggled", [animation_name])
	parent.add_child(toggle)


func _on_animation_toggled(enabled, animation_name):
	animation_states[animation_name] = enabled
	if !enabled:
		animation_times[animation_name] = 0.0
	_update_animated_pose()


func _on_handles_toggled(enabled):
	handles_visible = enabled
	for button in handle_buttons.values():
		button.visible = enabled


func _on_handle_input(event, handle_name):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		handle_custom[handle_name] = false
		_update_animated_pose()
	elif event is InputEventMouseMotion and (event.button_mask & BUTTON_MASK_LEFT) != 0:
		# Drag distance is in screen pixels; the bone target lives in Spine units,
		# so it has to come back through both the display scale and the zoom.
		var display_scale = _display_scale() * view_zoom
		var movement = Vector2(event.relative.x / display_scale, -event.relative.y / display_scale)
		handle_targets[handle_name] = handle_targets.get(handle_name, Vector2.ZERO) + movement
		handle_custom[handle_name] = true
		_update_animated_pose()


func _update_handle_buttons():
	for handle_name in handle_buttons.keys():
		var definition = handle_definitions[handle_name]
		if !bool(handle_custom.get(handle_name, false)):
			var target_bones = definition.get("target_bones", [])
			var bone_name = target_bones[0] if !target_bones.empty() else definition.get("end_bone", "")
			if bones.has(bone_name):
				handle_targets[handle_name] = Vector2(float(bones[bone_name].x), float(bones[bone_name].y))
		var screen_position = _model_to_screen(DISPLAY_ORIGIN + Vector2(handle_targets[handle_name].x, -handle_targets[handle_name].y) * _display_scale())
		var button = handle_buttons[handle_name]
		button.rect_position = screen_position - button.rect_size * 0.5
		button.visible = handles_visible


func _add_select(parent, label_text, group_id, part_ids, allow_none = false, channel = ""):
	var select = _make_select(parent, label_text, channel)
	if allow_none:
		select.add_item(_text("DOLL2_PREVIEW_NONE"))
		select.set_item_metadata(0, "")
	for part_id in part_ids:
		select.add_item(CATALOGUE.display(part_id))
		select.set_item_metadata(select.get_item_count() - 1, part_id)
	_select_metadata(select, selections.get(group_id, ""))
	select.connect("item_selected", self, "_on_select_changed", [group_id, select])
	ui[group_id] = select


func _add_axis_select(parent, label_text, axis, values):
	var select = _make_select(parent, label_text)
	for value in values:
		select.add_item(value)
		select.set_item_metadata(select.get_item_count() - 1, value)
	_select_metadata(select, axis_values.get(axis, ""))
	select.connect("item_selected", self, "_on_axis_changed", [axis, select])
	ui["axis/" + axis] = select


# Height slides, but only between the six authored steps: anything in between
# has no proportions of its own, so the slider snaps to whole tiers.
func _add_height_slider(parent):
	var row = HBoxContainer.new()
	parent.add_child(row)
	var label = Label.new()
	label.text = _text("DOLL2_PREVIEW_HEIGHT")
	label.rect_min_size.x = 105
	row.add_child(label)
	var slider = HSlider.new()
	slider.min_value = 0
	slider.max_value = MODIFIERS.HEIGHT_ORDER.size() - 1
	slider.step = 1
	slider.tick_count = MODIFIERS.HEIGHT_ORDER.size()
	slider.ticks_on_borders = true
	slider.value = MODIFIERS.HEIGHT_ORDER.find(height_tier)
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.connect("value_changed", self, "_on_height_changed")
	row.add_child(slider)
	var value_label = Label.new()
	value_label.rect_min_size.x = 62
	value_label.align = Label.ALIGN_RIGHT
	value_label.text = height_tier
	row.add_child(value_label)
	ui["height"] = slider
	ui["height_label"] = value_label


func _on_height_changed(value):
	height_tier = MODIFIERS.HEIGHT_ORDER[int(clamp(value, 0, MODIFIERS.HEIGHT_ORDER.size() - 1))]
	if ui.has("height_label"):
		ui["height_label"].text = height_tier
	# Height changes bone scales and the display scale, so the geometry has to be
	# solved again rather than just re-transformed.
	_update_animated_pose()


func _add_preset_select(parent):
	var presets = CATALOGUE.presets().keys()
	if presets.empty():
		return
	presets.sort()
	var select = _make_select(parent, "DOLL2_PREVIEW_PRESET")
	select.add_item(_text("DOLL2_PREVIEW_NONE"))
	select.set_item_metadata(0, "")
	for preset_id in presets:
		select.add_item(preset_id)
		select.set_item_metadata(select.get_item_count() - 1, preset_id)
	select.connect("item_selected", self, "_on_preset_selected", [select])
	ui["preset"] = select


func _make_select(parent, label_text, channel = ""):
	var label = Label.new()
	label.text = _text(label_text)
	parent.add_child(label)
	var row = HBoxContainer.new()
	parent.add_child(row)
	var select = OptionButton.new()
	select.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	select.clip_text = true
	row.add_child(select)
	# The colour of a part belongs next to the part itself, not in a separate
	# list at the bottom of the panel.
	if !channel.empty():
		_add_channel_picker(row, channel)
	return select


func _build_channel_materials():
	var channels = CATALOGUE.color_channels()
	for channel_id in channels.keys():
		var material = ShaderMaterial.new()
		material.shader = RECOLOR_SHADER
		channel_materials[channel_id] = material
		var zones = int(channels[channel_id].get("zones", 0))
		if zones > 0:
			# Gear art is hue-coded, so its zones start on real colours instead
			# of on white: raw magenta is a placeholder, not a look.
			material.set_shader_param("zone_count", zones)
			material.set_shader_param("zone_hues", Vector3(
				CATALOGUE.zone_hues()[0] / 360.0,
				CATALOGUE.zone_hues()[1] / 360.0,
				CATALOGUE.zone_hues()[2] / 360.0
			))
			material.set_shader_param("zone_distance", CATALOGUE.zone_distance() / 360.0)
			zone_values[channel_id] = []
			for i in range(zones):
				zone_values[channel_id].append(CATALOGUE.zone_defaults()[i])
			_apply_zone_colours(channel_id)
			continue
		color_values[channel_id] = Color(1, 1, 1)
		color_values_secondary[channel_id] = Color(1, 1, 1)
		_apply_channel_colour(channel_id)


func _add_channel_picker(parent, channel_id):
	var channel = CATALOGUE.color_channels()[channel_id]
	var zones = int(channel.get("zones", 0))
	if zones > 0:
		for i in range(zones):
			_add_zone_picker(parent, channel_id, i)
		return
	_add_picker_button(parent, channel_id, false)
	if channel.get("two_tone", false):
		_add_picker_button(parent, channel_id, true)


func _add_picker_button(parent, channel_id, secondary):
	var picker = ColorPickerButton.new()
	picker.rect_min_size = Vector2(54, 0)
	picker.color = color_values_secondary[channel_id] if secondary else color_values[channel_id]
	picker.hint_tooltip = _text("DOLL2_PREVIEW_TINT_TIPS_HINT" if secondary else "DOLL2_PREVIEW_TINT_HINT")
	picker.connect("color_changed", self, "_on_channel_colour_changed", [channel_id, secondary])
	parent.add_child(picker)
	ui["color/" + channel_id + ("/tips" if secondary else "")] = picker


func _add_zone_picker(parent, channel_id, zone_index):
	var picker = ColorPickerButton.new()
	picker.rect_min_size = Vector2(36, 0)
	picker.color = zone_values[channel_id][zone_index]
	picker.hint_tooltip = _text("DOLL2_PREVIEW_ZONE_HINT")
	picker.connect("color_changed", self, "_on_zone_colour_changed", [channel_id, zone_index])
	parent.add_child(picker)
	ui["color/%s/zone%d" % [channel_id, zone_index]] = picker


func _on_channel_colour_changed(colour, channel_id, secondary = false):
	if secondary:
		color_values_secondary[channel_id] = colour
	else:
		color_values[channel_id] = colour
	_apply_channel_colour(channel_id)


func _on_zone_colour_changed(colour, channel_id, zone_index):
	zone_values[channel_id][zone_index] = colour
	_apply_zone_colours(channel_id)


func _apply_zone_colours(channel_id):
	var material = channel_materials.get(channel_id)
	if material == null:
		return
	for i in range(zone_values[channel_id].size()):
		material.set_shader_param("zone%d_color" % (i + 1), zone_values[channel_id][i])


func _apply_channel_colour(channel_id):
	var material = channel_materials.get(channel_id)
	if material == null:
		return
	var primary = color_values[channel_id]
	var secondary = color_values_secondary.get(channel_id, primary)
	var has_primary = !_is_neutral(primary)
	var has_secondary = !_is_neutral(secondary)
	# White is how an unset colour is expressed: the shader stays off while both
	# are white, and a single picked colour paints the whole part evenly.
	if !has_primary:
		primary = secondary
	if !has_secondary:
		secondary = primary
	material.set_shader_param("recolor", primary)
	material.set_shader_param("recolor2", secondary)
	material.set_shader_param("strength", 0.0 if !has_primary and !has_secondary else 1.0)


func _is_neutral(colour):
	return colour.r >= 0.999 and colour.g >= 0.999 and colour.b >= 0.999


# Two-tone channels blend along the mesh, so they need to know how tall it is.
# Bounds are taken from the solved geometry rather than the art, so a long
# hairstyle and a short one each get the full gradient across their own length.
func _track_gradient_bounds(channel_id, points):
	if channel_id.empty() or points.empty():
		return
	if !CATALOGUE.color_channels()[channel_id].get("two_tone", false):
		return
	var bounds = gradient_bounds.get(channel_id, Vector2(points[0].y, points[0].y))
	for point in points:
		bounds.x = min(bounds.x, point.y)
		bounds.y = max(bounds.y, point.y)
	gradient_bounds[channel_id] = bounds


func _apply_gradient_bounds():
	for channel_id in channel_materials.keys():
		if !CATALOGUE.color_channels()[channel_id].get("two_tone", false):
			continue
		var bounds = gradient_bounds.get(channel_id, Vector2.ZERO)
		channel_materials[channel_id].set_shader_param("gradient_top", bounds.x)
		channel_materials[channel_id].set_shader_param("gradient_span", max(bounds.y - bounds.x, 0.0))


func _select_metadata(select, value):
	for i in range(select.get_item_count()):
		if select.get_item_metadata(i) == value:
			select.select(i)
			return
	select.select(0)


func _text(key):
	var translated = tr(key)
	if translated != key:
		return translated
	if editor_strings.empty():
		editor_strings = ENGLISH_TRANSLATION.new().TranslationDict
	return editor_strings.get(key, key)


func _on_select_changed(_item_index, group_id, select):
	selections[group_id] = select.get_item_metadata(select.selected)
	if group_id == "body":
		_follow_body_tag()
	_rebuild_model()


# A beastkin body ships its own chin and skull meshes, so switching the body
# moves the head with it unless the head already matches.  Both sides are looked
# up by tag, never by attachment name.
func _follow_body_tag():
	var beastkin_body = CATALOGUE.has_tag(selections.get("body", ""), "beastkin")
	if CATALOGUE.has_tag(selections.get("head", ""), "beastkin") == beastkin_body:
		return
	var head_id = ""
	if beastkin_body:
		head_id = CATALOGUE.first_part_with_tag("head", "beastkin")
	else:
		head_id = str(CATALOGUE.group("head").get("default", ""))
	if head_id.empty():
		return
	selections["head"] = head_id
	_select_ui_value("head", head_id)


func _on_axis_changed(_item_index, axis, select):
	axis_values[axis] = select.get_item_metadata(select.selected)
	_rebuild_model()


func _on_preset_selected(_item_index, select):
	var preset_id = str(select.get_item_metadata(select.selected))
	if preset_id.empty():
		return
	selections = CATALOGUE.apply_preset(selections, preset_id)
	_follow_body_tag()
	for group_id in selections.keys():
		_select_ui_value(group_id, selections[group_id])
	_rebuild_model()


func _select_ui_value(key, value):
	if !ui.has(key):
		return
	_select_metadata(ui[key], value)


func _rebuild_model():
	if !skeleton:
		return
	composed = CATALOGUE.compose(selections, axis_values)
	if model_root != null:
		model_root.queue_free()
	mesh_records.clear()
	gradient_bounds.clear()
	model_root = Node2D.new()
	model_root.name = "SpineModel"
	add_child(model_root)
	_bake_bone_hierarchy()
	rendered_meshes = 0
	for slot in _draw_ordered_slots():
		var attachment = _resolve_attachment(slot)
		if attachment.empty():
			continue
		_add_attachment(slot, attachment)
	_apply_gradient_bounds()
	# The model node is new, so the view has to be put back onto it.
	_apply_view()
	print("Doll2Preview: created %d mesh slots from %d Spine slots." % [rendered_meshes, slot_data.size()])


# Child order in the scene is draw order, so the model is built along the
# catalogue's corrected order rather than the export's raw slot order.
func _draw_ordered_slots():
	var by_name = {}
	for slot in slot_data:
		by_name[slot.get("name", "")] = slot
	var result = []
	for slot_name in CATALOGUE.draw_order():
		if by_name.has(slot_name):
			result.append(by_name[slot_name])
	return result


func _bake_bone_hierarchy():
	bone_nodes.clear()
	bone_root = Node2D.new()
	bone_root.name = "Bones"
	model_root.add_child(bone_root)
	bone_root.position = DISPLAY_ORIGIN
	bone_root.scale = Vector2.ONE * float(MODIFIERS.display_scale(height_tier))
	# Bone2D editor gizmos cover the entire doll with white wedges.  Keep the
	# clean textured preview in the editor; the full Bone2D hierarchy is built
	# when the scene runs and can be inspected in Remote.
	if Engine.editor_hint:
		return
	var nodes = {}
	for definition in skeleton.get("bones", []):
		var bone = Bone2D.new()
		bone.name = definition.get("name", "Bone")
		var solved = bones[bone.name]
		bone.position = Vector2(float(solved.local_x), -float(solved.local_y)) * DISPLAY_SCALE
		bone.rotation = -deg2rad(float(solved.local_rotation))
		bone.scale = Vector2(float(solved.local_scale_x), float(solved.local_scale_y))
		var parent_name = definition.get("parent", "")
		if parent_name.empty():
			bone_root.add_child(bone)
		else:
			nodes[parent_name].add_child(bone)
		nodes[bone.name] = bone
		bone_nodes[bone.name] = bone


func _update_bone_nodes():
	if is_instance_valid(bone_root):
		bone_root.scale = Vector2.ONE * float(MODIFIERS.display_scale(height_tier))
	for bone_name in bone_nodes.keys():
		if !is_instance_valid(bone_nodes[bone_name]) or !bones.has(bone_name):
			continue
		var solved = bones[bone_name]
		var node = bone_nodes[bone_name]
		node.position = Vector2(float(solved.local_x), -float(solved.local_y)) * DISPLAY_SCALE
		node.rotation = -deg2rad(float(solved.local_rotation))
		node.scale = Vector2(float(solved.local_scale_x), float(solved.local_scale_y))


# The export is a single flattened skin, so there is no skin stack to search:
# the catalogue already decided which attachment every slot holds.
func _resolve_attachment(slot):
	var slot_name = slot.get("name", "")
	var attachment_name = str(composed.get(slot_name, ""))
	if attachment_name.empty():
		return {}
	var attachments = skin_map.get(SKIN_NAME, {}).get("attachments", {})
	if !attachments.has(slot_name) or !attachments[slot_name].has(attachment_name):
		push_warning("Doll2Preview: composed attachment `%s/%s` is not in the export" % [slot_name, attachment_name])
		return {}
	var result = attachments[slot_name][attachment_name].duplicate()
	result["_attachment_name"] = attachment_name
	result["_skin_name"] = SKIN_NAME
	return result


func _add_attachment(slot, attachment):
	var attachment_type = attachment.get("type", "region")
	if attachment_type == "clipping" or attachment_type == "path" or attachment_type == "point":
		return
	# Spine 4.2 writes the atlas region into `name` for most meshes. `path` is
	# used by some older exports. Falling straight back to the attachment key
	# made clothes, ears and tails resolve logically but fail before rendering.
	var path = attachment.get("path", "")
	if path.empty():
		path = attachment.get("name", "")
	if path.empty():
		path = attachment.get("_attachment_name", "")
	if !atlas.has(path):
		return
	var region = atlas[path]
	var page = pages.get(region.page, {})
	if page.empty() or page.texture == null:
		return
	var data = _attachment_geometry(slot, attachment, region, page.size, _attachment_deform(slot, attachment))
	if data.empty():
		return
	var polygon = Polygon2D.new()
	polygon.name = slot.get("name", "Attachment")
	polygon.texture = page.texture
	polygon.position = DISPLAY_ORIGIN
	polygon.color = _attachment_colour(slot, attachment)
	var channel = CATALOGUE.slot_channel(slot.get("name", ""))
	polygon.material = channel_materials.get(channel)
	_track_gradient_bounds(channel, data.points)
	polygon.polygon = data.points
	polygon.uv = data.uvs
	polygon.polygons = data.triangles
	model_root.add_child(polygon)
	mesh_records.append({"polygon": polygon, "slot": slot, "attachment": attachment, "region": region, "page_size": page.size})
	rendered_meshes += 1


func _update_mesh_geometry():
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		var deform = _attachment_deform(record.slot, record.attachment)
		var data = _attachment_geometry(record.slot, record.attachment, record.region, record.page_size, deform)
		if !data.empty():
			record.polygon.polygon = data.points


func _attachment_deform(slot, attachment):
	var result = []
	var skin_name = attachment.get("_skin_name", "")
	var slot_name = slot.get("name", "")
	var attachment_name = attachment.get("_attachment_name", "")
	for animation_name in animation_states.keys():
		if !animation_states[animation_name]:
			continue
		var attachment_timelines = skeleton.get("animations", {}).get(animation_name, {}).get("attachments", {})
		if !attachment_timelines.has(skin_name):
			continue
		var skin_timelines = attachment_timelines[skin_name]
		if !skin_timelines.has(slot_name) or !skin_timelines[slot_name].has(attachment_name):
			continue
		var timeline = skin_timelines[slot_name][attachment_name].get("deform", [])
		var sampled = _sample_deform_timeline(timeline, float(animation_times.get(animation_name, 0.0)), _deform_length(attachment))
		if result.empty():
			result = sampled
		else:
			for i in range(min(result.size(), sampled.size())):
				result[i] += sampled[i]
	return result


func _deform_length(attachment):
	var vertices = attachment.get("vertices", [])
	var uv_size = attachment.get("uvs", []).size()
	if vertices.size() == uv_size:
		return vertices.size()
	var cursor = 0
	var influence_count = 0
	while cursor < vertices.size():
		var count = int(vertices[cursor])
		influence_count += count
		cursor += 1 + count * 4
	return influence_count * 2


func _sample_deform_timeline(frames, time, length):
	var empty_deform = []
	empty_deform.resize(length)
	for i in range(length):
		empty_deform[i] = 0.0
	if frames.empty():
		return empty_deform
	var current_index = 0
	for i in range(frames.size()):
		if float(frames[i].get("time", 0.0)) <= time:
			current_index = i
		else:
			break
	var current = _expanded_deform_frame(frames[current_index], length)
	var curve = frames[current_index].get("curve", "")
	var stepped = typeof(curve) == TYPE_STRING and curve == "stepped"
	if current_index + 1 >= frames.size() or stepped:
		return current
	var next_frame = frames[current_index + 1]
	var start_time = float(frames[current_index].get("time", 0.0))
	var end_time = float(next_frame.get("time", start_time))
	if end_time <= start_time:
		return current
	var next = _expanded_deform_frame(next_frame, length)
	var percent = clamp((time - start_time) / (end_time - start_time), 0.0, 1.0)
	for i in range(length):
		current[i] = lerp(float(current[i]), float(next[i]), percent)
	return current


func _expanded_deform_frame(frame, length):
	var result = []
	result.resize(length)
	for i in range(length):
		result[i] = 0.0
	var offset = int(frame.get("offset", 0))
	var values = frame.get("vertices", [])
	for i in range(values.size()):
		if offset + i < length:
			result[offset + i] = float(values[i])
	return result


# Attachment tints are deliberately ignored.  Eighteen beastkin meshes carry a
# pale lavender tint left over from before their art was redrawn: it renders the
# breasts blue against a purple torso, which is the mismatch the previous preview
# tried to patch over.  The art underneath already matches, and player colour now
# comes from the channel material, so the stale tint has no job left.
func _attachment_colour(slot, _attachment):
	return _spine_colour(slot.get("color", "FFFFFFFF"))


func _spine_colour(hex_value):
	if hex_value == null or str(hex_value).length() < 8:
		return Color(1, 1, 1, 1)
	# Color() requires an HTML value.  Without the leading '#', Godot 3 turns
	# otherwise valid Spine colours into black, hiding every mesh in the editor.
	return Color("#" + str(hex_value).substr(0, 8))


func _multiply_colours(first, second):
	return Color(first.r * second.r, first.g * second.g, first.b * second.b, first.a * second.a)


func _attachment_geometry(slot, attachment, region, page_size, deform = []):
	var raw_vertices = attachment.get("vertices", [])
	var is_mesh = attachment.get("type", "region") in ["mesh", "linkedmesh"] or raw_vertices.size() > 0
	if is_mesh:
		if raw_vertices.empty():
			return {}
		var points = _mesh_points(raw_vertices, attachment.get("uvs", []).size(), deform)
		var uv_points = PoolVector2Array()
		var uvs = attachment.get("uvs", [])
		for i in range(0, uvs.size(), 2):
			uv_points.append(_mesh_uv(region, float(uvs[i]), float(uvs[i + 1]), page_size))
		var triangles = []
		for i in range(0, attachment.get("triangles", []).size(), 3):
			triangles.append(PoolIntArray([attachment.triangles[i], attachment.triangles[i + 1], attachment.triangles[i + 2]]))
		return {"points": points, "uvs": uv_points, "triangles": triangles}
	var width = float(attachment.get("width", region.bounds.size.x))
	var height = float(attachment.get("height", region.bounds.size.y))
	var x = float(attachment.get("x", 0.0))
	var y = float(attachment.get("y", 0.0))
	var rotation = deg2rad(float(attachment.get("rotation", 0.0)))
	var sx = float(attachment.get("scaleX", 1.0))
	var sy = float(attachment.get("scaleY", 1.0))
	var local = [Vector2(-width * 0.5 * sx, -height * 0.5 * sy), Vector2(-width * 0.5 * sx, height * 0.5 * sy), Vector2(width * 0.5 * sx, height * 0.5 * sy), Vector2(width * 0.5 * sx, -height * 0.5 * sy)]
	var points = PoolVector2Array()
	var bone = bones[slot.get("bone", "root")]
	for point in local:
		var rotated = point.rotated(rotation) + Vector2(x, y)
		points.append(_world_point(bone, rotated))
	var rect = region.bounds
	var uv_points = PoolVector2Array()
	if region.rotate:
		uv_points.append_array([Vector2(rect.position.x, rect.position.y), Vector2(rect.position.x + rect.size.x, rect.position.y), Vector2(rect.end.x, rect.end.y), Vector2(rect.position.x, rect.end.y)])
	else:
		uv_points.append_array([Vector2(rect.position.x, rect.end.y), Vector2(rect.position.x, rect.position.y), Vector2(rect.end.x, rect.position.y), Vector2(rect.end.x, rect.end.y)])
	return {"points": points, "uvs": uv_points, "triangles": [PoolIntArray([0, 1, 2]), PoolIntArray([0, 2, 3])]}


func _mesh_uv(region, u, v, page_size):
	var source_size = region.source_size
	if source_size == Vector2.ZERO:
		return Vector2(u * page_size.x, v * page_size.y)
	# `uvs` in a Spine JSON mesh are normalized inside its source region, not the
	# atlas page. This is Spine's MeshAttachment.updateRegion calculation, kept in
	# pixels because Godot 3 Polygon/Canvas UVs use pixel coordinates.
	var bounds = region.bounds
	if !region.rotate:
		var u_scale = bounds.size.x * source_size.x / bounds.size.x
		var v_scale = bounds.size.y * source_size.y / bounds.size.y
		var u_offset = bounds.position.x - u_scale * region.offset.x / source_size.x
		var v_offset = bounds.position.y + bounds.size.y * (1.0 - source_size.y / bounds.size.y) + v_scale * region.offset.y / source_size.y
		return Vector2(u_offset + u * u_scale, v_offset + v * v_scale)
	# A rotated atlas region swaps its untrimmed dimensions before projecting the
	# mesh's local U/V values into the packed page.
	var rotated_u_scale = source_size.y
	var rotated_v_scale = source_size.x
	var rotated_u_offset = bounds.position.x + bounds.size.y - source_size.y + region.offset.y
	# For a 90 degree atlas rotation Spine keeps `region.width` equal to the
	# packed bounds width. Using the packed height here samples a neighbouring
	# atlas region, which is why legs previously displayed masks and hair pieces.
	var rotated_v_offset = bounds.position.y + bounds.size.x + region.offset.x
	return Vector2(rotated_u_offset + v * rotated_u_scale, rotated_v_offset - u * rotated_v_scale)


func _mesh_points(vertices, uv_size, deform = []):
	var points = PoolVector2Array()
	# Weighted Spine vertices begin with an integer bone count.  An unweighted mesh
	# always has exactly twice as many entries as its UV list and is handled below.
	var unweighted = vertices.size() == uv_size
	if unweighted:
		for i in range(0, vertices.size(), 2):
			var deform_x = float(deform[i]) if i < deform.size() else 0.0
			var deform_y = float(deform[i + 1]) if i + 1 < deform.size() else 0.0
			points.append(_world_point(bones["root"], Vector2(float(vertices[i]) + deform_x, float(vertices[i + 1]) + deform_y)))
		return points
	var cursor = 0
	var deform_cursor = 0
	while cursor < vertices.size():
		var count = int(vertices[cursor])
		cursor += 1
		var result = Vector2.ZERO
		for _i in range(count):
			var bone_index = int(vertices[cursor])
			var deform_x = float(deform[deform_cursor]) if deform_cursor < deform.size() else 0.0
			var deform_y = float(deform[deform_cursor + 1]) if deform_cursor + 1 < deform.size() else 0.0
			var local = Vector2(float(vertices[cursor + 1]) + deform_x, float(vertices[cursor + 2]) + deform_y)
			var weight = float(vertices[cursor + 3])
			var bone_name = skeleton.bones[bone_index].name
			result += _world_point(bones[bone_name], local) * weight
			cursor += 4
			deform_cursor += 2
		points.append(result)
	return points
func _world_point(bone, point):
	var display_scale = _display_scale()
	return Vector2((bone.a * point.x + bone.b * point.y + bone.x) * display_scale, -(bone.c * point.x + bone.d * point.y + bone.y) * display_scale)
