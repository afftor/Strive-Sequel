extends Node

const category = 'caress'
const code = 'sucknipples'
const order = 4
var givers
var takers
const canlast = true
const giverpart = 'mouth'
const takerpart = ''
const virginloss = false
const givertags = ['oral','noorgasm']
const takertags = ['tits']
const giver_skill = ['oral']
const taker_skill = []
const consent_level = 20

func getname(state = null):
	return "Nipple Sucking"

func getongoingname(givers, takers):
	return "[name1] suck[s/1] on [names2] nipples."

func getongoingdescription(givers, takers):
	var text = ''
	var temparray = []
	temparray += ["[name1] continue[s/1] {^licking:teasing} and {^kissing:sucking on} [names2] nipples"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	temparray += [", rolling them around with [his1] tongue[/s1]."]
	temparray += [", {^lightly:gently} {^nibbling at:stimulating} them with [his1] teeth."]
	temparray += [", {^greedily slurping at them:nursing} like [a /1]bab[y/ies1]."]
	temparray += ["."]
	text += temparray[randi()%temparray.size()]
	return text
	
func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
#	else:
#		for i in givers:
#			if i.mouth != null:
#				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 80, horny = 15}

	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.3
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^take:place:shove:stick}[s/1] [names2] nipples into [his1] mouth[/s1]"]
	temparray += ["[name1] latch[es/1] onto [names2] nipples"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	temparray += [", {^licking:teasing} and {^kissing:sucking on} them."]
	temparray += [", {^lightly:gently} {^nibbling at:stimulating} them with [his1] teeth."]
	temparray += [", {^greedily slurping at them:nursing} like [a /1]bab[y/ies1]."]
	text += temparray[randi()%temparray.size()]
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] nipples {^respond:react} to {^the stimulation:[names1] suckling:[names1] teasing}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] nipples being {^stimulated:teased:sucked on:suckled}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tongue[/s1]:in response to [names1] suckling}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
