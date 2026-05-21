extends Reference

const category = 'SM'
const code = 'nippleclamp'
const order = 4
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'acc5'#nipple extra
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['punish','pain', 'tits']
const giver_skill = []
const taker_skill = []
const consent_level = 30
const consent_giver = 0
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_NIPPLE_CLAMP")

func getongoingname(givers, takers):
	return tr("SEXACTION_NIPPLECLAMP_ONGOING_1")

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.acc5 != null:
#			valid = false
	if takers.size() < 1 || givers.size() != 1:
		valid = false
	return valid

func givereffect(member):
	var effects = {lust = 25}
	return effects

func takereffect(member):
	var effects = {sens = 75, horny = 5}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.3
	return effects

func initiate():
	return tr("SEXACTION_NIPPLECLAMP_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_NIPPLECLAMP_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_NIPPLECLAMP_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_NIPPLECLAMP_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_NIPPLECLAMP_REACTION_3")
	else:
		text = tr("SEXACTION_NIPPLECLAMP_REACTION_4")
	return text
