extends Reference

# Semantics shared by every Doll 2 skeleton.
#
# The male and female exports are separate Spine projects with separate rigs,
# but they are drawn to the same conventions: the same slot names, the same art
# folders for everything above the neck, the same hue code, one `default` skin.
# Everything that is true of both lives here; doll2_overrides.gd (female) and
# doll2_overrides_male.gd carry only what is theirs.
#
# The builder composes the two: a doll's table is merged over this one key by
# key, and a key set to `null` there drops the shared entry for that doll.  That
# way each file only declares what its own export actually contains, and the
# stale-reference report stays meaningful for both.

const SCHEMA_VERSION = 2

# ---------------------------------------------------------------- groups ----

# `order` drives both the UI order and the compose order: a later group wins
# when two parts write the same slot (an outfit may replace a body attachment).
const GROUP_DEFS = {
	"body": {"kind": "set", "optional": false, "order": 0, "label": "DOLL2_PREVIEW_BODY"},
	"head": {"kind": "options", "optional": false, "order": 1, "label": "DOLL2_PREVIEW_HEAD"},
	"face": {"kind": "options", "optional": false, "order": 2, "label": "DOLL2_PREVIEW_FACE"},
	"eyes": {"kind": "options", "optional": false, "order": 3, "label": "DOLL2_PREVIEW_EYES"},
	"eyes_effect": {"kind": "options", "optional": true, "order": 4, "label": "DOLL2_PREVIEW_EYES_EFFECT"},
	"blush": {"kind": "options", "optional": true, "order": 5, "label": "DOLL2_PREVIEW_BLUSH"},
	"eyebrows": {"kind": "options", "optional": true, "order": 4, "label": "DOLL2_PREVIEW_EYEBROWS"},
	"nose": {"kind": "options", "optional": true, "order": 5, "label": "DOLL2_PREVIEW_NOSE"},
	"lips": {"kind": "options", "optional": true, "order": 6, "label": "DOLL2_PREVIEW_LIPS"},
	"ears": {"kind": "options", "optional": true, "order": 7, "label": "DOLL2_PREVIEW_EARS"},
	# Base hair and fringe are one choice.  Their lists are the same styles under
	# two names, and a style only ever makes sense with its own fringe; they stay
	# two slots because the ears draw between them, but they are picked together.
	"hair": {"kind": "options", "optional": true, "order": 8, "label": "DOLL2_PREVIEW_HAIR"},
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
	# The lower half of every set, composed after the whole one so it wins the
	# slots it holds.  The game equips a chest and a pair of legs separately and
	# they are often different armour; one group for the whole body could only
	# ever show one of the two.  The builder fills this - see LOWER_HALF.
	"outfit_legs": {"kind": "set", "optional": true, "order": 21, "label": "DOLL2_PREVIEW_OUTFIT_LEGS"},
	# and the pair of hands, so a set's paws or gauntlets can be worn over any
	# clothes rather than instead of them
	"outfit_hands": {"kind": "set", "optional": true, "order": 22, "label": "DOLL2_PREVIEW_OUTFIT_HANDS"},
	"collar": {"kind": "options", "optional": true, "order": 23, "label": "DOLL2_PREVIEW_COLLAR"},
	"headgear": {"kind": "options", "optional": true, "order": 24, "label": "DOLL2_PREVIEW_HEADGEAR"},
	"mask": {"kind": "options", "optional": true, "order": 25, "label": "DOLL2_PREVIEW_MASK"},
	"weapon_belt": {"kind": "options", "optional": true, "order": 26, "label": "DOLL2_PREVIEW_WEAPON_BELT"},
	"weapon_back": {"kind": "options", "optional": true, "order": 27, "label": "DOLL2_PREVIEW_WEAPON_BACK"},
}


# --------------------------------------------------------------- routing ----

# Folder -> group, for the art both dolls share: everything above the neck, the
# races, the tattoos and the weapons.  Bodies and armour sets are cut per doll
# and live in the doll's own file.
const FOLDER_MAP = {
	"01_heads": {"group": "head"},
	"16_beastkin_heads": {"group": "head", "tags": ["beastkin"]},
	"16_beastkin_heads_new": {"group": "head", "tags": ["beastkin"]},
	"02_faces": {"group": "face"},
	"17_beastkin_faces": {"group": "face", "tags": ["beastkin"]},
	"12_lips": {"group": "lips"},
	"17_beastkin_lips": {"group": "lips", "tags": ["beastkin"]},
	"03_noses": {"group": "nose"},
	"03_ears": {"group": "ears"},
	"10_eyes": {"group": "eyes"},
	"11_eyebrows": {"group": "eyebrows"},
	"04_hairs_base": {"group": "hair"},
	# The fringe art makes no parts of its own; PAIRED_SLOTS hangs it off the
	# matching base style instead.
	"04_hairs_fringe": {"group": "hair"},
	"06_hairs_back": {"group": "hair_back"},
	"05_hairs_assist": {"group": "hair_assist"},
	"08_horns": {"group": "horns"},
	"09_wings": {"group": "wings"},
	"07_tails": {"group": "tails"},
	"14_animals_body": {"group": "animal_body"},
	"13_dicks": {"group": "genitals"},
	"97_tatoos": {"group": "tattoo"},
	"25_head_masks": {"group": "mask"},
	"200_weapon_belt": {"group": "weapon_belt"},
	"201_weapon_back": {"group": "weapon_back"},

	"20_dryad": {"group": "race_overlay", "part": "race_dryad"},
	"21_nereid": {"group": "race_overlay", "part": "race_nereid"},
	"22_slime": {"group": "race_overlay", "part": "race_slime"},
}

# Slot -> group, applied before FOLDER_MAP.  These slots are equipment of their
# own in the game (head gear, collars) and must not be swallowed by the outfit
# set of the folder that happens to ship them.
const SLOT_ROUTES = {
	"eyes_hearts": "eyes_effect",
	"blush": "blush",
	"equip_head": "headgear",
	"equip_collar": "collar",
	"equip_masks": "mask",
	"race_head": "face_markings",
}

# Slots that never produce a part of their own: they are driven by FIXED_SLOTS
# or attached to another part through COMPANIONS.
const CONSUMED_SLOTS = ["head_skull", "sclera", "testicle", "animal_frontbody", "hairs_fringe"]

# Slots filled by pairing rather than by a choice of their own.  For every part of
# the group, the attachment whose style matches the part's is looked up in the
# target slot: `strip` reduces both names to that style, so `hair_base_kare` and
# `hair_fringe_kare` meet at "kare" despite the export spelling the prefix two
# ways.  A style with no counterpart simply leaves the slot empty.
const PAIRED_SLOTS = {
	"hair": [{"slot": "hairs_fringe", "strip": "^hairs?_(base|fringe)_"}],
}

# Draw order corrections, applied on top of the export's slot order.
# `{"slot": "x", "before": "y"}` moves slot x to sit directly in front of y.
# The Spine file stays the source of truth; only this list disagrees with it, so
# a re-export cannot silently undo the correction without the build reporting it.
const DRAW_ORDER_FIXES = [
	# Tattoos are painted on skin but the export lists them after the clothing
	# slots, so a dressed character wore the tattoo on top of the armour.
	{"slot": "tatoos", "before": "equip_torso"},
	# Same for the genitals: the export draws `dick` after the lower armour, so a
	# dressed character wore it over their trousers.  The testicles already sit
	# below the armour and are left alone.
	{"slot": "dick", "before": "equip_pelvis"},
	# Animal ears are attached to the skull, not to the hairstyle, so the hair in
	# front of the head has to fall over them: the export draws them after the
	# hair and they came out pasted on top of it.  Under the hair mass and over
	# the hair that hangs behind the head is where they belong.
	{"slot": "ears", "before": "hairs_base"},
]

# Always present, independent of any selection.
const FIXED_SLOTS = {"sclera": "sklera"}

# Extra slot assignments folded into an `options` part when it is selected.
# The first matching rule wins; `folder` and `base_prefix` are both optional.
const COMPANIONS = {
	"head": [
		{"folder": "01_heads", "slots": {"head_skull": "head_skull"}},
		{"folder": "16_beastkin_heads", "slots": {"head_skull": "beastkin_skull"}},
		{"folder": "16_beastkin_heads_new", "slots": {"head_skull": "beastkin_skull"}},
	],
	# `base_prefix` matches the art file, which kept its capitals when the export
	# lower-cased the attachment names; the slot value is an attachment name and
	# so did change.  Mixing the two up silently drops the testicles.
	"genitals": [
		{"base_prefix": "Dick_human", "slots": {"testicle": "testicle_human"}},
		{"base_prefix": "Dick_furry", "slots": {"testicle": "testicle_furry"}},
		{"base_prefix": "Dick_horse", "slots": {"testicle": "testicle_furry"}},
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
	# The export grew a second pair of legs, cut heavier for orcs.  It is a
	# shape rather than a size, and the game has no stat for it: the race picks
	# it, the way it picks a muzzle.
	"legs": {
		"values": ["default", "orc"],
		"default": "default",
		"label": "DOLL2_PREVIEW_LEGS",
		"parse": "tokens",
		"tokens": {"orc": "orc"},
		"fallback": "default",
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
# Only the hands are shared: breasts and pregnancy exist on the female rig alone.
const SLOT_AXES = {
	# Both rigs grew a heavier pair of legs for orcs.
	"leg_left": "legs",
	"leg_right": "legs",

	"hand_left": "hand_pose",
	"hand_right": "hand_pose",
	"equip_hand_left": "hand_pose",
	"equip_hand_right": "hand_pose",
}

# Slots a part replaces outright.  The old doll hid its `l_body` node group when a
# race had an animal lower body: a centaur's barrel, a lamia's coils and a
# scylla's tentacles stand where the legs would, and leaving the legs on draws
# them through the animal.  The leg armour goes with them - there is nothing left
# to wear it.
# An animal lower body replaces the human one from the waist down, genitals
# included: the horse half of a centaur has no place to hang a human cock, and
# the art draws none, so the human ones are cleared with the legs however
# undressed the character is.
const HIDDEN_BY_ANIMAL_BODY = ["leg_left", "leg_right", "equip_leg_left",
	"equip_leg_right", "race_leg_left", "race_leg_right", "dick", "testicle"]

# A harpy's wings are her arms: the pair is drawn from the shoulder down, so the
# human arm and hand underneath would stick out of the feathers.  The shoulders
# stay - the wing starts there and the art expects them.
const HIDDEN_BY_WING_ARMS = ["arm_left", "arm_right", "hand_left", "hand_right",
	"equip_arm_left", "equip_arm_right", "equip_hand_left", "equip_hand_right",
	"race_arm_left", "race_arm_right"]

const PART_HIDES = {
	"wings_harpia": HIDDEN_BY_WING_ARMS,
	"kentaur_body": HIDDEN_BY_ANIMAL_BODY,
	"lamia_body": HIDDEN_BY_ANIMAL_BODY,
	"scylla_body": HIDDEN_BY_ANIMAL_BODY,
	# the spider keeps its own pelvis as well, so the human one goes too
	"arachna_body": HIDDEN_BY_ANIMAL_BODY + ["pelvis", "equip_pelvis", "race_pelvis"],
}

# Tables that belong to one doll or the other and have no shared content.  They
# are declared empty here so a doll file only has to write what it actually
# needs, and the builder always finds the key.
# Attachments the export carries twice: the same picture under two names.  The
# artist has since deleted most of the pairs, so what is left here are the ones
# the export still ships twice - the prefixed spelling is the one kept, because
# it is what the game's own short values resolve to.
const EXCLUDE = [
	"hairs_base_parting", "hairs_base_slave", "twin_tails_2",
]
const AXIS_OVERRIDES = {}
const PART_SLOTS = {}
# Parts the doll draws exactly as the artist painted them.
#
# The recolour has nothing to do on a set that is already coloured: the maid
# outfit is black and white on purpose, and the gear channel - which starts its
# bands on steel and leather - only muddied it.  A part named here is drawn with
# no material at all, so what reaches the screen is the art.
#
# A decision about the set rather than a property of its pixels, which is why it
# is a list and not something the builder works out.
const UNPAINTED_PARTS = ["outfit_maid"]

const PART_SPLITS = {}

# The pieces every set is cut into, besides the whole thing.
#
# The game dresses a character from several slots at once - a chest, a pair of
# legs, a pair of hands - while the catalogue holds one part for the whole body,
# so on its own it can only ever show one of them.  Each cut below becomes a
# group of its own, composed after `outfit` and winning exactly the slots it
# names.
#
# The legs take theirs from the colour channel that already claims them: the
# artist paints those three slots as one, so the seam the doll wears its armour
# along and the seam it paints it along are the same line by construction rather
# than by two lists agreeing.  The hands name their slots outright - no channel
# is drawn along that line.
#
# `suffix` is what the piece is called: `outfit_plate` -> `outfit_plate_legs`.
# `doll_gear_map.gd` spells the same suffixes, because it names a part without
# being able to read the catalogue.
const SET_CUTS = {
	"outfit_legs": {"source": "outfit_lower", "suffix": "_legs", "display": " (legs)"},
	"outfit_hands": {"slots": ["equip_hand_left", "equip_hand_right"], "suffix": "_hands", "display": " (hands)"},
}

# Everything above the neck, which both exports take from the same art.
const DEFAULTS = {
	"head": "head_chin_default",
	# face1 to face5 were withdrawn in the August re-export; face7 is the plain
	# one of what is left.
	"face": "face7",
	"eyes": "eyes1",
	"eyebrows": "eyebrows1",
	"nose": "nose_default",
	"lips": "lips1",
	"ears": "ears_human",
	"hair": "hair_base_straight",
	"hair_back": "hair_back_straight",
}

# Developer-facing names for the shared art.  Anything absent is titled from its
# part id.
const DISPLAY = {
	# The head group holds both human chins and beastkin muzzles, and the raw art
	# names bury the muzzles in the middle of the list.
	"beastkin_chin_cat": "Muzzle: cat",
	"beastkin_chin_fox": "Muzzle: fox",
	# The shared muzzles, worn by whichever races are given the choice rather
	# than their animal's own snout - the wolves, the foxes and the tanuki.
	"beastkin_head_muzzle_1": "Muzzle: 1",
	"beastkin_head_muzzle_2": "Muzzle: 2",
	"beastkin_head_muzzle_3": "Muzzle: 3",
	"beastkin_chin_rabbit": "Muzzle: rabbit",
	"beastkin_chin_tanuki": "Muzzle: tanuki",
	"beastkin_chin_wolf": "Muzzle: wolf",
	"head_chin_default": "Chin: default",
	"head_chin_curve": "Chin: curved",
	"head_chin_curve_kobold": "Chin: curved kobold",
	"head_chin_kobold2": "Chin: kobold 2",
	"head_chin_long_skinny": "Chin: long skinny",
	"head_chin_muscle": "Chin: muscular",
	"head_chin_short": "Chin: short",
	"head_chin_small_c": "Chin: small curved",
	"race_dryad": "Dryad",
	"race_nereid": "Nereid",
	"race_slime": "Slime",
	"race_dragon": "Dragon",
}

# Convenience multi-group selections.  These replace the race dropdown the
# multi-skin export used to provide: a race is a set of ordinary part choices,
# never a separate rendering path.
const PRESETS = {
	"cat": {"ears": "ears_cat", "tails": "tail_cat"},
	"wolf": {"ears": "ears_wolf", "tails": "tail_wolf"},
	"fox": {"ears": "ears_fox_n1", "tails": "tail_fox"},
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
	# `coverage` marks the channel fur and scale patterns are painted over: the body,
	# never the hair or the gear.
	# Nipples are drawn on the body's own meshes, so they inherited the skin colour
	# and went green with it.  They are their own colour: named slots rather than a
	# group, because no group tells them apart from the torso they are drawn on.
	# Declared above `skin`, which would otherwise claim them with the rest of the
	# body.  Nothing feeds it from the character, so the art's own tone stands
	# until someone picks a colour.
	# The two exports name them differently and neither has all of them: the
	# female rig splits breasts, torso and the beastkin extras, the male rig has
	# one `nipples` slot.  A slot the doll in hand does not have is simply noted.
	"nipples": {"anchor": "body", "groups": [], "slots": [
		"breast_nipples", "torso_nipples_mask", "nipples",
		"beastkin_torso_many_nipples", "beastkin_pregnancy_nipple",
	]},
	"skin": {"anchor": "body", "groups": ["body", "head", "face", "nose", "genitals"], "coverage": true},
	"eyes": {"anchor": "eyes", "groups": ["eyes", "eyes_effect"]},
	"eyebrows": {"anchor": "eyebrows", "groups": ["eyebrows"]},
	"lips": {"anchor": "lips", "groups": ["lips"]},
	# Painted like a body part rather than like gear: one colour over the whole
	# ear, hue and saturation from the pick and the art's own lightness kept.
	#
	# The art does carry hue bands - the inner ear is a second colour on the furry
	# cuts - and this channel used to drive them the way the armour does.  Two
	# swatches for an ear turned out to be two ways to get it wrong, and the band
	# defaults fought the fur colour the character already has; the plain path
	# lets the drawn shading through and needs no second decision.
	"ears": {"anchor": "ears", "groups": ["ears"]},
	# Each hair layer carries two colours, as it did in the old paperdoll, where
	# `hair_*_color_1` and `hair_*_color_2` drove two separate shader zones.  That
	# art had a baked mask to divide the zones; this art has none, so the second
	# colour is blended down the length of the strands instead - roots to tips.
	# One channel for the whole hairstyle, so the roots-to-tips gradient runs
	# across the base and the fringe as one head of hair.
	"hair": {"anchor": "hair", "groups": ["hair"], "two_tone": true},
	"hair_back": {"anchor": "hair_back", "groups": ["hair_back"], "two_tone": true},
	"hair_assist": {"anchor": "hair_assist", "groups": ["hair_assist"], "two_tone": true},
	"horns": {"anchor": "horns", "groups": ["horns"]},
	# Wings and animal bodies are the two body parts the artist really does code
	# by hue: a fairy wing's membrane and its frame are separate bands, and the
	# old paperdoll carried two masks for each animal body for the same reason.
	"wings": {"anchor": "wings", "groups": ["wings"], "zones": true},
	"tail": {"anchor": "tails", "groups": ["tails"]},
	"animal": {"anchor": "animal_body", "groups": ["animal_body"], "zones": true},
	"race": {"anchor": "race_overlay", "groups": ["race_overlay"]},
	"face_markings": {"anchor": "face_markings", "groups": ["face_markings"]},
	"tattoo": {"anchor": "tattoo", "groups": ["tattoo"]},
	# Gear is painted entirely in the hue code, so its zones start on real
	# colours instead of on white - see ZONE_DEFAULTS.
	# The body is dressed by one part but coloured as two, because the game equips
	# a chest and a pair of legs separately and the old paperdoll painted them
	# from two stats (`armor_color_base` and `armor_color_lower`, its `cloth_top`
	# and `cloth_bottom` node groups).  The lower half is the same three slots
	# that group held - the pelvis and the two legs - claimed by name and so
	# declared above the channel it is carving them out of.
	#
	# The belly and the two pregnancy slots stay on top: all three draw the *same*
	# attachment as one another in every set, so splitting them would paint one
	# piece of art in two colours.
	"outfit_lower": {"anchor": "outfit", "groups": [], "gear": true, "slots": [
		"equip_pelvis", "equip_leg_left", "equip_leg_right",
	]},
	"outfit": {"anchor": "outfit", "groups": ["outfit"], "gear": true},
	"collar": {"anchor": "collar", "groups": ["collar"], "gear": true},
	"headgear": {"anchor": "headgear", "groups": ["headgear"], "gear": true},
	"mask": {"anchor": "mask", "groups": ["mask"], "gear": true},
	"weapon": {"anchor": "weapon_belt", "groups": ["weapon_belt", "weapon_back"], "gear": true},
}

# Hue bands the art is coded in.  These are not guesses: they are the target
# colours the old paperdoll's own recolour materials were built around -
# Color(0.98, 0, 1), Color(0.5, 1, 0) and Color(0, 1, 0.6) - magenta, chartreuse
# and spring green.
#
# Zones are opt-in per channel, never guessed from the picture.  Measuring says
# a band is *present*, not that it is *meaningful*: purple hair, fox ears and a
# cat tail all sit as close to the magenta band as a coded gear pixel does, and
# offering them a second colour only produces the wrong one.  Coded art can be
# told apart by how tightly it hugs the band centre - gear lands within a degree
# of it, painted art spreads over the full window - but a fairy wing's membrane
# is shaded and spreads too, so no threshold separates the two.  Which channels
# are coded is therefore stated above, and the measurement below only decides
# which of the three bands a given part offers within those channels.
const ZONE_HUES = [299.0, 90.0, 156.0]

# Each band has its own half-width, because they do not have the same
# neighbours.  Coded pixels hug their centre - measured within 1 degree on gear
# and within 7 on the ear linings - so the widths below are set by what sits
# nearby in the art rather than by how far the code spreads:
#
#   magenta  - purple skin, hair, tails and ears live 21 to 24 degrees away, so
#              this band has to stay narrow or it repaints them.  A rabbit ear is
#              the closest of all at 21 degrees, which is exactly what a wider
#              band got wrong, and is the ceiling on this number.
#
#              20 rather than 15 because not every set is painted in the code
#              colour: the pet suit sits at 284 rather than 299, so at 15 only
#              61% of a glove took the pick and the rest kept the art colour.
#              20 reaches 85% of it and still stops short of the rabbit.  Its
#              cat and rabbit ear pieces are 33 degrees out and stay uncovered -
#              that art has to be repainted, no width reaches them safely.
#   green    - nothing in the art sits anywhere near it, and the armour greens
#              are shaded out to 29 degrees, so this band stays wide.  Narrowing
#              it left green patches showing through on the gear.
#   cyan     - nothing at all sits nearby, and the fairy wing membrane is shaded
#              and spreads about 22 degrees, so this one is wide.
const ZONE_DISTANCE = [20.0, 32.0, 26.0]

# How much of a part's art has to land in a band before that band is offered as a
# colour of its own, in percent of the part's opaque pixels.  Below this it is an
# anti-aliased edge, not a paintable zone.
const ZONE_COVERAGE_MIN = 2.0

# Where the zone pickers start.  Unlike the body channels, gear is never left at
# its raw art colour: unpainted magenta is a placeholder, not a look, so the
# defaults stand in for the old `default`, `default_metal` and `default_leather`
# presets.
const ZONE_DEFAULTS = [Color("7b8490"), Color("6f5133"), Color("8d3b3b")]
