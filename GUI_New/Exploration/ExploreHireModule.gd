extends Panel


func _ready():
	pass # Replace with function body.


func hire():
	get_parent().hiremode = 'hire'
	show()
	$RichTextLabel.bbcode_text = ""
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	for i in get_parent().active_faction.slaves:
		var tchar = characters_pool.get_char_by_id(i)
		var newbutton = input_handler.DuplicateContainerTemplate(
			$ScrollContainer/VBoxContainer
		)
		newbutton.get_node("name").text = tchar.get_stat('name')
		newbutton.get_node("Price").text = str(tchar.calculate_price())
		#newbutton.connect('signal_RMB_release',input_handler,'ShowSlavePanel', [tchar])
		newbutton.connect("pressed", input_handler, 'ShowSlavePanel', [tchar])  #, self, "select_slave_in_guild", [tchar])
		newbutton.set_meta("person", tchar)
		globals.connectslavetooltip(newbutton, tchar)
