extends Reference

# Which of the doll's authored sex takes match what one sex-scene member is doing,
# for Doll2View.set_sex_pose.  Only the obvious matches are mapped; a member doing
# nothing listed here keeps the idle.  Every partner whose penis is in the pose is
# passed along, so the doll draws it as theirs.

# Taking a penis in the vagina or the anus, and the take each one plays.  Missionary
# itself stands; lotus and on-top read as the legs-up missionary take from the front.
const VAGINAL = {"missionary": "sex_standing", "lotus": "sex_missionary",
	"revlotus": "sex_missionary", "ontop": "sex_missionary"}
const ANAL = ["missionaryanal", "lotusanal", "revlotusanal", "ontopanal"]


# `last_action`, the newest action applied in the scene, is shown over the ongoing
# ones even when it does not last: it is read first, so it wins a part they share.
static func pose_for(member, ongoingactions, last_action = null):
	var roles = {}
	var hands = []
	var vaginal_take = "sex_missionary"
	var actions = [] + ongoingactions
	if last_action != null:
		for action in ongoingactions:
			if action.id == last_action.id:
				actions.erase(action)
		actions.push_front(last_action)
	for action in actions:
		var code = str(action.scene.code)
		var givers = action.givers
		var takers = action.takers
		if member in takers:
			if VAGINAL.has(code):
				if _claim(roles, "vaginal", givers, 0):
					vaginal_take = VAGINAL[code]
			elif code in ANAL:
				_claim(roles, "anal", givers, 0)
			# two givers: the first takes the action's first part, the second its
			# `takerpart2` (startscene sets them up that way)
			elif code == "doublepen":
				_claim(roles, "vaginal", givers, 0)
				_claim(roles, "anal", givers, 1)
			elif code == "spitroast":
				_claim(roles, "vaginal", givers, 0)
				_claim(roles, "mouth", givers, 1)
			elif code == "spitroastass":
				_claim(roles, "anal", givers, 0)
				_claim(roles, "mouth", givers, 1)
		if member in givers:
			if code == "blowjob":
				_claim(roles, "mouth", takers, 0)
			elif code == "titjob":
				_claim(roles, "tits", takers, 0)
			elif code == "handjob":
				for partner in takers:
					if !(partner in hands):
						hands.append(partner)

	var lower = ""
	if roles.has("vaginal") and roles.has("anal"):
		lower = "double_pen"
	elif roles.has("vaginal"):
		lower = vaginal_take
		# the standing take's penis carries a deform, and so does titjob's, on the
		# one slot both need - the legs-up take's moves aside
		if lower == "sex_standing" and roles.has("tits"):
			lower = "sex_missionary"
	elif roles.has("anal"):
		lower = "anal_missionary"
	# Two hands each on a partner at the sides; one hand on the side when the front
	# of the body is busy, both hands in front when it is all she is doing.
	var arms = ""
	if hands.size() >= 2:
		arms = "simult_handjob"
		roles["hand_left"] = hands[0]
		roles["hand_right"] = hands[1]
	elif hands.size() == 1:
		if lower == "" and !roles.has("mouth") and !roles.has("tits"):
			arms = "handjob2"
			roles["hand"] = hands[0]
		else:
			arms = "handjobside1"
			roles["hand_left"] = hands[0]
	var base = lower
	if base == "":
		if roles.has("tits"):
			base = "titjob"
		elif roles.has("mouth"):
			base = "blowjob"
		else:
			base = arms
	if base == "":
		return null
	var parts = {}
	if roles.has("tits") and base != "titjob":
		parts["chest"] = "titjob"
	if roles.has("mouth") and base != "blowjob":
		parts["head"] = "blowjob"
	if arms != "" and base != arms:
		parts["arms"] = arms
	var partners = {}
	for role in roles.keys():
		partners[role] = _partner(roles[role])
	return {"base": base, "parts": parts, "partners": partners}


static func _claim(roles, role, members, index):
	if !roles.has(role) and members.size() > index:
		roles[role] = members[index]
		return true
	return false


# What the doll needs to draw a partner's penis as theirs.
static func _partner(partner):
	var person = partner.person
	var size = str(person.get_stat('penis_size'))
	return {
		"penis_type": str(person.get_stat('penis_type')),
		"penis_size": size,
		"skin": str(person.get_stat('body_color_skin')),
		"strapon": bool(partner.strapon) and size in ['', 'none'],
	}
