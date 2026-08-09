extends Control

#Invisible hover/click area shaped like the breasts that are currently shown.
#It is a direct child of the ragdoll node, so after a rebuild its local space
#matches the pixels of the ragdoll viewport one to one.

onready var ragdoll = get_parent()


func has_point(point):
	if ragdoll == null or !ragdoll.tits_interaction:
		return false
	var mesh = ragdoll.get_tits_mesh()
	if mesh == null:
		return false
	var outline = ragdoll.get_tits_outline()
	if outline.size() < 3:
		return false
	var local = mesh.get_global_transform().affine_inverse().xform(point) - mesh.offset
	return Geometry.is_point_in_polygon(local, outline)


func _gui_input(event):
	if !(event is InputEventMouseButton):
		return
	if !event.pressed or event.button_index != BUTTON_LEFT:
		return
	ragdoll.jiggle_tits()
	accept_event()
