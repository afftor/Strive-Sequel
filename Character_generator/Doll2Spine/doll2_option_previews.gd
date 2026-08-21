extends Node

# Pictures of the options a character can be given: the head of *this* character
# wearing each hairstyle, each pair of eyes, each mouth.
#
# There is no preview art in the project - only the raw layers the doll is built
# from - so the pictures are taken rather than loaded: an off-screen doll is
# dressed in one option at a time and its head is photographed.  The character
# being made is the model, so a picker shows what the choice will actually look
# like on them rather than on a stock face.
#
# Shots take a couple of frames each, so the work is done a few at a time and
# handed back through a signal.  Everything taken is kept: the same option on the
# same character is photographed once per session.

signal preview_ready(group_id, part_id, texture)

const DOLL = preload("res://Character_generator/Doll2Spine/Doll2View.tscn")
const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")
const CHARACTER_MAP = preload("res://Character_generator/Doll2Spine/universal/doll_character_map.gd")
# Big enough to read a hairstyle at a glance; the menu scales it down if it wants
# something smaller.
const CANVAS = Vector2(192, 192)
# `skin_coverage` is not a part in any group: the pattern is painted over the
# body rather than worn, so its pictures are filed under a name of their own.
const COVERAGE_GROUP = "skin_coverage"
# What each picture is framed on, and how much of the tile it fills: a hairstyle
# is read off the whole head, a mouth off the mouth with enough chin around it
# to tell whose it is.  1.0 would be edge to edge.
const FRAMING = {
	"hair": {"slots": ["head", "head_skull", "hairs_base", "hairs_fringe"], "fill": 0.95},
	"hair_back": {"slots": ["head", "head_skull", "hairs_back"], "fill": 0.95},
	"hair_assist": {"slots": ["head", "head_skull", "hairs_assist"], "fill": 0.95},
	# the export spells the beard slot `bread`
	"beard": {"slots": ["head", "head_skull", "bread"], "fill": 0.9},
	# the `head` slot is the jaw alone - the skull is its own - so a chin is
	# chosen on a picture of the jaw rather than of the whole head
	"head": {"slots": ["head"], "fill": 0.8},
	"face": {"slots": ["face", "eyes", "noses", "lips"], "fill": 0.85},
	"eyes": {"slots": ["eyes", "sclera"], "fill": 0.9},
	"eyebrows": {"slots": ["eyebrows"], "fill": 0.8},
	# horns are read against the head they sit on
	"horns": {"slots": ["horns", "head_skull"], "fill": 0.95},
	"nose": {"slots": ["noses"], "fill": 0.32},
	"lips": {"slots": ["lips"], "fill": 0.42},
	"ears": {"slots": ["ears"], "fill": 0.95},
	# a coat is read off the body, not the head
	"skin_coverage": {"slots": ["torso", "breasts", "belly", "pelvis"], "fill": 0.95},
}
const HEAD_FALLBACK = {"slots": ["head", "head_skull", "face"], "fill": 0.8}

var _viewport = null
var _doll = null
var _queue = []
var _cache = {}
var _busy = false
var _character = null
var _borrowed = [] # the group the last shot changed, and what it wore before
var _look = "" # what the character looked like when these pictures were taken
var _built = "" # ...and what the doll in the booth is currently wearing


# A picture is of this character's head, so it goes stale the moment the head
# changes: a new hair colour, a different chin, another race.  These are what a
# shot depends on besides the option it is showing; when any of them moves, every
# picture already taken is of somebody else and is thrown away.
const LOOK_STATS = [
	"race", "sex", "height", "body_color_skin", "body_color_lips", "body_color_ears",
	"body_color_horns", "eye_color", "skin_coverage",
	"hair_base_color_1", "hair_base_color_2", "hair_back_color_1", "hair_back_color_2",
	"hair_assist_color_1", "hair_assist_color_2", "hair_facial_color",
	"chin", "eyeshape", "eye_tex", "eyebrows", "lips", "nose", "ears", "horns",
	"hair_base", "hair_back", "hair_assist", "beard",
	"hair_base_length", "hair_back_length", "hair_assist_length",
]


func _look_of(character):
	var marks = []
	for stat in LOOK_STATS:
		marks.append(str(character.get_stat(stat)))
	return PoolStringArray(marks).join("|")


# `parts` is what to photograph, in the order they should appear.  Anything
# already taken comes back at once; the rest arrive as they are shot.
func request(character, group_id, parts):
	if character == null:
		return
	var look = _look_of(character)
	if _character != character or look != _look:
		# a different character - or the same one after a change - is a different
		# set of pictures, and the old ones are of somebody else's face
		_cache.clear()
		_queue.clear()
		_character = character
		_look = look
	for part_id in parts:
		var key = _key(group_id, part_id)
		if _cache.has(key):
			emit_signal("preview_ready", group_id, part_id, _cache[key])
			continue
		if !_queue.has([group_id, part_id]):
			_queue.append([group_id, part_id])
	if !_busy:
		_busy = true
		_work()


# The same thing for a menu that thinks in stats rather than in parts: a stat's
# value is turned into the part it stands for, so the picker asks for `bun` and
# gets a picture of the doll wearing `hair_assist_bun`.  The pictures come back
# under the stat and the value, which is what the menu has in hand.
func request_for_stat(character, statname, values):
	if str(statname) == COVERAGE_GROUP:
		# a coat's values stand for themselves; there is no part to look up
		request(character, COVERAGE_GROUP, values)
		return
	var group_id = str(CHARACTER_MAP.FEEDS.get(str(statname), ""))
	if group_id == "":
		return
	var parts = []
	for value in values:
		parts.append(CHARACTER_MAP.resolve(str(statname), str(value)))
	request(character, group_id, parts)


# Which picture belongs to a stat's value, once it has been taken.
func taken_for_stat(statname, value):
	if str(statname) == COVERAGE_GROUP:
		return taken(COVERAGE_GROUP, str(value))
	var group_id = str(CHARACTER_MAP.FEEDS.get(str(statname), ""))
	if group_id == "":
		return null
	return taken(group_id, CHARACTER_MAP.resolve(str(statname), str(value)))


# What is already in hand, for a menu that wants to draw itself before the rest
# of the shots land.
func taken(group_id, part_id):
	return _cache.get(_key(group_id, part_id))


func forget():
	_cache.clear()
	_queue.clear()
	_character = null
	_look = ""
	_built = ""


func _key(group_id, part_id):
	return "%s/%s" % [str(group_id), str(part_id)]


func _build():
	_viewport = Viewport.new()
	_viewport.size = CANVAS
	_viewport.usage = Viewport.USAGE_2D
	_viewport.transparent_bg = true
	_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	add_child(_viewport)
	_doll = DOLL.instance()
	_doll.rect_position = Vector2.ZERO
	_doll.rect_min_size = Vector2.ZERO #the scene asks for a big frame; a shot is small
	_doll.rect_size = CANVAS
	_doll.portrait_mode = true
	_doll.show_undress_buttons = false
	_viewport.add_child(_doll)
	# after it is in the tree: entering re-reads the scene's own margins and
	# would put the size back to what the .tscn says
	_doll.rect_size = CANVAS


func _work():
	if _doll == null:
		_build()
		yield(get_tree(), "idle_frame")
	while !_queue.empty():
		# the character can change while the booth is working through its queue,
		# so the model is caught up here rather than once at the start
		if _character != null and _built != _look:
			_doll.rebuild(_character)
			_doll.rebuild_cloth(true)
			_borrowed = []
			_built = _look
		var job = _queue.pop_front()
		_shoot(job[0], job[1])
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		var image = _viewport.get_texture().get_data()
		image.flip_y() # a render target hands its picture back upside down
		var texture = ImageTexture.new()
		texture.create_from_image(image, Texture.FLAG_FILTER)
		_cache[_key(job[0], job[1])] = texture
		emit_signal("preview_ready", job[0], job[1], texture)
	_busy = false


# The doll is told to wear one part without the character being changed: this is
# a picture of a choice, not a choice being made.
func _shoot(group_id, part_id):
	if _doll == null or _doll.model == null:
		return
	_doll.rect_size = CANVAS
	CATALOGUE.use(_doll.model.doll_id)
	if group_id == COVERAGE_GROUP:
		# the coat is on the body, so the body has to be bare for it to be seen;
		# the doll is rebuilt before the next shot rather than dressed again
		_doll.set_undress_level("naked")
		_doll.show_coverage(part_id)
		_built = ""
		var coat = FRAMING[COVERAGE_GROUP]
		_doll.model.scale = Vector2.ONE
		_doll.frame_on(coat.slots, coat.fill)
		return
	# put back what the last shot borrowed: a horn left on from the horn pictures
	# would still show in the pictures of the eyebrows
	if !_borrowed.empty():
		_doll.model.selections[_borrowed[0]] = _borrowed[1]
	_borrowed = [group_id, str(_doll.model.selections.get(group_id, ""))]
	if part_id == "" or part_id in CATALOGUE.parts(group_id):
		_doll.model.selections[group_id] = part_id
	else:
		# a value the art has nothing for is drawn as nothing rather than as
		# whatever the character happens to be wearing
		_doll.model.selections[group_id] = ""
	_doll.model._rebuild_model()
	_doll.model._update_animated_pose()
	var framing = FRAMING.get(str(group_id), HEAD_FALLBACK)
	if _doll._bounds_of(framing.slots).size.y <= 0.0:
		framing = HEAD_FALLBACK # nothing worn: a bare head still reads as `none`
	_doll.model.scale = Vector2.ONE
	_doll.frame_on(framing.slots, framing.fill)
