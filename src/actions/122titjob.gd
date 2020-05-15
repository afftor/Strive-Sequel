extends Node

const category = 'caress'
const code = 'titjob'
const order = 7
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm', 'tits']
const takertags = ['pet','penis']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 20

func getname(state = null):
	if givers.size() + takers.size() == 2:
		return "Titjob"
	else:
		return "Smlt. Titjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /2]titjob[/s2] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue[s/1] {^rubbing:massaging:squeezing} [names2] [penis2] with [his1] [tits1]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('tits_size') in ['masculine','flat']:
				valid = false
			if i.limbs == false:
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 90, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects

func initiate():
	var temparray = []
	temparray += ["[name1] buries [names2] [penis2] in [his1] [tits1], {^squeezing:teasing} and {^rubbing:massaging:milking} [it2]."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] [tits1]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[names1] [tits1]}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^rubbed:massaged:squeezed} by [names1] [tits1]."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^rubbed:massaged:squeezed} by [names1] [tits1]."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] [tits1] against [his2] [penis2]:in response to [names1] [tits1]}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
