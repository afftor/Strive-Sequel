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
const TITJUMP_ANIMATION = "titjump"
const EARJUMP_ANIMATION = "earjump"
const TAILMOVE_ANIMATION = "tailmove"
const CUM_ANIMATION = "orgasm"
const CUM_FACE_ANIMATION = "emote_orgasm"
const MISSIONARY_CUM_RESIDUE = "00_semen/semen_hole2"
const PERSISTENT_SEMEN_SLOTS = ["semen_ahole", "semen_vhole", "semen_body", "semen_face", "semen_lips"]
const UNDERWEAR_STOCKINGS = ["legl_underwear2", "legl_underwear2_beastkin", "legr_armor_underwear2", "legr_armor_underwear2_beastkin"]
const TITHAND_ANIMATIONS = ["tithand1", "tithand2"]
const HAND_GRIP_TAKES = {
	"handjobside1": {"bone8": "hand_l"},
	"handjobside2": {"bone16": "hand_r"},
	"simult_handjob": {"bone8": "hand_l", "bone16": "hand_r"},
}
var hand_grip_offsets = {}
const PARTNER_HAND_POSES = ["sex_fingers", "sex_fingers_anal"]
const PARTNER_HAND_SLOTS = ["gg_hand", "gg_hand2", "gg_hand3"]
# Spine lists the frontmost slot first. The renderer traverses back to front.
const TITHAND_DRAW_ORDER = [
	"gg_hand", "gg_hand2", "gg_hand3",
	"hand_left", "fingL", "equip_hand_left", "arm_left", "race_arm_left", "equip_arm_left",
	"hand_right", "fingR", "equip_hand_right", "arm_right", "race_arm_right", "equip_arm_right",
]
const OVERLAY_RULES = preload("res://Character_generator/Doll2Spine/doll2_overlay_rules.gd")
var cum_enabled = false
var cum_visibility_by_animation = {}
var cum_face_overlay = null
var semen_residue = {}
var cum_semen_cleared = false
var tithand_hand_bones = {}
const CUM_POSE_SPEED = 1.3
const CUM_POSE_FAST_DURATION = 1.0
const CUM_POSE_BRAKE_DURATION = 1.0
const CUM_POSE_HOLD_PHASE = 0.25
var cum_pose_playback = {}
# These authored full-body takes use their own anatomical layers. They share
# the exclusive pose dropdown with idle poses and keep the selected worn gear.
const ANATOMY_ANIMATIONS = ["sex_standing", "sex_missionary", "anal_missionary", "double_pen", "deepthroat", "blowjob", "titjob", "handjob2", "handjob1", "simult_handjob", "handjobside1", "handjobside2", "test_combo", "xray", "sex_fingers", "sex_fingers_anal"]
# These lower-body takes use the rear body mesh and its matching clothing cut.
const ASS_ANIMATIONS = ["anal_missionary", "double_pen", "sex_missionary", "test_combo", "sex_fingers", "sex_fingers_anal"]
const ANATOMY_SLOTS = [
	"ass", "ahole", "ahole1", "HipL", "HipL_muscle", "HipR", "HipR_muscle",
	"HipL_up", "HipL_muscle_up", "HipR_up", "HipR_muscle_up",
	"ShinL", "ShinL_muscle", "ShinR", "ShinR_muscle",
	"vagina", "vagina2", "vagina2_muscle", "vhole", "penis", "penis2",
	"penis_minet", "penis_minet2", "penis3", "fingL", "fingR",
]
# The export supplies only one shared version of these layers.
# ahole1 is the second layer keyed by anal_missionary/double_pen for both bodies; the main
# ahole slot still resolves to the selected body's own mesh.
const SHARED_ANATOMY_SLOTS = ["ahole1", "vhole", "penis", "penis2", "penis_minet", "penis_minet2", "penis3"]
const ANATOMY_ALTERNATIVES = {
	"penis": "00_body_nude_female/falos",
	"penis2": "00_body_nude_female/falos",
	"penis3": "00_body_nude_female/falos",
	"penis_minet": "00_body_nude_female/falos_minet",
}
# The right hand's penis has no strap-on art, only the plain and the animal one;
# its plain attachment is named after the left hand's slot.
const ANATOMY_FURRY_ONLY = {"penis_minet2": "00_body_nude_female/penis_minet"}
var anatomy_alternatives = {}
# Poses built from several takes (doll2_pose_composer.gd), registered into the
# shared skeleton under a name derived from their recipe.
const COMPOSER = preload("res://Character_generator/Doll2Spine/doll2_pose_composer.gd")
const COMPOSED_PREFIX = "pose:"
var pose_composer = null
var composed_info = {}
var posed_genitals = ""
var vaginal_opening_mesh = null
var vaginal_partner_material = null
# slot -> the channel colour it had before a partner's was put on it
var partner_colour_defaults = {}
# A beastkin's extra rows under the chest are weighted to the smallest breast
# size's bones, which the titjump take swings along with every other size's, so
# the rows bounced with a chest they are not part of.  They are skinned from a
# pose without the take - see _unjiggled_pose().  The breast sliders still move
# them: the rows' art carries the top pair as well.
const JIGGLE_FREE_SLOTS = ["breasts_beastkin_many", "beastkin_torso_many_nipples"]

# Slots used only to decide whether a click landed on the chest. The motion
# itself comes entirely from the authored titjump animation.
const TITS_SLOTS = ["breasts", "breast_nipples", "equip_breasts",
	"breasts_beastkin", "breasts_beastkin_pregnancy", "beastkin_pregnancy_nipple",
	"breasts_beastkin_many"]

# The export keeps every ear cut in one slot, but its two rig groups need
# different layering. Cuts skinned to the upper ear_lt/ear_rt pair sit behind
# the base hair; side ears on ear_l/ear_r retain the JSON order above it.
# The split is identical in the female and male skeletons.
const UPPER_EAR_PARTS = [
	"ears_cat",
	"ears_fox_n1", "ears_fox_n2", "ears_fox_n3", "ears_fox_n4",
	"ears_mouse",
	"ears_rabbit", "ears_rabbit2", "ears_rabbit3",
	"ears_tanuk",
	"ears_wolf",
]
const FRINGE_BACK_EAR_PARTS = ["ears_human"]
# Base cuts with no fringe piece whose sides hang over the ear roots: the side
# ears go behind the base hair instead of sitting on top of it.
const EARS_BEHIND_HAIR_PARTS = ["hair_base_parting"]

# These broad back-hair meshes do not gain enough visible length from their
# authored bone weights alone.  The back-hair slider therefore scales their
# already-skinned world geometry as well: its full +/-30% on Y and half of that
# on X.  Scaling about the middle of the top edge keeps the roots planted while
# the extra length grows downwards.
const HAIR_BACK_MESH_SCALE_PARTS = [
	"hair_back_wawe", "hair_back_straight", "hair_back_bobcut",
]
const HAIR_BACK_MESH_SLOT = "hairs_back"
const ANIMAL_LOWER_BODIES = ["arachna_body", "scylla_body", "lamia_body", "kentaur_body"]
const ANIMAL_BACK_HEM_START = 115.0
const ANIMAL_BACK_HEM_CENTRE = 65.0
const ANIMAL_BACK_HEM_SHOULDER = 60.0
const ANIMAL_BACK_HEM_WIDTH = 235.0
const ANIMAL_BACK_HEM_DROP = 220.0

# `say` fades the closed and open mouth slots against one another.  The ordinary
# open mouth is the setup attachment, while an orc needs the matching cut added
# by the export instead of showing human lips through its face.
const SAY_ANIMATION = "say"
const SAY_LIPS_SLOT = "lips_say"
const SAY_DEFAULT_LIPS_PART = "lips_s2"
const SAY_ORC_LIPS_PART = "lips_s_orc"
const SAY_ORC_LIPS_PREFIX = "lips_orc"

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
var part_hidden_slots = {}
# Slots a mod paints with its own image instead of the atlas.  Empty without mods.
var composed_textures = {}
# Slots drawn by a part that is not recoloured - see UNPAINTED_PARTS.
var composed_unpainted = {}
# Slots the composed set is wearing but does not show - what makes a character
# bare rather than dressed.  The screens fill this from the character's undress
# level; in here it follows the undress buttons.
var hidden_slots = []
# Whether a beastkin's extra rows under the chest are grown into breasts or are
# nipples alone.  The breast art repeats the top pair, which sits crooked on a
# flat chest, so a flat chest is only ever given the nipples.  The screens set it
# off the character; in here it follows the toggle under the extra-rows picker.
var many_tits_developed = true
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
# The children that keep only part of their parent's basis in `_set_bone_world`,
# by their name on this rig, each with the parent it applies under.  Found once
# per rig in `_load_source`: worked out inline it was a dictionary lookup and up to
# three `rig_bone` calls on every one of the thousand-odd bone writes of a frame.
var butt_compensated_children = {}
var shoulder_compensated_children = {}
# Bone names by their index in the export: a skinning weight names its bone by index.
var bone_names_by_index = []
# The display scale of `display_scale_tier`, kept because the modifiers rebuild
# the tier table on every ask.
var display_scale_tier = "#unset"
var display_scale_value = 1.0
# Spine's RRGGBBAA colour strings, each parsed once.
var spine_colours = {}
# The pose every solve starts from - see `_setup_bones` - with what it was worked
# out for.
var setup_pose = {}
var setup_pose_names = []
var setup_pose_ready = false
var flat_chest_edge_weights = {}
var setup_pose_butt = 1.0
var setup_pose_shoulders = 1.0
# Walks of the skeleton that depend on it alone, kept by the bones they start from:
# see `_descendants_below`, `_resolve_subtree` and `_keyed_bones`.  Emptied with the
# skeleton.
var descendants_below = {}
var subtree_under = {}
var keyed_bones_of = {}
# Fur or scale pattern painted over the body, "" for bare skin, plus the colour
# of each of its layers.
var coverage_id = ""
var coverage_colors = []
var coverage_textures = {}
# The nipples follow the skin - or the coat's own, while one is worn - and the
# mouth follows the fur it sits in, the way both do in the game, until somebody in
# here picks a colour for them by hand.
var nipples_follow_rule = true
var lips_follow_rule = true
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
var xray_enabled = false
var xray_root = null
var xray_records = []
var xray_mask = {}
var xray_pivot = Vector2.ZERO
var animation_states = {}
# What the running animations currently say about the slots: which attachment
# each holds and in what order they draw.  Both change which meshes exist, so a
# change here needs a rebuild rather than a re-pose.
var animation_attachments = {}
var animation_signature = 0
var animation_attachment_signature = 0
var animation_times = {}
# how fast the sex takes play, against their authored speed (the sex scene's slider)
var pose_speed = 1.0
var pose_start_ramps = {}
const POSE_START_RAMP_DURATION = 0.4
const POSE_START_RAMP_RATE = 0.0
var animation_durations = {}
const POSE_TRANSITION_DURATION = 0.35
const EMOTION_TRANSITION_DURATION = 0.3
const EMOTION_PREFIX = "emote_"
const EMOTION_SETUP_SLOTS = {
	# This take keeps the setup blush visible without authoring a redundant
	# attachment or RGBA key for it.
	"emote_horny": ["blush"],
}
# A pose switch crossfades the local transforms produced by the old pose into
# the live sample of the new one. Missing keys mean setup values, which also
# makes turning the last pose off fade smoothly back to the setup pose.
var pose_transition_from = {}
var pose_transition_elapsed = POSE_TRANSITION_DURATION
var pose_transition_sample = {}
var pose_transition_sample_key = ""
var emotion_transition_from = {}
# The bones an emotion crossfade may ease, worked out once per rig.  The fade
# starts from the pose the doll was in, and easing every bone of that sample held
# the whole body back for its length: the idle went on running while the doll
# stayed where the face changed, and the parts the idle swings hardest - the
# breasts, and the nipples on them - lurched and then caught up.  An emotion is an
# overlay on a pose, so only the bones the emotions themselves key have anything
# to ease; everything else follows the live sample.
var emotion_eased_bones = null
var emotion_transition_elapsed = EMOTION_TRANSITION_DURATION
var emotion_transition_sample = {}
var emotion_transition_sample_key = ""
var emotion_colour_from = {}
var emotion_deform_from = {}
var emotion_transition_bone_mask = null
var emotion_setup_slots_from = []
var emotion_setup_slots_to = []
var bone_setup_sample = {}
# What the running animations do to the bones they key, as {bone: [x, y,
# rotation, scale_x, scale_y, shear_x, shear_y]} - the local values before any modifier has
# touched them. A solve
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
const TAIL_MIN_DELAY = 3.0
const TAIL_MAX_DELAY = 7.0
var tail_animation_enabled = false
var tail_animation_delay = 0.0
# Bone offsets asked for by the artless parts - the shy glance - kept apart from
# what the selections want so the eyes can travel between the two.  The pose is
# built with `pose_offsets`; a glide eases it from `pose_offsets_from` to
# `pose_offsets_to` over POSE_OFFSET_GLIDE seconds, and `pose_offsets_time` is
# negative whenever nothing is moving.
const POSE_OFFSET_GLIDE = 0.2
var pose_offsets = {}
var pose_offsets_from = {}
var pose_offsets_to = {}
var pose_offsets_time = -1.0
# Set by the panel just before the rebuild it wants eased; the rebuild uses it up.
var glide_pose_offsets = false
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
	cum_enabled = false
	cum_semen_cleared = false
	cum_pose_playback.clear()
	animation_states = {}
	animation_times = {}
	pose_start_ramps.clear()
	pose_transition_from = {}
	pose_transition_elapsed = POSE_TRANSITION_DURATION
	pose_transition_sample = {}
	pose_transition_sample_key = ""
	emotion_transition_from = {}
	emotion_transition_elapsed = EMOTION_TRANSITION_DURATION
	emotion_transition_sample = {}
	emotion_transition_sample_key = ""
	emotion_colour_from = {}
	emotion_deform_from = {}
	emotion_transition_bone_mask = null
	emotion_setup_slots_from = []
	emotion_setup_slots_to = []
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
	pose_changed = _advance_earjump(delta) or pose_changed
	pose_changed = _advance_tail_animation(delta) or pose_changed
	pose_changed = _advance_pose_transition(delta) or pose_changed
	pose_changed = _advance_emotion_transition(delta) or pose_changed
	pose_changed = _advance_titjump(delta) or pose_changed
	if _advance_pose_offsets(delta):
		pose_changed = true
	pose_changed = _advance_animation_times(delta) or pose_changed
	if pose_changed:
		# An order-only key reuses meshes; attachment changes still rebuild them.
		if _animation_signature().hash() != animation_signature:
			if _animation_attachments().hash() == animation_attachment_signature:
				_reorder_animated_slots()
				_update_animated_pose()
				animation_signature = _animation_signature().hash()
			else:
				# New slot state and geometry must sample the same animation time,
				# including the first frame after wrapping around the loop.
				_solve_pose()
				_rebuild_model()
		else:
			_update_animated_pose()


func _advance_animation_times(delta):
	var changed = false
	for animation_name in animation_states.keys():
		if animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION]:
			continue
		if animation_name in [TITJUMP_ANIMATION, EARJUMP_ANIMATION, TAILMOVE_ANIMATION]:
			continue
		if animation_states[animation_name]:
			var duration = float(animation_durations.get(animation_name, 0.0))
			var previous = float(animation_times.get(animation_name, 0.0))
			var rate = pose_speed if _is_anatomy_animation(animation_name) or _is_sex_side_animation(animation_name) else 1.0
			var step = _pose_start_delta(animation_name, delta) * rate
			var next = fmod(previous + step, duration) if duration > 0.0 else 0.0
			if cum_enabled and (_cum_controls_pose(animation_name) or _is_sex_side_animation(animation_name)) and duration > 0.0:
				next = _cum_pose_time(animation_name, delta, duration)
			animation_times[animation_name] = next
			changed = next != previous or changed
	if cum_enabled:
		var was_running = !_cum_has_finished()
		for animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION]:
			var duration = float(animation_durations.get(animation_name, 0.0))
			# All semen attachment, alpha and deform tracks share this overlay.
			# Brake and hold it with the pose instead of leaving it looping.
			if animation_name == CUM_ANIMATION and duration > 0.0:
				animation_times[animation_name] = _cum_pose_time(animation_name, delta, duration)
			else:
				animation_times[animation_name] = fmod(float(animation_times.get(animation_name, 0.0)) + delta, duration) if duration > 0.0 else 0.0
		if was_running and _cum_has_finished():
			_remember_visible_semen(_has_missionary_lower_take())
		changed = true
	return changed


func _pose_has_partner_attachment(animation_name):
	var timelines = _animation_data(animation_name).get("slots", {})
	for slot_name in timelines:
		var is_hand = str(slot_name).begins_with("gg_hand")
		if !is_hand and !str(slot_name).begins_with("penis"):
			continue
		var keys = timelines[slot_name].get("attachment", [])
		for key in keys:
			if key.get("name") != null and !str(key.name).empty():
				return true
		# A keyed slot can show its setup cut before the first attachment key.
		var can_show_setup = (_is_sex_side_animation(animation_name) or _is_partner_hand_pose(animation_name)) if is_hand else _is_anatomy_animation(animation_name)
		if can_show_setup and (keys.empty() or float(keys[0].get("time", 0.0)) > 0.0):
			for slot in slot_data:
				if slot.name == slot_name and !str(slot.get("attachment", "")).empty():
					return true
	return false


func _pose_start_delta(animation_name, delta):
	if !pose_start_ramps.has(animation_name):
		return delta
	var elapsed = float(pose_start_ramps[animation_name])
	var ramp_step = min(delta, POSE_START_RAMP_DURATION - elapsed)
	var finish = elapsed + ramp_step
	if finish >= POSE_START_RAMP_DURATION:
		pose_start_ramps.erase(animation_name)
	else:
		pose_start_ramps[animation_name] = finish
	# Integrate the linear ramp over the part of the frame inside it.
	# It runs once per activation, independently of frame rate or loops.
	var midpoint = (elapsed + ramp_step * 0.5) / POSE_START_RAMP_DURATION
	return delta - ramp_step * (1.0 - POSE_START_RAMP_RATE) * (1.0 - midpoint)


func _cum_controls_pose(animation_name):
	return !_is_emotion_animation(animation_name) and !_is_sex_side_animation(animation_name) and !(animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION, TITJUMP_ANIMATION, EARJUMP_ANIMATION, TAILMOVE_ANIMATION, BLINK_ANIMATION, SAY_ANIMATION]) and _poses_the_skeleton(animation_name)


func _cum_has_finished():
	return float(cum_pose_playback.get(CUM_ANIMATION, {}).get("elapsed", 0.0)) >= CUM_POSE_FAST_DURATION + CUM_POSE_BRAKE_DURATION


# Use elapsed time so a frame crossing a phase boundary lands at the same
# animation position at every frame rate.
func _cum_pose_time(animation_name, delta, duration):
	if !cum_pose_playback.has(animation_name):
		var start = float(animation_times.get(animation_name, 0.0))
		var brake_start = start + CUM_POSE_SPEED * CUM_POSE_FAST_DURATION
		var hold = duration * CUM_POSE_HOLD_PHASE
		var ideal_stop = brake_start + CUM_POSE_SPEED * CUM_POSE_BRAKE_DURATION * 0.5
		var stop = hold + round((ideal_stop - hold) / duration) * duration
		if stop <= brake_start:
			stop += duration * (floor((brake_start - stop) / duration) + 1.0)
		cum_pose_playback[animation_name] = {"start": start, "elapsed": 0.0, "distance": stop - brake_start}
	var state = cum_pose_playback[animation_name]
	state.elapsed = min(CUM_POSE_FAST_DURATION + CUM_POSE_BRAKE_DURATION, float(state.elapsed) + max(0.0, delta))
	var elapsed = float(state.elapsed)
	if elapsed <= CUM_POSE_FAST_DURATION:
		return fmod(float(state.start) + CUM_POSE_SPEED * elapsed, duration)
	if elapsed >= CUM_POSE_FAST_DURATION + CUM_POSE_BRAKE_DURATION:
		return duration * CUM_POSE_HOLD_PHASE
	var amount = (elapsed - CUM_POSE_FAST_DURATION) / CUM_POSE_BRAKE_DURATION
	var distance = float(state.distance)
	# Align the stop to a forward 25% phase, close to a linear brake's travel.
	# Its power curve starts at 130% and reaches zero speed without a final snap.
	var exponent = CUM_POSE_SPEED * CUM_POSE_BRAKE_DURATION / distance
	var progress = 1.0 - pow(1.0 - amount, exponent)
	if exponent <= 1.0:
		# A very long cycle can put the next 25% phase beyond the brake's normal
		# travel. A forward Hermite catch-up still arrives continuously at rest.
		progress = (-2.0 * amount + 3.0) * amount * amount + exponent * amount * (amount - 1.0) * (amount - 1.0)
	return fmod(float(state.start) + CUM_POSE_SPEED * CUM_POSE_FAST_DURATION + distance * progress, duration)


# The authored breast take is an overlay and runs once. It is kept out of the
# ordinary animation loop above, which deliberately wraps poses with fmod().
func _advance_titjump(delta):
	if !bool(animation_states.get(TITJUMP_ANIMATION, false)):
		return false
	# A chest made flat part way through a take stops it where it is, and so does
	# the preview's own toggle, which turns the take on without asking.
	if chest_is_flat():
		animation_states[TITJUMP_ANIMATION] = false
		animation_times[TITJUMP_ANIMATION] = 0.0
		bone_sample_key = ""
		return true
	var duration = float(animation_durations.get(TITJUMP_ANIMATION, 0.0))
	var next_time = float(animation_times.get(TITJUMP_ANIMATION, 0.0)) + delta
	if duration <= 0.0 or next_time >= duration:
		animation_states[TITJUMP_ANIMATION] = false
		animation_times[TITJUMP_ANIMATION] = 0.0
	else:
		animation_times[TITJUMP_ANIMATION] = next_time
	bone_sample_key = ""
	return true


func play_titjump():
	if !animation_states.has(TITJUMP_ANIMATION):
		return
	# nothing there to bounce: the take would swing the bones of a chest that is
	# drawn flat, and the torso and the top weighted to them wobble with it
	if chest_is_flat():
		return
	animation_times[TITJUMP_ANIMATION] = 0.0
	animation_states[TITJUMP_ANIMATION] = true
	bone_sample_key = ""
	set_process(true)


func _advance_earjump(delta):
	return _advance_one_shot(EARJUMP_ANIMATION, delta)


func play_earjump():
	if !animation_states.has(EARJUMP_ANIMATION):
		return
	animation_times[EARJUMP_ANIMATION] = 0.0
	animation_states[EARJUMP_ANIMATION] = true
	bone_sample_key = ""
	set_process(true)


func _advance_one_shot(animation_name, delta):
	if !bool(animation_states.get(animation_name, false)):
		return false
	var duration = float(animation_durations.get(animation_name, 0.0))
	var next_time = float(animation_times.get(animation_name, 0.0)) + delta
	if duration <= 0.0 or next_time >= duration:
		animation_states[animation_name] = false
		animation_times[animation_name] = 0.0
	else:
		animation_times[animation_name] = next_time
	bone_sample_key = ""
	return true
# Whether this rig carries the named emotion at all.
func has_emotion(emotion_name):
	return animation_states.has(EMOTION_PREFIX + str(emotion_name))


func has_cum_animation():
	var animations = skeleton.get("animations", {})
	return animations.has(CUM_ANIMATION) and animations.has(CUM_FACE_ANIMATION)


# A separate overlay channel: neither the selected pose nor the ordinary
# emotion is switched off, so both resume unchanged when Cum is disabled.
func set_cum(value):
	var enabled = bool(value) and has_cum_animation()
	if enabled == cum_enabled:
		return
	if !enabled:
		_remember_visible_semen()
	var previous_pose = _sampled_bone_timelines().duplicate(true)
	var previous_colours = _capture_animated_slot_colours()
	var previous_deforms = _capture_animated_attachment_deforms()
	var previous_setup_slots = _active_emotion_setup_slots()
	cum_enabled = enabled
	cum_semen_cleared = false
	cum_pose_playback.clear()
	for animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION]:
		animation_times[animation_name] = 0.0
	_begin_emotion_transition(previous_pose, previous_colours, previous_deforms, previous_setup_slots, true)
	_rebuild_model()


func clear_semen():
	semen_residue.clear()
	# Keep the running pose and emotion. Suppress the current emission until
	# the next activation so it cannot repaint the slots immediately.
	cum_semen_cleared = cum_enabled
	_rebuild_model()


# A game view can be reused for another character while this one is hidden.
# Keep the emission clock separate from its residue: the clock only makes
# sense if the character comes back in the same pose.
func capture_cum_effect():
	_remember_visible_semen()
	var state = {}
	if !semen_residue.empty():
		state["residue"] = semen_residue.duplicate(true)
	if cum_enabled:
		var times = {}
		for name in cum_pose_playback:
			times[name] = float(animation_times.get(name, 0.0))
		times[CUM_FACE_ANIMATION] = float(animation_times.get(CUM_FACE_ANIMATION, 0.0))
		state["playback"] = cum_pose_playback.duplicate(true)
		state["times"] = times
		state["cleared"] = cum_semen_cleared
	return state


func restore_cum_effect(state, same_pose):
	if !has_cum_animation() or state.empty():
		return
	semen_residue = state.get("residue", {}).duplicate(true)
	if same_pose and state.has("playback"):
		cum_enabled = true
		cum_semen_cleared = bool(state.get("cleared", false))
		cum_pose_playback = state.playback.duplicate(true)
		for name in state.times:
			if name in [CUM_ANIMATION, CUM_FACE_ANIMATION] or bool(animation_states.get(name, false)):
				animation_times[name] = state.times[name]
		pose_transition_elapsed = POSE_TRANSITION_DURATION
		bone_sample_key = ""
	_rebuild_model()


func _has_missionary_lower_take():
	for animation_name in animation_states:
		if animation_states[animation_name] and composed_info.get(animation_name, {}).get("owners", {}).get("lower", animation_name) == "sex_missionary":
			return true
	return false


func _remember_visible_semen(missionary_finish = false):
	var visible = _cum_visible_slots()
	if visible.empty():
		return
	var current = _animation_attachments()
	var active = _ordered_active_animations()
	var skin = skin_map.get(SKIN_NAME, {}).get("attachments", {})
	for slot in slot_data:
		var slot_name = str(slot.name)
		if !(slot_name in PERSISTENT_SEMEN_SLOTS) or !visible.has(slot_name):
			continue
		var name = str(current.get(slot_name, ""))
		var slot_attachments = skin.get(slot_name, {})
		var replace_vhole = missionary_finish and slot_name == "semen_vhole" and slot_attachments.has(MISSIONARY_CUM_RESIDUE)
		if replace_vhole:
			name = MISSIONARY_CUM_RESIDUE
		var attachment = slot_attachments.get(name, {})
		if attachment.empty():
			continue
		var colour = _animated_slot_colour(slot_name, active)
		if colour.a <= 0.0:
			continue
		var previous = semen_residue.get(slot_name, {})
		if replace_vhole:
			cum_pose_playback[CUM_ANIMATION]["missionary_residue"] = true
		if !previous.empty() and previous.attachment == name and colour.a < previous.colour.a:
			continue
		attachment = attachment.duplicate()
		attachment["_attachment_name"] = name
		attachment["_skin_name"] = SKIN_NAME
		semen_residue[slot_name] = {
			"attachment": name,
			"colour": colour,
			"deform": _attachment_deform(slot, attachment, active),
		}


# The face the doll is making: an emotion by its name without the `emote_`
# prefix, or "" for none, crossfaded the way the preview's picker does it.  A rig
# that has no such emotion - the male export carries none at all - is left as it
# is, and the answer is false.
func set_emotion(emotion_name):
	var wanted = ""
	if str(emotion_name) != "":
		wanted = EMOTION_PREFIX + str(emotion_name)
		if !animation_states.has(wanted):
			return false
	var active = ""
	for animation_name in animation_states.keys():
		if _is_emotion_animation(animation_name) and bool(animation_states[animation_name]):
			active = animation_name
	if wanted == active:
		return true
	if wanted == "":
		_on_animation_toggled(false, active)
		return true
	_on_animation_toggled(true, wanted)
	return true


func _advance_pose_transition(delta):
	if pose_transition_elapsed >= POSE_TRANSITION_DURATION:
		return false
	pose_transition_elapsed = min(POSE_TRANSITION_DURATION, pose_transition_elapsed + delta)
	pose_transition_sample_key = ""
	if pose_transition_elapsed >= POSE_TRANSITION_DURATION:
		pose_transition_from = {}
	return true


func _advance_emotion_transition(delta):
	if emotion_transition_elapsed >= EMOTION_TRANSITION_DURATION:
		return false
	emotion_transition_elapsed = min(EMOTION_TRANSITION_DURATION, emotion_transition_elapsed + delta)
	emotion_transition_sample_key = ""
	if emotion_transition_elapsed >= EMOTION_TRANSITION_DURATION:
		var remove_setup_slots = false
		for slot_name in emotion_setup_slots_from:
			if !(slot_name in emotion_setup_slots_to):
				remove_setup_slots = true
				break
		emotion_transition_from = {}
		emotion_colour_from = {}
		emotion_deform_from = {}
		emotion_setup_slots_from = []
		emotion_setup_slots_to = []
		# A setup attachment that faded out stayed in the mesh list solely for the
		# transition. Remove it once its alpha has reached zero.
		if remove_setup_slots:
			call_deferred("_rebuild_model")
	return true
# Catches the pose offsets up with the selections.  Only a change is acted on, so
# the rebuilds an animation triggers part way through a glide leave it running.
# A change nobody asked to see eased lands at once, and so does one made while
# the doll is hidden - there is nobody to watch it travel.
func _sync_pose_offsets():
	var wanted = CATALOGUE.compose_bone_offsets(selections)
	var glide = glide_pose_offsets
	glide_pose_offsets = false
	if wanted.hash() == pose_offsets_to.hash():
		return
	pose_offsets_to = wanted
	if glide and is_visible_in_tree():
		pose_offsets_from = pose_offsets.duplicate()
		pose_offsets_time = 0.0
	else:
		pose_offsets = wanted.duplicate()
		pose_offsets_time = -1.0


# One frame of a glide.  Eased in and out, the way an eye starts and settles
# rather than sliding at an even pace.  Returns whether anything moved.
#
# A step is never counted as longer than a thirtieth of a second.  The pick that
# starts a glide rebuilds the whole doll, and that frame alone runs to 60 ms or
# so: counted in full it swallowed the first fifth of the movement, and the eyes
# visibly jumped before they started to travel.
func _advance_pose_offsets(delta):
	if pose_offsets_time < 0.0:
		return false
	pose_offsets_time += min(delta, 1.0 / 30.0)
	var t = clamp(pose_offsets_time / POSE_OFFSET_GLIDE, 0.0, 1.0)
	var eased = t * t * (3.0 - 2.0 * t)
	var moving = {}
	for bone_name in pose_offsets_from.keys():
		moving[bone_name] = true
	for bone_name in pose_offsets_to.keys():
		moving[bone_name] = true
	pose_offsets = {}
	for bone_name in moving.keys():
		var start = pose_offsets_from.get(bone_name, Vector2.ZERO)
		var finish = pose_offsets_to.get(bone_name, Vector2.ZERO)
		pose_offsets[bone_name] = start.linear_interpolate(finish, eased)
	if t >= 1.0:
		pose_offsets = pose_offsets_to.duplicate()
		pose_offsets_time = -1.0
	return true


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


func set_tail_animation(value):
	tail_animation_enabled = bool(value) and animation_durations.get(TAILMOVE_ANIMATION, 0.0) > 0.0
	animation_states[TAILMOVE_ANIMATION] = false
	animation_times[TAILMOVE_ANIMATION] = 0.0
	bone_sample_key = ""
	_schedule_tail_animation()
	_update_animated_pose()


func _schedule_tail_animation():
	tail_animation_delay = rand_range(TAIL_MIN_DELAY, TAIL_MAX_DELAY)


func _advance_tail_animation(delta):
	if !tail_animation_enabled or !animation_states.has(TAILMOVE_ANIMATION):
		return false
	if animation_states[TAILMOVE_ANIMATION]:
		var duration = float(animation_durations.get(TAILMOVE_ANIMATION, 0.0))
		var next_time = float(animation_times.get(TAILMOVE_ANIMATION, 0.0)) + delta
		if duration <= 0.0 or next_time >= duration:
			animation_states[TAILMOVE_ANIMATION] = false
			animation_times[TAILMOVE_ANIMATION] = 0.0
			_schedule_tail_animation()
		else:
			animation_times[TAILMOVE_ANIMATION] = next_time
		bone_sample_key = ""
		return true
	tail_animation_delay -= delta
	if tail_animation_delay <= 0.0:
		animation_times[TAILMOVE_ANIMATION] = 0.0
		animation_states[TAILMOVE_ANIMATION] = true
		bone_sample_key = ""
		return true
	return false


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


# A flat or masculine chest - the screens send both as the `flat` size.
func chest_is_flat():
	return str(axis_values.get("tits_size", "")) == "flat"


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
		play_titjump()


func _load_source():
	asset_dir = get_script().resource_path.get_base_dir() + "/"
	var source = DOLLS.doll(doll_id)
	contract = source.contract
	_find_compensated_bones()
	# a new rig, or the same one read again: nothing kept from the last skeleton holds
	setup_pose_ready = false
	descendants_below = {}
	subtree_under = {}
	keyed_bones_of = {}
	pose_composer = null
	composed_info = {}
	emotion_eased_bones = null
	cum_visibility_by_animation.clear()
	cum_face_overlay = null
	semen_residue.clear()
	cum_semen_cleared = false
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
	tithand_hand_bones.clear()
	for definition in skeleton.get("bones", []):
		var name = str(definition.get("name", ""))
		if name in ["bone37", "bone54"] or tithand_hand_bones.has(definition.get("parent", "")):
			tithand_hand_bones[name] = true
	bone_names_by_index = []
	for definition in skeleton.get("bones", []):
		bone_names_by_index.append(definition.get("name", ""))
	# A different rig keys different bones, and the sample is keyed only by which
	# animations are running and when - two dolls both sitting at time 0 of an
	# animation they both name `idle1` would otherwise share one.
	bone_sample = {}
	bone_sample_key = ""
	bone_setup_sample = {}
	for definition in skeleton.get("bones", []):
		bone_setup_sample[str(definition.get("name", ""))] = [
			float(definition.get("x", 0.0)),
			float(definition.get("y", 0.0)),
			float(definition.get("rotation", 0.0)),
			float(definition.get("scaleX", 1.0)),
			float(definition.get("scaleY", 1.0)),
			float(definition.get("shearX", 0.0)),
			float(definition.get("shearY", 0.0)),
		]
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
	var layers = MODIFIERS.layer_factors(proportions, _bone_parents(), contract.CONTRACT_ID, selections)
	var drawn = _drawn_slot_names()
	var wanted = []
	for slot_name in layers.keys():
		if !drawn.empty() and !drawn.has(slot_name):
			skipped_layers[slot_name] = true
		else:
			wanted.append(slot_name)
	# The slots the jiggle leaves alone are skinned from a pose solved without it.
	# Solved ahead of the ordinary pose, so `bones` still ends up holding that one.
	var still = _unjiggled_pose()
	# Solved first now rather than last: the layers are taken off this pose
	# instead of each solving the skeleton again from the setup pose.  `bones` is
	# left holding it either way.
	_build_bone_transforms()
	if still != null:
		for slot_name in JIGGLE_FREE_SLOTS:
			layer_poses[slot_name] = still
	if wanted.empty():
		return
	var world_offsets = MODIFIERS.bone_world_offsets(proportions, contract.CONTRACT_ID)
	var base = _snapshot_pose()
	for slot_name in wanted:
		var factors = layers[slot_name]
		var turns = MODIFIERS.layer_turns(slot_name, proportions, selections, contract.CONTRACT_ID)
		var affected = []
		for bone_name in factors.keys():
			if bones.has(bone_name):
				affected.append(bone_name)
		for bone_name in turns.keys():
			if bones.has(bone_name) and !(bone_name in affected):
				affected.append(bone_name)
		if _layer_needs_a_full_solve(affected, world_offsets):
			_build_bone_transforms(factors, turns)
			layer_poses[slot_name] = _snapshot_pose()
			_build_bone_transforms()
			continue
		layer_poses[slot_name] = _layer_pose(base, factors, turns, affected)


# The skeleton solved with the titjump take switched off, or null while none is
# running or none of the slots that want it is drawn.  The take is left as it was
# found; the caller solves `bones` again.
func _unjiggled_pose():
	if !bool(animation_states.get(TITJUMP_ANIMATION, false)):
		return null
	var drawn = _drawn_slot_names()
	if !drawn.empty():
		var wanted = false
		for slot_name in JIGGLE_FREE_SLOTS:
			if drawn.has(slot_name):
				wanted = true
		if !wanted:
			return null
	animation_states[TITJUMP_ANIMATION] = false
	bone_sample_key = ""
	_build_bone_transforms()
	var pose = _snapshot_pose()
	animation_states[TITJUMP_ANIMATION] = true
	bone_sample_key = ""
	return pose


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
func _layer_pose(base, layer_factors, layer_turns, affected):
	if affected.empty():
		return base
	# The post-IK pass left every world transform computed with the parent's own
	# limb thickness stripped out of the basis; a re-derive has to be made in the
	# same terms or a bone under a thickened parent lands somewhere else.
	applying_post_ik_visual_scales = !post_ik_visual_scales.empty()
	var restore = {}
	for bone_name in affected:
		var bone = bones[bone_name]
		restore[bone_name] = [float(bone.local_scale_x), float(bone.local_scale_y), float(bone.local_rotation)]
		var factor = layer_factors.get(bone_name, Vector2.ONE)
		_set_bone_world(
			bone_name,
			float(bone.local_x), float(bone.local_y),
			float(bone.local_rotation) + float(layer_turns.get(bone_name, 0.0)),
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
		var values = restore[bone_name]
		_set_bone_world(
			bone_name,
			float(bone.local_x), float(bone.local_y), values[2],
			values[0], values[1],
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


func _build_bone_transforms(layer_factors = {}, layer_turns = {}):
	_setup_bones()
	bones.clear()
	post_ik_visual_scales.clear()
	applying_post_ik_visual_scales = false
	for name in setup_pose_names:
		bones[name] = setup_pose[name].duplicate()
	# The timelines and the modifiers write the bones' own values, and the modifier
	# pass re-derives the skeleton from them once, after both.
	var keyed = _apply_active_bone_timelines()
	var authored_grips = _authored_hand_grips()
	_apply_bone_modifiers(layer_factors, layer_turns, keyed)
	_apply_pushables()
	_apply_native_handle_targets()
	var constraints = skeleton.get("ik", []).duplicate()
	constraints.sort_custom(self, "_sort_ik_constraints")
	for constraint in constraints:
		_apply_ik_constraint(constraint)
	_apply_hand_handles()
	_apply_post_ik_visual_scales()
	_apply_hand_grip_offsets(authored_grips)
	_apply_beastkin_mouth_offset()


func _authored_hand_grips():
	var grips = {}
	if doll_id != "female":
		return grips
	var authored_world = {}
	for name in animation_states:
		if !animation_states[name]:
			continue
		var take = composed_info.get(name, {}).get("owners", {}).get("arms", name)
		var anchors = HAND_GRIP_TAKES.get(take, {})
		for anchor in anchors:
			var hand = anchors[anchor]
			if !bones.has(anchor) or !bones.has(hand):
				continue
			# Track the middle of the palm, so a length change moves the grip
			# even if the wrist itself stays put. Ignore visual thickness.
			var palm = Vector2(float(bones[hand].definition.get("length", 0.0)) * 0.5, 0.0)
			grips[anchor] = [hand, palm, _authored_bone_transform(hand, authored_world).xform(palm)]
	return grips


# At this point the blended animation has set local transforms, but the
# proportions have not touched them. Only walk the ancestor chains we need.
func _authored_bone_transform(name, cache):
	if !cache.has(name):
		var bone = bones[name]
		var angle_x = deg2rad(float(bone.local_rotation) + float(bone.local_shear_x))
		var angle_y = deg2rad(float(bone.local_rotation) + 90.0 + float(bone.local_shear_y))
		var local = Transform2D(
			Vector2(cos(angle_x), sin(angle_x)) * float(bone.local_scale_x),
			Vector2(cos(angle_y), sin(angle_y)) * float(bone.local_scale_y),
			Vector2(float(bone.local_x), float(bone.local_y)))
		if !str(bone.parent_name).empty():
			local = _authored_bone_transform(bone.parent_name, cache) * local
		cache[name] = local
	return cache[name]


func _apply_hand_grip_offsets(grips):
	var moved = []
	for name in grips:
		var grip = grips[name]
		var hand = _bone_transform(bones[grip[0]])
		var offset = hand.xform(grip[1]) - grip[2]
		var role = "hand_left" if grip[0] == "hand_l" else "hand_right"
		offset += hand.basis_xform(hand_grip_offsets.get(role, Vector2.ZERO))
		if offset.length_squared() <= 0.000001:
			continue
		var bone = bones[name]
		var position = _world_to_bone_parent(name, Vector2(bone.x, bone.y) + offset)
		_set_bone_world(name, position.x, position.y, bone.local_rotation,
			bone.local_scale_x, bone.local_scale_y, bone.local_shear_x, bone.local_shear_y)
		moved.append(name)
	if !moved.empty():
		_update_ik_descendants(moved)


func _tithand_take():
	for take in TITHAND_ANIMATIONS:
		if bool(animation_states.get(take, false)):
			return take
	return ""


# Apply after all hierarchy/IK passes so limb sliders cannot erase the offset.
# Spine's world Y points up. Moving the root once also moves lips2/lips3 and
# every closed/open/emotion mouth skinned to them, without changing the export.
func _apply_beastkin_mouth_offset():
	if !CATALOGUE.has_tag(str(selections.get("body", "")), "beastkin") or !bones.has("lips"):
		return
	var mouth = bones["lips"]
	mouth.y = float(mouth.y) + 5.0
	bones["lips"] = mouth
	_update_ik_descendants(["lips"])


# Every bone at its setup values and solved: the pose every solve starts from.  It
# reads nothing an animation moves - only the export, the rig's names and, through
# the basis compensation in `_set_bone_world`, the butt and shoulder sliders - so it
# is kept and worked out again only when one of those changes.  Solving it at the
# start of every pass was over 3 ms a frame.
func _setup_bones():
	var butt = float(proportions.get("butt", 1.0))
	var shoulders = float(proportions.get("shoulders", 1.0))
	if setup_pose_ready and setup_pose_butt == butt and setup_pose_shoulders == shoulders:
		return
	flat_chest_edge_weights.clear()
	bones.clear()
	post_ik_visual_scales.clear()
	applying_post_ik_visual_scales = false
	setup_pose_names = []
	var index = 0
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "bone_%d" % index)
		bones[name] = {"definition": definition, "index": index, "parent_name": definition.get("parent", "")}
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
		setup_pose_names.append(name)
		index += 1
	setup_pose = {}
	for name in setup_pose_names:
		setup_pose[name] = bones[name].duplicate()
	setup_pose_butt = butt
	setup_pose_shoulders = shoulders
	setup_pose_ready = true


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


func _apply_bone_modifiers(layer_factors = {}, layer_turns = {}, resolve = false):
	# Every active modifier contributes a multiplier and they compose, so no
	# modifier can silently discard another one acting on the same bone.
	var factors = MODIFIERS.bone_factors(proportions, height_tier, contract.CONTRACT_ID)
	var offsets = MODIFIERS.bone_offsets(proportions, contract.CONTRACT_ID)
	var world_offsets = MODIFIERS.bone_world_offsets(proportions, contract.CONTRACT_ID)
	# A part with no art - the shy glance - moves bones instead of drawing, and
	# adds to the face sliders rather than replacing them.  Read from where the
	# glide has got to rather than from the selections, so the eyes travel.
	for bone_name in pose_offsets.keys():
		var rig_name = MODIFIERS.rig_bone(bone_name, contract.CONTRACT_ID)
		if rig_name == "":
			continue
		offsets[rig_name] = offsets.get(rig_name, Vector2.ZERO) + pose_offsets[bone_name]
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
	for bone_name in layer_turns.keys():
		touched[bone_name] = true
	for bone_name in touched.keys():
		if !bones.has(bone_name):
			continue
		var bone = bones[bone_name]
		var factor = factors.get(bone_name, Vector2.ONE)
		var offset = offsets.get(bone_name, Vector2.ZERO)
		_set_bone_local(
			bone_name,
			float(bone.local_x) + offset.x, float(bone.local_y) + offset.y,
			float(bone.local_rotation) + float(layer_turns.get(bone_name, 0.0)),
			float(bone.local_scale_x) * factor.x,
			float(bone.local_scale_y) * factor.y,
			float(bone.local_shear_x), float(bone.local_shear_y)
		)
	# `resolve` is the timelines' re-derive, left to happen here along with this one.
	if resolve or !touched.empty():
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
	if height_tier != display_scale_tier:
		display_scale_tier = height_tier
		display_scale_value = DISPLAY_SCALE * float(MODIFIERS.display_scale(height_tier))
	return display_scale_value


# Bones a running animation keys, plus - and this is the part that is easy to
# miss - everything hanging off them.  A timeline moves a forearm; the hand is
# not keyed and so is never revisited, and it keeps the world transform it was
# given under the setup pose.  On the arm-swinging idles that left the wrist
# 52-74 px from the hand it belongs to.  The IK pass and the modifier pass
# already re-solve their descendants.  This one writes the keyed bones' own values
# only and leaves the re-derive of the whole skeleton to `_apply_bone_modifiers`,
# which does it once after its own writes.  Answers whether anything was sampled.
func _apply_active_bone_timelines():
	var sample = _sampled_bone_timelines()
	if sample.empty():
		return false
	for name in sample.keys():
		if !bones.has(name):
			continue
		var values = sample[name]
		_set_bone_local(
			name, values[0], values[1], values[2],
			values[3], values[4],
			values[5], values[6]
		)
	return true


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
	var target = _sample_current_bone_timelines()
	if pose_transition_elapsed >= POSE_TRANSITION_DURATION:
		return _emotion_bone_sample(target)
	var transition_key = "%s#%.6f" % [bone_sample_key, pose_transition_elapsed]
	if transition_key == pose_transition_sample_key:
		return _emotion_bone_sample(pose_transition_sample)
	pose_transition_sample_key = transition_key
	pose_transition_sample = {}
	var names = {}
	for name in pose_transition_from.keys():
		names[name] = true
	for name in target.keys():
		names[name] = true
	var amount = clamp(pose_transition_elapsed / POSE_TRANSITION_DURATION, 0.0, 1.0)
	# Smoothstep keeps both ends of the short transition from arriving with a
	# visible jerk while retaining the requested quarter-second duration.
	amount = amount * amount * (3.0 - 2.0 * amount)
	var tithand_active = !_tithand_take().empty()
	for name in names.keys():
		var setup = bone_setup_sample.get(name, [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0])
		var first = pose_transition_from.get(name, setup)
		var second = target.get(name, setup)
		# The newly displayed hands start in the authored pose instead of
		# sliding into view from their offstage setup position.
		if tithand_active and tithand_hand_bones.has(name):
			pose_transition_sample[name] = second
			continue
		pose_transition_sample[name] = [
			lerp(float(first[0]), float(second[0]), amount),
			lerp(float(first[1]), float(second[1]), amount),
			_lerp_degrees(float(first[2]), float(second[2]), amount),
			lerp(float(first[3]), float(second[3]), amount),
			lerp(float(first[4]), float(second[4]), amount),
			_lerp_degrees(float(first[5]), float(second[5]), amount),
			_lerp_degrees(float(first[6]), float(second[6]), amount),
		]
	return _emotion_bone_sample(pose_transition_sample)


func _emotion_bone_sample(target):
	if emotion_transition_elapsed >= EMOTION_TRANSITION_DURATION:
		return target
	var transition_key = "%s#%.6f#%.6f" % [
		bone_sample_key, pose_transition_elapsed, emotion_transition_elapsed
	]
	if transition_key == emotion_transition_sample_key:
		return emotion_transition_sample
	emotion_transition_sample_key = transition_key
	emotion_transition_sample = {}
	var names = {}
	for name in emotion_transition_from.keys():
		names[name] = true
	for name in target.keys():
		names[name] = true
	var amount = clamp(emotion_transition_elapsed / EMOTION_TRANSITION_DURATION, 0.0, 1.0)
	amount = amount * amount * (3.0 - 2.0 * amount)
	var eased = emotion_transition_bone_mask if emotion_transition_bone_mask != null else _emotion_eased_bones()
	for name in names.keys():
		# a bone no emotion keys is nobody's to ease: it is the pose's own, and
		# holding it back is what stalled the idle for the length of the fade
		if !eased.has(name):
			if target.has(name):
				emotion_transition_sample[name] = target[name]
			continue
		var setup = bone_setup_sample.get(name, [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0])
		var first = emotion_transition_from.get(name, setup)
		var second = target.get(name, setup)
		emotion_transition_sample[name] = [
			lerp(float(first[0]), float(second[0]), amount),
			lerp(float(first[1]), float(second[1]), amount),
			_lerp_degrees(float(first[2]), float(second[2]), amount),
			lerp(float(first[3]), float(second[3]), amount),
			lerp(float(first[4]), float(second[4]), amount),
			_lerp_degrees(float(first[5]), float(second[5]), amount),
			_lerp_degrees(float(first[6]), float(second[6]), amount),
		]
	return emotion_transition_sample


# Every bone any emotion of this rig keys, which is the whole of what an emotion
# crossfade has to ease.  Kept per rig beside the other skeleton walks and thrown
# away with them in `_load_source`.
func _emotion_eased_bones():
	if emotion_eased_bones != null:
		return emotion_eased_bones
	emotion_eased_bones = {}
	var animations = skeleton.get("animations", {})
	for animation_name in animations.keys():
		if !_is_emotion_animation(animation_name):
			continue
		for bone_name in _animation_data(animation_name).get("bones", {}).keys():
			emotion_eased_bones[bone_name] = true
	return emotion_eased_bones


func _lerp_degrees(first, second, amount):
	var difference = fposmod(second - first + 180.0, 360.0) - 180.0
	return first + difference * amount


func _sample_current_bone_timelines():
	var active = _ordered_active_animations()
	var key = ""
	for animation_name in active:
		key += "%s@%.6f|" % [animation_name, float(animation_times.get(animation_name, 0.0))]
	# An empty key is never a hit: `bone_sample_key = ""` is how callers throw the
	# sample away, and it is also the key of "nothing is running".  Taken as a hit,
	# the last animation to stop - a titjump with the idle off - stayed applied.
	if key != "" and key == bone_sample_key:
		return bone_sample
	bone_sample_key = key
	bone_sample = {}
	if key == "":
		return bone_sample
	for animation_name in active:
		var animation = _animation_data(animation_name)
		var bone_timelines = animation.get("bones", {})
		var time = float(animation_times.get(animation_name, 0.0))
		for keyed in _keyed_bones(animation_name, bone_timelines):
			var name = keyed[0]
			var x = keyed[1]
			var y = keyed[2]
			var rotation = keyed[3]
			var scale_x = keyed[4]
			var scale_y = keyed[5]
			var shear_x = keyed[6]
			var shear_y = keyed[7]
			var channels = keyed[8]
			if channels.has("translate"):
				var translation = _sample_timeline(channels.translate, time, ["x", "y"])
				x += float(translation.get("x", 0.0))
				y += float(translation.get("y", 0.0))
			if channels.has("rotate"):
				var turn = _sample_timeline(channels.rotate, time, ["value"])
				rotation += float(turn.get("value", 0.0))
			if channels.has("scale"):
				var scale = _sample_timeline(channels.scale, time, ["x", "y"], 1.0)
				scale_x *= float(scale.get("x", 1.0))
				scale_y *= float(scale.get("y", 1.0))
			if channels.has("shear"):
				var shear = _sample_timeline(channels.shear, time, ["x", "y"])
				shear_x += float(shear.get("x", 0.0))
				shear_y += float(shear.get("y", 0.0))
			# A bone two animations both key is written by the later one, which is
			# what the pass this replaced did as well.
			bone_sample[name] = [x, y, rotation, scale_x, scale_y, shear_x, shear_y]
	return bone_sample


# An animation's keyed bones in skeleton order, each as [name, its seven setup
# values, its timelines].  The sample above walked all 269 bones for them and read
# every one's setup values afresh on each frame.
func _keyed_bones(animation_name, bone_timelines):
	if keyed_bones_of.has(animation_name):
		return keyed_bones_of[animation_name]
	var result = []
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "")
		if !bone_timelines.has(name):
			continue
		result.append([
			name,
			float(definition.get("x", 0.0)),
			float(definition.get("y", 0.0)),
			float(definition.get("rotation", 0.0)),
			float(definition.get("scaleX", 1.0)),
			float(definition.get("scaleY", 1.0)),
			float(definition.get("shearX", 0.0)),
			float(definition.get("shearY", 0.0)),
			bone_timelines[name],
		])
	keyed_bones_of[animation_name] = result
	return result


func _sample_timeline(frames, time, fields, default_value = 0.0):
	var result = {}
	for field in fields:
		result[field] = default_value
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
		result[field] = _sample_curve_value(current, next, time, field, field_index, default_value)
	return result


# Spine 4.2 stores cubic control points as absolute time/value pairs. Translate
# timelines contain one group of four numbers per field, so X and Y can use
# different easing curves instead of sharing a linear percentage.
func _sample_curve_value(current, next, time, field, field_index, default_value = 0.0):
	var first_value = float(current.get(field, default_value))
	if next == null:
		return first_value
	var second_value = float(next.get(field, default_value))
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
		# `_cubic_bezier` written out, the same sum in the same order: fourteen calls a
		# sample on every keyed channel came to two and a half thousand calls a frame.
		var inverse = 1.0 - middle
		var sampled_time = inverse * inverse * inverse * start_time \
			+ 3.0 * inverse * inverse * middle * control_time_1 \
			+ 3.0 * inverse * middle * middle * control_time_2 \
			+ middle * middle * middle * end_time
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
	var parent_name = bone.parent_name
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
		if butt_compensated_children.get(name, "") == parent_name:
			var butt_factor = float(proportions.get("butt", 1.0))
			if butt_factor != 0.0:
				parent_b /= butt_factor
				parent_d /= butt_factor
		# Shoulder width should move the arm root with the end of the collarbone,
		# but must not scale or shear the arm basis.  Position above intentionally
		# keeps the widened parent; only the basis loses its local-X factor.
		if shoulder_compensated_children.get(name, "") == parent_name:
			var shoulder_factor = float(proportions.get("shoulders", 1.0))
			if shoulder_factor != 0.0:
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


# A bone's own values, with its world transform left to a re-derive of the skeleton.
# The timelines and the modifiers set many bones and then re-derive them all, so the
# world maths `_set_bone_world` did for each of them was thrown away.
func _set_bone_local(name, x, y, rotation, scale_x, scale_y, shear_x, shear_y):
	var bone = bones[name]
	bone["local_x"] = x
	bone["local_y"] = y
	bone["local_rotation"] = rotation
	bone["local_scale_x"] = scale_x
	bone["local_scale_y"] = scale_y
	bone["local_shear_x"] = shear_x
	bone["local_shear_y"] = shear_y


# The pairs `_set_bone_world` compensates, on this rig's names - see
# BUTT_SCALE_COMPENSATION_BONES and SHOULDER_WIDTH_BASIS_COMPENSATION.  A child the
# rig has no counterpart for is left out; a parent it has none for is kept as "",
# which no bone's parent is.
func _find_compensated_bones():
	butt_compensated_children = {}
	shoulder_compensated_children = {}
	var pelvis = MODIFIERS.rig_bone("spine1", contract.CONTRACT_ID)
	for authored_name in MODIFIERS.BUTT_SCALE_COMPENSATION_BONES:
		var child = MODIFIERS.rig_bone(authored_name, contract.CONTRACT_ID)
		if child != "":
			butt_compensated_children[child] = pelvis
	for child in MODIFIERS.SHOULDER_WIDTH_BASIS_COMPENSATION.keys():
		shoulder_compensated_children[child] = MODIFIERS.rig_bone(MODIFIERS.SHOULDER_WIDTH_BASIS_COMPENSATION[child], contract.CONTRACT_ID)


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
	for name in _descendants_below(constrained_names):
		_restore_bone_world(name)


# The bones `_update_ik_descendants` re-derives under the given ones, in the order it
# re-derives them.  Which they are depends on the skeleton alone, so the walk over
# all 269 bones is taken once per set of names instead of on every IK solve.
func _descendants_below(constrained_names):
	var key = PoolStringArray(constrained_names).join("|")
	if descendants_below.has(key):
		return descendants_below[key]
	var changed = {}
	for name in constrained_names:
		changed[name] = true
	var result = []
	for definition in skeleton.get("bones", []):
		var name = definition.get("name", "")
		if changed.has(name):
			continue
		var parent_name = definition.get("parent", "")
		if changed.has(parent_name):
			result.append(name)
			changed[name] = true
	descendants_below[key] = result
	return result


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
	# which bones, and in what order, depends on the skeleton alone: walked once per set of roots
	var key = PoolStringArray(roots).join("|")
	if !subtree_under.has(key):
		var changed = {}
		for name in roots:
			changed[name] = true
		var order = []
		for definition in skeleton.get("bones", []):
			var name = definition.get("name", "")
			if !bones.has(name):
				continue
			if !changed.has(name) and !changed.has(str(definition.get("parent", ""))):
				continue
			changed[name] = true
			order.append(name)
		subtree_under[key] = order
	var moved = {}
	for name in subtree_under[key]:
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
			if event.pressed and (_poke_ears(event.position) or _poke_tits(event.position)):
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
	for record in mesh_records + xray_records:
		if is_instance_valid(record.polygon):
			record.polygon.position = origin
	# The handles are projected through the same origin, so they move with it -
	# without this the foot handles of a freshly switched doll sit off-screen.
	_update_handle_buttons()
	_update_xray_view()


func _apply_view():
	if is_instance_valid(model_root):
		model_root.position = view_offset
		model_root.scale = Vector2.ONE * view_zoom
	_update_xray_view()
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
	# Poses, sex_side and emotions are independent animation channels. Each is
	# exclusive inside itself, so a dropdown describes it better than a row of
	# checkboxes that can appear to allow impossible combinations.
	_add_animation_select(box, "Poses", _pose_animations(), "pose", false)
	_add_animation_select(box, "sex_side", _sex_side_animations(), "sex_side", true)
	_add_animation_select(box, "Emotions", _emotion_animations(), "emotion", true)
	if skeleton.get("animations", {}).has(CUM_ANIMATION) and skeleton.get("animations", {}).has(CUM_FACE_ANIMATION):
		var cum_toggle = CheckButton.new()
		cum_toggle.text = "Cum"
		cum_toggle.pressed = cum_enabled
		cum_toggle.connect("toggled", self, "set_cum")
		box.add_child(cum_toggle)
		ui["cum"] = cum_toggle
		var clear_semen_button = Button.new()
		clear_semen_button.text = "Clear semen"
		clear_semen_button.connect("pressed", self, "clear_semen")
		box.add_child(clear_semen_button)
	# Small overlays such as `say` remain toggles: they run on top of both
	# channels and must not replace the selected pose.
	for animation_name in _sorted_animations():
		if animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION]:
			continue
		if animation_name in [BLINK_ANIMATION, TITJUMP_ANIMATION, EARJUMP_ANIMATION, TAILMOVE_ANIMATION]:
			continue
		if _is_emotion_animation(animation_name) or _poses_the_skeleton(animation_name):
			continue # the blink runs it on its own timer, see the toggle below
		_add_animation_toggle(box, ANIMATION_LABELS.get(animation_name, ""), animation_name)
	var blink_toggle = CheckButton.new()
	blink_toggle.text = _text("DOLL2_PREVIEW_BLINK")
	blink_toggle.pressed = blink_enabled
	blink_toggle.connect("toggled", self, "set_blinking")
	box.add_child(blink_toggle)
	var tail_toggle = CheckButton.new()
	tail_toggle.text = "Tail animation"
	tail_toggle.pressed = tail_animation_enabled
	tail_toggle.disabled = !animation_states.has(TAILMOVE_ANIMATION)
	tail_toggle.connect("toggled", self, "set_tail_animation")
	box.add_child(tail_toggle)
	ui["tail_animation"] = tail_toggle
	var xray_toggle = CheckButton.new()
	xray_toggle.text = "X-ray"
	xray_toggle.pressed = xray_enabled
	xray_toggle.disabled = !skin_map.get(SKIN_NAME, {}).get("attachments", {}).has("XRAY")
	xray_toggle.connect("toggled", self, "set_xray")
	box.add_child(xray_toggle)
	ui["xray"] = xray_toggle
	var handles_toggle = CheckButton.new()
	handles_toggle.text = _text("DOLL2_PREVIEW_SHOW_HANDLES")
	handles_toggle.pressed = handles_visible
	handles_toggle.connect("toggled", self, "_on_handles_toggled")
	box.add_child(handles_toggle)
	_add_anatomy_options(box)
	_add_preset_select(box)
	_add_undress_row(box)
	for group_id in CATALOGUE.group_order():
		var group = CATALOGUE.group(group_id)
		if group.parts.empty():
			continue
		var channels = CATALOGUE.channels_for_group(group_id).duplicate()
		for channel in channels.duplicate():
			if str(channel).begins_with("anatomy_"):
				channels.erase(channel)
		_add_select(box, group.label, group_id, group.parts, group.optional, channels)
	for axis in _sorted_axes():
		var definition = CATALOGUE.axes()[axis]
		# an axis the body decides is not the player's to pick
		if bool(definition.get("hidden", false)):
			continue
		_add_axis_select(box, definition.label, axis, definition.values)
		if str(axis) == "many_tits":
			_add_many_tits_toggle(box)
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


func _add_anatomy_options(parent):
	for slot_name in ANATOMY_ALTERNATIVES.keys():
		var variants = _anatomy_variants(slot_name)
		if variants.empty():
			continue
		var row = HBoxContainer.new()
		var label = Label.new()
		label.text = slot_name
		row.add_child(label)
		parent.add_child(row)
		var select = OptionButton.new()
		for variant in variants.keys():
			select.add_item(variant)
			select.set_item_metadata(select.get_item_count() - 1, variant)
		select.select(variants.keys().find(_selected_anatomy_variant(slot_name)))
		select.connect("item_selected", self, "_on_anatomy_alternative_selected", [slot_name])
		row.add_child(select)
		ui["anatomy_alternative/" + slot_name] = select
		# Each slot and each variant keeps its own palette when switching back.
		for variant in variants.keys():
			var colours = HBoxContainer.new()
			row.add_child(colours)
			ui["anatomy_colours/%s/%s" % [slot_name, variant]] = colours
			_add_channel_picker(colours, _anatomy_colour_channel(slot_name, variant))
		_refresh_anatomy_colours(slot_name)


func _anatomy_variants(slot_name):
	var attachments = skin_map.get(SKIN_NAME, {}).get("attachments", {}).get(slot_name, {})
	var result = {}
	if ANATOMY_FURRY_ONLY.has(slot_name):
		if attachments.has(ANATOMY_FURRY_ONLY[slot_name]):
			result["penis"] = ANATOMY_FURRY_ONLY[slot_name]
	elif !ANATOMY_ALTERNATIVES.has(slot_name) or !attachments.has(ANATOMY_ALTERNATIVES[slot_name]):
		return result
	else:
		var original = "00_body_nude_female/" + str(slot_name)
		if attachments.has(original):
			result["penis"] = original
		result["falos"] = ANATOMY_ALTERNATIVES[slot_name]
	var names = attachments.keys()
	names.sort()
	for name in names:
		if str(name).ends_with("_f"):
			result[str(name).get_file()] = name
	return result


func _selected_anatomy_variant(slot_name):
	var value = anatomy_alternatives.get(slot_name, "penis")
	# Accept the former two-way state when an existing viewer is reused.
	if typeof(value) == TYPE_BOOL:
		value = "falos" if value else "penis"
	var variants = _anatomy_variants(slot_name)
	return str(value) if variants.has(str(value)) else "penis"


func _anatomy_colour_channel(slot_name, variant):
	var paint = "penis_f" if str(variant).ends_with("_f") else str(variant)
	return "anatomy_%s/%s" % [paint, slot_name]


func _refresh_anatomy_colours(slot_name):
	var selected = _selected_anatomy_variant(slot_name)
	for variant in _anatomy_variants(slot_name).keys():
		var key = "anatomy_colours/%s/%s" % [slot_name, variant]
		if ui.has(key):
			ui[key].visible = selected == variant


func _on_anatomy_alternative_selected(index, slot_name):
	if !ANATOMY_ALTERNATIVES.has(slot_name):
		return
	var select = ui.get("anatomy_alternative/" + slot_name)
	if select == null or index < 0 or index >= select.get_item_count():
		return
	anatomy_alternatives[slot_name] = str(select.get_item_metadata(index))
	_refresh_anatomy_colours(slot_name)
	_rebuild_model()


func _sorted_axes():
	var result = CATALOGUE.axes().keys()
	result.sort()
	return result


# Does this animation move bones, or is it only an overlay on top of a pose?
func _poses_the_skeleton(animation_name):
	return !_animation_data(animation_name).get("bones", {}).empty()


# All animation consumers see the same scoped face overlay: filtering only
# attachments would still let lower-level colour/deform passes change the mouth.
func _animation_data(animation_name):
	var animation = skeleton.get("animations", {}).get(animation_name, {})
	if animation_name != CUM_FACE_ANIMATION:
		return animation
	if cum_face_overlay == null:
		cum_face_overlay = OVERLAY_RULES.cum_face(animation)
	return cum_face_overlay


func _is_emotion_animation(animation_name):
	return str(animation_name).begins_with(EMOTION_PREFIX)


func _is_sex_side_animation(animation_name):
	return animation_name in TITHAND_ANIMATIONS


func _sex_side_animations():
	var result = []
	for animation_name in TITHAND_ANIMATIONS:
		if !skeleton.get("animations", {}).get(animation_name, {}).empty():
			result.append(animation_name)
	return result


func _partner_hands_active():
	return !_tithand_take().empty() or _partner_hand_pose_active()


func _partner_hand_pose_active():
	for animation_name in animation_states:
		if animation_states[animation_name] and _is_partner_hand_pose(animation_name):
			return true
	return false


func _is_partner_hand_pose(animation_name):
	var base = composed_info.get(animation_name, {}).get("owners", {}).get("torso", animation_name)
	return base in PARTNER_HAND_POSES


func _emotion_animations():
	var result = []
	for animation_name in _sorted_animations():
		if _is_emotion_animation(animation_name) and animation_name != CUM_FACE_ANIMATION:
			result.append(animation_name)
	return result


func _pose_animations():
	var result = []
	for animation_name in _sorted_animations():
		if animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION, TITJUMP_ANIMATION, EARJUMP_ANIMATION, TAILMOVE_ANIMATION]:
			continue
		if _is_sex_side_animation(animation_name):
			continue
		if !_is_emotion_animation(animation_name) and _poses_the_skeleton(animation_name):
			result.append(animation_name)
	return result


# Stable composition order: regular poses and overlays first, emotion last.
# This makes every authored emotion channel authoritative wherever both takes
# address the same bone, slot, attachment, deform or draw-order key.
func _ordered_active_animations():
	var ordinary = []
	var emotions = []
	var side = []
	for animation_name in animation_states.keys():
		if animation_name in [CUM_ANIMATION, CUM_FACE_ANIMATION]:
			continue # reserved for the independent Cum channel
		if !animation_states[animation_name]:
			continue
		if _is_emotion_animation(animation_name):
			emotions.append(animation_name)
		elif _is_sex_side_animation(animation_name):
			side.append(animation_name)
		else:
			ordinary.append(animation_name)
	ordinary.sort()
	emotions.sort()
	# Anatomy takes key the mouth and face, so `say` and `eyesmove` must not override them whatever the names sort to.
	for animation_name in ordinary.duplicate():
		if _is_anatomy_animation(animation_name):
			ordinary.erase(animation_name)
			ordinary.append(animation_name)
	# Independent sex_side channel owns its authored keys over the base pose.
	# Emotions and the scoped Cum overlay retain their existing higher priority.
	side.sort()
	ordinary.append_array(side)
	# Authored reactions are overlays on the pose. Apply them after the idle so
	# its keys cannot overwrite a moving ear or tail; emotion remains the final
	# channel wherever it deliberately addresses the same control.
	for overlay in [TAILMOVE_ANIMATION, EARJUMP_ANIMATION, TITJUMP_ANIMATION]:
		if overlay in ordinary:
			ordinary.erase(overlay)
			ordinary.append(overlay)
	ordinary.append_array(emotions)
	if cum_enabled:
		ordinary.append(CUM_ANIMATION)
		ordinary.append(CUM_FACE_ANIMATION)
	return ordinary


func _cum_visible_slots():
	var result = {}
	if !cum_enabled or cum_semen_cleared:
		return result
	var finished = _cum_has_finished()
	for animation_name in _ordered_active_animations():
		if !_poses_the_skeleton(animation_name) or _is_emotion_animation(animation_name):
			continue
		if animation_name in [TITJUMP_ANIMATION, EARJUMP_ANIMATION, TAILMOVE_ANIMATION]:
			continue
		var pose = composed_info.get(animation_name, {})
		var standing_anal = "anal" in pose.get("slots", {}).values()
		for take in pose.get("takes", [animation_name]):
			var effect_take = "anal_missionary" if take == "sex_standing" and standing_anal else take
			if !cum_visibility_by_animation.has(effect_take):
				cum_visibility_by_animation[effect_take] = OVERLAY_RULES.cum_slots(skeleton, effect_take)
			for slot_name in cum_visibility_by_animation[effect_take].keys():
				result[slot_name] = true
			if finished:
				for slot_name in OVERLAY_RULES.cum_finish_slots(effect_take):
					result[slot_name] = true
	# On the held frame, render the saved missionary cut rather than issuing
	# the original emitter again. It then carries over through the usual residue path.
	if bool(cum_pose_playback.get(CUM_ANIMATION, {}).get("missionary_residue", false)):
		result.erase("semen_vhole")
	return result


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


func _add_animation_select(parent, label_text, animation_names, channel, allow_none):
	if animation_names.empty():
		return
	var select = _make_select(parent, label_text)
	if allow_none:
		select.add_item(_text("DOLL2_PREVIEW_NONE"))
		select.set_item_metadata(0, "")
	var active = ""
	for animation_name in animation_names:
		var item_label = str(animation_name)
		if _is_emotion_animation(animation_name):
			item_label = item_label.substr(EMOTION_PREFIX.length()).replace("_", " ").capitalize()
		elif ANIMATION_LABELS.has(animation_name):
			item_label = _text(ANIMATION_LABELS[animation_name])
		select.add_item(item_label)
		select.set_item_metadata(select.get_item_count() - 1, animation_name)
		if bool(animation_states.get(animation_name, false)):
			active = animation_name
	_select_metadata(select, active)
	select.connect("item_selected", self, "_on_animation_selected", [channel, select])
	ui["animation_select_" + channel] = select


func _on_animation_selected(_item_index, channel, select):
	var animation_names = _emotion_animations() if channel == "emotion" else _pose_animations()
	if channel == "sex_side":
		animation_names = _sex_side_animations()
	var selected = str(select.get_item_metadata(select.selected))
	var active = ""
	for animation_name in animation_names:
		if bool(animation_states.get(animation_name, false)):
			active = animation_name
			break
	if selected == active:
		return
	if selected.empty():
		if !active.empty():
			_on_animation_toggled(false, active)
	else:
		_on_animation_toggled(true, selected)


# A pose is exclusive inside its channel: two of them are two sets of keys on the same
# bones, and the doll ends up in whichever the loop reached last rather than in
# either.  Overlays are not - `eyesmove` only swaps attachments and has no bone
# timeline of its own, so it rides along with any pose.
func _on_animation_toggled(enabled, animation_name):
	var previous_tithand = _tithand_take()
	var is_emotion = _is_emotion_animation(animation_name)
	var is_side = _is_sex_side_animation(animation_name)
	var transitions_pose = _poses_the_skeleton(animation_name) and !is_emotion
	if _cum_controls_pose(animation_name) or is_side:
		_remember_visible_semen()
	var previous_pose = _sampled_bone_timelines().duplicate(true) if transitions_pose else {}
	var previous_emotion_pose = _sampled_bone_timelines().duplicate(true) if is_emotion else {}
	var previous_emotion_colours = _capture_animated_slot_colours() if is_emotion else {}
	var previous_emotion_deforms = _capture_animated_attachment_deforms() if is_emotion else {}
	var previous_setup_slots = _active_emotion_setup_slots() if is_emotion else []
	if !enabled:
		pose_start_ramps.erase(animation_name)
	elif !bool(animation_states.get(animation_name, false)) and _pose_has_partner_attachment(animation_name):
		pose_start_ramps[animation_name] = 0.0
	animation_states[animation_name] = enabled
	if cum_enabled and _cum_controls_pose(animation_name):
		cum_pose_playback.clear()
	elif is_side:
		cum_pose_playback.erase(animation_name)
	if !enabled:
		animation_times[animation_name] = 0.0
	elif is_emotion or _poses_the_skeleton(animation_name):
		for other_name in animation_states.keys():
			if other_name == animation_name or !animation_states[other_name]:
				continue
			if is_emotion != _is_emotion_animation(other_name):
				continue
			if is_side != _is_sex_side_animation(other_name):
				continue
			if !is_emotion and !_poses_the_skeleton(other_name):
				continue
			animation_states[other_name] = false
			animation_times[other_name] = 0.0
			pose_start_ramps.erase(other_name)
			cum_pose_playback.erase(other_name)
			var toggle = ui.get("animation_" + other_name, null)
			if is_instance_valid(toggle):
				toggle.set_block_signals(true)
				toggle.pressed = false
				toggle.set_block_signals(false)
	if is_emotion:
		_begin_emotion_transition(previous_emotion_pose, previous_emotion_colours, previous_emotion_deforms, previous_setup_slots)
	elif transitions_pose:
		bone_sample_key = ""
		pose_transition_from = previous_pose
		pose_transition_elapsed = 0.0
		pose_transition_sample = {}
		pose_transition_sample_key = ""
	# An authored pose brings its own hands and its own draw order, so turning one
	# on or off is a rebuild, not a re-pose.
	if previous_tithand != _tithand_take():
		_solve_pose()
	_rebuild_model()


func _begin_emotion_transition(previous_pose, previous_colours, previous_deforms, previous_setup_slots, cum_only = false):
	bone_sample_key = ""
	emotion_transition_from = previous_pose
	emotion_colour_from = previous_colours
	emotion_deform_from = previous_deforms
	emotion_transition_bone_mask = null
	if cum_only:
		# A Cum toggle must not even crossfade unrelated mouth channels: they
		# continue sampling the live pose throughout the eyes/blush transition.
		emotion_transition_bone_mask = _animation_data(CUM_FACE_ANIMATION).get("bones", {})
		emotion_colour_from = {}
		if previous_colours.has("blush"):
			emotion_colour_from["blush"] = previous_colours.blush
		emotion_deform_from = {}
		for key in previous_deforms.keys():
			var fields = str(key).split("|")
			if fields.size() > 1 and fields[1] == "blush":
				emotion_deform_from[key] = previous_deforms[key]
	emotion_setup_slots_from = previous_setup_slots
	emotion_setup_slots_to = _active_emotion_setup_slots()
	emotion_transition_elapsed = 0.0
	emotion_transition_sample = {}
	emotion_transition_sample_key = ""


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


# Under the extra-rows picker: the rows as nipples alone, or grown into breasts.
func _add_many_tits_toggle(parent):
	var toggle = CheckButton.new()
	toggle.text = _text("DOLL2_PREVIEW_MANY_TITS_DEVELOPED")
	toggle.pressed = many_tits_developed
	toggle.connect("toggled", self, "_on_many_tits_developed_toggled")
	parent.add_child(toggle)
	ui["many_tits_developed"] = toggle


func _on_many_tits_developed_toggled(pressed):
	many_tits_developed = bool(pressed)
	_rebuild_model()


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
	# a coat brings its own nipples and puts the mouth in its fur
	_follow_rule_with_nipples()
	_follow_coat_with_mouth()


func _on_coverage_colour_changed(colour, index):
	while coverage_colors.size() <= index:
		coverage_colors.append(Color(1, 1, 1))
	coverage_colors[index] = colour
	_apply_coverage_to_meshes()
	# the mouth follows its own layer being repainted
	if index == COVERAGE.mouth_index(coverage_id):
		_follow_coat_with_mouth()


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
	for record in mesh_records + xray_records:
		if !is_instance_valid(record.polygon) or record.polygon.material == null:
			continue
		_apply_coverage(record.polygon.material, record.get("channel", ""), record.slot.get("name", ""))


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
		# near-black ink takes a pick as it is - see `flat` on the tattoo channel
		material.set_shader_param("paint_flat", 1.0 if bool(channels[channel_id].get("flat", false)) else 0.0)
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
	var swatches = COLORS.swatches("skin" if str(channel_id).begins_with("anatomy_penis") else channel_id)
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
		nipples_follow_rule = false
	if channel_id == "lips" and !secondary:
		lips_follow_rule = false
	_apply_channel_colour(channel_id)
	if channel_id == "skin" and !secondary:
		_follow_rule_with_nipples()


# In the game the nipples are read off the skin's own shade, and a furred chest
# wears its coat's nipples instead; the preview used to leave them at the artist's
# pink, which is why a light skin came out with one pair here and another one in
# play.
func _follow_rule_with_nipples():
	if !nipples_follow_rule or !color_values.has("nipples"):
		return
	var coat = COVERAGE.nipple_colour(coverage_id) if _coverage_available() else null
	color_values["nipples"] = coat if coat != null else COLORS.nipples_from_colour(color_values.get("skin", Color(1, 1, 1)))
	_apply_channel_colour("nipples")
	if ui.has("color/nipples"):
		ui["color/nipples"].color = color_values["nipples"]


# A coat's mouth is a darker shade of the fur it sits in, as the game paints it -
# see ch_stats.get_body_color_lips().  With no coat on, the lips go back to the
# art's own colour.
func _follow_coat_with_mouth():
	if !lips_follow_rule or !color_values.has("lips"):
		return
	var index = COVERAGE.mouth_index(coverage_id)
	var lips = Color(1, 1, 1)
	if _coverage_available() and index >= 0 and index < coverage_colors.size():
		lips = Color(COLORS.lips_code_for_fur("#" + coverage_colors[index].to_html(false)))
	color_values["lips"] = lips
	_apply_channel_colour("lips")
	if ui.has("color/lips"):
		ui["color/lips"].color = lips


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
		# Alternatives are outside wardrobe composition. Keep the clothing
		# shader's three hue-zone controls available for their own palette.
		if str(channel_id).begins_with("anatomy_falos/"):
			zones = range(CATALOGUE.zone_hues().size())
		for i in range(CATALOGUE.zone_hues().size()):
			var key = "color/%s/zone%d" % [channel_id, i]
			if ui.has(key):
				ui[key].visible = i in zones


# skin_alternate channels take the body's colour too: the split is only for fur masks.
const CHANNEL_MIRRORS = {"skin": "skin_alternate"}


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
	var mirror = str(CHANNEL_MIRRORS.get(channel_id, ""))
	if mirror != "" and channel_materials.has(mirror):
		color_values[mirror] = color_values[channel_id]
		if color_values_secondary.has(channel_id):
			color_values_secondary[mirror] = color_values_secondary[channel_id]
		else:
			color_values_secondary.erase(mirror)
		_apply_channel_colour(mirror)


# A mesh's own material: the channel's colours plus the map from atlas UV back to
# the art canvas, which is what lets a full-body mask find this mesh.
func _mesh_material(channel_id, region, page_size, slot_name = ""):
	var template = channel_materials.get(channel_id)
	if template == null:
		return null
	var material = template.duplicate()
	var map = _canvas_map(region, page_size)
	material.set_shader_param("canvas_row0", map[0])
	material.set_shader_param("canvas_row1", map[1])
	_apply_coverage(material, channel_id, slot_name)
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


func _apply_coverage(material, channel_id, slot_name = ""):
	if material == null:
		return
	material.set_shader_param("coverage_solid_on", 0.0)
	var channel = CATALOGUE.color_channels().get(channel_id, {})
	var alternate = 0
	if channel.get("coverage_alternate", false):
		alternate = 1
	if channel.get("coverage_alternate_2", false):
		alternate = 2
	var layers = COVERAGE.layers(coverage_id, alternate)
	if coverage_id.empty() or layers.empty() or !channel.get("coverage", false) or !_coverage_available():
		material.set_shader_param("coverage_count", 0)
		return
	material.set_shader_param("coverage_count", min(layers.size(), COVERAGE.MAX_LAYERS))
	# The base, when the pattern has one, is the first colour of the row.
	if COVERAGE.has_base(coverage_id):
		var base = coverage_colors[0] if coverage_colors.size() > 0 else Color(1, 1, 1)
		material.set_shader_param("coverage_base", base)
		material.set_shader_param("coverage_base_on", 0.0 if _is_neutral(base) else 1.0)
	else:
		material.set_shader_param("coverage_base_on", 0.0)
	for i in range(min(layers.size(), COVERAGE.MAX_LAYERS)):
		material.set_shader_param("coverage_mask%d" % (i + 1), _coverage_texture(COVERAGE.mask_path(coverage_id, i, alternate)))
		var index = COVERAGE.colour_index(coverage_id, i, alternate)
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
	for record in mesh_records + xray_records:
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
	# Keep the controls for individual mesh layers together.
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
	if key == "freckles_alpha":
		_apply_freckles_alpha()
		return
	# Bone scales feed the solver, so the pose has to be worked out again.
	_update_animated_pose()
	if key == "breast_scale":
		play_titjump()


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
		# a body that cannot wear the coat gives its nipples and mouth back to their rule
		_follow_rule_with_nipples()
		_follow_coat_with_mouth()
	_refresh_all_bindings()
	_refresh_zone_pickers()
	# Layer poses depend on the selected cut as well as the slider value.  Re-solve
	# before rebuilding so leaving the two fringe cuts cannot retain their
	# second scale axis.
	if group_id == "hair":
		_solve_pose()
	# a look picked here is watched being made, so the eyes travel to it
	glide_pose_offsets = true
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
	play_titjump()
	return true


func _poke_ears(screen_point):
	var box = _slot_bounds(PUSH.PART_SLOTS)
	if box.size.y <= 0.0:
		return false
	if !box.has_point(_to_doll_space(to_local(screen_point))):
		return false
	play_earjump()
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
		play_titjump()


func _on_preset_selected(_item_index, select):
	var preset_id = str(select.get_item_metadata(select.selected))
	if preset_id.empty():
		return
	selections = CATALOGUE.apply_preset(selections, preset_id)
	# Match the race-driven leg selection used by Doll2View in the game.
	if axis_values.has("legs"):
		axis_values["legs"] = "orc" if preset_id in ["orc", "goblin"] else "default"
		_select_ui_value("axis/legs", axis_values["legs"])
	_follow_body_tag()
	for group_id in selections.keys():
		_select_ui_value(group_id, selections[group_id])
	_solve_pose()
	_rebuild_model()


func _select_ui_value(key, value):
	if !ui.has(key):
		return
	_select_metadata(ui[key], value)


func _rebuild_model():
	if !skeleton:
		return
	_sync_pose_offsets()
	var authored_animation_attachments = _animation_attachments()
	animation_signature = _animation_signature().hash()
	animation_attachment_signature = authored_animation_attachments.hash()
	var worn = _worn_selections(_shows_posed_genitals(authored_animation_attachments))
	part_hidden_slots = CATALOGUE.hidden_by_parts(worn)
	composed = CATALOGUE.compose(worn, axis_values, hidden_slots)
	_apply_say_lips(worn)
	animation_attachments = _match_animated_hands(authored_animation_attachments, worn)
	animation_attachments = _match_animated_body(animation_attachments)
	composed_textures = CATALOGUE.compose_textures(worn)
	composed_unpainted = CATALOGUE.unpainted_slots(worn)
	# A stripped character keeps the pieces of the set that are not there for
	# modesty - the stockings stay when the rest of the underwear goes.
	for slot_name in hidden_slots:
		composed.erase(slot_name)
		composed_textures.erase(slot_name)
	# The pregnancy overlays use the pregnancy axis, so they cannot infer whether
	# the character actually has extra rows. Keep all four related slots tied to
	# the many-tits picker, then choose nipples alone or the developed breast mesh.
	var has_many_tits = str(axis_values.get("many_tits", "none")) != "none"
	if !has_many_tits:
		for slot_name in [
			"breasts_beastkin_many", "beastkin_torso_many_nipples",
			"breasts_beastkin_pregnancy", "beastkin_pregnancy_nipple",
		]:
			composed.erase(slot_name)
			composed_textures.erase(slot_name)
	elif !many_tits_developed:
		composed.erase("breasts_beastkin_many")
		composed_textures.erase("breasts_beastkin_many")
		composed.erase("breasts_beastkin_pregnancy")
		composed_textures.erase("breasts_beastkin_pregnancy")
	elif chest_is_flat():
		# Only the ordinary developed mesh repeats the top pair and therefore sits
		# incorrectly on a flat chest. The pregnant overlay has its own authored
		# mid/big geometry and remains valid.
		composed.erase("breasts_beastkin_many")
		composed_textures.erase("breasts_beastkin_many")
	if model_root != null:
		model_root.hide()
		model_root.queue_free()
	mesh_records.clear()
	gradient_bounds.clear()
	model_root = Node2D.new()
	model_root.name = "SpineModel"
	add_child(model_root)
	_bake_bone_hierarchy()
	rendered_meshes = 0
	var rows = {}
	var clipping = {}
	for slot in _draw_ordered_slots():
		var attachment = _resolve_attachment(slot)
		if attachment.get("type", "") == "clipping":
			# Spine does not nest masks. An end equal to the start slot means
			# clip through the rest of the draw order, not an empty interval.
			if clipping.empty():
				clipping = {"slot": slot, "attachment": attachment}
			continue
		if !attachment.empty():
			_add_attachment(slot, attachment, rows, clipping)
		# The end slot is inclusive, even when it has no visible attachment.
		if !clipping.empty() and str(slot.name) == str(clipping.attachment.get("end", "")):
			clipping = {}
	_bind_vaginal_opening_clip()
	_rebuild_xray(rows)
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


# The legs-up takes key the rear mesh. The standing take exposes the lower
# body with the ordinary pelvis, including when composed with other takes.
func _shows_posed_genitals(authored_attachments):
	if posed_genitals.empty():
		return false
	if !str(authored_attachments.get("ass", "")).empty():
		return true
	for animation_name in animation_states:
		if !animation_states[animation_name]:
			continue
		var owners = composed_info.get(animation_name, {}).get("owners", {})
		if owners.get("lower", animation_name) == "sex_standing":
			return true
	return false


# What the doll actually has on, once the undress buttons have had their say.
# The dropdowns go on showing what was picked - stripping a character is not the
# same as choosing nothing - so the level is applied on the way to the model.
func _worn_selections(show_posed_genitals):
	var level = GEAR.normalise(undress_level)
	if level == GEAR.DRESSED and !show_posed_genitals:
		return selections
	var result = selections.duplicate()
	if show_posed_genitals:
		result["genitals"] = posed_genitals
	match level:
		GEAR.NAKED:
			for group_id in GEAR.WORN_GROUPS:
				result[group_id] = ""
		GEAR.UNDERWEAR:
			result["outfit"] = GEAR.default_underwear(doll_id)
		GEAR.BARE:
			# The selected cut stays on, with its covering slots hidden.
			result["weapon_belt"] = ""
			result["weapon_back"] = ""
	return result


func _is_anatomy_animation(animation_name):
	return animation_name in ANATOMY_ANIMATIONS or str(animation_name).begins_with(COMPOSED_PREFIX)


func _anatomy_animation_active():
	if doll_id != "female":
		return false
	for animation_name in animation_states.keys():
		if _is_anatomy_animation(animation_name) and bool(animation_states[animation_name]):
			return true
	return false


func _ass_animation_active():
	if doll_id != "female":
		return false
	for animation_name in animation_states:
		if animation_states[animation_name]:
			var lower_take = composed_info.get(animation_name, {}).get("owners", {}).get("lower", animation_name)
			if lower_take in ASS_ANIMATIONS:
				return true
	return false


# Registers the pose a recipe describes (see doll2_pose_composer.gd) and returns
# its animation name, or "" when this rig has no such takes.
func compose_pose(recipe):
	if skeleton.empty():
		return ""
	var name = COMPOSED_PREFIX + str(hash(var2str(recipe)))
	var animations = skeleton.get("animations", {})
	if composed_info.has(name) and animations.has(name):
		return name
	if pose_composer == null:
		pose_composer = COMPOSER.new(skeleton)
	var built = pose_composer.compose(recipe)
	if built == null:
		return ""
	animations[name] = built.animation
	animation_durations[name] = built.duration
	composed_info[name] = built
	return name


# Plays a pose in place of whatever pose was running; overlays carry on.
func play_pose(animation_name):
	if !skeleton.get("animations", {}).has(animation_name) or bool(animation_states.get(animation_name, false)):
		return
	animation_times[animation_name] = 0.0
	_on_animation_toggled(true, animation_name)


func set_chest_touch(enabled):
	if enabled:
		play_pose("tithand2")
	else:
		var active = _tithand_take()
		if !active.empty():
			_on_animation_toggled(false, active)


func stop_poses(include_side = false):
	var stopped = false
	for animation_name in animation_states.keys():
		if !animation_states[animation_name]:
			continue
		if str(animation_name).begins_with(COMPOSED_PREFIX) or (include_side and _is_sex_side_animation(animation_name)):
			animation_states[animation_name] = false
			animation_times[animation_name] = 0.0
			pose_start_ramps.erase(animation_name)
			stopped = true
	return stopped


# How each partner penis is drawn: slot -> {kind = "penis" | "falos" | "furry",
# colour = Color or null}.  A slot left out goes back to the plain art in its own
# colour.  True when an attachment changed, which needs a rebuild; a colour does not.
func set_partner_penises(styles):
	var changed = false
	for slot_name in ANATOMY_ALTERNATIVES.keys() + ANATOMY_FURRY_ONLY.keys():
		var style = styles.get(slot_name, {})
		var variants = _anatomy_variants(slot_name)
		var wanted = "penis"
		if str(style.get("kind", "")) == "falos" and variants.has("falos"):
			wanted = "falos"
		elif str(style.get("kind", "")) == "furry":
			for key in variants.keys():
				if str(key).ends_with("_f"):
					wanted = key
		if _selected_anatomy_variant(slot_name) != wanted:
			changed = true
		anatomy_alternatives[slot_name] = wanted
		var channel = _anatomy_colour_channel(slot_name, "penis")
		if color_values.has(channel):
			if !partner_colour_defaults.has(channel):
				partner_colour_defaults[channel] = color_values[channel]
			var colour = style.get("colour", null)
			color_values[channel] = colour if colour != null else partner_colour_defaults[channel]
			_apply_channel_colour(channel)
	return changed


# Use the selected body's counterpart, including attachment names that do not
# contain a beastkin suffix. The catalogue routes them by their source folder.
func _match_animated_body(authored):
	if !_anatomy_animation_active():
		return authored
	var result = authored.duplicate()
	for slot_name in ANATOMY_SLOTS:
		if !result.has(slot_name) or str(result[slot_name]).empty():
			continue
		if slot_name in SHARED_ANATOMY_SLOTS:
			continue
		result[slot_name] = str(composed.get(slot_name, ""))
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


# A flat chest draws no breasts, so the nipples a piercing goes through are the
# torso's own, drawn under the torso's clothing.  The piercing goes down there
# with them: at its export place above the breasts it would sit on top of a top
# the nipples are under, and clear of the sheer one they are seen through.
const FLAT_CHEST_DRAW_ORDER_FIXES = [{"slot": "piercing_nipple_1_0", "before": "equip_torso"}]

# A belly that size pushes what hangs under it forward instead of hiding it.
const PREGNANT_DRAW_ORDER_FIXES = [
	{"slot": "dick", "after": "pregnancy_belly"},
	{"slot": "testicle", "after": "pregnancy_belly"},
]


# The order to draw in: the catalogue's, unless a running animation reorders the
# slots itself.  An authored pose does that - the doll folds its arms in front of
# the body in `idle2` and behind it everywhere else, which is a draw order change
# and nothing else.  A flat chest then moves the nipple piercing in either.
func _current_draw_order():
	var animated = _animation_draw_order()
	var order = animated if !animated.empty() else CATALOGUE.draw_order()
	order = _apply_selected_ear_draw_order(order.duplicate())
	if chest_is_flat():
		# on a copy: the catalogue's order is the one every doll on the rig reads
		order = _apply_draw_order_fixes(order.duplicate(), FLAT_CHEST_DRAW_ORDER_FIXES)
	if composed.has("pregnancy_belly"):
		for fix in PREGNANT_DRAW_ORDER_FIXES:
			if order.find(fix.slot) < order.find(fix.after):
				order = _apply_draw_order_fixes(order, [fix])
	if !posed_genitals.empty() and composed.has("dick") and str(selections.get("genitals", "")).empty():
		var covering_slot = "equip_pregnancy_low" if composed.has("equip_pregnancy_low") else "equip_pelvis"
		if order.find("dick") < order.find(covering_slot):
			order = _apply_draw_order_fixes(order, [{"slot": "dick", "after": covering_slot}])
	if !_tithand_take().empty() and _front_handjob_active() and order.has("semen_pm2"):
		for slot_name in TITHAND_DRAW_ORDER:
			order.erase(slot_name)
		var insertion = order.find("semen_pm2") + 1
		for slot_name in TITHAND_DRAW_ORDER:
			order.insert(insertion, slot_name)
			insertion += 1
	if _has_animal_lower_body():
		order = _apply_animal_back_draw_order(order)
	return order


func _apply_animal_back_draw_order(order):
	var lower = "animal_body"
	if composed.has("animal_frontbody") and order.has("animal_frontbody"):
		# The spider's extra lower-body layer also belongs behind the cape/hair.
		_apply_draw_order_fixes(order, [{"slot": "animal_frontbody", "after": lower}])
		lower = "animal_frontbody"
	var rear_slots = ["equip_back"]
	var hair = str(animation_attachments.get(HAIR_BACK_MESH_SLOT, composed.get(HAIR_BACK_MESH_SLOT, "")))
	if _is_verylong_back_hair(hair):
		rear_slots.push_front(HAIR_BACK_MESH_SLOT)
	var first_human = order.size()
	for slot in ["torso", "pelvis", "head", "arm_left", "arm_right", "hand_left", "hand_right", "shoulder_left", "shoulder_right"]:
		var index = order.find(slot)
		if index >= 0:
			first_human = min(first_human, index)
	for slot in rear_slots:
		var index = order.find(slot)
		if index >= 0 and (index <= order.find(lower) or index >= first_human):
			# Reinsert the pair only when a key moves it outside its proper
			# interval. Otherwise retain the authored order of the back gear.
			var fixes = []
			for i in range(rear_slots.size() - 1, -1, -1):
				fixes.append({"slot": rear_slots[i], "after": lower})
			return _apply_draw_order_fixes(order, fixes)
	return order


func _front_handjob_active():
	for animation_name in animation_states:
		if !animation_states[animation_name]:
			continue
		var takes = composed_info.get(animation_name, {}).get("takes", [animation_name])
		if "handjob1" in takes or "handjob2" in takes:
			return true
	return false


func _apply_selected_ear_draw_order(order):
	var ear_part = str(selections.get("ears", ""))
	var anchor = ""
	if UPPER_EAR_PARTS.has(ear_part):
		anchor = "hairs_base"
	elif EARS_BEHIND_HAIR_PARTS.has(str(selections.get("hair", ""))):
		anchor = "hairs_base"
	elif FRINGE_BACK_EAR_PARTS.has(ear_part):
		# Human ears stay between the base hair and its fringe. Enforce this on
		# animated draw orders too, where the export may move the ears forward.
		anchor = "hairs_fringe"
	else:
		return order
	var from = order.find("ears")
	var hair = order.find(anchor)
	if from < 0 or hair < 0:
		return order
	order.remove(from)
	hair = order.find(anchor)
	order.insert(hair, "ears")
	return order


# Spine's DrawOrderTimeline, worked out over the export's own slot order because
# that is the order the offsets were authored against.  The catalogue's
# corrections are rules rather than positions, so they are re-applied afterwards
# instead of being carried through the shuffle - the arms cross the tattoo slot
# on their way forward, and an index would land one slot out.
func _draw_order_timeline(animation_name):
	# Keep the base take's draw order. The tithand/handjob rule above moves
	# just the hand and arm slots that need to cross in that combination.
	if _is_sex_side_animation(animation_name):
		return []
	var timeline = _animation_data(animation_name).get("drawOrder", [])
	# Small/flat chests keep titjob's endpoint order throughout the take
	# (test_combo and a composed pose with titjob's chest carry its keys). Filter
	# at runtime so changing size restores the authored keys immediately.
	var titjob_keys = animation_name in ["titjob", "test_combo"] or "titjob" in composed_info.get(animation_name, {}).get("takes", [])
	if doll_id == "female" and titjob_keys and str(axis_values.get("tits_size", "")) in ["small", "flat"] and timeline.size() > 2:
		return [timeline[0], timeline[timeline.size() - 1]]
	return timeline


func _animation_draw_order():
	var entry = []
	for animation_name in _ordered_active_animations():
		var timeline = _draw_order_timeline(animation_name)
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
	for animation_name in _ordered_active_animations():
		var timeline = _draw_order_timeline(animation_name)
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
# out and dropped directly below/above y.  The catalogue's rules, unless `fixes`
# names others.
func _apply_draw_order_fixes(order, fixes = null):
	if fixes == null:
		fixes = CATALOGUE.draw_order_fixes()
	for fix in fixes:
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
	var cum_slots = _cum_visible_slots()
	var fingers_active = _partner_hand_pose_active()
	for animation_name in _ordered_active_animations():
		var tithand_overlay = _is_sex_side_animation(animation_name)
		# The tithand take hides gg_hand when played alone. In a combination,
		# the main pose owns that hand and the overlay adds gg_hand2/gg_hand3.
		var preserve_fingers_hand = tithand_overlay and fingers_active
		if tithand_overlay or _is_partner_hand_pose(animation_name):
			# Alpha-only hand tracks use this take's setup cut, not a hand
			# attachment left behind by the independently running base pose.
			for slot in slot_data:
				var slot_name = str(slot.name)
				if slot_name in PARTNER_HAND_SLOTS and !(preserve_fingers_hand and slot_name == "gg_hand"):
					result[slot_name] = str(slot.get("attachment", ""))
		var timelines = _animation_data(animation_name).get("slots", {})
		var time = float(animation_times.get(animation_name, 0.0))
		for slot_name in timelines.keys():
			if preserve_fingers_hand and slot_name == "gg_hand":
				continue
			if str(slot_name).begins_with("semen_") and !cum_slots.has(slot_name):
				result[slot_name] = ""
				continue
			var keys = timelines[slot_name].get("attachment", [])
			var value = null
			var found = false
			for key in keys:
				if float(key.get("time", 0.0)) <= time:
					value = key.get("name", null)
					found = true
			if found:
				# These takes hide setup leg gear in Spine, but the selected outfit
				# owns it here. Ignore only hide keys, preserving explicit swaps.
				if animation_name in ["anal_missionary", "double_pen", "sex_missionary", "test_combo"] and slot_name in ["equip_leg_left", "equip_leg_right"] and (value == null or str(value).empty()):
					continue
				# A missing/null name is an explicit hide key, not an absent track.
				result[slot_name] = str(value) if value != null else ""
	return result


# Add the setup open mouth while `say` is running.  `lips_say` is a separate
# slot in the export and the animation only keys its RGBA, so it must already
# have a mesh for that alpha to reveal.  Orc lips use their matching open cut.
func _apply_say_lips(worn):
	if !bool(animation_states.get(SAY_ANIMATION, false)):
		return
	var lips_part = str(worn.get("lips", ""))
	# a face drawn without a mouth - a cat's muzzle has its own - does not grow one to talk
	if lips_part == "":
		return
	var say_selection = worn.duplicate()
	say_selection["lips"] = SAY_ORC_LIPS_PART if lips_part.begins_with(SAY_ORC_LIPS_PREFIX) else SAY_DEFAULT_LIPS_PART
	var say_composed = CATALOGUE.compose(say_selection, axis_values)
	if say_composed.has(SAY_LIPS_SLOT):
		composed[SAY_LIPS_SLOT] = say_composed[SAY_LIPS_SLOT]


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
		var attachment_name = str(authored.get(body_slot, ""))
		if !authored.has(body_slot):
			# Before a hand timeline's first key, Spine uses the setup attachment,
			# not the wardrobe's default hand pose. handjob2 keys its right palm only
			# at the end, so its setup handr2 must be race-matched for the full take.
			var has_hand_timeline = false
			for animation_name in _ordered_active_animations():
				var frames = _animation_data(animation_name).get("slots", {}).get(body_slot, {}).get("attachment", [])
				if !frames.empty():
					has_hand_timeline = true
					break
			if !has_hand_timeline:
				continue
			for slot in slot_data:
				if str(slot.name) == body_slot:
					attachment_name = str(slot.get("attachment", ""))
					break
		# An explicit null/hide key stays empty; only absent keys use setup.
		var pose_value = _hand_pose_for_attachment(body_slot, attachment_name)
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
	# Nor for a doll in the game, which has no panel to inspect them from and where
	# nothing reads them: moving 269 of them was 0.6 ms of every animated frame.
	if Engine.editor_hint or !interface_enabled:
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
	# Enforce visibility before setup, animation or overlay attachments resolve.
	if part_hidden_slots.has(slot_name):
		return {}
	if slot_name in ["ass", "ass_eq"] and !_ass_animation_active():
		return {}
	var is_semen = str(slot_name).begins_with("semen_")
	var retained_semen = {}
	if is_semen and !_cum_visible_slots().has(slot_name):
		retained_semen = semen_residue.get(slot_name, {})
		if retained_semen.empty():
			return {}
	# These are exclusive to the inset, never wardrobe items on the main doll.
	if slot_name in ["XRAY", "xray"]:
		return {}
	var attachment_name = str(composed.get(slot_name, ""))
	if slot_name in PARTNER_HAND_SLOTS:
		if !_partner_hands_active():
			return {}
		# Some takes key only alpha and intentionally use the setup hand;
		# others swap or hide it explicitly. These are not wardrobe selections.
		attachment_name = str(animation_attachments.get(slot_name, slot.get("attachment", "")))
	if is_semen:
		attachment_name = str(retained_semen.get("attachment", animation_attachments.get(slot_name, "")))
	# Clipping is skeleton state, not a selectable wardrobe/catalogue part.
	# Resolve setup and attachment keys even though it has no atlas texture.
	var source_attachments = skin_map.get(SKIN_NAME, {}).get("attachments", {}).get(slot_name, {})
	var helper_name = str(animation_attachments.get(slot_name, slot.get("attachment", "")))
	if source_attachments.get(helper_name, {}).get("type", "") == "clipping":
		var helper = source_attachments[helper_name].duplicate()
		helper["_attachment_name"] = helper_name
		helper["_skin_name"] = SKIN_NAME
		return helper
	var anatomy_active = _anatomy_animation_active()
	# The rear clothing cut belongs only to the alternate ass mesh. Keep the
	# selected outfit (not the export's setup item), and never leave it floating
	# in ordinary poses or after an attachment key hides the body underneath.
	if slot_name == "ass_eq" and (!anatomy_active or str(animation_attachments.get("ass", "")).empty()):
		return {}
	# This pose omits the lower-leg layers for every selected body.
	if anatomy_active and bool(animation_states.get("deepthroat", false)) and slot_name in ["ShinL", "ShinR", "ShinL_muscle", "ShinR_muscle"]:
		return {}
	if slot_name in ANATOMY_SLOTS:
		if !anatomy_active:
			return {}
		# Honour setup visibility and delayed keys instead of showing every
		# catalogue body part. A setup attachment needs the selected race too.
		attachment_name = str(slot.get("attachment", ""))
		if !attachment_name.empty() and !(slot_name in SHARED_ANATOMY_SLOTS):
			attachment_name = str(composed.get(slot_name, ""))
	if anatomy_active and retained_semen.empty() and animation_attachments.has(slot_name):
		attachment_name = str(animation_attachments[slot_name])
	var emotion_slot = _active_emotion_animates_slot(slot_name)
	# Emotion art is intentionally absent from the ordinary appearance
	# selection.  Blush is a setup attachment animated only through RGBA, while
	# the surprise mouth is introduced by an attachment timeline.  Materialise
	# those slots while an emotion owns them; ordinary pose attachments still
	# cannot put hidden hands or clothes back on the doll.
	if emotion_slot and animation_attachments.has(slot_name):
		attachment_name = str(animation_attachments[slot_name])
	elif emotion_slot and attachment_name.empty():
		attachment_name = str(slot.get("attachment", ""))
		if attachment_name.empty():
			var slot_attachments = skin_map.get(SKIN_NAME, {}).get("attachments", {}).get(slot_name, {})
			if slot_attachments.size() == 1:
				attachment_name = str(slot_attachments.keys()[0])
	# Only for a slot the doll is already showing: the timeline says which hand to
	# use, not whether the character has one.
	if !attachment_name.empty() and retained_semen.empty() and animation_attachments.has(slot_name):
		attachment_name = str(animation_attachments[slot_name])
	# The waitress piece in the cape slot is the back of the skirt.
	if slot_name == "equip_back" and attachment_name.get_file() == "waitress_back" and _has_animal_lower_body():
		return {}
	if attachment_name.empty():
		return {}
	var attachments = skin_map.get(SKIN_NAME, {}).get("attachments", {})
	# Apply only after animation visibility and authored attachment keys. A
	# replacement must not materialise a hidden slot or be reset by every key.
	if ANATOMY_ALTERNATIVES.has(slot_name) or ANATOMY_FURRY_ONLY.has(slot_name):
		# The dropdown owns the variant, while the animation owns visibility.
		var chosen = str(_anatomy_variants(slot_name).get(_selected_anatomy_variant(slot_name), ""))
		if attachments.get(slot_name, {}).has(chosen):
			attachment_name = chosen
	if !attachments.has(slot_name) or !attachments[slot_name].has(attachment_name):
		push_warning("Doll2Preview: composed attachment `%s/%s` is not in the export" % [slot_name, attachment_name])
		return {}
	var result = attachments[slot_name][attachment_name].duplicate()
	result["_attachment_name"] = attachment_name
	result["_skin_name"] = SKIN_NAME
	if slot_name == "semen_vhole" and attachment_name == MISSIONARY_CUM_RESIDUE:
		_bind_missionary_residue_to_spine(result)
	if semen_residue.has(slot_name) and semen_residue[slot_name].attachment == attachment_name:
		result["_semen_residue"] = semen_residue[slot_name]
		result["_semen_residue_only"] = !retained_semen.empty()
	return result


func _bind_missionary_residue_to_spine(attachment):
	var vertices = attachment.get("vertices", [])
	# Respect future exports that already supply bone weights.
	if vertices.empty() or vertices.size() != attachment.get("uvs", []).size():
		return
	if !setup_pose.has("root") or !setup_pose.has("spine1"):
		return
	# Keep the exported setup position, but let spine1 move all ten vertices.
	var spine = setup_pose["spine1"]
	var root_to_spine = _bone_transform(spine).affine_inverse() * _bone_transform(setup_pose["root"])
	var weighted = []
	for i in range(0, vertices.size(), 2):
		var point = root_to_spine.xform(Vector2(float(vertices[i]), float(vertices[i + 1])))
		weighted.append_array([1, spine.index, point.x, point.y, 1.0])
	attachment["vertices"] = weighted


func _active_emotion_animates_slot(slot_name):
	for animation_name in _ordered_active_animations():
		if !_is_emotion_animation(animation_name):
			continue
		if _animation_data(animation_name).get("slots", {}).has(slot_name):
			return true
		if slot_name in EMOTION_SETUP_SLOTS.get(animation_name, []):
			return true
	# Keep a setup-only attachment alive while it fades out. Without this the
	# rebuild caused by disabling horny removes blush before its alpha can move.
	if emotion_transition_elapsed < EMOTION_TRANSITION_DURATION:
		return slot_name in emotion_setup_slots_from or slot_name in emotion_setup_slots_to
	return false


func _active_emotion_setup_slots():
	var result = []
	for animation_name in _ordered_active_animations():
		if !_is_emotion_animation(animation_name):
			continue
		for slot_name in EMOTION_SETUP_SLOTS.get(animation_name, []):
			if !(slot_name in result):
				result.append(slot_name)
		# An emotion's own RGBA key for the slot counts as on (embarrassment and shy fade the blush in).
		for slot_name in _animation_data(animation_name).get("slots", {}).keys():
			if _is_emotion_setup_slot(slot_name) and !(slot_name in result) and _emotion_slot_shows(animation_name, slot_name):
				result.append(slot_name)
	return result


# Keys that only hide the slot (joy, angry, surprise) do not count as showing it.
func _emotion_slot_shows(animation_name, slot_name):
	var timelines = _animation_data(animation_name).get("slots", {}).get(slot_name, {})
	var frames = timelines.get("rgba", [])
	if frames.empty():
		return true
	for frame in frames:
		if _spine_colour(frame.get("color", "FFFFFFFF")).a > 0.0:
			return true
	return false


func _active_emotion_keys_slot(slot_name):
	for animation_name in _ordered_active_animations():
		if !_is_emotion_animation(animation_name):
			continue
		if _animation_data(animation_name).get("slots", {}).has(slot_name):
			return true
	return false


func _is_emotion_setup_slot(slot_name):
	for slots in EMOTION_SETUP_SLOTS.values():
		if slot_name in slots:
			return true
	return false


func _emotion_setup_slot_alpha(slot_name):
	if !_is_emotion_setup_slot(slot_name):
		return 1.0
	# Full-body poses can introduce blush themselves. An active emotion still
	# owns its own keyed colour and transition when both channels address it.
	if _anatomy_animation_active() and !_active_emotion_animates_slot(slot_name) and animation_attachments.has(slot_name):
		return 0.0 if str(animation_attachments[slot_name]).empty() else 1.0
	if emotion_transition_elapsed >= EMOTION_TRANSITION_DURATION:
		return 1.0 if slot_name in _active_emotion_setup_slots() else 0.0
	var first = 1.0 if slot_name in emotion_setup_slots_from else 0.0
	var second = 1.0 if slot_name in emotion_setup_slots_to else 0.0
	var amount = clamp(emotion_transition_elapsed / EMOTION_TRANSITION_DURATION, 0.0, 1.0)
	amount = amount * amount * (3.0 - 2.0 * amount)
	return lerp(first, second, amount)


func _add_attachment(slot, attachment, rows = {}, clipping = {}, inset = false):
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
	var data = _attachment_geometry(slot, attachment, region, page.size, _attachment_deform(slot, attachment), mod_texture, _pose_for(slot), false, _skinning_rows(slot, rows), rows)
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
	if ANATOMY_ALTERNATIVES.has(str(slot.get("name", ""))) or ANATOMY_FURRY_ONLY.has(str(slot.get("name", ""))):
		var variant = "falos" if str(attachment.get("_attachment_name", "")) == str(ANATOMY_ALTERNATIVES.get(str(slot.name), "")) else "penis"
		if str(attachment.get("_attachment_name", "")).ends_with("_f"):
			variant = "penis_f"
		channel = _anatomy_colour_channel(str(slot.name), variant)
	# Coverage needs the mesh's own place on the art canvas, so those meshes get
	# their own material instead of sharing the channel's.
	polygon.material = _mesh_material(channel, region, page.size, slot.get("name", ""))
	var points = _apply_mesh_size_modifiers(data.points, slot, attachment)
	_track_gradient_bounds(channel, points)
	var displayed = {"points": points, "uvs": data.uvs, "triangles": data.triangles}
	if !clipping.empty():
		displayed = _clip_mesh_geometry(displayed, _clipping_points(clipping, rows))
	if inset:
		displayed = _clip_mesh_geometry(displayed, _clipping_points(xray_mask, rows))
	_set_polygon_geometry(polygon, displayed)
	var target = xray_root if inset else model_root
	target.add_child(polygon)
	var records = xray_records if inset else mesh_records
	records.append({"polygon": polygon, "slot": slot, "attachment": attachment, "region": region, "page_size": page.size, "mod_texture": mod_texture, "channel": channel, "clipping": clipping, "uvs": data.uvs, "triangles": data.triangles, "inset": inset})
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
	# One list of what is running for the whole pass: nothing in it starts or stops an
	# animation, and every mesh used to build and sort it twice.
	var active = _ordered_active_animations()
	var rows = {}
	var clip_points = {}
	var aperture = _clipping_points(xray_mask, rows, active) if !xray_mask.empty() else PoolVector2Array()
	for record in mesh_records + xray_records:
		if !is_instance_valid(record.polygon):
			continue
		var deform = _attachment_deform(record.slot, record.attachment, active)
		var data = _attachment_geometry(record.slot, record.attachment, record.region, record.page_size, deform, null, _pose_for(record.slot), true, _skinning_rows(record.slot, rows), rows)
		if !data.empty():
			var points = _apply_mesh_size_modifiers(data.points, record.slot, record.attachment)
			var displayed = {"points": points, "uvs": record.uvs, "triangles": record.triangles}
			if !record.clipping.empty():
				var key = str(record.clipping.slot.name)
				if !clip_points.has(key):
					clip_points[key] = _clipping_points(record.clipping, rows, active)
				displayed = _clip_mesh_geometry(displayed, clip_points[key])
			if record.get("inset", false):
				displayed = _clip_mesh_geometry(displayed, aperture)
			if !record.clipping.empty() or record.get("inset", false) or record.get("clipping_changed", false):
				_set_polygon_geometry(record.polygon, displayed)
				record.erase("clipping_changed")
			else:
				record.polygon.polygon = points
		record.polygon.color = _attachment_colour(record.slot, record.attachment, active)
	_update_vaginal_opening_clip()
	_update_xray_pivot(aperture)
	_update_xray_view()


# The vaginal partner is drawn over the shadow and under the foreground mesh.
# Clip at the top of the animated opening to keep the tip under the body above it.
func _bind_vaginal_opening_clip():
	vaginal_opening_mesh = null
	vaginal_partner_material = null
	if str(animation_attachments.get("vhole", "")).empty():
		return
	var partner_slot = _vaginal_partner_slot()
	if partner_slot.empty():
		return
	for record in mesh_records:
		if record.slot.name == "vhole":
			vaginal_opening_mesh = record.polygon
		elif record.slot.name == partner_slot:
			vaginal_partner_material = record.polygon.material
	_update_vaginal_opening_clip()


func _vaginal_partner_slot():
	for animation_name in animation_states:
		if !animation_states[animation_name]:
			continue
		var composed_slots = composed_info.get(animation_name, {}).get("slots", {})
		for slot_name in composed_slots:
			if composed_slots[slot_name] == "vaginal":
				return slot_name
		var authored_slots = COMPOSER.TAKE_PENISES.get(animation_name, {})
		for slot_name in authored_slots:
			if authored_slots[slot_name][0] == "vaginal":
				return slot_name
	return ""


func _update_vaginal_opening_clip():
	if vaginal_opening_mesh == null or vaginal_partner_material == null:
		return
	var top = INF
	for point in vaginal_opening_mesh.polygon:
		top = min(top, point.y)
	if top < INF:
		vaginal_partner_material.set_shader_param("opening_clip_y", top)


func set_xray(enabled):
	xray_enabled = bool(enabled)
	if !skeleton.empty():
		_rebuild_model()


func _xray_attachment(slot):
	var name = str(slot.get("name", ""))
	var attachments = skin_map.get(SKIN_NAME, {}).get("attachments", {}).get(name, {})
	var key = "XRAY" if name == "XRAY" else str(slot.get("attachment", ""))
	if key.empty() and attachments.size() == 1:
		key = str(attachments.keys()[0])
	if !attachments.has(key):
		return {}
	var result = attachments[key].duplicate()
	result["_attachment_name"] = key
	result["_skin_name"] = SKIN_NAME
	return result


func _reorder_animated_slots():
	_reorder_mesh_records(mesh_records, model_root, _draw_ordered_slots())
	if is_instance_valid(xray_root):
		_reorder_mesh_records(xray_records, xray_root, _xray_draw_ordered_slots(), true)


# Reassign clipping too: moving a slot across a mask boundary changes which
# mask applies, even though its attachment and Polygon2D stay the same.
func _reorder_mesh_records(records, root, ordered, inset = false):
	var by_slot = {}
	for record in records:
		by_slot[str(record.slot.name)] = record
	var clipping = {}
	var reordered = []
	for slot in ordered:
		var name = str(slot.name)
		if inset and name == "XRAY":
			continue
		var attachment = _xray_attachment(slot) if inset and name == "xray" else _resolve_attachment(slot)
		if attachment.get("type", "") == "clipping":
			if clipping.empty():
				clipping = {"slot": slot, "attachment": attachment}
			continue
		if by_slot.has(name):
			var record = by_slot[name]
			record.clipping = clipping
			record["clipping_changed"] = true
			root.move_child(record.polygon, root.get_child_count() - 1)
			reordered.append(record)
		if !clipping.empty() and name == str(clipping.attachment.get("end", "")):
			clipping = {}
	records.clear()
	records.append_array(reordered)


func _xray_draw_ordered_slots():
	# Keep the inset's authored override on top of animated slot ordering.
	var ordered = _draw_ordered_slots()
	var front = {}
	for slot in ordered.duplicate():
		if str(slot.name) in ["xray", "penis"]:
			front[str(slot.name)] = slot
			ordered.erase(slot)
	var insertion = ordered.size()
	for i in range(ordered.size()):
		if str(ordered[i].name) == "vagina2_muscle":
			insertion = i + 1
	for name in ["xray", "penis"]:
		if front.has(name):
			ordered.insert(insertion, front[name])
			insertion += 1
	return ordered


func _rebuild_xray(rows):
	if is_instance_valid(xray_root):
		xray_root.hide()
		xray_root.queue_free()
	xray_root = null
	xray_records.clear()
	xray_mask = {}
	if !xray_enabled:
		return
	for slot in slot_data:
		if str(slot.name) == "XRAY":
			var attachment = _xray_attachment(slot)
			if attachment.get("type", "") == "clipping":
				xray_mask = {"slot": slot, "attachment": attachment}
	if xray_mask.empty():
		return
	xray_root = Node2D.new()
	xray_root.name = "XRayModel"
	add_child(xray_root)
	# Spine's tree lists the frontmost slots first. Keep all other ordering,
	# but draw these three back-to-front as vagina2_muscle, xray, penis.
	var ordered = _xray_draw_ordered_slots()
	var clipping = {}
	for slot in ordered:
		if str(slot.name) == "XRAY":
			continue # applied independently, in addition to authored local masks
		var attachment = _xray_attachment(slot) if str(slot.name) == "xray" else _resolve_attachment(slot)
		if attachment.get("type", "") == "clipping":
			if clipping.empty():
				clipping = {"slot": slot, "attachment": attachment}
			continue
		if !attachment.empty():
			_add_attachment(slot, attachment, rows, clipping, true)
		if !clipping.empty() and str(slot.name) == str(clipping.attachment.get("end", "")):
			clipping = {}
	_update_xray_pivot(_clipping_points(xray_mask, rows))
	_update_xray_view()


func _update_xray_pivot(points):
	if points.empty():
		return
	var bounds = Rect2(points[0], Vector2.ZERO)
	for point in points:
		bounds = bounds.expand(point)
	xray_pivot = bounds.position + bounds.size * 0.5


func _update_xray_view():
	if !is_instance_valid(xray_root):
		return
	# Enlarge about the aperture centre, so the inset stays beside the source
	# rather than jumping upwards when the model is zoomed to 200%.
	var pivot = _display_origin() + xray_pivot
	xray_root.scale = Vector2.ONE * view_zoom * 2.0
	xray_root.position = view_offset + Vector2(250.0, -250.0) - pivot * view_zoom


func _clipping_points(clipping, rows, active = null):
	var slot = clipping.slot
	var attachment = clipping.attachment
	var vertices = attachment.get("vertices", [])
	var coordinate_count = int(attachment.get("vertexCount", 0)) * 2
	var deform = _attachment_deform(slot, attachment, active)
	var pose = _pose_for(slot)
	if vertices.size() != coordinate_count:
		return _mesh_points(vertices, coordinate_count, deform, pose, _skinning_rows(slot, rows))
	# Unlike weighted vertices, plain clipping vertices are local to the slot bone.
	var points = PoolVector2Array()
	for i in range(0, coordinate_count, 2):
		var offset = Vector2(float(deform[i]), float(deform[i + 1])) if i + 1 < deform.size() else Vector2.ZERO
		points.append(_world_point(pose[slot.get("bone", "root")], Vector2(float(vertices[i]), float(vertices[i + 1])) + offset))
	return points


# Clip each textured triangle independently. Barycentric UV interpolation keeps
# the atlas mapping intact at newly introduced edge vertices, including concave
# masks which can split one triangle into multiple disjoint polygons.
func _clip_mesh_geometry(data, mask):
	var points = PoolVector2Array()
	var uvs = PoolVector2Array()
	var triangles = []
	if mask.size() < 3:
		return {"points": points, "uvs": uvs, "triangles": triangles}
	for triangle in data.triangles:
		var a = data.points[triangle[0]]
		var b = data.points[triangle[1]]
		var c = data.points[triangle[2]]
		var determinant = (b - a).cross(c - a)
		if abs(determinant) < 0.000001:
			continue
		for piece in Geometry.intersect_polygons_2d(PoolVector2Array([a, b, c]), mask):
			var indices = Geometry.triangulate_polygon(piece)
			if indices.empty():
				continue
			var start = points.size()
			for point in piece:
				var wb = (point - a).cross(c - a) / determinant
				var wc = (b - a).cross(point - a) / determinant
				points.append(point)
				uvs.append(data.uvs[triangle[0]] * (1.0 - wb - wc) + data.uvs[triangle[1]] * wb + data.uvs[triangle[2]] * wc)
			for i in range(0, indices.size(), 3):
				triangles.append(PoolIntArray([start + indices[i], start + indices[i + 1], start + indices[i + 2]]))
	return {"points": points, "uvs": uvs, "triangles": triangles}


func _set_polygon_geometry(polygon, data):
	# Empty `polygons` means automatic triangulation in Godot: hide a fully
	# clipped mesh explicitly so it cannot fall back to drawing the original.
	polygon.polygons = []
	polygon.uv = PoolVector2Array()
	polygon.polygon = data.points
	polygon.uv = data.uvs
	polygon.polygons = data.triangles
	polygon.visible = !data.triangles.empty()


# Human/beastkin ass attachments and their clothing share the scale. Scale the
# freshly skinned mesh about its centre, preserving the authored pose and UVs.
# Legs has asymmetric limits; map each half to -15% / +25% mesh scale.
func _apply_mesh_size_modifiers(points, slot, attachment):
	if !(str(slot.get("name", "")) in ["ass", "ass_eq"]):
		points = _scale_back_hair_mesh(points, slot)
		return _tuck_animal_back_hem(points, slot, attachment)
	if points.empty():
		return points
	var limits = MODIFIERS.MODIFIERS["legs"].range
	var neutral = float(limits.default)
	var value = clamp(float(proportions.get("legs", neutral)), float(limits.minimum), float(limits.maximum))
	if is_equal_approx(value, neutral):
		return points
	var span = float(limits.maximum) - neutral if value > neutral else neutral - float(limits.minimum)
	var amplitude = 0.25 if value > neutral else 0.15
	var factor = 1.0 + amplitude * (value - neutral) / span
	var minimum = points[0]
	var maximum = points[0]
	for point in points:
		minimum.x = min(minimum.x, point.x)
		minimum.y = min(minimum.y, point.y)
		maximum.x = max(maximum.x, point.x)
		maximum.y = max(maximum.y, point.y)
	var pivot = (minimum + maximum) * 0.5
	var scaled = PoolVector2Array()
	scaled.resize(points.size())
	for i in range(points.size()):
		scaled[i] = pivot + (points[i] - pivot) * factor
	return scaled


func _has_animal_lower_body():
	return composed.get("animal_body", "") in ANIMAL_LOWER_BODIES


func _is_verylong_back_hair(attachment_name):
	return attachment_name.get_file() in ["hair_back_verylong1", "hair_back_verylong_wave"]


# Keep the upper mesh and its UVs. Compress only the hanging part into a hem
# that is high at the middle of the waist and drops towards either flank.
# Do the fit in the posed waist frame, so it follows twists and height changes.
func _tuck_animal_back_hem(points, slot, attachment):
	var slot_name = str(slot.get("name", ""))
	var key = str(attachment.get("_attachment_name", ""))
	if slot_name != "equip_back" and !(slot_name == HAIR_BACK_MESH_SLOT and _is_verylong_back_hair(key)):
		return points
	if points.empty() or !_has_animal_lower_body():
		return points
	var pose = _pose_for(slot)
	if !pose.has("spine1"):
		return points
	var bone = pose["spine1"]
	var scale = _display_scale()
	var waist = Transform2D(Vector2(bone.a, -bone.c) * scale, Vector2(bone.b, -bone.d) * scale, Vector2(bone.x, -bone.y) * scale)
	var to_waist = waist.affine_inverse()
	var lower = ANIMAL_BACK_HEM_START
	var local = PoolVector2Array()
	for point in points:
		var p = to_waist.xform(point)
		lower = min(lower, p.x)
		local.append(p)
	if lower >= ANIMAL_BACK_HEM_CENTRE:
		return points
	var fitted = PoolVector2Array()
	fitted.resize(points.size())
	for i in range(points.size()):
		var p = local[i]
		var flank = clamp(inverse_lerp(ANIMAL_BACK_HEM_SHOULDER, ANIMAL_BACK_HEM_WIDTH, abs(p.y)), 0.0, 1.0)
		var hem = ANIMAL_BACK_HEM_CENTRE - ANIMAL_BACK_HEM_DROP * flank * flank
		if p.x < ANIMAL_BACK_HEM_START and lower < hem:
			p.x = lerp(hem, ANIMAL_BACK_HEM_START, inverse_lerp(lower, ANIMAL_BACK_HEM_START, p.x))
			fitted[i] = waist.xform(p)
		else:
			fitted[i] = points[i]
	return fitted


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


func _attachment_deform(slot, attachment, active = null):
	if attachment.has("_semen_residue"):
		var residue = attachment["_semen_residue"]
		if bool(attachment.get("_semen_residue_only", false)) or _animated_slot_colour(str(slot.name), active).a < residue.colour.a:
			return residue.deform
	if active == null:
		active = _ordered_active_animations()
	var result = []
	var blink_overlay = []
	var skin_name = attachment.get("_skin_name", "")
	var slot_name = slot.get("name", "")
	var attachment_name = attachment.get("_attachment_name", "")
	for animation_name in active:
		var attachment_timelines = _animation_data(animation_name).get("attachments", {})
		if !attachment_timelines.has(skin_name):
			continue
		var skin_timelines = attachment_timelines[skin_name]
		if !skin_timelines.has(slot_name) or !skin_timelines[slot_name].has(attachment_name):
			continue
		var timeline = skin_timelines[slot_name][attachment_name].get("deform", [])
		var time = float(animation_times.get(animation_name, 0.0))
		var sampled = _sample_deform_timeline(timeline, time, _deform_length(attachment))
		if slot_name == "equip_leg_right" and attachment_name in ["legr_armor1", "legr_armor1_beastkin"]:
			_match_maid_stocking_motion(sampled, animation_name, skin_name, attachment_name, time)
		# `emote_horny` is now an authored static face-mesh deformation rather
		# than a bone pose. `eyesmove` addresses the same meshes, so applying the
		# emotion last used to erase the blink completely. Keep the blink aside
		# and add its relative deformation after the emotion: its zero frames
		# preserve the horny face, while its middle frames close those same eyes.
		if animation_name == BLINK_ANIMATION:
			blink_overlay = sampled
			continue
		if result.empty() or _is_emotion_animation(animation_name) or _is_sex_side_animation(animation_name) or animation_name == CUM_ANIMATION:
			result = sampled
		else:
			for i in range(min(result.size(), sampled.size())):
				result[i] += sampled[i]
	if !blink_overlay.empty():
		if result.empty():
			result = blink_overlay
		else:
			for i in range(min(result.size(), blink_overlay.size())):
				result[i] += blink_overlay[i]
	# Bone crossfading cannot affect the current mesh-authored horny take. Ease
	# every displayed attachment from the deformation visible before the switch
	# to the new raw sample, both on entry and on exit.
	var transition_key = _attachment_deform_key(slot, attachment)
	if emotion_transition_elapsed < EMOTION_TRANSITION_DURATION and emotion_deform_from.has(transition_key):
		var first = emotion_deform_from[transition_key]
		var length = max(first.size(), result.size())
		if length > 0:
			var amount = clamp(emotion_transition_elapsed / EMOTION_TRANSITION_DURATION, 0.0, 1.0)
			amount = amount * amount * (3.0 - 2.0 * amount)
			var eased = []
			eased.resize(length)
			for i in range(length):
				var first_value = float(first[i]) if i < first.size() else 0.0
				var second_value = float(result[i]) if i < result.size() else 0.0
				eased[i] = lerp(first_value, second_value, amount)
			result = eased
	return result


# These takes omit an early key present in double_pen/test_combo. Borrow the
# right stocking's motion only over the slipping intervals and ease back
# to the original curves. Composed poses can retime the lower-body region.
func _match_maid_stocking_motion(sampled, animation_name, skin_name, attachment_name, time):
	var take = str(composed_info.get(animation_name, {}).get("owners", {}).get("lower", animation_name))
	if sampled.empty() or !(take in ["anal_missionary", "sex_missionary", "sex_fingers", "sex_fingers_anal"]):
		return
	if take != animation_name:
		var duration = float(animation_durations.get(animation_name, 0.0))
		if duration <= 0.0:
			return
		time *= float(animation_durations.get(take, duration)) / duration
	var amount = smoothstep(0.0, 0.025, time) * (1.0 - smoothstep(0.105, 0.1333, time))
	if attachment_name == "legr_armor1_beastkin":
		amount = max(amount, smoothstep(0.325, 0.39, time) * (1.0 - smoothstep(0.443, 0.5, time)))
	if amount <= 0.0:
		return
	var tracks = _animation_data("double_pen").get("attachments", {}).get(skin_name, {}).get("equip_leg_right", {})
	var reference = tracks.get(attachment_name, {}).get("deform", [])
	if reference.empty():
		return
	var fitted = _sample_deform_timeline(reference, time, sampled.size())
	for i in range(sampled.size()):
		sampled[i] = lerp(float(sampled[i]), float(fitted[i]), amount)


func _attachment_deform_key(slot, attachment):
	return "%s|%s|%s" % [
		str(attachment.get("_skin_name", "")),
		str(slot.get("name", "")),
		str(attachment.get("_attachment_name", "")),
	]


func _capture_animated_attachment_deforms():
	var result = {}
	var active = _ordered_active_animations()
	for record in mesh_records + xray_records:
		result[_attachment_deform_key(record.slot, record.attachment)] = _attachment_deform(record.slot, record.attachment, active).duplicate()
	return result


func _deform_length(attachment):
	var vertices = attachment.get("vertices", [])
	var uv_size = attachment.get("uvs", []).size()
	if attachment.get("type", "") == "clipping":
		uv_size = int(attachment.get("vertexCount", 0)) * 2
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
func _attachment_colour(slot, attachment, active = null):
	var colour = _spine_colour(slot.get("color", "FFFFFFFF"))
	var slot_name = str(slot.get("name", ""))
	var animated = _animated_slot_colour(slot_name, active)
	if attachment.has("_semen_residue"):
		var residue = attachment["_semen_residue"]
		if bool(attachment.get("_semen_residue_only", false)) or animated.a < residue.colour.a:
			animated = residue.colour
	colour *= animated
	if slot_name == "ass_eq":
		colour.a *= _animated_slot_colour("ass", active).a
	colour.a *= _emotion_setup_slot_alpha(slot_name)
	if _is_muscle_slot(slot_name):
		colour.a *= clamp(float(proportions.get("muscle_alpha", 30.0)) / 100.0, 0.0, 1.0)
	if slot_name == "freckles":
		colour.a *= clamp(float(proportions.get("freckles_alpha", 100.0)) / 100.0, 0.0, 1.0)
	return colour


# Slot RGBA timelines are what `say` uses to cross-fade the closed lips into the
# open-mouth slot.  As with bone timelines, a later active animation wins when
# two animations key the same slot.
func _animated_slot_colour(slot_name, active = null):
	if active == null:
		active = _ordered_active_animations()
	var result = Color(1, 1, 1, 1)
	for animation_name in active:
		var slot_timelines = _animation_data(animation_name).get("slots", {})
		if !slot_timelines.has(slot_name):
			continue
		var frames = slot_timelines[slot_name].get("rgba", [])
		if !frames.empty():
			result = _sample_rgba_timeline(frames, float(animation_times.get(animation_name, 0.0)))
		elif animation_name == CUM_FACE_ANIMATION and slot_timelines[slot_name].has("attachment"):
			# This face authors attachment keys, not RGBA. Lower-channel hide
			# keys (say, a pose, or another emotion) must not erase its mouth
			# and blush even though the higher channel uses setup-white alpha.
			result = Color(1, 1, 1, 1)
	if emotion_transition_elapsed < EMOTION_TRANSITION_DURATION and emotion_colour_from.has(slot_name):
		var amount = clamp(emotion_transition_elapsed / EMOTION_TRANSITION_DURATION, 0.0, 1.0)
		amount = amount * amount * (3.0 - 2.0 * amount)
		result = emotion_colour_from[slot_name].linear_interpolate(result, amount)
	return result


func _capture_animated_slot_colours():
	var result = {}
	var drawn_slots = {}
	for record in mesh_records + xray_records:
		drawn_slots[str(record.slot.get("name", ""))] = true
	for slot in skeleton.get("slots", []):
		var slot_name = str(slot.get("name", ""))
		var colour = _animated_slot_colour(slot_name)
		# A slot introduced by the next emotion fades in from transparency rather
		# than appearing at full opacity on the rebuild frame.
		# Setup-only emotion slots have their own symmetric alpha transition below;
		# keeping this channel opaque avoids applying the fade twice.
		# One the current emotion keys itself keeps its keyed alpha.
		if _is_emotion_setup_slot(slot_name) and !_active_emotion_keys_slot(slot_name):
			colour.a = 1.0
		elif !drawn_slots.has(slot_name):
			colour.a = 0.0
		result[slot_name] = colour
	return result


func _sample_rgba_timeline(frames, time):
	var numeric_frames = []
	for frame in frames:
		var colour = _spine_colour(frame.get("color", "FFFFFFFF"))
		var numeric = {
			"time": float(frame.get("time", 0.0)),
			"r": colour.r, "g": colour.g, "b": colour.b, "a": colour.a,
		}
		if frame.has("curve"):
			numeric["curve"] = frame.curve
		numeric_frames.append(numeric)
	var sampled = _sample_timeline(numeric_frames, time, ["r", "g", "b", "a"])
	return Color(
		clamp(float(sampled.r), 0.0, 1.0),
		clamp(float(sampled.g), 0.0, 1.0),
		clamp(float(sampled.b), 0.0, 1.0),
		clamp(float(sampled.a), 0.0, 1.0)
	)


func _apply_muscle_alpha():
	for record in mesh_records + xray_records:
		if !is_instance_valid(record.polygon):
			continue
		if !_is_muscle_slot(str(record.slot.get("name", ""))):
			continue
		record.polygon.color = _attachment_colour(record.slot, record.attachment)


func _is_muscle_slot(slot_name):
	return slot_name.ends_with("_muscle") or slot_name.ends_with("_muscle_up")


func _apply_freckles_alpha():
	for record in mesh_records + xray_records:
		if !is_instance_valid(record.polygon):
			continue
		if str(record.slot.get("name", "")) != "freckles":
			continue
		record.polygon.color = _attachment_colour(record.slot, record.attachment)


func _spine_colour(hex_value):
	if hex_value == null or str(hex_value).length() < 8:
		return Color(1, 1, 1, 1)
	# Spine writes RRGGBBAA, while Godot 3 interprets an eight-digit HTML colour as
	# AARRGGBB.  Parsing the channels explicitly keeps the alpha timelines in
	# `say` from turning transparency into a blue/yellow colour instead.
	var value = str(hex_value).substr(0, 8)
	if spine_colours.has(value):
		return spine_colours[value]
	var colour = Color(
		float(("0x" + value.substr(0, 2)).hex_to_int()) / 255.0,
		float(("0x" + value.substr(2, 2)).hex_to_int()) / 255.0,
		float(("0x" + value.substr(4, 2)).hex_to_int()) / 255.0,
		float(("0x" + value.substr(6, 2)).hex_to_int()) / 255.0
	)
	spine_colours[value] = colour
	return colour


# `points_only` is the animated path: a frame of an animation moves the vertices
# and nothing else, while the UV projection and the triangle list are fixed by
# the art.  Building them anyway and throwing them away - which is what an
# animated frame did - cost 3.2 ms a doll.
func _attachment_geometry(slot, attachment, region, page_size, deform = [], mod_texture = null, pose = null, points_only = false, rows = null, geometry_cache = null):
	if pose == null:
		pose = bones
	var raw_vertices = attachment.get("vertices", [])
	var is_mesh = attachment.get("type", "region") in ["mesh", "linkedmesh"] or raw_vertices.size() > 0
	if is_mesh:
		if raw_vertices.empty():
			return {}
		var points = _mesh_points(raw_vertices, attachment.get("uvs", []).size(), deform, pose, rows)
		points = _align_shin_knee(points, slot, attachment, deform, pose, geometry_cache)
		var name = str(attachment.get("_attachment_name", ""))
		if slot.name == "equip_breasts" and doll_id == "female":
			if chest_is_flat() or name == "tits_slave_small":
				points = _fit_chest_edges(points, attachment, deform, pose, rows, geometry_cache, !chest_is_flat())
		if slot.name in ["equip_leg_left", "equip_leg_right"]:
			points = _fit_split_leg_gear(points, slot, attachment, deform, pose, geometry_cache)
			if name in UNDERWEAR_STOCKINGS:
				points = _fit_underwear_knee(points, slot, attachment, pose, geometry_cache)
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



# The solved bones as plain rows [a, b, c, d, x, y] by their index in the export, for
# skinning: reading the six numbers out of a bone's dictionary by name, on every
# weight, cost more than copying them all out once a pass.
func _pose_table(pose):
	var table = []
	table.resize(bone_names_by_index.size())
	for i in range(bone_names_by_index.size()):
		var bone = pose[bone_names_by_index[i]]
		table[i] = [bone.a, bone.b, bone.c, bone.d, bone.x, bone.y]
	return table


# A slot's pose as a table, made once per pass over the meshes and kept in `rows`:
# the ordinary pose's under "", a layer pose's under its slot.
func _skinning_rows(slot, rows):
	var pose = _pose_for(slot)
	var slot_name = str(slot.get("name", ""))
	var key = "" if pose == bones else slot_name
	if !rows.has(key):
		rows[key] = _pose_table(pose)
	# All attachments in Shin slots, including orc/beastkin and muscle overlays,
	# share a mesh-only correction. The skeleton and all other meshes keep the
	# full Legs factor. Cache separately so correction never leaks into Hip/ass.
	if slot_name.to_lower().begins_with("shin"):
		var corrected_key = "shin_mesh/" + key
		if !rows.has(corrected_key):
			rows[corrected_key] = _compensate_shin_skinning_rows(rows[key])
		return rows[corrected_key]
	return rows[key]


# Build a reference for the garment edges only: carry breast weights with their
# torso parent, without changing the bones or the animated garment interior.
func _fit_chest_edges(points, attachment, deform, pose, rows, cache, sides_only):
	var hull = int(attachment.get("hull", 0))
	if hull < 3 or hull > points.size():
		return points
	var name = str(attachment.get("_attachment_name", ""))
	if sides_only:
		name += "/side_seams"
	if !flat_chest_edge_weights.has(name):
		var rest = _mesh_points(attachment.vertices, attachment.uvs.size(), [], setup_pose)
		var scale = _display_scale()
		var weights = PoolRealArray()
		var left = INF
		var right = -INF
		if sides_only:
			for i in range(hull):
				left = min(left, rest[i].x)
				right = max(right, rest[i].x)
		var centre = (left + right) * 0.5 if sides_only else 0.0
		var half_width = (right - left) * 0.5 if sides_only else 0.0
		for i in range(rest.size()):
			# On Small only the side seams hug the torso. Keep the cups and
			# their authored lower hem moving with the breast.
			if sides_only:
				weights.append(smoothstep(0.65, 0.91, abs(rest[i].x - centre) / max(half_width, 1.0)))
				continue
			if i < hull:
				weights.append(1.0)
				continue
			var depth = INF
			for j in range(hull):
				var start = rest[j]
				var segment = rest[(j + 1) % hull] - start
				var length_squared = segment.length_squared()
				var along = clamp((rest[i] - start).dot(segment) / length_squared, 0.0, 1.0) if length_squared > 0.0 else 0.0
				depth = min(depth, rest[i].distance_squared_to(start + segment * along))
			# Blend out over a thin band, keeping the original dynamics inside it.
			weights.append(1.0 - smoothstep(3.0, 26.0, sqrt(depth) / scale))
		flat_chest_edge_weights[name] = weights
	if cache == null:
		cache = {}
	if !cache.has("flat_chest_rows"):
		cache["flat_chest_rows"] = _flat_chest_gear_rows(pose, _pose_table(pose) if rows == null else rows)
	var anchored = _mesh_points(attachment.vertices, attachment.uvs.size(), [] if sides_only else deform, pose, cache["flat_chest_rows"])
	var weights = flat_chest_edge_weights[name]
	var result = PoolVector2Array()
	for i in range(points.size()):
		result.append(points[i].linear_interpolate(anchored[i], weights[i]))
	return _limit_mesh_folds(result, anchored, attachment.triangles)


func _flat_chest_gear_rows(pose, source_rows):
	var corrected = source_rows.duplicate()
	var torso_motion = {}
	for name in setup_pose_names:
		if !name.begins_with("nipple"):
			continue
		var setup = setup_pose[name]
		var anchor = str(setup.parent_name)
		while anchor.begins_with("nipple"):
			anchor = str(setup_pose[anchor].parent_name)
		if !pose.has(anchor):
			continue
		if !torso_motion.has(anchor):
			torso_motion[anchor] = _bone_transform(pose[anchor]) * _bone_transform(setup_pose[anchor]).affine_inverse()
		var fitted = torso_motion[anchor] * _bone_transform(setup)
		corrected[int(setup.index)] = [fitted.x.x, fitted.y.x, fitted.x.y, fitted.y.y, fitted.origin.x, fitted.origin.y]
	return corrected


func _bone_transform(bone):
	return Transform2D(Vector2(bone.a, bone.c), Vector2(bone.b, bone.d), Vector2(bone.x, bone.y))


func _compensate_shin_skinning_rows(source_rows):
	var value = float(proportions.get("legs", 1.0))
	if is_equal_approx(value, 1.0):
		return source_rows
	var factors = MODIFIERS.post_ik_visual_factors({"legs": value}, contract.CONTRACT_ID)
	var corrected = source_rows.duplicate(true)
	for i in range(bone_names_by_index.size()):
		var factor = factors.get(bone_names_by_index[i], Vector2.ONE)
		# Reduce the deviation from neutral by 30%, not the whole size.
		# Undo only Legs' contribution to each weighted vertex's local basis;
		# keep the animated joint positions and unrelated modifiers untouched.
		var ratio_x = (1.0 + (factor.x - 1.0) * 0.7) / factor.x if factor.x != 0.0 else 1.0
		var ratio_y = (1.0 + (factor.y - 1.0) * 0.7) / factor.y if factor.y != 0.0 else 1.0
		corrected[i][0] *= ratio_x
		corrected[i][2] *= ratio_x
		corrected[i][1] *= ratio_y
		corrected[i][3] *= ratio_y
	return corrected


# Gear on the old leg chain and the split body use different weights. Transfer
# the visible body's slider displacement at the garment's neutral position.
# Spine's animation deform and the original clearance remain in the baseline.
func _fit_split_leg_gear(points, slot, attachment, deform, pose, cache):
	var legs = float(proportions.get("legs", 1.0))
	if doll_id != "female" or is_equal_approx(legs, 1.0) or !_anatomy_animation_active():
		return points
	if cache == null:
		cache = {}
	var side = "L" if slot.name == "equip_leg_left" else "R"
	var key = "split_gear/" + side
	if !cache.has(key):
		cache[key] = _split_leg_motion_field(side, legs, cache)
	var field = cache[key]
	if field.empty():
		return points
	var baseline = _mesh_points(attachment.vertices, attachment.get("uvs", []).size(), deform, pose, _neutral_leg_rows(pose, legs, cache))
	var scale = _display_scale()
	var result = PoolVector2Array(points)
	for i in range(baseline.size()):
		var sample = _leg_motion_at(baseline[i], field)
		# Keep the outfit's own scaling on loose edges away from the leg.
		var blend = smoothstep(35.0 * scale, 80.0 * scale, float(sample[1]))
		result[i] = (baseline[i] + sample[0]).linear_interpolate(points[i], blend)
	return _limit_mesh_folds(result, baseline, attachment.triangles)


func _fit_underwear_knee(points, slot, attachment, pose, cache):
	if doll_id != "female" or !_anatomy_animation_active():
		return points
	var side = "L" if slot.name == "equip_leg_left" else "R"
	var knee = pose.get("spine136" if side == "L" else "spine129", {})
	var hull = int(attachment.get("hull", 0))
	if knee.empty() or hull < 3 or hull > points.size():
		return points
	if cache == null:
		cache = {}
	var key = "split_gear/" + side
	if !cache.has(key):
		cache[key] = _split_leg_motion_field(side, float(proportions.get("legs", 1.0)), cache)
	var boundary = cache[key].get("boundary", [])
	if boundary.empty():
		return points
	var scale = _display_scale()
	var joint = _world_point(knee, Vector2.ZERO, scale)
	var contour = PoolVector2Array()
	for i in range(hull):
		contour.append(points[i])
	var edge_pushes = PoolVector2Array()
	edge_pushes.resize(hull)
	var needs_fit = false
	var radius = 60.0 * scale
	var minimum_gap = 0.25 * scale
	var maximum_gap = 18.0 * scale
	for edge in boundary:
		var start = edge[0] + edge[3]
		var end = edge[0] + edge[1] + edge[4]
		if joint.distance_to(Geometry.get_closest_point_to_segment_2d(joint, start, end)) > radius:
			continue
		var steps = max(1, int(ceil(start.distance_to(end) / (5.0 * scale))))
		for i in range(steps + 1):
			var sample = start.linear_interpolate(end, float(i) / steps)
			if sample.distance_to(joint) > radius or Geometry.is_point_in_polygon(sample, contour):
				continue
			var nearest = Vector2.ZERO
			var distance = INF
			var seam = 0
			for j in range(hull):
				var point = Geometry.get_closest_point_to_segment_2d(sample, contour[j], contour[(j + 1) % hull])
				var gap = sample.distance_squared_to(point)
				if gap < distance:
					distance = gap
					nearest = point
					seam = j
			# Follow only near misses at the knee, not the intentional
			# upper seam of the stocking or geometry on the other leg.
			if distance > minimum_gap * minimum_gap and distance < maximum_gap * maximum_gap:
				var other = (seam + 1) % hull
				var length = contour[seam].distance_to(contour[other])
				var t = clamp(contour[seam].distance_to(nearest) / length, 0.0, 1.0) if length > 0.0001 else 0.0
				var a = 1.0 - t
				# Move the endpoints of the segment that actually missed the
				# skin, even when a long edge has no vertex near the crease.
				var push = (sample - nearest) * 1.23 / (a * a + t * t)
				for endpoint in [[seam, a], [other, t]]:
					var index = endpoint[0]
					var candidate = push * endpoint[1]
					if candidate.length_squared() > maximum_gap * maximum_gap:
						candidate = candidate.normalized() * maximum_gap
					if candidate.length_squared() > edge_pushes[index].length_squared():
						edge_pushes[index] = candidate
						needs_fit = true
	if !needs_fit:
		return points
	var result = PoolVector2Array()
	for i in range(points.size()):
		var vertex = points[i]
		var push = Vector2.ZERO
		if i < hull:
			push = edge_pushes[i]
		else:
			for j in range(hull):
				if edge_pushes[j] == Vector2.ZERO:
					continue
				var fade = 1.0 - smoothstep(6.0, 42.0, vertex.distance_to(contour[j]) / scale)
				var candidate = edge_pushes[j] * fade
				if candidate.length_squared() > push.length_squared():
					push = candidate
		var knee_weight = 1.0 - smoothstep(65.0, 125.0, vertex.distance_to(joint) / scale)
		result.append(vertex + push * knee_weight)
	return _limit_mesh_folds(result, points, attachment.triangles)


func _limit_mesh_folds(points, baseline, triangles):
	# At thin seams, neighbouring vertices may move in different directions.
	# Shorten only the corrections involved in a newly folded triangle.
	for _pass in range(3):
		var adjusted = false
		for i in range(0, triangles.size(), 3):
			var a = int(triangles[i])
			var b = int(triangles[i + 1])
			var c = int(triangles[i + 2])
			var first = (baseline[b] - baseline[a]).cross(baseline[c] - baseline[a])
			if abs(first) < 0.5:
				continue
			var last = (points[b] - points[a]).cross(points[c] - points[a])
			if last * first >= 0.0:
				continue
			var low = 0.0
			var high = 1.0
			for _step in range(7):
				var middle = (low + high) * 0.5
				var start = baseline[a].linear_interpolate(points[a], middle)
				var edge_b = baseline[b].linear_interpolate(points[b], middle) - start
				var edge_c = baseline[c].linear_interpolate(points[c], middle) - start
				if edge_b.cross(edge_c) * first >= first * first * 0.08:
					low = middle
				else:
					high = middle
			for vertex in [a, b, c]:
				points[vertex] = baseline[vertex].linear_interpolate(points[vertex], low)
			adjusted = true
		if !adjusted:
			break
	return points


func _neutral_leg_rows(pose, legs, cache):
	# Split legs and their equipment use the main solved pose.
	var key = "neutral_leg_rows"
	if pose == bones and cache.has(key):
		return cache[key]
	var rows = _pose_table(pose)
	var factors = MODIFIERS.post_ik_visual_factors({"legs": legs}, contract.CONTRACT_ID)
	for i in range(bone_names_by_index.size()):
		var factor = factors.get(bone_names_by_index[i], Vector2.ONE)
		rows[i][0] /= factor.x
		rows[i][2] /= factor.x
		rows[i][1] /= factor.y
		rows[i][3] /= factor.y
	if pose == bones:
		cache[key] = rows
	return rows


func _split_leg_motion_field(side, legs, cache):
	var parts = {}
	var hip_name = "Hip" + side
	var shin_name = "Shin" + side
	for slot in slot_data:
		var name = str(slot.name)
		if name in [hip_name, hip_name + "_up", shin_name]:
			parts[name] = slot
	var triangles = []
	var boundary = []
	for candidates in [[hip_name, hip_name + "_up"], [shin_name]]:
		for name in candidates:
			if !parts.has(name):
				continue
			var slot = parts[name]
			var mesh = _resolve_attachment(slot)
			if mesh.get("vertices", []).empty() or mesh.get("triangles", []).empty():
				continue
			var pose = _pose_for(slot)
			var deform = _attachment_deform(slot, mesh)
			var count = mesh.get("uvs", []).size()
			var neutral = _mesh_points(mesh.vertices, count, deform, pose, _neutral_leg_rows(pose, legs, cache))
			var drawn = _mesh_points(mesh.vertices, count, deform, pose, _skinning_rows(slot, cache))
			drawn = _align_shin_knee(drawn, slot, mesh, deform, pose, cache)
			_append_leg_motion(neutral, drawn, mesh.triangles, triangles, boundary)
			break
	return {} if triangles.empty() else {"triangles": triangles, "boundary": boundary}


func _append_leg_motion(neutral, drawn, indices, triangles, boundary):
	var edges = {}
	for i in range(0, indices.size(), 3):
		var ia = int(indices[i])
		var ib = int(indices[i + 1])
		var ic = int(indices[i + 2])
		var a = neutral[ia]
		var b = neutral[ib]
		var c = neutral[ic]
		var ab = b - a
		var ac = c - a
		var area = ab.cross(ac)
		if abs(area) > 0.000001:
			var bounds = Rect2(a, Vector2.ZERO).expand(b).expand(c)
			triangles.append([bounds, a, ab, ac, 1.0 / area, drawn[ia] - a, drawn[ib] - b, drawn[ic] - c])
		for pair in [[ia, ib], [ib, ic], [ic, ia]]:
			var edge = Vector2(min(pair[0], pair[1]), max(pair[0], pair[1]))
			edges[edge] = edges.get(edge, 0) + 1
	for edge in edges:
		if edges[edge] != 1:
			continue
		var from = int(edge.x)
		var to = int(edge.y)
		var delta = neutral[to] - neutral[from]
		boundary.append([neutral[from], delta, delta.length_squared(), drawn[from] - neutral[from], drawn[to] - neutral[to]])


func _leg_motion_at(point, field):
	for face in field.triangles:
		if !face[0].has_point(point):
			continue
		var relative = point - face[1]
		var b = relative.cross(face[3]) * face[4]
		var c = face[2].cross(relative) * face[4]
		if b >= 0.0 and c >= 0.0 and b + c <= 1.0:
			return [face[5] * (1.0 - b - c) + face[6] * b + face[7] * c, 0.0]
	var distance = INF
	var motion = Vector2.ZERO
	for edge in field.boundary:
		var relative = point - edge[0]
		var along = clamp(relative.dot(edge[1]) / edge[2], 0.0, 1.0) if edge[2] > 0.000001 else 0.0
		var gap = (relative - edge[1] * along).length_squared()
		if gap < distance:
			distance = gap
			motion = edge[3].linear_interpolate(edge[4], along)
	return [motion, sqrt(distance)]


# Keep the knee overlap on the same deformation field as the adjoining Hip.
# A uniform Shin scale cannot do this: Hip vertices have different bone weights.
# Preserve the neutral artwork offset, transfer the nearest Hip surface motion,
# then fade back to the ordinary compensated Shin over the upper calf.
func _align_shin_knee(points, slot, attachment, deform, pose, rows):
	var name = str(slot.get("name", "")).to_lower()
	if !name.begins_with("shin") or is_equal_approx(float(proportions.get("legs", 1.0)), 1.0):
		return points
	var hip_name = "HipL" if name.begins_with("shinl") else "HipR" if name.begins_with("shinr") else ""
	var knee_name = "spine136" if hip_name == "HipL" else "spine129"
	if hip_name.empty() or !pose.has(knee_name):
		return points
	if rows == null:
		rows = {}
	var key = "knee_surface/" + hip_name
	if !rows.has(key):
		var hip_slot = {}
		var hip = {}
		# Some takes replace Hip with Hip_up. Resolve the visible attachment,
		# including the selected race, instead of using a hidden setup mesh.
		for candidate_name in [hip_name, hip_name + "_up"]:
			for candidate in slot_data:
				if str(candidate.get("name", "")) != candidate_name:
					continue
				var resolved = _resolve_attachment(candidate)
				if !resolved.get("vertices", []).empty() and !resolved.get("triangles", []).empty():
					hip_slot = candidate
					hip = resolved
				break
			if !hip.empty():
				break
		if hip.get("vertices", []).empty() or hip.get("triangles", []).empty():
			rows[key] = {}
		else:
			var full = _pose_table(pose)
			var neutral = full.duplicate(true)
			var factors = MODIFIERS.post_ik_visual_factors({"legs": float(proportions.get("legs", 1.0))}, contract.CONTRACT_ID)
			for i in range(bone_names_by_index.size()):
				var factor = factors.get(bone_names_by_index[i], Vector2.ONE)
				neutral[i][0] /= factor.x
				neutral[i][2] /= factor.x
				neutral[i][1] /= factor.y
				neutral[i][3] /= factor.y
			var hip_deform = _attachment_deform(hip_slot, hip)
			# The thigh may have a separate layer pose. Sample its actual drawn
			# deformation field while keeping the shin's own neutral baseline.
			var hip_pose = _pose_for(hip_slot)
			var hip_full = _pose_table(hip_pose)
			var hip_neutral = hip_full.duplicate(true)
			for i in range(bone_names_by_index.size()):
				var factor = factors.get(bone_names_by_index[i], Vector2.ONE)
				hip_neutral[i][0] /= factor.x
				hip_neutral[i][2] /= factor.x
				hip_neutral[i][1] /= factor.y
				hip_neutral[i][3] /= factor.y
			var knee = neutral[bone_names_by_index.find(knee_name)]
			var scale = _display_scale()
			var knee_transform = Transform2D(Vector2(knee[0], -knee[2]) * scale, Vector2(knee[1], -knee[3]) * scale, Vector2(knee[4], -knee[5]) * scale)
			rows[key] = {
				"slot": hip_slot.name,
				"attachment": hip.get("_attachment_name", ""),
				"rows": neutral,
				"neutral": _mesh_points(hip.vertices, hip.get("uvs", []).size(), hip_deform, hip_pose, hip_neutral),
				"drawn": _mesh_points(hip.vertices, hip.get("uvs", []).size(), hip_deform, hip_pose, hip_full),
				"triangles": hip.triangles,
				"knee_inverse": knee_transform.affine_inverse(),
				"length": float(pose[knee_name].definition.get("length", 250.0)),
			}
	var surface = rows[key]
	if surface.empty():
		return points
	var baseline = _mesh_points(attachment.vertices, attachment.get("uvs", []).size(), deform, pose, surface.rows)
	var result = PoolVector2Array(points)
	for i in range(points.size()):
		var along = surface.knee_inverse.xform(baseline[i]).x
		var blend = clamp((along - surface.length * 0.08) / (surface.length * 0.27), 0.0, 1.0)
		if blend >= 1.0:
			continue
		blend = blend * blend * (3.0 - 2.0 * blend)
		var joined = baseline[i] + _nearest_mesh_motion(baseline[i], surface.neutral, surface.drawn, surface.triangles)
		result[i] = joined.linear_interpolate(points[i], blend)
	return result


func _nearest_mesh_motion(point, neutral, drawn, triangles):
	var nearest_distance = INF
	var motion = Vector2.ZERO
	for i in range(0, triangles.size(), 3):
		var ia = int(triangles[i])
		var ib = int(triangles[i + 1])
		var ic = int(triangles[i + 2])
		var a = neutral[ia]
		var b = neutral[ib]
		var c = neutral[ic]
		var determinant = (b - a).cross(c - a)
		if abs(determinant) > 0.000001:
			var wb = (point - a).cross(c - a) / determinant
			var wc = (b - a).cross(point - a) / determinant
			if wb >= 0.0 and wc >= 0.0 and wb + wc <= 1.0:
				return (drawn[ia] - a) * (1.0 - wb - wc) + (drawn[ib] - b) * wb + (drawn[ic] - c) * wc
		for edge in [[ia, ib], [ib, ic], [ic, ia]]:
			var start = neutral[edge[0]]
			var end = neutral[edge[1]]
			var segment = end - start
			var amount = clamp((point - start).dot(segment) / segment.length_squared(), 0.0, 1.0) if segment.length_squared() > 0.000001 else 0.0
			var distance = point.distance_squared_to(start + segment * amount)
			if distance < nearest_distance:
				nearest_distance = distance
				motion = (drawn[edge[0]] - start).linear_interpolate(drawn[edge[1]] - end, amount)
	return motion


func _mesh_points(vertices, uv_size, deform = [], pose = null, rows = null):
	if pose == null:
		pose = bones
	# Worked out once here rather than inside `_world_point`.  It is the same
	# number for every vertex of every mesh, and it costs a dictionary build and
	# three divisions in the modifiers to arrive at; asked once per bone weight it
	# was 4.1 ms of the 17.6 an animated frame took.
	var display_scale = _display_scale()
	var points = PoolVector2Array()
	var deform_size = deform.size()
	# Weighted Spine vertices begin with an integer bone count.  An unweighted mesh
	# always has exactly twice as many entries as its UV list and is handled below.
	var unweighted = vertices.size() == uv_size
	if unweighted:
		var root = pose["root"]
		for i in range(0, vertices.size(), 2):
			var deform_x = float(deform[i]) if i < deform_size else 0.0
			var deform_y = float(deform[i + 1]) if i + 1 < deform_size else 0.0
			points.append(_world_point(root, Vector2(float(vertices[i]) + deform_x, float(vertices[i + 1]) + deform_y), display_scale))
		return points
	# `_world_point` is written out in the loop, in its own order of operations, so the
	# points come out the same to the bit.  A call on each of two thousand bone weights
	# was much of what skinning cost, and so was finding the bone through the export's
	# list of dictionaries and then the pose's on every weight - see `_pose_table`.
	if rows == null:
		rows = _pose_table(pose)
	var vertex_count = vertices.size()
	var cursor = 0
	var deform_cursor = 0
	while cursor < vertex_count:
		var count = int(vertices[cursor])
		cursor += 1
		var result = Vector2.ZERO
		for _i in range(count):
			var deform_x = float(deform[deform_cursor]) if deform_cursor < deform_size else 0.0
			var deform_y = float(deform[deform_cursor + 1]) if deform_cursor + 1 < deform_size else 0.0
			var local = Vector2(float(vertices[cursor + 1]) + deform_x, float(vertices[cursor + 2]) + deform_y)
			var bone = rows[int(vertices[cursor])]
			result += Vector2((bone[0] * local.x + bone[1] * local.y + bone[4]) * display_scale, -(bone[2] * local.x + bone[3] * local.y + bone[5]) * display_scale) * float(vertices[cursor + 3])
			cursor += 4
			deform_cursor += 2
		points.append(result)
	return points
func _world_point(bone, point, display_scale = -1.0):
	if display_scale < 0.0:
		display_scale = _display_scale()
	return Vector2((bone.a * point.x + bone.b * point.y + bone.x) * display_scale, -(bone.c * point.x + bone.d * point.y + bone.y) * display_scale)
