extends Reference

const category = 'SM'
const code = 'fisting'
const order = 5
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'vagina'
const virginloss = true
const givertags = ['pet','noorgasm']
const takertags = ['pet', 'vagina']
const giver_skill = ['petting']
const taker_skill = ['pussy']
const consent_level = 10
const consent_giver = 2
const consent_taker = 5

func getname(state = null):
	return tr("SEXACTION_FISTING")

func getongoingname(givers, takers):
	return tr("SEXACTION_FISTING_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_FISTING_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	for i in givers:
		if i.limbs == false:
			valid = false
	for i in takers:
#		if i.vagina != null || i.person.has_pussy == false:
#			valid = false
		if i.person.get_stat('sex') == 'male':
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 50, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 25}
	return effects

func initiate():
	var text = ''
	if takers[0].person.get_stat('lust') > 30:
		text += tr("SEXACTION_FISTING_INITIATE_1")
	else:
		text += tr("SEXACTION_FISTING_INITIATE_2")
	if takers[0].person.get_stat('vaginal_virgin'):
		text += tr("SEXACTION_FISTING_INITIATE_VIRGIN")
	else:
		text += tr("SEXACTION_FISTING_INITIATE_SUFFIX")
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_FISTING_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_FISTING_REACTION_1")
	elif member.sens < 300:
		text = tr("SEXACTION_FISTING_REACTION_2")
	elif member.sens < 600:
		text = tr("SEXACTION_FISTING_REACTION_3")
	else:
		text = tr("SEXACTION_FISTING_REACTION_4")
	return text
