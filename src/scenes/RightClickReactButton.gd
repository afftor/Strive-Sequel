extends Control

signal signal_RMB
signal signal_RMB_release
signal signal_LMB

var RMBpressed = false
var indialog = false

#func _input(event):
#	if !self.is_visible_in_tree() || disable():
#		return
#	if get_global_rect().has_point(get_global_mouse_position()):
#		if event.is_pressed() && event.is_echo() == false:
#			if event.is_action("RMB"):
#				emit_signal("signal_RMB")
#				RMBpressed = true
#			elif event.is_action('LMB'):
#				emit_signal("signal_LMB")
#	if event.is_action_released("RMB") && RMBpressed == true:
#		emit_signal("signal_RMB_release")
#		RMBpressed = false

func _ready():
	connect("gui_input", self, "_on_Button_gui_input")

func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				emit_signal("signal_LMB")
			BUTTON_RIGHT:
				emit_signal("signal_RMB_release")
				emit_signal("signal_RMB")


func disable():
	if !indialog and gui_controller.dialogue != null and gui_controller.dialogue.is_visible() || \
		gui_controller.inventory != null && gui_controller.inventory.is_visible() || \
		!input_handler.is_descendant_of_current_screen(self):
		return true
	return false


	# gui_controller.slavepanel != null && gui_controller.slavepanel.is_visible() || \
