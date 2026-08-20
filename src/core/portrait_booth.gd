extends Node

#Off screen doll that generates portraits for characters nobody opened.
#The screens only ever shot the character being looked at, so in a save of forty slaves
#thirty nine had no portrait at all and fell back to their race icon.
#
#The doll is framed on its own head at the size of the canvas, so the picture is what the
#viewport holds and nothing is cropped afterwards. The old paperdoll cut a rectangle out
#of the rendered screen instead, and that rectangle ran off the top of the canvas on tall
#characters - a portrait could come back a 9 px sliver or empty.

const DOLL = preload("res://Character_generator/Doll2Spine/Doll2View.tscn")
const CANVAS = Vector2(512, 512)
const FRAMES_BETWEEN = 6 #a rebuild is not cheap, so leave the game room to breathe

var _viewport = null
var _doll = null
var _queue = []
var _attempted = {} #one go per character per session, a failing shot must not loop
var _busy = false


func enqueue(person):
	if person == null or !person.needs_portrait():
		return
	if _attempted.has(person.id) or _queue.has(person.id):
		return
	_queue.append(person.id)
	if !_busy:
		_busy = true
		_work()


func forget(id): #lets a character be shot again, e.g. after their look changed
	_attempted.erase(id)


func _build():
	#a viewport of exactly the portrait's size: what it renders is the portrait. It keeps
	#rendering while nothing shows it, which is the whole point of a booth.
	_viewport = Viewport.new()
	_viewport.size = CANVAS
	_viewport.usage = Viewport.USAGE_2D
	_viewport.transparent_bg = true
	_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	add_child(_viewport)
	_doll = DOLL.instance()
	_doll.rect_position = Vector2.ZERO
	_doll.rect_size = CANVAS
	_doll.portrait_mode = true
	_viewport.add_child(_doll)


func _work():
	if _doll == null:
		_build()
		yield(get_tree(), 'idle_frame') #let the instance finish its own _ready
	while !_queue.empty():
		var person = characters_pool.get_char_by_id(_queue.pop_front())
		if person != null and person.needs_portrait():
			_attempted[person.id] = true
			_shoot(person)
		for _i in FRAMES_BETWEEN: #save_portrait waits two frames of its own before reading
			yield(get_tree(), 'idle_frame')
	_busy = false


func _shoot(person):
	_doll.rebuild(person)
	_doll.rebuild_cloth(!person.has_work_rule('nudity'))
	person.update_portrait(_doll)
