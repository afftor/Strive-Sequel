extends Button
#One portrait in the top strip. It hands its person over and nothing else - everything that
#can be done with them is done where they are put down, whether they were dragged there or
#carried there by a second click.

#the same yellow a picked-up room wears in rearrange mode
const COLOR_PICKED = Color(1.5, 1.4, 0.8)
#somebody the mansion will not take: shown, so the player can see they are idle and why, but
#not picked up and carried to a refusal
const COLOR_BLOCKED = Color(1, 0.45, 0.45)

#What a compact cell keeps: the portrait, at a size a whole party still fits across a panel.
#The name it drops is the one thing that was never load-bearing - it is in the tooltip too.
const COMPACT_SIZE = Vector2(44, 44)
const COMPACT_INSET = 3.0
#the mark that says what a busy portrait is busy with, at the size a 44px cell can carry
const COMPACT_MARK = Vector2(18, 18)

var view = null
var char_id = null
#A cell in the lower strip stands for somebody already at work: it wears what they are doing,
#and carried onto a place it moves them there rather than taking them out of nothing.
var busy = false


func setup(view_node, character, compact = false, at_work = false):
	view = view_node
	char_id = character
	busy = at_work
	if compact:
		apply_compact()
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	#the household list has offered a menu on a right click for a while; these are the same
	#people, so the same gesture offers the same menu
	if !is_connected("gui_input", self, "on_cell_input"):
		connect("gui_input", self, "on_cell_input")
	refresh()


func apply_compact():
	rect_min_size = COMPACT_SIZE
	rect_size = COMPACT_SIZE
	$name.visible = false
	$icon.rect_position = Vector2(COMPACT_INSET, COMPACT_INSET)
	$icon.rect_size = COMPACT_SIZE - Vector2(COMPACT_INSET, COMPACT_INSET) * 2
	#The mark for what somebody is busy with is drawn in the corner of the portrait, so it has
	#to shrink with the portrait: left at the size it has in the scene it hung half outside a
	#compact cell, which is the only size the strip is ever drawn at inside the mansion.
	#its minimum comes from the scene, where the cell is half again this size, and a rect_size
	#below that minimum is simply ignored - so the floor has to come down first
	$assignment.rect_min_size = COMPACT_MARK
	$assignment.rect_size = COMPACT_MARK
	$assignment.rect_position = COMPACT_SIZE - COMPACT_MARK - Vector2(COMPACT_INSET, COMPACT_INSET)


func is_picked():
	return char_id != null and view.picked_char == char_id


#Why this person cannot be put to work, as the key that says so - or "" when they can. The
#same question assign_worker() asks before it refuses, asked here instead so the refusal is
#read off the portrait rather than after dragging it across the screen.
func blocked_reason():
	var person = view.get_character(char_id)
	if person == null:
		return ""
	#beds are for everyone; only work is refused
	if view.mode == 'sleep':
		return ""
	if !person.is_worker():
		#is_worker() refuses for two quite different reasons, and "they will not work for you"
		#answers neither of them. A slave without a trainer is a thing the player can go and
		#fix; anybody else simply is not one of the household's workers.
		if person.get_stat('slave_class') == 'slave':
			return "MANSIONVIEW_ERR_NOTRAINER"
		return "MANSIONVIEW_ERR_NOTWORKER"
	#"Away" means away from the place being looked at, not away from the mansion. Somebody
	#standing in Millford is exactly who the Millford panel is offering work to; asking
	#whether they are home instead greyed out every single person on every location.
	if !view.person_is_here(person):
		return "MANSIONVIEW_ERR_AWAY"
	return ""


func is_blocked():
	return blocked_reason() != ""


#The click alternative to dragging: this lifts them, the next click on a place puts them
#there, and clicking them again sets them back down where they were. Both gestures go
#through the screen's carrying protocol, so they lift and refuse in exactly the same cases.
func on_pressed():
	view.begin_carry_click(self)


func refresh():
	modulate = COLOR_PICKED if is_picked() else Color(1, 1, 1, 1)
	if !is_picked() and is_blocked():
		modulate = COLOR_BLOCKED
	var person = view.get_character(char_id)
	if person == null:
		$icon.texture = null
		$name.text = ""
		return
	$icon.texture = person.get_icon()
	if $icon.texture == null:
		$icon.texture = person.get_class_icon()
	#portraits are rendered a few frames late, so ask and let the next rebuild pick it up
	input_handler.queue_portrait(person)
	$name.text = person.get_short_name()
	var work = view.assignment_of(char_id) if busy else null
	$assignment.visible = work != null and work.icon != null
	if $assignment.visible:
		$assignment.texture = work.icon
	view.connect_char_tooltip(self, person, build_tooltip(person), build_hint())


func on_cell_input(event):
	if !(event is InputEventMouseButton) or !event.pressed:
		return
	if event.button_index != BUTTON_RIGHT:
		return
	var person = view.get_character(char_id)
	if person == null:
		return
	accept_event()
	view.open_char_menu(person, get_global_rect().position + Vector2(get_global_rect().size.x, 0))


func build_tooltip(person):
	var text = person.get_short_name()
	if busy:
		var work = view.assignment_of(char_id)
		if work != null and work.text != "":
			text += "\n" + work.text
	if view.mode == 'sleep':
		text += "\n" + tr("MANSIONVIEW_NOBEDHINT")
	var blocked = blocked_reason()
	if blocked != "":
		#the whole of why they are sitting idle and cannot be moved out of it
		return person.translate(tr(blocked))
	return text


#What the mouse can do with them. The panel keeps this at its foot, apart from who they
#are - somebody who cannot be moved at all is told why instead, in build_tooltip.
#The menu is on the right button whatever else the cell will or will not do, so that line
#stands even for somebody who cannot be moved at all.
func build_hint():
	var lines = []
	if blocked_reason() == "":
		lines.append(tr("MANSIONVIEW_PUTBACKHINT" if is_picked() else "MANSIONVIEW_PICKHINT"))
	lines.append(tr("MANSIONVIEW_MENUHINT"))
	return PoolStringArray(lines).join("\n")


#The portraits stand on top of the panel and stop events, so a person dragged out of a room
#and let go over one of them never reached the panel underneath - the drop only landed in the
#gaps between icons. A cell hands that drop on rather than eating it: dropping somebody "on
#the idle list" is one gesture wherever in the list it lands.
func refusal_for(data):
	return view.rest_panel.refusal_for(data)


func take_carried(data):
	return view.rest_panel.take_carried(data)


func can_drop_data(_position, data):
	return refusal_for(data) == ''


func drop_data(_position, data):
	take_carried(data)


#### the carrying protocol ####

func carry_data():
	if char_id == null:
		return null
	#'work' either way: somebody carried out of the lower strip is being taken off the job
	#they hold, which is what release_character() does for a portrait dragged off a room.
	var kind = 'work' if busy else view.mode
	return {kind = 'mansion_char', char_id = char_id, from_slot = null, from_kind = kind}


#Lifting somebody the mansion will not put to work only ends in a refusal on the way down,
#so it is refused at the near end where there is a portrait to point at.
func carry_refusal():
	return blocked_reason()


func carry_texture():
	return $icon.texture


func get_drag_data(_position):
	return view.begin_carry_drag(self)
