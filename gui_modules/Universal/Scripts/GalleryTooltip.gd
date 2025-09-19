extends tooltip_main


func showup(node, text):
	if node == null:
		return
	if _setup(node):
		#var sex_scenes = ResourceScripts.scriptdict.sex_scenes.new().sex_scenes
		$VBoxContainer/BottomText.text = text#sex_scenes[scene_name]


func update():
	var screen = get_viewport().get_visible_rect()
	
	var pos = parentnode.get_global_rect()
	pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)
	if get_rect().end.x + 100 > screen.size.x:
		rect_global_position.x -= get_rect().end.x + 100 - screen.size.x
	if get_rect().end.y + 125 > screen.size.y:
		rect_global_position.y -= get_rect().end.y + 125 - screen.size.y


