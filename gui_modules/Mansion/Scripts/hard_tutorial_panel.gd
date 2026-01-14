extends Control

onready var next_btn = $panel/Label/Panel/next
onready var curtain1 = $highlight/highlight1
onready var curtain2 = $highlight/highlight2
onready var curtain3 = $highlight/highlight3
onready var curtain4 = $highlight/highlight4
onready var abort_yes_btn = $abort_panel/RichTextLabel/TextureRect/ButtonL
onready var abort_no_btn = $abort_panel/RichTextLabel/TextureRect/ButtonR
var additinal_borders = []

func _ready():
	input_handler.register_btn_source("tut_panel_next", self, "get_next_btn")
	input_handler.register_btn_source("tut_full_screen", self, "get_full_screen")
	input_handler.register_btn_source("abort_yes", self, "get_abort_yes")
	input_handler.register_btn_source("abort_no", self, "get_abort_no")

func get_next_btn():
	return next_btn
func get_full_screen():
	return self
func get_abort_yes():
	return abort_yes_btn
func get_abort_no():
	return abort_no_btn

func connect_btns(parent):
	abort_yes_btn.connect("pressed", parent, "abort_tutorial_confirm")
	abort_no_btn.connect("pressed", parent, "withdraw_abort")

func show_tut(txt, pos):
	$panel/Label.bbcode_text = txt
	$panel.rect_global_position = pos
	raise()
	$panel.show()
	show()

func hide_text():
	$panel.hide()

func highlight_rects(list):
	if !additinal_borders.empty():
		for frame in additinal_borders:
			frame.queue_free()
		additinal_borders.clear()
	for i in range(list.size()):
		var rect = list[i]
		rect.position.x -= 15
		rect.position.y -= 15
		rect.size.x += 30
		rect.size.y += 30
		if i == 0:
			if list.size() == 1:
				curtain_on(rect)
			else:
				curtain_off()
			set_frame($highlight/borders, rect)
		else:
			var new_frame = $highlight/borders.duplicate()
			$highlight.add_child(new_frame)
			additinal_borders.append(new_frame)
			set_frame(new_frame, rect)
	$highlight.show()

func curtain_off():
	curtain1.hide()
	curtain2.hide()
	curtain3.hide()
	curtain4.hide()

func curtain_on(rect):
	curtain1.show()
	curtain2.show()
	curtain3.show()
	curtain4.show()
	curtain1.rect_size.x = rect.position.x
	curtain2.rect_global_position.x = rect.end.x
	curtain2.rect_size.x = 1920 - rect.end.x
	curtain3.rect_global_position.x = rect.position.x
	curtain3.rect_global_position.y = rect.end.y
	curtain3.rect_size.x = rect.size.x
	curtain3.rect_size.y = 1080 - rect.position.y
	curtain4.rect_global_position.x = rect.position.x
	curtain4.rect_size.x = rect.size.x
	curtain4.rect_size.y = rect.position.y

func set_frame(frame_node, rect):
	frame_node.rect_global_position = rect.position
	frame_node.rect_size = rect.size

func highlight_off():
	$highlight.hide()

func next_btn_on():
	next_btn.show()

func next_btn_off():
	next_btn.hide()

func ask_abort():
	raise()
	$abort_panel.popup()

func hide_abort():
	$abort_panel.hide()

func is_in_abort():
	return $abort_panel.visible
