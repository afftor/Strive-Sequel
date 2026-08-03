extends Control

var last_frame

func _ready():
	pass # Replace with function body.


func reset():
	visible = true
	last_frame = null
	input_handler.ClearContainer(self, ['Frame', 'Text', 'NextButton', 'Label'])
	$Text.bbcode_text = ""


func show_frame(path, position, size, delay = 1.0):
	var new_frame = input_handler.DuplicateContainerTemplate(self, 'Frame')
	new_frame.modulate.a = 0.0
	new_frame.rect_position = position
	new_frame.rect_size = size
	new_frame.texture = load(path)
	ResourceScripts.core_animations.UnfadeAnimation(new_frame, delay)
#	ResourceScripts.core_animations.UnfadeAnimation(new_frame, 0.2)
	last_frame = new_frame


func show_text(text):
	$Text.bbcode_text = text

func shake_last_frame(time = 0.5):
	ResourceScripts.core_animations.ShakeAnimation(last_frame, time)

func shake_screen(time = 0.5):
	ResourceScripts.core_animations.ShakeAnimation(self, time)

#2add more commands
