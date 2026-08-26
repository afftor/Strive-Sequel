extends Control

# The doll as the game embeds it, standing in for `ragdoll.tscn`.
#
# A Control rather than a Node2D, and that is the whole trick of fitting into the
# screens: it clips its own contents, so the doll cannot draw outside the box the
# screen gives it.  The old doll needed a `Light2D` in mask mode over a 1500x1500
# texture on every screen, plus `light_mask` on all 192 of its nodes, to do the
# same rectangular crop.  Here it is one property, and the box is the node's own
# rect - which the screen was already authoring.
#
# The screens talk to this and never to the new doll directly: they call the same
# handful of methods the old paperdoll had - `rebuild`, `rebuild_cloth`,
# `rebuild_underwear`, `rebuild_stat` - so replacing the doll is a change of node
# and not a rewrite of eight screens.
#
# What it does not do yet, on purpose: no animation and no poses.  The doll is
# solved once per rebuild and then stands still, which is also why it costs
# nothing per frame.

const CATALOGUE = preload("res://Character_generator/Doll2Spine/doll2_catalogue.gd")
const CHARACTER_MAP = preload("res://Character_generator/Doll2Spine/universal/doll_character_map.gd")
const MODEL = preload("res://Character_generator/Doll2Spine/Doll2Preview.tscn")
const MODIFIERS = preload("res://Character_generator/Doll2Spine/universal/doll_modifiers.gd")
const COLORS = preload("res://Character_generator/Doll2Spine/universal/doll_colors.gd")
const COVERAGE = preload("res://Character_generator/Doll2Spine/universal/doll_coverage.gd")
const GEAR = preload("res://Character_generator/Doll2Spine/universal/doll_gear_map.gd")
const DOLL_DROPDOWN_THEME = preload("res://assets/Themes_v2/UNIVERSAL/DropDown.tres")
# The frame is sized for the tallest character there can be, so the others stay
# visibly shorter inside it.
const TALLEST_TIER = "towering"

# The stats the map reads.  Kept here rather than fetched from GeneratorData, so
# the new doll does not depend on the old one's data file.
const STATS = [
	"race", "sex", "chin", "eyeshape", "eye_tex", "eyebrows", "lips", "nose",
	"ears", "hair_base", "hair_back", "hair_assist", "horns", "wings", "tail",
	"penis_type", "tits_size", "pregnancy_status", "height", "skin_coverage",
	"multiple_tits_developed", "body_shape", "hand_pose", "face_markings",
	"ass_size", "beard", "penis_size", "balls_size",
]

# Colour channel -> the stat that picks its colour, and the stat that picks the
# second one where the channel is two-tone.  The old doll kept a colour per part;
# the new one keeps a colour per channel, and the two line up one to one.
const CHANNEL_COLOURS = {
	"skin": ["body_color_skin", ""],
	"eyes": ["eye_color", ""],
	"lips": ["body_color_lips", ""],
	"eyebrows": ["body_color_eyebrows", ""],
	"hair": ["hair_base_color_1", "hair_base_color_2"],
	# The male rig grew beard art; the game has carried `hair_facial_color` since
	# the old doll with nothing to paint.
	"beard": ["hair_facial_color", ""],
	"hair_back": ["hair_back_color_1", "hair_back_color_2"],
	"hair_assist": ["hair_assist_color_1", "hair_assist_color_2"],
	# `ears` is decided per part below: only an animal ear takes the ear colour.
	"ears": ["body_color_ears", ""],
	"tail": ["body_color_tail", ""],
	"wings": ["body_color_wings", ""],
	"horns": ["body_color_horns", ""],
	"animal": ["body_color_animal", ""],
	"race": ["body_color_skin", ""],
	# nipples have no stat of their own: their table is keyed by the skin's code,
	# so they follow the skin a character was given
	"nipples": ["body_color_skin", ""],
}

# What the new doll wants and the character does not carry yet.  They are listed
# in `legacy/old_doll_behaviour.md` with where each one belongs; until they are
# added, asking for them would raise, so the doll does without and takes the
# catalogue's default.  Delete a name here as its stat is added.
#
# The list is written out rather than checked against `statdata`, because naming
# an autoload from a script this early in the load order does not parse.
const NOT_A_STAT_YET = ["body_shape", "hand_pose", "face_markings"]

# Old stat -> catalogue axis, for the dimensions that select between several
# attachments of one part rather than between parts.
const AXES = {
	"tits_size": "tits_size",
	"pregnancy_status": "pregnancy",
	"hand_pose": "hand_pose",
}
const TITS = {
	"flat": "flat", "small": "small", "average": "normal", "average_high": "normal",
	"average_narrow": "normal", "average_wide": "normal", "big": "large",
	"big_high": "large", "big_narrow": "large", "huge": "big", "huge_high": "big",
	"huge_narrow": "big", "masculine": "flat",
}
const PREGNANCY = {"no": "none", "early": "mid", "heavy": "big"}
# Races the export cut a heavier pair of legs for.
const ORC_LEGS = ["Orc", "Goblin"]


# A little room at the top, so hair and horns are not flush against the edge.
export var frame_headroom = 0.04
# The screens show the doll from the hips up, as the old one did: it is drawn
# large and the frame keeps the upper body.  Turn this off for a screen that
# wants the whole figure.
export var show_from_the_hips = true
# Frames the head instead of the whole figure, for the portrait booth.  The old
# doll cropped a rectangle out of the rendered screen and the crop ran off the
# canvas on tall characters; here the doll is simply drawn at the size the
# portrait wants, so there is nothing to trim.
export var portrait_mode = false
# How much of the shot is head: 1.0 would be the head box exactly, and the rest
# is shoulders and hair.
export var portrait_zoom = 1.55
# The player may look closer and move the doll about, as they could on the old
# one.  Its limits are kept: a tenth per wheel step, three quarters to one and a
# half, and a pan that cannot push the figure out of its own frame.
export var allow_zoom = true
# The four undress steps, as toggles in the doll's own top corner.  Off for the
# portrait booth and for any screen that would rather drive the level itself.
export var show_undress_buttons = true
# Which of the four steps this screen offers, empty for all of them.  Character
# creation shows only underwear and naked: the character being made has no gear
# on, so `dressed` and `bare` are two more words for the same two pictures.
export var offered_undress_levels = []
# The hair menu belongs where a character is being looked at, not where one is
# being made - creation has its own hair rows.
export var show_hair_menu = true
# On the mansion screens the undress buttons are not a way of looking at the
# character but the Nudity work rule itself, which used to be a checkbox in the
# rules list.  With this on, the buttons obey the rule's own requirement and what
# the player picks is written back to the character, so the portraits and the
# stored sprites are shot the way the doll is standing.  Off everywhere the doll
# is only being looked at - character creation, the previews, the booth.
export var undress_is_a_rule = false
# Below this the frame is a thumbnail and the buttons would cover the character.
const UNDRESS_BAR_NEEDS = Vector2(240, 300)
const UNDRESS_BAR_MARGIN = 6
const ZOOM_STEP = 0.1
const ZOOM_MIN = 0.75
const ZOOM_MAX = 1.5
const DRAG_THRESHOLD = 6.0
# Sideways and downwards the old doll's limits are plenty.  Upwards is another
# matter: the screens frame the doll from the hips, so the legs and the feet are
# below the frame and only a long pull brings them into it.
const PAN_LIMIT_X = 220.0
const PAN_LIMIT_DOWN = 0.35
const PAN_LIMIT_UP = 1.1

var view_zoom = 1.0
var view_pan = Vector2.ZERO
var _drag_from = Vector2.ZERO
var _pan_from = Vector2.ZERO
var _drag_candidate = false
var _dragging = false

# Standing in for the old doll's own flags, so the screens can keep setting them.
var test_mode = false
var update_character_portrait = true
var character = null
# How much of the character is shown, one of GEAR.LEVELS.  `rebuild_cloth`, which
# is what the screens call, still speaks in dressed-or-not and lands on `dressed`
# or `bare` - the level the old doll had when it stripped somebody.
var undress_level = GEAR.DRESSED

var model = null
# Pushes the whole set of corner buttons down the frame; see
# `place_controls_below`, which is the only thing that should set it.
var controls_offset = 0
var _undress_bar = null
var _undress_bar_top = 0.0
var _undress_buttons = {}
var _hair_button = null
var _hair_button_top = 0.0
var _hair_panel = null
var _hair_panel_width = 0.0
var _look_changed = false
var _hair_controls = {}

# The screens around the doll redraw what they show of the character - a card
# portrait, a stored sprite - when the player strips one.
signal undress_level_changed(level)


func _ready():
	rect_clip_content = true
	# the doll takes the wheel and the drag inside its own rect and lets everything
	# else through, which is what the old doll's `ZoomArea` did
	mouse_filter = Control.MOUSE_FILTER_PASS if allow_zoom and !portrait_mode else Control.MOUSE_FILTER_IGNORE
	model = MODEL.instance()
	# said before the model enters the tree, so its editor panel is never built
	model.interface_enabled = false
	add_child(model)
	# authored controls entered first, so the model has to return to the back where
	# it was when the controls were appended from code
	move_child(model, 0)
	# the preview carries an editor panel and drag handles; in the game the doll
	# is only ever looked at
	for child in model.get_children():
		if child is CanvasLayer:
			child.queue_free()
	model.handle_buttons.clear()
	model.handles_visible = false
	model.set_process_unhandled_input(false)
	for animation_name in model.animation_states.keys():
		model.animation_states[animation_name] = false
	if portrait_mode or !show_undress_buttons:
		for control_name in ["UndressLevels", "HairMenuButton", "HairMenu"]:
			get_node(control_name).queue_free()
	else:
		if !show_hair_menu:
			get_node("HairMenuButton").queue_free()
			get_node("HairMenu").queue_free()
		_build_undress_bar()
		connect("resized", self, "_refresh_undress_bar")
		connect("visibility_changed", self, "_on_doll_visibility_changed")
	set_process(false)


# --- the old doll's API -------------------------------------------------------

func rebuild(character_to_build):
	# A different character is a fresh look at a fresh doll: whatever the player
	# zoomed into or dragged off-frame on the last one is not where they want to
	# start on this one.
	if character_to_build != character:
		view_zoom = 1.0
		view_pan = Vector2.ZERO
		undress_level = GEAR.DRESSED
		_close_hair_menu()
	character = character_to_build
	_apply()


func rebuild_cloth(value):
	if value != null:
		undress_level = GEAR.normalise(!bool(value))
	_apply()


# The four steps, for the screens and for the doll's own corner buttons.
func set_undress_level(level):
	var wanted = GEAR.normalise(level)
	if wanted == undress_level:
		return
	if undress_is_a_rule and wanted != GEAR.DRESSED and !nudity_allowed():
		_refresh_undress_bar()
		return
	undress_level = wanted
	if undress_is_a_rule:
		_write_undress_rule()
	_apply()
	emit_signal("undress_level_changed", undress_level)


# Whether this character may be kept undressed at all - the requirement the
# Nudity rule carried while it was a checkbox in the rules list.
func nudity_allowed():
	if character == null or !character.has_method("has_status"):
		return false
	return character.has_status("sexservice")


# What the player left the doll wearing is the rule from here on: the portrait
# booth and the unique sprites both read the work rule rather than the doll.
func _write_undress_rule():
	if character == null or !character.has_method("set_work_rule"):
		return
	var undressed = undress_level != GEAR.DRESSED
	if bool(character.has_work_rule("nudity")) == undressed:
		return
	character.set_work_rule("nudity", undressed)
	if character.has_method("update_prt"):
		character.update_prt()
	var handler = _singleton("input_handler")
	if handler != null and handler.has_method("reshoot_portrait"):
		handler.reshoot_portrait(character)


func rebuild_underwear():
	_apply()


func rebuild_stat(_statname):
	# the new doll has no per-stat path: a rebuild is 20-30 ms and every stat
	# reaches the same solve, so there is nothing for a partial one to save
	_apply()


# --- the portrait pipeline ----------------------------------------------------

# --- the undress toggles ------------------------------------------------------

# Four toggles in the doll's top corner, over the figure rather than beside it:
# the doll is handed a rect by the screen it sits in, and there is nothing next
# to it that it owns.  A plain child of the doll, so it hides, clips and moves
# with it - a CanvasLayer would float above the screen's own popups.
# the styleboxes are owned by `Doll2View.tscn` now; keep its palette in sync
# with `doll_control_styles.gd`, which still dresses the painted cast's toggle
func _build_undress_bar():
	_undress_bar = get_node("UndressLevels")
	_undress_bar_top = _undress_bar.margin_top
	for level in GEAR.LEVELS:
		var button = _undress_bar.get_node(level)
		button.text = tr(GEAR.LEVEL_LABELS[level])
		button.pressed = level == undress_level
		button.connect("pressed", self, "set_undress_level", [level])
		_undress_buttons[level] = button
	if !show_hair_menu:
		if controls_offset != 0:
			place_controls_below(controls_offset)
		return
	# this opens a menu rather than choosing a level, so it stands beside the
	# column and reads as a separate action while keeping the same dress
	_hair_button = get_node("HairMenuButton")
	_hair_button_top = _hair_button.margin_top
	_hair_button.text = tr("DOLL2_HAIR_MENU")
	_hair_button.connect("toggled", self, "_on_hair_menu_toggled")
	_undress_buttons["hair"] = _hair_button
	if controls_offset != 0:
		place_controls_below(controls_offset)


# How far down the doll's frame the buttons start, for a screen whose top corner
# is already taken - the expanded card keeps its close button up there, and the
# first level button was sitting under it.  `NudityToggle.place_below` is the
# exact twin of this: the two are the same bar on the same screen, one for the
# generated characters and one for the painted cast.
func place_controls_below(offset):
	controls_offset = offset
	if _undress_bar != null:
		var bar_top = _undress_bar_top + controls_offset
		_undress_bar.margin_bottom += bar_top - _undress_bar.margin_top
		_undress_bar.margin_top = bar_top
	if _hair_button != null:
		var button_top = _hair_button_top + controls_offset
		_hair_button.margin_bottom += button_top - _hair_button.margin_top
		_hair_button.margin_top = button_top
	_position_hair_panel()


# Hair, under a button of its own next to the undress levels.  Everything here is
# free: any style on any character, any colour off the wheel - the doll is being
# looked at, not rolled, so the race's own list has no say.
#
# Three layers, the same three the test preview has: the hair itself, what hangs
# behind the head and the extra strands.  Each carries two colours - roots and
# tips - which makes six, and they follow the styles rather than sitting among
# them: a layer nobody wears takes its pair of pickers away with it.
const HAIR_LENGTHS = ["bald", "short", "default", "middle", "long"]
const HAIR_LAYERS = [
	{"id": "hair", "group": "hair", "stat": "hair_base", "label": "DOLL2_HAIR_STYLE", "tone": "DOLL2_HAIR_MENU"},
	{"id": "hair_back", "group": "hair_back", "stat": "hair_back", "label": "DOLL2_HAIR_BACK", "tone": "DOLL2_HAIR_BACK"},
	{"id": "hair_assist", "group": "hair_assist", "stat": "hair_assist", "label": "DOLL2_HAIR_ASSIST", "tone": "DOLL2_HAIR_ASSIST"},
]
const HAIR_TONES = ["DOLL2_HAIR_TONE_ROOTS", "DOLL2_HAIR_TONE_TIPS"]


func _on_hair_menu_toggled(pressed):
	if _hair_panel == null:
		_build_hair_panel()
	_hair_panel.visible = pressed
	if pressed:
		_refresh_hair_panel()


# The scene owns the panel and its rows.  Only the dropdown lists retain their
# own game theme here: that resource knows how to dress PopupMenu, which the
# scene tree cannot reach through its OptionButton.
func _build_hair_panel():
	_hair_panel = get_node("HairMenu")
	_hair_panel_width = _hair_panel.margin_right - _hair_panel.margin_left
	var title = get_node("HairMenu/VBox/Title/Label")
	title.text = tr("DOLL2_HAIR_MENU")
	var close = get_node("HairMenu/VBox/Title/Close")
	close.text = tr("OPTCLOSE")
	close.connect("pressed", self, "_close_hair_menu")
	var rows = get_node("HairMenu/VBox/Rows")
	var row_texts = []
	# each layer keeps its own colours right under it: picking a style and then
	# hunting for its pair at the bottom of the panel is two jobs, not one
	for layer in HAIR_LAYERS:
		row_texts.append([layer.id + "_style", tr(layer.label)])
		for tone in range(HAIR_TONES.size()):
			var control_id = "%s_colour%d" % [layer.id, tone + 1]
			row_texts.append([control_id,
				"%s - %s" % [tr(layer.tone), tr(HAIR_TONES[tone])]])
	row_texts.append(["hair_length", tr("DOLL2_HAIR_LENGTH")])
	row_texts.append(["beard_style", tr("DOLL2_BEARD_STYLE")])
	row_texts.append(["beard_colour", tr("DOLL2_BEARD_COLOUR")])
	for row in row_texts:
		var control_id = row[0]
		var control = rows.get_node(control_id)
		var label = rows.get_node(control_id + "_label")
		label.text = row[1]
		_hair_controls[control_id] = control
		_hair_controls[control_id + "_label"] = label
		if control is ColorPickerButton:
			control.connect("color_changed", self, "_on_hair_colour_picked", [control_id])
			# the wheel is wider than the frame the doll stands in, so it opens
			# beside the doll instead of over the character it changes
			control.get_popup().connect("about_to_show", self, "_place_colour_popup", [control])
		else:
			control.get_popup().theme = DOLL_DROPDOWN_THEME
			control.connect("item_selected", self, "_on_hair_option_picked", [control_id, control])
	_position_hair_panel()


func _position_hair_panel():
	if _hair_panel == null or _hair_button == null:
		return
	# it opens below its own trigger and grows to the left on roomy dolls.  At the
	# minimum supported width the left edge is clamped inside the doll instead of
	# being clipped away with the character.
	var panel_width = min(_hair_panel_width,
		max(0.0, rect_size.x - UNDRESS_BAR_MARGIN * 2))
	var panel_right = _hair_button.margin_right
	var panel_left = panel_right - panel_width
	var left_limit = -rect_size.x + UNDRESS_BAR_MARGIN
	if panel_left < left_limit:
		panel_left = left_limit
		panel_right = panel_left + panel_width
	_hair_panel.margin_left = panel_left
	_hair_panel.margin_right = panel_right
	var panel_top = _hair_button.margin_bottom + 4
	_hair_panel.margin_top = panel_top
	_hair_panel.margin_bottom = panel_top + _hair_panel.get_combined_minimum_size().y
# Beside the doll, never on top of it.
func _place_colour_popup(picker):
	var popup = picker.get_popup()
	var wheel = popup.rect_size
	var doll_box = Rect2(rect_global_position, rect_size)
	var room = get_viewport_rect().size
	var x = doll_box.position.x - wheel.x - UNDRESS_BAR_MARGIN
	if x < 0:
		x = doll_box.end.x + UNDRESS_BAR_MARGIN
	var y = doll_box.position.y
	if _hair_panel != null:
		y = _hair_panel.rect_global_position.y
	popup.rect_global_position = Vector2(
		clamp(x, 0, max(0, room.x - wheel.x)),
		clamp(y, 0, max(0, room.y - wheel.y)))


# The lists are filled from the catalogue rather than from the character, so a
# style nobody of that race wears is still on offer.
func _refresh_hair_panel():
	if _hair_panel == null or model == null:
		return
	CATALOGUE.use(model.doll_id)
	for layer in HAIR_LAYERS:
		var worn = str(model.selections.get(layer.group, ""))
		_fill_options(layer.id + "_style", CATALOGUE.parts(layer.group), worn, layer.group != "hair")
		# the two colours belong to the layer: with nothing worn there is nothing
		# to paint, so the pair goes with it
		for tone in [1, 2]:
			var key = "%s_colour%d" % [layer.id, tone]
			var stat = "%s_color_%d" % [layer.stat, tone]
			_hair_controls[key].color = COLORS.colour_of(stat, _stat(stat))
			_show_hair_row(key, worn != "")
	# length has no art behind it yet: the tiers are listed so the row reads right
	# and the control is dead until the lengths are wired to the hair chains
	_fill_options("hair_length", HAIR_LENGTHS, str(_stat("hair_base_length")))
	_hair_controls.hair_length.disabled = true
	_hair_controls.hair_length_label.modulate = Color(1, 1, 1, 0.45)
	_fill_options("beard_style", CATALOGUE.parts("beard"), str(model.selections.get("beard", "")), true)
	_hair_controls.beard_colour.color = COLORS.colour_of("hair_facial_color", _stat("hair_facial_color"))
	# a beard is a man's, and only while the art has any
	var beards = !CATALOGUE.parts("beard").empty() and str(_stat("sex")) != "female"
	_show_hair_row("beard_style", beards)
	_show_hair_row("beard_colour", beards)
	_position_hair_panel()


func _show_hair_row(control_id, shown):
	_hair_controls[control_id].visible = shown
	_hair_controls[control_id + "_label"].visible = shown


func _fill_options(control_id, values, current, allow_none = false):
	var control = _hair_controls[control_id]
	control.clear()
	if allow_none:
		control.add_item(tr("DOLL2_HAIR_NONE"))
		control.set_item_metadata(0, "")
	for value in values:
		control.add_item(str(value))
		control.set_item_metadata(control.get_item_count() - 1, value)
	for i in range(control.get_item_count()):
		if str(control.get_item_metadata(i)) == current:
			control.select(i)
			break


func _on_hair_option_picked(_index, control_id, control):
	_look_changed = true
	if character == null:
		return
	var value = str(control.get_item_metadata(control.selected))
	for layer in HAIR_LAYERS:
		if control_id == layer.id + "_style":
			# The part's own id goes in, not the name with the group's prefix cut
			# off it.  The art carries two families - `hair_base_lion` alongside
			# `hairs_base_lion` - and a cut name cannot be put back together: the
			# map would rebuild the wrong one, or none at all.
			character.set_stat(layer.stat, value)
	if control_id == "beard_style":
		character.set_stat("beard", value.replace("beard_", ""))
	_apply()
	_refresh_hair_panel()


func _on_hair_colour_picked(colour, control_id):
	_look_changed = true
	if character == null:
		return
	var hex = "#" + colour.to_html(false)
	if control_id == "beard_colour":
		character.set_stat("hair_facial_color", hex)
		_apply()
		return
	for layer in HAIR_LAYERS:
		for tone in [1, 2]:
			if control_id == "%s_colour%d" % [layer.id, tone]:
				character.set_stat("%s_color_%d" % [layer.stat, tone], hex)
	_apply()


# A screen closing is where a changed look gets written down: the hair menu is
# put away so it does not spring open on the next character, and the portrait
# on file - taken before the hairstyle changed - is shot again.
func _on_doll_visibility_changed():
	if is_visible_in_tree():
		return
	_close_hair_menu()
	if !_look_changed:
		return
	_look_changed = false
	var handler = _singleton("input_handler")
	if handler != null and handler.has_method("reshoot_portrait"):
		handler.reshoot_portrait(character)


func _close_hair_menu():
	if _hair_panel != null:
		_hair_panel.visible = false
	if _undress_buttons.has("hair"):
		_undress_buttons["hair"].pressed = false


func _refresh_undress_bar():
	if _undress_bar == null:
		return
	var bar_visible = (rect_size.x >= UNDRESS_BAR_NEEDS.x
		and rect_size.y >= UNDRESS_BAR_NEEDS.y)
	_undress_bar.visible = bar_visible
	if _hair_button != null:
		_hair_button.visible = bar_visible and show_hair_menu
	if !bar_visible:
		_close_hair_menu()
	var offered = _levels_that_differ()
	# a level the character has no picture of its own for shows the next one down
	var shown = ""
	for level in GEAR.LEVELS:
		if level in offered:
			shown = level
		if level == undress_level:
			break
	if shown == "":
		# the level in hand is not offered because it looks like the next one down,
		# so that is the button to light: a character with no clothes on shows the
		# same picture dressed as in their underwear
		shown = offered.front() if !offered.empty() else undress_level
	var barred = undress_is_a_rule and !nudity_allowed()
	for level in _undress_buttons.keys():
		if level == "hair":
			continue
		_undress_buttons[level].visible = level in offered
		_undress_buttons[level].pressed = level == shown
		_undress_buttons[level].disabled = barred and level != GEAR.DRESSED
	# while the buttons are the Nudity rule they say what the rule said
	if undress_is_a_rule:
		var stand_clear_of = _lowest_visible_button()
		for level in GEAR.LEVELS:
			if level == GEAR.DRESSED or !_undress_buttons.has(level):
				continue
			_rule_tooltip(_undress_buttons[level], stand_clear_of)
	_position_hair_panel()
	if _hair_panel != null and _hair_panel.visible:
		_refresh_hair_panel()


# The bottom of the bar, which is what a tooltip has to be placed under.  Placed
# under the button hovered instead, the panel lies across every button below it.
func _lowest_visible_button():
	if _undress_bar == null:
		return null
	var lowest = null
	for child in _undress_bar.get_children():
		if child.visible:
			lowest = child
	return lowest


func _rule_tooltip(button, stand_clear_of = null):
	var globals_singleton = _singleton("globals")
	if globals_singleton == null or character == null:
		return
	var text = "[center]" + tr("WORKRULENUDITY") + "[/center]\n"
	text += character.translate(tr("WORKRULENUDITYDESCRIPT"))
	globals_singleton.connecttexttooltip(button, text, false, null, stand_clear_of)


# Which of the four are worth offering.  A step that renders exactly what the
# next one down renders is not a choice: a character with no outer clothes looks
# the same dressed as in their underwear, and one with nothing to keep on looks
# the same bare as naked.  The more dressed of the two is the one that goes -
# what the button promises is what is missing from it.
func _levels_that_differ():
	if model == null or character == null:
		return GEAR.LEVELS
	var equipment = _equipment()
	var pictures = {}
	for level in GEAR.LEVELS:
		var slots = CATALOGUE.compose(GEAR.selections_for(equipment, level, model.doll_id),
			model.axis_values)
		for slot_name in GEAR.hidden_slots(level):
			slots.erase(slot_name)
		pictures[level] = slots.hash()
	var result = []
	for index in GEAR.LEVELS.size():
		var level = GEAR.LEVELS[index]
		if !offered_undress_levels.empty() and !(level in offered_undress_levels):
			continue
		if index + 1 < GEAR.LEVELS.size() and pictures[level] == pictures[GEAR.LEVELS[index + 1]]:
			continue
		result.append(level)
	return result


# The wheel zooms, the left button drags.  Only inside this node's own rect,
# because that is the rect the screen gave the doll.
func _gui_input(event):
	if !allow_zoom or portrait_mode or model == null:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				# a poke at the chest swings it, the way the old doll did; anywhere
				# else the press starts a drag as before
				if tits_interaction(event.position):
					accept_event()
					return
				_drag_candidate = true
				_dragging = false
				_drag_from = event.position
				_pan_from = view_pan
			else:
				_drag_candidate = false
				_dragging = false
			return
		if !event.pressed or !(event.button_index in [BUTTON_WHEEL_UP, BUTTON_WHEEL_DOWN]):
			return
		var step = ZOOM_STEP if event.button_index == BUTTON_WHEEL_UP else -ZOOM_STEP
		var zoomed = clamp(view_zoom + step, ZOOM_MIN, ZOOM_MAX)
		if zoomed != view_zoom:
			view_zoom = zoomed
			_stand_on_the_node()
		accept_event()
		return
	if event is InputEventMouseMotion and _drag_candidate:
		var moved = event.position - _drag_from
		if !_dragging and moved.length_squared() < DRAG_THRESHOLD * DRAG_THRESHOLD:
			return
		_dragging = true
		view_pan = Vector2(
			clamp(_pan_from.x + moved.x, -PAN_LIMIT_X, PAN_LIMIT_X),
			clamp(_pan_from.y + moved.y, -rect_size.y * PAN_LIMIT_UP, rect_size.y * PAN_LIMIT_DOWN))
		_stand_on_the_node()
		accept_event()


# Puts the view back where it started, for a screen that wants a clean doll.
func reset_view():
	view_zoom = 1.0
	view_pan = Vector2.ZERO
	_stand_on_the_node()


# Shoots the doll into a picture.  Only in portrait mode, which means only in the
# booth: on a screen this node's viewport is the game window, and a portrait is
# not a screenshot of it.  The old doll cropped a rectangle out of whatever was
# rendered and the crop ran off the canvas on tall characters; here the whole
# viewport is the portrait.
func save_portrait(name, char_ref = null):
	if !portrait_mode:
		return false
	var folder = _portraits_folder()
	var directory = Directory.new()
	if !directory.dir_exists(folder):
		directory.make_dir(folder)
	var path = folder + name + ".png"
	# the render has to land before it can be read
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	if !is_inside_tree() or get_viewport() == null:
		if char_ref != null:
			char_ref.portrait_failed()
		return false
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	_unpremultiply(image)
	# handed over in memory as well as written: the png is only there to survive a
	# restart, and nothing has to read it back to show the fresh portrait
	var handler = _singleton("input_handler")
	if handler != null:
		handler.store_portrait(path, image)
	if char_ref != null:
		char_ref.portrait_ready(path)
	image.save_png(path)
	if handler != null:
		handler.emit_signal("PortraitUpdate")
	return true


# The autoloads are fetched rather than named.  Naming one from this script does
# not parse when the script is preloaded before the singletons are bound - the
# node then falls back to a plain Control and every call on it fails.
func _singleton(singleton_name):
	if !is_inside_tree():
		return null
	return get_tree().get_root().get_node_or_null(singleton_name)


func _portraits_folder():
	var settings = _singleton("variables")
	return str(settings.portraits_folder) if settings != null else "user://userportraits/"


# A half transparent pixel comes back from the canvas already multiplied by its
# own alpha, which darkens it.  Over a dark card that goes unnoticed; over a
# location backdrop it draws a dark rim around hair and ears.
func _unpremultiply(image):
	image.lock()
	for y in image.get_height():
		for x in image.get_width():
			var pixel = image.get_pixel(x, y)
			if pixel.a <= 0.0 or pixel.a >= 1.0:
				continue
			image.set_pixel(x, y, Color(
				min(pixel.r / pixel.a, 1.0), min(pixel.g / pixel.a, 1.0),
				min(pixel.b / pixel.a, 1.0), pixel.a))
	image.unlock()


# The old doll had to slide its pose until a crop frame landed on an anchor.
# This one is framed by construction, so there is nothing to centre.
func center_portrait_frame(_anchor = Vector2.ZERO):
	return portrait_mode


# --- the breast interaction ---------------------------------------------------
# Kept as no-ops so the screens that call them keep working; they need animation,
# which is off for now.

# A swing of the chest: the size sliders call this when the size changes, and a
# click on the breasts calls it through `tits_interaction`.  The swing itself
# belongs to the model, so the preview panel and the game show the same one.
func jiggle_tits(power = 1.0):
	if model == null or !is_visible_in_tree():
		return
	model.jiggle_tits(power)


func stop_tits_jiggle():
	if model != null:
		model.stop_tits_jiggle()


func tits_interaction(position = Vector2.ZERO):
	if model == null or model.scale.x == 0.0:
		return false
	var box = _bounds_of(model.TITS_SLOTS)
	if box.size.y <= 0.0:
		return false
	var local = (position - model.position) / model.scale
	if !box.has_point(local):
		return false
	jiggle_tits()
	return true


func get_tits_mesh():
	return null


func get_tits_outline():
	return null


# --- driving the doll ---------------------------------------------------------

func _apply():
	if model == null or character == null:
		return
	# The mesh nodes are about to be replaced, so a swing in flight is put back
	# before it loses the meshes it was moving.
	stop_tits_jiggle()
	var stats = {}
	for stat in STATS:
		stats[stat] = _stat(stat)
	stats["equipment"] = _equipment()
	stats["undress"] = undress_level
	stats["beast"] = _beast()

	var doll_id = _doll_id(stats)
	# a different sex is a different export, not only a different part list: the
	# skeletons share neither their bones nor their parts, so the model has to be
	# swapped rather than pointed at another catalogue
	if doll_id != model.doll_id:
		model._switch_doll(doll_id)
		model.handle_buttons.clear()
		model.handles_visible = false
		for animation_name in model.animation_states.keys():
			model.animation_states[animation_name] = false
	CATALOGUE.use(doll_id)
	model.selections = CATALOGUE.default_selections()
	var wanted = CHARACTER_MAP.selections_for(stats, doll_id)
	for group_id in wanted.keys():
		var part_id = str(wanted[group_id])
		if part_id.empty() or part_id in CATALOGUE.parts(group_id):
			model.selections[group_id] = part_id
			continue
		# This rig has not been drawn that piece.  Where the map names something it
		# stands in for - a second cut of an elven ear falls back to the plain one -
		# wear that; otherwise leave the slot as the catalogue has it.
		var stand_in = CHARACTER_MAP.stand_in(group_id, part_id)
		if stand_in != "" and stand_in in CATALOGUE.parts(group_id):
			model.selections[group_id] = stand_in
	# A hair stat that names a part outright is one somebody picked by hand, and
	# it is worn as it stands: the map's prefix rule is for the short values the
	# game generates (`straight` -> `hair_base_straight`) and cannot rebuild an
	# id that does not follow it.
	for layer in HAIR_LAYERS:
		var picked = str(stats.get(layer.stat, ""))
		if picked != "" and picked in CATALOGUE.parts(layer.group):
			model.selections[layer.group] = picked
	# An empty hair stat is a layer deliberately taken off.  The map leaves a slot
	# alone when it cannot resolve a value, which is right for a value it does not
	# know and wrong for a plain `none`, so the two optional layers are cleared
	# here rather than left on the catalogue's default.
	for layer in HAIR_LAYERS:
		if layer.group != "hair" and str(stats.get(layer.stat, "")) == "":
			model.selections[layer.group] = ""
	model.axis_values = CATALOGUE.default_axes()
	for stat in AXES.keys():
		var value = _axis_value(stat, stats.get(stat, ""))
		if value != "" and model.axis_values.has(AXES[stat]):
			model.axis_values[AXES[stat]] = value
	# The heavier legs the export ships are a race's, not a stat's: an orc and a
	# goblin stand on them, everybody else on the plain pair.
	if model.axis_values.has("legs"):
		model.axis_values["legs"] = "orc" if str(stats.get("race", "")) in ORC_LEGS else "default"
	# what the level wears is already in the selections; this is what it wears but
	# does not show, which is what makes a bare character bare
	model.hidden_slots = GEAR.hidden_slots(undress_level)
	model.height_tier = _height(str(stats.get("height", "")))
	#The preview picks the same six sizes by name, so the two cannot drift apart.
	model.proportions["butt"] = MODIFIERS.step_factor("butt", stats.get("ass_size", ""))
	# The art has one pair of genitals, so the three sizes the game carries are a
	# scale on the bones they hang from.
	model.proportions["dick"] = MODIFIERS.step_factor("dick", stats.get("penis_size", ""))
	model.proportions["balls"] = MODIFIERS.step_factor("balls", stats.get("balls_size", ""))
	_apply_colours()
	model._rebuild_model()
	_apply_coverage()
	model._update_animated_pose()
	_stand_on_the_node()
	_refresh_undress_bar()


# The character's own colours, on the channels that carry them.  A channel with
# no colour keeps white, which the shader reads as "leave the art alone" - that is
# what an unpainted part looked like on the old doll too.
func _apply_colours():
	# A coat is the artist's colour, not the character's.  The skin shade under it
	# tints the fur through the shader's lightness, which turned a dark cat's
	# orange coat muddy, so a furred body drops its skin before the pattern goes on.
	var worn_coat = _coverage_pattern()
	for channel_id in CHANNEL_COLOURS.keys():
		if !model.color_values.has(channel_id):
			continue
		if channel_id == "skin" and worn_coat != "":
			model.color_values[channel_id] = Color.white
			model._apply_channel_colour(channel_id)
			continue
		var pair = CHANNEL_COLOURS[channel_id]
		# A pointed ear is skin, not fur.  The old doll painted `body_color_ears`
		# onto its furry-ear node alone and never touched the humanoid one, whose
		# art is drawn in skin tone; the stat still answers for a human ear, with a
		# fallback of `yellow2` that has nothing to do with the character.
		if channel_id == "race" and str(model.selections.get("race_overlay", "")) in OVERLAY_FINS:
			# a nereid's arm and leg webbing is the same fin as the ears and the
			# tail, so it takes the fin colour instead of the skin the other race
			# overlays are painted in
			var webbing = COLORS.fins_code_for_skin(_stat("body_color_skin"))
			if webbing == "":
				webbing = str(_stat("body_color_skin"))
			model.color_values[channel_id] = COLORS.colour_of("body_color_tail", webbing)
			model._apply_channel_colour(channel_id)
			continue
		if channel_id == "nipples":
			# a furred chest wears the coat's nipples rather than the skin's
			var coat = COVERAGE.nipple_colour(_coverage_pattern())
			if coat == null:
				coat = COLORS.nipples_of(_stat("body_color_skin"))
			model.color_values[channel_id] = coat
			model._apply_channel_colour(channel_id)
			continue
		if channel_id == "ears" and !_wears_animal_ears():
			model.color_values[channel_id] = COLORS.colour_of("body_color_skin", _stat("body_color_skin"))
			model._apply_channel_colour(channel_id)
			continue
		model.color_values[channel_id] = COLORS.colour_of(str(pair[0]), _stat(str(pair[0])))
		if str(pair[1]) != "":
			model.color_values_secondary[channel_id] = COLORS.colour_of(str(pair[1]), _stat(str(pair[1])))
		model._apply_channel_colour(channel_id)


# `skin_coverage` -> the fur pattern painted over the body.  The names carried
# over unchanged where the art did; what the old doll had and this one has not is
# listed as empty, and the body is then simply bare skin.
const COVERAGE_PATTERNS = {
	"fur_orange": "fur_orange",
	"fur_orange_white": "fur_orange_white",
	"fur_white": "fur_white",
	"fur_grey": "fur_grey",
	"fur_brown": "fur_brown",
	"fur_black": "fur_black",
	"fur_striped": "fur_striped",
	"fur_tricolor": "fur_tricolor",
	"kobold": "kobold",
	# no art for these yet: feathers, plant, and the three scale patterns
	"feathers": "",
	"plant": "",
	"scale": "",
	"scale2": "",
	"scale3": "",
}


# The fur or scales the character wears, painted over the body's own colour.  It
# needs the masks, so it is applied after the meshes exist; and it belongs to a
# beastkin body alone, exactly as the patterns declare.
# The pattern the character actually wears: the stat says which one, the body
# says whether it can carry one at all.
func _coverage_pattern():
	var wanted = str(COVERAGE_PATTERNS.get(str(_stat("skin_coverage")), ""))
	if wanted != "" and !CATALOGUE.has_tag(str(model.selections.get("body", "")), COVERAGE.REQUIRES_TAG):
		return ""
	return wanted


func _apply_coverage():
	var wanted = _coverage_pattern()
	model.coverage_id = wanted
	model.coverage_colors = COVERAGE.default_colors(wanted)
	model._apply_coverage_to_meshes()


# Ears drawn as fur rather than as skin.  Everything the art calls an ear that is
# not one of the humanoid shapes.
# Race overlays that are webbing rather than hide: their art is the same fin the
# ears and the tail are, and it is painted in the fin colour.
const OVERLAY_FINS = ["race_nereid"]

# `ears_nereid` is deliberately absent: a nereid ear is a fin, and it takes the
# fin colour through `body_color_ears` rather than the plain skin.
const HUMANOID_EARS = ["ears_human", "ears_elven", "ears_orc", "ears_goblin"]

func _wears_animal_ears():
	var part_id = str(model.selections.get("ears", ""))
	return part_id != "" and !(part_id in HUMANOID_EARS)


# Two things at once: the doll is scaled to the frame it was given, and shifted
# so this node's own position is the ground it stands on.
#
# Both are read off the drawn geometry rather than from the preview's own origin.
# That origin is measured once per doll and does not follow the height tier - the
# tier stretches the spine and shrinks the head rather than scaling the whole
# figure, so the distance from the root to the feet moves with it.  Trusting it
# left a switched doll floating 66 px above its own node while a freshly built
# one stood 71 px below it.
func _stand_on_the_node():
	if model == null:
		return
	model.scale = Vector2.ONE
	if portrait_mode:
		_frame_the_head()
		return
	var shown = _bounds_of(BUST_PARTS) if show_from_the_hips else _body_bounds()
	if shown.size.y <= 0.0:
		return
	var frame = rect_size
	var tier = float(MODIFIERS.display_scale(model.height_tier))
	var tallest = float(MODIFIERS.display_scale(TALLEST_TIER))
	var fit = 1.0
	if frame.y > 0.0 and tier > 0.0 and tallest > 0.0:
		# Fitting what is shown to the frame would make every character exactly as
		# tall as every other, which is the one thing the height tier is for.  The
		# frame is fitted to a towering character instead, and this one keeps its
		# share of it.
		var reference = (shown.size.y * HEADROOM_FOR_HAIR) / tier
		fit = (frame.y * (1.0 - frame_headroom)) / (reference * tallest)
	fit *= view_zoom * float(SHORT_TIERS_NEARER.get(model.height_tier, 1.0))
	model.scale = Vector2(fit, fit)
	if show_from_the_hips:
		# Anchored at the hips, which is where the old doll anchored: it scaled the
		# whole figure by the tier (0.75 to 1.3) and then slid it up or down by a
		# per-tier offset - +60 px for the smallest, -30 for the largest - which is
		# exactly what it takes to keep everyone standing on one line while the
		# head rises.  Pinning the head instead, as this did before, aligns the
		# wrong end: heads level and feet wandering reads as being pushed about
		# rather than as being taller.
		var hip_line = HIPS_SIT_AT - float(SHORT_TIERS_HIGHER.get(model.height_tier, 0.0))
		model.position = Vector2(frame.x * 0.5, frame.y * hip_line) + view_pan - Vector2(shown.position.x + shown.size.x * 0.5, shown.end.y) * fit
	else:
		# stands on the bottom of its own box, in the middle of it
		model.position = Vector2(frame.x * 0.5, frame.y) + view_pan - Vector2(shown.position.x + shown.size.x * 0.5, shown.end.y) * fit


# How tall the doll stands, measured from the parts every doll has.  Not from
# everything drawn: a race overlay can carry a mesh with vertices far outside the
# figure - the slime one does - and measuring that shrinks the whole doll to fit
# a shape nobody can see.
# What the whole figure is measured by.  The animal halves are in here because a
# centaur or a lamia is that shape: measuring only the human half would leave the
# barrel or the coils hanging out of the bottom of the frame.
const MEASURED_BY = ["head", "head_skull", "torso", "pelvis", "leg_left", "leg_right",
	"animal_body", "animal_frontbody"]
# What a portrait is framed on.  The hair is left out on purpose: a very long
# style would otherwise pull the frame down to the character's waist.
const PORTRAIT_PARTS = ["head", "head_skull", "face", "eyes", "lips", "nose", "ears"]
# Head to hips: what a screen shows.  The legs run past the bottom of the frame
# and are clipped, which is how the old doll filled these panels.
const BUST_PARTS = ["head", "head_skull", "torso", "pelvis"]
# The head art stops at the crown; hair and horns sit above it, so the frame
# keeps a little more room than the body alone asks for.
const HEADROOM_FOR_HAIR = 1.12
# Where the hip line sits in the frame, as a share of its height.  Every
# character's hips land here whatever their height, and the head rises above it
# as they get taller - the way the old doll's per-tier offsets kept them on a
# common floor.
const HIPS_SIT_AT = 0.93
# A short character drawn at their own share of a frame built for a towering one
# ends up small and low in it, which reads as standing further away rather than
# as being short.  The smaller tiers are brought a little nearer and lifted a
# little off the bottom - enough to sit in the frame, not enough to lose the
# height difference, which is the whole point of the tier.
const SHORT_TIERS_NEARER = {"tiny": 1.10, "petite": 1.06, "short": 1.03}
const SHORT_TIERS_HIGHER = {"tiny": 0.04, "petite": 0.025, "short": 0.012}


# Fills the rect with the head, centred, whatever the character's height or
# hairstyle.  The frame is the portrait, so nothing is cropped afterwards.
func _frame_the_head():
	frame_on(PORTRAIT_PARTS, 1.0 / max(0.01, portrait_zoom))


# Fills the frame with whatever parts are named, centred, with `fill` saying how
# much of the frame they take: 1.0 is edge to edge and 0.4 leaves the rest of
# the face around them, which is what a picture of one mouth needs to be read
# at all.
func frame_on(slots, fill = 1.0):
	if model == null:
		return
	var box = _bounds_of(slots)
	if box.size.y <= 0.0 or fill <= 0.0:
		return
	var frame = rect_size
	var fit = min(frame.x * fill / box.size.x, frame.y * fill / box.size.y)
	model.scale = Vector2(fit, fit)
	model.position = frame * 0.5 - (box.position + box.size * 0.5) * fit


# The figure's own box: where it stands and how tall it is.
func _body_bounds():
	return _bounds_of(MEASURED_BY)


func _bounds_of(slots):
	var minimum = Vector2(1e9, 1e9)
	var maximum = Vector2(-1e9, -1e9)
	for record in model.mesh_records:
		if !is_instance_valid(record.polygon):
			continue
		if !(str(record.slot.get("name", "")) in slots):
			continue
		for point in record.polygon.polygon:
			var world = point + record.polygon.position
			minimum.x = min(minimum.x, world.x)
			minimum.y = min(minimum.y, world.y)
			maximum.x = max(maximum.x, world.x)
			maximum.y = max(maximum.y, world.y)
	if minimum.x > maximum.x:
		return Rect2()
	return Rect2(minimum, maximum - minimum)


func _axis_value(stat, value):
	value = str(value)
	if stat == "tits_size":
		return str(TITS.get(value, "normal"))
	if stat == "pregnancy_status":
		return str(PREGNANCY.get(value, "none"))
	if stat == "hand_pose":
		return value if value != "" else "1"
	return value


# The two skeletons are separate exports; sex chooses between them and a femboy
# body keeps the male one.
func _doll_id(stats):
	var sex = str(stats.get("sex", "female"))
	return "male" if sex == "male" else "female"


func _height(value):
	return value if value in ["tiny", "petite", "short", "average", "tall", "towering"] else "average"


# The animal a beastkin race is drawn from, for the muzzle.
func _beast():
	var race = str(_stat("race")).to_lower()
	for animal in ["cat", "fox", "wolf", "rabbit", "bunny", "tanuki", "rat"]:
		if race.find(animal) >= 0:
			return animal
	return "cat"


func _equipment():
	if character == null or !character.has_method("get_stat"):
		return {}
	var result = {}
	# the slots the game actually has; there is no `back` - a weapon slung across
	# the back is still equipped in a hand
	for slot_name in ["chest", "legs", "underwear", "neck", "head", "rhand"]:
		var item_id = null
		if character.get("equipment") != null and character.equipment.has_method("get_gear_type"):
			item_id = character.equipment.get_gear_type(slot_name)
		if item_id != null:
			result[slot_name] = str(item_id)
	return result


func _stat(statname):
	if character == null or !character.has_method("get_stat"):
		return ""
	if statname in NOT_A_STAT_YET:
		return ""
	var value = character.get_stat(statname)
	return "" if value == null else value


# Wear a pattern the character has not chosen, for the picture that offers it.
# The two roads a coat can take are both here: a dragon's scales and a kobold's
# spots are drawn parts and swap the race overlay, everything else is a mask
# painted over the body.  Nothing on the character is touched - this is a
# picture of a choice, not a choice being made.
func show_coverage(value):
	if model == null:
		return
	var race = str(_stat("race"))
	var variants = CHARACTER_MAP.OVERLAY_COVERAGE.get(str(CHARACTER_MAP.RACE_OVERLAYS.get(race, "")), {})
	if variants.has(str(value)):
		model.selections["race_overlay"] = str(variants[str(value)])
		model._rebuild_model()
		model._update_animated_pose()
		return
	var pattern = str(COVERAGE_PATTERNS.get(str(value), ""))
	if pattern != "" and !CATALOGUE.has_tag(str(model.selections.get("body", "")), COVERAGE.REQUIRES_TAG):
		pattern = ""
	model.coverage_id = pattern
	model.coverage_colors = COVERAGE.default_colors(pattern)
	model._apply_coverage_to_meshes()
	# the chest belongs to the coat as much as the back does
	if model.color_values.has("nipples"):
		var coat_nipples = COVERAGE.nipple_colour(pattern)
		if coat_nipples == null:
			coat_nipples = COLORS.nipples_of(_stat("body_color_skin"))
		model.color_values["nipples"] = coat_nipples
		model._apply_channel_colour("nipples")
