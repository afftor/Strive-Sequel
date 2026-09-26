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
#	                 Replacement furniture is scaled to fit its original room footprint.

const ATLASES = {
	house = "res://assets/images/mansion_rooms/house_layout_atlas.png",
	furniture = "res://assets/images/mansion_rooms/room_furniture_atlas.png",
	trash = "res://assets/images/mansion_rooms/room_trashed_atlas.png",
	dirty_floor = "res://assets/images/mansion_rooms/room_dirty_floor_atlas.png",
	rug = "res://assets/images/mansion_rooms/rug_brown_gold_atlas.png",
}
#the sheet the older pieces were cut from, and what a piece without a sheet of its own means
const ATLAS = "res://assets/images/mansion_rooms/house_layout_atlas.png"

const LIST = {
	wall_window = {code = 'wall_window', kind = 'wall', rect = Rect2(0, 0, 240, 248), full = true},

	bed = {code = 'bed', kind = 'prop', rect = Rect2(260, 52, 122, 188)},
	fireplace = {code = 'fireplace', kind = 'prop', rect = Rect2(403, 5, 75, 75)},
	desk = {code = 'desk', kind = 'prop', rect = Rect2(482, 5, 76, 98)},
	cabinet = {code = 'cabinet', kind = 'prop', rect = Rect2(398, 149, 84, 91)},
	side_table = {code = 'side_table', kind = 'prop', rect = Rect2(501, 147, 37, 93)},
	chair = {code = 'chair', kind = 'prop', rect = Rect2(259, 278, 42, 123)},
	rug = {code = 'rug', kind = 'prop', sheet = 'rug', rect = Rect2(0, 0, 236, 224)},
	chest = {code = 'chest', kind = 'prop', rect = Rect2(330, 425, 60, 47)},
	book = {code = 'book', kind = 'prop', rect = Rect2(428, 99, 20, 29)},
	torch_wall_a = {code = 'torch_wall_a', kind = 'prop', rect = Rect2(241, 424, 24, 48)},
	torch_wall_b = {code = 'torch_wall_b', kind = 'prop', rect = Rect2(272, 424, 24, 48)},
	torch_small = {code = 'torch_small', kind = 'prop', rect = Rect2(306, 427, 13, 45)},

	#Replacement furniture atlas, fitted proportionally into the previous piece sizes.
	bath = {code = 'bath', kind = 'prop', sheet = 'furniture', scale = 0.83962264, rect = Rect2(333, 15, 185, 106)},
	bed_plain = {code = 'bed_plain', kind = 'prop', sheet = 'furniture', scale = 0.81208054, rect = Rect2(20, 23, 149, 93)},
	bed_grand = {code = 'bed_grand', kind = 'prop', sheet = 'furniture', scale = 0.81896552, rect = Rect2(193, 76, 116, 189)},
	bunk_bed = {code = 'bunk_bed', kind = 'prop', sheet = 'furniture', scale = 0.81208054, rect = Rect2(20, 134, 149, 132)},
	forge_oven = {code = 'forge_oven', kind = 'prop', sheet = 'furniture', scale = 0.83333333, rect = Rect2(323, 134, 102, 133)},
	altar = {code = 'altar', kind = 'prop', sheet = 'furniture', scale = 0.75789474, rect = Rect2(441, 172, 101, 95)},
	crate = {code = 'crate', kind = 'prop', sheet = 'furniture', scale = 0.72972973, rect = Rect2(19, 282, 34, 37)},
	sack = {code = 'sack', kind = 'prop', sheet = 'furniture', scale = 0.74358974, rect = Rect2(61, 279, 35, 39)},
	partition_wide = {code = 'partition_wide', kind = 'prop', sheet = 'furniture', scale = 0.80314961, rect = Rect2(122, 282, 127, 107)},
	cauldron = {code = 'cauldron', kind = 'prop', sheet = 'furniture', scale = 0.74712644, rect = Rect2(265, 275, 87, 114)},
	partition_tall = {code = 'partition_tall', kind = 'prop', sheet = 'furniture', scale = 0.72164948, rect = Rect2(372, 295, 97, 90)},
	bottle_tall = {code = 'bottle_tall', kind = 'prop', sheet = 'furniture', scale = 0.76923077, rect = Rect2(487, 293, 13, 28)},
	anvil = {code = 'anvil', kind = 'prop', sheet = 'furniture', scale = 0.72289157, rect = Rect2(14, 327, 83, 66)},
	bottle_small = {code = 'bottle_small', kind = 'prop', sheet = 'furniture', scale = 0.69230769, rect = Rect2(487, 327, 13, 24)},
	armour_stand = {code = 'armour_stand', kind = 'prop', sheet = 'furniture', scale = 0.75757576, rect = Rect2(385, 384, 66, 143)},
	flask = {code = 'flask', kind = 'prop', sheet = 'furniture', scale = 0.66666667, rect = Rect2(484, 360, 18, 21)},
	craft_bench = {code = 'craft_bench', kind = 'prop', sheet = 'furniture', scale = 0.75968992, rect = Rect2(15, 410, 129, 118)},
	weapon_rack = {code = 'weapon_rack', kind = 'prop', sheet = 'furniture', scale = 0.75229358, rect = Rect2(165, 416, 123, 109)},
	robe_stand = {code = 'robe_stand', kind = 'prop', sheet = 'furniture', scale = 0.70000000, rect = Rect2(474, 396, 60, 132)},
	brazier = {code = 'brazier', kind = 'prop', sheet = 'furniture', scale = 0.69841270, rect = Rect2(301, 442, 63, 81)},

	#Keep only the largest connected island in each crop: diagonal debris overlaps
	#neighbouring bounding rectangles, although the actual opaque islands are separate.
	trash_stones_a = {code = 'trash_stones_a', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(240, 1, 50, 73)},
	trash_stone_block = {code = 'trash_stone_block', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(112, 17, 41, 35)},
	trash_stone_small_a = {code = 'trash_stone_small_a', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(299, 33, 22, 17)},
	trash_broken_crate_a = {code = 'trash_broken_crate_a', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(51, 41, 44, 46)},
	trash_stone_small_b = {code = 'trash_stone_small_b', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(209, 44, 20, 18)},
	trash_stones_small = {code = 'trash_stones_small', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(178, 55, 22, 30)},
	trash_plank_a = {code = 'trash_plank_a', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(215, 75, 67, 53)},
	trash_stone_pair = {code = 'trash_stone_pair', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(56, 97, 31, 39)},
	trash_plank_b = {code = 'trash_plank_b', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(226, 97, 62, 45)},
	trash_stones_b = {code = 'trash_stones_b', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(290, 105, 55, 59)},
	trash_stone_flat = {code = 'trash_stone_flat', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(176, 117, 33, 26)},
	trash_broken_furniture = {code = 'trash_broken_furniture', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(53, 139, 99, 92)},
	trash_plank_upright = {code = 'trash_plank_upright', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(258, 150, 16, 63)},
	trash_broken_crate_b = {code = 'trash_broken_crate_b', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(292, 168, 71, 74)},
	trash_plank_long = {code = 'trash_plank_long', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(158, 193, 90, 57)},
	trash_plank_c = {code = 'trash_plank_c', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(86, 212, 73, 51)},
	trash_plank_bent = {code = 'trash_plank_bent', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(195, 257, 48, 49)},
	trash_rubble_a = {code = 'trash_rubble_a', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(33, 261, 73, 61)},
	trash_rubble_b = {code = 'trash_rubble_b', kind = 'prop', sheet = 'trash', scale = 1.0, rect = Rect2(308, 261, 60, 61)},

	floor_tiles = {code = 'floor_tiles', kind = 'floor', rect = Rect2(400, 320, 80, 80), full = true},
	floor_tiles_dirty = {code = 'floor_tiles_dirty', kind = 'floor', sheet = 'dirty_floor', rect = Rect2(0, 0, 80, 80), full = true},
	floor_brick = {code = 'floor_brick', kind = 'floor', rect = Rect2(480, 320, 80, 80), full = true},
	floor_cobble = {code = 'floor_cobble', kind = 'floor', rect = Rect2(400, 400, 80, 80), full = true},
	floor_wood = {code = 'floor_wood', kind = 'floor', rect = Rect2(480, 400, 80, 80), full = true},
}

#What a finished room picture measures.
const ROOM_SIZE = Vector2(320, 320)
#The slot spans the inner width; reserve the upper strip for the back wall.
#The floor reaches the bottom edge except for the foreground column corners.
const FLOOR_RECT = Rect2(0, 56, 320, 264)
const ROOM_COLUMN_LEFT = 18
const ROOM_COLUMN_RIGHT = 24
const ROOM_COLUMN_HEIGHT = 24
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
	if piece.get('sheet', '') == 'trash':
		return isolated_texture(atlas_texture, piece.rect)
	var tex = AtlasTexture.new()
	tex.atlas = atlas_texture
	tex.region = piece.rect
	return tex


static func isolated_texture(atlas_texture, rect):
	var source = atlas_texture.get_data().get_rect(rect)
	source.convert(Image.FORMAT_RGBA8)
	var width = source.get_width()
	var height = source.get_height()
	var seen = {}
	var largest = []
	source.lock()
	for y in range(height):
		for x in range(width):
			var start = Vector2(x, y)
			if seen.has(start) or source.get_pixel(x, y).a == 0:
				continue
			var island = [start]
			seen[start] = true
			var cursor = 0
			while cursor < island.size():
				var at = island[cursor]
				cursor += 1
				for dy in range(-1, 2):
					for dx in range(-1, 2):
						var next = at + Vector2(dx, dy)
						if next.x < 0 or next.y < 0 or next.x >= width or next.y >= height or seen.has(next):
							continue
						seen[next] = true
						if source.get_pixel(int(next.x), int(next.y)).a > 0:
							island.append(next)
			if island.size() > largest.size():
				largest = island
	var clean = Image.new()
	clean.create(width, height, false, Image.FORMAT_RGBA8)
	clean.fill(Color(0, 0, 0, 0))
	clean.lock()
	for at in largest:
		clean.set_pixel(int(at.x), int(at.y), source.get_pixel(int(at.x), int(at.y)))
	clean.unlock()
	source.unlock()
	var tex = ImageTexture.new()
	tex.create_from_image(clean, 0)
	return tex
