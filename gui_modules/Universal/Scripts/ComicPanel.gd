extends Control


func _ready():
	pass # Replace with function body.


func reset():
	visible = true
	input_handler.ClearContainer(self, ['Frame', 'Text', 'NextButton', 'Label'])
	$Text.bbcode_text = ""


func show_frame(path, position, size, delay = 1.0):
	var new_frame = input_handler.DuplicateContainerTemplate(self, 'Frame')
	new_frame.rect_position = position
	new_frame.rect_size = size
	new_frame.texture = load(path)
	ResourceScripts.core_animations.UnfadeAnimation(new_frame, delay)
#	ResourceScripts.core_animations.UnfadeAnimation(new_frame, 0.2)


func show_text(text):
	$Text.bbcode_text = text

#2add more commands
