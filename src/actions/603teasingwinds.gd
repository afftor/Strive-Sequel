extends Reference

const category = 'tools'
const code = 'teasing_winds'
const order = 83
const trait = 'teasing_winds'
const mana_cost = 5
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['magic', 'noorgasm']
const takertags = ['magic', 'noorgasm']
const giver_skill = []
const taker_skill = []
const consent_level = 0
const consent_giver = 0
const consent_taker = 0

func getname(state = null):
	return tr("SEXACTION_TEASING_WINDS")

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
	return tr("SEXACTION_TEASING_WINDS_INITIATE")

func apply_action(sceneref, action_ids):
	var caster = givers[0]
	var target = takers[0]
	caster.person.mp -= mana_cost
	target.horny += 50
	target.add_sens_no_orgasm(400)
	return tr("SEXACTION_TEASING_WINDS_RESULT")
