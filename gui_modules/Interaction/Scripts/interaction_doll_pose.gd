extends Reference

# Which of the doll's authored sex takes match what one sex-scene member is doing,
# for Doll2View.set_sex_pose.  Only the obvious matches are mapped; a member doing
# nothing listed here keeps the idle.  Every partner whose penis is in the pose is
# passed along, so the doll draws it as theirs.

const VAGINAL = {
	"missionary": "sex_standing",
	"lotus": "sex_missionary", "revlotus": "sex_missionary", "ontop": "sex_missionary",
	"doggy": "sex_missionary", "insertinturns": "sex_missionary",
}
const ANAL = {
	"missionaryanal": "sex_standing",
	"lotusanal": "anal_missionary", "revlotusanal": "anal_missionary", "ontopanal": "anal_missionary",
	"doggyanal": "anal_missionary", "insertinturnsass": "anal_missionary",
}
const ARMS_UP_ACTIONS = ["missionary", "missionaryanal", "doggy", "doggyanal", "lotus", "lotusanal"]
const DILDO_ROLES = {"doubledildo": "vaginal", "doubledildoass": "anal"}
const GRINDING_ACTIONS = ["tribadism", "frottage"]
const FINGERING = {"fingering": "sex_fingers", "assfingering": "sex_fingers_anal"}


# `last_action`, the newest action applied in the scene, is shown over the ongoing
# ones even when it does not last: it is read first, so it wins a part they share.
static func pose_for(member, ongoingactions, last_action = null):
	var roles = {}
	var dildo_roles = []
	var hands = []
	var vaginal_take = "sex_missionary"
	var anal_take = "anal_missionary"
	var raise_arms = false
	var grinding = false
	var fingers_take = ""
	var chest_touch = false
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
		var is_giver = member in givers
		var is_taker = member in takers
		if !is_giver and !is_taker:
			continue
		# Both participants share the motion in these actions.
		if DILDO_ROLES.has(code):
			var role = DILDO_ROLES[code]
			if _claim(roles, role, givers if is_taker else takers, 0):
				dildo_roles.append(role)
				raise_arms = true
		elif code in GRINDING_ACTIONS:
			grinding = true
		elif is_taker:
			if VAGINAL.has(code):
				if _claim(roles, "vaginal", givers, 0):
					vaginal_take = VAGINAL[code]
					raise_arms = raise_arms or code in ARMS_UP_ACTIONS
			elif ANAL.has(code):
				if _claim(roles, "anal", givers, 0):
					anal_take = ANAL[code]
					raise_arms = raise_arms or code in ARMS_UP_ACTIONS
			elif FINGERING.has(code) and fingers_take == "" and !givers.empty():
				fingers_take = FINGERING[code]
			elif code == "fondletits" and !givers.empty():
				chest_touch = true
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
		if is_giver:
			if code == "blowjob":
				_claim(roles, "mouth", takers, 0)
			elif code == "titjob":
				_claim(roles, "tits", takers, 0)
			elif code == "handjob":
				for partner in takers:
					if !(partner in hands):
						hands.append(partner)

	# The fingering takes also animate the lower body, so use them when a
	# penetration take does not already supply that region.
	var lower = "sex_missionary" if grinding else fingers_take
	if roles.has("vaginal") and roles.has("anal"):
		lower = "double_pen"
	elif roles.has("vaginal"):
		lower = vaginal_take
	elif roles.has("anal"):
		lower = anal_take
	# Standing and titjob both need the same slot for their mesh deform.
	if lower == "sex_standing" and roles.has("tits"):
		lower = "anal_missionary" if roles.has("anal") else "sex_missionary"
	# Two hands each on a partner at the sides; one hand on the side when the front
	# of the body is busy, both hands in front when it is all she is doing.
	var arms = "arms_up" if raise_arms or grinding else ""
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
	chest_touch = chest_touch and !roles.has("tits")
	if base == "" and !chest_touch:
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
		partners[role] = _partner(roles[role], role in dildo_roles)
	return {"base": base, "parts": parts, "partners": partners, "chest_touch": chest_touch}


static func _claim(roles, role, members, index):
	if !roles.has(role) and members.size() > index:
		roles[role] = members[index]
		return true
	return false


# What the doll needs to draw a partner's penis as theirs.
static func _partner(partner, dildo):
	var person = partner.person
	var size = "" if dildo else str(person.get_stat('penis_size'))
	return {
		"id": person.id,
		"penis_type": str(person.get_stat('penis_type')),
		"penis_size": size,
		"skin": str(person.get_stat('body_color_skin')),
		"strapon": dildo or (bool(partner.strapon) and size in ['', 'none']),
	}
