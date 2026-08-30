extends Reference

# Bone modifiers shared by every doll that satisfies a skeleton contract.
#
# All operations are RELATIVE and compose by multiplication: two modifiers acting
# on the same bone multiply together instead of overwriting each other.  The old
# paperdoll writes absolute bone scales from GeneratorData, where `ass_size` runs
# after `height` and silently discards the height scaling of the same bone; that
# whole class of bug is impossible here by construction.
#
# Factors are per axis (Vector2), because stretching a body is not a uniform
# scale: the torso gets longer without getting wider.

# Every skeleton these modifiers know how to drive.  A modifier is written once,
# against the female rig's bone names, and translated per contract below.
const CONTRACTS = {
	"doll2_v1": preload("res://Character_generator/Doll2Spine/universal/doll_contract.gd"),
	"doll2_male_v1": preload("res://Character_generator/Doll2Spine/universal/doll_contract_male.gd"),
}
const DEFAULT_CONTRACT = "doll2_v1"

const BREAST_BONES = [
	"nipple2_l", "nipple2_r", "nipple3_l", "nipple3_r",
	"nipple4_l", "nipple4_r", "nipple5_l", "nipple5_r",
]

# spine1 widens the pelvis for Butt size, but the two thigh roots must keep the
# world basis they had before that widening.  Their positions still inherit the
# wider pelvis; only the scale basis is compensated in doll2_preview.gd.
const BUTT_SCALE_COMPENSATION_BONES = ["spine46", "bone"]

# The male export is the same skeleton with a few bones spelled differently and
# the breast chain absent: it names the collarbones `collarb_*` and carries a
# proper leg hierarchy (`hip`, `shin`, `foot`) where the female rig has `spine46`
# and `bone`.  Translating the names is enough - a second copy of every modifier
# would be two things to keep in step.  `null` means the bone has no counterpart
# on that rig and the operation is dropped for it.
const BONE_ALIASES = {
	"doll2_male_v1": {
		"collarbone_l": "collarb_l",
		"collarbone_r": "collarb_r",
		"spine46": "hip_l",
		"bone": "hip_r",
		"chest_l": null,
		"chest_r": null,
		"nipple2_l": null, "nipple2_r": null,
		"nipple3_l": null, "nipple3_r": null,
		"nipple4_l": null, "nipple4_r": null,
		"nipple5_l": null, "nipple5_r": null,
		"eyes_l": "eye_l",
		"eyes_r": "eye_r",
	},
}


# A bone's name on the given rig, or "" when that rig has no such bone.
static func rig_bone(bone_name, contract_id):
	var aliases = BONE_ALIASES.get(contract_id, {})
	if !aliases.has(bone_name):
		return bone_name
	var alias = aliases[bone_name]
	return "" if alias == null else str(alias)


static func contract_bones(contract_id):
	return CONTRACTS.get(contract_id, CONTRACTS[DEFAULT_CONTRACT]).BONES


# ------------------------------------------------------------- free sliders --

# Continuously adjustable per-bone modifiers, on top of the height tier.  These
# are build controls: how heavy or slight a character is, as opposed to how tall.
#
# They cannot fight the height tier, by construction rather than by care.  A
# bone's local X runs along its length and its Y across it, so height works the
# long way - it stretches the spine chain - while every slider here works the
# broad way.  The two multiply per axis and never touch the same number.
#
# Nothing here is wired to a character stat yet; they exist to find out which
# bones are worth exposing.  Turn `build` up and `legs` down for a squat dwarf,
# everything down for something fey and slight.
#
const MODIFIERS = {
	# `head_size`, on the same bone the height tier counter-scales.  The two do not
	# fight: every operation here is relative and they multiply, so a towering
	# character with a big head still reads as small-headed for their height, which
	# is what the tier is for.  The range is deliberately narrower than the tier's -
	# past about a tenth either way the neck stops meeting the jaw.
	#
	# Everything on the face and every hair chain hangs off `head`, so one bone
	# carries the whole thing.
	"head_size": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_HEAD_SIZE",
		"tune": true,
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"steps": {
			"default": "average",
			"order": ["tiny", "small", "average", "big", "huge"],
			"values": {"tiny": 0.88, "small": 0.94, "average": 1.0, "big": 1.06, "huge": 1.12},
		},
		"ops": [
			{"bone": "head"},
		],
	},
	"eyes_scale": {
		"contract": "doll2_v1", "label": "DOLL2_PREVIEW_EYES_SCALE",
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"ops": [{"bone": "eyes_l"}, {"bone": "eyes_r"}],
	},
	"brow_scale": {
		"contract": "doll2_v1", "label": "DOLL2_PREVIEW_BROW_SCALE",
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"ops": [{"bone": "brov_l"}, {"bone": "brov_r"}],
	},
	"pupil_scale": {
		"contract": "doll2_v1", "label": "DOLL2_PREVIEW_PUPIL_SCALE",
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"ops": [{"bone": "pupil_l"}, {"bone": "pupil_r"}],
	},
	"nose_scale": {
		"contract": "doll2_v1", "label": "DOLL2_PREVIEW_NOSE_SCALE",
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"ops": [{"bone": "nose"}],
	},
	"lips_scale": {
		"contract": "doll2_v1", "label": "DOLL2_PREVIEW_LIPS_SCALE",
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"ops": [{"bone": "lips"}],
	},
	"breast_scale": {
		"contract": "doll2_v1",
		"contracts": ["doll2_v1"],
		"label": "DOLL2_PREVIEW_BREAST_SCALE",
		"range": {"default": 1.0, "minimum": 0.85, "maximum": 1.15, "step": 0.01},
		"ops": [
			{"bone": "nipple2_l"}, {"bone": "nipple2_r"},
			{"bone": "nipple3_l"}, {"bone": "nipple3_r"},
			{"bone": "nipple4_l"}, {"bone": "nipple4_r"},
			{"bone": "nipple5_l"}, {"bone": "nipple5_r"},
		],
	},
	"muscle_alpha": {
		"contract": "doll2_v1",
		"contracts": ["doll2_v1"],
		"label": "DOLL2_PREVIEW_MUSCLE_ALPHA",
		"display": "percent",
		"range": {"default": 30.0, "minimum": 0.0, "maximum": 100.0, "step": 1.0},
		# This is a visual slot modifier rather than a bone transform.  Keeping it
		# here lets it share the same slider/default/state machinery.
		"ops": [],
	},
	"build": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_BUILD",
		"range": {"default": 1.0, "minimum": 0.8, "maximum": 1.3, "step": 0.01},
		# spine2 carries the whole upper body, and everything below it inherits
		# the scale, so one bone widens the chest, ribs and arms together.
		# Scaling its children as well would multiply the effect down the chain -
		# the same trap the height tier has to avoid.
		"ops": [
			{"bone": "spine2", "axis": "y", "op": "mul"},
		],
	},
	"waist": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_WAIST",
		"range": {"default": 1.0, "minimum": 0.8, "maximum": 1.4, "step": 0.01},
		# `build` widens the whole trunk, so the waist stays as narrow relative to
		# the chest as it started - the figure gets bigger, not heavier.  This one
		# changes the shape: spine3 widens the middle and spine4 takes the same
		# widening back off the chest above it.  Measured in bands down the
		# silhouette, it moves the narrowest point by a fifth while the chest and
		# the hips do not move at all.
		"ops": [
			{"bone": "spine3", "axis": "y", "op": "mul"},
			{"bone": "spine4", "axis": "y", "op": "div"},
		],
	},
	"shoulders": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_SHOULDERS",
		"range": {"default": 1.0, "minimum": 0.8, "maximum": 1.3, "step": 0.01},
		# A collarbone runs outward from the spine, so its length is the breadth
		# of the shoulders and the arm hangs from wherever it ends.
		"ops": [
			{"bone": "collarbone_l", "axis": "x", "op": "mul"},
			{"bone": "collarbone_r", "axis": "x", "op": "mul"},
		],
	},
	"arms": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_ARM_THICKNESS",
		"range": {"default": 1.0, "minimum": 0.8, "maximum": 1.35, "step": 0.01},
		# Only the upper arm is scaled; the forearm and hand inherit it, which
		# thickens the whole limb evenly instead of squaring the lower half.
		"ops": [
			{"bone": "shoulder_l", "axis": "y", "op": "mul"},
			{"bone": "shoulder_r", "axis": "y", "op": "mul"},
		],
	},
	"legs": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_LEG_THICKNESS",
		"range": {"default": 1.0, "minimum": 0.8, "maximum": 1.35, "step": 0.01},
		# The thighs, again with the shin and foot inheriting.  The rig names the
		# left leg spine46 and the right one `bone`; the IK chains drive their
		# rotation, never their scale, so this does not fight them.
		"ops": [
			{"bone": "spine46", "axis": "y", "op": "mul"},
			{"bone": "bone", "axis": "y", "op": "mul"},
		],
	},
	# The character's `ass_size`, and the only handle the pelvis has.  Named sizes
	# rather than a free range: the stat carries one of these six and nothing in
	# between, so a number the game can never ask for would only be a trap.
	#
	# spine1 is the lower half of the trunk, the mirror of spine2 above it.  The
	# pelvis bones themselves are the wrong handle - the mesh holds its outer edge
	# on spine1, so scaling one of them moves 2-5 px - and stretching spine1 the
	# long way instead drops the hip until the leg IK crosses the legs over each
	# other.  Width is what a bigger backside can be on a figure drawn from the
	# front, which is what the old doll did too: it scaled its pelvis sprite in the
	# one axis it had, 1.0 flat to 1.15 huge, and touched nothing else.
	"butt": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_BUTT_SIZE",
		"range": {"default": 1.0, "minimum": 0.9, "maximum": 1.14, "step": 0.01},
		"steps": {
			"default": "average",
			"order": ["flat", "small", "average", "big", "huge", "masculine"],
			"values": {
				"flat": 0.9, "small": 0.95, "average": 1.0,
				"big": 1.07, "huge": 1.14, "masculine": 0.9,
			},
		},
		"ops": [
			{"bone": "spine1", "axis": "y", "op": "mul"},
		],
	},
	# `penis_size` and `balls_size`, the same three sizes the game has carried
	# since the old doll.  The art is one pair of meshes, so a size is a scale:
	# the shaft hangs off spine6 and the sack off spine9, and the bones below each
	# of them inherit, so one bone apiece moves the whole thing.  Uniform rather
	# than per axis - a bigger one is longer *and* thicker.
	#
	# `tune` puts a free slider beside the named picker in the preview panel, so
	# these three numbers can be found by eye and then written down here.
	"dick": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_DICK_SIZE",
		"tune": true,
		"range": {"default": 1.0, "minimum": 0.7, "maximum": 1.4, "step": 0.01},
		"steps": {
			"default": "average",
			"order": ["small", "average", "big"],
			"values": {"small": 0.7, "average": 1.0, "big": 1.2},
		},
		"ops": [
			{"bone": "spine6"},
		],
	},
	"balls": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_BALLS_SIZE",
		"tune": true,
		"range": {"default": 1.0, "minimum": 0.7, "maximum": 1.4, "step": 0.01},
		"steps": {
			"default": "average",
			"order": ["small", "average", "big"],
			"values": {"small": 0.85, "average": 1.0, "big": 1.2},
		},
		# The two are siblings under spine1, not a chain: scaling one leaves the
		# other where it was.
		"ops": [
			{"bone": "spine9"},
			{"bone": "spine10"},
		],
	},
}

# Face placement is additive and applied after animation sampling. On this rig
# local X follows the face vertically and local Y horizontally.
const POSITION_MODIFIERS = {
	"eyes_width": {
		"label": "DOLL2_PREVIEW_EYES_WIDTH",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		# Eye and pupil meshes use parallel sibling bones under the head, so both
		# pairs need the same offset to remain centred on one another.
		"ops": [
			{"bone": "eyes_l", "axis": "y", "amount": 1.0},
			{"bone": "eyes_r", "axis": "y", "amount": -1.0},
			{"bone": "pupil_l", "axis": "y", "amount": 1.0},
			{"bone": "pupil_r", "axis": "y", "amount": -1.0},
		],
	},
	"eyes_height": {
		"label": "DOLL2_PREVIEW_EYES_HEIGHT",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		"ops": [{"bone": "eyes_l", "axis": "x"}, {"bone": "eyes_r", "axis": "x"}],
	},
	"brow_width": {
		"label": "DOLL2_PREVIEW_BROW_WIDTH",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		"ops": [{"bone": "brov_l", "axis": "y", "amount": 1.0}, {"bone": "brov_r", "axis": "y", "amount": -1.0}],
	},
	"brow_height": {
		"label": "DOLL2_PREVIEW_BROW_HEIGHT",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		"ops": [{"bone": "brov_l", "axis": "x"}, {"bone": "brov_r", "axis": "x"}],
	},
	"pupil_height": {
		"label": "DOLL2_PREVIEW_PUPIL_HEIGHT",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		"ops": [{"bone": "pupil_l", "axis": "x"}, {"bone": "pupil_r", "axis": "x"}],
	},
	"nose_height": {
		"label": "DOLL2_PREVIEW_NOSE_HEIGHT",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		"ops": [{"bone": "nose", "axis": "x"}],
	},
	"lips_height": {
		"label": "DOLL2_PREVIEW_LIPS_HEIGHT",
		"range": {"default": 0.0, "minimum": -7.0, "maximum": 7.0, "step": 0.1},
		"ops": [{"bone": "lips", "axis": "x"}],
	},
	"waist_width": {
		"label": "DOLL2_PREVIEW_WAIST_WIDTH",
		"range": {"default": 0.0, "minimum": -15.0, "maximum": 15.0, "step": 0.1},
		# The spine is turned roughly 90 degrees in setup pose: its children's
		# local Y is the horizontal screen axis. Positive values widen the waist;
		# negative values move both sides towards its centre line.
		"ops": [
			{"bone": "pelvisl_1", "axis": "y", "amount": 1.0},
			{"bone": "sternum_l", "axis": "y", "amount": 1.0},
			{"bone": "pelvisr_1", "axis": "y", "amount": -1.0},
			{"bone": "sternum_r", "axis": "y", "amount": -1.0},
		],
		# Moving the four controls apart would also stretch their own meshes.
		# Counter that along their green/local-Y axis: narrow = 1.30, rest = 1.0,
		# wide = 0.70.
		"scale": {"at_min": 1.3, "at_max": 0.7},
		"scale_ops": [
			{"bone": "pelvisl_1", "axis": "y"},
			{"bone": "sternum_l", "axis": "y"},
			{"bone": "pelvisr_1", "axis": "y"},
			{"bone": "sternum_r", "axis": "y"},
		],
	},
	"waist_height": {
		"label": "DOLL2_PREVIEW_WAIST_HEIGHT",
		"range": {"default": 0.0, "minimum": -20.0, "maximum": 20.0, "step": 0.1},
		# Local X follows the vertical screen axis for all four waist controls.
		"ops": [
			{"bone": "pelvisl_1", "axis": "x"},
			{"bone": "sternum_l", "axis": "x"},
			{"bone": "pelvisr_1", "axis": "x"},
			{"bone": "sternum_r", "axis": "x"},
		],
	},
	"breast_height": {
		"contracts": ["doll2_v1"],
		"label": "DOLL2_PREVIEW_BREAST_HEIGHT",
		"range": {"default": 0.0, "minimum": -15.0, "maximum": 15.0, "step": 0.1},
		# Spine world Y points up.  These roots carry the second nipple bones and
		# every weighted breast mesh below them, so one offset moves each size as
		# a whole without changing its authored shape.
		"ops": [
			{"bone": "nipple2_l", "axis": "y", "space": "global"},
			{"bone": "nipple2_r", "axis": "y", "space": "global"},
			{"bone": "nipple3_l", "axis": "y", "space": "global"},
			{"bone": "nipple3_r", "axis": "y", "space": "global"},
			{"bone": "nipple4_l", "axis": "y", "space": "global"},
			{"bone": "nipple4_r", "axis": "y", "space": "global"},
			{"bone": "nipple5_l", "axis": "y", "space": "global"},
			{"bone": "nipple5_r", "axis": "y", "space": "global"},
		],
	},
}

const FACE_MODIFIER_ORDER = [
	"eyes_width", "eyes_height", "eyes_scale",
	"brow_width", "brow_height", "brow_scale",
	"pupil_height", "pupil_scale",
	"nose_height", "nose_scale", "lips_height", "lips_scale",
]

const WAIST_MODIFIER_ORDER = ["waist_width", "waist_height"]
const BREAST_MODIFIER_ORDER = ["breast_scale", "breast_height"]


# ---------------------------------------------------------------- layers --

# Hair layers share parts of the same rig, so each slot receives its own solved
# pose.  Only the authored length controls below are scaled; unrelated bones stay
# at setup scale and cannot pull another part of the hairstyle out of shape.

const LAYER_MODIFIERS = {
	"hair_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_HAIR_LENGTH",
		"range": {"default": 1.0, "minimum": 0.7, "maximum": 1.3, "step": 0.01},
		# The tiers the game carries, as factors on this layer.  `bald` is not a
		# length - the doll drops the hair instead - but it is listed so a value
		# the character already has never falls through to the default.
		#
		# `tune` keeps the free slider in the preview beside the named picker, which
		# is how these four numbers were found in the first place.
		"tune": true,
		"steps": {
			"default": "default",
			"order": ["short", "default", "middle", "long"],
			"values": {"bald": 1.0, "short": 0.78, "default": 1.0, "middle": 1.15, "long": 1.3},
		},

		"slots": ["hairs_base"],
		"bones": ["hair3_l", "hair3_r"],
		# Spine bones extend along local X. In this rig that is the visible strand
		# length even though the finished hair grows vertically on screen.
		"axis": "x",
	},
	"fringe_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_FRINGE_LENGTH",
		"range": {"default": 1.0, "minimum": 0.65, "maximum": 1.35, "step": 0.01},
		"slots": ["hairs_fringe"],
		"bones": ["fringe3_l", "fringe3_r"],
		"axis": "x",
	},
	"hair_back_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_HAIR_BACK_LENGTH",
		"range": {"default": 1.0, "minimum": 0.7, "maximum": 1.3, "step": 0.01},
		# The tiers the game carries, as factors on this layer.  `bald` is not a
		# length - the doll drops the hair instead - but it is listed so a value
		# the character already has never falls through to the default.
		#
		# `tune` keeps the free slider in the preview beside the named picker, which
		# is how these four numbers were found in the first place.
		"tune": true,
		"steps": {
			"default": "default",
			"order": ["short", "default", "middle", "long"],
			"values": {"bald": 1.0, "short": 0.78, "default": 1.0, "middle": 1.15, "long": 1.3},
		},

		"slots": ["hairs_back"],
		"bones": ["hair1_l4", "hair1_r4", "hair4_l2", "hair4_r2", "hair1_r11", "hair1_l12"],
		"axis": "x",
	},
	"hair_assist_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_ASSIST_LENGTH",
		"range": {"default": 1.0, "minimum": 0.7, "maximum": 1.3, "step": 0.01},
		# The tiers the game carries, as factors on this layer.  `bald` is not a
		# length - the doll drops the hair instead - but it is listed so a value
		# the character already has never falls through to the default.
		#
		# `tune` keeps the free slider in the preview beside the named picker, which
		# is how these four numbers were found in the first place.
		"tune": true,
		"steps": {
			"default": "default",
			"order": ["short", "default", "middle", "long"],
			"values": {"bald": 1.0, "short": 0.78, "default": 1.0, "middle": 1.15, "long": 1.3},
		},

		"slots": ["hairs_assist"],
		"bones": ["head3", "head7", "head5", "head10", "head15", "head17"],
		"axis": "y",
	},
}


# ------------------------------------------------------------------ height --

# Height is a step, not a slider: the game stores it as one of these six values
# and the old paperdoll authored a full set of proportions for each.
#
# These are that authored set, read off GeneratorData.transforms.height, and they
# are RAW: every one of them is relative to that rig's own baseline, not to this
# art.  Its `average` already stretches the spine and shrinks the head, so using
# the numbers directly would deform the default doll.  Everything below is
# therefore divided by the `average` row, which makes `average` render the Spine
# setup pose exactly and every other tier a relative deviation from it - the same
# proportions the old doll had, expressed against this art.
#
# `display` is the global scale, `torso` the stretch along the spine and `head`
# the counter-scale that keeps a short character big-headed and a towering one
# small-headed, which is what actually reads as age and stature.
#
# Two things from the old data are deliberately not carried over:
#   - its per-tier Y offset, which existed because that rig scaled about the
#     doll's centre.  This one scales about the feet, so a taller doll simply
#     grows upward and needs no compensation.
#   - its hand-written shoulder, hip and breast counter-scales, which are just
#     1/torso; they are derived here instead, so they can never drift apart.
const HEIGHT_ORDER = ["tiny", "petite", "short", "average", "tall", "towering"]
const HEIGHT_DEFAULT = "average"
const HEIGHT_TIERS_RAW = {
	"tiny": {"display": 0.75, "torso": 1.0, "head": 1.25},
	"petite": {"display": 0.85, "torso": 1.025, "head": 1.15},
	"short": {"display": 1.0, "torso": 1.05, "head": 0.95},
	"average": {"display": 1.1, "torso": 1.075, "head": 0.925},
	"tall": {"display": 1.2, "torso": 1.1, "head": 0.9},
	"towering": {"display": 1.3, "torso": 1.125, "head": 0.85},
}

# One bone carries the stretch, exactly as the old rig had a single `Spine` node
# holding the whole upper body.  Bone scale composes down the chain here, so
# stretching spine2, spine3 and spine4 together would cube the effect and no
# counter-scale further down could cancel it again.
const TORSO_BONES = ["spine2"]
# Direct children of the torso chain that must not be stretched with it, or the
# shoulders shear and the breasts smear sideways.  The right collarbone was
# spelled `collarbonr_r` until the August re-export straightened out the name.
const TORSO_CHILDREN = [
	"neck", "collarbone_l", "collarbone_r",
	"chest_l", "chest_r", "sternum_l", "sternum_r",
	"nipple2_l", "nipple2_r", "nipple3_l", "nipple3_r",
	"nipple4_l", "nipple4_r", "nipple5_l", "nipple5_r",
]


static func defaults():
	var result = {}
	for modifier_id in MODIFIERS.keys():
		result[modifier_id] = MODIFIERS[modifier_id].range.default
	for modifier_id in LAYER_MODIFIERS.keys():
		result[modifier_id] = LAYER_MODIFIERS[modifier_id].range.default
	for modifier_id in POSITION_MODIFIERS.keys():
		result[modifier_id] = POSITION_MODIFIERS[modifier_id].range.default
	return result


# One modifier by id, whichever of the two tables holds it.
static func modifier(modifier_id):
	if MODIFIERS.has(modifier_id):
		return MODIFIERS[modifier_id]
	if POSITION_MODIFIERS.has(modifier_id):
		return POSITION_MODIFIERS[modifier_id]
	return LAYER_MODIFIERS.get(modifier_id, null)


# The factor a named step stands for.  A modifier with `steps` is picked by name
# by both the preview and the character, so the two cannot drift apart.
static func step_factor(modifier_id, step_name):
	var definition = modifier(modifier_id)
	if definition == null or !definition.has("steps"):
		return 1.0
	var steps = definition.steps
	return float(steps.values.get(str(step_name), steps.values[steps.default]))


# {slot name: {bone: Vector2}} for the layers that are off their default length.
# A slot missing from the result is posed by the ordinary skeleton, so a doll with
# every slider at rest costs no extra work at all.
static func layer_factors(values, parents = {}, contract_id = DEFAULT_CONTRACT):
	var result = {}
	for modifier_id in LAYER_MODIFIERS.keys():
		var modifier = LAYER_MODIFIERS[modifier_id]
		var value = float(values.get(modifier_id, modifier.range.default))
		if value == modifier.range.default:
			continue
		var factor = Vector2(value, value)
		if modifier.get("axis", "both") == "x":
			factor = Vector2(value, 1.0)
		elif modifier.get("axis", "both") == "y":
			factor = Vector2(1.0, value)
		var factors = {}
		var affected = []
		for bone_name in modifier.get("bones", []):
			var rig_name = rig_bone(bone_name, contract_id)
			if rig_name != "":
				affected.append(rig_name)
		var chains = []
		for bone_name in modifier.get("chains", []):
			var rig_name = rig_bone(bone_name, contract_id)
			if rig_name != "":
				chains.append(rig_name)
		for bone_name in chain_segments(chains, int(modifier.get("from_leaf", 0)), parents):
			if !(bone_name in affected):
				affected.append(bone_name)
		for bone_name in affected:
			if bone_name in contract_bones(contract_id):
				factors[bone_name] = factor
			else:
				push_warning("Doll2 modifiers: unknown bone `%s` in contract %s" % [bone_name, contract_id])
		for slot_name in modifier.slots:
			result[slot_name] = factors
	return result


# A tier's proportions relative to the default one, so `average` is always 1.0.
static func height_tier(tier_id):
	var raw = HEIGHT_TIERS_RAW.get(tier_id, HEIGHT_TIERS_RAW[HEIGHT_DEFAULT])
	var base = HEIGHT_TIERS_RAW[HEIGHT_DEFAULT]
	return {
		"display": float(raw.display) / float(base.display),
		"torso": float(raw.torso) / float(base.torso),
		"head": float(raw.head) / float(base.head),
	}


static func display_scale(tier_id):
	return height_tier(tier_id).display


# Accumulated per-axis multiplier for every affected bone: {bone name: Vector2}.
# Bones absent from the result keep their setup scale.
static func bone_factors(values, tier_id = HEIGHT_DEFAULT, contract_id = DEFAULT_CONTRACT):
	var result = {}
	var tier = height_tier(tier_id)
	var stretch = float(tier.torso)
	if stretch != 1.0:
		for bone_name in TORSO_BONES:
			_accumulate(result, bone_name, Vector2(stretch, 1.0), contract_id)
		for bone_name in TORSO_CHILDREN:
			_accumulate(result, bone_name, Vector2(1.0 / stretch, 1.0), contract_id)
	if float(tier.head) != 1.0:
		_accumulate(result, "head", Vector2(tier.head, tier.head), contract_id)

	for modifier_id in MODIFIERS.keys():
		var modifier = MODIFIERS[modifier_id]
		var value = float(values.get(modifier_id, modifier.range.default))
		if value == modifier.range.default:
			continue
		for operation in modifier.ops:
			if !operation.has("bone"):
				continue
			# `div` applies the inverse, which is how a slider can widen one part
			# of a chain and take the widening back off the part below it.
			var amount = 1.0 / value if operation.get("op", "mul") == "div" and value != 0.0 else value
			var factor = Vector2(amount, amount)
			if operation.get("axis", "both") == "x":
				factor = Vector2(amount, 1.0)
			elif operation.get("axis", "both") == "y":
				factor = Vector2(1.0, amount)
			_accumulate(result, operation.bone, factor, contract_id)

	# Position controls may carry a scale compensation tied to the same slider.
	# Waist width uses this to shorten the four moved control bones along local Y
	# as they move apart, and lengthen them by the same amount as they move in.
	for modifier_id in POSITION_MODIFIERS.keys():
		var modifier = POSITION_MODIFIERS[modifier_id]
		if !modifier.has("scale_ops"):
			continue
		var value = float(values.get(modifier_id, modifier.range.default))
		if value == modifier.range.default:
			continue
		var span = float(modifier.range.maximum) - float(modifier.range.minimum)
		var percent = 0.5 if span == 0.0 else (value - float(modifier.range.minimum)) / span
		var scale_definition = modifier.scale
		var amount = lerp(float(scale_definition.at_min), float(scale_definition.at_max), percent)
		for operation in modifier.scale_ops:
			var factor = Vector2(amount, amount)
			if operation.get("axis", "both") == "x":
				factor = Vector2(amount, 1.0)
			elif operation.get("axis", "both") == "y":
				factor = Vector2(1.0, amount)
			_accumulate(result, operation.bone, factor, contract_id)

	for bone_name in result.keys():
		if !(bone_name in contract_bones(contract_id)):
			push_warning("Doll2 modifiers: unknown bone `%s` in contract %s" % [bone_name, contract_id])
			result.erase(bone_name)
	return result

# Accumulated local-position offsets for facial bones: {bone: Vector2}.
static func bone_offsets(values, contract_id = DEFAULT_CONTRACT):
	var result = {}
	for modifier_id in POSITION_MODIFIERS.keys():
		var modifier = POSITION_MODIFIERS[modifier_id]
		var value = float(values.get(modifier_id, modifier.range.default))
		if value == modifier.range.default:
			continue
		for operation in modifier.ops:
			if operation.get("space", "local") == "global":
				continue
			var rig_name = rig_bone(operation.bone, contract_id)
			if rig_name == "":
				continue
			var amount = value * float(operation.get("amount", 1.0))
			var offset = result.get(rig_name, Vector2.ZERO)
			if operation.get("axis", "x") == "y":
				offset.y += amount
			else:
				offset.x += amount
			result[rig_name] = offset
	for bone_name in result.keys():
		if !(bone_name in contract_bones(contract_id)):
			push_warning("Doll2 modifiers: unknown bone `%s` in contract %s" % [bone_name, contract_id])
			result.erase(bone_name)
	return result


# Additive offsets expressed in Spine world coordinates.  They are applied after
# the local hierarchy is solved, then inherited by every descendant.
static func bone_world_offsets(values, contract_id = DEFAULT_CONTRACT):
	var result = {}
	for modifier_id in POSITION_MODIFIERS.keys():
		var modifier = POSITION_MODIFIERS[modifier_id]
		var value = float(values.get(modifier_id, modifier.range.default))
		if value == modifier.range.default:
			continue
		for operation in modifier.ops:
			if operation.get("space", "local") != "global":
				continue
			var rig_name = rig_bone(operation.bone, contract_id)
			if rig_name == "":
				continue
			var amount = value * float(operation.get("amount", 1.0))
			var offset = result.get(rig_name, Vector2.ZERO)
			if operation.get("axis", "x") == "y":
				offset.y += amount
			else:
				offset.x += amount
			result[rig_name] = offset
	for bone_name in result.keys():
		if !(bone_name in contract_bones(contract_id)):
			push_warning("Doll2 modifiers: unknown bone `%s` in contract %s" % [bone_name, contract_id])
			result.erase(bone_name)
	return result

# The lower part of every strand: for each branch of a chain, the bone that sits
# `from_leaf` bones above its tip.  Scaling those and letting the rest of the
# branch inherit is what lengthens the ends without moving the crown.  Resolved
# against the live skeleton rather than listed by hand, so a re-rigged doll that
# still satisfies the contract keeps working.
static func chain_segments(chains, from_leaf, parents):
	if parents.empty():
		return chains
	var children = {}
	for bone_name in parents.keys():
		var parent_name = parents[bone_name]
		if !children.has(parent_name):
			children[parent_name] = []
		children[parent_name].append(bone_name)
	var result = []
	for root in chains:
		_collect_segments(root, from_leaf, children, result)
	return result


static func _collect_segments(bone_name, from_leaf, children, result):
	if _depth_to_leaf(bone_name, children) <= from_leaf:
		result.append(bone_name)
		return
	for child_name in children.get(bone_name, []):
		_collect_segments(child_name, from_leaf, children, result)


static func _depth_to_leaf(bone_name, children):
	var deepest = 0
	for child_name in children.get(bone_name, []):
		deepest = max(deepest, 1 + _depth_to_leaf(child_name, children))
	return deepest


static func _accumulate(factors, bone_name, factor, contract_id = DEFAULT_CONTRACT):
	var rig_name = rig_bone(bone_name, contract_id)
	if rig_name == "":
		return
	var current = factors.get(rig_name, Vector2.ONE)
	factors[rig_name] = Vector2(current.x * factor.x, current.y * factor.y)
