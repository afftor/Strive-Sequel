extends Panel
#warning-ignore-all:return_value_discarded

func _ready():
	show()
	$Accept.connect("pressed",self,"Accept")
	$Quit.connect("pressed",self, "Quit")

func Accept():
	hide()
	input_handler.SetMusic("intro")
	input_handler.globalsettings.warnseen = true

func Quit():
	get_parent().quit()