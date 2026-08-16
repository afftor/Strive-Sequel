extends Reference

# Hand-authored semantics for the Doll 2 catalogue.
#
# The generator (doll2_catalogue_builder.gd) reads this file, applies it to a
# fresh Spine export and writes doll2_catalogue_gen.gd.  Everything here is
# checked against the export on every run: names that no longer exist are listed
# in the report as stale, so hand edits survive a re-export and never rot in
# silence.  Nothing in this file may reference mesh, vertex or animation data.
#
# Vocabulary
#   folder  - source art folder, the leading part of an attachment `path`.
#   group   - a UI/semantic category ("head", "outfit").  `options` groups make
#             one part per attachment, `set` groups make one part per folder.
#   part    - a named bundle of {slot: attachment} assignments.
#   axis    - a shared dimension (breast size, pregnancy) that selects between
#             several attachments of the same part inside one slot.

const SCHEMA_VERSION = 2

# ---------------------------------------------------------------- groups ----

# `order` drives both the UI order and the compose order: a later group wins
# when two parts write the same slot (an outfit may replace a body attachment).
const GROUP_DEFS = {
	"body": {"kind": "set", "optional": false, "order": 0, "label": "DOLL2_PREVIEW_BODY"},
	"head": {"kind": "options", "optional": false, "order": 1, "label": "DOLL2_PREVIEW_HEAD"},
	"face": {"kind": "options", "optional": false, "order": 2, "label": "DOLL2_PREVIEW_FACE"},
	"eyes": {"kind": "options", "optional": false, "order": 3, "label": "DOLL2_PREVIEW_EYES"},
	"eyebrows": {"kind": "options", "optional": true, "order": 4, "label": "DOLL2_PREVIEW_EYEBROWS"},
	"nose": {"kind": "options", "optional": true, "order": 5, "label": "DOLL2_PREVIEW_NOSE"},
	"lips": {"kind": "options", "optional": true, "order": 6, "label": "DOLL2_PREVIEW_LIPS"},
	"ears": {"kind": "options", "optional": true, "order": 7, "label": "DOLL2_PREVIEW_EARS"},
	"hair_base": {"kind": "options", "optional": true, "order": 8, "label": "DOLL2_PREVIEW_HAIR_BASE"},
	"hair_fringe": {"kind": "options", "optional": true, "order": 9, "label": "DOLL2_PREVIEW_FRINGE"},
	"hair_back": {"kind": "options", "optional": true, "order": 10, "label": "DOLL2_PREVIEW_HAIR_BACK"},
	"hair_assist": {"kind": "options", "optional": true, "order": 11, "label": "DOLL2_PREVIEW_HAIR_ACCESSORY"},
	"horns": {"kind": "options", "optional": true, "order": 12, "label": "DOLL2_PREVIEW_HORNS"},
	"wings": {"kind": "options", "optional": true, "order": 13, "label": "DOLL2_PREVIEW_WINGS"},
	"tails": {"kind": "options", "optional": true, "order": 14, "label": "DOLL2_PREVIEW_TAILS"},
	"animal_body": {"kind": "options", "optional": true, "order": 15, "label": "DOLL2_PREVIEW_ANIMAL_BODY"},
	"race_overlay": {"kind": "set", "optional": true, "order": 16, "label": "DOLL2_PREVIEW_RACE_OVERLAY"},
	# The scale plates and spots on the cheeks.  They live in their own slot and
	# are the only face decoration the export has, so they are a group of their
	# own rather than part of the race bundle: otherwise the only way to put
	# kobold lines on a beastkin face is to give it the whole kobold body.
	"face_markings": {"kind": "options", "optional": true, "order": 17, "label": "DOLL2_PREVIEW_FACE_MARKINGS"},
	"genitals": {"kind": "options", "optional": true, "order": 18, "label": "DOLL2_PREVIEW_GENITALS"},
	"tattoo": {"kind": "options", "optional": true, "order": 19, "label": "DOLL2_PREVIEW_TATTOO"},
	"outfit": {"kind": "set", "optional": true, "order": 20, "label": "DOLL2_PREVIEW_OUTFIT"},
	"collar": {"kind": "options", "optional": true, "order": 21, "label": "DOLL2_PREVIEW_COLLAR"},
	"headgear": {"kind": "options", "optional": true, "order": 22, "label": "DOLL2_PREVIEW_HEADGEAR"},
	"mask": {"kind": "options", "optional": true, "order": 23, "label": "DOLL2_PREVIEW_MASK"},
	"weapon_belt": {"kind": "options", "optional": true, "order": 24, "label": "DOLL2_PREVIEW_WEAPON_BELT"},
	"weapon_back": {"kind": "options", "optional": true, "order": 25, "label": "DOLL2_PREVIEW_WEAPON_BACK"},
}

# --------------------------------------------------------------- routing ----

# Folder -> group.  `part` is required for `set` groups and names the bundle the
# whole folder collapses into.  `tags` are carried into the generated parts.
const FOLDER_MAP = {
	"00_body_nude_female": {"group": "body", "part": "body_female_base"},
	"15_beastkin_body_nude": {"group": "body", "part": "body_female_beastkin", "tags": ["beastkin"]},

	"01_heads": {"group": "head"},
	"16_beastkin_heads_new": {"group": "head", "tags": ["beastkin"]},
	"02_faces": {"group": "face"},
	"17_beastkin_faces": {"group": "face", "tags": ["beastkin"]},
	"12_lips": {"group": "lips"},
	"17_beastkin_lips": {"group": "lips", "tags": ["beastkin"]},
	"03_noses": {"group": "nose"},
	"03_ears": {"group": "ears"},
	"10_eyes": {"group": "eyes"},
	"11_eyebrows": {"group": "eyebrows"},
	"04_hairs_base": {"group": "hair_base"},
	"04_hairs_fringe": {"group": "hair_fringe"},
	"06_hairs_back": {"group": "hair_back"},
	"05_hairs_assist": {"group": "hair_assist"},
	"08_horns": {"group": "horns"},
	"09_wings": {"group": "wings"},
	"07_tails": {"group": "tails"},
	"14_animals_body": {"group": "animal_body"},
	"13_dicks": {"group": "genitals"},
	"97_tatoos": {"group": "tattoo"},
	"25_head_masks": {"group": "mask"},
	"150_armory_acces_collars": {"group": "collar"},
	"200_weapon_belt": {"group": "weapon_belt"},
	"201_weapon_back": {"group": "weapon_back"},

	"20_dryad": {"group": "race_overlay", "part": "race_dryad"},
	"21_nereid": {"group": "race_overlay", "part": "race_nereid"},
	"22_slime": {"group": "race_overlay", "part": "race_slime"},
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

# Slot -> group, applied before FOLDER_MAP.  These slots are equipment of their
# own in the game (head gear, collars) and must not be swallowed by the outfit
# set of the folder that happens to ship them.
const SLOT_ROUTES = {
	"equip_head": "headgear",
	"equip_collar": "collar",
	"equip_masks": "mask",
	"race_head": "face_markings",
}

# Slots that never produce a part of their own: they are driven by FIXED_SLOTS
# or attached to another part through COMPANIONS.
const CONSUMED_SLOTS = ["head_skull", "sclera", "testicle", "animal_frontbody"]

# Draw order corrections, applied on top of the export's slot order.
# `{"slot": "x", "before": "y"}` moves slot x to sit directly in front of y.
# The Spine file stays the source of truth; only this list disagrees with it, so
# a re-export cannot silently undo the correction without the build reporting it.
const DRAW_ORDER_FIXES = [
	# Tattoos are painted on skin but the export lists them after the clothing
	# slots, so a dressed character wore the tattoo on top of the armour.
	{"slot": "tatoos", "before": "equip_torso"},
]

# Always present, independent of any selection.
const FIXED_SLOTS = {"sclera": "sklera"}

# Extra slot assignments folded into an `options` part when it is selected.
# The first matching rule wins; `folder` and `base_prefix` are both optional.
const COMPANIONS = {
	"head": [
		{"folder": "01_heads", "slots": {"head_skull": "head_skull"}},
		{"folder": "16_beastkin_heads_new", "slots": {"head_skull": "beastkin_skull"}},
	],
	"genitals": [
		{"base_prefix": "Dick_human", "slots": {"testicle": "Testicle_human"}},
		{"base_prefix": "Dick_furry", "slots": {"testicle": "Testicle_furry"}},
		{"base_prefix": "Dick_horse", "slots": {"testicle": "Testicle_furry"}},
	],
	"animal_body": [
		{"base_prefix": "arachna", "slots": {"animal_frontbody": "arachna_helicere"}},
	],
}

# ------------------------------------------------------------------ axes ----

const AXES = {
	"tits_size": {
		"values": ["flat", "small", "normal", "large", "big"],
		"default": "large",
		"label": "DOLL2_PREVIEW_BREAST_SIZE",
		"parse": "tokens",
		"tokens": {"0": "flat", "o": "flat", "flat": "flat", "small": "small", "normal": "normal", "large": "large", "big": "big"},
	},
	"pregnancy": {
		"values": ["none", "mid", "big"],
		"default": "none",
		"label": "DOLL2_PREVIEW_PREGNANCY",
		"parse": "tokens",
		# The export uses `small` and `mid` interchangeably for the first stage.
		"tokens": {"small": "mid", "mid": "mid", "big": "big"},
		"fallback": "none",
	},
	"hand_pose": {
		"values": ["1", "2", "3"],
		"default": "1",
		"label": "DOLL2_PREVIEW_HAND_POSE",
		"parse": "digit",
	},
	"many_tits": {
		"values": ["none", "4", "6"],
		"default": "none",
		"label": "DOLL2_PREVIEW_MANY_TITS",
		"parse": "digit",
		"fallback": "none",
	},
}

# Slot -> axis.  An axis is only applied when a part owns more than one
# attachment in that slot; a single attachment is always assigned directly.
const SLOT_AXES = {
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

	"hand_left": "hand_pose",
	"hand_right": "hand_pose",
	"equip_hand_left": "hand_pose",
	"equip_hand_right": "hand_pose",

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
	"Hand3_armorL3",
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
	"head": "head_chin_default",
	"face": "face3",
	"eyes": "eyes_m5",
	"eyebrows": "eyebrows1",
	"nose": "nose_default",
	"lips": "lips1",
	"ears": "ears_human",
	"hair_base": "hair_base_straight",
	"hair_fringe": "hair_fringe_fringe",
	"hair_back": "hair_back_straight",
}

# Developer-facing names.  Anything absent is titled from its part id.
const DISPLAY = {
	# The head group holds both human chins and beastkin muzzles, and the raw art
	# names bury the muzzles in the middle of the list.
	"beastkin_chin_cat": "Muzzle: cat",
	"beastkin_chin_fox": "Muzzle: fox",
	"beastkin_chin_rabbit": "Muzzle: rabbit",
	"beastkin_chin_tanuki": "Muzzle: tanuki",
	"beastkin_chin_wolf": "Muzzle: wolf",
	"head_chin_default": "Chin: default",
	"head_chin_curve": "Chin: curved",
	"head_chin_curve_kobold": "Chin: curved kobold",
	"head_chin_kobold2": "Chin: kobold 2",
	"head_chin_loli": "Chin: loli",
	"head_chin_long_skinny": "Chin: long skinny",
	"head_chin_male": "Chin: male",
	"head_chin_muscle": "Chin: muscular",
	"head_chin_short": "Chin: short",
	"head_chin_small": "Chin: small",
	"body_female_base": "Female base body",
	"body_female_beastkin": "Female beastkin body",
	"race_dragon": "Dragon",
	"race_dragon_scales": "Dragon (scales)",
	"race_dragon_scales2": "Dragon (scales 2)",
	"race_kobold": "Kobold",
	"race_kobold_spots": "Kobold (spots)",
	"race_dryad": "Dryad",
	"head_dragon_mask": "Dragon cheek scales",
	"head_dragon_mask_2": "Dragon cheek scales 2",
	"kobold_head_kobold": "Kobold spots",
	"kobold_head_mask1": "Kobold cheek plates",
	"race_nereid": "Nereid",
	"race_slime": "Slime",
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

# Convenience multi-group selections.  These replace the race dropdown the
# multi-skin export used to provide: a race is a set of ordinary part choices,
# never a separate rendering path.
const PRESETS = {
	"cat": {"ears": "ears_cat", "tails": "tail_cat"},
	"wolf": {"ears": "ears_wolf", "tails": "tail_wolf"},
	"fox": {"ears": "ears_fox", "tails": "tail_fox"},
	"mouse": {"ears": "ears_mouse", "tails": "tail_mouse"},
	"tanuki": {"ears": "ears_tanuk", "tails": "tail_tanuk"},
	"rabbit": {"ears": "ears_rabbit"},
	"elf": {"ears": "ears_elven"},
	"orc": {"ears": "ears_orc", "lips": "lips_orc"},
	"goblin": {"ears": "ears_goblin"},
	"demon": {"horns": "horn_curve_up", "tails": "tail_demon", "wings": "wings_demon"},
	"dragon": {"race_overlay": "race_dragon", "face_markings": "head_dragon_mask", "horns": "horn_dragon2", "tails": "tail_dragon", "wings": "Wings_dragon"},
	"kobold": {"race_overlay": "race_kobold", "face_markings": "kobold_head_kobold", "tails": "tail_kobold", "nose": "nose_kobold"},
	"slime": {"race_overlay": "race_slime"},
	"dryad": {"race_overlay": "race_dryad"},
	"nereid": {"race_overlay": "race_nereid", "ears": "ears_nereid", "tails": "tail_nereid"},
	"fairy": {"wings": "Wings_fairy"},
	"seraph": {"wings": "Wings_seraph", "horns": "horn_seraph_fibule"},
	"harpia": {"wings": "wings_harpia"},
	"arachna": {"animal_body": "arachna_body"},
	"kentaur": {"animal_body": "kentaur_body"},
	"lamia": {"animal_body": "lamia_body"},
	"scylla": {"animal_body": "scylla_body"},
}

# ---------------------------------------------------------------- colour ----

# Colour channels.  A channel is one colour picker: it owns the slots of the
# groups it lists and paints them through the recolour shader.  `anchor` is the
# group whose dropdown the picker sits next to in the editor UI.
#
# Slots are derived from the groups rather than listed by hand, so a new part
# that introduces a new slot is coloured automatically.  When two channels claim
# the same slot the earlier one wins and the build reports the overlap; that is
# how `breast_nipples` stays on skin even though the plate armour set writes a
# nipple mask into it.
#
# The old paperdoll drove this from 144 preset .tres materials with baked masks
# per zone.  Here the slot is the zone and the colour is free, which is the whole
# point of moving to a picker.
const COLOR_CHANNELS = {
	"skin": {"anchor": "body", "groups": ["body", "head", "face", "nose", "genitals"]},
	"eyes": {"anchor": "eyes", "groups": ["eyes"]},
	"eyebrows": {"anchor": "eyebrows", "groups": ["eyebrows"]},
	"lips": {"anchor": "lips", "groups": ["lips"]},
	"ears": {"anchor": "ears", "groups": ["ears"]},
	# Each hair layer carries two colours, as it did in the old paperdoll, where
	# `hair_*_color_1` and `hair_*_color_2` drove two separate shader zones.  That
	# art had a baked mask to divide the zones; this art has none, so the second
	# colour is blended down the length of the strands instead - roots to tips.
	"hair_base": {"anchor": "hair_base", "groups": ["hair_base"], "two_tone": true},
	"hair_fringe": {"anchor": "hair_fringe", "groups": ["hair_fringe"], "two_tone": true},
	"hair_back": {"anchor": "hair_back", "groups": ["hair_back"], "two_tone": true},
	"hair_assist": {"anchor": "hair_assist", "groups": ["hair_assist"], "two_tone": true},
	"horns": {"anchor": "horns", "groups": ["horns"]},
	"wings": {"anchor": "wings", "groups": ["wings"]},
	"tail": {"anchor": "tails", "groups": ["tails"]},
	"animal": {"anchor": "animal_body", "groups": ["animal_body"]},
	"race": {"anchor": "race_overlay", "groups": ["race_overlay"]},
	"face_markings": {"anchor": "face_markings", "groups": ["face_markings"]},
	"tattoo": {"anchor": "tattoo", "groups": ["tattoo"]},
	# Gear art is hue-coded rather than painted in final colours, so these
	# channels drive three zones each - see ZONE_HUES below.
	"outfit": {"anchor": "outfit", "groups": ["outfit"], "zones": 3},
	"collar": {"anchor": "collar", "groups": ["collar"], "zones": 3},
	"headgear": {"anchor": "headgear", "groups": ["headgear"], "zones": 3},
	"mask": {"anchor": "mask", "groups": ["mask"], "zones": 3},
	"weapon": {"anchor": "weapon_belt", "groups": ["weapon_belt", "weapon_back"], "zones": 3},
}

# Hue bands the gear art is coded in, measured off the atlas: magenta carries the
# main material, green the second, cyan the third.  Sampling the plate, maid,
# latex, collar and weapon art puts every gear pixel in one of these three bands,
# while body and hair art sits well outside them.
#
# `distance` is the half-width of a band in degrees; anything further away keeps
# its own colour, which is what protects outlines, metal highlights and any part
# the artist painted in its final colour.
const ZONE_HUES = [300.0, 105.0, 165.0]
const ZONE_DISTANCE = 32.0

# Where the zone pickers start.  Unlike the body channels, gear is never left at
# its raw art colour: unpainted magenta is a placeholder, not a look, so the
# defaults stand in for the old `default`, `default_metal` and `default_leather`
# presets.
const ZONE_DEFAULTS = [Color("9aa6b4"), Color("6f5133"), Color("8d3b3b")]
