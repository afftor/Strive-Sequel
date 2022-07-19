extends TextureProgress
class_name Progress3state 

export(Texture) var texture_1
export(Texture) var texture_2
export(Texture) var texture_3

func _ready():
	connect("value_changed", self, 'set_state')


func set_state(nval):
	value = nval
	var part = value / max_value
	if part < 0.33:
		texture_progress = texture_1
	elif part < 0.66:
		texture_progress = texture_2
	else:
		texture_progress = texture_3
	
	hint_tooltip = "%.1f" % value
#	hint_tooltip = "%.1f/%.1f" % [value, max_value]
#	print(hint_tooltip)

