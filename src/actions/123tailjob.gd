extends Node

const category = 'caress'
const code = 'tailjob'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'penis'
const virginloss = false
const givertags = ['pet', 'tail', 'noorgasm']
const takertags = ['pet','penis']
const giver_skill = ['tail']
const taker_skill = []
const consent_level = 25

func getname(state = null):
	return "Tailjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /2]tailjob[/s2] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^massage:stroke:rub:jerk}[s/1] [names2] [penis2] with [his1] tail[/s1]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^massage:work:stroke:rub}[s/1] {^up and down the length of:all along:the shaft[/s2] of} [names2] [penis2] with [his1] tail[/s1]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() > givers.size():
		valid = false
	else:
		for i in givers:
			if !variables.longtails.has(i.person.get_stat('tail')):
				valid = false
			if i.limbs == false:
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 75, horny = 20}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects

func initiate():
	var temparray = []
	temparray += ["[name1] wrap[/s1] [his1] tail around [names2] [penis2] and {^massage:stroke:rub:jerk}[s/1] [it2]."]
	temparray += ["[name1] {^tease[s/1]:brush[es/1] against} the {^tip:shaft:base}[/s2] of [names2] [penis2] as [he1] {^service:stroke:attend}[s/1] [it2] with [his1] tail[/s1]."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] tail[/s1]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[names1] tail[/s1]}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^jerked:stroked} by [names1] tail[/s1]."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^jerked:stroked} by [names1] tail[/s1]."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tail[/s1] against [his2] [penis2]:in response to [names1] stroking}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
