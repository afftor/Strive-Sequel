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
	"human1": Color(0.7, 0.45, 0.38),
	"human2": Color(0.59, 0.4, 0.33),
	"human3": Color(0.48, 0.34, 0.26),
	"human4": Color(0.36, 0.29, 0.25),
	"human5": Color(0.25, 0.2, 0.18),
	"orc1": Color(0.32, 0.33, 0.26),
	"orc2": Color(0.32, 0.24, 0.31),
	"orc3": Color(0.2, 0.21, 0.12),
	"orc4": Color(0.34, 0.27, 0.15),
	"dryad1": Color(0.34, 0.28, 0.41),
	"darkelf1": Color(0.34, 0.28, 0.41),
	"darkelf2": Color(0.26, 0.25, 0.34),
	"darkelf3": Color(0.32, 0.25, 0.34),
	"darkelf4": Color(0.2, 0.25, 0.3),
	"kobold1": Color(0.27, 0.3, 0.2),
	"kobold2": Color(0.18, 0.23, 0.18),
	"kobold3": Color(0.3, 0.23, 0.2),
	"kobold4": Color(0.3, 0.2, 0.21),
	"demon1": Color(0.39, 0.23, 0.2),
	"demon2": Color(0.28, 0.19, 0.31),
	"nereid1": Color(0.26, 0.33, 0.33),
	"nereid2": Color(0.26, 0.33, 0.29),
	"nereid3": Color(0.49, 0.28, 0.48),

}

const color = {
	nipple_human1 = "d26161",
	nipple_human2 = "a94040",
	nipple_human3 = "7f3b3b",
	nipple_human4 = "5c4040",
	nipple_human5 = "3d2727",
	nipple_humanpreg = "2d2020",
	nipple_orc1 = "515c35",
	nipple_orc2 = "56355c",
	nipple_orc3 = "2a352d",
	nipple_orc4 = "473c24",
	nipple_dryad1 = "472c5a",
	nipple_darkelf1 = "332c5a",
	nipple_darkelf2 = "59375d",
	nipple_darkelf3 = "643b77",
	nipple_darkelf4 = "284353",
	nipple_kobold1 = "384b2d",
	nipple_kobold2 = "232f1c",
	nipple_kobold3 = "483127",
	nipple_kobold4 = "422027",
	nipple_demon1 = "793636",
	nipple_demon2 = "451d52",
	nipple_nereid1 = "253e3f",
	nipple_nereid2 = "2c4242",
	nipple_nereid3 = "7c3784",
	hair_blond = "b9ad37",
	hair_grey = "84837c",
	hair_orange = "a04f23",
	hair_red = "933030",
	hair_darkred = "541b1b",
	hair_brown = "482d26",
	hair_black = "1d1512",
	hair_green = "4d6534",
	hair_blue = "2c4f5f",
	hair_purple = "3f2c5f",
	hair_pink = "b65dab",
	hair_cyan = "3dafb0",
	dragon_scales1 = "612626", 
	dragon_scales2 = "272222",
	dragon_scales3 = "6f788d",
	demon_wings1 = "50333b",
	demon_wings2 = "494227",
	demon_wings3 = "2b2752",
	nereid_fins1 = "6b9295",
	nereid_fins2 = "746b95",
	nereid_fins3 = "a689a6",

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
	"body_color_lips": "LIPS", "body_color_eyebrows": "HAIR",
	"body_color_ears": "BODY_PARTS", "body_color_tail": "BODY_PARTS",
	"body_color_wings": "BODY_PARTS", "body_color_horns": "BODY_PARTS",
	"body_color_animal": "BODY_PARTS",
}


# The colour a stat value means.  White when the value is unknown or empty, which
# is what the shader reads as "leave the art as the artist drew it".
# Nipples, keyed by the skin they sit on: the code is the same one
# `body_color_skin` carries, so a character's nipples follow their skin without
# a stat of their own.
#
# The shades are the authored ones from `color` above - `nipple_human1` is the
# nipple for skin `human1` - rather than anything worked out here.  They are read
# out of that block once and kept, because a `const` cannot be computed.
const NIPPLES = {}


# Fins: a nereid's tail and ears are one piece of webbing, and the palette names
# it after the skin it belongs to - `nereid_fins2` goes with skin `nereid2`.
# Keyed by the authored name rather than by the skin code, so a fin and a skin
# can never be mistaken for one another.
const FINS = {}


static func fins():
	if FINS.empty():
		for key in color.keys():
			var name = str(key)
			if name.find("_fins") >= 0:
				FINS[name] = Color(str(color[key]))
	return FINS


# The fin that belongs to a skin, or "" where the palette has none: `nereid2`
# answers `nereid_fins2`.
static func fins_code_for_skin(skin_value):
	var name = str(skin_value)
	var cut = name.length()
	while cut > 0 and name[cut - 1] >= "0" and name[cut - 1] <= "9":
		cut -= 1
	if cut == name.length():
		return ""
	var code = name.substr(0, cut) + "_fins" + name.substr(cut)
	return code if fins().has(code) else ""


static func nipples():
	if NIPPLES.empty():
		for key in color.keys():
			var name = str(key)
			if name.begins_with("nipple_"):
				NIPPLES[name.substr(7)] = Color(str(color[key]))
	return NIPPLES


# Which table a doll channel paints from, so the preview can offer the game's own
# colours as swatches instead of a bare colour wheel.  The gear channels are
# deliberately absent: their art is coded by hue and starts from ZONE_DEFAULTS,
# which is a different palette with a different meaning.
const CHANNEL_TABLES = {
	"skin": "SKIN", "race": "SKIN",
	"eyes": "EYES",
	"lips": "LIPS",
	"nipples": "NIPPLES",
	"eyebrows": "HAIR", "hair": "HAIR", "hair_back": "HAIR", "hair_assist": "HAIR",
	"ears": "BODY_PARTS", "tail": "BODY_PARTS", "wings": "BODY_PARTS",
	"horns": "BODY_PARTS", "animal": "BODY_PARTS",
}


# Races whose shades are filed under another name.  Everyone the palette does
# not name gets the human ones.
const RACE_SHADES = {
	"Goblin": "orc",
	"Dragonkin": "human",
	"Halfkin": "human",
	"Beastkin": "human",
}


# The values of a stat that belong to a race.  A skin shade is named after the
# race that wears it - `orc2`, `kobold4`, `demon1` - so the list a character is
# offered comes out of the palette rather than out of a hand-written race entry,
# and adding `demon3` to the table is all it takes for a demon to be offered it.
# A table whose keys are colour families, not races, applies to everyone whole.
# The parts of a covering are painted in the race's own shades where the palette
# has them - a demon's wings are demon-coloured, a kobold's tail kobold-coloured -
# and fall back to the colour families for the races the palette does not name,
# which is where a fairy's wing colours come from.
const COVERING_STATS = ["body_color_wings", "body_color_horns", "body_color_tail",
	"body_color_animal"]


static func values_for_race(statname, race):
	if str(statname) in COVERING_STATS:
		var shades = values_for_race("body_color_skin", race)
		if !shades.empty() and !str(shades[0]).begins_with("human"):
			return shades
	var table = _table(str(FAMILIES.get(str(statname), "")))
	if table.empty():
		return []
	var prefixes = {}
	for key in table.keys():
		var name = str(key)
		var cut = name.length()
		while cut > 0 and name[cut - 1] >= "0" and name[cut - 1] <= "9":
			cut -= 1
		if cut == name.length():
			return table.keys() # families, not races: cyan, brown, dark...
		prefixes[name.substr(0, cut)] = true
	var wanted = ""
	for prefix in prefixes.keys():
		if str(race).to_lower().find(str(prefix)) >= 0:
			wanted = str(prefix)
			break
	if wanted == "":
		for named in RACE_SHADES.keys():
			if str(race).find(named) >= 0:
				wanted = str(RACE_SHADES[named])
				break
	if wanted == "" or !prefixes.has(wanted):
		# a table of colour families rather than of races - hair, eyes, body parts -
		# belongs to everyone whole
		if !prefixes.has("human"):
			return table.keys()
		wanted = "human"
	var result = []
	for key in table.keys():
		if str(key).begins_with(wanted):
			result.append(key)
	return result


# Every value a stat can take, in table order: the list a picker offers and the
# list a character can be rolled from.
static func values_for(statname):
	return _table(str(FAMILIES.get(str(statname), ""))).keys()


# A colour out of the table a channel paints from, rather than out of a stat's
# own family: the nipples are keyed by the skin's code and have no stat.
# The nipples a skin wears.  The table names the shades the palette knows; a
# colour it does not name - one picked off the wheel in the preview, or a race
# nobody has written nipples for - is taken darker and a little deeper, which is
# exactly how the table's own entries were made (saturation x1.5, value x0.8
# reproduces them). Both the game and the preview ask this, so a light skin
# cannot come out with one pair of nipples in the tool and another in play.
static func nipples_of(skin_value):
	if nipples().has(str(skin_value)):
		return nipples()[str(skin_value)]
	return nipples_from_colour(colour_of("body_color_skin", skin_value))


static func nipples_from_colour(skin):
	# an unpainted skin leaves the art alone, and so do its nipples
	if skin.s < 0.02 and skin.v > 0.98:
		return Color(1, 1, 1)
	# a shade taken off the palette is a shade the table names, so a tool holding
	# only the colour still lands on exactly what the game will draw
	for code in SKIN.keys():
		if SKIN[code].is_equal_approx(skin) and nipples().has(code):
			return nipples()[code]
	var deep = Color(skin.r, skin.g, skin.b)
	deep.s = min(deep.s * 1.5, 1.0)
	deep.v = deep.v * 0.8
	return deep


static func channel_colour(channel_id, value):
	var table = _table(str(CHANNEL_TABLES.get(str(channel_id), "")))
	if table.has(str(value)):
		return table[str(value)]
	return borrowed(value)


# What a channel can be painted, as [[name, colour], ...] in table order.  Empty
# for a channel this palette says nothing about.
static func swatches(channel_id):
	var table = _table(str(CHANNEL_TABLES.get(str(channel_id), "")))
	var result = []
	for key in table.keys():
		result.append([key, table[key]])
	return result


static func colour_of(statname, value):
	# A colour picked freely rather than off the palette is kept in the stat as its
	# own hex: the stats are strings, so a `#a24b7c` survives a save and comes back
	# without a table entry to hold it.
	if str(value).begins_with("#"):
		return Color(str(value))
	var table = _table(str(FAMILIES.get(statname, "")))
	if table.has(str(value)):
		return table[str(value)]
	return borrowed(value)


# The colour a value means in whichever table owns it.  A stat can carry a colour
# borrowed from another part - lips take the skin's, a beastkin's ears take the
# hair's, a dragon's horns take the hide's - and the key spaces say which table a
# value came from: skin shades are named after the race that wears them, hair
# carries an underscore, body parts do not.  `EYES` and `LIPS` share their names
# and so are read last, and in that order only for a value nobody else claims.
# Whether any table has this value at all - the check a list of allowed colours
# is filtered through, since a covering may be named after a race and a wing
# after a colour family.
static func knows(value):
	if str(value).begins_with("#"):
		return true
	for name in ["SKIN", "HAIR", "BODY_PARTS", "LIPS", "EYES", "NIPPLES", "FINS"]:
		if _table(name).has(str(value)):
			return true
	return false


static func borrowed(value):
	if str(value).begins_with("#"):
		return Color(str(value))
	for name in ["SKIN", "HAIR", "BODY_PARTS", "LIPS", "EYES", "FINS"]:
		var table = _table(name)
		if table.has(str(value)):
			return table[str(value)]
	return Color(1, 1, 1)


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
		"NIPPLES":
			return nipples()
		"FINS":
			return fins()
	return {}
