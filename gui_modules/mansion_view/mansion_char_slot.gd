extends Button
#One place inside a room - a bed in sleep mode, a workplace in work mode. Filled places
#show the character's portrait, empty ones stay blank, the same shape the job screen uses
#for workers (Mansion/Scripts/MansionJobModule.gd show_faces).
#
#It is both a drag source and a drop target: dragging lifts the person out, dropping puts
#somebody in. A workplace held by somebody who is away from the mansion is drawn faded -
#they keep it and walk back into it on their own, unless a character who is actually here
#takes it from them.
#
#Clicking does the same thing in two halves rather than one gesture: a click lifts the
#person out, the next click on a place puts them there. Both ways go through the view's
#place_character(), and both ask can_drop_data() whether a place will have them.

const MansionLayout = preload("res://src/core/mansion_layout.gd")

const COLOR_SLEEP = Color('4a5f7a')
const COLOR_WORK = Color('6b5a3f')
#builders read differently from workers on purpose - they are the thing holding a room up
const COLOR_BUILD = Color('8a6f2e')
const COLOR_EMPTY = Color(1, 1, 1, 0.12)
#the same yellow a picked-up room wears in rearrange mode
const COLOR_PICKED = Color('f9e181')

var view = null
#'sleep' | 'work' | 'build' inside the mansion, 'task' for work at another location -
#in which case "holder" is a task id rather than a slot code
var kind = 'work'
var holder = ''
var char_id = null


func setup(view_node, place_kind, place_owner, character):
	view = view_node
	kind = place_kind
	holder = place_owner
	char_id = character
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	refresh()


func is_away():
	if char_id == null:
		return false
	return !view.is_present(view.get_character(char_id))


func is_picked():
	return char_id != null and view.picked_char == char_id


func refresh():
	modulate = target_modulate()
	if char_id == null:
		$bg.color = COLOR_EMPTY
		$icon.texture = null
		globals.connecttexttooltip(self, empty_tooltip(), true)
		return
	var character = view.get_character(char_id)
	if character == null:
		$icon.texture = null
		return
	$bg.color = COLOR_PICKED if is_picked() else kind_color()
	#a place is only ~34px wide, so the name lives in the tooltip and on the room card
	$icon.texture = character.get_icon()
	if $icon.texture == null:
		$icon.texture = character.get_class_icon()
	input_handler.queue_portrait(character)
	var text = character.get_short_name()
	if is_away():
		text += "\n" + tr("MANSIONVIEW_AWAYHINT")
	text += "\n" + tr("MANSIONVIEW_PUTBACKHINT" if is_picked() else "MANSIONVIEW_PICKHINT")
	globals.connecttexttooltip(self, text, true)


func empty_tooltip():
	if view.picked_char != null:
		return tr("MANSIONVIEW_EMPTYSLOT") + "\n" + tr("MANSIONVIEW_PUTHINT")
	return tr("MANSIONVIEW_EMPTYSLOT")


#With somebody in hand the row reads as a set of targets, so whatever will not take them
#steps back. Whether it will is the very question a drag asks, asked the same way.
func target_modulate():
	if view.picked_char != null and !is_picked() \
			and !can_drop_data(Vector2.ZERO, view.pick_data()):
		return Color(0.4, 0.4, 0.4, 1)
	#away but still holding the place: faded, not gone
	return Color(1, 1, 1, 0.45) if is_away() else Color(1, 1, 1, 1)


#The click half of moving people. With empty hands a filled place hands its person over and
#an empty one opens the room's card; with somebody in hand this is where they go. Taking
#them out of a place altogether is a click on the top panel, or the list on the card.
func on_pressed():
	if view.mode == 'rearrange':
		return
	if view.picked_char != null:
		if is_picked():
			view.clear_char_pick()
		else:
			view.place_picked(kind, holder, char_id)
		return
	if char_id == null:
		if kind != 'task':
			view.open_card(holder)
		return
	view.pick_character(char_id, holder, kind)


func kind_color():
	match kind:
		'sleep':
			return COLOR_SLEEP
		'build':
			return COLOR_BUILD
	return COLOR_WORK


func get_drag_data(_position):
	if char_id == null or view.mode == 'rearrange':
		return null
	var character = view.get_character(char_id)
	if character == null:
		return null
	var preview = TextureRect.new()
	preview.texture = $icon.texture
	preview.expand = true
	preview.rect_size = Vector2(64, 64)
	set_drag_preview(preview)
	return {kind = 'mansion_char', char_id = char_id, from_slot = holder, from_kind = kind}


func can_drop_data(_position, data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return false
	if view.mode == 'rearrange':
		return false
	if data.char_id == char_id:
		return false
	if char_id == null:
		return true
	#an occupied place gives way when the two can trade, or when a workplace is being held
	#by somebody who is not even in the mansion
	if kind == 'sleep':
		return true
	#a workplace or scaffolding gives way only when whoever holds it is not even here
	return is_away()


func drop_data(_position, data):
	view.place_character(kind, holder, data.char_id, char_id)
