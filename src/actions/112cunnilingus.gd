extends Node

const category = 'caress'
const code = 'cunnilingus'
const order = 7
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'clit'
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['oral','noorgasm']
const takertags = ['vagina']

func getname(state = null):
	return "Cunnilingus"

func getongoingname(givers, takers):
	return "[name1] lick[s/1] [names2] puss[y/ies2]."

func getongoingdescription(givers, takers):
	return "[name1] {^eat[s/1] out:lick[s/1]:slurp[s/1] at} [names2] [pussy2]."

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
		for i in takers:
#			if i.vagina != null || i.person.vagina == 'none':
#				valid = false
			if i.person.vagina == 'none':
				valid = false
#			elif i.clit != null:
#				valid = false
			elif i.person.sex == 'male':
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {sens = 90}
	member.person.metrics.oral += 1
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 300):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {sens = 180}
	member.lube()
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 150):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	text += "[name1] {^eat[s/1] out:lick[s/1]:slurp[s/1] at} [names2] [pussy2], {^gently:steadily:diligently} stimulating [his2] pink clit[/s2]."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[names2] [pussy2] {^trembles:twitches}, {^responding:reacting} to {^the stimulation:[names1] licking:[names1] tongue[/s1]} even in [his2] unconcious state."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] licking:[names1] tongue[/s1]}."
	elif member.sens < 300:
		text = "[names2] [pussy2] {^begins:starts} to {^respond:react} to the {^sensation:feeling} of {^[names1] licking:[names1] tongue[/s1]}."
	elif member.sens < 600:
		text = "[names2] [pussy2] {^trembles:quivers} in {^response:reaction} to the {^sensation:feeling} of {^[names1] licking:[names1] tongue[/s1]}, [his2] arousal {^made clear:apparent:clearly showing}."
	else:
		text = "[names2] [pussy2] {^violently trembles:clenches:quivers} with every movement of [names1] tongue[/s1]{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text