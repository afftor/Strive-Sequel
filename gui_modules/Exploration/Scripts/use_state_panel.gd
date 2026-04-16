extends NinePatchRect

var explorer

func set_explorer(new_explorer):
	explorer = new_explorer

func _input(event):
	if !visible: return
	if event.is_action_released("RMB") or event.is_action_released("LMB"):
		get_tree().connect("idle_frame", self, "try_stop_use_state", [], CONNECT_ONESHOT)

func try_stop_use_state():
	explorer.try_stop_use_state()
