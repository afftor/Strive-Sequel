extends Reference

const category = 'tools'
const code = 'analvibrator'
const order = 10
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'anus'
const virginloss = true
const givertags = ['pet','noorgasm', 'toys']
const takertags = ['pet','anal','toys']
const giver_skill = []
const taker_skill = ['anal']
const consent_level = 25
const consent_giver = 0
const consent_taker = 5

func getname(state = null):
	return tr("SEXACTION_ANAL_VIBRATOR")

func getongoingname(givers, takers):
	return tr("SEXACTION_ANALVIBRATO_ONGOING_1")

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.anus != null:
#			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 50, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 130, horny = 25}
	return effects

func initiate():
	return tr("SEXACTION_ANALVIBRATOR_INITIATE_1") + tr("SEXACTION_ANALVIBRATOR_INITIATE_SUFFIX")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_ANALVIBRATOR_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_ANALVIBRATOR_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_ANALVIBRATOR_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_ANALVIBRATOR_REACTION_3")
	else:
		text = tr("SEXACTION_ANALVIBRATOR_REACTION_4")
	return text
