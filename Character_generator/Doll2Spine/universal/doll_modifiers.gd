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

# The male export is the same skeleton with a few bones spelled differently and
# the breast chain absent: it names the collarbones `collarb_*` and carries a
# proper leg hierarchy (`hip`, `shin`, `foot`) where the female rig has `spine46`
# and `bone`.  Translating the names is enough - a second copy of every modifier
# would be two things to keep in step.  `null` means the bone has no counterpart
# on that rig and the operation is dropped for it.
const BONE_ALIASES = {
	"doll2_male_v1": {
		"collarbone_l": "collarb_l",
		"collarbonr_r": "collarb_r",
		"spine46": "hip_l",
		"bone": "hip_r",
		"chest_l": null,
		"chest_r": null,
		"nipple2_l": null, "nipple2_r": null,
		"nipple3_l": null, "nipple3_r": null,
		"nipple4_l": null, "nipple4_r": null,
		"nipple5_l": null, "nipple5_r": null,
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
# Head size is deliberately absent: head proportion is what height is for, and a
# second control over the same bone only lets the two disagree.

const MODIFIERS = {
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
			{"bone": "collarbonr_r", "axis": "x", "op": "mul"},
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
	"hips": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_HIPS",
		"range": {"default": 1.0, "minimum": 0.8, "maximum": 1.3, "step": 0.01},
		# spine1 is the lower half of the trunk, the mirror of spine2 above it.
		# The pelvis bones themselves turned out to be the wrong handle: the mesh
		# holds its outer edge on spine1, so scaling them moved almost nothing.
		"ops": [
			{"bone": "spine1", "axis": "y", "op": "mul"},
		],
	},
}


# ---------------------------------------------------------------- layers --

# Hair length is not an ordinary bone modifier, and it cannot be one.
#
# The rig hangs hair on six chains off the head: `hair1_l/r` (the volume and the
# long tails), `fringe1_l/r` (the bangs) and `head2`/`head6`, the rim chains that
# run down either side of the skull.  Every hair layer is weighted across several
# of them at once and they overlap heavily - a ponytail is 32% hair chain and 68%
# rim, a fringe is 40% hair chain - so scaling a chain moves part of every layer.
# That is what tore the accessories: the bones that moved carried a fifth of the
# mesh and the rest stayed where it was.
#
# So length is applied per layer instead.  Each entry scales ALL six chains, but
# only for the slots it names, and the doll solves a separate pose for it.  A
# layer therefore lengthens as a whole regardless of which chains its art happens
# to be weighted to, and two layers can differ without pulling on each other.
const HAIR_CHAIN_ROOTS = ["hair1_l", "hair1_r", "fringe1_l", "fringe1_r", "head2", "head6"]

# How much of a strand a length slider takes hold of, counted in bones up from
# the tip of each branch.
#
# Scaling a chain from its root moves the whole hairstyle rather than lengthening
# it: shortening drags the silhouette inward until a lock lies across the face,
# and lengthening swells the crown into a dome above the skull.  Taking hold part
# way down leaves the head where it is and only draws the ends out.
#
# Three is measured, not guessed.  At 1.5 the hair moves 69 px and the top fifth
# of it 8 px; from the root it moves 94 px and the crown 25.  Four reaches 86 px
# but starts to dome the very long styles, whose branches are only five bones
# deep, so the fourth bone up is already their root.  A branch shorter than this
# is scaled from its own root - there is nothing above the tip to keep.
const HAIR_FROM_LEAF = 3

# Deeper than any chain in the rig, so the whole branch is scaled from its root.
const WHOLE_CHAIN = 99

const LAYER_MODIFIERS = {
	"hair_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_HAIR_LENGTH",
		"range": {"default": 1.0, "minimum": 0.6, "maximum": 1.8, "step": 0.01},
		# The hair proper: the volume on the head and whatever falls behind it.
		# They are one hairstyle, so one slider drives both.
		"slots": ["hairs_base", "hairs_back"],
		"chains": HAIR_CHAIN_ROOTS,
		"from_leaf": HAIR_FROM_LEAF,
	},
	"fringe_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_FRINGE_LENGTH",
		"range": {"default": 1.0, "minimum": 0.6, "maximum": 1.8, "step": 0.01},
		# The fringe takes hold of its chains all the way to the roots.  It is a
		# short piece at the front with no length below the crown worth keeping,
		# and its art hangs mostly off the upper bones, so a partial hold barely
		# moves it: 40 px against 69 at 1.5.  Bangs get shorter or longer, and
		# nothing else in the hairstyle is in this mesh to be dragged about.
		"slots": ["hairs_fringe"],
		"chains": HAIR_CHAIN_ROOTS,
		"from_leaf": WHOLE_CHAIN,
	},
	"hair_assist_length": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_ASSIST_LENGTH",
		"range": {"default": 1.0, "minimum": 0.6, "maximum": 1.8, "step": 0.01},
		# Buns, braids, pigtails and tails.  Their own slider, so growing the hair
		# out does not grow the ponytail tied into it.
		"slots": ["hairs_assist"],
		"chains": HAIR_CHAIN_ROOTS,
		"from_leaf": HAIR_FROM_LEAF,
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
	for modifier_id in LAYER_MODIFIERS.keys():
		result[modifier_id] = LAYER_MODIFIERS[modifier_id].range.default
	return result


# One modifier by id, whichever of the two tables holds it.
static func modifier(modifier_id):
	if MODIFIERS.has(modifier_id):
		return MODIFIERS[modifier_id]
	return LAYER_MODIFIERS.get(modifier_id, null)


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
		var chains = []
		for bone_name in modifier.chains:
			var rig_name = rig_bone(bone_name, contract_id)
			if rig_name != "":
				chains.append(rig_name)
		for bone_name in chain_segments(chains, int(modifier.get("from_leaf", 0)), parents):
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
