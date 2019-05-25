extends Node

const category = 'SM'
const code = 'whipping'
const order = 2
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['noorgasm']
const takertags = ['punish','pain']

func getname(state = null):
	return "Whipping"

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
	var result
	var effects = {sens = 20}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {pain = 2, tags = ['punish'], obed = rand_range(14,22), stress = rand_range(5,10)}
	if (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30) || member.person.traits.find('Masochist') >= 0:
		result = 'good'
		effects.sens = 100
	elif member.person.traits.find("Likes it rough") >= 0 || member.sens >= 700:
		result = 'average'
		effects.sens = 50
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] {^lash}[s/1] at [names2] [body2] with a leather whip."]
	return temparray[rand_range(0,temparray.size())]

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = "[name2] {^jerk:wince:writhe}[s/2] in pain from the {^harsh:severe:brutal} punishment."
	elif member.sens < 600:
		text = "[name2] cries out with each {^strike:lash}, though [his2] voice betrays some enjoyment."
	elif member.sens < 950:
		text = "[names2] moans make it {^hard:difficult} to tell if [he2] in pain or enjoying [himself2]."
	else:
		text = "[name2] barely reacts to {^heavy:painful} {^strikes:lashes} as [he2] edge[s/2] toward orgasm."
	
	return text