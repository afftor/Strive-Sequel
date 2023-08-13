extends Reference

const category = 'caress'
const code = 'rimjob'
const order = 8
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = 'anus'
const virginloss = false
const givertags = ['oral','noorgasm','sub']
const takertags = ['anal','dom']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 25

func getname(state = null):
	return "Rimjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]rimjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	return "[name1] {^eat[s/1] out:lick[s/1]:slurp[s/1] at} [names2] [anus2]."

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
#	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
#		for i in takers:
#			if i.anus != null:
#				valid = false
	for i in givers:
		if !i.person.has_status('sex_oral'):
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 80, horny = 10}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 20}
	return effects

func initiate():
	var text = ''
	text += "[name1] {^eat[s/1] out:lick[s/1]:slurp[s/1] at} [names2] [anus2], stimulating the {^enterance:walls} with [his1] tongue[/s1]."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [anus2] {^respond:react}[s/#2] to {^the stimulation:[names1] tongue[/s1]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] tongue[/s1]}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} to {^the stimulation:[names1] tongue[/s1]}."
	elif member.sens < 800:
		text = "[name2] {^moan[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [anus2] [is2] {^stimulated:licked:eaten out}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tongue[/s1]:in response to [names1] licking}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
