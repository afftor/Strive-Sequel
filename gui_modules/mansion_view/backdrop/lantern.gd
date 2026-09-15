tool
extends Node2D
#A lantern set about on the mansion's backdrop (mansion_backdrop.tscn). How it shines is set on the
#lantern itself: select a placed lantern in the backdrop scene and set these in its inspector, or set
#them on the root of lamp_post.tscn / wall_lantern.tscn for every lantern of that kind that does not
#set its own. The lantern puts them on its Light - the pool it throws on the ground about it - and its
#Glow - the glow on its glass - in the editor too, so a change shows as it is made. Set them here
#rather than on those two nodes, which are overwritten from these. In the game the backdrop says how
#far the lantern is lit for the hour, and the light wavers about these values, each on its own beat.
#
#Radii are in the lantern's own pixels - the picture's, while the lantern is at scale 1 - so scaling
#a placed lantern scales its light with it.

#The pool of light on the ground: how far it reaches, how strong it is, and its colour.
export(float, 0, 4000, 0.1) var light_radius = 614.4 setget set_light_radius
export(float, 0, 16, 0.05) var light_energy = 2.2 setget set_light_energy
export(Color, RGB) var light_color = Color(1, 0.6, 0.28) setget set_light_color
#The glow on the glass, which the game draws over the rooms: its size, how bright, and its colour.
export(float, 0, 2000, 0.1) var glow_radius = 153.6 setget set_glow_radius
export(float, 0, 8, 0.05) var glow_intensity = 1.0 setget set_glow_intensity
export(Color, RGB) var glow_color = Color(1, 0.72, 0.36) setget set_glow_color
#How far the light swings about its strength, 0 steady, and how fast; 1 is a flame in still air.
export(float, 0.0, 1.0) var flicker_amount = 0.15
export(float, 0.0, 10.0) var flicker_speed = 1.0

onready var light = get_node_or_null('Light')
onready var glow = get_node_or_null('Glow')

var level = 1.0
#Set by the backdrop when this glow is drawn over the rooms, by mansion_view's GlowsOverRooms: the
#sprite then stays hidden and only keeps its colour and size up to date for that to copy.
var glow_elsewhere = false
var daylight = Color(1, 1, 1, 1)
var noise = OpenSimplexNoise.new()
var clock = 0.0


func _ready():
	put_on()
	#no flicker in the editor: it would only leave wandering values to be saved into the scene
	if Engine.editor_hint:
		set_process(false)
		return
	noise.seed = randi()
	noise.octaves = 2
	noise.period = 0.6
	clock = randf() * 1000.0
	shine()


func set_light_radius(value):
	light_radius = value
	values_changed()


func set_light_energy(value):
	light_energy = value
	values_changed()


func set_light_color(value):
	light_color = value
	values_changed()


func set_glow_radius(value):
	glow_radius = value
	values_changed()


func set_glow_intensity(value):
	glow_intensity = value
	values_changed()


func set_glow_color(value):
	glow_color = value
	values_changed()


#A value set once the lantern is in the tree - in the inspector, or by code in the game. While the
#scene is still being loaded the values only land, and _ready() puts them on.
func values_changed():
	if !is_inside_tree():
		return
	put_on()
	if !Engine.editor_hint and level > 0.001:
		flicker()


#The values onto Light and Glow as they stand, burning steady at full.
func put_on():
	var pool = get_node_or_null('Light')
	if pool != null:
		pool.color = light_color
		pool.energy = light_energy
		pool.texture_scale = radius_scale(pool.texture, light_radius)
	var halo = get_node_or_null('Glow')
	if halo != null:
		halo.self_modulate = Color(glow_color.r, glow_color.g, glow_color.b, glow_intensity)
		var size = radius_scale(halo.texture, glow_radius)
		halo.scale = Vector2(size, size)


#The scale that makes a round light texture reach a radius: at scale 1 it reaches half its width.
func radius_scale(texture, radius):
	if texture == null or texture.get_width() <= 0:
		return 1.0
	return radius / (texture.get_width() / 2.0)


#The backdrop's say: how far lit, 0 to 1, and the colour of the hour on this lantern's floor. The
#glow is divided through by that colour, so the hour darkens the post and the ground about it but
#not the flame.
func set_lamp(value, tint):
	level = value
	daylight = tint
	shine()


func shine():
	var lit = level > 0.001
	if light != null:
		light.enabled = lit
	if glow != null:
		glow.visible = lit and !glow_elsewhere
	set_process(lit and !Engine.editor_hint)
	if lit:
		flicker()


func _process(delta):
	if !is_visible_in_tree():
		return
	clock += delta * flicker_speed
	flicker()


func flicker():
	#a slow swell with a quicker flutter over it
	var swing = noise.get_noise_1d(clock) * 0.7 + noise.get_noise_1d(clock * 5.3 + 57.0) * 0.3
	var strength = max(0.0, 1.0 + swing * 2.0 * flicker_amount)
	if light != null:
		light.energy = light_energy * level * strength
		light.texture_scale = radius_scale(light.texture, light_radius) * (1.0 + swing * 0.5 * flicker_amount)
	if glow != null:
		glow.self_modulate = Color(glow_color.r / max(daylight.r, 0.05),
			glow_color.g / max(daylight.g, 0.05), glow_color.b / max(daylight.b, 0.05),
			glow_intensity * level * strength)
		var size = radius_scale(glow.texture, glow_radius) * (1.0 + swing * 0.3 * flicker_amount)
		glow.scale = Vector2(size, size)
