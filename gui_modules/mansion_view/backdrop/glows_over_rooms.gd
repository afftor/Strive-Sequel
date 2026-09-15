extends Control
#The lanterns' glows and the sun shafts, drawn over the rooms. A lantern's Glow is a sprite in the backdrop scene, and
#the backdrop lies under every room on the plan, so a glow beside a room was cut off by the room's
#card. This comes after the plan in GridViewport and draws each glow the backdrop hands over - the
#floor on screen's, see mansion_backdrop.draw_glows_over_rooms() - where its sprite is and in the
#colour the sprite has there, with the sprites' own additive material. The panels over the plan
#still come after it, so no glow shows through a panel, and the viewport clips it like the plan.

var grid = null
var backdrop = null


func _ready():
	grid = get_node_or_null("../FloorGrid")
	backdrop = null if grid == null else grid.get_node_or_null("Backdrops")
	if backdrop == null or !backdrop.has_method("draw_glows_over_rooms"):
		visible = false
		set_process(false)
		return
	backdrop.draw_glows_over_rooms(true)


func _process(_delta):
	visible = backdrop.is_visible_in_tree() and (backdrop.lamp_level > 0.001 or backdrop.sky_shows())
	if visible:
		update()


func _draw():
	if backdrop == null:
		return
	var here = get_global_transform().affine_inverse()
	var top = grid.get_parent()
	for lamp in backdrop.lamps:
		if !is_instance_valid(lamp) or !lamp.glow_elsewhere or lamp.glow == null or lamp.glow.texture == null:
			continue
		if lamp.level <= 0.001 or !lamp.is_visible_in_tree():
			continue
		var glow = lamp.glow
		#the colour the sprite would be drawn in: its own, under every modulate between it and the plan
		var colour = glow.self_modulate * glow.modulate
		var walk = glow.get_parent()
		while walk != null and walk != top:
			if walk is CanvasItem:
				colour *= walk.modulate
			walk = walk.get_parent()
		var corner = glow.offset
		if glow.centered:
			corner -= glow.texture.get_size() / 2
		draw_set_transform_matrix(here * glow.get_global_transform())
		draw_texture(glow.texture, corner, colour)
	#the sun shafts over everything, glows included
	for sky in backdrop.skies:
		if !is_instance_valid(sky) or !sky.drawn_elsewhere or !sky.shows():
			continue
		var tone = sky.self_modulate * sky.modulate
		var up = sky.get_parent()
		while up != null and up != top:
			if up is CanvasItem:
				tone *= up.modulate
			up = up.get_parent()
		draw_set_transform_matrix(here * sky.get_global_transform())
		sky.draw_beams(self, tone)
	draw_set_transform_matrix(Transform2D())
