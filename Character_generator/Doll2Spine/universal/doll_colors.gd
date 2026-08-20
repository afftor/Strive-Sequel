extends Reference

# The old paperdoll's palette, read off the old paperdoll.
#
# It could not be copied out of the preset materials: a colour transform takes
# one numbered slot from a shared `.tres`, and the three slots in those files
# neither agree with each other nor with the name on the file.  So every value
# was applied to a real doll, the pixels it moved were found by diffing two
# values, and those pixels were averaged.  That average is what the new doll's
# picker wants anyway: its shader replaces hue and saturation and keeps the art's
# own shading, so the colour is what matters and the shading is not.
#
# Sampled from `ragdoll.tscn` on 2026-08-20.  `legacy/old_doll_behaviour.md`
# lists which stat each family belongs to.

# `body_color_skin`: 42 shades, pale to dark.
const SKIN = {
	"blue1": Color(0.5103, 0.4993, 0.7365),
	"blue2": Color(0.4374, 0.4228, 0.7199),
	"blue3": Color(0.3482, 0.3336, 0.7089),
	"blue4": Color(0.3134, 0.2951, 0.5873),
	"blue5": Color(0.2624, 0.2484, 0.5075),
	"green1": Color(0.4846, 0.6056, 0.3826),
	"green2": Color(0.4515, 0.5795, 0.3487),
	"green3": Color(0.3807, 0.5008, 0.2877),
	"green4": Color(0.2884, 0.4077, 0.2011),
	"green5": Color(0.2085, 0.3274, 0.1212),
	"grey1": Color(0.7036, 0.7029, 0.7029),
	"grey2": Color(0.6612, 0.6606, 0.6605),
	"grey3": Color(0.5443, 0.5437, 0.5436),
	"grey4": Color(0.4763, 0.4757, 0.4756),
	"grey5": Color(0.4056, 0.4050, 0.4048),
	"human1": Color(0.8526, 0.7416, 0.6615),
	"human2": Color(0.8066, 0.6420, 0.5266),
	"human3": Color(0.7732, 0.6047, 0.4563),
	"human4": Color(0.7284, 0.5370, 0.4050),
	"human5": Color(0.4882, 0.3465, 0.2414),
	"human6": Color(0.3884, 0.3089, 0.1215),
	"human7": Color(0.2949, 0.2344, 0.0881),
	"pink1": Color(0.9489, 0.8313, 0.8544),
	"pink2": Color(0.9106, 0.7367, 0.7688),
	"pink3": Color(0.8478, 0.5199, 0.6587),
	"pink4": Color(0.8066, 0.3745, 0.5594),
	"pink5": Color(0.7242, 0.2375, 0.4499),
	"purple1": Color(0.8954, 0.8026, 0.8986),
	"purple2": Color(0.7812, 0.5684, 0.7862),
	"purple3": Color(0.6316, 0.3737, 0.7018),
	"purple4": Color(0.5162, 0.2615, 0.5808),
	"purple5": Color(0.4521, 0.2548, 0.5409),
	"red1": Color(0.9226, 0.7999, 0.7202),
	"red2": Color(0.9387, 0.8103, 0.7508),
	"red3": Color(0.8843, 0.6696, 0.6184),
	"red4": Color(0.8210, 0.5071, 0.4617),
	"red5": Color(0.7302, 0.2994, 0.3083),
	"yellow1": Color(0.8488, 0.8544, 0.6789),
	"yellow2": Color(0.8022, 0.8096, 0.5974),
	"yellow3": Color(0.7366, 0.6925, 0.5258),
	"yellow4": Color(0.6750, 0.5981, 0.3411),
	"yellow5": Color(0.6081, 0.5264, 0.2548),
}

# Every hair layer, both colours: `hair_*_color_1` and `_2` share these names.
const HAIR = {
	"blue_1": Color(0.3576, 0.3291, 0.6377),
	"blue_2": Color(0.2456, 0.2561, 0.5170),
	"blue_3": Color(0.1963, 0.1664, 0.3632),
	"brown_1": Color(0.5281, 0.3877, 0.2859),
	"brown_2": Color(0.3960, 0.2460, 0.1829),
	"brown_3": Color(0.2832, 0.1775, 0.1475),
	"cyan_1": Color(0.2863, 0.5199, 0.5497),
	"cyan_2": Color(0.2239, 0.3828, 0.4646),
	"cyan_3": Color(0.1382, 0.2740, 0.3601),
	"dark_1": Color(0.2477, 0.2360, 0.2247),
	"dark_2": Color(0.1736, 0.1619, 0.1505),
	"dark_3": Color(0.1318, 0.1199, 0.1087),
	"green_1": Color(0.4373, 0.5957, 0.2355),
	"green_2": Color(0.3407, 0.4579, 0.1703),
	"green_3": Color(0.2307, 0.3455, 0.1377),
	"orange_1": Color(0.7103, 0.4133, 0.1488),
	"orange_2": Color(0.6259, 0.3100, 0.1366),
	"orange_3": Color(0.4444, 0.2059, 0.1087),
	"pink_1": Color(0.6342, 0.2911, 0.4871),
	"pink_2": Color(0.5372, 0.2334, 0.4030),
	"pink_3": Color(0.3896, 0.1715, 0.2857),
	"purple_1": Color(0.5526, 0.3131, 0.6986),
	"purple_2": Color(0.4368, 0.2723, 0.5203),
	"purple_3": Color(0.2933, 0.1779, 0.3406),
	"red_1": Color(0.6448, 0.3037, 0.2727),
	"red_2": Color(0.5394, 0.2728, 0.2342),
	"red_3": Color(0.4057, 0.1816, 0.1825),
	"white_1": Color(0.6409, 0.6291, 0.6177),
	"white_2": Color(0.5185, 0.5067, 0.4954),
	"white_3": Color(0.4669, 0.4551, 0.4438),
	"yellow_1": Color(0.6261, 0.5481, 0.2976),
	"yellow_2": Color(0.5455, 0.4522, 0.2267),
	"yellow_3": Color(0.4596, 0.3787, 0.2030),
}

# `eye_color`.
const EYES = {
	"black": Color(0.1720, 0.1337, 0.2123),
	"blue": Color(0.2152, 0.2430, 0.4863),
	"brown": Color(0.3752, 0.2483, 0.2066),
	"cyan": Color(0.2510, 0.4576, 0.6157),
	"green": Color(0.3528, 0.5057, 0.2119),
	"grey": Color(0.3845, 0.3786, 0.4053),
	"pink": Color(0.6234, 0.0818, 0.5665),
	"purple": Color(0.4112, 0.1683, 0.4800),
	"red": Color(0.4178, 0.2004, 0.2055),
	"yellow": Color(0.4765, 0.3487, 0.1310),
}

# `body_color_lips`.
const LIPS = {
	"black": Color(0.1373, 0.1431, 0.1108),
	"blue": Color(0.2078, 0.2265, 0.3333),
	"brown": Color(0.3098, 0.2010, 0.1598),
	"cyan": Color(0.1990, 0.3755, 0.4412),
	"green": Color(0.3196, 0.3794, 0.1520),
	"grey": Color(0.3147, 0.2931, 0.2804),
	"pink": Color(0.4755, 0.0971, 0.4284),
	"purple": Color(0.3108, 0.1637, 0.3265),
	"red": Color(0.3363, 0.1745, 0.1637),
	"yellow": Color(0.3725, 0.2490, 0.1108),
}

# `body_color_ears`, `_tail`, `_wings`, `_horns` and `_animal` share one palette.
# Sampled off a tail: it is the only one of them big enough to measure reliably.
const BODY_PARTS = {
	"blue1": Color(0.4653, 0.4500, 0.7715),
	"blue2": Color(0.2769, 0.3082, 0.6517),
	"blue3": Color(0.1871, 0.1659, 0.4533),
	"brown1": Color(0.6349, 0.4691, 0.3626),
	"brown2": Color(0.4698, 0.2733, 0.2052),
	"brown3": Color(0.3148, 0.1794, 0.1558),
	"cyan1": Color(0.3446, 0.6419, 0.6853),
	"cyan2": Color(0.2364, 0.4734, 0.5925),
	"cyan3": Color(0.1145, 0.3202, 0.4493),
	"dark1": Color(0.2658, 0.2623, 0.2623),
	"dark2": Color(0.1634, 0.1600, 0.1600),
	"dark3": Color(0.1057, 0.1022, 0.1022),
	"green1": Color(0.5337, 0.7265, 0.3098),
	"green2": Color(0.4001, 0.5691, 0.1870),
	"green3": Color(0.2466, 0.4136, 0.1422),
	"orange1": Color(0.8495, 0.4998, 0.2125),
	"orange2": Color(0.7655, 0.3614, 0.1631),
	"orange3": Color(0.5371, 0.2144, 0.1023),
	"pink1": Color(0.7534, 0.3842, 0.6189),
	"pink2": Color(0.6518, 0.2723, 0.5114),
	"pink3": Color(0.4616, 0.1734, 0.3510),
	"purple1": Color(0.6682, 0.4591, 0.8264),
	"purple2": Color(0.5182, 0.3309, 0.6520),
	"purple3": Color(0.3249, 0.1822, 0.4225),
	"red1": Color(0.7651, 0.3909, 0.3754),
	"red2": Color(0.6532, 0.3188, 0.2901),
	"red3": Color(0.4838, 0.1868, 0.2079),
	"white1": Color(0.8047, 0.8013, 0.8013),
	"white2": Color(0.6395, 0.6360, 0.6360),
	"white3": Color(0.5683, 0.5649, 0.5649),
	"yellow1": Color(0.7435, 0.6628, 0.4075),
	"yellow2": Color(0.6611, 0.5477, 0.2808),
	"yellow3": Color(0.5577, 0.4541, 0.2328),
}

# Which table a stat reads from.
const FAMILIES = {
	"body_color_skin": "SKIN",
	"hair_base_color_1": "HAIR", "hair_base_color_2": "HAIR",
	"hair_fringe_color_1": "HAIR", "hair_fringe_color_2": "HAIR",
	"hair_back_color_1": "HAIR", "hair_back_color_2": "HAIR",
	"hair_assist_color_1": "HAIR", "hair_assist_color_2": "HAIR",
	"hair_facial_color": "HAIR",
	"eye_color": "EYES",
	"body_color_lips": "LIPS",
	"body_color_ears": "BODY_PARTS", "body_color_tail": "BODY_PARTS",
	"body_color_wings": "BODY_PARTS", "body_color_horns": "BODY_PARTS",
	"body_color_animal": "BODY_PARTS",
}


# The colour a stat value means.  White when the value is unknown or empty, which
# is what the shader reads as "leave the art as the artist drew it".
static func colour_of(statname, value):
	var table = _table(str(FAMILIES.get(statname, "")))
	return table.get(str(value), Color(1, 1, 1))


static func _table(name):
	match name:
		"SKIN":
			return SKIN
		"HAIR":
			return HAIR
		"EYES":
			return EYES
		"LIPS":
			return LIPS
		"BODY_PARTS":
			return BODY_PARTS
	return {}
