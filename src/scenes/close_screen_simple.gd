extends ToolButton

func _ready():
	connect("pressed", self, 'close_parent')
	connect("visibility_changed", self, "on_vis_changed")

func close_parent():
	get_parent().hide()

func on_vis_changed():
	if is_visible_in_tree():
		rect_global_position = Vector2(0,0)
