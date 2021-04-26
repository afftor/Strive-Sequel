extends Button

var status setget status_set #disabled, seen, next_dialogue
var hotkey setget hotkey_set

func _ready():
	connect("mouse_entered", self, 'change_text_color', ['highlight'])
	connect("mouse_exited", self, 'change_text_color', ['normal'])

func hotkey_set(value):
	hotkey = value
	$Label.bbcode_text = str(value) + ". " + $Label.bbcode_text

func status_set(value):
	status = value
	change_text_color('normal')

func change_text_color(event):
	if status == 'disabled':
		$Label.set('custom_colors/default_color', variables.hexcolordict.gray)
		return
	match event:
		'highlight':
			$Label.set('custom_colors/default_color', variables.hexcolordict.aqua)
		'normal':
			if status == 'seen':
				$Label.set('custom_colors/default_color', variables.hexcolordict.gray_text_dialogue)
			elif status == 'next_dialogue':
				$Label.set('custom_colors/default_color', variables.hexcolordict.yellow)
			else:
				$Label.set('custom_colors/default_color', variables.hexcolordict.white)
				
