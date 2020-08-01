extends Panel
#warning-ignore-all:return_value_discarded

func _ready():
	show()
	$Panel/Accept.connect("pressed",self,"Accept")
	$Panel/Quit.connect("pressed",self, "Quit")

func Accept():
	hide()
	input_handler.SetMusic("intro")
	input_handler.globalsettings.warnseen = true

func Quit():
	get_parent().quit()
