extends Control
#The picture the mansion's floors stand on, and whatever is set about on it by hand - lanterns,
#urns, anything else put into this scene. mansion_view.tscn instances it as FloorGrid/Backdrops;
#mansion_floor_grid.gd lays it under the rooms - which floor, where and how large - and
#ClockModule keeps its hour.
#
#One child per floor that stands on a picture, named by the floor's code in mansion_floor_plans.gd,
#each the size of the picture and laid out in its pixels: an Art to show, an Objects to set things
#in, and a Rooms holding a mark for each of the floor's slots, named by the slot's code. Move or
#size a mark and the room is drawn there in the game; the marks show in the editor only, and a slot
#without one is drawn where the plan's tiles put it. The floor on screen is drawn over the ones
#before it, which show through dimmed by below_shade so they read as beneath it, and the ones after
#it are hidden. To put something on a floor, instance it or drop its picture into that floor's
#Objects; a lantern is lamp_post.tscn, wall_lantern.tscn, or any scene whose root carries lantern.gd.
#
#Beside the floors a Sky holds what falls over all of them - sun shafts, sun_shafts.tscn, and mist, fog.tscn.
#It is drawn over whichever floor is on screen, told the hour like the lanterns, and the game
#always shows it: its eye in the editor is only for seeing past it while placing things. In the game
#mansion_view draws both over the rooms as well - the shafts through GlowsOverRooms, the mist through
#FogOverRooms.

#The colour of the hour, the way the screen behind the plan has one: the stops, which the clock
#fades between as a turn plays out. They tint each floor whole, what is set on it included - all
#but a lantern's glow, which makes up for it so a flame burns as bright at night as by day.
export(Color) var tint_morning = Color("ffe9a7")
export(Color) var tint_day = Color("ffffff")
export(Color) var tint_evening = Color("cd9b6b")
export(Color) var tint_night = Color("516583")
#How much of the hour's colour is laid on: 1 is the colour itself, 0 none of it - each is
#blended toward white by that much less, keeping its hue.
export(float, 0.0, 1.0) var tint_strength = 1.0
#How far the lanterns are lit at each hour: 0 out, 1 burning the way their scenes set them up.
export(float, 0.0, 1.0) var lamps_morning = 0.25
export(float, 0.0, 1.0) var lamps_day = 0.0
export(float, 0.0, 1.0) var lamps_evening = 0.8
export(float, 0.0, 1.0) var lamps_night = 1.0
#What the floors beneath the one on screen are seen through.
export(Color) var below_shade = Color(0.6, 0.64, 0.76)

#The light layers lanterns shine on, one a floor from this bit up. Everything in a floor is put
#on that floor's layer and nothing else on the mansion screen is on any of them, so a lantern
#lights the picture and the things about it, but never a room, a panel over the plan, or the
#floor above its own.
const LAMP_LAYER = 512
const LAMP_LAYERS = LAMP_LAYER * 255

#The hour as the clock counts them - 1 morning, 2 noon, 3 evening, 4 night, and 0 the night again
#past midnight - fractional in between, so the clock can tween it: 2.5 is halfway from noon to
#evening.
var hour_blend = 2.0 setget set_hour_blend
var shown_floor = ''
var tint = Color(1, 1, 1, 1)
var lamp_level = 0.0
var lamps = []
#the floor each lantern stands on, as its layer's place among floors()
var lamp_floor = {}
#whether the floor on screen's glows are drawn over the rooms - see draw_glows_over_rooms()
var glows_over_rooms = false
#the sky things - sun shafts - gathered from Sky
var skies = []
#the mists under Sky, and whether mansion_view's FogOverRooms draws them over the rooms - see draw_fog_over_rooms()
var fogs = []
var fog_over_rooms = false


func _ready():
	var layers = floors()
	for i in range(layers.size()):
		put_on_layer(layers[i], LAMP_LAYER << i, i)
		#the marks are for placing the rooms in the editor; in the game the rooms draw themselves
		var rooms = layers[i].get_node_or_null('Rooms')
		if rooms != null:
			rooms.visible = false
	var sky = get_node_or_null('Sky')
	if sky != null:
		sky.visible = true
		gather_skies(sky)
	set_hour_blend(hour_blend)


func gather_skies(node):
	for child in node.get_children():
		if child.has_method('set_sky_hour'):
			skies.append(child)
		elif child.has_method('fog_material'):
			fogs.append(child)
		gather_skies(child)


#Everything under a floor onto that floor's light layer, and its lanterns shining on that layer
#alone; the lanterns are gathered on the way.
func put_on_layer(node, layer, index):
	for child in node.get_children():
		if child is Light2D:
			child.range_item_cull_mask = layer
		elif child is CanvasItem:
			child.light_mask = (child.light_mask & ~LAMP_LAYERS) | layer
		if child.has_method('set_lamp'):
			lamps.append(child)
			lamp_floor[child] = index
		put_on_layer(child, layer, index)


func floors():
	var res = []
	for child in get_children():
		if child is Control and child.has_node('Art'):
			res.append(child)
	return res


func has_floor(code):
	var layer = get_node_or_null(str(code))
	return layer != null and layer in floors()


#The size of the picture everything here is laid out in.
func canvas_size():
	for layer in floors():
		var art = layer.get_node('Art')
		if art is TextureRect and art.texture != null:
			return art.texture.get_size()
	return rect_size


#Where a room is drawn on a floor, in the picture's pixels: the mark named by its slot's code under
#the floor's Rooms, as moved and sized in the editor, or null when the scene has none for that slot.
func room_rect(floor_code, slot_code):
	var mark = get_node_or_null("%s/Rooms/%s" % [floor_code, slot_code])
	if !(mark is Control):
		return null
	return Rect2(mark.get_parent().rect_position + mark.rect_position, mark.rect_size)


func show_floor(code):
	shown_floor = str(code)
	apply()


#Asked for by mansion_view's GlowsOverRooms, which draws the glows of the floor on screen over the
#rooms: their sprites here are hidden and flicker on for it to copy. Only that floor's - a lower
#floor's glow drawn over the rooms would shine up through the floor drawn over it.
func draw_glows_over_rooms(on):
	glows_over_rooms = on
	apply()


#Asked for by mansion_view's FogOverRooms, which draws the mist over the rooms with the mist's own material: the
#mist here then hides, and only keeps drifting for that to copy.
func draw_fog_over_rooms(on):
	fog_over_rooms = on
	apply()


func first_fog():
	for fog in fogs:
		if is_instance_valid(fog):
			return fog
	return null


#Whether anything under Sky shows at this hour - GlowsOverRooms stays up for it.
func sky_shows():
	for sky in skies:
		if is_instance_valid(sky) and sky.shows():
			return true
	return false


func set_hour(hour):
	set_hour_blend(float(hour))


func set_hour_blend(value):
	hour_blend = value
	var from = int(floor(value))
	var along = value - from
	tint = hour_tint(from).linear_interpolate(hour_tint(from + 1), along)
	lamp_level = lerp(hour_lamps(from), hour_lamps(from + 1), along)
	if is_inside_tree():
		apply()


func apply():
	var layers = floors()
	var at = -1
	for i in range(layers.size()):
		if layers[i].name == shown_floor:
			at = i
	for i in range(layers.size()):
		layers[i].visible = i <= at
		layers[i].modulate = tint * below_shade if i < at else tint
	for lamp in lamps:
		if is_instance_valid(lamp):
			lamp.glow_elsewhere = glows_over_rooms and lamp_floor.get(lamp, -1) == at
			lamp.set_lamp(lamp_level, tint)
	#the sky falls over every floor, so it goes over the rooms whenever the glows do
	for sky in skies:
		if is_instance_valid(sky):
			sky.drawn_elsewhere = glows_over_rooms
			sky.set_sky_hour(hour_blend)
	for fog in fogs:
		if is_instance_valid(fog):
			fog.drawn_elsewhere = fog_over_rooms
			fog.set_fog_hour(hour_blend)


func hour_tint(hour):
	var full = tint_night
	match posmod(hour, 4):
		1:
			full = tint_morning
		2:
			full = tint_day
		3:
			full = tint_evening
	return Color(1, 1, 1, 1).linear_interpolate(full, tint_strength)


func hour_lamps(hour):
	match posmod(hour, 4):
		1:
			return lamps_morning
		2:
			return lamps_day
		3:
			return lamps_evening
	return lamps_night
