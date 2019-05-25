extends Node

const category = 'SM'
const code = 'deepthroat'
const order = 3
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'mouth'
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['penis']
const takertags = ['mouth','penetration']

func getname(state = null):
	return "Deepthroat"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [names2] throat[/s1]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^roughly :forcefully :}{^push:slam}[s/1] [his1] [penis1] into [names2] {^throat:mouth pussy}."]
	#temparray += ["[name1] {^work:nurse:serve}[s/1] {^the length of :the shaft[/s2] of :the tip[/s2] of :}[names2] [penis2] with [his1] mouth[/s1]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	#if takers.size() < 1 || givers.size() < 1:
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.person.penis == 'none' && i.strapon == null:
				valid = false
#			elif i.penis != null && givers.size() > 1:
#				valid = false
		for i in takers:
#			if i.mouth != null && givers.size() > 1:
#				valid = false
			if i.acc1 == null:
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {sens = 220}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 15):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {pain = 3, tags = ['punish','pervert'], obed = rand_range(10,15), stress = rand_range(3,6)}
	if (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30) || member.person.traits.find('Masochist') >= 0:
		result = 'good'
		effects.sens = 150
	elif member.person.traits.find("Likes it rough") >= 0 || member.sens >= 700:
		result = 'average'
		effects.sens = 100
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] {^push:shove}[s/1] [his1] [penis1] into [names2] mouth [/s1], intent on humiliating [him2]."]
#	temparray += ["[name1] {^take:place:shove}[s/1] into [name2] {^right :square :}{^across:on} [his2] [ass2] {^repeatedly:again and again:over and over}."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = "[name2] {^jerk:wince:writhe}[s/2] in pain from the {^humiliating:demeaning:embarassing} punishment."
	elif member.sens < 600:
		text = "[name2] cries out with each push into [his2] throat, though [his2] facial expression betrays some enjoyment."
	elif member.sens < 950:
		text = "[names2] expression make it {^hard:difficult} to tell if [he2] in pain or enjoying [himself2] from the gagging."
	else:
		text = "[names2] body {^trembles:quivers} {^with each push:each time [name1] slam[s/1] [his2] throat}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	
	return text