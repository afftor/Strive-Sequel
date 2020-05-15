extends Control

signal signal_RMB
signal signal_RMB_release
signal signal_LMB

var RMBpressed = false


func _input(event):
	if !self.is_visible_in_tree():
		return
	if get_global_rect().has_point(get_global_mouse_position()):
		if event.is_pressed() && event.is_echo() == false:
			if event.is_action("RMB"):
				emit_signal("signal_RMB")
				RMBpressed = true
			elif event.is_action('LMB'):
				emit_signal("signal_LMB")
	if event.is_action_released("RMB") && RMBpressed == true:
		emit_signal("signal_RMB_release")
		RMBpressed = false
