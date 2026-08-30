extends Panel
#The strip of portraits along the top. It is the pool the player drags people out of, and
#what it holds depends on the mode:
#	work  - everyone who is in the mansion and has no job. This is Rest.
#	sleep - everyone without a bed. In a settled mansion it is empty; anything left in it
#	        is what blocks the end of the turn.
#
#Characters who are away from the mansion never appear here. They are still drawn, faded,
#on whatever workplace they hold, because they walk back into it on their own.
#
#It is also where somebody is put down to be taken out of wherever they were - by dropping
#them on it, or by clicking it while carrying them.

const COLOR_TARGET = Color(1.5, 1.45, 1.0)

var view = null


func setup(view_node):
	view = view_node
	$HouseButton.connect("pressed", self, "house_everyone")
	$HouseButton.text = tr("MANSIONVIEW_HOUSEALL")


#Embedded the strip has a slice of a panel rather than the top of a screen, so the portraits
#lose their names to the tooltip and shrink to something a row of thirty still fits in.
const COMPACT_CELL = Vector2(44, 44)
const CELL_GAP = 6
#the title and its warning share the line above the portraits
const TITLE_HEIGHT = 30
#past this the strip scrolls rather than growing further down the screen
const MAX_ROWS = 3


#How wide the strip is decides how many portraits fit across it, and that decides how many
#rows a household needs - which is what the panel's own height comes out of. Returns that
#height so the screen can put everything below the strip underneath whatever it turns out to
#be, rather than under a number written down in advance.
#Two strips, one above the other, and the panel is as tall as they turn out to be. It places
#them itself: the screen used to stretch the one Scroll over everything below the title, which
#is exactly the space the second strip needs.
func apply_layout(width):
	var step = COMPACT_CELL.x + CELL_GAP
	var columns = int(max(1, floor((width - 20 + CELL_GAP) / step)))
	var inner = max(10, width - 20)
	$Scroll/List.columns = columns
	$BusyScroll/BusyList.columns = columns
	place($Title, Rect2(10, 4, 220, 24))
	#the button sits at the right-hand end of the title line, and the warning stops short of it
	var button_width = 260
	var warning_width = max(10, width - 248 - (button_width + 12 if $HouseButton.visible else 0))
	place($Warning, Rect2(238, 4, warning_width, 24))
	if $HouseButton.visible:
		place($HouseButton, Rect2(width - button_width - 10, 2, button_width, 28))
	var idle = strip_height(portrait_count($Scroll/List), columns)
	place($Scroll, Rect2(10, TITLE_HEIGHT, inner, idle))
	var height = TITLE_HEIGHT + idle + 6
	#the second strip takes room only when it has somebody in it
	if $BusyTitle.visible:
		#the row is as tall as the label's own font asks for, not a number guessed here - two
		#pixels short of that and the strip below it started inside the title
		var row = max(24.0, $BusyTitle.get_combined_minimum_size().y)
		place($BusyTitle, Rect2(10, height, 220, row))
		var busy = strip_height(portrait_count($BusyScroll/BusyList), columns)
		place($BusyScroll, Rect2(10, height + row + 4, inner, busy))
		height += row + 4 + busy + 6
	return height


func place(node, rect):
	node.rect_position = rect.position
	node.rect_size = rect.size


func strip_height(count, columns):
	var rows = int(max(1, ceil(float(count) / columns)))
	return min(rows, MAX_ROWS) * (COMPACT_CELL.y + CELL_GAP)


func portrait_count(list):
	var res = 0
	for cell in list.get_children():
		if cell.visible and !cell.is_queued_for_deletion():
			res += 1
	return res


func rebuild():
	#while rooms are being moved the panel has nothing to offer, and it sits over the top
	#of the plan - so it steps out of the way entirely rather than swallowing drops meant
	#for a room underneath it
	if view.mode == 'rearrange':
		visible = false
		return
	#embedded this panel is the lower half of the slave list's own bar, and goes away with it
	visible = view.hud_visible
	var ids = view.resting_characters()
	$Title.text = "%s (%d)" % [label_for_mode(), ids.size()]
	#the wording lives here now rather than baked into the scene: the sentence changed when the
	#turn stopped depending on it, and it is a line the player reads, so it is a key like any other
	$Warning.text = tr("MANSIONVIEW_NOBEDWARNING")
	$Warning.visible = view.mode == 'sleep' and !ids.empty()
	#Only while there is somebody to bed down and a bed to put them in: a button that would
	#answer "nowhere to put them" is a button that should not be there.
	$HouseButton.visible = $Warning.visible and view.free_beds() > 0
	#with somebody in hand who came out of a room, the panel is where they are set free
	self_modulate = COLOR_TARGET if accepts_pick() else Color(1, 1, 1, 1)
	input_handler.ClearContainer($Scroll/List)
	for char_id in ids:
		var cell = input_handler.DuplicateContainerTemplate($Scroll/List)
		cell.setup(view, char_id, view.embedded)
	#Under the idle row, everyone here who is already at work and could be put on something
	#else. Beds mode has no such row - there the strip above lists people with nowhere to
	#sleep, and what they do by day does not come into it.
	var busy = view.working_characters()
	$BusyTitle.visible = !busy.empty()
	$BusyScroll.visible = !busy.empty()
	$BusyTitle.text = "%s (%d)" % [tr("MANSIONVIEW_ATWORK"), busy.size()]
	input_handler.ClearContainer($BusyScroll/BusyList)
	for char_id in busy:
		var cell = input_handler.DuplicateContainerTemplate($BusyScroll/BusyList)
		cell.setup(view, char_id, view.embedded, true)
	#how many portraits there are is what the strip's height comes out of, so everything the
	#screen puts below it has to be placed again now that the number has changed
	view.lay_out_hud()


func label_for_mode():
	match view.mode:
		'sleep':
			return tr("MANSIONVIEW_UNHOUSED")
		'rearrange':
			return tr("MANSIONVIEW_REST")
	return tr("MANSIONVIEW_REST")


#Everybody without a bed, put wherever there is room - the same seating the estate does for
#itself when a room is built or somebody arrives, offered here as a button because a household
#of fifteen is a lot of dragging.
func house_everyone():
	var seated = ResourceScripts.game_res.autohouse_household()
	if seated <= 0:
		input_handler.SystemMessage(tr("MANSIONVIEW_HOUSEALLNONE"))
		return
	input_handler.SystemMessage(tr("MANSIONVIEW_HOUSEALLDONE") % seated)
	view.refresh_people()
	rebuild()


#### the carrying protocol ####

#The idle strip takes anybody: putting somebody down here is what "stop doing that" means,
#and somebody already idle is simply set down again. Dropping and clicking both come through
#refusal_for / take_carried, so the strip cannot accept one gesture and refuse the other.
func refusal_for(data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return 'MANSIONVIEW_ERR_VOID'
	return ''


func take_carried(data):
	view.release_character(data.char_id, data.get('from_kind', 'work'))
	return true


func can_drop_data(_position, data):
	return refusal_for(data) == ''


func drop_data(_position, data):
	take_carried(data)


#Lit only when there is something to undo - somebody who came out of a room. Anyone already
#idle is welcome here too, but saying so would light the strip for no reason.
func accepts_pick():
	var carried = view.pick_data()
	return carried != null and refusal_for(carried) == '' \
		and carried.get('from_slot', null) != null


func _gui_input(event):
	if view.picked_char == null:
		return
	if !(event is InputEventMouseButton) or !event.pressed or event.button_index != BUTTON_LEFT:
		return
	view.drop_carried_on(self)
	accept_event()
