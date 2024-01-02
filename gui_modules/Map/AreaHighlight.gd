extends Polygon2D

export var HighlightColor:Color setget highlight_set
var code

# Called when the node enters the scene tree for the first time.
func _ready():
	code = name
	$Area2D.connect("mouse_entered", self, 'Light')
	$Area2D.connect("mouse_exited", self, 'UnLight')
	UnLight()

#those two can be adjusted to add more visuals to highlighting
func Light():
	highlight(HighlightColor)


func UnLight():
	highlight(Color(0,0,0,0))


func highlight(modulate_color):
	modulate = modulate_color


tool func highlight_set(value):
	HighlightColor = value
	highlight(value)
