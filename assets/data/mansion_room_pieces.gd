extends Reference
#The furniture a mansion room picture is built out of, cut from one atlas.
#Plain script, not an autoload - use preload("res://assets/data/mansion_room_pieces.gd").LIST
#
#The pieces are cut from the sheets in ATLASES. Every entry names a sheet and a rectangle inside
#it; nothing here knows where a piece goes in a room, only what it looks like.
#Where the pieces are put is a layout, saved by the room builder
#(gui_modules/mansion_view/room_builder/room_builder.tscn) beside the picture it bakes.
#
#Rectangles were measured off the atlas rather than typed by eye: every island of touching
#opaque pixels is one piece, and the floor block at the bottom right is four squares of 80.
#
#	kind = 'prop'  - stands somewhere in the room, placed one at a time
#	kind = 'floor' - the ground: one square laid over and over across the whole room
#	kind = 'wall'  - the back wall, drawn behind everything but the ground
#	full = true    - not put down at its own size but covers the whole room, and a room holds
#	                 one of each such kind: laying a second floor takes up the first
#	sheet = ...    - which sheet in ATLASES the rectangle is cut from, 'house' when not said
#	scale = ...    - how much of its own size the piece stands at in a room, SCALE when not said.
#	                 The furniture sheet is drawn at the size it is used, so it stands at 1

const ATLASES = {
	house = "res://assets/images/mansion_rooms/house_layout_atlas.png",
	furniture = "res://assets/images/mansion_rooms/room_furniture_atlas.png",
}
#the sheet the older pieces were cut from, and what a piece without a sheet of its own means
const ATLAS = "res://assets/images/mansion_rooms/house_layout_atlas.png"

const LIST = {
	wall_window = {code = 'wall_window', kind = 'wall', rect = Rect2(0, 0, 240, 240), full = true},

	bed = {code = 'bed', kind = 'prop', rect = Rect2(260, 52, 122, 188)},
	fireplace = {code = 'fireplace', kind = 'prop', rect = Rect2(403, 5, 75, 75)},
	desk = {code = 'desk', kind = 'prop', rect = Rect2(482, 5, 76, 98)},
	cabinet = {code = 'cabinet', kind = 'prop', rect = Rect2(398, 149, 84, 91)},
	side_table = {code = 'side_table', kind = 'prop', rect = Rect2(501, 147, 37, 93)},
	chair = {code = 'chair', kind = 'prop', rect = Rect2(259, 278, 42, 123)},
	rug = {code = 'rug', kind = 'prop', rect = Rect2(2, 249, 236, 224)},
	chest = {code = 'chest', kind = 'prop', rect = Rect2(330, 425, 60, 47)},
	book = {code = 'book', kind = 'prop', rect = Rect2(428, 99, 20, 29)},
	torch_wall_a = {code = 'torch_wall_a', kind = 'prop', rect = Rect2(241, 424, 24, 48)},
	torch_wall_b = {code = 'torch_wall_b', kind = 'prop', rect = Rect2(272, 424, 24, 48)},
	torch_small = {code = 'torch_small', kind = 'prop', rect = Rect2(306, 427, 13, 45)},

	#furniture, drawn at the size it stands in a room
	bath = {code = 'bath', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(100, 158, 163, 89)},
	bed_plain = {code = 'bed_plain', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(0, 254, 121, 81)},
	bed_grand = {code = 'bed_grand', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(0, 0, 95, 156)},
	bunk_bed = {code = 'bunk_bed', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(97, 0, 121, 121)},
	forge_oven = {code = 'forge_oven', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(272, 0, 85, 116)},
	altar = {code = 'altar', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(123, 254, 83, 72)},
	crate = {code = 'crate', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(417, 254, 26, 27)},
	sack = {code = 'sack', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(388, 254, 27, 29)},
	partition_wide = {code = 'partition_wide', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(265, 158, 102, 89)},
	cauldron = {code = 'cauldron', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(403, 0, 65, 94)},
	partition_tall = {code = 'partition_tall', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(208, 254, 70, 70)},
	bottle_tall = {code = 'bottle_tall', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(445, 254, 10, 23)},
	anvil = {code = 'anvil', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(326, 254, 60, 52)},
	bottle_small = {code = 'bottle_small', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(457, 254, 9, 18)},
	armour_stand = {code = 'armour_stand', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(220, 0, 50, 117)},
	flask = {code = 'flask', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(468, 254, 13, 14)},
	craft_bench = {code = 'craft_bench', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(0, 158, 98, 94)},
	weapon_rack = {code = 'weapon_rack', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(369, 158, 95, 82)},
	robe_stand = {code = 'robe_stand', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(359, 0, 42, 105)},
	brazier = {code = 'brazier', kind = 'prop', sheet = 'furniture', scale = 1.0, rect = Rect2(280, 254, 44, 58)},

	floor_tiles = {code = 'floor_tiles', kind = 'floor', rect = Rect2(400, 320, 80, 80), full = true},
	floor_brick = {code = 'floor_brick', kind = 'floor', rect = Rect2(480, 320, 80, 80), full = true},
	floor_cobble = {code = 'floor_cobble', kind = 'floor', rect = Rect2(400, 400, 80, 80), full = true},
	floor_wood = {code = 'floor_wood', kind = 'floor', rect = Rect2(480, 400, 80, 80), full = true},
}

#What a finished room picture measures.
const ROOM_SIZE = Vector2(320, 320)
#The atlas was drawn for a 400px room; every piece is put down at this much of its own size so
#a 320px room holds the same furniture in the same proportions. 80px floor squares become 64,
#and five of those cover the room exactly.
const SCALE = 0.8


static func get_piece(code):
	if code != null and LIST.has(code):
		return LIST[code]
	return null


#Whether the piece is the room itself rather than a thing standing in it. One of these is laid
#over the whole room and stays where it is - the mouse does not pick it up.
static func fills_room(code):
	var piece = get_piece(code)
	return piece != null and piece.get('full', false) == true


#How big the piece stands in a room, as opposed to how big it is on its sheet.
static func drawn_size(code):
	var piece = get_piece(code)
	if piece == null:
		return Vector2()
	if piece.get('full', false):
		return ROOM_SIZE
	return (piece.rect.size * piece.get('scale', SCALE)).floor()


static func sheet_of(code):
	var piece = get_piece(code)
	return piece.get('sheet', 'house') if piece != null else 'house'


#How big one of the piece's own squares stands in a room. For a floor that is the square that
#is laid over and over; for everything else it is the piece itself.
static func tile_size(code):
	var piece = get_piece(code)
	if piece == null:
		return Vector2()
	return (piece.rect.size * piece.get('scale', SCALE)).floor()


#The two pieces every room starts with: the ground it stands on and the wall behind it.
static func default_wall():
	return first_of_kind('wall')


static func default_floor():
	return first_of_kind('floor')


static func first_of_kind(kind):
	for code in LIST:
		if LIST[code].kind == kind:
			return code
	return null


static func codes_of_kind(kind):
	var res = []
	for code in LIST:
		if LIST[code].kind == kind:
			res.append(code)
	res.sort()
	return res


#One piece as a texture of its own, cut out of the atlas. Made on demand rather than stored,
#so nothing has to be kept in step with the atlas but the rectangles above.
static func make_texture(code, atlas_texture):
	var piece = get_piece(code)
	if piece == null or atlas_texture == null:
		return null
	var tex = AtlasTexture.new()
	tex.atlas = atlas_texture
	tex.region = piece.rect
	return tex
