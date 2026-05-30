extends NinePatchRect

var explorer
var last_input_handled = false

func set_explorer(new_explorer):
	explorer = new_explorer

func last_input_is_handled():
	last_input_handled = true

func _input(event):
	if !visible: return
	if event.is_action_released("RMB") or event.is_action_released("LMB"):
		if input_handler.hard_tutorial_active: return
		last_input_handled = false
		get_tree().connect("idle_frame", self, "try_stop_use_state", [], CONNECT_ONESHOT)
	if event is InputEventMouseMotion:
		rect_global_position.x = event.position.x + 20
		rect_global_position.y = event.position.y + 20

func show():
	var pos = get_viewport().get_mouse_position()
	rect_global_position.x = pos.x + 20
	rect_global_position.y = pos.y + 20
	.show()


func try_stop_use_state():
	if last_input_handled: return
	if explorer.is_in_dedicated_animation(): return
	explorer.try_stop_use_state()
