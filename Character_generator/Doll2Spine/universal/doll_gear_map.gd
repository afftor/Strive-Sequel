extends Reference

# Equipped item -> catalogue selection, and the rules that went with it.
#
# The old paperdoll worked this out inside `CharacterClass.get_stat`, where a
# gear slot was turned into a `GeneratorData` key and anything unrecognised
# degraded to `servant`.  Those rules are game design, not rendering, so they are
# kept here rather than lost with the doll they were written for; what changes is
# only the name on the right-hand side.  `legacy/old_doll_behaviour.md` records
# where each of them came from.
#
# Nothing here reads a singleton: the caller passes plain values, so this file
# can be preloaded from anywhere.

# Gear slot -> the catalogue group it drives.
const SLOT_GROUPS = {
	"chest": "outfit",
	"legs": "outfit",
	"underwear": "outfit",
	"neck": "collar",
	"head": "headgear",
	"rhand": "weapon_belt",
	"back": "weapon_back",
}

# How much of a character is shown.  Four steps rather than a bool: a screen used
# to ask for dressed or not, and "not" meant one thing on the old doll - bare but
# still collared - while the game also wants a character in underwear, and wants
# a figure with nothing on at all for the moments that call for one.
const DRESSED = "dressed"
const UNDERWEAR = "underwear"
const BARE = "bare"
const NAKED = "naked"
const LEVELS = ["dressed", "underwear", "bare", "naked"]

# What each level is called on the buttons that switch between them.  The doll's
# corner and the test preview show the same four, so the names live with the
# levels rather than in one of the two.
const LEVEL_LABELS = {
	"dressed": "DOLL2_UNDRESS_DRESSED",
	"underwear": "DOLL2_UNDRESS_UNDERWEAR",
	"bare": "DOLL2_UNDRESS_BARE",
	"naked": "DOLL2_UNDRESS_NAKED",
}

# Which gear slots may dress the body at each level, in the order they are asked.
# The two undressed-but-not-naked levels wear whatever is in the underwear slot,
# or the default set when it is empty; nothing dresses a naked one.
const OUTFIT_BY_LEVEL = {
	"dressed": ["chest", "legs", "underwear"],
	"underwear": ["underwear"],
	"bare": ["underwear"],
	"naked": [],
}

# What stays on top at each level.  A collar is worn on a naked slave and a hat
# does not come off with the dress, so `bare` keeps those two and lets the
# weapons go; `naked` is naked.
const EXTRAS_BY_LEVEL = {
	"dressed": ["neck", "head", "rhand", "back"],
	"underwear": ["neck", "head", "rhand", "back"],
	"bare": ["neck", "head"],
	"naked": [],
}

# The slots a bare character does not wear even when the set they have on carries
# them: the chest, the crotch and the belly.  Everything else a set holds -
# stockings, sleeves, a cape - is not there for modesty and stays, which is the
# whole difference between `bare` and `naked`.  A set that has nothing but these
# leaves the two levels looking alike, and the doll then offers only one of them.
const MODESTY_SLOTS = [
	"equip_torso", "equip_breasts", "equip_pelvis", "equip_belly",
	"equip_pregnancy_low", "equip_pregnancy_up",
]

# The old doll dressed the upper and the lower half from two separate stats.
# The new catalogue has one `outfit` group covering the whole body, so the two
# cannot both write it: the chest is what a character reads as wearing, the legs
# answer for it only when the chest is bare, and underwear only when neither is.
const OUTFIT_PRIORITY = ["chest", "legs", "underwear"]

# A gear slot usually names the group whose art it wears, but the head slot holds
# both hats and masks and the catalogue keeps those in groups of their own.  An
# item named here goes to its group instead of its slot's; a part that lands in
# the wrong group is dropped by the doll and simply never appears.
const ITEM_GROUPS = {
	"mask": "mask",
	"foxmask": "mask",
}

# Every catalogue group gear can fill, which is what a naked character has none
# of.  The screens strip a character by level, but the test preview picks parts
# by hand and needs to know which of them are clothing.
const WORN_GROUPS = ["outfit", "collar", "headgear", "mask", "weapon_belt", "weapon_back"]

# Worn when nothing is equipped and the character is not on nudity duty.  The old
# doll put underwear on anyone not told to go naked; the slave set is what that
# means here, and it is the one set both dolls have.
const COVERED_BY_DEFAULT = "outfit_slave"

# What an unrecognised body item falls back to.  An unknown collar or weapon
# simply does not show, as before - only the outfit degrades.
const UNKNOWN_ITEM = "outfit_slave"

# The two dolls do not name everything alike, and the male has less of it.  Any
# part named here replaces the one above for that doll; `null` drops the entry.
const PER_DOLL = {
	"male": {
		"leather_collar": "collar_leather_big",
		"steel_collar": "collar_steel_big",
		"enslaving_collar": "collar_metallic_big",
		"bell_collar": "collar_bell_big",
		"elegant_choker": "collar_heart_big",
		"amulet_of_recognition": "collar_heart_small",
		"pet_suit": "collar_leather_small",
		"servant": "outfit_servant",
		"service_suit": "outfit_waiter",
		"underwear": "outfit_slave",
		"lacy_underwear": "outfit_slave",
		"seethrough_underwear": "outfit_slave",
	},
}

# itembase -> catalogue part.  The left-hand side is every itembase the old doll
# had art for; the right-hand side is the set that replaced it.  Entries marked
# `# guess` are the ones where the old name does not name a set the new art has,
# and are the first thing to check against the artist.
const ITEM_PARTS = {
	# cloth, leather and plate come in a base and an advanced cut, which is
	# exactly how the new sets are split
	"chest_base_cloth": "outfit_cloth",
	"chest_adv_cloth": "outfit_cloth3",
	"chest_base_leather": "outfit_leather",
	"chest_adv_leather": "outfit_leather2",
	"chest_base_metal": "outfit_plate",
	"chest_adv_metal": "outfit_plate2",
	"legs_base_cloth": "outfit_cloth",
	"legs_adv_cloth": "outfit_cloth3",
	"legs_base_leather": "outfit_leather",
	"legs_adv_leather": "outfit_leather2",
	"legs_base_metal": "outfit_plate",
	"legs_adv_metal": "outfit_plate2",

	"underwear": "outfit_underwear1",
	"lacy_underwear": "outfit_underwear2",
	"seethrough_underwear": "outfit_gipure1", # guess: the old art has no third underwear
	"jacket": "outfit_jacket",
	"latex_suit": "outfit_latex",
	"tentacle_suit": "outfit_tentacle",
	"service_suit": "outfit_waitress",
	"worker_outfit": "outfit_smith",
	"craftsman_suit": "outfit_smith", # guess: one smith set covers both trades
	"servant": "outfit_maid",

	# collars: the old list is item names, the new one is what the collar looks
	# like, so these pair by material
	"leather_collar": "collar_leather",
	"steel_collar": "collar_steel",
	"enslaving_collar": "collar_metallic",
	"bell_collar": "collar_bell",
	"elegant_choker": "collar_heart", # guess
	"amulet_of_recognition": "collar_heart", # guess
	"pet_suit": "collar_leather", # the suit's collar; its hood is headgear below

	# head
	# the old doll dressed `mask` in facemask2 and `foxmask` in facemask1, and the
	# art bears it out: facemask1 is the kitsune one
	"mask": "facemask2",
	"foxmask": "facemask1",

	# weapons carried at the belt
	"sword": "weapon_belt_sword",
	"swordadv": "weapon_belt_sword2",
	"holy_sword": "weapon_belt_sword2",
	"cali_heirloom": "weapon_belt_sword",
	"cali_heirloom_active": "weapon_belt_sword2",
	"dagger": "weapon_belt_dagger",
	"mace": "weapon_belt_mace",
	"maceadv": "weapon_back_mace2",
	"club": "weapon_belt_bat",
	# and the ones slung across the back
	"spear": "weapon_back_spear",
	"spearadv": "weapon_back_spear2",
	"holy_spear": "weapon_back_spear2",
	"bow": "weapon_back_bow",
	"bowadv": "weapon_back_bow2",
	"aire_bow": "weapon_back_bow2",
	"crossbow": "weapon_back_crossbow1",
	"crossbowadv": "weapon_back_crossbow2",
	"battleaxe": "weapon_back_axe1",
	"battleaxeadv": "weapon_back_axe2",
	"staff": "weapon_back_stick",
	"staffadv": "weapon_back_stick2",
}

# Items that put something on a second slot as well - the pet suit is a collar
# and a hood.
const ALSO = {
	"pet_suit": {"headgear": "Petsuit_cat"},
	"service_suit": {"headgear": "hair_armor_waitress"},
	"servant": {"headgear": "hair_armor_maid"},
}


# `equipped` is {gear slot: itembase or ""}, `level` is one of LEVELS.
static func selections_for(equipped, level = DRESSED, doll_id = "female"):
	var result = {}
	var shown = normalise(level)
	var dresses = OUTFIT_BY_LEVEL[shown]
	var extras = EXTRAS_BY_LEVEL[shown]
	# the body, resolved by priority because one group answers for both halves
	var outfit = ""
	for slot_name in dresses:
		var item_id = str(equipped.get(slot_name, ""))
		if item_id.empty():
			continue
		outfit = _part_for(item_id, doll_id)
		if outfit.empty():
			outfit = _override(UNKNOWN_ITEM, doll_id)
		break
	if outfit.empty() and !dresses.empty():
		outfit = default_underwear(doll_id)
	if !outfit.empty():
		result["outfit"] = outfit
	# and everything worn on top of it
	for slot_name in SLOT_GROUPS.keys():
		if slot_name in OUTFIT_PRIORITY:
			continue
		if !(slot_name in extras):
			continue
		var item_id = str(equipped.get(slot_name, ""))
		if item_id.empty():
			continue
		var part_id = _part_for(item_id, doll_id)
		if part_id.empty():
			continue
		# a weapon may hang at the belt or across the back, and the art decides
		var group_id = str(ITEM_GROUPS.get(item_id, SLOT_GROUPS[slot_name]))
		if part_id.begins_with("weapon_back"):
			group_id = "weapon_back"
		result[group_id] = part_id
	# items that also put something on a second slot, like the pet suit's hood
	for slot_name in equipped.keys():
		var item_id = str(equipped[slot_name])
		if !(slot_name in extras) and !(slot_name in dresses):
			continue
		for extra_group in ALSO.get(item_id, {}).keys():
			result[extra_group] = ALSO[item_id][extra_group]
	return result


# The set worn when the underwear slot is empty, under this doll's own naming.
static func default_underwear(doll_id = "female"):
	var named = str(PER_DOLL.get(doll_id, {}).get("_covered_by_default", ""))
	return named if !named.empty() else _override(COVERED_BY_DEFAULT, doll_id)


# The slots this level takes off a set it otherwise wears.  Only `bare` has any:
# it wears the underwear and shows the body through it.
static func hidden_slots(level = DRESSED):
	return MODESTY_SLOTS.duplicate() if normalise(level) == BARE else []


# A level name, from whatever a caller has.  The screens used to pass a bool, and
# `true` - stripped, collar left on - is what `bare` means now.
static func normalise(level):
	if typeof(level) == TYPE_BOOL:
		return BARE if level else DRESSED
	var name = str(level)
	return name if name in LEVELS else DRESSED


static func _part_for(item_id, doll_id):
	var per_doll = PER_DOLL.get(doll_id, {})
	if per_doll.has(item_id):
		return "" if per_doll[item_id] == null else str(per_doll[item_id])
	return str(ITEM_PARTS.get(item_id, ""))


static func _override(part_id, doll_id):
	var per_doll = PER_DOLL.get(doll_id, {})
	return str(per_doll[part_id]) if per_doll.has(part_id) else str(part_id)


# Entries pointing at parts a doll does not have.  The build report cannot see
# this file, so the check is offered here and called by the verification harness.
static func stale_entries(known_parts, doll_id = "female"):
	var result = []
	for item_id in ITEM_PARTS.keys():
		var part_id = _part_for(item_id, doll_id)
		if !part_id.empty() and !(part_id in known_parts):
			result.append("%s -> %s" % [item_id, part_id])
	var cover = str(PER_DOLL.get(doll_id, {}).get("_covered_by_default", COVERED_BY_DEFAULT))
	if !(cover in known_parts):
		result.append("the default cover -> %s" % cover)
	if !(_override(UNKNOWN_ITEM, doll_id) in known_parts):
		result.append("the fallback outfit -> %s" % _override(UNKNOWN_ITEM, doll_id))
	for item_id in ALSO.keys():
		for group_id in ALSO[item_id].keys():
			if !(ALSO[item_id][group_id] in known_parts):
				result.append("%s also -> %s" % [item_id, ALSO[item_id][group_id]])
	return result
