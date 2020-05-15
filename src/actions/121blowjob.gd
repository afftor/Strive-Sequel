extends Node

const category = 'caress'
const code = 'blowjob'
const order = 6
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'penis'
const virginloss = false
const givertags = ['oral','noorgasm','sub']
const takertags = ['penis','dom']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 15

func getname(state = null):
	if givers.size() == 0 || takers.size() == 0 || givers.size() + takers.size() == 2:
		return "Blowjob"
	else:
		return "Smlt. Blowjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]blowjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^suck:blow}[s/1] [names2] [penis2]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^work:nurse:serve}[s/1] {^the length of :the shaft[/s2] of :the tip[/s2] of :}[names2] [penis2] with [his1] mouth[/s1]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
		for i in takers:
#			if i.penis != null || i.person.penis_size == '':
#				valid = false
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 75, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 180, horny = 25}
	return effects

func initiate():
	var temparray = []
	temparray += ["[name1] {^take:place:shove}[s/1] [names2] [penis2] into [his1] mouth[/s1], {^carefully serving:working the length of:coiling around} [it2] with [his1] tongue[/s1]."]
	temparray += ["[name1] {^kiss[es/1]:rub[s/1] [his1] face against:lick[s/1] the tip of:admire[s/1]} [names2] [penis2] as [he1] begin[s/1] {^servicing:slurping at:milking:attending} [it2]."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] mouth[/s1]:[names1] fellatio}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[names1] fellatio}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^sucked:licked:fellated}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^sucked:licked:fellated}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tongue[/s1] against [his2] [penis2]:in response to [names1] fellatio}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
