extends Node

const category = 'tools'
const code = 'blindfold'
const order = 7
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'acc2'#eyesextra
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['noorgasm']
const giver_skill = []
const taker_skill = []
const consent_level = 30

func getname(state = null):
	return "Blindfold"

func getongoingname(givers, takers):
	return "[name1] put blindfold[s/1] on [names2] eyes."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.acc2 != null:
#			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	return valid

#Disabling until something is decided about tools
func givereffect(member):
	var result
	var effects = {}
	if  (member.person.check_trait("Likes it rough") && member.lewd >= 10):
		result = 'good'
	elif member.person.check_trait("Likes it rough"):
		result = 'average'
	else:
		result = 'bad'
	return effects

#Disabling until something is decided about tools
func takereffect(member):
	var result
	var effects = {}
	if (member.person.check_trait("Likes it rough") && member.lewd >= 10):
		result = 'good'
	elif member.person.check_trait("Likes it rough"):
		result = 'average'
	else:
		result = 'bad'
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^place:put}[s/1] a blindfold on [names2] eyes."]
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
		text = "[name2] lie[s/2] unconscious, with the blinfold still on [his2] eyes."
	#elif member.consent == false:
		#TBD
# probably fear descriptions here as she woulnd see who or what is doing things to her
#	elif member.sens < 100:
#		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] nipples being {^stimulated:teased:sucked on:suckled}."
#	elif member.sens < 400:
#		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
#	elif member.sens < 800:
#		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
#	else:
#		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tongue[/s1]:in response to [names1] suckling}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
