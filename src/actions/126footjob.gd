extends Node

const category = 'caress'
const code = 'footjob'
const order = 10
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm','dom']
const takertags = ['pet','penis','sub']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 25

func getname(state = null):
	return "Footjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /2]footjob[/s2] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :aggressively :}{^massage:stroke:rub:jerk}[s/1] [names2] [penis2] with [his1] feet."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in takers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
		for i in givers:
			if i.person.get_stat('legs') in ['horse','spider', 'snake']:
				valid = false
			if i.limbs == false:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 50, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 125, horny = 15}
	return effects


func initiate():
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :} {^massage:stroke:rub:jerk}[s/1] [names2] [penis2] with [his1] feet."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] touch}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] feet:[names1] touch}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^jerked:stroked}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^jerked:stroked}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] feet against [his2] [penis2]:in response to [names1] jerking}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
