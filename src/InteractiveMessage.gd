extends Panel

func open(scene):
	show()
	$RichTextLabel.bbcode_text = scene.text
	globals.ClearContainer($VBoxContainer)
	for i in scene.options:
		var newbutton = globals.DuplicateContainerTemplate($VBoxContainer)
		newbutton.text = i.text
		newbutton.connect("pressed", self, i.code)
		if i.has('disabled') && i.disabled == true:
			newbutton.disabled = true

func close():
	hide()

func repeat():
	#close()
	input_handler.repeat_social_skill()
	input_handler.slave_panel_node.open(null)