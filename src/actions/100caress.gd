extends Reference

const category = 'caress'
const code = 'caress'
const order = 1
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet','noorgasm']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 10

const consent_giver = 0
const consent_taker = 1

func getname(state = null):
	return tr("SEXACTION_CARESS")

func getongoingname(givers, takers):
	return tr("SEXACTION_CARESS_ONGOING_1")

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 75, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 110, horny = 25}
	return effects

func initiate():
	var text = ''
	var kissable = true
	var temparray = []
	for i in givers:
		if i.mouth != null:
			kissable = false
	temparray += ["SEXACTION_CARESS_INITIATE_1"]
	temparray += ["SEXACTION_CARESS_INITIATE_2"]
	text += tr(temparray[randi()%temparray.size()])
	temparray.clear()
	if kissable:
		temparray += ["SEXACTION_CARESS_INITIATE_KISSABLE_1"]
		temparray += ["SEXACTION_CARESS_INITIATE_KISSABLE_2"]
		temparray += ["SEXACTION_CARESS_INITIATE_KISSABLE_3"]
		text += tr(temparray[randi()%temparray.size()])
		temparray.clear()
	else:
		temparray += ["SEXACTION_CARESS_INITIATE_NOKISS_1"]
		temparray += ["SEXACTION_CARESS_INITIATE_NOKISS_2"]
		text += tr(temparray[randi()%temparray.size()])
		temparray.clear()
	return text + '.'

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_CARESS_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_CARESS_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_CARESS_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_CARESS_REACTION_3")
	else:
		text = tr("SEXACTION_CARESS_REACTION_4")
	return text
