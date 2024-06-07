extends TextureButton

	

func _ready():
	input_handler.connect("LocationSlavesUpdate", self, 'update')
	

func update():
	var dun_node = get_parent().get_parent().get_parent()
	if dun_node.active_location == null:
		return
	var value
	var loc = dun_node.active_location
	if !loc.has('captured_characters'):
		value = 0
	else:
		value = loc.captured_characters.size()
	$Label.text = str(value)
	$Label.visible = int(value) > 0
