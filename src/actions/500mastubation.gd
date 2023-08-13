extends Reference

const category = 'humiliation'
const code = 'mastshow'
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'vagina'
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['vagina','shame']
const giver_skill = []
const taker_skill = ['petting']
const consent_level = 10

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
	for i in givers:
		if !i.person.has_status('sex_adv'):
			valid = false
	return valid

#Disabling until something is decided about tools
func givereffect(member):
	var effects = {sens = 50, horny = 20}
	return effects

#Disabling until something is decided about tools
func takereffect(member):
	var effects = {sens = 110, horny = 25}
	return effects

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
		text = "[name2] {^moan[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] intimate parts are {^stimulated:teased}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [his2] fingers[/s1]:in response to [his2] fingers}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
