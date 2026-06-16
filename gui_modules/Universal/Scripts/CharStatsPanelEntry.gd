extends Control

onready var desc_node = $desc
onready var icon_node = $icon
onready var name_node = $name

func _ready():
	desc_node.connect("resized", self, "on_resized")

func on_resized():
	rect_min_size.y = desc_node.get_rect().end.y

func set_entry(entry):
	desc_node.bbcode_text = globals.TextEncoder(entry.text)
	if entry.has("name"):
		name_node.text = entry.name
	else:
		name_node.hide()
	if entry.has("is_skill"):
		icon_node.get_node("skill_frame").show()
	if entry.has('icon'):
		if entry.icon is String:
			icon_node.texture = load(entry.icon)
		else:
			icon_node.texture = entry.icon
	if entry.has("complex_icon"):
		icon_node.get_node('simple_icon_bg').show()
		icon_node.get_node('simple_icon_frame').show()
		if entry.has('cross'):
			icon_node.get_node('cross').visible = true
		else:
			if entry.has('positive'):
				icon_node.texture_normal = load("res://assets/images/iconstraits/green.png")
			if entry.has('negative'):
				icon_node.texture_normal = load("res://assets/images/iconstraits/red.png")
	if entry.has("skill_tooltip"):
		globals.connectskilltooltip(icon_node, entry.code, entry.character.get_ref())

