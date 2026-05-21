extends Reference

const category = 'SM'
const code = 'analfisting'
const order = 6
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'anus'
const virginloss = false
const givertags = ['pet', 'noorgasm']
const takertags = ['pet', 'anal']
const giver_skill = ['petting']
const taker_skill = ['anal']
const consent_level = 45
const consent_giver = 3
const consent_taker = 5

func getname(state = null):
	return tr("SEXACTION_ANAL_FISTING")

func getongoingname(givers, takers):
	return tr("SEXACTION_ANALFISTING_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_ANALFISTING_ONGOING_DESC_1")

func requirements():
	var valid = true
	for i in givers:
		if i.limbs == false:
			valid = false
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
#	for i in takers:
#		if i.anus != null:
#			valid = false
	return valid

func givereffect(member):
	var effects = {lust = 50, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 20}
	return effects

func initiate():
	var text = ''
	if takers[0].person.get_stat('lust') > 30:
		text += tr("SEXACTION_ANALFISTING_INITIATE_1")
	else:
		text += tr("SEXACTION_ANALFISTING_INITIATE_2")
	text += tr("SEXACTION_ANALFISTING_INITIATE_SUFFIX")
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_ANALFISTING_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_ANALFISTING_REACTION_1")
	elif member.sens < 300:
		text = tr("SEXACTION_ANALFISTING_REACTION_2")
	elif member.sens < 600:
		text = tr("SEXACTION_ANALFISTING_REACTION_3")
	else:
		text = tr("SEXACTION_ANALFISTING_REACTION_4")
	return text
