extends Button
#One portrait in the top strip. It hands its person over and nothing else - everything that
#can be done with them is done where they are put down, whether they were dragged there or
#carried there by a second click.

#the same yellow a picked-up room wears in rearrange mode
const COLOR_PICKED = Color(1.5, 1.4, 0.8)

var view = null
var char_id = null


func setup(view_node, character):
	view = view_node
	char_id = character
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	refresh()


func is_picked():
	return char_id != null and view.picked_char == char_id


#The click alternative to dragging: this lifts them, the next click on a place puts them
#there, and clicking them again sets them back down where they were.
func on_pressed():
	if is_picked():
		view.clear_char_pick()
		return
	view.pick_character(char_id, null, view.mode)


func refresh():
	modulate = COLOR_PICKED if is_picked() else Color(1, 1, 1, 1)
	var person = view.get_character(char_id)
	if person == null:
		$icon.texture = null
		$name.text = ""
		return
	$icon.texture = person.get_icon()
	if $icon.texture == null:
		$icon.texture = person.get_class_icon()
	#portraits are rendered a few frames late, so ask and let the next rebuild pick it up
	input_handler.queue_portrait(person)
	$name.text = person.get_short_name()
	globals.connecttexttooltip(self, build_tooltip(person), true)


func build_tooltip(person):
	var text = person.get_short_name()
	if view.mode == 'sleep':
		text += "\n" + tr("MANSIONVIEW_NOBEDHINT")
	elif !person.is_worker():
		text += "\n" + tr("MANSIONVIEW_ERR_NOTWORKER")
	text += "\n" + tr("MANSIONVIEW_PUTBACKHINT" if is_picked() else "MANSIONVIEW_PICKHINT")
	return text


func get_drag_data(_position):
	if char_id == null:
		return null
	var preview = TextureRect.new()
	preview.texture = $icon.texture
	preview.expand = true
	preview.rect_size = Vector2(64, 64)
	set_drag_preview(preview)
	return {kind = 'mansion_char', char_id = char_id, from_slot = null, from_kind = view.mode}
