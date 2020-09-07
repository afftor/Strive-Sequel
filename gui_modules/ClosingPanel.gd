extends Control

var closebuttonoffset = [9,9]
var closebutton
var open_sound = 'menu_open'
var close_sound = 'menu_close'
var close_played = false

func _ready():
	rect_pivot_offset = Vector2(rect_size.x/2, rect_size.y/2)
	closebutton = load(ResourceScripts.scenedict.close).instance()
	add_child(closebutton)
	move_child(closebutton, 0)
	closebutton.connect("pressed", self, 'hide')
	RepositionCloseButton()

func RepositionCloseButton():
	var rect = get_global_rect()
	var pos = Vector2(rect.end.x - closebutton.rect_size.x - closebuttonoffset[0], rect.position.y + closebuttonoffset[1])
	closebutton.rect_global_position = pos

func show():
#	if !is_visible_in_tree():
#		input_handler.PlaySound(open_sound)
	close_played = false
	input_handler.Open(self)
	get_viewport().set_disable_input(true)
	yield(get_tree().create_timer(0.15),"timeout")
	get_viewport().set_disable_input(false)
	input_handler.CurrentScene = self
#	self.visible = true

func hide():
	pass
	# print("Hide: " + str(self.name))
	# var char_info = input_handler.get_spec_node(input_handler.NODE_SLAVEMODULE)
	# if input_handler.PreviousScene.name == "slavemodule":
	# 	char_info.show()
	# 	input_handler.Close(self)
	# 	if input_handler.CurrentScene == self && self.name != "ClassPanel":
	# 		char_info.set_state("default")
	# elif input_handler.PreviousScene.name == "SlaveClassesModule":
	# 	input_handler.Close(self)
	# 	input_handler.PreviousScene = char_info
	# 	input_handler.CurrentScene = char_info.ClassesModule
	# elif input_handler.CurrentScene.name != "slavemodule":
	# 	pass
	# else:
	# 	if input_handler.CurrentScene.name != "ClassPanel":
	# 		input_handler.PreviousScene = self
	# 		if is_visible_in_tree() && close_played == false:
	# 			#input_handler.PlaySound(close_sound)
	# 			close_played = true
	# 		input_handler.Close(self)
	# 		get_viewport().set_disable_input(true)
	# 		yield(get_tree().create_timer(0.15),"timeout")
	# 		get_viewport().set_disable_input(false)
