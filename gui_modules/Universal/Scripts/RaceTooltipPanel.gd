extends tooltip_main
#The races a location can yield, as icons: in colour once the player has taken that race here, a question
#mark until then. globals.connectracetooltip attaches it. The plain text tooltip cannot hold images, which
#is the whole reason this panel exists.

const PANEL_W = 598
const ICON = 40
const PAD = 15
const TOP = 12
const GAP = 10
const UNKNOWN = "res://assets/Textures_v2/icon_question_small.png"

var location = null


func showup(node, loc):
	if _setup(node):
		location = loc


func update():
	var label = $RichTextLabel
	var row = $Races
	label.rect_position = Vector2(PAD, TOP)
	label.rect_size = Vector2(PANEL_W - PAD * 2, 10)
	label.bbcode_text = _header()
	rect_size.x = PANEL_W
	$Panel.rect_size.x = PANEL_W

	#the row's template is a TextureRect named Icon, not the helpers' default Button
	input_handler.ClearContainer(row, ['Icon'])
	var slots = globals.location_race_slots(location)
	for slot in slots:
		var icon = input_handler.DuplicateContainerTemplate(row, 'Icon')
		icon.texture = races.racelist[slot.race].icon if slot.known else load(UNKNOWN)
		icon.modulate = Color(1, 1, 1, 1) if slot.known else Color(1, 1, 1, 0.5)
	yield(get_tree(), 'idle_frame')

	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	var text_height = ceil(label.get_content_height())
	#a tooltip never scrolls, and a label left scrollable keeps the offset it had at height 10
	label.scroll_active = false
	label.rect_size.y = text_height + 4
	var height = text_height + TOP * 2
	if !slots.empty():
		row.rect_position = Vector2(PAD, TOP + text_height + GAP)
		height = TOP + text_height + GAP + ICON + TOP
	row.visible = !slots.empty()
	rect_size.y = height
	$Panel.rect_size.y = height
	_place()
	emit_signal("update_completed")


func _header():
	if !(location is Dictionary):
		return ""
	var lines = ["[color=#dbc281]" + tr(location.get('name', '')) + "[/color]"]
	var kind = location.get('classname', '')
	if location.get('tags', []).has('quest'):
		kind = "QUESTLOCATION"
	if kind != '':
		lines.append(tr(kind))
	return PoolStringArray(lines).join("\n")


#Below the hovered node, flipped above it when there is no room, and clamped inside the screen - the same
#rules the text tooltip follows.
func _place():
	var screen = get_viewport().get_visible_rect()
	var anchor = input_handler.get_real_global_rect(parentnode, true)
	var pos = Vector2(anchor.position.x, anchor.end.y + 10)
	if pos.y + rect_size.y > screen.end.y:
		pos.y = anchor.position.y - rect_size.y - 10
	pos.x = clamp(pos.x, screen.position.x, max(screen.position.x, screen.end.x - rect_size.x))
	pos.y = clamp(pos.y, screen.position.y, max(screen.position.y, screen.end.y - rect_size.y))
	set_global_position(pos)
