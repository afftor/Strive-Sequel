extends Reference

const category = 'caress'
const code = 'kiss'
const order = 2
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'mouth'
const virginloss = false
const givertags = ['oral','noorgasm']
const takertags = ['oral','noorgasm']
const giver_skill = ['oral']
const taker_skill = ['oral']
const consent_level = 15

const consent_giver = 1
const consent_taker = 1

func getname(state = null):
	if givers.size() == 0 || takers.size() == 0:
		return tr("SEXACTION_KISS")
	elif givers.size() > 1 || takers.size() > 1:
		return tr("SEXACTION_DOUBLE_KISS")
	else:
		return tr("SEXACTION_KISS")

func getongoingname(givers, takers):
	return tr("SEXACTION_KISS_ONGOING_1")

func getongoingdescription(givers, takers):
	var temparray = []
	if givers.size() + takers.size() == 2:
		temparray += ["SEXACTION_KISS_ONGOING_DESC_1"]
	elif givers.size() == 2:
		temparray += ["SEXACTION_KISS_ONGOING_DESC_2"]
	else:
		temparray += ["SEXACTION_KISS_ONGOING_DESC_3"]
	return tr(temparray[randi()%temparray.size()])

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
#	else:
#		for i in givers+takers:
#			if i.mouth != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 120, horny = 25}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 25}
	return effects


func initiate():
	var temparray = []
	if givers.size() == 2:
		temparray += ["[name1] take[s/1] turns {^french :}kissing [name2] and licking {^all around :}[his2] face[/s2]."]
		temparray += ["[name1] take[s/1] turns coiling [his1] tongue[/s1] inside [names2] mouth[/s2] and [he2] {^eagerly:enthusiastically} return[s/2] the gesture."]
	else:
		temparray += ["[name1] {^french :}kiss[es/1] [name2], licking {^all around :}[his2] face[/s2]."]
		temparray += ["[name1] coil[s/1] [his1] tongue[/s1] inside [names2] mouth[/s2] and [he2] {^eagerly:enthusiastically} return[s/2] the gesture."]
	temparray += ["[name1] grab[s/1] [name2] and {^deeply :}kiss[es/1] [him2], {^driving [his1] tongue[/s1] into [his2] mouth[/s2]:eagerly tasting [his2] lips}."]
	return temparray[randi()%temparray.size()]


func taker_resist():
	var temparray = []
	if takers[0].stamina > 20:
		temparray += ["[name2] shies away from the kiss seemingly nervous..."]
	else:
		temparray += ["[name2] tries to push back against the undesired action..."]
	return temparray[randi()%temparray.size()]
