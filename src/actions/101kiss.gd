extends Node

const category = 'caress'
const code = 'kiss'
const order = 2
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'mouth'
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'basic'
const givertags = ['oral','noorgasm']
const takertags = ['oral','noorgasm']

func getname(state = null):
	if givers.size() > 1 || takers.size() > 1:
		return "Double Kiss"
	else:
		return "Kiss"

func getongoingname(givers, takers):
	return "[name1] kiss[es/1] [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	if givers.size() + takers.size() == 2:
		temparray += ["[name1] and [name2] {^passionately :eagerly :}{^press together:exchange saliva:kiss}, {^showing no sign of separating from each others lips:coiling each others tongues together:biting and sucking each other's lips}."]
	elif givers.size() == 2:
		temparray += ["[name1] {^passionately :eagerly :}{^exchange[s/1] saliva with:kiss[es/1]:make[s/1] out with} [name2], {^savoring the taste of [his2] lips:trying [his1] best to share}."]
	else:
		temparray += ["[name1] {^passionately :eagerly :}{^exchange[s/1] saliva with:kiss[es/1]:make[s/1] out with} [name2], {^savoring the taste of [his2] lips:trying [his1] best keep both satisfied}."]
	return temparray[randi()%temparray.size()]

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
	var result
	var effects = {sens = 120}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 300):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {sens = 120}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 300):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]


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
	
