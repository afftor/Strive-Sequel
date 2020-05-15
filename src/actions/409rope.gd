extends Node

const category = 'SM'
const code = 'rope'
var givers
var takers
const canlast = false
const giverpart = ''
const takerpart = 'acc4'#body extra to change some getname into restrained getname
const virginloss = false
const givertags = []
const takertags = ['punish']
const giver_skill = []
const taker_skill = []
const consent_level = 25

func getname(state = null):
	return "Rope"

func getongoingname(givers, takers):
	return "[name1] bind[s/1] [names2] bod[y/ies2] with [a /2]rope[/s2]."

func getongoingdescription(givers, takers):
	return ""
	
func requirements():
	var valid = true
	if ResourceScripts.game_res.materials.rope < takers.size():
		valid = false
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif givers.size() > 2:
		valid = false
	for i in givers + takers:
		if i.limbs == false:
			valid = false
	return valid

func givereffect(member):
	var effects = {}
	return effects

func takereffect(member):
	var effects = {}
	return effects

func initiate():
	var text = ''
	var temparray = []
	temparray += ["[name1] {^wrap:tie}[s/1] a rope around [names2] body to restrict [his2] movements."]
	text += temparray[randi()%temparray.size()]
	for i in takers:
		ResourceScripts.game_res.materials.rope -= 1
		i.effects.append('tied')
	temparray.clear()
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, with [his2] body still tied down."

	return text
