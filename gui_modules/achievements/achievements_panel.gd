extends Control

func _ready():
	$CloseButton.connect("pressed", self, "hide")

func show():
	var achi_cont = $achi_cont
	var bonus_cont = $bonus_cont
	input_handler.ClearContainer(achi_cont, ["achi"])
	input_handler.ClearContainer(bonus_cont, ["bonus"])
	var dict = input_handler.achievements.get_unlocked_achimnts()
	for achi_name in dict:
		var new_panel = input_handler.DuplicateContainerTemplate(achi_cont, "achi")
		new_panel.set_opened(dict[achi_name])
	dict = input_handler.achievements.get_locked_achimnts()
	for achi_name in dict:
		var new_panel = input_handler.DuplicateContainerTemplate(achi_cont, "achi")
		new_panel.set_locked(dict[achi_name])
	dict = input_handler.achievements.get_unlocked_bonuses()
	for bonus_name in dict:
		var new_panel = input_handler.DuplicateContainerTemplate(bonus_cont, "bonus")
		new_panel.set_opened(dict[bonus_name])
	dict = input_handler.achievements.get_locked_bonuses()
	for bonus_name in dict:
		var new_panel = input_handler.DuplicateContainerTemplate(bonus_cont, "bonus")
		new_panel.set_locked(dict[bonus_name])
	
	.show()

