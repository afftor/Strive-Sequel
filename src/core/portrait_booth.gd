extends Node

#Off screen ragdoll that generates portraits for characters nobody opened.
#The screens only ever shot the character being looked at, so in a save of forty slaves
#thirty nine had no portrait at all and fell back to their race icon.
#
#Framing here does not depend on the host screen: the pose is placed at a fixed scale and
#then slid so the crop frame lands in the middle of a small canvas, instead of cutting a
#rectangle out of a screen sized one and hoping it stayed inside.

const RAGDOLL_SCENE = "res://ragdoll.tscn"
const CANVAS = Vector2(512, 512) #big enough for the widest crop frame at scale 1
const ANCHOR = Vector2(256, 256)
const POSE_START = Vector2(256, 520) #rough placing, centre_portrait_frame() does the rest
const FRAMES_BETWEEN = 6 #a rebuild is not cheap, so leave the game room to breathe

var _host = null
var _ragdoll = null
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
	#a viewport that is never displayed - its children still render into their own targets,
	#and a node parked inside one still counts as visible, which rebuild() insists on
	_host = Viewport.new()
	_host.size = Vector2(1, 1)
	_host.render_target_update_mode = Viewport.UPDATE_DISABLED
	add_child(_host)
	_ragdoll = load(RAGDOLL_SCENE).instance()
	_ragdoll.test_mode = false
	_ragdoll.update_character_portrait = false #shot by hand here, after the centring pass
	_ragdoll.position = POSE_START #read by the ragdoll's own _ready, so set it before adding
	_ragdoll.scale = Vector2(1, 1)
	_host.add_child(_ragdoll)
	_ragdoll.get_node('VPC/VP').size = CANVAS


func _work():
	if _ragdoll == null:
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
	_ragdoll.rebuild(person)
	_ragdoll.rebuild_cloth(!person.has_work_rule('nudity'))
	if _ragdoll.center_portrait_frame(ANCHOR):
		person.update_portrait(_ragdoll)
