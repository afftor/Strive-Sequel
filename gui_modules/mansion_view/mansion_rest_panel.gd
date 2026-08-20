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
func apply_layout(width):
	var step = COMPACT_CELL.x + CELL_GAP
	var columns = int(max(1, floor((width - 20 + CELL_GAP) / step)))
	$Scroll/List.columns = columns
	var rows = int(max(1, ceil(float(portrait_count()) / columns)))
	return TITLE_HEIGHT + min(rows, MAX_ROWS) * (COMPACT_CELL.y + CELL_GAP) + 6


func portrait_count():
	var res = 0
	for cell in $Scroll/List.get_children():
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
	$Warning.visible = view.mode == 'sleep' and !ids.empty()
	#with somebody in hand who came out of a room, the panel is where they are set free
	self_modulate = COLOR_TARGET if accepts_pick() else Color(1, 1, 1, 1)
	input_handler.ClearContainer($Scroll/List)
	for char_id in ids:
		var cell = input_handler.DuplicateContainerTemplate($Scroll/List)
		cell.setup(view, char_id, view.embedded)
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
