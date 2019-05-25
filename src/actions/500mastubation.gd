extends Node

const category = 'humiliation'
const code = 'mastshow'
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'vagina'
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'
const givertags = ['noorgasm']
const takertags = ['vagina','shame']

func getname(state = null):
	return "Order Masturbation"

func getongoingname(givers, takers):
	return "[name2] masturbate[s/2] as [name1] ordered."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.vagina != null:
#			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

#Disabling until something is decided about tools
func givereffect(member):
	var result
	var effects = {sens = 50}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

#Disabling until something is decided about tools
func takereffect(member):
	var result
	var effects = {sens = 110, tags = ['pervert']}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.sens >= 250):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] order[s/1] [name2] to masturbate exposing to anyone willing to see [his2] intimate parts."]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] intimate parts being {^stimulated:teased}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] intimate parts are {^stimulated:teased}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] intimate parts are {^stimulated:teased}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [his2] fingers[/s1]:in response to [his2] fingers}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
