tool
extends Node2D
class_name TransformConstraint
 
export var targets = [] setget _set_targets, _get_targets
export var enabled : bool = false setget _set_enabled, _get_enabled
export var scale_rate_x :float= 1.0
export var scale_rate_y :float= 1.0
export var rotation_rate :float = 1.0
export var position_rate_x :float= 1.0
export var position_rate_y :float= 1.0
 
var bound_targets = []
var t_origin
var flag := true
 
func _set_targets(v):
	targets = v
	if enabled:
		set_bound_targets()
 
func _get_targets():
	return targets
 
func _set_enabled(v):
	enabled = v
	if enabled:
		set_bound_targets()
		t_origin = global_transform
 
func _get_enabled():
	return enabled
 
func set_bound_targets():
	if targets == null or targets.size() == 0:
		return
	bound_targets = []
	for target in targets:
		if target == null:
			continue
		bound_targets.append(target)
 
func _process(delta):
	if global_transform == t_origin or targets == null or targets.size() == 0:
		return
	var t = Transform2D.IDENTITY
	var gt = global_transform
	#scale
	if scale_rate_x or scale_rate_y !=0.0:
		t.x *= global_scale.x * scale_rate_x
		t.y *= global_scale.y * scale_rate_y
	#rotation
	t = t.rotated(atan2(gt.x.y,gt.x.x) * rotation_rate) #could use global_rotation
	for node in bound_targets:
		if is_instance_valid(get_node(node)) == false:
			continue
		t.origin = get_node(node).transform.origin
		get_node(node).global_transform = t
 
		# position
		if flag:
			get_node(node).global_position-=global_position-position
		var diff = global_transform.origin - t_origin.origin
		diff.x *= position_rate_x
		diff.y *= position_rate_y
		get_node(node).translate(diff)
	flag= false
	t_origin = global_transform
 
