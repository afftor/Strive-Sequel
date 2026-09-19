extends Reference

# Fur and scale patterns painted over the body, ported from the old paperdoll's
# `skin_coverage` stat.
#
# A pattern is an optional `base` colour plus a stack of layers, each a full-body
# mask and a colour.  The mask says where its colour goes and how strongly - its
# alpha is the blend weight, so a soft edge fades instead of cutting.
#
# The base is what covers the whole body under the masks, and it is not optional
# decoration: the masks are painted around a torso, so anything that reaches past
# that silhouette - a large pair of breasts most of all - falls outside every mask
# and would otherwise stay bare skin in the middle of a furred body.  The old
# paperdoll had exactly this: its zone 1 carried no mask and so painted
# everywhere.  Patterns that are patches on bare skin, like the tricolour cat,
# genuinely have no base and leave it out.
#
# The masks are the ones the old doll already ships, in Character_generator/
# images/98_masks.  They still fit: every mask is the 872x1514 art canvas, and
# the Spine meshes still declare that same canvas, so a mask lands on the new
# body within a dozen pixels of where it landed on the old one.  Nothing here
# needs new art.
#
# Colours are only starting points - every layer has its own picker.  The old
# presets could not be copied over: they store hue rotations against a red
# reference, not the colours you actually see.

const MASKS = "res://Character_generator/images/98_masks/"

const ORDER = [
	"fur_orange", "fur_orange_white", "fur_white", "fur_grey", "fur_brown",
	"fur_black", "fur_striped", "fur_tricolor", "kobold",
]

# The coat colours are the artist's own, read off the preview's pickers in the
# order they appear there: the first picker is the base where a pattern has one,
# then each mask in turn.  `nipple` is the colour a furred chest wears instead of
# the one its skin shade would give.  `mouth` is which of those colours, counted
# the same way, the lips sit in: the mask that covers the lips' place on the
# canvas (x 420-460, y 348-362), read off the mask files.  A beastkin's mouth is
# a darker shade of that fur rather than of the skin under it - see
# ch_stats.get_body_color_lips().
const PATTERNS = {
	"fur_orange": {
		"label": "Fur: orange",
		"base": Color("904b18"),
		"nipple": Color("543131"),
		"mouth": 2,
		"layers": [
			{"mask": "white_mask.png", "color": Color("904b18")},
#			{"mask": "mask_besatkin 2.png", "color": Color("904b18")},
		],
	},
	"fur_orange_white": {
		"label": "Fur: orange and white",
		"base": Color("67605b"),
		"nipple": Color("645553"),
		"mouth": 2,
		"layers": [
			{"mask": "mask_besatkin 2 ext.png", "color": Color("ad5c21")},
			{"mask": "mask_besatkin 2.png", "color": Color("9e9595")},
		],
		"layers_alternate": [
			{"mask": "white_mask.png", "color": Color("ad5c21")},
		],
	},
	"fur_white": {
		"label": "Fur: white",
		"base": Color("6a6464"),
		"nipple": Color("6b6564"),
		"mouth": 2,
		"layers": [
			{"mask": "white_mask.png", "color": Color("ababab")},
#			{"mask": "mask_besatkin 2.png", "color": Color("ababab")},
		],
	},
	"fur_grey": {
		"label": "Fur: grey",
		"base": Color("6d6d6d"),
		"nipple": Color("4e4948"),
		"mouth": 2,
		"layers": [
			{"mask": "white_mask.png", "color": Color("6d6d6d")},
#			{"mask": "mask_besatkin 2.png", "color": Color("6d6d6d")},
		],
	},
	"fur_brown": {
		"label": "Fur: brown",
		"base": Color("846952"),
		"nipple": Color("493c3a"),
		"mouth": 2,
		"layers": [
			{"mask": "white_mask.png", "color": Color("513b28")},
#			{"mask": "mask_besatkin 2.png", "color": Color("513b28")},
		],
	},
	"fur_black": {
		"label": "Fur: black",
		"base": Color("a09b9b"),
		"nipple": Color("342f2e"),
		"mouth": 2,
		"layers": [
			{"mask": "mask_besatkin 2 ext.png", "color": Color("191918")},
			{"mask": "mask_besatkin 2.png", "color": Color("363533")},
		],
		"layers_alternate": [
			{"mask": "white_mask.png", "color": Color("191918")},
		],
	},
	# The striped and tricolour cats use their own masks rather than the shared
	# beastkin pair, which is what makes their patterns read as patterns.
	"fur_striped": {
		"label": "Fur: striped",
		"base": Color("745d49"),
		"nipple": Color("855151"),
		"mouth": 1,
		"layers": [
			{"mask": "mask_cat 2.png", "color": Color("925927")},
			{"mask": "mask_cat2 2 ext.png", "color": Color("21170f")},
		],
	},
	"fur_tricolor": {
		"label": "Fur: tricolour",
		"nipple": Color("705c58"),
		"mouth": 1,
		"layers": [
			{"mask": "mask_besatkin cat_tricolor_black.png", "color": Color("655340")},
			{"mask": "mask_besatkin cat_tricolor_white.png", "color": Color("92846c")},
			{"mask": "mask_besatkin cat_tricolor_yellow.png", "color": Color("6b5022")},
		],
	},
	"kobold": {
		"label": "Scales: kobold",
		"layers": [
			{"mask": "mask_kobold.png", "color": Color("7a6a4a")},
		],
	},
}

const MAX_LAYERS = 3

# Patterns only apply to a body that can grow fur.  A human body takes none of
# them, so the control is offered only while a body carrying this tag is worn.
const REQUIRES_TAG = "beastkin"


static func pattern(pattern_id):
	return PATTERNS.get(pattern_id, {})


static func layers(pattern_id, alternate = false):
	var pattern = pattern(pattern_id)
	var res = pattern.get("layers", [])
	if alternate and pattern.has("layers_alternate"): #only if alternate layers exists, fallback is basic layers, so no overwriting without checking
		res = pattern.get("layers_alternate") 
	return res


static func mask_path(pattern_id, index, alternate = false):
	var list = layers(pattern_id, alternate)
	if index < 0 or index >= list.size():
		return ""
	return MASKS + str(list[index].mask)


# The base is index 0 of the colour list, so a pattern with one is offered one
# picker more than it has masks.  White means the body keeps its own colour.
# The nipples a coat brings with it, or null when the pattern says nothing and
# the skin's own shade should answer.
static func nipple_colour(pattern_id):
	var found = pattern(pattern_id).get("nipple", null)
	return found


# Which of a pattern's colours the mouth sits in - an index into `default_colors()`,
# and so into a repainted `body_color_coat` - or -1 where the pattern puts no fur
# over the mouth.
static func mouth_index(pattern_id):
	return int(pattern(pattern_id).get("mouth", -1))


static func has_base(pattern_id):
	return pattern(pattern_id).has("base")


static func default_colors(pattern_id):
	var result = []
	if has_base(pattern_id):
		result.append(pattern(pattern_id).base)
	for layer in layers(pattern_id):
		result.append(layer.color)
	return result


static func color_count(pattern_id):
	return layers(pattern_id).size() + (1 if has_base(pattern_id) else 0)
