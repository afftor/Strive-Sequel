extends Panel

func _ready():
	show()
#warning-ignore:return_value_discarded
	$Accept.connect("pressed",self,"Accept")
#warning-ignore:return_value_discarded
	$Quit.connect("pressed",self, "Quit")

func Accept():
	hide()

func Quit():
	get_parent().quit()