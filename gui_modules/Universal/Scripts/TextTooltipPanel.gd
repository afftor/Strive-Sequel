extends tooltip_main

var Panel_x = 598
var Text_x = 565
var pos_fix = 26

var move_right = false


func showup(node, text, move_right = false):
#	if parentnode.is_connected("tree_exiting", self, "turnoff") == false:
#		parentnode.connect("tree_exiting", self, "turnoff")
	if _setup(node):
		$RichTextLabel.bbcode_text = globals.TextEncoder(text)
		self.move_right = move_right


func update():
	$RichTextLabel.rect_size.y = 10
	$RichTextLabel.rect_position.x = 15
	$RichTextLabel.rect_position.y = 12
	
	pos_fix = 26
	if $RichTextLabel.bbcode_text.length() < 12:
		$RichTextLabel.rect_position.x = 8
		$RichTextLabel.rect_size.x = Text_x/3.5
		self.rect_size.x = Panel_x/3.5
		$Panel.rect_size.x = Panel_x/3.5
		$RichTextLabel.bbcode_text = '[center]'+$RichTextLabel.bbcode_text+'[/center]'
	elif $RichTextLabel.bbcode_text.length() < 30:
		$RichTextLabel.rect_size.x = Text_x/2
		self.rect_size.x = Panel_x/2
		$Panel.rect_size.x = Panel_x/2
		$RichTextLabel.bbcode_text = '[center]'+$RichTextLabel.bbcode_text+'[/center]'
	elif $RichTextLabel.bbcode_text.length() < 50:
		$RichTextLabel.rect_size.x = Text_x/1.20
		$Panel.rect_size.x = Panel_x/1.20
		self.rect_size.x = Panel_x/1.20
		$RichTextLabel.bbcode_text = '[center]'+$RichTextLabel.bbcode_text+'[/center]'
	else:
		$RichTextLabel.rect_size.x = Text_x
		self.rect_size.x = Panel_x
		$Panel.rect_size.x = Panel_x
	yield(get_tree(), 'idle_frame')
	
	rect_size.y = $RichTextLabel.get_v_scroll().get_max() + pos_fix
	$Panel.rect_size.y = $RichTextLabel.get_v_scroll().get_max() + pos_fix
	$RichTextLabel.rect_size.y = rect_size.y
	
	var pos = input_handler.get_real_global_rect(parentnode, true)
	
	var screen = get_viewport().get_visible_rect()
	if move_right:
		pos = Vector2(pos.end.x + 10, pos.position.y)
		set_global_position(pos)
	else:
		pos = Vector2(pos.position.x, pos.end.y + 10)
		set_global_position(pos)
		if get_rect().end.x >= screen.size.x:
			rect_global_position.x -= get_rect().end.x - screen.size.x
		if get_rect().end.y >= screen.size.y:
			rect_global_position.y = parentnode.get_global_rect().position.y - (get_rect().size.y+10)
		if get_rect().position.y < 0:
			if gui_controller.current_screen == gui_controller.mansion:
				rect_global_position.y = screen.size.y - get_rect().size.y
				rect_global_position.x -= 485
			else:
				rect_global_position.y = 0
				rect_global_position.x -= get_rect().end.x - get_rect().size.x - 350
	emit_signal("update_completed")

