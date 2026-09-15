tool
extends Node2D
#Shafts of sunlight slanting across the mansion's backdrop. Put under mansion_backdrop.tscn's Sky, so
#they fall over whichever floor is on screen; in the game mansion_view's GlowsOverRooms draws them over
#the rooms too. The node stands where the light comes from and its beams fan out along its own
#downward axis: move it to the source and turn it to aim. How strong they are follows the hour, by
#the stops below, and each beam slowly breathes and sways on a beat of its own. In the editor they are
#drawn at full strength and standing still.

#How many beams, how far the fan opens, how long they are, and how wide at the source and at the far
#end - in the node's own pixels, which are the picture's while the node is at scale 1.
export(int, 1, 24) var beams = 5 setget set_beams
export(float, 0, 120, 0.5) var spread_degrees = 26.0 setget set_spread_degrees
export(float, 0, 8000, 1) var length = 3000.0 setget set_length
export(float, 0, 2000, 1) var width_near = 70.0 setget set_width_near
export(float, 0, 4000, 1) var width_far = 260.0 setget set_width_far
#How bright at full, and the colour of the light; it adds to what is under it.
export(float, 0, 4, 0.01) var intensity = 0.65 setget set_intensity
export(Color, RGB) var light_color = Color(1, 0.9, 0.62) setget set_light_color
#How much each beam's brightness wanders (0 steady), how fast, and how far the beams sway, in degrees.
export(float, 0, 1, 0.01) var shimmer = 0.3
export(float, 0, 4, 0.01) var shimmer_speed = 0.25
export(float, 0, 10, 0.1) var sway_degrees = 1.2
#How strong at each hour, 0 to 1; the backdrop fades between them as the clock turns.
export(float, 0, 1, 0.01) var at_morning = 1.0
export(float, 0, 1, 0.01) var at_day = 0.15
export(float, 0, 1, 0.01) var at_evening = 0.0
export(float, 0, 1, 0.01) var at_night = 0.0
#Picks which beams come out longer, wider or brighter than the others.
export(int) var variety_seed = 7 setget set_variety_seed

#Across a beam: clear at both edges, full in the middle.
const PROFILE = preload("res://gui_modules/mansion_view/backdrop/sun_shaft_profile.tres")

var level = 1.0
#Set by the backdrop when the shafts are drawn over the rooms by GlowsOverRooms: this node then draws
#nothing itself and only keeps its beams moving for that to copy.
var drawn_elsewhere = false setget set_drawn_elsewhere
var clock = 0.0
var shape = []


func _ready():
	lay_out()
	#standing still in the editor: moving beams would have the editor redraw without end
	set_process(!Engine.editor_hint)


func set_beams(value):
	beams = int(max(1, value))
	lay_out()


func set_spread_degrees(value):
	spread_degrees = value
	lay_out()


func set_variety_seed(value):
	variety_seed = value
	lay_out()


func set_length(value):
	length = value
	update()


func set_width_near(value):
	width_near = value
	update()


func set_width_far(value):
	width_far = value
	update()


func set_intensity(value):
	intensity = value
	update()


func set_light_color(value):
	light_color = value
	update()


func set_drawn_elsewhere(value):
	drawn_elsewhere = value
	update()


#Each beam's own aim, reach, width, brightness and beat, the same every time for the same seed.
func lay_out():
	var pick = RandomNumberGenerator.new()
	pick.seed = variety_seed
	shape = []
	for i in range(beams):
		var across = 0.0 if beams == 1 else float(i) / (beams - 1) - 0.5
		shape.append({
			angle = deg2rad(across * spread_degrees + pick.randf_range(-0.3, 0.3) * spread_degrees / beams),
			reach = pick.randf_range(0.7, 1.0),
			width = pick.randf_range(0.6, 1.4),
			bright = pick.randf_range(0.55, 1.0),
			phase = pick.randf() * TAU,
			beat = pick.randf_range(0.6, 1.4),
		})
	update()


#The backdrop's hour, fractional while the clock turns - see mansion_backdrop.hour_blend.
func set_sky_hour(hour_blend):
	var from = int(floor(hour_blend))
	level = lerp(stop(from), stop(from + 1), hour_blend - from)
	update()


func stop(hour):
	match posmod(hour, 4):
		1:
			return at_morning
		2:
			return at_day
		3:
			return at_evening
	return at_night


func shows():
	return level > 0.001 and intensity > 0.0 and is_visible_in_tree()


func _process(delta):
	clock += delta
	if !drawn_elsewhere and shows():
		update()


func _draw():
	if !drawn_elsewhere:
		draw_beams(self, Color(1, 1, 1, 1))


#The beams onto a canvas item in its current drawing transform - this node's own, or GlowsOverRooms'
#set to this node's place - under a colour laid over them.
func draw_beams(canvas, over):
	var strength = intensity * (1.0 if Engine.editor_hint else level)
	if strength <= 0.0:
		return
	for beam in shape:
		var angle = beam.angle + deg2rad(sway_degrees) * sin(clock * shimmer_speed * 0.7 * beam.beat + beam.phase)
		var breath = 1.0 - shimmer * 0.5 * (1.0 + sin(clock * shimmer_speed * TAU * 0.25 * beam.beat + beam.phase * 1.7))
		var along = Vector2(-sin(angle), cos(angle))
		var side = Vector2(along.y, -along.x)
		var far = length * beam.reach
		var near_half = max(0.5, width_near * beam.width * 0.5)
		var far_half = max(0.5, width_far * beam.width * 0.5)
		#it gathers over the first stretch from the source, holds across the middle, and only then
		#thins out to nothing at the far end
		var rise = 0.12
		var hold = 0.55
		var rise_half = lerp(near_half, far_half, rise)
		var hold_half = lerp(near_half, far_half, hold)
		var clear = Color(light_color.r * over.r, light_color.g * over.g, light_color.b * over.b, 0.0)
		var alpha = strength * beam.bright * breath * over.a
		var lit = Color(clear.r, clear.g, clear.b, alpha)
		var held = Color(clear.r, clear.g, clear.b, alpha * 0.8)
		quad(canvas, Vector2.ZERO, near_half, along * far * rise, rise_half, side, clear, lit)
		quad(canvas, along * far * rise, rise_half, along * far * hold, hold_half, side, lit, held)
		quad(canvas, along * far * hold, hold_half, along * far, far_half, side, held, clear)


func quad(canvas, from, from_half, to, to_half, side, from_colour, to_colour):
	var points = PoolVector2Array([from - side * from_half, from + side * from_half, to + side * to_half, to - side * to_half])
	var colours = PoolColorArray([from_colour, from_colour, to_colour, to_colour])
	var uvs = PoolVector2Array([Vector2(0, 0), Vector2(1, 0), Vector2(1, 1), Vector2(0, 1)])
	canvas.draw_polygon(points, colours, uvs, PROFILE)
