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
	
	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	#The scrollbar maximum keeps the label's previous viewport height in its range. Using
	#it here made short tooltips (notably gold) inherit a very tall black background.
	var screen = get_viewport().get_visible_rect()
	var content_height = ceil($RichTextLabel.get_content_height())
	var tooltip_height = clamp(content_height + pos_fix, 48, max(screen.size.y - 20, 48))
	rect_size.y = tooltip_height
	$Panel.rect_size.y = tooltip_height
	$RichTextLabel.rect_size.y = tooltip_height - pos_fix + 2
	
	var pos = input_handler.get_real_global_rect(parentnode, true)
	if move_right:
		pos = Vector2(pos.end.x + 10, pos.position.y)
	else:
		pos = Vector2(pos.position.x, pos.end.y + 10)
		if pos.y + rect_size.y > screen.end.y:
			pos.y = input_handler.get_real_global_rect(parentnode, true).position.y - rect_size.y - 10
	var max_x = max(screen.position.x, screen.end.x - rect_size.x)
	var max_y = max(screen.position.y, screen.end.y - rect_size.y)
	pos.x = clamp(pos.x, screen.position.x, max_x)
	pos.y = clamp(pos.y, screen.position.y, max_y)
	set_global_position(pos)
	emit_signal("update_completed")

