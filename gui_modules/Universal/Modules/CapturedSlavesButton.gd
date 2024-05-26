extends TextureButton

	

func _ready():
	input_handler.connect("LocationSlavesUpdate", self, 'update')
	

func update():
	var value = input_handler.active_location.captured_characters.size()
	$Label.text = str(value)
	$Label.visible = int(value) > 0
