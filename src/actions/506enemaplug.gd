extends Node

const category = 'humiliation'
const code = 'enemaplug'
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'anus'
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['shame', 'punish', 'anal']
const giver_skill = []
const taker_skill = []
const consent_level = 30

func getname(state = null):
	return "Enema + Plug"

func getongoingname(givers, takers):
	return "[name1] injects enema liquid into [names2] anus then plug it."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.anus != null:
#			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	return valid

#Disabling until something is decided about tools
func givereffect(member):
	var effects = {sens = 20, horny = 10}
	return effects

#Disabling until something is decided about tools
func takereffect(member):
	var effects = {sens = 120, horny = 20}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.3
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^put:place:shove:stick}[s/1] enema liquid into [names2] anus then insert plug[/s1] to make sure it holds in."]
#	temparray += ["[name1] latch[es/1] onto [names2] nipples"]
	text += temparray[randi()%temparray.size()]
	temparray.clear()
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] anus {^respond:react} to {^the liquid} trying to flow out but still restricted by the plug."
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
