extends MenuButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = tr("TESTNAMELOCALIZATION")
	get_popup().add_item("EN")
	get_popup().add_item("DE")
	
	get_popup().connect("id_pressed",self,"_on_item_pressed")
	
	print(input_handler.globalsettings.ActiveLocalization)
	pass # Replace with function body.

func _on_item_pressed(id):
	
	name = tr("TESTNAMELOCALIZATION")
	
	var name = get_popup().get_item_text(id)
	
	input_handler.globalsettings.ActiveLocalization = name.to_lower()
	input_handler.settings_save(input_handler.globalsettings)
	print(name)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
