extends Panel



func _ready():
	$CloseButton.connect("pressed", self, "hide")

