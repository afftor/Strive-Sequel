extends Control

onready var template = $VBoxContainer/Message
onready var container = $VBoxContainer

func show_message(text, time = 4):
	#Spoken to before it is in the tree - a load, or anything else that runs before the screen
	#exists - there is nothing here to copy. The message is not worth a crash, and the callers
	#that matter write it to a log of their own as well.
	if template == null or container == null:
		print_debug("SysMessage spoken to before it was ready: %s" % text)
		return
	var message = template.duplicate()
	container.add_child(message)
	container.move_child(message, 1)
	message.get_node('Margin/Text').bbcode_text = '[center]%s[/center]' % tr(text)
	message.show()
	message.modulate.a = 1
	ResourceScripts.core_animations.FadeAnimation(message, 1, time)
	yield(get_tree().create_timer(time + 1), 'timeout')
	message.queue_free()
