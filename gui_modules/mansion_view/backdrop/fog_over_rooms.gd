extends ColorRect
#The backdrop's mist drawn over the rooms. The mist is a fog.gd node under mansion_backdrop.tscn's Sky and lies under
#every room on the plan like the rest of the backdrop, so this comes after the plan in GridViewport and draws it again
#over the rooms, with the mist's own material and where the mist lies; the mist hides itself meanwhile
#(mansion_backdrop.draw_fog_over_rooms). It comes before GlowsOverRooms, so the lanterns' glows and the sun shafts
#still shine through, and before the panels over the plan. Nothing about the look is set here.

var backdrop = null


func _ready():
	visible = false
	var grid = get_node_or_null("../FloorGrid")
	backdrop = null if grid == null else grid.get_node_or_null("Backdrops")
	if backdrop == null or !backdrop.has_method("draw_fog_over_rooms"):
		set_process(false)
		return
	backdrop.draw_fog_over_rooms(true)


func _process(_delta):
	var fog = backdrop.first_fog()
	visible = fog != null and backdrop.is_visible_in_tree() and fog.shows()
	if !visible:
		return
	if material != fog.material:
		material = fog.material
	#where the mist lies, in this node's parent's space: the grid's zoom and pan, and the backdrop's place under them
	var place = get_parent().get_global_transform().affine_inverse() * fog.get_global_transform()
	if rect_position != place.origin:
		rect_position = place.origin
	if rect_scale != place.get_scale():
		rect_scale = place.get_scale()
	if rect_size != fog.rect_size:
		rect_size = fog.rect_size
