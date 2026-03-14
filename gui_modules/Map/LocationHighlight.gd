extends Polygon2D

export var HighlightColor:Color setget highlight_set
export var area :String
var code

onready var controller = get_parent().get_parent()
var mouse_in_me = false
var gray_shader = load("res://assets/gray_shader.tres")

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

func get_area():
	return area

#those two can be adjusted to add more visuals to highlighting
func Light():
	if !controller.if_location_in_list(name):
		return
	#both conditions are seems obsolete. Delete with time (12.02.26)
#	if controller.loc_locked:
#		return
#	if controller.area_locked():
#		return
	controller.hovered_location = name
	highlight(HighlightColor)


func UnLight():
	if !controller.if_location_in_list(name):
		return
	#both conditions are seems obsolete. Delete with time (12.02.26)
#	if controller.loc_locked:
#		return
#	if controller.area_locked():
#		return
	if controller.hovered_location == name:
		controller.hovered_location = null
	highlight(Color(0,0,0,0))


func highlight(modulate_color):
	self_modulate = modulate_color


tool func highlight_set(value):
	HighlightColor = value
	highlight(value)

func check_gray():
	if !controller.if_location_in_list(name):
		get_node("Sprite").material = gray_shader
	else:
		get_node("Sprite").material = null
