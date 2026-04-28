extends Reference

const category = 'fucking'
const code = 'frottage'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'penis'
const virginloss = false
const givertags = ['penis', 'pet']
const takertags = ['penis', 'pet']
const giver_skill = ['petting']
const taker_skill = ['petting']
const consent_level = 20
const consent_giver = 3
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_FROTTAGE")

func getongoingname(givers, takers):
	return tr("SEXACTION_FROTTAGE_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_FROTTAGE_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('penis_size') == '':
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 175, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 175, horny = 15}
	return effects

func initiate():
	return tr("SEXACTION_FROTTAGE_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_FROTTAGE_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_FROTTAGE_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_FROTTAGE_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_FROTTAGE_REACTION_3")
	else:
		text = tr("SEXACTION_FROTTAGE_REACTION_4")
	return text
