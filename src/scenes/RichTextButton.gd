extends Button

var txt = ""

func set_text(text):
	get_node("RichTextLabel").set_bbcode( "[center]%s[/center]" % text)
	txt = text
	
func get_text():
	return txt
