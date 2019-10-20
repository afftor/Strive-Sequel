extends Panel

var parentnode
var shutoff = false
var prevnode

var character = Reference

func _process(delta):
	if parentnode != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()

func _init():
	set_process(false)


func showup(node, text):
	parentnode = node
	if shutoff == true && prevnode == parentnode:
		return
	if parentnode.is_connected("tree_exiting", self, "turnoff") == false:
		parentnode.connect("tree_exiting", self, "turnoff")
	show()
	set_process(true)
	
	$RichTextLabel.rect_size.y = 10
	$RichTextLabel.bbcode_text = globals.TextEncoder(text)
	
	yield(get_tree(), 'idle_frame')
	
	rect_size.y = $RichTextLabel.get_v_scroll().get_max() + 50
	$RichTextLabel.rect_size.y = rect_size.y
	
	
	
	var pos = node.get_global_rect()
	pos = Vector2(pos.position.x, pos.end.y + 10)
	set_global_position(pos)
	var screen = get_viewport().get_visible_rect()
	if get_rect().end.x >= screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y >= screen.size.y:
		rect_global_position.y = node.get_global_rect().position.y - (get_rect().size.y+10)
	prevnode = parentnode

func turnoff():
	set_process(false)