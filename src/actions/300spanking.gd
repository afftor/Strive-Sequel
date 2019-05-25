extends Node

const category = 'SM'
const code = 'spanking'
const order = 1
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = ''
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['pet','noorgasm']
const takertags = ['pet', 'punish', 'pain']

func getname(state = null):
	return "Spanking"

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
	var result
	var effects = {sens = 10}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {tags = ['punish'], obed = rand_range(10,15), stress = rand_range(3,6)}
	if (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 20) || member.person.traits.find('Masochist') >= 0:
		result = 'good'
		effects.sens = 90
	elif member.person.traits.find("Likes it rough") >= 0 || member.sens >= 700:
		result = 'average'
		effects.sens = 55
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] {^spank:slap:beat:swat}[s/1] [names2] [ass2]{^ with [an /1]open hand[/s1]: until it turns red:, intent on humiliating [him2]}."]
	temparray += ["[name1] {^spank:slap:beat:swat}[s/1] [name2] {^right :square :}{^across:on} [his2] [ass2] {^repeatedly:again and again:over and over}."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = "[name2] {^jerk:wince:writhe}[s/2] in pain from the {^humiliating:demeaning:embarassing} punishment."
	elif member.sens < 600:
		text = "[name2] cries out with each blow to [his2] buttox, though [his2] voice betrays some enjoyment."
	elif member.sens < 950:
		text = "[names2] moans make it {^hard:difficult} to tell if [he2] in pain or enjoying [himself2]."
	else:
		text = "[names2] body {^trembles:quivers} {^with each swat:each time [name1] slap[s/1] [his2] [ass2]}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	
	return text