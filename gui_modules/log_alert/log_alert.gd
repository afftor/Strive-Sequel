extends Control

onready var text_node :RichTextLabel = $Panel/RichTextLabel

func _ready():
	$Panel/close.connect("pressed", self, "hide")

func show_string(input_str :String):
	text_node.append_bbcode(input_str + "\n")
	show()
