extends Node

const category = 'fucking'
const code = 'frottage'
const order = 10
var givers
var takers
const canlast = true
const giverpart = 'penis'
const takerpart = 'penis'
const virginloss = false
const givertags = ['penis', 'pet']
const takertags = ['penis', 'pet']
const giver_skill = ['petting']
const taker_skill = ['petting']
const consent_level = 20

func getname(state = null):
	return "Frottage"

func getongoingname(givers, takers):
	return "[name1] and [name2] rub [their] [penis3] together."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] continue to {^rub:grind} [their] [penis3] together."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.get_stat('penis_size') == '':
				valid = false
		for i in takers:
			if i.person.get_stat('penis_size') == '':
				valid = false
	return valid

func givereffect(member):
	var effects = {sens = 175, horny = 15}
	return effects

func takereffect(member):
	var effects = {sens = 175, horny = 15}
	return effects

func initiate():
	var text = ''
	text += "[name1] and [name2] {^rub:grind:press} [their] [penis3] {^together:against one another}."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] efforts:[name1] against [him2]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^rubbed:stimulated:teased}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^rubbed:stimulated:teased}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] [penis1] against [his_2]:in response to [names1] efforts}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
