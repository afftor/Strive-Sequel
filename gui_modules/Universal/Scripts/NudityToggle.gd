extends Button

# The Nudity rule for a character the screens draw as a picture instead of with
# the doll - the unique cast, whose bodies are painted sprites.
#
# The rule used to be a checkbox in the rules list, and for everybody else it is
# now the doll's own undress buttons.  A unique character has no doll to put
# buttons on, so this is the one button off that bar: the same look, in the same
# corner, saying the same thing.  What it flips is the same work rule, so the
# portrait and the stored sprite follow it exactly as they did.

const STYLES = preload("res://Character_generator/Doll2Spine/universal/doll_control_styles.gd")
const CONTROL_FONT = preload("res://assets/Themes_v2/UNIVERSAL/PT_18.tres")
const BUTTON_WIDTH = 116
const BUTTON_HEIGHT = 26
const BUTTON_MARGIN = 6

signal nudity_changed(person)

var person = null


func _init():
	name = "NudityToggle"
	toggle_mode = true
	clip_text = true
	rect_min_size = Vector2(BUTTON_WIDTH, BUTTON_HEIGHT)
	anchor_left = 1.0
	anchor_right = 1.0
	margin_left = -BUTTON_WIDTH - BUTTON_MARGIN
	margin_right = -BUTTON_MARGIN
	margin_top = BUTTON_MARGIN
	margin_bottom = BUTTON_MARGIN + BUTTON_HEIGHT
	hide()


func _ready():
	# The same boxes the doll's own bar is built from, so this button and that bar
	# stay one look on a screen that shows whichever the character calls for.
	STYLES.dress_button(self, STYLES.build(), CONTROL_FONT)
	text = tr("WORKRULENUDITY")
	if !is_connected("pressed", self, "_on_pressed"):
		connect("pressed", self, "_on_pressed")


# How far down the frame the button sits, for a screen whose top corner is
# already taken - the expanded card keeps its close button up there.
func place_below(offset):
	margin_top = BUTTON_MARGIN + offset
	margin_bottom = margin_top + BUTTON_HEIGHT


# Shown only where it has something to switch to: a unique character the game
# has a nude sprite for.  Everybody else is drawn by the doll, which carries the
# undress buttons itself.
func shows_for(character):
	if character == null:
		return false
	var unique_code = character.get_stat("unique")
	if unique_code == null or !worlddata.pregen_character_sprites.has(unique_code):
		return false
	return worlddata.pregen_character_sprites[unique_code].has("nude")


# The requirement the rule carried while it was a checkbox, and the same one the
# doll's buttons check for a generated character.
func allowed_for(character):
	return character != null and character.has_status("sexservice")


func bind(new_person):
	person = new_person
	visible = shows_for(person)
	if !visible:
		return
	pressed = bool(person.has_work_rule("nudity"))
	disabled = !allowed_for(person)
	var tooltip = "[center]" + tr("WORKRULENUDITY") + "[/center]\n"
	tooltip += person.translate(tr("WORKRULENUDITYDESCRIPT"))
	globals.connecttexttooltip(self, tooltip)


func _on_pressed():
	if person == null or disabled:
		pressed = person != null and bool(person.has_work_rule("nudity"))
		return
	person.set_work_rule("nudity", !person.has_work_rule("nudity"))
	pressed = bool(person.has_work_rule("nudity"))
	person.update_prt()
	emit_signal("nudity_changed", person)
