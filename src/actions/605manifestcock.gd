extends Reference

#Genitalia Manipulation in the encounter: the caster grows an average cock on the spot, which opens the
#penis actions and makes a woman a futa. It lasts until the encounter ends (interaction_member.dismiss_cock).
const category = 'tools'
const code = 'manifest_cock'
const order = 85
const skill = 'genitalia_manipulation'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['magic', 'noorgasm']
const takertags = []
const giver_skill = []
const taker_skill = []
const consent_level = 0
const consent_giver = 0
const consent_taker = 0

func getname(state = null):
	return tr("SEXACTION_MANIFEST_COCK")

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	return givers.size() == 1 && takers.size() == 0 && _can_cast(givers[0])

func _can_cast(member):
	return member.person.get_social_skills().has(skill) && member.person.get_stat('penis_size') == ''

func givereffect(member):
	return {lust = 0}

func initiate():
	return tr("SEXACTION_MANIFEST_COCK_INITIATE")

func apply_action(sceneref, action_ids):
	givers[0].manifest_cock()
	return tr("SEXACTION_MANIFEST_COCK_RESULT")
