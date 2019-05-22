extends "res://files/Close Panel Button/ClosingPanel.gd"

var target_node
var target_function


#warning-ignore-all:return_value_discarded

func _ready():
	$ConfirmButton.connect("pressed", self, "confirm_text")
	connect("hide", self, 'disable_input')

func open(targetnode, targetfunction, initialtext):
	show()
	input_handler.text_field_input = true
	$TextEdit.text = initialtext
	target_node = targetnode
	target_function = targetfunction

func confirm_text():
	target_node.call(target_function, $TextEdit.text)
	hide()

func disable_input():
	print(true)
	input_handler.text_field_input = false