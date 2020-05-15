extends Node

const category = 'caress'
const code = 'handjob'
const order = 5
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet','noorgasm']
const takertags = ['pet','penis']
const giver_skill = ['petting']
const taker_skill = []
const consent_level = 10

func getname(state = null):
	if givers.size() + takers.size() == 2:
		return "Handjob"
	else:
		return "Smlt. Handjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]handjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^massage:stroke:rub:jerk}[s/1] [names2] [penis2]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^massage:work:stroke:rub}[s/1] {^up and down the length of:all along:the shaft[/s2] of} [names2] [penis2] with [his1] hands."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	for i in givers:
		if i.limbs == false:
			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in takers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 65, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects


func initiate():
	var temparray = []
	temparray += ["[name1] {^grip:grab:seize}[s/1] [names2] [penis2] and {^massage:stroke:rub:jerk}[s/1] [it2] with {^inensity:intense focus:fervor:passion}."]
	temparray += ["[name1] {^tease[s/1]:brush[es/1] against} the {^tip:shaft:base}[/s2] of [names2] [penis2] with [his1] fingertips as [he1] {^service:stroke:milk:attend}[s/1] [it2] with [his1] hands."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] touch}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] fingers:[names1] touch}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^jerked:stroked}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^jerked:stroked}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] fingers against [his2] [penis2]:in response to [names1] jerking}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
