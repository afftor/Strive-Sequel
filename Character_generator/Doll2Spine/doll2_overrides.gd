extends Reference

# Hand-authored semantics for the female Doll 2 export.
#
# Everything both dolls agree on - groups, the art above the neck, the hue code,
# the colour channels - lives in doll2_overrides_shared.gd.  This file carries
# what is the female rig's alone: its bodies, its armour sets, and the breast and
# pregnancy axes the male rig has no slots for.  The builder merges the two, this
# file winning key by key.
#
# The generator (doll2_catalogue_builder.gd) reads both, applies them to a fresh
# Spine export and writes doll2_catalogue_gen.gd.  Everything here is checked
# against the export on every run: names that no longer exist are listed in the
# report as stale, so hand edits survive a re-export and never rot in silence.
# Nothing in this file may reference mesh, vertex or animation data.
#
# Vocabulary
#   folder  - source art folder, the leading part of an attachment `path`.
#   group   - a UI/semantic category ("head", "outfit").  `options` groups make
#             one part per attachment, `set` groups make one part per folder.
#   part    - a named bundle of {slot: attachment} assignments.
#   axis    - a shared dimension (breast size, pregnancy) that selects between
#             several attachments of the same part inside one slot.

const SHARED = preload("res://Character_generator/Doll2Spine/doll2_overrides_shared.gd")

# --------------------------------------------------------------- routing ----

# The female bodies and the armour sets cut for them.
# Folder -> group.  `part` is required for `set` groups and names the bundle the
# whole folder collapses into.  `tags` are carried into the generated parts.
const FOLDER_MAP = {
	"00_body_nude_female": {"group": "body", "part": "body_female_base"},
	"15_beastkin_body_nude": {"group": "body", "part": "body_female_beastkin", "tags": ["beastkin"]},
	"150_armory_acces_collars": {"group": "collar"},
	"23_dragon_female": {"group": "race_overlay", "part": "race_dragon"},
	"24_kobold_female": {"group": "race_overlay", "part": "race_kobold"},

	"99_armory_set_maidu": {"group": "outfit", "part": "outfit_maid"},
	"101_armory_set_cloth_female": {"group": "outfit", "part": "outfit_cloth"},
	"101_armory_set_cloth3_female": {"group": "outfit", "part": "outfit_cloth3"},
	"102_armory_set_leather_female": {"group": "outfit", "part": "outfit_leather"},
	"102_armory_set_leather2_female": {"group": "outfit", "part": "outfit_leather2"},
	"103_armory_set_plate_female": {"group": "outfit", "part": "outfit_plate"},
	"103_armory_set_plate2_female": {"group": "outfit", "part": "outfit_plate2"},
	"104_armory_set_slave_female": {"group": "outfit", "part": "outfit_slave"},
	"105_armory_set_gipure1_female": {"group": "outfit", "part": "outfit_gipure1"},
	"106_armory_set_gipure2_female": {"group": "outfit", "part": "outfit_gipure2"},
	"107_armory_set_jacket_female": {"group": "outfit", "part": "outfit_jacket"},
	"108_armory_set_latex_female": {"group": "outfit", "part": "outfit_latex"},
	"109_armory_set_waitress_female": {"group": "outfit", "part": "outfit_waitress"},
	"110_armory_set_smith_female": {"group": "outfit", "part": "outfit_smith"},
	"111_armory_set_tentackle_female": {"group": "outfit", "part": "outfit_tentacle"},
	"112_armory_set_playboy_female": {"group": "outfit", "part": "outfit_playboy"},
	"113_armory_set_underwear1": {"group": "outfit", "part": "outfit_underwear1"},
	"113_armory_set_underwear2": {"group": "outfit", "part": "outfit_underwear2"},
	"151_armory_acces_petsuit": {"group": "outfit", "part": "outfit_petsuit"},
}

# ------------------------------------------------------------------ axes ----

const AXES = {
	"belly_shape": {
		"values": ["default", "muscle"],
		"default": "default",
		"label": "DOLL2_PREVIEW_BELLY_SHAPE",
		"parse": "tokens",
		"tokens": {"muscle": "muscle"},
		"fallback": "default",
	},
}

# Slot -> axis.  An axis is only applied when a part owns more than one
# attachment in that slot; a single attachment is always assigned directly.
const SLOT_AXES = {
	"belly": "belly_shape",
	"breasts": "tits_size",
	"breasts_beastkin": "tits_size",
	"breast_nipples": "tits_size",
	"equip_breasts": "tits_size",

	"pregnancy_belly": "pregnancy",
	"breasts_beastkin_pregnancy": "pregnancy",
	"beastkin_pregnancy_nipple": "pregnancy",
	"equip_belly": "pregnancy",
	"equip_pregnancy_low": "pregnancy",
	"equip_pregnancy_up": "pregnancy",

	"torso": "many_tits",
	"breasts_beastkin_many": "many_tits",
	"beastkin_torso_many_nipples": "many_tits",
}

# Exceptions the name parser cannot infer, keyed by slot and then by the source
# art name (the last element of the attachment `path`).
const AXIS_OVERRIDES = {
	"equip_breasts": {
		# Variant-2 sets name their flat piece after the set, not after the size.
		"tits_leather_2": "flat",
		"tits_plate_2": "flat",
	},
	# Beastkin breast and nipple sizes are pinned in PART_SLOTS instead: their
	# names disagree with their art badly enough that no parser gets them right.
	"equip_belly": {
		# The leather set's big stage is named after the set instead of the stage.
		"Pregnancy_skin_leather": "big",
	},
}

# Attachments dropped from the catalogue entirely.  This one is duplicate art
# that collides with `Hand_armorL3` on hand pose 3; the right hand only ships
# `Hand_armorR3`, so the unnumbered name is the one that matches.
const EXCLUDE = [
	"hand3_armorl3",
	# The plate set puts the flat torso nipple mask into the breast slot, where it
	# wins over the body's size-matched nipple: a big chest ended up wearing the
	# flat one, high and in the wrong place.  The mask keeps its own slot, where the
	# body uses it.
	"breast_nipples/torso_nipples_mask",
]

# Slot assignments written out by hand, overriding the name parser for one part.
# Needed where the export's names cannot be trusted: the beastkin nipple meshes
# are named after sizes they are not, and beastkin has no `normal` nipple of its
# own at all - it borrows the human mesh, which lives in another art folder and
# so can never be inferred from the beastkin folder's contents.
#
# Names may be given as any alias or as the source art file; the build resolves
# them to the canonical attachment and reports them when they disappear.
# Attachments left over after an explicit assignment stay in `extra_options`.
const PART_SLOTS = {
	"body_female_base": {
		"hand_left": {"1": "handl1", "2": "handl2", "3": "handl3"},
		"hand_right": {"1": "handr1", "2": "handr2", "3": "handr3"},
	},
	# The playboy set ships two different hip pieces in one slot - `taz_armor` and
	# `pelvis_armor` - and they are not two names for one picture: 99.9% of their
	# pixels differ.  Only one can be worn, and the one named the way every other
	# set names its hips is the one kept; the other waits for the artist to say
	# where it belongs.
	"outfit_playboy": {"equip_pelvis": "pelvis_armor_playboy"},
	"body_female_beastkin": {
		# The `torso` slot also carries the two many-nipple overlays, which are
		# small patches (37 uvs) and not torsos (68).  Letting the extra-nipple
		# axis pick one of them there replaced the whole chest with a patch, so
		# the torso is pinned and the overlays stay in their own slot.
		"torso": "beastkin_torso",
		"breasts_beastkin": {
			# `beastkin_tits1` is deliberately absent: it is a fifth mesh that is
			# not a size, and putting it on `flat` meant a flat chest still grew
			# a full breast.  Flat now renders no breast mesh, as on the base body.
			"small": "beastkin_tits_small",
			"normal": "beastkin_tits_normal",
			"large": "beastkin_tits_large",
			"big": "beastkin_tits_big",
		},
		"breast_nipples": {
			"small": "beastkin_tits_nipples_small__2",
			"normal": "tits_nipples_normal",
			"large": "beastkin_tits_nipples_large",
			"big": "beastkin_tits_nipples_big",
		},
	},
}

# ----------------------------------------------------------------- parts ----

# Draw order corrections of this rig's own, appended to the shared ones.
#
# The female export lists the race body pieces after the clothing: a dragon's
# scales and a kobold's hide came out painted over the coat, and over the skirt
# and the belly piece as well.  The male export has them the other way round -
# body, then race, then gear - and that is the order the art is drawn for.  The
# three are moved the way the male rig keeps them, each landing directly in
# front of the first gear slot on the torso.
const DRAW_ORDER_FIXES = [
	{"slot": "race_torso_lower", "before": "equip_torso"},
	{"slot": "race_torso", "before": "equip_torso"},
	{"slot": "race_pelvis", "before": "equip_torso"},
]


# Sub-parts of a `set` part.  Each entry lists the attachments that belong to
# that variant; the first sub-part is the base and every other one inherits the
# slots it does not list.
const PART_SPLITS = {
	# The head pieces are not listed here: they are their own `face_markings`
	# group now, so they can be worn without the matching body.
	"race_dragon": {
		"race_dragon": ["dragon_LegL", "dragon_LegR", "dragon_pelvis", "dragon_body"],
		"race_dragon_scales": ["dragon_LegL 2", "dragon_LegR 2", "dragon_pelvis 2", "dragon_body 2"],
		"race_dragon_scales2": ["dragon_body3"],
	},
	"race_kobold": {
		"race_kobold": ["kobold_ArmL1", "kobold_ShoulderL1", "kobold_ShoulderR1", "kobold_LegL", "kobold_legR", "kobold_body1_1", "kobold_body2_1"],
		"race_kobold_spots": ["kobold_ArmL2", "kobold_ShoulderL2", "kobold_ShoulderR2", "kobold_legL2", "kobold_legR2", "kobold_body1_2", "kobold_body2_2"],
	},
}

const DEFAULTS = {
	"body": "body_female_base",
}

# Developer-facing names.  Anything absent is titled from its part id.
const DISPLAY = {
	"body_female_base": "Female base body",
	"body_female_beastkin": "Female beastkin body",
	"race_dragon_scales": "Dragon (scales)",
	"race_dragon_scales2": "Dragon (scales 2)",
	"race_kobold": "Kobold",
	"race_kobold_spots": "Kobold (spots)",
	"head_dragon_mask": "Dragon cheek scales",
	"head_dragon_mask_2": "Dragon cheek scales 2",
	"kobold_head_kobold": "Kobold spots",
	"kobold_head_mask1": "Kobold cheek plates",
	"outfit_maid": "Maid set",
	"outfit_cloth": "Cloth set",
	"outfit_cloth3": "Cloth set 3",
	"outfit_leather": "Leather set",
	"outfit_leather2": "Leather set 2",
	"outfit_plate": "Plate set",
	"outfit_plate2": "Plate set 2",
	"outfit_slave": "Slave set",
	"outfit_gipure1": "Gipure set 1",
	"outfit_gipure2": "Gipure set 2",
	"outfit_jacket": "Jacket set",
	"outfit_latex": "Latex set",
	"outfit_waitress": "Waitress set",
	"outfit_smith": "Smith set",
	"outfit_tentacle": "Tentacle set",
	"outfit_playboy": "Playboy set",
	"outfit_underwear1": "Underwear set 1",
	"outfit_underwear2": "Underwear set 2",
	"outfit_petsuit": "Pet suit accessories",
}
