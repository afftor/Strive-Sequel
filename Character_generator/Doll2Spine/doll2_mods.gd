extends Reference

# Modder-authored body parts, folded into the catalogue at runtime.
#
# A modder cannot author Spine meshes, but almost never needs to: nearly every
# addition is "the cat tail, painted differently" or "the cloth set in my
# colours".  So a mod part borrows from an existing one and overrides only what
# it changes.
#
# A part has three independent aspects, and each can be borrowed on its own:
#
#   placement - which slots it fills and with which meshes, including the whole
#               axis map, so a borrowed outfit keeps every breast size and
#               pregnancy stage without listing any of them; it also carries what
#               the part hangs off, see `binds` below
#   category  - the group it belongs to, which decides its dropdown, its colour
#               channel and what it draws over
#   rig       - the bone tweaks it applies while worn, on top of the height tier
#
# `binds` says what the part needs in order to make sense: a hair ornament needs
# hair, a codpiece needs an outfit, a piercing needs the body part it sits on.
# It names a group ("hair_base" - any hair will do) or one exact part
# ("outfit_plate"), or a list of them, and every one has to be satisfied.  While
# a binding is unmet the part is not offered and not composed, instead of
# rendering something that floats in the air.
#
# The easy path borrows all three at once:
#
#   PARTS = {
#       "mymod_tail_striped": {
#           "like": "tail_cat",
#           "display": "Striped tail",
#           "textures": {"tails": "user://doll2_parts/tail_striped.png"},
#       },
#   }
#
# The precise path names each aspect, or spells it out instead of borrowing:
#
#   "mymod_tail_heavy": {
#       "placement": "tail_wolf",           # borrow slots and meshes
#       "category": "tails",                # or state the group outright
#       "rig": "tail_dragon",               # borrow the bone tweaks
#       "bones": {"spine123": [1.15, 1.0]}, # or state them outright
#       "binds": ["hair_base", "outfit"],   # what it needs to be worn with
#       "slots": {"tails": "tail_dragon2"}, # anything stated wins over borrowed
#   }
#
# `textures` swaps the image while keeping the mesh, its weights and its UVs.
# The image must have the same pixel size as the art the original attachment was
# cut from (the build report lists it), because the mesh's UVs are normalised
# over that canvas.  A wrong size is reported rather than rendered askew.
#
# A part that borrows nothing must state `category` and `slots` itself.
#
# Sources, in load order:
#   1. the game's mod loader, table `doll2_parts` (a mod's [Data] section)
#   2. drop-in scripts in user://doll2_parts/*.gd, for authoring without
#      packaging a full mod - this is also how the preview scene sees them
#
# Nothing here can crash the doll: every problem is collected, the offending
# part is skipped, and the rest still loads.

const DROPIN_DIR = "user://doll2_parts"
const MOD_TABLE = "doll2_parts"
const MAX_INHERIT_DEPTH = 8


# Returns {"parts": {id: definition}, "problems": [text], "sources": [text]}.
static func collect():
	var result = {"parts": {}, "problems": [], "sources": []}
	_collect_from_mod_loader(result)
	_collect_from_dropin(result)
	return result


static func _collect_from_mod_loader(result):
	# Read the autoload lazily: this script is preloaded by the catalogue, and a
	# preloaded chain must not depend on singletons existing at load time.
	var tree = Engine.get_main_loop()
	if tree == null or !tree.has_method("get_root"):
		return
	var root = tree.get_root()
	if root == null or !root.has_node("modding_core"):
		return
	var core = root.get_node("modding_core")
	var tables = core.get("tables")
	if tables == null or !tables.has(MOD_TABLE):
		return
	var table = tables[MOD_TABLE]
	if typeof(table) != TYPE_DICTIONARY:
		result.problems.append("mod table `%s` is not a dictionary" % MOD_TABLE)
		return
	result.sources.append("mod loader table `%s`" % MOD_TABLE)
	_merge_definitions(table, result, "mod table")


static func _collect_from_dropin(result):
	var directory = Directory.new()
	if directory.open(DROPIN_DIR) != OK:
		return
	var names = []
	directory.list_dir_begin(true, true)
	var name = directory.get_next()
	while name != "":
		if name.ends_with(".gd"):
			names.append(name)
		name = directory.get_next()
	directory.list_dir_end()
	names.sort()
	for entry in names:
		var path = DROPIN_DIR + "/" + entry
		var script = load(path)
		if script == null:
			result.problems.append("%s: cannot be loaded" % path)
			continue
		var constants = script.get_script_constant_map()
		if !constants.has("PARTS") or typeof(constants.PARTS) != TYPE_DICTIONARY:
			result.problems.append("%s: no PARTS dictionary" % path)
			continue
		result.sources.append(path)
		_merge_definitions(constants.PARTS, result, entry)


static func _merge_definitions(definitions, result, origin):
	for part_id in definitions.keys():
		if typeof(definitions[part_id]) != TYPE_DICTIONARY:
			result.problems.append("%s: `%s` is not a definition" % [origin, part_id])
			continue
		if result.parts.has(part_id):
			result.problems.append("%s: `%s` was already defined by another mod, the later one wins" % [origin, part_id])
		var definition = definitions[part_id].duplicate(true)
		definition["_origin"] = origin
		result.parts[part_id] = definition


# Turns mod definitions into finished parts against the generated catalogue.
# Returns {"parts": {id: part}, "textures": {id: {slot: path}}, "problems": []}.
static func resolve(base_parts, definitions):
	var result = {"parts": {}, "textures": {}, "problems": []}
	var ids = definitions.keys()
	ids.sort()
	for part_id in ids:
		var resolved = _resolve_one(part_id, base_parts, definitions, result.problems, 0)
		if resolved.empty():
			continue
		var textures = resolved.get("_textures", {})
		resolved.erase("_textures")
		result.parts[part_id] = resolved
		if !textures.empty():
			result.textures[part_id] = textures
	return result


static func _resolve_one(part_id, base_parts, definitions, problems, depth):
	if depth > MAX_INHERIT_DEPTH:
		problems.append("`%s`: borrowing is too deep or loops back on itself" % part_id)
		return {}
	var definition = definitions[part_id]
	var origin = str(definition.get("_origin", "mod"))
	var part = {"folders": [], "tags": [], "extra_options": {}, "slots": {}, "bones": {}, "binds": []}
	var textures = {}

	# Each aspect is borrowed from its own source, and `like` is the shorthand
	# that points all three at the same part.
	var shorthand = str(definition.get("like", ""))
	var placement = _borrowed(part_id, str(definition.get("placement", shorthand)), base_parts, definitions, problems, depth, origin)
	var rig = _borrowed(part_id, str(definition.get("rig", shorthand)), base_parts, definitions, problems, depth, origin)
	if placement == null or rig == null:
		return {}

	if !placement.empty():
		part.slots = placement.get("slots", {}).duplicate(true)
		part.extra_options = placement.get("extra_options", {}).duplicate(true)
		part.folders = placement.get("folders", []).duplicate()
		part.tags = placement.get("tags", []).duplicate()
		part["group"] = placement.get("group", "")
		part.binds = placement.get("binds", []).duplicate()
		textures = placement.get("_textures", {}).duplicate(true)
	if !rig.empty():
		part.bones = rig.get("bones", {}).duplicate(true)

	if definition.has("category"):
		part["group"] = str(definition.category)
	if definition.has("display"):
		part["display"] = str(definition.display)
	if definition.has("tags"):
		part["tags"] = definition.tags
	if definition.has("binds"):
		part.binds = definition.binds if typeof(definition.binds) == TYPE_ARRAY else [definition.binds]
	for slot_name in definition.get("slots", {}).keys():
		part.slots[slot_name] = definition.slots[slot_name]
	for bone_name in definition.get("bones", {}).keys():
		part.bones[bone_name] = _as_vector(definition.bones[bone_name])
	for slot_name in definition.get("textures", {}).keys():
		textures[slot_name] = str(definition.textures[slot_name])

	if !part.has("display"):
		part["display"] = part_id
	part["mod"] = origin
	if str(part.get("group", "")).empty():
		problems.append("%s: `%s` has no category - borrow one with `like`/`placement` or name it with `category`" % [origin, part_id])
		return {}
	if part.slots.empty():
		problems.append("%s: `%s` fills no slots - borrow them with `like`/`placement` or list them in `slots`" % [origin, part_id])
		return {}
	if !textures.empty():
		part["_textures"] = textures
	return part


# Resolves one borrowing source into a finished part.  Returns {} when nothing
# is borrowed and null when the source is named but unusable.
static func _borrowed(part_id, source_id, base_parts, definitions, problems, depth, origin):
	if source_id.empty():
		return {}
	if base_parts.has(source_id):
		return base_parts[source_id]
	if definitions.has(source_id):
		var resolved = _resolve_one(source_id, base_parts, definitions, problems, depth + 1)
		if resolved.empty():
			problems.append("%s: `%s` borrows from `%s`, which failed to load" % [origin, part_id, source_id])
			return null
		return resolved
	problems.append("%s: `%s` borrows from `%s`, which does not exist" % [origin, part_id, source_id])
	return null


# Bone factors may be written as a Vector2 or as a plain [x, y] pair, so the same
# definition works in a .gd file and in a JSON data table.
static func _as_vector(value):
	if typeof(value) == TYPE_VECTOR2:
		return value
	if typeof(value) == TYPE_ARRAY and value.size() >= 2:
		return Vector2(float(value[0]), float(value[1]))
	return Vector2(float(value), float(value))


# Checks that a resolved part only names slots and attachments that exist, and
# that its images load and match the size the mesh expects.  `slot_sizes` is
# {slot: {attachment: Vector2}} taken from the export.
static func validate(parts, textures, slot_names, problems, known_groups = [], known_parts = []):
	for part_id in parts.keys():
		var part = parts[part_id]
		for slot_name in part.slots.keys():
			if !(slot_name in slot_names):
				problems.append("`%s`: slot `%s` is not in the export" % [part_id, slot_name])
		for anchor in part.get("binds", []):
			if anchor == part_id:
				problems.append("`%s`: binds to itself" % part_id)
			elif !(anchor in known_groups) and !(anchor in known_parts) and !parts.has(anchor):
				problems.append("`%s`: binds to `%s`, which is neither a group nor a part" % [part_id, anchor])
		for slot_name in textures.get(part_id, {}).keys():
			if !part.slots.has(slot_name):
				problems.append("`%s`: texture for slot `%s`, which the part does not use" % [part_id, slot_name])
				continue
			var path = textures[part_id][slot_name]
			if !_file_exists(path):
				problems.append("`%s`: image `%s` was not found" % [part_id, path])


static func _file_exists(path):
	var file = File.new()
	return file.file_exists(path)
