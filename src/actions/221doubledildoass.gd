extends Reference

const category = 'fucking'
const code = 'doubledildoass'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'anus'
const takerpart = 'anus'
const virginloss = true
const givertags = ['anal', 'penetration']
const takertags = ['anal', 'penetration']
const giver_skill = ['penetration','anal']
const taker_skill = ['penetration','anal']
const consent_level = 35
const consent_giver = 5
const consent_taker = 5

func getname(state = null):
	return tr("SEXACTION_DOUBLE_ANAL_DILDO")

func getongoingname(givers, takers):
	return tr("SEXACTION_DOUBLEDILDOASS_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_DOUBLEDILDOASS_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 190, horny = 5}
	return effects

func takereffect(member):
	var effects = {sens = 190, horny = 5}
	return effects

func initiate():
	return tr("SEXACTION_DOUBLEDILDOASS_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_DOUBLEDILDOASS_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_DOUBLEDILDOASS_REACTION_1")
	elif member.sens < 300:
		text = tr("SEXACTION_DOUBLEDILDOASS_REACTION_2")
	elif member.sens < 600:
		text = tr("SEXACTION_DOUBLEDILDOASS_REACTION_3")
	else:
		text = tr("SEXACTION_DOUBLEDILDOASS_REACTION_4")
	return text
