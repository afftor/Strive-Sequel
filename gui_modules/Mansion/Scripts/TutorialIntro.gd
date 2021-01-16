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
	yield(get_tree().create_timer(1), "timeout")
	if enabled:
		input_handler.ActivateTutorial("introduction")
	gui_controller.windows_opened.erase(self)
	ResourceScripts.game_progress.intro_tutorial_seen = true


