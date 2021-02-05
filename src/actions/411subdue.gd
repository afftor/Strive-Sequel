extends Reference

const category = 'SM'
const code = 'subdue'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = []
const takertags = ['punish']
const giver_skill = []
const taker_skill = []
const consent_level = 25

func getname(state = null):
	return "Subdue"

func getongoingname(givers, takers):
	return "[name1] [is1] holding down [name2]."

func getongoingdescription(givers, takers):
	return ""

func requirements():
	var valid = true
	if givers.size() < 1 || takers.size() != 1:
		valid = false
	for i in givers:
		if i.subduing != null:
			valid = false
	return valid

func givereffect(member):
	var effects = {lust = 0}
	return effects

func takereffect(member):
	var effects = {lust = 0}
	return effects
	

func initiate():
	for i in takers:
		for k in givers:
			i.subduedby.append(k)
			k.subduing = i
	
	if givers.size() < 2:
		return "[name1] tries to hold down [name2] with all [his1] might."
	else:
		return "[name1] try to hold down [name2] with all [his1] might."
