extends PanelContainer

const MAX_MESSAGES = 50

const EVENT_CONFIG = {
	"arrival": {
		label = "MANSION_ACTIVITY_TYPE_ARRIVAL",
		icon = preload("res://assets/Textures_v2/MANSION/icon_travel_small.png"),
		color = Color("72c8d9"),
	},
	#Everything that came off the benches over one turn - one row for the whole household, with
	#the line per finished product, in that product's quality colour, folded away behind it.
	#Built the same way the service report is: see globals.mansion_activity_craft().
	"craft": {
		label = "MANSION_ACTIVITY_TYPE_CRAFT",
		icon = preload("res://assets/Textures_v2/MANSION/icon_craft_small.png"),
		color = Color("e8aa55"),
	},
	"upgrade": {
		label = "MANSION_ACTIVITY_TYPE_UPGRADE",
		icon = preload("res://assets/Textures_v2/MANSION/icon_upgrades_small.png"),
		color = Color("d7bc68"),
	},
	"food": {
		label = "MANSION_ACTIVITY_TYPE_FOOD",
		icon = preload("res://assets/Textures_v2/Universal/Icons/icon_foodperday.png"),
		color = Color("e88761"),
	},
	"recovery": {
		label = "MANSION_ACTIVITY_TYPE_RECOVERY",
		icon = preload("res://assets/images/traits/health.png"),
		color = Color("77d38b"),
	},
	"population": {
		label = "MANSION_ACTIVITY_TYPE_POPULATION",
		icon = preload("res://assets/Textures_v2/Universal/Icons/icon_population.png"),
		color = Color("e8963c"),
	},
	"quest_task": {
		label = "MANSION_ACTIVITY_TYPE_QUEST_TASK",
		icon = preload("res://assets/Textures_v2/MANSION/quest_task.png"),
		color = Color("c89be8"),
	},
	#Scaffolding coming down: a room raised, a cluttered one cleared out, an improvement
	#finished. game_res.process_room_builds() is the only thing that writes these.
	"build": {
		label = "MANSION_ACTIVITY_TYPE_BUILD",
		icon = preload("res://assets/images/gui/inventory/tool_hammer.png"),
		color = Color("c9a06a"),
	},
	#The rest of what the estate got through in a turn - what turned up under the rubble, a
	#habit drilled out of somebody in the practice room.
	"work": {
		label = "MANSION_ACTIVITY_TYPE_WORK",
		icon = preload("res://assets/Textures_v2/MANSION/icon_gears_small.png"),
		color = Color("b8b0a0"),
	},
	"character_found": {
		label = "MANSION_ACTIVITY_TYPE_CHARACTER_FOUND",
		icon = preload("res://assets/images/gui/gui icons/icon_recruit.png"),
		color = Color("9edb6b"),
	},
	#A minor training run to its end - etiquette, letters, the courtly arms. Started by hand,
	#finished by the clock, which is why it belongs here and the master upgrades do not.
	"training": {
		label = "MANSION_ACTIVITY_TYPE_TRAINING",
		icon = preload("res://assets/Textures_v2/MANSION/icon_training_small.png"),
		color = Color("8f9fe0"),
	},
	#What an event did to somebody's numbers. One row per person per hour, rewritten in place as
	#more changes land - see globals.mansion_activity_stat_change().
	"stat_change": {
		label = "MANSION_ACTIVITY_TYPE_STAT",
		icon = preload("res://assets/Textures_v2/MANSION/icon_stat_small.png"),
		color = Color("c0c8d0"),
	},
	#Who the household has taken to and who it cannot stand - one entry for the lot. The icon is
	#deliberately neutral, two people and nothing said about how they feel; which way it went is
	#carried by the coloured status word, see RELATIONSHIP_LOG in game_party.gd.
	"relationship": {
		label = "MANSION_ACTIVITY_TYPE_RELATIONSHIP",
		icon = preload("res://assets/Textures_v2/MANSION/icon_relationship_small.png"),
		color = Color("d68fa8"),
	},
	#A night in the master's bed - who shared it, what it looked like, and whose training moved
	#because of it. Written once per night by game_res.process_master_bed_night(), and stamped
	#with the night that ended rather than the morning it is read in.
	"bedroom": {
		label = "MANSION_ACTIVITY_TYPE_BEDROOM",
		icon = preload("res://assets/Textures_v2/MANSION/icon_sex_small.png"),
		color = Color("d95d8a"),
	},
	#What the service task brought in over one turn - one row for the whole household, with the
	#line per worker folded away behind it. Like the craft report, the breakdown does not survive
	#a save: see globals.mansion_activity_service().
	"service": {
		label = "MANSION_ACTIVITY_TYPE_SERVICE",
		icon = preload("res://assets/images/iconsitems/gold.png"),
		color = Color("f0c860"),
	},
}

onready var scroll = $Margin/Layout/ScrollContainer
onready var entries = $Margin/Layout/ScrollContainer/Entries
onready var entry_template = $Margin/Layout/ScrollContainer/Entries/EntryTemplate
onready var empty_label = $Margin/Layout/ScrollContainer/Entries/EmptyLabel
onready var count_label = $Margin/Layout/Header/Count


func _ready():
	for data in ResourceScripts.game_globals.mansion_activity_log:
		add_log_message(data, false)
	_update_empty_state()
	call_deferred("_scroll_to_latest")


func add_log_message(data, scroll_to_latest = true):
	if !data.has("type") or !EVENT_CONFIG.has(data.type):
		return
	var config = EVENT_CONFIG[data.type]
	var entry = entry_template.duplicate()
	entry.name = "ActivityEntry"
	entry.set_meta("activity_entry", true)
	entry.set_meta("entry_key", entry_key(data))
	entry.get_node("Body/Accent").color = config.color
	entry.get_node("Body/Content/Row/Icon").texture = config.icon
	entry.get_node("Body/Content/Row/Text/Meta").text = "%s  -  %s" % [
		tr(config.label).to_upper(),
		_format_date(data),
	]
	entry.get_node("Body/Content/Row/Text/Meta").add_color_override("font_color", config.color)
	var message = entry.get_node("Body/Content/Row/Text/Message")
	message.bbcode_text = data.text
	message.connect("meta_clicked", self, "_on_meta_clicked")
	_fill_details(entry, data)
	entry.show()
	entries.add_child(entry)
	entries.move_child(entry, 0)
	_trim_entries()
	_update_empty_state()
	if scroll_to_latest:
		call_deferred("_scroll_to_latest")


#What identifies a row that can still be rewritten. globals folds stat changes on
#(type, character, stamp), so the same three name the row that fold has to find again.
static func entry_key(data):
	return "%s|%s|%s|%s" % [data.get("type", ""), data.get("char_id", ""),
		data.get("date", 0), data.get("hour", 0)]


#A folded entry grew another line. Nothing moves and no row is added - the text on the row
#already on screen is replaced. A row trimmed off the bottom simply is not found, which is fine:
#the message it was built from is on its way out of the log too.
func update_log_message(data):
	var key = entry_key(data)
	for child in entries.get_children():
		if !child.has_meta("activity_entry"):
			continue
		if child.get_meta("entry_key", "") != key:
			continue
		child.get_node("Body/Content/Row/Text/Message").bbcode_text = data.text
		#The fold is refilled but never reopened or closed here: a report that grows while the
		#player has it open gains its new lines under their eyes and stays open.
		_fill_details(child, data)
		return


#The breakdown behind a report, and the button that shows it. An entry type that has no
#breakdown - and a report loaded from a save, whose breakdown was dropped on the way in -
#leaves the whole section hidden, so the row stays exactly as tall as every other row.
func _fill_details(entry, data):
	var details = entry.get_node("Body/Content/Row/Text/Details")
	var lines = data.get("details", [])
	details.visible = lines.size() > 0
	if !details.visible:
		return
	var detail_scroll = details.get_node("DetailScroll")
	var list = detail_scroll.get_node("DetailList")
	#The list is refilled once for every line a report gains, and the whole turn runs inside one
	#frame. Clearing and rebuilding each time would cost a duplicated label per line per line -
	#and ClearContainer's queue_free() only lands at the end of the frame, so the discarded labels
	#would still be standing beside the new ones for the rest of it. That was cheap while the
	#service report was the only one folding, one line per person; the benches can finish dozens
	#of items in a turn. A report only ever gains lines, so the rows already built are kept and
	#only the new ones are added. A list that somehow shrank is not something this can patch up,
	#and falls back to the clean rebuild.
	var rows = _detail_rows(list)
	if rows.size() > lines.size():
		input_handler.ClearContainer(list, ['DetailTemplate'])
		rows = []
	for i in range(rows.size()):
		if rows[i].bbcode_text != lines[i]:
			rows[i].bbcode_text = lines[i]
	for i in range(rows.size(), lines.size()):
		input_handler.DuplicateContainerTemplate(list, 'DetailTemplate').bbcode_text = lines[i]
	var button = details.get_node("ExpandButton")
	button.text = _details_button_text(detail_scroll.visible)
	if !button.is_connected("pressed", self, "_on_details_toggled"):
		button.connect("pressed", self, "_on_details_toggled", [entry])


#The lines already standing in a fold, in the order they were added. Everything in the list but
#the template itself is one - the template is kept hidden and pushed back to the end by
#input_handler.DuplicateContainerTemplate(), so it is identified by node and not by name.
func _detail_rows(list):
	var template = list.get_node("DetailTemplate")
	var rows = []
	for child in list.get_children():
		if child == template:
			continue
		rows.append(child)
	return rows


func _on_details_toggled(entry):
	var details = entry.get_node("Body/Content/Row/Text/Details")
	var detail_scroll = details.get_node("DetailScroll")
	detail_scroll.visible = !detail_scroll.visible
	details.get_node("ExpandButton").text = _details_button_text(detail_scroll.visible)


func _details_button_text(expanded):
	if expanded:
		return tr("MANSION_ACTIVITY_SERVICE_COLLAPSE")
	return tr("MANSION_ACTIVITY_SERVICE_EXPAND")


func _on_meta_clicked(meta):
	var link = str(meta)
	if link == "mansion":
		gui_controller.nav_panel.return_to_mansion()
		return
	if !link.begins_with("loc:"):
		return
	var code = link.substr(4)
	var loc_data = ResourceScripts.world_gen.get_location_from_code(code)
	if loc_data == null:
		input_handler.SystemMessage(tr("MANSION_ACTIVITY_LOCATION_GONE"))
		return
	if !ResourceScripts.game_world.capitals.has(code):
		var someone_there = false
		for id in ResourceScripts.game_party.character_order:
			if ResourceScripts.game_party.characters[id].check_location(code, true):
				someone_there = true
				break
		if !someone_there:
			input_handler.SystemMessage(tr("MANSION_ACTIVITY_LOCATION_EMPTY") % tr(loc_data.name))
			return
	gui_controller.nav_panel.select_location(code)


func _format_date(data):
	var date = int(data.get("date", 1))
	var hour = int(data.get("hour", 1))
	var week = int((date - 1) / 7) + 1
	var day = int((date - 1) % 7) + 1
	return tr("MANSION_ACTIVITY_TIME") % [week, day, tr(variables.timeword.get(hour, "NIGHT"))]


func _update_empty_state():
	var count = 0
	for child in entries.get_children():
		if child.has_meta("activity_entry"):
			count += 1
	empty_label.visible = count == 0
	count_label.text = str(count)


func _trim_entries():
	var activity_entries = []
	for child in entries.get_children():
		if child.has_meta("activity_entry"):
			activity_entries.append(child)
	while activity_entries.size() > MAX_MESSAGES:
		var oldest = activity_entries.pop_back()
		entries.remove_child(oldest)
		oldest.queue_free()


func _scroll_to_latest():
	yield(get_tree(), "idle_frame")
	if is_instance_valid(scroll):
		scroll.scroll_vertical = 0
