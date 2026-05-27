extends Reference

const category = 'SM'
const code = 'spanking'
const order = 1
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['pet','noorgasm','dom']
const takertags = ['pet', 'punish', 'pain','sub']
const giver_skill = []
const taker_skill = []
const consent_level = 25
const consent_giver = 0
const consent_taker = 2

func getname(state = null):
	return tr("SEXACTION_SPANKING")

#func getongoingname(givers, takers):
#	return "[name1] spank[s/1] [names2] ass."

#func getongoingdescription(givers, takers):
#	var temparray = []
#	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 10, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 90, horny = 20}
	return effects

func initiate():
	var temparray = []
	temparray += ["SEXACTION_SPANKING_INITIATE_1"]
	temparray += ["SEXACTION_SPANKING_INITIATE_2"]
	return tr(temparray[randi()%temparray.size()])

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = tr("SEXACTION_SPANKING_REACTION_1")
	elif member.sens < 600:
		text = tr("SEXACTION_SPANKING_REACTION_2")
	elif member.sens < 950:
		text = tr("SEXACTION_SPANKING_REACTION_3")
	else:
		text = tr("SEXACTION_SPANKING_REACTION_4")

	return text
