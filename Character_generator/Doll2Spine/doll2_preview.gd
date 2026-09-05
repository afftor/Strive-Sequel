tool
extends Node2D

# Standalone viewer for the Spine 4.2 export.  It intentionally does not depend
# on the game character generator or on a third-party Spine runtime.

const DOLLS = preload("res://Character_generator/Doll2Spine/doll2_dolls.gd")
const SOURCE = preload("res://Character_generator/Doll2Spine/doll2_source.gd")
const DISPLAY_SCALE = 0.52
const DISPLAY_ORIGIN = Vector2(500, 785)
const ENGLISH_TRANSLATION = preload("res://localization/en/main.gd")
const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")
# The contract of the doll on screen; the male rig answers to another one.  It is
# looked up rather than preloaded, so switching doll switches its handles too.
var contract = DOLLS.doll(DOLLS.DEFAULT_DOLL).contract
const MODIFIERS = preload("res://Character_generator/Doll2Spine/universal/doll_modifiers.gd")
const COVERAGE = preload("res://Character_generator/Doll2Spine/universal/doll_coverage.gd")
const PUSH = preload("res://Character_generator/Doll2Spine/universal/doll_push.gd")
const GEAR = preload("res://Character_generator/Doll2Spine/universal/doll_gear_map.gd")
const COLORS = preload("res://Character_generator/Doll2Spine/universal/doll_colors.gd")
const RECOLOR_SHADER = preload("res://Character_generator/Doll2Spine/doll2_recolor.shader")
const SKIN_NAME = "default"

# Translated names for the animations that have one; anything else is shown under
# its own name from the export.
const ANIMATION_LABELS = {
	"idle": "DOLL2_PREVIEW_ANIMATION_IDLE",
	"eyesmove": "DOLL2_PREVIEW_ANIMATION_EYES",
}
# The chest swings when it is poked and when its size changes.  Both halves of
# it are the old paperdoll's: these four numbers are what `ragdoll_builder.gd`
# ran, down to the decay, and the shape below is its shader's.
#     wave = sin(t * TAU * FREQ) * SHIFT * power * exp(-t * DECAY)
const TITS_JIGGLE_TIME = 0.9
const TITS_JIGGLE_FREQ = 3.4
const TITS_JIGGLE_DECAY = 4.0
const TITS_JIGGLE_SHIFT = 16.0 # pixels the nipple travels on the first swing
# The deformation is the old paperdoll's, formula for formula.  Its shader ran
#     dist = length(VERTEX - anchor)
#     if (dist < range) offset += move * (range - dist) * power / range
# per anchor, and the jiggle drove two of them - one per breast - with `move`
# straight down.  So a vertex is pulled hardest at the anchor and not at all
# past `range`, falling off in a straight line between the two, and the pulls
# from both breasts add up where they overlap.  That is what makes the weight
# sit low and central instead of the whole shape growing.
const TITS_JIGGLE_RANGE = 110.0 # the old doll's radius, in pixels of art canvas
# The one thing the old shader did not do: hold the top edge.  Its anchors were
# placed by hand so the falloff had died before the chest, and ours are read off
# the nipples, so without this the whole breast - the join included - rides up
# and down with the wave.  The pull fades in over the top of the breast instead.
# Nothing moves in the top sixth, everything moves in the bottom quarter, and
# the pull eases in between the two rather than ramping straight up - a linear
# ramp still left the join travelling a few pixels.
const TITS_HOLD_FROM = 0.18 # depth where the breast starts to answer at all
const TITS_HOLD_TO = 0.78 # depth from which it answers in full
# Slots that are a breast rather than something drawn on one.  A flat chest has
# only the nipple mask, and a mask stretching by itself reads as a twitch, so a
# doll with none of these does not swing at all.
const TITS_BODY_SLOTS = ["breasts", "breasts_beastkin"]
# Where the anchors are read from, when the doll is bare enough to show them.
const TITS_NIPPLE_SLOTS = ["breast_nipples", "beastkin_pregnancy_nipple"]

# Everything drawn on the chest, so the nipples and the clothes over them swing
# with the breast instead of sliding off it.
const TITS_SLOTS = ["breasts", "breast_nipples", "equip_breasts",
	"breasts_beastkin", "breasts_beastkin_pregnancy", "beastkin_pregnancy_nipple",
	"breasts_beastkin_many"]

# These broad back-hair meshes do not gain enough visible length from their
# authored bone weights alone.  The back-hair slider therefore scales their
# already-skinned world geometry as well: its full +/-30% on Y and half of that
# on X.  Scaling about the middle of the top edge keeps the roots planted while
# the extra length grows downwards.
const HAIR_BACK_MESH_SCALE_PARTS = [
	"hair_back_wawe", "hair_back_straight", "hair_back_care",
]
const HAIR_BACK_MESH_SLOT = "hairs_back"

var _jiggle_time = -1.0
var _jiggle_power = 1.0
var _jiggle_meshes = [] # what is drawn on the chest, and how it rests
var _jiggle_pivot = Vector2.ZERO # the top of the breast: the stretch hangs here
var _jiggle_height = 1.0
var _jiggle_anchors = [] # one per breast, where the pull is hardest

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
# Slots a mod paints with its own image instead of the atlas.  Empty without mods.
var composed_textures = {}
# Slots drawn by a part that is not recoloured - see UNPAINTED_PARTS.
var composed_unpainted = {}
# Slots the composed set is wearing but does not show - what makes a character
# bare rather than dressed.  The screens fill this from the character's undress
# level; in here it follows the undress buttons.
var hidden_slots = []
# How undressed the preview's own buttons have the doll.  A screen leaves this
# alone: it works the level out against real gear and hands over the selections
# and the hidden slots itself.
var undress_level = GEAR.DRESSED
# Values of the per-bone modifiers: the free build sliders, and the named sizes
# a character carries as a stat.  Head size is deliberately not among them - that
# is what height is for.
var proportions = MODIFIERS.defaults()
# Height is one of six authored steps rather than a free scale: each step carries
# its own body proportions, the way the old paperdoll did.
var height_tier = MODIFIERS.HEIGHT_DEFAULT
# Extra solved poses, one per hair layer that is not at its default length.
var layer_poses = {}
var bone_parents = {}
# Arms and legs are solved at their authored lengths, then thickened locally.
# While that final visual pass is running, the factor on a parent segment is
# removed before its child is placed so it cannot turn into length or shear.
var post_ik_visual_scales = {}
var applying_post_ik_visual_scales = false
# Fur or scale pattern painted over the body, "" for bare skin, plus the colour
# of each of its layers.
var coverage_id = ""
var coverage_colors = []
var coverage_textures = {}
# The nipples follow the skin, the way they do in the game, until somebody in
# here picks a colour for them by hand.
var nipples_follow_skin = true
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
# Which of this doll's channels blend a second colour along the mesh, copied from
# the catalogue when the materials are built.
#
# The catalogue is one shared table with an active doll, and every doll on screen
# shares it: a portrait booth or an option picture switching rigs moves it under
# a doll that is mid-frame.  That was survivable while nothing animated - the
# gradient was worked out during a rebuild and never again - but an idling doll
# recomputes it every frame, and a channel the other rig does not have (the male
# `beard`) crashed the lookup.  The answer is not to ask the catalogue in a hot
# path at all.
var channel_two_tone = {}
# Vertical extent of each two-tone channel's meshes, so the shader knows where
# the roots end and the tips begin.
var gradient_bounds = {}
# Images loaded for modded parts, kept so a rebuild does not reload them.
var mod_textures = {}
# View transform for the model, kept out of the mesh maths: zooming moves the
# model node instead of re-solving every vertex, so it costs nothing per frame.
var view_zoom = 1.0
var view_offset = Vector2.ZERO
var panning = false
var ui = {}
var model_root
# Where the doll stands.  The two exports disagree about where their skeleton
# sits - the female rig's root is on the floor between the feet, the male's is up
# at the hips - so one shared origin drops the male half off the bottom of the
# view.  The first solved pose of each doll is measured once and the model is
# shifted so both stand on the same line, centred.  Measured rather than tuned by
# hand per export, which a re-export would silently invalidate.
var model_offset = Vector2.ZERO
var model_offset_ready = false
var bone_root
var bone_nodes = {}
var asset_dir = ""
var editor_strings = {}
var rendered_meshes = 0
var mesh_records = []
var animation_states = {}
# What the running animations currently say about the slots: which attachment
# each holds and in what order they draw.  Both change which meshes exist, so a
# change here needs a rebuild rather than a re-pose.
var animation_attachments = {}
var animation_signature = 0
var animation_times = {}
var animation_durations = {}
# What the running animations do to the bones they key, as {bone: [x, y,
# rotation]} - the local values before any modifier has touched them.  A solve
# runs the whole skeleton once per hair layer plus once more, and every one of
# those passes used to sample the same 151 keyed timelines at the same instant:
# four identical passes for one frame, 6 ms each.  The sample is taken once and
# kept beside the moment it was taken at, so the extra passes read it instead.
var bone_sample = {}
var bone_sample_key = ""
# Layer slots the last solve left alone because nothing was drawn in them.
var skipped_layers = {}
# A blink, on top of whatever else is playing.
#
# `eyesmove` is the take the artist cut for it: a quarter-second deform of the
# face mesh that closes the lids and opens them again, authored for every face in
# both exports, beastkin included.  It is not part of the idle - a breath is a
# steady loop and an eye is not - so it is fired on its own timer and switched
# off again the frame it ends, which leaves the lids where the pose has them.
#
# Only the game turns this on; the preview panel keeps its own toggle for the
# same animation, where it loops so it can be looked at.
# Parts the cursor can push about - the ears, today.
#
# What is pushable, how hard it gives and how it snaps back all live in
# `doll_push.gd`; the doll keeps only what the doll knows, which is where the
# bones have ended up this frame and how big the art on them is drawn.  Listing
# another part is a line in that file, not a change here.
var _push_state = {}
var _push_part = ""
var _push_cursor = Vector2.ZERO

const BLINK_ANIMATION = "eyesmove"
const BLINK_MIN_DELAY = 3.0
const BLINK_MAX_DELAY = 7.0
var blink_enabled = false
var blink_delay = 0.0
var handle_buttons = {}
var handles_visible = true
var handle_targets = {}
var handle_custom = {}
var handle_target_offsets = {}
# Which skeleton is on screen.  Everything the doll is made of - the export, its
# textures, its catalogue and its contract - comes from this one id.
var doll_id = DOLLS.DEFAULT_DOLL
# Whether this doll carries its editor panel.  True in the preview scene, false
# wherever the game shows the doll itself.
var interface_enabled = true
var handle_definitions = contract.HANDLES.duplicate(true)

func _ready():
	_load_source()
	_reset_animation_states()
	var mod_sources = CATALOGUE.mod_sources()
	if !mod_sources.empty():
		print("Doll2Preview: mod parts from %s" % PoolStringArray(mod_sources).join(", "))
	for problem in CATALOGUE.mod_problems():
		print("Doll2Preview: mod problem - %s" % problem)
	_build_channel_materials()
	_build_interface()
	_rebuild_model()
	set_blinking(true)
	set_process(true)

func _reset_animation_states():
	animation_states = {}
	animation_times = {}
	var default_animation = str(DOLLS.doll(doll_id).get("default_animation", ""))
	var animations = skeleton.get("animations", {})
	for animation_name in animations.keys():
		animation_states[animation_name] = animation_name == default_animation
		animation_times[animation_name] = 0.0
	if !animations.has(default_animation) and !animations.empty():
		var fallback = animations.keys()[0]
		animation_states[fallback] = true

func _process(delta):
	if skeleton.empty():
		return
	# A doll nobody can see still gets its frame from the engine, and an animated
	# frame is the most expensive thing this node does - the whole skin is solved
	# again on the CPU.  Screens keep their dolls built and hidden rather than
	# freeing them, so this is most of them most of the time.
	if !is_visible_in_tree():
		return
	# before the times are advanced: this decides whether the blink is one of the
	# animations that gets a share of this frame
	_advance_blink(delta)
	var pose_changed = _advance_pushables(delta)
	for animation_name in animation_states.keys():
		if animation_states[animation_name]:
			var duration = float(animation_durations.get(animation_name, 0.0))
			animation_times[animation_name] = fmod(float(animation_times.get(animation_name, 0.0)) + delta, duration) if duration > 0.0 else 0.0
			pose_changed = true
	if pose_changed:
		# A pose can swap an attachment or reorder the slots part way through, and
		# neither survives a plain re-pose.
		if _animation_signature().hash() != animation_signature:
			_rebuild_model()
		else:
			_update_animated_pose()
	# After the pose, never before it: an animated frame rewrites the very
	# points the swing is bending, so bending them first would be undone.
	_advance_jiggle(delta)


# Whether the doll blinks by itself.  Turned on beside the idle and off with it.
func set_blinking(value):
	blink_enabled = bool(value) and animation_durations.get(BLINK_ANIMATION, 0.0) > 0.0
	animation_states[BLINK_ANIMATION] = false
	animation_times[BLINK_ANIMATION] = 0.0
	_schedule_blink()


# The wait until the next one, so two dolls on the same screen do not blink in
# step.  The first wait is drawn the same way as the rest, which is why a doll
# does not blink the moment it appears.
func _schedule_blink():
	blink_delay = rand_range(BLINK_MIN_DELAY, BLINK_MAX_DELAY)


func _advance_blink(delta):
	if !blink_enabled or !animation_states.has(BLINK_ANIMATION):
		return
	if animation_states[BLINK_ANIMATION]:
		# The take runs once rather than looping, so it is stopped a frame before
		# the ordinary advance would wrap it back to the start.
		var duration = float(animation_durations.get(BLINK_ANIMATION, 0.0))
		if float(animation_times.get(BLINK_ANIMATION, 0.0)) + delta >= duration:
			animation_states[BLINK_ANIMATION] = false
			animation_times[BLINK_ANIMATION] = 0.0
			_schedule_blink()
		return
	blink_delay -= delta
	if blink_delay <= 0.0:
		animation_times[BLINK_ANIMATION] = 0.0
		animation_states[BLINK_ANIMATION] = true


# The cursor leaning on whatever the doll is wearing that gives way.  Says
# whether the pose has to be worked out again this frame; a doll wearing nothing
# pushable answers `false` after one dictionary lookup.
func _advance_pushables(delta):
	var part_id = str(selections.get(PUSH.PART_GROUP, ""))
	if part_id != _push_part:
		_push_part = part_id
		_push_state = PUSH.new_state(PUSH.bones_for(part_id))
	if _push_state.empty():
		return false
	var cursor = _cursor_over_the_doll()
	# Leaning into it needs the cursor to be moving: a part that drifts under a
	# still pointer - the idle does move the head - must not shove itself.
	var moved = cursor.distance_to(_push_cursor) > 0.5
	_push_cursor = cursor
	var art = _push_art(_push_state.keys())
	var changed = false
	for bone_name in _push_state.keys():
		var entry = _push_state[bone_name]
		if !bool(entry.held) and float(entry.snap) >= 0.0:
			changed = PUSH.advance_snap(entry, delta) or changed
			continue
		if !bool(entry.held) and !moved:
			continue
		var against = _push_contact(bone_name, art.get(bone_name), entry, cursor)
		changed = PUSH.push(entry, against) or changed
	return changed


# Where the cursor stands against one bone's worth of art, in the terms
# `doll_push` works in - or `null` when it is not against it at all.
#
# Contact is the distance to the nearest drawn point, not a cone around the bone:
# the ear art hangs anywhere from 12 to 100 degrees off the bone that carries it
# depending on which cut is worn, so a cone around the bone is a cone through
# empty air on half of them.
func _push_contact(bone_name, art, entry, cursor):
	if !bones.has(bone_name) or art == null or art.points.empty():
		return null
	var inside = false
	for triangle in art.triangles:
		if Geometry.point_is_inside_triangle(cursor, triangle[0], triangle[1], triangle[2]):
			inside = true
			break
	var nearest = 1e9
	if !inside:
		for point in art.points:
			nearest = min(nearest, cursor.distance_squared_to(point))
		nearest = sqrt(nearest)
	if !PUSH.touches(inside, nearest, art.size):
		return null
	var base = _world_point(bones[bone_name], Vector2.ZERO) + _display_origin()
	return PUSH.contact(base, art.middle, entry.angle, cursor)


# The drawn art belonging to each bone: its points, where it sits and how big it
# is.  Split off the points rather than taken from the slot as a whole, because
# one attachment carries both ears and the head is between them; a part rigged to
# a single bone - the cat ears are - takes all of it, because that is what the one
# bone is carrying.
func _push_art(bone_names):
	var points = []
	var triangles = []
	for _i in range(bone_names.size()):
		points.append([])
		triangles.append([])
	var box = _slot_bounds(PUSH.PART_SLOTS)
	var middle = box.position.x + box.size.x * 0.5
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		if !(str(record.slot.get("name", "")) in PUSH.PART_SLOTS):
			continue
		var drawn = record.polygon.polygon
		var offset = record.polygon.position
		for point in drawn:
			points[_side_of(point + offset, middle, bone_names.size())].append(point + offset)
		# The mesh's own triangles, so the cursor can be tested against the art
		# rather than against a box that is mostly the air beside it.
		var indices = record.attachment.get("triangles", [])
		for i in range(0, indices.size() - 2, 3):
			if int(indices[i]) >= drawn.size() or int(indices[i + 1]) >= drawn.size() or int(indices[i + 2]) >= drawn.size():
				continue
			var a = drawn[int(indices[i])] + offset
			var b = drawn[int(indices[i + 1])] + offset
			var c = drawn[int(indices[i + 2])] + offset
			var centre = (a + b + c) / 3.0
			triangles[_side_of(centre, middle, bone_names.size())].append([a, b, c])
	var result = {}
	for index in range(bone_names.size()):
		result[bone_names[index]] = _art_of(points[index], triangles[index])
	return result


# The bone lists are written left first, and the doll faces the viewer, so the
# left bone is the left of the screen.  A part on one bone takes everything.
func _side_of(point, middle, sides):
	if sides > 1 and point.x >= middle:
		return 1
	return 0


func _art_of(points, triangles):
	if points.empty():
		return {"points": [], "triangles": [], "middle": Vector2.ZERO, "size": 0.0}
	var low = Vector2(1e9, 1e9)
	var high = Vector2(-1e9, -1e9)
	for point in points:
		low.x = min(low.x, point.x)
		low.y = min(low.y, point.y)
		high.x = max(high.x, point.x)
		high.y = max(high.y, point.y)
	# The short way across is the yardstick for how near counts as touching: an
	# ear is long and thin, and half a long ear away is much too far.
	return {
		"points": points,
		"triangles": triangles,
		"middle": (low + high) * 0.5,
		"size": min(high.x - low.x, high.y - low.y),
	}


# Turns each pushed bone by however far it is being held, or by where its snap
# back has got to.  Nothing hangs off an ear bone, so the hierarchy below does
# not have to be resolved again.
func _apply_pushables():
	for bone_name in _push_state.keys():
		if !bones.has(bone_name):
			continue
		var swing = PUSH.angle_of(_push_state[bone_name])
		if abs(swing) < 0.001:
			continue
		var bone = bones[bone_name]
		_set_bone_world(bone_name,
			float(bone.local_x), float(bone.local_y),
			float(bone.local_rotation) + swing,
			float(bone.local_scale_x), float(bone.local_scale_y),
			float(bone.local_shear_x), float(bone.local_shear_y))


# Whether anything is drawn over the breasts right now.  Read off what is on
# screen rather than off the undress level, because the two do not always agree:
# a level can leave the chest bare with the rest still dressed, and a piece
# equipped in a screen covers it without the level moving at all.
const CHEST_COVER_SLOTS = ["equip_breasts"]


func chest_is_covered():
	for record in mesh_records:
		if str(record.slot.get("name", "")) in CHEST_COVER_SLOTS:
			return true
	return false


# Rebuilds, and swings the chest if that rebuild covered or bared it.  The panel
# calls this where a screen calls its own `_apply`, so the tool answers a hand on
# the undress buttons the way the game answers a hand on the character.
func _rebuild_and_watch_the_chest():
	var was_covered = chest_is_covered()
	_rebuild_model()
	if chest_is_covered() != was_covered:
		jiggle_tits()


# A swing of the chest.  `power` scales the first one.
func jiggle_tits(power = 1.0):
	stop_tits_jiggle()
	var has_a_breast = false
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		var slot_name = str(record.slot.get("name", ""))
		if !(slot_name in TITS_SLOTS):
			continue
		if slot_name in TITS_BODY_SLOTS:
			has_a_breast = true
		var box = _polygon_bounds(record.polygon)
		if box.size.y <= 0.0:
			continue
		if slot_name in TITS_BODY_SLOTS:
			# the breast decides where the middle is, which is how the two anchors
			# are told apart
			_jiggle_pivot = Vector2(box.position.x + box.size.x * 0.5, box.position.y)
			_jiggle_height = box.size.y
		_jiggle_meshes.append({"polygon": record.polygon, "rest": record.polygon.polygon})
	if !has_a_breast or _jiggle_meshes.empty() or _jiggle_height <= 0.0:
		# a flat chest, a male rig, or a nipple mask with nothing under it
		_jiggle_meshes = []
		return
	# Every vertex on the chest is weighed against the same two anchors rather
	# than against its own mesh: that is what keeps the nipples and the clothing
	# moving with the breast under them.
	_find_jiggle_anchors()
	if _jiggle_anchors.empty():
		_jiggle_meshes = []
		return
	var strongest = 0.0
	for entry in _jiggle_meshes:
		entry["offsets"] = _sag_offsets(entry.rest)
		for offset in entry.offsets:
			strongest = max(strongest, offset.y)
	if strongest > 1.0:
		# The two zones overlap and the shader added them up, so between the
		# breasts the pull came to more than one and the chest travelled further
		# than `SHIFT` says.  Dividing the whole chest by its strongest pull puts
		# that number back in charge without changing the shape.
		for entry in _jiggle_meshes:
			var scaled = PoolVector2Array()
			scaled.resize(entry.offsets.size())
			for i in range(entry.offsets.size()):
				scaled[i] = entry.offsets[i] / strongest
			entry["offsets"] = scaled
	_jiggle_time = 0.0
	_jiggle_power = clamp(power, 0.1, 2.0)
	set_process(true)


# How far each vertex travels on a full swing: down by how low and how central
# it is, out to the side by how far off centre.  One swing is this times the
# wave, so the shape of the sag never changes, only its size.
# How far each vertex travels on a full swing, by the old shader's rule: the
# linear falloff from each anchor, added together.  A swing is this times the
# wave, so the shape never changes - only how hard it is pulled.
func _sag_offsets(points):
	var result = PoolVector2Array()
	result.resize(points.size())
	for i in range(points.size()):
		var pull = 0.0
		for anchor in _jiggle_anchors:
			var distance = points[i].distance_to(anchor)
			if distance < TITS_JIGGLE_RANGE:
				pull += (TITS_JIGGLE_RANGE - distance) / TITS_JIGGLE_RANGE
		# nothing moves where the breast meets the chest; the pull eases in below
		var depth = (points[i].y - _jiggle_pivot.y) / max(_jiggle_height, 1.0)
		pull *= smoothstep(TITS_HOLD_FROM, TITS_HOLD_TO, depth)
		result[i] = Vector2(0.0, pull)
	return result


# Where the old doll hung its two anchors: on the nipples, one per breast.  They
# are read off the nipple mesh, split left and right about the breast's middle;
# a doll whose nipples are hidden under gear falls back to the breast itself.
func _find_jiggle_anchors():
	_jiggle_anchors = []
	var left = Vector2.ZERO
	var right = Vector2.ZERO
	var left_count = 0
	var right_count = 0
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		var slot_name = str(record.slot.get("name", ""))
		if !(slot_name in TITS_NIPPLE_SLOTS) and !(slot_name in TITS_BODY_SLOTS):
			continue
		var prefer_nipples = slot_name in TITS_NIPPLE_SLOTS
		if !prefer_nipples and left_count + right_count > 0:
			continue # the nipples were found already
		for point in record.polygon.polygon:
			if point.x < _jiggle_pivot.x:
				left += point
				left_count += 1
			else:
				right += point
				right_count += 1
		if prefer_nipples:
			break
	if left_count > 0:
		_jiggle_anchors.append(left / left_count)
	if right_count > 0:
		_jiggle_anchors.append(right / right_count)


func _polygon_bounds(polygon):
	var minimum = Vector2(1e9, 1e9)
	var maximum = Vector2(-1e9, -1e9)
	for point in polygon.polygon:
		minimum.x = min(minimum.x, point.x)
		minimum.y = min(minimum.y, point.y)
		maximum.x = max(maximum.x, point.x)
		maximum.y = max(maximum.y, point.y)
	if minimum.x > maximum.x:
		return Rect2()
	return Rect2(minimum, maximum - minimum)


# Everything back where it rests.  The mesh nodes do not survive a rebuild, so
# this runs before one rather than after.
func stop_tits_jiggle():
	for entry in _jiggle_meshes:
		if is_instance_valid(entry.polygon):
			entry.polygon.polygon = entry.rest
	_jiggle_meshes = []
	_jiggle_time = -1.0


# One frame of the swing: a sine that dies away, moving the chest meshes and
# nothing else.  Returns false when there is nothing left to do.
func _advance_jiggle(delta):
	if _jiggle_meshes.empty():
		return false
	_jiggle_time += delta
	if _jiggle_time >= TITS_JIGGLE_TIME:
		stop_tits_jiggle()
		return false
	var wave = sin(_jiggle_time * TAU * TITS_JIGGLE_FREQ) * TITS_JIGGLE_SHIFT * _jiggle_power
	wave *= exp(-_jiggle_time * TITS_JIGGLE_DECAY)
	for entry in _jiggle_meshes:
		if !is_instance_valid(entry.polygon):
			continue
		var rest = entry.rest
		var offsets = entry.offsets
		var points = PoolVector2Array()
		points.resize(rest.size())
		for i in range(rest.size()):
			points[i] = rest[i] + offsets[i] * wave
		entry.polygon.polygon = points
	return true


func _load_source():
	asset_dir = get_script().resource_path.get_base_dir() + "/"
	var source = DOLLS.doll(doll_id)
	contract = source.contract
	bone_parents.clear()
	handle_definitions = contract.HANDLES.duplicate(true)
	CATALOGUE.use(doll_id)
	# The export is read once per rig and handed to every doll that wears it: the
	# skeleton, its skins, the atlas regions and the animation lengths are the
	# same numbers for all of them, and each doll used to pay 3 MB of JSON and a
	# tenth of a second for a private copy of them.  Everything a doll *does* with
	# those numbers - the solved pose, the selections, the meshes and their
	# colours - stays on the instance, which is why the rest can be shared.
	var shared = SOURCE.of(doll_id)
	if shared.empty():
		return
	skeleton = shared.skeleton
	# A different rig keys different bones, and the sample is keyed only by which
	# animations are running and when - two dolls both sitting at time 0 of an
	# animation they both name `idle1` would otherwise share one.
	bone_sample = {}
	bone_sample_key = ""
	slot_data = shared.slot_data
	skin_map = shared.skin_map
	atlas = shared.atlas
	pages = shared.pages
	animation_durations = shared.animation_durations
	_solve_pose()
	_initialize_handles()


# Solves the skeleton, plus one extra pose for every hair layer whose length is
# off default.  A layer's meshes are skinned from its own pose, which is how two
# layers sharing the same bones can still have different lengths.
#
# A layer the character is not wearing is not solved.  The pose costs a full pass
# over 271 bones - the timelines, the modifiers, the IK - and a length is off
# default on every character whose hair is not the middle tier, so a bald one was
# paying for four hair poses nothing would ever read.
#
# `mesh_records` is the list those poses are read against: `_update_mesh_geometry`
# walks exactly it, and it is current at both call sites - every frame from
# `_process`, and straight after the rebuild the screens do.  The one solve that
# runs before the first build has no records to consult at all, so an empty list
# has to mean "solve them all" rather than "solve none".
func _solve_pose():
	layer_poses.clear()
	skipped_layers.clear()
	var layers = MODIFIERS.layer_factors(proportions, _bone_parents(), contract.CONTRACT_ID)
	var drawn = _drawn_slot_names()
	var wanted = []
	for slot_name in layers.keys():
		if !drawn.empty() and !drawn.has(slot_name):
			skipped_layers[slot_name] = true
		else:
			wanted.append(slot_name)
	# Solved first now rather than last: the layers are taken off this pose
	# instead of each solving the skeleton again from the setup pose.  `bones` is
	# left holding it either way.
	_build_bone_transforms()
	if wanted.empty():
		return
	var world_offsets = MODIFIERS.bone_world_offsets(proportions, contract.CONTRACT_ID)
	var base = _snapshot_pose()
	for slot_name in wanted:
		var factors = layers[slot_name]
		var affected = []
		for bone_name in factors.keys():
			if bones.has(bone_name):
				affected.append(bone_name)
		if _layer_needs_a_full_solve(affected, world_offsets):
			_build_bone_transforms(factors)
			layer_poses[slot_name] = _snapshot_pose()
			_build_bone_transforms()
			continue
		layer_poses[slot_name] = _layer_pose(base, factors, affected)


# One layer's pose, lifted off the ordinary one rather than solved again.
#
# A layer scales two to six bones at the end of a hair chain, and the whole
# difference between the two poses is those bones and the 2 to 35 that hang off
# them - out of 271, all below `head`.  Everything else in the solve arrives at
# the same numbers twice: the timelines, the modifiers, the IK on the limbs, the
# hands.  Solving it all again to find that out cost 10 ms a layer, and a
# character wearing three of them paid it three times a frame.
#
# Correctness rests on the layer factor reaching the bone the same way round
# either way.  It does: the old pass multiplied it into the modifier factors and
# set `local_scale * factor`, and the modifier factors are already in the local
# scale of the pose this starts from, so multiplying it in here composes the same
# product.  Nothing downstream of the modifiers writes to this subtree - no IK
# constraint, pushable or handle reaches a hair bone - and everything they do
# write, they write as local values, which a re-derive reproduces.
func _layer_pose(base, layer_factors, affected):
	if affected.empty():
		return base
	# The post-IK pass left every world transform computed with the parent's own
	# limb thickness stripped out of the basis; a re-derive has to be made in the
	# same terms or a bone under a thickened parent lands somewhere else.
	applying_post_ik_visual_scales = !post_ik_visual_scales.empty()
	var restore = {}
	for bone_name in affected:
		var bone = bones[bone_name]
		restore[bone_name] = Vector2(float(bone.local_scale_x), float(bone.local_scale_y))
		var factor = layer_factors[bone_name]
		_set_bone_world(
			bone_name,
			float(bone.local_x), float(bone.local_y), float(bone.local_rotation),
			float(bone.local_scale_x) * factor.x, float(bone.local_scale_y) * factor.y,
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
	var moved = _resolve_subtree(affected)
	# Shallow on purpose: the bones this layer did not move keep pointing at the
	# ordinary pose's entries, which nothing ever writes to.
	var pose = base.duplicate()
	for bone_name in moved.keys():
		var bone = bones[bone_name]
		pose[bone_name] = {"a": bone.a, "b": bone.b, "c": bone.c, "d": bone.d, "x": bone.x, "y": bone.y}
	# and the ordinary pose put back, so the next layer starts where this one did
	for bone_name in affected:
		var bone = bones[bone_name]
		var scale = restore[bone_name]
		_set_bone_world(
			bone_name,
			float(bone.local_x), float(bone.local_y), float(bone.local_rotation),
			scale.x, scale.y,
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
	_resolve_subtree(affected)
	applying_post_ik_visual_scales = false
	return pose


# The one thing a re-derive cannot reproduce is a world offset: it is added
# straight onto a solved position and leaves no trace in the bone's own local
# values.  A layer carrying one inside its subtree is solved the long way.
func _layer_needs_a_full_solve(affected, world_offsets):
	if world_offsets.empty() or affected.empty():
		return false
	var parents = _bone_parents()
	for offset_bone in world_offsets.keys():
		var cursor = str(offset_bone)
		var depth = 0
		while cursor != "" and depth < 64:
			if cursor in affected:
				return true
			cursor = str(parents.get(cursor, ""))
			depth += 1
	return false


# The slots the doll currently draws something in, as a set.
func _drawn_slot_names():
	var result = {}
	for record in mesh_records:
		result[str(record.slot.get("name", ""))] = true
	return result


# Whether the doll has just put on a layer the last pose left unsolved, which is
# the one way the skip above can be wrong: the pose was taken while the slot was
# empty, and the meshes that have appeared in it since would be skinned from the
# plain pose and worn at the default length.
func _drawn_layer_was_skipped():
	if skipped_layers.empty():
		return false
	for record in mesh_records:
		if skipped_layers.has(str(record.slot.get("name", ""))):
			return true
	return false


# {bone: parent} straight off the export, so a length modifier can work out where
# a strand ends without the bone names being written down anywhere.
func _bone_parents():
	if bone_parents.empty():
		for definition in skeleton.get("bones", []):
			bone_parents[definition.get("name", "")] = definition.get("parent", "")
	return bone_parents


# Skinning only reads the solved world transform, so the snapshot leaves out the
# definition and the local values that a re-solve rebuilds anyway.
func _snapshot_pose():
	var result = {}
	for bone_name in bones.keys():
		var bone = bones[bone_name]
		result[bone_name] = {"a": bone.a, "b": bone.b, "c": bone.c, "d": bone.d, "x": bone.x, "y": bone.y}
	return result


# The pose a slot is skinned from: its layer's, or the ordinary one.
func _pose_for(slot):
	return layer_poses.get(slot.get("name", ""), bones)


func _build_bone_transforms(layer_factors = {}):
	bones.clear()
	post_ik_visual_scales.clear()
	applying_post_ik_visual_scales = false
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
	_apply_bone_modifiers(layer_factors)
	_apply_pushables()
	_apply_native_handle_targets()
	var constraints = skeleton.get("ik", []).duplicate()
	constraints.sort_custom(self, "_sort_ik_constraints")
	for constraint in constraints:
		_apply_ik_constraint(constraint)
	_apply_hand_handles()
	_apply_post_ik_visual_scales()


# IK must never use a cosmetic thickness as reach.  Rebuild the final hierarchy
# once after every native and synthetic IK solve.  Every segment receives the
# slider in its own local Y; `_set_bone_world` strips the parent's copy from both
# position and basis before composing the next segment.
func _apply_post_ik_visual_scales():
	post_ik_visual_scales = MODIFIERS.post_ik_visual_factors(proportions, contract.CONTRACT_ID)
	if post_ik_visual_scales.empty():
		return
	applying_post_ik_visual_scales = true
	for definition in skeleton.get("bones", []):
		var name = str(definition.get("name", ""))
		if !bones.has(name):
			continue
		var bone = bones[name]
		var factor = post_ik_visual_scales.get(name, Vector2.ONE)
		_set_bone_world(
			name,
			float(bone.local_x), float(bone.local_y), float(bone.local_rotation),
			float(bone.local_scale_x) * factor.x,
			float(bone.local_scale_y) * factor.y,
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
	applying_post_ik_visual_scales = false


func _apply_bone_modifiers(layer_factors = {}):
	# Every active modifier contributes a multiplier and they compose, so no
	# modifier can silently discard another one acting on the same bone.
	var factors = MODIFIERS.bone_factors(proportions, height_tier, contract.CONTRACT_ID)
	var offsets = MODIFIERS.bone_offsets(proportions, contract.CONTRACT_ID)
	var world_offsets = MODIFIERS.bone_world_offsets(proportions, contract.CONTRACT_ID)
	# A part may carry its own bone tweaks; they multiply into the tier's rather
	# than replacing them, so height still reads correctly while it is worn.
	var part_bones = CATALOGUE.compose_bones(selections)
	for bone_name in part_bones.keys():
		var current = factors.get(bone_name, Vector2.ONE)
		factors[bone_name] = Vector2(current.x * part_bones[bone_name].x, current.y * part_bones[bone_name].y)
	# A layer pose stretches the hair chains on top of all of that, for the one
	# layer being solved.
	for bone_name in layer_factors.keys():
		var current = factors.get(bone_name, Vector2.ONE)
		factors[bone_name] = Vector2(current.x * layer_factors[bone_name].x, current.y * layer_factors[bone_name].y)
	var touched = {}
	for bone_name in factors.keys():
		touched[bone_name] = true
	for bone_name in offsets.keys():
		touched[bone_name] = true
	for bone_name in touched.keys():
		if !bones.has(bone_name):
			continue
		var bone = bones[bone_name]
		var factor = factors.get(bone_name, Vector2.ONE)
		var offset = offsets.get(bone_name, Vector2.ZERO)
		_set_bone_world(
			bone_name,
			float(bone.local_x) + offset.x, float(bone.local_y) + offset.y,
			float(bone.local_rotation),
			float(bone.local_scale_x) * factor.x,
			float(bone.local_scale_y) * factor.y,
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
	if !touched.empty():
		_resolve_bone_hierarchy()
	if !world_offsets.empty():
		for bone_name in world_offsets.keys():
			if !bones.has(bone_name):
				continue
			var bone = bones[bone_name]
			bone.x = float(bone.x) + world_offsets[bone_name].x
			bone.y = float(bone.y) + world_offsets[bone_name].y
			bones[bone_name] = bone
		_update_ik_descendants(world_offsets.keys())


# Recomputes every bone's world transform from its own local values, parents
# first.  `_update_ik_descendants` deliberately leaves alone the bones the caller
# just set, which is right after an IK solve but wrong after a pass that sets
# many bones at once: a keyed bone is solved against whatever its parent held at
# that moment, and if the parent settles afterwards the child is never revisited.
# That is how the face came adrift - `eyes_l` and `brov_l` are keyed and hang off
# `head`, which is not keyed and only moved later, so the face plate stayed where
# the setup pose had put it while the mouth and the skull went with the head.
# Identical eye keys in idle1 and idle3 drifted 0.8 px and 7.9 px respectively,
# which is what gave it away: the difference was not in the animation.
func _resolve_bone_hierarchy():
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "")
		if bones.has(name):
			_restore_bone_world(name)


func _display_scale():
	return DISPLAY_SCALE * float(MODIFIERS.display_scale(height_tier))


# Bones a running animation keys, plus - and this is the part that is easy to
# miss - everything hanging off them.  A timeline moves a forearm; the hand is
# not keyed and so is never revisited, and it keeps the world transform it was
# given under the setup pose.  On the arm-swinging idles that left the wrist
# 52-74 px from the hand it belongs to.  The IK pass and the modifier pass
# already re-solve their descendants; so does this one now.
func _apply_active_bone_timelines():
	var sample = _sampled_bone_timelines()
	if sample.empty():
		return
	for name in sample.keys():
		if !bones.has(name):
			continue
		var values = sample[name]
		var bone = bones[name]
		_set_bone_world(
			name, values[0], values[1], values[2],
			float(bone.local_scale_x), float(bone.local_scale_y),
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
	_resolve_bone_hierarchy()


# The keyed bones as the timelines have them at this instant, worked out once per
# moment rather than once per pass over the skeleton.
#
# Order is not part of the answer.  `_set_bone_world` stores what it is given as
# the bone's own local values and derives the world transform from whatever the
# parent holds at that moment, and `_resolve_bone_hierarchy` above re-derives
# every one of those world transforms from the locals, parents first - which is
# why a keyed child could be written before its keyed parent and still come out
# right.  Only the locals survive the pass, and those are independent of it.
func _sampled_bone_timelines():
	var key = ""
	for animation_name in animation_states.keys():
		if animation_states[animation_name]:
			key += "%s@%.6f|" % [animation_name, float(animation_times.get(animation_name, 0.0))]
	if key == bone_sample_key:
		return bone_sample
	bone_sample_key = key
	bone_sample = {}
	if key == "":
		return bone_sample
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
			# A bone two animations both key is written by the later one, which is
			# what the pass this replaced did as well.
			bone_sample[name] = [x, y, rotation]
	return bone_sample


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
	for field_index in range(fields.size()):
		var field = fields[field_index]
		result[field] = _sample_curve_value(current, next, time, field, field_index)
	return result


# Spine 4.2 stores cubic control points as absolute time/value pairs. Translate
# timelines contain one group of four numbers per field, so X and Y can use
# different easing curves instead of sharing a linear percentage.
func _sample_curve_value(current, next, time, field, field_index):
	var first_value = float(current.get(field, 0.0))
	if next == null:
		return first_value
	var second_value = float(next.get(field, 0.0))
	var start_time = float(current.get("time", 0.0))
	var end_time = float(next.get("time", start_time))
	var curve = current.get("curve", "")
	if typeof(curve) == TYPE_STRING and curve == "stepped":
		return first_value
	if end_time <= start_time:
		return first_value
	if typeof(curve) == TYPE_ARRAY:
		var offset = field_index * 4
		if curve.size() >= offset + 4:
			var parameter = _bezier_parameter_for_time(
				time, start_time, float(curve[offset]),
				float(curve[offset + 2]), end_time
			)
			return _cubic_bezier(
				first_value, float(curve[offset + 1]),
				float(curve[offset + 3]), second_value, parameter
			)
	var percent = clamp((time - start_time) / (end_time - start_time), 0.0, 1.0)
	return lerp(first_value, second_value, percent)


func _bezier_parameter_for_time(time, start_time, control_time_1, control_time_2, end_time):
	var low = 0.0
	var high = 1.0
	for _iteration in range(14):
		var middle = (low + high) * 0.5
		var sampled_time = _cubic_bezier(start_time, control_time_1, control_time_2, end_time, middle)
		if sampled_time < time:
			low = middle
		else:
			high = middle
	return (low + high) * 0.5


func _cubic_bezier(start, control_1, control_2, finish, parameter):
	var inverse = 1.0 - parameter
	return inverse * inverse * inverse * start \
		+ 3.0 * inverse * inverse * parameter * control_1 \
		+ 3.0 * inverse * parameter * parameter * control_2 \
		+ parameter * parameter * parameter * finish

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
		var parent_a = float(parent.a)
		var parent_b = float(parent.b)
		var parent_c = float(parent.c)
		var parent_d = float(parent.d)
		var position_a = parent_a
		var position_b = parent_b
		var position_c = parent_c
		var position_d = parent_d
		# Post-IK limb thickness is local to every segment.  Strip a parent's
		# visual factor before composing its child, including the child position:
		# even a small authored local-Y joint offset must not move an IK endpoint.
		if applying_post_ik_visual_scales and post_ik_visual_scales.has(parent_name):
			var visual_factor = post_ik_visual_scales[parent_name]
			if visual_factor.x != 0.0:
				parent_a /= visual_factor.x
				parent_c /= visual_factor.x
			if visual_factor.y != 0.0:
				parent_b /= visual_factor.y
				parent_d /= visual_factor.y
			position_a = parent_a
			position_b = parent_b
			position_c = parent_c
			position_d = parent_d
		bone["x"] = position_a * x + position_b * y + parent.x
		bone["y"] = position_c * x + position_d * y + parent.y
		# Butt size widens spine1 along its local Y.  The thigh positions must
		# follow that wider pelvis, but their bases (and therefore every child)
		# must remain at the world scale they had before it.  Remove only that
		# inherited factor from the parent's basis; the position above deliberately
		# keeps the real, widened parent transform.
		var butt_factor = float(proportions.get("butt", 1.0))
		var compensated_parent = MODIFIERS.rig_bone("spine1", contract.CONTRACT_ID)
		var compensate_scale = parent_name == compensated_parent
		if compensate_scale:
			compensate_scale = false
			for authored_name in MODIFIERS.BUTT_SCALE_COMPENSATION_BONES:
				if name == MODIFIERS.rig_bone(authored_name, contract.CONTRACT_ID):
					compensate_scale = true
					break
		if compensate_scale and butt_factor != 0.0:
			parent_b /= butt_factor
			parent_d /= butt_factor
		# Shoulder width should move the arm root with the end of the collarbone,
		# but must not scale or shear the arm basis.  Position above intentionally
		# keeps the widened parent; only the basis loses its local-X factor.
		var shoulder_factor = float(proportions.get("shoulders", 1.0))
		var authored_parent = MODIFIERS.SHOULDER_WIDTH_BASIS_COMPENSATION.get(name, "")
		if !str(authored_parent).empty() \
			and parent_name == MODIFIERS.rig_bone(authored_parent, contract.CONTRACT_ID) \
			and shoulder_factor != 0.0:
			parent_a /= shoulder_factor
			parent_c /= shoulder_factor
		bone["a"] = parent_a * local_a + parent_b * local_c
		bone["b"] = parent_a * local_b + parent_b * local_d
		bone["c"] = parent_c * local_a + parent_d * local_c
		bone["d"] = parent_c * local_b + parent_d * local_d
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


# The named bones and everything under them, re-derived from their own local
# values in hierarchy order, and the set of them returned.
#
# Unlike `_update_ik_descendants` this re-derives the named bones too, which is
# the difference between a pass that follows an IK solve and one that follows a
# change of local values.  A caller that sets several bones at once can have set
# one that hangs off another - `head5` sits three joints below `head3` and both
# are scaled by the same hair layer - and the lower one was then composed against
# a parent chain that had not been rebuilt yet.  Skipping it, as an IK pass must,
# left it 22 px out and carried its whole chain with it.
func _resolve_subtree(roots):
	var changed = {}
	for name in roots:
		changed[name] = true
	var moved = {}
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "")
		if !bones.has(name):
			continue
		if !changed.has(name) and !changed.has(str(definition.get("parent", ""))):
			continue
		changed[name] = true
		_restore_bone_world(name)
		moved[name] = true
	return moved


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
	_solve_pose()
	_update_mesh_geometry()
	# The hair gradient is measured off the solved geometry, so it has to be
	# measured again whenever that geometry moves.  Height is the case that
	# matters: it rescales the hair without rebuilding the model, and a gradient
	# left at the old extent stops matching the hair it is painted on.
	_recompute_gradient_bounds()
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
			# A poke owns its press and can never leave a previous pan latched.
			# Anywhere else keeps the existing press-to-pan, release-to-stop flow.
			if event.pressed and _poke_tits(event.position):
				panning = false
				get_tree().set_input_as_handled()
			else:
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


# The doll's origin on screen: the shared baseline plus this export's own shift.
func _display_origin():
	return DISPLAY_ORIGIN + model_offset * _display_scale()


func _measure_model_offset():
	if model_offset_ready:
		return
	var minimum = Vector2(1e9, 1e9)
	var maximum = Vector2(-1e9, -1e9)
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		for point in record.polygon.polygon:
			minimum.x = min(minimum.x, point.x)
			minimum.y = min(minimum.y, point.y)
			maximum.x = max(maximum.x, point.x)
			maximum.y = max(maximum.y, point.y)
	var scale = _display_scale()
	if minimum.x > maximum.x or scale == 0.0:
		return
	# Kept in model units so the height tier rescales it with the doll instead of
	# sliding it off the floor.  Whole pixels, so the default doll does not move.
	model_offset = Vector2(round(-(minimum.x + maximum.x) * 0.5), round(-maximum.y)) / scale
	model_offset_ready = true
	_apply_model_origin()


func _apply_model_origin():
	var origin = _display_origin()
	if is_instance_valid(bone_root):
		bone_root.position = origin
	for record in mesh_records:
		if is_instance_valid(record.polygon):
			record.polygon.position = origin
	# The handles are projected through the same origin, so they move with it -
	# without this the foot handles of a freshly switched doll sit off-screen.
	_update_handle_buttons()


func _apply_view():
	if is_instance_valid(model_root):
		model_root.position = view_offset
		model_root.scale = Vector2.ONE * view_zoom
	# The handles live on a CanvasLayer, which the model's transform does not
	# reach, so they have to be projected through the same view by hand.
	_update_handle_buttons()


func _model_to_screen(local_point):
	return view_offset + local_point * view_zoom


# Swaps the whole doll: another export, another catalogue, another contract.
# Everything downstream is rebuilt rather than patched, because the two dolls
# share neither their parts nor their bones.
func _switch_doll(new_doll_id):
	if new_doll_id == doll_id or !DOLLS.DOLLS.has(new_doll_id):
		return
	doll_id = new_doll_id
	model_offset = Vector2.ZERO
	model_offset_ready = false
	CATALOGUE.use(doll_id)
	for child in get_children():
		if child is CanvasLayer:
			child.queue_free()
	ui.clear()
	handle_buttons.clear()
	channel_materials.clear()
	gradient_bounds.clear()
	coverage_textures.clear()
	mod_textures.clear()
	handle_targets.clear()
	handle_custom.clear()
	handle_target_offsets.clear()
	selections = CATALOGUE.default_selections()
	axis_values = CATALOGUE.default_axes()
	undress_level = GEAR.DRESSED
	hidden_slots = []
	proportions = MODIFIERS.defaults()
	height_tier = MODIFIERS.HEIGHT_DEFAULT
	coverage_id = ""
	coverage_colors = []
	_load_source()
	_reset_animation_states()
	_build_channel_materials()
	_build_interface()
	_rebuild_model()


func _add_doll_select(parent):
	var row = HBoxContainer.new()
	parent.add_child(row)
	var label = Label.new()
	label.text = _text("DOLL2_PREVIEW_DOLL")
	label.rect_min_size.x = 105
	row.add_child(label)
	var select = OptionButton.new()
	select.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for index in range(CATALOGUE.doll_order().size()):
		var id = CATALOGUE.doll_order()[index]
		select.add_item(_text(CATALOGUE.doll_label(id)), index)
		if id == doll_id:
			select.select(index)
	select.connect("item_selected", self, "_on_doll_selected")
	row.add_child(select)


func _on_doll_selected(index):
	_switch_doll(CATALOGUE.doll_order()[index])


func _build_interface():
	# The panel is the editor for this doll, not part of it.  The game embeds the
	# same scene through `doll2_view.gd` and only wants the figure; without this
	# the whole control panel came back the moment the doll switched sex, because
	# switching rebuilds the interface.
	if !interface_enabled:
		return
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
	_add_doll_select(box)
	# Built from the export rather than listed here, so an animation added in a
	# later export shows up on its own instead of being invisible until someone
	# remembers to add a line.
	for animation_name in _sorted_animations():
		if animation_name == BLINK_ANIMATION:
			continue # the blink runs it on its own timer, see the toggle below
		_add_animation_toggle(box, ANIMATION_LABELS.get(animation_name, ""), animation_name)
	var blink_toggle = CheckButton.new()
	blink_toggle.text = _text("DOLL2_PREVIEW_BLINK")
	blink_toggle.pressed = blink_enabled
	blink_toggle.connect("toggled", self, "set_blinking")
	box.add_child(blink_toggle)
	var handles_toggle = CheckButton.new()
	handles_toggle.text = _text("DOLL2_PREVIEW_SHOW_HANDLES")
	handles_toggle.pressed = handles_visible
	handles_toggle.connect("toggled", self, "_on_handles_toggled")
	box.add_child(handles_toggle)
	_add_preset_select(box)
	_add_undress_row(box)
	for group_id in CATALOGUE.group_order():
		var group = CATALOGUE.group(group_id)
		if group.parts.empty():
			continue
		_add_select(box, group.label, group_id, group.parts, group.optional, CATALOGUE.channels_for_group(group_id))
	for axis in _sorted_axes():
		var definition = CATALOGUE.axes()[axis]
		# an axis the body decides is not the player's to pick
		if bool(definition.get("hidden", false)):
			continue
		_add_axis_select(box, definition.label, axis, definition.values)
	# A proportion picked by name reads as one of these, not as a slider stranded
	# in the middle of the build ones.
	for modifier_id in _sorted_modifiers():
		var stepped = MODIFIERS.modifier(modifier_id)
		if stepped.has("steps"):
			_add_proportion_select(box, stepped.label, modifier_id, stepped.steps)
	_add_coverage_select(box)
	_add_height_slider(box)
	for modifier_id in _sorted_modifiers():
		var definition = MODIFIERS.modifier(modifier_id)
		# A stepped proportion is picked by name above.  One marked `tune` gets a
		# slider here as well: that is how the numbers behind the names are found.
		if !definition.has("steps") or definition.get("tune", false):
			_add_proportion_slider(box, definition.label, modifier_id)
	var note = Label.new()
	note.autowrap = true
	note.text = _text("DOLL2_PREVIEW_NOTE")
	box.add_child(note)
	_refresh_zone_pickers()
	_update_handle_buttons()


func _sorted_axes():
	var result = CATALOGUE.axes().keys()
	result.sort()
	return result


# Does this animation move bones, or is it only an overlay on top of a pose?
func _poses_the_skeleton(animation_name):
	return !skeleton.get("animations", {}).get(animation_name, {}).get("bones", {}).empty()


func _sorted_animations():
	# An animation with no timelines at all is not one: the male export carries an
	# empty `1` left over in the Spine project, and a toggle that cannot move
	# anything only invites the question of why it does nothing.
	var result = []
	var animations = skeleton.get("animations", {})
	for animation_name in animations.keys():
		if !animations[animation_name].empty():
			result.append(animation_name)
	result.sort()
	return result


func _add_animation_toggle(parent, label_text, animation_name):
	if !skeleton.get("animations", {}).has(animation_name):
		return
	var toggle = CheckButton.new()
	# An animation with no translated name of its own is shown under its own.
	toggle.text = _text(label_text) if !str(label_text).empty() else animation_name
	toggle.pressed = bool(animation_states.get(animation_name, false))
	toggle.connect("toggled", self, "_on_animation_toggled", [animation_name])
	parent.add_child(toggle)
	ui["animation_" + animation_name] = toggle


# A pose is exclusive: two of them at once are two sets of keys on the same
# bones, and the doll ends up in whichever the loop reached last rather than in
# either.  Overlays are not - `eyesmove` only swaps attachments and has no bone
# timeline of its own, so it rides along with any pose.
func _on_animation_toggled(enabled, animation_name):
	animation_states[animation_name] = enabled
	if !enabled:
		animation_times[animation_name] = 0.0
	elif _poses_the_skeleton(animation_name):
		for other_name in animation_states.keys():
			if other_name == animation_name or !animation_states[other_name]:
				continue
			if !_poses_the_skeleton(other_name):
				continue
			animation_states[other_name] = false
			animation_times[other_name] = 0.0
			var toggle = ui.get("animation_" + other_name, null)
			if is_instance_valid(toggle):
				toggle.set_block_signals(true)
				toggle.pressed = false
				toggle.set_block_signals(false)
	# An authored pose brings its own hands and its own draw order, so turning one
	# on or off is a rebuild, not a re-pose.
	_rebuild_model()


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
		var screen_position = _model_to_screen(_display_origin() + Vector2(handle_targets[handle_name].x, -handle_targets[handle_name].y) * _display_scale())
		var button = handle_buttons[handle_name]
		button.rect_position = screen_position - button.rect_size * 0.5
		button.visible = handles_visible


func _add_select(parent, label_text, group_id, part_ids, allow_none = false, channels = []):
	var select = _make_select(parent, label_text, channels)
	if allow_none:
		select.add_item(_text("DOLL2_PREVIEW_NONE"))
		select.set_item_metadata(0, "")
	for part_id in part_ids:
		select.add_item(CATALOGUE.display(part_id))
		select.set_item_metadata(select.get_item_count() - 1, part_id)
	_select_metadata(select, selections.get(group_id, ""))
	_refresh_bindings(select)
	select.connect("item_selected", self, "_on_select_changed", [group_id, select])
	ui[group_id] = select


# The four steps a screen shows a character in, as one row of toggles.  It is the
# same switch the doll carries in its corner in the game; it is here so a set can
# be looked at at every level without a character to equip it on.
func _add_undress_row(parent):
	var label = Label.new()
	label.text = _text("DOLL2_UNDRESS")
	parent.add_child(label)
	var row = HBoxContainer.new()
	parent.add_child(row)
	var group = ButtonGroup.new()
	for level in GEAR.LEVELS:
		var button = Button.new()
		button.text = _text(GEAR.LEVEL_LABELS[level])
		button.toggle_mode = true
		button.group = group
		button.clip_text = true
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.pressed = level == undress_level
		button.connect("pressed", self, "_on_undress_picked", [level])
		row.add_child(button)
		ui["undress/" + level] = button


func _on_undress_picked(level):
	undress_level = level
	hidden_slots = GEAR.hidden_slots(level)
	_rebuild_and_watch_the_chest()


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
# Fur and scale patterns.  One row: the pattern, then a colour per layer, shown
# only for the layers the chosen pattern actually has.
func _add_coverage_select(parent):
	var label = Label.new()
	label.text = _text("DOLL2_PREVIEW_COVERAGE")
	parent.add_child(label)
	var row = HBoxContainer.new()
	parent.add_child(row)
	var select = OptionButton.new()
	select.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	select.clip_text = true
	select.add_item(_text("DOLL2_PREVIEW_NONE"))
	select.set_item_metadata(0, "")
	for pattern_id in COVERAGE.ORDER:
		select.add_item(COVERAGE.pattern(pattern_id).label)
		select.set_item_metadata(select.get_item_count() - 1, pattern_id)
	_select_metadata(select, coverage_id)
	select.connect("item_selected", self, "_on_coverage_changed", [select])
	row.add_child(select)
	ui["coverage"] = select
	for i in range(COVERAGE.MAX_LAYERS + 1):
		var picker = ColorPickerButton.new()
		picker.rect_min_size = Vector2(36, 0)
		picker.hint_tooltip = _text("DOLL2_PREVIEW_COVERAGE_HINT")
		picker.connect("color_changed", self, "_on_coverage_colour_changed", [i])
		row.add_child(picker)
		ui["coverage/layer%d" % i] = picker
	_refresh_coverage_pickers()


func _on_coverage_changed(_item_index, select):
	coverage_id = str(select.get_item_metadata(select.selected))
	coverage_colors = COVERAGE.default_colors(coverage_id)
	_refresh_coverage_pickers()
	_apply_coverage_to_meshes()


func _on_coverage_colour_changed(colour, index):
	while coverage_colors.size() <= index:
		coverage_colors.append(Color(1, 1, 1))
	coverage_colors[index] = colour
	_apply_coverage_to_meshes()


# Fur belongs to bodies that can grow it.  On a human body the whole row is
# disabled rather than hidden, so it stays obvious that the feature exists.
func _coverage_available():
	return CATALOGUE.has_tag(str(selections.get("body", "")), COVERAGE.REQUIRES_TAG)


func _refresh_coverage_pickers():
	var available = _coverage_available()
	var shown = COVERAGE.color_count(coverage_id)
	if ui.has("coverage"):
		ui["coverage"].disabled = !available
	for i in range(COVERAGE.MAX_LAYERS + 1):
		var key = "coverage/layer%d" % i
		if !ui.has(key):
			continue
		ui[key].visible = available and i < shown
		if i < coverage_colors.size():
			ui[key].color = coverage_colors[i]


# Coverage is a per-mesh uniform, so it is pushed straight to the live meshes
# rather than rebuilding the model.
func _apply_coverage_to_meshes():
	for record in mesh_records:
		if !is_instance_valid(record.polygon) or record.polygon.material == null:
			continue
		_apply_coverage(record.polygon.material, record.get("channel", ""))


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


func _make_select(parent, label_text, channels = []):
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
	# list at the bottom of the panel.  A group can anchor more than one: the body
	# carries the skin and the nipples.
	for channel_id in channels:
		_add_channel_picker(row, channel_id)
	return select


func _build_channel_materials():
	var channels = CATALOGUE.color_channels()
	# The two rigs do not carry the same channels - only the male doll has a
	# `beard` - so the old set has to go rather than be added to.  Kept, its
	# materials outlived the catalogue that named them and every lookup against
	# it was a crash waiting for the first frame that asked.  Everything cleared
	# here is rebuilt below, and the doll is recoloured right after a switch.
	channel_materials.clear()
	channel_two_tone.clear()
	color_values.clear()
	color_values_secondary.clear()
	zone_values.clear()
	gradient_bounds.clear()
	for channel_id in channels.keys():
		var material = ShaderMaterial.new()
		material.shader = RECOLOR_SHADER
		channel_materials[channel_id] = material
		channel_two_tone[channel_id] = bool(channels[channel_id].get("two_tone", false))
		material.set_shader_param("zone_hues", Vector3(
			CATALOGUE.zone_hues()[0] / 360.0,
			CATALOGUE.zone_hues()[1] / 360.0,
			CATALOGUE.zone_hues()[2] / 360.0
		))
		material.set_shader_param("zone_distance", Vector3(
			CATALOGUE.zone_distance()[0] / 360.0,
			CATALOGUE.zone_distance()[1] / 360.0,
			CATALOGUE.zone_distance()[2] / 360.0
		))
		# Gear is painted entirely in the hue code, so its zones start on real
		# colours: raw magenta is a placeholder, not a look.  Everywhere else a
		# zone starts white, which leaves that band of the art alone.
		var gear = bool(channels[channel_id].get("gear", false))
		# A channel may bring starting colours of its own - ears want fur and
		# flesh, not the steel and leather gear starts on.
		var own = channels[channel_id].get("zone_defaults", [])
		zone_values[channel_id] = []
		for i in range(CATALOGUE.zone_hues().size()):
			if i < own.size():
				zone_values[channel_id].append(own[i])
			else:
				zone_values[channel_id].append(CATALOGUE.zone_defaults()[i] if gear else Color(1, 1, 1))
		_apply_zone_colours(channel_id)
		color_values[channel_id] = Color(1, 1, 1)
		color_values_secondary[channel_id] = Color(1, 1, 1)
		_apply_channel_colour(channel_id)


func _add_channel_picker(parent, channel_id):
	var channel = CATALOGUE.color_channels()[channel_id]
	# The plain colour is always there; a zone picker only appears once the part
	# being worn actually has art in that band, so rows stay readable.
	_add_picker_button(parent, channel_id, false)
	if channel.get("two_tone", false):
		_add_picker_button(parent, channel_id, true)
	if channel.get("zones", false):
		for i in range(CATALOGUE.zone_hues().size()):
			_add_zone_picker(parent, channel_id, i)


func _add_picker_button(parent, channel_id, secondary):
	var picker = ColorPickerButton.new()
	picker.rect_min_size = Vector2(54, 0)
	picker.color = color_values_secondary[channel_id] if secondary else color_values[channel_id]
	picker.hint_tooltip = _text("DOLL2_PREVIEW_TINT_TIPS_HINT" if secondary else "DOLL2_PREVIEW_TINT_HINT")
	picker.connect("color_changed", self, "_on_channel_colour_changed", [channel_id, secondary])
	_add_swatches(picker, channel_id)
	parent.add_child(picker)
	ui["color/" + channel_id + ("/tips" if secondary else "")] = picker


# The colours a character can actually have, under the wheel.  A doll checked
# against a hand-typed hex is a doll checked against the wrong tone, so the
# palette the game paints from is offered directly; the names go in the tooltip
# because a preset is only a square.
func _add_swatches(picker, channel_id):
	var swatches = COLORS.swatches(channel_id)
	if swatches.empty():
		return
	var names = []
	for entry in swatches:
		picker.get_picker().add_preset(entry[1])
		names.append(str(entry[0]))
	picker.hint_tooltip += "\n\n" + _text("DOLL2_PREVIEW_SWATCHES") % [names.size(), ", ".join(names)]


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
	if channel_id == "nipples" and !secondary:
		# a hand-picked colour is the end of the rule, not an exception to it
		nipples_follow_skin = false
	_apply_channel_colour(channel_id)
	if channel_id == "skin" and !secondary:
		_follow_skin_with_nipples()


# In the game the nipples are read off the skin's own shade; the preview used to
# leave them at the artist's pink, which is why a light skin came out with one
# pair here and another one in play.
func _follow_skin_with_nipples():
	if !nipples_follow_skin or !color_values.has("nipples"):
		return
	color_values["nipples"] = COLORS.nipples_from_colour(color_values.get("skin", Color(1, 1, 1)))
	_apply_channel_colour("nipples")
	if ui.has("color/nipples"):
		ui["color/nipples"].color = color_values["nipples"]


func _on_zone_colour_changed(colour, channel_id, zone_index):
	zone_values[channel_id][zone_index] = colour
	_apply_zone_colours(channel_id)


func _apply_zone_colours(channel_id):
	var material = channel_materials.get(channel_id)
	if material == null:
		return
	for i in range(zone_values[channel_id].size()):
		var colour = zone_values[channel_id][i]
		material.set_shader_param("zone%d_color" % (i + 1), colour)
		# White means the band keeps the art's own colour and falls through to
		# the plain colour, the same convention the other pickers use.
		material.set_shader_param("zone%d_on" % (i + 1), 0.0 if _is_neutral(colour) else 1.0)
	_propagate_channel(channel_id)


# Shows only the zone pickers the worn parts can actually use.
func _refresh_zone_pickers():
	for channel_id in CATALOGUE.color_channels().keys():
		var zones = CATALOGUE.channel_zones(channel_id, selections)
		for i in range(CATALOGUE.zone_hues().size()):
			var key = "color/%s/zone%d" % [channel_id, i]
			if ui.has(key):
				ui[key].visible = i in zones


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
	_propagate_channel(channel_id)


# A mesh's own material: the channel's colours plus the map from atlas UV back to
# the art canvas, which is what lets a full-body mask find this mesh.
func _mesh_material(channel_id, region, page_size):
	var template = channel_materials.get(channel_id)
	if template == null:
		return null
	var material = template.duplicate()
	var map = _canvas_map(region, page_size)
	material.set_shader_param("canvas_row0", map[0])
	material.set_shader_param("canvas_row1", map[1])
	_apply_coverage(material, channel_id)
	return material


# Inverse of _mesh_uv: atlas UV -> canvas UV, as two affine rows.  A rotated
# region swaps the axes, which is why this is a matrix and not a scale.
func _canvas_map(region, page_size):
	var source = region.source_size
	if source == Vector2.ZERO or page_size.x <= 0.0 or page_size.y <= 0.0:
		return [Vector4_zero(), Vector4_zero()]
	var bounds = region.bounds
	if !region.rotate:
		var u_origin = bounds.position.x - region.offset.x
		var v_origin = bounds.position.y + bounds.size.y - source.y + region.offset.y
		return [
			Color(page_size.x / source.x, 0.0, -u_origin / source.x, 0.0),
			Color(0.0, page_size.y / source.y, -v_origin / source.y, 0.0),
		]
	var rotated_u_origin = bounds.position.x + bounds.size.y - source.y + region.offset.y
	var rotated_v_origin = bounds.position.y + bounds.size.x + region.offset.x
	return [
		Color(0.0, -page_size.y / source.x, rotated_v_origin / source.x, 0.0),
		Color(page_size.x / source.y, 0.0, -rotated_u_origin / source.y, 0.0),
	]


func Vector4_zero():
	return Color(0.0, 0.0, 0.0, 0.0)


func _apply_coverage(material, channel_id):
	if material == null:
		return
	var channel = CATALOGUE.color_channels().get(channel_id, {})
	var layers = COVERAGE.layers(coverage_id)
	if coverage_id.empty() or layers.empty() or !channel.get("coverage", false) or !_coverage_available():
		material.set_shader_param("coverage_count", 0)
		return
	material.set_shader_param("coverage_count", min(layers.size(), COVERAGE.MAX_LAYERS))
	# The base, when the pattern has one, is the first colour of the row.
	var offset = 0
	if COVERAGE.has_base(coverage_id):
		var base = coverage_colors[0] if coverage_colors.size() > 0 else Color(1, 1, 1)
		material.set_shader_param("coverage_base", base)
		material.set_shader_param("coverage_base_on", 0.0 if _is_neutral(base) else 1.0)
		offset = 1
	else:
		material.set_shader_param("coverage_base_on", 0.0)
	for i in range(min(layers.size(), COVERAGE.MAX_LAYERS)):
		material.set_shader_param("coverage_mask%d" % (i + 1), _coverage_texture(COVERAGE.mask_path(coverage_id, i)))
		var index = i + offset
		material.set_shader_param("coverage_color%d" % (i + 1), coverage_colors[index] if index < coverage_colors.size() else Color(1, 1, 1))


func _coverage_texture(path):
	if path.empty():
		return null
	if !coverage_textures.has(path):
		coverage_textures[path] = load(path)
		if coverage_textures[path] == null:
			push_warning("Doll2Preview: coverage mask `%s` cannot be loaded" % path)
	return coverage_textures[path]


# Colours live on the channel template; the live meshes each hold a copy, so a
# change has to reach them too.
func _propagate_channel(channel_id):
	var template = channel_materials.get(channel_id)
	if template == null:
		return
	for record in mesh_records:
		if record.get("channel", "") != channel_id or !is_instance_valid(record.polygon):
			continue
		var material = record.polygon.material
		if material == null:
			continue
		for name in ["recolor", "recolor2", "strength", "gradient_top", "gradient_span",
				"zone1_color", "zone2_color", "zone3_color", "zone1_on", "zone2_on", "zone3_on"]:
			material.set_shader_param(name, template.get_shader_param(name))


func _is_neutral(colour):
	return colour.r >= 0.999 and colour.g >= 0.999 and colour.b >= 0.999


# Two-tone channels blend along the mesh, so they need to know how tall it is.
# Bounds are taken from the solved geometry rather than the art, so a long
# hairstyle and a short one each get the full gradient across their own length.
func _track_gradient_bounds(channel_id, points):
	if channel_id.empty() or points.empty():
		return
	if !channel_two_tone.get(channel_id, false):
		return
	var bounds = gradient_bounds.get(channel_id, Vector2(points[0].y, points[0].y))
	for point in points:
		bounds.x = min(bounds.x, point.y)
		bounds.y = max(bounds.y, point.y)
	gradient_bounds[channel_id] = bounds


func _recompute_gradient_bounds():
	if gradient_bounds.empty():
		return
	gradient_bounds.clear()
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		_track_gradient_bounds(record.get("channel", ""), record.polygon.polygon)
	_apply_gradient_bounds()


func _apply_gradient_bounds():
	for channel_id in channel_materials.keys():
		if !channel_two_tone.get(channel_id, false):
			continue
		var bounds = gradient_bounds.get(channel_id, Vector2.ZERO)
		channel_materials[channel_id].set_shader_param("gradient_top", bounds.x)
		channel_materials[channel_id].set_shader_param("gradient_span", max(bounds.y - bounds.x, 0.0))
		_propagate_channel(channel_id)


func _select_metadata(select, value):
	for i in range(select.get_item_count()):
		if select.get_item_metadata(i) == value:
			select.select(i)
			return
	select.select(0)


# Build sliders, in a stable order so the panel does not reshuffle itself.
func _sorted_modifiers():
	var result = MODIFIERS.MODIFIERS.keys()
	for modifier_id in MODIFIERS.FACE_MODIFIER_ORDER:
		result.erase(modifier_id)
	for modifier_id in MODIFIERS.WAIST_MODIFIER_ORDER:
		result.erase(modifier_id)
	for modifier_id in MODIFIERS.BREAST_MODIFIER_ORDER:
		result.erase(modifier_id)
	result.sort()
	# The hair lengths sit apart from the build sliders: they are per layer rather
	# than per bone, and reading them next to each other is what makes them
	# legible as four independent lengths.
	var ordered = (
		MODIFIERS.LAYER_MODIFIERS.keys()
		+ result
		+ MODIFIERS.WAIST_MODIFIER_ORDER
		+ MODIFIERS.BREAST_MODIFIER_ORDER
		+ MODIFIERS.FACE_MODIFIER_ORDER
	)
	var available = []
	for modifier_id in ordered:
		var definition = MODIFIERS.modifier(modifier_id)
		var contracts = definition.get("contracts", [])
		if contracts.empty() or contract.CONTRACT_ID in contracts:
			available.append(modifier_id)
	return available


# A proportion the character carries as one of a few named sizes - butt size so
# far - is picked the way breast size is, not dragged on a slider whose numbers
# stand for nothing the game can ask for.
func _add_proportion_select(parent, label_text, key, steps):
	var select = _make_select(parent, label_text)
	for step_name in steps.order:
		select.add_item(step_name)
		select.set_item_metadata(select.get_item_count() - 1, step_name)
	_select_metadata(select, _proportion_step(key, steps))
	select.connect("item_selected", self, "_on_proportion_step_changed", [key, select])
	ui["proportion/" + key] = select


# Which named size the stored factor is, so a rebuilt panel comes up on the size
# the doll is actually wearing.
func _proportion_step(key, steps):
	for step_name in steps.order:
		if abs(float(steps.values[step_name]) - float(proportions.get(key, 1.0))) < 0.001:
			return step_name
	return steps.default


func _on_proportion_step_changed(_item_index, key, select):
	proportions[key] = MODIFIERS.step_factor(key, select.get_item_metadata(select.selected))
	# Bone scales feed the solver, so the pose has to be worked out again.
	_update_animated_pose()


func _add_proportion_slider(parent, label_text, key):
	var definition = MODIFIERS.modifier(key).range
	var row = HBoxContainer.new()
	parent.add_child(row)
	var label = Label.new()
	label.text = _text(label_text)
	label.rect_min_size.x = 105
	row.add_child(label)
	var slider = HSlider.new()
	slider.min_value = float(definition.minimum)
	slider.max_value = float(definition.maximum)
	slider.step = float(definition.step)
	slider.value = float(proportions[key])
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.connect("value_changed", self, "_on_proportion_changed", [key])
	row.add_child(slider)
	var value_label = Label.new()
	value_label.rect_min_size.x = 38
	value_label.align = Label.ALIGN_RIGHT
	row.add_child(value_label)
	ui[key] = slider
	ui[key + "_label"] = value_label
	_update_proportion_label(key)


func _on_proportion_changed(value, key):
	proportions[key] = float(value)
	_update_proportion_label(key)
	if key == "muscle_alpha":
		_apply_muscle_alpha()
		return
	# Bone scales feed the solver, so the pose has to be worked out again.
	_update_animated_pose()
	if key == "breast_scale":
		jiggle_tits()


func _update_proportion_label(key):
	if ui.has(key + "_label"):
		var definition = MODIFIERS.modifier(key)
		if definition.get("display", "") == "percent":
			ui[key + "_label"].text = "%.0f%%" % float(proportions[key])
		else:
			ui[key + "_label"].text = "%.2f" % float(proportions[key])


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
		_refresh_coverage_pickers()
	_refresh_all_bindings()
	_refresh_zone_pickers()
	_rebuild_and_watch_the_chest()


# A part can declare what it needs worn with it - a hair ornament needs hair.
# Entries whose needs are unmet are greyed out rather than hidden, so it stays
# obvious that they exist and why they cannot be picked yet.
func _refresh_all_bindings():
	for group_id in CATALOGUE.group_order():
		if ui.has(group_id):
			_refresh_bindings(ui[group_id])


func _refresh_bindings(select):
	for i in range(select.get_item_count()):
		var part_id = str(select.get_item_metadata(i))
		if part_id.empty():
			continue
		select.set_item_disabled(i, !CATALOGUE.bindings_met(part_id, selections))


# A beastkin body needs the animal cuts of the whole face.  The exported muzzle
# includes its own nose, and the tagged face/lips are drawn around that muzzle;
# leaving only one of these human is visibly wrong.
func _follow_body_tag():
	var beastkin_body = CATALOGUE.has_tag(selections.get("body", ""), "beastkin")
	for group_id in ["head", "face", "lips"]:
		var current = str(selections.get(group_id, ""))
		if CATALOGUE.has_tag(current, "beastkin") == beastkin_body:
			continue
		var replacement = ""
		if beastkin_body:
			if group_id == "face":
				var matching_face = "beastkin_" + current
				if matching_face in CATALOGUE.parts("face"):
					replacement = matching_face
			elif group_id == "lips" and "beastkin_lips_open" in CATALOGUE.parts("lips"):
				replacement = "beastkin_lips_open"
			if replacement.empty():
				replacement = CATALOGUE.first_part_with_tag(group_id, "beastkin")
		else:
			replacement = str(CATALOGUE.group(group_id).get("default", ""))
		if replacement.empty():
			continue
		selections[group_id] = replacement
		_select_ui_value(group_id, replacement)
	# The body part also hides this slot at composition time, so externally loaded
	# selections are safe; clearing the editor value makes the UI tell the truth.
	if beastkin_body:
		selections["nose"] = ""
		_select_ui_value("nose", "")
	elif str(selections.get("nose", "")).empty():
		var default_nose = str(CATALOGUE.group("nose").get("default", ""))
		selections["nose"] = default_nose
		_select_ui_value("nose", default_nose)


# True when the click landed on the chest, which is also when it swung it.
func _poke_tits(screen_point):
	var box = _tits_bounds()
	if box.size.y <= 0.0:
		return false
	if !box.has_point(_to_doll_space(to_local(screen_point))):
		return false
	jiggle_tits()
	return true


func _tits_bounds():
	return _slot_bounds(TITS_SLOTS)


# Where the pointer is in the space the meshes are built in.
#
# Not simply `to_local`: the panel pans and zooms the doll by moving `model_root`
# under this node, and the mesh points are children of that.  A cursor compared
# against them without taking the pan and the zoom back off lands somewhere else
# entirely - which is why the ears ignored the pointer in the tool while
# answering it perfectly in the game, where nothing pans.
func _cursor_over_the_doll():
	return _to_doll_space(to_local(get_global_mouse_position()))


func _to_doll_space(point):
	if !is_instance_valid(model_root):
		return point
	var zoom = max(float(model_root.scale.x), 0.001)
	return (point - model_root.position) / zoom


# The box the named slots draw inside, in the space the meshes are built in -
# where `_cursor_over_the_doll` puts the pointer.
func _slot_bounds(slot_names):
	var minimum = Vector2(1e9, 1e9)
	var maximum = Vector2(-1e9, -1e9)
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		if !(str(record.slot.get("name", "")) in slot_names):
			continue
		for point in record.polygon.polygon:
			var world = point + record.polygon.position
			minimum.x = min(minimum.x, world.x)
			minimum.y = min(minimum.y, world.y)
			maximum.x = max(maximum.x, world.x)
			maximum.y = max(maximum.y, world.y)
	if minimum.x > maximum.x:
		return Rect2()
	return Rect2(minimum, maximum - minimum)


func _on_axis_changed(_item_index, axis, select):
	axis_values[axis] = select.get_item_metadata(select.selected)
	_rebuild_model()
	# The size just changed under the player's eyes; the chest reacts to that
	# here the same way it does in character creation.
	if str(axis) == "tits_size":
		jiggle_tits()


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
	var authored_animation_attachments = _animation_attachments()
	animation_signature = _animation_signature().hash()
	var worn = _worn_selections()
	composed = CATALOGUE.compose(worn, axis_values)
	animation_attachments = _match_animated_hands(authored_animation_attachments, worn)
	composed_textures = CATALOGUE.compose_textures(worn)
	composed_unpainted = CATALOGUE.unpainted_slots(worn)
	# A stripped character keeps the pieces of the set that are not there for
	# modesty - the stockings stay when the rest of the underwear goes.
	for slot_name in hidden_slots:
		composed.erase(slot_name)
		composed_textures.erase(slot_name)
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
	# The screens all re-pose straight after a rebuild and would have caught this
	# on that call; the preview's own rebuilds do not, so a layer that has only
	# just been put on is solved here rather than left a frame behind.  Costs a
	# whole frame's worth of solving, which is why it waits to be needed.
	if _drawn_layer_was_skipped():
		_solve_pose()
		_update_mesh_geometry()
		_recompute_gradient_bounds()
	_apply_gradient_bounds()
	# The model node is new, so the view has to be put back onto it.
	_apply_view()
	# Only ever measured on the first build of a doll; afterwards the offset is
	# held so a change of outfit or pose cannot slide the doll around.
	_measure_model_offset()
	# print("Doll2Preview: created %d mesh slots from %d Spine slots." % [rendered_meshes, slot_data.size()])


# What the doll actually has on, once the undress buttons have had their say.
# The dropdowns go on showing what was picked - stripping a character is not the
# same as choosing nothing - so the level is applied on the way to the model.
func _worn_selections():
	var level = GEAR.normalise(undress_level)
	if level == GEAR.DRESSED:
		return selections
	var result = selections.duplicate()
	if level == GEAR.NAKED:
		for group_id in GEAR.WORN_GROUPS:
			result[group_id] = ""
		return result
	if level == GEAR.UNDERWEAR:
		# what a character with an empty underwear slot is given
		result["outfit"] = GEAR.default_underwear(doll_id)
		return result
	# `bare` keeps the set that is picked instead of the character's underwear, so
	# any set can be looked at with its covering pieces taken off - which is the
	# question this level is here to answer.  The weapons go with the clothes.
	result["weapon_belt"] = ""
	result["weapon_back"] = ""
	return result


# Child order in the scene is draw order, so the model is built along the
# catalogue's corrected order rather than the export's raw slot order.
func _draw_ordered_slots():
	var by_name = {}
	for slot in slot_data:
		by_name[slot.get("name", "")] = slot
	var result = []
	for slot_name in _current_draw_order():
		if by_name.has(slot_name):
			result.append(by_name[slot_name])
	return result


# The order to draw in: the catalogue's, unless a running animation reorders the
# slots itself.  An authored pose does that - the doll folds its arms in front of
# the body in `idle2` and behind it everywhere else, which is a draw order change
# and nothing else.
func _current_draw_order():
	var animated = _animation_draw_order()
	return animated if !animated.empty() else CATALOGUE.draw_order()


# Spine's DrawOrderTimeline, worked out over the export's own slot order because
# that is the order the offsets were authored against.  The catalogue's
# corrections are rules rather than positions, so they are re-applied afterwards
# instead of being carried through the shuffle - the arms cross the tattoo slot
# on their way forward, and an index would land one slot out.
func _animation_draw_order():
	var entry = []
	for animation_name in animation_states.keys():
		if !animation_states[animation_name]:
			continue
		var timeline = skeleton.get("animations", {}).get(animation_name, {}).get("drawOrder", [])
		if timeline.empty():
			continue
		var time = float(animation_times.get(animation_name, 0.0))
		for frame in timeline:
			if float(frame.get("time", 0.0)) <= time:
				entry = frame.get("offsets", [])
	if entry.empty():
		return []
	var order = CATALOGUE.slot_order()
	var count = order.size()
	var offsets = []
	for offset in entry:
		var index = order.find(str(offset.get("slot", "")))
		if index >= 0:
			offsets.append({"index": index, "offset": int(offset.get("offset", 0))})
	offsets.sort_custom(self, "_sort_draw_offsets")
	var placed = []
	placed.resize(count)
	for i in range(count):
		placed[i] = -1
	var unchanged = []
	var original = 0
	for offset in offsets:
		while original != offset.index:
			unchanged.append(original)
			original += 1
		var destination = original + offset.offset
		if destination >= 0 and destination < count:
			placed[destination] = original
		else:
			unchanged.append(original)
		original += 1
	while original < count:
		unchanged.append(original)
		original += 1
	var result = []
	result.resize(count)
	var cursor = unchanged.size()
	for i in range(count - 1, -1, -1):
		if placed[i] >= 0:
			result[i] = order[placed[i]]
		else:
			cursor -= 1
			result[i] = order[unchanged[cursor]] if cursor >= 0 else order[i]
	return _apply_draw_order_fixes(result)


# Small enough to compute every frame: what the animations say about the slots
# right now, so a change can be spotted without rebuilding to find out.
func _animation_signature():
	var result = [_animation_attachments()]
	for animation_name in animation_states.keys():
		if !animation_states[animation_name]:
			continue
		var timeline = skeleton.get("animations", {}).get(animation_name, {}).get("drawOrder", [])
		if timeline.empty():
			continue
		var time = float(animation_times.get(animation_name, 0.0))
		var index = -1
		for i in range(timeline.size()):
			if float(timeline[i].get("time", 0.0)) <= time:
				index = i
		result.append([animation_name, index])
	return result


func _sort_draw_offsets(first, second):
	return int(first.index) < int(second.index)


# `{"slot": x, "before": y}` / `{"slot": x, "after": y}`: x is lifted
# out and dropped directly below/above y.
func _apply_draw_order_fixes(order):
	for fix in CATALOGUE.draw_order_fixes():
		var slot_name = str(fix.get("slot", ""))
		var relation = "before" if fix.has("before") else "after"
		var anchor = str(fix.get(relation, ""))
		var from = order.find(slot_name)
		if from < 0:
			continue
		order.remove(from)
		var to = order.find(anchor)
		if to < 0:
			order.insert(from, slot_name)
		else:
			order.insert(to if relation == "before" else to + 1, slot_name)
	return order


# Attachments a running animation puts in a slot, overriding the choice made in
# the catalogue.  A pose does this to swap in the hand it needs - `idle2` folds
# the arms and takes a different hand for each - and a doll that ignores it wears
# one pose's hands on another pose's arms.
func _animation_attachments():
	var result = {}
	for animation_name in animation_states.keys():
		if !animation_states[animation_name]:
			continue
		var timelines = skeleton.get("animations", {}).get(animation_name, {}).get("slots", {})
		var time = float(animation_times.get(animation_name, 0.0))
		for slot_name in timelines.keys():
			var keys = timelines[slot_name].get("attachment", [])
			var value = null
			var found = false
			for key in keys:
				if float(key.get("time", 0.0)) <= time:
					value = key.get("name", null)
					found = true
			if found and value != null:
				result[slot_name] = str(value)
	return result


# Spine stores literal attachment names in a pose timeline.  Those names belong
# to the body that was visible while the animation was authored: female idle4
# names the human second hands, while the male crossed-arm idle names the femboy
# `variant_2` hands.  The timeline defines the hand SHAPE, not the character's
# race.  Find that shape on any body, then compose the same shape from the body
# actually being worn.  Hand armour follows the same per-side shape as the palm.
func _match_animated_hands(authored, worn):
	var result = authored.duplicate()
	var paired_slots = {
		"hand_left": "equip_hand_left",
		"hand_right": "equip_hand_right",
	}
	for body_slot in paired_slots.keys():
		if !authored.has(body_slot):
			continue
		var pose_value = _hand_pose_for_attachment(body_slot, str(authored[body_slot]))
		if pose_value.empty():
			continue
		var posed_axes = axis_values.duplicate()
		posed_axes["hand_pose"] = pose_value
		var posed = CATALOGUE.compose(worn, posed_axes)
		for slot_name in [body_slot, paired_slots[body_slot]]:
			if posed.has(slot_name):
				result[slot_name] = posed[slot_name]
	return result


func _hand_pose_for_attachment(slot_name, attachment_name):
	for part_id in CATALOGUE.parts("body"):
		var definition = CATALOGUE.part(part_id).get("slots", {}).get(slot_name, {})
		if typeof(definition) != TYPE_DICTIONARY or str(definition.get("axis", "")) != "hand_pose":
			continue
		for pose_value in definition.get("options", {}).keys():
			if str(definition.options[pose_value]) == attachment_name:
				return str(pose_value)
	return ""


func _bake_bone_hierarchy():
	bone_nodes.clear()
	bone_root = Node2D.new()
	bone_root.name = "Bones"
	model_root.add_child(bone_root)
	bone_root.position = _display_origin()
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
	# Only for a slot the doll is already showing: the timeline says which hand to
	# use, not whether the character has one.
	if !attachment_name.empty() and animation_attachments.has(slot_name):
		attachment_name = str(animation_attachments[slot_name])
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
	# A mod can repaint a part: its image replaces the atlas page while the mesh,
	# its weights and its UVs stay exactly as the export authored them.
	var mod_texture = _mod_texture(slot.get("name", ""), region)
	var data = _attachment_geometry(slot, attachment, region, page.size, _attachment_deform(slot, attachment), mod_texture, _pose_for(slot))
	if data.empty():
		return
	var polygon = Polygon2D.new()
	polygon.name = slot.get("name", "Attachment")
	polygon.texture = mod_texture if mod_texture != null else page.texture
	polygon.position = _display_origin()
	polygon.color = _attachment_colour(slot, attachment)
	var channel = CATALOGUE.slot_channel(slot.get("name", ""))
	# A part that is drawn as painted takes no channel: with no material the
	# shader never runs on it and the art reaches the screen untouched.
	if composed_unpainted.has(slot.get("name", "")):
		channel = ""
	# Coverage needs the mesh's own place on the art canvas, so those meshes get
	# their own material instead of sharing the channel's.
	polygon.material = _mesh_material(channel, region, page.size)
	var points = _scale_back_hair_mesh(data.points, slot)
	_track_gradient_bounds(channel, points)
	polygon.polygon = points
	polygon.uv = data.uvs
	polygon.polygons = data.triangles
	model_root.add_child(polygon)
	mesh_records.append({"polygon": polygon, "slot": slot, "attachment": attachment, "region": region, "page_size": page.size, "mod_texture": mod_texture, "channel": channel})
	rendered_meshes += 1


# Loads and caches a mod's image for a slot, warning when it is not the size the
# mesh's UVs were normalised over - at the wrong size the art lands askew.
func _mod_texture(slot_name, region):
	var path = str(composed_textures.get(slot_name, ""))
	if path.empty():
		return null
	if !mod_textures.has(path):
		var texture = _load_texture(path)
		if texture == null:
			push_warning("Doll2Preview: mod image `%s` cannot be loaded" % path)
		elif region.source_size != Vector2.ZERO and texture.get_size() != region.source_size:
			push_warning("Doll2Preview: mod image `%s` is %s, the mesh expects %s" % [path, str(texture.get_size()), str(region.source_size)])
		mod_textures[path] = texture
	return mod_textures[path]


# Mod images normally live outside res://, where Godot's importer never ran, so
# they are read as plain files rather than through the resource loader.
func _load_texture(path):
	if path.begins_with("res://"):
		return load(path)
	var image = Image.new()
	if image.load(path) != OK:
		return null
	var texture = ImageTexture.new()
	texture.create_from_image(image, Texture.FLAG_FILTER)
	return texture


func _update_mesh_geometry():
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		var deform = _attachment_deform(record.slot, record.attachment)
		var data = _attachment_geometry(record.slot, record.attachment, record.region, record.page_size, deform, null, _pose_for(record.slot), true)
		if !data.empty():
			record.polygon.polygon = _scale_back_hair_mesh(data.points, record.slot)


# Extra world-axis scale for the three broad back-hair meshes.  Bone length is
# deliberately left in place, so this transform compounds with the skinned pose
# instead of replacing it.  The top edge is the pivot on Y; expressing the
# result around it is the same scale-plus-downward-offset operation without
# depending on where the export placed the mesh origin.
func _scale_back_hair_mesh(points, slot):
	if str(slot.get("name", "")) != HAIR_BACK_MESH_SLOT:
		return points
	if !(str(selections.get("hair_back", "")) in HAIR_BACK_MESH_SCALE_PARTS):
		return points
	var scale_y = float(proportions.get("hair_back_length", 1.0))
	if is_equal_approx(scale_y, 1.0) or points.empty():
		return points
	var scale_x = 1.0 + (scale_y - 1.0) * 0.5
	var minimum = Vector2(1e9, 1e9)
	var maximum = Vector2(-1e9, -1e9)
	for point in points:
		minimum.x = min(minimum.x, point.x)
		minimum.y = min(minimum.y, point.y)
		maximum.x = max(maximum.x, point.x)
	var pivot = Vector2((minimum.x + maximum.x) * 0.5, minimum.y)
	var scaled = PoolVector2Array()
	scaled.resize(points.size())
	for i in range(points.size()):
		var relative = points[i] - pivot
		scaled[i] = pivot + Vector2(relative.x * scale_x, relative.y * scale_y)
	return scaled


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
	var percent = _sample_deform_curve_percent(frames[current_index], next_frame, time)
	for i in range(length):
		current[i] = lerp(float(current[i]), float(next[i]), percent)
	return current

func _sample_deform_curve_percent(current, next, time):
	var start_time = float(current.get("time", 0.0))
	var end_time = float(next.get("time", start_time))
	if end_time <= start_time:
		return 0.0
	var curve = current.get("curve", "")
	if typeof(curve) == TYPE_ARRAY and curve.size() >= 4:
		var parameter = _bezier_parameter_for_time(
			time, start_time, float(curve[0]), float(curve[2]), end_time
		)
		return _cubic_bezier(0.0, float(curve[1]), float(curve[3]), 1.0, parameter)
	return clamp((time - start_time) / (end_time - start_time), 0.0, 1.0)

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
	var colour = _spine_colour(slot.get("color", "FFFFFFFF"))
	if str(slot.get("name", "")).ends_with("_muscle"):
		colour.a *= clamp(float(proportions.get("muscle_alpha", 30.0)) / 100.0, 0.0, 1.0)
	return colour


func _apply_muscle_alpha():
	for record in mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		if !str(record.slot.get("name", "")).ends_with("_muscle"):
			continue
		record.polygon.color = _attachment_colour(record.slot, record.attachment)


func _spine_colour(hex_value):
	if hex_value == null or str(hex_value).length() < 8:
		return Color(1, 1, 1, 1)
	# Color() requires an HTML value.  Without the leading '#', Godot 3 turns
	# otherwise valid Spine colours into black, hiding every mesh in the editor.
	return Color("#" + str(hex_value).substr(0, 8))


# `points_only` is the animated path: a frame of an animation moves the vertices
# and nothing else, while the UV projection and the triangle list are fixed by
# the art.  Building them anyway and throwing them away - which is what an
# animated frame did - cost 3.2 ms a doll.
func _attachment_geometry(slot, attachment, region, page_size, deform = [], mod_texture = null, pose = null, points_only = false):
	if pose == null:
		pose = bones
	var raw_vertices = attachment.get("vertices", [])
	var is_mesh = attachment.get("type", "region") in ["mesh", "linkedmesh"] or raw_vertices.size() > 0
	if is_mesh:
		if raw_vertices.empty():
			return {}
		var points = _mesh_points(raw_vertices, attachment.get("uvs", []).size(), deform, pose)
		if points_only:
			return {"points": points}
		var uv_points = PoolVector2Array()
		var uvs = attachment.get("uvs", [])
		# A mesh's UVs are normalised over the art it was cut from, so a mod image
		# of that same size maps straight across it with no atlas projection.
		var mod_size = mod_texture.get_size() if mod_texture != null else Vector2.ZERO
		for i in range(0, uvs.size(), 2):
			if mod_texture != null:
				uv_points.append(Vector2(float(uvs[i]) * mod_size.x, float(uvs[i + 1]) * mod_size.y))
			else:
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
	var bone = pose[slot.get("bone", "root")]
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



func _mesh_points(vertices, uv_size, deform = [], pose = null):
	if pose == null:
		pose = bones
	# Worked out once here rather than inside `_world_point`.  It is the same
	# number for every vertex of every mesh, and it costs a dictionary build and
	# three divisions in the modifiers to arrive at; asked once per bone weight it
	# was 4.1 ms of the 17.6 an animated frame took.
	var display_scale = _display_scale()
	var points = PoolVector2Array()
	# Weighted Spine vertices begin with an integer bone count.  An unweighted mesh
	# always has exactly twice as many entries as its UV list and is handled below.
	var unweighted = vertices.size() == uv_size
	if unweighted:
		for i in range(0, vertices.size(), 2):
			var deform_x = float(deform[i]) if i < deform.size() else 0.0
			var deform_y = float(deform[i + 1]) if i + 1 < deform.size() else 0.0
			points.append(_world_point(pose["root"], Vector2(float(vertices[i]) + deform_x, float(vertices[i + 1]) + deform_y), display_scale))
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
			result += _world_point(pose[skeleton.bones[bone_index].name], local, display_scale) * weight
			cursor += 4
			deform_cursor += 2
		points.append(result)
	return points
func _world_point(bone, point, display_scale = -1.0):
	if display_scale < 0.0:
		display_scale = _display_scale()
	return Vector2((bone.a * point.x + bone.b * point.y + bone.x) * display_scale, -(bone.c * point.x + bone.d * point.y + bone.y) * display_scale)
