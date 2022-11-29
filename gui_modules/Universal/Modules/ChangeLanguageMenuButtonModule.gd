extends MenuButton


func _ready():
	text = tr("TESTNAMELOCALIZATION")
	get_popup().add_item("EN")
	
	get_popup().connect("id_pressed",self,"_on_item_pressed")

func _on_item_pressed(id):
	
	name = tr("TESTNAMELOCALIZATION")
	
	var name = get_popup().get_item_text(id)
	
	input_handler.globalsettings.ActiveLocalization = name.to_lower()
	input_handler.settings_save(input_handler.globalsettings)
