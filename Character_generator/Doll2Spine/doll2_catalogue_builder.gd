extends Reference

# Builds a catalogue from a Spine export plus its overrides: the shared file
# doll2_overrides_shared.gd, with doll2_overrides.gd (female) or
# doll2_overrides_male.gd merged over it.
#
# Run it through doll2_catalogue_build.gd (editor: File > Run) or through
# doll2_catalogue_build_cli.gd (command line).  The build is deterministic: the
# same export and the same overrides always produce a byte-identical catalogue,
# so an unchanged re-export leaves the file and its git diff untouched.
#
# The catalogue carries semantics only - part names, groups, axis values.  Mesh,
# vertex, UV and animation data stay in the Spine JSON and are read at runtime.

# Default semantics.  `build` takes an `overrides` option so a second export -
# the male doll - is built from its own file against the same generator.
const OVERRIDES = preload("res://Character_generator/Doll2Spine/doll2_overrides.gd")

const BASE_DIR = "res://Character_generator/Doll2Spine/"
const JSON_PATH = BASE_DIR + "Doll2_spine4.2_female.json"
const ATLAS_PATH = BASE_DIR + "Doll2_spine4.2_female.atlas"
const GEN_PATH = BASE_DIR + "doll2_catalogue_gen.gd"
const CONTRACT_PATH = BASE_DIR + "universal/doll_contract.gd"
const REPORT_PATH = "user://doll2_catalogue_report.txt"
# Default contract id; a doll with a rig of its own is built with another one.
const CONTRACT_ID = "doll2_v1"
const SCHEMA_VERSION = 2

# Seed used only when the contract file does not exist yet.  Hand-authored
# handles are preserved from the existing contract on every later run.
const SEED_HANDLES = {
	"left_hand": {"label": "DOLL2_PREVIEW_HANDLE_LEFT_HAND", "end_bone": "hand_l", "ik_bones": ["shoulder_l", "forearm_l"], "bend": 1},
	"right_hand": {"label": "DOLL2_PREVIEW_HANDLE_RIGHT_HAND", "end_bone": "hand_r", "ik_bones": ["shoulder_r", "forearm_r"], "bend": -1},
	"left_foot": {"label": "DOLL2_PREVIEW_HANDLE_LEFT_FOOT", "target_bones": ["target4", "target2"]},
	"right_foot": {"label": "DOLL2_PREVIEW_HANDLE_RIGHT_FOOT", "target_bones": ["target3", "target1"]},
}

# The overrides script this build reads its semantics from.
var _overrides = OVERRIDES
# Contract this build writes and checks against.  The male rig renames a handful
# of bones and drops the breast chain, so it cannot answer to the female id.
var _contract_id = CONTRACT_ID
var report_lines = []
var problems = []
# slot -> {attachment name: canonical attachment name}.  Attachment names are
# unique inside a slot, so this map is never ambiguous.
var canonical_by_name = {}
# slot -> {source art file name: canonical attachment name}.  Art names can be
# shared by several attachments, so this is only consulted as a fallback.
var canonical_by_base = {}
# attachment name -> its art path, for looking the art up when scanning zones
var _attachment_path_by_name = {}
# Canonical records of the current build, so a paired slot can look up the
# attachment that matches a part's style.
var _all_records = []
var _style_cache = {}


# Composes a doll's semantics over the shared ones.  A doll file declares only
# what its own export holds; anything it leaves out comes from the file named by
# its `SHARED` constant, and a key it sets to `null` drops the shared entry for
# that doll - the male rig has no kobold art, so it drops the kobold preset.
#
# The result is a plain dictionary, which reads exactly like the script it
# replaces: `_overrides.FOLDER_MAP` works either way.
func _compose_overrides(doll):
	var constants = doll.get_script_constant_map()
	var result = {}
	if constants.has("SHARED") and constants["SHARED"] != null:
		var shared = constants["SHARED"].get_script_constant_map()
		for key in shared.keys():
			result[key] = shared[key]
	for key in constants.keys():
		if key == "SHARED":
			continue
		result[key] = _merge_table(result.get(key, null), constants[key])
	return result


func _merge_table(base, addition):
	if typeof(base) == TYPE_DICTIONARY and typeof(addition) == TYPE_DICTIONARY:
		var merged = base.duplicate()
		for key in addition.keys():
			if addition[key] == null:
				merged.erase(key)
			else:
				merged[key] = addition[key]
		return merged
	if typeof(base) == TYPE_ARRAY and typeof(addition) == TYPE_ARRAY:
		return base + addition
	return addition


# Returns {"ok": bool, "written": bool, "report": String, "catalogue": Dictionary}.
func build(options = {}):
	_overrides = _compose_overrides(options.get("overrides", OVERRIDES))
	_contract_id = str(options.get("contract_id", CONTRACT_ID))
	report_lines = []
	problems = []
	var json_path = options.get("json_path", JSON_PATH)
	var atlas_path = options.get("atlas_path", ATLAS_PATH)
	var gen_path = options.get("gen_path", GEN_PATH)
	var contract_path = options.get("contract_path", CONTRACT_PATH)
	var update_contract = bool(options.get("update_contract", false))
	var dry_run = bool(options.get("dry_run", false))

	var skeleton = _read_json(json_path)
	if skeleton.empty():
		return _fail("cannot read Spine JSON at " + json_path)
	var atlas_regions = _read_atlas_regions(atlas_path)
	if atlas_regions.empty():
		return _fail("cannot read Spine atlas at " + atlas_path)

	var slot_order = []
	for slot in skeleton.get("slots", []):
		slot_order.append(slot.get("name", ""))
	var setup = {}
	for slot in skeleton.get("slots", []):
		if slot.has("attachment"):
			setup[slot.get("name", "")] = slot.get("attachment")

	_line("DOLL 2 CATALOGUE BUILD")
	_line("  skeleton   %s" % json_path)
	_line("  spine      %s" % str(skeleton.get("skeleton", {}).get("spine", "?")))
	_line("  hash       %s" % str(skeleton.get("skeleton", {}).get("hash", "?")))
	_line("  bones      %d" % skeleton.get("bones", []).size())
	_line("  slots      %d" % slot_order.size())

	var skins = skeleton.get("skins", [])
	if skins.size() != 1:
		_problem("expected a single flattened skin, found %d" % skins.size())
	var attachments = {}
	if skins.size() > 0:
		attachments = skins[0].get("attachments", {})

	var bone_names = []
	for bone in skeleton.get("bones", []):
		bone_names.append(str(bone.get("name", "")))
	var records = _collect_records(attachments, slot_order, bone_names)
	_line("  attachmnt  %d" % records.size())
	_line("")

	var canonical = _canonicalize(records)
	_all_records = canonical.records
	_style_cache = {}
	var built = _build_parts(canonical.records, slot_order)
	_scan_zones(built.parts, atlas_regions, atlas_path)
	_check_art_health(records, atlas_regions)
	_check_atlas(canonical.records, atlas_regions)
	_check_overrides(canonical, built)
	_report_contract(skeleton, slot_order, contract_path, update_contract)

	var catalogue = {
		"SCHEMA_VERSION": SCHEMA_VERSION,
		"SOURCE": {
			"contract": _contract_id,
			"spine_version": str(skeleton.get("skeleton", {}).get("spine", "")),
			"skeleton_hash": str(skeleton.get("skeleton", {}).get("hash", "")),
			"skeleton": json_path.get_file(),
			"atlas": atlas_path.get_file(),
			"bone_count": skeleton.get("bones", []).size(),
			"slot_count": slot_order.size(),
			"attachment_count": records.size(),
		},
		"SLOT_ORDER": slot_order,
		"DRAW_ORDER": _draw_order(slot_order),
		# The corrections as rules, not just baked into the order above: an
		# animation that reorders slots has to be re-corrected afterwards, and an
		# index cannot survive that.
		"DRAW_ORDER_FIXES": _overrides.DRAW_ORDER_FIXES,
		"GROUP_ORDER": built.group_order,
		"GROUPS": built.groups,
		"PARTS": built.parts,
		"AXES": _public_axes(),
		"FIXED_SLOTS": _overrides.FIXED_SLOTS,
		"COLOR_CHANNELS": built.color_channels,
		"SLOT_COLORS": built.slot_colors,
		"ZONE_HUES": _overrides.ZONE_HUES,
		"ZONE_DISTANCE": _overrides.ZONE_DISTANCE,
		"ZONE_DEFAULTS": _overrides.ZONE_DEFAULTS,
		"ALIASES": canonical.aliases,
		"UNCATEGORIZED": built.uncategorized,
		"PRESETS": built.presets,
	}

	var text = _emit(catalogue)
	var previous = _load_constants(gen_path)
	_report_diff(previous, catalogue)

	var written = false
	if dry_run:
		_line("DRY RUN - nothing written")
	elif _same_file(gen_path, text):
		_line("NO CHANGES - %s is up to date" % gen_path)
	else:
		if _write_file(gen_path, text):
			written = true
			_line("WROTE %s" % gen_path)
		else:
			_problem("cannot write " + gen_path)

	if !dry_run and (update_contract or !_file_exists(contract_path)):
		var contract_text = _emit_contract(skeleton, slot_order, contract_path)
		if _write_file(contract_path, contract_text):
			_line("WROTE %s" % contract_path)
		else:
			_problem("cannot write " + contract_path)

	_line("")
	if problems.empty():
		_line("RESULT: clean")
	else:
		_line("RESULT: %d problem(s)" % problems.size())
		for entry in problems:
			_line("  ! " + entry)
	var report = _join(report_lines, "\n")
	_write_file(REPORT_PATH, report)
	return {"ok": problems.empty(), "written": written, "report": report, "catalogue": catalogue}


# ------------------------------------------------------------- collection ---

func _collect_records(attachments, slot_order, bone_names = []):
	var records = []
	for slot_name in slot_order:
		if !attachments.has(slot_name):
			continue
		var names = attachments[slot_name].keys()
		names.sort()
		for name in names:
			var entry = attachments[slot_name][name]
			var path = str(entry.get("path", name))
			var folder = ""
			var base = path
			var cut = path.rfind("/")
			if cut >= 0:
				folder = path.substr(0, cut)
				base = path.substr(cut + 1, path.length())
			var weighted = entry.get("vertices", []).size() != entry.get("uvs", []).size()
			_attachment_path_by_name[name] = path
			records.append({
				"slot": slot_name,
				"name": name,
				"path": path,
				"folder": folder,
				"base": base,
				"weighted": weighted,
				"bones": _bound_bones(entry, bone_names) if weighted else [],
				"triangles": entry.get("triangles", []).size() / 3,
				"hull": int(entry.get("hull", 0)),
			})
	return records


# Bones a weighted mesh is actually bound to.  A Spine weighted vertex is stored
# as a bone count followed by that many (bone index, x, y, weight) groups.
func _bound_bones(entry, bone_names):
	var result = {}
	var vertices = entry.get("vertices", [])
	var cursor = 0
	while cursor < vertices.size():
		var count = int(vertices[cursor])
		cursor += 1
		for _i in range(count):
			var index = int(vertices[cursor])
			if index >= 0 and index < bone_names.size():
				result[bone_names[index]] = true
			cursor += 4
	var names = result.keys()
	names.sort()
	return names


# One family per (slot, path): the same art reached through several attachment
# names.  The best name becomes canonical, the others become aliases.  Weighted
# meshes win over unweighted ones, which is what heals the broken duplicates the
# flattening left behind (an unweighted head that cannot follow the skeleton).
func _canonicalize(records):
	var families = {}
	var order = []
	for record in records:
		var key = record.slot + "\u0000" + record.path
		if !families.has(key):
			families[key] = []
			order.append(key)
		families[key].append(record)
	var canonical_records = []
	var aliases = {}
	var collisions = []
	var wrong_art = []
	canonical_by_name = {}
	canonical_by_base = {}
	for key in order:
		var members = families[key]
		var best = members[0]
		var best_rank = _canonical_rank(best)
		for member in members:
			var rank = _canonical_rank(member)
			if rank < best_rank:
				best = member
				best_rank = rank
		canonical_records.append(best)
		if members.size() > 1:
			collisions.append(best.slot + "/" + best.name + "  (%d names)" % members.size())
		if !canonical_by_name.has(best.slot):
			canonical_by_name[best.slot] = {}
			canonical_by_base[best.slot] = {}
		# Overrides may name an attachment by any of its aliases or by the source
		# art file; all of them lead to the canonical name.
		canonical_by_name[best.slot][best.name] = best.name
		canonical_by_base[best.slot][best.base] = best.name
		for member in members:
			if member.name == best.name:
				continue
			if !aliases.has(member.slot):
				aliases[member.slot] = {}
			aliases[member.slot][member.name] = best.name
			canonical_by_name[member.slot][member.name] = best.name
			# A name that does not appear anywhere in its own art path is a
			# mislabelled attachment: it renders someone else's mesh.
			if member.name.find(member.base) == -1 and member.base.find(member.name) == -1:
				wrong_art.append("%s: %s -> %s" % [member.slot, member.name, member.path])
	_line("CANONICALISATION")
	_line("  families %d, canonical %d, aliases %d" % [order.size(), canonical_records.size(), records.size() - canonical_records.size()])
	if !wrong_art.empty():
		_line("  names pointing at another attachment's art (fix in the Spine project):")
		for entry in wrong_art:
			_line("    " + entry)
	_line("")
	return {"records": canonical_records, "aliases": aliases, "collisions": collisions}


func _canonical_rank(record):
	var weight_penalty = 0 if record.weighted else 1
	var rank = 4
	if record.name == record.base:
		rank = 0
	elif record.name.begins_with(record.base + "__"):
		rank = 1 if record.name.find("__body_female") >= 0 else 2
	elif record.name.find("__") == -1:
		rank = 3
	return "%d_%d_%03d_%s" % [weight_penalty, rank, min(record.name.length(), 999), record.name]


# ------------------------------------------------------------------ parts ---

func _build_parts(records, slot_order):
	var excluded = []
	var uncategorized = {}
	var option_records = {}
	var set_records = {}
	var slot_index = {}
	for i in range(slot_order.size()):
		slot_index[slot_order[i]] = i

	for record in records:
		# An entry is either an attachment name, dropped wherever it appears, or a
		# `slot/name` pair when the same attachment is wanted in one slot and not
		# in another - the plate armour puts the body's flat nipple mask into the
		# breast slot, where it overrides the size-matched one.
		#
		# Matched against the bare name as well as the full one: an export may
		# spell an attachment `04_hairs_base/hairs_base_dopple` or plainly
		# `hairs_base_dopple` depending on how the art was imported, and an
		# override should not have to know which.
		if _is_excluded(record):
			excluded.append(record.slot + "/" + record.name)
			continue
		if record.slot in _overrides.CONSUMED_SLOTS:
			continue
		var group_id = _route(record)
		if group_id.empty():
			if !uncategorized.has(record.slot):
				uncategorized[record.slot] = []
			uncategorized[record.slot].append(record.name)
			continue
		var group_def = _overrides.GROUP_DEFS[group_id]
		if group_def.kind == "options":
			if !option_records.has(group_id):
				option_records[group_id] = []
			option_records[group_id].append(record)
		else:
			var folder_entry = _overrides.FOLDER_MAP.get(record.folder, {})
			var part_id = str(folder_entry.get("part", ""))
			if part_id.empty():
				_problem("folder %s feeds set group %s without a `part` name" % [record.folder, group_id])
				continue
			if !set_records.has(part_id):
				set_records[part_id] = {"group": group_id, "folders": {}, "slots": {}}
			set_records[part_id].folders[record.folder] = true
			if !set_records[part_id].slots.has(record.slot):
				set_records[part_id].slots[record.slot] = []
			set_records[part_id].slots[record.slot].append(record)

	var parts = {}
	_build_option_parts(option_records, parts)
	_build_set_parts(set_records, parts)
	# Carried into the catalogue so the doll can see it without the overrides.
	# The list is shared by both rigs and they do not hold the same sets - the
	# maid dress is the male doll's `outfit_servant` - so a name this doll has
	# never heard of is noted rather than treated as a fault.
	for part_id in _overrides.get("UNPAINTED_PARTS", []):
		if parts.has(part_id):
			parts[part_id]["unpainted"] = true
		else:
			_line("  UNPAINTED_PARTS: this doll has no `%s`" % part_id)
	_build_set_cuts(parts)

	var groups = {}
	var group_ids = _overrides.GROUP_DEFS.keys()
	for group_id in group_ids:
		var group_def = _overrides.GROUP_DEFS[group_id]
		var members = []
		var slots = {}
		for part_id in parts.keys():
			if parts[part_id].group != group_id:
				continue
			members.append(part_id)
			for slot_name in parts[part_id].slots.keys():
				slots[slot_name] = true
		members.sort()
		var slot_names = slots.keys()
		slot_names.sort()
		var default_part = str(_overrides.DEFAULTS.get(group_id, ""))
		if !default_part.empty() and !(default_part in members):
			_problem("default part `%s` for group %s does not exist" % [default_part, group_id])
			default_part = ""
		if default_part.empty() and !group_def.optional and !members.empty():
			default_part = members[0]
		groups[group_id] = {
			"kind": group_def.kind,
			"optional": group_def.optional,
			"label": group_def.label,
			"order": group_def.order,
			"slots": slot_names,
			"parts": members,
			"default": default_part,
		}
		if members.empty():
			_problem("group %s has no parts" % group_id)

	var group_order = groups.keys()
	group_order.sort()
	group_order = _sort_by_order(group_order, groups)

	_line("GROUPS")
	for group_id in group_order:
		_line("  %-14s %-8s %3d parts  %2d slots" % [group_id, groups[group_id].kind, groups[group_id].parts.size(), groups[group_id].slots.size()])
	_line("")
	if !excluded.empty():
		_line("EXCLUDED BY OVERRIDES")
		for entry in excluded:
			_line("  " + entry)
		_line("")
	if !uncategorized.empty():
		_line("UNCATEGORIZED (no folder route - add the folder to FOLDER_MAP)")
		var slots = uncategorized.keys()
		slots.sort()
		for slot_name in slots:
			_line("  %-28s %s" % [slot_name, _join(uncategorized[slot_name], ", ")])
		_problem("%d slot(s) hold uncategorized attachments" % uncategorized.size())
		_line("")

	var colours = _build_colour_channels(groups)
	return {
		"parts": parts,
		"groups": groups,
		"group_order": group_order,
		"uncategorized": uncategorized,
		"presets": _validate_presets(parts),
		"color_channels": colours.channels,
		"slot_colors": colours.slots,
	}


# Expands each channel's groups into the slots it paints.  Deriving the slots
# means a new part that introduces a new slot is coloured without touching the
# overrides; the cost is that two channels can reach the same slot, which is
# resolved by declaration order and reported.
func _build_colour_channels(groups):
	var channels = {}
	var slot_colors = {}
	var overlaps = []
	var every_slot = {}
	for group_id in groups.keys():
		for slot_name in groups[group_id].slots:
			every_slot[slot_name] = true
	for channel_id in _overrides.COLOR_CHANNELS.keys():
		var definition = _overrides.COLOR_CHANNELS[channel_id]
		var slots = {}
		# A channel may name slots outright as well as inherit them from groups.
		# Deriving from groups is right until one part carries two things that want
		# separate colours - the body carries the nipples - and no group divides
		# them.  Named slots are claimed first, so such a channel is declared above
		# the one it is carving the slots out of.
		for slot_name in definition.get("slots", []):
			if !every_slot.has(slot_name):
				# the two dolls do not carry the same slots, and the overrides are shared
				_line("  %s: this doll has no `%s`" % [channel_id, slot_name])
				continue
			if slot_colors.has(slot_name):
				overlaps.append("%s stays on `%s`, also claimed by `%s`" % [slot_name, slot_colors[slot_name], channel_id])
				continue
			slot_colors[slot_name] = channel_id
			slots[slot_name] = true
		for group_id in definition.groups:
			if !groups.has(group_id):
				_problem("COLOR_CHANNELS[%s]: group `%s` does not exist" % [channel_id, group_id])
				continue
			for slot_name in groups[group_id].slots:
				if slot_colors.has(slot_name):
					if slot_colors[slot_name] != channel_id:
						overlaps.append("%s stays on `%s`, also claimed by `%s`" % [slot_name, slot_colors[slot_name], channel_id])
					continue
				slot_colors[slot_name] = channel_id
				slots[slot_name] = true
		if !(str(definition.anchor) in groups.keys()):
			_problem("COLOR_CHANNELS[%s]: anchor group `%s` does not exist" % [channel_id, str(definition.anchor)])
		var slot_names = slots.keys()
		slot_names.sort()
		var gear = bool(definition.get("gear", false))
		channels[channel_id] = {
			"anchor": definition.anchor,
			"slots": slot_names,
			"two_tone": bool(definition.get("two_tone", false)),
			# Gear is painted entirely in the hue code, so its zones start on real
			# colours; everywhere else a zone starts unset and leaves the art alone.
			"gear": gear,
			# Only channels whose art is genuinely coded offer zone colours; gear
			# always is.  Elsewhere a second colour would just repaint the art in
			# the wrong place.
			"zones": gear or bool(definition.get("zones", false)),
			# Whether fur and scale patterns paint over this channel's meshes.
			"coverage": bool(definition.get("coverage", false)),
			# Starting colours for this channel's zones.  Empty means the channel
			# falls back to ZONE_DEFAULTS when it is gear, or to white otherwise.
			"zone_defaults": definition.get("zone_defaults", []),
		}
	_line("COLOUR CHANNELS")
	for channel_id in channels.keys():
		var mode = "plain"
		if channels[channel_id].gear:
			mode = "gear, zones"
		elif channels[channel_id].zones:
			mode = "zones"
		elif channels[channel_id].two_tone:
			mode = "two tone"
		_line("  %-12s anchor %-14s %2d slots  %s" % [channel_id, channels[channel_id].anchor, channels[channel_id].slots.size(), mode])
	if !overlaps.empty():
		_line("  slots claimed by more than one channel (first declaration wins):")
		for entry in overlaps:
			_line("    " + entry)
	var uncoloured = []
	for group_id in groups.keys():
		for slot_name in groups[group_id].slots:
			if !slot_colors.has(slot_name):
				uncoloured.append(slot_name)
	uncoloured.sort()
	if !uncoloured.empty():
		_line("  slots with no channel: %s" % _join(uncoloured, ", "))
	_line("")
	return {"channels": channels, "slots": slot_colors}


# The order meshes are actually drawn in: the export's slot order with the
# hand-authored corrections applied.  Keeping them separate means a re-export
# brings its own order back and only the listed fixes are re-applied.
func _draw_order(slot_order):
	var order = slot_order.duplicate()
	_line("DRAW ORDER")
	if _overrides.DRAW_ORDER_FIXES.empty():
		_line("  export order used as is")
		_line("")
		return order
	for fix in _overrides.DRAW_ORDER_FIXES:
		var slot_name = str(fix.slot)
		var relation = "before" if fix.has("before") else "after"
		var anchor = str(fix.get(relation, ""))
		var from = order.find(slot_name)
		var to = order.find(anchor)
		if from == -1 or to == -1:
			_problem("DRAW_ORDER_FIXES: `%s` or `%s` is not in the export" % [slot_name, anchor])
			continue
		var correct = from < to if relation == "before" else from > to
		if correct:
			_line("  %s already draws %s %s" % [slot_name, "under" if relation == "before" else "over", anchor])
			continue
		order.remove(from)
		to = order.find(anchor)
		order.insert(to if relation == "before" else to + 1, slot_name)
		_line("  %s moved %s %s" % [slot_name, "under" if relation == "before" else "over", anchor])
	_line("")
	return order


# Whether an override drops this attachment: by full name or by bare name, on
# its own or paired with the slot it appears in.
func _is_excluded(record):
	for entry in _overrides.EXCLUDE:
		var name = str(entry)
		if name == record.name or name == record.base:
			return true
		if name == record.slot + "/" + record.name or name == record.slot + "/" + record.base:
			return true
	return false


func _route(record):
	if _overrides.SLOT_ROUTES.has(record.slot):
		return str(_overrides.SLOT_ROUTES[record.slot])
	var folder_entry = _overrides.FOLDER_MAP.get(record.folder, {})
	return str(folder_entry.get("group", ""))


func _build_option_parts(option_records, parts):
	var group_ids = option_records.keys()
	group_ids.sort()
	for group_id in group_ids:
		var records = option_records[group_id]
		records.sort_custom(self, "_sort_records")
		for record in records:
			var part_id = _sanitize(record.base)
			if parts.has(part_id):
				var suffix = 2
				while parts.has("%s_%d" % [part_id, suffix]):
					suffix += 1
				_line("  note: part id `%s` taken, `%s` became `%s_%d`" % [part_id, record.name, part_id, suffix])
				part_id = "%s_%d" % [part_id, suffix]
			var folder_entry = _overrides.FOLDER_MAP.get(record.folder, {})
			var slots = {record.slot: record.name}
			var companions = _companion_slots(group_id, record)
			for slot_name in companions.keys():
				slots[slot_name] = companions[slot_name]
			var paired = _paired_slots(group_id, record)
			for slot_name in paired.keys():
				slots[slot_name] = paired[slot_name]
			parts[part_id] = _part_entry(part_id, group_id, str(_overrides.DISPLAY.get(part_id, _title(record.base))), [record.folder], folder_entry.get("tags", []), slots, {})


func _companion_slots(group_id, record):
	var result = {}
	for rule in _overrides.COMPANIONS.get(group_id, []):
		if rule.has("folder") and rule.folder != record.folder:
			continue
		if rule.has("base_prefix") and !record.base.begins_with(rule.base_prefix):
			continue
		for slot_name in rule.slots.keys():
			result[slot_name] = rule.slots[slot_name]
		break
	return result


# Slots that follow the part's own style instead of being chosen: the fringe that
# belongs to a hairstyle.  Both names are reduced by the rule's `strip` pattern,
# so the export spelling either of them differently does not break the pairing.
func _paired_slots(group_id, record):
	var result = {}
	for rule in _overrides.PAIRED_SLOTS.get(group_id, []):
		var wanted = _style_key(record.base, rule.strip)
		if wanted.empty():
			continue
		for other in _style_index(str(rule.slot), str(rule.strip)).keys():
			if other == wanted:
				result[rule.slot] = _style_index(str(rule.slot), str(rule.strip))[other]
				break
	return result


# {style key: canonical attachment} for one slot, built once per slot and rule.
func _style_index(slot_name, strip):
	var cache_key = slot_name + "|" + strip
	if _style_cache.has(cache_key):
		return _style_cache[cache_key]
	var index = {}
	for record in _all_records:
		if record.slot != slot_name:
			continue
		var key = _style_key(record.base, strip)
		if !key.empty() and !index.has(key):
			index[key] = record.name
	_style_cache[cache_key] = index
	return index


func _style_key(base, strip):
	var expression = RegEx.new()
	if expression.compile(strip) != OK:
		return base
	var result = expression.sub(base, "", true)
	return result.strip_edges()


func _build_set_parts(set_records, parts):
	var part_ids = set_records.keys()
	part_ids.sort()
	for part_id in part_ids:
		var source = set_records[part_id]
		var splits = _overrides.PART_SPLITS.get(part_id, {})
		if splits.empty():
			parts[part_id] = _make_set_part(part_id, source, source.slots)
			continue
		var listed = {}
		for sub_id in splits.keys():
			for entry in splits[sub_id]:
				listed[entry] = true
		var base_sub = ""
		for sub_id in splits.keys():
			var sub_slots = {}
			for slot_name in source.slots.keys():
				var own = []
				var shared = []
				for record in source.slots[slot_name]:
					if record.name in splits[sub_id] or record.base in splits[sub_id]:
						own.append(record)
					elif !listed.has(record.name) and !listed.has(record.base):
						shared.append(record)
				if !own.empty():
					sub_slots[slot_name] = own + shared
				elif !shared.empty():
					sub_slots[slot_name] = shared
			if base_sub.empty():
				base_sub = sub_id
			else:
				# A variant only replaces what it lists; everything else it shares
				# with the base variant, so partial variants stay complete dolls.
				for slot_name in parts[base_sub].slots.keys():
					if !sub_slots.has(slot_name):
						sub_slots[slot_name] = parts[base_sub].slots[slot_name]
			if base_sub == sub_id:
				parts[sub_id] = _make_set_part(sub_id, source, sub_slots)
			else:
				parts[sub_id] = _make_set_part(sub_id, source, sub_slots, true)


# The pieces of every set that can be worn on their own, as parts of their own.
#
# Each carries the same slots the set does, cut down to the ones its rule names,
# and nothing else: no folders, no bindings.  A set with nothing in a cut - a
# jacket has no legs - gets no piece for it, which is what stops the groups
# filling up with empty entries.
func _build_set_cuts(parts):
	var cuts = _overrides.get("SET_CUTS", {})
	if cuts.empty():
		return
	var made = {}
	var counted = {}
	var cut_ids = cuts.keys()
	cut_ids.sort()
	for cut_id in cut_ids:
		var rule = cuts[cut_id]
		var wanted = rule.get("slots", [])
		if wanted.empty():
			wanted = _overrides.COLOR_CHANNELS.get(str(rule.get("source", "")), {}).get("slots", [])
		if wanted.empty():
			_problem("SET_CUTS[%s]: names no slots and no channel that has any" % cut_id)
			continue
		counted[cut_id] = 0
		var part_ids = parts.keys()
		part_ids.sort()
		for part_id in part_ids:
			var part = parts[part_id]
			if str(part.get("group", "")) != "outfit":
				continue
			var slots = {}
			for slot_name in wanted:
				if part.slots.has(slot_name):
					slots[slot_name] = part.slots[slot_name]
			if slots.empty():
				continue
			var piece = {
				"display": str(part.get("display", part_id)) + str(rule.get("display", "")),
				"folders": part.get("folders", []),
				"group": cut_id,
				"slots": slots,
			}
			if part.has("tags"):
				piece["tags"] = part.tags
			made[part_id + str(rule.suffix)] = piece
			counted[cut_id] += 1
	for part_id in made.keys():
		parts[part_id] = made[part_id]
	_line("SET CUTS")
	for cut_id in cut_ids:
		if counted.has(cut_id):
			_line("  %-14s %d set(s)" % [cut_id, counted[cut_id]])
	_line("")


func _make_set_part(part_id, source, slot_records, inherited = false):
	var slots = {}
	var extra_options = {}
	var explicit = _overrides.PART_SLOTS.get(part_id, {})
	for slot_name in slot_records.keys():
		var value = slot_records[slot_name]
		if typeof(value) != TYPE_ARRAY:
			slots[slot_name] = value
			continue
		var records = value
		# A hand-written assignment wins over name parsing: some art is named
		# after neither its size nor its owner, and some parts borrow a mesh from
		# another folder entirely.
		if explicit.has(slot_name):
			var assignment = _explicit_slot(part_id, slot_name, explicit[slot_name], records)
			if !assignment.empty():
				slots[slot_name] = assignment.value
				if !assignment.leftovers.empty():
					extra_options[slot_name] = assignment.leftovers
				continue
		if records.size() == 1:
			slots[slot_name] = records[0].name
			continue
		var axis = str(_overrides.SLOT_AXES.get(slot_name, ""))
		if axis.empty():
			var names = []
			for record in records:
				names.append(record.name)
			names.sort()
			extra_options[slot_name] = names
			_problem("%s/%s: %d attachments and no axis - left as extra_options" % [part_id, slot_name, records.size()])
			continue
		var options = {}
		var sorted_records = records.duplicate()
		sorted_records.sort_custom(self, "_sort_records")
		for record in sorted_records:
			var axis_value = _axis_value(axis, slot_name, record)
			if axis_value.empty():
				_problem("%s/%s: cannot classify `%s` on axis %s" % [part_id, slot_name, record.base, axis])
				continue
			if !(axis_value in _overrides.AXES[axis].values):
				_problem("%s/%s: `%s` produced unknown %s value `%s`" % [part_id, slot_name, record.base, axis, axis_value])
				continue
			if options.has(axis_value):
				_problem("%s/%s: `%s` and `%s` both claim %s=%s" % [part_id, slot_name, options[axis_value], record.name, axis, axis_value])
				continue
			options[axis_value] = record.name
		if options.empty():
			continue
		slots[slot_name] = {"axis": axis, "options": options}
	# A part may borrow a mesh from a folder it does not own, so an explicit slot
	# can name something the part has no records for at all.
	for slot_name in explicit.keys():
		if slots.has(slot_name):
			continue
		var borrowed = _explicit_slot(part_id, slot_name, explicit[slot_name], [])
		if !borrowed.empty():
			slots[slot_name] = borrowed.value
	var folders = source.folders.keys()
	folders.sort()
	var folder_entry = _overrides.FOLDER_MAP.get(folders[0], {}) if !folders.empty() else {}
	return _part_entry(part_id, source.group, str(_overrides.DISPLAY.get(part_id, _title(part_id))), folders, folder_entry.get("tags", []), slots, extra_options)


# A part carries only what it actually says.  Written out in full, every one of
# them repeated an empty `tags`, an empty `extra_options` and a `display` equal to
# its own id - 640 lines of nothing per doll, which buried the real differences in
# a re-export diff.  Every reader already treats these as optional
# (`get("tags", [])`, and `display` falls back to the part id).
func _part_entry(part_id, group_id, display, folders, tags, slots, extra_options):
	var result = {
		"group": group_id,
		"folders": folders,
		"slots": slots,
	}
	# Slots this part takes the place of.  A centaur's barrel replaces the legs
	# rather than covering them, and nothing else can express that: the legs
	# belong to the body part, which is chosen in another group.
	var hides = _overrides.PART_HIDES.get(part_id, [])
	if !hides.empty():
		result["hides"] = hides
	if display != part_id:
		result["display"] = display
	if !tags.empty():
		result["tags"] = tags
	if !extra_options.empty():
		result["extra_options"] = extra_options
	return result


# Resolves a PART_SLOTS entry into either a plain attachment name or an axis map.
# Returns {} when nothing resolved, so the caller can fall back to name parsing.
func _explicit_slot(part_id, slot_name, spec, records):
	var used = {}
	var value = null
	if typeof(spec) == TYPE_DICTIONARY:
		var axis = str(_overrides.SLOT_AXES.get(slot_name, ""))
		if axis.empty():
			_problem("PART_SLOTS[%s/%s]: an axis map needs `%s` in SLOT_AXES" % [part_id, slot_name, slot_name])
			return {}
		var options = {}
		var axis_values = spec.keys()
		axis_values.sort()
		for axis_value in axis_values:
			if !(axis_value in _overrides.AXES[axis].values):
				_problem("PART_SLOTS[%s/%s]: `%s` is not a %s value" % [part_id, slot_name, axis_value, axis])
				continue
			var name = _resolve_name(slot_name, str(spec[axis_value]))
			if name.empty():
				_problem("PART_SLOTS[%s/%s]: `%s` is not in the export" % [part_id, slot_name, str(spec[axis_value])])
				continue
			options[axis_value] = name
			used[name] = true
		if options.empty():
			return {}
		value = {"axis": axis, "options": options}
	else:
		var name = _resolve_name(slot_name, str(spec))
		if name.empty():
			_problem("PART_SLOTS[%s/%s]: `%s` is not in the export" % [part_id, slot_name, str(spec)])
			return {}
		value = name
		used[name] = true
	var leftovers = []
	for record in records:
		if !used.has(record.name):
			leftovers.append(record.name)
	leftovers.sort()
	return {"value": value, "leftovers": leftovers}


func _resolve_name(slot_name, key):
	var by_name = canonical_by_name.get(slot_name, {})
	if by_name.has(key):
		return str(by_name[key])
	return str(canonical_by_base.get(slot_name, {}).get(key, ""))


func _axis_value(axis, slot_name, record):
	var overrides = _overrides.AXIS_OVERRIDES.get(slot_name, {})
	if overrides.has(record.base):
		return str(overrides[record.base])
	if overrides.has(record.name):
		return str(overrides[record.name])
	var definition = _overrides.AXES[axis]
	if definition.get("parse", "tokens") == "digit":
		for i in range(record.base.length()):
			var character = record.base[i]
			if character >= "0" and character <= "9":
				return character
		return str(definition.get("fallback", ""))
	var tokens = definition.get("tokens", {})
	var lowered = record.base.to_lower().replace(" ", "_").replace("-", "_")
	for chunk in lowered.split("_", false):
		if tokens.has(chunk):
			return str(tokens[chunk])
		# Some art carries a copy index on the size itself (`big1`, `mid1`).
		var trimmed = _strip_trailing_digits(chunk)
		if trimmed != chunk and tokens.has(trimmed):
			return str(tokens[trimmed])
	return str(definition.get("fallback", ""))


func _strip_trailing_digits(chunk):
	var cut = chunk.length()
	while cut > 0:
		var character = chunk[cut - 1]
		if character < "0" or character > "9":
			break
		cut -= 1
	return chunk.substr(0, cut)


func _validate_presets(parts):
	var result = {}
	var preset_ids = _overrides.PRESETS.keys()
	preset_ids.sort()
	for preset_id in preset_ids:
		var selections = {}
		for group_id in _overrides.PRESETS[preset_id].keys():
			var part_id = str(_overrides.PRESETS[preset_id][group_id])
			if !parts.has(part_id):
				_problem("preset %s references missing part `%s`" % [preset_id, part_id])
				continue
			if parts[part_id].group != group_id:
				_problem("preset %s puts part `%s` in group %s, it belongs to %s" % [preset_id, part_id, group_id, parts[part_id].group])
				continue
			selections[group_id] = part_id
		if !selections.empty():
			result[preset_id] = selections
	return result


# ------------------------------------------------------------ validation ---

# Defects in the Spine project itself.  None of these are fixable here - they are
# reported so the export can be corrected at the source, and so a re-export can
# be checked at a glance.
func _check_art_health(records, atlas_regions):
	var by_slot = {}
	for record in records:
		if !by_slot.has(record.slot):
			by_slot[record.slot] = []
		by_slot[record.slot].append(record)

	var unrigged = []
	var unrigged_slots = []
	var mirrored = []
	var degenerate = []
	var slots = by_slot.keys()
	slots.sort()
	for slot_name in slots:
		var rigged = 0
		for record in by_slot[slot_name]:
			if record.weighted:
				rigged += 1
		for record in by_slot[slot_name]:
			if !record.weighted and rigged > 0:
				# The rest of the slot follows the skeleton and this one does not,
				# so it stays at the rig's origin instead of on the body.
				unrigged.append("%s/%s" % [slot_name, record.name])
			if record.triangles == 0 or record.hull == 0:
				degenerate.append("%s/%s (%d triangles, hull %d)" % [slot_name, record.name, record.triangles, record.hull])
			var side = _side_of(record.name)
			if side.empty():
				side = _side_of(slot_name)
			if side.empty() or record.bones.empty():
				continue
			var left = 0
			var right = 0
			for bone_name in record.bones:
				if bone_name.ends_with("_l"):
					left += 1
				elif bone_name.ends_with("_r"):
					right += 1
			if side == "l" and right > 0 and left == 0:
				mirrored.append("%s/%s is bound to %s" % [slot_name, record.name, _join(record.bones, ", ")])
			elif side == "r" and left > 0 and right == 0:
				mirrored.append("%s/%s is bound to %s" % [slot_name, record.name, _join(record.bones, ", ")])
		if rigged == 0 and by_slot[slot_name].size() > 0:
			unrigged_slots.append("%s (%d meshes)" % [slot_name, by_slot[slot_name].size()])

	var used = {}
	for record in records:
		used[record.path] = true
	var unused = []
	for region in atlas_regions.keys():
		if !used.has(region):
			unused.append(region)
	unused.sort()

	_line("ART HEALTH  (defects in the Spine project, not fixable here)")
	_report_health("meshes left unrigged while the rest of their slot is rigged - these sit at the rig origin instead of on the body", unrigged)
	_report_health("slots where nothing is rigged at all", unrigged_slots)
	_report_health("meshes named for one side but weighted to the other", mirrored)
	_report_health("meshes with no geometry", degenerate)
	_report_health("art in the atlas that no attachment uses", unused)
	_line("")


func _report_health(title, entries):
	if entries.empty():
		return
	_line("  %s:" % title)
	for entry in entries:
		_line("    " + entry)


func _side_of(name):
	var lowered = name.to_lower()
	if lowered.ends_with("_l") or lowered.find("_left") >= 0 or lowered.find("arml") >= 0 or lowered.find("legl") >= 0 or lowered.find("handl") >= 0 or lowered.find("shoulderl") >= 0:
		return "l"
	if lowered.ends_with("_r") or lowered.find("_right") >= 0 or lowered.find("armr") >= 0 or lowered.find("legr") >= 0 or lowered.find("handr") >= 0 or lowered.find("shoulderr") >= 0:
		return "r"
	return ""


# Which hue bands each part's art actually uses.  Measured rather than declared:
# the bands are an art convention, and only the picture knows whether a given
# wing is painted in one of them.  The UI offers exactly the colours a part can
# use, instead of four pickers on every row.
func _scan_zones(parts, atlas_regions, atlas_path):
	var pages = {}
	# Sampling every pixel of three 4095x4094 pages in GDScript would take
	# minutes; a coarse grid answers the same question.
	var step = 4
	var zone_hues = _overrides.ZONE_HUES
	var distances = []
	for entry in _overrides.ZONE_DISTANCE:
		distances.append(float(entry) / 360.0)
	var by_path = {}
	var scanned = 0
	var part_ids = parts.keys()
	part_ids.sort()
	for part_id in part_ids:
		var zones = {}
		for slot_name in parts[part_id].slots.keys():
			for path in _attachment_paths(parts[part_id].slots[slot_name], slot_name):
				if !by_path.has(path):
					by_path[path] = _scan_region(path, atlas_regions, pages, atlas_path, step, zone_hues, distances)
					scanned += 1
				for index in by_path[path]:
					zones[index] = true
		if !zones.empty():
			var list = zones.keys()
			list.sort()
			parts[part_id]["zones"] = list
	_line("COLOUR ZONES")
	_line("  scanned %d art regions at 1/%d resolution" % [scanned, step])
	var counts = {}
	for part_id in part_ids:
		var count = parts[part_id].get("zones", []).size()
		counts[count] = int(counts.get(count, 0)) + 1
	var keys = counts.keys()
	keys.sort()
	for count in keys:
		_line("  %d part(s) use %d zone(s)" % [counts[count], count])
	_line("")


func _attachment_paths(value, _slot_name):
	var names = []
	if typeof(value) == TYPE_DICTIONARY:
		for axis_value in value.get("options", {}).keys():
			names.append(value.options[axis_value])
	else:
		names.append(value)
	var result = []
	for name in names:
		if _attachment_path_by_name.has(name):
			result.append(_attachment_path_by_name[name])
	return result


func _scan_region(path, atlas_regions, pages, atlas_path, step, zone_hues, distances):
	var result = []
	if !atlas_regions.has(path):
		return result
	var page_name = str(atlas_regions[path].page)
	var bounds = atlas_regions[path].bounds
	# A region the packer turned on its side keeps its bounds in the art's own
	# orientation, so the box to read off the page is the other way round.  Read
	# as written, the box runs off the end of the art and into whatever is packed
	# next to it: the pet suit glove picked up 8% of its neighbour that way, which
	# is above ZONE_COVERAGE_MIN, and the part was offered a second colour for a
	# band its own art does not contain.
	if bool(atlas_regions[path].get("rotate", false)):
		bounds = Rect2(bounds.position, Vector2(bounds.size.y, bounds.size.x))
	if bounds.size.x < 1 or bounds.size.y < 1:
		return result
	if !pages.has(page_name):
		var image = Image.new()
		if image.load(atlas_path.get_base_dir() + "/" + page_name) != OK:
			pages[page_name] = null
		else:
			pages[page_name] = image
	var page = pages[page_name]
	if page == null:
		return result
	page.lock()
	var counts = [0, 0, 0]
	var opaque = 0
	# The three pages are not the same size, and a region's declared bounds can
	# run a pixel past the smaller ones.
	var limit_x = min(int(bounds.end.x), page.get_width())
	var limit_y = min(int(bounds.end.y), page.get_height())
	var y = int(bounds.position.y)
	while y < limit_y:
		var x = int(bounds.position.x)
		while x < limit_x:
			var pixel = page.get_pixel(x, y)
			if pixel.a > 0.75:
				opaque += 1
				if pixel.s > 0.15 and pixel.v > 0.08:
					for i in range(zone_hues.size()):
						var gap = abs(pixel.h - zone_hues[i] / 360.0)
						gap = min(gap, 1.0 - gap)
						if gap < distances[i]:
							counts[i] += 1
							break
			x += step
		y += step
	page.unlock()
	if opaque <= 0:
		return result
	for i in range(counts.size()):
		if 100.0 * counts[i] / opaque >= _overrides.ZONE_COVERAGE_MIN:
			result.append(i)
	return result


func _check_atlas(records, atlas_regions):
	var missing = []
	var used = {}
	for record in records:
		used[record.path] = true
		if !atlas_regions.has(record.path):
			missing.append(record.slot + "/" + record.name + " -> " + record.path)
	_line("ATLAS")
	_line("  regions %d, referenced %d" % [atlas_regions.size(), used.size()])
	if missing.empty():
		_line("  every referenced region resolves")
	else:
		_line("  MISSING regions:")
		for entry in missing:
			_line("    " + entry)
		_problem("%d attachment(s) reference a missing atlas region" % missing.size())
	_line("")


func _check_overrides(canonical, built):
	var stale = []
	var known_names = {}
	for record in canonical.records:
		if !known_names.has(record.slot):
			known_names[record.slot] = {}
		known_names[record.slot][record.name] = record.base
	var folders = {}
	for record in canonical.records:
		folders[record.folder] = true

	for folder in _overrides.FOLDER_MAP.keys():
		if !folders.has(folder):
			stale.append("FOLDER_MAP: folder `%s` is not in the export" % folder)
	for slot_name in _overrides.SLOT_ROUTES.keys():
		if !known_names.has(slot_name):
			stale.append("SLOT_ROUTES: slot `%s` is not in the export" % slot_name)
	for slot_name in _overrides.SLOT_AXES.keys():
		if !known_names.has(slot_name):
			stale.append("SLOT_AXES: slot `%s` is not in the export" % slot_name)
	for slot_name in _overrides.FIXED_SLOTS.keys():
		var fixed_name = str(_overrides.FIXED_SLOTS[slot_name])
		if !known_names.has(slot_name) or !known_names[slot_name].has(fixed_name):
			stale.append("FIXED_SLOTS: `%s/%s` is not in the export" % [slot_name, fixed_name])
	for group_id in _overrides.PAIRED_SLOTS.keys():
		if !built.groups.has(group_id):
			stale.append("PAIRED_SLOTS: group `%s` does not exist" % group_id)
			continue
		for rule in _overrides.PAIRED_SLOTS[group_id]:
			if !(str(rule.slot) in _overrides.CONSUMED_SLOTS):
				stale.append("PAIRED_SLOTS[%s]: slot `%s` is not consumed, so it also makes parts of its own" % [group_id, str(rule.slot)])
	for group_id in _overrides.COMPANIONS.keys():
		for rule in _overrides.COMPANIONS[group_id]:
			for slot_name in rule.slots.keys():
				var companion = str(rule.slots[slot_name])
				if !known_names.has(slot_name) or !known_names[slot_name].has(companion):
					stale.append("COMPANIONS[%s]: `%s/%s` is not in the export" % [group_id, slot_name, companion])
	for slot_name in _overrides.AXIS_OVERRIDES.keys():
		for key in _overrides.AXIS_OVERRIDES[slot_name].keys():
			var found = false
			for name in known_names.get(slot_name, {}).keys():
				if name == key or known_names[slot_name][name] == key:
					found = true
					break
			if !found:
				stale.append("AXIS_OVERRIDES[%s]: `%s` is not in the export" % [slot_name, key])
	for name in _overrides.EXCLUDE:
		# The same two spellings the exclusion itself accepts.
		var wanted = str(name)
		var slot_wanted = ""
		if wanted.find("/") >= 0 and known_names.has(wanted.split("/", false, 1)[0]):
			slot_wanted = wanted.split("/", false, 1)[0]
			wanted = wanted.split("/", false, 1)[1]
		var found = false
		for slot_name in known_names.keys():
			if slot_wanted != "" and slot_name != slot_wanted:
				continue
			for known in known_names[slot_name].keys():
				if known == wanted or str(known_names[slot_name][known]) == wanted:
					found = true
					break
			if found:
				break
		if !found:
			stale.append("EXCLUDE: `%s` is not in the export" % name)
	for part_id in _overrides.PART_SPLITS.keys():
		for sub_id in _overrides.PART_SPLITS[part_id].keys():
			for entry in _overrides.PART_SPLITS[part_id][sub_id]:
				var found = false
				for slot_name in known_names.keys():
					if known_names[slot_name].has(entry):
						found = true
						break
					for name in known_names[slot_name].keys():
						if known_names[slot_name][name] == entry:
							found = true
							break
					if found:
						break
				if !found:
					stale.append("PART_SPLITS[%s/%s]: `%s` is not in the export" % [part_id, sub_id, entry])
	for part_id in _overrides.PART_SLOTS.keys():
		if !built.parts.has(part_id):
			stale.append("PART_SLOTS: part `%s` does not exist" % part_id)
			continue
		for slot_name in _overrides.PART_SLOTS[part_id].keys():
			var spec = _overrides.PART_SLOTS[part_id][slot_name]
			var wanted = [spec] if typeof(spec) != TYPE_DICTIONARY else spec.values()
			for entry in wanted:
				if _resolve_name(slot_name, str(entry)).empty():
					stale.append("PART_SLOTS[%s/%s]: `%s` is not in the export" % [part_id, slot_name, str(entry)])
	for part_id in _overrides.DISPLAY.keys():
		if !built.parts.has(part_id):
			stale.append("DISPLAY: part `%s` does not exist" % part_id)

	_line("OVERRIDES")
	if stale.empty():
		_line("  every hand-authored reference still resolves")
	else:
		for entry in stale:
			_line("  STALE " + entry)
		_problem("%d stale override reference(s)" % stale.size())
	_line("")


func _report_contract(skeleton, slot_order, contract_path, update_contract):
	_line("SKELETON CONTRACT")
	var existing = _load_constants(contract_path)
	if existing.empty():
		_line("  no contract yet - writing %s" % _contract_id)
		_line("")
		return
	if update_contract:
		_line("  UPDATE_CONTRACT is on - rewriting %s" % str(existing.get("CONTRACT_ID", _contract_id)))
		_line("")
		return
	var bones = []
	for bone in skeleton.get("bones", []):
		bones.append(str(bone.get("name", "")))
	var drift = _name_drift(existing.get("BONES", []), bones, "bone")
	drift += _name_drift(existing.get("SLOTS", []), slot_order, "slot")
	if drift.empty():
		_line("  %s matches the export" % str(existing.get("CONTRACT_ID", _contract_id)))
	else:
		for entry in drift:
			_line("  DRIFT " + entry)
		_problem("the export no longer matches contract %s - poses and modifiers keyed to it may break" % str(existing.get("CONTRACT_ID", _contract_id)))
	_line("")


func _name_drift(old_names, new_names, label):
	var old_set = {}
	for name in old_names:
		old_set[name] = true
	var new_set = {}
	for name in new_names:
		new_set[name] = true
	var drift = []
	for name in new_names:
		if !old_set.has(name):
			drift.append("%s added: %s" % [label, name])
	for name in old_names:
		if !new_set.has(name):
			drift.append("%s removed: %s" % [label, name])
	return drift


func _report_diff(previous, catalogue):
	_line("DIFF AGAINST PREVIOUS CATALOGUE")
	if previous.empty():
		_line("  no previous catalogue")
		_line("")
		return
	var old_parts = previous.get("PARTS", {})
	var new_parts = catalogue.PARTS
	var added = []
	var removed = []
	var changed = []
	for part_id in new_parts.keys():
		if !old_parts.has(part_id):
			added.append(part_id)
		elif str(old_parts[part_id].get("slots", {})) != str(new_parts[part_id].slots):
			changed.append(part_id)
	for part_id in old_parts.keys():
		if !new_parts.has(part_id):
			removed.append(part_id)
	added.sort()
	removed.sort()
	changed.sort()
	if added.empty() and removed.empty() and changed.empty():
		_line("  identical")
	else:
		if !added.empty():
			_line("  added   %s" % _join(added, ", "))
		if !removed.empty():
			_line("  removed %s" % _join(removed, ", "))
		if !changed.empty():
			_line("  changed %s" % _join(changed, ", "))
	_line("")


# --------------------------------------------------------------- emitting ---

func _public_axes():
	var result = {}
	for axis in _overrides.AXES.keys():
		var definition = _overrides.AXES[axis]
		result[axis] = {
			"values": definition.values,
			"default": definition.default,
			"label": definition.label,
		}
	return result


func _emit(catalogue):
	var text = "extends Reference\n\n"
	text += "# GENERATED by doll2_catalogue_build.gd - DO NOT EDIT.\n"
	text += "# Semantics for the Doll 2 Spine export: groups, parts and axis values.\n"
	text += "# Change doll2_overrides.gd and rebuild instead of editing this file.\n"
	text += "# Mesh, vertex, UV and animation data stay in the Spine JSON.\n\n"
	var keys = ["SCHEMA_VERSION", "SOURCE", "SLOT_ORDER", "DRAW_ORDER", "DRAW_ORDER_FIXES", "GROUP_ORDER", "AXES", "FIXED_SLOTS", "COLOR_CHANNELS", "SLOT_COLORS", "ZONE_HUES", "ZONE_DISTANCE", "ZONE_DEFAULTS", "GROUPS", "PARTS", "PRESETS", "ALIASES", "UNCATEGORIZED"]
	for key in keys:
		text += "const %s = %s\n\n" % [key, _literal(catalogue[key], 0)]
	return text


func _literal(value, indent):
	match typeof(value):
		TYPE_DICTIONARY:
			if value.empty():
				return "{}"
			var keys = value.keys()
			keys.sort()
			var pad = _tabs(indent + 1)
			var parts = []
			for key in keys:
				parts.append("%s%s: %s," % [pad, _quote(str(key)), _literal(value[key], indent + 1)])
			return "{\n" + _join(parts, "\n") + "\n" + _tabs(indent) + "}"
		TYPE_ARRAY:
			if value.empty():
				return "[]"
			var items = []
			for entry in value:
				items.append(_literal(entry, indent + 1))
			var inline = "[" + _join(items, ", ") + "]"
			if inline.length() + indent * 4 <= 96 and inline.find("\n") == -1:
				return inline
			var pad = _tabs(indent + 1)
			var lines = []
			for item in items:
				lines.append(pad + item + ",")
			return "[\n" + _join(lines, "\n") + "\n" + _tabs(indent) + "]"
		TYPE_STRING:
			return _quote(value)
		TYPE_COLOR:
			return "Color(%s, %s, %s, %s)" % [value.r, value.g, value.b, value.a]
		TYPE_BOOL:
			return "true" if value else "false"
		TYPE_REAL:
			return str(value)
		_:
			return str(value)


func _quote(value):
	var escaped = value.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\t", "\\t")
	return "\"" + escaped + "\""


func _tabs(count):
	var result = ""
	for _i in range(count):
		result += "\t"
	return result


func _emit_contract(skeleton, slot_order, contract_path):
	var existing = _load_constants(contract_path)
	var handles = existing.get("HANDLES", SEED_HANDLES)
	var bones = []
	for bone in skeleton.get("bones", []):
		bones.append(str(bone.get("name", "")))
	var ik = []
	for constraint in skeleton.get("ik", []):
		ik.append({
			"name": str(constraint.get("name", "")),
			"target": str(constraint.get("target", "")),
			"bones": constraint.get("bones", []),
			"bend": -1 if constraint.get("bendPositive", true) == false else 1,
			"order": int(constraint.get("order", 0)),
		})
	var text = "extends Reference\n\n"
	text += "# Skeleton contract for the Doll 2 rig.  BONES, SLOTS and IK are generated\n"
	text += "# from the Spine export; HANDLES are hand-authored and preserved on rebuild.\n"
	text += "#\n"
	text += "# Everything in universal/ is keyed to CONTRACT_ID instead of to one export\n"
	text += "# file, so a second skeleton (the male export) either satisfies this contract\n"
	text += "# or gets its own id, and poses written against it can never silently drift.\n\n"
	text += "const CONTRACT_ID = %s\n\n" % _quote(_contract_id)
	text += "const BONES = %s\n\n" % _literal(bones, 0)
	text += "const SLOTS = %s\n\n" % _literal(slot_order, 0)
	text += "const IK = %s\n\n" % _literal(ik, 0)
	text += "# Friendly drag handles exposed by the preview.  Hands use a synthetic\n"
	text += "# two-bone chain; feet move the Spine foot endpoint and ankle target together.\n"
	text += "const HANDLES = %s\n" % _literal(handles, 0)
	return text


# ------------------------------------------------------------------- io -----

func _read_json(path):
	var file = File.new()
	if file.open(path, File.READ) != OK:
		return {}
	var parsed = JSON.parse(file.get_as_text())
	file.close()
	if parsed.error != OK:
		_problem("JSON parse error: " + parsed.error_string)
		return {}
	return parsed.result


# {region name: {"page": file, "bounds": Rect2, "rotate": bool}}.  Bounds are
# needed to sample a region's pixels when working out which colour zones its art
# uses, and `rotate` because a packed region that was turned on its side is
# stored width and height the other way round - see _scan_region.
func _read_atlas_regions(path):
	var file = File.new()
	if file.open(path, File.READ) != OK:
		return {}
	var regions = {}
	var current_page = ""
	var current_region = ""
	for raw_line in file.get_as_text().split("\n"):
		var line = raw_line.strip_edges()
		if line.empty():
			current_region = ""
			continue
		if line.find(":") == -1:
			if line.ends_with(".png"):
				current_page = line
				current_region = ""
			else:
				current_region = line
				regions[line] = {"page": current_page, "bounds": Rect2(), "rotate": false}
			continue
		var split = line.split(":", false, 1)
		if split.size() != 2 or current_region.empty():
			continue
		var key = split[0].strip_edges()
		if key == "bounds":
			var values = []
			for entry in split[1].split(","):
				values.append(float(entry.strip_edges()))
			if values.size() == 4:
				regions[current_region].bounds = Rect2(values[0], values[1], values[2], values[3])
		elif key == "rotate":
			var value = split[1].strip_edges()
			regions[current_region].rotate = value == "90" or value == "true"
	file.close()
	return regions


func _load_constants(path):
	if !_file_exists(path):
		return {}
	var script = load(path)
	if script == null:
		return {}
	return script.get_script_constant_map()


func _file_exists(path):
	var file = File.new()
	return file.file_exists(path)


func _same_file(path, text):
	if !_file_exists(path):
		return false
	var file = File.new()
	if file.open(path, File.READ) != OK:
		return false
	var existing = file.get_as_text()
	file.close()
	return existing == text


func _write_file(path, text):
	var directory = Directory.new()
	var folder = path.get_base_dir()
	if !directory.dir_exists(folder):
		directory.make_dir_recursive(folder)
	var file = File.new()
	if file.open(path, File.WRITE) != OK:
		return false
	file.store_string(text)
	file.close()
	return true


# ---------------------------------------------------------------- helpers ---

func _sort_records(first, second):
	return first.name < second.name


func _sort_by_order(group_ids, groups):
	var keyed = []
	for group_id in group_ids:
		keyed.append("%04d_%s" % [int(groups[group_id].order), group_id])
	keyed.sort()
	var result = []
	for entry in keyed:
		result.append(entry.substr(entry.find("_") + 1, entry.length()))
	return result


func _sanitize(value):
	var result = ""
	for i in range(value.length()):
		var character = value[i]
		if character == " " or character == "-" or character == "/" or character == ".":
			result += "_"
		else:
			result += character
	while result.find("__") != -1:
		result = result.replace("__", "_")
	return result


func _title(value):
	return _sanitize(value)


func _join(values, separator):
	var result = ""
	for i in range(values.size()):
		if i > 0:
			result += separator
		result += str(values[i])
	return result


func _line(text):
	report_lines.append(text)


func _problem(text):
	problems.append(text)


func _fail(message):
	_problem(message)
	var report = _join(report_lines, "\n") + "\nRESULT: " + message
	return {"ok": false, "written": false, "report": report, "catalogue": {}}
