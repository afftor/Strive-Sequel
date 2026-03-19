extends ToolButton

func _ready():
	connect("pressed", self, 'close_parent')
	connect("visibility_changed", self, "on_vis_changed")

func close_parent():
	gui_controller.close_scene(get_parent())

func on_vis_changed():
	var vis = is_visible_in_tree()
	if vis:
		rect_global_position = Vector2(0,0)
	if gui_controller.clock == null:
		return
	if vis:
		gui_controller.clock.ext_block_start(self, "close_parent")
	else:
		gui_controller.clock.ext_block_stop(self)
