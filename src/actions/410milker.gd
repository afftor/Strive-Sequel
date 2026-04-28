extends Reference

const category = 'tools'
const code = 'milker'
const order = 11
var givers
var takers
const canlast = true
const giverpart = ''
const takerpart = 'acc5'
const virginloss = false
const givertags = ['noorgasm']
const takertags = ['tits']
const giver_skill = []
const taker_skill = []
const consent_level = 30
const consent_giver = 0
const consent_taker = 3

func getname(state = null):
	return tr("SEXACTION_MILKER")

func getongoingname(givers, takers):
	return tr("SEXACTION_MILKER_ONGOING_1")

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
#	for i in takers:
#		if i.acc5 != null:
#			valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	return valid

func givereffect(member):
	var effects = {}
	return effects

func takereffect(member):
	var effects = {sens = 35, tags = ['pervert'], horny = 15}
	if member.person.get_stat('sex') == 'male':
		effects.sens /= 1.5
	return effects

func initiate():
	var temparray = []
	temparray += ["SEXACTION_MILKER_INITIATE_SUFFIX_1"]
	temparray += ["SEXACTION_MILKER_INITIATE_SUFFIX_2"]
	temparray += ["SEXACTION_MILKER_INITIATE_SUFFIX_3"]
	return tr("SEXACTION_MILKER_INITIATE_1") + tr(temparray[randi()%temparray.size()])

func reaction(member):
	var text = ''
#	if member.energy == 0:
#		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] nipples {^respond:react} to {^the stimulation:milker suckling:milker teasing}."
#	#elif member.consent == false:
#		#TBD
#	elif member.sens < 100:
#		text = "[name2] {^show:give}[s/2] little {^response:reaction} to [his2] nipples being {^stimulated:teased:sucked on:suckled}."
#	elif member.sens < 400:
#		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
#	elif member.sens < 800:
#		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] nipples are {^stimulated:teased:sucked on:suckled}."
#	else:
#		text = "[names2] body {^trembles:quivers} {^at the slightest suction of the milker:in response to the milker suckling}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
