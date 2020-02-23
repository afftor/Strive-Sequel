extends PopupPanel

var parentnode
var shutoff = false
var prevnode

func _process(delta):
	if parentnode != null && ( parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()

func _init():
	set_process(false)
#warning-ignore:return_value_discarded
	connect("popup_hide", self, 'cooldown')

func showup(node, text):
	parentnode = node
	if shutoff == true && prevnode == parentnode:
		return
	popup()
	set_process(true)
	$RichTextLabel.bbcode_text = text
	yield(get_tree(), "idle_frame")
	$RichTextLabel.rect_size.y = $RichTextLabel.get_v_scroll().get_max()
	rect_size.y = $RichTextLabel.rect_size.y + 70
	
	var screen = get_viewport().get_visible_rect()
	if get_rect().end.x >= screen.size.x:
		rect_global_position.x -= get_rect().end.x - screen.size.x
	if get_rect().end.y >= screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y
	
	prevnode = parentnode



func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false
