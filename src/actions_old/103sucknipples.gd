extends Reference

const category = 'caress'
const code = 'sucknipples'
const order = 4
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = ''
const virginloss = false
const givertags = ['oral','noorgasm']
const takertags = ['tits']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 20


const consent_giver = 0
const consent_taker = 2

func getname(state = null):
	return tr("SEXACTION_NIPPLE_SUCKING")

func getongoingname(givers, takers):
	return tr("SEXACTION_SUCKNIPPLES_ONGOING_1")

func getongoingdescription(givers, takers):
	var text = ''
	var temparray = []
	temparray += ["SEXACTION_SUCKNIPPLES_ONGOING_DESC_1"]
	text += tr(temparray[randi()%temparray.size()])
	temparray.clear()
	temparray += ["SEXACTION_SUCKNIPPLES_ONGOING_DESC_2"]
	temparray += ["SEXACTION_SUCKNIPPLES_ONGOING_DESC_3"]
	temparray += ["SEXACTION_SUCKNIPPLES_ONGOING_DESC_4"]
	temparray += ["."]
	text += tr(temparray[randi()%temparray.size()])
	return text
	
func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
#	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 80, horny = 15}

	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.3
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["SEXACTION_SUCKNIPPLES_INITIATE_1"]
	temparray += ["SEXACTION_SUCKNIPPLES_INITIATE_2"]
	text += tr(temparray[randi()%temparray.size()])
	temparray.clear()
	temparray += ["SEXACTION_SUCKNIPPLES_INITIATE_SUFFIX_1"]
	temparray += ["SEXACTION_SUCKNIPPLES_INITIATE_SUFFIX_2"]
	temparray += ["SEXACTION_SUCKNIPPLES_INITIATE_SUFFIX_3"]
	text += tr(temparray[randi()%temparray.size()])
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_SUCKNIPPLES_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_SUCKNIPPLES_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_SUCKNIPPLES_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_SUCKNIPPLES_REACTION_3")
	else:
		text = tr("SEXACTION_SUCKNIPPLES_REACTION_4")
	return text
