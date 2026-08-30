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
	# gloves wear the hands of a set and a tail plug wears a tail - the one piece
	# of gear that fills a body group
	"hands": "outfit_hands",
	"ass": "tails",
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
	"dressed": ["neck", "head", "rhand", "back", "hands", "ass"],
	"underwear": ["neck", "head", "rhand", "back", "hands", "ass"],
	# neither a plug nor a pair of paws is modesty, so the clothes coming off
	# leaves both where they were
	"bare": ["neck", "head", "ass", "hands"],
	# naked is naked, with one exception: a plug is worn in rather than on, and
	# taking the clothes off does not take it out
	"naked": ["ass"],
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

# The lower half of a set, worn when the legs have armour of their own.
#
# The catalogue carries a `<set>_legs` part for every set that has anything below
# the waist, composed after the whole set so it wins those slots; the suffix and
# the group are spelled in `doll2_overrides_shared.gd` under `LOWER_HALF`, and
# this file cannot read the catalogue, so they are named again here.
#
# What it buys: a character in a cloth shirt and plate greaves is drawn in both.
# The chest decides the body and the legs decide from the waist down; when a
# single item fills both slots - a dress, a suit - the two halves are the same
# set and nothing looks different.
const LOWER_GROUP = "outfit_legs"
const LOWER_SUFFIX = "_legs"
# and the pair of hands, which is worn over whatever the body has on rather than
# instead of it - see `SET_CUTS` in the overrides
const HANDS_SUFFIX = "_hands"

# A gear slot usually names the group whose art it wears, but the head slot holds
# both hats and masks and the catalogue keeps those in groups of their own.  An
# item named here goes to its group instead of its slot's; a part that lands in
# the wrong group is dropped by the doll and simply never appears.
const ITEM_GROUPS = {
	"mask": "mask",
	"foxmask": "mask",
}

# Gear that paints the part it puts on, whatever colour the character's own of
# that part is.  A tail plug is a bought thing with a colour of its own, not hair
# the wearer grew; the shade is a code from the doll's palette, the same names a
# character carries in `body_color_tail`.
const ITEM_COLOURS = {
	"tail_plug": {"tail": "orange1"},
}


# Every catalogue group gear can fill, which is what a naked character has none
# of.  The screens strip a character by level, but the test preview picks parts
# by hand and needs to know which of them are clothing.
const WORN_GROUPS = ["outfit", "outfit_legs", "outfit_hands", "collar", "headgear", "mask", "weapon_belt", "weapon_back"]

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
		"maid_dress": "outfit_servant",
		"service_suit": "outfit_waiter",
		# the male rig has the waiter where the female has the waitress, and no
		# pet suit of its own - so he keeps the collar and the hood and wears no
		# paws
		"worker_outfit": "outfit_waiter",
		"outfit_petsuit": null,
		"outfit_petsuit_hands": null,
		"animal_gloves": null,
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
	# lace is the gipure cut and the plainer second set is what shows through
	"lacy_underwear": "outfit_gipure1",
	"seethrough_underwear": "outfit_underwear2",
	"jacket": "outfit_jacket",
	"latex_suit": "outfit_latex",
	"tentacle_suit": "outfit_tentacle",
	# `service_suit` is the Bunny Costume - the code is the old one, the item is
	# the leotard with the ears, and the art for it is the playboy set.  It was
	# paired with the waitress by its code, which is how it came out dressed as a
	# waitress in game.
	"service_suit": "outfit_playboy",
	# two working outfits, two sets: the apron for the smith, the serving dress for
	# the worker
	"worker_outfit": "outfit_waitress",
	"craftsman_suit": "outfit_smith",
	# no item is called `servant`; the maid dress is `maid_dress`, and under the
	# old name it matched nothing and drew nothing
	"maid_dress": "outfit_maid",

	# worn things that fill a body group or a set of their own
	# the ears are the pet suit's headband, worn over the hair rather than growing
	# out of the head - the character keeps their own ears underneath
	"animal_ears": "Petsuit_cat",
	"tail_plug": "tail_fox_2",
	"maid_headband": "hair_armor_maid",
	# the only paw art in the export is the pet suit's, cut down to its hands: the
	# gloves are gloves, and they go on over anything
	"animal_gloves": "outfit_petsuit_hands",
	# medium armour, so the advanced leather rather than the base cut
	"garb_of_forest": "outfit_leather2",

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
# `maid_dress` is deliberately absent: the headband is its own item
# (`maid_headband`), and a dress that brought one along left no way to wear
# the dress without it.
const ALSO = {
	# The pet suit is worn on the neck, the hands and the head, so the collar is
	# what the slot itself answers with; the paws and the leggings are its own set
	# and the hood carries the ears.  All three have to be named, or the item shows
	# as a bare collar - which is what it did.
	"pet_suit": {"outfit": "outfit_petsuit", "outfit_hands": "outfit_petsuit_hands", "headgear": "Petsuit_cat"},
	"service_suit": {"headgear": "hair_armor_playboy"},
}


# `equipped` is {gear slot: itembase or ""}, `level` is one of LEVELS.
static func selections_for(equipped, level = DRESSED, doll_id = "female"):
	var result = {}
	var shown = normalise(level)
	var dresses = OUTFIT_BY_LEVEL[shown]
	var extras = EXTRAS_BY_LEVEL[shown]
	# The body: the chest first, then whatever is left that dresses it.  The legs
	# are deliberately not in this loop any more - they answer for the lower half
	# below, and a pair of greaves has no business dressing a torso.
	var outfit = ""
	for slot_name in dresses:
		if slot_name == "legs":
			continue
		var item_id = str(equipped.get(slot_name, ""))
		if item_id.empty():
			continue
		outfit = _part_for(item_id, doll_id)
		if outfit.empty():
			outfit = _override(UNKNOWN_ITEM, doll_id)
		break
	# Whether a dress, a suit or underwear actually answered for the body.  What
	# follows leans on it: gloves and a pet suit live in the same group as the
	# clothes, and they must not strip a character who is wearing some.
	var body_is_dressed = !outfit.empty()
	if outfit.empty() and !dresses.empty():
		outfit = default_underwear(doll_id)
	if !outfit.empty():
		result["outfit"] = outfit
	# and the lower half, when the legs wear something the body is not already in
	if !outfit.empty() and "legs" in dresses:
		var legs_item = str(equipped.get("legs", ""))
		if !legs_item.empty():
			var legs_part = _part_for(legs_item, doll_id)
			if !legs_part.empty() and legs_part != outfit:
				result[LOWER_GROUP] = legs_part + LOWER_SUFFIX
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
		if group_id == "outfit" and body_is_dressed:
			continue # the clothes keep the body; the paws would have bared it
		result[group_id] = part_id
	# Items that also put something on a second slot, like the pet suit's hood.
	# The dresses first and the worn-on-top slots after, so that when two items
	# both offer a hat the one actually worn on the head has the last word - a pet
	# suit's hood beats the headband its wearer's dress would have added.
	for slot_name in dresses + extras:
		var item_id = str(equipped.get(slot_name, ""))
		if item_id.empty():
			continue
		for extra_group in ALSO.get(item_id, {}).keys():
			# through the per-doll table as well: a second piece can be named
			# differently on the other rig, or not exist there at all
			var extra = _override(str(ALSO[item_id][extra_group]), doll_id)
			if extra.empty():
				continue
			if extra_group == "outfit" and body_is_dressed:
				continue # same rule: the pet suit adds paws, it does not undress
			result[extra_group] = extra
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
	if !per_doll.has(part_id):
		return str(part_id)
	# `null` is how the table says this doll simply has no such piece
	return "" if per_doll[part_id] == null else str(per_doll[part_id])


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
			# through the per-doll table, the way `selections_for` reads it: a
			# piece dropped for this doll is not a stale entry, it is an absence
			var extra = _override(str(ALSO[item_id][group_id]), doll_id)
			if !extra.empty() and !(extra in known_parts):
				result.append("%s also -> %s" % [item_id, extra])
	return result
