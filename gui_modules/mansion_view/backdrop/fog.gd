tool
extends ColorRect
#Mist drifting over the mansion's grounds. Put under mansion_backdrop.tscn's Sky, the size of the picture, so it lies
#over whichever floor is on screen; in the game mansion_view's FogOverRooms draws it over the rooms too, with this
#node's own material, and this node then hides and only keeps the mist moving (drawn_elsewhere). How it looks is set
#by the exports below, which hand themselves to fog.shader - kept on the node rather than in the material, so an
#instance saves its own values in the scene it stands in and the editor shows a change at once. It stands still in
#the editor.

#How thick the mist is where it is thickest, and its colour, at each hour. The backdrop fades between them as the
#clock turns (set_fog_hour), as it does the floors' tint. The mist is drawn over the rooms, outside that tint, so
#its colour has to carry the hour itself. The editor shows the hour picked in editor_hour.
export(float, 0.0, 1.0, 0.01) var density_morning = 0.3 setget set_density_morning
export(float, 0.0, 1.0, 0.01) var density_day = 0.12 setget set_density_day
export(float, 0.0, 1.0, 0.01) var density_evening = 0.2 setget set_density_evening
export(float, 0.0, 1.0, 0.01) var density_night = 0.24 setget set_density_night
export(Color, RGB) var color_morning = Color(0.95, 0.9, 0.82) setget set_color_morning
export(Color, RGB) var color_day = Color(0.85, 0.88, 0.92) setget set_color_day
export(Color, RGB) var color_evening = Color(0.8, 0.68, 0.58) setget set_color_evening
export(Color, RGB) var color_night = Color(0.4, 0.48, 0.62) setget set_color_night
export(int, "Morning", "Day", "Evening", "Night") var editor_hour = 0 setget set_editor_hour
#How much of the picture the patches cover, how softly they fade at their edges, and how large a patch is, in
#picture pixels - the same at every hour.
export(float, 0.0, 1.0, 0.01) var coverage = 0.55 setget set_coverage
export(float, 0.01, 1.0, 0.01) var softness = 0.48 setget set_softness
export(float, 50, 4000, 10) var patch_size = 900.0 setget set_patch_size
#How far the mist travels in a second, in picture pixels. Only in the game.
export(Vector2) var drift = Vector2(14, -3)

#fog.shader's noise repeats every 64 patches, so the offsets wrap there without a seam
const REPEAT = 64.0
#how fast the finer layer of the noise travels, as a share of drift, so the patches change shape as they go
const FINE_PACE = 0.6

#Set by the backdrop while FogOverRooms draws this mist over the rooms.
var drawn_elsewhere = false setget set_drawn_elsewhere
#The backdrop's hour as the clock counts them - 1 morning, 2 noon, 3 evening, 4 or 0 night - fractional while the
#clock turns; see mansion_backdrop.hour_blend.
var hour_blend = 1.0
var clock = 0.0


func _ready():
	if !Engine.editor_hint:
		#a material of its own, so two mists in one scene cannot overwrite each other's look
		if material != null:
			material = material.duplicate()
		#as large as the picture, whatever size the scene gave it to be seen in the editor
		if owner != null and owner.has_method("canvas_size"):
			rect_size = owner.canvas_size()
	apply_look()
	set_process(!Engine.editor_hint)


func set_density_morning(value):
	density_morning = value
	apply_look()


func set_density_day(value):
	density_day = value
	apply_look()


func set_density_evening(value):
	density_evening = value
	apply_look()


func set_density_night(value):
	density_night = value
	apply_look()


func set_color_morning(value):
	color_morning = value
	apply_look()


func set_color_day(value):
	color_day = value
	apply_look()


func set_color_evening(value):
	color_evening = value
	apply_look()


func set_color_night(value):
	color_night = value
	apply_look()


func set_editor_hour(value):
	editor_hour = value
	apply_look()


func set_coverage(value):
	coverage = value
	apply_look()


func set_softness(value):
	softness = value
	apply_look()


func set_patch_size(value):
	patch_size = max(1.0, value)
	apply_look()


#The backdrop's hour, handed on by mansion_backdrop.apply().
func set_fog_hour(value):
	hour_blend = value
	apply_look()


#The hour the mist is shown at: the clock's in the game, editor_hour in the editor.
func shown_hour():
	return float(editor_hour + 1) if Engine.editor_hint else hour_blend


func density_now():
	var hour = shown_hour()
	var from = int(floor(hour))
	return lerp(hour_density(from), hour_density(from + 1), hour - from)


func color_now():
	var hour = shown_hour()
	var from = int(floor(hour))
	return hour_color(from).linear_interpolate(hour_color(from + 1), hour - from)


func hour_density(hour):
	match posmod(hour, 4):
		1:
			return density_morning
		2:
			return density_day
		3:
			return density_evening
	return density_night


func hour_color(hour):
	match posmod(hour, 4):
		1:
			return color_morning
		2:
			return color_day
		3:
			return color_evening
	return color_night


#The look at the hour shown, handed to the shader.
func apply_look():
	if !(material is ShaderMaterial):
		return
	var colour = color_now()
	material.set_shader_param("fog_color", Color(colour.r, colour.g, colour.b, 1.0))
	material.set_shader_param("density", density_now())
	material.set_shader_param("coverage", coverage)
	material.set_shader_param("softness", softness)
	material.set_shader_param("patch_size", patch_size)


func set_drawn_elsewhere(value):
	drawn_elsewhere = value
	visible = !value


#What FogOverRooms draws with; it is also how the backdrop tells a mist from the other things under Sky.
func fog_material():
	return material


#Whether there is mist to draw: a material and some density at this hour, under a Sky that is shown.
func shows():
	if !(material is ShaderMaterial) or density_now() <= 0.0:
		return false
	var sky = get_parent()
	return !(sky is CanvasItem) or sky.is_visible_in_tree()


func _process(delta):
	if !(material is ShaderMaterial):
		return
	clock += delta
	var period = REPEAT * patch_size
	material.set_shader_param("offset_a", wrapped(drift * clock, period))
	material.set_shader_param("offset_b", wrapped(drift * clock * FINE_PACE, period))


func wrapped(offset, period):
	return Vector2(fposmod(offset.x, period), fposmod(offset.y, period))
