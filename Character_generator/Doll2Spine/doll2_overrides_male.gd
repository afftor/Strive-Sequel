extends Reference

# Hand-authored semantics for the male Doll 2 export.
#
# The male doll is a separate Spine project with a rig of its own, drawn to the
# same conventions: the same slot names, the same art above the neck, the same
# hue code.  All of that lives in doll2_overrides_shared.gd; this file carries
# only what is the male export's own - its three bodies, the armour sets cut for
# them, and the parts of the shared semantics that have no male art.
#
# A key set to `null` here drops the shared entry for this doll.

const SHARED = preload("res://Character_generator/Doll2Spine/doll2_overrides_shared.gd")

# --------------------------------------------------------------- routing ----

# The male bodies and the armour sets cut for them.  Collars are not listed: the
# slot route sends `equip_collar` to the collar group whatever folder ships it.
const FOLDER_MAP = {
	"01_body_nude_male": {"group": "body", "part": "body_male_base"},
	"01_body_nude_male_femboy": {"group": "body", "part": "body_male_femboy"},
	"15_beastkin_body_nude_male": {"group": "body", "part": "body_male_beastkin", "tags": ["beastkin"]},

	"23_dragon_male": {"group": "race_overlay", "part": "race_dragon"},
	# Two race overlays kept their female folder names in the male project, but
	# the art inside them is rigged to this skeleton: the kobold set in full, and
	# a third dragon torso.
	"23_dragon_female": {"group": "race_overlay", "part": "race_dragon"},
	"24_kobold_female": {"group": "race_overlay", "part": "race_kobold"},

	"100_armory_set_servant_male": {"group": "outfit", "part": "outfit_servant"},
	"104_armory_set_slave_male": {"group": "outfit", "part": "outfit_slave"},
	"121_armory_set_cloth_male": {"group": "outfit", "part": "outfit_cloth"},
	"121_armory_set_cloth2_male": {"group": "outfit", "part": "outfit_cloth2"},
	"122_armory_set_leather_male": {"group": "outfit", "part": "outfit_leather"},
	"122_armory_set_leather2_male": {"group": "outfit", "part": "outfit_leather2"},
	"123_armory_set_plate_male": {"group": "outfit", "part": "outfit_plate"},
	"123_armory_set_plate2_male": {"group": "outfit", "part": "outfit_plate2"},
	"123_armory_set_smith_male": {"group": "outfit", "part": "outfit_smith"},
	"124_armory_set_latex_male": {"group": "outfit", "part": "outfit_latex"},
	"124_armory_set_waiter_male": {"group": "outfit", "part": "outfit_waiter"},
	"125_armory_set_jacket_male": {"group": "outfit", "part": "outfit_jacket"},
	"125_armory_set_tentackle_male": {"group": "outfit", "part": "outfit_tentacle"},
}

# ------------------------------------------------------------------ axes ----

# The male rig has no breasts, no pregnancy and no extra-nipple slots, so the
# axes that drive them are dropped rather than left as dead dropdowns.
#
# What it does have instead is two builds - the base male body and the femboy -
# and a few armour sets carry a chest cut for each.  The art marks them `_m` and
# `_fb`, which is what this axis reads.
const AXES = {
	"tits_size": null,
	"pregnancy": null,
	"many_tits": null,
	"body_shape": {
		"values": ["male", "femboy"],
		"default": "male",
		"label": "DOLL2_PREVIEW_BODY_SHAPE",
		"parse": "tokens",
		"tokens": {"m": "male", "fb": "femboy"},
		"fallback": "male",
	},
}

const SLOT_AXES = {
	"equip_torso": "body_shape",
}

# ----------------------------------------------------------------- parts ----

# The femboy folder is a torso variant, not a whole body: it ships no legs and no
# nipples, so it borrows the base male ones.  Without this a femboy renders with
# bare hips and no legs at all.
const PART_SLOTS = {
	"body_male_femboy": {
		"leg_left": "legl_m",
		"leg_right": "legr_m",
		"nipples": "nipples_m",
	},
}

# The male dragon ships two skins of the same overlay: a plain one and a scaled
# one that only redraws the torso and the legs.  Everything the scaled variant
# does not list - arms, shoulders, pelvis, lower torso - is inherited from the
# first sub-part, exactly as on the female doll.
const PART_SPLITS = {
	"race_dragon": {
		"race_dragon": ["dragon_torso_m", "legl_m_dragon", "legr_m_dragon", "dragon_pelvis_m"],
		"race_dragon_scales": ["dragon_torso_m3", "legl_m_dragon2", "legr_m_dragon2"],
		"race_dragon_scales2": ["dragon_body3"],
	},
	# Two garments share the cloth folder, as two separate sets do on the female
	# doll, so they are split back apart rather than left as one set with a spare
	# torso.
	"outfit_cloth": {
		"outfit_cloth": ["torso_armor_cloth"],
		"outfit_cloth3": ["torso_armor_cloth3"],
	},
	# The latex set ships a second, slimmer cut: `arml1_armor_latex2` is the
	# femboy arm mesh exactly, down to the vertex, and the same goes for the
	# shoulders and `torso_armor_latex`.  The main set keeps the two chests the
	# body_shape axis picks between.
	"outfit_latex": {
		"outfit_latex": ["torso_armor_m_latex", "torso_armor_fb_latex", "arml1_armor_latex", "armr1_armor_latex", "shoulderl_armor_latex", "shoulderr_armor_latex"],
		"outfit_latex2": ["torso_armor_latex", "arml1_armor_latex2", "armr1_armor_latex2", "shoulderl_armor_latex2", "shoulderr_armor_latex2"],
	},
	# The male kobold art is cut differently from the female one: the plain skin
	# has no right arm and no pelvis of its own, and the spotted variant carries
	# both.  Listing what each one owns keeps that from being guessed.
	"race_kobold": {
		"race_kobold": ["kobold_arml1", "kobold_shoulderl1", "kobold_shoulderr1", "kobold_legl", "kobold_legr", "kobold_body1_1", "kobold_body2_1"],
		"race_kobold_spots": ["kobold_arml2", "kobold_armr2", "kobold_shoulderl2", "kobold_shoulderr2", "kobold_legl2", "kobold_legr2", "kobold_pelvis2", "kobold_body1_2", "kobold_body2_2"],
	},
}

const DEFAULTS = {
	"body": "body_male_base",
}

# Developer-facing names.  Anything absent is titled from its part id.
const DISPLAY = {
	"body_male_base": "Male base body",
	"body_male_femboy": "Male femboy body",
	"body_male_beastkin": "Male beastkin body",
	"race_dragon_scales": "Dragon (scales)",
	"race_dragon_scales2": "Dragon (scales 2)",
	"race_kobold": "Kobold",
	"race_kobold_spots": "Kobold (spots)",
	"kobold_head_kobold": "Kobold spots",
	"kobold_head_mask1": "Kobold cheek plates",
	"head_m_dragon": "Dragon cheek scales",
	"head_m_dragon2": "Dragon cheek scales 2",
	"outfit_servant": "Servant set",
	"outfit_slave": "Slave set",
	"outfit_cloth": "Cloth set",
	"outfit_cloth2": "Cloth set 2",
	"outfit_leather": "Leather set",
	"outfit_leather2": "Leather set 2",
	"outfit_plate": "Plate set",
	"outfit_plate2": "Plate set 2",
	"outfit_smith": "Smith set",
	"outfit_latex": "Latex set",
	"outfit_latex2": "Latex set (slim cut)",
	"outfit_cloth3": "Cloth set 3",
	"outfit_waiter": "Waiter set",
	"outfit_jacket": "Jacket set",
	"outfit_tentacle": "Tentacle set",
}

# The dragon's cheek scales are drawn for this face rather than the female one.
const PRESETS = {
	"dragon": {"race_overlay": "race_dragon", "face_markings": "head_m_dragon", "horns": "horn_dragon2", "tails": "tail_dragon", "wings": "Wings_dragon"},
}


# ----------------------------------------------------------------- beard ----

# The male export grew a beard slot - spelled `bread` in the Spine project - with
# nine beards, four moustaches and four of the two together.  Its attachments
# carry no folder, so the slot is what routes them.  All three tables live here
# rather than in the shared file because the female rig has no such art; move
# them across when it grows some.
const SLOT_ROUTES = {
	"bread": "beard",
}

const GROUP_DEFS = {
	"beard": {"kind": "options", "optional": true, "order": 11.5, "label": "DOLL2_PREVIEW_BEARD"},
}

# A beard is hair and takes a colour of its own: the game has carried
# `hair_facial_color` since the old doll, with nothing to paint until now.
const COLOR_CHANNELS = {
	"beard": {"anchor": "beard", "groups": ["beard"]},
}
