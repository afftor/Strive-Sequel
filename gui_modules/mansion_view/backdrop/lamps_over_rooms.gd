extends Control
#Draw lamp bodies above room art, below fog, glow and the interface.
#The original nodes retain their transforms and floor lighting configuration.

var backdrop = null
var bodies = []


func _ready():
	backdrop = get_node_or_null('../FloorGrid/Backdrops')
	if backdrop == null:
		set_process(false)
		return
	for lamp in backdrop.lamps:
		for child in lamp.get_children():
			if child is Sprite and child != lamp.glow:
				bodies.append({lamp = lamp, sprite = child, was_visible = child.visible})


func _process(_delta):
	for entry in bodies:
		if is_instance_valid(entry.sprite) and is_instance_valid(entry.lamp):
			entry.sprite.visible = entry.was_visible and !entry.lamp.glow_elsewhere
	update()


func _draw():
	if backdrop == null:
		return
	var here = get_global_transform().affine_inverse()
	var top = get_parent()
	for entry in bodies:
		var lamp = entry.lamp
		var sprite = entry.sprite
		if !is_instance_valid(lamp) or !is_instance_valid(sprite):
			continue
		if !entry.was_visible or !lamp.glow_elsewhere or !lamp.is_visible_in_tree() or sprite.texture == null:
			continue
		var colour = sprite.self_modulate * sprite.modulate
		var ancestor = sprite.get_parent()
		while ancestor != null and ancestor != top:
			if ancestor is CanvasItem:
				colour *= ancestor.modulate
			ancestor = ancestor.get_parent()
		draw_set_transform_matrix(here * sprite.get_global_transform())
		var rect = sprite.get_rect()
		if sprite.flip_h:
			rect.size.x = -rect.size.x
		if sprite.flip_v:
			rect.size.y = -rect.size.y
		draw_texture_rect(sprite.texture, rect, false, colour)
	draw_set_transform_matrix(Transform2D())


func _exit_tree():
	for entry in bodies:
		if is_instance_valid(entry.sprite):
			entry.sprite.visible = entry.was_visible
