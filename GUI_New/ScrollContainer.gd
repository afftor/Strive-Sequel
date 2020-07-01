extends Control

var scroll_area
var hidden_scroll_bar
var v_scroll_bar
var mouse_entered = false


func _ready():
	scroll_area = $ScrollContainer.get_rect().size
	v_scroll_bar = $VScrollBar
	hidden_scroll_bar = $ScrollContainer.get_v_scrollbar()
	hidden_scroll_bar.self_modulate = Color(0, 0, 0, 0)
	v_scroll_bar.connect("value_changed", self, "scroll")
	v_scroll_bar.connect("mouse_entered", self, "set_entered", [true])
	v_scroll_bar.connect("mouse_exited", self, "set_entered", [false])
	hidden_scroll_bar.connect("value_changed", self, "position_grabber")


func scroll(value):
	v_scroll_bar.max_value = (hidden_scroll_bar.max_value - scroll_area.y)
	hidden_scroll_bar.value = value


func position_grabber(value):
	if mouse_entered:
		return
	v_scroll_bar.max_value = (hidden_scroll_bar.max_value - scroll_area.y)
	v_scroll_bar.value = value


func set_entered(is_entered):
	mouse_entered = is_entered
