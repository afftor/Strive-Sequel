extends Control

# The doll as the game embeds it, standing in for `ragdoll.tscn`.
#
# A Control rather than a Node2D, and that is the whole trick of fitting into the
# screens: it clips its own contents, so the doll cannot draw outside the box the
# screen gives it.  The old doll needed a `Light2D` in mask mode over a 1500x1500
# texture on every screen, plus `light_mask` on all 192 of its nodes, to do the
# same rectangular crop.  Here it is one property, and the box is the node's own
# rect - which the screen was already authoring.
#
# The screens talk to this and never to the new doll directly: they call the same
# handful of methods the old paperdoll had - `rebuild`, `rebuild_cloth`,
# `rebuild_underwear`, `rebuild_stat` - so replacing the doll is a change of node
# and not a rewrite of eight screens.
#
# What it does not do yet, on purpose: no animation and no poses.  The doll is
# solved once per rebuild and then stands still, which is also why it costs
# nothing per frame.

const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")
const CHARACTER_MAP = preload("res://Character_generator/Doll2Spine/universal/doll_character_map.gd")
const MODEL = preload("res://Character_generator/Doll2Spine/Doll2Preview.tscn")
const MODIFIERS = preload("res://Character_generator/Doll2Spine/universal/doll_modifiers.gd")
const COLORS = preload("res://Character_generator/Doll2Spine/universal/doll_colors.gd")
const COVERAGE = preload("res://Character_generator/Doll2Spine/universal/doll_coverage.gd")
# The frame is sized for the tallest character there can be, so the others stay
# visibly shorter inside it.
const TALLEST_TIER = "towering"

# The stats the map reads.  Kept here rather than fetched from GeneratorData, so
# the new doll does not depend on the old one's data file.
const STATS = [
	"race", "sex", "chin", "eyeshape", "eye_tex", "eyebrows", "lips", "nose",
	"ears", "hair_base", "hair_back", "hair_assist", "horns", "wings", "tail",
	"penis_type", "tits_size", "pregnancy_status", "height", "skin_coverage",
	"multiple_tits_developed", "body_shape", "hand_pose", "face_markings",
	"ass_size",
]

# Colour channel -> the stat that picks its colour, and the stat that picks the
# second one where the channel is two-tone.  The old doll kept a colour per part;
# the new one keeps a colour per channel, and the two line up one to one.
const CHANNEL_COLOURS = {
	"skin": ["body_color_skin", ""],
	"eyes": ["eye_color", ""],
	"lips": ["body_color_lips", ""],
	"eyebrows": ["hair_base_color_1", ""],
	"hair": ["hair_base_color_1", "hair_base_color_2"],
	"hair_back": ["hair_back_color_1", "hair_back_color_2"],
	"hair_assist": ["hair_assist_color_1", "hair_assist_color_2"],
	# `ears` is decided per part below: only an animal ear takes the ear colour.
	"ears": ["body_color_ears", ""],
	"tail": ["body_color_tail", ""],
	"wings": ["body_color_wings", ""],
	"horns": ["body_color_horns", ""],
	"animal": ["body_color_animal", ""],
	"race": ["body_color_skin", ""],
}

# What the new doll wants and the character does not carry yet.  They are listed
# in `legacy/old_doll_behaviour.md` with where each one belongs; until they are
# added, asking for them would raise, so the doll does without and takes the
# catalogue's default.  Delete a name here as its stat is added.
#
# The list is written out rather than checked against `statdata`, because naming
# an autoload from a script this early in the load order does not parse.
const NOT_A_STAT_YET = ["body_shape", "hand_pose", "face_markings"]

# Old stat -> catalogue axis, for the dimensions that select between several
# attachments of one part rather than between parts.
const AXES = {
	"tits_size": "tits_size",
	"pregnancy_status": "pregnancy",
	"hand_pose": "hand_pose",
}
const TITS = {
	"flat": "flat", "small": "small", "average": "normal", "average_high": "normal",
	"average_narrow": "normal", "average_wide": "normal", "big": "large",
	"big_high": "large", "big_narrow": "large", "huge": "big", "huge_high": "big",
	"huge_narrow": "big", "masculine": "flat",
}
const PREGNANCY = {"no": "none", "early": "mid", "heavy": "big"}

# Old stat -> the width of the hips, which is the only handle the pelvis has.
# The rig carries no backside of its own: its six pelvis bones hold so little of
# the mesh that scaling one moves 2-5 px, and stretching the lower trunk the long
# way drops the hip until the leg IK crosses the legs over each other.  Widening
# it is what reads as a bigger bottom on a figure drawn from the front, and it is
# what the old doll did too - `ass_size` there scaled the pelvis sprite in the one
# axis it had, 1.0 flat to 1.15 huge, and touched nothing else.  Centred on
# `average` so an ordinary character keeps the rig's own shape.
const ASS = {
	"flat": 0.9, "masculine": 0.9, "small": 0.95,
	"average": 1.0, "big": 1.07, "huge": 1.14,
}

# A little room at the top, so hair and horns are not flush against the edge.
export var frame_headroom = 0.04
# The screens show the doll from the hips up, as the old one did: it is drawn
# large and the frame keeps the upper body.  Turn this off for a screen that
# wants the whole figure.
export var show_from_the_hips = true
# Frames the head instead of the whole figure, for the portrait booth.  The old
# doll cropped a rectangle out of the rendered screen and the crop ran off the
# canvas on tall characters; here the doll is simply drawn at the size the
# portrait wants, so there is nothing to trim.
export var portrait_mode = false
# How much of the shot is head: 1.0 would be the head box exactly, and the rest
# is shoulders and hair.
export var portrait_zoom = 1.55
# The player may look closer and move the doll about, as they could on the old
# one.  Its limits are kept: a tenth per wheel step, three quarters to one and a
# half, and a pan that cannot push the figure out of its own frame.
export var allow_zoom = true
const ZOOM_STEP = 0.1
const ZOOM_MIN = 0.75
const ZOOM_MAX = 1.5
const DRAG_THRESHOLD = 6.0
# Sideways and downwards the old doll's limits are plenty.  Upwards is another
# matter: the screens frame the doll from the hips, so the legs and the feet are
# below the frame and only a long pull brings them into it.
const PAN_LIMIT_X = 220.0
const PAN_LIMIT_DOWN = 0.35
const PAN_LIMIT_UP = 1.1

var view_zoom = 1.0
var view_pan = Vector2.ZERO
var _drag_from = Vector2.ZERO
var _pan_from = Vector2.ZERO
var _drag_candidate = false
var _dragging = false

# Standing in for the old doll's own flags, so the screens can keep setting them.
var test_mode = false
var update_character_portrait = true
var character = null
var clothes = true

var model = null


func _ready():
	rect_clip_content = true
	# the doll takes the wheel and the drag inside its own rect and lets everything
	# else through, which is what the old doll's `ZoomArea` did
	mouse_filter = Control.MOUSE_FILTER_PASS if allow_zoom and !portrait_mode else Control.MOUSE_FILTER_IGNORE
	model = MODEL.instance()
	# said before the model enters the tree, so its editor panel is never built
	model.interface_enabled = false
	add_child(model)
	# the preview carries an editor panel and drag handles; in the game the doll
	# is only ever looked at
	for child in model.get_children():
		if child is CanvasLayer:
			child.queue_free()
	model.handle_buttons.clear()
	model.handles_visible = false
	model.set_process_unhandled_input(false)
	for animation_name in model.animation_states.keys():
		model.animation_states[animation_name] = false
	set_process(false)


# --- the old doll's API -------------------------------------------------------

func rebuild(character_to_build):
	# A different character is a fresh look at a fresh doll: whatever the player
	# zoomed into or dragged off-frame on the last one is not where they want to
	# start on this one.
	if character_to_build != character:
		view_zoom = 1.0
		view_pan = Vector2.ZERO
	character = character_to_build
	_apply()


func rebuild_cloth(value):
	if value != null:
		clothes = value
	_apply()


func rebuild_underwear():
	_apply()


func rebuild_stat(_statname):
	# the new doll has no per-stat path: a rebuild is 20-30 ms and every stat
	# reaches the same solve, so there is nothing for a partial one to save
	_apply()


# --- the portrait pipeline ----------------------------------------------------

# The wheel zooms, the left button drags.  Only inside this node's own rect,
# because that is the rect the screen gave the doll.
func _gui_input(event):
	if !allow_zoom or portrait_mode or model == null:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_drag_candidate = true
				_dragging = false
				_drag_from = event.position
				_pan_from = view_pan
			else:
				_drag_candidate = false
				_dragging = false
			return
		if !event.pressed or !(event.button_index in [BUTTON_WHEEL_UP, BUTTON_WHEEL_DOWN]):
			return
		var step = ZOOM_STEP if event.button_index == BUTTON_WHEEL_UP else -ZOOM_STEP
		var zoomed = clamp(view_zoom + step, ZOOM_MIN, ZOOM_MAX)
		if zoomed != view_zoom:
			view_zoom = zoomed
			_stand_on_the_node()
		accept_event()
		return
	if event is InputEventMouseMotion and _drag_candidate:
		var moved = event.position - _drag_from
		if !_dragging and moved.length_squared() < DRAG_THRESHOLD * DRAG_THRESHOLD:
			return
		_dragging = true
		view_pan = Vector2(
			clamp(_pan_from.x + moved.x, -PAN_LIMIT_X, PAN_LIMIT_X),
			clamp(_pan_from.y + moved.y, -rect_size.y * PAN_LIMIT_UP, rect_size.y * PAN_LIMIT_DOWN))
		_stand_on_the_node()
		accept_event()


# Puts the view back where it started, for a screen that wants a clean doll.
func reset_view():
	view_zoom = 1.0
	view_pan = Vector2.ZERO
	_stand_on_the_node()


# Shoots the doll into a picture.  Only in portrait mode, which means only in the
# booth: on a screen this node's viewport is the game window, and a portrait is
# not a screenshot of it.  The old doll cropped a rectangle out of whatever was
# rendered and the crop ran off the canvas on tall characters; here the whole
# viewport is the portrait.
func save_portrait(name, char_ref = null):
	if !portrait_mode:
		return false
	var folder = _portraits_folder()
	var directory = Directory.new()
	if !directory.dir_exists(folder):
		directory.make_dir(folder)
	var path = folder + name + ".png"
	# the render has to land before it can be read
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	if !is_inside_tree() or get_viewport() == null:
		if char_ref != null:
			char_ref.portrait_failed()
		return false
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	_unpremultiply(image)
	# handed over in memory as well as written: the png is only there to survive a
	# restart, and nothing has to read it back to show the fresh portrait
	var handler = _singleton("input_handler")
	if handler != null:
		handler.store_portrait(path, image)
	if char_ref != null:
		char_ref.portrait_ready(path)
	image.save_png(path)
	if handler != null:
		handler.emit_signal("PortraitUpdate")
	return true


# The autoloads are fetched rather than named.  Naming one from this script does
# not parse when the script is preloaded before the singletons are bound - the
# node then falls back to a plain Control and every call on it fails.
func _singleton(singleton_name):
	if !is_inside_tree():
		return null
	return get_tree().get_root().get_node_or_null(singleton_name)


func _portraits_folder():
	var settings = _singleton("variables")
	return str(settings.portraits_folder) if settings != null else "user://userportraits/"


# A half transparent pixel comes back from the canvas already multiplied by its
# own alpha, which darkens it.  Over a dark card that goes unnoticed; over a
# location backdrop it draws a dark rim around hair and ears.
func _unpremultiply(image):
	image.lock()
	for y in image.get_height():
		for x in image.get_width():
			var pixel = image.get_pixel(x, y)
			if pixel.a <= 0.0 or pixel.a >= 1.0:
				continue
			image.set_pixel(x, y, Color(
				min(pixel.r / pixel.a, 1.0), min(pixel.g / pixel.a, 1.0),
				min(pixel.b / pixel.a, 1.0), pixel.a))
	image.unlock()


# The old doll had to slide its pose until a crop frame landed on an anchor.
# This one is framed by construction, so there is nothing to centre.
func center_portrait_frame(_anchor = Vector2.ZERO):
	return portrait_mode


# --- the breast interaction ---------------------------------------------------
# Kept as no-ops so the screens that call them keep working; they need animation,
# which is off for now.

func jiggle_tits():
	pass


func tits_interaction(_position = Vector2.ZERO):
	pass


func get_tits_mesh():
	return null


func get_tits_outline():
	return null


# --- driving the doll ---------------------------------------------------------

func _apply():
	if model == null or character == null:
		return
	var stats = {}
	for stat in STATS:
		stats[stat] = _stat(stat)
	stats["equipment"] = _equipment()
	stats["nude"] = !clothes
	stats["beast"] = _beast()

	var doll_id = _doll_id(stats)
	# a different sex is a different export, not only a different part list: the
	# skeletons share neither their bones nor their parts, so the model has to be
	# swapped rather than pointed at another catalogue
	if doll_id != model.doll_id:
		model._switch_doll(doll_id)
		model.handle_buttons.clear()
		model.handles_visible = false
		for animation_name in model.animation_states.keys():
			model.animation_states[animation_name] = false
	CATALOGUE.use(doll_id)
	model.selections = CATALOGUE.default_selections()
	for group_id in CHARACTER_MAP.selections_for(stats, doll_id).keys():
		var part_id = str(CHARACTER_MAP.selections_for(stats, doll_id)[group_id])
		if part_id.empty() or part_id in CATALOGUE.parts(group_id):
			model.selections[group_id] = part_id
	model.axis_values = CATALOGUE.default_axes()
	for stat in AXES.keys():
		var value = _axis_value(stat, stats.get(stat, ""))
		if value != "" and model.axis_values.has(AXES[stat]):
			model.axis_values[AXES[stat]] = value
	model.height_tier = _height(str(stats.get("height", "")))
	#`hips` is a free build slider in the preview and the character's butt size
	#here: both widen the same bone, and the two multiply if the preview sets one.
	model.proportions["hips"] = float(ASS.get(str(stats.get("ass_size", "")), 1.0))
	_apply_colours()
	model._rebuild_model()
	_apply_coverage()
	model._update_animated_pose()
	_stand_on_the_node()


# The character's own colours, on the channels that carry them.  A channel with
# no colour keeps white, which the shader reads as "leave the art alone" - that is
# what an unpainted part looked like on the old doll too.
func _apply_colours():
	for channel_id in CHANNEL_COLOURS.keys():
		if !model.color_values.has(channel_id):
			continue
		var pair = CHANNEL_COLOURS[channel_id]
		# A pointed ear is skin, not fur.  The old doll painted `body_color_ears`
		# onto its furry-ear node alone and never touched the humanoid one, whose
		# art is drawn in skin tone; the stat still answers for a human ear, with a
		# fallback of `yellow2` that has nothing to do with the character.
		if channel_id == "ears" and !_wears_animal_ears():
			model.color_values[channel_id] = COLORS.colour_of("body_color_skin", _stat("body_color_skin"))
			model._apply_channel_colour(channel_id)
			continue
		model.color_values[channel_id] = COLORS.colour_of(str(pair[0]), _stat(str(pair[0])))
		if str(pair[1]) != "":
			model.color_values_secondary[channel_id] = COLORS.colour_of(str(pair[1]), _stat(str(pair[1])))
		model._apply_channel_colour(channel_id)


# `skin_coverage` -> the fur pattern painted over the body.  The names carried
# over unchanged where the art did; what the old doll had and this one has not is
# listed as empty, and the body is then simply bare skin.
const COVERAGE_PATTERNS = {
	"fur_orange": "fur_orange",
	"fur_orange_white": "fur_orange_white",
	"fur_white": "fur_white",
	"fur_grey": "fur_grey",
	"fur_brown": "fur_brown",
	"fur_black": "fur_black",
	"fur_striped": "fur_striped",
	"fur_tricolor": "fur_tricolor",
	"kobold": "kobold",
	# no art for these yet: feathers, plant, and the three scale patterns
	"feathers": "",
	"plant": "",
	"scale": "",
	"scale2": "",
	"scale3": "",
}


# The fur or scales the character wears, painted over the body's own colour.  It
# needs the masks, so it is applied after the meshes exist; and it belongs to a
# beastkin body alone, exactly as the patterns declare.
func _apply_coverage():
	var wanted = str(COVERAGE_PATTERNS.get(str(_stat("skin_coverage")), ""))
	if wanted != "" and !CATALOGUE.has_tag(str(model.selections.get("body", "")), COVERAGE.REQUIRES_TAG):
		wanted = ""
	model.coverage_id = wanted
	model.coverage_colors = COVERAGE.default_colors(wanted)
	model._apply_coverage_to_meshes()


# Ears drawn as fur rather than as skin.  Everything the art calls an ear that is
# not one of the humanoid shapes.
const HUMANOID_EARS = ["ears_human", "ears_elven", "ears_orc", "ears_goblin", "ears_nereid"]

func _wears_animal_ears():
	var part_id = str(model.selections.get("ears", ""))
	return part_id != "" and !(part_id in HUMANOID_EARS)


# Two things at once: the doll is scaled to the frame it was given, and shifted
# so this node's own position is the ground it stands on.
#
# Both are read off the drawn geometry rather than from the preview's own origin.
# That origin is measured once per doll and does not follow the height tier - the
# tier stretches the spine and shrinks the head rather than scaling the whole
# figure, so the distance from the root to the feet moves with it.  Trusting it
# left a switched doll floating 66 px above its own node while a freshly built
# one stood 71 px below it.
func _stand_on_the_node():
	if model == null:
		return
	model.scale = Vector2.ONE
	if portrait_mode:
		_frame_the_head()
		return
	var shown = _bounds_of(BUST_PARTS) if show_from_the_hips else _body_bounds()
	if shown.size.y <= 0.0:
		return
	var frame = rect_size
	var tier = float(MODIFIERS.display_scale(model.height_tier))
	var tallest = float(MODIFIERS.display_scale(TALLEST_TIER))
	var fit = 1.0
	if frame.y > 0.0 and tier > 0.0 and tallest > 0.0:
		# Fitting what is shown to the frame would make every character exactly as
		# tall as every other, which is the one thing the height tier is for.  The
		# frame is fitted to a towering character instead, and this one keeps its
		# share of it.
		var reference = (shown.size.y * HEADROOM_FOR_HAIR) / tier
		fit = (frame.y * (1.0 - frame_headroom)) / (reference * tallest)
	fit *= view_zoom
	model.scale = Vector2(fit, fit)
	if show_from_the_hips:
		# Anchored at the hips, which is where the old doll anchored: it scaled the
		# whole figure by the tier (0.75 to 1.3) and then slid it up or down by a
		# per-tier offset - +60 px for the smallest, -30 for the largest - which is
		# exactly what it takes to keep everyone standing on one line while the
		# head rises.  Pinning the head instead, as this did before, aligns the
		# wrong end: heads level and feet wandering reads as being pushed about
		# rather than as being taller.
		model.position = Vector2(frame.x * 0.5, frame.y * HIPS_SIT_AT) + view_pan - Vector2(shown.position.x + shown.size.x * 0.5, shown.end.y) * fit
	else:
		# stands on the bottom of its own box, in the middle of it
		model.position = Vector2(frame.x * 0.5, frame.y) + view_pan - Vector2(shown.position.x + shown.size.x * 0.5, shown.end.y) * fit


# How tall the doll stands, measured from the parts every doll has.  Not from
# everything drawn: a race overlay can carry a mesh with vertices far outside the
# figure - the slime one does - and measuring that shrinks the whole doll to fit
# a shape nobody can see.
# What the whole figure is measured by.  The animal halves are in here because a
# centaur or a lamia is that shape: measuring only the human half would leave the
# barrel or the coils hanging out of the bottom of the frame.
const MEASURED_BY = ["head", "head_skull", "torso", "pelvis", "leg_left", "leg_right",
	"animal_body", "animal_frontbody"]
# What a portrait is framed on.  The hair is left out on purpose: a very long
# style would otherwise pull the frame down to the character's waist.
const PORTRAIT_PARTS = ["head", "head_skull", "face", "eyes", "lips", "nose", "ears"]
# Head to hips: what a screen shows.  The legs run past the bottom of the frame
# and are clipped, which is how the old doll filled these panels.
const BUST_PARTS = ["head", "head_skull", "torso", "pelvis"]
# The head art stops at the crown; hair and horns sit above it, so the frame
# keeps a little more room than the body alone asks for.
const HEADROOM_FOR_HAIR = 1.12
# Where the hip line sits in the frame, as a share of its height.  Every
# character's hips land here whatever their height, and the head rises above it
# as they get taller - the way the old doll's per-tier offsets kept them on a
# common floor.
const HIPS_SIT_AT = 0.93


# Fills the rect with the head, centred, whatever the character's height or
# hairstyle.  The frame is the portrait, so nothing is cropped afterwards.
func _frame_the_head():
	var head = _bounds_of(PORTRAIT_PARTS)
	if head.size.y <= 0.0:
		return
	var frame = rect_size
	var fit = min(frame.x / (head.size.x * portrait_zoom), frame.y / (head.size.y * portrait_zoom))
	model.scale = Vector2(fit, fit)
	model.position = frame * 0.5 - (head.position + head.size * 0.5) * fit


# The figure's own box: where it stands and how tall it is.
func _body_bounds():
	return _bounds_of(MEASURED_BY)


func _bounds_of(slots):
	var minimum = Vector2(1e9, 1e9)
	var maximum = Vector2(-1e9, -1e9)
	for record in model.mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		if !(str(record.slot.get("name", "")) in slots):
			continue
		for point in record.polygon.polygon:
			var world = point + record.polygon.position
			minimum.x = min(minimum.x, world.x)
			minimum.y = min(minimum.y, world.y)
			maximum.x = max(maximum.x, world.x)
			maximum.y = max(maximum.y, world.y)
	if minimum.x > maximum.x:
		return Rect2()
	return Rect2(minimum, maximum - minimum)


func _axis_value(stat, value):
	value = str(value)
	if stat == "tits_size":
		return str(TITS.get(value, "normal"))
	if stat == "pregnancy_status":
		return str(PREGNANCY.get(value, "none"))
	if stat == "hand_pose":
		return value if value != "" else "1"
	return value


# The two skeletons are separate exports; sex chooses between them and a femboy
# body keeps the male one.
func _doll_id(stats):
	var sex = str(stats.get("sex", "female"))
	return "male" if sex == "male" else "female"


func _height(value):
	return value if value in ["tiny", "petite", "short", "average", "tall", "towering"] else "average"


# The animal a beastkin race is drawn from, for the muzzle.
func _beast():
	var race = str(_stat("race")).to_lower()
	for animal in ["cat", "fox", "wolf", "rabbit", "bunny", "tanuki", "rat"]:
		if race.find(animal) >= 0:
			return animal
	return "cat"


func _equipment():
	if character == null or !character.has_method("get_stat"):
		return {}
	var result = {}
	# the slots the game actually has; there is no `back` - a weapon slung across
	# the back is still equipped in a hand
	for slot_name in ["chest", "legs", "underwear", "neck", "head", "rhand"]:
		var item_id = null
		if character.get("equipment") != null and character.equipment.has_method("get_gear_type"):
			item_id = character.equipment.get_gear_type(slot_name)
		if item_id != null:
			result[slot_name] = str(item_id)
	return result


func _stat(statname):
	if character == null or !character.has_method("get_stat"):
		return ""
	if statname in NOT_A_STAT_YET:
		return ""
	var value = character.get_stat(statname)
	return "" if value == null else value
