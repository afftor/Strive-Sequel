extends Reference

const category = 'fucking'
const code = 'tribadism'
const order = 9
var givers
var takers
const canlast = true
const giverpart = 'vagina'
const takerpart = 'vagina'
const virginloss = false
const givertags = ['vagina', 'pet']
const takertags = ['vagina', 'pet']
const giver_skill = ['pussy']
const taker_skill = ['pussy']
const consent_level = 25
const consent_giver = 3
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_TRIBADISM")

func getongoingname(givers, takers):
	return tr("SEXACTION_TRIBADISM_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_TRIBADISM_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
		for i in takers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 160, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 160, horny = 10}
	return effects

func initiate():
	return tr("SEXACTION_TRIBADISM_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_TRIBADISM_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_TRIBADISM_REACTION_1")
	elif member.sens < 300:
		text = tr("SEXACTION_TRIBADISM_REACTION_2")
	elif member.sens < 600:
		text = tr("SEXACTION_TRIBADISM_REACTION_3")
	else:
		text = tr("SEXACTION_TRIBADISM_REACTION_4")
	return text
