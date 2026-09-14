extends Reference

# Faces the doll pulls at what happens to the character: an item put on, and a
# click on the chest.  What happened picks the reaction, and a character reacts
# at most once every COOLDOWN seconds, however many dolls show them.
#
# A reaction is a list of steps, [emotion, seconds], played one after another;
# the face goes back to the character's ordinary one after the last.  An emotion
# is named the way the rig names it, without its `emote_` prefix.  The female
# export carries `surprise`, `joy`, `shy` and `embarrassment` - there is no shock
# of its own, so surprise stands for it - and the male export carries none, so a
# man simply does not react.

const COOLDOWN = 8.0
# how long the shock is held before the reaction it leads into
const SHOCK_SECONDS = 1.0
const SHOCK = "surprise"
# how often a click on the chest is noticed at all
const POKE_CHANCE = 0.15

# Pieces a character puts on with some bashfulness.  Every collar counts as well,
# found by its code rather than listed.
const PERSONAL_ITEMS = ["animal_ears", "animal_gloves", "maid_dress", "maid_headband", "lacy_underwear"]
# ... and the ones put on for sex.  `service_suit` is the bunny costume.
const SEX_ITEMS = ["seethrough_underwear", "anal_plug", "tail_plug", "chastity_belt", "latex_suit",
	"service_suit", "stimulative_underwear"]

# character id -> OS.get_ticks_msec() when their last reaction started
const LAST_REACTION = {}


# What a character's face does as `item` goes on, or [] for nothing.  A piece
# with a meaning of its own answers before its quality does.
static func equip_reaction(character, item):
	var base = str(item.itembase)
	# the master answers to no one's affection or consent, so only an item's quality
	# moves their face
	var for_master = character.has_method("is_master") and character.is_master()
	if base in SEX_ITEMS and !for_master:
		var after = "embarrassment" if int(character.get_stat("consent")) <= 3 else "shy"
		return [[SHOCK, SHOCK_SECONDS], [after, 2.0]]
	if (base in PERSONAL_ITEMS or base.find("collar") >= 0) and !for_master:
		var feeling = "embarrassment" if int(character.get_stat("affection")) <= 20 else "shy"
		return [[feeling, 2.0]]
	match str(item.quality):
		"legendary":
			return [[SHOCK, SHOCK_SECONDS], ["joy", 3.0]]
		"epic":
			if randf() < 0.5:
				return [[SHOCK if randf() < 0.5 else "joy", 2.0]]
		"good":
			if randf() < 0.3:
				return [["joy", 2.0]]
	return []


# What a character's face does when the player clicks their chest, or [] for
# nothing - most clicks go unremarked.
static func poke_reaction(_character):
	if randf() >= POKE_CHANCE:
		return []
	return [[SHOCK, SHOCK_SECONDS], ["embarrassment", 2.0]]


# Whether the character may react right now; when they may, the cooldown starts.
static func take_turn(character):
	var id = str(character.id)
	var now = OS.get_ticks_msec()
	if LAST_REACTION.has(id) and now - int(LAST_REACTION[id]) < int(COOLDOWN * 1000.0):
		return false
	LAST_REACTION[id] = now
	return true
