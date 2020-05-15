extends Node

const category = 'SM'
const code = 'clitclap'
const order = 5
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'acc6'#clit
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['punish','pain', 'vagina']
const giver_skill = []
const taker_skill = []
const consent_level = 30

func getname(state = null):
	return "Clit Clap"

func getongoingname(givers, takers):
	return "[name1] put clip[s/1] on [names2] clit[/s1]."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
	for i in takers:
#		if i.acc6 != null:
#			valid = false
		if i.person.get_stat('sex') == 'male':
			valid = false
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	return valid

func givereffect(member):
	var effects = {sens = 30}
	return effects

func takereffect(member):
	var effects = {sens = 120, horny = 10}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.3
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^place:stick}[s/1] clips on [names2] clit."]
#	temparray += ["[name1] latch[es/1] onto [names2] nipples"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
#	temparray += [", {^licking:teasing} and {^kissing:sucking on} them."]
#	temparray += [", {^lightly:gently} {^nibbling at:stimulating} them with [his1] teeth."]
#	temparray += [", {^greedily slurping at them:nursing} like [a /1]bab[y/ies1]."]
#	text += temparray[randi()%temparray.size()]
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] clit {^respond:react} to {^the stimulation:the claps pression:the claps teasing}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] clit being {^stimulated:teased:pressed:pinched}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] clit are {^stimulated:teased:pressed:pinched}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] clit are {^stimulated:teased::pressed:pinched}."
	else:
		text = "[names2] body {^trembles:quivers} {^by the slightest pressure of the claps:in response of the claps pression}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
