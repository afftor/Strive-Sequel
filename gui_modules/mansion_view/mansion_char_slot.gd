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
#person out, the next click on a place puts them there. It is a source and a target under the
#screen's one carrying protocol - carry_data / carry_refusal to be lifted from, refusal_for /
#take_carried to be put down on - so a drag and a click cannot mean different things here.

const MansionLayout = preload("res://src/core/mansion_layout.gd")
#An empty builder's place says what it is waiting for. A row of blank squares gave no sign
#that the scaffolding wanted hands, so a paid-for room could stand half-built with nothing
#on the screen asking for anybody.
const ICON_BUILD = preload("res://assets/images/gui/inventory/tool_hammer.png")

const COLOR_SLEEP = Color('4a5f7a')
#The master's own bed, which is never anybody else's however many are added beside it. A colour
#rather than a kind of its own: 'sleep' is what the pinning rule and the drop checks are written
#against, and a fourth kind would have had to be added to every one of them to say one thing
#about how it looks.
const COLOR_SLEEP_MASTER = Color('7a5a46')
const COLOR_WORK = Color('6b5a3f')
#a place an upgrade paid for, so what widening a room bought can be seen at a glance
const COLOR_WORK_UPGRADE = Color('4f6b52')
#a place for a different job in the same room - the tutor rather than another pupil
const COLOR_WORK_SPECIAL = Color('5a4a6b')
#builders read differently from workers on purpose - they are the thing holding a room up
const COLOR_BUILD = Color('8a6f2e')
const COLOR_EMPTY = Color(1, 1, 1, 0.12)
#the same yellow a picked-up room wears in rearrange mode
const COLOR_PICKED = Color('f9e181')
#Whoever would be turned out to make room for the person in hand. A full workroom takes a
#newcomer by trading, so the question the player is actually asking - "who goes instead?" - is
#answered on the faces before the drop rather than after it.
const COLOR_SWAP = Color('a8552e')

var view = null
#'sleep' | 'work' | 'build' inside the mansion, 'task' for work at another location -
#in which case "holder" is a task id rather than a slot code
var kind = 'work'
#set before setup() by whoever builds the row - see mansion_slot_node.places_for_mode()
var master_bed = false
var holder = ''
var holder_floor = -1
var char_id = null


#"place_floor" names the floor the holder sits on, for the one caller whose places are not on
#the floor being shown: the estate grounds are drawn by the local tasks screen while the plan
#behind it is still on a floor of the house. -1 means "whichever floor is on screen".
func setup(view_node, place_kind, place_owner, character, place_floor = -1):
	view = view_node
	kind = place_kind
	holder = place_owner
	char_id = character
	holder_floor = place_floor
	if !is_connected("pressed", self, "on_pressed"):
		connect("pressed", self, "on_pressed")
	refresh()


#Away from the place being looked at, not away from the mansion. Somebody working in Millford
#is exactly where the Millford panel expects them; asking whether they were home instead drew
#every worker on every location faded, as though they had wandered off.
func is_away():
	if char_id == null:
		return false
	return !view.person_is_here(view.get_character(char_id))


func is_picked():
	return char_id != null and view.picked_char == char_id


func refresh():
	modulate = target_modulate()
	if char_id == null:
		#An empty place still says which kind it is. Drawn all one grey, the three colours only
		#appeared once somebody was standing in them - and which places an upgrade paid for is
		#worth seeing while deciding whether to buy it, not afterwards.
		$bg.color = empty_color()
		$icon.texture = ICON_BUILD if kind == 'build' else null
		#dimmed, so it reads as a place waiting to be filled rather than as somebody standing in it
		$icon.self_modulate = Color(1, 1, 1, 0.55)
		globals.connecttexttooltip(self, empty_tooltip(), true)
		return
	var character = view.get_character(char_id)
	if character == null:
		$icon.texture = null
		return
	if is_picked():
		$bg.color = COLOR_PICKED
	elif would_be_swapped_out():
		$bg.color = COLOR_SWAP
	else:
		$bg.color = kind_color()
	#a place is only ~34px wide, so the name lives in the tooltip and on the room card
	$icon.self_modulate = Color(1, 1, 1, 1)
	$icon.texture = character.get_icon()
	if $icon.texture == null:
		$icon.texture = character.get_class_icon()
	input_handler.queue_portrait(character)
	var text = character.get_short_name()
	#What they are worth here this turn, between the name and the hints: the hints are about what
	#the mouse can do next, this is about the person the mouse is over.
	var made = view.person_yield_text(character, kind, holder, holder_floor)
	if made != "":
		text += "\n" + made
	if is_away():
		text += "\n" + tr("MANSIONVIEW_AWAYHINT")
	if would_be_swapped_out():
		text += "\n" + tr("MANSIONVIEW_SWAPHINT")
	else:
		text += "\n" + tr("MANSIONVIEW_PUTBACKHINT" if is_picked() else "MANSIONVIEW_PICKHINT")
	globals.connecttexttooltip(self, text, true)


func empty_tooltip():
	#scaffolding asks for builders by name rather than calling itself a free slot
	var what = tr("MANSIONVIEW_BUILDINGHINT" if kind == 'build' else "MANSIONVIEW_EMPTYSLOT")
	if view.carried_data() != null:
		return what + "\n" + tr("MANSIONVIEW_PUTHINT")
	return what


#Somebody is in hand, this place is taken, and it would take them anyway - so the person
#standing here is the one who would be turned out for them. Asked through can_drop_data, the
#way the drop itself asks, so the mark cannot promise a trade that would then be refused.
func would_be_swapped_out():
	var carried = view.carried_data()
	if char_id == null or carried == null or is_picked():
		return false
	return can_drop_data(Vector2.ZERO, carried)


#With somebody in hand the row reads as a set of targets, so whatever will not take them
#steps back. Whether it will is the very question a drag asks, asked the same way.
func target_modulate():
	var carried = view.carried_data()
	if carried != null and !is_picked() and !can_drop_data(Vector2.ZERO, carried):
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
		#clicking whoever is in hand is how they are set back down; anybody else goes here
		if is_picked():
			view.clear_char_pick()
		else:
			view.drop_carried_on(self)
		return
	if char_id == null:
		if kind != 'task':
			view.open_card(holder)
		return
	view.begin_carry_click(self)


func empty_color():
	if kind in ['work', 'work_upgrade', 'work_special']:
		var tint = kind_color()
		return Color(tint.r, tint.g, tint.b, 0.30)
	return COLOR_EMPTY


func kind_color():
	match kind:
		'sleep':
			return COLOR_SLEEP_MASTER if master_bed else COLOR_SLEEP
		'build':
			return COLOR_BUILD
		'work_upgrade':
			return COLOR_WORK_UPGRADE
		'work_special':
			return COLOR_WORK_SPECIAL
	return COLOR_WORK


#### the carrying protocol ####

func carry_data():
	if char_id == null or view.mode == 'rearrange' or view.get_character(char_id) == null:
		return null
	return {kind = 'mansion_char', char_id = char_id, from_slot = holder, from_kind = kind}


#A place hands over whoever stands in it without conditions - where they may go instead is
#the receiving end's business, and it is asked there.
func carry_refusal():
	return ''


func carry_texture():
	return $icon.texture


func get_drag_data(_position):
	return view.begin_carry_drag(self)


func refusal_for(data):
	if !(data is Dictionary) or data.get('kind', '') != 'mansion_char':
		return 'MANSIONVIEW_ERR_VOID'
	if view.mode == 'rearrange':
		return 'MANSIONVIEW_ERR_VOID'
	#nobody is put into the place they are already standing in. A click never gets this far -
	#setting them back down is handled before anything is asked - so it is only the drag that
	#needs telling, and a drag reads any refusal as the same silent no
	if data.char_id == char_id:
		return 'MANSIONVIEW_ERR_VOID'
	#The master's own room keeps him, so every other BED steps back rather than letting him be
	#dropped into it and quietly taken out of his. Only beds: where he sleeps has nothing to
	#do with whether he can take a turn at a workbench or on somebody's scaffolding, and
	#refusing those told him he sleeps elsewhere when he was being put to work.
	if kind == 'sleep' and view.is_pinned(data.char_id):
		return 'MANSIONVIEW_ERR_MASTERPINNED'
	#Every occupied place gives way: the two trade, and whoever was here takes the place the
	#newcomer came from. Dropping somebody onto the person you mean to replace is the obvious
	#gesture, and workplaces used to refuse it unless their holder was out of the house.
	return ''


func take_carried(data):
	return view.place_character(kind, holder, data.char_id, char_id, holder_floor)


func can_drop_data(_position, data):
	return refusal_for(data) == ''


func drop_data(_position, data):
	take_carried(data)
