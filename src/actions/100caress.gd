extends Node

const category = 'caress'
const code = 'caress'
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
const takertags = ['pet']

func getname(state = null):
	return "Caress"

func getongoingname(givers, takers):
	return "[name1] caress[es/1] [names2] [body2]."

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

func givereffect(member):
	var result
	var effects = {sens = 75}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 100):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {sens = 110}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 100):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	var kissable = true
	var temparray = []
	for i in givers:
		if i.mouth != null:
			kissable = false
	temparray += ["[name1] {^gently:tenderly:carefully} {^stroke:fondle:cuddle:massage}[s/1] and {^caress[es/1]:rub[s/1]} [names2] [body2]"]
	temparray += ["[name1] {^run:rub:work}[s/1] [his1] hands all {^over:along:around} [names2] [body2]"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	if kissable:
		temparray += [", kissing [him2] all over"]
		temparray += [", kissing and teasing [him2] with [his1] tongue[/s1]"]
		temparray += [", planting {^a few small:fleeting:a few brief} kisses as [he1] go[es/1]"]
		text += temparray[randi()%temparray.size()]
		temparray.clear()
	else:
		temparray += [", {^hitting:touching} all the right spots"]
		temparray += [", {^thoroughly:expertly} pleasuring [him2]"]
		text += temparray[randi()%temparray.size()]
		temparray.clear()
	return text + '.'

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] body {^responds:reacts} to {^the stimulation:[names1] touch:[names1] caress}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] touch:[names1] caress}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} to {^the stimulation:[names1] touch:[names1] caress}."
	elif member.sens < 800:
		text = "[name2] {^revel:bask}[s/2] in {^the stimulation:[names1] touch:[names1] caress}{^, [his2] arousal clearly showing:, becoming more and more excited:}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest touch:with every touch:each time [name1] touch[es/1] [him2]}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
