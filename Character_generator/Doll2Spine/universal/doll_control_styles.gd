extends Reference

# the doll authors a copy of this palette in `Doll2View.tscn`; change both when a
# colour or frame changes so its controls still match the painted cast's toggle

# The dress the doll's own controls wear: the undress bar, the hair button and
# the hair menu that button opens.
#
# The values are the mansion slave-list cards' - dark brown fill, copper frame,
# gold when it is the one picked.  The controls are drawn on top of those screens
# and used to wear the character-creation theme instead, which is teal and read
# as belonging to another screen.
#
# It lives in a file of its own for `NudityToggle`, which is that bar's one button
# for the unique cast, who are painted sprites with no doll scene to put it in.
#
# Nothing here reads a singleton, so it can be preloaded from anywhere.

const FILL_NORMAL = Color(0.105882, 0.0705882, 0.0588235, 0.96)
const FILL_HOVER = Color(0.121569, 0.0803922, 0.0627451, 0.98)
const FILL_PRESSED = Color(0.137255, 0.0901961, 0.0627451, 1)
const BORDER_NORMAL = Color(0.486275, 0.309804, 0.227451, 1)
const BORDER_HOVER = Color(0.65098, 0.52549, 0.266667, 1)
const BORDER_PRESSED = Color(0.976471, 0.760784, 0.25098, 1)

const FONT_NORMAL = Color(0.88, 0.88, 0.88)
const FONT_HOVER = Color(0.94, 0.94, 0.94)
const FONT_PRESSED = Color(1, 1, 1)
const FONT_DISABLED = Color(0.9, 0.9, 0.9, 0.35)
# the label column in the hair menu, quieter than the text on the buttons so the
# eye lands on what is pickable
const FONT_LABEL = Color(0.72, 0.7, 0.68)

const RADIUS = 5
# the pressed frame is a touch tighter, which is what the cards do to say a thing
# is held rather than merely there
const RADIUS_PRESSED = 4
const BORDER_WIDTH = 2
# a colour picker draws its colour inside the frame, so the frame is kept thin
# and the swatch is not squeezed by it
const SWATCH_BORDER_WIDTH = 1
const STATES = ["normal", "hover", "pressed", "disabled"]


# One box per state, built once and handed to every control that wants it:
# sharing the resources is also what keeps a button from shifting by a pixel as
# it changes state.
static func build(border_width = BORDER_WIDTH):
	var styles = {}
	styles.normal = flat(FILL_NORMAL, BORDER_NORMAL, RADIUS, border_width)
	styles.hover = flat(FILL_HOVER, BORDER_HOVER, RADIUS, border_width)
	styles.pressed = flat(FILL_PRESSED, BORDER_PRESSED, RADIUS_PRESSED, border_width)
	# the theme this replaced had no disabled box at all, so a blocked button fell
	# back to Godot's grey one in the middle of the bar.  A copy of `normal` keeps
	# the frame the others wear and lets the dimmed font say it is off.
	styles.disabled = styles.normal.duplicate()
	return styles


static func flat(fill, border, radius, border_width):
	var style = StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_right = radius
	style.corner_radius_bottom_left = radius
	return style


# Everything a button needs to join the set.  `styles` is a dictionary from
# `build`, so a caller with several buttons builds one and dresses them all.
static func dress_button(button, styles, font = null):
	for state in STATES:
		button.add_stylebox_override(state, styles[state])
	if font != null:
		button.add_font_override("font", font)
	button.add_color_override("font_color", FONT_NORMAL)
	button.add_color_override("font_color_hover", FONT_HOVER)
	button.add_color_override("font_color_pressed", FONT_PRESSED)
	button.add_color_override("font_color_disabled", FONT_DISABLED)


# The same frame around something that is not a button - the hair menu's own
# panel.  It carries content margins, which a button takes from its text.
static func panel(margin = 8):
	var style = flat(FILL_NORMAL, BORDER_NORMAL, RADIUS, BORDER_WIDTH)
	style.content_margin_left = margin
	style.content_margin_top = margin
	style.content_margin_right = margin
	style.content_margin_bottom = margin
	return style
