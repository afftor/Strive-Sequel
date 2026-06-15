extends Reference

const category = 'tools'
const code = 'dark_rapture'
const order = 84
const trait = 'dark_rapture'
const mana_cost = 7
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['magic']
const takertags = ['magic']
const giver_skill = []
const taker_skill = []
const consent_level = 0
const consent_giver = 0
const consent_taker = 0

func getname(state = null):
	return tr("SEXACTION_DARK_RAPTURE")

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	return givers.size() == 1 && takers.size() == 1 && _can_cast(givers[0])

func _can_cast(member):
	return member.person.check_trait(trait) && member.person.mp >= mana_cost

func givereffect(member):
	return {lust = 0}

func takereffect(member):
	return {lust = 0}

func initiate():
	var variants = ["SEXACTION_DARK_RAPTURE_INITIATE_1", "SEXACTION_DARK_RAPTURE_INITIATE_2"]
	return tr(variants[randi() % variants.size()])

func apply_action(sceneref, action_ids):
	var caster = givers[0]
	var target = takers[0]
	caster.person.mp -= mana_cost
	target.lack_consent += 7
	target.set_lastaction(action_ids)
	target.orgasm()
	return tr("SEXACTION_DARK_RAPTURE_RESULT")
