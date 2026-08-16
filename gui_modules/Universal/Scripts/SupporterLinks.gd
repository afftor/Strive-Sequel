extends Panel

# Small chooser shown instead of jumping straight to one site: the supporter code is
# posted on every platform, so the player picks the one they support the game on.
# Button names double as input_handler.open_shell codes (see the 'Code' suffix there).

func _ready():
	hide()
	for button in $MarginContainer/VBoxContainer/Buttons.get_children():
		button.connect("pressed", self, "open_link", [button.name])
	get_node("CloseButton").connect("pressed", self, "hide")


func open():
	show()
	raise()


func open_link(platform):
	input_handler.open_shell(platform + 'Code')
	hide()
