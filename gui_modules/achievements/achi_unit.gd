extends Control

signal open_group(group_name)
var achi_name

#expects dict from achievements_data.gd with loaded icon
func set_opened(data):
	achi_name = data.id
	var tr_name = data.name
	var tr_desc = data.description
	if !data.has("no_tr") or !data.no_tr:
		tr_name = tr(tr_name)
		tr_desc = tr(tr_desc)
	$bg_opened.show()
	$bg_closed.hide()
	$name.text = tr_name
	$name.show()
	if data.has("points"):
		$points.text = "+%s" % data.points
		$points.show()
	$desc_panel/desc.text = tr_desc
	$icon.texture = data.icon

func set_locked(data):
	achi_name = data.id
	var tr_hint = data.hint
	if !data.has("no_tr") or !data.no_tr:
		tr_hint = tr(tr_hint)
	$desc_panel/desc.text = tr_hint
#	$bg_opened.hide()
#	$bg_closed.show()
#	$name.hide()
#	$points.hide()
#	$icon.texture = load("res://assets/Textures_v2/CHAR_INFO/bubble_charinfo.png")

func set_opened_group(data):
	set_opened(data)
#	$points.text = "%s/%s" % [data.points, data.max_points]
	add_group()

func set_locked_group(data):
	var temp_tex = $icon.texture
	set_opened_group(data)
	$bg_opened.hide()
	$bg_closed.show()
	$icon.texture = temp_tex

func add_group():
	$desc_panel/open_group.show()
	$desc_panel/open_group.connect("pressed", self, "emit_signal", ["open_group", achi_name])

func get_achi_name():
	return achi_name
