extends "res://files/Close Panel Button/ClosingPanel.gd"

#i think, this variable should be in data as singleton
var queststext = {
	elves = {
		1 : "Search Eastern Forest for Elves",
		2 : "Report your discoveries to Flak"
		},
	demitrus = {
		1 : "Explore Caves with Dimitrus",
		},
	forge = {
		1 : "Upgrade Blacksmith Forge to unlock more recipes",
		},
	demofinish = {
		1 : "You have completed the demo!"
	}
	
}

func open():
	show()
	globals.ClearContainer($ScrollContainer/VBoxContainer)
	for i in state.activequests: #{code = name, stage = value}
		var newquest = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newquest.get_node("RichTextLabel").bbcode_text = queststext[i.code][int(i.stage)]
	if state.activequests.size() == 0:
		var newquest = globals.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
		newquest.get_node("RichTextLabel").bbcode_text = tr("NOACTIVEQUESTS")