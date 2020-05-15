extends Node

const category = 'fucking'
const code = 'inserttailv'
const order = 11
var givers
var takers
const canlast = true
const giverpart = 'tail'
const takerpart = 'vagina'
const virginloss = true
const givertags = ['tail', 'noorgasm']
const takertags = ['vagina', 'penetration']
const giver_skill = ['tail']
const taker_skill = ['pussy']
const consent_level = 35

func getname(state = null):
	return "Insert Tail Pussy"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2]'s pussy with [his1] tail."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] thrust[s/1] [his1] tail in and out of [names2] [pussy2]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.limbs == false:
				valid = false
			if !variables.longtails.has(i.person.get_stat('tail')):
				valid = false
		for i in takers:
			if i.person.get_stat('has_pussy') == false:
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 100, horny = 5}
	return effects

func takereffect(member):
	var effects = {sens = 240, horny = 10}
	return effects


func initiate():
	var temparray = []
	temparray += ["[name1] insert[s/1] [his1] thick tail into [names2] [pussy2]. "]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [pussy2] {^respond:react}[s/#2] to {^the stimulation:[names1] tail[/s1]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[names1] tail[/s1]}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [pussy2] get[s/#2] {^fucked:penetrated} by [names1] tail[/s1]."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [pussy2] get[s/#2] {^fucked:penetrated} by [names1] tail[/s1]."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tail[/s1] inside [his2] [pussy2]:in response to [names1] penetrating}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
