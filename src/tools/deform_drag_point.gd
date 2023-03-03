tool
extends Position2D
class_name DeformDragPoint

export var anchor := Vector2(0,0)
export var lock_anchor_position:bool setget set_lock_anchor



func _ready():
	pass # Replace with function body.


func set_lock_anchor(value):
	lock_anchor_position = value
	if value:
		anchor = position


func get_deform():
	if lock_anchor_position:
		return position - anchor
	else:
		return Vector2(0, 0)


var old_range
var old_deform
func _process(delta):
	var change = false
	if old_deform != get_deform():
		change = true
		old_deform = get_deform()
	if old_range != gizmo_extents:
		change = true
		old_range = gizmo_extents
	if change:
		print('call_updating')
		get_parent().update_shader() 
	else:
		return 
	

#func set_position(value):
#	position = value
#	if lock_anchor_position:
#		
#		
#
#
#func set_gizmo_extents(value):
#	gizmo_extents = value
#	if lock_anchor_position:
#		get_parent().update_shader()
