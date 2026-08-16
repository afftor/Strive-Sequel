extends Reference

# Game item -> catalogue selection.
#
# The old paperdoll resolves equipment inside CharacterClass.get_stat, where a
# gear type is translated to a GeneratorData key and anything unknown degrades to
# `servant`.  This file is the same idea without the hardcoding: an item id maps
# to ordinary catalogue selections, and an unmapped item falls back to FALLBACK
# instead of rendering nothing.
#
# Nothing reads this yet - it is wired up when the doll is bound to characters.
# The catalogue part ids used here are validated by the build report only once
# entries exist, so keep them in sync with doll2_catalogue_gen.gd.

const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")

# Gear slot -> catalogue group it drives.
const SLOT_GROUPS = {
	"chest": "outfit",
	"legs": "outfit",
	"neck": "collar",
	"head": "headgear",
	"rhand": "weapon_belt",
	"back": "weapon_back",
}

# Item id -> {group: part id}.
const ITEM_PARTS = {
	# "platearmor": {"outfit": "outfit_plate"},
	# "maidoutfit": {"outfit": "outfit_maid"},
}

# Used when an equipped item has no entry, so unknown gear still looks dressed.
const FALLBACK = {"outfit": "outfit_slave"}


static func selections_for(item_ids):
	var result = {}
	for item_id in item_ids:
		if ITEM_PARTS.has(item_id):
			for group_id in ITEM_PARTS[item_id].keys():
				result[group_id] = ITEM_PARTS[item_id][group_id]
		elif !item_id.empty():
			for group_id in FALLBACK.keys():
				result[group_id] = FALLBACK[group_id]
	return result


# Reports entries pointing at parts the catalogue no longer has.
static func stale_entries():
	var result = []
	for item_id in ITEM_PARTS.keys():
		for group_id in ITEM_PARTS[item_id].keys():
			var part_id = ITEM_PARTS[item_id][group_id]
			if CATALOGUE.part(part_id).empty():
				result.append("%s -> %s" % [item_id, part_id])
	return result
