extends Control
#A bench for building the pictures the mansion draws for its rooms
#(gui_modules/mansion_view/rooms/*.png). Not part of the game: open this scene in the editor
#and press F6.
#
#	pick a piece on the left and click the canvas to put it down. That piece is then the one
#	being worked on and the palette lets go, so the next click moves what is already there:
#	drag a piece about, right-click it to take it away
#	the ground and the walls are pieces like any other, only they cover the whole room and a
#	room holds one of each - laying a second floor takes up the first
#	every room starts with a floor and a wall, at the bottom of the pile
#	the colour on the left belongs to the piece being worked on: choose a chair, move the
#	colour, that chair changes. Every piece takes paint, furniture included
#	the rooms built so far are listed at the top: choosing one says which room Save writes over
#	and which one Open brings back
#	the wheel over the canvas, or the two buttons by the colour, look closer or further out.
#	That is this bench's view only - the picture saved is always the size of the room
#	the arrows nudge the chosen piece a pixel at a time, with shift a whole grid step
#	the list on the right is the pile of pieces, the front of the picture first and the ground
#	last. Each row is that piece's settings: P paints it with the colour on the left, <> mirrors
#	it, ^^ ^ v vv move it through the pile, x takes it out
#	Save writes two things side by side - the picture the game will draw, and the layout it was
#	built from, so it can be opened again and changed
#
#The picture is baked by drawing the canvas into a Viewport and saving what it rendered, which
#is why the canvas is a child of one. Saving into res:// only works while running from the
#editor - which is the only place this scene is ever meant to run.

const Pieces = preload("res://assets/data/mansion_room_pieces.gd")

const ROOMS_DIR = "res://gui_modules/mansion_view/rooms/"
const LAYOUTS_DIR = "res://gui_modules/mansion_view/rooms/layouts/"
#a piece is put down centred on the click, and moved by the same handle
const GRID = 8
const ZOOM_STEPS = [0.5, 1.0, 1.5, 2.0, 3.0, 4.0]

var atlases = {}
var brush = ''
var dragging = null
var drag_offset = Vector2()
var selected = null
var zoom = 1.0
#set while the palette buttons or the colour are being brought in line with what is chosen, so
#the bench does not mistake its own tidying for the user pressing something
var syncing = false
#a floor is one square laid over and over, tiled once into a picture of the whole room
var floor_pictures = {}


func _ready():
	atlases = load_atlases()
	canvas().rect_min_size = Pieces.ROOM_SIZE
	canvas().rect_size = Pieces.ROOM_SIZE
	canvas().get_node("Viewport").size = Pieces.ROOM_SIZE
	room().rect_size = Pieces.ROOM_SIZE
	canvas().get_node("Catcher").connect("gui_input", self, "on_canvas_input")
	$Body/SidePane/Side/Save.connect("pressed", self, "save_room")
	$Body/SidePane/Side/Load.connect("pressed", self, "load_room")
	$Body/SidePane/Side/Clear.connect("pressed", self, "reset_room")
	$Body/SidePane/Side/Paint.connect("color_changed", self, "on_paint_changed")
	$Body/SidePane/Side/ZoomRow/Out.connect("pressed", self, "zoom_by", [-1])
	$Body/SidePane/Side/ZoomRow/In.connect("pressed", self, "zoom_by", [1])
	$Body/SidePane/Side/RoomName.connect("text_changed", self, "on_name_typed")
	$Body/CanvasHolder.connect("resized", self, "centre_canvas")
	set_zoom(zoom)
	build_palette()
	refresh_rooms()
	reset_room()


#Godot can only load() a picture the editor has imported, and a sheet dropped into the project
#arrives as a plain file. Until the editor has scanned it, the raw PNG is read instead - the same
#pixels either way.
func load_atlases():
	var res = {}
	for sheet in Pieces.ATLASES:
		res[sheet] = load_sheet(Pieces.ATLASES[sheet])
	return res


func load_sheet(path):
	var imported = load(path)
	if imported != null:
		return imported
	var image = Image.new()
	if image.load(path) != OK:
		return null
	var tex = ImageTexture.new()
	#no filtering: the pieces are drawn at four fifths of their size and smoothing turns pixel
	#art into porridge at any scale that is not a whole number
	tex.create_from_image(image, 0)
	return tex


func sheet_for(code):
	return atlases.get(Pieces.sheet_of(code))


#An atlas region cannot be tiled by a TextureRect, so the tiling is done once into a picture the
#size of the room. The floor is then a piece like any other - put down, chosen and painted the
#same way - rather than a grid of squares living apart from everything else.
func floor_picture(code):
	if floor_pictures.has(code):
		return floor_pictures[code]
	if sheet_for(code) == null:
		return null
	var source = sheet_for(code).get_data()
	source.convert(Image.FORMAT_RGBA8)
	var step = Pieces.tile_size(code)
	var square = source.get_rect(Pieces.get_piece(code).rect)
	square.resize(int(step.x), int(step.y), Image.INTERPOLATE_NEAREST)
	var whole = Image.new()
	whole.create(int(Pieces.ROOM_SIZE.x), int(Pieces.ROOM_SIZE.y), false, Image.FORMAT_RGBA8)
	var y = 0
	while y < Pieces.ROOM_SIZE.y:
		var x = 0
		while x < Pieces.ROOM_SIZE.x:
			whole.blit_rect(square, Rect2(Vector2(), step), Vector2(x, y))
			x += int(step.x)
		y += int(step.y)
	var tex = ImageTexture.new()
	tex.create_from_image(whole, 0)
	floor_pictures[code] = tex
	return tex


func texture_for(code):
	if Pieces.get_piece(code).kind == 'floor':
		return floor_picture(code)
	return Pieces.make_texture(code, sheet_for(code))


#### the palette ####

func build_palette():
	for holder in [$Body/SidePane/Side/Floors/List, $Body/SidePane/Side/Props/List]:
		input_handler.ClearContainer(holder, ['Piece'])
	for code in Pieces.codes_of_kind('floor'):
		add_palette_button($Body/SidePane/Side/Floors/List, code)
	for kind in ['wall', 'prop']:
		for code in Pieces.codes_of_kind(kind):
			add_palette_button($Body/SidePane/Side/Props/List, code)


func add_palette_button(holder, code):
	var button = input_handler.DuplicateContainerTemplate(holder, 'Piece')
	#the one square, not the whole tiled floor: it is an icon, and one square shows the pattern
	button.get_node('Icon').texture = Pieces.make_texture(code, sheet_for(code))
	button.get_node('Name').text = code
	button.set_meta('code', code)
	#a palette button stays pressed while it is the one being put down, so what the next click
	#on the canvas will do can be read off the screen rather than remembered
	button.toggle_mode = true
	button.connect("toggled", self, "on_brush_toggled", [code])
	return button


func on_brush_toggled(on, code):
	if syncing:
		return
	pick_piece(code if on else '')


#Choosing what to put down next. Choosing the piece that is already chosen puts the brush away,
#and so does putting one down or taking hold of something already in the room: laying pieces and
#moving them are two different things, and the bench is never doing both at once.
func pick_piece(code):
	brush = '' if code == brush else code
	sync_palette()
	show_chosen()


func sync_palette():
	syncing = true
	for holder in [$Body/SidePane/Side/Floors/List, $Body/SidePane/Side/Props/List]:
		for button in holder.get_children():
			if button.has_meta('code'):
				button.pressed = button.get_meta('code') == brush
	syncing = false


func show_chosen():
	if brush != '':
		$Body/SidePane/Side/Chosen.text = "putting down: %s" % brush
	elif is_instance_valid(selected):
		$Body/SidePane/Side/Chosen.text = "%s at %d,%d" % [selected.get_meta('code'),
			selected.rect_position.x, selected.rect_position.y]
	else:
		$Body/SidePane/Side/Chosen.text = "-"


func paint_colour():
	return $Body/SidePane/Side/Paint.color


#### the colour ####

#The colour belongs to the piece being worked on rather than to any one part of the room: choose
#a chair and the picker holds that chair's colour, move it and that chair changes. Nothing is
#held back from the brush - the walls, the ground and every stick of furniture are drawn through
#a colour of their own.
func sync_paint():
	var picker = $Body/SidePane/Side/Paint
	picker.disabled = !is_instance_valid(selected)
	if is_instance_valid(selected):
		syncing = true
		picker.color = selected.modulate
		syncing = false
	$Body/SidePane/Side/PaintHeader.text = paint_header()


func paint_header():
	if !is_instance_valid(selected):
		return "Paint - nothing chosen"
	return "Paint - %s" % selected.get_meta('code')


func on_paint_changed(colour):
	if syncing or !is_instance_valid(selected):
		return
	selected.modulate = colour


#### how close the bench is looking ####

#Only this bench's view of the room. The room is drawn into a Viewport the size of the picture
#and that is what gets saved, however big it is being shown here - which is why the canvas is
#scaled rather than resized: a ViewportContainer that stretches resizes its viewport with it,
#and the saved picture would come out whatever size the bench happened to be showing.
func set_zoom(value):
	zoom = clamp(value, ZOOM_STEPS[0], ZOOM_STEPS[ZOOM_STEPS.size() - 1])
	canvas().rect_scale = Vector2(zoom, zoom)
	$Body/CanvasHolder.rect_min_size = Pieces.ROOM_SIZE * zoom
	$Body/SidePane/Side/ZoomRow/Level.text = "zoom x%s" % zoom
	centre_canvas()


#The room stands in the middle of what the two panels leave, at whatever size it is being shown
#- the thing being built belongs in the middle of the bench rather than pushed against the tools.
func centre_canvas():
	var holder = $Body/CanvasHolder
	canvas().rect_position = ((holder.rect_size - Pieces.ROOM_SIZE * zoom) / 2.0).floor()


func zoom_by(step):
	var index = ZOOM_STEPS.find(zoom)
	if index == -1:
		index = ZOOM_STEPS.find(1.0)
	set_zoom(ZOOM_STEPS[int(clamp(index + step, 0, ZOOM_STEPS.size() - 1))])


#### the room being built ####

func canvas():
	return $Body/CanvasHolder/Canvas


func room():
	return $Body/CanvasHolder/Canvas/Viewport/Room


#Left button: with a piece chosen on the left it is put down where the click landed. What lies
#under the cursor cannot decide that - the ground covers the whole room, so there is no bare
#spot to aim at, and a click meant to place a piece would forever grab the floor instead. Once
#it is down the palette lets go, and the same click takes hold of what is already there and
#moves it. Right button takes a piece away, middle button paints it, the wheel looks closer.
func on_canvas_input(event):
	if !(event is InputEventMouseButton):
		return
	var at = event.position
	if event.button_index == BUTTON_LEFT and !event.pressed:
		dragging = null
		return
	if !event.pressed:
		return
	if event.button_index == BUTTON_WHEEL_UP:
		zoom_by(1)
		return
	if event.button_index == BUTTON_WHEEL_DOWN:
		zoom_by(-1)
		return
	if event.button_index == BUTTON_RIGHT:
		remove_at(at)
		return
	if event.button_index == BUTTON_MIDDLE:
		paint_at(at)
		return
	if event.button_index != BUTTON_LEFT:
		return
	if brush != '':
		#what was just put down is the piece being worked on, and the press that put it there
		#goes on to slide it, so it can be placed and settled in one movement
		var placed = place(brush, at)
		select_piece(placed)
		grab(placed, at)
		return
	var under = piece_at(at)
	if under != null:
		select_piece(under)
	grab(under, at)


func grab(node, at):
	if node == null or Pieces.fills_room(node.get_meta('code')):
		return
	dragging = node
	drag_offset = node.rect_position - at


func place(code, at):
	var piece = Pieces.get_piece(code)
	var props = room().get_node("Props")
	#a room has one ground and one back wall: laying another takes up the one already there
	if Pieces.fills_room(code):
		for other in placed_pieces():
			if Pieces.get_piece(other.get_meta('code')).kind == piece.kind:
				drop_piece(other)
	var node = props.get_node("Piece").duplicate()
	node.visible = true
	node.texture = texture_for(code)
	var size = Pieces.drawn_size(code)
	node.rect_min_size = size
	node.rect_size = size
	#a piece that covers the room has nowhere to be put - it is the whole of it
	node.rect_position = Vector2(0, 0) if Pieces.fills_room(code) else snapped_corner(at, size)
	node.set_meta('code', code)
	props.add_child(node)
	if Pieces.fills_room(code):
		props.move_child(node, bottom_index(piece.kind))
	refresh_placed()
	return node


#The ground lies at the very bottom of the pile and the wall stands just in front of it, so the
#wall's foot is drawn over the ground it meets. Everything else is put on top.
func bottom_index(kind):
	if kind == 'wall' and has_kind('floor'):
		return 2
	return 1


func snapped_corner(at, size):
	var corner = at - size / 2.0
	return Vector2(round(corner.x / GRID) * GRID, round(corner.y / GRID) * GRID)


#Everything the click landed on, front to back.
func nodes_under(at):
	var res = []
	var props = placed_pieces()
	props.invert()
	for node in props:
		if node.visible and Rect2(node.rect_position, node.rect_size).has_point(at):
			res.append(node)
	return res


#What the mouse can take hold of. The ground and the wall are the room itself rather than things
#standing in it: they are painted, moved through the pile and taken out from their row, not
#dragged around.
func piece_at(at, movable_only = true):
	for node in nodes_under(at):
		if movable_only and Pieces.fills_room(node.get_meta('code')):
			continue
		return node
	return null


#The piece being pointed at takes the colour - the rug lying on the floor before the floor under
#it, the torch on the wall before the wall.
func paint_at(at):
	for node in nodes_under(at):
		paint_piece(node)
		return


#Painting a piece makes it the one being worked on, so the colour on the left goes on holding
#what was just used on it.
func paint_piece(node):
	if !is_instance_valid(node):
		return
	node.modulate = paint_colour()
	select_piece(node)


#Mirrored, so one drawn chair faces either way and a room does not read as the same picture
#twice. It is the piece's own setting, kept in the layout beside its colour.
func mirror_piece(node):
	if !is_instance_valid(node):
		return
	node.flip_h = !node.flip_h
	refresh_placed()


func remove_at(at):
	drop_piece(piece_at(at))


func drop_piece(node):
	if node == null:
		return
	if selected == node:
		selected = null
	node.get_parent().remove_child(node)
	node.queue_free()
	refresh_placed()
	show_chosen()
	sync_paint()


func clear_room():
	input_handler.ClearContainer(room().get_node("Props"), ['Piece'])
	set_selected(null)


#An empty room is not an empty picture: it is a floor and four walls with nothing on them, so
#clearing one out leaves those two standing, at the bottom of the pile where they belong.
func reset_room():
	clear_room()
	for code in [Pieces.default_floor(), Pieces.default_wall()]:
		if code != null:
			place(code, Pieces.ROOM_SIZE / 2.0)
	show_chosen()


#### what stands in the room ####

#Everything down, back to front - the order the picture is painted in.
func placed_pieces():
	var res = []
	for node in room().get_node("Props").get_children():
		if node.name == 'Piece' or node.is_queued_for_deletion():
			continue
		res.append(node)
	return res


func has_kind(kind):
	for node in placed_pieces():
		if Pieces.get_piece(node.get_meta('code')).kind == kind:
			return true
	return false


#The list reads the way the pile looks from the front: what is nearest the eye at the top, the
#ground at the bottom. "Level" is that order and nothing else - there is no depth in a flat
#picture beyond who is painted over whom - so level 0 is the last row, the ground.
func refresh_placed():
	var list = $Body/Placed/Scroll/List
	if !is_instance_valid(list):
		return
	input_handler.ClearContainer(list, ['Row'])
	var pile = placed_pieces()
	pile.invert()
	var level = pile.size() - 1
	for node in pile:
		var code = node.get_meta('code')
		var row = input_handler.DuplicateContainerTemplate(list, 'Row')
		row.set_meta('piece', node)
		row.get_node('Level').text = str(level)
		row.get_node('Pick').text = str(code)
		row.get_node('Pick').pressed = node == selected
		row.get_node('Pick').connect("pressed", self, "select_piece", [node])
		row.get_node('Paint').connect("pressed", self, "paint_piece", [node])
		row.get_node('Mirror').pressed = node.flip_h
		row.get_node('Mirror').connect("pressed", self, "mirror_piece", [node])
		row.get_node('Top').connect("pressed", self, "move_to_end", [node, 1])
		row.get_node('Up').connect("pressed", self, "move_level", [node, 1])
		row.get_node('Down').connect("pressed", self, "move_level", [node, -1])
		row.get_node('Bottom').connect("pressed", self, "move_to_end", [node, -1])
		row.get_node('Drop').connect("pressed", self, "drop_piece", [node])
		level -= 1


#Taking hold of a piece already in the room is the other thing the canvas can be doing, so the
#brush goes away with it: the next click moves this piece instead of standing another on top.
func select_piece(node):
	brush = ''
	sync_palette()
	set_selected(node)


func set_selected(node):
	selected = node
	show_chosen()
	sync_paint()
	refresh_placed()
	show_row(node)


#The list is taller than its window once a room fills up, so the chosen piece is scrolled to
#rather than left somewhere out of sight. The row was made a moment ago and stands nowhere yet,
#so where to scroll to is only known once the list has laid itself out - hence the frame's wait.
func show_row(node):
	if !is_instance_valid(node):
		return
	yield(get_tree(), "idle_frame")
	if !is_inside_tree() or !is_instance_valid(node):
		return
	for row in $Body/Placed/Scroll/List.get_children():
		if row.visible and row.get_meta('piece') == node:
			$Body/Placed/Scroll.ensure_control_visible(row)
			return


#Up the list is towards the front of the picture - drawn later, over the top of its neighbour.
#The template node sits first among the children and is not a piece, so the pile starts one
#past it.
func move_level(node, step):
	if !is_instance_valid(node):
		return
	var props = room().get_node("Props")
	var wanted = node.get_position_in_parent() + step
	props.move_child(node, int(clamp(wanted, lowest_level(node), props.get_child_count() - 1)))
	refresh_placed()


func move_to_end(node, step):
	if !is_instance_valid(node):
		return
	var props = room().get_node("Props")
	props.move_child(node, props.get_child_count() - 1 if step > 0 else lowest_level(node))
	refresh_placed()


#Nothing goes under the ground. The floor covers the whole room, so a piece pushed below it is
#not at the back of the picture - it is gone, with no sign left of where it went, and a chair
#that answers a button by vanishing looks like a broken bench rather than a chair at level 0.
#Under the wall is another matter: most of that picture is open air, and a rug tucked below its
#stonework is how a rug is meant to lie.
func lowest_level(node):
	if Pieces.get_piece(node.get_meta('code')).kind == 'floor':
		return 1
	for other in placed_pieces():
		if Pieces.get_piece(other.get_meta('code')).kind == 'floor':
			return other.get_position_in_parent() + 1
	return 1


#### saving and opening again ####

func room_name():
	var text = $Body/SidePane/Side/RoomName.text.strip_edges()
	return text if text != '' else 'new_room'


#Every room built so far, so a name is chosen from what is there rather than typed from memory -
#one letter out and Save quietly makes a second room instead of writing over the first.
func saved_rooms():
	var res = []
	var dir = Directory.new()
	if dir.open(LAYOUTS_DIR) != OK:
		return res
	dir.list_dir_begin(true, true)
	var found = dir.get_next()
	while found != '':
		if found.ends_with('.json'):
			res.append(found.substr(0, found.length() - 5))
		found = dir.get_next()
	dir.list_dir_end()
	res.sort()
	return res


func refresh_rooms():
	var list = $Body/SidePane/Side/Rooms/Scroll/List
	input_handler.ClearContainer(list, ['Row'])
	for name in saved_rooms():
		var row = input_handler.DuplicateContainerTemplate(list, 'Row')
		row.text = name
		row.pressed = name == room_name()
		row.connect("pressed", self, "choose_room", [name])
	show_room_name()


#Choosing one from the list only says which room is being worked on: Save writes over it, Open
#brings it back. Opening on a click would throw away whatever is on the canvas at the time.
func choose_room(name):
	$Body/SidePane/Side/RoomName.text = name
	refresh_rooms()


func on_name_typed(_text):
	refresh_rooms()


func show_room_name():
	var name = room_name()
	$Body/SidePane/Side/Save.text = 'Save "%s"' % name
	$Body/SidePane/Side/Load.text = 'Open "%s"' % name


func layout_of_room():
	var placed = []
	for node in placed_pieces():
		placed.append({code = node.get_meta('code'), x = node.rect_position.x,
			y = node.rect_position.y, paint = node.modulate.to_html(false),
			mirrored = node.flip_h})
	return {pieces = placed}


func save_room():
	var dir = Directory.new()
	dir.make_dir_recursive(LAYOUTS_DIR)
	var name = room_name()
	var file = File.new()
	file.open(LAYOUTS_DIR + name + ".json", File.WRITE)
	file.store_string(to_json(layout_of_room()))
	file.close()
	#the viewport has already drawn this frame's contents; ask it to draw once more so the
	#picture that is saved is the one on screen rather than the frame before it
	var viewport = canvas().get_node("Viewport")
	viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	yield(VisualServer, "frame_post_draw")
	var image = viewport.get_texture().get_data()
	#a viewport told to draw once turns itself off afterwards, and the canvas would sit there
	#showing the room as it was at the moment of saving however much was moved or painted after
	viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	image.flip_y()
	var path = ROOMS_DIR + name + ".png"
	var err = image.save_png(path)
	$Body/SidePane/Side/Report.text = "saved %s" % name if err == OK else "could not save (%d)" % err
	refresh_rooms()


func load_room():
	var name = room_name()
	var file = File.new()
	if !file.file_exists(LAYOUTS_DIR + name + ".json"):
		$Body/SidePane/Side/Report.text = "no layout called %s" % name
		return
	file.open(LAYOUTS_DIR + name + ".json", File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if !(data is Dictionary):
		$Body/SidePane/Side/Report.text = "layout %s is not readable" % name
		return
	clear_room()
	for entry in data.get('pieces', []):
		var piece = Pieces.get_piece(entry.get('code', ''))
		if piece == null:
			continue
		var node = place(entry.code, Vector2(0, 0))
		if !Pieces.fills_room(entry.code):
			node.rect_position = Vector2(entry.get('x', 0), entry.get('y', 0))
		node.modulate = Color(entry.get('paint', 'ffffff'))
		node.flip_h = entry.get('mirrored', false) == true
	#a layout saved before rooms carried their own ground and wall still gets them
	for code in [Pieces.default_floor(), Pieces.default_wall()]:
		if code != null and !has_kind(Pieces.get_piece(code).kind):
			place(code, Pieces.ROOM_SIZE / 2.0)
	refresh_placed()
	show_chosen()
	refresh_rooms()
	$Body/SidePane/Side/Report.text = "opened %s" % name


func has_piece(code):
	for node in placed_pieces():
		if node.get_meta('code') == code:
			return true
	return false


#### moving what is already down ####

#The arrows nudge the piece being worked on a pixel at a time, holding shift a whole grid step -
#for the last bit of a placement, where the mouse and its eight-pixel grid are too coarse. Taken
#in _input and marked handled, or the arrows would walk the focus around the buttons instead;
#while a name is being typed they belong to the writing.
const NUDGES = {KEY_LEFT: Vector2(-1, 0), KEY_RIGHT: Vector2(1, 0), KEY_UP: Vector2(0, -1),
	KEY_DOWN: Vector2(0, 1)}


func _input(event):
	if !(event is InputEventKey) or !event.pressed:
		return
	if !NUDGES.has(event.scancode) or get_focus_owner() is LineEdit:
		return
	if !is_instance_valid(selected) or Pieces.fills_room(selected.get_meta('code')):
		return
	selected.rect_position += NUDGES[event.scancode] * (GRID if event.shift else 1)
	show_chosen()
	get_tree().set_input_as_handled()


func _process(_delta):
	if dragging == null or !is_instance_valid(dragging):
		return
	var at = canvas().get_node("Catcher").get_local_mouse_position()
	dragging.rect_position = Vector2(round((at.x + drag_offset.x) / GRID) * GRID,
		round((at.y + drag_offset.y) / GRID) * GRID)
