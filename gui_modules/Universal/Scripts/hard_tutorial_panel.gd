extends Control
#The tutorial's text and its red frame draw from a CanvasLayer of their own ($Top, layer 100)
#rather than from this Control. They have to: the mansion screen floats its room card on a
#CanvasLayer of layer 3 (gui_modules/mansion_view/mansion_view.tscn), and anything the game
#adds to the tree root loses to that at any non-negative layer - so a step pointing at the
#room card would have hidden its own instructions behind it.
#
#The root stays a Control because it is still the full-screen rect handed to steps that
#accept a click anywhere (see get_full_screen and the 'tut_full_screen' button). What it is
#no longer is the thing that hides the panel: a CanvasLayer breaks CanvasItem visibility
#inheritance, so hide() on this node leaves $Top's children on screen. close_panel() is what
#puts the tutorial away.

onready var top = $Top
onready var panel = $Top/panel
onready var highlight = $Top/highlight
onready var next_btn = $Top/panel/Label/Panel/next
onready var next_frame = $Top/panel/Label/Panel/next_frame
onready var curtain1 = $Top/highlight/highlight1
onready var curtain2 = $Top/highlight/highlight2
onready var curtain3 = $Top/highlight/highlight3
onready var curtain4 = $Top/highlight/highlight4
var additinal_borders = []
var next_pulse_tween
#What the frame is drawn around, so it can be measured again. A rectangle is only true for the
#frame it was taken in: the navigation bar gains a place and lays itself out again, a list
#scrolls, a panel is resized to fit its text. When that happened after a step began, the frame
#stayed where the button had been and pointed at whatever moved into that spot.
var framed_source = null
var framed_names = []
var framed_rects = []
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
	$Top/panel/Label.bbcode_text = globals.TextEncoder(txt)
	$Top/panel.rect_global_position = clamp_panel_pos(pos)
	raise()
	$Top/panel.show()
	show()


#Everything the tutorial draws, put away in one call. hide() on this node cannot do it - the
#panel and the frame hang off a CanvasLayer, which does not inherit visibility from here.
func close_panel():
	stop_following()
	hide()
	$Top/panel.hide()
	$Top/highlight.hide()
	next_frame.hide()

#panel_pos is the panel's top left corner and the frame adds 20px around it, so a step
#that aims at the right half of the screen would otherwise run past the edge
func clamp_panel_pos(pos):
	var view = get_viewport_rect().size
	var width = $Top/panel.rect_size.x + 40
	#fit_content_height only updates rect_size next layout pass, so ask the text itself
	var text_height = $Top/panel/Label.rect_size.y
	if $Top/panel/Label.has_method("get_content_height"):
		text_height = max(text_height, $Top/panel/Label.get_content_height())
	var height = max(text_height, $Top/panel.rect_size.y) + 40 + PANEL_BOTTOM_PADDING_WITH_NEXT
	pos.x = clamp(pos.x, 24, max(24, view.x - width))
	pos.y = clamp(pos.y, 24, max(24, view.y - height))
	return pos

func hide_text():
	$Top/panel.hide()

#Draw the frame around these rectangles, and keep watching where they came from. The caller
#hands over what it measured plus how to measure it again; without the second part the frame
#is a snapshot.
func follow_rects(source, names):
	framed_source = source
	framed_names = names
	framed_rects = []
	for name in names:
		framed_rects.append(source.get_true_rect(name))
	highlight_rects(framed_rects)


func stop_following():
	framed_source = null
	framed_names = []
	framed_rects = []


func _process(_delta):
	if framed_source == null or framed_names.empty() or !$Top/highlight.visible:
		return
	var now = []
	for name in framed_names:
		now.append(framed_source.get_true_rect(name))
	if now == framed_rects:
		return
	framed_rects = now
	highlight_rects(now)


func highlight_rects(list):
	clear_extra_borders()
	next_frame.hide()
	$Top/highlight/borders.show()
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
			set_frame($Top/highlight/borders, rect)
		else:
			var new_frame = $Top/highlight/borders.duplicate()
			$Top/highlight.add_child(new_frame)
			additinal_borders.append(new_frame)
			set_frame(new_frame, rect)
	$Top/highlight.show()

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
	$Top/highlight/borders.hide()
	$Top/highlight.show()
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
	stop_following()
	$Top/highlight.hide()
	next_frame.hide()

#steps without a game button wait on this one, so it pulses to read as the thing to click
func next_btn_on():
	$Top/panel/Label/Panel.margin_bottom = PANEL_BOTTOM_PADDING_WITH_NEXT
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
	$Top/panel/Label/Panel.margin_bottom = PANEL_BOTTOM_PADDING
	next_pulse_tween.stop_all()
	next_pulse_tween.remove_all()
	next_btn.self_modulate = Color.white
	next_btn.hide()
	next_frame.hide()
