extends Panel
# warning-ignore-all:return_value_discarded

func _ready():
	$Button.connect("pressed",self,'hide')

func open(text, buttonname = 'Confirm'):
	show()
	$RichTextLabel.bbcode_text = text
	$Button.text = buttonname

