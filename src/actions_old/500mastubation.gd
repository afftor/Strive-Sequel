extends Reference

const category = 'humiliation'
const code = 'mastshow'
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'vagina'
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['vagina','shame']
const giver_skill = []
const taker_skill = ['petting']
const consent_level = 10
const consent_giver = 0
const consent_taker = 2

func getname(state = null):
	return tr("SEXACTION_ORDER_MASTURBATION")

func getongoingname(givers, takers):
	return tr("SEXACTION_MASTUBATION_ONGOING_1")

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
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

#Disabling until something is decided about tools
func givereffect(member):
	var effects = {sens = 50, horny = 20}
	return effects

#Disabling until something is decided about tools
func takereffect(member):
	var effects = {sens = 110, horny = 25}
	return effects

func initiate():
	return tr("SEXACTION_MASTURBATION_INITIATE_1")

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = tr("SEXACTION_MASTURBATION_REACTION_UNCONSCIOUS")
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = tr("SEXACTION_MASTURBATION_REACTION_1")
	elif member.sens < 400:
		text = tr("SEXACTION_MASTURBATION_REACTION_2")
	elif member.sens < 800:
		text = tr("SEXACTION_MASTURBATION_REACTION_3")
	else:
		text = tr("SEXACTION_MASTURBATION_REACTION_4")
	return text
