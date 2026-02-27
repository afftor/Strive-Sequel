extends Control


#expects dict from achievements_data.gd with loaded icon
func set_opened(data):
	$bg_opened.show()
	$bg_closed.hide()
	$name.text = tr(data.name)
	$name.show()
	$points.text = "+%s" % data.points
	$points.show()
	$desc.text = tr(data.description)
	$icon.texture = data.icon

func set_locked(data):
	$desc.text = tr(data.hint)
#	$bg_opened.hide()
#	$bg_closed.show()
#	$name.hide()
#	$points.hide()
#	$icon.texture = load("res://assets/Textures_v2/CHAR_INFO/bubble_charinfo.png")
