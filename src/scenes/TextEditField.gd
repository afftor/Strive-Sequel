extends "res://src/scenes/ClosingPanel.gd"

var target_node
var target_function
var check_function


#warning-ignore-all:return_value_discarded

func _ready():
	$ConfirmButton.connect("pressed", self, "confirm_text")
	connect("hide", self, 'disable_input')

func open(targetnode, targetfunction, initialtext, optional_description = '', checkfunction = null):
	show()
	input_handler.text_field_input = true
	$TextEdit.text = initialtext
	target_node = targetnode
	target_function = targetfunction
	check_function = checkfunction
	$RichTextLabel.bbcode_text = optional_description

func confirm_text():
	if check_function != null:
		if !target_node.call(check_function, $TextEdit.text):
			return
	target_node.call(target_function, $TextEdit.text)
	hide()

func disable_input():
	input_handler.text_field_input = false
