extends Node

const category = 'caress'
const code = 'fondletits'
const order = 3
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = ''
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet', 'tits']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 15

func getname(state = null):
	return "Fondle Chest"

func getongoingname(givers, takers):
	return "[name1] fondle[s/1] [names2] chest."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue[s/1] {^fondling:caressing:rubbing:squeezing} [names2] [tits2]."]
	return temparray[randi()%temparray.size()]
	
func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 25}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 2
	return effects

func initiate():
	var text = ''
	var kissable = true
	var temparray = []
	for i in givers:
		if i.mouth != null:
			kissable = false
	temparray += ["[name1] {^squeeze[s/1]:fondle[s/1]:massage[s/1]:caress[es/1]} [names2] [tits2]"]
	temparray += ["[name1] {^run:rub:work}[s/1] [his1] hands all around [names2] [tits2]"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	temparray += [", {^playing with:teasing:flicking and teasing} [his2] nipples."]
	temparray += [", kneading into the surrounding {^flesh:tissue}."]
	temparray += [". "]
	if kissable:
		temparray += [", {^kissing:licking} and {^kneading:teasing} them."]
		temparray += [", {^burrying:nuzzling} [his1] face[/s1] in them."]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [tits2] {^respond:react} to {^the stimulation:[names1] touch:[names1] caress}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] touch:[names1] caress}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} to {^the stimulation:[names1] touch:[names1] caress}."
	elif member.sens < 800:
		text = "[name2] {^revel:bask}[s/2] in {^the stimulation:[names1] touch:[names1] caress}{^, [his2] arousal clearly showing:, becoming more and more excited:}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest touch:with every touch:each time [name1] touch[es/1] [his2] [tits2]}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
