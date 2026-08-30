extends "res://gui_modules/Universal/Scripts/tooltip_main.gd"
#What a character portrait on the mansion screen says when the mouse rests on it: the line the
#plain text tooltip used to carry - the name, the work, how to pick them up - and then the four
#numbers the expanded card leads with, the tools they are carrying, and the buffs on them.
#
#It is its own panel rather than the text tooltip because none of that can be said in text: the
#tools and the buffs are pictures. The rows are all templates in the scene; nothing here builds
#a node.
#
#The four stats are read and shown exactly as MansionSlaveExpandedDetails.build_overview() reads
#and shows them, so the hover and the card can never disagree.

const STATS = ["physics", "wits", "charm", "productivity"]
const STAT_ICONS = {
	physics = preload("res://assets/images/gui/gui icons/icon_physics.png"),
	wits = preload("res://assets/images/gui/gui icons/icon_wits.png"),
	charm = preload("res://assets/images/gui/gui icons/icon_charm.png"),
	productivity = preload("res://assets/images/gui/inventory/icon_craft1.png"),
}

var person = null
var header = ""
var hint = ""

onready var body = $Panel/Margin/Body
onready var header_label = $Panel/Margin/Body/Header
onready var stat_rows = $Panel/Margin/Body/Stats
onready var tool_row = $Panel/Margin/Body/Tools
onready var buff_row = $Panel/Margin/Body/Buffs
onready var hint_label = $Panel/Margin/Body/Hint
onready var hint_rule = $Panel/Margin/Body/HintRule


#Hover a portrait: the cell hands over who it is drawing and the line it wants at the top.
func showup(node, who, text, foot = ""):
	if !_setup(node):
		return
	person = who
	header = text
	hint = foot


func update():
	fill(person, header, hint)
	#the panel is only as big as what went into it, and that size is not known until the
	#containers have laid themselves out
	yield(get_tree(), "idle_frame")
	if !weakref(parentnode).get_ref():
		emit_signal("update_completed")
		return
	rect_size = $Panel.get_combined_minimum_size()
	place_beside(input_handler.get_real_global_rect(parentnode, true))
	emit_signal("update_completed")


#Filling and placing are apart so a test can fill the panel without a mouse.
#The hint - drag them, put them back - is not about the character at all, it is about what the
#mouse can do next, so it sits at the foot under a rule rather than between the name and what
#the panel came here to say.
func fill(who, text, foot = ""):
	person = who
	header = text
	hint = foot
	header_label.bbcode_text = text
	hint_label.text = foot
	hint_label.visible = foot != ""
	hint_rule.visible = foot != ""
	if !is_instance_valid(who):
		stat_rows.visible = false
		tool_row.visible = false
		buff_row.visible = false
		return
	build_stats(who)
	build_tools(who)
	globals.build_buffs_for_char(who, buff_row, 'mansion')
	#That builder hangs a tooltip on every buff it draws, and this panel is already a tooltip:
	#a second one opening over the first is a panel the player never asked for and cannot read
	#past. The pictures speak here; the words are on the character's own screen.
	for icon in buff_row.get_children():
		globals.disconnect_text_tooltip(icon)
	buff_row.visible = shown_children(buff_row) > 0


func build_stats(who):
	input_handler.ClearContainer(stat_rows, ['Row'])
	for code in STATS:
		var row = input_handler.DuplicateContainerTemplate(stat_rows, 'Row')
		row.get_node("Icon").texture = STAT_ICONS[code]
		row.get_node("Value").text = stat_text(who, code)
	stat_rows.visible = true


#Productivity is a percentage; the other three read as what they are out of what they could be.
func stat_text(who, code):
	if code == "productivity":
		return "%d%%" % int(floor(who.get_stat(code)))
	return "%d / %d" % [int(floor(who.get_stat(code))),
		int(floor(who.get_stat(code + "_cap") + who.get_stat(code + "_bonus")))]


#Only the tools: the rest of what somebody is wearing is the inventory screen's business, and a
#row of eleven pictures would say nothing at a glance. A tool is what decides whether they can
#do the work they are standing at, which is why it belongs beside the numbers.
#No tooltip of their own - see the buffs above.
func build_tools(who):
	input_handler.ClearContainer(tool_row, ['Entry'])
	var stock = ResourceScripts.game_res.items
	for slot in who.equipment.gear:
		if !str(slot).begins_with('tool_'):
			continue
		#a slot holds the id of an item in the estate's stock, not the item itself
		var item_id = who.equipment.gear[slot]
		if item_id == null or !stock.has(item_id):
			continue
		var item = stock[item_id]
		var entry = input_handler.DuplicateContainerTemplate(tool_row, 'Entry')
		item.set_icon(entry.get_node("Icon"))
	tool_row.visible = shown_children(tool_row) > 0


func shown_children(holder):
	var res = 0
	for child in holder.get_children():
		if child.visible and !child.is_queued_for_deletion():
			res += 1
	return res


#Beside the portrait, never over it and never off the screen: the strip runs along the top of the
#mansion, so the panel drops below what is hovered and only climbs above it when there is no room
#underneath.
func place_beside(anchor):
	var screen = get_viewport().get_visible_rect()
	var pos = Vector2(anchor.position.x, anchor.end.y + 8)
	if pos.y + rect_size.y > screen.size.y:
		pos.y = anchor.position.y - rect_size.y - 8
	if pos.x + rect_size.x > screen.size.x:
		pos.x = screen.size.x - rect_size.x - 8
	pos.x = max(8, pos.x)
	pos.y = max(8, pos.y)
	set_global_position(pos)
	return Rect2(pos, rect_size)
