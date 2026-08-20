extends Reference

# Poses shared by every doll that satisfies a skeleton contract.
#
# A pose is a set of deltas over the setup pose, keyed by BONE NAMES rather than
# by scene node paths, so the same pose data applies to any skeleton exporting
# those bones - the female rig today, the male rig later.  `contract` records
# which skeleton contract the bone names were authored against; a pose whose
# contract no longer matches must be re-checked rather than silently applied.
#
# Draw order overrides live here too: Spine slot order is fixed in the export,
# but a pose that crosses the arms in front of the body has to reorder them, the
# way the old paperdoll rewrites z_index per pose.

const MODIFIERS = preload("res://Character_generator/Doll2Spine/universal/doll_modifiers.gd")

const POSES = {
	"default": {
		"contract": "doll2_v1",
		"label": "DOLL2_PREVIEW_POSE_DEFAULT",
		"bones": {},
		"ik_targets": {},
		"draw_order": {},
	},
	# Shape of a real entry, kept as documentation until poses are authored:
	#
	# "shy": {
	#     "contract": "doll2_v1",
	#     "label": "DOLL2_PREVIEW_POSE_SHY",
	#     "bones": {"spine2": {"rotation": -12.0, "position": [0.0, -4.0]}},
	#     "ik_targets": {"target1": [30.0, -410.0]},
	#     "draw_order": {"arm_left": 12, "arm_right": 8},
	# },
}


static func ids():
	var result = POSES.keys()
	result.sort()
	return result


static func pose(pose_id):
	return POSES.get(pose_id, POSES.default)


# Poses authored against another skeleton contract cannot be trusted on this rig.
# The contract has to be named by the caller: there are two rigs now, and a file
# that preloads one of them silently answers for the wrong doll.
static func compatible(pose_id, contract_id = MODIFIERS.DEFAULT_CONTRACT):
	return str(pose(pose_id).get("contract", "")) == contract_id
