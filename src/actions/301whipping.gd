extends Reference

const category = 'SM'
const code = 'whipping'
const order = 2
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['noorgasm','dom']
const takertags = ['punish','pain','sub']
const giver_skill = []
const taker_skill = []
const consent_level = 30
const consent_giver = 0
const consent_taker = 2

func getname(state = null):
	return tr("SEXACTION_WHIPPING")

#func getongoingname(givers, takers):
#	return "[name1] whip[s/1] [name2]."

#func getongoingdescription(givers, takers):
#	var temparray = []
#	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 20, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 15}
	return effects

func initiate():
	return tr("SEXACTION_WHIPPING_INITIATE_1")

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = tr("SEXACTION_WHIPPING_REACTION_1")
	elif member.sens < 600:
		text = tr("SEXACTION_WHIPPING_REACTION_2")
	elif member.sens < 950:
		text = tr("SEXACTION_WHIPPING_REACTION_3")
	else:
		text = tr("SEXACTION_WHIPPING_REACTION_4")

	return text
