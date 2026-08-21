extends Reference

# Character stat -> catalogue selection.
#
# The old paperdoll kept this correspondence inside `GeneratorData.transforms`,
# mixed in with the node paths and the textures it applied.  Here it is only the
# correspondence: which value of which stat means which part.
# `legacy/old_doll_behaviour.md` lists every stat the old doll read and what it
# accepted; this file answers it value by value.
#
# Where the two dolls happen to agree on a name, RULES resolves it and no entry
# is needed.  VALUES holds the rest, which is most of the older art: those names
# were written before these folders were.
#
# Nothing here touches a singleton - the caller passes the values in.

const GEAR = preload("res://Character_generator/Doll2Spine/universal/doll_gear_map.gd")

# stat -> the group it picks a part in.
const FEEDS = {
	"chin": "head",
	"eyeshape": "face",
	"eye_tex": "eyes",
	"eyebrows": "eyebrows",
	"lips": "lips",
	"nose": "nose",
	"ears": "ears",
	"hair_base": "hair",
	"hair_back": "hair_back",
	"hair_assist": "hair_assist",
	# The male export grew beard art; the female rig has none and ignores it.
	"beard": "beard",
	"horns": "horns",
	"wings": "wings",
	"tail": "tails",
	"penis_type": "genitals",
}

# Prefix tried when a value has no entry below: `straight` finds
# `hair_base_straight`, `cat` finds `ears_cat`.
const RULES = {
	"head": "head_chin_",
	"face": "",
	"eyes": "",
	"eyebrows": "",
	"lips": "lips_",
	"nose": "nose_",
	"ears": "ears_",
	"hair": "hair_base_",
	"hair_back": "hair_back_",
	"hair_assist": "hair_assist_",
	"beard": "",
	"horns": "horn_",
	"wings": "wings_",
	"tails": "tail_",
	"genitals": "Dick_",
}

# What the rules cannot reach.  An empty string means the new art has nothing for
# that value and the slot stays bare - a content gap, recorded rather than hidden.
const VALUES = {
	"eye_tex": {
		"eyes1m": "eyes_m1", "eyes2m": "eyes_m2", "eyes3m": "eyes_m3",
		"eyes4m": "eyes_m4", "eyes5m": "eyes_m5",
	},
	"eyebrows": {
		"style1": "eyebrows1", "style2": "eyebrows2", "style3": "eyebrows3",
		"style4": "eyebrows4", "style5": "eyebrows5",
		"style6": "eyebrows_m1", "style7": "eyebrows_m2", "style8": "eyebrows_m3",
	},
	"lips": {
		"none": "", "style1": "lips1", "style2": "lips2", "style3": "lips3",
		"style4": "lips4", "style5": "lips5", "orcish": "lips_orc",
		"style6": "lips_m1", "style7": "lips_m2", "style8": "lips_m3", "style9": "lips_m4",
		# the new smiles, drawn for either sex
		"style10": "lips_s1", "style11": "lips_s2", "style12": "lips_s3",
		"orcish_1": "lips_orc_1", "orcish_2": "lips_orc_2", "orcish_3": "lips_orc_3",
		"beastkin_cry": "beastkin_lips_cry", "beastkin_open": "beastkin_lips_open",
		"beastkin_smile": "beastkin_lips_smile",
	},
	"ears": {
		"rat": "ears_mouse", "tanuki": "ears_tanuk", "cow": "ears_taurus",
		"bunny": "ears_rabbit", "bunny_standing": "ears_rabbit2",
		"bunny_drooping": "ears_rabbit3", "orcish": "ears_orc",
		"normal": "ears_human", "fish": "ears_nereid",
		"demon": "", "feathered": "",
	},
	"horns": {
		# the names are the old doll's and so is the art each one picked: its
		# `straight` was the diagonal pair and its `short` the stubby one.  The
		# export carries a single spiral, so both spiral names land on it.
		"curved": "horn_curve_up", "curved_top": "horn_curve_top",
		"curved_down": "horn_curve_down",
		"straight": "Horn_straight_diagonal", "short": "Horn_straight_top",
		"dragon": "horn_dragon2", "seraph": "horn_seraph_fibule",
		"spiral": "horn_spiral_2", "spiral_2": "horn_spiral_2",
	},
	# a beastkin muzzle has its nose drawn in, so there is no separate one
	"nose": {"beastkin": ""},
	"tail": {
		"rat": "tail_mouse", "tanuki": "tail_tanuk", "fish": "tail_nereid",
		"dragon2": "tail_dragon2",
		# Tails with no art of their own.  A centaur, a lamia and a harpy wear a
		# whole lower body instead, and nobody has drawn a rabbit's scut yet.
		"cow": "", "horse": "", "snake": "", "avian": "", "bunny": "",
	},
	"penis_type": {
		"human": "Dick_human_up", "furry": "Dick_furry_up", "feline": "Dick_furry_up",
		"canine": "Dick_furry_up", "equine": "Dick_horse_up",
	},
	"chin": {
		"kobold": "head_chin_curve_kobold", "kobold_2": "head_chin_kobold2",
		"skinny": "head_chin_long_skinny", "small": "head_chin_small",
		# a beastkin muzzle depends on the animal; BEAST_CHINS answers it
		"beastkin": "",
	},
	"hair_base": {
		"fringe2": "hair_base_fringe_2", "lion": "hairs_base_lion",
	},
	"hair_back": {
		"wave": "hair_back_wawe", "very_long": "hair_back_verylong1",
		"double_tail": "hair_back_double_tail_long",
		"twin_braids": "hair_back_twin_braids", "no": "",
	},
	"hair_assist": {
		"no": "", "twin_tails_2": "hair_assist_twin_tails_2",
		"ponytail_2": "ponytail_2", "ponytail_3": "ponytail_3",
		"twin_tails_3": "twin_tails_3",
		# two names the export drew the same way; the art is gone, the saved
		# characters wearing them are not
		"twin_tails_4": "hair_assist_twin_tails",
		"twin_tails_5": "hair_assist_twin_tails_2",
	},
	# Seventeen pieces of beard art against the twelve styles the game had:
	# the extra five are new values, so nothing the artist drew is unreachable.
	"beard": {
		"no": "", "": "",
		"style1": "beard1", "style2": "beard2", "style3": "beard3",
		"style4": "beard4", "style5": "beard5", "style6": "beard6",
		"style7": "beard7", "style8": "beard8", "style9": "beard9",
		"style10": "beard_moustache1", "style11": "beard_moustache2",
		"style12": "beard_moustache3", "style13": "beard_moustache4",
		"style14": "moustache1", "style15": "moustache2",
		"style16": "moustache3", "style17": "moustache4",
	},
	"wings": {
		"dragon": "Wings_dragon", "fairy": "Wings_fairy", "seraph": "Wings_seraph",
		# the art spells the harpy's pair the Latin way
		"harpy": "wings_harpia",
	},
}

# A beastkin does not merely wear a muzzle: the face and the mouth are drawn for
# a snout as well, and the human ones sit flat on it.  These are the groups with
# a beastkin cut, and how a human value becomes its beastkin counterpart.
#   face   face3 -> beastkin_face3, face_m2 -> beastkin_face_m2
#   lips   any human mouth -> the beast mouth; the three `beastkin_lips_*` are
#          expressions and stay reachable by naming them outright
#   head   forced to a muzzle even when the character's chin says otherwise,
#          because a human chin on a beastkin body is the wrong shape
const BEASTKIN_GROUPS = ["head", "face", "lips", "nose"]
const BEASTKIN_FACE_PREFIX = "beastkin_"
const BEASTKIN_DEFAULT_FACE = "beastkin_face1"
const BEASTKIN_LIPS = "lips_beast"
const BEASTKIN_EXPRESSIONS = ["beastkin_lips_cry", "beastkin_lips_open", "beastkin_lips_smile"]


# The muzzle to use, by the animal the beastkin race is drawn from.
const BEAST_CHINS = {
	"cat": "beastkin_chin_cat", "fox": "beastkin_chin_fox", "wolf": "beastkin_chin_wolf",
	"rabbit": "beastkin_chin_rabbit", "bunny": "beastkin_chin_rabbit",
	"tanuki": "beastkin_chin_tanuki", "rat": "beastkin_chin_cat",
}

# The old doll had one rig and swapped textures on it; here the body is a part.
const BODIES = {
	"female": {"base": "body_female_base", "beastkin": "body_female_beastkin"},
	"male": {"base": "body_male_base", "beastkin": "body_male_beastkin", "femboy": "body_male_femboy"},
}

# Races that put a whole overlay on the body rather than only ears and a tail.
const RACE_OVERLAYS = {
	"Dragonkin": "race_dragon", "Kobold": "race_kobold", "Dryad": "race_dryad",
	"Nereid": "race_nereid", "Slime": "race_slime",
}

# A dragon's scales and a kobold's spots are drawn parts rather than fur
# masks: they are variants of the race's own overlay, and `skin_coverage` is
# what picks between them.  `doll_coverage.gd` answers the furs.
const OVERLAY_COVERAGE = {
	"race_dragon": {
		"scale": "race_dragon", "scale2": "race_dragon_scales",
		"scale3": "race_dragon_scales2",
	},
	"race_kobold": {"kobold": "race_kobold", "kobold_spots": "race_kobold_spots"},
}

# Races whose lower half is an animal.
# The race ids are the game's; the part ids are the art's, and the two spell the
# centaur differently.
const ANIMAL_BODIES = {
	"Centaur": "kentaur_body",
	"Arachna": "arachna_body",
	"Lamia": "lamia_body",
	"Scylla": "scylla_body",
}


# `stats` is a plain dictionary of the values the old doll read, plus
# `equipment` and `undress` for the gear.  An unknown value leaves its slot alone,
# exactly as a missing `transforms` entry did.
static func selections_for(stats, doll_id = "female"):
	var result = {}
	var race = str(stats.get("race", ""))
	# Only beastkin are drawn as animals.  A halfkin is the same race with the fur
	# taken off - the game renames `Beastkin` to `Halfkin` itself when the furry
	# setting is off - so they keep the ears and the tail on a human body and a
	# human face.  Ratkin are their own race and are not furry either.
	var beastkin = race.find("Beastkin") >= 0
	var bodies = BODIES.get(doll_id, BODIES.female)
	var body = "beastkin" if beastkin else "base"
	if str(stats.get("body_shape", "")) == "femboy" and bodies.has("femboy"):
		body = "femboy"
	result["body"] = bodies[body]

	# The old doll showed or hid the whole genitals node from `sex`: a woman has
	# none, a man and a futa do.  Reading `penis_type` alone put one on everybody,
	# because every character carries a type whether or not they have the part.
	var sex = str(stats.get("sex", "female"))
	# Dressed characters keep them out of sight, as they did on the old doll.  The
	# export only carries the erect variants (`Dick_*_up`), whose upper half is
	# drawn on the belly above any waistband, so putting one under the trousers
	# still leaves it sticking out over them.  When the art gains a resting
	# variant this becomes a choice between the two rather than a hide.
	var undress = GEAR.normalise(stats.get("undress", stats.get("nude", false)))
	var bared = undress == GEAR.BARE or undress == GEAR.NAKED
	var has_genitals = (sex == "male" or sex == "futa") and bared
	for stat in FEEDS.keys():
		var group_id = str(FEEDS[stat])
		if group_id == "genitals" and !has_genitals:
			result[group_id] = ""
			continue
		var part_id = resolve(stat, str(stats.get(stat, "")), stats)
		if beastkin and group_id in BEASTKIN_GROUPS:
			# these four are decided by the muzzle, whatever the character says -
			# including when it says nothing.  Leaving them to the catalogue's
			# default puts a human face and mouth on a snout, which is what the
			# old doll's `chin = beastkin` was there to prevent.
			result[group_id] = beastkin_variant(group_id, part_id, stats)
			continue
		if part_id != "":
			result[group_id] = part_id

	if RACE_OVERLAYS.has(race):
		var overlay = str(RACE_OVERLAYS[race])
		var variants = OVERLAY_COVERAGE.get(overlay, {})
		overlay = str(variants.get(str(stats.get("skin_coverage", "")), overlay))
		result["race_overlay"] = overlay
	if ANIMAL_BODIES.has(race):
		result["animal_body"] = ANIMAL_BODIES[race]
	for stat in ["tattoo", "face_markings"]:
		var value = str(stats.get(stat, ""))
		if value != "":
			result[stat] = value

	var gear = GEAR.selections_for(stats.get("equipment", {}), undress, doll_id)
	for group_id in gear.keys():
		result[group_id] = gear[group_id]
	return result


# The beastkin cut of a part, or the part unchanged when there is none.
static func beastkin_variant(group_id, part_id, stats = {}):
	if group_id == "head":
		return str(BEAST_CHINS.get(str(stats.get("beast", "")), "beastkin_chin_cat"))
	if group_id == "face":
		if part_id == "":
			return BEASTKIN_DEFAULT_FACE
		return part_id if part_id.begins_with(BEASTKIN_FACE_PREFIX) else BEASTKIN_FACE_PREFIX + part_id
	if group_id == "lips":
		return part_id if part_id in BEASTKIN_EXPRESSIONS else BEASTKIN_LIPS
	# the muzzle is drawn with its own nose, so the human one would be a second
	if group_id == "nose":
		return ""
	return part_id


static func resolve(stat, value, stats = {}):
	if value == "" or value == "no" or value == "none" or value == "Null":
		return ""
	if stat == "chin" and value == "beastkin":
		return str(BEAST_CHINS.get(str(stats.get("beast", "")), "beastkin_chin_cat"))
	var table = VALUES.get(stat, {})
	if table.has(value):
		return str(table[value])
	var prefix = str(RULES.get(str(FEEDS.get(stat, "")), ""))
	return prefix + value


# Every value the old doll accepted that this map answers with a part the
# catalogue does not have, so the gaps are reported rather than met on a
# character.
static func unmapped(old_values, parts_by_group):
	var result = []
	for stat in FEEDS.keys():
		var group_id = str(FEEDS[stat])
		var known = parts_by_group.get(group_id, [])
		for value in old_values.get(stat, []):
			var part_id = resolve(stat, str(value), {"beast": "cat"})
			if part_id == "":
				continue
			if !(part_id in known):
				result.append("%s = %s -> %s, which %s has not" % [stat, value, part_id, group_id])
	return result
