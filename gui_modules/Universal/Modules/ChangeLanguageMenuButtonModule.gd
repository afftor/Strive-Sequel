extends MenuButton
var OkPanel

func _ready():
	
	for i in input_handler.TranslationData:
		get_popup().add_item(i)
		pass
	
	get_popup().connect("id_pressed",self,"_on_item_pressed")
	pass 

func _on_item_pressed(id):
	var name = get_popup().get_item_text(id)
	
	if name == input_handler.globalsettings.ActiveLocalization:
		return
	
	input_handler.globalsettings.ActiveLocalization = name.to_lower()
	input_handler.settings_save(input_handler.globalsettings)
	
	OkPanel.visible = true
	pass
