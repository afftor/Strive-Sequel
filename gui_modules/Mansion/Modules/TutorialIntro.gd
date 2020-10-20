extends Control


func _ready():
	$Enable.connect("pressed", self, "select_option", [true])
	$Dismiss.connect("pressed", self, "select_option", [false])

func select_option(enabled):
	ResourceScripts.game_progress.show_tutorial = enabled
	hide()
	var message = "Tutorials "
	if enabled:
		message += "enabled."
	else:
		message += "disabled."
	input_handler.SystemMessage(message)
	get_parent().emit_signal("tut_option_selected")


