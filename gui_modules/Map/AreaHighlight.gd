extends Polygon2D

export var HighlightColor:Color setget highlight_set
var code

onready var controller = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	code = name
	$Area2D.connect("mouse_entered", self, 'Light')
	$Area2D.connect("mouse_exited", self, 'UnLight')
	UnLight()

#those two can be adjusted to add more visuals to highlighting
func Light():
	controller._hovered_area = name
	if !ResourceScripts.game_world.is_area_unlocked(name):
		return
	if controller.selected_area != null:
		return
	controller.hovered_area = name
	highlight(HighlightColor)


func UnLight():
	if controller._hovered_area == name:
		controller._hovered_area = null
	if !ResourceScripts.game_world.is_area_unlocked(name):
		return
	if controller.selected_area != null:
		return
	if controller.hovered_area == name:
		controller.hovered_area = null
	highlight(Color(0,0,0,0))


func highlight(modulate_color):
	modulate = modulate_color


tool func highlight_set(value):
	HighlightColor = value
	highlight(value)
