extends Reference

const category = 'humiliation'
const code = 'grovel'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = 'posh1'
const virginloss = false
const givertags = []
const takertags = ['shame']
const giver_skill = []
const taker_skill = []
const consent_level = 30
const consent_giver = 0
const consent_taker = 1

func getname(state = null):
	return "Order Grovelling"

func getongoingname(givers, takers):
	return "[name2] grovel[s/2] as [name1] ordered."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
	for i in givers:
		if i.limbs == false:
			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	return valid

#Disabling until something is decided about tools
func givereffect(member):
	var effects = {}
	return effects

#Disabling until something is decided about tools
func takereffect(member):
	var effects = {lust = 0, sens = 0}
	if member.person.check_trait("Masochist"):
		effects.stress = 0
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name2] submissively wait[s/2] facedown for [names1] orders like [a /2]good slave[/s2]."]
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
		text = "[name2] lie[s/2] unconscious."
	#elif member.consent == false:
		#TBD
# not sure what humiliation reaction should be
#	elif member.sens < 100:
#		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] nipples being {^stimulated:teased:sucked on:suckled}."
#	elif member.sens < 400:
#		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
#	elif member.sens < 800:
#		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
#	else:
#		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tongue[/s1]:in response to [names1] suckling}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
