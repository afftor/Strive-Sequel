tool
extends AutoPoly
class_name DeformPoly


func _ready():
	material = load("res://assets/deform_shader_recolor.tres").duplicate()
	if get_child_count() == 0: 
		for i in range(6):
			var new_node = DeformDragPoint.new()
			add_child(new_node)
			new_node.set_owner(get_tree().get_edited_scene_root())


func update_shader():
	print("updating shader")
	for i in range(6):
		var nd:DeformDragPoint
		nd = get_child(i)
		if nd.lock_anchor_position:
			material.set_shader_param("anchor%d" % (i + 1), nd.anchor)
			material.set_shader_param("move%d" % (i + 1), nd.get_deform())
			material.set_shader_param("range%d" % (i + 1), nd.gizmo_extents)
#			print(nd.anchor)
#			print(nd.get_deform())
#			print(nd.gizmo_extents)
		else:
			material.set_shader_param("move%d" % (i + 1), nd.get_deform())
			material.set_shader_param("range%d" % (i + 1), 0)
