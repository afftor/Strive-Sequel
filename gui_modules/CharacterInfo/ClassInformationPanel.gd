extends Panel


#currently this is not required at all - due to similar effect of this closebutton and main charinfo's
func _ready():
	gui_controller.add_close_button_simple(self)


func open(classcode, person):
	rect_size.y = 10
	$scroll._open_panel(person, classcode)
