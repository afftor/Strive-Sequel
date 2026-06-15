extends Reference

const category = 'tools'
const code = 'calming_touch'
const order = 80
const trait = 'calming_touch'
const mana_cost = 3
const max_uses = 1
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
	return tr("SEXACTION_CALMING_TOUCH")

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	return givers.size() == 1 && takers.size() == 1 && _can_cast(givers[0])

func _can_cast(member):
	return member.person.check_trait(trait) && member.person.mp >= mana_cost && member.sex_spell_uses.get(code, 0) < max_uses

func givereffect(member):
	return {lust = 0}

func takereffect(member):
	return {lust = 0}

func initiate():
	return tr("SEXACTION_CALMING_TOUCH_INITIATE")

func apply_action(sceneref, action_ids):
	var caster = givers[0]
	var target = takers[0]
	caster.person.mp -= mana_cost
	caster.sex_spell_uses[code] = caster.sex_spell_uses.get(code, 0) + 1
	target.lack_consent = max(0, target.lack_consent - 5)
	return tr("SEXACTION_CALMING_TOUCH_RESULT")
