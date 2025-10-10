extends Control
class_name tooltip_main

enum {STATE_HIDE, STATE_OPENING, STATE_OPEN}
var parentnode
var open_timer
var state = STATE_HIDE

func _init():
	set_process(false)


func _ready():
	.hide()



func _process(delta):
	if !weakref(parentnode).get_ref():
		hide()
		return
	if parentnode != null and ( parentnode.is_visible_in_tree() == false or !input_handler.get_real_global_rect(parentnode, true).has_point(get_global_mouse_position())):
		hide()
		return
	if state == STATE_OPENING:
		open_timer -= delta
		if open_timer <= 0:
			state = STATE_OPEN
			show()
#			update()
			yield(update(), 'completed')
#			modulate.a = 1.0
#			show()
			ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)


func _setup(node):
	if state == STATE_HIDE:
		parentnode = node
		open_timer = variables.tooltip_delay
		state = STATE_OPENING
		set_process(true)
		return true
#	elif parentnode != null and !input_handler.get_real_global_rect(parentnode, true).has_point(get_global_mouse_position()):
	elif node == parentnode:
		return false
	else: 
		hide()
		parentnode = node
		open_timer = variables.tooltip_delay
		state = STATE_OPENING
		set_process(true)
		return true
#	else:
#		print("warning - tooltip already opened")


func hide():
	parentnode = null
	set_process(false)
	state = STATE_HIDE
#	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	.hide()


func show():
	visible = true
	modulate.a = 0.01
