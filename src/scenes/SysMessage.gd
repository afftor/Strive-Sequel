extends Control

onready var template = $VBoxContainer/Message
onready var container = $VBoxContainer

func show_message(text, time = 4):
	var message = template.duplicate()
	container.add_child(message)
	container.move_child(message, 1)
	message.get_node('Text').bbcode_text = '[center]%s[/center]' % tr(text)
	message.show()
	message.modulate.a = 1
	ResourceScripts.core_animations.FadeAnimation(message, 1, time)
	yield(get_tree().create_timer(time + 1), 'timeout')
	message.queue_free()
