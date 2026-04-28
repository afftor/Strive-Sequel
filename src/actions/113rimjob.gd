extends Reference

const category = 'caress'
const code = 'rimjob'
const order = 8
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'anus'
const virginloss = false
const givertags = ['oral','noorgasm','sub']
const takertags = ['anal','dom']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 25


const consent_giver = 3
const consent_taker = 4

func getname(state = null):
	return tr("SEXACTION_RIMJOB")

func getongoingname(givers, takers):
	return tr("SEXACTION_RIMJOB_ONGOING_1")

func getongoingdescription(givers, takers):
	return tr("SEXACTION_RIMJOB_ONGOING_DESC_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
#	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
#		for i in takers:
#			if i.anus != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 80, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 20}
	return effects

func initiate():
	return tr("SEXACTION_RIMJOB_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_RIMJOB_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_RIMJOB_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_RIMJOB_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_RIMJOB_REACTION_3")
	else:
		text = tr("SEXACTION_RIMJOB_REACTION_4")
	return text
