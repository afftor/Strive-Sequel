extends PanelContainer

const MAX_MESSAGES = 50

const EVENT_CONFIG = {
	"arrival": {
		label = "MANSION_ACTIVITY_TYPE_ARRIVAL",
		icon = preload("res://assets/Textures_v2/MANSION/icon_travel_small.png"),
		color = Color("72c8d9"),
	},
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
	"quest_task": {
		label = "MANSION_ACTIVITY_TYPE_QUEST_TASK",
		icon = preload("res://assets/Textures_v2/MANSION/quest_task.png"),
		color = Color("c89be8"),
	},
	"character_found": {
		label = "MANSION_ACTIVITY_TYPE_CHARACTER_FOUND",
		icon = preload("res://assets/images/gui/gui icons/icon_recruit.png"),
		color = Color("9edb6b"),
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
	entry.get_node("Body/Accent").color = config.color
	entry.get_node("Body/Content/Row/Icon").texture = config.icon
	entry.get_node("Body/Content/Row/Text/Meta").text = "%s  -  %s" % [
		tr(config.label).to_upper(),
		_format_date(data),
	]
	entry.get_node("Body/Content/Row/Text/Meta").add_color_override("font_color", config.color)
	entry.get_node("Body/Content/Row/Text/Message").bbcode_text = data.text
	entry.show()
	entries.add_child(entry)
	entries.move_child(entry, 0)
	_trim_entries()
	_update_empty_state()
	if scroll_to_latest:
		call_deferred("_scroll_to_latest")


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
