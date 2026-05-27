extends Reference

const category = 'tools'
const code = 'vibrator'
const order = 9
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'vagina'
const virginloss = true
const givertags = ['pet', 'noorgasm', 'toys']
const takertags = ['pet', 'vagina', 'toys']
const giver_skill = []
const taker_skill = ['pussy']
const consent_level = 15
const consent_giver = 0
const consent_taker = 4

func getname(state = null):
	return tr("SEXACTION_VIBRATOR")

func getongoingname(givers, takers):
	return tr("SEXACTION_VIBRATOR_ONGOING_1")

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.vagina != null:
#			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	for i in takers:
		if i.person.get_stat('has_pussy') == false:
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 50, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects

func initiate():
	return tr("SEXACTION_VIBRATOR_INITIATE_1") + tr("SEXACTION_VIBRATOR_INITIATE_SUFFIX")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_VIBRATOR_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_VIBRATOR_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_VIBRATOR_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_VIBRATOR_REACTION_3")
	else:
		text = tr("SEXACTION_VIBRATOR_REACTION_4")
	return text
