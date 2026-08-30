extends Reference

# How the character creation screen lays its options out.
#
# The screen used to draw every option the same way - a label with an arrow on
# each side - so a hairstyle, a height and a virginity all read alike and none of
# them showed what they were.  This says which control each option deserves; the
# screen builds them, and this file is where the decision lives so it can be
# changed without reading the builder.

# Options whose values are a ladder from least to most: a slider says at a glance
# where on it a character stands, which an arrow pair never did.
const SLIDERS = ["height", "head_size", "tits_size", "ass_size", "penis_size", "balls_size",
	"hair_base_length", "hair_back_length", "hair_assist_length"]

# Values that are on the list but not on the ladder.  A masculine chest is not a
# size between two others, so it sits at the far end of the slider rather than
# in the middle of the run.
const OFF_THE_LADDER = {
	"tits_size": ["masculine"],
	"ass_size": ["masculine"],
}

# Values a stat can hold but nobody may choose.  `bald` is not a hair length, it
# is the absence of hair, and on a slider it sat one step past `short` where a
# player shaved a character by nudging it.  Characters still generate bald - the
# value keeps working everywhere that reads it - it simply is not on offer.
const NEVER_OFFERED = {
	"hair_base_length": ["bald"],
	"hair_fringe_length": ["bald"],
}


# Whether a value may be put in front of the player at all.
static func offered(statname, value):
	return !(value in NEVER_OFFERED.get(str(statname), []))

# One button per part, each opening its own panel of pictures - the character's
# own head wearing each option, the current one framed.  Not grouped: a player
# looking for the nose should press `nose`, not hunt through a `face details`
# drawer.  The pictures come from `doll2_option_previews.gd`, which photographs
# the doll and frames each shot on the part being chosen; there is no preview
# art in the project to load instead.
#
# `hair_fringe` is deliberately absent: the new doll has no fringe of its own,
# every hairstyle carries one, and the stat drives nothing.
const SUBMENUS = [
	{"id": "hair_base", "label": "CHARCREATE_MENU_HAIR", "stats": ["hair_base"]},
	{"id": "hair_back", "label": "CHARCREATE_MENU_HAIR_BACK", "stats": ["hair_back"]},
	{"id": "hair_assist", "label": "CHARCREATE_MENU_HAIR_EXTRA", "stats": ["hair_assist"]},
	# Male art only: the row hides itself for anyone whose only beard is `no`.
	{"id": "beard", "label": "CHARCREATE_MENU_BEARD", "stats": ["beard"]},
	{"id": "eye_tex", "label": "CHARCREATE_MENU_EYES", "stats": ["eye_tex"]},
	{"id": "eyeshape", "label": "CHARCREATE_MENU_EYE_SHAPE", "stats": ["eyeshape"]},
	{"id": "chin", "label": "CHARCREATE_MENU_CHIN", "stats": ["chin"]},
	{"id": "eyebrows", "label": "CHARCREATE_MENU_EYEBROWS", "stats": ["eyebrows"]},
	{"id": "nose", "label": "CHARCREATE_MENU_NOSE", "stats": ["nose"]},
	{"id": "lips", "label": "CHARCREATE_MENU_LIPS", "stats": ["lips"]},
	{"id": "ears", "label": "CHARCREATE_MENU_EARS", "stats": ["ears"]},
	{"id": "tail", "label": "CHARCREATE_MENU_TAIL", "stats": ["tail"]},
	{"id": "skin_coverage", "label": "CHARCREATE_MENU_COVERAGE", "stats": ["skin_coverage"]},
	{"id": "horns", "label": "CHARCREATE_MENU_HORNS", "stats": ["horns"]},
]

# Yes or no, so a box to tick.
const CHECKBOXES = ["penis_virgin", "vaginal_virgin", "anal_virgin", "mouth_virgin"]

# A colour belongs under the thing it paints, not in a heap of swatches at the
# bottom of the screen.  Left is the colour, right is the option it follows; a
# colour whose option is not on screen follows nothing and is not shown either.
const COLOUR_FOLLOWS = {
	# the skin has no option row of its own to follow - a race decides it - so the
	# swatches stand alone at the top of the visuals
	"body_color_skin": "",
	"eye_color": "eye_tex",
	"body_color_lips": "lips",
	"body_color_eyebrows": "eyebrows",
	"hair_base_color_1": "hair_base",
	"hair_base_color_2": "hair_base",
	"hair_back_color_1": "hair_back",
	"hair_back_color_2": "hair_back",
	"hair_assist_color_1": "hair_assist",
	"hair_assist_color_2": "hair_assist",
	"hair_facial_color": "beard",
	"body_color_wings": "wings",
	"body_color_tail": "tail",
	"body_color_horns": "horns",
	"body_color_animal": "body_lower",
	# fur ears sit right under the ear they are the colour of
	"body_color_ears": "ears",
}

# Colours with a rule behind them are still offered, but their first value is the
# rule itself: an empty stat means "whatever this other colour is", and the
# swatch for it shows that colour so the player can see what they are keeping.
# Everything after it is the whole palette rather than the race's short list -
# a painted mouth is a choice, not a birthright.
const DEFAULT_COLOUR_FROM = {
	"body_color_lips": "body_color_skin",
	"body_color_eyebrows": "hair_base_color_1",
	# a beastkin's ears are the colour of the hair between them unless the player
	# says otherwise, and the fur a character is covered in overrules both
	"body_color_ears": "hair_base_color_1",
	# and the tail is the same story
	"body_color_tail": "hair_base_color_1",
}

# Colours the game works out entirely on its own - a fur tail takes the hair, a
# dragon's horns the hide - are not offered at all; `ch_stats.derives_colour()`
# is what answers that, and the screen already asks it.


# The seven factors are the only thing on the screen a player spends points on,
# and they used to read as a wall of identical arrow pairs labelled by a picture
# of the word "PHY".  Each one gets a plate of its own colour instead, so the row
# is told apart by its colour and its picture before any text is read.
#
# `colour` paints the plate, the border, the pips and the name.  The picture is
# a medallion in `assets/images/iconsfactors` named after the stat itself, so
# there is no second name here to fall out of step with the first.  Those
# medallions carry their own colour - they must not be tinted the way a flat
# glyph would be.  `hint` is the one-line "what does this do" under the name;
# the long text stays where it was, on the row's tooltip.
#
# The order is the order the rows appear in.  A master has no `tame_factor` or
# `authority_factor` - `possible_vals` comes back empty for those two and the
# screen hides the rows - so this list is seven rows for a slave and five for a
# master without saying so twice.
const FACTOR_ROWS = [
	{"stat": "physics_factor",   "colour": "e2564e"},
	{"stat": "wits_factor",      "colour": "4a9be0"},
	{"stat": "charm_factor",     "colour": "a566d8"},
	{"stat": "sexuals_factor",   "colour": "e76a9e"},
	{"stat": "magic_factor",     "colour": "4fb86b"},
	{"stat": "tame_factor",      "colour": "d6a93f"},
	{"stat": "authority_factor", "colour": "d2703f"},
]

const FACTOR_ICON_DIR = "res://assets/images/iconsfactors/"

# How strongly the plate is washed with the row's colour, and how strongly its
# border is drawn in it.  Kept here rather than in the scene so the whole set can
# be re-tuned in one place.
const FACTOR_WASH_ALPHA = 0.38
const FACTOR_BORDER_ALPHA = 0.60
const FACTOR_PIP_EMPTY_ALPHA = 0.35

# What the panel costs to draw, so its height can be worked out from how many
# rows are actually on it.  CHROME is everything that is not a row: the frame and
# the mode buttons above the first plate, and the unassigned-points line below the
# last one.  These have to agree with StatsContainer's margins in the scene
# (margin_top 93, margin_bottom -62) and with FactorRow's rect_min_size.
const FACTOR_ROW_HEIGHT = 54
const FACTOR_ROW_SEPARATION = 4
const STATS_PANEL_CHROME = 155
const STATS_PANEL_GAP = 6


# The row description for a factor, or null when the stat is not one.
static func factor_row(statname):
	for row in FACTOR_ROWS:
		if row.stat == str(statname):
			return row
	return null


# The one-line hint under a factor's name.  Derived from the stat code so a new
# factor needs no entry here, only its key in `localization/en/main.gd`.
static func factor_hint_key(statname):
	return "CHARCREATE_STAT_HINT_" + str(statname).to_upper()


# The values of a slider option, ladder first and the odd ones after it.
static func ladder(statname, values):
	var odd = OFF_THE_LADDER.get(str(statname), [])
	var result = []
	for value in values:
		if !(value in odd):
			result.append(value)
	for value in values:
		if value in odd:
			result.append(value)
	return result


# Which submenu an option belongs to, or "" when it stays on the main list.
static func submenu_of(statname):
	for menu in SUBMENUS:
		if str(statname) in menu.stats:
			return str(menu.id)
	return ""
