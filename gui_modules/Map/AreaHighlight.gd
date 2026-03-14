extends Polygon2D

export var HighlightColor:Color setget highlight_set
var code

onready var controller = get_parent().get_parent()
var mouse_in_me = false

# Called when the node enters the scene tree for the first time.
func _ready():
	code = name
	$Area2D.connect("mouse_entered", self, 'Light')
	$Area2D.connect("mouse_exited", self, 'UnLight')
	UnLight()

func custom_input(event):
	if !(event is InputEventMouseMotion):
		return
	var this_mouse_in_me = false
	var owners = $Area2D.get_shape_owners()
	for owner_id in owners:
		if this_mouse_in_me:
			break
		var obj = $Area2D.shape_owner_get_owner(owner_id)
		this_mouse_in_me = Geometry.is_point_in_polygon(obj.to_local(event.global_position), obj.polygon)
	set_mouse_in_me(this_mouse_in_me)

func set_mouse_in_me(value):
	if !mouse_in_me and value:
		$Area2D.emit_signal("mouse_entered")
	elif mouse_in_me and !value:
		$Area2D.emit_signal("mouse_exited")
	mouse_in_me = value

#those two can be adjusted to add more visuals to highlighting
func Light():
	#_hovered_area and selected_area condition seems obsolete. Delete with time (12.02.26)
#	controller._hovered_area = name
	if !ResourceScripts.game_world.is_area_unlocked(name):
		return
#	if controller.selected_area != null:
#		return
	controller.hovered_area = name
	highlight(HighlightColor)


func UnLight():
	#_hovered_area and selected_area condition seems obsolete. Delete with time (12.02.26)
#	if controller._hovered_area == name:
#		controller._hovered_area = null
	if !ResourceScripts.game_world.is_area_unlocked(name):
		return
#	if controller.selected_area != null:
#		return
	if controller.hovered_area == name:
		controller.hovered_area = null
	highlight(Color(0,0,0,0))


func highlight(modulate_color):
	modulate = modulate_color


tool func highlight_set(value):
	HighlightColor = value
	highlight(value)
