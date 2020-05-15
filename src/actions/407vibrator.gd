extends Node

const category = 'tools'
const code = 'vibrator'
const order = 9
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'vagina'
const virginloss = true
const givertags = ['pet', 'noorgasm', 'toys']
const takertags = ['pet', 'vagina', 'toys']
const giver_skill = []
const taker_skill = ['pussy']
const consent_level = 15

func getname(state = null):
	return "Vibrator"

func getongoingname(givers, takers):
	return "[name1] put [a /2]vibrator[/s2] in [names2] vagina[/s2]."

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
	for i in takers:
		if i.person.get_stat('has_pussy') == false:
			valid = false
	return valid

func givereffect(member):
	var effects = {sens = 50, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 150, horny = 25}
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^push:place:shove:stick}[s/1] [a /2]vibrator[/s2] into [names2] {^pussy:fuck hole:front door:vagina}[/s2]"]
#	temparray += ["[name1] latch[es/1] onto [names2] nipples"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	temparray += [", {^stimulating:teasing} [it2]."]
#	temparray += [", {^lightly:gently} {^nibbling at:stimulating} them with [his1] teeth."]
#	temparray += [", {^greedily slurping at them:nursing} like [a /1]bab[y/ies1]."]
	text += temparray[randi()%temparray.size()]
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] {^pussy:fuck hole:front door:vagina} still {^respond:react} to {^the stimulation:vibration}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] {^pussy:fuck hole:front door:vagina} being {^stimulated:teased:used}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} at the {^stimulation:tease:use} of [his2] {^pussy:fuck hole:front door:vagina}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} at [his2] {^pussy:fuck hole:front door:vagina} been {^stimulated:teased:used}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest stimulation of the vibrator:in response to the vibrator}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm}."
	return text
