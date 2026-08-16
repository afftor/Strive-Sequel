extends Control

onready var next_btn = $panel/Label/Panel/next
onready var next_frame = $panel/Label/Panel/next_frame
onready var curtain1 = $highlight/highlight1
onready var curtain2 = $highlight/highlight2
onready var curtain3 = $highlight/highlight3
onready var curtain4 = $highlight/highlight4
var additinal_borders = []
var next_pulse_tween
#the frame hugs the text; the button gets its own strip under it so the two never overlap
const PANEL_BOTTOM_PADDING = 20
const PANEL_BOTTOM_PADDING_WITH_NEXT = 62

func _ready():
	input_handler.register_btn_source("tut_panel_next", self, "get_next_btn")
	input_handler.register_btn_source("tut_full_screen", self, "get_full_screen")
	next_pulse_tween = Tween.new()
	add_child(next_pulse_tween)


func get_next_btn():
	return next_btn
func get_full_screen():
	return self

func show_tut(txt, pos):
	$panel/Label.bbcode_text = globals.TextEncoder(txt)
	$panel.rect_global_position = clamp_panel_pos(pos)
	raise()
	$panel.show()
	show()

#panel_pos is the panel's top left corner and the frame adds 20px around it, so a step
#that aims at the right half of the screen would otherwise run past the edge
func clamp_panel_pos(pos):
	var view = get_viewport_rect().size
	var width = $panel.rect_size.x + 40
	#fit_content_height only updates rect_size next layout pass, so ask the text itself
	var text_height = $panel/Label.rect_size.y
	if $panel/Label.has_method("get_content_height"):
		text_height = max(text_height, $panel/Label.get_content_height())
	var height = max(text_height, $panel.rect_size.y) + 40 + PANEL_BOTTOM_PADDING_WITH_NEXT
	pos.x = clamp(pos.x, 24, max(24, view.x - width))
	pos.y = clamp(pos.y, 24, max(24, view.y - height))
	return pos

func hide_text():
	$panel.hide()

func highlight_rects(list):
	clear_extra_borders()
	next_frame.hide()
	$highlight/borders.show()
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

func clear_extra_borders():
	if additinal_borders.empty():
		return
	for frame in additinal_borders:
		frame.queue_free()
	additinal_borders.clear()

#the panel's own button sits above the curtain layer, so its frame is a node inside the panel
func highlight_next_btn(rect):
	clear_extra_borders()
	rect.position -= Vector2(15, 15)
	rect.size += Vector2(30, 30)
	curtain_on(rect)
	$highlight/borders.hide()
	$highlight.show()
	next_frame.show()

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
	next_frame.hide()

#steps without a game button wait on this one, so it pulses to read as the thing to click
func next_btn_on():
	$panel/Label/Panel.margin_bottom = PANEL_BOTTOM_PADDING_WITH_NEXT
	next_btn.show()
	next_pulse_tween.stop_all()
	next_pulse_tween.remove_all()
	next_btn.self_modulate = Color.white
	next_pulse_tween.interpolate_property(next_btn, "self_modulate",
		Color.white, Color(1.0, 0.75, 0.2, 1.0), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	next_pulse_tween.interpolate_property(next_btn, "self_modulate",
		Color(1.0, 0.75, 0.2, 1.0), Color.white, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.5)
	next_pulse_tween.repeat = true
	next_pulse_tween.start()

func next_btn_off():
	$panel/Label/Panel.margin_bottom = PANEL_BOTTOM_PADDING
	next_pulse_tween.stop_all()
	next_pulse_tween.remove_all()
	next_btn.self_modulate = Color.white
	next_btn.hide()
	next_frame.hide()
