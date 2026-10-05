extends Button

const OPTION_ICONS = {
	continue = preload("res://assets/Textures_v2/QUEST_DIALOGUE/option_continue.png"),
	fight = preload("res://assets/Textures_v2/QUEST_DIALOGUE/option_fight.png"),
	close = preload("res://assets/Textures_v2/QUEST_DIALOGUE/option_close.png"),
}

var status setget status_set #disabled, seen, next_dialogue
var hotkey setget hotkey_set
var option_icon setget option_icon_set #continue, fight, close; only templates with an Icon node show it

func _ready():
	connect("mouse_entered", self, 'change_text_color', ['highlight'])
	connect("mouse_exited", self, 'change_text_color', ['normal'])

func hotkey_set(value):
	hotkey = value
	$Label.bbcode_text = str(value) + ". " + $Label.bbcode_text

func status_set(value):
	status = value
	change_text_color('normal')

func option_icon_set(value):
	option_icon = value
	var icon_node = get_node_or_null("Icon")
	if icon_node == null:
		return
	icon_node.texture = OPTION_ICONS.get(value)
	icon_node.visible = icon_node.texture != null

func change_text_color(event):
	var color
	if status == 'disabled':
		color = variables.hexcolordict.gray
	else:
		match event:
			'highlight':
				color = variables.hexcolordict.aqua
			'normal':
				if status == 'seen':
					color = variables.hexcolordict.gray_text_dialogue
				elif status == 'next_dialogue':
					color = variables.hexcolordict.yellow
				else:
					color = variables.hexcolordict.white
	if color == null:
		return
	$Label.set('custom_colors/default_color', color)
	var icon_node = get_node_or_null("Icon")
	if icon_node != null:
		icon_node.modulate = Color(color)
