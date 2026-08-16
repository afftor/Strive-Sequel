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

const CONTRACT = preload("res://Character_generator/Doll2Spine/universal/doll_contract.gd")


# ------------------------------------------------------------- free sliders --

# Continuously adjustable per-bone modifiers, on top of the height tier.
#
# Head size is deliberately not one of them: head proportion is what height is
# for, and a second control over the same bone only lets the two disagree.  The
# entry it used to hold is the shape a future one takes, say `ass_size`:
#
#   "ass_size": {
#       "contract": "doll2_v1",
#       "label": "DOLL2_PREVIEW_ASS_SIZE",
#       "range": {"default": 1.0, "minimum": 0.8, "maximum": 1.2, "step": 0.01},
#       "ops": [{"bone": "spine1", "axis": "y", "op": "mul"}],
#   }
#
# Anything listed here multiplies into the tier's factors rather than replacing
# them, so the two can never cancel each other out.
const MODIFIERS = {}


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
# shoulders shear and the breasts smear sideways.  `collarbonr_r` is spelled that
# way in the rig.
const TORSO_CHILDREN = [
	"neck", "collarbone_l", "collarbonr_r",
	"chest_l", "chest_r", "sternum_l", "sternum_r",
	"nipple2_l", "nipple2_r", "nipple3_l", "nipple3_r",
	"nipple4_l", "nipple4_r", "nipple5_l", "nipple5_r",
]


static func defaults():
	var result = {}
	for modifier_id in MODIFIERS.keys():
		result[modifier_id] = MODIFIERS[modifier_id].range.default
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
static func bone_factors(values, tier_id = HEIGHT_DEFAULT):
	var result = {}
	var tier = height_tier(tier_id)
	var stretch = float(tier.torso)
	if stretch != 1.0:
		for bone_name in TORSO_BONES:
			_accumulate(result, bone_name, Vector2(stretch, 1.0))
		for bone_name in TORSO_CHILDREN:
			_accumulate(result, bone_name, Vector2(1.0 / stretch, 1.0))
	if float(tier.head) != 1.0:
		_accumulate(result, "head", Vector2(tier.head, tier.head))

	for modifier_id in MODIFIERS.keys():
		var modifier = MODIFIERS[modifier_id]
		var value = float(values.get(modifier_id, modifier.range.default))
		if value == modifier.range.default:
			continue
		for operation in modifier.ops:
			if !operation.has("bone"):
				continue
			var factor = Vector2(value, value)
			if operation.get("axis", "both") == "x":
				factor = Vector2(value, 1.0)
			elif operation.get("axis", "both") == "y":
				factor = Vector2(1.0, value)
			_accumulate(result, operation.bone, factor)

	for bone_name in result.keys():
		if !(bone_name in CONTRACT.BONES):
			push_warning("Doll2 modifiers: unknown bone `%s` in contract %s" % [bone_name, CONTRACT.CONTRACT_ID])
			result.erase(bone_name)
	return result


static func _accumulate(factors, bone_name, factor):
	var current = factors.get(bone_name, Vector2.ONE)
	factors[bone_name] = Vector2(current.x * factor.x, current.y * factor.y)
