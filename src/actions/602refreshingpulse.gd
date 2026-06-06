extends Reference

const category = 'tools'
const code = 'refreshing_pulse'
const order = 82
const trait = 'refreshing_pulse'
const mana_cost = 8
const max_uses = 1
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
	return tr("SEXACTION_REFRESHING_PULSE")

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	return givers.size() == 1 && takers.size() == 0 && _can_cast(givers[0])

func _can_cast(member):
	return member.person.check_trait(trait) && member.person.mp >= mana_cost && member.sex_spell_uses.get(code, 0) < max_uses

func givereffect(member):
	return {lust = 0}

func initiate():
	return tr("SEXACTION_REFRESHING_PULSE_INITIATE")

func apply_action(sceneref, action_ids):
	var caster = givers[0]
	caster.person.mp -= mana_cost
	caster.sex_spell_uses[code] = caster.sex_spell_uses.get(code, 0) + 1
	for member in sceneref.participants:
		member.actions_remaining += 2
	return tr("SEXACTION_REFRESHING_PULSE_RESULT")
