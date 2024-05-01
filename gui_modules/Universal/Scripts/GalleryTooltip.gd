extends TextureRect

var parentnode

func _process(delta):
	if weakref(parentnode).get_ref() == null || weakref(parentnode) == null:
		_hide()
		return
	if parentnode != null && (parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		_hide()

func _init():
	set_process(false)

func showup(node, text):
	if node == null:
		return
	parentnode = node
	var screen = get_viewport().get_visible_rect()
	ResourceScripts.core_animations.UnfadeAnimation(self, 0.2)
	
	var pos = node.get_global_rect()
	pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)
	if get_rect().end.x+100 > screen.size.x:
		rect_global_position.x -= get_rect().end.x+100 - screen.size.x
	if get_rect().end.y+125 > screen.size.y:
		rect_global_position.y -= get_rect().end.y+125 - screen.size.y
	
	#var sex_scenes = ResourceScripts.scriptdict.sex_scenes.new().sex_scenes
	$VBoxContainer/BottomText.text = text#sex_scenes[scene_name]
	
	
	show()
	set_process(true)

func _hide():
	parentnode = null
	set_process(false)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
	hide()
