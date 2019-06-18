extends Panel

var cheat_options = {
	
	
}

func _ready():
	for i in cheat_options:
		var newbutton = Button.new()
		$VBoxContainer.add_child(newbutton)
		newbutton.text = i.name
		newbutton.connect("pressed", self, i.function)


