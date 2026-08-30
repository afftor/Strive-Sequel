extends Node

#A picture has landed on disk and the character's icon now points at it, so
#whoever is showing them can ask for it again.
signal portrait_taken(id)

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
var _forced = {} #ids to shoot again even though they already have a picture


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


#The look changed under somebody's eyes - a hairstyle picked on an open doll - so
#the picture on file is stale even though there is one and `needs_portrait` says
#no. This shoots it again regardless.
func reshoot(person):
	if person == null:
		return
	person.set_stat('portrait_update', true)
	_forced[person.id] = true
	_attempted.erase(person.id)
	if !_queue.has(person.id):
		_queue.append(person.id)
	if !_busy:
		_busy = true
		_work()


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
	_doll.rect_min_size = Vector2.ZERO #the scene asks for a big frame; a shot is small
	_doll.rect_size = CANVAS
	_doll.portrait_mode = true
	_viewport.add_child(_doll)
	#entering the tree re-reads the scene's margins, so the canvas size is set
	#again once it is in there
	_doll.rect_size = CANVAS


func _work():
	if _doll == null:
		_build()
		yield(get_tree(), 'idle_frame') #let the instance finish its own _ready
	while !_queue.empty():
		var person = characters_pool.get_char_by_id(_queue.pop_front())
		if person != null and (person.needs_portrait() or _forced.has(person.id)):
			_forced.erase(person.id)
			_attempted[person.id] = true
			#the shot is a coroutine of its own: it lets the render land, reads the
			#viewport and only then points the character at the picture. Announcing it
			#before that hands every listener the icon they already had, which is how a
			#list built once kept showing race icons for characters that did get a shot.
			var shot = _shoot(person)
			if shot is GDScriptFunctionState and shot.is_valid():
				shot = yield(shot, 'completed')
			if shot:
				emit_signal('portrait_taken', person.id)
		for _i in FRAMES_BETWEEN:
			yield(get_tree(), 'idle_frame')
	_busy = false


func _shoot(person):
	_doll.rebuild(person)
	_doll.rebuild_cloth(!person.has_work_rule('nudity'))
	return person.update_portrait(_doll)
