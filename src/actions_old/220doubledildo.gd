extends Reference

const category = 'fucking'
const code = 'doubledildo'
const order = 9
var givers
var takers
const canlast = true
const giverpart = 'vagina'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['vagina', 'penetration']
const takertags = ['vagina', 'penetration']
const giver_skill = ['penetration','pussy']
const taker_skill = ['penetration','pussy']
const consent_level = 30
const consent_giver = 4
const consent_taker = 4

func getname(state = null):
	return tr("SEXACTION_DOUBLE_DILDO")

func getongoingname(givers, takers):
	return tr("SEXACTION_DOUBLEDILDO_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_DOUBLEDILDO_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('has_pussy') == false :
				valid = false
		for i in takers:
			if i.person.get_stat('has_pussy') == false :
				valid = false
#			elif i.vagina != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 200, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 200, horny = 10}
	return effects

func initiate():
	return tr("SEXACTION_DOUBLEDILDO_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_DOUBLEDILDO_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_DOUBLEDILDO_REACTION_1")
	elif member.sens < 300:
		text = tr("SEXACTION_DOUBLEDILDO_REACTION_2")
	elif member.sens < 600:
		text = tr("SEXACTION_DOUBLEDILDO_REACTION_3")
	else:
		text = tr("SEXACTION_DOUBLEDILDO_REACTION_4")
	return text
