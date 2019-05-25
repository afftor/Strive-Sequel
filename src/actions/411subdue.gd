extends Node

const category = 'SM'
const code = 'subdue'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['pet']
const takertags = ['punish']

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
	var result
	var effects = {lust = 0}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 0}
	
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]
	

func initiate():
	for i in takers:
		for k in givers:
			i.subduedby.append(k)
			k.subduing = i
	
	if givers.size() < 2:
		return "[name1] tries to hold down [name2] with all [his1] might."
	else:
		return "[name1] try to hold down [name2] with all [his1] might."
